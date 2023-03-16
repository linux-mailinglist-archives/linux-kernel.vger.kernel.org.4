Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0706BD474
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCPP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjCPP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:56:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215747DD2E;
        Thu, 16 Mar 2023 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678982191; x=1710518191;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rcRlYcN7CeOopWtHiOOwqwsRcXJ74ftY03kG789MPNY=;
  b=c5vXbJ4hu1Md5Yr59jE3WrL2onPZBkYKRchOvLblOTu0Ey9e7PQnQLHY
   N81nL7KKgjR7FKuOZvQ8QCOsQ49vajulWHOws7BNha8osbreyk8CpRA7h
   BfE8k5jptfzf41lzHTpJGF3OtUoeGXZ+HTVedWLz2hJ9RmqBC4iFxc+JQ
   dhz7cxgkFpiB7qEZpkFLQQR0NJNtgjxu81NMysSETV+szbEdi0ZDhuPw+
   qL8pJAF6gWapj+rZJUiKgmW02HNWbwtcu6fCjnWlJlm0MA34wJ567tNgn
   lGprbPcgFabDDGerKAmeiFbu52Tc2m23YWVS8RQ4bBgY4hLbOR42Bd9/1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="321888313"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321888313"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823310975"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="823310975"
Received: from trybicki-mobl1.ger.corp.intel.com ([10.252.63.119])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:56:25 -0700
Date:   Thu, 16 Mar 2023 17:56:23 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH 12/15] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
In-Reply-To: <20230315072902.9298-13-ychuang570808@gmail.com>
Message-ID: <8b5854d3-2793-bc33-137e-5a2673d72329@linux.intel.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com> <20230315072902.9298-13-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023, Jacky Huang wrote:

> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> The clock controller generates clocks for the whole chip, including
> system clocks and all peripheral clocks. This driver support ma35d1
> clock gating, divider, and individual PLL configuration.
> 
> There are 6 PLLs in ma35d1 SoC:
>   - CA-PLL for the two Cortex-A35 CPU clock
>   - SYS-PLL for system bus, which comes from the companion MCU
>     and cannot be programmed by clock controller.
>   - DDR-PLL for DDR
>   - EPLL for GMAC and GFX, Display, and VDEC IPs.
>   - VPLL for video output pixel clock
>   - APLL for SDHC, I2S audio, and other IPs.
> CA-PLL has only one operation mode.
> DDR-PLL, EPLL, VPLL, and APLL are advanced PLLs which have 3
> operation modes: integer mode, fraction mode, and spread specturm mode.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/clk/Makefile                     |   1 +
>  drivers/clk/nuvoton/Makefile             |   4 +
>  drivers/clk/nuvoton/clk-ma35d1-divider.c | 144 ++++
>  drivers/clk/nuvoton/clk-ma35d1-pll.c     | 534 +++++++++++++
>  drivers/clk/nuvoton/clk-ma35d1.c         | 970 +++++++++++++++++++++++
>  drivers/clk/nuvoton/clk-ma35d1.h         | 198 +++++
>  6 files changed, 1851 insertions(+)
>  create mode 100644 drivers/clk/nuvoton/Makefile
>  create mode 100644 drivers/clk/nuvoton/clk-ma35d1-divider.c
>  create mode 100644 drivers/clk/nuvoton/clk-ma35d1-pll.c
>  create mode 100644 drivers/clk/nuvoton/clk-ma35d1.c
>  create mode 100644 drivers/clk/nuvoton/clk-ma35d1.h
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e3ca0d058a25..2e7916d269e1 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -103,6 +103,7 @@ endif
>  obj-y					+= mstar/
>  obj-y					+= mvebu/
>  obj-$(CONFIG_ARCH_MXS)			+= mxs/
> +obj-$(CONFIG_ARCH_NUVOTON)		+= nuvoton/
>  obj-$(CONFIG_COMMON_CLK_NXP)		+= nxp/
>  obj-$(CONFIG_COMMON_CLK_PISTACHIO)	+= pistachio/
>  obj-$(CONFIG_COMMON_CLK_PXA)		+= pxa/
> diff --git a/drivers/clk/nuvoton/Makefile b/drivers/clk/nuvoton/Makefile
> new file mode 100644
> index 000000000000..d2c092541b8d
> --- /dev/null
> +++ b/drivers/clk/nuvoton/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ARCH_NUVOTON) += clk-ma35d1.o
> +obj-$(CONFIG_ARCH_NUVOTON) += clk-ma35d1-divider.o
> +obj-$(CONFIG_ARCH_NUVOTON) += clk-ma35d1-pll.o
> diff --git a/drivers/clk/nuvoton/clk-ma35d1-divider.c b/drivers/clk/nuvoton/clk-ma35d1-divider.c
> new file mode 100644
> index 000000000000..5f4791531e47
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1-divider.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/spinlock.h>
> +
> +#include "clk-ma35d1.h"
> +
> +#define div_mask(width)		((1 << (width)) - 1)
> +
> +struct ma35d1_adc_clk_divider {
> +	struct clk_hw hw;
> +	void __iomem *reg;
> +	u8 shift;
> +	u8 width;
> +	u32 mask;
> +	const struct clk_div_table *table;
> +	spinlock_t *lock;

Add comment to indicate what it protects.

> +};
> +
> +#define to_ma35d1_adc_clk_divider(_hw)	\
> +	container_of(_hw, struct ma35d1_adc_clk_divider, hw)

static inline

> +static unsigned long ma35d1_clkdiv_recalc_rate(struct clk_hw *hw,
> +					       unsigned long parent_rate)
> +{
> +	unsigned int val;
> +	struct ma35d1_adc_clk_divider *dclk = to_ma35d1_adc_clk_divider(hw);
> +
> +	val = readl_relaxed(dclk->reg) >> dclk->shift;
> +	val &= div_mask(dclk->width);
> +	val += 1;
> +	return divider_recalc_rate(hw, parent_rate, val, dclk->table,
> +				   CLK_DIVIDER_ROUND_CLOSEST, dclk->width);
> +}
> +
> +static long ma35d1_clkdiv_round_rate(struct clk_hw *hw, unsigned long rate,
> +				     unsigned long *prate)
> +{
> +	struct ma35d1_adc_clk_divider *dclk = to_ma35d1_adc_clk_divider(hw);
> +
> +	return divider_round_rate(hw, rate, prate, dclk->table,
> +				  dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
> +}
> +
> +static int ma35d1_clkdiv_set_rate(struct clk_hw *hw, unsigned long rate,
> +				  unsigned long parent_rate)
> +{
> +	int value;
> +	unsigned long flags = 0;
> +	u32 data;
> +	struct ma35d1_adc_clk_divider *dclk = to_ma35d1_adc_clk_divider(hw);
> +
> +	value = divider_get_val(rate, parent_rate, dclk->table,
> +				dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
> +
> +	if (dclk->lock)
> +		spin_lock_irqsave(dclk->lock, flags);
> +
> +	data = readl_relaxed(dclk->reg);
> +	data &= ~(div_mask(dclk->width) << dclk->shift);
> +	data |= (value - 1) << dclk->shift;
> +	data |= dclk->mask;
> +
> +	writel_relaxed(data, dclk->reg);
> +
> +	if (dclk->lock)
> +		spin_unlock_irqrestore(dclk->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops ma35d1_adc_clkdiv_ops = {
> +	.recalc_rate = ma35d1_clkdiv_recalc_rate,
> +	.round_rate = ma35d1_clkdiv_round_rate,
> +	.set_rate = ma35d1_clkdiv_set_rate,
> +};
> +
> +struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev, const char *name,
> +				     const char *parent_name,
> +				     unsigned long flags, void __iomem *reg,
> +				     u8 shift, u8 width, u32 mask_bit)
> +{
> +	struct ma35d1_adc_clk_divider *div;
> +	struct clk_init_data init;
> +	struct clk_div_table *table;
> +	u32 max_div, min_div;
> +	struct clk_hw *hw;
> +	int ret;
> +	int i;
> +
> +	/* allocate the divider */
> +	div = kzalloc(sizeof(*div), GFP_KERNEL);
> +	if (!div)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Init the divider table */
> +	max_div = div_mask(width) + 1;
> +	min_div = 1;
> +
> +	table = kcalloc(max_div + 1, sizeof(*table), GFP_KERNEL);
> +	if (!table) {
> +		kfree(div);
> +		return ERR_PTR(-ENOMEM);

Use rollback to do error handling:

		ret = ERR_PTR(-ENOMEM);
		goto free_div;

> +	}
> +
> +	for (i = 0; i < max_div; i++) {
> +		table[i].val = (min_div + i);
> +		table[i].div = 2 * table[i].val;
> +	}
> +	table[max_div].val = 0;
> +	table[max_div].div = 0;
> +
> +	init.name = name;
> +	init.ops = &ma35d1_adc_clkdiv_ops;
> +	init.flags |= flags;
> +	init.parent_names = parent_name ? &parent_name : NULL;
> +	init.num_parents = parent_name ? 1 : 0;
> +
> +	/* struct ma35d1_adc_clk_divider assignments */
> +	div->reg = reg;
> +	div->shift = shift;
> +	div->width = width;
> +	div->mask = mask_bit ? BIT(mask_bit) : 0;
> +	div->lock = &ma35d1_lock;
> +	div->hw.init = &init;
> +	div->table = table;
> +
> +	/* Register the clock */
> +	hw = &div->hw;
> +	ret = clk_hw_register(NULL, hw);
> +	if (ret) {
> +		kfree(table);
> +		kfree(div);
> +		return ERR_PTR(ret);

ret = ERR_PTR(ret);
goto free_table;

> +	}
> +	return hw;

free_table:
	kfree(table);
free_div:
	kfree(div);
	return ret;

> +}
> diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c b/drivers/clk/nuvoton/clk-ma35d1-pll.c
> new file mode 100644
> index 000000000000..79e724b148fa
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1-pll.c
> @@ -0,0 +1,534 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/bitfield.h>
> +
> +#include "clk-ma35d1.h"
> +
> +#define to_ma35d1_clk_pll(clk) \
> +	(container_of(clk, struct ma35d1_clk_pll, clk))

static inline

> +
> +#define PLL0CTL0_FBDIV_MSK	GENMASK(7, 0)
> +#define PLL0CTL0_INDIV_MSK	GENMASK(11, 8)
> +#define PLL0CTL0_OUTDIV_MSK	GENMASK(13, 12)
> +#define PLL0CTL0_PD_MSK		BIT(16)
> +#define PLL0CTL0_BP_MSK		BIT(17)
> +#define PLLXCTL0_FBDIV_MSK	GENMASK(10, 0)
> +#define PLLXCTL0_INDIV_MSK	GENMASK(17, 12)
> +#define PLLXCTL0_MODE_MSK	GENMASK(19, 18)
> +#define PLLXCTL0_SSRATE_MSK	GENMASK(30, 20)
> +#define PLLXCTL1_PD_MSK		BIT(0)
> +#define PLLXCTL1_BP_MSK		BIT(1)
> +#define PLLXCTL1_OUTDIV_MSK	GENMASK(6, 4)
> +#define PLLXCTL1_FRAC_MSK	GENMASK(31, 8)
> +#define PLLXCTL2_SLOPE_MSK	GENMASK(23, 0)
> +
> +struct ma35d1_clk_pll {
> +	struct clk_hw hw;
> +	u8 type;
> +	u8 mode;
> +	unsigned long rate;
> +	void __iomem *ctl0_base;
> +	void __iomem *ctl1_base;
> +	void __iomem *ctl2_base;
> +	struct regmap *regmap;
> +};
> +
> +struct vsipll_freq_conf_reg_tbl {
> +	unsigned long freq;
> +	u8 mode;
> +	u32 ctl0_reg;
> +	u32 ctl1_reg;
> +	u32 ctl2_reg;
> +};
> +
> +static const struct vsipll_freq_conf_reg_tbl ma35d1pll_freq[] = {
> +	{ 1000000000, VSIPLL_INTEGER_MODE, 0x307d, 0x10, 0 },
> +	{ 884736000, VSIPLL_FRACTIONAL_MODE, 0x41024, 0xdd2f1b11, 0 },
> +	{ 533000000, VSIPLL_SS_MODE, 0x12b8102c, 0x6aaaab20, 0x12317 },
> +	{ }
> +};
> +
> +static void CLK_UnLockReg(struct ma35d1_clk_pll *pll)

Use lowercase only.

> +{
> +	int ret;
> +
> +	/* Unlock PLL registers */
> +	do {
> +		regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x59);
> +		regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x16);
> +		regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x88);
> +		regmap_read(pll->regmap, REG_SYS_RLKTZNS, &ret);
> +	} while (ret == 0);
> +}
> +
> +static void CLK_LockReg(struct ma35d1_clk_pll *pll)

Ditto.

> +{
> +	/* Lock PLL registers */
> +	regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x0);
> +}
> +
> +/* SMIC PLL for CAPLL */
> +unsigned long CLK_GetPLLFreq_SMICPLL(struct ma35d1_clk_pll *pll,
> +				     unsigned long PllSrcClk)

Lowercase only for function name and variable names. Please do the rest,
I won't mention more of them.

> +{
> +	u32 u32M, u32N, u32P, u32OutDiv;
> +	u32 val;
> +	unsigned long u64PllClk;
> +	u32 clk_div_table[] = { 1, 2, 4, 8};

Inconsistent whitespaces.

> +
> +	val = __raw_readl(pll->ctl0_base);
> +
> +	u32N = FIELD_GET(PLL0CTL0_FBDIV_MSK, val);
> +	u32M = FIELD_GET(PLL0CTL0_INDIV_MSK, val);
> +	u32P = FIELD_GET(PLL0CTL0_OUTDIV_MSK, val);
> +	u32OutDiv = clk_div_table[u32P];
> +
> +	if (val & PLL0CTL0_BP_MSK) {
> +		u64PllClk = PllSrcClk;
> +	} else {
> +		u64PllClk = PllSrcClk * u32N;
> +		do_div(u64PllClk, u32M * u32OutDiv);

Does this block depend on unsigned long being 64-bit? Or should you 
enforce it by using u64 that is always same sized unlike unsigned long?

> +	}
> +	return u64PllClk;
> +}
> +
> +/* VSI-PLL: INTEGER_MODE */
> +unsigned long CLK_CalPLLFreq_Mode0(unsigned long PllSrcClk,
> +				   unsigned long u64PllFreq, u32 *u32Reg)
> +{
> +	u32 u32TmpM, u32TmpN, u32TmpP;
> +	u32 u32RngMinN, u32RngMinM, u32RngMinP;
> +	u32 u32RngMaxN, u32RngMaxM, u32RngMaxP;
> +	u32 u32Tmp, u32Min, u32MinN, u32MinM, u32MinP;

Remove types from names.

> +	unsigned long u64PllClk;
> +	unsigned long u64Con1, u64Con2, u64Con3;

Okay as unsigned long or do you want always 64-bit which is u64 ?

Define these inside the loops below and remove the types from the name.

> +
> +	u64PllClk = 0;
> +	u32Min = (u32) -1;
> +
> +	if (!((u64PllFreq >= VSIPLL_FCLKO_MIN_FREQ) &&
> +	    (u64PllFreq <= VSIPLL_FCLKO_MAX_FREQ))) {
> +		u32Reg[0] = ma35d1pll_freq[0].ctl0_reg;
> +		u32Reg[1] = ma35d1pll_freq[0].ctl1_reg;
> +		u64PllClk = ma35d1pll_freq[0].freq;
> +		return u64PllClk;
> +	}
> +
> +	u32RngMinM = 1UL;
> +	u32RngMaxM = 63UL;
> +	u32RngMinM = ((PllSrcClk / VSIPLL_FREFDIVM_MAX_FREQ) > 1) ?
> +		     (PllSrcClk / VSIPLL_FREFDIVM_MAX_FREQ) : 1;

max(PllSrcClk / VSIPLL_FREFDIVM_MAX_FREQ, 1UL);

Remember to add include for it.

> +	u32RngMaxM = ((PllSrcClk / VSIPLL_FREFDIVM_MIN_FREQ0) < u32RngMaxM) ?
> +		     (PllSrcClk / VSIPLL_FREFDIVM_MIN_FREQ0) : u32RngMaxM;

min();

> +
> +	for (u32TmpM = u32RngMinM; u32TmpM < (u32RngMaxM + 1); u32TmpM++) {

<= and remove + 1

Why can't you call this loop cariable just m ?

> +		u64Con1 = PllSrcClk / u32TmpM;
> +		u32RngMinN = 16UL;
> +		u32RngMaxN = 2047UL;

Why aren't these two values in defines?

> +		u32RngMinN = ((VSIPLL_FCLK_MIN_FREQ / u64Con1) > u32RngMinN) ?
> +			     (VSIPLL_FCLK_MIN_FREQ / u64Con1) : u32RngMinN;

max();

> +		u32RngMaxN = ((VSIPLL_FCLK_MAX_FREQ / u64Con1) < u32RngMaxN) ?
> +			     (VSIPLL_FCLK_MAX_FREQ / u64Con1) : u32RngMaxN;

min();

> +
> +		for (u32TmpN = u32RngMinN; u32TmpN < (u32RngMaxN + 1);

<= and remove + 1

Name variable as n ?

> +		     u32TmpN++) {

One line.

> +			u64Con2 = u64Con1 * u32TmpN;
> +			u32RngMinP = 1UL;
> +			u32RngMaxP = 7UL;

Limits to defines?

> +			u32RngMinP = ((u64Con2 / VSIPLL_FCLKO_MAX_FREQ) > 1) ?
> +				      (u64Con2 / VSIPLL_FCLKO_MAX_FREQ) : 1;
> +			u32RngMaxP = ((u64Con2 / VSIPLL_FCLKO_MIN_FREQ) <
> +				      u32RngMaxP) ?
> +				      (u64Con2 / VSIPLL_FCLKO_MIN_FREQ) :
> +				      u32RngMaxP;

min & max.

> +			for (u32TmpP = u32RngMinP; u32TmpP < (u32RngMaxP + 1);

<= and remove +1?

Name variable as p?

> +			     u32TmpP++) {

One line.

> +				u64Con3 = u64Con2 / u32TmpP;
> +				if (u64Con3 > u64PllFreq)
> +					u32Tmp = u64Con3 - u64PllFreq;
> +				else
> +					u32Tmp = u64PllFreq - u64Con3;

abs()?

> +
> +				if (u32Tmp < u32Min) {
> +					u32Min = u32Tmp;
> +					u32MinM = u32TmpM;
> +					u32MinN = u32TmpN;
> +					u32MinP = u32TmpP;
> +
> +					if (u32Min == 0UL) {

goto out?

> +						u32Reg[0] = (u32MinM << 12) |
> +							    (u32MinN);
> +						u32Reg[1] = (u32MinP << 4);
> +						return ((PllSrcClk * u32MinN) /
> +							(u32MinP * u32MinM));
> +					}
> +				}
> +			}
> +		}
> +	}
> +

out: ?

> +	u32Reg[0] = (u32MinM << 12) | (u32MinN);

FIELD_PREP() | FIELD_PREP() ?

> +	u32Reg[1] = (u32MinP << 4);

FIELD_PREP() ?

> +	u64PllClk = (PllSrcClk * u32MinN) / (u32MinP * u32MinM);

Use the 64-bit divide from math64.h rather than leave it up to compiler.

> +	return u64PllClk;
> +}
> +
> +/* VSI-PLL: FRACTIONAL_MODE */
> +unsigned long CLK_CalPLLFreq_Mode1(unsigned long PllSrcClk,
> +				   unsigned long u64PllFreq, u32 *u32Reg)
> +{
> +	unsigned long u64X, u64N, u64M, u64P, u64tmp;
> +	unsigned long u64PllClk, u64FCLKO;
> +	u32 u32FRAC;
> +
> +	if (u64PllFreq > VSIPLL_FCLKO_MAX_FREQ) {
> +		u32Reg[0] = ma35d1pll_freq[1].ctl0_reg;
> +		u32Reg[1] = ma35d1pll_freq[1].ctl1_reg;
> +		u64PllClk = ma35d1pll_freq[1].freq;
> +		return u64PllClk;
> +	}
> +
> +	if (u64PllFreq > (VSIPLL_FCLKO_MIN_FREQ/(100-1))) {
> +		u64FCLKO = u64PllFreq * ((VSIPLL_FCLKO_MIN_FREQ / u64PllFreq) +
> +			   ((VSIPLL_FCLKO_MIN_FREQ % u64PllFreq) ? 1 : 0));

You need to rework this to do 64-bit divide and remainder with 
something that comes from math64.h.

> +	} else {
> +		pr_err("Failed to set rate %ld\n", u64PllFreq);
> +		return 0;
> +	}
> +
> +	u64P = (u64FCLKO >= VSIPLL_FCLK_MIN_FREQ) ? 1 :
> +	       ((VSIPLL_FCLK_MIN_FREQ / u64FCLKO) +
> +		((VSIPLL_FCLK_MIN_FREQ % u64FCLKO) ? 1 : 0));

Ditto.

Is here some ...ROUND_UP() trick hidden too?

> +
> +	if ((PllSrcClk > (VSIPLL_FREFDIVM_MAX_FREQ * (64-1))) ||
> +	    (PllSrcClk < VSIPLL_FREFDIVM_MIN_FREQ1))
> +		return 0;
> +
> +	u64M = (PllSrcClk <= VSIPLL_FREFDIVM_MAX_FREQ) ? 1 :
> +	       ((PllSrcClk / VSIPLL_FREFDIVM_MAX_FREQ) +
> +	       ((PllSrcClk % VSIPLL_FREFDIVM_MAX_FREQ) ? 1 : 0));

Ditto.

> +
> +	u64tmp = (u64FCLKO * u64P * u64M * 1000) / PllSrcClk;
> +	u64N = u64tmp / 1000;
> +	u64X = u64tmp % 1000;

math64.h x 3 (or x2 since you can get remainder for free I think).

> +	u32FRAC = ((u64X << 24) + 500) / 1000;
> +	u64PllClk = (PllSrcClk * u64tmp) / u64P / u64M / 1000;
> +
> +	u32Reg[0] = (u64M << 12) | (u64N);

FIELD_PREP() ?

> +	u32Reg[1] = (u64P << 4) | (u32FRAC << 8);

FIELD_PREP() ?

> +	return u64PllClk;
> +}
> +
> +/* VSI-PLL: SS_MODE */
> +unsigned long CLK_CalPLLFreq_Mode2(unsigned long PllSrcClk,
> +				   unsigned long u64PllFreq,
> +				   u32 u32SR, u32 u32Fmod, u32 *u32Reg)
> +{
> +	unsigned long u64X, u64N, u64M, u64P, u64tmp, u64tmpP, u64tmpM;
> +	unsigned long u64SSRATE, u64SLOPE, u64PllClk, u64FCLKO;
> +	u32 u32FRAC, i;
> +
> +	if (u64PllFreq >= VSIPLL_FCLKO_MAX_FREQ) {
> +		u32Reg[0] = ma35d1pll_freq[2].ctl0_reg;
> +		u32Reg[1] = ma35d1pll_freq[2].ctl1_reg;
> +		u32Reg[2] = ma35d1pll_freq[2].ctl2_reg;
> +		u64PllClk = ma35d1pll_freq[2].freq;
> +		return u64PllClk;
> +	}
> +
> +	if (u64PllFreq < VSIPLL_FCLKO_MIN_FREQ) {
> +		u64FCLKO = 0;
> +		for (i = 2; i < 8; i++) {
> +			u64tmp = (i * u64PllFreq);
> +			if (u64tmp > VSIPLL_FCLKO_MIN_FREQ)

VSIPLL_FCLKO_MAX_FREQ check is not required ?

> +				u64FCLKO = u64tmp;
> +		}
> +		if (u64FCLKO == 0) {
> +			pr_err("Failed to set rate %ld\n", u64PllFreq);
> +			return 0;
> +		}
> +
> +	} else
> +		u64FCLKO = u64PllFreq;
> +
> +	u64P = 0;
> +	for (i = 1; i < 8; i++) {
> +		u64tmpP = i * u64FCLKO;
> +		if ((u64tmpP <= VSIPLL_FCLK_MAX_FREQ) &&
> +		    (u64tmpP >= VSIPLL_FCLK_MIN_FREQ)) {
> +			u64P = i;
> +			break;
> +		}
> +	}
> +
> +	if (u64P == 0)
> +		return 0;
> +
> +	u64M = 0;
> +	for (i = 1; i < 64; i++) {
> +		u64tmpM = PllSrcClk / i;
> +		if ((u64tmpM <= VSIPLL_FREFDIVM_MAX_FREQ) &&
> +		    (u64tmpM >= VSIPLL_FREFDIVM_MIN_FREQ1)) {
> +			u64M = i;
> +			break;
> +		}
> +	}
> +
> +	if (u64M == 0)
> +		return 0;
> +
> +	u64tmp = (u64FCLKO * u64P * u64M * 1000) / PllSrcClk;
> +	u64N = u64tmp / 1000;
> +	u64X = u64tmp % 1000;
> +	u32FRAC = ((u64X << 24) + 500) / 1000;
> +
> +	u64SSRATE = ((PllSrcClk >> 1) / (u32Fmod * 2)) - 1;
> +	u64SLOPE = ((u64tmp * u32SR / u64SSRATE) << 24) / 100 / 1000;
> +
> +	u64PllClk = (PllSrcClk * u64tmp) / u64P / u64M / 1000;

Is some *SEC_PER_*SEC define relevant for 1000 ?

Or some other units, e.g., HZ related?

> +
> +	u32Reg[0] = (u64SSRATE << VSIPLLCTL0_SSRATE_POS) | (u64M <<
> +		     VSIPLLCTL0_INDIV_POS) | (u64N);

FIELD_PREP()

> +	u32Reg[1] = (u64P << VSIPLLCTL1_OUTDIV_POS) | (u32FRAC << VSIPLLCTL1_FRAC_POS);

Instead of _POS named variables, add GENMASK one instead and use 
FIELD_PREP. You might need to use GENMASK_ULL() for the masks if you are 
dealing with true 64-bitness here instead of the quasi unsigned longs.

> +	u32Reg[2] = u64SLOPE;
> +	return u64PllClk;
> +}
> +
> +unsigned long CLK_SetPLLFreq(struct ma35d1_clk_pll *pll,
> +			     unsigned long PllSrcClk,
> +			     unsigned long u64PllFreq)
> +{
> +	u32 u32Reg[3] = { 0 }, val_ctl0, val_ctl1, val_ctl2;
> +	unsigned long u64PllClk;
> +
> +	val_ctl0 = __raw_readl(pll->ctl0_base);
> +	val_ctl1 = __raw_readl(pll->ctl1_base);
> +	val_ctl2 = __raw_readl(pll->ctl2_base);
> +
> +	switch (pll->mode) {
> +	case VSIPLL_INTEGER_MODE:
> +		u64PllClk = CLK_CalPLLFreq_Mode0(PllSrcClk, u64PllFreq,
> +						 u32Reg);

One line.

> +		val_ctl0 = u32Reg[0] |
> +			   (VSIPLL_INTEGER_MODE << VSIPLLCTL0_MODE_POS);

GENMASK() + FIELD_PREP()

> +		break;
> +	case VSIPLL_FRACTIONAL_MODE:
> +		u64PllClk = CLK_CalPLLFreq_Mode1(PllSrcClk, u64PllFreq,
> +						 u32Reg);
> +		val_ctl0 = u32Reg[0] |
> +			   (VSIPLL_FRACTIONAL_MODE << VSIPLLCTL0_MODE_POS);

Ditto.

> +		break;
> +	case VSIPLL_SS_MODE:
> +		u64PllClk = CLK_CalPLLFreq_Mode2(PllSrcClk, u64PllFreq,
> +						 VSIPLL_MODULATION_FREQ,
> +						 VSIPLL_SPREAD_RANGE, u32Reg);
> +		val_ctl0 = u32Reg[0] |
> +			   (VSIPLL_SS_MODE << VSIPLLCTL0_MODE_POS);

Ditto.

> +		break;
> +	}
> +
> +	val_ctl1 = VSIPLLCTL1_PD_MSK | u32Reg[1];
> +	val_ctl2 = u32Reg[2];
> +
> +	__raw_writel(val_ctl0, pll->ctl0_base);
> +	__raw_writel(val_ctl1, pll->ctl1_base);
> +	__raw_writel(val_ctl2, pll->ctl2_base);
> +	return u64PllClk;
> +}
> +
> +unsigned long CLK_GetPLLFreq_VSIPLL(struct ma35d1_clk_pll *pll,
> +				    unsigned long PllSrcClk)
> +{
> +	u32 u32M, u32N, u32P, u32X, u32SR, u32FMOD;
> +	u32 val_ctl0, val_ctl1, val_ctl2;
> +	unsigned long u64PllClk, u64X;
> +
> +	val_ctl0 = __raw_readl(pll->ctl0_base);
> +	val_ctl1 = __raw_readl(pll->ctl1_base);
> +	val_ctl2 = __raw_readl(pll->ctl2_base);
> +
> +	if (val_ctl1 & PLLXCTL1_BP_MSK) {
> +		u64PllClk = PllSrcClk;
> +		return u64PllClk;
> +	}
> +
> +	if (pll->mode == VSIPLL_INTEGER_MODE) {
> +		u32N = FIELD_GET(PLLXCTL0_FBDIV_MSK, val_ctl0);
> +		u32M = FIELD_GET(PLLXCTL0_INDIV_MSK, val_ctl0);
> +		u32P = FIELD_GET(PLLXCTL1_OUTDIV_MSK, val_ctl1);
> +
> +		u64PllClk = PllSrcClk * u32N;
> +		do_div(u64PllClk, u32M * u32P);
> +
> +	} else if (pll->mode == VSIPLL_FRACTIONAL_MODE) {
> +		u32N = FIELD_GET(PLLXCTL0_FBDIV_MSK, val_ctl0);
> +		u32M = FIELD_GET(PLLXCTL0_INDIV_MSK, val_ctl0);
> +		u32P = FIELD_GET(PLLXCTL1_OUTDIV_MSK, val_ctl1);
> +		u32X = FIELD_GET(PLLXCTL1_FRAC_MSK, val_ctl1);
> +		u64X = (u64) u32X;
> +		u64X = (((u64X * 1000) + 500) >> 24);
> +		u64PllClk = (PllSrcClk * ((u32N * 1000) + u64X)) /
> +			    1000 / u32P / u32M;

math64.h

Please fix the remaining ones w/o me noting them down.

> +
> +	} else {
> +		u32N = FIELD_GET(PLLXCTL0_FBDIV_MSK, val_ctl0);
> +		u32M = FIELD_GET(PLLXCTL0_INDIV_MSK, val_ctl0);
> +		u32SR = FIELD_GET(PLLXCTL0_SSRATE_MSK, val_ctl0);
> +		u32P = FIELD_GET(PLLXCTL1_OUTDIV_MSK, val_ctl1);
> +		u32X = FIELD_GET(PLLXCTL1_FRAC_MSK, val_ctl1);
> +		u32FMOD = FIELD_GET(PLLXCTL2_SLOPE_MSK, val_ctl2);
> +		u64X = (u64) u32X;
> +		u64X = ((u64X * 1000) >> 24);
> +		u64PllClk = (PllSrcClk * ((u32N * 1000) + u64X)) /
> +			    1000 / u32P / u32M;
> +	}
> +	return u64PllClk;
> +}
> +
> +static int ma35d1_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +				      unsigned long parent_rate)
> +{
> +	struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
> +
> +	if ((parent_rate < VSIPLL_FREF_MIN_FREQ) ||
> +	    (parent_rate > VSIPLL_FREF_MAX_FREQ))
> +		return 0;
> +
> +	if ((pll->type == MA35D1_CAPLL) || (pll->type == MA35D1_DDRPLL)) {
> +		pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
> +		return -EACCES;
> +	}
> +	CLK_UnLockReg(pll);
> +	pll->rate = CLK_SetPLLFreq(pll, parent_rate, rate);
> +	CLK_LockReg(pll);
> +	return 0;
> +}
> +
> +static unsigned long ma35d1_clk_pll_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	unsigned long pllfreq;
> +	struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
> +
> +	if ((parent_rate < VSIPLL_FREF_MIN_FREQ)
> +	    || (parent_rate > VSIPLL_FREF_MAX_FREQ))
> +		return 0;
> +
> +	switch (pll->type) {
> +	case MA35D1_CAPLL:
> +		pllfreq = CLK_GetPLLFreq_SMICPLL(pll, parent_rate);
> +		break;
> +	case MA35D1_DDRPLL:
> +	case MA35D1_APLL:
> +	case MA35D1_EPLL:
> +	case MA35D1_VPLL:
> +		pllfreq = CLK_GetPLLFreq_VSIPLL(pll, parent_rate);
> +		break;
> +	}
> +
> +	return pllfreq;
> +}
> +
> +static long ma35d1_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				      unsigned long *prate)
> +{
> +	return rate;
> +}
> +
> +static int ma35d1_clk_pll_is_prepared(struct clk_hw *hw)
> +{
> +	struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
> +	u32 val = __raw_readl(pll->ctl1_base);
> +
> +	return (val & VSIPLLCTL1_PD_MSK) ? 0 : 1;

Unnecessary parenthesis

> +}
> +
> +static int ma35d1_clk_pll_prepare(struct clk_hw *hw)
> +{
> +	struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
> +	u32 val;
> +
> +	if ((pll->type == MA35D1_CAPLL) || (pll->type == MA35D1_DDRPLL)) {
> +		pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
> +		return -EACCES;
> +	}

Add helper for this, there is more than 1 copy of this.

> +
> +	CLK_UnLockReg(pll);
> +	val = __raw_readl(pll->ctl1_base);
> +	val &= ~VSIPLLCTL1_PD_MSK;
> +	__raw_writel(val, pll->ctl1_base);
> +	CLK_LockReg(pll);
> +	return 0;
> +}
> +
> +static void ma35d1_clk_pll_unprepare(struct clk_hw *hw)
> +{
> +	struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
> +	u32 val;
> +
> +	if ((pll->type == MA35D1_CAPLL) || (pll->type == MA35D1_DDRPLL)) {
> +		pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
> +	} else {
> +		val = __raw_readl(pll->ctl1_base);
> +		val |= VSIPLLCTL1_PD_MSK;
> +		__raw_writel(val, pll->ctl1_base);
> +	}
> +}
> +
> +static const struct clk_ops ma35d1_clk_pll_ops = {
> +	.is_prepared = ma35d1_clk_pll_is_prepared,
> +	.prepare = ma35d1_clk_pll_prepare,
> +	.unprepare = ma35d1_clk_pll_unprepare,
> +	.set_rate = ma35d1_clk_pll_set_rate,
> +	.recalc_rate = ma35d1_clk_pll_recalc_rate,
> +	.round_rate = ma35d1_clk_pll_round_rate,
> +};
> +
> +struct clk_hw *ma35d1_reg_clk_pll(enum ma35d1_pll_type type,
> +				  u8 u8mode, const char *name,
> +				  const char *parent,
> +				  unsigned long targetFreq,
> +				  void __iomem *base,
> +				  struct regmap *regmap)
> +{
> +	struct ma35d1_clk_pll *pll;
> +	struct clk_hw *hw;
> +	struct clk_init_data init;
> +	int ret;
> +
> +	pll = kmalloc(sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pll->type = type;
> +	pll->mode = u8mode;
> +	pll->rate = targetFreq;
> +	pll->ctl0_base = base + VSIPLL_CTL0;
> +	pll->ctl1_base = base + VSIPLL_CTL1;
> +	pll->ctl2_base = base + VSIPLL_CTL2;
> +	pll->regmap = regmap;
> +
> +	init.name = name;
> +	init.flags = 0;
> +	init.parent_names = &parent;
> +	init.num_parents = 1;
> +	init.ops = &ma35d1_clk_pll_ops;
> +	pll->hw.init = &init;
> +	hw = &pll->hw;
> +
> +	ret = clk_hw_register(NULL, hw);
> +	if (ret) {
> +		pr_err("failed to register vsi-pll clock!!!\n");

No need to use ! let alone 3 of them.

> +		kfree(pll);
> +		return ERR_PTR(ret);
> +	}
> +	return hw;
> +}
> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
> new file mode 100644
> index 000000000000..ac8154458b81
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
> @@ -0,0 +1,970 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +
> +#include "clk-ma35d1.h"
> +
> +DEFINE_SPINLOCK(ma35d1_lock);
> +
> +static const char *const ca35clk_sel_clks[] = {
> +	"hxt", "capll", "ddrpll", "dummy"
> +};
> +
> +static const char *const sysclk0_sel_clks[] = {
> +	"epll_div2", "syspll"
> +};
> +
> +static const char *const sysclk1_sel_clks[] = {
> +	"hxt", "syspll"
> +};
> +
> +static const char *const axiclk_sel_clks[] = {
> +	"capll_div2", "capll_div4"
> +};
> +
> +static const char *const ccap_sel_clks[] = {
> +	"hxt", "vpll", "apll", "syspll"
> +};
> +
> +static const char *const sdh_sel_clks[] = {
> +	"syspll", "apll", "dummy", "dummy"
> +};
> +
> +static const char *const dcu_sel_clks[] = {
> +	"epll_div2", "syspll"
> +};
> +
> +static const char *const gfx_sel_clks[] = {
> +	"epll", "syspll"
> +};
> +
> +static const char *const dbg_sel_clks[] = {
> +	"hirc", "syspll"
> +};
> +
> +static const char *const timer0_sel_clks[] = {
> +	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const timer1_sel_clks[] = {
> +	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const timer2_sel_clks[] = {
> +	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const timer3_sel_clks[] = {
> +	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const timer4_sel_clks[] = {
> +	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const timer5_sel_clks[] = {
> +	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const timer6_sel_clks[] = {
> +	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const timer7_sel_clks[] = {
> +	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const timer8_sel_clks[] = {
> +	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const timer9_sel_clks[] = {
> +	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const timer10_sel_clks[] = {
> +	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const timer11_sel_clks[] = {
> +	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
> +};
> +
> +static const char *const uart_sel_clks[] = {
> +	"hxt", "sysclk1_div2", "dummy", "dummy"
> +};
> +
> +static const char *const wdt0_sel_clks[] = {
> +	"dummy", "lxt", "pclk3_div4096", "lirc"
> +};
> +
> +static const char *const wdt1_sel_clks[] = {
> +	"dummy", "lxt", "pclk3_div4096", "lirc"
> +};
> +
> +static const char *const wdt2_sel_clks[] = {
> +	"dummy", "lxt", "pclk4_div4096", "lirc"
> +};
> +
> +static const char *const wwdt0_sel_clks[] = {
> +	"dummy", "dummy", "pclk3_div4096", "lirc"
> +};
> +
> +static const char *const wwdt1_sel_clks[] = {
> +	"dummy", "dummy", "pclk3_div4096", "lirc"
> +};
> +
> +static const char *const wwdt2_sel_clks[] = {
> +	"dummy", "dummy", "pclk4_div4096", "lirc"
> +};
> +
> +static const char *const spi0_sel_clks[] = {
> +	"pclk1", "apll", "dummy", "dummy"
> +};
> +
> +static const char *const spi1_sel_clks[] = {
> +	"pclk2", "apll", "dummy", "dummy"
> +};
> +
> +static const char *const spi2_sel_clks[] = {
> +	"pclk1", "apll", "dummy", "dummy"
> +};
> +
> +static const char *const spi3_sel_clks[] = {
> +	"pclk2", "apll", "dummy", "dummy"
> +};
> +
> +static const char *const qspi0_sel_clks[] = {
> +	"pclk0", "apll", "dummy", "dummy"
> +};
> +
> +static const char *const qspi1_sel_clks[] = {
> +	"pclk0", "apll", "dummy", "dummy"
> +};
> +
> +static const char *const i2s0_sel_clks[] = {
> +	"apll", "sysclk1_div2", "dummy", "dummy"
> +};
> +
> +static const char *const i2s1_sel_clks[] = {
> +	"apll", "sysclk1_div2", "dummy", "dummy"
> +};
> +
> +static const char *const can_sel_clks[] = {
> +	"apll", "vpll"
> +};
> +
> +static const char *const cko_sel_clks[] = {
> +	"hxt", "lxt", "hirc", "lirc", "capll_div4", "syspll",
> +	"ddrpll", "epll_div2", "apll", "vpll", "dummy", "dummy",
> +	"dummy", "dummy", "dummy", "dummy"
> +};
> +
> +static const char *const smc_sel_clks[] = {
> +	"hxt", "pclk4"
> +};
> +
> +static const char *const kpi_sel_clks[] = {
> +	"hxt", "lxt"
> +};
> +
> +static const struct clk_div_table ip_div_table[] = {
> +	{0, 2}, {1, 4}, {2, 6}, {3, 8}, {4, 10},
> +	{5, 12}, {6, 14}, {7, 16}, {0, 0},
> +};
> +
> +static const struct clk_div_table eadc_div_table[] = {
> +	{0, 2}, {1, 4}, {2, 6}, {3, 8}, {4, 10},
> +	{5, 12}, {6, 14}, {7, 16}, {8, 18},
> +	{9, 20}, {10, 22}, {11, 24}, {12, 26},
> +	{13, 28}, {14, 30}, {15, 32}, {0, 0},
> +};
> +
> +static struct clk_hw **hws;
> +static struct clk_hw_onecell_data *ma35d1_hw_data;
> +
> +static int ma35d1_clocks_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *clk_node = dev->of_node;
> +	void __iomem *clk_base;
> +	struct regmap *regmap;
> +	u32 pllmode[5] = { 0, 0, 0, 0, 0 };
> +	u32 pllfreq[5] = { 0, 0, 0, 0, 0 };
> +
> +	dev_info(&pdev->dev, "Nuvoton MA35D1 Clock Driver\n");
> +	ma35d1_hw_data = devm_kzalloc(&pdev->dev, struct_size(ma35d1_hw_data,
> +				      hws, CLK_MAX_IDX), GFP_KERNEL);
> +
> +	if (WARN_ON(!ma35d1_hw_data))
> +		return -ENOMEM;
> +
> +	ma35d1_hw_data->num = CLK_MAX_IDX;
> +	hws = ma35d1_hw_data->hws;
> +
> +	clk_node = of_find_compatible_node(NULL, NULL, "nuvoton,ma35d1-clk");
> +	clk_base = of_iomap(clk_node, 0);
> +	of_node_put(clk_node);
> +	if (!clk_base) {
> +		pr_err("%s: could not map region\n", __func__);
> +		return -ENOMEM;
> +	}
> +	regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +						 "nuvoton,sys");
> +	if (IS_ERR(regmap))
> +		pr_warn("%s: Unable to get syscon\n", __func__);

Don't print __func__ to user.

> +
> +	/* clock sources */
> +	hws[HXT] = ma35d1_clk_fixed("hxt", 24000000);
> +	hws[HXT_GATE] = ma35d1_clk_gate("hxt_gate", "hxt",
> +					clk_base + REG_CLK_PWRCTL, 0);
> +	hws[LXT] = ma35d1_clk_fixed("lxt", 32768);
> +	hws[LXT_GATE] = ma35d1_clk_gate("lxt_gate", "lxt",
> +					clk_base + REG_CLK_PWRCTL, 1);
> +	hws[HIRC] = ma35d1_clk_fixed("hirc", 12000000);
> +	hws[HIRC_GATE] = ma35d1_clk_gate("hirc_gate", "hirc",
> +					 clk_base + REG_CLK_PWRCTL, 2);
> +	hws[LIRC] = ma35d1_clk_fixed("lirc", 32000);
> +	hws[LIRC_GATE] = ma35d1_clk_gate("lirc_gate", "lirc",
> +					 clk_base + REG_CLK_PWRCTL, 3);
> +
> +	/* PLL */
> +	of_property_read_u32_array(clk_node, "clock-pll-mode", pllmode,
> +				   ARRAY_SIZE(pllmode));
> +	of_property_read_u32_array(clk_node, "assigned-clock-rates", pllfreq,
> +				   ARRAY_SIZE(pllfreq));
> +
> +	/* SMIC PLL */
> +	hws[CAPLL] = ma35d1_reg_clk_pll(MA35D1_CAPLL, pllmode[0], "capll",
> +					"hxt", pllfreq[0],
> +					clk_base + REG_CLK_PLL0CTL0, regmap);
> +	hws[SYSPLL] = ma35d1_clk_fixed("syspll", 180000000);
> +
> +	/* VSI PLL */
> +	hws[DDRPLL] = ma35d1_reg_clk_pll(MA35D1_DDRPLL, pllmode[1], "ddrpll",
> +					 "hxt", pllfreq[1],
> +					 clk_base + REG_CLK_PLL2CTL0, regmap);
> +	hws[APLL] = ma35d1_reg_clk_pll(MA35D1_APLL, pllmode[2], "apll", "hxt",
> +				       pllfreq[2], clk_base + REG_CLK_PLL3CTL0,
> +				       regmap);
> +	hws[EPLL] = ma35d1_reg_clk_pll(MA35D1_EPLL, pllmode[3], "epll", "hxt",
> +				       pllfreq[3], clk_base + REG_CLK_PLL4CTL0,
> +				       regmap);
> +	hws[VPLL] = ma35d1_reg_clk_pll(MA35D1_VPLL, pllmode[4], "vpll", "hxt",
> +				       pllfreq[4], clk_base + REG_CLK_PLL5CTL0,
> +				       regmap);
> +	hws[EPLL_DIV2] = ma35d1_clk_fixed_factor("epll_div2", "epll", 1, 2);
> +	hws[EPLL_DIV4] = ma35d1_clk_fixed_factor("epll_div4", "epll", 1, 4);
> +	hws[EPLL_DIV8] = ma35d1_clk_fixed_factor("epll_div8", "epll", 1, 8);
> +
> +	/* CA35 */
> +	hws[CA35CLK_MUX] = ma35d1_clk_mux("ca35clk_mux",
> +					  clk_base + REG_CLK_CLKSEL0, 0,
> +					  2, ca35clk_sel_clks,
> +					  ARRAY_SIZE(ca35clk_sel_clks));
> +
> +	/* AXI */
> +	hws[AXICLK_DIV2] = ma35d1_clk_fixed_factor("capll_div2", "ca35clk_mux",
> +						   1, 2);
> +	hws[AXICLK_DIV4] = ma35d1_clk_fixed_factor("capll_div4", "ca35clk_mux",
> +						   1, 4);
> +	hws[AXICLK_MUX] = ma35d1_clk_mux("axiclk_mux",
> +					 clk_base + REG_CLK_CLKDIV0,
> +					 26, 1, axiclk_sel_clks,
> +					 ARRAY_SIZE(axiclk_sel_clks));
> +
> +	/* SYSCLK0 & SYSCLK1 */
> +	hws[SYSCLK0_MUX] = ma35d1_clk_mux("sysclk0_mux",
> +					  clk_base + REG_CLK_CLKSEL0,
> +					  2, 1, sysclk0_sel_clks,
> +					  ARRAY_SIZE(sysclk0_sel_clks));
> +	hws[SYSCLK1_MUX] = ma35d1_clk_mux("sysclk1_mux",
> +					  clk_base + REG_CLK_CLKSEL0,
> +					  4, 1, sysclk1_sel_clks,
> +					  ARRAY_SIZE(sysclk1_sel_clks));
> +	hws[SYSCLK1_DIV2] = ma35d1_clk_fixed_factor("sysclk1_div2",
> +						    "sysclk1_mux", 1, 2);
> +
> +	/* HCLK0~3 & PCLK0~4 */
> +	hws[HCLK0] = ma35d1_clk_fixed_factor("hclk0", "sysclk1_mux", 1, 1);
> +	hws[HCLK1] = ma35d1_clk_fixed_factor("hclk1", "sysclk1_mux", 1, 1);
> +	hws[HCLK2] = ma35d1_clk_fixed_factor("hclk2", "sysclk1_mux", 1, 1);
> +	hws[PCLK0] = ma35d1_clk_fixed_factor("pclk0", "sysclk1_mux", 1, 1);
> +	hws[PCLK1] = ma35d1_clk_fixed_factor("pclk1", "sysclk1_mux", 1, 1);
> +	hws[PCLK2] = ma35d1_clk_fixed_factor("pclk2", "sysclk1_mux", 1, 1);
> +
> +	hws[HCLK3] = ma35d1_clk_fixed_factor("hclk3", "sysclk1_mux", 1, 2);
> +	hws[PCLK3] = ma35d1_clk_fixed_factor("pclk3", "sysclk1_mux", 1, 2);
> +	hws[PCLK4] = ma35d1_clk_fixed_factor("pclk4", "sysclk1_mux", 1, 2);
> +
> +	hws[USBPHY0] = ma35d1_clk_fixed("usbphy0", 480000000);
> +	hws[USBPHY1] = ma35d1_clk_fixed("usbphy1", 480000000);
> +
> +	/* DDR */
> +	hws[DDR0_GATE] = ma35d1_clk_gate("ddr0_gate", "ddrpll",
> +					 clk_base + REG_CLK_SYSCLK0, 4);
> +	hws[DDR6_GATE] = ma35d1_clk_gate("ddr6_gate", "ddrpll",
> +					 clk_base + REG_CLK_SYSCLK0, 5);
> +
> +	/* CAN0 */
> +	hws[CAN0_MUX] = ma35d1_clk_mux("can0_mux", clk_base + REG_CLK_CLKSEL4,
> +				       16, 1, can_sel_clks,
> +				       ARRAY_SIZE(can_sel_clks));
> +	hws[CAN0_DIV] = ma35d1_clk_divider_table("can0_div", "can0_mux",
> +						 clk_base + REG_CLK_CLKDIV0,
> +						 0, 3, ip_div_table);
> +	hws[CAN0_GATE] = ma35d1_clk_gate("can0_gate", "can0_div",
> +					 clk_base + REG_CLK_SYSCLK0, 8);
> +
> +	/* CAN1 */
> +	hws[CAN1_MUX] = ma35d1_clk_mux("can1_mux", clk_base + REG_CLK_CLKSEL4,
> +				       17, 1, can_sel_clks,
> +				       ARRAY_SIZE(can_sel_clks));
> +	hws[CAN1_DIV] = ma35d1_clk_divider_table("can1_div", "can1_mux",
> +						 clk_base + REG_CLK_CLKDIV0,
> +						 4, 3, ip_div_table);
> +	hws[CAN1_GATE] = ma35d1_clk_gate("can1_gate", "can1_div",
> +					 clk_base + REG_CLK_SYSCLK0, 9);
> +
> +	/* CAN2 */
> +	hws[CAN2_MUX] = ma35d1_clk_mux("can2_mux", clk_base + REG_CLK_CLKSEL4,
> +				       18, 1, can_sel_clks,
> +				       ARRAY_SIZE(can_sel_clks));
> +	hws[CAN2_DIV] = ma35d1_clk_divider_table("can2_div", "can2_mux",
> +						 clk_base + REG_CLK_CLKDIV0,
> +						 8, 3, ip_div_table);
> +	hws[CAN2_GATE] = ma35d1_clk_gate("can2_gate", "can2_div",
> +					 clk_base + REG_CLK_SYSCLK0, 10);
> +
> +	/* CAN3 */
> +	hws[CAN3_MUX] = ma35d1_clk_mux("can3_mux", clk_base + REG_CLK_CLKSEL4,
> +				       19, 1, can_sel_clks,
> +				       ARRAY_SIZE(can_sel_clks));
> +	hws[CAN3_DIV] = ma35d1_clk_divider_table("can3_div", "can3_mux",
> +						 clk_base + REG_CLK_CLKDIV0,
> +						 12, 3, ip_div_table);
> +	hws[CAN3_GATE] = ma35d1_clk_gate("can3_gate", "can3_div",
> +					 clk_base + REG_CLK_SYSCLK0, 11);
> +
> +	/* SDH0 */
> +	hws[SDH0_MUX] = ma35d1_clk_mux("sdh0_mux", clk_base + REG_CLK_CLKSEL0,
> +				       16, 2, sdh_sel_clks,
> +				       ARRAY_SIZE(sdh_sel_clks));
> +	hws[SDH0_GATE] = ma35d1_clk_gate("sdh0_gate", "sdh0_mux",
> +					 clk_base + REG_CLK_SYSCLK0, 16);
> +
> +	/* SDH1 */
> +	hws[SDH1_MUX] = ma35d1_clk_mux("sdh1_mux", clk_base + REG_CLK_CLKSEL0,
> +				       18, 2, sdh_sel_clks,
> +				       ARRAY_SIZE(sdh_sel_clks));
> +	hws[SDH1_GATE] = ma35d1_clk_gate("sdh1_gate", "sdh1_mux",
> +					 clk_base + REG_CLK_SYSCLK0, 17);
> +
> +	/* NAND */
> +	hws[NAND_GATE] = ma35d1_clk_gate("nand_gate", "hclk1",
> +					 clk_base + REG_CLK_SYSCLK0, 18);
> +
> +	/* USB */
> +	hws[USBD_GATE] = ma35d1_clk_gate("usbd_gate", "usbphy0",
> +					 clk_base + REG_CLK_SYSCLK0, 19);
> +	hws[USBH_GATE] = ma35d1_clk_gate("usbh_gate", "usbphy0",
> +					 clk_base + REG_CLK_SYSCLK0, 20);
> +	hws[HUSBH0_GATE] = ma35d1_clk_gate("husbh0_gate", "usbphy0",
> +					   clk_base + REG_CLK_SYSCLK0, 21);
> +	hws[HUSBH1_GATE] = ma35d1_clk_gate("husbh1_gate", "usbphy0",
> +					   clk_base + REG_CLK_SYSCLK0, 22);
> +
> +	/* GFX */
> +	hws[GFX_MUX] = ma35d1_clk_mux("gfx_mux", clk_base + REG_CLK_CLKSEL0,
> +				      26, 1, gfx_sel_clks,
> +				      ARRAY_SIZE(gfx_sel_clks));
> +	hws[GFX_GATE] = ma35d1_clk_gate("gfx_gate", "gfx_mux",
> +					clk_base + REG_CLK_SYSCLK0, 24);
> +
> +	/* VC8K */
> +	hws[VC8K_GATE] = ma35d1_clk_gate("vc8k_gate", "sysclk0_mux",
> +					 clk_base + REG_CLK_SYSCLK0, 25);
> +
> +	/* DCU */
> +	hws[DCU_MUX] = ma35d1_clk_mux("dcu_mux", clk_base + REG_CLK_CLKSEL0,
> +				      24, 1, dcu_sel_clks,
> +				      ARRAY_SIZE(dcu_sel_clks));
> +	hws[DCU_GATE] = ma35d1_clk_gate("dcu_gate", "dcu_mux",
> +					clk_base + REG_CLK_SYSCLK0, 26);
> +
> +	/* DCUP */
> +	hws[DCUP_DIV] = ma35d1_clk_divider_table("dcup_div", "vpll",
> +						 clk_base + REG_CLK_CLKDIV0,
> +						 16, 3, ip_div_table);
> +
> +	/* EMAC0 */
> +	hws[EMAC0_GATE] = ma35d1_clk_gate("emac0_gate", "epll_div2",
> +					  clk_base + REG_CLK_SYSCLK0, 27);
> +
> +	/* EMAC1 */
> +	hws[EMAC1_GATE] = ma35d1_clk_gate("emac1_gate", "epll_div2",
> +					  clk_base + REG_CLK_SYSCLK0, 28);
> +
> +	/* CCAP0 */
> +	hws[CCAP0_MUX] = ma35d1_clk_mux("ccap0_mux",
> +					clk_base + REG_CLK_CLKSEL0,
> +					12, 1, ccap_sel_clks,
> +					ARRAY_SIZE(ccap_sel_clks));
> +	hws[CCAP0_DIV] = ma35d1_clk_divider("ccap0_div", "ccap0_mux",
> +					    clk_base + REG_CLK_CLKDIV1, 8, 4);
> +	hws[CCAP0_GATE] = ma35d1_clk_gate("ccap0_gate", "ccap0_div",
> +					  clk_base + REG_CLK_SYSCLK0, 29);
> +
> +	/* CCAP1 */
> +	hws[CCAP1_MUX] = ma35d1_clk_mux("ccap1_mux",
> +					clk_base + REG_CLK_CLKSEL0,
> +					14, 1, ccap_sel_clks,
> +					ARRAY_SIZE(ccap_sel_clks));
> +	hws[CCAP1_DIV] = ma35d1_clk_divider("ccap1_div", "ccap1_mux",
> +					    clk_base + REG_CLK_CLKDIV1,
> +					    12, 4);
> +	hws[CCAP1_GATE] = ma35d1_clk_gate("ccap1_gate", "ccap1_div",
> +					  clk_base + REG_CLK_SYSCLK0, 30);
> +
> +	/* PDMA0~3 */
> +	hws[PDMA0_GATE] = ma35d1_clk_gate("pdma0_gate", "hclk0",
> +					  clk_base + REG_CLK_SYSCLK1, 0);
> +	hws[PDMA1_GATE] = ma35d1_clk_gate("pdma1_gate", "hclk0",
> +					  clk_base + REG_CLK_SYSCLK1, 1);
> +	hws[PDMA2_GATE] = ma35d1_clk_gate("pdma2_gate", "hclk0",
> +					  clk_base + REG_CLK_SYSCLK1, 2);
> +	hws[PDMA3_GATE] = ma35d1_clk_gate("pdma3_gate", "hclk0",
> +					  clk_base + REG_CLK_SYSCLK1, 3);
> +
> +	/* WH0~1 */
> +	hws[WH0_GATE] = ma35d1_clk_gate("wh0_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 4);
> +	hws[WH1_GATE] = ma35d1_clk_gate("wh1_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 5);
> +
> +	/* HWS */
> +	hws[HWS_GATE] = ma35d1_clk_gate("hws_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 6);
> +
> +	/* EBI */
> +	hws[EBI_GATE] = ma35d1_clk_gate("ebi_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 7);
> +
> +	/* SRAM0~1 */
> +	hws[SRAM0_GATE] = ma35d1_clk_gate("sram0_gate", "hclk0",
> +					  clk_base + REG_CLK_SYSCLK1, 8);
> +	hws[SRAM1_GATE] = ma35d1_clk_gate("sram1_gate", "hclk0",
> +					  clk_base + REG_CLK_SYSCLK1, 9);
> +
> +	/* ROM */
> +	hws[ROM_GATE] = ma35d1_clk_gate("rom_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 10);
> +
> +	/* TRA */
> +	hws[TRA_GATE] = ma35d1_clk_gate("tra_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 11);
> +
> +	/* DBG */
> +	hws[DBG_MUX] = ma35d1_clk_mux("dbg_mux", clk_base + REG_CLK_CLKSEL0,
> +				      27, 1, dbg_sel_clks,
> +				      ARRAY_SIZE(dbg_sel_clks));
> +	hws[DBG_GATE] = ma35d1_clk_gate("dbg_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 12);
> +
> +	/* CLKO */
> +	hws[CKO_MUX] = ma35d1_clk_mux("cko_mux", clk_base + REG_CLK_CLKSEL4,
> +				      24, 4, cko_sel_clks,
> +				      ARRAY_SIZE(cko_sel_clks));
> +	hws[CKO_DIV] = ma35d1_clk_divider_pow2("cko_div", "cko_mux",
> +					       clk_base + REG_CLK_CLKOCTL,
> +					       0, 4);
> +	hws[CKO_GATE] = ma35d1_clk_gate("cko_gate", "cko_div",
> +					clk_base + REG_CLK_SYSCLK1, 13);
> +
> +	/* GTMR */
> +	hws[GTMR_GATE] = ma35d1_clk_gate("gtmr_gate", "hirc",
> +					 clk_base + REG_CLK_SYSCLK1, 14);
> +
> +	/* GPIO */
> +	hws[GPA_GATE] = ma35d1_clk_gate("gpa_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 16);
> +	hws[GPB_GATE] = ma35d1_clk_gate("gpb_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 17);
> +	hws[GPC_GATE] = ma35d1_clk_gate("gpc_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 18);
> +	hws[GPD_GATE] = ma35d1_clk_gate("gpd_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 19);
> +	hws[GPE_GATE] = ma35d1_clk_gate("gpe_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 20);
> +	hws[GPF_GATE] = ma35d1_clk_gate("gpf_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 21);
> +	hws[GPG_GATE] = ma35d1_clk_gate("gpg_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 22);
> +	hws[GPH_GATE] = ma35d1_clk_gate("gph_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 23);
> +	hws[GPI_GATE] = ma35d1_clk_gate("gpi_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 24);
> +	hws[GPJ_GATE] = ma35d1_clk_gate("gpj_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 25);
> +	hws[GPK_GATE] = ma35d1_clk_gate("gpk_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 26);
> +	hws[GPL_GATE] = ma35d1_clk_gate("gpl_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 27);
> +	hws[GPM_GATE] = ma35d1_clk_gate("gpm_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 28);
> +	hws[GPN_GATE] = ma35d1_clk_gate("gpn_gate", "hclk0",
> +					clk_base + REG_CLK_SYSCLK1, 29);
> +
> +	/* TIMER0~11 */
> +	hws[TMR0_MUX] = ma35d1_clk_mux("tmr0_mux", clk_base + REG_CLK_CLKSEL1,
> +				       0, 3, timer0_sel_clks,
> +				       ARRAY_SIZE(timer0_sel_clks));
> +	hws[TMR0_GATE] = ma35d1_clk_gate("tmr0_gate", "tmr0_mux",
> +					 clk_base + REG_CLK_APBCLK0, 0);
> +	hws[TMR1_MUX] = ma35d1_clk_mux("tmr1_mux", clk_base + REG_CLK_CLKSEL1,
> +				       4, 3, timer1_sel_clks,
> +				       ARRAY_SIZE(timer1_sel_clks));
> +	hws[TMR1_GATE] = ma35d1_clk_gate("tmr1_gate", "tmr1_mux",
> +					 clk_base + REG_CLK_APBCLK0, 1);
> +	hws[TMR2_MUX] = ma35d1_clk_mux("tmr2_mux", clk_base + REG_CLK_CLKSEL1,
> +				       8, 3, timer2_sel_clks,
> +				       ARRAY_SIZE(timer2_sel_clks));
> +	hws[TMR2_GATE] = ma35d1_clk_gate("tmr2_gate", "tmr2_mux",
> +					 clk_base + REG_CLK_APBCLK0, 2);
> +	hws[TMR3_MUX] = ma35d1_clk_mux("tmr3_mux", clk_base + REG_CLK_CLKSEL1,
> +				       12, 3, timer3_sel_clks,
> +				       ARRAY_SIZE(timer3_sel_clks));
> +	hws[TMR3_GATE] = ma35d1_clk_gate("tmr3_gate", "tmr3_mux",
> +					 clk_base + REG_CLK_APBCLK0, 3);
> +	hws[TMR4_MUX] = ma35d1_clk_mux("tmr4_mux", clk_base + REG_CLK_CLKSEL1,
> +				       16, 3, timer4_sel_clks,
> +				       ARRAY_SIZE(timer4_sel_clks));
> +	hws[TMR4_GATE] = ma35d1_clk_gate("tmr4_gate", "tmr4_mux",
> +					 clk_base + REG_CLK_APBCLK0, 4);
> +	hws[TMR5_MUX] = ma35d1_clk_mux("tmr5_mux", clk_base + REG_CLK_CLKSEL1,
> +				       20, 3, timer5_sel_clks,
> +				       ARRAY_SIZE(timer5_sel_clks));
> +	hws[TMR5_GATE] = ma35d1_clk_gate("tmr5_gate", "tmr5_mux",
> +					 clk_base + REG_CLK_APBCLK0, 5);
> +	hws[TMR6_MUX] = ma35d1_clk_mux("tmr6_mux", clk_base + REG_CLK_CLKSEL1,
> +				       24, 3, timer6_sel_clks,
> +				       ARRAY_SIZE(timer6_sel_clks));
> +	hws[TMR6_GATE] = ma35d1_clk_gate("tmr6_gate", "tmr6_mux",
> +					 clk_base + REG_CLK_APBCLK0, 6);
> +	hws[TMR7_MUX] = ma35d1_clk_mux("tmr7_mux", clk_base + REG_CLK_CLKSEL1,
> +				       28, 3, timer7_sel_clks,
> +				       ARRAY_SIZE(timer7_sel_clks));
> +	hws[TMR7_GATE] = ma35d1_clk_gate("tmr7_gate", "tmr7_mux",
> +					 clk_base + REG_CLK_APBCLK0, 7);
> +	hws[TMR8_MUX] = ma35d1_clk_mux("tmr8_mux", clk_base + REG_CLK_CLKSEL2,
> +				       0, 3, timer8_sel_clks,
> +				       ARRAY_SIZE(timer8_sel_clks));
> +	hws[TMR8_GATE] = ma35d1_clk_gate("tmr8_gate", "tmr8_mux",
> +					 clk_base + REG_CLK_APBCLK0, 8);
> +	hws[TMR9_MUX] = ma35d1_clk_mux("tmr9_mux", clk_base + REG_CLK_CLKSEL2,
> +				       4, 3, timer9_sel_clks,
> +				       ARRAY_SIZE(timer9_sel_clks));
> +	hws[TMR9_GATE] = ma35d1_clk_gate("tmr9_gate", "tmr9_mux",
> +					 clk_base + REG_CLK_APBCLK0, 9);
> +	hws[TMR10_MUX] = ma35d1_clk_mux("tmr10_mux",
> +					clk_base + REG_CLK_CLKSEL2,
> +					8, 3, timer10_sel_clks,
> +					ARRAY_SIZE(timer10_sel_clks));
> +	hws[TMR10_GATE] = ma35d1_clk_gate("tmr10_gate", "tmr10_mux",
> +					  clk_base + REG_CLK_APBCLK0, 10);
> +	hws[TMR11_MUX] = ma35d1_clk_mux("tmr11_mux",
> +					clk_base + REG_CLK_CLKSEL2,
> +					12, 3, timer11_sel_clks,
> +					ARRAY_SIZE(timer11_sel_clks));
> +	hws[TMR11_GATE] = ma35d1_clk_gate("tmr11_gate", "tmr11_mux",
> +					  clk_base + REG_CLK_APBCLK0, 11);
> +
> +	/* UART0~16 */
> +	hws[UART0_MUX] = ma35d1_clk_mux("uart0_mux",
> +					clk_base + REG_CLK_CLKSEL2,
> +					16, 2, uart_sel_clks,
> +					ARRAY_SIZE(uart_sel_clks));
> +	hws[UART0_DIV] = ma35d1_clk_divider("uart0_div", "uart0_mux",
> +					    clk_base + REG_CLK_CLKDIV1,
> +					    16, 4);
> +	hws[UART0_GATE] = ma35d1_clk_gate("uart0_gate", "uart0_div",
> +					  clk_base + REG_CLK_APBCLK0, 12);
> +	hws[UART1_MUX] = ma35d1_clk_mux("uart1_mux",
> +					clk_base + REG_CLK_CLKSEL2,
> +					18, 2, uart_sel_clks,
> +					ARRAY_SIZE(uart_sel_clks));
> +	hws[UART1_DIV] = ma35d1_clk_divider("uart1_div", "uart1_mux",
> +					    clk_base + REG_CLK_CLKDIV1,
> +					    20, 4);
> +	hws[UART1_GATE] = ma35d1_clk_gate("uart1_gate", "uart1_div",
> +					  clk_base + REG_CLK_APBCLK0, 13);
> +	hws[UART2_MUX] = ma35d1_clk_mux("uart2_mux",
> +					clk_base + REG_CLK_CLKSEL2,
> +					20, 2, uart_sel_clks,
> +					ARRAY_SIZE(uart_sel_clks));
> +	hws[UART2_DIV] = ma35d1_clk_divider("uart2_div", "uart2_mux",
> +					    clk_base + REG_CLK_CLKDIV1,
> +					    24, 4);
> +	hws[UART2_GATE] = ma35d1_clk_gate("uart2_gate", "uart2_div",
> +					  clk_base + REG_CLK_APBCLK0, 14);
> +	hws[UART3_MUX] = ma35d1_clk_mux("uart3_mux",
> +					clk_base + REG_CLK_CLKSEL2,
> +					22, 2, uart_sel_clks,
> +					ARRAY_SIZE(uart_sel_clks));
> +	hws[UART3_DIV] = ma35d1_clk_divider("uart3_div", "uart3_mux",
> +					    clk_base + REG_CLK_CLKDIV1,
> +					    28, 4);
> +	hws[UART3_GATE] = ma35d1_clk_gate("uart3_gate", "uart3_div",
> +					  clk_base + REG_CLK_APBCLK0, 15);
> +	hws[UART4_MUX] = ma35d1_clk_mux("uart4_mux",
> +					clk_base + REG_CLK_CLKSEL2,
> +					24, 2, uart_sel_clks,
> +					ARRAY_SIZE(uart_sel_clks));
> +	hws[UART4_DIV] = ma35d1_clk_divider("uart4_div", "uart4_mux",
> +					    clk_base + REG_CLK_CLKDIV2,
> +					    0, 4);
> +	hws[UART4_GATE] = ma35d1_clk_gate("uart4_gate", "uart4_div",
> +					  clk_base + REG_CLK_APBCLK0, 16);
> +	hws[UART5_MUX] = ma35d1_clk_mux("uart5_mux",
> +					clk_base + REG_CLK_CLKSEL2,
> +					26, 2, uart_sel_clks,
> +					ARRAY_SIZE(uart_sel_clks));
> +	hws[UART5_DIV] = ma35d1_clk_divider("uart5_div", "uart5_mux",
> +					    clk_base + REG_CLK_CLKDIV2,
> +					    4, 4);
> +	hws[UART5_GATE] = ma35d1_clk_gate("uart5_gate", "uart5_div",
> +					  clk_base + REG_CLK_APBCLK0, 17);
> +	hws[UART6_MUX] = ma35d1_clk_mux("uart6_mux",
> +					clk_base + REG_CLK_CLKSEL2,
> +					28, 2, uart_sel_clks,
> +					ARRAY_SIZE(uart_sel_clks));
> +	hws[UART6_DIV] = ma35d1_clk_divider("uart6_div", "uart6_mux",
> +					    clk_base + REG_CLK_CLKDIV2,
> +					    8, 4);
> +	hws[UART6_GATE] = ma35d1_clk_gate("uart6_gate", "uart6_div",
> +					  clk_base + REG_CLK_APBCLK0, 18);
> +	hws[UART7_MUX] = ma35d1_clk_mux("uart7_mux",
> +					clk_base + REG_CLK_CLKSEL2,
> +					30, 2, uart_sel_clks,
> +					ARRAY_SIZE(uart_sel_clks));
> +	hws[UART7_DIV] = ma35d1_clk_divider("uart7_div", "uart7_mux",
> +					    clk_base + REG_CLK_CLKDIV2,
> +					    12, 4);
> +	hws[UART7_GATE] = ma35d1_clk_gate("uart7_gate", "uart7_div",
> +					  clk_base + REG_CLK_APBCLK0, 19);
> +	hws[UART8_MUX] = ma35d1_clk_mux("uart8_mux",
> +					clk_base + REG_CLK_CLKSEL3,
> +					0, 2, uart_sel_clks,
> +					ARRAY_SIZE(uart_sel_clks));
> +	hws[UART8_DIV] = ma35d1_clk_divider("uart8_div", "uart8_mux",
> +					    clk_base + REG_CLK_CLKDIV2,
> +					    16, 4);
> +	hws[UART8_GATE] = ma35d1_clk_gate("uart8_gate", "uart8_div",
> +					  clk_base + REG_CLK_APBCLK0, 20);
> +	hws[UART9_MUX] = ma35d1_clk_mux("uart9_mux",
> +					clk_base + REG_CLK_CLKSEL3,
> +					2, 2, uart_sel_clks,
> +					ARRAY_SIZE(uart_sel_clks));
> +	hws[UART9_DIV] = ma35d1_clk_divider("uart9_div", "uart9_mux",
> +					    clk_base + REG_CLK_CLKDIV2,
> +					    20, 4);
> +	hws[UART9_GATE] = ma35d1_clk_gate("uart9_gate", "uart9_div",
> +					  clk_base + REG_CLK_APBCLK0, 21);
> +	hws[UART10_MUX] = ma35d1_clk_mux("uart10_mux",
> +					 clk_base + REG_CLK_CLKSEL3,
> +					 4, 2, uart_sel_clks,
> +					 ARRAY_SIZE(uart_sel_clks));
> +	hws[UART10_DIV] = ma35d1_clk_divider("uart10_div", "uart10_mux",
> +					     clk_base + REG_CLK_CLKDIV2,
> +					     24, 4);
> +	hws[UART10_GATE] = ma35d1_clk_gate("uart10_gate", "uart10_div",
> +					   clk_base + REG_CLK_APBCLK0, 22);
> +	hws[UART11_MUX] = ma35d1_clk_mux("uart11_mux",
> +					 clk_base + REG_CLK_CLKSEL3,
> +					 6, 2, uart_sel_clks,
> +					 ARRAY_SIZE(uart_sel_clks));
> +	hws[UART11_DIV] = ma35d1_clk_divider("uart11_div", "uart11_mux",
> +					     clk_base + REG_CLK_CLKDIV2,
> +					     28, 4);
> +	hws[UART11_GATE] = ma35d1_clk_gate("uart11_gate", "uart11_div",
> +					   clk_base + REG_CLK_APBCLK0, 23);
> +	hws[UART12_MUX] = ma35d1_clk_mux("uart12_mux",
> +					 clk_base + REG_CLK_CLKSEL3,
> +					 8, 2, uart_sel_clks,
> +					 ARRAY_SIZE(uart_sel_clks));
> +	hws[UART12_DIV] = ma35d1_clk_divider("uart12_div", "uart12_mux",
> +					     clk_base + REG_CLK_CLKDIV3,
> +					     0, 4);
> +	hws[UART12_GATE] = ma35d1_clk_gate("uart12_gate", "uart12_div",
> +					   clk_base + REG_CLK_APBCLK0, 24);
> +	hws[UART13_MUX] = ma35d1_clk_mux("uart13_mux",
> +					 clk_base + REG_CLK_CLKSEL3,
> +					 10, 2, uart_sel_clks,
> +					 ARRAY_SIZE(uart_sel_clks));
> +	hws[UART13_DIV] = ma35d1_clk_divider("uart13_div", "uart13_mux",
> +					     clk_base + REG_CLK_CLKDIV3,
> +					     4, 4);
> +	hws[UART13_GATE] = ma35d1_clk_gate("uart13_gate", "uart13_div",
> +					   clk_base + REG_CLK_APBCLK0, 25);
> +	hws[UART14_MUX] = ma35d1_clk_mux("uart14_mux",
> +					 clk_base + REG_CLK_CLKSEL3,
> +					 12, 2, uart_sel_clks,
> +					 ARRAY_SIZE(uart_sel_clks));
> +	hws[UART14_DIV] = ma35d1_clk_divider("uart14_div", "uart14_mux",
> +					     clk_base + REG_CLK_CLKDIV3,
> +					     8, 4);
> +	hws[UART14_GATE] = ma35d1_clk_gate("uart14_gate", "uart14_div",
> +					   clk_base + REG_CLK_APBCLK0, 26);
> +	hws[UART15_MUX] = ma35d1_clk_mux("uart15_mux",
> +					 clk_base + REG_CLK_CLKSEL3,
> +					 14, 2, uart_sel_clks,
> +					 ARRAY_SIZE(uart_sel_clks));
> +	hws[UART15_DIV] = ma35d1_clk_divider("uart15_div", "uart15_mux",
> +					     clk_base + REG_CLK_CLKDIV3,
> +					     12, 4);
> +	hws[UART15_GATE] = ma35d1_clk_gate("uart15_gate", "uart15_div",
> +					   clk_base + REG_CLK_APBCLK0, 27);
> +	hws[UART16_MUX] = ma35d1_clk_mux("uart16_mux",
> +					 clk_base + REG_CLK_CLKSEL3,
> +					 16, 2, uart_sel_clks,
> +					 ARRAY_SIZE(uart_sel_clks));
> +	hws[UART16_DIV] = ma35d1_clk_divider("uart16_div", "uart16_mux",
> +					     clk_base + REG_CLK_CLKDIV3,
> +					     16, 4);
> +	hws[UART16_GATE] = ma35d1_clk_gate("uart16_gate", "uart16_div",
> +					   clk_base + REG_CLK_APBCLK0, 28);
> +
> +	/* RTC */
> +	hws[RTC_GATE] = ma35d1_clk_gate("rtc_gate", "lxt",
> +					clk_base + REG_CLK_APBCLK0, 29);
> +
> +	/* DDRP */
> +	hws[DDR_GATE] = ma35d1_clk_gate("ddr_gate", "ddrpll",
> +					clk_base + REG_CLK_APBCLK0, 30);
> +
> +	/* KPI */
> +	hws[KPI_MUX] = ma35d1_clk_mux("kpi_mux", clk_base + REG_CLK_CLKSEL4,
> +				      30, 1, kpi_sel_clks,
> +				      ARRAY_SIZE(kpi_sel_clks));
> +	hws[KPI_DIV] = ma35d1_clk_divider("kpi_div", "kpi_mux",
> +					  clk_base + REG_CLK_CLKDIV4,
> +					  24, 8);
> +	hws[KPI_GATE] = ma35d1_clk_gate("kpi_gate", "kpi_div",
> +					clk_base + REG_CLK_APBCLK0, 31);
> +
> +	/* I2C0~5 */
> +	hws[I2C0_GATE] = ma35d1_clk_gate("i2c0_gate", "pclk0",
> +					 clk_base + REG_CLK_APBCLK1, 0);
> +	hws[I2C1_GATE] = ma35d1_clk_gate("i2c1_gate", "pclk1",
> +					 clk_base + REG_CLK_APBCLK1, 1);
> +	hws[I2C2_GATE] = ma35d1_clk_gate("i2c2_gate", "pclk2",
> +					 clk_base + REG_CLK_APBCLK1, 2);
> +	hws[I2C3_GATE] = ma35d1_clk_gate("i2c3_gate", "pclk0",
> +					 clk_base + REG_CLK_APBCLK1, 3);
> +	hws[I2C4_GATE] = ma35d1_clk_gate("i2c4_gate", "pclk1",
> +					 clk_base + REG_CLK_APBCLK1, 4);
> +	hws[I2C5_GATE] = ma35d1_clk_gate("i2c5_gate", "pclk2",
> +					 clk_base + REG_CLK_APBCLK1, 5);
> +
> +	/* QSPI0~1 */
> +	hws[QSPI0_MUX] = ma35d1_clk_mux("qspi0_mux",
> +					clk_base + REG_CLK_CLKSEL4,
> +					8, 2, qspi0_sel_clks,
> +					ARRAY_SIZE(qspi0_sel_clks));
> +	hws[QSPI0_GATE] = ma35d1_clk_gate("qspi0_gate", "qspi0_mux",
> +					  clk_base + REG_CLK_APBCLK1, 6);
> +	hws[QSPI1_MUX] = ma35d1_clk_mux("qspi1_mux",
> +					clk_base + REG_CLK_CLKSEL4,
> +					10, 2, qspi1_sel_clks,
> +					ARRAY_SIZE(qspi1_sel_clks));
> +	hws[QSPI1_GATE] = ma35d1_clk_gate("qspi1_gate", "qspi1_mux",
> +					  clk_base + REG_CLK_APBCLK1, 7);
> +
> +	/* SMC0~1 */
> +	hws[SMC0_MUX] = ma35d1_clk_mux("smc0_mux",
> +					clk_base + REG_CLK_CLKSEL4,
> +					28, 1, smc_sel_clks,
> +					ARRAY_SIZE(smc_sel_clks));
> +	hws[SMC0_DIV] = ma35d1_clk_divider("smc0_div", "smc0_mux",
> +					   clk_base + REG_CLK_CLKDIV1,
> +					   0, 4);
> +	hws[SMC0_GATE] = ma35d1_clk_gate("smc0_gate", "smc0_div",
> +					 clk_base + REG_CLK_APBCLK1, 12);
> +
> +	hws[SMC1_MUX] = ma35d1_clk_mux("smc1_mux",
> +					 clk_base + REG_CLK_CLKSEL4,
> +					 29, 1, smc_sel_clks,
> +					 ARRAY_SIZE(smc_sel_clks));
> +	hws[SMC1_DIV] = ma35d1_clk_divider("smc1_div", "smc1_mux",
> +					   clk_base + REG_CLK_CLKDIV1,
> +					   4, 4);
> +	hws[SMC1_GATE] = ma35d1_clk_gate("smc1_gate", "smc1_div",
> +					 clk_base + REG_CLK_APBCLK1, 13);
> +
> +	/* WDT0~2 */
> +	hws[WDT0_MUX] = ma35d1_clk_mux("wdt0_mux",
> +				       clk_base + REG_CLK_CLKSEL3,
> +				       20, 2, wdt0_sel_clks,
> +				       ARRAY_SIZE(wdt0_sel_clks));
> +	hws[WDT0_GATE] = ma35d1_clk_gate("wdt0_gate", "wdt0_mux",
> +					 clk_base + REG_CLK_APBCLK1, 16);
> +	hws[WDT1_MUX] = ma35d1_clk_mux("wdt1_mux",
> +				       clk_base + REG_CLK_CLKSEL3,
> +				       24, 2, wdt1_sel_clks,
> +				       ARRAY_SIZE(wdt1_sel_clks));
> +	hws[WDT1_GATE] = ma35d1_clk_gate("wdt1_gate", "wdt1_mux",
> +					 clk_base + REG_CLK_APBCLK1, 17);
> +	hws[WDT2_MUX] = ma35d1_clk_mux("wdt2_mux",
> +				       clk_base + REG_CLK_CLKSEL3,
> +				       28, 2, wdt2_sel_clks,
> +				       ARRAY_SIZE(wdt2_sel_clks));
> +	hws[WDT2_GATE] = ma35d1_clk_gate("wdt2_gate", "wdt2_mux",
> +				       clk_base + REG_CLK_APBCLK1, 18);
> +
> +	/* WWDT0~2 */
> +	hws[WWDT0_MUX] = ma35d1_clk_mux("wwdt0_mux",
> +					clk_base + REG_CLK_CLKSEL3,
> +					22, 2, wwdt0_sel_clks,
> +					ARRAY_SIZE(wwdt0_sel_clks));
> +	hws[WWDT1_MUX] = ma35d1_clk_mux("wwdt1_mux",
> +					clk_base + REG_CLK_CLKSEL3,
> +					26, 2, wwdt1_sel_clks,
> +					ARRAY_SIZE(wwdt1_sel_clks));
> +	hws[WWDT2_MUX] = ma35d1_clk_mux("wwdt2_mux",
> +					clk_base + REG_CLK_CLKSEL3,
> +					30, 2, wwdt2_sel_clks,
> +					ARRAY_SIZE(wwdt2_sel_clks));
> +
> +	/* EPWM0~2 */
> +	hws[EPWM0_GATE] = ma35d1_clk_gate("epwm0_gate", "pclk1",
> +					  clk_base + REG_CLK_APBCLK1, 24);
> +	hws[EPWM1_GATE] = ma35d1_clk_gate("epwm1_gate", "pclk2",
> +					  clk_base + REG_CLK_APBCLK1, 25);
> +	hws[EPWM2_GATE] = ma35d1_clk_gate("epwm2_gate", "pclk1",
> +					  clk_base + REG_CLK_APBCLK1, 26);
> +
> +	/* I2S0~1 */
> +	hws[I2S0_MUX] = ma35d1_clk_mux("i2s0_mux",
> +				       clk_base + REG_CLK_CLKSEL4,
> +				       12, 2, i2s0_sel_clks,
> +				       ARRAY_SIZE(i2s0_sel_clks));
> +	hws[I2S0_GATE] = ma35d1_clk_gate("i2s0_gate", "i2s0_mux",
> +					 clk_base + REG_CLK_APBCLK2, 0);
> +	hws[I2S1_MUX] = ma35d1_clk_mux("i2s1_mux",
> +				       clk_base + REG_CLK_CLKSEL4,
> +				       14, 2, i2s1_sel_clks,
> +				       ARRAY_SIZE(i2s1_sel_clks));
> +	hws[I2S1_GATE] = ma35d1_clk_gate("i2s1_gate", "i2s1_mux",
> +					 clk_base + REG_CLK_APBCLK2, 1);
> +
> +	/* SSMCC */
> +	hws[SSMCC_GATE] = ma35d1_clk_gate("ssmcc_gate", "pclk3",
> +					  clk_base + REG_CLK_APBCLK2, 2);
> +
> +	/* SSPCC */
> +	hws[SSPCC_GATE] = ma35d1_clk_gate("sspcc_gate", "pclk3",
> +					  clk_base + REG_CLK_APBCLK2, 3);
> +
> +	/* SPI0~3 */
> +	hws[SPI0_MUX] = ma35d1_clk_mux("spi0_mux",
> +				       clk_base + REG_CLK_CLKSEL4,
> +				       0, 2, spi0_sel_clks,
> +				       ARRAY_SIZE(spi0_sel_clks));
> +	hws[SPI0_GATE] = ma35d1_clk_gate("spi0_gate", "spi0_mux",
> +					 clk_base + REG_CLK_APBCLK2, 4);
> +	hws[SPI1_MUX] = ma35d1_clk_mux("spi1_mux",
> +				       clk_base + REG_CLK_CLKSEL4,
> +				       2, 2, spi1_sel_clks,
> +				       ARRAY_SIZE(spi1_sel_clks));
> +	hws[SPI1_GATE] = ma35d1_clk_gate("spi1_gate", "spi1_mux",
> +					 clk_base + REG_CLK_APBCLK2, 5);
> +	hws[SPI2_MUX] = ma35d1_clk_mux("spi2_mux",
> +				       clk_base + REG_CLK_CLKSEL4,
> +				       4, 2, spi2_sel_clks,
> +				       ARRAY_SIZE(spi2_sel_clks));
> +	hws[SPI2_GATE] = ma35d1_clk_gate("spi2_gate", "spi2_mux",
> +					 clk_base + REG_CLK_APBCLK2, 6);
> +	hws[SPI3_MUX] = ma35d1_clk_mux("spi3_mux",
> +				       clk_base + REG_CLK_CLKSEL4,
> +				       6, 2, spi3_sel_clks,
> +				       ARRAY_SIZE(spi3_sel_clks));
> +	hws[SPI3_GATE] = ma35d1_clk_gate("spi3_gate", "spi3_mux",
> +					 clk_base + REG_CLK_APBCLK2, 7);
> +
> +	/* ECAP0~2 */
> +	hws[ECAP0_GATE] = ma35d1_clk_gate("ecap0_gate", "pclk1",
> +					  clk_base + REG_CLK_APBCLK2, 8);
> +	hws[ECAP1_GATE] = ma35d1_clk_gate("ecap1_gate", "pclk2",
> +					  clk_base + REG_CLK_APBCLK2, 9);
> +	hws[ECAP2_GATE] = ma35d1_clk_gate("ecap2_gate", "pclk1",
> +					  clk_base + REG_CLK_APBCLK2, 10);
> +
> +	/* QEI0~2 */
> +	hws[QEI0_GATE] = ma35d1_clk_gate("qei0_gate", "pclk1",
> +					 clk_base + REG_CLK_APBCLK2, 12);
> +	hws[QEI1_GATE] = ma35d1_clk_gate("qei1_gate", "pclk2",
> +					 clk_base + REG_CLK_APBCLK2, 13);
> +	hws[QEI2_GATE] = ma35d1_clk_gate("qei2_gate", "pclk1",
> +					 clk_base + REG_CLK_APBCLK2, 14);
> +
> +	/* ADC */
> +	hws[ADC_DIV] = ma35d1_reg_adc_clkdiv(dev, "adc_div", "pclk0", 0,
> +					     clk_base + REG_CLK_CLKDIV4,
> +					     4, 17, 0x1ffff);
> +	hws[ADC_GATE] = ma35d1_clk_gate("adc_gate", "adc_div",
> +					clk_base + REG_CLK_APBCLK2, 24);
> +
> +	/* EADC */
> +	hws[EADC_DIV] = ma35d1_clk_divider_table("eadc_div", "pclk2",
> +						 clk_base + REG_CLK_CLKDIV4,
> +						 0, 4, eadc_div_table);
> +	hws[EADC_GATE] = ma35d1_clk_gate("eadc_gate", "eadc_div",
> +					 clk_base + REG_CLK_APBCLK2, 25);
> +
> +	ret = of_clk_add_hw_provider(clk_node, of_clk_hw_onecell_get,
> +				     ma35d1_hw_data);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register hws for MA35D1\n");
> +		iounmap(clk_base);
> +	}
> +	return ret;
> +}
> +
> +static const struct of_device_id ma35d1_clk_of_match[] = {
> +	{ .compatible = "nuvoton,ma35d1-clk" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ma35d1_clk_of_match);
> +
> +static struct platform_driver ma35d1_clk_driver = {
> +	.probe = ma35d1_clocks_probe,
> +	.driver = {
> +		.name = "ma35d1-clk",
> +		.of_match_table = ma35d1_clk_of_match,
> +	},
> +};
> +
> +static int __init ma35d1_clocks_init(void)
> +{
> +	return platform_driver_register(&ma35d1_clk_driver);
> +}
> +
> +postcore_initcall(ma35d1_clocks_init);
> +
> +MODULE_AUTHOR("Chi-Fang Li<cfli0@nuvoton.com>");

Space missing.

> +MODULE_DESCRIPTION("NUVOTON MA35D1 Clock Driver");
> +MODULE_LICENSE("GPL v2");

"GPL" is enough.

> diff --git a/drivers/clk/nuvoton/clk-ma35d1.h b/drivers/clk/nuvoton/clk-ma35d1.h
> new file mode 100644
> index 000000000000..faae5a17e425
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1.h
> @@ -0,0 +1,198 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#ifndef __DRV_CLK_NUVOTON_MA35D1_H
> +#define __DRV_CLK_NUVOTON_MA35D1_H
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/spinlock.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/ma35d1-sys.h>
> +
> +enum ma35d1_pll_type {
> +	MA35D1_CAPLL,
> +	MA35D1_DDRPLL,
> +	MA35D1_APLL,
> +	MA35D1_EPLL,
> +	MA35D1_VPLL,
> +};
> +
> +enum ma35d1_pll_mode {
> +	VSIPLL_INTEGER_MODE,
> +	VSIPLL_FRACTIONAL_MODE,
> +	VSIPLL_SS_MODE,
> +};
> +
> +/* VSI-PLL CTL0~2 */
> +#define VSIPLL_CTL0			0x0
> +#define VSIPLL_CTL1			0x4
> +#define VSIPLL_CTL2			0x8
> +
> +/* VSI-PLL Specification limits */
> +#define VSIPLL_FREF_MAX_FREQ		200000000UL
> +#define VSIPLL_FREF_MIN_FREQ		1000000UL
> +#define VSIPLL_FREFDIVM_MAX_FREQ	40000000UL
> +#define VSIPLL_FREFDIVM_MIN_FREQ0	1000000UL
> +#define VSIPLL_FREFDIVM_MIN_FREQ1	10000000UL
> +#define VSIPLL_FCLK_MAX_FREQ		2400000000UL
> +#define VSIPLL_FCLK_MIN_FREQ		600000000UL
> +#define VSIPLL_FCLKO_MAX_FREQ		2400000000UL
> +#define VSIPLL_FCLKO_MIN_FREQ		85700000UL
> +#define VSIPLL_SPREAD_RANGE		194
> +#define VSIPLL_MODULATION_FREQ		50000
> +
> +/* Clock Control Registers Offset */
> +#define REG_CLK_PWRCTL			(0x00)

Unnecessary parenthesis.

> +#define REG_CLK_SYSCLK0			(0x04)
> +#define REG_CLK_SYSCLK1			(0x08)
> +#define REG_CLK_APBCLK0			(0x0C)
> +#define REG_CLK_APBCLK1			(0x10)
> +#define REG_CLK_APBCLK2			(0x14)
> +#define REG_CLK_CLKSEL0			(0x18)
> +#define REG_CLK_CLKSEL1			(0x1C)
> +#define REG_CLK_CLKSEL2			(0x20)
> +#define REG_CLK_CLKSEL3			(0x24)
> +#define REG_CLK_CLKSEL4			(0x28)
> +#define REG_CLK_CLKDIV0			(0x2C)
> +#define REG_CLK_CLKDIV1			(0x30)
> +#define REG_CLK_CLKDIV2			(0x34)
> +#define REG_CLK_CLKDIV3			(0x38)
> +#define REG_CLK_CLKDIV4			(0x3C)
> +#define REG_CLK_CLKOCTL			(0x40)
> +#define REG_CLK_STATUS			(0x50)
> +#define REG_CLK_PLL0CTL0		(0x60)
> +#define REG_CLK_PLL2CTL0		(0x80)
> +#define REG_CLK_PLL2CTL1		(0x84)
> +#define REG_CLK_PLL2CTL2		(0x88)
> +#define REG_CLK_PLL3CTL0		(0x90)
> +#define REG_CLK_PLL3CTL1		(0x94)
> +#define REG_CLK_PLL3CTL2		(0x98)
> +#define REG_CLK_PLL4CTL0		(0xA0)
> +#define REG_CLK_PLL4CTL1		(0xA4)
> +#define REG_CLK_PLL4CTL2		(0xA8)
> +#define REG_CLK_PLL5CTL0		(0xB0)
> +#define REG_CLK_PLL5CTL1		(0xB4)
> +#define REG_CLK_PLL5CTL2		(0xB8)
> +#define REG_CLK_CLKDCTL			(0xC0)
> +#define REG_CLK_CLKDSTS			(0xC4)
> +#define REG_CLK_CDUPB			(0xC8)
> +#define REG_CLK_CDLOWB			(0xCC)
> +#define REG_CLK_CKFLTRCTL		(0xD0)
> +#define REG_CLK_TESTCLK			(0xF0)
> +#define REG_CLK_PLLCTL			(0x40)
> +
> +/* Constant Definitions for Clock Controller */
> +#define SMICPLLCTL0_FBDIV_POS		(0)
> +#define SMICPLLCTL0_FBDIV_MSK		(0xfful << SMICPLLCTL0_FBDIV_POS)
> +#define SMICPLLCTL0_INDIV_POS		(8)
> +#define SMICPLLCTL0_INDIV_MSK		(0xful << SMICPLLCTL0_INDIV_POS)
> +#define SMICPLLCTL0_OUTDIV_POS		(12)
> +#define SMICPLLCTL0_OUTDIV_MSK		(0x3ul << SMICPLLCTL0_OUTDIV_POS)

GENMASK() + remove _POS define completely.

> +#define SMICPLLCTL0_PD_POS		(16)
> +#define SMICPLLCTL0_PD_MSK		(0x1ul << SMICPLLCTL0_PD_POS)

BIT() + remove _POS.

Is this really a mask or a bit? I'd remove _MSK from the name (which is 
usually not that useful anyway even if it would be a multiple bit mask 
for real).

> +#define SMICPLLCTL0_BP_POS		(17)
> +#define SMICPLLCTL0_BP_MSK		(0x1ul << SMICPLLCTL0_BP_POS)

BIT()?

> +#define VSIPLLCTL0_FBDIV_POS		(0)
> +#define VSIPLLCTL0_FBDIV_MSK		(0x7fful << VSIPLLCTL0_FBDIV_POS)
> +#define VSIPLLCTL0_INDIV_POS		(12)
> +#define VSIPLLCTL0_INDIV_MSK		(0x3ful << VSIPLLCTL0_INDIV_POS)
> +#define VSIPLLCTL0_MODE_POS		(18)
> +#define VSIPLLCTL0_MODE_MSK		(0x3ul << VSIPLLCTL0_MODE_POS)
> +#define VSIPLLCTL0_SSRATE_POS		(20)
> +#define VSIPLLCTL0_SSRATE_MSK		(0x7fful << VSIPLLCTL0_SSRATE_POS)
> +#define VSIPLLCTL1_PD_POS		(0)
> +#define VSIPLLCTL1_PD_MSK		(0x1ul << VSIPLLCTL1_PD_POS)
> +#define VSIPLLCTL1_BP_POS		(1)
> +#define VSIPLLCTL1_BP_MSK		(0x1ul << VSIPLLCTL1_BP_POS)
> +#define VSIPLLCTL1_OUTDIV_POS		(4)
> +#define VSIPLLCTL1_OUTDIV_MSK		(0x7ul << VSIPLLCTL1_OUTDIV_POS)
> +#define VSIPLLCTL1_FRAC_POS		(8)
> +#define VSIPLLCTL1_FRAC_MSK		(0xfffffful << VSIPLLCTL1_FRAC_POS)
> +#define VSIPLLCTL2_SLOPE_POS		(0)
> +#define VSIPLLCTL2_SLOPE_MSK		(0xfffffful << VSIPLLCTL2_SLOPE_POS)

...and more of them.



-- 
 i.

