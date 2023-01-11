Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70B46658A1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbjAKKKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbjAKKKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:10:15 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2092.outbound.protection.outlook.com [40.92.103.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67E9DFF5;
        Wed, 11 Jan 2023 02:06:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4905V82hUxdt1VqE47iSGXsVorVw1s5aez73K8+AWFgBnaxQGU/iaXbj7YKT9oMoSegrsiUi83jDCNppPEMP8gnyEuZSy8ad13j6XvFLGsZd2KZZHZOCxcvUBcLHoD4BYeHwnVuJi8vzl8qZzORHJXcctC3EICEGxRxfakJnyQ1YVmyXvWzB2HQWvj3On8qK9XGoErSc00sxm2TKyakFrljcsf2BRnWPPN7H3CRf/L2jfA/2DYb295x+PAz++XLkz0al8fmP9y0s0VhWxIOYAt6dfMPsvjnmOe7FI2mGKqlQmBgysXyxKKG2ieDclBRxQhYTVWhSOqWiwp8iuSDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkgVilK9CzkGq3z7TONLXujhYjDnv2DaiNSSBCw12Z4=;
 b=NybfeAaqng/LGTE2HNzB9bwnbB0O+2qxf8tUTbfiLycWGX1/kKAdmM8mm3acGVpfjpZ/qg/FYKSLXcZYi7Tf51mfICbClwIV/d5/OCDvIK7tZFuZCbEtYGemOJBbs1VMuyjFZvUaIK0bamzzKKWPOkX9J+Gc19Tuo6Ip9ETTGAZpBoX+uugaPuerM1dA0jUSoBl6S9NJ2OAxG5zwSFMPRdpV3q/8SLf/TPDeu+rb2tOsA5z0pnmKBsWGBbcvGaFeLsfNlFMcFcZ2RZhOX09lax9BauD2hFWoczJbgeCKHhTXF+TkKlwQ8wz82zkQ8gnmwAtPI2G/DbGppjMUvzLOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkgVilK9CzkGq3z7TONLXujhYjDnv2DaiNSSBCw12Z4=;
 b=IRgzg3iet1iUijwNe+6EEnoplUbQopKlSRnQZViwo3ryoFYtXUy4VjGd8IHW/Rdd2rjpBmFCghv1kEpVgB+RfPe1Qa24iKlK0sgwnk82mybbReZgTK01xTwUn1k6aVN/djQz6gzgJjJ6EfDLjvnGSyRglSIA98HpAeRpMTnduCUd9d8NGpz55sD4OGJPGfjLOzpCcxB+Nv6sNJvTzPOoUSPC0aLkPU3o+YMv3LI/22youKbHiVnkVLwebJYezta5N+eOSu0S9uvXK/52RSZahVfIsNa0JDneBgEMLoenlMydaKfGgKNYV6VSDtnzfsrwJix9LW+vjVCwkbbpvl7VqA==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MA0PR01MB6359.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Wed, 11 Jan 2023 10:06:27 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a%6]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 10:06:27 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "orlandoch.dev@gmail.com" <orlandoch.dev@gmail.com>,
        "ronald@innovation.ch" <ronald@innovation.ch>
Subject: Re: [PATCH v2] HID: Recognize sensors with application collections
 too.
Thread-Topic: [PATCH v2] HID: Recognize sensors with application collections
 too.
Thread-Index: AQHZJNGQGewQeI41JU22YhcaXx9jy66YOK6AgADGWQA=
Date:   Wed, 11 Jan 2023 10:06:27 +0000
Message-ID: <A02BE14A-8532-4C2D-940B-06DCCDB005D3@live.com>
References: <8DA00FF4-DB08-4CEC-A5B4-47A71DC09C13@live.com>
 <01D620E2-18CA-40F6-A330-454CBC20C542@live.com>
 <EFCEA45A-C6F4-477A-B011-9C9E6E61E488@live.com>
 <74fbf0eb19ebdb964397d8f8d9b5fc12a06128cf.camel@linux.intel.com>
In-Reply-To: <74fbf0eb19ebdb964397d8f8d9b5fc12a06128cf.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [UN6I2o5BcOFUD/a+oa+BFlK8+a2faC2BsknhOfesfg7c/pwKAr1HTVcZnuF9snrQ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MA0PR01MB6359:EE_
x-ms-office365-filtering-correlation-id: 74867673-657c-4135-9d40-08daf3bb80f1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xsbllrBTs5rmh0almGHvA9XTBZhLGuxxIgtQGQpFLyk81QD5FJtRcTa9yLbyZk7deUQWYET8szG1FS4OX8eYY2V2jHJT18/bEmYM0/puZohVfbzzSTyyiafyUY4PKlc6UF9Pdz/Y8GhCvkt7wWIylIrZ9dvxhngiMGG6szR9/UNN/zLHkopR84rZO/IAjhlxXrS3pdxJvziTR2UKS/1/cYubu4NV83eu0a4XX/37A6hzwEhRqD7CSCNmohFKxhtVrZFbi7QR3u5q5lM7xLMYIB/IQh0Dh3xBYZ3yrdrEX/FOebypYCvSYspmVSPd5ccgfkfaVRd2DYwqWPbuZtg3SKyQz6AiTR7m/O1T0gw7SAVFi+s+o4efTsIfpQYTO5C7eYB4Pcogw/n/KVB7zoyDbBLB1iaeWJ8LBL6M6A+sMT/li3mPL5X4c2GPam5APhSNGXLtrHEkW8DzRxR5JD8VJTFhFYSh7jF0kjozzO2nPSfYyUhsNw0Y9GtQZr2vGUD0kWyyp+Svyda6U+GLUMMm/qTtvDkLqNwcuFCmZCQox15VrhhpY/SuQnYqrkNJsLhyh7C55ilneyNivVsp9+a/a8Mvc8vWi+sdbza3OpQimv96GJ4MLMHd2XHI0zZSvc4HwuUXpZN7SxAich5uy8YTXg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L7UkVGovRV6BWXkRgbABavcG8uM3EregBTrbhDfA+MKqkBM9L30pav8LwM0I?=
 =?us-ascii?Q?NcBPxchS5vwCeoKWXvLLS7bIhqdEBOowwgpXQX93zx1XsP6d6EvujQofVjQr?=
 =?us-ascii?Q?0bCZFj2nCQ9xiTAdWv1MOWtXNr8b30s7juFUVrYmDiwGon2h2B4nwGEHFHGX?=
 =?us-ascii?Q?mKqpioLZmn/mMqFS907FsS/PRpKBsT3BV0LrrL+9nYfE9DXlGhbgkYOmcDPA?=
 =?us-ascii?Q?Ggfe1RZdLQvnF8K2FLPI16A6pxF5AW/n4Np7JOVJrWejGFYunoLmD6aUDkZk?=
 =?us-ascii?Q?b5QdLvd0iqgwt70bSfvOOhB9um0ri+k4t+SgSFcLZdSKtT1aXA163nuEscm3?=
 =?us-ascii?Q?nsINBcsdxXZOCKttFl/fVp7NYSEhpqWkmYxbrsUiLRO2utEVL3v4Ym0VOEOA?=
 =?us-ascii?Q?2HMJ1w8fiFQ3OxGPhtSc2WcAeJ9gil1OoPZ9TcPJJ5bv3/BGwxLDtUPDlAz5?=
 =?us-ascii?Q?yZejkBGEFKXAawqBORMtmOwKC03Ca4uGdqMQpPn0nFCFjOQ90UofK9eysk+p?=
 =?us-ascii?Q?pof8sUnK7yVjmlFG4yTYAssGhCwiFflVqGMyOyOqrgw3zzFdAlE6eHVXsJHx?=
 =?us-ascii?Q?eDnAJHNEjWEdRCN3LTjF0IvC4zTlS8XO/CNnIDRNs45wQyruzhD4wcR9t4z3?=
 =?us-ascii?Q?tgRJNktNHi4yiCsTs0TOQzuIxah5e0M6O328SXuejfsKefCNqMC8LCjzW/rA?=
 =?us-ascii?Q?PtBff6I4bF942MXvGIq7W+sjaJ/6nGkZFuVx65W4tWvjoaLuzbF/SYf+bK5T?=
 =?us-ascii?Q?scftKqJs8uzQUWBDuK0pTDkYNIssjo+hZmAnxMROZj7zISDAnIfeDORNV2Gz?=
 =?us-ascii?Q?MdJxnotEOeRoDbivadF1Lazw96wLnbniSYr/mKlSKQl6/WWkyCZ1fcGib9Tf?=
 =?us-ascii?Q?rAojchKuy7+VfriNjc1nFE9L5/shCQy7REAZZneemIveynzvwS/4C0OFV51p?=
 =?us-ascii?Q?wSz8TLJAAXT3KoCrYCDXhK9jh33a1F0ZFPcT/bzSGoOTtoqIAQzcLj+sB99f?=
 =?us-ascii?Q?decRWRcrPic2fPk4cheUWQ/9QDfF2MJjpwtoQW8IhkUOurhkoaQCPQwMKmGq?=
 =?us-ascii?Q?v3R24gDWvPuaU6IlQXbCICNZVQuUP1ikg0lEGlvqvrQrH+1unvqAzluNF1dF?=
 =?us-ascii?Q?FvSMsq0Woo4pfEtnd5mFrj/3E7TNFkWFXF2oI2dwNoyoY/kAkK7qBS0KRSGH?=
 =?us-ascii?Q?4Q4f00Hwh89n4tHrjQmJ0Npgam9l5SbGYy0Lj59zBoMLSwlpw9EqMD+go+3u?=
 =?us-ascii?Q?ugmyYpVVsYMxjMeVMKHqRN33wUEiOH77AoitAMMafayCy5lap/cqjBL0AXuh?=
 =?us-ascii?Q?YH4TbuAZO8PZNifEh0TZ9XNIOT/YrtPtCEEjVhQ4UKl8Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F581870798785D42ACDD1801C9B40F6B@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 74867673-657c-4135-9d40-08daf3bb80f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 10:06:27.3786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6359
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 11-Jan-2023, at 3:46 AM, srinivas pandruvada <srinivas.pandruvada@linu=
x.intel.com> wrote:
>=20
>=20
> Don't add full stop at the end.
>=20
> HID: Recognize sensors with application collection
>=20
> Better not use language extensions. Simple to use
>=20
> report->field[i]->physical ?  report->field[i]->physical : report-
>> field[i]->application
>=20
>=20

Sending a v3 with the changes.


