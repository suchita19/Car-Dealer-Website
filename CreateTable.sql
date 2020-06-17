--1. User_Info
CREATE TABLE User_Info (     
	UserID               NUMBER         NOT NULL,     
	Email                VARCHAR2(40)   NOT NULL,
	Username             VARCHAR2(20)   NOT NULL UNIQUE,
	Password             VARCHAR2(20)   NOT NULL, 
	Contact_Information  VARCHAR2(20)   NOT NULL,
	Credit_Card_Number   CHAR(19)       NULL,
	SSN                  NUMBER         NULL UNIQUE,
	Passport_Number      VARCHAR2(10)   NULL UNIQUE,
	PRIMARY KEY (UserID)
);
	
--2. Car
CREATE TABLE Car (
	CarID                     CHAR(9)         NOT NULL, 
	Gearbox                   VARCHAR2(10)    NOT NULL CONSTRAINT gb CHECK (Gearbox = 'Manual' OR Gearbox = 'Automatic'),
	Km_Age                    NUMBER          NOT NULL CONSTRAINT km CHECK (Km_Age >= 0.0),
	Picture                   VARCHAR2(2000)  NULL,
	Transaction_State         VARCHAR2(5)     NOT NULL,
	Transaction_City          VARCHAR2(100)   NOT NULL,
	Transaction_Zip_Code      CHAR(5)         NOT NULL,
	Brand                     VARCHAR2(100)   NOT NULL,
	Model                     VARCHAR2(1000)  NULL,
	Price                     BINARY_FLOAT    NOT NULL,
	Price_for_new_car         BINARY_FLOAT    NULL,
	Sold_time                 INT             NOT NULL,
	Car_Insurance             VARCHAR2(1)     NOT NULL CONSTRAINT Insurance CHECK (Car_Insurance = 'Y' OR Car_Insurance = 'N'),
	UserID                    NUMBER          NOT NULL,
	Car_Status                VARCHAR2(10)    NOT NULL CONSTRAINT CStat CHECK (Car_Status = 'sold out' OR Car_Status = 'waiting'),
	PRIMARY KEY (CarID),
	FOREIGN KEY (UserID) REFERENCES User_Info(UserID)
);

--3. Interest
CREATE TABLE Interest (     
	UserID   NUMBER  NOT NULL, 
	CarID    CHAR(9) NOT NULL,    
	PRIMARY KEY (UserID,CarID),
	FOREIGN KEY (UserID) REFERENCES User_Info(UserID),
	FOREIGN KEY (CarID) REFERENCES Car(CarID)
);

--4. View_History
CREATE TABLE View_History (     
	UserID   NUMBER  NOT NULL, 
	CarID    CHAR(9) NOT NULL,
	Time     DATE    NOT NULL,    
	PRIMARY KEY (UserID,CarID),
	FOREIGN KEY (UserID) REFERENCES User_Info(UserID),
	FOREIGN KEY (CarID) REFERENCES Car(CarID)
);

--5. Order_History
CREATE TABLE Order_History (  
	OrderID             NUMBER        NOT NULL, 
	Transaction_Time    DATE          NOT NULL,
	UserID1             NUMBER        NOT NULL, 
	UserID2             NUMBER        NOT NULL,
	CarID               CHAR(9)       NOT NULL,    
	Transcation_date    DATE          NOT NULL,
	Transcation_amount  BINARY_FLOAT  NOT NULL,
	Order_Status        VARCHAR2(15)  NOT NULL CONSTRAINT OStat CHECK (Order_Status = 'Arrived' OR Order_Status = 'Not Arrived'),
	User_Role           VARCHAR2(10)  NOT NULL CONSTRAINT Role CHECK (User_Role = 'Buyer' OR User_Role = 'Dealer'),
	PRIMARY KEY (OrderID),
	FOREIGN KEY (UserID1) REFERENCES User_Info(UserID),
	FOREIGN KEY (UserID2) REFERENCES User_Info(UserID),
	FOREIGN KEY (CarID) REFERENCES Car(CarID)
);

--6. Post
CREATE TABLE Post (
	UserID   NUMBER        NOT NULL,
	CarID    CHAR(9)       NOT NULL,
	Time     DATE          NOT NULL,
	Status   VARCHAR2(50)  NOT NULL CONSTRAINT Stat CHECK (Status = 'Waiting' OR Status = 'Purchased'),
	PRIMARY KEY (UserID, CarID),
	FOREIGN KEY (UserID) REFERENCES User_Info(UserID),
	FOREIGN KEY (CarID) REFERENCES Car(CarID)
);

--7. Country_Info
CREATE TABLE Country_Info (
	Zip_Code     CHAR(5)         NOT NULL,
	City         VARCHAR2(50)    NOT NULL,
	State        VARCHAR2(50)    NOT NULL,
	Abbreviation CHAR(2)         NOT NULL,
	PRIMARY KEY (Zip_Code, City, State)
);


