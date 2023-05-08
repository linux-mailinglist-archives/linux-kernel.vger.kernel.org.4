Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFDB6FA9A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjEHKyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjEHKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:53:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D72B42A;
        Mon,  8 May 2023 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683543175; x=1715079175;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e53Vfgrq0O3oiCNIBxCYeSPht884wxjJXLz+OxJpKJ8=;
  b=Ff6fdxQtJ4UOKdW7+zslJsT5GKcOa5FAooWpQ5Jh85zb4eas3Vkh4iKl
   RfENvvzliS5JMUuJE8T3a2Z+diiKfo4LQhD6y+6lb0qADKp+FXFodVfxL
   GfGX6V3xxDhbW/bDZAzDkvqOr1fMTiARGQAvCTW9PVUCdN675jsIerzPT
   lLTPTK29jPO4yihkaY6rs8lyeSts9j0tY0Fy8pzY1WWeAxPRh66gAkG0h
   a72xFhIzX9eOp8o7c98MrcW3IbVE6MdXaCCFgDEGdz79I/DZHHbOVb1s7
   B61mmdz13gDWjo9zEbacTHDKfH5SZgbOYBhitnSC/iZxEaP7wdQZXMxlX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="349644377"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="349644377"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 03:52:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="842653784"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="842653784"
Received: from cciobanu-mobl1.ger.corp.intel.com ([10.249.37.159])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 03:52:48 -0700
Date:   Mon, 8 May 2023 13:52:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, tmaimon77@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>, arnd@arndb.de,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v10 08/10] clk: nuvoton: Add clock driver for ma35d1
 clock controller
In-Reply-To: <20230508025936.36776-9-ychuang570808@gmail.com>
Message-ID: <e417c2ab-f789-40ce-531-d6b9ea9c7e6b@linux.intel.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com> <20230508025936.36776-9-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2023, Jacky Huang wrote:

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
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Hi,

A few small things still below.

> diff --git a/drivers/clk/nuvoton/clk-ma35d1-divider.c b/drivers/clk/nuvoton/clk-ma35d1-divider.c
> new file mode 100644
> index 000000000000..0d4d8186a85c
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1-divider.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>
> +
> +struct ma35d1_adc_clk_div {
> +	struct clk_hw hw;
> +	void __iomem *reg;
> +	u8 shift;
> +	u8 width;
> +	u32 mask;
> +	const struct clk_div_table *table;
> +	/* protects concurrent access to clock divider registers */
> +	spinlock_t *lock;
> +};
> +
> +struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev, const char *name,
> +				     struct clk_hw *parent_hw, spinlock_t *lock,
> +				     unsigned long flags, void __iomem *reg,
> +				     u8 shift, u8 width, u32 mask_bit);
> +
> +static inline struct ma35d1_adc_clk_div *to_ma35d1_adc_clk_div(struct clk_hw *_hw)
> +{
> +	return container_of(_hw, struct ma35d1_adc_clk_div, hw);
> +}
> +
> +static inline unsigned long ma35d1_clkdiv_recalc_rate(struct clk_hw *hw,
> +						      unsigned long parent_rate)
> +{
> +	unsigned int val;
> +	struct ma35d1_adc_clk_div *dclk = to_ma35d1_adc_clk_div(hw);
> +
> +	val = readl_relaxed(dclk->reg) >> dclk->shift;
> +	val &= clk_div_mask(dclk->width);
> +	val += 1;
> +	return divider_recalc_rate(hw, parent_rate, val, dclk->table,
> +				   CLK_DIVIDER_ROUND_CLOSEST, dclk->width);
> +}
> +
> +static inline long ma35d1_clkdiv_round_rate(struct clk_hw *hw,
> +					    unsigned long rate,
> +					    unsigned long *prate)
> +{
> +	struct ma35d1_adc_clk_div *dclk = to_ma35d1_adc_clk_div(hw);
> +
> +	return divider_round_rate(hw, rate, prate, dclk->table,
> +				  dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
> +}
> +
> +static inline int ma35d1_clkdiv_set_rate(struct clk_hw *hw,
> +					 unsigned long rate,
> +					 unsigned long parent_rate)
> +{
> +	int value;
> +	unsigned long flags = 0;
> +	u32 data;
> +	struct ma35d1_adc_clk_div *dclk = to_ma35d1_adc_clk_div(hw);
> +
> +	value = divider_get_val(rate, parent_rate, dclk->table,
> +				dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
> +
> +	spin_lock_irqsave(dclk->lock, flags);
> +
> +	data = readl_relaxed(dclk->reg);
> +	data &= ~(clk_div_mask(dclk->width) << dclk->shift);
> +	data |= (value - 1) << dclk->shift;
> +	data |= dclk->mask;
> +	writel_relaxed(data, dclk->reg);
> +
> +	spin_unlock_irqrestore(dclk->lock, flags);
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
> +				     struct clk_hw *parent_hw, spinlock_t *lock,
> +				     unsigned long flags, void __iomem *reg,
> +				     u8 shift, u8 width, u32 mask_bit)
> +{
> +	struct ma35d1_adc_clk_div *div;
> +	struct clk_init_data init;
> +	struct clk_div_table *table;
> +	struct clk_parent_data pdata = { .index = 0 };
> +	u32 max_div, min_div;
> +	struct clk_hw *hw;
> +	int ret;
> +	int i;
> +
> +	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
> +	if (!div)
> +		return ERR_PTR(-ENOMEM);
> +
> +	max_div = clk_div_mask(width) + 1;
> +	min_div = 1;
> +
> +	table = devm_kcalloc(dev, max_div + 1, sizeof(*table), GFP_KERNEL);
> +	if (!table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < max_div; i++) {
> +		table[i].val = min_div + i;
> +		table[i].div = 2 * table[i].val;
> +	}
> +	table[max_div].val = 0;
> +	table[max_div].div = 0;
> +
> +	memset(&init, 0, sizeof(init));
> +	init.name = name;
> +	init.ops = &ma35d1_adc_clkdiv_ops;
> +	init.flags |= flags;
> +	pdata.hw = parent_hw;
> +	init.parent_data = &pdata;
> +	init.num_parents = 1;
> +
> +	div->reg = reg;
> +	div->shift = shift;
> +	div->width = width;
> +	div->mask = mask_bit ? BIT(mask_bit) : 0;
> +	div->lock = lock;
> +	div->hw.init = &init;
> +	div->table = table;
> +
> +	hw = &div->hw;
> +	ret = devm_clk_hw_register(dev, hw);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	return hw;
> +}
> +EXPORT_SYMBOL_GPL(ma35d1_reg_adc_clkdiv);
> diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c b/drivers/clk/nuvoton/clk-ma35d1-pll.c
> new file mode 100644
> index 000000000000..a9981db0a54a
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1-pll.c
> @@ -0,0 +1,365 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/slab.h>
> +#include <linux/units.h>
> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +
> +/* PLL frequency limits */
> +#define PLL_FREF_MAX_FREQ	(200 * HZ_PER_MHZ)
> +#define PLL_FREF_MIN_FREQ	(1 * HZ_PER_MHZ)
> +#define PLL_FREF_M_MAX_FREQ	(40 * HZ_PER_MHZ)
> +#define PLL_FREF_M_MIN_FREQ	(10 * HZ_PER_MHZ)
> +#define PLL_FCLK_MAX_FREQ	(2400 * HZ_PER_MHZ)
> +#define PLL_FCLK_MIN_FREQ	(600 * HZ_PER_MHZ)
> +#define PLL_FCLKO_MAX_FREQ	(2400 * HZ_PER_MHZ)
> +#define PLL_FCLKO_MIN_FREQ	(85700 * HZ_PER_KHZ)
> +#define PLL_SS_RATE		0x77
> +#define PLL_SLOPE		0x58CFA
> +
> +#define REG_PLL_CTL0_OFFSET	0x0
> +#define REG_PLL_CTL1_OFFSET	0x4
> +#define REG_PLL_CTL2_OFFSET	0x8
> +
> +/* bit fields for REG_CLK_PLL0CTL0, which is SMIC PLL design */
> +#define SPLL0_CTL0_FBDIV	GENMASK(7, 0)
> +#define SPLL0_CTL0_INDIV	GENMASK(11, 8)
> +#define SPLL0_CTL0_OUTDIV	GENMASK(13, 12)
> +#define SPLL0_CTL0_PD		BIT(16)
> +#define SPLL0_CTL0_BP		BIT(17)
> +
> +/* bit fields for REG_CLK_PLLxCTL0 ~ REG_CLK_PLLxCTL2, where x = 2 ~ 5 */
> +#define PLL_CTL0_FBDIV		GENMASK(10, 0)
> +#define PLL_CTL0_INDIV		GENMASK(17, 12)
> +#define PLL_CTL0_MODE		GENMASK(19, 18)
> +#define PLL_CTL0_SSRATE		GENMASK(30, 20)
> +#define PLL_CTL1_PD		BIT(0)
> +#define PLL_CTL1_BP		BIT(1)
> +#define PLL_CTL1_OUTDIV		GENMASK(6, 4)
> +#define PLL_CTL1_FRAC		GENMASK(31, 24)
> +#define PLL_CTL2_SLOPE		GENMASK(23, 0)
> +
> +#define INDIV_MIN		1
> +#define INDIV_MAX		63
> +#define FBDIV_MIN		16
> +#define FBDIV_MAX		2047
> +#define FBDIV_FRAC_MIN		1600
> +#define FBDIV_FRAC_MAX		204700
> +#define OUTDIV_MIN		1
> +#define OUTDIV_MAX		7
> +
> +#define PLL_MODE_INT            0
> +#define PLL_MODE_FRAC           1
> +#define PLL_MODE_SS             2
> +
> +struct ma35d1_clk_pll {
> +	struct clk_hw hw;
> +	u32 id;
> +	u8 mode;
> +	void __iomem *ctl0_base;
> +	void __iomem *ctl1_base;
> +	void __iomem *ctl2_base;
> +};
> +
> +struct clk_hw *ma35d1_reg_clk_pll(struct device *dev, u32 id, u8 u8mode, const char *name,
> +				  struct clk_hw *parent_hw, void __iomem *base);
> +
> +static inline struct ma35d1_clk_pll *to_ma35d1_clk_pll(struct clk_hw *_hw)
> +{
> +	return container_of(_hw, struct ma35d1_clk_pll, hw);
> +}
> +
> +static unsigned long ma35d1_calc_smic_pll_freq(u32 pll0_ctl0,
> +					       unsigned long parent_rate)
> +{
> +	const u32 clk_div_table[] = { 1, 2, 4, 8 };

This is just 1 << n so the table doesn't seem necessary.

> +	u32 m, n, p, outdiv;
> +	u64 pll_freq;
> +
> +	if (pll0_ctl0 & SPLL0_CTL0_BP)
> +		return parent_rate;
> +
> +	n = FIELD_GET(SPLL0_CTL0_FBDIV, pll0_ctl0);
> +	m = FIELD_GET(SPLL0_CTL0_INDIV, pll0_ctl0);
> +	p = FIELD_GET(SPLL0_CTL0_OUTDIV, pll0_ctl0);
> +	outdiv = clk_div_table[p];
> +	pll_freq = (u64)parent_rate * n;
> +	div_u64(pll_freq, m * outdiv);
> +	return pll_freq;
> +}
> +
> +static unsigned long ma35d1_calc_pll_freq(u8 mode, u32 *reg_ctl, unsigned long parent_rate)
> +{
> +	unsigned long pll_freq, x;
> +	u32 m, n, p;
> +
> +	if (reg_ctl[1] & PLL_CTL1_BP)
> +		return parent_rate;
> +
> +	n = FIELD_GET(PLL_CTL0_FBDIV, reg_ctl[0]);
> +	m = FIELD_GET(PLL_CTL0_INDIV, reg_ctl[0]);
> +	p = FIELD_GET(PLL_CTL1_OUTDIV, reg_ctl[1]);
> +
> +	if (mode == PLL_MODE_INT) {
> +		pll_freq = (u64)parent_rate * n;
> +		div_u64(pll_freq, m * p);
> +	} else {
> +		x = FIELD_GET(PLL_CTL1_FRAC, reg_ctl[1]);
> +		/* 2 decimal places floating to integer (ex. 1.23 to 123) */
> +		n = n * 100 + ((x * 100) / FIELD_MAX(PLL_CTL1_FRAC));
> +
> +		/* pll_freq = parent_rate * n / 100 / m / p */

Repeats what the code does, drop.

> +		pll_freq = div_u64(parent_rate * n, 100 * m * p);
> +	}
> +	return pll_freq;
> +}
> +
> +static int ma35d1_pll_find_closest(struct ma35d1_clk_pll *pll, unsigned long rate,
> +				   unsigned long parent_rate, u32 *reg_ctl,
> +				   unsigned long *freq)
> +{
> +	unsigned long min_diff = ULONG_MAX;
> +	int fbdiv_min, fbdiv_max;
> +	int p, m, n;
> +
> +	*freq = 0;
> +	if (rate < PLL_FCLKO_MIN_FREQ || rate > PLL_FCLKO_MAX_FREQ)
> +		return -EINVAL;
> +
> +	if (pll->mode == PLL_MODE_INT) {
> +		fbdiv_min = FBDIV_MIN;
> +		fbdiv_max = FBDIV_MAX;
> +	} else {
> +		fbdiv_min = FBDIV_FRAC_MIN;
> +		fbdiv_max = FBDIV_FRAC_MAX;
> +	}
> +
> +	for (m = INDIV_MIN; m <= INDIV_MAX; m++) {
> +		for (n = fbdiv_min; n <= fbdiv_max; n++) {
> +			for (p = OUTDIV_MIN; p <= OUTDIV_MAX; p++) {
> +				unsigned long tmp, fout, fclk, diff;
> +
> +				tmp = div_u64(parent_rate, m);
> +				if (tmp < PLL_FREF_M_MIN_FREQ ||
> +				    tmp > PLL_FREF_M_MAX_FREQ)
> +					continue; /* constrain */
> +
> +				fclk = div_u64(parent_rate * n, m);
> +				/* for 2 decimal places */
> +				if (pll->mode != PLL_MODE_INT)
> +					fclk = div_u64(fclk, 100);
> +
> +				if (fclk < PLL_FCLK_MIN_FREQ ||
> +				    fclk > PLL_FCLK_MAX_FREQ)
> +					continue; /* constrain */
> +
> +				fout = div_u64(fclk, p);
> +				if (fout < PLL_FCLKO_MIN_FREQ ||
> +				    fout > PLL_FCLKO_MAX_FREQ)
> +					continue; /* constrain */
> +
> +				diff = abs(rate - fout);
> +				if (diff < min_diff) {
> +					reg_ctl[0] = FIELD_PREP(PLL_CTL0_INDIV, m) |
> +						     FIELD_PREP(PLL_CTL0_FBDIV, n);
> +					reg_ctl[1] = FIELD_PREP(PLL_CTL1_OUTDIV, p);
> +					*freq = fout;
> +					min_diff = diff;
> +					if (min_diff == 0)
> +						break;
> +				}
> +			}
> +		}
> +	}
> +	if (*freq == 0)
> +		return -EINVAL; /* cannot find even one valid setting */
> +	return 0;
> +}
> +
> +static int ma35d1_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +				   unsigned long parent_rate)
> +{
> +	struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
> +	u32 reg_ctl[3] = { 0 };
> +	unsigned long pll_freq;
> +	int ret;
> +
> +	if (parent_rate < PLL_FREF_MIN_FREQ ||
> +	    parent_rate > PLL_FREF_MAX_FREQ)

One line.

> +		return -EINVAL;
> +
> +	ret = ma35d1_pll_find_closest(pll, rate, parent_rate, reg_ctl, &pll_freq);
> +	if (ret != 0)
> +		return ret;
> +
> +	switch (pll->mode) {
> +	case PLL_MODE_INT:
> +		reg_ctl[0] |= FIELD_PREP(PLL_CTL0_MODE, PLL_MODE_INT);
> +		break;
> +	case PLL_MODE_FRAC:
> +		reg_ctl[0] |= FIELD_PREP(PLL_CTL0_MODE, PLL_MODE_FRAC);
> +		break;
> +	case PLL_MODE_SS:
> +		reg_ctl[0] |= FIELD_PREP(PLL_CTL0_MODE, PLL_MODE_SS) |
> +			      FIELD_PREP(PLL_CTL0_SSRATE, PLL_SS_RATE);
> +		reg_ctl[2] = FIELD_PREP(PLL_CTL2_SLOPE, PLL_SLOPE);
> +		break;
> +	}
> +	reg_ctl[1] |= PLL_CTL1_PD;
> +
> +	writel_relaxed(reg_ctl[0], pll->ctl0_base);
> +	writel_relaxed(reg_ctl[1], pll->ctl1_base);
> +	writel_relaxed(reg_ctl[2], pll->ctl2_base);
> +	return 0;
> +}
> +
> +static unsigned long ma35d1_clk_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
> +	u32 reg_ctl[3];
> +	unsigned long pll_freq;
> +
> +	if (parent_rate < PLL_FREF_MIN_FREQ || parent_rate > PLL_FREF_MAX_FREQ)
> +		return 0;
> +
> +	switch (pll->id) {
> +	case CAPLL:
> +		reg_ctl[0] = readl_relaxed(pll->ctl0_base);
> +		pll_freq = ma35d1_calc_smic_pll_freq(reg_ctl[0], parent_rate);
> +		return pll_freq;
> +	case DDRPLL:
> +	case APLL:
> +	case EPLL:
> +	case VPLL:
> +		reg_ctl[0] = readl_relaxed(pll->ctl0_base);
> +		reg_ctl[1] = readl_relaxed(pll->ctl1_base);
> +		pll_freq = ma35d1_calc_pll_freq(pll->mode, reg_ctl, parent_rate);
> +		return pll_freq;
> +	}
> +	return 0;
> +}
> +
> +static long ma35d1_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				      unsigned long *parent_rate)
> +{
> +	struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
> +	u32 reg_ctl[3] = { 0 };
> +	unsigned long pll_freq;
> +	long ret;
> +
> +	if (*parent_rate < PLL_FREF_MIN_FREQ || *parent_rate > PLL_FREF_MAX_FREQ)
> +		return -EINVAL;
> +
> +	ret = ma35d1_pll_find_closest(pll, rate, *parent_rate, reg_ctl, &pll_freq);
> +	if (ret != 0)

< 0

> +		return ret;
> +
> +	switch (pll->id) {
> +	case CAPLL:
> +		reg_ctl[0] = readl_relaxed(pll->ctl0_base);
> +		pll_freq = ma35d1_calc_smic_pll_freq(reg_ctl[0], *parent_rate);
> +		return pll_freq;
> +	case DDRPLL:
> +	case APLL:
> +	case EPLL:
> +	case VPLL:
> +		reg_ctl[0] = readl_relaxed(pll->ctl0_base);
> +		reg_ctl[1] = readl_relaxed(pll->ctl1_base);
> +		pll_freq = ma35d1_calc_pll_freq(pll->mode, reg_ctl, *parent_rate);
> +		return pll_freq;
> +	}
> +	return 0;
> +}
> +
> +static int ma35d1_clk_pll_is_prepared(struct clk_hw *hw)
> +{
> +	struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
> +	u32 val = readl_relaxed(pll->ctl1_base);
> +
> +	return !(val & PLL_CTL1_PD);
> +}
> +
> +static int ma35d1_clk_pll_prepare(struct clk_hw *hw)
> +{
> +	struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
> +	u32 val;
> +
> +	val = readl_relaxed(pll->ctl1_base);
> +	val &= ~PLL_CTL1_PD;
> +	writel_relaxed(val, pll->ctl1_base);
> +	return 0;
> +}
> +
> +static void ma35d1_clk_pll_unprepare(struct clk_hw *hw)
> +{
> +	struct ma35d1_clk_pll *pll = to_ma35d1_clk_pll(hw);
> +	u32 val;
> +
> +	val = readl_relaxed(pll->ctl1_base);
> +	val |= PLL_CTL1_PD;
> +	writel_relaxed(val, pll->ctl1_base);
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
> +static const struct clk_ops ma35d1_clk_fixed_pll_ops = {
> +	.recalc_rate = ma35d1_clk_pll_recalc_rate,
> +	.round_rate = ma35d1_clk_pll_round_rate,
> +};
> +
> +struct clk_hw *ma35d1_reg_clk_pll(struct device *dev, u32 id, u8 u8mode, const char *name,
> +				  struct clk_hw *parent_hw, void __iomem *base)
> +{
> +	struct clk_parent_data pdata = { .index = 0 };
> +	struct clk_init_data init = {};
> +	struct ma35d1_clk_pll *pll;
> +	struct clk_hw *hw;
> +	int ret;
> +
> +	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pll->id = id;
> +	pll->mode = u8mode;
> +	pll->ctl0_base = base + REG_PLL_CTL0_OFFSET;
> +	pll->ctl1_base = base + REG_PLL_CTL1_OFFSET;
> +	pll->ctl2_base = base + REG_PLL_CTL2_OFFSET;
> +
> +	init.name = name;
> +	init.flags = 0;
> +	pdata.hw = parent_hw;
> +	init.parent_data = &pdata;
> +	init.num_parents = 1;
> +
> +	if (id == CAPLL || id == DDRPLL)
> +		init.ops = &ma35d1_clk_fixed_pll_ops;
> +	else
> +		init.ops = &ma35d1_clk_pll_ops;
> +
> +	pll->hw.init = &init;
> +	hw = &pll->hw;
> +
> +	ret = devm_clk_hw_register(dev, hw);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	return hw;
> +}
> +EXPORT_SYMBOL_GPL(ma35d1_reg_clk_pll);

> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
> new file mode 100644
> index 000000000000..68fbaf2f4945
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
> @@ -0,0 +1,948 @@

> +static inline struct clk_hw *ma35d1_clk_fixed(const char *name, int rate)
> +{
> +	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_mux_parent(struct device *dev,
> +						   const char *name,
> +						   void __iomem *reg,
> +						   u8 shift, u8 width,
> +						   const struct clk_parent_data *pdata,
> +						   int num_pdata)
> +{
> +	return clk_hw_register_mux_parent_data(dev, name, pdata, num_pdata,
> +					       CLK_SET_RATE_NO_REPARENT, reg, shift,
> +					       width, 0, &ma35d1_lock);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_mux(struct device *dev,
> +					    const char *name,
> +					    void __iomem *reg,
> +					    u8 shift, u8 width,
> +					    const char *const *parents,
> +					    int num_parents)
> +{
> +	return devm_clk_hw_register_mux(dev, name, parents, num_parents,
> +					CLK_SET_RATE_NO_REPARENT, reg, shift,
> +					width, 0, &ma35d1_lock);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_divider(struct device *dev,
> +						const char *name,
> +						const char *parent,
> +						void __iomem *reg, u8 shift,
> +						u8 width)
> +{
> +	return devm_clk_hw_register_divider(dev, name, parent, CLK_SET_RATE_PARENT,
> +					    reg, shift, width, 0, &ma35d1_lock);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_divider_pow2(struct device *dev,
> +						     const char *name,
> +						     const char *parent,
> +						     void __iomem *reg,
> +						     u8 shift, u8 width)
> +{
> +	return devm_clk_hw_register_divider(dev, name, parent,
> +					    CLK_DIVIDER_POWER_OF_TWO, reg, shift,
> +					    width, 0, &ma35d1_lock);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_divider_table(struct device *dev,
> +						      const char *name,
> +						      const char *parent,
> +						      void __iomem *reg,
> +						      u8 shift, u8 width,
> +						      const struct clk_div_table *table)
> +{
> +	return devm_clk_hw_register_divider_table(dev, name, parent, 0,
> +						  reg, shift, width, 0,
> +						  table, &ma35d1_lock);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_fixed_factor(struct device *dev,
> +						     const char *name,
> +						     const char *parent,
> +						     unsigned int mult,
> +						     unsigned int div)
> +{
> +	return devm_clk_hw_register_fixed_factor(dev, name, parent,
> +					    CLK_SET_RATE_PARENT, mult, div);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_gate(struct device *dev,
> +					     const char *name,
> +					     const char *parent,
> +					     void __iomem *reg, u8 shift)
> +{
> +	return devm_clk_hw_register_gate(dev, name, parent, CLK_SET_RATE_PARENT,
> +				    reg, shift, 0, &ma35d1_lock);
> +}

Inline is not something that should be used that much in .c files, just 
leave it up to the compiler to decide whether to inline or not. There were 
some other inlines in the other file I noted later but I didn't mark them 
but please check their inline usage too.

> +static int ma35d1_get_pll_setting(struct device_node *clk_node, u32 *pllmode)
> +{
> +	const char *of_str;
> +	int i;
> +
> +	for (i = 0; i < PLL_MAX_NUM; i++) {
> +		if (of_property_read_string_index(clk_node, "nuvoton,pll-mode", i, &of_str))
> +			return -EINVAL;
> +		if (!strcmp(of_str, "integer"))
> +			pllmode[i] = PLL_MODE_INT;
> +		else if (!strcmp(of_str, "fractional"))
> +			pllmode[i] = PLL_MODE_FRAC;
> +		else if (!strcmp(of_str, "spread-spectrum"))
> +			pllmode[i] = PLL_MODE_SS;
> +		else
> +			return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int ma35d1_clocks_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *clk_node = pdev->dev.of_node;
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	void __iomem *clk_base;
> +	static struct clk_hw **hws;
> +	static struct clk_hw_onecell_data *ma35d1_hw_data;
> +	u32 pllmode[PLL_MAX_NUM];
> +	int ret;
> +
> +	ma35d1_hw_data = devm_kzalloc(dev,
> +				      struct_size(ma35d1_hw_data, hws, CLK_MAX_IDX),
> +				      GFP_KERNEL);
> +	if (WARN_ON(!ma35d1_hw_data))

Alloc error should not be WARN_ON()'ed, it's not a bug. If you want to 
notify about normal (non-programming) errors, use dev_err() instead.

> +		return -ENOMEM;
> +
> +	ma35d1_hw_data->num = CLK_MAX_IDX;
> +	hws = ma35d1_hw_data->hws;
> +
> +	clk_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(clk_base))
> +		return PTR_ERR(clk_base);
> +
> +	ret = ma35d1_get_pll_setting(clk_node, pllmode);
> +	if (ret < 0) {
> +		dev_err(dev, "Invalid PLL setting!\n");
> +		return -EINVAL;
> +	}


-- 
 i.

