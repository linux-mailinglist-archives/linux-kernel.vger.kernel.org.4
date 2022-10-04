Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35B35F49DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJDTt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJDTtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:49:24 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE986AEB8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVR1NyHrAnkzHQgO412hLALM+FVUZEWWl6iKan/4Dr0FvpdrCtBZ21HYh7Jwl4H7qPOeqZE3NW9OyJ/mIXlZXzhILvcJ8KdL9lpQbpFZtAZFmfXwG8b/CT2C72t1dHlx/W3U40bMLhSHaVF8GzQrxUm3YOqzQ8IbsCU/iQypDogvJOxDbjfu06gHa4gX5AIIyP6/p/oc2A+4SBYCwRzPNBBpkkI6VZoeLyqyO/i5ltF3ejponbCrWcpz3dqcqTZbeUGJSvIfQdxEETa/4sFsf0YXXqpsa+vRUiUxe/fuW3PhZxxMQRfcBcydgEvU18zfWCOSbT0cXs4xr/NzqEUzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plBrsmyr4RlAxGC1MGpnEr2uEk9xCKfQoMNFzsduGc8=;
 b=f3oA/Iz0DsoIUdXWwJNMNNGYBBMq1AjXvL3BEEgmH+dKKsCgJyxTvKrzExMM/HDtRRZGQ95dTsm0H8q110WKN1IGGevDrtzQwqt4kx0YfnKNNR+3gTB0vfQ5zRPtHdvg5u5svdF/VrCZxZ5HKvn1WjtMMk7ZSdgXASv7NNLPjSMMfo4FLhIU1URbhnexvnmpg7vGect8l7LpMqfRsIJiFbsYyo8JEiDHsECNezsnFHN8A3mBBlrcfucDgZ7wqHeKrZfsExxHjC6E9ttS0JHjX961Kwhy1C1NikStDd0hw8MwpSzVOY2YuBJw1HPMoiZCJWCVliuPbZyehaQnVZw2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plBrsmyr4RlAxGC1MGpnEr2uEk9xCKfQoMNFzsduGc8=;
 b=McFYYgL9imGoRpYIMqfZ1GnQpfu0WDlxeoHTDk0nORpFwuk+vmuOWf+1zcMhDyjW28mDOrdrBKJXaP7Q63eDA204zA4aulIGhRs/PQ811Mh7INR+pFWtuz3JP94uaVE2dkn0JQef8L2jkROL9CXep1wLF0aFNPdm1Tp2LxGcTek=
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 by DB9PR04MB8204.eurprd04.prod.outlook.com (2603:10a6:10:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 4 Oct
 2022 19:49:20 +0000
Received: from AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90]) by AM9PR04MB8793.eurprd04.prod.outlook.com
 ([fe80::54da:4ebc:2916:de90%5]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 19:49:19 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Marc Zyngier <maz@kernel.org>,
        "Colin King (gmail)" <colin.i.king@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: irqchip: Add IMX MU MSI controller driver
Thread-Topic: [EXT] Re: irqchip: Add IMX MU MSI controller driver
Thread-Index: AQHY2CjKjfbcE3xOcUWs9M8cYBY5rK3+oxqAgAABI4A=
Date:   Tue, 4 Oct 2022 19:49:19 +0000
Message-ID: <AM9PR04MB879381782BA8387D90E75EB6885A9@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <e5992130-ce33-9377-e3f3-9bfdb240f9b8@gmail.com>
 <868rlv8jc4.wl-maz@kernel.org>
In-Reply-To: <868rlv8jc4.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8793:EE_|DB9PR04MB8204:EE_
x-ms-office365-filtering-correlation-id: eaf251b7-3538-43ef-67db-08daa641873b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUgxQD4U/Img8Y3jQ2Ok9iJiDqB/MVTXTbCDboEPDH0wgLOvfA8MLFymZiy70eF6xnBJoCbInzw6JxRrQtU2fij1DkgT29tv3UwXNu9QmT7Pu6S7+lNheqmQqbNOMtotJ7KNRycOK4gsQaYlTJHbsYDrqBfmn4mEmXAlJlEXPDfFL7xmpf2bFZiJH4lQidTHQSooOXLR6fuQx98/19EPujfBveDivE5kNFaXzCC1yO0NZfrlkFoqdr9I7G8BCviMmvQ97YsjbZU/Hm7clUczStZX0SVlsG5dFD6pf8VPr2klY6hdXSWLc7pn4nxrI4Ut+Qb/Ir45ZPEdbn8aKZgSbMB5D/P6yGJTUoNaGrl0+pAwW5GfKijPbtqbFDcpiHHOR4UYe3HBKRgDfmC1uXgFK1nrutSX7U50Hzgl+m0r37USzHmuzqkTpoTvLOppgR4+4/n4LWnYhc2a6IkHH4cW4XztzsUjQWp4+RkTJPjARZ5M8q1qjcvriOLUZCkehbQxh1QGxrsrlEtBgjyBWiqIl9Hr0g5lgX9cUm83eTeAsNjvx1v5rnQXtNk18nlHI8ASFBBQXxsZopsa/83F2vq7PnDc6z1ue1yLHwYqJBYkzc0sGJm9PYyMJ4uVXYWSIg8qQ0eTe1qR0TCuh6TTYv1EvC9YCsIszDuJkD/ov/oZWio23s+EBXekUhra/aalIsxzVtzRXXbx9ZzUYXrTFdU0YarZ+IgdMQUP5WLlS4ooDs0auya2xrI3/kBU2Rlmn/atSKj/OXHAqOzqMCO0Kuorbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8793.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(66946007)(66476007)(8676002)(76116006)(66446008)(64756008)(4326008)(8936002)(38100700002)(7696005)(122000001)(44832011)(66556008)(5660300002)(55016003)(2906002)(26005)(186003)(6506007)(33656002)(41300700001)(83380400001)(55236004)(86362001)(9686003)(53546011)(52536014)(38070700005)(110136005)(54906003)(478600001)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0BSuV4x+F4eeIPEPzodHP7JRPA8KES81gB0Gp/MNsCvabIJjhjvUUZxbaKvt?=
 =?us-ascii?Q?fZ2bqT3NUpHiuPdTMImGLESvxt9pQRxQj8KlNMvy0sokDTB6jfcqKyoiD6E8?=
 =?us-ascii?Q?lX+Vexw8jCfRvWEqWxIwij5Oj9T91u3s2bHQ0YjbI+v+BuzjN2rUDnzeoVrN?=
 =?us-ascii?Q?WvPPHZQlCoqhYVsj77IdJ4LW0fUYOjROdEBIFNRNB7IAUT1Rr1uGyrq263HH?=
 =?us-ascii?Q?Q+9tJ3+vnLPQcUIIVv57vdhbutCJZ4dU2RlgKjb3bFye1MfHlVD+vHwv+3VE?=
 =?us-ascii?Q?R/jf04JvVWRyL927g+Bgd0jMU02vdf9/IP3eRC8kqwBW7HnnvGeFyzBrQw8a?=
 =?us-ascii?Q?JkMz0AXQjHhimiWntbS2Vaz242DQ/SYKxAG5aBZA4++3DXF8hf6+QqvBbeZp?=
 =?us-ascii?Q?sG/iRuXGoOLk/TmaugHtikqD4W/AKNgs3bH5t3+Jfk3KZsVqzwVHPbFnExuG?=
 =?us-ascii?Q?d/CR85aTRjuQVmB0cNQnfMh3UKelk/0pCptA9XASLdX0zI7XXWw4RenCeqwp?=
 =?us-ascii?Q?gffYrTfnGtPC4nexvfXbTPmIM06YR8CT1YTTqM+a1DDtMrd5SQJaeWJvGuja?=
 =?us-ascii?Q?AEscU15FIuHcO2FXPTY0L8nYA84uqVb0VIQ4SH4kuB5bZYdCAhVXK7KO2aM3?=
 =?us-ascii?Q?8srovjx3WuuJjlhIRIGsZUMLR6ND1UY/C1mLvjTEXLsZAlTT5Zidc8tNwgWL?=
 =?us-ascii?Q?i8TBejedVKStqw7ChM9UJgVncya9hzRJdDS6qBb9BOZfDOE0rM/x/+ZMYOhp?=
 =?us-ascii?Q?dyCMd/6QgLFF211iz8Whyxpbm9XceSvFzuSFp8N2TW2FuKjbuwEc3uabxGe+?=
 =?us-ascii?Q?wC7hRnA+uJ//IGf8HHBlA6np5KhE8XG4T9unJp7Z/1lPGcoLB0c4Qkk1bXaZ?=
 =?us-ascii?Q?dByodj6sc7rgkE2BPnaYYUAp0QpSINObO31RLokfnp4bglbwYqrP28XI5TZ5?=
 =?us-ascii?Q?WwXvkv7JSD4AogzTrQDUwBwcxpmI3O6BT7XxJsWWd3uF4X567kFYZdB8MJB5?=
 =?us-ascii?Q?NG9TkKGWEREMhkPuWQVHaPw7C8w+CeCxKzrpEsbmGNUoj6pZx8IeLMscBVHz?=
 =?us-ascii?Q?ymT9oRrWfbXYkMi18K6EM+cj1mxe/3QJ/YTd7GHa/SJL05EyHzEjUmuQTlNW?=
 =?us-ascii?Q?DTr0W1HUM72LYOR6u85CxBlzo04ORnmUhdDFQ4uIeXbhRtaDIGElHU9j5Bul?=
 =?us-ascii?Q?qxq+6KLPlUOlXwFOT9SN96DR9VtY4DGORbhS296yDOdOyZW1nRAFu9o2DeCE?=
 =?us-ascii?Q?18ixkAEGT7jPQxIOfp6mxdrh9i2bZgmuosDYHG/i3LVfDqYkIQn4QpBLSQQP?=
 =?us-ascii?Q?dUKHEp1Ft/c1OS3yaGceipaSbw7ksNVO5bGVg0X1l0CpX6bzAguMZc8f5koh?=
 =?us-ascii?Q?13DdXSwbkkWLYkDT0s+kJJHreQkjGC6nc7V1vaxFAozgllVek0nVcokN2cXL?=
 =?us-ascii?Q?HuJ8GMAzuSaLm5XhUZrOIsYrA4/QkXLk395PYFOJwYl8Njk+weabuwaQ52bP?=
 =?us-ascii?Q?+GEwvVlO072hFbgC/xIYWitZE5BG2s1nw0j6AYkBWSG760q38mcWv9fikxq0?=
 =?us-ascii?Q?tq6ddlIOsFsjhJRzcuA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf251b7-3538-43ef-67db-08daa641873b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 19:49:19.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZ/HHLFHyD4LDNvZKJttRcqipkh5G0pzEkhXbzzWKCqKeDHZPq5Api2YymEwhEQuw7EHj1URO4CT9JdXPz+MQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Tuesday, October 4, 2022 2:44 PM
> To: Colin King (gmail) <colin.i.king@gmail.com>; Frank Li <frank.li@nxp.c=
om>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; linux-
> kernel@vger.kernel.org
> Subject: [EXT] Re: irqchip: Add IMX MU MSI controller driver
>=20
> Caution: EXT Email
>=20
> On Tue, 04 Oct 2022 20:37:46 +0100,
> "Colin King (gmail)" <colin.i.king@gmail.com> wrote:
> >
> > Hi,
> >
> > Static analysis with clang scan-build detected an issue with the
> > following commit in linux-next:
> >
> > commit 70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e
> > Author: Frank Li <Frank.Li@nxp.com>
> > Date:   Thu Sep 22 11:12:43 2022 -0500
> >
> >     irqchip: Add IMX MU MSI controller driver
> >
> > The issue is as follows in source drivers/irqchip/irq-imx-mu-msi.c :
> >
> >
> > static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp =3D {
> >         .type   =3D IMX_MU_V2,
> >         .xTR    =3D 0x200,
> >         .xRR    =3D 0x280,
> >         .xSR    =3D {
> >                         [IMX_MU_SR]  =3D 0xC,
> >                         [IMX_MU_GSR] =3D 0x118,
> >                         [IMX_MU_GSR] =3D 0x124,    /* <--- issue here *=
/
> >                         [IMX_MU_RSR] =3D 0x12C,
> >                   },
> >         .xCR    =3D {
> >                         [IMX_MU_GIER] =3D 0x110,
> >                         [IMX_MU_GCR]  =3D 0x114,
> >                         [IMX_MU_TCR]  =3D 0x120,
> >                         [IMX_MU_RCR]  =3D 0x128
> >                   },
> > };
> >
> > The .xSR object with index  IMX_MU_GSR is being set twice, once with
> > 0x118 and again with 0x128. I believe the first one should be
> > IMX_MU_TSR but w/o the datasheet I don't want to make any assumptions.
>=20
> Huh, nice catch.
>=20
> Frank, can you please provide a fix for this ASAP?
[Frank Li] Okay, will fix today.=20

>=20
> Thanks,
>=20
>         M.
>=20
> --
> Without deviation from the norm, progress is not possible.
