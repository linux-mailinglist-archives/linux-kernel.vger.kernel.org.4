Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDA86102A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbiJ0UYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiJ0UYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:24:33 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06728F4D;
        Thu, 27 Oct 2022 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666902267; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdedvNfyJ6QLWa3QxULLjV2IS11ddz/l6K4bga6afTU=;
        b=RnMM2QyWubvxStgSbjUGK1bz9A7ypKnnaqmMyNc0gUevKcQLvituYDEaD/L97gYu2TwbAk
        yN0MvDgk7V4FIMjS6/zubTOwt/Dq121RLwlwXbUV/xNZ6wPvuKqwdtZ6cx433zoDTs/0Pq
        H/tNrSSHc84U99LhNrJhUxxbK0+LOI4=
Date:   Thu, 27 Oct 2022 21:24:17 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v6 3/3] clk: Add Ingenic JZ4755 CGU driver
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <H0IFKR.MDIS5V1PYBUI@crapouillou.net>
In-Reply-To: <20221027192024.484320-4-lis8215@gmail.com>
References: <20221027192024.484320-1-lis8215@gmail.com>
        <20221027192024.484320-4-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siarhei,

Le jeu. 27 oct. 2022 =E0 22:20:23 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =E9crit :
> Add support for the clocks provided by the CGU in the Ingenic JZ4755
> SoC.
>=20
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  drivers/clk/ingenic/Kconfig      |  10 +
>  drivers/clk/ingenic/Makefile     |   1 +
>  drivers/clk/ingenic/jz4755-cgu.c | 346=20
> +++++++++++++++++++++++++++++++
>  3 files changed, 357 insertions(+)
>  create mode 100644 drivers/clk/ingenic/jz4755-cgu.c
>=20
> diff --git a/drivers/clk/ingenic/Kconfig b/drivers/clk/ingenic/Kconfig
> index 898f1bc47..f80ac4f29 100644
> --- a/drivers/clk/ingenic/Kconfig
> +++ b/drivers/clk/ingenic/Kconfig
> @@ -15,6 +15,16 @@ config INGENIC_CGU_JZ4740
>=20
>  	  If building for a JZ4740 SoC, you want to say Y here.
>=20
> +config INGENIC_CGU_JZ4755
> +	bool "Ingenic JZ4755 CGU driver"
> +	default MACH_JZ4755
> +	select INGENIC_CGU_COMMON
> +	help
> +	  Support the clocks provided by the CGU hardware on Ingenic JZ4755
> +	  and compatible SoCs.
> +
> +	  If building for a JZ4755 SoC, you want to say Y here.
> +
>  config INGENIC_CGU_JZ4725B
>  	bool "Ingenic JZ4725B CGU driver"
>  	default MACH_JZ4725B
> diff --git a/drivers/clk/ingenic/Makefile=20
> b/drivers/clk/ingenic/Makefile
> index 9edfaf461..81d8e23c2 100644
> --- a/drivers/clk/ingenic/Makefile
> +++ b/drivers/clk/ingenic/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_INGENIC_CGU_COMMON)	+=3D cgu.o pm.o
>  obj-$(CONFIG_INGENIC_CGU_JZ4740)	+=3D jz4740-cgu.o
> +obj-$(CONFIG_INGENIC_CGU_JZ4755)	+=3D jz4755-cgu.o
>  obj-$(CONFIG_INGENIC_CGU_JZ4725B)	+=3D jz4725b-cgu.o
>  obj-$(CONFIG_INGENIC_CGU_JZ4760)	+=3D jz4760-cgu.o
>  obj-$(CONFIG_INGENIC_CGU_JZ4770)	+=3D jz4770-cgu.o
> diff --git a/drivers/clk/ingenic/jz4755-cgu.c=20
> b/drivers/clk/ingenic/jz4755-cgu.c
> new file mode 100644
> index 000000000..d2eb3ae0c
> --- /dev/null
> +++ b/drivers/clk/ingenic/jz4755-cgu.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Ingenic JZ4755 SoC CGU driver
> + * Heavily based on JZ4725b CGU driver
> + *
> + * Copyright (C) 2022 Siarhei Volkau
> + * Author: Siarhei Volkau <lis8215@gmail.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +
> +#include <dt-bindings/clock/ingenic,jz4755-cgu.h>
> +
> +#include "cgu.h"
> +#include "pm.h"
> +
> +/* CGU register offsets */
> +#define CGU_REG_CPCCR		0x00
> +#define CGU_REG_LCR		0x04
> +#define CGU_REG_CPPCR		0x10
> +#define CGU_REG_CLKGR		0x20
> +#define CGU_REG_OPCR		0x24
> +#define CGU_REG_I2SCDR		0x60
> +#define CGU_REG_LPCDR		0x64
> +#define CGU_REG_MSCCDR		0x68
> +#define CGU_REG_SSICDR		0x74
> +#define CGU_REG_CIMCDR		0x7C
> +
> +/* bits within the LCR register */
> +#define LCR_SLEEP		BIT(0)

Nitpick: this macro is not used anywhere.

With that fixed:
Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Stephen: you can merge v6 with the unused macro if you want, the same=20
unused macro is already in jz4740-cgu.c and jz4725b-cgu.c, so we'll=20
have to send a patch to remove these later anyway.

> +
> +static struct ingenic_cgu *cgu;
> +
> +static const s8 pll_od_encoding[4] =3D {
> +	0x0, 0x1, -1, 0x3,
> +};
> +
> +static const u8 jz4755_cgu_cpccr_div_table[] =3D {
> +	1, 2, 3, 4, 6, 8,
> +};
> +
> +static const u8 jz4755_cgu_pll_half_div_table[] =3D {
> +	2, 1,
> +};
> +
> +static const struct ingenic_cgu_clk_info jz4755_cgu_clocks[] =3D {
> +
> +	/* External clocks */
> +
> +	[JZ4755_CLK_EXT] =3D { "ext", CGU_CLK_EXT },
> +	[JZ4755_CLK_OSC32K] =3D { "osc32k", CGU_CLK_EXT },
> +
> +	[JZ4755_CLK_PLL] =3D {
> +		"pll", CGU_CLK_PLL,
> +		.parents =3D { JZ4755_CLK_EXT, },
> +		.pll =3D {
> +			.reg =3D CGU_REG_CPPCR,
> +			.rate_multiplier =3D 1,
> +			.m_shift =3D 23,
> +			.m_bits =3D 9,
> +			.m_offset =3D 2,
> +			.n_shift =3D 18,
> +			.n_bits =3D 5,
> +			.n_offset =3D 2,
> +			.od_shift =3D 16,
> +			.od_bits =3D 2,
> +			.od_max =3D 4,
> +			.od_encoding =3D pll_od_encoding,
> +			.stable_bit =3D 10,
> +			.bypass_reg =3D CGU_REG_CPPCR,
> +			.bypass_bit =3D 9,
> +			.enable_bit =3D 8,
> +		},
> +	},
> +
> +	/* Muxes & dividers */
> +
> +	[JZ4755_CLK_PLL_HALF] =3D {
> +		"pll half", CGU_CLK_DIV,
> +		.parents =3D { JZ4755_CLK_PLL, },
> +		.div =3D {
> +			CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1, 0,
> +			jz4755_cgu_pll_half_div_table,
> +		},
> +	},
> +
> +	[JZ4755_CLK_EXT_HALF] =3D {
> +		"ext half", CGU_CLK_DIV,
> +		.parents =3D { JZ4755_CLK_EXT, },
> +		.div =3D {
> +			CGU_REG_CPCCR, 30, 1, 1, -1, -1, -1, 0,
> +			NULL,
> +		},
> +	},
> +
> +	[JZ4755_CLK_CCLK] =3D {
> +		"cclk", CGU_CLK_DIV,
> +		.parents =3D { JZ4755_CLK_PLL, },
> +		.div =3D {
> +			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
> +			jz4755_cgu_cpccr_div_table,
> +		},
> +	},
> +
> +	[JZ4755_CLK_H0CLK] =3D {
> +		"hclk", CGU_CLK_DIV,
> +		.parents =3D { JZ4755_CLK_PLL, },
> +		.div =3D {
> +			CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1, 0,
> +			jz4755_cgu_cpccr_div_table,
> +		},
> +	},
> +
> +	[JZ4755_CLK_PCLK] =3D {
> +		"pclk", CGU_CLK_DIV,
> +		.parents =3D { JZ4755_CLK_PLL, },
> +		.div =3D {
> +			CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1, 0,
> +			jz4755_cgu_cpccr_div_table,
> +		},
> +	},
> +
> +	[JZ4755_CLK_MCLK] =3D {
> +		"mclk", CGU_CLK_DIV,
> +		.parents =3D { JZ4755_CLK_PLL, },
> +		.div =3D {
> +			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
> +			jz4755_cgu_cpccr_div_table,
> +		},
> +	},
> +
> +	[JZ4755_CLK_H1CLK] =3D {
> +		"h1clk", CGU_CLK_DIV,
> +		.parents =3D { JZ4755_CLK_PLL, },
> +		.div =3D {
> +			CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1, 0,
> +			jz4755_cgu_cpccr_div_table,
> +		},
> +	},
> +
> +	[JZ4755_CLK_UDC] =3D {
> +		"udc", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_EXT_HALF, JZ4755_CLK_PLL_HALF, },
> +		.mux =3D { CGU_REG_CPCCR, 29, 1 },
> +		.div =3D { CGU_REG_CPCCR, 23, 1, 6, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR, 10 },
> +	},
> +
> +	[JZ4755_CLK_LCD] =3D {
> +		"lcd", CGU_CLK_DIV | CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_PLL_HALF, },
> +		.div =3D { CGU_REG_LPCDR, 0, 1, 11, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR, 9 },
> +	},
> +
> +	[JZ4755_CLK_MMC] =3D {
> +		"mmc", CGU_CLK_DIV,
> +		.parents =3D { JZ4755_CLK_PLL_HALF, },
> +		.div =3D { CGU_REG_MSCCDR, 0, 1, 5, -1, -1, -1 },
> +	},
> +
> +	[JZ4755_CLK_I2S] =3D {
> +		"i2s", CGU_CLK_MUX | CGU_CLK_DIV,
> +		.parents =3D { JZ4755_CLK_EXT_HALF, JZ4755_CLK_PLL_HALF, },
> +		.mux =3D { CGU_REG_CPCCR, 31, 1 },
> +		.div =3D { CGU_REG_I2SCDR, 0, 1, 9, -1, -1, -1 },
> +	},
> +
> +	[JZ4755_CLK_SPI] =3D {
> +		"spi", CGU_CLK_DIV | CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_PLL_HALF, },
> +		.div =3D { CGU_REG_SSICDR, 0, 1, 4, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR, 4 },
> +	},
> +
> +	[JZ4755_CLK_TVE] =3D {
> +		"tve", CGU_CLK_MUX | CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_LCD, JZ4755_CLK_EXT, },
> +		.mux =3D { CGU_REG_LPCDR, 31, 1 },
> +		.gate =3D { CGU_REG_CLKGR, 18 },
> +	},
> +
> +	[JZ4755_CLK_RTC] =3D {
> +		"rtc", CGU_CLK_MUX | CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_EXT512, JZ4755_CLK_OSC32K, },
> +		.mux =3D { CGU_REG_OPCR, 2, 1},
> +		.gate =3D { CGU_REG_CLKGR, 2 },
> +	},
> +
> +	[JZ4755_CLK_CIM] =3D {
> +		"cim", CGU_CLK_DIV | CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_PLL_HALF, },
> +		.div =3D { CGU_REG_CIMCDR, 0, 1, 8, -1, -1, -1 },
> +		.gate =3D { CGU_REG_CLKGR, 8 },
> +	},
> +
> +	/* Gate-only clocks */
> +
> +	[JZ4755_CLK_UART0] =3D {
> +		"uart0", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_EXT_HALF, },
> +		.gate =3D { CGU_REG_CLKGR, 0 },
> +	},
> +
> +	[JZ4755_CLK_UART1] =3D {
> +		"uart1", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_EXT_HALF, },
> +		.gate =3D { CGU_REG_CLKGR, 14 },
> +	},
> +
> +	[JZ4755_CLK_UART2] =3D {
> +		"uart2", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_EXT_HALF, },
> +		.gate =3D { CGU_REG_CLKGR, 15 },
> +	},
> +
> +	[JZ4755_CLK_ADC] =3D {
> +		"adc", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_EXT_HALF, },
> +		.gate =3D { CGU_REG_CLKGR, 7 },
> +	},
> +
> +	[JZ4755_CLK_AIC] =3D {
> +		"aic", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_EXT_HALF, },
> +		.gate =3D { CGU_REG_CLKGR, 5 },
> +	},
> +
> +	[JZ4755_CLK_I2C] =3D {
> +		"i2c", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_EXT_HALF, },
> +		.gate =3D { CGU_REG_CLKGR, 3 },
> +	},
> +
> +	[JZ4755_CLK_BCH] =3D {
> +		"bch", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_H1CLK, },
> +		.gate =3D { CGU_REG_CLKGR, 11 },
> +	},

Just to clear things up vs. what you wrote in your cover letter:=20
according to table 30-3 of chapter 30.1 of the PM, BCH is on the AHB1=20
bus, so H1CLK is correct.

Cheers,
-Paul

> +
> +	[JZ4755_CLK_TCU] =3D {
> +		"tcu", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_EXT, },
> +		.gate =3D { CGU_REG_CLKGR, 1 },
> +	},
> +
> +	[JZ4755_CLK_DMA] =3D {
> +		"dma", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_PCLK, },
> +		.gate =3D { CGU_REG_CLKGR, 12 },
> +	},
> +
> +	[JZ4755_CLK_MMC0] =3D {
> +		"mmc0", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_MMC, },
> +		.gate =3D { CGU_REG_CLKGR, 6 },
> +	},
> +
> +	[JZ4755_CLK_MMC1] =3D {
> +		"mmc1", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_MMC, },
> +		.gate =3D { CGU_REG_CLKGR, 16 },
> +	},
> +
> +	[JZ4755_CLK_AUX_CPU] =3D {
> +		"aux_cpu", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_H1CLK, },
> +		.gate =3D { CGU_REG_CLKGR, 24 },
> +	},
> +
> +	[JZ4755_CLK_AHB1] =3D {
> +		"ahb1", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_H1CLK, },
> +		.gate =3D { CGU_REG_CLKGR, 23 },
> +	},
> +
> +	[JZ4755_CLK_IDCT] =3D {
> +		"idct", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_H1CLK, },
> +		.gate =3D { CGU_REG_CLKGR, 22 },
> +	},
> +
> +	[JZ4755_CLK_DB] =3D {
> +		"db", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_H1CLK, },
> +		.gate =3D { CGU_REG_CLKGR, 21 },
> +	},
> +
> +	[JZ4755_CLK_ME] =3D {
> +		"me", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_H1CLK, },
> +		.gate =3D { CGU_REG_CLKGR, 20 },
> +	},
> +
> +	[JZ4755_CLK_MC] =3D {
> +		"mc", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_H1CLK, },
> +		.gate =3D { CGU_REG_CLKGR, 19 },
> +	},
> +
> +	[JZ4755_CLK_TSSI] =3D {
> +		"tssi", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_EXT_HALF/* not sure */, },
> +		.gate =3D { CGU_REG_CLKGR, 17 },
> +	},
> +
> +	[JZ4755_CLK_IPU] =3D {
> +		"ipu", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_PLL_HALF/* not sure */, },
> +		.gate =3D { CGU_REG_CLKGR, 13 },
> +	},
> +
> +	[JZ4755_CLK_EXT512] =3D {
> +		"ext/512", CGU_CLK_FIXDIV,
> +		.parents =3D { JZ4755_CLK_EXT, },
> +
> +		.fixdiv =3D { 512 },
> +	},
> +
> +	[JZ4755_CLK_UDC_PHY] =3D {
> +		"udc_phy", CGU_CLK_GATE,
> +		.parents =3D { JZ4755_CLK_EXT_HALF, },
> +		.gate =3D { CGU_REG_OPCR, 6, true },
> +	},
> +};
> +
> +static void __init jz4755_cgu_init(struct device_node *np)
> +{
> +	int retval;
> +
> +	cgu =3D ingenic_cgu_new(jz4755_cgu_clocks,
> +			      ARRAY_SIZE(jz4755_cgu_clocks), np);
> +	if (!cgu) {
> +		pr_err("%s: failed to initialise CGU\n", __func__);
> +		return;
> +	}
> +
> +	retval =3D ingenic_cgu_register_clocks(cgu);
> +	if (retval)
> +		pr_err("%s: failed to register CGU Clocks\n", __func__);
> +
> +	ingenic_cgu_register_syscore_ops(cgu);
> +}
> +CLK_OF_DECLARE_DRIVER(jz4755_cgu, "ingenic,jz4755-cgu",=20
> jz4755_cgu_init);
> --
> 2.36.1
>=20


