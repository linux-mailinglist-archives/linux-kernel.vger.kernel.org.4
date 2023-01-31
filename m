Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E929D682A71
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjAaKZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjAaKZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:25:12 -0500
Received: from mx0a-00209e01.pphosted.com (mx0a-00209e01.pphosted.com [148.163.148.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28F04C6C0;
        Tue, 31 Jan 2023 02:25:09 -0800 (PST)
Received: from pps.filterd (m0115755.ppops.net [127.0.0.1])
        by mx0a-00209e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V32R0s022404;
        Tue, 31 Jan 2023 05:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pod1119;
 bh=5VulXayu5AIdH1Wk7h1Ul34hw9yevJw7fHdq5KmkzlI=;
 b=zUeg+FVSQWydJVMUwwa8b28xKcX+FAd1OYiMn1NDHftttCzlDSJDnklbWxizuNE4WzZQ
 RENz30gys8Bc7Vh23YR27zO3k4DzMmjqRBTs4xF0V46UN+pwv1fB1o5nvw3n9cQ9xW7R
 ZsfiSa1IN/K9q2W6tUCdJ2hpLc9Wbtlji5/wfgBWNA30vv8ztLV5l/M1psrxIofSxuX1
 6e0VQsvdYpkF1zVEFVY61m9EPkjJkDj3MUqZG0Ur+NZ4D9FQbPaAXwpyRq7SB6CN9rPw
 oq5Y3dDuiVD3UMVEAFr8zAZfKLIB/Ktzql0mzIf/2GdEUc8yNAQ+jtYMpf5XefHRqd6h 6A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-00209e01.pphosted.com (PPS) with ESMTPS id 3ncx7wkptn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 05:25:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwTyLeKUtu1XsIFP1Y44Rr1CTLAvrNs+joxq3Koysiu3CCqAgR4iBC3tSoqRSxJz7QJevSTAJR8wQFQvV/gQnpfGXU3ZjtKOtBPBFVT6ohvuPHbzk/3tW7teFBRrpxxHH1GvZidp9eOzSO0O+47UHD8TOOK2Whd9WHkgIhq7/LGvWfjkD0mRSYvNutznluH0Xo1EForBxL/ufSzuVe9iFjanKPvgSlUHGtYPWHloIFAQnow0SC4GXGsB1rMMdvgcNZTzg4SWtSsjmJ+NjW05/hA2LhcoqtT4Fsjt2DLvkb38jQPLDMCc3yuH5RieA4uf/JeDiCZ8l/92Q0zIqW9yhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VulXayu5AIdH1Wk7h1Ul34hw9yevJw7fHdq5KmkzlI=;
 b=W1W1KCuR/Ob94vCM1JbxHzKcf/u+QOpAbToPsB9Qb0bLygkCJaoWSKgtZ+/honwMQDUNUg75LZOGlJPInAm7CvyftCNbJDMrt1YIvQku2fXIXcr7aydzzYoOMz9v+EqNF3dzSBLzmzvPPNG7eorl/qskwswrHdFq6e2CLX0FtGTOwNLyL/r9Q6Ra2hr5V6MZKv4pWcrTtoeYX1jZHv1IZM5i3pEOqduWLSBBSfjNhug5v738/22bO7CbLG90QFdEupgqOVjtVXqUjeEUP2VYCqislupPmyZteSyja5yykyQgQ9Bh77WTMtQWGEYDc39P/ZP+5GXOt8dz0FZPDCM0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from MW5PR15MB5218.namprd15.prod.outlook.com (2603:10b6:303:19e::18)
 by MW3PR15MB3834.namprd15.prod.outlook.com (2603:10b6:303:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 10:25:04 +0000
Received: from MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6]) by MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6%3]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 10:25:04 +0000
From:   "Leonard, Niall" <Niall.Leonard@ncr.com>
To:     Rob Herring <robh@kernel.org>,
        "Leonard, Niall" <Niall.Leonard@ncr.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
 bindings
Thread-Topic: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
 bindings
Thread-Index: AQHZMW99YCz74HQkk0+hHBCSYD4Bfa6woJsAgAF0QhCAA32uAIABZfOAgABYVwCAAQjbgA==
Date:   Tue, 31 Jan 2023 10:25:04 +0000
Message-ID: <87743158-f65e-53cc-dd09-1720d6e6e0b9@ncr.com>
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
 <20230126-gpio-mmio-fix-v1-1-8a20ce0e8275@ncr.com>
 <d4a70ab2-c5a2-2478-3fa9-c703c1619252@linaro.org>
 <MW5PR15MB52184F83BA524D9600B820F5FDCC9@MW5PR15MB5218.namprd15.prod.outlook.com>
 <ed16faa2-eb04-772d-8762-0c3f90fddbcb@linaro.org>
 <c95cea18-5b92-e16c-f4f6-cde93ca22ca1@ncr.com>
 <20230130183706.GA3079628-robh@kernel.org>
In-Reply-To: <20230130183706.GA3079628-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR15MB5218:EE_|MW3PR15MB3834:EE_
x-ms-office365-filtering-correlation-id: 97165294-2e9f-4a78-a4b7-08db03756ac9
x-from-ncr-tenant: Processed
x-pp-secret: m9yph.359rsj96jnp6w-uuxnb8thy.9r62ir35fve
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KoDNTCpSOnGXGt9Uw5+YN8aDyKw2NL015hrGANs2BQu+1BB6uq/vx0NxmHkZ5zSGg4idOgCVMU2olvtg/b1nJwiWk5mdYocl+CN/c9XVQqgzdNDBgi9nYoOZB2LKznTY54k7FVzDIbwCqPCNmv4SPJv1zCoxZOC62hzab34Lcf1kXTiXxPO0r63vXC4o+/23Xpi+x/1P3vLrr2cB3xceSZPHMP0EbApPRcKgx2QHGXcQwO8eLhlLa3dq8zuCmmstJ21yDe5ZISwIQR7F8bgW+AjoqbJFGIzODhej3RFV968V9F0Nl4DQA3/SMFp4XVUhbEy03J0mxJatPcZ7ocYM4YQxSEsJ8JT+gK2OC7fyKnY8XXdtiYXnBuTobtFA01rV7GqQgoK3o1tSJvt4NB2p8yqB0dnMn7tff9sFOjUDuazHJLvaEnMuHgOvrFDoc7Y2NWc6rfRc1C5SC+tsySUdvFqgjh3dOge3xtGBVUKC1uAms5sAF6OaHMjsqvEHKaqn9Wamp3DFaIEvMbrfQ5qWKjTpEMupoYuIYvil3zOuCZf259HAHpabWuOoWaXkiTDzTlhjlmhXnUAAXNxDjgAWSw3ewR3vK7dxtvK7EEV9bvdlOZPmFBHhxE6YTJB1UQhJ54U/mnSv0CGA905kKB6wjFyagVtRjIlnnMxnlJhrRbE6vh/vnD6tZByGMkFw8Row5OzHhRjMO6bG4SMdd7anMSKQSIG6KGhwIP8O2JvELRpUxRw9+0u0Syky98xbtTDJeKnntzth9zgVUqHy8dPn+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR15MB5218.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199018)(31686004)(2906002)(5660300002)(38070700005)(86362001)(82960400001)(83380400001)(8936002)(31696002)(41300700001)(36756003)(478600001)(71200400001)(26005)(6512007)(186003)(6506007)(53546011)(6486002)(110136005)(54906003)(2616005)(4326008)(66476007)(66446008)(76116006)(8676002)(66946007)(66556008)(316002)(91956017)(38100700002)(64756008)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3FUYk5uUVJnUldQcGd1Qys0RktqaWJoZTMrOCt0dk5FOEVwNjE4T2hGVHBE?=
 =?utf-8?B?dUQ3OHJWMGNzOEZlVlpRMTJ6WGE1QVpLVmRPRWNNSnUvMGFMcUdDRjYxZXR4?=
 =?utf-8?B?eUYrb1NnT2ZTUjh4VFB2bDYwK3VrZm5yR09HdWdOUDg1MXFBNmcxd3lkRytj?=
 =?utf-8?B?NVpKcFlna3ZFOURTbS9RM0RaSURvd1VteFVZUXBHS0V4dHlQUGNzSWYxWUl1?=
 =?utf-8?B?MXBwWkUwRTZRelduTUVGUFQ4Ukd1clNGcEJjdW1oZVMyT0xHTWwwZDl1bENU?=
 =?utf-8?B?ODYyQUd2VjNHTFFwRzZ5V2EyVWo5TUc2TkZmSHBxTkRVTVNQNHU0WHNFQjNJ?=
 =?utf-8?B?UlRSck5lYVluektlbG9nV2VDUTdveCttUlRqbUcwc0ZhQndybE4zR2ZNZG82?=
 =?utf-8?B?Z3lzbnhkcmVxdy8vNkJTM3dDeHRlVUlkbzJZZk93VW5NUjRDQzYrUTF6RFNW?=
 =?utf-8?B?ejZzYTFIdFYrVEdRZlVUNk5uOUdrcC9YS3lUUHJ0cjl2bTU5MWJtbWRjcWto?=
 =?utf-8?B?QnFOSENvd1BjVFFZbjF0VTV4Wkl0N3JnUmZHK2hERUVNS3ptdTJPTSttWjdp?=
 =?utf-8?B?WndXOE1rek4zY0tkQjZSQ3E5ZlVZYmIwTlZaWnRnUzBRREp1OU5odGtnSG5n?=
 =?utf-8?B?M3dVMzg4cnFhUWFtRWdtQkxER21zclRNa3M0Rk9xUVgvWi9Oam9pRUk4dTNL?=
 =?utf-8?B?VDBKL1VYL0ZVb0djTVRNVHV2OVJlMXBDMkFLSUgvUCtHdk4zUlc2cjZuVWE3?=
 =?utf-8?B?VjJpOFo1Z2J1RDNMeVZzOCtuOEZPN2xYUHFDMmVtVHVoR2l6alM3UVR3Nngw?=
 =?utf-8?B?bWRpT1VzNk1ub0QrZDBRc25ZNHBJb01xZlhubEdKTXdpd1BBUVpTWldWRTdL?=
 =?utf-8?B?eVd5UHY5MW5DcnVDbi9mTFFHdkNNcHRHRjJuVmxHditEOEVqRzg2UXkzc0NT?=
 =?utf-8?B?dGFlVStMMG9ONFkzcXYrVXhUaThZWHc0TUdFUGlISW93WGpHTGFuNTBTR3RW?=
 =?utf-8?B?dmc4UXNxUVFhaHV1SysvbGZpMWhLdS8zejVGNVQ3akpXbENtR2JJbzluQkwz?=
 =?utf-8?B?OVRmWEpsTEY2OTh4d2s3NU5TUE1lS3ppOXVCc25WTzFPVjROM1N2T2l1NWdx?=
 =?utf-8?B?SHNaMTIxUHVxckZzcHA2SlZwVWsvdDB1YTNoekhKQUpaTk1aMExlR1ZwL3ox?=
 =?utf-8?B?WFpGdkpHTTdiZE4yZ2pXNkQwS05FMG5CMk0xUkFKOW1YczNneWViQmdwSU1u?=
 =?utf-8?B?NFlsbVgxVlNpZzBxVVIxZTRSWVRsZVhkdk9zcnJ3ZCsvaGtFWDlRK0dWQU53?=
 =?utf-8?B?clBEYi9QdjhkYlZQQnZNSnhwUXBhYjZxOHpvVlIxbkR4b0hEYzI2RUlRbWht?=
 =?utf-8?B?dXpkVFBWN1ltYkdCbU5UbGhac0txTE5iMHNlSWxGUDIxdGsxZkJMQ3JxS1U0?=
 =?utf-8?B?R204WGlTVDNzUnExREVBQWRQRVBDV3RuTHFkL1VLUVdXODFBU2w2NDBUa0FN?=
 =?utf-8?B?Ri82QVExSVJaekZPeXEzc3BZelhyR1BRWlUwcE0yVXRkZ1h1OWswTWUxTEl3?=
 =?utf-8?B?UmkyVjB3SXAvL3BtWENmekUxQ3dFcEkwbWVTVWZXMFdDODltbnVjWE4xSHJh?=
 =?utf-8?B?TC9kcDN2bFpOTHVyTTAvVGlXVFgreHhRU3R5OEVkOXd0alZITzhjbGZxbzl6?=
 =?utf-8?B?VGRTbzBReTdTUU5yUDBKR20rS3dFTS82UWNBelZ6bmVHaWlTNm9qZkpTR2lO?=
 =?utf-8?B?MUdoWlpkRlpNOWVvTCtRNFRxeWtIOWE1R3BmTXVyV2JPbFExVFViWjllVVVz?=
 =?utf-8?B?UnlBUUVucHJBTDhQWWlPZytVeVo5c2gxRXdiZVVzWnR3Y3ZSYTNYTDdkNmVv?=
 =?utf-8?B?cTNleUFxc1F6eDI1Vnlvb1FYRS96bU9PZzF3czZiR2ttS0VWS2Jya2dKTGRS?=
 =?utf-8?B?VTNteTJ5c0ptTE1kdU1mMkRLTnJ4Q1ZXN1NYOVhGOU1KS3ZFSWI0ajRjdWRG?=
 =?utf-8?B?UXM0dENKQXBvT1dXT2JMQUtFQ2p5SDdVQmJFR3FXanZ3NjZYMzA2bWVUZEFl?=
 =?utf-8?B?enltVXJyM212V0ZSbmVUMUtRZ25ibEY3Q050Qkk2RHRlQ2FDWHdiMk52RC9L?=
 =?utf-8?Q?gEcA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDE36206905D0B40B13DD61461FEAD89@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ANWDFeGof+o+/Ptecw2Yjo2Ina9xfFjfId1KZ1lv7RaAUo0Wd1Pec0HULS5u4iAflaxIlc4x8awcrTMcct+IWoX+X1H3nLNbSWAt9I90UpKTU7jC8iFg6VcvkeGrfzH3fHgrKaaiWwZyeu/qT6/w21Vdq+Mp3PGDB3OLIjW2kHSYehRHomteBAgdkWNzAmIj6sR6Axd1ToW8piH0O2NH3Kkhhm2tr6dIAeQ+nC8QdWmRv3GNEwVe33Es2wiZ4ABVOvqf6rnSeuj9u/1RFSxtC089ELba7MZlIVMRFBXQNn6JsynLlzA7rOlhXCLEgt/cFUpwnvfXxvH7E2gjYpHw/PUE4sumseqDgHA2YH49R0n/xgzJOwXtrMP7xLETFxouh7uXkaPLFinmoYpsDhhx2Xv23yIXygttHaGgVCpT8q9NGQHizUWZvjoQRzCrx1WgyZ0bPR2UzJ18ZazWN0i8/MdRBtWHL5m2BqsK54t0RzpNh07eFXfkQbPQMaceiPha+GZMXSlxxNS/6WEjZFOdocsXorDTxXBhmCNxDpbNU7/JiNkUkSMNuG36KznzF83a9mT5OsYCegWM/SM36w08QAn+vQOfbjOuwxgKwCHwy89sFU9ogly9YmqA73q81UBzM5I4jkbUvz1e23WRu4SF4aths66ytVpkWxxTF00SLfXZLz3CeU0R9JbcW1ZRdKhk4ybrFb9Lr3i35ilxCHh+Hr7ZJUjX0IoMNGnLYpEc594BRJbBotbwxtJQSyUGribDe8xGh9DlHYpWja1Rn/yBzMEpKgDYhfrAb0f5166MQlAm2jW3EAo1ajpocuPEl65hXq4oQvR3IzURXXQ2RfWfC5FWdQIhZHREeoKGpC3Tfu8=
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR15MB5218.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97165294-2e9f-4a78-a4b7-08db03756ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 10:25:04.0245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZjtnhj3TDnU5jS9+p1WOIW9+5vNkl3Xi8uJ6WSk1ShuNiFwc/RU0u/Pu9lTBzYFCdlTnwrGEESU388XSMLLdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3834
X-Proofpoint-GUID: FTmL3x7faCEURFSaNwreg6-ElQScHLhR
X-Proofpoint-ORIG-GUID: FTmL3x7faCEURFSaNwreg6-ElQScHLhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_04,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDEvMjAyMyAxODozNywgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ICpFeHRlcm5hbCBNZXNz
YWdlKiAtIFVzZSBjYXV0aW9uIGJlZm9yZSBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+
IA0KPiBPbiBNb24sIEphbiAzMCwgMjAyMyBhdCAwMToyMDo1NVBNICswMDAwLCBMZW9uYXJkLCBO
aWFsbCB3cm90ZToNCj4+IE9uIDI5LzAxLzIwMjMgMTU6NTksIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+Pj4gKkV4dGVybmFsIE1lc3NhZ2UqIC0gVXNlIGNhdXRpb24gYmVmb3JlIG9wZW5p
bmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4+Pg0KPj4+IE9uIDI3LzAxLzIwMjMgMTI6MzksIExl
b25hcmQsIE5pYWxsIHdyb3RlOg0KPj4+Pg0KPj4+Pg0KPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+Pj4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3ps
b3dza2lAbGluYXJvLm9yZz4NCj4+Pj4+IFNlbnQ6IDI2IEphbnVhcnkgMjAyMyAxMjoyOQ0KPj4+
Pj4gVG86IExlb25hcmQsIE5pYWxsIDxOaWFsbC5MZW9uYXJkQG5jci5jb20+OyBMaW51cyBXYWxs
ZWlqDQo+Pj4+PiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPjsgQmFydG9zeiBHb2xhc3pld3Nr
aSA8YnJnbEBiZ2Rldi5wbD47IFJvYg0KPj4+Pj4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
PjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPj4+Pj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGlu
YXJvLm9yZz4NCj4+Pj4+IENjOiBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPj4+Pj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0K
Pj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGdwaW86IGR0LWJpbmRpbmdzOiBhZGQgbmV3
IHByb3BlcnR5IHRvIHdkLG1ibC1ncGlvDQo+Pj4+PiBiaW5kaW5ncw0KPj4+Pj4NCj4+Pj4+ICpF
eHRlcm5hbCBNZXNzYWdlKiAtIFVzZSBjYXV0aW9uIGJlZm9yZSBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzDQo+Pj4+Pg0KPj4+Pj4gT24gMjYvMDEvMjAyMyAxMToxNywgTmlhbGwgTGVvbmFy
ZCB2aWEgQjQgU3VibWlzc2lvbiBFbmRwb2ludCB3cm90ZToNCj4+Pj4+PiBGcm9tOiBOaWFsbCBM
ZW9uYXJkIDxubDI1MDA2MEBuY3IuY29tPg0KPj4+Pj4NCj4+Pj4+IFN1YmplY3Q6IG1pc3Npbmcg
IndkLG1ibC1ncGlvOiIgcHJlZml4Lg0KPj4+Pj4NCj4+Pj4+IFN1YmplY3Q6IGRyb3Agc2Vjb25k
L2xhc3QsIHJlZHVuZGFudCAiYmluZGluZ3MiLiBUaGUgImR0LWJpbmRpbmdzIg0KPj4+Pj4gcHJl
Zml4IGlzIGFscmVhZHkgc3RhdGluZyB0aGF0IHRoZXNlIGFyZSBiaW5kaW5ncy4NCj4+Pj4+DQo+
Pj4+Pj4NCj4+Pj4+PiBBZGRlZCBvcHRpb25hbCAibm8taW5wdXQiIHByb3BlcnR5DQo+Pj4+Pg0K
Pj4+Pj4gTWlzc2luZyBmdWxsIHN0b3AuDQo+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogTmlhbGwgTGVvbmFyZCA8bmwyNTAwNjBAbmNyLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+
PiAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bpby93ZCxtYmwtZ3Bpby50
eHQgfCAxICsNCj4+Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+Pj4+
Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
Z3Bpby93ZCxtYmwtZ3Bpby50eHQNCj4+Pj4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9ncGlvL3dkLG1ibC1ncGlvLnR4dA0KPj4+Pj4+IGluZGV4IDAzOGMzYTZhMWY0ZC4u
OTQwNWY5ZGFkNTIyIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9ncGlvL3dkLG1ibC1ncGlvLnR4dA0KPj4+Pj4+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncGlvL3dkLG1ibC1ncGlvLnR4dA0KPj4+Pj4+IEBAIC0x
OCw2ICsxOCw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+Pj4+Pj4NCj4+Pj4+PiAgICBPcHRp
b25hbCBwcm9wZXJ0aWVzOg0KPj4+Pj4+ICAgIAktIG5vLW91dHB1dDogR1BJT3MgYXJlIHJlYWQt
b25seS4NCj4+Pj4+PiArCS0gbm8taW5wdXQ6IEdQSU9zIGFyZSB3cml0ZS1vbmx5LiBSZWFkIGlz
IHZpYSBhIHNoYWRvdyByZWdpc3Rlci4NCj4+Pj4+DQo+Pj4+PiBXaHkgdGhpcyBwcm9wZXJ0eSBp
cyBuZWVkZWQ/IFdoeSBkcml2ZXIgY2Fubm90IGFsd2F5cyB1c2Ugc2hhZG93DQo+Pj4+PiByZWdp
c3Rlcj8NCj4+Pj4+DQo+Pj4+IFRoZSBzaGFkb3cgcmVnaXN0ZXIgaXMgY3VycmVudGx5IG9ubHkg
dXNlZCBkdXJpbmcgdGhlIHdyaXRlIG9wZXJhdGlvbi4gSXQgaXMgbm90IGF2YWlsYWJsZSBkdXJp
bmcgdGhlIHJlYWQgb3BlcmF0aW9uLg0KPj4+DQo+Pj4gWW91IGp1c3Qgd3JvdGUgYWJvdmUgdGhh
dCByZWFkaW5nIGlzIHZpYSBzaGFkb3cgcmVnaXN0ZXIsIHNvIGhvdyBjYW4gaXQNCj4+PiBub3Qg
YmUgYXZhaWxhYmxlIGZvciByZWFkcz8gQWdhaW4sIHdoeSB5b3UgY2Fubm90IGFsd2F5cyByZWFk
IHZpYSBzaGFkb3cNCj4+PiByZWdpc3RlciBhbmQgbmVlZCB0byBtYWtlIGEgcHJvcGVydHk/IFlv
dSBtZWFuIHRoYXQgZm9yIG90aGVyIEdQSU9zDQo+Pj4gdGhlcmUgaXMgbm8gc2hhZG93IHJlZ2lz
dGVyIGF0IGFsbD8NCj4+Pg0KPj4gVGhlIGV4aXN0aW5nIHJlYWQgbWV0aG9kIGRvZXMgbm90IHVz
ZSB0aGUgc2hhZG93IHJlZ2lzdGVyLg0KPj4NCj4+IHN0YXRpYyBpbnQgYmdwaW9fZ2V0KHN0cnVj
dCBncGlvX2NoaXAgKmdjLCB1bnNpZ25lZCBpbnQgZ3BpbykNCj4+IHsNCj4+IAlyZXR1cm4gISEo
Z2MtPnJlYWRfcmVnKGdjLT5yZWdfZGF0KSAmIGJncGlvX2xpbmUybWFzayhnYywgZ3BpbykpOw0K
Pj4gfQ0KPj4NCj4+PiBXaGF0IGNoYW5nZXMgYmV0d2VlbiBvbmUgYm9hcmQgYW5kIGFub3RoZXIg
dGhhdCBqdXN0aWZpZXMgdGhpcyBwcm9wZXJ0eT8NCj4+DQo+PiBJIGhhdmUgYSBjb3VwbGUgb2Yg
Ym9hcmRzIHdoZXJlIHRoZSBlbGVjdHJvbmljcyBlbmdpbmVlciBkZWNpZGVkIHRvIG9ubHkNCj4+
IHVzZSB0aGUgY2hpcCBzZWxlY3QgbGluZSwgc28gbm8gcmVhZC93cml0ZSBzaWduYWwgaXMgY29u
bmVjdGVkLiBUaGlzDQo+PiBtZWFucyB0aGF0IHJlYWRpbmcgdGhlIGFkZHJlc3MgYWN0aXZhdGVz
IHRoZSBjaGlwIHNlbGVjdCBhbmQgZHJpdmVzIHRoZQ0KPj4gY29udGVudHMgb2YgdGhlIGRhdGEg
YnVzIHRvIHRoZSBwb3J0Lg0KPiANCj4gVGhpcyBwYXJ0IG1ha2VzIHNlbnNlIGFzIHlvdSBleHBs
YWluZWQgdGhlIGgvdy4NCj4gDQo+PiBGb3IgZXhhbXBsZSBpcyBzb21lb25lIHJlYWRzIHRoZQ0K
Pj4gZmlsZSAvc3lzL2tlcm5lbC9kZWJ1Zy9ncGlvIHRoaXMgY29ycnVwdHMgdGhlIHBvcnQuIFNv
IEkgaGF2ZSBoYWQgdG8gYWRkDQo+PiB0aGlzIHByb3BlcnR5IHRvIGF2b2lkIHRoYXQgc2l0dWF0
aW9uLg0KPiANCj4gTm90IHF1aXRlIHJlbGV2YW50IHRvIHRoZSBEVCBiaW5kaW5nIGJlaW5nIGEg
TGludXggZGV0YWlsLg0KPiANCj4+DQo+PiBJZiB5b3UgYXJlIHN0cm9uZ2x5IGFnYWluc3QgdGhp
cyB0aGVuIGp1c3QgcmVqZWN0IGl0IGFuZCBJIHdpbGwgbG9vaw0KPj4gYWZ0ZXIgaXQgbXlzZWxm
LiBJIHRob3VnaHQgdGhlcmUgbWF5IGJlIG90aGVycyB3aG8gd291bGQgZmluZCB0aGlzDQo+PiBj
aGFuZ2UgdXNlZnVsLg0KPiANCj4gQSBwcm9wZXJ0eSBmb3IgYSBib2FyZCBsZXZlbCBxdWlyayBp
cyBhcHByb3ByaWF0ZS4gWW91IGp1c3QgbmVlZCB0bw0KPiBleHBsYWluIHRoYXQgaW4gdGhlIGNv
bW1pdCBtZXNzYWdlIHJhdGhlciB0aGFuIHN0YXRpbmcgd2hhdCB0aGUgZGlmZg0KPiBhbHJlYWR5
IHRlbGxzIHVzLg0KPiANCj4gUm9iDQpUaGFua3MgZm9yIHJldmlld2luZy4NCkkgd2lsbCB1cGRh
dGUgdGhlIGRlc2NyaXB0aW9uIGluIHRoZSBwYXRjaCBpbnRyb2R1Y3Rpb24gdG8gaW5kaWNhdGUg
dGhpcyANCmEgYm9hcmQgbGV2ZWwgcXVpcmsgYW5kIHRoZSByZWFzb25pbmcgYmVoaW5kIGl0Lg0K
DQpSZWdhcmRzLA0KTmlhbGwgTGVvbmFyZA0K
