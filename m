Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9671595A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjE3JFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjE3JFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:05:51 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F3CD
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxZUwDM+qZBZBlkLT/SwY9HR4oBdsAhLyDYIJj0JpPzzcjPPHAiSIkAoe4drlvPiP4w7gP+tfIRYwlsb4dOPf0wY5GcQaBD0LZowaTNyiZs2FUcN7eBAlfwJZ1x3EFYMJsnFiM46qBvtK4RcEfpxeujFPv8iagtqkZzPj7WjNnecdouz+t2T1UQasio5tdRkNYvoFO/jU5Gd48hd8Czsab9bcWPdvQ6oq8mwSSSFpKTgaylJR9BEkZ4F2lPYbbp0CDYqOXCEJkwlSYUbw9690RC9UBmnjnZuEa2mbZEmi3uklbxByb60YBpCFMl3ig7lb8cSa7okT3A+YsKKlviMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gl0mjcuRzrnNyjXHsdRlBr34HsNSY/Hc1BV1JvK1FM=;
 b=GETUAmVSH7sAmFyfYtQfO0ZKfacT5qQeSdOXqFlc9l6yZsY3SKqZ0USucd10MnOkyoCAs30oLADyWMpzfXz8qhPGCgMVjz2RGAGp9pV24EGVgZfhA3bIliv+I7IYwi1oNSmSlKEGvOBEzDg7Zani3+lf2Dt4LH4Yob4bYXa8e34CeKc7tbz553w5kyGlUq0u1l8NSy8ogRRI75NB9iyF40q0g41q7tzr+Rs29j/ABALwmxtS3e7dsmJLjfgh4h/nNcWGrZMZdRA3+DzF4o2jMiKVBiXYtH7lPiqiJOTPtVQirVervW16Q6gzk9FOBttEw/wUnhViiUaV6egGGo5DMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gl0mjcuRzrnNyjXHsdRlBr34HsNSY/Hc1BV1JvK1FM=;
 b=QffkInZs6rzto7uEJXjnKrX1JFJdFrrM7RZDvpPbQ0dLoZx59qfk2Emggfb431a2WR+r8G7/Upots7HUjdNo4K9v/IQN0FPEVZdWCyjsoLD9e4P0VEgsakEMFaojGYhikdqFwL7eNj5YT/2Ff4i6CZUwd8ynPgiCS7W5XecDKp4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:05:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 09:05:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V4 1/2] soc: imx: Correct i.MX8MP soc device
Thread-Topic: [PATCH V4 1/2] soc: imx: Correct i.MX8MP soc device
Thread-Index: AQHZkd4qgHr/ckH1Z0ej5JIm8+Wk6q9yd3eAgAAP6yA=
Date:   Tue, 30 May 2023 09:05:46 +0000
Message-ID: <DU0PR04MB94176DAD895FEB66FDF23B9B884B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230529033710.4098568-1-peng.fan@oss.nxp.com>
 <04a3e224-3f06-47e9-54ca-44a0c4d5759c@prevas.dk>
In-Reply-To: <04a3e224-3f06-47e9-54ca-44a0c4d5759c@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB7119:EE_
x-ms-office365-filtering-correlation-id: 61d6b372-1142-47d1-9c4b-08db60ed0e6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GiHBtXShGzyEbaEm6r6nFCxb0VF6s6SLaYVOglnw9WVyFXeoiHXYkMbn3Fx32VjZR98X8FsmiYX91eqGxAJNNkdz+Cyf9qdPvxQrigRb+4jIeCv/eMMUyxyTQlXcgc1kYIyy9ZQS9VLPceniTJu3NNe710RxLh7rhY/bZl3zkpfNtxzcMbXNABuubo8egUcLMzR62inVKgtG3tB+O/SUev0Dl6zNLTUeaeUIlLEKUzBgX8xLBMm4DxeXc+Ch51BHLA/iHBOIWVznJI18yMnV3JpUwhPz2heNi0Vse/K9MDdBftIwVC5O6bJV6FS4cXDE6MCyfUrPjOU63Dp0wQCJK4FGmhJZBtlGs6YSpYIN12zuFy9x6HnluvfM+202IqSd5F6A4r7UgrD8ATZijIH1TgA9j00rWIvCBK9T2Ir1ZOJdRK++HAQbMdqBFIcp3zaTYQ069K7tbrZEfqZ2w+J3jessQNGpW7vZvSLyPS7LWG/1caqG/Ak6R/fF+DEbBcmDwPW9ntRcpcse/tEim+GtpsHTK9t6Wgh5aFgorPenYdUeJlV82LaxI3XXPjZyQx0ITIU88OSnzWdskdWJPUucBcB5NKaNR/KY3b3PDpws23+SNRHj2S5kRUYryrD1niCU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(33656002)(54906003)(110136005)(478600001)(38100700002)(122000001)(45080400002)(966005)(66946007)(66556008)(71200400001)(64756008)(66446008)(66476007)(76116006)(7696005)(41300700001)(52536014)(8676002)(8936002)(5660300002)(86362001)(44832011)(26005)(2906002)(55016003)(186003)(6506007)(9686003)(83380400001)(38070700005)(4326008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XIqRcPhOCQogvrB73i/3rGGDl8M2BhYA6/h+CQ1eh2n3V0TAQhUr5LtB9wOI?=
 =?us-ascii?Q?KfaGMaUwQeZ+8n7+nsIPxNyebukerEPVkZwZxxqcsy9+n4WJat+w3krKc11C?=
 =?us-ascii?Q?1Vf1BSUMP8sPT418dEGmDODn9PYNS1MzhUDaMDtAC9uJf0wtj85uTf1h0TAb?=
 =?us-ascii?Q?/y0p/otRyGs2XlqKIoCk6OUk8sGom+YbD1WNeIt+1u0MtMHoLztgVYUo0ACQ?=
 =?us-ascii?Q?wdwW8TVYhDO0QKVFB5aIZ8NPEE1xt+I5IdldNsqCIMTFCuPe2BNkO/ySDmma?=
 =?us-ascii?Q?iQcxRPcRfBvu05MAZSDNrrcTo7FGH9MvYHHermHOcvMleCG9X6WKtx07cOpD?=
 =?us-ascii?Q?oC91NS0IWpzXoqbfIXOHAnzM29J9tf6l9Srj5uE8CMsLN3UIclcGfPGJMq95?=
 =?us-ascii?Q?1RBEdEHUxfdpAe1gWAcvcizkqAW9BfFVBxvsa2cDd7xYgT/+bZCNi6Nr2tMY?=
 =?us-ascii?Q?JfARZVxU7nUc/70fCtJvV0IXzyN/HI2K3rutYVd490qC3I0jM5HEIWkXwCMF?=
 =?us-ascii?Q?USSStc+KjZK/iNrMbH7OyYvMW5gyNVxC/iJ/ev6TGxT3WXWZDpOusROu/sF2?=
 =?us-ascii?Q?yMd8qWqIHV5WehATJ+u3u3A9PNi5TRzIIT9MHmc6Jl4f/NU7VYbTtax0j/wx?=
 =?us-ascii?Q?vYyaUHRD3+JfDOM0cBh84JZ+e9HXNXzDEpXjpowKXCJnKIiXsGEQyzTYopjI?=
 =?us-ascii?Q?BSEqaynQOEYPuCcP18psA162DPsPj+/ir4L60BtnTW0PPhJT28yWK+SaPdjC?=
 =?us-ascii?Q?uTzbreuLN/lJ8UgNeT2b+IK+y2M7F0z2cq+RGTkXS1PUCey9kOGbKYr0ljFX?=
 =?us-ascii?Q?WpMMYl/3nj6nVSpQj8oNqhPGqFpPpX9GpA+dpBnmmozN9Ukshko+4vEwnZTm?=
 =?us-ascii?Q?Cy4I8pXaiZ2TXutv3MqynzoH1MeuREkPznXn5m1+S1TatEiHyw3slf0do2lx?=
 =?us-ascii?Q?tZZPG3SHurY7xKtj1cZjhrPTRBAwvGdO0F8EXLBxxWRovHjbkpL4FaWZi3XU?=
 =?us-ascii?Q?AgvsBWfVneTw97cq9yoTI4mG4ewMlY3NRnWnNqp/8L0GSz20qThtAy6EjDOT?=
 =?us-ascii?Q?1B08DWuzBwKhO8XWFbzG38ovfduNr0uZNotIyJm18FzIrSpPOm3OO8cUwM9f?=
 =?us-ascii?Q?YMIWO7l0E1bBvoIFEbY4EZwCzx5lxKW5qZiI2H5x2AVa3uDtBWxmB7oPDDbQ?=
 =?us-ascii?Q?cHvRuvPq0MgW2/3CKGQVOr3RY8KNrctpVmzyk0YMxaGXlrw4Mb7kr323feib?=
 =?us-ascii?Q?wRrMRs982kAlP1oKgyPkSIMgd+6Zny8KAGTDU73mTGHfd7kp9Aa60PapFeu6?=
 =?us-ascii?Q?tpRN230S674b9Beek3nK5LPIFzaJnwS1K0TanEYDSfSTDpHWTuGpXiXOEpfS?=
 =?us-ascii?Q?kO/zO/EPJIusCnk44/EdgCuDhr2x9shBz3jYO0E2ljEwDcqem/C70gEGjXIt?=
 =?us-ascii?Q?bWbWUMPFeZiG9lhznUwZA4G0rcs8aqRXg03f8bamJXvoHssaqdD+JihBjp3N?=
 =?us-ascii?Q?u4nC79/wr0GftDGHTh44RwalIoHoO/3oHhMz6k1ER0h5OMOPmWrS8GmZz/+q?=
 =?us-ascii?Q?EMTemK5k3wGUjxNkzk0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d6b372-1142-47d1-9c4b-08db60ed0e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 09:05:46.8292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9E/1rZ3M4YJyDHtJgpMy2ZSDoJ+9MDW6FVigvBBW2atOTWLYwRBrZ9U6KVIQtuPoHgp/JqLenQBXBCJ5ny+JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V4 1/2] soc: imx: Correct i.MX8MP soc device
>=20
> On 29/05/2023 05.37, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8MP UID is actually 128bits and partitioned into two parts, with
> > 1st 64bits at 0x410 and 0x420, with 2nd 64bits at 0xE00 and 0xE10.
> >
> > So introduce soc_uid_h for the higher 64bits
>=20
> Interestingly, reaching out to our NXP sales rep asking for clarification
> resulted in:
>=20
>   On i.MX 8MP Unique ID is 64 bits. Please see here:
>=20
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Fnxp-imx%2Fuboot-
> imx%2Fblob%2Flf_v2022.04%2Farch%2Farm%2Fmach-
> imx%2Fimx8m%2Fsoc.c%23L752&data=3D05%7C01%7Cpeng.fan%40nxp.com
> %7Cc6ca2761f8144f3f78d008db60e4bfe0%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C638210307846757073%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000%7C%7C%7C&sdata=3DLTdrBwhNesEEfrcvmw0zV0hA08SbX6ZMI
> qPppwWQ5nk%3D&reserved=3D0

U-Boot only supports 64bits for now.
struct tag_serialnr {
        u32 low;
        u32 high;
};

>=20
> So could you guys (and here I'm referring to everybody with an @nxp.com
> email) internally _please_ talk to each other and figure out what's what.
>=20
> And, again assuming that the UID is really 128 bits, nobody has yet
> answered why the upper 64 bits are not locked down, nor what
> would/could happen if the end user/customer modifies those bits.
>=20
> > Fixes: 18f662a73862 ("soc: imx: Add i.MX8MP SoC driver support")
> > Reported-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>=20
> That's true.
>=20
> > Closes:
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore
> > .kernel.org%2Fall%2Ffe5e2b36-6a8e-656c-a4a6-
> 13a47f4871af%40prevas.dk%2
> >
> F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7Cc6ca2761f8144f3f78d008db
> 60e4bfe0
> > %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63821030784675
> 7073%7CUnk
> >
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I
> k1haWw
> >
> iLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DFqgRvctzHuImX8tFkF3zasB
> mnyG0Uc12
> > fA38i0Pxwus%3D&reserved=3D0
>=20
> Not at all. We (anybody outside nxp.com, and from what I can tell, probab=
ly
> quite a few people inside) still lack a complete explanation for this who=
le
> mess - why does the RM say one thing, which gets repeated by NXP
> TechSupport in a community forum, while a sales representative asserts
> that the current code (in both mainline and downstream linux and
> u-boot) is correct, and now you claim that in fact the current code is no=
t
> correct.

What I checked was just RM and fuse map.

Let me try to reach to the lead of the i.MX8MP project and back if any
information.

Regards,
Peng.

>=20
> Rasmus

