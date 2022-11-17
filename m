Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C3762DF7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbiKQPUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240562AbiKQPUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:20:00 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8327723F;
        Thu, 17 Nov 2022 07:14:14 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHFC7qe018975;
        Thu, 17 Nov 2022 15:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=sXb2EmS906kZgyQXJJ/dybKNi4R+fXt9iE4PcEDPT5M=;
 b=f40Ax+SLj9rBjmoek6H0CNu5TfDf5PE2VRI7dMMKIo2OT9oTUr2caZjYgywos1rpYDq+
 WS4D2Hl/TuY75IBehP82ANlfVU3C9J+FWKlblLRJFrFGTDqT7gVtH/Jb/tGC+jHpgFaz
 5Y3gy4a6T2pHCToY6jtN7bmbqmQfPzf93EFVkt630D4q7T9i+QmYFCa2d0UXfF/W7Ds5
 mVGA5Q1ayluS+8VgPo5gJBFv/d9wjRLQs5kOE2HoXFYRGPUkfGY8Bb9K1qNg6jFjStVQ
 mGg7oo0ZaVRcCn+yARNuEVJ1M/nMZaxCQQhy+NS8CnaXjj9VCIIb564AHJAN7XAX/Fy9 Wg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kwppa8ctj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 15:13:56 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 6ED168040F5;
        Thu, 17 Nov 2022 15:13:54 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Nov 2022 03:13:54 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Nov 2022 03:13:53 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 17 Nov 2022 03:13:53 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Nov 2022 15:13:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2pzbnD2a2md27in/9KiD/tGeIlCYsJkZk3iW4ocwvSy/HI4zn7yNwrH2ZX6WIQLP+ubTEfmpr0iDDyyfBnw+xPzyf8DEwc1ylJwNQeSYGMSmSj52AxZo7Up+jzLesZH3v5w+60n1AAoYusbPcsY5/Yq7CTPxv2yvv3bDr5l4TJt3OKgRyOiD9jG/A/KovSNGic6yaOOWEEqJWVP5x8ILxKVEuAR9cz7D2nTrU/QH3/TQ/xy39wCQyx7116UdsFe8SLbVTKb/3LKIQyTDNKN/2Hs1k0wWlcbo/QN35hruAHYxLdXjxkcqk3qrrjM2Xv+ZF2XDkv1ZROVfsZEevY6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXb2EmS906kZgyQXJJ/dybKNi4R+fXt9iE4PcEDPT5M=;
 b=ZG3tutNlf7R5BmaMKDMhUyh9K/sfQyCVh67jam4/46CEtamG+2V6OEom+WYFWUeFb6dNe5V/dSV7iOv52JqH+9tUKSc5K82ZZnTAEFsJCNJb0V2/fMAr11tIEcfnm/t3iB7BjBl/EMI6x9eTOxTujkwTvzFmfNw0yLQZSGNgg+sZ9shOylzrZZnS+SZ4gzbPoCUE+dspgJBs8disH2DO1fyi2gboJegoIjo99bC+vzaLfNsHs5E0USoqTSwARfYKAGPIJSsnUWSDP1aM6ZJL4wIgct+flBJNL+W6fsOceD/lJv40N0wPkGPtXSfxqMKM6p6HoIGvW57SZn7CGe1D9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1698.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 15:13:47 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 15:13:47 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 00/24] crypto: fix RCU stalls
Thread-Topic: [PATCH v4 00/24] crypto: fix RCU stalls
Thread-Index: AQHY+XHhbEL3YWz16EWWpSEFHZ9zIa5Cft8AgAC37TA=
Date:   Thu, 17 Nov 2022 15:13:47 +0000
Message-ID: <MW5PR84MB1842928E4228956EFA4D4BCAAB069@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <Y3WxcrjHD4MRWHcS@gondor.apana.org.au>
In-Reply-To: <Y3WxcrjHD4MRWHcS@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|SJ0PR84MB1698:EE_
x-ms-office365-filtering-correlation-id: 8b413da6-2200-4d9c-f689-08dac8ae5367
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwNLyeQWhZKYQxxkSHdoRv/e7VCE17IkjU09hmBtIcUz//Pf7akhsapecv4fA/bFWeTNJ9gBnYGbrWCezyAHveTSq2yU3Doog8oH4IFxw3JjZkBwvT+598aK6oukEQkbziGQCVhpDgSGuJMt0V+DwQzim75o85Ba2GQlPIBfUTEWVWzLNn75exTPbl6zGKq+tDNaqwzdMLYQW+0s9fx/Q/OBneD9nmPkVCFgx7Nr/ob28+EO444JdG0swENVW6gK8JaTShwubZdeqAxFpDwflyxb7PgztaqEu75s8wsGjbP4qaxccbJHX3QHHR5gAmO+Nrz1DlV8pXKPR3q+hH1NB+bKsFacTHQipKAk2uLxsfYb2ttZHSONulon705d4IQLYyghHjLZhnuB8MfHHMgaS5yHnnvTf82TmppPEUV8eoKsEyd70I0C8ad2qyG57M320WXh8ehinmYdziPjW1NJW1SdJ1U1+r23baKokiqc0Pa9a1xBciIfcR+F1u7trPcpntLziumlsTFYdDIfdXeL4CjOnYKy/xgK7AjdjtiFxe9swzc+HOy3aVFcTOR1ft80ZmFGd2g8XC7lLR5FoURIb8goxdHvnAjyddqMgwySoPAsoz8pGsDfPLoSFRC5jDiRHWdxGlwBc61YFDvQLVfZn8lW1+Seih4KYSKIfxKJHBICPnOYakiV4jlZP3rNU75p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(71200400001)(66946007)(7696005)(6506007)(55016003)(478600001)(76116006)(316002)(6916009)(53546011)(54906003)(33656002)(83380400001)(38070700005)(186003)(9686003)(38100700002)(26005)(66446008)(4326008)(5660300002)(52536014)(64756008)(7416002)(66556008)(8676002)(66476007)(8936002)(82960400001)(86362001)(122000001)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?782oyOpb9y30wRlynztrdEUXbjE8Cs5hk7DOntKxRvi7WJKWXqkZa0i72ZoN?=
 =?us-ascii?Q?UpNVwr1ByGIBbSbmx0AdFc5FIDd5OiAyFdfjmLQ98T44OKhGS2Ykbqnkdjws?=
 =?us-ascii?Q?ecO6faGXn559tb9hZRCYNEMHYZKuquWUZsa+6AitSDX+mb+b6VNNu86K7frG?=
 =?us-ascii?Q?ooPoIr+SqEnTiB/F07NdTM+SOIQ3TZxxx6gAVqWVabv2R7fh5xWm4F/raLlw?=
 =?us-ascii?Q?ltchOcRgTmFB0mzWHrVFy0g1/eE7DF5hsHOn+jDA/To/ceRzvN9HQu79N5EA?=
 =?us-ascii?Q?KSAKO1kZjDPDD0QR3fUJqq1fk5zB8YUmaQxEAQOZuSLtYUy9TTtC13vSOgLH?=
 =?us-ascii?Q?nni6p2qsFbS6qgUAqcP1hqGir38VzdHhy1Y9hR7MGEK9EJF3glqyAZKnv1fj?=
 =?us-ascii?Q?9NwTNaek68xZDJWFIdtVFeFMqHruWRCWloUtn4G5wujlCB7TAXnfwZOXzu9y?=
 =?us-ascii?Q?lbHfhi2J9GmVLGyGrNcG/wdhXuwM4swt0KfVNPCx/5dc+3HdOZGaT4Yfshdo?=
 =?us-ascii?Q?+QkvwERkOwu1uP3+kg4RATsMJfDC7n/492r9mQsidcLYdTeYULDjh5035EmQ?=
 =?us-ascii?Q?/6yzaVBSpFKdbLcy06eJyXDH5FNXgiF3ixwrwyK3tu+iSFu+3PDHESDZfZ3G?=
 =?us-ascii?Q?+b7DFFNlOxDCWuyCKmuJmGR3zgFI8IMe4spr/UF/ykxEinJIZBAFSLozcavu?=
 =?us-ascii?Q?NK+mvgljCwFDV+s0t+u48UFNqsXSQ2czv8POVosk5PDcv/drD5R4W80ufjAF?=
 =?us-ascii?Q?/SFq4Sdmq/LOqb/4J04S0+3Eid7khkZ7xwgZlGYuF/ZuX/ic7Y/3YlOtMfn1?=
 =?us-ascii?Q?ZiEps+QRspSLhLSgoOj7IegxfqNCOe5B4i+PiAqe9SF+73NtSwF6m0DG1pAC?=
 =?us-ascii?Q?20WnVyno6GZfpycm2MfgI+z5DrK1Dse7umT++JR1Ojnne+ak09UEZX6BXb/e?=
 =?us-ascii?Q?NBT43/IMxxNvn5xOgvirJCH9Ruox4/6jy1+Uoue5blwmKlbOcBaE4jISxBi4?=
 =?us-ascii?Q?QCt1eN30PUyvsjbde6aagdQdcyMdKvcJEfNHI0nAbdiX/EE0MWIt9ckcHt+V?=
 =?us-ascii?Q?B6so09yWa8wOQaVIKSNC43AM6zm0ULOsF+A9ubN051CE9P+CNfm/7zV1pBgg?=
 =?us-ascii?Q?cDFcuP20uX5n1lBTTFOFejAKi2QlGTt/KizRyoPF/Moxw+0IWwMX+qnrRBt7?=
 =?us-ascii?Q?rnMfb9O9E2xckOfIuH0xaBQFcX4w23YkTPREDQTjy+uyD6HR9GYCoOBvj+Kp?=
 =?us-ascii?Q?OII8piJo2s6wLInQkTBGSRMPV/sCoa8wjNTE1oGVQ1Bh90UCnhydiDufOkIb?=
 =?us-ascii?Q?wntETmBAg4sk52LjWDKDsIYXcvYNbSkcr32wjcJz1k0pI7pBJ2nfhcXPIaZq?=
 =?us-ascii?Q?FVPFbZbdJ7MyWsqqh7nY4Q4c28+TItcA6urQd1R+/oH0NSwWowKy5KC1r5oK?=
 =?us-ascii?Q?M2IqRFDQ2GW6dTI1cmQEvt2xi7ItM+IvtpZYMt+cjzGXDUEsbh2N9GY12owQ?=
 =?us-ascii?Q?8stCP2mdQhWusvhb8y+l5KDxUO7ikPZrTVTvc0KAFSLqIpR+fNpfz9dWY/GR?=
 =?us-ascii?Q?Gk47zZks4x/Tnrq/vsU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b413da6-2200-4d9c-f689-08dac8ae5367
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 15:13:47.5064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJiCru7PrXDi2ZKFwg9YP7A6zFygXXYILpzDaeyXTSS9VvITMfy9P9qiWve+MCqc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1698
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: n3Yv7l-OUlHWWpyW31qkLAqXykYBxWUO
X-Proofpoint-ORIG-GUID: n3Yv7l-OUlHWWpyW31qkLAqXykYBxWUO
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Wednesday, November 16, 2022 9:59 PM
> Subject: Re: [PATCH v4 00/24] crypto: fix RCU stalls
>=20
> On Tue, Nov 15, 2022 at 10:13:18PM -0600, Robert Elliott wrote:
...
> > These problems have always been lurking, but improving the
> > loading of the x86/sha512 module led to it happening a lot
> > during boot when using SHA-512 for module signature checking.
>=20
> Can we split this series up please? The fixes to the stalls should
> stand separately from the changes to how modules are loaded.  The
> latter is more of an improvement while the former should be applied
> ASAP.

Yes. With the v4 patch numbers:
[PATCH v4 01/24] crypto: tcrypt - test crc32
[PATCH v4 02/24] crypto: tcrypt - test nhpoly1305

Those ensure the changes to those hash modules are testable.

[PATCH v4 03/24] crypto: tcrypt - reschedule during cycles speed

That's only for tcrypt so not urgent for users, but pretty
simple.

[PATCH v4 04/24] crypto: x86/sha - limit FPU preemption
[PATCH v4 05/24] crypto: x86/crc - limit FPU preemption
[PATCH v4 06/24] crypto: x86/sm3 - limit FPU preemption
[PATCH v4 07/24] crypto: x86/ghash - use u8 rather than char
[PATCH v4 08/24] crypto: x86/ghash - restructure FPU context saving
[PATCH v4 09/24] crypto: x86/ghash - limit FPU preemption
[PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
[PATCH v4 11/24] crypto: x86/aegis - limit FPU preemption
[PATCH v4 12/24] crypto: x86/sha - register all variations
[PATCH v4 13/24] crypto: x86/sha - minimize time in FPU context

That's the end of the fixes set.

[PATCH v4 14/24] crypto: x86/sha - load based on CPU features
[PATCH v4 15/24] crypto: x86/crc - load based on CPU features
[PATCH v4 16/24] crypto: x86/sm3 - load based on CPU features
[PATCH v4 17/24] crypto: x86/poly - load based on CPU features
[PATCH v4 18/24] crypto: x86/ghash - load based on CPU features
[PATCH v4 19/24] crypto: x86/aesni - avoid type conversions
[PATCH v4 20/24] crypto: x86/ciphers - load based on CPU features
[PATCH v4 21/24] crypto: x86 - report used CPU features via module
[PATCH v4 22/24] crypto: x86 - report missing CPU features via module
[PATCH v4 23/24] crypto: x86 - report suboptimal CPUs via module
[PATCH v4 24/24] crypto: x86 - standardize module descriptions

I'll put those in a new series.

For 6.1, I still suggest reverting aa031b8f702e ("crypto: x86/sha512 -
load based on CPU features) since that exposed the problem. Target
the fixes for 6.2 and module loading for 6.2 or 6.3.

