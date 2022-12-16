Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1117364F3C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLPWMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPWMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:12:33 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5065C1EED3;
        Fri, 16 Dec 2022 14:12:32 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGKof0k031985;
        Fri, 16 Dec 2022 22:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=f7Pz8wySrCSFe456f1e5lGUin2M/wDCHYlbMLwIEtGw=;
 b=UQtQ7A/tRCKxjKB6pxVtWamwgoqj9UMcfQqjHjlys52q45VnZsocRGqofkkCuISdn4pf
 P4OP78FLQJ9a/LjR5EaZuixgE6nmMrmDm+U/D6rw/YZrc1ABNoswMHrgSpVqtY1pSccs
 PjVJiyH/YNuTGCCa5ULANs0JVLQX7a477SYgqIuF/uEZKrXY0K5lsCVwd1LBu6vQXIXS
 RACdGi6jsAV9iG2MV9RYnYRGDoQCJLkAvQFGev5ykwxGl0BRRStdGytolDzJFgkzYK1S
 GzJmXVnUKoKs0Ba7catptjV7s2AcBJwJEv7PNBExKi1hAxHcvqKZlrleG2pjBb0nJKB/ lw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3mgqmqvn2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 22:12:11 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 43D4380711A;
        Fri, 16 Dec 2022 22:12:09 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 16 Dec 2022 10:12:08 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 16 Dec 2022 10:12:08 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 16 Dec 2022 10:12:08 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 16 Dec 2022 10:12:07 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOAn3IgMNGLnE2xxF9U1vzAXzov9Awc5ksipagEiZQv0bknLU6nGTswTTlzQH7QTXgLifsQOsgP8DG6nD4Wsqu0hdtHFLqciIGMonfg6Ibv2MTauab+BGZFQOjb7VcD0DFT5W5jdYLzVj31EauNZxbCDaaDtmRURxyBn/gJJVZl83EHBkxXQWXhzd0qt4LHZEl0ZOgrci0LnfUqxE1jTHg9zv2jydhC4gsjMwS1o/3joFl3dtwYp5IfZBwq1hV6JU4heSnwNN8SuzSN2wM19BdYsHGugFJCWzzo1QM6iRkt71i4brRb/Ws7D0H0gSAI04idtttFekzw5GbPVupJMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7Pz8wySrCSFe456f1e5lGUin2M/wDCHYlbMLwIEtGw=;
 b=JOPcfC2qBryOotkKPeGaoJZGxfGFPqFKXSaNvUP+cHIACg0pf35GPuzOavocK8iKyrOyBaBci6FI4WRU2XRxbhEOTjRbiZyV9LkGx6rBr/nQGrmGnIVfBD/WCPHF6GePFBYKgQykSwhGnUnF0uFJg68qr0nL6iJL9rsRFl1EU8f17XvhMlNP0eb/qW4AOnpdt1wdzz5/LG9pkmuR+Ehm/S1xnnlR32r+3rRDnhdzxfMw7ELLKW2jvdUATpODHIRklUru88Mbo6ywpFoUay8dESxdqyLc2xn0962mffIPrRSlRxTMgfOcEhq7Y70nbzm+MRPOowBbpN56NFzLvTvdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1714.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 22:12:05 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 22:12:05 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Peter Lafreniere <peter@n8pjl.ca>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Topic: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Index: AQHY+XHqfLLvXNGxcESumjNg7U4Mn65BZh+AgA36OwCACrj5IIAHgoWAgAS5juCACuOV0A==
Date:   Fri, 16 Dec 2022 22:12:05 +0000
Message-ID: <MW5PR84MB1842A7B13F829CC3FF09A8A5ABE69@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-11-elliott@hpe.com> <Y3TF7/+DejcnN0eV@zx2c4.com>
 <Y4B/kjS0lgzdUJHG@gondor.apana.org.au>
 <MW5PR84MB1842C2D1EA00D5EF65784E25AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <FuRP6eq1TdvRdmbeIUM2jGr9qmB2CptLqZsWq_hVq3Bqur-pL9HX3xBLPC3iC1F6F4FT1Moi9GhPssy8MGEKO7LUKH6sA34TbV0S8K3Gn8Q=@n8pjl.ca>
 <MW5PR84MB18422AE2CA0732E3847E569BAB1F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB18422AE2CA0732E3847E569BAB1F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1714:EE_
x-ms-office365-filtering-correlation-id: 2424e5cd-b0cc-442d-7e91-08dadfb29113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A9lXfDHfwNJ+QEUIsUazoBGEi/nepBmr5e4eGEsa5/OEyjOzjpzZbjmQbehAR5omIWXuyc4iWaS70QHAdMtRs/yBdJuqLvs1qH6VY0wByNlssyVqalC9gCo1dm/6AGlFtfK3srqCSCT4/G7o0Mp2+BB9haTrDtg+DB6B6um6+Jbx/cudrYgzEbahbEmUEhK5hQ7P7iGVZDUoZJZ5Ak9K8N5A4Y5x/5pmTAG0yIxbMHxNFsd2rwtpYajUfQTiZiRINrOCHrps149s71tSnsFLK2u38o0NtQv833PWOdCYbjg6T+AKbrKb7qM7j6EgXd8HxctvKKickO/NfbfPtPX0f8kci84xY789s2JHNlMuVDhwT7IKkxq+lFppY7FcI3hBsvJFLXcQdEYiH0PaxgNg/E50QNGcRyTTXOM0o3ktU8NZVI2KvwRxOC1fJB0RflyUrNdjIJpUSY4Ke/Vm5iyLd8uStEJRZK/SRulaODfNRz0nnGH/dISK4tzJcK9vQna4xXblzOzJprSlsknzzUKmEYZEJtMXXHcUYEUHbTFhkwdUyiVXLpzMX/sJNMk81kYXpp9KPG8xDEOx11vVsKQSU6eoQD00il3rGhavTCf9wGhqP0K0+hUA7pHkuhAlQr7Gpa1Xk6zqWFe5oi9s/gnaOWr88WEKdzzASuE1gDlAB0xIwqydshZNlemy9HYToKg/ZdKT9pXGRRo3fKuA2A156A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(71200400001)(478600001)(186003)(6506007)(7696005)(38070700005)(9686003)(26005)(55016003)(5660300002)(2906002)(83380400001)(54906003)(33656002)(64756008)(76116006)(66446008)(7416002)(66946007)(66476007)(4326008)(8676002)(6916009)(316002)(66556008)(41300700001)(8936002)(86362001)(38100700002)(122000001)(82960400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEpYdGZZL3RuZ2dLMWRsWG94RWVjdDFqdXdWc0NnSUhwQk80Ritnbklma0s2?=
 =?utf-8?B?U1pZb3NDdm5oS3B0ajBCRHh6eU8vRUxxZGM1dGtIcHZEYnZRamMwelE0OEUz?=
 =?utf-8?B?NENwYU5vc0hUYlQyWjdFandCQkhMU29DQ0dvRVdFTHBnZmZkMlh3TTVwbmZl?=
 =?utf-8?B?YkJCeW1NdHVNRmF0ZGRxRUphNitBTFp2M2VrSHVvT1lNaFNydXVyUlBheFp5?=
 =?utf-8?B?dldIYVBWdG9INi9iZE1kSWVrRmhKOHd0YlhXWFB2Ti9IRUp0ekFlMUVITmZt?=
 =?utf-8?B?SGozRVVzQjcwTnVoUEhKdzZqYzQ4dG80bXdGaWsxc3pBT2Q2STNNd2ZUTy95?=
 =?utf-8?B?a1g4cjB3YnoxV0Zvckg4L3dIajAzaFJOcnJWOHcwRVhEdXRLVGJ6ckhXdmhR?=
 =?utf-8?B?OU1QRnpKU3Q3UW1ONHFIMTViOEZ1OW5pZzZUeWcwRW0wb0t0YmtQaUhzVEps?=
 =?utf-8?B?R2U2S0g2MVczcjNrSDlXTkNxTU5FMDc1Ry9Vd1I2US9aenFDa05SL2l2ZWdZ?=
 =?utf-8?B?bUtzQ3pCaXorclFqTk1kWjhxZ21FVm4zVzFPeW9mYm5KbFAraW5CT3M3V2FL?=
 =?utf-8?B?WHVERHJIM205QkkzcHR4U0QwSVg5ZlJ1aW9STllPUXFLdDVKRmhjSVJpTit1?=
 =?utf-8?B?YXlGSFQ1RklEZS9wcE9UMytURFRNQzJESW84S3NYTGgzQUVxMlRJeTJKOHBI?=
 =?utf-8?B?aCttL1NrRnVJUUk5VGRBYzVRTE1jUDNRLzB3S1ZHQVF2bmFFNE5UVFNzT3pa?=
 =?utf-8?B?YmtodVZIRnVXc0Q0TXREdE9pbndhUVVWckptMWoxdEtQbE9sSm4rT1dycEEx?=
 =?utf-8?B?U2F3bEpTQXc1VURCQ0Z4cHRLejZHL1ZuU3RhRm1uL1RnUzZGN29RL2lQVVFI?=
 =?utf-8?B?WlJRRGhCRTZDZnc3L0dETUxqeTVJN0NnRXFhcFJJMU5MRVNFOG9FaEV0RktL?=
 =?utf-8?B?eW9PaUViam4zR25ucWk2TDN2b0dlL0k0QktkVCtQalB2UWE5M3BFV3FXYmhT?=
 =?utf-8?B?OGNwL0hhSkJRQmdGWDFhYXdWaUhEM1J1L2pOYStFMnJwNGNoRWN3bnVSY2Mv?=
 =?utf-8?B?L1kxMjBFVTZWRFE4WDVmWnNwUDgrckF2c3V4ZTM2Q1J5QjN4NEZxSDI4QWJD?=
 =?utf-8?B?VWJ2dGxMeXJBOGlBaEVTRXEzQ3E0aDZaSXJZWldqMVJFcWdDeS9BbFFWY1Vk?=
 =?utf-8?B?SjlRVnFiTnYrZkZ4OTVtYU5pT0ZtSjM2SCtUL3c5VW9hNnd2aHdqYW5QaCtE?=
 =?utf-8?B?Q1ZkTkFQRnF2bWdwaVZBMG1oWXRJNC84UjVBVEpVcEdINzI1ZENYVS9CS1Iz?=
 =?utf-8?B?dkhFc2JpUE9UTitGUVgxb0JUUVpTd0lFbTdoajFCd1NoU2gvaFdHT0UzRVVT?=
 =?utf-8?B?NnB6VWNOby9ZVWtMZVcrb0h4Y051K290TlBUSkx4Z0NlcmYvemllZzFSZzI3?=
 =?utf-8?B?Vk9WR2VVNnJCK3Q3b2tLcmhZMTNGdW1lMVdCYUVKZUdJKzRkUHNGQTVhb0dt?=
 =?utf-8?B?SERDK2ZjcTBES3llblJXQk1HVm4rNk5uVWg1WEJ3TWJxVEs5cXpucWZCOTRF?=
 =?utf-8?B?Z0pzblNKQWtvWHYvZC9LVE94U1hEZnlaaGhNWlg3VDdrYzBSMllKTDk1WVFM?=
 =?utf-8?B?ZWVpZklUZloyUktpNmZodmRFTDdncDR4cmJ3ZkJIWjU4U3ErYVZ4TzczTHhr?=
 =?utf-8?B?QXAwanZMZEFNQUNNTm4wVGFZOHBEVkI1bU9tYWd5SjR4emtreWlJenVIN3V2?=
 =?utf-8?B?b0ZoL0Rrdk01cFlNeXhVYmJ5NWpNZ3JEelQ0WkZZV1BoQW9ySThnb1UrYUZO?=
 =?utf-8?B?bmRlNktXQWtnRmtEemd0TEw1OGlKQWRQVU9JRS8yL0x5andxelJqTjZ0NG1a?=
 =?utf-8?B?UTc4WWlHV1Z1RUpBN2F3MXdOMTVjZDF0ZHJySmFCRXhkT3Y3aG1kTWlKNTBy?=
 =?utf-8?B?TFIzNXFRYWxlR2tIQThFUnpoMHJocDZuejlKWXdFRkR1bFEvc3lzTUM2aURv?=
 =?utf-8?B?dDVsTlN1c01va3hTMlZ6VGNjWFlURjRUZ0VnUjBzQ1g3bitOWTA4R2MxdGI2?=
 =?utf-8?B?WXQ3VFJFK1BBWVExMlIyVXhDeEpPcmNJWWFlN0hnMjdBeXJ6Y2huVUE3emxM?=
 =?utf-8?Q?v/34=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2424e5cd-b0cc-442d-7e91-08dadfb29113
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 22:12:05.6868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vClwY8NzhhEjr0asLWshxM/f3rszF9mxCkph0mrImtGfeIbM8lncwFpqh5sjMdKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1714
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: J8yxiCaCa89zJPbW_1IkskT52Xbdyv8V
X-Proofpoint-GUID: J8yxiCaCa89zJPbW_1IkskT52Xbdyv8V
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=733
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160198
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEknbGwga2VlcCBleHBlcmltZW50aW5nIHdpdGggYWxsIHRoZSBwcmVlbXB0IG1vZGVzLCBo
ZWF2aWVyDQo+IHdvcmtsb2FkcywgYW5kIHNob3J0ZXIgUkNVIHRpbWVvdXRzIHRvIGNvbmZpcm0g
dGhpcyBzb2x1dGlvbg0KPiBpcyByb2J1c3QuIEl0IG1pZ2h0IGV2ZW4gYmUgYXBwcm9wcmlhdGUg
Zm9yIHRoZSBnZW5lcmljDQo+IGRyaXZlcnMsIGlmIHRoZXkgc3VmZmVyIGZyb20gdGhlIHByb2Js
ZW1zIHRoYXQgc200IHNob3dzIGhlcmUuDQoNCkkgaGF2ZSBhIHNldCBvZiBwYXRjaGVzIHRoYXQn
cyBsb29raW5nIHByb21pc2luZy4gSXQncyBubyBsb25nZXINCmdlbmVyYXRpbmcgUkNVIHN0YWxs
IHdhcm5pbmdzIG9yIHNvZnQgbG9ja3VwcyB3aXRoIGVpdGhlciB4ODYNCmRyaXZlcnMgb3IgZ2Vu
ZXJpYyBkcml2ZXJzIChzbTQgaXMgcGFydGljdWxhcmx5IHRheGluZykuDQoNClRlc3QgY2FzZTog
DQoqIGFkZGVkIDI4IGNsb25lcyBvZiB0aGUgdGNyeXB0IG1vZHVsZSBzbyBtb2Rwcm9iZSBjYW4g
cnVuIGl0DQogIG1hbnkgdGltZXMgaW4gcGFyYWxsZWwgKDEgdGhyZWFkIHBlciBDUFUgY29yZSkN
CiogYWRkZWQgMSBNaUIgYmlnIGJ1ZmZlciBmdW5jdGlvbmFsIHRlc3RzIChjb21wYXJlIHRvDQog
IGdlbmVyaWMgcmVzdWx0cykNCiogYWRkZWQgMSBNaUIgYmlnIGJ1ZmZlciBzcGVlZCB0ZXN0cw0K
KiAzIHdpbmRvd3MgcnVubmluZw0KICAqIDI4IHRocmVhZHMgcnVubmluZw0KICAgICogbW9kcHJv
YmUgd2l0aCBlYWNoIGRlZmluZWQgdGVzdCBtb2RlIGluIG9yZGVyIDEsIDIsIDMsIGV0Yy4NCiog
UkNVIHN0YWxsIHRpbWVvdXRzIHNldCB0byBzaG9ydGVzdCBzdXBwb3J0ZWQgdmFsdWVzDQoqIHJ1
biBpbiBwcmVlbXB0PW5vbmUsIHByZWVtcHQ9dm9sdW50YXJ5LCBwcmVlbXB0PWZ1bGwgbW9kZXMN
Cg0KUGF0Y2hlcyBpbmNsdWRlOg0KKiBBcmQncyBrbWFwX2xvY2FsKCkgcGF0Y2gNCiogU3VwcHJl
c3MgUkNVIHN0YWxsIHdhcm5pbmdzIGR1cmluZyBzcGVlZCB0ZXN0cy4gQ2hhbmdlIHRoZQ0KICBy
Y3Vfc3lzcnFfc3RhcnQoKS9lbmQoKSBmdW5jdGlvbnMgdG8gYmUgZ2VuZXJhbCBwdXJwb3NlIGFu
ZA0KICBjYWxsIHRoZW0gZnJvbSB0Y3J5cHQgdGVzdCBmdW5jdGlvbnMgdGhhdCBtZWFzdXJlIHRp
bWUgb2YNCiAgYSBjcnlwdG8gb3BlcmF0aW9uDQoqIGFkZCBjcnlwdG9feWllbGQoKSB1bmlsYXRl
cmFsbHkgaW4gc2tjaXBoZXJfd2Fsa19kb25lIHNvDQogIGl0IGlzIHJ1biBldmVuIGlmIGRhdGEg
aXMgYWxpZ25lZA0KKiBhZGQgY3J5cHRvX3lpZWxkKCkgaW4gYWVhZF9lbmNyeXB0L2RlY3J5cHQg
c28gdGhleSBhbHdheXMNCiAgY2FsbCBpdCBsaWtlIHNrY2lwaGVyDQoqIGFkZCBjcnlwdG9feWll
bGQoKSBhdCB0aGUgZW5kIGVhY2ggaGFzaCB1cGRhdGUoKSwgZGlnZXN0KCksDQogIGFuZCBmaW51
cCgpIGZ1bmN0aW9uIHNvIHRoZXkgYWx3YXlzIGNhbGwgaXQgbGlrZSBza2NpcGhlciANCiogYWRk
IGtlcm5lbF9mcHVfeWllbGQoKSBjYWxscyBldmVyeSA0IEtpQiBpbnNpZGUgeDg2DQogIGtlcm5l
bF9mcHVfYmVnaW4oKS9lbmQoKSBibG9ja3MsIHNvIHRoZSB4ODYgZnVuY3Rpb25zIGFsd2F5cw0K
ICB5aWVsZCB0byB0aGUgc2NoZWR1bGVyIGV2ZW4gd2hlbiB0aGV5J3JlIGJ5cGFzc2luZyB0aG9z
ZQ0KICBoZWxwZXIgZnVuY3Rpb25zICh0aGF0IG5vdyBjYWxsIGNyeXB0b195aWVsZCgpIG1vcmUN
CiAgY29uc2lzdGVudGx5KQ0KDQpJJ2xsIGtlZXAgdHJ5aW5nIHRvIGJyZWFrIGl0IG92ZXIgdGhl
IHdlZWtlbmQuIElmIGl0IGhvbGRzDQp1cCBJJ2xsIHBvc3QgdGhlIHBhdGNoZXMgbmV4dCB3ZWVr
Lg0KDQoNCg==
