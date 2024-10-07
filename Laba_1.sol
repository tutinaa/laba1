// SPDX-License-Identifier: MIT 
pragma solidity 0.8.26; 

contract Wallet{ 
    address public immutable OWNER; 
    uint private _currentBalance; 
    address public TestAdress=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; 

    constructor(){ 
        OWNER = msg.sender; 
    } 


    function Deposit() public payable { 
        _currentBalance += msg.value; 

    } 

    function Withdraw(uint amountToWithdraw) public IsOwner {
        require(_currentBalance >= amountToWithdraw, "Insufficient balance");
        payable(msg.sender).transfer(amountToWithdraw);
        _currentBalance -= amountToWithdraw;
    }

    function WithdrawAllMoney() public IsOwner {  
        require(_currentBalance > 0, "Balance is zero");  
        payable(OWNER).transfer(_currentBalance);  
        _currentBalance = 0;  
    
    }

    function SendMoneyTo(address to, uint amountInWei) public IsOwner payable { 
        require(_currentBalance >= amountInWei, "Insufficient balance"); 
        _currentBalance -= amountInWei; 
        payable(to).transfer(amountInWei); 

    } 

    function ReturnCurrentBalance() public view IsOwner returns (uint) { 
        return _currentBalance; 
    } 

    modifier IsOwner(){ 
        require(msg.sender == OWNER, "You are not the owner of this contract."); 
        _; 
    }
}