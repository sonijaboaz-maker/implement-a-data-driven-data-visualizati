pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/StringHelpers.sol";

contract DataNotifier {
    address private owner;
    mapping (string => uint256) public data;
    mapping (string => address[]) public subscribers;

    event NewData(string key, uint256 value);
    event Subscription(string key, address subscriber);

    constructor() {
        owner = msg.sender;
    }

    function setData(string key, uint256 value) public onlyOwner {
        data[key] = value;
        emit NewData(key, value);
    }

    function subscribe(string key) public {
        subscribers[key].push(msg.sender);
        emit Subscription(key, msg.sender);
    }

    function unsubscribe(string key) public {
        for (uint256 i = 0; i < subscribers[key].length; i++) {
            if (subscribers[key][i] == msg.sender) {
                delete subscribers[key][i];
                break;
            }
        }
    }

    function notifySubscribers(string key) internal {
        for (uint256 i = 0; i < subscribers[key].length; i++) {
            // Use a hypothetical notification mechanism (e.g. Web3.js, WebSockets)
            // notify(subscribers[key][i], key, data[key]);
        }
    }

    function notifyOnNewData(string key, uint256 value) internal {
        notifySubscribers(key);
    }
}