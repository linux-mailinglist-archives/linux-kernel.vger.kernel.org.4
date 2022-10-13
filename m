Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83F85FE45C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJMVsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMVs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:48:29 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D39CF53F8;
        Thu, 13 Oct 2022 14:48:28 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DKhAdP029309;
        Thu, 13 Oct 2022 21:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=nQw3VxQazLl8NYQG+2ALJfwqaSM6nEU2JsknpfOj9ek=;
 b=TtEMJrh900FghXPrWEeLQPVZYL81k/WJ/VmPtVuFG44KaCSeo1z2gd3emluMF+i+Dgq1
 sEvrnorswT4rNym+KLRxBuBRdW4DCCyZvVJmglamSidBYNvswT1QJaqRa4Jm6LCwr1Jx
 QkreheqmwKoD+ptKtXf/SYzW4Z1jef5z7DkReQ6fDMc43Do5sAgabvx8STXL58ar2B2L
 jgpX4FHka003GMYk/Lw1q3o0jag3cWCL3xJvfkmkTT+lo99oxM2DSrIRrsHce6EQ9pIH
 8illpPciStQws87mzEp1Riv8UhY5B4XAl06NX1EnXjGDYtKSZSW/kS6uBDVy1GMDe9mn 6g== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k6qw19h6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 21:48:12 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id BDF54806B5F;
        Thu, 13 Oct 2022 21:48:10 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 09:48:08 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 09:48:07 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 13 Oct 2022 09:48:07 -1200
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 09:48:07 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNMBKRlZzf+gVZrEF05vdftAg/L61HW4blRIp63kFX9cwJribHaEQj0hung3UlpneOQjIRJ9yqaqGzpqgtvzQgbweRU7cvjwOfft+bMS+E5nUWxKMXxAv1ZadtEBGy81YSam9WStcg00a/B7S4TezxUBe4hfaIMPOmqxF43DTmZ2KNTIiLXsalzgAE+CVho9yJo2Y1ZgHFt2LzMxLoZlqNLnr2fU9X5HH4ZNeuDgI6I4W4zVrQiScC4p/fKg6fsEtIz8Ulmogf2oCG+frSyZYxpKGrZrFsA/m8b3DGps5WtVu9xpQnWjiGTe+MCGJP84c44vbHBSAXogCISj3GnJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQw3VxQazLl8NYQG+2ALJfwqaSM6nEU2JsknpfOj9ek=;
 b=bFPi9q+Qz4FYr7vC7DO8nGcHwZsZEq6hePfZ1hzpPlPnoLHIa17suQUw48zYRX3dzX5UT6KaimAam0fxJLE5aR+kbrp9lZLucExf5pNPZ+kBkPITyRxMaRW/bo0iOMKDnwIxlA0k48RPf8AUB/VNCUNe0CefKpT3r4WD9zFjQ+X3yBb5bIfKIltqQjygTRdv6JiB7qPrgZ7EolOw3HMTqwNZvwY2dp0KW3/BiEpkWa7na+dcQZhQy6/WNCmiuF0eY5wJuSu4vy3TnZmsoiqoLlAFzZLB+hX4HNvxs0FAxHj5wPPVk3OOKaHEz4mUZR1+66/WswMDLW5tjUrp4Ebc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1408.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 21:48:05 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 21:48:05 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 09/19] crypto: x86 - use common macro for FPU limit
Thread-Topic: [PATCH v2 09/19] crypto: x86 - use common macro for FPU limit
Thread-Index: AQHY3oYJHDRQQDpIyUq04aDzJuq/H64LelgAgAFZXsA=
Date:   Thu, 13 Oct 2022 21:48:05 +0000
Message-ID: <MW5PR84MB18427894BEF615BD08F4603EAB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-10-elliott@hpe.com> <Y0ddUkGg15kHCIiB@zx2c4.com>
In-Reply-To: <Y0ddUkGg15kHCIiB@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1408:EE_
x-ms-office365-filtering-correlation-id: 8981f904-306a-495a-57b0-08daad649c3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHq8mNHN0VtqQZ3q9KRTPYufn0hzsypjUX2/wfKoB4w7H0HNITWFbIZId40691XbS9sFv3p+i0JgJDA62u/GX6oh9H3A9204MzEI/yOLDpgPcegz/vEQIvTntnkM4RNYRoy0sjX15k0+zGv7/fz5FM5+W2cBFMgT4MQob2TXHGodyRxYZk0f6zCdyEGs4GdCQQjAMiEWq9FKbMSVpdkPtzcy7rK1DVoY57aR+qBuTHQ9TDVZU0pESzqU9KrPWucEkWkTrmRKNgztMuHvHwzogUQzNJc97duu6pxTVjImx9h8b++3WkWq09Mo2eIrYXtUFHEgviXWe9NIvI1aPnQ7GTMu9yabgx1vEIlRop4fpw7XWPkOxR6j/ej0yh0XgI1WiYtKb2pHaFpx6PNVbQ25rm3cqA+OP4TFO5+XlVRo/aVSCv89Gci5HeNOTtygf8tvXLMClKsICuBmgcCZQUePGytz6zV2Kts4EcM5hJGJhNdNEyIGR0HlFY1z+URq1aYS2hlkn9g0KKxXjMUUWsNQJmN8OKnXMkGGyIhCCkNrdcEjgGcYIQoaHJoOS4ZWKzUOAT4uyXm8uspbZTImeH38wdqqrd+zTWjvcbqlFHl8rH6Hdj1YLm55f0H6TgjwNb+mx0VuKxSnRfjrSQpF/3SPVEjx2FPWO/FrYKIOgN4MJMBU0GZiqaIo+3aMugHQb7MU3TdUA0hjBSDmQ7j+341BxfKGInCfDPEdqLGhA6VchAEmiqBgLcaq7BOemWfJO2sM3w7UzjOKaqhSLLm9aIofgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(9686003)(66556008)(7696005)(71200400001)(53546011)(5660300002)(83380400001)(186003)(2906002)(6506007)(52536014)(316002)(26005)(41300700001)(478600001)(8936002)(66946007)(4326008)(6916009)(66476007)(64756008)(66446008)(54906003)(76116006)(8676002)(55016003)(33656002)(122000001)(38100700002)(86362001)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlF3ZEtVTHhPbG1OeldQSUs3ZU5OMHg5SXdvV2JIVG1tbVZNRjA3VGlZVzh0?=
 =?utf-8?B?ZjNaRjFaelpQZ0RjVkZhOVAvWHFIRFRLUFF3L2ZUeWo3cGdNV3I4TmJaUHdQ?=
 =?utf-8?B?K05TRERMbmp3Ti93OFpHdFg3YUo0Q005WnhudWZ0b1l2bFFQNlRYMXBlOVA3?=
 =?utf-8?B?WTBoVzV2VEtsMU1WbmZmRUNublVPUzd6aDBGeGJ6eDcxTWcyQWkrRDMwUit1?=
 =?utf-8?B?bWhoRzl1M2ZrTks1K1RuRXNsS0ZqMko4NkZvMTdaOU44ZkhuYVpmV3pVL1NW?=
 =?utf-8?B?VnlvZGVsTGdtdGdwd1VtZktrMlBSempRSjU1cUlzWnJCeEl1cng5OGhybWJI?=
 =?utf-8?B?Q3JFMk1XU2lvT2dEa2RzVE0rMVhUUzZYYlNrcmxmSWF3NnJuNE9zUXoyN0Vp?=
 =?utf-8?B?U3BiMGdwbjZDVVZWYmwrNWpUeFJ5WVo5Ylk1SmZrVEF2OTN6UC8zRkJhWmhH?=
 =?utf-8?B?VHh5cjJoaCt5RmpUTmlSUStDY0hBNkJFb05tdFdRUXVBV1FEdUVVQ1MreDhi?=
 =?utf-8?B?dmdVRnUyWkFFeGt6cjR2Ui82MHhDNlJZOHF1eGUyL3VER0hRZHFmNy9JUUZw?=
 =?utf-8?B?U2EwdnlnTmIvY3JBNmNadDNURmlVdFhYQ0FUaHFZRmVKbWxLWjhrbmx2cGhZ?=
 =?utf-8?B?RlRCdXI3bFUrWmxQMlJBRnZmZjJBRmpIV0REL1FlTDh6WHIyZzl2WVZNYWFL?=
 =?utf-8?B?alQ0dHMyZ000NytqcTlaVXRtUzlTS3UxbnphOFl2ZWtlWTRwdWpXcjRHZisw?=
 =?utf-8?B?bWVuMWtUdGcxcDZDUkFzUXdoMHQ5OW9vc3Z5Z3pIMlpoZ2o5RGd2VStNSW9B?=
 =?utf-8?B?NlRoUWNNTm42UURtazA3cEVKY2Z6Ky9USFFzVFRmRUZJcGxHTEp1REJvRTla?=
 =?utf-8?B?NHFLenZNTEZwcnN6ZkFWWHcvc0o1RnJXem5HemIvdEpMT0prL0RFTjhwei9T?=
 =?utf-8?B?T2FTYWNOSjE3aXdNRS82Y2x0Z1Z6SkVpak5nZDdHbWtmL2hSMG5HMFg4Qit4?=
 =?utf-8?B?aHk3YUttV0VzVVhicm8zd3hxeWF2NW95YmtMdEwzb2cySlV6d1krdUh3ZC9P?=
 =?utf-8?B?a3B5OC9SZHN2UWNTZUJUaXppbTRuYUdIdnV4d1ltZmdWclNCU2lRN1NqbktP?=
 =?utf-8?B?ZUxIS0NBSGhmVHBmOEliM0dkb3BrU1A4eDdBOEVBRVBQWWcrcjluRlRTYXVD?=
 =?utf-8?B?NGxzcy9OdndUdzcwNVQ0R1pPMERlVkx4U1N4OExXWHZYdlFjQ0VBSWpQTDF6?=
 =?utf-8?B?aVBnTFZ5UzRXeGc4eXJ0WWxYR1dZUEVxNXgxeWhkcVdrdTNiak9xOStySlla?=
 =?utf-8?B?eHhCWWEvb0FtM2t6Um5sZ3hUWlF0REFQT2tjRmRYaTArSC9VY3p4UWpBVndq?=
 =?utf-8?B?TnBFTDIxUmw5N1JVS2lMN2lIc3dCWTFPTk1hYk5JSFZmSjNMV1d2SzQycTc2?=
 =?utf-8?B?STJGM1JLY1NsMjF4ZUtQN1JYZHgxYzlFaWpKM1hHUWhMZ29valFOYXQ0dnVw?=
 =?utf-8?B?VTFqUUl0QlViU2llVlNrdWhFMWdqdlQvNG41aXdKekQxQXFkeW91UDdzZ1JZ?=
 =?utf-8?B?d2hSZ1JRSjhmZldPODRzd0w3R2lSdjBxQVA3cVorOUxYRW05b3RzeXlSVUtm?=
 =?utf-8?B?OUlJU2NIN1JHSU9mc3hoUWxaUXhPbHc4VXhqbHVhN2VkcU5ZZkVQNnh0R210?=
 =?utf-8?B?anNJNHlRWTMvLzM2RndOcnpqK0ZwN0pLanZJMGJXZGxPellFODIxSGFKeXBy?=
 =?utf-8?B?Mk9abWsxTXZGSUhBWEVxdXV3RWRpWTJobE0zS1NQdnY2T2JzL0g2KzZ4NGM3?=
 =?utf-8?B?bUpsKzBOUURnckNLZjZpekdGUUFkdER0MTZPY2FMNkZ6K2lRa1F6R2piU2dZ?=
 =?utf-8?B?b3RqcVNDM3VCOGJJditNdUQwanYzc2l5ZG5FallETzJ2SGdEZ29iWFh5L1pN?=
 =?utf-8?B?UExFb1loRVR6T2dWUkZUQWVLZU9CU2s3WnhKM0Zsc3JxOE8vSnV4SjFySXNu?=
 =?utf-8?B?aUlCa3c2S3gzN09RYXZITExxK210YUJxLyt5a1FnVGdpVGhDZGRrOHZOaGlF?=
 =?utf-8?B?T2F2aGFiL0JacGw5bkJncW5zMS9xUGUrQ0NyTjROeEdpS2cyQUIyZW1kSlNz?=
 =?utf-8?Q?Ngso=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8981f904-306a-495a-57b0-08daad649c3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 21:48:05.5594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4n3cTyIrJsCimeBJODiuebK/iocnEJ3ugUD4KAmN9MjE4MfT3VhRn4XRJWuhoilG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1408
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: -KPmx1FF1QbCDXx9gT_wsilgynthODnM
X-Proofpoint-ORIG-GUID: -KPmx1FF1QbCDXx9gT_wsilgynthODnM
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130121
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gQS4gRG9uZW5m
ZWxkIDxKYXNvbkB6eDJjNC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAxMiwgMjAy
MiA3OjM2IFBNDQo+IFRvOiBFbGxpb3R0LCBSb2JlcnQgKFNlcnZlcnMpIDxlbGxpb3R0QGhwZS5j
b20+DQo+IENjOiBoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7IGRhdmVtQGRhdmVtbG9mdC5u
ZXQ7DQo+IHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tOyBhcDQyMDA3M0BnbWFpbC5jb207IGFy
ZGJAa2VybmVsLm9yZzsgbGludXgtDQo+IGNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwOS8xOV0gY3J5
cHRvOiB4ODYgLSB1c2UgY29tbW9uIG1hY3JvIGZvciBGUFUgbGltaXQNCj4gDQo+IE9uIFdlZCwg
T2N0IDEyLCAyMDIyIGF0IDA0OjU5OjIxUE0gLTA1MDAsIFJvYmVydCBFbGxpb3R0IHdyb3RlOg0K
PiA+IFVzZSBhIGNvbW1vbiBtYWNybyBuYW1lIChGUFVfQllURVMpIGZvciB0aGUgbGltaXQgb2Yg
dGhlIG51bWJlciBvZiBieXRlcw0KPiA+IHByb2Nlc3NlZCB3aXRoaW4ga2VybmVsX2ZwdV9iZWdp
biBhbmQga2VybmVsX2ZwdV9lbmQgcmF0aGVyIHRoYW4NCj4gPiB1c2luZyBTWl80SyAod2hpY2gg
aXMgYSBzaWduZWQgdmFsdWUpLCBvciBhIG1hZ2ljIHZhbHVlIG9mIDQwOTZVLg0KPiANCj4gTm90
IHN1cmUgSSBsaWtlIHRoaXMgdmVyeSBtdWNoLiBUaGUgd2hvbGUgaWRlYSBpcyB0aGF0IHRoaXMg
aXMgdmFyaWFibGUNCj4gcGVyIGFsZ29yaXRobSwgc2luY2Ugbm90IGFsbCBhbGdvcml0aG1zIGhh
dmUgdGhlIHNhbWUgcGVyZm9ybWFuY2UNCj4gY2hhcmFjdGVyaXN0aWNzLiANCg0KR29vZCBwb2lu
dC4NCg0KSSBub3RpY2VkIHRoZSBwb3dlcnBjIGFlcywgc2hhMSwgYW5kIHNoYTI1NiBtb2R1bGVz
IGluY2x1ZGUgZXhwbGFuYXRpb25zDQpvZiBob3cgdGhlaXIgbWFjcm9zIHNlcnZpbmcgYSBzaW1p
bGFyIHB1cnBvc2Ugd2VyZSBjYWxjdWxhdGVkLg0KDQphcmNoL3Bvd2VycGMvY3J5cHRvL2Flcy1z
cGUtZ2x1ZS5jOg0KKiBNQVhfQllURVMgZGVmaW5lcyB0aGUgbnVtYmVyIG9mIGJ5dGVzIHRoYXQg
YXJlIGFsbG93ZWQgdG8gYmUgcHJvY2Vzc2VkDQogKiBiZXR3ZWVuIHByZWVtcHRfZGlzYWJsZSgp
IGFuZCBwcmVlbXB0X2VuYWJsZSgpLiBlNTAwIGNvcmVzIGNhbiBpc3N1ZSB0d28NCiAqIGluc3Ry
dWN0aW9ucyBwZXIgY2xvY2sgY3ljbGUgdXNpbmcgb25lIDMyLzY0IGJpdCB1bml0IChTVTEpIGFu
ZCBvbmUgMzINCiAqIGJpdCB1bml0IChTVTIpLiBPbmUgb2YgdGhlc2UgY2FuIGJlIGEgbWVtb3J5
IGFjY2VzcyB0aGF0IGlzIGV4ZWN1dGVkIHZpYQ0KICogYSBzaW5nbGUgbG9hZCBhbmQgc3RvcmUg
dW5pdCAoTFNVKS4gWFRTLUFFUy0yNTYgdGFrZXMgfjc4MCBvcGVyYXRpb25zIHBlcg0KICogMTYg
Ynl0ZSBibG9jayBvciAyNSBjeWNsZXMgcGVyIGJ5dGUuIFRodXMgNzY4IGJ5dGVzIG9mIGlucHV0
IGRhdGENCiAqIHdpbGwgbmVlZCBhbiBlc3RpbWF0ZWQgbWF4aW11bSBvZiAyMCwwMDAgY3ljbGVz
LiBIZWFkcm9vbSBmb3IgY2FjaGUgbWlzc2VzDQogKiBpbmNsdWRlZC4gRXZlbiB3aXRoIHRoZSBs
b3cgZW5kIG1vZGVsIGNsb2NrZWQgYXQgNjY3IE1IeiB0aGlzIGVxdWFscyB0byBhDQogKiBjcml0
aWNhbCB0aW1lIHdpbmRvdyBvZiBsZXNzIHRoYW4gMzB1cy4gVGhlIHZhbHVlIGhhcyBiZWVuIGNo
b3NlbiB0bw0KICogcHJvY2VzcyBhIDUxMiBieXRlIGRpc2sgYmxvY2sgaW4gb25lIG9yIGEgbGFy
Z2UgMTQwMCBieXRlcyBJUHNlYyBuZXR3b3JrDQogKiBwYWNrZXQgaW4gdHdvIHJ1bnMuDQojZGVm
aW5lIE1BWF9CWVRFUyA3NjgNCg0KYW5kIGFyY2gvcG93ZXJwYy9jcnlwdG8vc2hhMS1zcGUtZ2x1
ZS5jOg0KICogTUFYX0JZVEVTIGRlZmluZXMgdGhlIG51bWJlciBvZiBieXRlcyB0aGF0IGFyZSBh
bGxvd2VkIHRvIGJlIHByb2Nlc3NlZA0KICogYmV0d2VlbiBwcmVlbXB0X2Rpc2FibGUoKSBhbmQg
cHJlZW1wdF9lbmFibGUoKS4gU0hBMSB0YWtlcyB+MTAwMA0KICogb3BlcmF0aW9ucyBwZXIgNjQg
Ynl0ZXMuIGU1MDAgY29yZXMgY2FuIGlzc3VlIHR3byBhcml0aG1ldGljIGluc3RydWN0aW9ucw0K
ICogcGVyIGNsb2NrIGN5Y2xlIHVzaW5nIG9uZSAzMi82NCBiaXQgdW5pdCAoU1UxKSBhbmQgb25l
IDMyIGJpdCB1bml0IChTVTIpLg0KICogVGh1cyAyS0Igb2YgaW5wdXQgZGF0YSB3aWxsIG5lZWQg
YW4gZXN0aW1hdGVkIG1heGltdW0gb2YgMTgsMDAwIGN5Y2xlcy4NCiAqIEhlYWRyb29tIGZvciBj
YWNoZSBtaXNzZXMgaW5jbHVkZWQuIEV2ZW4gd2l0aCB0aGUgbG93IGVuZCBtb2RlbCBjbG9ja2Vk
DQogKiBhdCA2NjcgTUh6IHRoaXMgZXF1YWxzIHRvIGEgY3JpdGljYWwgdGltZSB3aW5kb3cgb2Yg
bGVzcyB0aGFuIDI3dXMuDQojZGVmaW5lIE1BWF9CWVRFUyAyMDQ4DQoNCmFyY2gvcG93ZXJwYy9j
cnlwdG8vc2hhMjU2LXNwZS1nbHVlLmM6DQoqIE1BWF9CWVRFUyBkZWZpbmVzIHRoZSBudW1iZXIg
b2YgYnl0ZXMgdGhhdCBhcmUgYWxsb3dlZCB0byBiZSBwcm9jZXNzZWQNCiAqIGJldHdlZW4gcHJl
ZW1wdF9kaXNhYmxlKCkgYW5kIHByZWVtcHRfZW5hYmxlKCkuIFNIQTI1NiB0YWtlcyB+MiwwMDAN
CiAqIG9wZXJhdGlvbnMgcGVyIDY0IGJ5dGVzLiBlNTAwIGNvcmVzIGNhbiBpc3N1ZSB0d28gYXJp
dGhtZXRpYyBpbnN0cnVjdGlvbnMNCiAqIHBlciBjbG9jayBjeWNsZSB1c2luZyBvbmUgMzIvNjQg
Yml0IHVuaXQgKFNVMSkgYW5kIG9uZSAzMiBiaXQgdW5pdCAoU1UyKS4NCiAqIFRodXMgMUtCIG9m
IGlucHV0IGRhdGEgd2lsbCBuZWVkIGFuIGVzdGltYXRlZCBtYXhpbXVtIG9mIDE4LDAwMCBjeWNs
ZXMuDQogKiBIZWFkcm9vbSBmb3IgY2FjaGUgbWlzc2VzIGluY2x1ZGVkLiBFdmVuIHdpdGggdGhl
IGxvdyBlbmQgbW9kZWwgY2xvY2tlZA0KICogYXQgNjY3IE1IeiB0aGlzIGVxdWFscyB0byBhIGNy
aXRpY2FsIHRpbWUgd2luZG93IG9mIGxlc3MgdGhhbiAyN3VzLg0KI2RlZmluZSBNQVhfQllURVMg
MTAyNA0KDQpQZXJoYXBzIHdlIHNob3VsZCBkZWNsYXJlIGEgdGltZSBnb2FsIGxpa2UgIjMwIHVz
LCIgbWVhc3VyZSB0aGUgYWN0dWFsDQpzcGVlZCBvZiBlYWNoIGFsZ29yaXRobSB3aXRoIGEgdGNy
eXB0IHNwZWVkIHRlc3QsIGFuZCBjYWxjdWxhdGUgdGhlDQpub21pbmFsIHZhbHVlIGFzc3VtaW5n
IHNvbWUgc2xvdyB4ODYgQ1BVIGNvcmUgc3BlZWQ/DQoNClRoYXQgY291bGQgYmUgZnVydGhlciBh
ZGp1c3RlZCBhdCBydW4tdGltZSBiYXNlZCBvbiB0aGUgc3VwcG9zZWQNCm1pbmltdW0gQ1BVIGZy
ZXF1ZW5jeSAoZS5nLiwgYXMgcmVwb3J0ZWQgaW4NCi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw
dWZyZXEvcG9saWN5MC9zY2FsaW5nX21pbl9mcmVxKS4NCg0KSWYgdmFsdWVzIGxlc3MgdGhhbiA0
IEtpQiBhcmUgbmVjZXNzYXJ5IChlLmcuLCBsaWtlIHRoZSBwb3dlcnBjDQp2YWx1ZXMpLCB0aGF0
IHdpbGwgcmVxdWlyZSBjaGFuZ2VzIGluIGFsbCB0aGUgbW9kdWxlcyB1c2luZyANCnNrY2lwaGVy
X3dhbGsgdG9vLg0KDQo+IFNvIGluIHRoYXQgc2Vuc2UsIGl0J3MgYmV0dGVyIHRvIHB1dCB0aGlz
IGNsb3NlIHRvDQo+IHdoZXJlIGl0J3MgYWN0dWFsbHkgdXNlZCwgcmF0aGVyIHRoYW4gc29tZXdo
ZXJlIGF0IHRoZSB0b3Agb2YgdGhlIGZpbGUuDQo+IFdoZW4geW91IGRvIHRoYXQsIGl0IG1ha2Vz
IGl0IHNlZW0gbGlrZSAiRlBVX0JZVEVTIiBpcyBzb21lIHVuaXZlcnNhbA0KPiBjb25zdGFudCwg
d2hpY2ggb2YgY291cnNlIGl0IGlzbid0Lg0KPiANCj4gSW5zdGVhZCwgZGVjbGFyZSB0aGlzIGFz
IGFuIHVudHlwZWQgZW51bSB2YWx1ZSB3aXRoaW4gdGhlIGZ1bmN0aW9uLiANCg0KTWFueSBvZiB0
aGVzZSBtb2R1bGVzIHVzZSB0aGUgc2FtZSB2YWx1ZSBmb3IgYm90aCBhbiBfdXBkYXRlIGFuZA0K
YSBfZmluaXQgZnVuY3Rpb24gKHVzdWFsbHkgcHJldHR5IGNsb3NlIHRvIGVhY2ggb3RoZXIpLiBJ
cyBpdA0KaW1wb3J0YW50IHRvIGF2b2lkIHJlcGxpY2F0aW9uPw0KDQoNCg==
