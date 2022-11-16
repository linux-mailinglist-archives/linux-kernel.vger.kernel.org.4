Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8021D62C2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiKPPrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiKPPrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:47:05 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E4A6170
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:47:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMWND+C3katoREzYPvjnRzfde60RZFRUR8Zss/XcYXQHq537OGimsGmlgArAfJyluGvFlDX23boiU/ROJ31kYDFhkWHJ+mLlsKk7ZyTMrsyFHr1aSjJjeLUnTOMEbG3xMaNgeA+hX+EbMfTLqoHMAd2TDeb90sxE4bIOawWG1vfeRDaQAD89kfg9nrkTmLJ7ZOMmwW1ZUUwCyPvKKrSE1yKCy6WjeR5SbXEliyElidnhn0A2srP9nFNtiiAF5q8HiD4nTFFz0zZOyylxRzoM8MuqLmOIv0MA9ExWmSWk/m5w42wP5v2BzVUFrEaVmX5YHwT2EKxHsgKWHzg09SrXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6B2SDp2DUO6OibjacnvQUjokHUSCIs06N2jAdU16Zo=;
 b=BckgEjcGjhXGZjDUjQP8MwSpb+gPswoD47kPfouzvlpfRVwlOjnZ6CUeC2YezizJqgcYnq8YZNnEmJifcUe1LsU6cz4RNQBWt1Ku6xHwxK7xQ4/xtv8KWaCFpj4Hg+XZr5XxyHQe2Na/86VrHClMGrxfDgyzw19gVijr8ycN+MLvp9sXzR+gmopckmBcb0jXcwfEBQV10WteXvjDyl5LKtiLcuImv8L8O1/bL8JNDJdswC4fgWZIk/2Q/0eqc7NgeUZRcQ9xFe9B2kKz2WXznVcnR6knczA4qu4g1sEIuhlzSU7SmLerQE5L1QM8XdLWn9RU0FPK/BKQzfSwhJuV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6B2SDp2DUO6OibjacnvQUjokHUSCIs06N2jAdU16Zo=;
 b=MAho8i0K6Uf8cuTcEp1Dudh6QT29mmCHZNXL03stw/s05gp4AvyWxELGhW4GWPo4OjMC6HpjoR4tuU3fuOqyo/elGEwQNr3jgTufAS45J2f9L3tTl49Z4JUoRm9PygJkeikCy46S8DQEPm+2SBEbYk4e64/tXikGoVdXV5VMjMw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB7057.eurprd04.prod.outlook.com (2603:10a6:208:1a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 15:47:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Wed, 16 Nov 2022
 15:47:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V5 07/12] arm64: dts: imx8mn-evk: update vdd_soc dvs
 voltage
Thread-Topic: [PATCH V5 07/12] arm64: dts: imx8mn-evk: update vdd_soc dvs
 voltage
Thread-Index: AQHY+NLkMsIJTWCTDE+Rd0hYrBnN864/wTKAgAETwlCAAHq0AIAAYx3Q
Date:   Wed, 16 Nov 2022 15:47:01 +0000
Message-ID: <DU0PR04MB941725DCB67C215999733C6688079@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
 <20221115091709.2865997-8-peng.fan@oss.nxp.com>
 <20221115100251.7hwpnodgxzirgpw6@pengutronix.de>
 <DU0PR04MB941782A4B6323FB9405808B588079@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20221116094900.52tbr2o3z4hvaw4z@pengutronix.de>
In-Reply-To: <20221116094900.52tbr2o3z4hvaw4z@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB7057:EE_
x-ms-office365-filtering-correlation-id: 23f8e6f3-6104-4f22-28a1-08dac7e9cd79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: njW/+jzW+y+ARfHOFpP91m1lAErOELrJd8dOFMr4gFtgMd3jkr+NYVDC4b2JLB6MavDWKrCf9c/LAHy76aCezer5wOchbca4G3UQJ/cwhmInaT/QbPVURTr02a6pqpZLZS/avJrvYXIGXMh4JA7Rk4O0QXfn7SgCOFjyt7J43dM2du/xFMv0QOIxVUoif+7ls2blkhDwqv7g/XxIhLVWrL8F57mh0EH8jAuluygiCzzzuX4TR/oo8tjJrJxWC7tii8knKCHkMweee98DebTJG6UfsQKqIbnjJAwO6zLwyuJ/Q853VF4tKEMptNfzQ8oiAYcU6x8YPIfS2D0tR43xgCoyJWrUvM9XCV20/B1zoE0KkuAe7m0Uw+AMLPBHW06biNNP0QgGVaAikXqbg7AtdRhZaL2Ej1TyYKLK4xiUuc4XiFbqYK5lxcf9xmuDgi2HE/z2vGyFx5MSnKIahpIYT6Dzdb6pyo+XBw5FnzjN66M3F0kE9N6Ud2UvFweKjs/zBaoxdt+0wXFSFOUCPYPdB2Kwzhf9ZpU9AfqgO88DWhnaiKbT3ZiNwhnFiJY9rhlTNJ3O8nqLajXDYaW9vR0OtNLZ5MIYcj/4Ty0MpnIuN3C3DKBhgu3Zpw1svfo/UI7HhY/sWKcQJqim4BslJHLBq7m2oTulKZpyfunLe0hQbn4TkDqC1TqlFgw57CuDpdiquS52WsiLXxc8weELINtU6hdRBCPCpBe5uiaUq5xCg5uxNshCIh/+F9cGXTtkZcBHyU4zP1E+ulHaKTVu7VFWNEfOdNro3KvsThdtQ5X8+TM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(26005)(33656002)(86362001)(122000001)(38070700005)(38100700002)(186003)(83380400001)(2906002)(55016003)(44832011)(9686003)(15650500001)(5660300002)(478600001)(7696005)(8936002)(6506007)(41300700001)(54906003)(71200400001)(66476007)(76116006)(8676002)(52536014)(64756008)(66446008)(6916009)(4326008)(66556008)(66946007)(316002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PThPHISj6IoGcHZFRMpfee4mJPAwvramMqCOirFEsBibb09kHL/DZhtjdXpo?=
 =?us-ascii?Q?k0q6JPggV3TLmXdBTGmmSPG1BNFYbbFn1B7/VLKhrw6vHBfPxWZqMc0o71as?=
 =?us-ascii?Q?f6A4t7TZKB3jwvcVWjrDdLx6oh10q2aMjhj+ROvCcaua/Fusln9Vk22w5VbF?=
 =?us-ascii?Q?aD520T1v/MJXrstdpZivVWh3R9nD50tl2gl9cC/wIsxJ0+czKeZxuNoQqt2j?=
 =?us-ascii?Q?Zg2VBVxZ/gY+yqY1pPxH0IZaf+w9DaEErBDT4N9BgsGs8+k9JG3KTW3e5Gzq?=
 =?us-ascii?Q?QDxfm+cxHcvU5pSfu0Ojfcab5csLHXSG4YR0NgvMPeX7zQzohkgjH+3bfHCx?=
 =?us-ascii?Q?zGjZU6Kc7XogGRajoAnCHsW/Y1itlv5qHFe2uOStwcWaQdoG3n2LoRIKAU8z?=
 =?us-ascii?Q?v2/ky2KInXISxVtk+wRTn8dNzoTDa6cp3FKIQKXKakU0V3sU1LTBYeuiOfbP?=
 =?us-ascii?Q?A6PZKUB3rR0EysGxjSNJWuzOk8Gf+S5B5gg8Mm9yVARmpubFcvE2IHw2Zypf?=
 =?us-ascii?Q?MPWLP0uGD58dgnTIemPya7Oaaisa3Gm2muqaO6SsEtDHc3xQEnv/dj3JClfh?=
 =?us-ascii?Q?kgDB1JrLV6Nvj6nVG+3Kx4Mx9otFC+UozgBiqKNDNXkFKF6w4QOuuFNg5Azm?=
 =?us-ascii?Q?xTADajo4QRUW45yRBgMS80kFz5XFr53Esldk+6YH61JR2ASW4Lx8GJYS/lbd?=
 =?us-ascii?Q?66hqRXuKl4iDnPbXPcXWec/m0+JoMGmIPFgHT8rrx/HtqIaDXgQ+s+WBAiLR?=
 =?us-ascii?Q?XyI/uzXaE717JpSTr+0t8JzL2PeKsoOhn5+FV45C+vnHp5x15vHVgKvNa3vP?=
 =?us-ascii?Q?Eyq1O54/4BKx7TbxUbgVGgcHtmpmUKklYVgseoXT9CbhgaoWjD4blPErQluO?=
 =?us-ascii?Q?JtnSLFIf1/MF1I1WqPhj43+K6CFSlaqntoJjOmwfyBax5MeFojNHQ0FaonPc?=
 =?us-ascii?Q?X8sqh/MpWfpZnK4R2aYT6lMXODZZWmFNI/KD3H+R8pnA9W+Vm8v0Gql5XrCK?=
 =?us-ascii?Q?xpxBCkJj6On+M0zLgl0L9OrYbeL/UAKbRcwqHRk0eViI8FkfIvnhUt+eEg3h?=
 =?us-ascii?Q?yKOpgnbYtY6zL/RS86o84m43s81HwJm1C2XGInVuaw/q0S6WXppfS3GJHBmY?=
 =?us-ascii?Q?TZU+6gyrZDuQZR9aVtWX24VptPvytHLlAyAYy2w9EdmeuKRRSzfGHSdCmQyG?=
 =?us-ascii?Q?mJuyi09A94madVOJvgIMLi0SrkVe/qsNiusIcvrRWecCiZCS70a5WgdzPUW2?=
 =?us-ascii?Q?A7BlWog6FeVDEm2I6kEa/apzBzjr1X/dQObMWYRTt6C9/qi973YvI/9oCoW8?=
 =?us-ascii?Q?p80aEpWaInVqgaA+dVLMsavsxF9MYpc10dKJJjsJ4i5uTnwb6brYgkGkhwzS?=
 =?us-ascii?Q?BmXdbNahb7MhJnVNov5juE7obAwgH3GWoab86Ap65x/k1QzO1o9zuxXBKfCJ?=
 =?us-ascii?Q?DhPyu2/CpWte365P5LHV3XQl6HMQJjeGcLCAYsqu/QLlou5UhAxwmucS8G0Q?=
 =?us-ascii?Q?qX39Op/RaBHQHkXTZKsLDIjpZTgnrmL+f/7O8trMsjPfdJGOhKTotqjcq64c?=
 =?us-ascii?Q?fhcnu7/gBDTs2j8L6jE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f8e6f3-6104-4f22-28a1-08dac7e9cd79
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 15:47:01.4454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOSuRKCtOvG9YAFmqWPxgu7pEiYpDmBZN1V1Kj4qJ/umJ9iBW5LBNRTDi3eF+te0VgKPW2NnrbFNQdVL/LqNVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V5 07/12] arm64: dts: imx8mn-evk: update vdd_soc dvs
> voltage
>=20
> On 22-11-16, Peng Fan wrote:
> > > Subject: Re: [PATCH V5 07/12] arm64: dts: imx8mn-evk: update vdd_soc
> > > dvs voltage
> > >
> > > Hi Peng,
> > >
> > > On 22-11-15, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Per schematic, BUCK1 is for VDD_SOC&DRAM&PU_0V9. The
> > > > nxp,dvs-run-voltage and nxp,dvs-standby-voltage need set for
> > > > BUCK1, not
> > > BUCK2.
> > > > BUCK2 is for A53, which is handled by DVFS, so no need dvs property=
.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > > > b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > > > index 4eb467df5ba7..a5a7d74ec1d5 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> > > > @@ -47,6 +47,8 @@ buck1: BUCK1{
> > > >  				regulator-boot-on;
> > > >  				regulator-always-on;
> > > >  				regulator-ramp-delay =3D <3125>;
> > > > +				nxp,dvs-run-voltage =3D <950000>;
> > >
> > > One last question on this. According the schematic the max should be
> > > 0.88/0.945V and you are going to set it to 0.950V.
> >
> > No, my schematic shows the TYP voltage is 0.85/0.95V.
>=20
> I have the Rev.A2 i.MX8MNano DDR4 SoM schematic and TYP is listed as
> 0.8/0.9V. Is this different for different ram configurations?
[Peng Fan]=20

It maybe DDR4 board support 2400MTS, LPDDR4 board support 3200MTS,
but I am not sure.

Regards,
Peng.

 Sorry for asking
> but the i.MX8MNano LPDDR4 schematic is not available.
>=20
> > > According the driver the nxp,dvs-run-voltage is just the same as the
> > > normal regulator voltage. So I would suggest to just use the
> > > nxp,dvs-standby- voltage property to enable the DVS feature since
> > > the run voltage is already handled by the
> > > regulator-min-microvolt/regulator-max-microvolt. So it would be just:
> > It should be fine to not set nxp,dvs-run-voltage, because bootloader
> > already set that.
>=20
> Okay, so leave the voltage as it is right now and just add the nxp,dvs-
> standby-voltage seems fine :)
>=20
> Regards,
>   Marco
>=20
> >
> > Thanks,
> > Peng.
> > >
> > > > +				nxp,dvs-standby-voltage =3D <750000>;
> > >
> > > Regards,
> > >   Marco
> > >
> > > >  			};
> > > >
> > > >  			buck2: BUCK2 {
> > > > @@ -56,8 +58,6 @@ buck2: BUCK2 {
> > > >  				regulator-boot-on;
> > > >  				regulator-always-on;
> > > >  				regulator-ramp-delay =3D <3125>;
> > > > -				nxp,dvs-run-voltage =3D <950000>;
> > > > -				nxp,dvs-standby-voltage =3D <850000>;
> > > >  			};
> > > >
> > > >  			buck4: BUCK4{
> > > > --
> > > > 2.37.1
> > > >
> > > >
> > > >
> >
