Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F3B704D69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjEPMHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjEPMHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:07:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D802101;
        Tue, 16 May 2023 05:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOQCClsCURwVa878O5c2JBYaIY2kM0tqbYCC2Jl1AdAX4xBT/rpYNkfbXDZMhQNlyewbnLnAus1cl2hQ++ZBqYSeVoaOGa11rid4a9McU/BcyGRztY28CkRKmVpnBjVJGSPllTizUGB10d1buSnRxEAmHL0PjSzPCCAgPxc3uCBkjLtzOK0hqSUfOflfdV3ig9Iswr1oW6Kk9gPZY/PsHjFIpv3aPeks6lr0Du9J7gb4WJDzaaKZEt6qvnuAXTAHY58FGohCIHUvqLPpOrYkq1XkEv/FzUh0zkOu074xXQGWVzrPngY5KXx9aoB3DUyChGlfafcybSWlf7B6WmDyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC2OYVg8bKCUWkXOtyEmi2QXSKFtUPxOr+55lWBjn3o=;
 b=I9DwgoEQNcfduVvwCo6HLSTBM+3+QkZjSvT9HySWrySgTFWvSqSV/MCgzv+lnnaMmb8Ls+fnUw7SdCrDFzvUYTwf4T7ZELGF+fTdRA9RZ6Y6Qwx5hSLM+gV0atXKMerg1vWds4TGDJaT+oL9FoP8+h8KmgAPHEQweQJt1ORkWB6EzJgvIjuj4oinnPcKFLakMxETNIMuvd5nu91BcxI71rF3mSijOPRmkCXDHFhzpgMcNG3zqwd0jbgR7SV89Qso+nO+FRlGIkLrSQyB/IXaVOZWJM5/M87pIK+qXsDglGjLdV2jHCCVGcelNC4K4Xx2P/VC5MDhMTj6GsPmxnQMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC2OYVg8bKCUWkXOtyEmi2QXSKFtUPxOr+55lWBjn3o=;
 b=Fb7swHNgMaR86RqQF/uRwZPHBN4YoGy65CsRaZxQPYrjkLiEL+rWe0BYeSTfthPy37X2qLsEEoxGK8i1fH9a+zj0VQZbTxIUYHkXgVPU9wM2eJoLFRi+dCWNXxrIdaJfCT5rvz7dEggc05upPLG74SeZOAJ7iTB8aUA5z3PAQ8o=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 12:07:23 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::4db:e158:60d:21e4]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::4db:e158:60d:21e4%6]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 12:07:23 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 3/3] spi: spi-imx: fix use of more than four chipselects
Thread-Topic: [PATCH 3/3] spi: spi-imx: fix use of more than four chipselects
Thread-Index: AQHZd3xKn1eSnAuz0ESi22CczVsXFK9c7cLQ
Date:   Tue, 16 May 2023 12:07:22 +0000
Message-ID: <BN7PR12MB280270590FF8B7DF27E07760DC799@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
 <20230425134527.483607-4-linux@rasmusvillemoes.dk>
In-Reply-To: <20230425134527.483607-4-linux@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|SJ2PR12MB8157:EE_
x-ms-office365-filtering-correlation-id: 0b014b1e-2fa8-449a-a4ba-08db56061b41
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0O5b0waMC1WwPsx32iiOnpvLHlEpxWD9juMKqgJGEjPO9I9FRnKR6E4Cko0tRKa69K0gACH+MZ5Wqf0efPFlUgfIQMzrex+TDM3IyMtjZmCLu+b0lXl9i0EP7/O1fWlOROYGk7jY4e1vYGR/e+AslMGIgRkBdwMFavL6/5NOdYEdOQifoBPg27E/W0M8YQSNTgqU03W/LHYLXP0Hc/Y2LWQuPQaM+cITZCttkEdfqsP4fmaf1Otwx12J50qfYe7o3FgdikLGO8Erz4fCRFBVtW1x2T+K0AJIjk4BIYICpvgao/YEZxOA3agEzmlbY08jnDbemO6n9Pr9GpP4wHl4sCFmyCTaHZ7zLvqyzmTWwgi70RxJV9n+xsUcs+jp9cEOQCuZg1T6AYYxhtBsjik++s+5muPDZd3gkFCV5/kl9bS7AkEOjywRNtn0C+iI5/3/6mg08GqZnzy7uP+LAW9ABpyLpHJBcxn4gQwkiLWqad6PKWDfAehkYHHWcNXj3Psall6Z9oh6/3Zcjm0rg1AJEYIR29ZcAZsZG5fR7EzF2meaw+BA16igZ805DF7l7mZLW6cl7NQQZiAvgDMvLSmbaKtPXFNBsn+w3ABGp+NGiUs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(6506007)(966005)(7696005)(478600001)(110136005)(54906003)(9686003)(53546011)(26005)(186003)(71200400001)(2906002)(4326008)(316002)(76116006)(66946007)(52536014)(8936002)(7416002)(66446008)(66476007)(66556008)(8676002)(41300700001)(5660300002)(55016003)(64756008)(122000001)(38100700002)(86362001)(38070700005)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nk97Z9wPfXyV0xWfrEjjNHaFFxNXArvETsMD7KSkYrzGBMW6fugM0cANgiMB?=
 =?us-ascii?Q?zPbmc8ypzj0eHvhV29E5N60KXRX4K+PnakOzVb8jxbmWJdnuK2lM5Ne1Qbly?=
 =?us-ascii?Q?xhA7jPo/YXfHsWdRsaNBjN+7oITFqhunfppvASxQQsHgPPyztD82tiSyL7x1?=
 =?us-ascii?Q?kER+vNAq86P7hz71jz/mTYvSNp2S4OPkBQ7jlZxyc/+k4KH5QYEk3KOeo610?=
 =?us-ascii?Q?xRHciFy6wf7KNk8fbshi1uExUn0lenUrIqlNCsB7NMYaUEYyShTSYwEo0mKw?=
 =?us-ascii?Q?LuzI+YrrGjgezecoplzmOCuHrxG4Jpf/WUujq88aCnCMDxDmF0CLYC6GvM+g?=
 =?us-ascii?Q?+YSSMVEKl1VD7H26lPEtS6iIfj91B5ujYnj3BausTZ3YH8wrKnzCMq+d7bKW?=
 =?us-ascii?Q?VLZ6CDGO9rZY/yla5xKNO0Vl7Y1F9mLG8Ouon1i66vEJJ1eVeDvRKw82cX/J?=
 =?us-ascii?Q?R1RzD1KPupnUKPEcGzLIuIhazbCym41eGqy5POYaTUzXs+Elt70nE6e70Cni?=
 =?us-ascii?Q?pAT7Pmegx26eEYaUFwcyEjqEWtIVk48zPbLlB5D/ByxD1GqtSgjGQKA0HQN0?=
 =?us-ascii?Q?my5vgspKI2ww36xB5N94O9ayTGk8AvDRoRiS74AbFwkO9lZABm8RqpoR85Zj?=
 =?us-ascii?Q?6v71X4pVarf8oYtVNjCq20f+jVI0SxRKLwFuNiNeQ7ULBL3Hk+IORNMM48KL?=
 =?us-ascii?Q?WpU2B4WK1+aJ8bE5gsiBks8Ow9ytZLltkNH7JJaDUY0CPnOnhywQQ4n86R9U?=
 =?us-ascii?Q?sSUtjP1QfhOl9u76PMa8ihrspwv4eZNRdCLoIPURt3GMxk9+cD2b96rIeQHH?=
 =?us-ascii?Q?YbI5dBCbmRXUAT4HOFnKdaYUwFmgXUELy4w2GAqDonMNTIpvvV3S2IdWWRgN?=
 =?us-ascii?Q?7cktW0QMlU1WrLXXQFxMtBvXOkY/FR37r8q/3Ll9J6zWfhWD5kIs+F77VJak?=
 =?us-ascii?Q?i4gv/K/PdO7t+npHslOtdjGHew9/3rS5f2jNLBJXHA781ci7L6NSJAOCJEGo?=
 =?us-ascii?Q?8uHZuawJ1uz/PkE/MHFcAQuJXk8tb+3H/gH4x/LuaNz2K7DoerP0zRz7x216?=
 =?us-ascii?Q?uokBlY4uo+0kVOE/0r+dqEUkg9JCFuH5852hEu6xthFTJ1Ys0bcWrjrJJRQr?=
 =?us-ascii?Q?/B9jqm8eLMT8/2TE8yi2L5NIeAZodPBdKCnNv41VE6CccQjeKTbThGlczQXW?=
 =?us-ascii?Q?a23z6koiGr3t6G8VB0uv/LYn2YxIhGJ5bzfYys0f4spsH+VYqH1YWvEFg2bO?=
 =?us-ascii?Q?ymJi/xi0eRyHFasKwNU2DUFJvOvUQQZlIwlyE3kZi+h4eNnREVfxf43jJKAG?=
 =?us-ascii?Q?qf1q+S+s8GPt2wem/VL1MOSPDn/VOKshck2/91dwJTfcvIyTv4SvqDBN5AMB?=
 =?us-ascii?Q?ynApEkhZO1Ps1IS1VZR11H7Zr9/MNKr324YSgGIgaHssG+Pl/iqnNLgSw+n5?=
 =?us-ascii?Q?cwN1cINGz+2Oi6ZM9CtmYzd+YCHzllOy4OLQvyAmKgfpVRQLVq1bLDsqNfPl?=
 =?us-ascii?Q?WzqHsd4cKEZQI6Ta7zYz3sneEMN5h8uMbiGBnug8Mu/018intLbiM0yBlbyc?=
 =?us-ascii?Q?1UcSCbPXlv0xyt3zZfE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b014b1e-2fa8-449a-a4ba-08db56061b41
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 12:07:22.9700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtb84jI0rTDXFkzmnEEnx9maIgBIx1AELI4aSNoZHvBgIBTPFBvTvdcpDHNNJce5ryfgotKPelhsPd7uquErsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> -----Original Message-----
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Tuesday, April 25, 2023 7:15 PM
> To: Mark Brown <broonie@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; NXP Linux
> Team <linux-imx@nxp.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; linux-spi@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 3/3] spi: spi-imx: fix use of more than four chipselects
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> Currently, the spi->chip_select is used unconditionally in code such as
>=20
>         /* set chip select to use */
>         ctrl |=3D MX51_ECSPI_CTRL_CS(spi->chip_select);
>=20
> and
>=20
>         if (spi->mode & SPI_CPHA)
>                 cfg |=3D MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
>         else
>                 cfg &=3D ~MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
>=20
> with these macros being
>=20
>         #define MX51_ECSPI_CTRL_CS(cs)          ((cs) << 18)
>         #define MX51_ECSPI_CONFIG_SCLKPHA(cs)   (1 << ((cs) +  0))
>=20
> However, the CHANNEL_SELECT field in the control register is only two bit=
s
> wide, so when spi->chip_select >=3D 4, we end up writing garbage into the
> BURST_LENGTH field. Similarly, there are only four bits in the SCLK_PHA f=
ield,
> so the code above ends up actually modifying bits in the SCLK_POL (or hig=
her)
> field.
>=20
> The scrambling of the BURST_LENGTH field itself is probably benign, since
> that is explicitly completely initialized later, in
> ->prepare_transfer.
>=20
> But, since we effectively write (spi->chip_select & 3) into the
> CHANNEL_SELECT field, that value is what the IP block then uses to determ=
ine
> which bits of the configuration register control phase, polarity etc., an=
d those
> bits are not properly initialized, so communication with the spi device
> completely fails.
>=20
> Fix this by using the ->unused_native_cs value as channel number for any =
spi
> device which uses a gpio as chip select.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/spi/spi-imx.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> e8f7afbd9847..569a5132f324 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -504,6 +504,13 @@ static void mx51_ecspi_disable(struct spi_imx_data
> *spi_imx)
>         writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);  }
>=20
> +static int mx51_ecspi_channel(const struct spi_device *spi) {
> +       if (!spi->cs_gpiod)
> +               return spi->chip_select;

New set/get APIs for accessing spi->chip_select and spi->cs_gpiod were intr=
oduced by
https://github.com/torvalds/linux/commit/303feb3cc06ac0665d0ee9c1414941200e=
60e8a3
please use these APIs instead of accessing spi->chip_select & spi->cs_gpiod=
 directly.

Regards,
Amit

> +       return spi->controller->unused_native_cs;
> +}
> +
>  static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
>                                       struct spi_message *msg)  { @@ -514=
,6 +521,7 @@
> static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
>         u32 testreg, delay;
>         u32 cfg =3D readl(spi_imx->base + MX51_ECSPI_CONFIG);
>         u32 current_cfg =3D cfg;
> +       int channel =3D mx51_ecspi_channel(spi);
>=20
>         /* set Master or Slave mode */
>         if (spi_imx->slave_mode)
> @@ -528,7 +536,7 @@ static int mx51_ecspi_prepare_message(struct
> spi_imx_data *spi_imx,
>                 ctrl |=3D MX51_ECSPI_CTRL_DRCTL(spi_imx->spi_drctl);
>=20
>         /* set chip select to use */
> -       ctrl |=3D MX51_ECSPI_CTRL_CS(spi->chip_select);
> +       ctrl |=3D MX51_ECSPI_CTRL_CS(channel);
>=20
>         /*
>          * The ctrl register must be written first, with the EN bit set o=
ther @@ -
> 549,22 +557,22 @@ static int mx51_ecspi_prepare_message(struct
> spi_imx_data *spi_imx,
>          * BURST_LENGTH + 1 bits are received
>          */
>         if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
> -               cfg &=3D ~MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
> +               cfg &=3D ~MX51_ECSPI_CONFIG_SBBCTRL(channel);
>         else
> -               cfg |=3D MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
> +               cfg |=3D MX51_ECSPI_CONFIG_SBBCTRL(channel);
>=20
>         if (spi->mode & SPI_CPOL) {
> -               cfg |=3D MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
> -               cfg |=3D MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
> +               cfg |=3D MX51_ECSPI_CONFIG_SCLKPOL(channel);
> +               cfg |=3D MX51_ECSPI_CONFIG_SCLKCTL(channel);
>         } else {
> -               cfg &=3D ~MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
> -               cfg &=3D ~MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
> +               cfg &=3D ~MX51_ECSPI_CONFIG_SCLKPOL(channel);
> +               cfg &=3D ~MX51_ECSPI_CONFIG_SCLKCTL(channel);
>         }
>=20
>         if (spi->mode & SPI_CS_HIGH)
> -               cfg |=3D MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
> +               cfg |=3D MX51_ECSPI_CONFIG_SSBPOL(channel);
>         else
> -               cfg &=3D ~MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
> +               cfg &=3D ~MX51_ECSPI_CONFIG_SSBPOL(channel);
>=20
>         if (cfg =3D=3D current_cfg)
>                 return 0;
> @@ -609,14 +617,15 @@ static void mx51_configure_cpha(struct
> spi_imx_data *spi_imx,
>         bool cpha =3D (spi->mode & SPI_CPHA);
>         bool flip_cpha =3D (spi->mode & SPI_RX_CPHA_FLIP) && spi_imx->rx_=
only;
>         u32 cfg =3D readl(spi_imx->base + MX51_ECSPI_CONFIG);
> +       int channel =3D mx51_ecspi_channel(spi);
>=20
>         /* Flip cpha logical value iff flip_cpha */
>         cpha ^=3D flip_cpha;
>=20
>         if (cpha)
> -               cfg |=3D MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
> +               cfg |=3D MX51_ECSPI_CONFIG_SCLKPHA(channel);
>         else
> -               cfg &=3D ~MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
> +               cfg &=3D ~MX51_ECSPI_CONFIG_SCLKPHA(channel);
>=20
>         writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);  }
> --
> 2.37.2

