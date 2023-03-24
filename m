Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179976C7C64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCXKSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCXKSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:18:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273065FC5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:18:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho4GpyzAw63zThwVLZMoaQFFZnu2/zop4a9EYV9yjwrr5dXh0cVZt2+AhsUnMZa1OsDDoIMSH3cpgSy4Lt3+rMBaD21Ai2lKTi7tgPc4KYp6jwqThTUimP7emY71o38G39u9LAfOTWz1Cu/rhMX6x0E+o7o4heLYzD7QFjCrzQVBGyeh4+Qex+QnKna0HmDkkqQ/S/tf6jADFMTyHWR6aAPcTaqLGVcP8xAMzQf56nb9kC6AXOJsCLQMBu0i9mKIRKLwjlLOpbg1XhJUUW5/0g5P99R4nUmCl1x0u7FtK8It3iiNhpB+Jm9PYQRsWi16N6sH47lISQ5sQxhT64gwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huKbJOubJ54pF0u6la/xRURYJgoEcJjjdXdUNKSWlao=;
 b=jVtRdo0BWBGs+xR2CTIPrmpch//AWamvk/wXrvLX9e21mmuFAmWjVMrKB7HeqnjIpW82nsN5KyJ1QNipy7+EimzwIH6CybYQfYbjagqGsUh2GKMQQH8P9jF4X0hA0IPCH5o4TM4zypMqwVkYaQL0dqX/aJf0Hf7Dffk5Epylv4cure/rPTxlDBGMSVv+xXvRTQAwttjHcDJa+rDObqmkg4gL6in/oMyDBm3Pg91odp7TEzYwbf8M7TecMbP4F1TgcSNn7J/rv5Aw/+9fOcKUNlvqDBsq7GLmWnXQM8Ydh1RvLDMECkB16nLK61LuNC1W88XuSC9fGjYFY6YIT1cX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huKbJOubJ54pF0u6la/xRURYJgoEcJjjdXdUNKSWlao=;
 b=bupmxJxKVJGrszZ6nM6DRCfPfD0WBhploFJAGhvQq8P03of0cz/InWkuZP7FcsMO5j09/jTFKzdTbqbTMVceBG1AGf05R1M7wfhW12g6A0pgIWSOMONmm76OdB81bYqIEIp5GdgifUD3zhGrmPliudCXwZCBAgh8x8IV6ThqAMc=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 10:18:17 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::5b9d:2097:31d0:c3a]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::5b9d:2097:31d0:c3a%9]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 10:18:17 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 support
Thread-Topic: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 support
Thread-Index: AQHZXXZt5pMZSwGyAE6437fZs85FYq8JtdDg
Date:   Fri, 24 Mar 2023 10:18:17 +0000
Message-ID: <PA4PR04MB964081F4DB2E16D8E300B08389849@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20230323105826.2058003-1-m.felsch@pengutronix.de>
In-Reply-To: <20230323105826.2058003-1-m.felsch@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9640:EE_|AM8PR04MB7794:EE_
x-ms-office365-filtering-correlation-id: 6805686a-388a-4cad-55fd-08db2c5115bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9znldTUXDnWMPvk4V0RWWPe523JjrkdRpH9OtpWhf7g1u1DxVSs8nwxTl0RtlBIGyKX2C8PWWnu//PkVZX4ptnaklQOykwtp7iStHoYV8OwBSY6q2dyL5kpaaL9edboZ3wI925wxrMeocmI7NuYVjWSO6UJa3EIPmI177Z0onC4InGkOykbplHsiOdb5qmuAVadaEIwQwxb03+IHGgeR7SqhFJxaMGG7LgEz2rlUS+abesK5lrxk2hmGj2lNFkFOk/p9kxMFLYnM1MP5h4y8FW1etWmPxpM8CKqAng0z/IDH9VV+vX8hYsyUE26Zxxj92qxWydN/7ae6FjFlWU/vQ6eblOfc3VNH+BqQxuOujyxBV5EnWuBWlM7/9E+gMe70MHVciTKZWLO8Xq69n/gSgK8fFpb81t7Ul/znN16Zt/lKOeVJv3h1Ut0/IA303HpcOMomPT2Zyh7XKBowFN44nOUAO4Okhiac0YGszAxUg4u2/D1ZAmhfIx5j9+6LtnBHT1mnwfzGEw3X12o8yZX/Ig0THkXq9JylCp+3694MXRb0Y6ajxECw0XL5PbFZwtlhVAA5RP96A6azUGxPp3nQFO+0qqWUnNMrfd7Pzc8Fa26QY9zM31uHuTrZzvk8c3BkWoS8edRAuAjqp10tGtYB8c4VwWcjbntxClaD2ZGwMQAVN5lUAYsWnSxgu0Pikwm089TJj54INRERfeTada0UBY3BzOgdT31xY05U/1JyH3bxqBC7BiaN2h5fy1j9/4xO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199018)(66476007)(64756008)(41300700001)(66446008)(8676002)(5660300002)(66556008)(2906002)(38070700005)(44832011)(4326008)(33656002)(86362001)(122000001)(52536014)(38100700002)(26005)(478600001)(76116006)(7696005)(316002)(71200400001)(110136005)(66946007)(8936002)(55016003)(83380400001)(54906003)(6506007)(9686003)(53546011)(186003)(32563001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nYoERG3GA54B8ItyG6sNpfUbSrGMkBvJ443Oh/SKygTOjwwRkI9Ypnwmb5os?=
 =?us-ascii?Q?zRtlH/72b3R8VIbcMW1u4gmwNsfHUzolY9QtOwzxLlQWvbtVXnFgdAeZva9A?=
 =?us-ascii?Q?kBKTjO/MKc92Dzx8ImLGxQlwX9J5DeGt8Wo+FJ0IqjTvy+9pguAvDnS5scfc?=
 =?us-ascii?Q?dmejlLsaLWBnO2O2dpHlBW1jpaUJBtE6Gt4EZIz0usXlEMP+xhQH7zIhR9Ye?=
 =?us-ascii?Q?A3aLaU3bks4D6cVUzsIh9Hm4yakxP6oDUcRlOYJqRsd3Ja212tKTVn5RsKqo?=
 =?us-ascii?Q?1TppDFZCVVNwQnJRBQQOipZycaqLjFGzNP9sdeLYmpIqj4p+DKP60sTVNlw0?=
 =?us-ascii?Q?EPhjjSeh2brHEWsf+0gB2hZFZs5gNWWMdKhj9e4lPAQV8cmsjuE/v7iVc2QP?=
 =?us-ascii?Q?23Eo0vYcTDlCnQ+yQGoNSaS6tgwXCBaWlQTMhjtpWKlLngaRQyyXzDkjO3Dh?=
 =?us-ascii?Q?aM9cyDLnwpgGZZKejUlYh1iSnRJwR7TdGok/6dnpWRJydtsnmAiKZOn4PB4O?=
 =?us-ascii?Q?l7u61CSVGmsIGpMhT7nHASLuYyqvAgqoGcWbVBP32Fk5sRkpl7C2dRDHWChw?=
 =?us-ascii?Q?B9LZm5xgTxB45XIz7+3K0eoqUh2z48HzWaDmjuOIheE9rIstHDFJ7DjS9v/O?=
 =?us-ascii?Q?oOfx9Y5wOmMGmw3MNev2U1mYAXGJIcTYGQniqVUtYH20VpF3rH2V2ar2qd/S?=
 =?us-ascii?Q?QnQWRY9z2C+0cgdjqHcA1emk7QUVeWWKSKhguq1TebuW3PGogyEdlbKoQYOK?=
 =?us-ascii?Q?nQZqduzMNTUiPL40s+dT410AV0zDGA78nQSLNlAKKe0rjDHlPqUb8fbtjf9M?=
 =?us-ascii?Q?Ge8NNJ+iNY57DmikfyGwXsyaMppjMfDfSAWa1BQ6MUV3AWie2ZW2PWG7Bxi7?=
 =?us-ascii?Q?hIS9UdTF2O9iW30578+d5M5JDqCTvcqo78Sa8xB/+9ZpHtj7ChCknUBLi5Sy?=
 =?us-ascii?Q?aIub3vw3eQvY7yIzabMYZgbe58AVPp+gx1gGVYx/AGVgN/9N+2YlUkd9Nq/l?=
 =?us-ascii?Q?Z7GQECrGjrSyB8Cxg/BsalqbzNRH9d168b9Ivjey2n/vtCChvuMKCNSb2r7o?=
 =?us-ascii?Q?vMmwRWIu2GZHYysVPXevWuNvg24zN4ch3GPhz6Nvh/7e8lkXfb/z6037I4x5?=
 =?us-ascii?Q?f/S6kOHuk9xMzTQp5zSi5IbN+rGVpfVMVUHRb470cuO5D385bS+xtdwVzltv?=
 =?us-ascii?Q?qGlYIUQM/kSvJ0dNkFt2hzzu/gsh0tPW9tPz3JbAtDH5hP8exuIbvERZQ2lB?=
 =?us-ascii?Q?Y74wLWLRzaKLdORz+1creIOqLREft5VoKgPyyDeI3QM8XpMka0zw8G6FFaEm?=
 =?us-ascii?Q?cZ7xkoG8RDQU2M78CFqma1PewYqDuW7PAWuL4833zcRksQ/lpJWls85yXVJt?=
 =?us-ascii?Q?vDyvbvOJu576QDViRVPUDaEoFleXtUOe0k6t6NVtCBHxdrGv4ZgSzx01NkEI?=
 =?us-ascii?Q?CsEGk+aH5L5cEdgLUnTJPkWX6M4Q/E9jxaOO6g4PwPUBE3gRTTxnXCTg10ni?=
 =?us-ascii?Q?7TOav9I/crP0RvvxIPKKgbG6IxZetfRwkPiLmEtgbhF6kPxBMiN4IFUB6QH/?=
 =?us-ascii?Q?McPbN7nMtbkJB/26hdU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6805686a-388a-4cad-55fd-08db2c5115bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 10:18:17.1225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FB6JzppBBVfAZYrUu3Rnw/5xmXQZy4G6q/l+45GId6IzFNbhS/9VbJn7UAQ1jOum
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Thursday, March 23, 2023 6:58 PM
> To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> shawnguo@kernel.org; dl-linux-imx <linux-imx@nxp.com>; festevam@gmail.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de
> Subject: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 support
>=20
> The i.MX8MP-EVK has a dual-role usb-type-c port marked as PORT1. By this
> commit the dual-role support is added which allows the user-space to assi=
gn
> usb-gadget functions to it via the configFS.

So just ignore the orientation switch will make this port cannot work
at super speed, this is actually why this port is not enabled at upstream.
I see the orientation switch via GPIO for SBU is already merged:
drivers/usb/typec/mux/gpio-sbu-mux.c
Do you have interest to expand this driver to support super speed
switch for this case?=20

Thanks
Li Jun
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 59 ++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index f2d93437084be..982fe35f09a7e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -5,7 +5,9 @@
>=20
>  /dts-v1/;
>=20
> +#include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/phy/phy-imx8-pcie.h>
> +#include <dt-bindings/usb/pd.h>
>  #include "imx8mp.dtsi"
>=20
>  / {
> @@ -336,6 +338,34 @@ &i2c2 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_i2c2>;
>  	status =3D "okay";
> +
> +	tcpc@50 {
> +		compatible =3D "nxp,ptn5110";
> +		reg =3D <0x50>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_tcpc>;
> +		interrupt-parent =3D <&gpio4>;
> +		interrupts =3D <19 IRQ_TYPE_LEVEL_LOW>;
> +
> +		connector {
> +			compatible =3D "usb-c-connector";
> +			label =3D "USB-C";
> +			power-role =3D "dual";
> +			data-role =3D "dual";
> +			try-power-role =3D "sink";
> +			source-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			sink-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			op-sink-microwatt =3D <15000000>;
> +			self-powered;
> +		};
> +
> +		port {
> +			usb_con_ss: endpoint {
> +				remote-endpoint =3D <&usb_dwc3_0_drd>;
> +			};
> +		};
> +	};
>  };
>=20
>  &i2c3 {
> @@ -449,14 +479,37 @@ &uart2 {
>  	status =3D "okay";
>  };
>=20
> +&usb3_phy0 {
> +	status =3D "okay";
> +};
> +
>  &usb3_phy1 {
>  	status =3D "okay";
>  };
>=20
> +&usb3_0 {
> +	status =3D "okay";
> +};
> +
>  &usb3_1 {
>  	status =3D "okay";
>  };
>=20
> +&usb_dwc3_0 {
> +	dr_mode =3D "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	usb-role-switch;
> +	status =3D "okay";
> +
> +	port {
> +		usb_dwc3_0_drd: endpoint {
> +			remote-endpoint =3D <&usb_con_ss>;
> +		};
> +	};
> +};
> +
>  &usb_dwc3_1 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_usb1_vbus>;
> @@ -666,6 +719,12 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
>  		>;
>  	};
>=20
> +	pinctrl_tcpc: tcpcgrp {
> +		fsl,pins =3D <
> +			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19	0x159
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins =3D <
>  			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
> --
> 2.30.2

