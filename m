Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F004462563D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiKKJIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiKKJIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:08:30 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E186567
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 01:08:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8dQd3xlBD3P16xeyhxjTjau2x0aptnzMZLIpTjjoZ5LYZsQPJsRdCwrbL4McwJ9CDepx+rNsobry1CsVWYXFsQtnKmH8VgDcvoHHO//aBDO2woG7dapNXQUC6z1RTMMHvW/l8ijuFR6jq2YZHF7VlY612ddbgrRmOSchPgmSXBXIWKl/+BHqTiQrqOed8Z49NtDGYWtLlOu8W1LMVDBwWEh6VQutrp5R0nbDgaibHdrY99FntMA3b50osEmEBWGNwjkEuXTJeeDWl+mf3yqPttk0NVlumPmzg2oQ3apOPRVEh8t1ZiGtpkLd42gUSlxOXEY+SFNfhDKQko43Qf9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcMbUYe3mbK3cQBzQwNjypx4nMAvhVhnFZiVF75AMDg=;
 b=cqMzual5Ef8S1db/aZYjGpJ4Jo0sMKUDJ92v8Z5/MW7Dzb8eEFS1OsuKTnPSCZVODZC705MlUT5zPEAg5KC2JciPOPhQ29dsBzGOOPz99lt1J1qqT+tSNaJnSNMpkq3TC4N6aGdrK1ghWSjQhXiyv4ibW22B7h0E4TnNo5jG9xB+iPLpnfjc0RBpMyxv54oS6cTfI0kWK6bl7rhCjDFUchR6TT9sbgvvKoGJhH2I432KdS/rnTYnXGtWFFhnyFTYaA2ptSg7tyxd0+mMwoqW8/2myPaP9sIT5h43TdqKb1+vZYCGpl8Oos/TOUMk6l963tBYE+QazPeG6zSlrJfKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcMbUYe3mbK3cQBzQwNjypx4nMAvhVhnFZiVF75AMDg=;
 b=HkCFDVJRK1lFpZbxPJdPcTOOcxoUABgaFjR2VZnW9jVLUTtBlZlamfvJ5oG/M5CZLjK6FoTtmaShKjguqB/CLTUWX6sXygPJf3WG2GEgkU+O8FPhXh26YePbbw/1RzHRB/VGE7jlXjAic1WwPTVkKtU6bskxjl3yqt6t1BEaioE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7385.eurprd04.prod.outlook.com (2603:10a6:102:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 09:08:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 09:08:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sherry Sun <sherry.sun@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 12/14] arm64: dts: imx8mm-evk: Enable usdhc1 to support
 wifi
Thread-Topic: [PATCH V4 12/14] arm64: dts: imx8mm-evk: Enable usdhc1 to
 support wifi
Thread-Index: AQHY9X2D4MClIKKs1EGIszxWLL5M0a45ba8AgAABgCA=
Date:   Fri, 11 Nov 2022 09:08:25 +0000
Message-ID: <DU0PR04MB94177ED8966506D445CFBA5688009@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
 <20221111032811.2456916-13-peng.fan@oss.nxp.com>
 <20221111090232.6ibqzoivfqsndhxg@pengutronix.de>
In-Reply-To: <20221111090232.6ibqzoivfqsndhxg@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PR3PR04MB7385:EE_
x-ms-office365-filtering-correlation-id: 99adf2bb-a554-4438-622f-08dac3c44a86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h4MKYc1ZDQLuAmBe6sM+804ch9yjs/WQGn1dhzqjALYM/giOGiYmVPVCSZtObnkfN78TICcixeumPDUA2JUul0wMyS0RnltgENa+la9uJTd2W8Ms2kmf6OGu9v5NYNUpo2Qa25MtBOV6ArqHylw5Qvak6W9bfLkzOLmVIJG6SuuAnYK5l1cGDYpN6pfR1V6xWrymVgq8MuCNJAJdAJsi3hcIyb8KKR+kSWGBoFlcjxjm361ph3fR7/J2UqJboxqxJeNjc3erQxrmUCAOUvC53kZP3GJNngnqH/JGiXDPIIAW8GfE1IL1r+zzIhTs2QwB9hgF0ORgsq8NmzQIXuyLrOd81Aod/AM2r7i7ADrlZ+V5WF0ueKECkPi9kbN/+l3gkuXlaejfmQDzvVFVDfoV4TYEM1eiLrEOJKsfkf9cmoSgwXpNQmyCj4xcpJiI1XnA+OyfFheozuUv9Now8EYEcTlyDskpJQUJDzy3VgX5j761v4uJUUK/T20+Wiqon3ItEaWK3E0dI+nvO9I5M302fxOS4mIj7R3PsMv3LPvpYeqUAQsn7yi6S+hBYfYAONcjfo8MOZQUbO04vBHnG87zQl9w0IJG9JXkWZYcN4nr/LjucJ3BxOO16z6cksN8AEvVjiIUul3ssViHcZbgi/OWQYTSAGMF5hfjwQJ4ji8FGnRynL0RwSxKvJbuASeuZdRBbt/RqmM2QtMdRYMtYBmwBkxXjDpOc+tqA+nzblp6OCnzrjatzMDso7x6Fa9LDnweNaodxeZdv0MllogSqAlfWr2QBa4djOzMkGAPBErJoNBwFFtPJWbcX1kU0tR2qpMG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(55016003)(316002)(33656002)(38070700005)(2906002)(86362001)(38100700002)(122000001)(44832011)(76116006)(66556008)(8676002)(41300700001)(4326008)(64756008)(66476007)(66446008)(66946007)(52536014)(6506007)(7696005)(9686003)(54906003)(8936002)(5660300002)(110136005)(83380400001)(186003)(478600001)(26005)(71200400001)(32563001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4HHjPG5amu2S+AL6JoUwzRnMCJ2J83DaIQIrZyLJWTXzKaXARactxqaPf9Ds?=
 =?us-ascii?Q?CZH5PrScRBhJ0AzW8GUYxzKvM4ey8x0PloVZocYZjMpXVNSB5pJFjuR1Wuab?=
 =?us-ascii?Q?Jsvl+2j1UFqwtBXQZjMfS1jjmxYipg13jS3xG/bc/q5Sbluv6iTt1rabmwa7?=
 =?us-ascii?Q?eFiRqSWcsOGujj1Dc6wlxfuSppdd1YpKKEXUAx9yqCW19ptuf1JA+v6oGSC5?=
 =?us-ascii?Q?X7oA7nDqaVZWEdoLVZXfUBlb/j9LasK5dK0JGHGVc14ndLw6J0Ky9V6HqSUr?=
 =?us-ascii?Q?H+lMDpj3XNDx7onTAba7YKt/ChGgmtzuu+4QhUkKgVGKxfF7S89juUVqCyqu?=
 =?us-ascii?Q?RfRSlukEzV6TmBVz40KATz/TZnGBBOowIk1rpAHlr3VNm0vSELqpSme6kW3V?=
 =?us-ascii?Q?aDLOiuNT83Q/qji8tiPlbbo0UYvQ7wvlXReIYAT9etB9d5s7la/xJDPYttTv?=
 =?us-ascii?Q?FKQFw0XR5UmsTA265YfVcEXEBSzIWz3im8T8Ih5p8F8j4aIQ9kVN25Li3Goo?=
 =?us-ascii?Q?3/rx1pfU8u8I3280GeEUFto0m2V0S8CLUrRGcw1oupLPUdg2z9RIY/OIeL/s?=
 =?us-ascii?Q?VOxBXJ/JNa5X0y/77bOyPpiVOV6vRUD1WAfEW2kLCUgOjebG0Z+7avWlvZk4?=
 =?us-ascii?Q?fZJnawjgKt9SzLsM5uT9LHamyNEoz7/XZvtqNm1mrAB7k9lACTdMkMXM6JZx?=
 =?us-ascii?Q?WtOv99Pu0Lvclj//uyOpHxy+YsXex67LvbSnd22ubGmpKM56pbL1VDs0fa4K?=
 =?us-ascii?Q?RQlGeQfhPaHGJ/HYe2vVRCqbZ9unbbe1b2YP6+w5qYJps+i3FAxU/szFzq3z?=
 =?us-ascii?Q?8S2/IV7tcD1ANtfbtEhWrW0TsCuJzf45vJU463cn/51o3M7fsTGRG5DCohJs?=
 =?us-ascii?Q?twgAur3rxefR+4VdPSy/pn0k6h+3bxBSjLEG98PGY9Uo6gOAoVTCpTaDUOYs?=
 =?us-ascii?Q?NXnxrXPeB/eXSNwJn1QpvYPnIeKk5KW8BUm26d4gZOe/xC0xNlctWGKGhOVV?=
 =?us-ascii?Q?V1UYnqAjF1VIdbc/y58eqPVZgMLSD2fl8CGfBhfFOcD7a7Qzei4BeKOlxXyv?=
 =?us-ascii?Q?hGDNMXbAXVHVZsXG8rzJL+HM+N0DblQLDUm/7NyI9FT+fl46vVQQsJ+q4Ofh?=
 =?us-ascii?Q?2d/bZyutb0sZGsp5Tscpw4cerpjF9SMhh/MygvyaUrNKIXhMVSMsLfZEHpAu?=
 =?us-ascii?Q?XTiJsMY7G/imKIm3Moub2rrxREN7xyE3I7r7Knbxk9fBHQP8Th6waFfHGsB0?=
 =?us-ascii?Q?cBps1boy1M060O+jZG8ayfXdo18Ii3QiQmO1kM2RbBtQuLxyoA0T5idzWC77?=
 =?us-ascii?Q?k/lu+PdL8ZftbyKcBLiSOQzy2fCIiK0y3COZhFQWyvfkgeP723ijPInZNnM5?=
 =?us-ascii?Q?Ah+5M+R814ky9YDNUvTuV+BzSzL93ArafP2hMnPfH8qMRCIYmXU+EZI7tF5P?=
 =?us-ascii?Q?9Nd1d/j4GXUtm0WsDHhKdv19pQ3Nt+lUoTVUwUTqXFbpgNqvTSKHMPa3Irs2?=
 =?us-ascii?Q?WzUbt2K6zOyvTP2pJRHnOUn+cuEAl7FX/ojgWKyufQag2Kbv6VeYKwbGzqQs?=
 =?us-ascii?Q?yA5WRItCOmvzSMlj2EQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99adf2bb-a554-4438-622f-08dac3c44a86
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 09:08:25.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNZr81JcEqql4QT8CuJDiECvQHCWGRqmTja3Oudowzw/qCK9fbTNP6q8U9AB32M3z648P93atkrraR3AJbb+cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7385
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sherry,

> Subject: Re: [PATCH V4 12/14] arm64: dts: imx8mm-evk: Enable usdhc1 to
> support wifi
>=20
> Hi Peng,
>=20
> On 22-11-11, Peng Fan (OSS) wrote:
> > From: Sherry Sun <sherry.sun@nxp.com>
> >
> > Enable usdhc1 which is used for wifi.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 27 +++++++++++++
> > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 39
> +++++++++++++++++++
> >  2 files changed, 66 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > index a2b24d4d4e3e..7b80f144327d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > @@ -15,6 +15,13 @@ / {
> >  	aliases {
> >  		spi0 =3D &flexspi;
> >  	};
> > +
> > +	usdhc1_pwrseq: usdhc1_pwrseq {
> > +		compatible =3D "mmc-pwrseq-simple";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_usdhc1_gpio>;
> > +		reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
> > +	};
> >  };
> >
> >  &ddrc {
> > @@ -53,6 +60,19 @@ flash@0 {
> >  	};
> >  };
> >
> > +&usdhc1 {
> > +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > +	pinctrl-0 =3D <&pinctrl_usdhc1>, <&pinctrl_wlan>;
> > +	pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>, <&pinctrl_wlan>;
> > +	pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>, <&pinctrl_wlan>;
> > +	bus-width =3D <4>;
> > +	keep-power-in-suspend;
> > +	mmc-pwrseq =3D <&usdhc1_pwrseq>;
> > +	non-removable;
> > +	wakeup-source;
> > +	status =3D "okay";
> > +};
> > +
> >  &usdhc3 {
> >  	assigned-clocks =3D <&clk IMX8MM_CLK_USDHC3_ROOT>;
> >  	assigned-clock-rates =3D <400000000>;
> > @@ -125,4 +145,11 @@ MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7
> 0x1d6
> >  			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE
> 0x196
> >  		>;
> >  	};
> > +
> > +	pinctrl_wlan: wlangrp {
> > +		fsl,pins =3D <
> > +
> 	MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K
> 	0x141
> > +			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9
> 	0x159
> > +		>;
> > +	};
>=20
> Out of curiousity, this is not shareable with the other ddr4 evk?
[Peng Fan]=20

Could you please help answer?

Thanks,
Peng.

>=20
> Regards,
>   Marco
>=20
> >  };
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > index 7d6317d95b13..ce450965e837 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > @@ -559,6 +559,45 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX
> 	0x140
> >  		>;
> >  	};
> >
> > +	pinctrl_usdhc1_gpio: usdhc1grpgpio {
> > +		fsl,pins =3D <
> > +			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc1: usdhc1grp {
> > +		fsl,pins =3D <
> > +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK
> 	0x190
> > +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD
> 	0x1d0
> > +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0
> 	0x1d0
> > +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1
> 	0x1d0
> > +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2
> 	0x1d0
> > +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3
> 	0x1d0
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> > +		fsl,pins =3D <
> > +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK
> 	0x194
> > +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD
> 	0x1d4
> > +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0
> 	0x1d4
> > +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1
> 	0x1d4
> > +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2
> 	0x1d4
> > +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3
> 	0x1d4
> > +		>;
> > +	};
> > +
> > +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> > +		fsl,pins =3D <
> > +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK
> 	0x196
> > +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD
> 	0x1d6
> > +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0
> 	0x1d6
> > +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1
> 	0x1d6
> > +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2
> 	0x1d6
> > +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3
> 	0x1d6
> > +		>;
> > +	};
> > +
> >  	pinctrl_usdhc2_gpio: usdhc2grpgpiogrp {
> >  		fsl,pins =3D <
> >  			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15
> 	0x1c4
> > --
> > 2.37.1
> >
> >
> >
