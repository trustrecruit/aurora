// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

  import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; 
  import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
  import "@openzeppelin/contracts/utils/Counters.sol";
  import "@openzeppelin/contracts/access/Ownable.sol";
    
contract NftResume is ERC721,ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    address public tokenVaultContract;
    
    Counters.Counter private _tokenIdCounter;
     struct ResumeStruct {
        string name;
        string hash; 
        string cat; 
        string sub;     
        uint256  price ; 
        address owner;  
        uint id;
        address tokenaddress;
    }
    
   
     mapping (address => ResumeStruct) ResumeStructs;
    address[] public ResumesAccs;
  
    constructor() ERC721("TrustrecruitNft", "TNFT") {
     
    }

    // function _baseURI() internal pure override returns (string memory) {
    //     return "https://storageapi.fleek.co/parvindrachaudhary-team-bucket/";
    // }

    function Mint(address _vaultAddress,string memory _name, string memory _hash,string memory _cat,string memory _sub,uint256  _price) public  returns (bool){
   _safeMint(msg.sender, _tokenIdCounter.current()); 
        tokenVaultContract = _vaultAddress;
   ResumeStruct storage resumeStruct = ResumeStructs[msg.sender];
        resumeStruct.name = _name;
        resumeStruct.hash = _hash;
        resumeStruct.cat = _cat;
        resumeStruct.sub = _sub;
        resumeStruct.price = _price;
        resumeStruct.owner = msg.sender;
        resumeStruct.id = _tokenIdCounter.current();
        ResumesAccs.push(msg.sender);
        _tokenIdCounter.increment();
         setApprovalForAll(_vaultAddress, true);
        return true ;
    }

    
    function setResumePrice(uint _price,,string memory id) public {
        require(msg.sender == ResumeStructs[msg.sender].owner);
        ResumeStructs[id].price = _price;
    }
    
      function setResumeName(string memory _name,,string memory id) public {
        require(msg.sender == ResumeStructs[msg.sender].owner);
        ResumeStructs[id].name = _name;
        
    }
    
     function setResumeHash(string memory _hash,string memory id) public {
        require(msg.sender == ResumeStructs[msg.sender].owner);
        ResumeStructs[id].hash = _hash;
    }
    
     function setResumeCat(string memory _cat,string memory _sub,,string memory id) public {
        require(msg.sender == ResumeStructs[msg.sender].owner);
        ResumeStructs[id].cat = _cat;
        ResumeStructs[id].sub = _sub;
       
    }
    
    
  function getResumeAllOwners() view public returns( address[] memory) {
        return ResumesAccs;
    }
     
    
    function getResume(address _address) view public returns ( string memory, string memory,string memory, string memory,uint256,uint) {
        return (ResumeStructs[_address].name, ResumeStructs[_address].hash, ResumeStructs[_address].cat, ResumeStructs[_address].sub, ResumeStructs[_address].price,ResumeStructs[_address].id);
    }
    
    function countResumes() view public returns (uint) {
        return ResumesAccs.length;
    }



    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

 
}

