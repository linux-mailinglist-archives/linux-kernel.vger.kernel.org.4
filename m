Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B76209E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiKHHOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKHHOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:14:22 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2121.outbound.protection.outlook.com [40.107.114.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36786120B6;
        Mon,  7 Nov 2022 23:14:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe8AnFbsIkLhN6241D1oX9nC2Nar8aFYCX34EyGEDHKJpJwaHBut/IBDRVtb1G+fT+hr0fGn6UtUZH6P8hhEqpXTYdzIW9Sd4m8PBpYETbicqqa7pW5aQazbCL+Ae2+vFKg9kpzS86wDeHmqU4x8oo8l6g/KXOOVOoSltyyslw43YVDUmiSDB6x7aadoiSNTPLOU9agDU0IpCCb9TZop3aOiOouQcGe+rzHqnyscmgDc/F5Hm4f3vIgc80foyXQq8NPi/jmJ+ibsZinpxbZ8uy0F60j3Ocl6xBCpZ7l0yeNQEKraYgjQWTY88p/tQIqofyyRyKYF4JgC2qDKDLhcfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Dpr4k5A1Gf7YrnHhYjO/kO6xwwbfrkzxW9vGXyNqy0=;
 b=MLXr5No0YKyHGkURnTmBcrqdbZUEYXStZnghinbOCkJ+5PbEsnp8WthGhZ/+kOe8+1h2pnCGb6cxO51a8EgOiMqj5v5UTmyWEPAq4fWGUcIEnYncw7AOtmkH5SH/KO+c6AilzXk2J7MblWF0Bpga8XdIoRdIWR6kRpRlLGYowKpZpmFHVLqg0JAGGspfOFyZObgiJHFBHFUdok9cHiFvKJfKMlhW8/uKfCMLYPJrwIDny6yBLSSnphHWhw9R6YKnJ8khnROG6m76ruuyqZP4iD8QIHEEMwJD9VcQmBOU+IDCqQa58NshIQKY8b7kxUV9dPbdY71ooTRnrjIHlxihlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Dpr4k5A1Gf7YrnHhYjO/kO6xwwbfrkzxW9vGXyNqy0=;
 b=vUe7Ti81K6nwc5br95x0soZRA+9hyN//WMBukZRPmWgUaWtMpv5yAnQ/bOX1m2/1FywsD8VNm/TjbjtaOhieo9dWM911pXfsvoxlOz5OeS9LILSqFTADb4VyYB1zeba168AoCPUeVWo9bUWgotDnB1a4RQHA1KeCuQ8WpYPGTrM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10794.jpnprd01.prod.outlook.com (2603:1096:400:296::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 07:14:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 07:14:14 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH RFC 2/5] pinctrl: renesas: rzg2l: Fix configuring the GPIO
 pins as interrupts
Thread-Topic: [PATCH RFC 2/5] pinctrl: renesas: rzg2l: Fix configuring the
 GPIO pins as interrupts
Thread-Index: AQHY8tHTw1YXCrAdj0KX+iZlhq0xQa40m+uw
Date:   Tue, 8 Nov 2022 07:14:14 +0000
Message-ID: <OS0PR01MB592295C7DBA5E0A85B4D26AF863F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221107175305.63975-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10794:EE_
x-ms-office365-filtering-correlation-id: c36819ea-3ef2-4c97-a119-08dac158d7ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PoJLz8twoQIulCs+oTHDN0fCzaJE/cJfu6w2qdFUoyS/Ys+Ky44jKsfyvD10OIQcCf9vgiyrLBaU5ash1M0qCPPy/mZgxfzqth6uLPvClaIXsTNmUmQoJtb6mwM0+lw3d1ALumAr4Rjulz5Ty8J8n65o08CFi2dShBghEZ+WNv5soI3tNe+7WY0qc5nDo1alH3URPZlOI5l+QZRCIP5mlP9++oYc6X65cubv7ea/veKQNQOWNbh3uRZlYQ1pBJda1bJ1GiAQed9uPcYIoiLDb4CFlzSy1PZ/6JxO6CvaytnV9/qikV+IaFTelqQgW2jxHbH4XmbYYVmaL0FcPpCy5d7LWNARnAAhwK5qEVtR2BgSqKc7EvGxDjsLDxYitajiZ7yprU77Vp1BmeFJh2FBoYtjGxYBkwYnJUR1N3AAWgyiODwp7y5OUhEsN966Qj9iJi4anAza2R63xSprmOZm/8Rk7QP/K/PVQW303b9skCvZWpCqqi23YvY2ydKDJB7i5SF1rbhYrHJSTXcV8A7Uo9wsjP+zBUjloXExVo6dLealL4KQfy9bdwBNgVSn2X0GiMme3C6FGUkANN153eu2BApYmvJoBUJtiRvd+4OkLCfvxSNTyG6koKaJ8SB9ub/u4hBPA9kbk51EFHf6FobMEBAZ+SfARaSsKdSVmLPqwQMHlH0fIEEKrset0u9UnQMZ+hEceOpSnciaCvdtRPISKN0qZ/nAs7nwc7whw0gwnzdW+FCLZFmSOiLnppErQ59AsVWTive3xmPmmdzt/yxhsNULki/mjMUSKAIJbf0Ubj8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199015)(33656002)(122000001)(38070700005)(86362001)(38100700002)(2906002)(55016003)(7416002)(5660300002)(83380400001)(107886003)(7696005)(186003)(6506007)(9686003)(26005)(66946007)(76116006)(966005)(54906003)(71200400001)(4326008)(478600001)(52536014)(316002)(66476007)(66556008)(66446008)(110136005)(64756008)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r5+wlI30y9/Ql4KCevqXAqgkcruwYJF91NyPm8lvyI2U7gyoi0CcDAMfe0Lv?=
 =?us-ascii?Q?dOztxsCOOR+5ehaiegX8Jr/FYQvf8y0afEkVi48HxXj7tQiK75rmC9D5d7HX?=
 =?us-ascii?Q?OJoKTMtDf+D8xapAGcgI9VS0ru5k/jtzj2YLS/LkfQa1jbCkBK4J/tJk6IV4?=
 =?us-ascii?Q?SbWO1G76OTjzFazdVQBqZkZ+p2gnuU2ndPH41JEBVCsK841mC1738uRYIGnl?=
 =?us-ascii?Q?HiUxryG05BP13Bdjd+HEyXglXHeniji3iTyWyLOoMzvcxllMgS3SpjuKNJWW?=
 =?us-ascii?Q?MfUD4JkEa7a/RxdzpSYnUiF6Z/ku/8tHcURJQy0J/NiUl/R2LStW1ZidMTIZ?=
 =?us-ascii?Q?pX4uF87NJ3N5ktJrNSMd4FAe86vXmD33Qz0vzRcOahhAZypGrMZEVBz08/cd?=
 =?us-ascii?Q?s0wqISRT4Ys1lnhwt1Ep6p+ntTgt/y4tERHq/FNvZ9D0RABTST1m82idzEnH?=
 =?us-ascii?Q?n0ZVZQ4dPOC2dp7u5AnXaT6cycCIXq4AL9OIvRCokY0sGpX8VMjARVipyEeV?=
 =?us-ascii?Q?dEmSHOPoi07XvKuGwbSuCCGIVEB0jN0tAPQJLN4e+ckBqb8XjYDDSHCysIZi?=
 =?us-ascii?Q?PYlG8TBhxQzKNpzdJvYFB394qTfQfdRFHzX8K2GwRLHXKODbnvp3TmAs3FBh?=
 =?us-ascii?Q?4Kl2lJGoe30f0w4+j/qfXpHTxYNfT18SQtm9ekejj+nWhZXBkm6d7ABQGlRC?=
 =?us-ascii?Q?Uty19q0vxtAHPZ2Sxnn6XeE3ohmRg3b7Q6hrqaBm8c4pgwMVJpCRNe+cFHGG?=
 =?us-ascii?Q?uP2TzO61LPSrP8cDtAvbDdT3hniF41L4Ooa4gEr0tUHcNGJFK20H7AsnLJfR?=
 =?us-ascii?Q?Cgq6sD2QML11cAkz5YmrfwGqpgyQIDw/ZyGrYiNN8Lx2yNXL8NTeaS7VOxGO?=
 =?us-ascii?Q?ciUxXM8pjRfe5xO8QPFW4yx4ObwJHzHX3KGBZISgW6EXAef2Z9C7UIFg3ggc?=
 =?us-ascii?Q?UT0S1lckml52CBTNQtlC3LTjnKbMww8ZODPM+p8a/D07sH2/YK/dpoNGDgK1?=
 =?us-ascii?Q?dPdZfqhaNyXDzmH29Dy/tgjRFhMyz3qMZYg80Wi4rSKIH0nkwH4F6pZSWZb1?=
 =?us-ascii?Q?F94vfH5IXy6OMc743QWswttq7QTkStI9xYw0ldBH+WT79OKL2nIWZHtMTGPb?=
 =?us-ascii?Q?Yfl2uo++cISk5dNCwyNWy7c0n4+EmEiFsQp4AB53Hu80l8MWVZj1qEmXdCZN?=
 =?us-ascii?Q?c8EA4lfR6xXQdGQU49clCV5zM3CPPBP97H9HqC4Af1ICnM2xaCwx4ymQOT3m?=
 =?us-ascii?Q?bi6j04FCHKH6jhXgnxEszx00M1Ds8PO4TggV+yypyD+ClUxSm2NWlbooeXnr?=
 =?us-ascii?Q?6wT6ryFzNFsoq8JJM2SImBHJ9zkneQRlEtqb/EEp/eMjkndaDRt+QxvBJoCQ?=
 =?us-ascii?Q?M8AqSxb9OzyON8q5gh+v6HkS24Du2onilAZ9zHCa64RhnExHkyFllPaksBcr?=
 =?us-ascii?Q?SLI0jQIG8QixmVxcF7DG1nLKsg/QzDcqw/MLv/FXj4QBnPVSng5iOBoACHId?=
 =?us-ascii?Q?PaifV/94iCa6+P4c5nWX2Y7VuOuodhuYzjkhf8HzwtrUghiO/bCqIHSX7ULh?=
 =?us-ascii?Q?nEmLiKn2mDdLT8x7KRPyF40adb76xgMuOOPvAsK0O1rZGWVjhCmow2i+lef9?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36819ea-3ef2-4c97-a119-08dac158d7ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 07:14:14.5887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4TUd+bsof3PJEnEtdGqkvkrLtDFxzElGTV1Wj0fAcVg+eSzJG6Vc+JYSS49SKbxGfCjUtMd5QRGTQ4KteZ1DY21VQzlbE4K31qbEtlwx6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10794
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,


> Subject: [PATCH RFC 2/5] pinctrl: renesas: rzg2l: Fix configuring the GPI=
O
> pins as interrupts
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> On the RZ/G2UL SoC we have less number of pins compared to RZ/G2L and als=
o
> the pin configs are completely different. This patch makes sure we use th=
e
> appropriate pin configs for each SoC (which is passed as part of the OF
> data) while configuring the GPIO pin as interrupts instead of using
> rzg2l_gpio_configs[] for all the SoCs.
>=20

Looks like you are missing fixes tag.
Fixes: db2e5f21a48ed ("pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to h=
andle GPIO interrupt")

As we have already pinctrl support for RZ/G2UL [1]
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/pinctrl/renesas/pinctrl-rzg2l.c?h=3Dv6.1-rc4&id=3Dbfc69bdbaad141=
ac408e6de86b7e0d771c8e3ccb

Cheers,
Biju

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index a43824fd9505..dcc495baa678 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -127,6 +127,7 @@ struct rzg2l_dedicated_configs {  struct
> rzg2l_pinctrl_data {
>  	const char * const *port_pins;
>  	const u32 *port_pin_configs;
> +	unsigned int n_port_pin_configs;
>  	struct rzg2l_dedicated_configs *dedicated_pins;
>  	unsigned int n_port_pins;
>  	unsigned int n_dedicated_pins;
> @@ -1122,7 +1123,7 @@ static struct {
>  	}
>  };
>=20
> -static int rzg2l_gpio_get_gpioint(unsigned int virq)
> +static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct
> +rzg2l_pinctrl_data *data)
>  {
>  	unsigned int gpioint;
>  	unsigned int i;
> @@ -1131,13 +1132,13 @@ static int rzg2l_gpio_get_gpioint(unsigned int vi=
rq)
>  	port =3D virq / 8;
>  	bit =3D virq % 8;
>=20
> -	if (port >=3D ARRAY_SIZE(rzg2l_gpio_configs) ||
> -	    bit >=3D RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
> +	if (port >=3D data->n_port_pin_configs ||
> +	    bit >=3D RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[port]))
>  		return -EINVAL;
>=20
>  	gpioint =3D bit;
>  	for (i =3D 0; i < port; i++)
> -		gpioint +=3D RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]);
> +		gpioint +=3D RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[i]);
>=20
>  	return gpioint;
>  }
> @@ -1237,7 +1238,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct
> gpio_chip *gc,
>  	unsigned long flags;
>  	int gpioint, irq;
>=20
> -	gpioint =3D rzg2l_gpio_get_gpioint(child);
> +	gpioint =3D rzg2l_gpio_get_gpioint(child, pctrl->data);
>  	if (gpioint < 0)
>  		return gpioint;
>=20
> @@ -1311,8 +1312,8 @@ static void rzg2l_init_irq_valid_mask(struct gpio_c=
hip
> *gc,
>  		port =3D offset / 8;
>  		bit =3D offset % 8;
>=20
> -		if (port >=3D ARRAY_SIZE(rzg2l_gpio_configs) ||
> -		    bit >=3D RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
> +		if (port >=3D pctrl->data->n_port_pin_configs ||
> +		    bit >=3D
> +RZG2L_GPIO_PORT_GET_PINCNT(pctrl->data->port_pin_configs[port]))
>  			clear_bit(offset, valid_mask);
>  	}
>  }
> @@ -1517,6 +1518,7 @@ static int rzg2l_pinctrl_probe(struct platform_devi=
ce
> *pdev)  static struct rzg2l_pinctrl_data r9a07g043_data =3D {
>  	.port_pins =3D rzg2l_gpio_names,
>  	.port_pin_configs =3D r9a07g043_gpio_configs,
> +	.n_port_pin_configs =3D ARRAY_SIZE(r9a07g043_gpio_configs),
>  	.dedicated_pins =3D rzg2l_dedicated_pins.common,
>  	.n_port_pins =3D ARRAY_SIZE(r9a07g043_gpio_configs) *
> RZG2L_PINS_PER_PORT,
>  	.n_dedicated_pins =3D ARRAY_SIZE(rzg2l_dedicated_pins.common),
> @@ -1525,6 +1527,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D=
 {
> static struct rzg2l_pinctrl_data r9a07g044_data =3D {
>  	.port_pins =3D rzg2l_gpio_names,
>  	.port_pin_configs =3D rzg2l_gpio_configs,
> +	.n_port_pin_configs =3D ARRAY_SIZE(rzg2l_gpio_configs),
>  	.dedicated_pins =3D rzg2l_dedicated_pins.common,
>  	.n_port_pins =3D ARRAY_SIZE(rzg2l_gpio_names),
>  	.n_dedicated_pins =3D ARRAY_SIZE(rzg2l_dedicated_pins.common) +
> --
> 2.25.1

