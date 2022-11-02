Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED81761663E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiKBPdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiKBPdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:33:41 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C65A1F633;
        Wed,  2 Nov 2022 08:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip9QHlBE+lfbcWHSmU6UJ/KHEW9OeFZoUR5rGg3EGwGkCNCDYP2G425ntrKMlBMjjm8+/Nt78Ihknjk+hw3e6m0v0nrYdw6VlPE90QOJzchnxgTAKu9kaSNkn8Im2gaW4utEeLqFs9fXOulgQWeu0EhTP/ieve7rwv1iXUc1LdTYJL19UHaGxWkGtzW+jfz2J3lF3jVEK2bKGIapusti6rpc8zzJhkv1sImyEcjYFapfiqksxQMxGFlhn9Gs5MmMG8HvxvxnGTG8Ri4AKUQUiR9u4AJ0AJzUaWNERLqrid6Fg0i8+WtOkYk2flqjFa6YssZ6VNUKM9Zc/MaBOBw+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MORB4AHaDTLM1Uv0qyKSfV7bjhSlhRimieT8dliL+ic=;
 b=hpL/JMgZGEwK4qlMA3YToD5vPE48zAG/Cto4a+UGKajR2RFUjkF9Vj+9qwNPdZ7CKGxtI2cgGLcajcORuAeok3IS+2Z4eK6QG1ONXHO4bWggqH2x12KYzfA1STLjYljvg6+YJv2Evn7Lfe5SkQQ+x+N2taC2W4lQ3xJjSBu6WyHKN1qQje5Xw1Tz3RZnoT3ECksC+L0D+Lf3ZC5nv15Atb/oMLhxAU8ZEss4/cyrFmWJM9frNWIrRmUmO2MkskF/aQdVAADNHPSqXeS02b1A7pzD4DNBnqcV+B2D+y+EQhfDDNzK3q2MXzDCkMiYyblggPjjfgyxWvlIB3OM3RrI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MORB4AHaDTLM1Uv0qyKSfV7bjhSlhRimieT8dliL+ic=;
 b=qjT/55PBLlX9RV0tx7M4+2ZnE7aIXlZSkM6OrskuBnw43oJhRmosMhpUCM8YTL2c/VeXD7KZ+M8d1iQUn6xmn/TyDM/AIwEsMjbsn+Ek2zM9V5jJ1xvijCyen+cmLm+Ibt5naEQff1J5mskSzWkeQJpIJDXN6cFZXXGq3GQuU6w=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY1PR01MB10850.jpnprd01.prod.outlook.com (2603:1096:400:324::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 15:33:34 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 15:33:34 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "marcan@marcan.st" <marcan@marcan.st>,
        "sven@svenpeter.dev" <sven@svenpeter.dev>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] pwm: Add Apple PWM controller
Thread-Topic: [PATCH v2 2/4] pwm: Add Apple PWM controller
Thread-Index: AQHY7scaJddHyAtwqkGPO5YDCJjX564rwPsw
Date:   Wed, 2 Nov 2022 15:33:34 +0000
Message-ID: <OS0PR01MB59227A9E7B8A471E4D6B665786399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102141513.49289-1-fnkl.kernel@gmail.com>
 <20221102141513.49289-3-fnkl.kernel@gmail.com>
In-Reply-To: <20221102141513.49289-3-fnkl.kernel@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY1PR01MB10850:EE_
x-ms-office365-filtering-correlation-id: 3e690b8a-6269-4e24-bf05-08dabce79a84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4DkfMIxACoO6bY3UWl75SHVVluZHWiT7PNerkoJ3C5RiLgUfahbyHxEIn7H/TnmBj64cJ44XjXGfI4iV/12OTBdeNZd2Zy2ee7OoLzCqnv+GJ7D2zV8WTxY6BX+861Ogj4zMbCs9J9Bz2+cE44aoc99AltdshlIqG7AXndVml5ZTr2/9t/5k0zGb+asDsBsCjqlxH1zSGIHwGOj1QevtqDkWOBpszxbsPyUxfUgLBQhyCBssypkPWloqByLimwiK9dcKiB+1Uz1/gRwAAlPQvfNXlD7bkgOHTneDiDCYIbhM0d+6WJ/GUnHG9KgVseuhtqDYN3lAUx5YzNqL99TC1KldcZJpbsb0nrl7KMkwSrdrmW84PFhOOZYDVB1sEpHuuotgo5QT9Yh9Dk1MhGObvSLFIjAK+spKleYW/ci27Eu+jd0VRYiWFfD4zFdKEdf0xVEfcRlqNp/AqgIiopN6oIANr6cEW9sh6DqcwhrRpInHLYS0wqrcFv+8kicTaFhny0tmX5xNoZwvqKrghBTRD3JQfwwBm+Iob4xPPokg0JbUu/xrleZ65doiXxq582NYLFmcNtNFf2rGjvFOq1YP0M7VdNbkgZFP/dduow6c8On9zLVigQom2ASfyMKy+sWJonhsqFRnX5Fo/2M32oFHBeYhdklGY4LjsIxjUVIsZMT8rk9BBfrimQy9C0tfCH0O9Yeid2x4NKr27Gb403K29Jp/yjguBhAzGZDJMLgoYf2JwR0JcUdcc92D2TKWlWF1p+BLptRRPJw2GWHe8+sqEl9GLSCnyq8kRA96EiAe/ePGTfboGdmv+hchrZDz/VQNK8d7XZBNrPhUXO/tRBmDCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(47660400002)(451199015)(2906002)(316002)(86362001)(122000001)(9686003)(83380400001)(33656002)(186003)(66446008)(52536014)(5660300002)(7416002)(66556008)(8936002)(76116006)(6506007)(8676002)(66476007)(7696005)(66946007)(64756008)(4326008)(41300700001)(26005)(38070700005)(55016003)(478600001)(110136005)(966005)(71200400001)(45080400002)(38100700002)(54906003)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SLswX+JjwLxFalC9YbEtIf4YUYrUMHwexN8aifHClqrDNL0fh8MGeS0jqD6O?=
 =?us-ascii?Q?OVGXWyeghIMO0FwfBt1jphvrz2G6iYHTLdqfpSJOUWx1UbPGo0sw88yt4SGw?=
 =?us-ascii?Q?gKyXYYgrpavUC8GGjbNnqnmkdm9Y85plf5Pz3Kii8VOYJYn2vnwTyzzeqwgY?=
 =?us-ascii?Q?DFRkvoO8Z/LxQq0+UGXnh6LCG668UrXme+NTO0kZDRF8lmj2wtB/8PBZYCs+?=
 =?us-ascii?Q?C2KDc5cmCIeyy6wkM4YbNjXkSFPCn39HBxLPpKLrreViYHslEdwBjwh2qqaY?=
 =?us-ascii?Q?k7vieHztgMCE9aXBUfEmUIvM4Wr//7Jjj5s68KkwHwjmBlNAOPJHZSeS/ASS?=
 =?us-ascii?Q?vC0TmA6K46J/0Dv2ToivCy0zC3zca61uRSNoTSI60x4XZmAPk7JMQN7jwzzQ?=
 =?us-ascii?Q?04mNXC/wHXr3Y/lhajUf/Sm/R6DT4zkW+5J2CaP/jumc+lxUpRaNX4oLqzD0?=
 =?us-ascii?Q?y4QeYOMdIKfgM632ybvjq4B861pw3/mNDU0B0/LVY5oDfZiwhQFAeLBAdQg/?=
 =?us-ascii?Q?gC4nn+KNm4U6f1S3hSVb4xmxEjpVjI23PQQTCv6AO6V19l/lc4QcmuEdc06/?=
 =?us-ascii?Q?eNbqQz5+u+EDoLh/vH94qYpXviNuy3AQFdEAciOOFmrAzDaYWsncV51TuJCs?=
 =?us-ascii?Q?OuCgtKRPEEhXKZtjMh39MTmkyQF8aj7SZryqU63Z836J6esb0fbrLpSB+DnB?=
 =?us-ascii?Q?M7gFZbhR4FFU+oo/YkSYV4/S64g9VPtSI+wmvi8gGBf677QBtS5FG5fgoO01?=
 =?us-ascii?Q?5W7DyjnlzNTDwFXiTiKavpNOSMJ+D/EKC2F+ZM3lvP0LMKndEZQgvH8VIMN3?=
 =?us-ascii?Q?zjZpglgYfzGdoT2ylPQFAjjbiANzxaBsVz16ibWshb314KnqyhykkB9XDup0?=
 =?us-ascii?Q?Xy6ntkCvJ+vkEhfCqAKMphqcaCJA2oQhaQtPuo7JwXGx/1v+/DhrujCvn7MJ?=
 =?us-ascii?Q?H9QpybDZS7SzIp3c+vAFfZ46/i93Me+YD9VHD9aqAkMBWsAGmUqE0P94Pm5r?=
 =?us-ascii?Q?zUCTcH46bpBC+Vlvwsg9fDRM1U0FtK0zAZQYId6a9nendIz54rs+2A1mnbnL?=
 =?us-ascii?Q?T2Sxhwizty3LgdSSJLhVk6Zz0hcysSWc/griGj5MsUDvSJFHQckKoR1d7oid?=
 =?us-ascii?Q?K8X3Le4Z3innQ1PXw7yxX/xuCsOcyvuFiHR29Gsld9mCq+0wwOk1X6fR8g4U?=
 =?us-ascii?Q?LoQne4llwIjsHOHYBAAETLtVlvMQTHQygJoaTTcNQF8fDxANZW0vtUoidF80?=
 =?us-ascii?Q?+/efArCUekIGg1qzpNnqyzAKhxdKxmMohKAflCgNOiKzbeUJkVtiRMH5CmJ/?=
 =?us-ascii?Q?TyakX+4U8TMJAwy+ha7a7fNt7VGORipaEZkgqAjJQP2IcEi33aneDSEWmlmc?=
 =?us-ascii?Q?aZJjYRManNQh2hvJJ5F58x+RUtEakDPnz7Zd5wCnFfGYt/yqnMTEUcMlksT3?=
 =?us-ascii?Q?qT0/5qDm6D00sj+goCVspsnvAWcPd/sKqx1q1FwiDuCRxR5roKkEZTxCJ8Rn?=
 =?us-ascii?Q?gRzrfXzHhq80df23xEwFd1A4KaYM25ZB1bE2cvwnB+Uu9Z12TgQxg+95SGxl?=
 =?us-ascii?Q?ZWhUojfuhKsuOUx/MiZ0X/aroW9a07gcfgSorAWiR7B0UuvJc6bJWqW7moyA?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e690b8a-6269-4e24-bf05-08dabce79a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 15:33:34.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2A68bYuA/s5Zx9ArNuYli7k7+JT0qrEpBsV5HQVOYjoVORTDL1VWYLfSVdNevAXoG9hQIKXPAqLqBlvkueSyl+E17a0j5qMvpyuq3YLYKtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10850
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha Finkelstein,

Thanks for the patch.

> Subject: [PATCH v2 2/4] pwm: Add Apple PWM controller
>=20
> Adds the Apple PWM controller driver.
>=20
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/pwm/Kconfig     |  12 ++++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-apple.c | 127
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 drivers/pwm/pwm-apple.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> 60d13a949bc5..c3be11468414 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -51,6 +51,18 @@ config PWM_AB8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-ab8500.
>=20
> +config PWM_APPLE
> +	tristate "Apple SoC PWM support"
> +	depends on ARCH_APPLE || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for PWM controller present on
> +	  Apple SoCs
> +
> +	  Say Y here if you have an ARM Apple laptop, otherwise say N
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-apple.
> +
>  config PWM_ATMEL
>  	tristate "Atmel PWM support"
>  	depends on ARCH_AT91 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> 7bf1a29f02b8..19899b912e00 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_SYSFS)		+=3D sysfs.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
> +obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> diff --git a/drivers/pwm/pwm-apple.c b/drivers/pwm/pwm-apple.c new
> file mode 100644 index 000000000000..7b2936346f4e
> --- /dev/null
> +++ b/drivers/pwm/pwm-apple.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Driver for the Apple SoC PWM controller
> + *
> + * Copyright The Asahi Linux Contributors  */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/math64.h>

May be sort header alphabetically??

> +
> +#define PWM_CONTROL     0x00
> +#define PWM_ON_CYCLES   0x1c
> +#define PWM_OFF_CYCLES  0x18
> +
> +#define CTRL_ENABLE        BIT(0)
> +#define CTRL_MODE          BIT(2)
> +#define CTRL_UPDATE        BIT(5)
> +#define CTRL_TRIGGER       BIT(9)
> +#define CTRL_INVERT        BIT(10)
> +#define CTRL_OUTPUT_ENABLE BIT(14)
> +
> +struct apple_pwm {
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +	u64 clkrate;
> +};
> +
> +static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct apple_pwm *fpwm;
> +	u64 on_cycles, off_cycles;
> +
> +	fpwm =3D container_of(chip, struct apple_pwm, chip);
> +	if (state->enabled) {
> +		on_cycles =3D mul_u64_u64_div_u64(fpwm->clkrate,
> +						state->duty_cycle, NSEC_PER_SEC);
> +		off_cycles =3D mul_u64_u64_div_u64(fpwm->clkrate,
> +						 state->period, NSEC_PER_SEC) -
> on_cycles;
> +		writel(on_cycles, fpwm->base + PWM_ON_CYCLES);
> +		writel(off_cycles, fpwm->base + PWM_OFF_CYCLES);
> +		writel(CTRL_ENABLE | CTRL_OUTPUT_ENABLE | CTRL_UPDATE,
> +		       fpwm->base + PWM_CONTROL);
> +	} else {
> +		writel(0, fpwm->base + PWM_CONTROL);
> +	}
> +	return 0;
> +}
> +
> +static void apple_pwm_get_state(struct pwm_chip *chip, struct
> pwm_device *pwm,
> +			   struct pwm_state *state)
> +{
> +	struct apple_pwm *fpwm;
> +	u32 on_cycles, off_cycles, ctrl;
> +
> +	fpwm =3D container_of(chip, struct apple_pwm, chip);
> +
> +	ctrl =3D readl(fpwm->base + PWM_CONTROL);
> +	on_cycles =3D readl(fpwm->base + PWM_ON_CYCLES);
> +	off_cycles =3D readl(fpwm->base + PWM_OFF_CYCLES);
> +
> +	state->enabled =3D (ctrl & CTRL_ENABLE) && (ctrl &
> CTRL_OUTPUT_ENABLE);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->duty_cycle =3D div_u64(on_cycles, fpwm->clkrate) *
> NSEC_PER_SEC;
> +	state->period =3D div_u64(off_cycles + on_cycles, fpwm->clkrate) *
> +NSEC_PER_SEC; }
> +
> +static const struct pwm_ops apple_pwm_ops =3D {
> +	.apply =3D apple_pwm_apply,
> +	.get_state =3D apple_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int apple_pwm_probe(struct platform_device *pdev) {
> +	struct apple_pwm *pwm;
> +	struct clk *clk;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->base))
> +		return PTR_ERR(pwm->base);
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);

What is your use case?=20

PWM is configured by bootloader intially??

Or

PWM is configured by Linux not by the bootloader?


Or

Driver needs to support both ??

Cheers,
Biju


> +
> +	pwm->clkrate =3D clk_get_rate(clk);
> +	pwm->chip.dev =3D &pdev->dev;
> +	pwm->chip.npwm =3D 1;
> +	pwm->chip.ops =3D &apple_pwm_ops;
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, &pwm->chip);
> +	return ret;
> +}
> +
> +static const struct of_device_id apple_pwm_of_match[] =3D {
> +	{ .compatible =3D "apple,s5l-fpwm" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, apple_pwm_of_match);
> +
> +static struct platform_driver apple_pwm_driver =3D {
> +	.probe =3D apple_pwm_probe,
> +	.driver =3D {
> +		.name =3D "apple-pwm",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D apple_pwm_of_match,
> +	},
> +};
> +module_platform_driver(apple_pwm_driver);
> +
> +MODULE_DESCRIPTION("Apple SoC PWM driver"); MODULE_LICENSE("Dual
> +MIT/GPL");
> --
> 2.37.3
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists
> .infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&amp;data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7C0ff5a9275b954
> eff39ae08dabcde3c28%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63802
> 9959918512569%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DzdoRENBcN
> FUDLdqC8wOspyvoOzRsTkBkS01Q8ff9okk%3D&amp;reserved=3D0
