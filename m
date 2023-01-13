Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3269366A37A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjAMTkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjAMTjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:39:40 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2428D5F8;
        Fri, 13 Jan 2023 11:36:08 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DJ8UD9010123;
        Fri, 13 Jan 2023 19:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=v+/xTsYc/OFoS73Kv2jSY8Wq5bW8z51XVIrdy9i012o=;
 b=QFqb2ydsU2U5K+5VJ81kK1pOwZLMTGtxpCnkj5wb2ikq48HlDCySeJgTrGsFVEykuQNe
 b+sYe37Hi9N4PLlwzN1spEoxPfFLOz1DWQoebxQTAJPLlp3W0krVRIKk5y3nVS0fAcqy
 S0OygPbihWCdq7BP9FqrLHswEnq8kkFrJwXCppx4ZDpipBuCYg5brS1ffIRmbaD5Qhhb
 pO1bd/IKgDPf0t70o9XIdGLpgh6wYFjv3Qj9l89ioOhIiQsLrQBlgCIxcMq0BIhtyj42
 PpTkRvxzkrwKtW2pMjwrLw1R1QhYk7xut8UAVe4QB4V7hjkwpPacyuNWPHRiJPLhMAhc sg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3n3an7s94q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 19:35:23 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id A6C9C801723;
        Fri, 13 Jan 2023 19:35:20 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 13 Jan 2023 07:35:09 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 13 Jan 2023 07:35:09 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 13 Jan 2023 07:35:09 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 13 Jan 2023 07:35:09 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDjdXg6mK+3oxzEHWzJrSKYWDhtJC27BtlM5qHVC/pLWueeE3Y0roPE2rmj2phIL1ZvbBJnDNh8pO+AXrHA1df3xCCgI+NHH65JxzFjuKedrwPoNyz/h1GvJ3eH52eGBX1zhHLWJrIYhtEUCP/yf0WWrqps5IcFBMm9qgnbaU3i2igmwTApi6vc3TQz5f2vSJfSJl+6NFqtpAAPDk2vsASSxpig1Wj5IK+fH/4sB1b909hQKy1Vv3f/t0QGDHZv3iioMGoPh+nw3Rc4qASwtc3z2MzuF6RoY4agm+Lvwp5g6U3tc/+VoSaTRB5yKcrM1OcZifheb3VWJtmE/T8mn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+/xTsYc/OFoS73Kv2jSY8Wq5bW8z51XVIrdy9i012o=;
 b=VXtURv2+DQ5IdKGyd6vprn4s2dNy8OnAyaTilVeSfEOwQK5dTwtrW9FCnLRsK6SY13Axv8300oMAAZwKV6nnYf/YZImYu9qS3czbdtXYgMC9gm+v75ThEDdun1lenD77q/7POLebNY0SvGiVARWJmblU3ce6CXFi0z5AnbihB0T990eRI6sAPQ54UrY0OJe/podTNDFx6kKz68WK0jPwwGkz2hVmseYI/eaTEXduPEKKixcR9nzY/XLKNJYPeVSNUeUXnrQOUeb8roqJbva5twm5o96jtpmmoV28svvMRsLOvs+Sm9m7LhRfnAvBWU9UhkxWHplBhILa/SSNmEvNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1667.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 19:35:08 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5986.019; Fri, 13 Jan 2023
 19:35:08 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "peter@n8pjl.ca" <peter@n8pjl.ca>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/13] crypto: x86/sha - yield FPU context during long
 loops
Thread-Topic: [PATCH 03/13] crypto: x86/sha - yield FPU context during long
 loops
Thread-Index: AQHZE/XDWaAb3QEorke1SC9apjqFca6akXiAgACzCACAAIMpAIAAAGsAgAEWHVA=
Date:   Fri, 13 Jan 2023 19:35:07 +0000
Message-ID: <MW5PR84MB1842C7F8190348625158DE9CABC29@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221219220223.3982176-1-elliott@hpe.com>
 <20221219220223.3982176-4-elliott@hpe.com>
 <Y7+/Yy7+mLEyqeiK@gondor.apana.org.au> <Y8BVkjwPc6DLm7HT@sol.localdomain>
 <Y8DDmBg6J31pS0KW@gondor.apana.org.au> <Y8DD8s9nakxW5zzE@gondor.apana.org.au>
In-Reply-To: <Y8DD8s9nakxW5zzE@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1667:EE_
x-ms-office365-filtering-correlation-id: 94d1c415-fb2a-4b57-3052-08daf59d4731
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+i9TX0usiWrvUvvMBLQt8quBcs8eWgKMAsuGIbmw1bStSZFyVwCYURy9hQSXBbHFYsObZSvqcohAaG3ta502ajlLij/JjPWCcjTpMazf/ncthgQQ3xZK96GWheXzkkkRxg/QDwWbPDAt5g0tm2y7bDRRA0uZAUJ9p3VQKQbH7UiwtboLqcwZHRONP5VCx06v0oTHFlX1O+sh7pZXBRivCRc3595tV0jF+iwHytT1co2v7vThfHF9YCO35MN4E7/H7Y4Lp5Mpf8Ej7IIrhxceVHWmGC63UXOqml08uf2wBNkm71gp/O9N4vxyVSTRHNh194u8XqXh26cz125B3nztfUfAOBQo+WCzM4nXGRGfMHMPpMco8MjFSZpGzRjL3kCio00mcCwoiiJAnFCa1xOIMe9BG/OhknMUWx56zwSEhcz/fDokGtjnJ9nMmF1SOGnt8sqhWvhl88MWhUpou031J89MsGADgYQr80WBq5UOtFwQAtDizQMG7OVBVDT2X0GxsOC8SIqr7Ew137UQTHK4cZ5avlqzlyd2IZdW+ES/o5HSlX2+UIrFnOVv2ZPshx7eHAcLIExldYj2F6qXmgc4IcO778eHUC1fl7rtYUz89ogEKQl+M6YGHnxDX7gnl6ZFdouMOGEmq69541YvftjQ37/slV+rT/PyjjFWrgPF8F1+7Ho1599ljdYpxsmLX1rJqCXv9bi/MXd8Wb72RADLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(33656002)(38070700005)(2906002)(122000001)(86362001)(8936002)(5660300002)(55016003)(7416002)(41300700001)(52536014)(83380400001)(82960400001)(38100700002)(54906003)(110136005)(53546011)(6506007)(478600001)(8676002)(4326008)(66476007)(7696005)(71200400001)(66556008)(64756008)(76116006)(66946007)(66446008)(316002)(9686003)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I0zl/4SUESfw8UJEsJTEfLm+d7jjn0gUgqQUziJGovutpvgp3TRbh+1q0p0D?=
 =?us-ascii?Q?x4gALikWl8qJbhFGM/ozIVlujAjXqlVye1yU6zzqcD4lG7R6bQBhnFxxhCfU?=
 =?us-ascii?Q?3PjuXCYffNlLOQhzM85YVlT4LetnYK7s7I0O/i08XTWaJJI4Few+V6Cl0H3p?=
 =?us-ascii?Q?zVXzQcTNjmfw+wvHwtfZ3nmVcQRgUvbHzPIDG6v3O/HEPlMzhx3fYtPQpmJE?=
 =?us-ascii?Q?05S/lUuFv/7PEXAHqSrmnExpDwblvBuZC3bneUS3pV0WGhVOk+qV3bn33ssS?=
 =?us-ascii?Q?epWCcjmBdekpd/EP34UlQhpFfwDahw1BwbNow+pyKvdWL7Qa5hVnK+pvSYbR?=
 =?us-ascii?Q?OU9lb4NzCf3YG16GSHih6I0I5m6bIBnB4rcjDqkzHQXzMd/KRpG24RyInITS?=
 =?us-ascii?Q?yLXEzFEP03HG2/ndKPEpi1gZU+OcE0QwtxYPWOjwYuc4J0YG1t8Ruhb6ut9v?=
 =?us-ascii?Q?UvWpJikUK0Q/YEkcwRYIWSPC3ZLcA2l2HrsYBYP89BzuZxh3Z5XvinXHdMxX?=
 =?us-ascii?Q?PF/uN9M4+LtMhZIXIZR5g0e6gFY+fV0pWQymEho4UJCD2JF93SNjUBcZd0VR?=
 =?us-ascii?Q?EEK2p9Iv+dQsmbqe2TFEE4hBNyEzdfZnfMjDpcaAeekfvh0zOTIalP/ymMDp?=
 =?us-ascii?Q?zRAyrc0yVKvpgmcZBFdBOls3Me82aOuSsBmqBKZmwsniU1YpeVm4PC1rlLQ1?=
 =?us-ascii?Q?34Bj6RWMxQBl3c07XQy9V5ssCICvO8dRFIhvv/pdFBFZ4wSvqlJL+njvPUGh?=
 =?us-ascii?Q?jt/+ko1ieveT7D0ssIc2+2rqYFjDv8eTdHaHvHlVRZ7B2Wp/IfvXwJg6rREQ?=
 =?us-ascii?Q?VbTClm9n3SvXOv+JbVeufRFFLkLLe/TaaAgMvFqcfgb/JlCsx0SXfpLKCrc7?=
 =?us-ascii?Q?NAdg5y9Ux4v6IZtfdO3VjatuPGvmaAtgO+P3lqXgfdGFXVQy3aWhBslOu+2+?=
 =?us-ascii?Q?VMxvzFZTrF/VzDGYC7+QUcEBAwVesNWjco9BwCZ9mGQvYcWIYQTaAHyB17hB?=
 =?us-ascii?Q?NoGMQ79O/JaSReYyIYnjQ7mYZZC7rZiwsu0lB8MHcIfNZ3be2V8jBLKaVm6j?=
 =?us-ascii?Q?kLepVSGQKg+ku22SIYiVLZ0CojJqg3HzkP9KFVu8Lq1RMsVEuEnmjF+5/2es?=
 =?us-ascii?Q?YhioD8fMWr2CcanlHxN6IsFcUBGPtbt+e+Wst9C0YL0J28y1Lby+H/Sp2HhP?=
 =?us-ascii?Q?r1aWo/z8/H3sAe4LOrYP+syjPUams2SptsbDyiWzVptEfVA0Ja9HfYGHE50q?=
 =?us-ascii?Q?iBjiEt6doPWcNObvidCi1bD86CH1yaQV2MmHFMcPMnVMTgiymr109UVCBJlp?=
 =?us-ascii?Q?vV/AlAwM7dtJUSAGP4/tJ+Hu5PF/cuK/XqDagNLzy/WIEOfsIiUtlCxBdYX4?=
 =?us-ascii?Q?edYYy1nWn7bNbC+/kWGREHpdPh91rdU6BtUa3/ac2Px38MvyxXxEFimADSsQ?=
 =?us-ascii?Q?JegC1Dp8YyuJbXfH1GjxUR0caYk34awbsySGsM7O23HfdwY1qMvs8PdK8wrw?=
 =?us-ascii?Q?g0dcqlVhNrh/D+zvGVQ2HUKX6+yGcJZzIE8H14NeIBbTjfwH/gzyqbxfo/1A?=
 =?us-ascii?Q?7xVlo0wh8ZMUGaWeAE0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d1c415-fb2a-4b57-3052-08daf59d4731
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 19:35:07.8798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ftV4HVOF5FN5/AvWi5PhLxzXeGlfaA2KJjbMXiiTcEyMq5et16SXZV+FLnh9S3p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1667
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: n1fi6m9g53a2pW-o5F9hxM17R2ZKk6A_
X-Proofpoint-GUID: n1fi6m9g53a2pW-o5F9hxM17R2ZKk6A_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130132
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
> Sent: Thursday, January 12, 2023 8:38 PM
> To: Eric Biggers <ebiggers@kernel.org>
> Cc: Elliott, Robert (Servers) <elliott@hpe.com>; davem@davemloft.net;
> Jason@zx2c4.com; ardb@kernel.org; ap420073@gmail.com;
> David.Laight@aculab.com; tim.c.chen@linux.intel.com; peter@n8pjl.ca;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; linux-crypto@vger.kernel.org; x86@kernel.org=
;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 03/13] crypto: x86/sha - yield FPU context during lon=
g
> loops
>=20
> On Fri, Jan 13, 2023 at 10:36:08AM +0800, Herbert Xu wrote:
> >
> > Perhaps we should just convert any users that trigger these warnings
> > over to ahash? The shash interface was never meant to process large
> > amounts of data anyway.
>=20
> We could even add some length checks in shash to ensure that
> all large updates fail with a big bright warning once the existing
> users have been converted.

The call trace that triggered this whole topic was checking module
signatures during boot (thousands of files totaling 2.4 GB):
[   29.729849]  ? sha512_finup.part.0+0x1de/0x230 [sha512_ssse3]
[   29.729851]  ? pkcs7_digest+0xaf/0x1f0
[   29.729854]  ? pkcs7_verify+0x61/0x540
[   29.729856]  ? verify_pkcs7_message_sig+0x4a/0xe0
[   29.729859]  ? pkcs7_parse_message+0x174/0x1b0
[   29.729861]  ? verify_pkcs7_signature+0x4c/0x80
[   29.729862]  ? mod_verify_sig+0x74/0x90
[   29.729867]  ? module_sig_check+0x87/0xd0
[   29.729868]  ? load_module+0x4e/0x1fc0
[   29.729871]  ? xfs_file_read_iter+0x70/0xe0 [xfs]
[   29.729955]  ? __kernel_read+0x118/0x290
[   29.729959]  ? ima_post_read_file+0xac/0xc0
[   29.729962]  ? kernel_read_file+0x211/0x2a0
[   29.729965]  ? __do_sys_finit_module+0x93/0xf0

pkcs_digest() uses shash like this:
        /* Allocate the hashing algorithm we're going to need and find out =
how
         * big the hash operational data will be.
         */
        tfm =3D crypto_alloc_shash(sinfo->sig->hash_algo, 0, 0);
        if (IS_ERR(tfm))
                return (PTR_ERR(tfm) =3D=3D -ENOENT) ? -ENOPKG : PTR_ERR(tf=
m);

        desc_size =3D crypto_shash_descsize(tfm) + sizeof(*desc);
        sig->digest_size =3D crypto_shash_digestsize(tfm);

        ret =3D -ENOMEM;
        sig->digest =3D kmalloc(sig->digest_size, GFP_KERNEL);
        if (!sig->digest)
                goto error_no_desc;

        desc =3D kzalloc(desc_size, GFP_KERNEL);
        if (!desc)
                goto error_no_desc;

        desc->tfm   =3D tfm;

        /* Digest the message [RFC2315 9.3] */
        ret =3D crypto_shash_digest(desc, pkcs7->data, pkcs7->data_len,
                                  sig->digest);
        if (ret < 0)
                goto error;
        pr_devel("MsgDigest =3D [%*ph]\n", 8, sig->digest);

There is a crypto_ahash_digest() available. Interestingly, the number of
users of each one happens to be identical:
    $ grep -Er --include '*.[chS]' "crypto_shash_digest\(" | wc -l
    37
    $ grep -Er --include '*.[chS]' "crypto_ahash_digest\(" | wc -l
    37


