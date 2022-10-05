Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191AD5F580D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJEQLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJEQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:10:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF487CB58
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciuo0NNosZ95mcX8KKCTil6VNyq7HZrsT6LxQ5m3TbTtPnwcSjaSr5Qh986ywvXjxC57ucUlf/74aIsrwnM2dzgfPx08/eW3aHHFuaSKt4E3+6KdnTpXAYyN2zEdKANA/ekbG5pIAr8ek7Buvg5QYl3TAp4XGz6M4bT1dgKA7XSWKtWp+lI1smoYJMch9t8jQInr5LCrZJQt8TGKPk4Q+VE1QpY1Xobh5fVQ9VUsLCWaWBzls2Sw4bF6uQrX69eBW/Uo+cdt5bVNLMVDJAcVvuDGSm/QP0PTvcVhDQms4IIExX5ZrGMniupk16cC56x92jeAd49uuu/exK1oId1vow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lbocmqso65Nm61naEJ91gjCoUGy51y3HBaL4ntgDaE=;
 b=UWIhXAa21xvns7JBNbxUgqjTeceHjEX41g/eFvYiFpWAzkmiNOhe1Ea68EORsgF7sypb+W+B4IjU2muWyGGOQQAD0HXbtW1YW1llMcysdH5JJXEMyca0uL0T/xV30jJxziF4wmIm8bifSG+L6vovsEh40nBi4VkBROs3ZN1URdPlfAu/dc0BRkMec4l5QbB6GyIX4Lq3acvcwNRAnvslJyCq4TovakAE0nGQmUMKL9Bkf2bl82mu6n0EeNzzwk5rzamyvn4tDGsSi9USeK6vB0rIiDcjcG3Tr9DBwEeS0mACw9qeCryoPJM4f0DtoeBoBuBPnQsFKzd+nNnsU3whqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lbocmqso65Nm61naEJ91gjCoUGy51y3HBaL4ntgDaE=;
 b=hxwvQVxGbAE8MNQPTCQa7NABQfZNKUCndfi37063JOUiF1SEUso2kEefXbHNOEdO6EXqo5lJPmFFvEW9FGC23mwuUbXrhzQ03EoxNBOrkVHQm5dXz1/9rVZe1ik1uw90dR0/fyMufoop+SqTyqlw1UZ3Fp+tcYHEyfbwZc3PLJ4=
Received: from BN7PR07MB4195.namprd07.prod.outlook.com (2603:10b6:406:b1::33)
 by DM5PR07MB3131.namprd07.prod.outlook.com (2603:10b6:3:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 16:10:44 +0000
Received: from BN7PR07MB4195.namprd07.prod.outlook.com
 ([fe80::c50d:50af:a2a0:b08a]) by BN7PR07MB4195.namprd07.prod.outlook.com
 ([fe80::c50d:50af:a2a0:b08a%3]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 16:10:44 +0000
From:   Brent Pappas <pappasbrent@Knights.ucf.edu>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: most: net: Replace macros HB and LB with static
 inline functions
Thread-Topic: [PATCH] staging: most: net: Replace macros HB and LB with static
 inline functions
Thread-Index: AQHY2NCS+bpUHPbVE0O7eKPldm0pFw==
Date:   Wed, 5 Oct 2022 16:10:44 +0000
Message-ID: <BN7PR07MB419563C5B405ED4082D7841DF65D9@BN7PR07MB4195.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR07MB4195:EE_|DM5PR07MB3131:EE_
x-ms-office365-filtering-correlation-id: b3f2ab11-4898-4a1d-7a3f-08daa6ec2869
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d1tZUuvkLLB3xwI6XyBewzOgb83ptlCCGGtc6Bxff764LXtd6vNZes/Wf/ZOOLjLIN4N/Vern/UhI6RoXmdQNLu8EB6dWmPcCwa+lXj8RyIbjuyfgrmnqt7Z+K+hBulTOk8f7rE549y3SVgS5dViibjVaxgl6m3UFG3VDOpCP8Meq0lYZ93cLk3UPpiuG0ZUCLaFa4kvoyV8KjtwBHF0vkyKSp4H4s0RcRuVo2DuhxowRWx0mI8AytdNjTRDbxAMzXqMJSewMFiLW0fxAxtDy4Gl9NRCFi8lfT39T7icNFTMVrJHpdpm2K0klHwY1Pz9T4Uj9WLfu+uuhCPTFVzUzYgjYdSinsR8OFkZHaQVc+7AMw28dr1ON+BRGcwtB/zMrYQWiudkoe68Jlo3wz5rCAft+Au3cFjlrBm/O3NOYfNwulAPMun7vxiYPKs66mxdBprwssRfufFcvIX6X0C/7a2toFXUXG2hVMVcGvhNTapLiEIS3aQW9URww+pMi+YtjpECJHSsUQG/bG9abzESsl9Qucrk+GeJlnzM+vYhTpUnuMGch+3xL5+TH5TRHiAdkmoWemkV63LKvMOOXMuP0/sO5qIpq0IFwTKDumfsuFOrsYciX2WMWso9/WiZ8oVHV3IW64WLQbcOG/lqvgqzqu+Z4SzF3pkwqRRkDHOR11vV9Lh30WGWsn//JbIESF+lzVXorQrRCU2msZXFXF5tAUhgDBzcDYvuHdPDELGBsB+wZTvJpAlbK3XL5QqVs+4y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR07MB4195.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(4744005)(5660300002)(122000001)(41320700001)(38100700002)(75432002)(55016003)(38070700005)(52536014)(8936002)(86362001)(33656002)(478600001)(71200400001)(7696005)(6506007)(66946007)(66476007)(66556008)(64756008)(8676002)(4326008)(66446008)(91956017)(76116006)(786003)(316002)(6916009)(54906003)(2906002)(41300700001)(26005)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NuxUC8Vj3YBLjsWY5QrUc/6/Z+T8f7BjW58JnlEQKvIJPsQU9gfDBkGch8?=
 =?iso-8859-1?Q?AWKZ+QJ+g4i2XsNPdj5KzTjA4+Q3R6qXPMa+dqO8XH2kap/LhYO7HVpY1x?=
 =?iso-8859-1?Q?ffEDE0vIdxnXyb6N0Q68+dyduedqLkrdzdAY+u71ZNDCVqlCErfFO8o+LW?=
 =?iso-8859-1?Q?vMe4ped8NFSvl6RVu/FJTU7KZpqIHfJoRR+mHP247tQlW+Win9uuHRI5TQ?=
 =?iso-8859-1?Q?TJItxDCwWOBr7wjc43uSi3StKsIgC9ET6Ie+DLyVycxbynvzQnAp9mmkBp?=
 =?iso-8859-1?Q?PndAp15wcT7esoyIZjGzphewMq6jFgBgsnfWe5IG+cnzDQqL2b1D38ekVX?=
 =?iso-8859-1?Q?VYzSAxKbG6O1xrVh2XrcIEab4R0jQXrT1JwYFHk3DJOLu7NZcxZZUfDc6s?=
 =?iso-8859-1?Q?vHXM1JSCW88RPZp2xjXYECIQXWDSz1KRNwHqkttY4HIfMPlCS7SJfr4UAI?=
 =?iso-8859-1?Q?m3cJFzwZTpYf9cxPzblpvGEafni//kKPRlNzejOrCBBoC3Cus8MrJR0qj6?=
 =?iso-8859-1?Q?3c1Zf7WCIp4DvgdzSkvrHsN92HjIEJYly1BgDX2sHHDIpuyge7ghsfZ7xO?=
 =?iso-8859-1?Q?xc7EpjWVt7soR0CrGxR3ug1CTiZmv76LNGHfDb+fOUCVhSIVuy8KyXwUp9?=
 =?iso-8859-1?Q?xjuPS7odlSMDppeZObLdZhUUJfAPDyvpVQRXU/M/30AHoa/AGHrdCYUZev?=
 =?iso-8859-1?Q?VIJszwR/tLvrPzLym7mMNo2eQI5guqSwGoDKbrp5xceJSHE2C6dOTKFpBl?=
 =?iso-8859-1?Q?p8XZ0jAktD4XBGOdToB5tf3EMq74WlVIsN/7gHqTatNcTFo1de0YehMxRH?=
 =?iso-8859-1?Q?J56TaZdSDWxyGBRXH1zRBw4z+wIvoTqsrsg4686FWvVtknCR572OctPf3O?=
 =?iso-8859-1?Q?CmJQvvCGnM9ILfrTv/REArx4vciIEGVZgz1v1b6z+xQS95nPWyIwUWVMo2?=
 =?iso-8859-1?Q?fv6Rl7AgBQstaNU68zMbv8MR/1IEoVUWlGV6MJ79I5hiQr1aVwJGqkXNhw?=
 =?iso-8859-1?Q?Zx8njwuZNl86QdVfr93R2AVW8apG+Xd7MxeckQzLDk6NVpJcHpSWzGnNp5?=
 =?iso-8859-1?Q?fzY2xfeInxcLQPEZp7K1HyPxxkSysMYw1hjgxIzflmthMklGfRA2CsJc41?=
 =?iso-8859-1?Q?f1zviLZYu2mtWmBbNBQFU6T61GJ29QWXJMxR2kFIKA25CvwOhputShBQsj?=
 =?iso-8859-1?Q?ddtX3Whaclb8KQsbUB3vX1Mt3pY7JyacHFsbP+KU4Pf1POSOuzNLirW6mL?=
 =?iso-8859-1?Q?pZM/3/Gxrbsi5U66E8KNi0p454xhCaGpTC+cLjjxwqz77aZP8jP7j7VlNn?=
 =?iso-8859-1?Q?eq+g+2coeJ01Wv8AyICI4UFJrusmR/VbpZR4+fIszlKbcTC5QxExlNLHri?=
 =?iso-8859-1?Q?sWeTyrgUaS0VmP9T0kuaii8OhBMjntrngZiVxzhZFYR1h1WKNHtQqAqpYB?=
 =?iso-8859-1?Q?tbiUs88RndOOyzG8iFiTugleET/4MiV3QMErh96FnCUkvozL9H5WOjaYh3?=
 =?iso-8859-1?Q?t77Npq6l1Ea5tF/oWfW+H4HxeBHUaisYtVCendWML/Qc0A2ZahTTFBKMLt?=
 =?iso-8859-1?Q?U2RBKe6cGK7FNnwDn5DRsW/WRxFkNjaIvdOyvhIQwMrmsTK1dV5j6Xz6oI?=
 =?iso-8859-1?Q?7oijO8QNbi57aW8WPk1DX4vq3Rfl1F5H03?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR07MB4195.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f2ab11-4898-4a1d-7a3f-08daa6ec2869
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 16:10:44.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trNJ7FDoD9oNjd9td3xz8rzCsRGZIOdBVtxjzFBJjj6Z88aUn4IUQbHgNNk68xzQMP3IUYq3WR0zNBpsbG61O36KUvdvIe9M58b8pvS8aHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3131
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace function-like macros "HB" and "LB" with static inline functions=0A=
to comply with preferred Linux coding style standards.=0A=
=0A=
Signed-off-by: Brent Pappas <pappasbrent@knights.ucf.edu>=0A=
---=0A=
diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.=
c=0A=
index 1d1fe8bff7ee..8a8fbc274b73 100644=0A=
--- a/drivers/staging/most/net/net.c=0A=
+++ b/drivers/staging/most/net/net.c=0A=
@@ -36,8 +36,8 @@=0A=
 #define PMS_TELID_MASK         0x0F=0A=
 #define PMS_TELID_SHIFT                4=0A=
 =0A=
-#define HB(value)              ((u8)((u16)(value) >> 8))=0A=
-#define LB(value)              ((u8)(value))=0A=
+static inline u8 HB(unsigned int value)                { return ((u8)((u16=
)(value) >> 8)); }=0A=
+static inline u8 LB(unsigned int value)                { return ((u8)(valu=
e)); }=0A=
 =0A=
 #define EXTRACT_BIT_SET(bitset_name, value) \=0A=
        (((value) >> bitset_name##_SHIFT) & bitset_name##_MASK)=
