Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6380A6BF04F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCQSDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjCQSDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:03:50 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2138.outbound.protection.outlook.com [40.107.113.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F9D17CCD;
        Fri, 17 Mar 2023 11:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJTmF+IBQgt9NmDjWp60wyExFdg4gOGas7T+V24IaYUzWNM58+G4TQlBU1PmFMiYTlFcfBWsTX6WtUoN9BC8PjOcYM/epdd6rbd4bqSJLckXUqFlLTLZXy/ZzQ0yKnN3e5/VCikEQeP7iOqfWkDgMtEZcInflVmgMV33FVVL1lnOEK7pr6030l4d2oYFS2fmoTV0ypzkVLELoA3gMUBsrWAS8GUjhCCqMMJAIICipcIdpJXYzO8m58hcAFlTiq0Z7O8pAVbvw9d5gayuIe4l2PZI46lEnAHRkmy2JQ8LIi/cfkOUn89plXQRddObPKooOJRd4JtVxkTvXrl8J2oVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8puquUbdbFCgyPrpV3PWuTftvxo5Yw1HI2hT00XNjE=;
 b=H7XdNwlbRDR8uOtSSSnZS3BG40JYJ9vXj0Nym7J1QAbXMm4RPSCuCxykDmtfKjmmWKOdUOvs6aklvGPjCS+vbSMKnSsjNwVb/457ULMQdNVIEbgyqVMLigoZts9KDscCbcSfTiJhCO5xS/USmuo9xnJzDFjLHdYrLcQPNOtUil7zuTpY5+JxeXCifMgUUxWwA3CEGFFV5E9Bh4ebL321BmwSyFI8Qx5fS/x5Wr6XQ2GoxT7VN+MSqgIbNMqduiE++Kw+oslW+9V+JRbVPWWB/QSoxSg1x7N3WW46FQiNUSWnygSaujcTYU+qeZg7MKI4Q7DX3jynk+dIiDue5EIHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8puquUbdbFCgyPrpV3PWuTftvxo5Yw1HI2hT00XNjE=;
 b=oBOoEnczNDNdlJiCqz8Ukwl+9VvLq+pFhr1e8I9Q7MQdNFGnyHGAhKlMZaZQ/5NuuZKxaur/+6KYCy/l76Ho4T4Ovyvz8b6OgOHdb5tScFFNfHSdhDFzwxgkzgzgHd+Ba+7G6h9XY4Q4eoDmKnToWDEzgRE//nylJUu8rDCzSSQ=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYWPR01MB8805.jpnprd01.prod.outlook.com (2603:1096:400:16b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 18:03:43 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53%4]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 18:03:43 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH v2 2/2] arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI
 support
Thread-Topic: [PATCH v2 2/2] arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI
 support
Thread-Index: AQHZWMzmcmPajYc+BUqUMuSeR5Unp67/Q60g
Date:   Fri, 17 Mar 2023 18:03:43 +0000
Message-ID: <TYCPR01MB10588B29A18ABE00374AD07A3B7BD9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <20230317123314.145121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230317123314.145121-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230317123314.145121-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYWPR01MB8805:EE_
x-ms-office365-filtering-correlation-id: a0d6e727-62de-4980-3344-08db2711f209
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BSCe2Ex9JmgdRA7xLqLHfJfd/6BYb67T2j4FOhviUTMXYdMKFkqZmzwHLUG84wCAIbHmWFDIHNNYyWijq23LVh8R4PVIOZLr9zCBt4Kw07lD/oEo3jTLslvFECLgUEViJcGpDwu8uwdDEXkebw2IirktDwywR8H/pcYgtRHDRAwfw7fozZI/hrpV6bS8tcNQmls+DYUZZbN0hyy4/vaKGRb1YdGAn4BNElgz9xom3dcoimp1XDSOWyeA2oBABF0ER/nFDqoVLsjPekVaJU63gOz5yAdOUCnXqf3lVpcStf6FZHmVWtLEaD7mMWgZfS0Bseo7FCEugx21KzUdQKrcjb2cMm+pfmHT6XSMzzWPcUwGfVgqgGBSibZfE/Skt4VK6yj+vjsS6hAlhpIuDJTYSDNVfQ80g7WE4wEglqcfmrhOkj+Tnr/1j4zGUyQrGDNhYFVZcJjPgLqX3xWIlcdP8h9tJTAFsMrdlR/KqS0vvc+zrAZ83fMdVGJDEmw1w91rcfRwzIEVeRoMcmkJF86Cr/Kxdc5WKcaoIK2wnDXx6x5h9ccDPJnqkeP9rXkSOoF7n8nIRiBkwlMtHfIfejwO5htg2qkLMOXHrNVKBy91Yhx455NN0ECiYkI4hRjiabCugapr8Q83l45kjUAp3xtMRUN0fi21/uZ/Hbwi6Bvxcke356jRCnO+cVMHmUYVal2dCZ7aPtvytoBUUU40jByGCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199018)(52536014)(8936002)(5660300002)(41300700001)(4326008)(55016003)(33656002)(86362001)(38070700005)(38100700002)(122000001)(2906002)(83380400001)(6506007)(478600001)(9686003)(26005)(107886003)(186003)(7696005)(71200400001)(66476007)(76116006)(66946007)(8676002)(66446008)(64756008)(66556008)(110136005)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?67RgIqkpFbKQyBNcDs7klE30Idqfj0KjMvi9M4NThR4fOnZ9x6DlyeoV?=
 =?Windows-1252?Q?21K2bMRhdgsEbDEUlpUvn3mIG3GqUskwsTGW1GVaeDPltW93O9T061kt?=
 =?Windows-1252?Q?TdEz8QVh9hGxutSyOJ27g6mdBCVt8e98fNzG0a0nkJPdp9/I1ZsJSvhY?=
 =?Windows-1252?Q?pZOFj6hMaPVMNl1Lc/JQpbuUVUto1MP53l0KtG9Xevehe0Vj+BZotBzv?=
 =?Windows-1252?Q?BBiXr0BaXlZi0VMGxsZaU5bOUHraKLXBv2K2XXT3rwaPWxwAXsnHUeMi?=
 =?Windows-1252?Q?7A17SwaFDpyAnXRA45BucUHulo2/OOHC0CVnQkCy+SKBC4s9SN4QOjxh?=
 =?Windows-1252?Q?WpOLXzzSjuKl3RAmWo4WY0Tc++FX6/f2Zjq/2XJdmYPsgChpj8SpcgJu?=
 =?Windows-1252?Q?WnK0WBnGW2ZjkmUkMHzHy3xa/sV/lMAE7CDZ4jSfVVhxBvT19wMY09Fd?=
 =?Windows-1252?Q?c9qSIhqD1Aj4pJ0c7H53E7J5bODVEJeubUful4sjYQga3Cor7GsYQUZu?=
 =?Windows-1252?Q?IGTDaZX9FqxEUT3Y4ie3KtR9HARYrVs9eu1HLV/+vN2wY+4DhXzJ6grL?=
 =?Windows-1252?Q?wp4DhLS7cGZZhW0Wqi8aLqYSFDStyI/+sebHhwAlBMHnJtJhBNl8gDgi?=
 =?Windows-1252?Q?sw5Z7NzSwQcBjJ02xYqCHExp+skBCcP9UffC2sYhl/Vyw4FLeMI6J/Ie?=
 =?Windows-1252?Q?WgQR6cFgqnqBI76v/R0hj0iIQbNwtZppdHOfT1NLYOfssIvS1rCX45Yg?=
 =?Windows-1252?Q?3hstgrNnMPcAwmcfFxb62ozHiLeMYn67IPBkGAdGqcc1RD5HNgVRiHy4?=
 =?Windows-1252?Q?krOktnxK3WNZUWlNk2p+uBRhQI2UeBphOoe2VaVjtYYOMX2V82/7Rvm/?=
 =?Windows-1252?Q?xTOmxI/JCojfDLdQUKkf9+hsWQQUL5Mw8fuKtgpWVD2vyyu3KObd4c9R?=
 =?Windows-1252?Q?3mMaBrm98UyVArQ9a7T2+KX6pMPv2WO/7h4TFKlW+lUdcoM53/lZaGbX?=
 =?Windows-1252?Q?9Lr3Tbv8M+an848g6E0XnwPwEwTeRt9Rps0ceTtbQBvauZ8RIyW0b+Iy?=
 =?Windows-1252?Q?0ldt9tz1Acg9ROds3QKI1db189L5aTJTjP3EJZfSUI9q9CVR42CmGKO7?=
 =?Windows-1252?Q?G1zo1hvtuCddhbW3kap/qN1wvzVhsO9Wqcb1haGEOuPQrnWRiY3M+CA5?=
 =?Windows-1252?Q?HyYL4CLxN0XonowXD3W/AV8tJQueIqozmAKGYGnB+CnqIntQtXdmGxpM?=
 =?Windows-1252?Q?4Y07t6wG+doq6wXKOYxklE6eGiBC6ueatgBUg8jzT/anJFfvLftisq2h?=
 =?Windows-1252?Q?O/C3Zf8ZSoVB1DeQRtwmykU+Esnkb1nwPodT6QJYp2whMoBDDFZlA7jv?=
 =?Windows-1252?Q?MF5DBDkUKobOk09vrRAu0AzFyJIKu5isUVsnFKZrO7qN+IN9fUYEBwKR?=
 =?Windows-1252?Q?P9HZQj5FZdaz3fdc1gY9r3D768JEa1neXJvs/hF7BDPfwQYm7OuZdCc/?=
 =?Windows-1252?Q?uDZ5G5g9d/oMadEeR1GyFF85nCLFohyHOtq+VTQwIRHhCjcgtbdtn7SZ?=
 =?Windows-1252?Q?8Y5UAKI/rVZaDbPNVFSlBo80mYmVzb+8KP6puVuNUeKXIRlXmZNk/nEP?=
 =?Windows-1252?Q?884FBVnan9fjNoDmHRzaG6Wq+OKccIiRMr3Kl/pU9W6zc3ujeV0tteJb?=
 =?Windows-1252?Q?d7V9bZ/tUCtGcWGZxZI1dmqxfUGHFRg6crmC2tIeHElwcetnkhIlBQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d6e727-62de-4980-3344-08db2711f209
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 18:03:43.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opUgXASqgJuOoeu7f+CuZVh89/NNTlkka6K+BlVqMVILrLi/CvJU4mHjZf8xfmFtl7vHYXwzn+zQdeUpjOQ6nKjWnuk0O0xuzZ+vSDlIPqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8805
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prabhakar,

> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: 17 March 2023 12:33
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Enable CRU, CSI on RZ/G2L SMARC EVK and tie the CSI to OV5645 sensor
> using Device Tree overlay. rz-smarc-cru-csi-ov5645.dtsi is created so
> that RZ/G2L alike EVKs can make use of it.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> setenv bootfile kernel_fdt.itb
> tftpboot ${bootfile}
> bootm ${fileaddr}#rzg2l-smarc#ov5645
>=20
> v1->v2
> * New patch
> ---
>  arch/arm64/boot/dts/renesas/Makefile          |  1 +
>  .../r9a07g044l2-smarc-cru-csi-ov5645.dtso     | 18 ++++
>  .../dts/renesas/rz-smarc-cru-csi-ov5645.dtsi  | 87 +++++++++++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-
> csi-ov5645.dtso
>  create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-
> ov5645.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/renesas/Makefile
> b/arch/arm64/boot/dts/renesas/Makefile
> index 23b10c03091c..a553d99175cb 100644
> --- a/arch/arm64/boot/dts/renesas/Makefile
> +++ b/arch/arm64/boot/dts/renesas/Makefile
> @@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_R9A07G043) +=3D r9a07g043u11-
> smarc.dtb
>=20
>  dtb-$(CONFIG_ARCH_R9A07G044) +=3D r9a07g044c2-smarc.dtb
>  dtb-$(CONFIG_ARCH_R9A07G044) +=3D r9a07g044l2-smarc.dtb
> +dtb-$(CONFIG_ARCH_R9A07G044) +=3D r9a07g044l2-smarc-cru-csi-
> ov5645.dtbo
>=20
>  dtb-$(CONFIG_ARCH_R9A07G054) +=3D r9a07g054l2-smarc.dtb
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-
> ov5645.dtso b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-
> ov5645.dtso
> new file mode 100644
> index 000000000000..40cece1491bb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc-cru-csi-ov5645.dtso
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree overlay for the RZ/G2L SMARC EVK with OV5645 camera
> + * connected to CSI and CRU enabled.
> + *
> + * Copyright (C) 2023 Renesas Electronics Corp.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#define OV5645_PARENT_I2C i2c0
> +#include "rz-smarc-cru-csi-ov5645.dtsi"
> +
> +&ov5645 {
> +	enable-gpios =3D <&pinctrl RZG2L_GPIO(2, 0) GPIO_ACTIVE_HIGH>;
> +	reset-gpios =3D <&pinctrl RZG2L_GPIO(40, 2) GPIO_ACTIVE_LOW>;
> +};
> diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
> b/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
> new file mode 100644
> index 000000000000..95286bf2066e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common Device Tree for the RZ/G2L SMARC EVK (and alike EVKs) with
> + * OV5645 camera connected to CSI and CRU enabled.
> + *
> + * Copyright (C) 2023 Renesas Electronics Corp.
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>

Are either of these includes used in this file?
Or should they move to the overlay?

Kind regards, Chris

> +
> +&{/} {
> +	ov5645_vdddo_1v8: 1p8v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "camera_vdddo";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		regulator-always-on;
> +	};
> +
> +	ov5645_vdda_2v8: 2p8v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "camera_vdda";
> +		regulator-min-microvolt =3D <2800000>;
> +		regulator-max-microvolt =3D <2800000>;
> +		regulator-always-on;
> +	};
> +
> +	ov5645_vddd_1v5: 1p5v {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "camera_vddd";
> +		regulator-min-microvolt =3D <1500000>;
> +		regulator-max-microvolt =3D <1500000>;
> +		regulator-always-on;
> +	};
> +
> +	ov5645_fixed_clk: osc25250_clk {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <24000000>;
> +	};
> +};
> +
> +&cru {
> +	status =3D "okay";
> +};
> +
> +&csi2 {
> +	status =3D "okay";
> +
> +	ports {
> +		port@0 {
> +			csi2_in: endpoint {
> +				clock-lanes =3D <0>;
> +				data-lanes =3D <1 2>;
> +				remote-endpoint =3D <&ov5645_ep>;
> +			};
> +		};
> +	};
> +};
> +
> +&OV5645_PARENT_I2C {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	status =3D "okay";
> +
> +	ov5645: camera@3c {
> +		compatible =3D "ovti,ov5645";
> +		reg =3D <0x3c>;
> +		clocks =3D <&ov5645_fixed_clk>;
> +		clock-frequency =3D <24000000>;
> +		vdddo-supply =3D <&ov5645_vdddo_1v8>;
> +		vdda-supply =3D <&ov5645_vdda_2v8>;
> +		vddd-supply =3D <&ov5645_vddd_1v5>;
> +
> +		port {
> +			ov5645_ep: endpoint {
> +				clock-lanes =3D <0>;
> +				data-lanes =3D <1 2>;
> +				remote-endpoint =3D <&csi2_in>;
> +			};
> +		};
> +	};
> +};
> --
> 2.25.1

