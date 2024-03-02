USE management;


SHOW TABLES;

DROP TABLE EMPLOYEE;

/* 
Creating Employee Details, Employee Performance, Financial Details(Monthly Profit and Loss), Department Details, EmployeeFinances,
LoginDetails
*/

CREATE TABLE EMPLOYEE(
       EMPNO       BIGINT       PRIMARY KEY,
       FIRSTNME    VARCHAR(12)     NOT NULL,
       MIDINIT     CHAR(1)         NOT NULL,
       LASTNAME    VARCHAR(15)     NOT NULL,
       WORKDEPT    INT REFERENCES     DEPT(DeptID),
       PHONENO     BIGINT,
       ADDRESS1    VARCHAR(250),
       ADDRESS2    VARCHAR(250),
       CITY        VARCHAR(50),
       STATES      VARCHAR(50),
       COUNTRY     VARCHAR(50),
       EDLEVEL     SMALLINT        NOT NULL,
       SEX         CHAR(1)                 ,
       BIRTHDATE   DATE                    
) 

/*

Column name
Description
EMPNO	Employee number
FIRSTNME	First name of employee
MIDINIT	Middle initial of employee
LASTNAME	Family name of employee
WORKDEPT	ID of department in which the employee works
PHONENO	Employee telephone number
HIREDATE	Date of hire
JOB	Job held by the employee
EDLEVEL	Number of years of formal education
SEX	Sex of the employee (M or F)
BIRTHDATE	Date of birth
SALARY	Yearly salary in dollars
BONUS	Yearly bonus in dollars
COMM	Yearly commission in dollars 

*/

--Creating EmployeeFinances table where the complete data regarding the compensation given to an employee is stored 
CREATE TABLE EmployeeFinances(
      EMPNO BIGINT REFERENCES EMPLOYEE(EMPNO),
      SALARY      DECIMAL(9,2),
      BONUS       DECIMAL(9,2),
      COMM        DECIMAL(9,2),
      TAXPERCENTAGE DECIMAL(2,2)
)



ALTER TABLE EMPLOYEE 
MODIFY COLUMN EMPNO INT;

CREATE TABLE EPERFORMANCE(
    EMPID INT REFERENCES EMPLOYEE(EMPNO),
    REPORTSUBTIME SMALLINT CHECK(REPORTSUBTIME >= 1 AND REPORTSUBTIME <= 3),
    PRODUCTIVITY SMALLINT CHECK(PRODUCTIVITY >= 1 AND PRODUCTIVITY <= 10)
)

ALTER TABLE EPERFORMANCE
DROP COLUMN LIOTIMESCORE;

/*

EPERFORMANCE TABLE DETAILS
EMPID will reference the EMPLOYEE TABLE's EMPNO (FOREIGN KEY)
LIOTIMESCORE is a measure of whether an employee logs in and logs out of work at their respective wrok shfits,
REPORTSUBTIME is a measure of the number of times the employee has submitted the report or task with 3 for being Before Time submission
and 2 for an On time submission and 1 for a delay in the report submission.
PRODUCTIVITY is the overall score for a person for the ability to work productivily 


These ALL columns can we applied on a monthly basis and I believe this table should not be created for every month, instead we could
simply create a form in the user interface side of things and then simply add all of those, maybe if someone needs all this data for any
kind of analysis in the future, where can I store it?, How can I store it?




*/

/*

Creating a table for finances where the first column will store the date and the next colum will store which department made that
profit and then we will have monthly profits and Losses. 


*/

CREATE TABLE FINANCES(
      INPUTTIME datetime NOT NULL,
      DeptID INT REFERENCES DEPT(DeptID),
      PROFIT BIGINT NOT NULL,
      LOSS BIGINT NOT NULL
)

ALTER TABLE FINANCES
ADD COLUMN NETPROFIT BIGINT;

-- creating a department table 

CREATE TABLE DEPT(
      DeptID INT PRIMARY KEY,
      DeptName VARCHAR(50) NOT NULL,
      NumberofEmp INT
)

CREATE TABLE LOGINCRED(
      Username VARCHAR(30) PRIMARY KEY,
      Password VARCHAR(30) NOT NULL,
      EMPNO BIGINT REFERENCES EMPLOYEE(EMPNO)
);

DROP TABLE LOGINCRED;


SELECT * FROM EMPLOYEE;
SELECT * FROM EmployeeFinances;
SELECT * FROM EPERFORMANCE;
SELECT * FROM FINANCES;
SELECT * FROM DEPT;
SELECT * FROM LOGINCRED;

INSERT INTO DEPT (DeptID, DeptName, NumberofEmp)
VALUES (101, "Finance", 8),
(102, "Marketing", 8),
(103, "IT", 8),
(104, "Sales", 6);

SELECT WORKDEPT,COUNT(EMPNO) FROM EMPLOYEE GROUP BY `WORKDEPT`;

UPDATE EMPLOYEE
SET MIDINIT = "A",LASTNAME = "Dexter"
WHERE EMPNO = 1;

INSERT INTO EMPLOYEE (EMPNO, FIRSTNME, MIDINIT, LASTNAME, WORKDEPT, PHONENO, ADDRESS1, ADDRESS2, CITY, STATES, COUNTRY, EDLEVEL, SEX, BIRTHDATE)
VALUES
(1, 'John', 'D', 'Doe', 101, '1234', '123 Main St', 'Apt 456', 'Anytown', 'CA', 'USA', 16, 'M', '1990-05-15'),
(2, 'Jane', 'M', 'Smith', 102, '5678', '456 Oak St', 'Unit 789', 'Sometown', 'NY', 'USA', 18, 'F', '1988-12-10'),
(3, 'Bob', 'E', 'Johnson', 101, '9876', '789 Pine St', NULL, 'Othercity', 'TX', 'USA', 14, 'M', '1995-02-28'),
(4, 'Alice', 'K', 'Williams', 103, '6543', '321 Elm St', 'Suite 555', 'Somewhere', 'FL', 'USA', 20, 'F', '1985-08-20'),
(5, 'Charlie', 'R', 'Brown', 102, '2345', '111 Cedar St', NULL, 'Nowhere', 'AZ', 'USA', 16, 'M', '1992-07-03'),
(6, 'Eva', 'L', 'Davis', 103, '8765', '555 Pineapple Ave', 'Apt 123', 'Tropicaltown', 'FL', 'USA', 19, 'F', '1989-11-18'),
(7, 'George', 'A', 'Johnson', 101, '3456', '789 Oak St', 'Unit 456', 'Newcity', 'IL', 'USA', 17, 'M', '1993-04-05'),
(8, 'Helen', 'S', 'Jones', 104, '7890', '222 Maple St', 'Suite 789', 'Maplewood', 'NJ', 'USA', 18, 'F', '1987-09-25'),
(9, 'David', 'P', 'Clark', 102, '1234', '456 Pine St', NULL, 'Pinesville', 'CA', 'USA', 15, 'M', '1996-01-12'),
(10, 'Grace', 'T', 'Martin', 103, '5678', '789 Elm St', 'Apt 987', 'Greenville', 'SC', 'USA', 20, 'F', '1986-06-30'),
(11, 'Frank', 'M', 'Anderson', 101, '9876', '123 Maple St', 'Unit 321', 'Mapletown', 'WA', 'USA', 16, 'M', '1994-03-22'),
(12, 'Irene', 'B', 'Baker', 104, '6543', '555 Oak St', NULL, 'Oakville', 'OH', 'USA', 19, 'F', '1991-08-14'),
(13, 'Jack', 'S', 'Evans', 102, '2345', '321 Pine St', 'Suite 222', 'Pinewood', 'CO', 'USA', 17, 'M', '1990-02-08'),
(14, 'Katherine', 'C', 'Harris', 103, '8765', '789 Cedar St', 'Apt 555', 'Cedarville', 'IN', 'USA', 18, 'F', '1988-07-17'),
(15, 'Leo', 'J', 'Wong', 102, '3456', '111 Oak St', NULL, 'Oaktown', 'OR', 'USA', 15, 'M', '1995-12-03'),
(16, 'Marilyn', 'L', 'Miller', 104, '7890', '222 Pine St', 'Suite 444', 'Pinetown', 'LA', 'USA', 20, 'F', '1989-05-28'),
(17, 'Nathan', 'R', 'Turner', 101, '1234', '456 Cedar St', 'Apt 999', 'Cedarville', 'NV', 'USA', 14, 'M', '1992-10-11'),
(18, 'Olivia', 'E', 'Barnes', 103, '5678', '789 Maple St', 'Unit 777', 'Mapleville', 'MA', 'USA', 17, 'F', '1993-03-01'),
(19, 'Peter', 'W', 'White', 102, '9876', '123 Cedar St', NULL, 'Cedartown', 'WI', 'USA', 19, 'M', '1987-06-23'),
(20, 'Quinn', 'G', 'Roberts', 104, '6543', '555 Elm St', 'Suite 333', 'Elmsville', 'KY', 'USA', 16, 'F', '1996-09-19'),
(21, 'Robert', 'H', 'Lee', 101, '2345', '321 Cedar St', NULL, 'Cedarburg', 'SD', 'USA', 18, 'M', '1985-04-16'),
(22, 'Samantha', 'F', 'Young', 103, '8765', '789 Pine St', 'Apt 888', 'Pinetown', 'NC', 'USA', 20, 'F', '1990-01-30'),
(23, 'Timothy', 'J', 'Taylor', 102, '3456', '111 Oak St', NULL, 'Oakland', 'ID', 'USA', 15, 'M', '1994-07-08'),
(24, 'Ursula', 'K', 'Brown', 104, '7890', '222 Pine St', 'Unit 222', 'Pinesburg', 'KS', 'USA', 19, 'F', '1988-12-05'),
(25, 'Vincent', 'L', 'Garcia', 101, '1234', '456 Elm St', 'Apt 333', 'Elmtown', 'OK', 'USA', 17, 'M', '1992-04-24'),
(26, 'Wendy', 'N', 'Cooper', 103, '5678', '789 Pine St', 'Suite 666', 'Pinewood', 'MS', 'USA', 16, 'F', '1995-11-14'),
(27, 'Xavier', 'Q', 'Lopez', 102, '9876', '123 Oak St', NULL, 'Oakville', 'RI', 'USA', 18, 'M', '1989-08-07'),
(28, 'Yvonne', 'R', 'Reyes', 104, '6543', '321 Cedar St', 'Apt 111', 'Cedartown', 'MO', 'USA', 19, 'F', '1986-03-26'),
(29, 'Zachary', 'S', 'Ward', 101, '2345', '555 Elm St', 'Unit 777', 'Elmville', 'GA', 'USA', 20, 'M', '1991-10-18'),
(30, 'Amy', 'D', 'Hill', 103, '8765', '222 Pine St', 'Suite 444', 'Pinewood', 'AL', 'USA', 15, 'F', '1993-05-02');


INSERT INTO EmployeeFinances (EMPNO, SALARY, BONUS, COMM, TAXPERCENTAGE) VALUES
(1, 80000.00, 3000.00, 1500.00, 0.12),
(2, 90000.00, 3500.00, 1800.00, 0.13),
(3, 75000.00, 2800.00, 1200.00, 0.10),
(4, 100000.00, 4000.00, 2000.00, 0.15),
(5, 70000.00, 2500.00, 1300.00, 0.09),
(6, 85000.00, 3200.00, 1600.00, 0.11),
(7, 95000.00, 3800.00, 1900.00, 0.14),
(8, 72000.00, 2700.00, 1100.00, 0.09),
(9, 105000.00, 4200.00, 2200.00, 0.16),
(10, 68000.00, 2400.00, 1200.00, 0.08),
(11, 88000.00, 3300.00, 1700.00, 0.12),
(12, 92000.00, 3600.00, 1900.00, 0.13),
(13, 78000.00, 2900.00, 1400.00, 0.10),
(14, 98000.00, 3900.00, 2000.00, 0.14),
(15, 71000.00, 2600.00, 1100.00, 0.08),
(16, 89000.00, 3400.00, 1600.00, 0.11),
(17, 94000.00, 3700.00, 1800.00, 0.12),
(18, 76000.00, 3000.00, 1300.00, 0.09),
(19, 102000.00, 4100.00, 2100.00, 0.15),
(20, 69000.00, 2300.00, 1200.00, 0.08),
(21, 87000.00, 3200.00, 1500.00, 0.11),
(22, 91000.00, 3500.00, 1700.00, 0.12),
(23, 77000.00, 2800.00, 1400.00, 0.10),
(24, 99000.00, 4000.00, 2000.00, 0.14),
(25, 73000.00, 2500.00, 1100.00, 0.09),
(26, 90000.00, 3300.00, 1600.00, 0.11),
(27, 96000.00, 3700.00, 1800.00, 0.12),
(28, 79000.00, 3000.00, 1400.00, 0.10),
(29, 104000.00, 4200.00, 2200.00, 0.15),
(30, 70000.00, 2400.00, 1200.00, 0.08);

ALTER TABLE EMPLOYEE
DROP EDLEVEL;

INSERT INTO EPERFORMANCE (EMPID, REPORTSUBTIME, PRODUCTIVITY) VALUES
(1, 1, 8),
(2, 3, 5),
(3, 2, 9),
(4, 1, 7),
(5, 3, 6),
(6, 2, 8),
(7, 1, 10),
(8, 3, 4),
(9, 2, 7),
(10, 1, 9),
(11, 3, 6),
(12, 2, 8),
(13, 1, 7),
(14, 3, 5),
(15, 2, 9),
(16, 1, 8),
(17, 3, 6),
(18, 2, 7),
(19, 1, 9),
(20, 3, 5),
(21, 2, 8),
(22, 1, 7),
(23, 3, 6),
(24, 2, 9),
(25, 1, 8),
(26, 3, 7),
(27, 2, 6),
(28, 1, 9),
(29, 3, 5),
(30, 2, 8);

-- Assuming you have DEPT table with DeptID values

-- Example DEPT table creation
-- CREATE TABLE DEPT(
--     DeptID INT PRIMARY KEY,
--     DepartmentName VARCHAR(255)
-- );

-- Example DEPT data insertion
-- INSERT INTO DEPT (DeptID, DepartmentName) VALUES
-- (101, 'Finance'),
-- (102, 'Marketing'),
-- (103, 'IT'),
-- (104, 'Sales');

-- Dummy data for FINANCES table
INSERT INTO FINANCES (INPUTTIME, DeptID, PROFIT, LOSS)
VALUES
('2023-01-27 18:30:00', 101, 50000, 20000),
('2023-01-27 18:30:00', 102, 60000, 25000),
('2023-01-27 18:30:00', 103, 55000, 18000),
('2023-01-27 18:30:00', 104, 52000, 22000),
('2023-02-24 18:45:00', 101, 60000, 25000),
('2023-02-24 18:45:00', 102, 58000, 24000),
('2023-02-24 18:45:00', 103, 53000, 20000),
('2023-02-24 18:45:00', 104, 55000, 21000),
('2023-03-31 18:15:00', 101, 55000, 18000),
('2023-03-31 18:15:00', 102, 62000, 26000),
('2023-03-31 18:15:00', 103, 58000, 22000),
('2023-03-31 18:15:00', 104, 53000, 20000),
('2023-04-28 18:30:00', 101, 52000, 22000),
('2023-04-28 18:30:00', 102, 59000, 24000),
('2023-04-28 18:30:00', 103, 56000, 21000),
('2023-04-28 18:30:00', 104, 54000, 23000),
('2023-05-26 18:45:00', 101, 54000, 23000),
('2023-05-26 18:45:00', 102, 60000, 25000),
('2023-05-26 18:45:00', 103, 55000, 20000),
('2023-05-26 18:45:00', 104, 57000, 22000),
('2023-06-30 18:15:00', 101, 57000, 22000),
('2023-06-30 18:15:00', 102, 62000, 26000),
('2023-06-30 18:15:00', 103, 58000, 23000),
('2023-06-30 18:15:00', 104, 59000, 24000),
('2023-07-28 18:30:00', 101, 60000, 25000),
('2023-07-28 18:30:00', 102, 57000, 22000),
('2023-07-28 18:30:00', 103, 54000, 20000),
('2023-07-28 18:30:00', 104, 56000, 21000),
('2023-08-25 18:45:00', 101, 59000, 24000),
('2023-08-25 18:45:00', 102, 61000, 26000),
('2023-08-25 18:45:00', 103, 58000, 23000),
('2023-08-25 18:45:00', 104, 60000, 25000),
('2023-09-29 18:15:00', 101, 58000, 23000),
('2023-09-29 18:15:00', 102, 60000, 25000),
('2023-09-29 18:15:00', 103, 55000, 20000),
('2023-09-29 18:15:00', 104, 57000, 22000),
('2023-10-27 18:30:00', 101, 59000, 24000),
('2023-10-27 18:30:00', 102, 57000, 22000),
('2023-10-27 18:30:00', 103, 54000, 20000),
('2023-10-27 18:30:00', 104, 56000, 21000),
('2023-11-24 18:45:00', 101, 60000, 25000),
('2023-11-24 18:45:00', 102, 58000, 24000),
('2023-11-24 18:45:00', 103, 53000, 20000),
('2023-11-24 18:45:00', 104, 55000, 21000),
('2023-12-29 18:15:00', 101, 57000, 22000),
('2023-12-29 18:15:00', 102, 62000, 26000),
('2023-12-29 18:15:00', 103, 56000, 23000),
('2023-12-29 18:15:00', 104, 59000, 24000);


-- Dummy data for LOGINCRED table
INSERT INTO LOGINCRED (Username, Password, EMPNO) VALUES
('john_a_dexter', 'p@55w0rd!', 1),
('jane_m_smith', '1234xyz', 2),
('bob_e_johnson', '!9876word', 3),
('alice_k_williams', '6543abc', 4),
('charlie_r_brown', 'qwerty2345', 5),
('eva_l_davis', 'p@ss8765', 6),
('george_a_johnson', '3456word!', 7),
('helen_s_jones', 'p@55w0rd', 8),
('david_p_clark', '!secure123', 9),
('grace_t_martin', '5678word', 10),
('frank_m_anderson', '!9876p@55', 11),
('irene_b_baker', '6543!word', 12),
('jack_s_evans', 'p@55word2345', 13),
('katherine_c_harris', '8765abc', 14),
('leo_j_wong', '!p@ss3456', 15),
('marilyn_l_miller', '!7890secure', 16),
('nathan_r_turner', 'password!secure', 17),
('olivia_e_barnes', '!5678p@ss', 18),
('peter_w_white', '!9876secure', 19),
('quinn_g_roberts', 'word!6543', 20),
('robert_h_lee', 'p@ss2345!', 21),
('samantha_f_young', '8765p@ss!', 22),
('timothy_j_taylor', '!secure3456', 23),
('ursula_k_brown', 'p@ss7890!', 24),
('vincent_l_garcia', '123!secure', 25),
('wendy_n_cooper', 'p@ss5678!', 26),
('xavier_q_lopez', '!9876qwerty', 27),
('yvonne_r_reyes', '6543p@ss!', 28),
('zachary_s_ward', '!p@ss2345', 29),
('amy_d_hill', '!secure8765', 30);

INSERT INTO LOGINCRED(Username, Password, EMPNO)
VALUES ("vardhandasarly", "cfrgtjae", 31);

-- NetProfit calculation
UPDATE FINANCES
SET NetProfit = PROFIT - LOSS;

SELECT Password FROM LOGINCRED WHERE Username = "vardhandasarly";

ALTER TABLE EMPLOYEE
MODIFY MIDINIT CHAR(1);

ALTER TABLE EMPLOYEE
MODIFY FIRSTNME VARCHAR(50);

ALTER TABLE EMPLOYEE
MODIFY LASTNAME VARCHAR(50);

ALTER TABLE EMPLOYEE
MODIFY PHONENO BIGINT;

INSERT INTO EMPLOYEE (EMPNO, FIRSTNME, MIDINIT, LASTNAME, WORKDEPT, PHONENO, ADDRESS1, ADDRESS2, CITY, STATES, COUNTRY, SEX, BIRTHDATE)
VALUES (31,"SRI VARDHAN REDDY", NULL, "DASARLAPALLI", 105, '9734196893123', "Hyderabad", NULL, "HYD", "TELANGANA", "INDIA", "M", "2003-07-17" );

INSERT INTO DEPT(DeptID, DeptName, NumberofEmp)
VALUES (105, "ADMINISTRATOR", 1);

GRANT ALL PRIVILEGES ON management TO 'root'@'localhost' WITH GRANT OPTION; 
FLUSH PRIVILEGES; 


ALTER TABLE EMPLOYEE 
      ADD FOREIGN KEY RED (WORKDEPT) 
      REFERENCES DEPARTMENT 
      ON DELETE SET NULL

ALTER TABLE EMPLOYEE 
      ADD CONSTRAINT NUMBER 
      CHECK (PHONENO >= '0000' AND PHONENO <= '9999')

