Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D889D613442
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJaLNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaLNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:13:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20595DEF2;
        Mon, 31 Oct 2022 04:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyTrDoyIdgMIIqonbzlKhAaOi76h0b45KvKEzvfefjj3Vm+BMO97us1ayDPeBhZLXuuEC/PX9SxnRlZyjTpQnrYbR+v1Ge4bG0tZTwXrDBEqIMj0nGrywh8vNQwiq6f+nIRteoYnhg56yRg8CWdlzyoRrPYsdi/QQPUlbbTQaKIaGxhBhKnqq3ud01PKJN120/PRafZ5h11/gMegSshd29cyUQWTSWvUjaRHgvhHf09b4AiODc6EqG/DSPJiB8pFnQL6YpfFDzLW1Z+4FGb0qlkypj3go///NvAN2/u3RwCXFZUlVwPCjZO1/zIWD+I5D0vLhh68tITtyHxNTlB88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2skmIrDLeRjx3XFqxvzNfuFedOydxHo1vPj2i9nqtss=;
 b=mOmt/ShuDDh/WjINh9Je74leVf9NFqstNldrSKcgv+TbZvtgWTIjuTCxzyvAog+TgYCE/VoNTRedx8jzpGiIU/uoAjYrQBEWTMtvtPaSHhxUk+aG/CAYFImt51AUDUPfc5sSZBOWDkJWdrS4FqA1CNm6EoiVtrQh91e7KyaUUHAg54mH2Ow11yi0H1qg59/En6aEMYKagnrcJ2V3z0Ektzf+MGujUqqFv2iMaUCanzSG70LIu7q+Zmb49mOhYebrQziWRiYwMvQtnW9T7rkcmzoZFLKowmSnAYq3oe3rOro3O9NQiFSfS9tiNktU48NjNGNkCrbP9gzIwUOBlfyYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2skmIrDLeRjx3XFqxvzNfuFedOydxHo1vPj2i9nqtss=;
 b=Ra52r4jPWoF82f84J+/nrfiOG98YnslYnwUIKtKy6NEt0kg5dhuvav0u4TaOKKfxKwZIqDTTtPM4Mz8bc4tskWvrx53mM1ESa/DjlJo08W1bpuGihAwyZRG0JeJFYQxjFgS51BFHO/kj3Y5sEWDmME7qxaG3ha9aamvj/1FM/48=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5925.jpnprd01.prod.outlook.com (2603:1096:604:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 11:13:43 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 11:13:43 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jerome Neanne <jneanne@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jeff@labundy.com" <jeff@labundy.com>
CC:     "afd@ti.com" <afd@ti.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "j-keerthy@ti.com" <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: RE: [PATCH v5 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Thread-Topic: [PATCH v5 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Thread-Index: AQHYyENwfeSoLjmHiU+cGdhL0pREk64ooH3w
Date:   Mon, 31 Oct 2022 11:13:43 +0000
Message-ID: <OS0PR01MB59221A8415766E7E3615F39E86379@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220914140758.7582-1-jneanne@baylibre.com>
 <20220914140758.7582-5-jneanne@baylibre.com>
In-Reply-To: <20220914140758.7582-5-jneanne@baylibre.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5925:EE_
x-ms-office365-filtering-correlation-id: 5b2b8e70-3491-4ab9-e3e2-08dabb30f8b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GB+H+oeefoimU/3uBoT7/dT6elHMQPlz1QOW8e89CTlODSCW9T97EnxoNBRHG2cma7jEkw6vMq9zvSuYb6uSUNFLBzZgkMtZlWyhm9tcbPX2hG3pFrqeWhvL0T5mNs7dvGlrvw5x/Saz9zWX5KYqGrB8esmC8HucLvGZjSlWnwffrTjerqVZN31DMfZFuWisNyWkArSW4Ve6L/bjNbb6yKu/N1LbvryfEjI1G2reKcvwHCuXBlPvdlfx3hVk4uvwR1IjkGPt2F+cwmIWGPsdEGeULQ+XxaLBYKHvCK3QM1kCz2OtxumETibPUAZVbUjY2IvIVPawVQgvr1O5R9Cyl1d4zotfR3RL1GVvNsFFdRao0SFrjFtGRo1nXEpkpK2ghZYhVO/nZRLg5iGlTHn9SBsKGM+eGvOsL28gFA4X6xOMMy31VPISP1VzKI03lfU8HhhmQjVZfGniREfJPEMfMQB0JDJW8sWL1OfqbI3aWD0oSRTUjp4B+7T8pRgOAIKRu0doOYzyf4xgaChcFup/LazkAAMuDDJOYlO3f9T6jQAmxeTmWNDxx8syveF4wvT8+1b42Apl9G/zdiR6NhKWandbX0181Og9v7ml0+bqUCOreYI85Bi6o6u8yAUgUhN8O/BUGfe5ML0EGAQZz47N9bm9gacgRZV87a2ImmkKr7OKas18/ZhHk3YnO+4hTIMtuZqeSfBMtR7DW82vhTD21YMVV3DSeIeCAPwH1f18AinuXEHt1JrumyvK8XkEz0NmGQgx1gq3Y9juJVqzXk5G/QCdIk3wef2DB+sTDPPhOXoMwJQ9VVdo4CH6wlFEJosA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199015)(921005)(122000001)(38070700005)(38100700002)(55016003)(86362001)(33656002)(71200400001)(2906002)(30864003)(478600001)(66946007)(4326008)(7406005)(316002)(66476007)(66446008)(66556008)(8676002)(7416002)(110136005)(45080400002)(64756008)(5660300002)(54906003)(7696005)(6506007)(41300700001)(52536014)(8936002)(76116006)(186003)(9686003)(26005)(83380400001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T3eMj+m3PytBSlEE39Lo4EFMqf+PoRYalYreyLTwIE2wvfwACLKhaSdum84D?=
 =?us-ascii?Q?HbRpKfAFeqpPFuvPGaXowdyqYa7+UA9DDUmLOA4/z/FbbMWWUpfbg4lv1kFE?=
 =?us-ascii?Q?s9p6YN5Z5x+9ha4aP03Z/5Zj/sibqK3Br5Zkfgl+8pQLqU9BEiCpoPXCDK/4?=
 =?us-ascii?Q?tq9x2bIc4fy6Wo8voidDWLE3qgZHS4Y2qN0Dw9hSOQOMxQceZtWFSmCidqsG?=
 =?us-ascii?Q?tPNczBGblnh6DXrX9s04GZQMBbEZFWeCk0bslXL0hhfFqx+WHmsX/6D5fcHp?=
 =?us-ascii?Q?aUbsKmsJ1/GsD/auwm4AjhsbJvsCZcGl93dgfjNxieY6L5h6jNx44bIQ8vwG?=
 =?us-ascii?Q?uBePVsf+X7kbq8Lrdset2UXnj8QKO8jB+loPUtg04IXOLlsgJhIu2uK6GrBf?=
 =?us-ascii?Q?Q68tSVtfFKiIOmINWKAPE+KphpuiWLMR+ak3McOYCrZrJjNMcwJbHOUnRx8R?=
 =?us-ascii?Q?ol7UDw/uP6XrJcqw9cIHPfm74fzq6jk6kdseJFwW+r0DcAeqLfPYgvDHtK3o?=
 =?us-ascii?Q?pDKD/BN5Id98AO5drrqU69Ymr/6nNFd31ss/dX5kg/Dqv0nSEk1roJAXwk1g?=
 =?us-ascii?Q?1LfG071UbkggOKJmuFEEnDABFTqQZCpf1OM1pGyf78rQ5zq5PZZVr5mS8RtK?=
 =?us-ascii?Q?qLLkkrbjA9PCu8Qr71jbMXJX6e0qq7BSqgc7WmnDvytk086QBSAhqgbTdhGH?=
 =?us-ascii?Q?YNKW9okPwHfpDbj+mlaw2lILGZSXC1EVJGu+wSkW1oigi5ZnggUNLiFZ0EWU?=
 =?us-ascii?Q?6H8gpROH0pTjWXU05k8JC4GWtdY1wrGDrIq1J2910+Skt8FXXZtAkBoJOWWJ?=
 =?us-ascii?Q?PvYtUN7uQvbGSi3vQ53QajqNK3Am9c4ybnibtgSPS/x8lKhGfwHnebHRnl8g?=
 =?us-ascii?Q?pDBBlCfIzB8nBBLgnrjC4JXaYV6o7sEUpTKzYU9k0ysm8qgXYdTirLfSauaO?=
 =?us-ascii?Q?XevDx/FxX3OoU1HXrIw/s81chVK4QA4/K/JnCbcQoWTZsZsadUEvqL0M802l?=
 =?us-ascii?Q?XNZR7ybVMxC76nXFskWtnVXJ+7d+p1EBdYyTohFT1pT32ClqlzGQgpzQ/yag?=
 =?us-ascii?Q?nKhOa3rfvytY9x+9X4jw2BEU6wtp171f7F8rPl9yGDzChQ6v8rz2L/zMTgiT?=
 =?us-ascii?Q?KnDxVDMDX5NRlDLv9eiExh0GGTSGYvidwLrtnwNWOhJ7fou1zM8v/lYEJ2fM?=
 =?us-ascii?Q?R/bmftEslSnew5Jt0b+z/MiKNWAo+ZCGwo0Jnc4SYg9GhZkdjrA6Tlo+qAtm?=
 =?us-ascii?Q?6+xtxC5jsxDPsmumbHLb6OPG05rt8TpMvDbgIg1tJgX/ZjcECCTcB47wwgjG?=
 =?us-ascii?Q?cA/MQAxcpS2yZa/M7c/P8djBAxu8XvTzIcVRYJryqpeoI8Ylg77mAHyP2cRP?=
 =?us-ascii?Q?cOrKLdujg66cTvFYYMiHruGGk9ZiqpdtdPAqLa97z8eeLVhA7Isv+BGop/MJ?=
 =?us-ascii?Q?Nod7xbSVPTrhnKi6vXMuITiBz4g5arfSS+7rrm4r+e1kNja8BLgvwRTk5hO7?=
 =?us-ascii?Q?TP3qnhPyjWVDCMwDn1nSIcqpW80lfWAQrzGmqxJPnkkHUYyurLCNwdwMrCXi?=
 =?us-ascii?Q?aIEfruIGPAx48vaECxPH0/uI5olnu27nUNqoUbR3BOHwFjyjwNOh4K9OZBKZ?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2b8e70-3491-4ab9-e3e2-08dabb30f8b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 11:13:43.1397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LoQVy7GIaghEOsFoXCajwQvV3nQeqwuVEZxefM48J+9C5jX5MDizJ4w+8/OvUKaEcLDzzyZTzjgVo1EHBdNQx8ttOdl7Rmt8P8TdiMYZYGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5925
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Subject: [PATCH v5 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
>=20
> The TPS65219 is a power management IC PMIC designed to supply a wide rang=
e
> of SoCs in both portable and stationary applications. Any SoC can control
> TPS65219 over a standard I2C interface.
>=20
> It contains the following components:
> - Regulators.
> - Over Temperature warning and Shut down.
> - GPIOs
> - Multi Function Pins (MFP)
> - power-button
>=20
> This patch adds support for tps65219 PMIC. At this time only the
> functionalities listed below are made available:
>=20
> - Regulators probe and functionalities
> - warm and cold reset support
> - SW shutdown support
> - Regulator warnings via IRQs
> - Power-button via IRQ
>=20
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  MAINTAINERS                  |   1 +
>  drivers/mfd/Kconfig          |  14 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/tps65219.c       | 320 ++++++++++++++++++++++++++++++++
>  include/linux/mfd/tps65219.h | 345 +++++++++++++++++++++++++++++++++++
>  5 files changed, 681 insertions(+)
>  create mode 100644 drivers/mfd/tps65219.c  create mode 100644
> include/linux/mfd/tps65219.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f35b29ffd5fb..960df879c635 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14926,6 +14926,7 @@ F:	drivers/mfd/menelaus.c
>  F:	drivers/mfd/palmas.c
>  F:	drivers/mfd/tps65217.c
>  F:	drivers/mfd/tps65218.c
> +F:	drivers/mfd/tps65219.c
>  F:	drivers/mfd/tps65910.c
>  F:	drivers/mfd/twl-core.[ch]
>  F:	drivers/mfd/twl4030*.c
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index
> abb58ab1a1a4..1a846c7dd0c2 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1576,6 +1576,20 @@ config MFD_TPS65218
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tps65218.
>=20
> +config MFD_TPS65219
> +	tristate "TI TPS65219 Power Management IC"
> +	depends on I2C && OF
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  If you say yes here you get support for the TPS65219 series of
> Power
> +	  Management ICs. These include voltage regulators, GPIOs and
> +	  push/power button that are often used in portable devices.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called tps65219.
> +
>  config MFD_TPS6586X
>  	bool "TI TPS6586x Power Management chips"
>  	depends on I2C=3Dy
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile index
> 858cacf659d6..a8ff3d6ea3ab 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_TPS6507X)		+=3D tps6507x.o
>  obj-$(CONFIG_MFD_TPS65086)	+=3D tps65086.o
>  obj-$(CONFIG_MFD_TPS65217)	+=3D tps65217.o
>  obj-$(CONFIG_MFD_TPS65218)	+=3D tps65218.o
> +obj-$(CONFIG_MFD_TPS65219)	+=3D tps65219.o
>  obj-$(CONFIG_MFD_TPS65910)	+=3D tps65910.o
>  obj-$(CONFIG_MFD_TPS65912)	+=3D tps65912-core.o
>  obj-$(CONFIG_MFD_TPS65912_I2C)	+=3D tps65912-i2c.o
> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c new file mod=
e
> 100644 index 000000000000..c1638483e069
> --- /dev/null
> +++ b/drivers/mfd/tps65219.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Driver for TPS65219 Integrated Power Management Integrated Chips
> +(PMIC) // // Copyright (C) 2022 BayLibre Incorporated -
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>

Do you need all the includes??

> +
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/tps65219.h>
> +
> +static int tps65219_warm_reset(struct tps65219 *tps) {
> +	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
> +				  TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK,
> +				  TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK);
> +}
> +
> +static int tps65219_cold_reset(struct tps65219 *tps) {
> +	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
> +				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK,
> +				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK);
> +}
> +
> +static int tps65219_soft_shutdown(struct tps65219 *tps) {
> +	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
> +				  TPS65219_MFP_I2C_OFF_REQ_MASK,
> +				  TPS65219_MFP_I2C_OFF_REQ_MASK);
> +}
> +
> +static int tps65219_restart(struct notifier_block *this,
> +			    unsigned long reboot_mode, void *cmd) {
> +	struct tps65219 *tps;
> +
> +	tps =3D container_of(this, struct tps65219, nb);
> +	if (!tps) {
> +		pr_err("tps65219: Restarting failed because the pointer to
> tps65219 is invalid\n");
Why not dev_error?

Cheers,
Biju
> +		return -ENODEV;
> +	}
> +	if (reboot_mode =3D=3D REBOOT_WARM)
> +		tps65219_warm_reset(tps);
> +	else
> +		tps65219_cold_reset(tps);
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block pmic_rst_restart_nb =3D {
> +	.notifier_call =3D tps65219_restart,
> +	.priority =3D 200,
> +};
> +
> +static const struct resource tps65219_pwrbutton_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_FALLING_EDGE_DETECT,
> "falling"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_RISING_EDGE_DETECT, "rising"),
> };
> +
> +static const struct resource tps65219_regulator_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_SCG, "LDO3_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_OC, "LDO3_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_UV, "LDO3_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_SCG, "LDO4_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_OC, "LDO4_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_UV, "LDO4_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_SCG, "LDO1_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_OC, "LDO1_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_UV, "LDO1_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_SCG, "LDO2_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_OC, "LDO2_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_UV, "LDO2_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_SCG, "BUCK3_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_OC, "BUCK3_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_NEG_OC, "BUCK3_NEG_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_UV, "BUCK3_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_SCG, "BUCK1_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_OC, "BUCK1_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_NEG_OC, "BUCK1_NEG_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_UV, "BUCK1_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_SCG, "BUCK2_SCG"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_OC, "BUCK2_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_NEG_OC, "BUCK2_NEG_OC"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_UV, "BUCK2_UV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_RV, "BUCK1_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_RV, "BUCK2_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_RV, "BUCK3_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_RV, "LDO1_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_RV, "LDO2_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_RV, "LDO3_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_RV, "LDO4_RV"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK1_RV_SD, "BUCK1_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK2_RV_SD, "BUCK2_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_BUCK3_RV_SD, "BUCK3_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO1_RV_SD, "LDO1_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO2_RV_SD, "LDO2_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO3_RV_SD, "LDO3_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_LDO4_RV_SD, "LDO4_RV_SD"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_TIMEOUT, "TIMEOUT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_3_WARM, "SENSOR_3_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_2_WARM, "SENSOR_2_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_1_WARM, "SENSOR_1_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_0_WARM, "SENSOR_0_WARM"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_3_HOT, "SENSOR_3_HOT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_2_HOT, "SENSOR_2_HOT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_1_HOT, "SENSOR_1_HOT"),
> +	DEFINE_RES_IRQ_NAMED(TPS65219_INT_SENSOR_0_HOT, "SENSOR_0_HOT"), };
> +
> +static const struct mfd_cell tps65219_cells[] =3D {
> +	{
> +		.name =3D "tps65219-regulator",
> +		.resources =3D tps65219_regulator_resources,
> +		.num_resources =3D ARRAY_SIZE(tps65219_regulator_resources),
> +	}, {
> +		.name =3D "tps65219-gpios",
> +	},
> +};
> +
> +static const struct mfd_cell tps65219_pwrbutton_cell =3D {
> +	.name =3D "tps65219-pwrbutton",
> +	.resources =3D tps65219_pwrbutton_resources,
> +	.num_resources =3D ARRAY_SIZE(tps65219_pwrbutton_resources),
> +};
> +
> +static const struct regmap_config tps65219_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D TPS65219_REG_FACTORY_CONFIG_2, };
> +
> +/*
> + * Mapping of main IRQ register bits to sub-IRQ register offsets so
> +that we can
> + * access corect sub-IRQ registers based on bits that are set in main
> +IRQ
> + * register.
> + */
> +/* Timeout Residual Voltage Shutdown */ static unsigned int
> +bit0_offsets[] =3D { TPS65219_REG_INT_TO_RV_POS };
> +static unsigned int bit1_offsets[] =3D { TPS65219_REG_INT_RV_POS };	/*
> Residual Voltage */
> +static unsigned int bit2_offsets[] =3D { TPS65219_REG_INT_SYS_POS };	/*
> System */
> +static unsigned int bit3_offsets[] =3D { TPS65219_REG_INT_BUCK_1_2_POS }=
;
> 	/* Buck 1-2 */
> +static unsigned int bit4_offsets[] =3D { TPS65219_REG_INT_BUCK_3_POS };	=
/*
> Buck 3 */
> +static unsigned int bit5_offsets[] =3D { TPS65219_REG_INT_LDO_1_2_POS };=
	/*
> LDO 1-2 */
> +static unsigned int bit6_offsets[] =3D { TPS65219_REG_INT_LDO_3_4_POS };=
	/*
> LDO 3-4 */
> +static unsigned int bit7_offsets[] =3D { TPS65219_REG_INT_PB_POS };	/*
> Power Button */
> +
> +static struct regmap_irq_sub_irq_map tps65219_sub_irq_offsets[] =3D {
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit2_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit3_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit4_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit5_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit6_offsets),
> +	REGMAP_IRQ_MAIN_REG_OFFSET(bit7_offsets),
> +};
> +
> +#define TPS65219_REGMAP_IRQ_REG(int_name, register_position) \
> +	REGMAP_IRQ_REG(int_name, register_position, int_name##_MASK)
> +
> +static struct regmap_irq tps65219_irqs[] =3D {
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO3_SCG,
> TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO3_OC,
> TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO3_UV,
> TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO4_SCG,
> TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO4_OC,
> TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO4_UV,
> TPS65219_REG_INT_LDO_3_4_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO1_SCG,
> TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO1_OC,
> TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO1_UV,
> TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO2_SCG,
> TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO2_OC,
> TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO2_UV,
> TPS65219_REG_INT_LDO_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_SCG,
> TPS65219_REG_INT_BUCK_3_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_OC,
> TPS65219_REG_INT_BUCK_3_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_NEG_OC,
> TPS65219_REG_INT_BUCK_3_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_UV,
> TPS65219_REG_INT_BUCK_3_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_SCG,
> TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_OC,
> TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_NEG_OC,
> TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_UV,
> TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_SCG,
> TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_OC,
> TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_NEG_OC,
> TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_UV,
> TPS65219_REG_INT_BUCK_1_2_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_3_WARM,
> TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_2_WARM,
> TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_1_WARM,
> TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_0_WARM,
> TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_3_HOT,
> TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_2_HOT,
> TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_1_HOT,
> TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_SENSOR_0_HOT,
> TPS65219_REG_INT_SYS_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_RV,
> TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_RV,
> TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_RV,
> TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO1_RV,
> TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO2_RV,
> TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO3_RV,
> TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO4_RV,
> TPS65219_REG_INT_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK1_RV_SD,
> TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK2_RV_SD,
> TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_BUCK3_RV_SD,
> TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO1_RV_SD,
> TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO2_RV_SD,
> TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO3_RV_SD,
> TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_LDO4_RV_SD,
> TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_TIMEOUT,
> TPS65219_REG_INT_TO_RV_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_PB_FALLING_EDGE_DETECT,
> TPS65219_REG_INT_PB_POS),
> +	TPS65219_REGMAP_IRQ_REG(TPS65219_INT_PB_RISING_EDGE_DETECT,
> +TPS65219_REG_INT_PB_POS), };
> +
> +static struct regmap_irq_chip tps65219_irq_chip =3D {
> +	.name =3D "tps65219_irq",
> +	.main_status =3D TPS65219_REG_INT_SOURCE,
> +	.num_main_regs =3D 1,
> +	.num_main_status_bits =3D 8,
> +	.irqs =3D tps65219_irqs,
> +	.num_irqs =3D ARRAY_SIZE(tps65219_irqs),
> +	.status_base =3D TPS65219_REG_INT_LDO_3_4,
> +	.ack_base =3D TPS65219_REG_INT_LDO_3_4,
> +	.clear_ack =3D 1,
> +	.num_regs =3D 8,
> +	.sub_reg_offsets =3D tps65219_sub_irq_offsets, };
> +
> +static int tps65219_probe(struct i2c_client *client) {
> +	struct tps65219 *tps;
> +	unsigned int chipid;
> +	bool pwr_button;
> +	int ret;
> +
> +	tps =3D devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
> +	if (!tps)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, tps);
> +
> +	tps->dev =3D &client->dev;
> +
> +	tps->regmap =3D devm_regmap_init_i2c(client, &tps65219_regmap_config);
> +	if (IS_ERR(tps->regmap)) {
> +		ret =3D PTR_ERR(tps->regmap);
> +		dev_err(tps->dev, "Failed to allocate register map: %d\n",
> ret);
> +		return ret;
> +	}
> +
> +	ret =3D devm_regmap_add_irq_chip(&client->dev, tps->regmap, client-
> >irq,
> +				       IRQF_ONESHOT, 0, &tps65219_irq_chip,
> +				       &tps->irq_data);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(tps->regmap, TPS65219_REG_TI_DEV_ID, &chipid);
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to read device ID: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D devm_mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO,
> +				   tps65219_cells, ARRAY_SIZE(tps65219_cells),
> +				   NULL, 0, regmap_irq_get_domain(tps->irq_data));
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to add child devices: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pwr_button =3D of_property_read_bool(tps->dev->of_node, "ti,power-
> button");
> +	if (pwr_button) {
> +		ret =3D devm_mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO,
> +					   &tps65219_pwrbutton_cell, 1, NULL, 0,
> +					   regmap_irq_get_domain(tps->irq_data));
> +		if (ret) {
> +			dev_err(tps->dev, "Failed to add power-button: %d\n",
> ret);
> +			return ret;
> +		}
> +	}
> +
> +	tps->nb =3D pmic_rst_restart_nb;
> +	ret =3D register_restart_handler(&tps->nb);
> +	if (ret) {
> +		dev_err(tps->dev, "cannot register restart handler, %d\n",
> ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_tps65219_match_table[] =3D {
> +	{ .compatible =3D "ti,tps65219", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_tps65219_match_table);
> +
> +static struct i2c_driver tps65219_driver =3D {
> +	.driver		=3D {
> +		.name	=3D "tps65219",
> +		.of_match_table =3D of_tps65219_match_table,
> +	},
> +	.probe_new	=3D tps65219_probe,
> +};
> +module_i2c_driver(tps65219_driver);
> +
> +MODULE_AUTHOR("Jerome Neanne <jneanne@baylibre.com>");
> +MODULE_DESCRIPTION("TPS65219 power management IC driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
> new file mode 100644 index 000000000000..2c1cf92e92ac
> --- /dev/null
> +++ b/include/linux/mfd/tps65219.h
> @@ -0,0 +1,345 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Functions to access TPS65219 power management IC.
> + *
> + * Copyright (C) 2022 BayLibre Incorporated -
> +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.=
b
> +aylibre.com%2F&amp;data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7C13cf6=
2
> +f23ce0455a0cb108da965a913f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7
> +C637987612976950969%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
> +iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DQnc1=
a
> +xUPdLWQwakr2eqFbc1IS7KeQY23oMJjMwc0A44%3D&amp;reserved=3D0
> + */
> +
> +#ifndef MFD_TPS65219_H
> +#define MFD_TPS65219_H
> +
> +#include <linux/bitops.h>
> +#include <linux/notifier.h>
> +#include <linux/regulator/driver.h>
> +
> +struct regmap;
> +struct regmap_irq_chip_data;
> +
> +#define TPS65219_1V35					1350000
> +#define TPS65219_1V8					1800000
> +
> +/* TPS chip id list */
> +#define TPS65219					0xF0
> +
> +/* I2C ID for TPS65219 part */
> +#define TPS65219_I2C_ID					0x24
> +
> +/* All register addresses */
> +#define TPS65219_REG_TI_DEV_ID				0x00
> +#define TPS65219_REG_NVM_ID				0x01
> +#define TPS65219_REG_ENABLE_CTRL			0x02
> +#define TPS65219_REG_BUCKS_CONFIG			0x03
> +#define TPS65219_REG_LDO4_VOUT				0x04
> +#define TPS65219_REG_LDO3_VOUT				0x05
> +#define TPS65219_REG_LDO2_VOUT				0x06
> +#define TPS65219_REG_LDO1_VOUT				0x07
> +#define TPS65219_REG_BUCK3_VOUT				0x8
> +#define TPS65219_REG_BUCK2_VOUT				0x9
> +#define TPS65219_REG_BUCK1_VOUT				0xA
> +#define TPS65219_REG_LDO4_SEQUENCE_SLOT			0xB
> +#define TPS65219_REG_LDO3_SEQUENCE_SLOT			0xC
> +#define TPS65219_REG_LDO2_SEQUENCE_SLOT			0xD
> +#define TPS65219_REG_LDO1_SEQUENCE_SLOT			0xE
> +#define TPS65219_REG_BUCK3_SEQUENCE_SLOT		0xF
> +#define TPS65219_REG_BUCK2_SEQUENCE_SLOT		0x10
> +#define TPS65219_REG_BUCK1_SEQUENCE_SLOT		0x11
> +#define TPS65219_REG_nRST_SEQUENCE_SLOT			0x12
> +#define TPS65219_REG_GPIO_SEQUENCE_SLOT			0x13
> +#define TPS65219_REG_GPO2_SEQUENCE_SLOT			0x14
> +#define TPS65219_REG_GPO1_SEQUENCE_SLOT			0x15
> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_1		0x16
> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_2		0x17
> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_3		0x18
> +#define TPS65219_REG_POWER_UP_SLOT_DURATION_4		0x19
> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_1		0x1A
> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_2		0x1B
> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_3		0x1C
> +#define TPS65219_REG_POWER_DOWN_SLOT_DURATION_4		0x1D
> +#define TPS65219_REG_GENERAL_CONFIG			0x1E
> +#define TPS65219_REG_MFP_1_CONFIG			0x1F
> +#define TPS65219_REG_MFP_2_CONFIG			0x20
> +#define TPS65219_REG_STBY_1_CONFIG			0x21
> +#define TPS65219_REG_STBY_2_CONFIG			0x22
> +#define TPS65219_REG_OC_DEGL_CONFIG			0x23
> +/* 'sub irq' MASK registers */
> +#define TPS65219_REG_INT_MASK_UV			0x24
> +#define TPS65219_REG_MASK_CONFIG			0x25
> +
> +#define TPS65219_REG_I2C_ADDRESS_REG			0x26
> +#define TPS65219_REG_USER_GENERAL_NVM_STORAGE		0x27
> +#define TPS65219_REG_MANUFACTURING_VER			0x28
> +#define TPS65219_REG_MFP_CTRL				0x29
> +#define TPS65219_REG_DISCHARGE_CONFIG			0x2A
> +/* main irq registers */
> +#define TPS65219_REG_INT_SOURCE				0x2B
> +/* 'sub irq' registers */
> +#define TPS65219_REG_INT_LDO_3_4			0x2C
> +#define TPS65219_REG_INT_LDO_1_2			0x2D
> +#define TPS65219_REG_INT_BUCK_3				0x2E
> +#define TPS65219_REG_INT_BUCK_1_2			0x2F
> +#define TPS65219_REG_INT_SYSTEM				0x30
> +#define TPS65219_REG_INT_RV				0x31
> +#define TPS65219_REG_INT_TIMEOUT_RV_SD			0x32
> +#define TPS65219_REG_INT_PB				0x33
> +
> +#define TPS65219_REG_INT_LDO_3_4_POS			0
> +#define TPS65219_REG_INT_LDO_1_2_POS			1
> +#define TPS65219_REG_INT_BUCK_3_POS			2
> +#define TPS65219_REG_INT_BUCK_1_2_POS			3
> +#define TPS65219_REG_INT_SYS_POS			4
> +#define TPS65219_REG_INT_RV_POS				5
> +#define TPS65219_REG_INT_TO_RV_POS			6
> +#define TPS65219_REG_INT_PB_POS				7
> +
> +#define TPS65219_REG_USER_NVM_CMD			0x34
> +#define TPS65219_REG_POWER_UP_STATUS			0x35
> +#define TPS65219_REG_SPARE_2				0x36
> +#define TPS65219_REG_SPARE_3				0x37
> +#define TPS65219_REG_FACTORY_CONFIG_2			0x41
> +
> +/* Register field definitions */
> +#define TPS65219_DEVID_REV_MASK				GENMASK(7, 0)
> +#define TPS65219_BUCKS_LDOS_VOUT_VSET_MASK		GENMASK(5, 0)
> +#define TPS65219_BUCKS_UV_THR_SEL_MASK			BIT(6)
> +#define TPS65219_BUCKS_BW_SEL_MASK			BIT(7)
> +#define LDO_BYP_SHIFT					6
> +#define TPS65219_LDOS_BYP_CONFIG_MASK			BIT(LDO_BYP_SHIFT)
> +#define TPS65219_LDOS_LSW_CONFIG_MASK			BIT(7)
> +/* Regulators enable control */
> +#define TPS65219_ENABLE_BUCK1_EN_MASK			BIT(0)
> +#define TPS65219_ENABLE_BUCK2_EN_MASK			BIT(1)
> +#define TPS65219_ENABLE_BUCK3_EN_MASK			BIT(2)
> +#define TPS65219_ENABLE_LDO1_EN_MASK			BIT(3)
> +#define TPS65219_ENABLE_LDO2_EN_MASK			BIT(4)
> +#define TPS65219_ENABLE_LDO3_EN_MASK			BIT(5)
> +#define TPS65219_ENABLE_LDO4_EN_MASK			BIT(6)
> +/* power ON-OFF sequence slot */
> +#define TPS65219_BUCKS_LDOS_SEQUENCE_OFF_SLOT_MASK	GENMASK(3, 0)
> +#define TPS65219_BUCKS_LDOS_SEQUENCE_ON_SLOT_MASK	GENMASK(7, 4)
> +/* TODO: Not needed, same mapping as TPS65219_ENABLE_REGNAME_EN,
> factorize */
> +#define TPS65219_STBY1_BUCK1_STBY_EN_MASK		BIT(0)
> +#define TPS65219_STBY1_BUCK2_STBY_EN_MASK		BIT(1)
> +#define TPS65219_STBY1_BUCK3_STBY_EN_MASK		BIT(2)
> +#define TPS65219_STBY1_LDO1_STBY_EN_MASK		BIT(3)
> +#define TPS65219_STBY1_LDO2_STBY_EN_MASK		BIT(4)
> +#define TPS65219_STBY1_LDO3_STBY_EN_MASK		BIT(5)
> +#define TPS65219_STBY1_LDO4_STBY_EN_MASK		BIT(6)
> +/* STBY_2 config */
> +#define TPS65219_STBY2_GPO1_STBY_EN_MASK		BIT(0)
> +#define TPS65219_STBY2_GPO2_STBY_EN_MASK		BIT(1)
> +#define TPS65219_STBY2_GPIO_STBY_EN_MASK		BIT(2)
> +/* MFP Control */
> +#define TPS65219_MFP_I2C_OFF_REQ_MASK			BIT(0)
> +#define TPS65219_MFP_STBY_I2C_CTRL_MASK			BIT(1)
> +#define TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK		BIT(2)
> +#define TPS65219_MFP_WARM_RESET_I2C_CTRL_MASK		BIT(3)
> +#define TPS65219_MFP_GPIO_STATUS_MASK			BIT(4)
> +/* MFP_1 Config */
> +#define TPS65219_MFP_1_VSEL_DDR_SEL_MASK		BIT(0)
> +#define TPS65219_MFP_1_VSEL_SD_POL_MASK			BIT(1)
> +#define TPS65219_MFP_1_VSEL_RAIL_MASK			BIT(2)
> +/* MFP_2 Config */
> +#define TPS65219_MFP_2_MODE_STBY_MASK			GENMASK(1, 0)
> +#define TPS65219_MFP_2_MODE_RESET_MASK			BIT(2)
> +#define TPS65219_MFP_2_EN_PB_VSENSE_DEGL_MASK		BIT(3)
> +#define TPS65219_MFP_2_EN_PB_VSENSE_MASK		GENMASK(5, 4)
> +#define TPS65219_MFP_2_WARM_COLD_RESET_MASK		BIT(6)
> +#define TPS65219_MFP_2_PU_ON_FSD_MASK			BIT(7)
> +#define TPS65219_MFP_2_EN				0
> +#define TPS65219_MFP_2_PB				BIT(4)
> +#define TPS65219_MFP_2_VSENSE				BIT(5)
> +/* MASK_UV Config */
> +#define TPS65219_REG_MASK_UV_LDO1_UV_MASK		BIT(0)
> +#define TPS65219_REG_MASK_UV_LDO2_UV_MASK		BIT(1)
> +#define TPS65219_REG_MASK_UV_LDO3_UV_MASK		BIT(2)
> +#define TPS65219_REG_MASK_UV_LDO4_UV_MASK		BIT(3)
> +#define TPS65219_REG_MASK_UV_BUCK1_UV_MASK		BIT(4)
> +#define TPS65219_REG_MASK_UV_BUCK2_UV_MASK		BIT(5)
> +#define TPS65219_REG_MASK_UV_BUCK3_UV_MASK		BIT(6)
> +#define TPS65219_REG_MASK_UV_RETRY_MASK			BIT(7)
> +/* MASK Config */
> +// SENSOR_N_WARM_MASK already defined in Thermal
> +#define TPS65219_REG_MASK_INT_FOR_RV_MASK		BIT(4)
> +#define TPS65219_REG_MASK_EFFECT_MASK			GENMASK(2, 1)
> +#define TPS65219_REG_MASK_INT_FOR_PB_MASK		BIT(7)
> +/* UnderVoltage - Short to GND - OverCurrent*/
> +/* LDO3-4 */
> +#define TPS65219_INT_LDO3_SCG_MASK			BIT(0)
> +#define TPS65219_INT_LDO3_OC_MASK			BIT(1)
> +#define TPS65219_INT_LDO3_UV_MASK			BIT(2)
> +#define TPS65219_INT_LDO4_SCG_MASK			BIT(3)
> +#define TPS65219_INT_LDO4_OC_MASK			BIT(4)
> +#define TPS65219_INT_LDO4_UV_MASK			BIT(5)
> +/* LDO1-2 */
> +#define TPS65219_INT_LDO1_SCG_MASK			BIT(0)
> +#define TPS65219_INT_LDO1_OC_MASK			BIT(1)
> +#define TPS65219_INT_LDO1_UV_MASK			BIT(2)
> +#define TPS65219_INT_LDO2_SCG_MASK			BIT(3)
> +#define TPS65219_INT_LDO2_OC_MASK			BIT(4)
> +#define TPS65219_INT_LDO2_UV_MASK			BIT(5)
> +/* BUCK3 */
> +#define TPS65219_INT_BUCK3_SCG_MASK			BIT(0)
> +#define TPS65219_INT_BUCK3_OC_MASK			BIT(1)
> +#define TPS65219_INT_BUCK3_NEG_OC_MASK			BIT(2)
> +#define TPS65219_INT_BUCK3_UV_MASK			BIT(3)
> +/* BUCK1-2 */
> +#define TPS65219_INT_BUCK1_SCG_MASK			BIT(0)
> +#define TPS65219_INT_BUCK1_OC_MASK			BIT(1)
> +#define TPS65219_INT_BUCK1_NEG_OC_MASK			BIT(2)
> +#define TPS65219_INT_BUCK1_UV_MASK			BIT(3)
> +#define TPS65219_INT_BUCK2_SCG_MASK			BIT(4)
> +#define TPS65219_INT_BUCK2_OC_MASK			BIT(5)
> +#define TPS65219_INT_BUCK2_NEG_OC_MASK			BIT(6)
> +#define TPS65219_INT_BUCK2_UV_MASK			BIT(7)
> +/* Thermal Sensor  */
> +#define TPS65219_INT_SENSOR_3_WARM_MASK			BIT(0)
> +#define TPS65219_INT_SENSOR_2_WARM_MASK			BIT(1)
> +#define TPS65219_INT_SENSOR_1_WARM_MASK			BIT(2)
> +#define TPS65219_INT_SENSOR_0_WARM_MASK			BIT(3)
> +#define TPS65219_INT_SENSOR_3_HOT_MASK			BIT(4)
> +#define TPS65219_INT_SENSOR_2_HOT_MASK			BIT(5)
> +#define TPS65219_INT_SENSOR_1_HOT_MASK			BIT(6)
> +#define TPS65219_INT_SENSOR_0_HOT_MASK			BIT(7)
> +/* Residual Voltage */
> +#define TPS65219_INT_BUCK1_RV_MASK			BIT(0)
> +#define TPS65219_INT_BUCK2_RV_MASK			BIT(1)
> +#define TPS65219_INT_BUCK3_RV_MASK			BIT(2)
> +#define TPS65219_INT_LDO1_RV_MASK			BIT(3)
> +#define TPS65219_INT_LDO2_RV_MASK			BIT(4)
> +#define TPS65219_INT_LDO3_RV_MASK			BIT(5)
> +#define TPS65219_INT_LDO4_RV_MASK			BIT(6)
> +/* Residual Voltage ShutDown */
> +#define TPS65219_INT_BUCK1_RV_SD_MASK			BIT(0)
> +#define TPS65219_INT_BUCK2_RV_SD_MASK			BIT(1)
> +#define TPS65219_INT_BUCK3_RV_SD_MASK			BIT(2)
> +#define TPS65219_INT_LDO1_RV_SD_MASK			BIT(3)
> +#define TPS65219_INT_LDO2_RV_SD_MASK			BIT(4)
> +#define TPS65219_INT_LDO3_RV_SD_MASK			BIT(5)
> +#define TPS65219_INT_LDO4_RV_SD_MASK			BIT(6)
> +#define TPS65219_INT_TIMEOUT_MASK			BIT(7)
> +/* Power Button */
> +#define TPS65219_INT_PB_FALLING_EDGE_DETECT_MASK	BIT(0)
> +#define TPS65219_INT_PB_RISING_EDGE_DETECT_MASK		BIT(1)
> +#define TPS65219_INT_PB_REAL_TIME_STATUS_MASK		BIT(2)
> +
> +#define TPS65219_PB_POS					7
> +#define TPS65219_TO_RV_POS				6
> +#define TPS65219_RV_POS					5
> +#define TPS65219_SYS_POS				4
> +#define TPS65219_BUCK_1_2_POS				3
> +#define TPS65219_BUCK_3_POS				2
> +#define TPS65219_LDO_1_2_POS				1
> +#define TPS65219_LDO_3_4_POS				0
> +
> +/* IRQs */
> +enum {
> +	/* LDO3-4 register IRQs */
> +	TPS65219_INT_LDO3_SCG,
> +	TPS65219_INT_LDO3_OC,
> +	TPS65219_INT_LDO3_UV,
> +	TPS65219_INT_LDO4_SCG,
> +	TPS65219_INT_LDO4_OC,
> +	TPS65219_INT_LDO4_UV,
> +	/* LDO1-2 */
> +	TPS65219_INT_LDO1_SCG,
> +	TPS65219_INT_LDO1_OC,
> +	TPS65219_INT_LDO1_UV,
> +	TPS65219_INT_LDO2_SCG,
> +	TPS65219_INT_LDO2_OC,
> +	TPS65219_INT_LDO2_UV,
> +	/* BUCK3 */
> +	TPS65219_INT_BUCK3_SCG,
> +	TPS65219_INT_BUCK3_OC,
> +	TPS65219_INT_BUCK3_NEG_OC,
> +	TPS65219_INT_BUCK3_UV,
> +	/* BUCK1-2 */
> +	TPS65219_INT_BUCK1_SCG,
> +	TPS65219_INT_BUCK1_OC,
> +	TPS65219_INT_BUCK1_NEG_OC,
> +	TPS65219_INT_BUCK1_UV,
> +	TPS65219_INT_BUCK2_SCG,
> +	TPS65219_INT_BUCK2_OC,
> +	TPS65219_INT_BUCK2_NEG_OC,
> +	TPS65219_INT_BUCK2_UV,
> +	/* Thermal Sensor  */
> +	TPS65219_INT_SENSOR_3_WARM,
> +	TPS65219_INT_SENSOR_2_WARM,
> +	TPS65219_INT_SENSOR_1_WARM,
> +	TPS65219_INT_SENSOR_0_WARM,
> +	TPS65219_INT_SENSOR_3_HOT,
> +	TPS65219_INT_SENSOR_2_HOT,
> +	TPS65219_INT_SENSOR_1_HOT,
> +	TPS65219_INT_SENSOR_0_HOT,
> +	/* Residual Voltage */
> +	TPS65219_INT_BUCK1_RV,
> +	TPS65219_INT_BUCK2_RV,
> +	TPS65219_INT_BUCK3_RV,
> +	TPS65219_INT_LDO1_RV,
> +	TPS65219_INT_LDO2_RV,
> +	TPS65219_INT_LDO3_RV,
> +	TPS65219_INT_LDO4_RV,
> +	/* Residual Voltage ShutDown */
> +	TPS65219_INT_BUCK1_RV_SD,
> +	TPS65219_INT_BUCK2_RV_SD,
> +	TPS65219_INT_BUCK3_RV_SD,
> +	TPS65219_INT_LDO1_RV_SD,
> +	TPS65219_INT_LDO2_RV_SD,
> +	TPS65219_INT_LDO3_RV_SD,
> +	TPS65219_INT_LDO4_RV_SD,
> +	TPS65219_INT_TIMEOUT,
> +	/* Power Button */
> +	TPS65219_INT_PB_FALLING_EDGE_DETECT,
> +	TPS65219_INT_PB_RISING_EDGE_DETECT,
> +};
> +
> +enum tps65219_regulator_id {
> +	/* DCDC's */
> +	TPS65219_BUCK_1,
> +	TPS65219_BUCK_2,
> +	TPS65219_BUCK_3,
> +	/* LDOs */
> +	TPS65219_LDO_1,
> +	TPS65219_LDO_2,
> +	TPS65219_LDO_3,
> +	TPS65219_LDO_4,
> +};
> +
> +/* Number of step-down converters available */
> +#define TPS65219_NUM_DCDC		3
> +/* Number of LDO voltage regulators available */
> +#define TPS65219_NUM_LDO		4
> +/* Number of total regulators available */
> +#define TPS65219_NUM_REGULATOR		(TPS65219_NUM_DCDC +
> TPS65219_NUM_LDO)
> +
> +/* Define the TPS65219 IRQ numbers */
> +enum tps65219_irqs {
> +	/* INT source registers */
> +	TPS65219_TO_RV_SD_SET_IRQ,
> +	TPS65219_RV_SET_IRQ,
> +	TPS65219_SYS_SET_IRQ,
> +	TPS65219_BUCK_1_2_SET_IRQ,
> +	TPS65219_BUCK_3_SET_IRQ,
> +	TPS65219_LDO_1_2_SET_IRQ,
> +	TPS65219_LDO_3_4_SET_IRQ,
> +	TPS65219_PB_SET_IRQ,
> +};
> +
> +/**
> + * struct tps65219 - tps65219 sub-driver chip access routines
> + *
> + * Device data may be used to access the TPS65219 chip
> + *
> + * @dev MFD device
> + * @regmap Regmap for accessing the device registers
> + * @irq_data Regmap irq data used for the irq chip
> + * @nb notifier block for the restart handler  */ struct tps65219 {
> +	struct device *dev;
> +	struct regmap *regmap;
> +
> +	struct regmap_irq_chip_data *irq_data;
> +	struct notifier_block nb;
> +};
> +
> +#endif /*  MFD_TPS65219_H */
> --
> 2.17.1

