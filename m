Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0055624D71
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKJWGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKJWGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:06:47 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5CF2A94F;
        Thu, 10 Nov 2022 14:06:46 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAJ05T9025094;
        Thu, 10 Nov 2022 22:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=oLKJcxlNwfsWXrhnzyZXm1kl1NsYYuem9Kd0tBOrd5A=;
 b=hNJOL8m7sNPPQShQBpjjQpqNgYA7FL/NFKNbmsthxU41lFdJ9C+ht8966+kLrce+tKmA
 N5/WSfnDMpoJnBHFjNFpFnLs3yuepAdCLxIN3vT75wLOkBRgmpuE9SDxUY1jOOTeGKcw
 gI/GFjgX73wx2Ze3dRiK0i6rTwCkhMHXy6W3zsp1QBfTgJRFiNYy3/AD0zlwKWiDPhie
 RbkfbP/jpNqXvpRQIT8AY5QN7gSkJS98kvtKNyKR2kMgIFBZNxJDM+OkoZBDr5PxZMX7
 nBBbz2qHA14AIGykwCnDVbeJYBgWvWEDcZmrqu2i7krrEvZv+QT9Gpf24VM/4QJi4EVF 1w== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3ks72k1bjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 22:06:30 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8D464806B77;
        Thu, 10 Nov 2022 22:06:29 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 10 Nov 2022 10:06:29 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 10 Nov 2022 10:06:28 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 10 Nov 2022 10:06:28 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 10 Nov 2022 10:06:28 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqJyDs5n8yaxr+GfNGG4/oBrhKBG7D1MMh0kS9wiFD/1RE4tD7drogM22n4WdI9QvOyESpcVZ9Jhp8oOHk8htSQAt38px83XQEUFwku9qII44LBGa4tJEDsIKyBzGsMIE6thMz7X5cO7Q7gkaLJIIb9nBqz1rwU+c2Ht8ZjCgdocKke7A0XgiamDfD2hUxgoTui3HFKI2OCZU9FMSOKk2jgUffHDC1+GnA89WPeWFkfTZvW58rIXbcwF4Jn7zX/4SUnon0Zw3rK6DHcPcC1e7hRVCe30Ab2vqp+RhJ9FhBMzmKX2r3MSzGYOIEMFti1CG1OnvLL2mWJbLZ3rQSoiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLKJcxlNwfsWXrhnzyZXm1kl1NsYYuem9Kd0tBOrd5A=;
 b=btKGln4n0XY7sjDr6zgGkEN2yEdjTsciwwH05Wgfy4nRR2Ha/djxYnkexjTnr84I4JTIlRpEGtDkMqwHonD2Oy3PJSEHSuy7wpach8ehHwLh6jR5zxEEtdcxlU6OniOBjMwnbiQq9XvAZO3MDwb79HrERtyvEHuNZvDg3oOLcbWDjocTRgRYl0u0tlMswX95nzaAd9J+4ayrtIBheHs6hCdTO9BF7vM7lj2prEwXZHBYStHxtBCc0z0Kl7k6a3OMlFLSaMZWTtwiUcHdSRFCC7C34b2GC6snzTNI5HVCahcKU2jvqnHtpThK93UBWzmgRsQrwUrG1u1jzJY7pcdYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1763.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 22:06:25 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22%7]) with mapi id 15.20.5791.026; Thu, 10 Nov 2022
 22:06:25 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 18/19] crypto: x86 - standardize not loaded prints
Thread-Topic: [PATCH v2 18/19] crypto: x86 - standardize not loaded prints
Thread-Index: AQHY3oYbFARu/v/glky9dQBH5rlEfK4LfFEAgAFidKCAK/7xIA==
Date:   Thu, 10 Nov 2022 22:06:25 +0000
Message-ID: <MW5PR84MB18428853F001C480C989761BAB019@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-19-elliott@hpe.com> <Y0de+gl0irG+eNpT@zx2c4.com>
 <MW5PR84MB184287FFFD5AD3D897659396AB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB184287FFFD5AD3D897659396AB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1763:EE_
x-ms-office365-filtering-correlation-id: 570b41f1-2b28-45ab-f318-08dac367cf31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mytqGSHdYA46roW6tgmcobvOKhK+yVh1/9ZYy5LN2uOx2Fz2HCqzq7tcka8ZxlL2RSfLNaUPSgbVNUfA195P62ksxnr9fP+ncl8330gh/HcQh4SeCezVkWpK42OgfRwDYsbFSAS5KUE7M53pYtXgM1FY4UFmH6yJRnv5Ps9lfbg1QrJirVt062Gxo0vWMD4y+rUcu+TWrPXivg/euh6e/vbQinAlLdNXQjRdcVPuOK5uQN5g+7S0ny5jnzfV66otgA5n9xgTKiXOc3Bru33Eg1AslpdJtqjRpYaXiUoGjvA6plkeX1ONB4pq8ZtL2fqCBSY7tVtPbLpmSvBOfWJGvSe+hVIf0uXTPlFhXBkeC736yqs4qoslKVDvNvVFxCrS2J3yNCPBTbX4XtN+JgTRiSQK+dq5DPZGyRdF7EejYcyO1EZVV/ROfkb6Bzhr8J/Y3KqRFEPU8cm5V9b301bf3bn8eRhtwzj/ZpMGCUWAVPqHzLQZ5rwch2Q9mXwCMboXbA3jiETBq4Vo8oPMK8bM87DOnd+5ddcOIysqt5osHaPEkoRgNoqOSNp4E93/OiMSC3ZDl7RIuEZbb4gDZEUJADpuUGrFVM7reormu/5UpmfzKKs+KxaJlWMG7VIY54XXMoZvcSjhiH6BMXfj555CAy3VfbRaHmmtYoEEjo7EhV+HH6ojUmGWX0fwUS1aGf5Om1qrEXNinI5VIX/zHdusDeqvw4fvZJ8X1ReShMtG4OLYxiqv0+aR5pSE/tgTgfE7kHsXrrBPc+kCwvdFOKJOEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(54906003)(110136005)(33656002)(64756008)(66446008)(66946007)(66476007)(66556008)(76116006)(5660300002)(82960400001)(52536014)(8676002)(4326008)(38070700005)(38100700002)(316002)(41300700001)(83380400001)(478600001)(186003)(122000001)(86362001)(6506007)(55016003)(26005)(71200400001)(9686003)(7696005)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2QzamJVNkt5akJZV1FsWS9QWmNnbFdpSUN0NUhxeEs5Ym9iTG9GRmxQME5v?=
 =?utf-8?B?aWM3Y3lEdFNML3VQdzRzMUxUNlBUOEM4dXpXODNUTGRBdzJ3Qld2bGFzS2Vo?=
 =?utf-8?B?V3doRS8xWW5PbmlPZndYWG1vMFN3dGxETEttTFg1OWhIc1lkR2FKUjhJcnZa?=
 =?utf-8?B?cUxSMzdMSk1pNy84aUtOTkxiNm9ybG5LT2FMZGFwM2dKY0JCRXNvUVhuS090?=
 =?utf-8?B?enNteUduOG8rcGRlNVVyZFNUajdrU3h3ZlRZRURCNXNNc05paC9kUE5pMm5n?=
 =?utf-8?B?YVlIU3RaanlUVWh4SmU3OW1veS9HbnMxMHdDc0tUSEFQSWg3M0xhanhJcU5V?=
 =?utf-8?B?cmpGZFBIcHU0SzY2Y1pBcjR0U3ZOSWY2a2JCenhvWHVSeXo3V2pDMEpFWDdO?=
 =?utf-8?B?dDJDRU1OSkZsMDZpRVBLU0phZXgvWlJsMkFTQVVTcjBzNjRhNTdwN25lWWNk?=
 =?utf-8?B?bUVweStXVWU4MHhwdmY3Sngvb3BXVWk0UFVBL3ZTbUk0ZWtGeVgwL3hyWk1j?=
 =?utf-8?B?L3lRY0ZJUDMvbWY1SXB3TDZtdW5WT0xCMk5CTTBpUkhYT0NFeXp2Uk91R2V5?=
 =?utf-8?B?RW0zcTFkMjVJSTkyd3Z6WGNaRU5BZjVZanluU2FjZFVoSE10REZoRFBZS2Mr?=
 =?utf-8?B?akFHM3RHcHh2NnVSR2Uzb01iWFVRY2xldU1zTVJzQ0lzbFRJZmhYSmRGRUI1?=
 =?utf-8?B?Y0FpNE02a01iY1ZMVCtudUdqb0xSNFllU1RxbWRjRXViWGpEM0V2SlA2dGR3?=
 =?utf-8?B?b052a3JMY2hpL0lVTFlpV1hrNEVFUVV6M3VQOVlBRFJRbys0U21WV2tmZ2dz?=
 =?utf-8?B?WU1oWmdlYitXbThnak5MRDEvQzlRWS9uOEw5VzQvMFN3c3pvWEhFZEZJUHZK?=
 =?utf-8?B?VHk4Q1pBcU1jZFoya1VSRjE5M0w3SkhXSkJweFZzSUY1S1BvOHZ3N1UyU1U4?=
 =?utf-8?B?bzJBSUNBWWt1ejNwdGFVUHJ0ekV6dk4zK3czZzI0ak9jbzZ1LzZpZDUwQkFp?=
 =?utf-8?B?SFdiSFhLU05lYlc2OW1yT1RtRlk4c1FKK3czZkJveUNJUmpnL1hPMHRBdUE5?=
 =?utf-8?B?ZkJFekE2QnNLOHovUzRNdHBJN3E4anBRZlF1QW5GOWFDVTl3WkxxZ2lKWU5p?=
 =?utf-8?B?V0RHQ0FLNGZlbTF0ZWFCRUFRR20xb3kyU0FSMXlhV0RjMDlSVHZJb3JMd29n?=
 =?utf-8?B?ZU9PalFXL2VtQ041TkJMRG5mUVY1L1JxaVJtbExkQWdNbCtPTDhBVVNkSlgz?=
 =?utf-8?B?UVRpcTdmZDJXWmIzckFCNnZHZzlFTDFDL0Nuc2hZOUdVN3dsYmRyWkFycEpi?=
 =?utf-8?B?MVBwOVV6cjNnSjVyQlZNNk9aaFlGcUpRVGRhNlJocVdHUlkvYzEwMEFlMVls?=
 =?utf-8?B?VHp5Z1F4TkhPbTFHbUZJS3UraHFiSWFkQmNhMmtkeGV0VTVKQ0piZ2pjckFP?=
 =?utf-8?B?RkFiN2JkdEhaMG9ZUWdzOVlHbUdHYm8yaEJSNkp1cEx2enZUWUQ4akJOclRD?=
 =?utf-8?B?ZFVpaHo1U3k5dTVhLzRKcjhuWEFWbWNQa2EwVHBxSStLMGo4NHQ1OEUxV3NV?=
 =?utf-8?B?d0JsYjd3U2lPS2hNeVlkR1ZhbmZ4VE90SDJIaFUwTzJtN1g4Qzk1QTdVZHhs?=
 =?utf-8?B?cE93MVJVMkVRSndZWGs2RlVWWGFYVWN0K1F1Q25Mdng4YTlhaXZaRjJsNGVO?=
 =?utf-8?B?SUlGd2J0VW5kZ0h1eFFsb0QyNzg5N05DS2ZLKzZneDV6WnpSWTZEakVOS2Vr?=
 =?utf-8?B?TUQxOG5BTDhaR3U1SG9oN3JFMk56OW5zc0dWbndsVVJMVWdUeTBqbWw1MTY3?=
 =?utf-8?B?dlp6WTErdXh1VGUzMVFkMkFrU0RsbDB3cWNTSUVhSEQvdzhENFF4UXNFUXlS?=
 =?utf-8?B?anJ5b3lFc0xNUUcwbnNWSXZxV3RIVVBjNVl2YnJKWENkMEhLR0I1MGlJcEVp?=
 =?utf-8?B?TFJZUHg0eTAzVTBJdFlobFhOYWdnS0ZPSWlOeW9BeXJFKzhrdktpTUxQYnpP?=
 =?utf-8?B?QUJmMENFNnJ4Q3A3MDlIUVllc2Zoejl2SjdNd1Z4MEZkSXEvSWw3SmFsNlQz?=
 =?utf-8?B?SkZlU2tqNHc2M1UrQUlOTlBGV2pCTFlOS0MzMlpFVFRDWkJ2Vk41ay9QT1NZ?=
 =?utf-8?Q?Wpv0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 570b41f1-2b28-45ab-f318-08dac367cf31
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 22:06:25.1395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71EUaMwNiPLRUHGka81yZ+xIw/5wADHTVuo/O8b8xMy5nwsAu2y552n8H4GHoil7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1763
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: or-rdz6QwhcQd6Ibb-Xuh2gw9R3LLiVs
X-Proofpoint-ORIG-GUID: or-rdz6QwhcQd6Ibb-Xuh2gw9R3LLiVs
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100155
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFRoZSBwb3NpdGl2ZSBtZXNzYWdlcyBhYm91dCB3aGljaCBvcHRpb25hbCBmZWF0dXJlcyBh
cmUNCj4gZW5nYWdlZCBjb3VsZCBiZSByZXBvcnRlZCBhcyByZWFkLW9ubHkgbW9kdWxlIHBhcmFt
ZXRlcnMuDQoNCkkndmUgZXhwZXJpbWVudGVkIHdpdGggdGhpcyBhcHByb2FjaC4NCg0KVGhlcmUg
YXJlIHR3byBjb25zdHJ1Y3Rpb25zIGZvciB0aGUgbW9kdWxlczoNCjEuIG1vZHVsZXMgdGhhdCBl
bmFibGUgZGlmZmVyZW50IGJlaGF2aW9yIGluIHRoZSBkcml2ZXJzDQogIChlLmcuLCBhZXNuaV9p
bnRlbCBlbmFibGluZyBhdnggb3IgYXZ4MiB3aXRoaW4gZWFjaCBkcml2ZXIpDQoNCiAgSSBuYW1l
ZCB0aGVzZSBwYXJhbWV0ZXJzICJlbmdhZ2VkXzxmZWF0dXJlPiINCiANCjIuIG1vZHVsZXMgdGhh
dCByZWdpc3RlciBzZXBhcmF0ZSBkcml2ZXJzIGZvciBkaWZmZXJlbnQgYmVoYXZpb3INCiAgKGUu
Zy4sIHNoYTEgcmVnaXN0ZXJpbmcgc2VwYXJhdGUgZHJpdmVycyBmb3IgYXZ4MiwgYXZ4LCBhbmQg
c3NzZTMpDQoNCiAgSSBuYW1lZCB0aGVzZSBwYXJhbWV0ZXJzICJyZWdpc3RlcmVkXzxmZWF0dXJl
PiINCg0KSXQgbG9va3MgbGlrZSB0aGlzOg0KDQokIGdyZXAgLUhzIC4gL3N5cy9tb2R1bGUvKi9w
YXJhbWV0ZXJzL2VuZ2FnZWQqDQovc3lzL21vZHVsZS9hZXNuaV9pbnRlbC9wYXJhbWV0ZXJzL2Vu
Z2FnZWRfYXZ4OjENCi9zeXMvbW9kdWxlL2Flc25pX2ludGVsL3BhcmFtZXRlcnMvZW5nYWdlZF9h
dngyOjENCi9zeXMvbW9kdWxlL2FyaWFfYWVzbmlfYXZ4X3g4Nl82NC9wYXJhbWV0ZXJzL2VuZ2Fn
ZWRfZ2ZuaTowDQovc3lzL21vZHVsZS9jaGFjaGFfeDg2XzY0L3BhcmFtZXRlcnMvZW5nYWdlZF9h
dngyOjENCi9zeXMvbW9kdWxlL2NoYWNoYV94ODZfNjQvcGFyYW1ldGVycy9lbmdhZ2VkX2F2eDUx
MjoxDQovc3lzL21vZHVsZS9jcmMzMmNfaW50ZWwvcGFyYW1ldGVycy9lbmdhZ2VkX3BjbG11bHFk
cToxDQovc3lzL21vZHVsZS9jdXJ2ZTI1NTE5X3g4Nl82NC9wYXJhbWV0ZXJzL2VuZ2FnZWRfYWR4
OjENCi9zeXMvbW9kdWxlL2xpYmJsYWtlMnNfeDg2XzY0L3BhcmFtZXRlcnMvZW5nYWdlZF9hdng1
MTI6MQ0KL3N5cy9tb2R1bGUvbGliYmxha2Uyc194ODZfNjQvcGFyYW1ldGVycy9lbmdhZ2VkX3Nz
c2UzOjENCi9zeXMvbW9kdWxlL3BvbHkxMzA1X3g4Nl82NC9wYXJhbWV0ZXJzL2VuZ2FnZWRfYXZ4
OjENCi9zeXMvbW9kdWxlL3BvbHkxMzA1X3g4Nl82NC9wYXJhbWV0ZXJzL2VuZ2FnZWRfYXZ4Mjox
DQovc3lzL21vZHVsZS9wb2x5MTMwNV94ODZfNjQvcGFyYW1ldGVycy9lbmdhZ2VkX2F2eDUxMjow
DQoNCndpdGggbW9kaW5mbyBkZXNjcmlwdGlvbnMgbGlrZToNCnBhcm06ICAgICAgICAgICBlbmdh
Z2VkX2F2eDI6VXNpbmcgeDg2IGluc3RydWN0aW9uIHNldCBleHRlbnNpb25zOiBBVlgyIChmb3Ig
R0NNIG1vZGUpIChpbnQpDQpwYXJtOiAgICAgICAgICAgZW5nYWdlZF9hdng6VXNpbmcgeDg2IGlu
c3RydWN0aW9uIHNldCBleHRlbnNpb25zOiBBVlggKGZvciBDVFIgYW5kIEdDTSBtb2RlcykgKGlu
dCkNCg0KJCBncmVwIC1IcyAuIC9zeXMvbW9kdWxlLyovcGFyYW1ldGVycy9yZWdpc3RlcmVkKg0K
L3N5cy9tb2R1bGUvc2hhMV9zc3NlMy9wYXJhbWV0ZXJzL3JlZ2lzdGVyZWRfYXZ4OjENCi9zeXMv
bW9kdWxlL3NoYTFfc3NzZTMvcGFyYW1ldGVycy9yZWdpc3RlcmVkX2F2eDI6MQ0KL3N5cy9tb2R1
bGUvc2hhMV9zc3NlMy9wYXJhbWV0ZXJzL3JlZ2lzdGVyZWRfc2hhbmk6MA0KL3N5cy9tb2R1bGUv
c2hhMV9zc3NlMy9wYXJhbWV0ZXJzL3JlZ2lzdGVyZWRfc3NzZTM6MQ0KL3N5cy9tb2R1bGUvc2hh
MjU2X3Nzc2UzL3BhcmFtZXRlcnMvcmVnaXN0ZXJlZF9hdng6MQ0KL3N5cy9tb2R1bGUvc2hhMjU2
X3Nzc2UzL3BhcmFtZXRlcnMvcmVnaXN0ZXJlZF9hdngyOjENCi9zeXMvbW9kdWxlL3NoYTI1Nl9z
c3NlMy9wYXJhbWV0ZXJzL3JlZ2lzdGVyZWRfc2hhbmk6MA0KL3N5cy9tb2R1bGUvc2hhMjU2X3Nz
c2UzL3BhcmFtZXRlcnMvcmVnaXN0ZXJlZF9zc3NlMzoxDQovc3lzL21vZHVsZS9zaGE1MTJfc3Nz
ZTMvcGFyYW1ldGVycy9yZWdpc3RlcmVkX2F2eDoxDQovc3lzL21vZHVsZS9zaGE1MTJfc3NzZTMv
cGFyYW1ldGVycy9yZWdpc3RlcmVkX2F2eDI6MQ0KL3N5cy9tb2R1bGUvc2hhNTEyX3Nzc2UzL3Bh
cmFtZXRlcnMvcmVnaXN0ZXJlZF9zc3NlMzoxDQoNCndpdGggbW9kaW5mbyBkZXNjcmlwdGlvbnMg
bGlrZToNCnBhcm06ICAgICAgICAgICByZWdpc3RlcmVkX3NoYW5pOlJlZ2lzdGVyZWQgY3J5cHRv
IGRyaXZlciB1c2luZyB4ODYgaW5zdHJ1Y3Rpb24gc2V0IGV4dGVuc2lvbnM6IFNIQS1OSSAoaW50
KQ0KcGFybTogICAgICAgICAgIHJlZ2lzdGVyZWRfc3NzZTM6UmVnaXN0ZXJlZCBjcnlwdG8gZHJp
dmVyIHVzaW5nIHg4NiBpbnN0cnVjdGlvbiBzZXQgZXh0ZW5zaW9uczogU1NTRTMgKGludCkNCnBh
cm06ICAgICAgICAgICByZWdpc3RlcmVkX2F2eDpSZWdpc3RlcmVkIGNyeXB0byBkcml2ZXIgdXNp
bmcgeDg2IGluc3RydWN0aW9uIHNldCBleHRlbnNpb25zOiBBVlggKGludCkNCnBhcm06ICAgICAg
ICAgICByZWdpc3RlcmVkX2F2eDI6UmVnaXN0ZXJlZCBjcnlwdG8gZHJpdmVyIHVzaW5nIHg4NiBp
bnN0cnVjdGlvbiBzZXQgZXh0ZW5zaW9uczogQVZYMiAoaW50KQ0KDQpUaGF0IHdvdWxkIGVsaW1p
bmF0ZSB0aGVzZSBwcmludHMgaW4gYWVzbmlfaW50ZWwsIHNvIGFsbCB0aGUNCm1vZHVsZXMgbG9h
ZCBzaWxlbnRseSAoYnV0IHlvdSBjYW4gZmlndXJlIG91dCB3aGF0IHRoZXkncmUNCmRvaW5nIGlm
IG5lZWRlZCkuDQoNCglwcl9pbmZvKCJBVlgyIHZlcnNpb24gb2YgZ2NtX2VuYy9kZWMgZW5nYWdl
ZC5cbiIpOw0KCXByX2luZm8oIkFWWCB2ZXJzaW9uIG9mIGdjbV9lbmMvZGVjIGVuZ2FnZWQuXG4i
KTsNCglwcl9pbmZvKCJTU0UgdmVyc2lvbiBvZiBnY21fZW5jL2RlYyBlbmdhZ2VkLlxuIik7DQoJ
cHJfaW5mbygiQUVTIENUUiBtb2RlIGJ5OCBvcHRpbWl6YXRpb24gZW5hYmxlZFxuIik7DQoNCg0K
