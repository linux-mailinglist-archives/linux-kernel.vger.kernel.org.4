Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7596ECBB6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjDXMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjDXMBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:01:12 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFBA188
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:01:08 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id qusTpm7dE4wSaqusTpBxKs; Mon, 24 Apr 2023 14:01:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682337666;
        bh=FmG3SuHZdMzKY8zWgoRB8dYSb+psyjIol5AQGffMCJY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=O8R5EIOYcIyxvvooE51pTrv6hxHhlE9yU5BaguQSSm7AsPyOgn/gaaqtI9o9fJa17
         hFSgBBvR5Gf3EsSxhzpyhXLQL+32ddM5/yHJysXVO2hCM9ai318wuJnLsj1762oGTL
         BOUll+2WdrtQDgz/T65BQ5qP4TH1mZzBdRGrf2wwxxJ+1xAcQtmoNKzhJNDWrT8QVu
         uiyfLqNXTqQ9xV412I8erUVxqsZ3MixXIHXIDYyf2AyIve5HDeuVcsRDNOkHais0GC
         2P8oA9RxvGP2S69Z7lMs1V3tCK5WbUxw6BPnd3O+hbzCHm8fXA6cWHIyM7aA7mQiP+
         Gh7myz1M8v2Cg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Apr 2023 14:01:06 +0200
X-ME-IP: 86.243.2.178
Message-ID: <1623d2ab-91da-c5c8-0263-8decef3281ac@wanadoo.fr>
Date:   Mon, 24 Apr 2023 14:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 12/43] clk: ep93xx: add DT support for Cirrus EP93xx
Content-Language: fr
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-13-nikita.shubin@maquefel.me>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230424123522.18302-13-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/04/2023 à 14:34, Nikita Shubin a écrit :
> This is a rewrite of EP93xx timer driver in
> arch/arm/mach-ep93xx/clock.c trying to do everything
> the device tree way:
> 
> - convert to syscon driver
> - provide clock acces via of
> 
> Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>      rfc->v0
>      Linus Walleij:
>      - renamed all __underscore
>      
>      Alexander Sverdlin:
>      - "Logick" -> "Logic"
>      
>      Changes by Alexander Sverdlin:
>      - remove pr_info
>      - DIV_ROUND_UP_ULL -> DIV_ROUND_CLOSEST
>      - fix zeroing bitfield in ep93xx_div_set_rate
>      - add sanity check for EP93XX_SYSCON_CHIPID_ID
>      - use bit index for DMA clock's
>      - ep93xx_clk_register_gate() takes bit index, not mask
>      - remove redundant define
>      - use DIV_ROUND_CLOSEST() everywhere to achieve frequencies closer to those
>        requested
>      - Add the forgotten configuration from the deleted
>        arch/arm/mach-ep93xx/core.c
> 
>   drivers/clk/Kconfig      |   8 +
>   drivers/clk/Makefile     |   1 +
>   drivers/clk/clk-ep93xx.c | 880 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 889 insertions(+)
>   create mode 100644 drivers/clk/clk-ep93xx.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 1eef05bb1f99..d3ad975b688e 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -436,6 +436,14 @@ config COMMON_CLK_K210
>   	help
>   	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
>   
> +config COMMON_CLK_EP93XX
> +	bool "Clock driver for Cirrus Logic ep93xx SoC"
> +	depends on ARCH_EP93XX || COMPILE_TEST
> +	select MFD_SYSCON
> +	select REGMAP
> +	help
> +	 This driver supports the SoC clocks on the Cirrus Logic ep93xx.
> +
>   source "drivers/clk/actions/Kconfig"
>   source "drivers/clk/analogbits/Kconfig"
>   source "drivers/clk/baikal-t1/Kconfig"
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e3ca0d058a25..deec25ffd004 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
>   obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
>   obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
>   obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
> +obj-$(CONFIG_COMMON_CLK_EP93XX)		+= clk-ep93xx.o
>   obj-$(CONFIG_ARCH_SPARX5)		+= clk-sparx5.o
>   obj-$(CONFIG_COMMON_CLK_EN7523)		+= clk-en7523.o
>   obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)	+= clk-fixed-mmio.o
> diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
> new file mode 100644
> index 000000000000..e5913fc4c39b
> --- /dev/null
> +++ b/drivers/clk/clk-ep93xx.c
> @@ -0,0 +1,880 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Clock control for Cirrus EP93xx chips.
> + * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * Based on a rewrite of arch/arm/mach-ep93xx/clock.c:
> + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + */
> +#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/soc/cirrus/ep93xx.h>
> +#include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +
> +#include <asm/div64.h>
> +
> +#define EP93XX_EXT_CLK_RATE		14745600
> +#define EP93XX_EXT_RTC_RATE		32768
> +
> +#define EP93XX_SYSCON_POWER_STATE	0x00
> +#define EP93XX_SYSCON_PWRCNT		0x04
> +#define EP93XX_SYSCON_PWRCNT_UARTBAUD	BIT(29)
> +#define EP93XX_SYSCON_PWRCNT_USH_EN	28
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2M1	27
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2M0	26
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P8	25
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P9	24
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P6	23
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P7	22
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P4	21
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P5	20
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P2	19
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P3	18
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P0	17
> +#define EP93XX_SYSCON_PWRCNT_DMA_M2P1	16
> +#define EP93XX_SYSCON_CLKSET1		0x20
> +#define EP93XX_SYSCON_CLKSET1_NBYP1	BIT(23)
> +#define EP93XX_SYSCON_CLKSET2		0x24
> +#define EP93XX_SYSCON_CLKSET2_NBYP2	BIT(19)
> +#define EP93XX_SYSCON_CLKSET2_PLL2_EN	BIT(18)
> +#define EP93XX_SYSCON_DEVCFG		0x80
> +#define EP93XX_SYSCON_DEVCFG_U3EN	24
> +#define EP93XX_SYSCON_DEVCFG_U2EN	20
> +#define EP93XX_SYSCON_DEVCFG_U1EN	18
> +#define EP93XX_SYSCON_VIDCLKDIV		0x84
> +#define EP93XX_SYSCON_CLKDIV_ENABLE	15
> +#define EP93XX_SYSCON_CLKDIV_ESEL	BIT(14)
> +#define EP93XX_SYSCON_CLKDIV_PSEL	BIT(13)
> +#define EP93XX_SYSCON_CLKDIV_PDIV_SHIFT	8
> +#define EP93XX_SYSCON_I2SCLKDIV		0x8c
> +#define EP93XX_SYSCON_I2SCLKDIV_SENA	31
> +#define EP93XX_SYSCON_I2SCLKDIV_ORIDE	BIT(29)
> +#define EP93XX_SYSCON_I2SCLKDIV_SPOL	BIT(19)
> +#define EP93XX_I2SCLKDIV_SDIV		(1 << 16)
> +#define EP93XX_I2SCLKDIV_LRDIV32	(0 << 17)
> +#define EP93XX_I2SCLKDIV_LRDIV64	(1 << 17)
> +#define EP93XX_I2SCLKDIV_LRDIV128	(2 << 17)
> +#define EP93XX_I2SCLKDIV_LRDIV_MASK	(3 << 17)
> +#define EP93XX_SYSCON_KEYTCHCLKDIV	0x90
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN	31
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	16
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	15
> +#define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV	0
> +#define EP93XX_SYSCON_CHIPID		0x94
> +#define EP93XX_SYSCON_CHIPID_ID		0x9213
> +
> +static DEFINE_SPINLOCK(clk_lock);
> +static struct regmap *ep93xx_map;
> +#define ep93xx_regmap_read(reg, val) regmap_read(ep93xx_map, reg, val)
> +
> +/* Keeps track of all clocks */
> +static struct clk_hw_onecell_data *ep93xx_clk_data;
> +
> +static char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
> +static char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
> +static char pclk_divisors[] = { 1, 2, 4, 8 };
> +
> +static char adc_divisors[] = { 16, 4 };
> +static char sclk_divisors[] = { 2, 4 };
> +static char lrclk_divisors[] = { 32, 64, 128 };
> +
> +static const char * const mux_parents[] = {
> +	"xtali",
> +	"pll1",
> +	"pll2"
> +};
> +
> +/*
> + * PLL rate = 14.7456 MHz * (X1FBD + 1) * (X2FBD + 1) / (X2IPD + 1) / 2^PS
> + */
> +static unsigned long calc_pll_rate(unsigned long long rate, u32 config_word)
> +{
> +	int i;
> +
> +	rate *= ((config_word >> 11) & 0x1f) + 1;		/* X1FBD */
> +	rate *= ((config_word >> 5) & 0x3f) + 1;		/* X2FBD */
> +	do_div(rate, (config_word & 0x1f) + 1);			/* X2IPD */
> +	for (i = 0; i < ((config_word >> 16) & 3); i++)		/* PS */
> +		rate >>= 1;
> +
> +	return (unsigned long)rate;
> +}
> +
> +struct clk_psc {
> +	struct clk_hw hw;
> +	unsigned int reg;
> +	u8 bit_idx;
> +	u32 mask;
> +	u8 shift;
> +	u8 width;
> +	char *div;
> +	u8 num_div;
> +	spinlock_t *lock;
> +};
> +
> +#define to_clk_psc(_hw) container_of(_hw, struct clk_psc, hw)
> +
> +static int ep93xx_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	u32 val;
> +
> +	ep93xx_regmap_read(psc->reg, &val);
> +
> +	return (val & BIT(psc->bit_idx)) ? 1 : 0;
> +}
> +
> +static int ep93xx_clk_enable(struct clk_hw *hw)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	unsigned long flags = 0;
> +	u32 val;
> +
> +	if (psc->lock)
> +		spin_lock_irqsave(psc->lock, flags);
> +
> +	ep93xx_regmap_read(psc->reg, &val);
> +	val |= BIT(psc->bit_idx);
> +
> +	ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +	if (psc->lock)
> +		spin_unlock_irqrestore(psc->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void ep93xx_clk_disable(struct clk_hw *hw)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	unsigned long flags = 0;
> +	u32 val;
> +
> +	if (psc->lock)
> +		spin_lock_irqsave(psc->lock, flags);
> +
> +	ep93xx_regmap_read(psc->reg, &val);
> +	val &= ~BIT(psc->bit_idx);
> +
> +	ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +	if (psc->lock)
> +		spin_unlock_irqrestore(psc->lock, flags);
> +}
> +
> +static const struct clk_ops clk_ep93xx_gate_ops = {
> +	.enable = ep93xx_clk_enable,
> +	.disable = ep93xx_clk_disable,
> +	.is_enabled = ep93xx_clk_is_enabled,
> +};
> +
> +static struct clk_hw *ep93xx_clk_register_gate(const char *name,
> +				    const char *parent_name,
> +				    unsigned int reg,
> +				    u8 bit_idx)
> +{
> +	struct clk_init_data init;
> +	struct clk_psc *psc;
> +	struct clk *clk;
> +
> +	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
> +	if (!psc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &clk_ep93xx_gate_ops;
> +	init.flags = CLK_SET_RATE_PARENT;
> +	init.parent_names = (parent_name ? &parent_name : NULL);
> +	init.num_parents = (parent_name ? 1 : 0);
> +
> +	psc->reg = reg;
> +	psc->bit_idx = bit_idx;
> +	psc->hw.init = &init;
> +	psc->lock = &clk_lock;
> +
> +	clk = clk_register(NULL, &psc->hw);
> +	if (IS_ERR(clk)) {
> +		kfree(psc);
> +		return ERR_CAST(clk);
> +	}
> +
> +	return &psc->hw;
> +}
> +
> +static u8 ep93xx_mux_get_parent(struct clk_hw *hw)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	u32 val;
> +
> +	ep93xx_regmap_read(psc->reg, &val);
> +	if (!(val & EP93XX_SYSCON_CLKDIV_ESEL))
> +		return 0;
> +
> +	if (!(val & EP93XX_SYSCON_CLKDIV_PSEL))
> +		return 1;
> +
> +	return 2;
> +}
> +
> +static int ep93xx_mux_set_parent_lock(struct clk_hw *hw, u8 index)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	unsigned long flags = 0;
> +	u32 val;
> +
> +	if (index >= ARRAY_SIZE(mux_parents))
> +		return -EINVAL;
> +
> +	if (psc->lock)
> +		spin_lock_irqsave(psc->lock, flags);
> +
> +	ep93xx_regmap_read(psc->reg, &val);
> +	val &= ~(EP93XX_SYSCON_CLKDIV_ESEL | EP93XX_SYSCON_CLKDIV_PSEL);
> +
> +	if (index != 0) {
> +		val |= EP93XX_SYSCON_CLKDIV_ESEL;
> +		val |= (index - 1) ? EP93XX_SYSCON_CLKDIV_PSEL : 0;
> +	}
> +
> +	ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +	if (psc->lock)
> +		spin_unlock_irqrestore(psc->lock, flags);
> +
> +	return 0;
> +}
> +
> +static bool is_best(unsigned long rate, unsigned long now,
> +		     unsigned long best)
> +{
> +	return abs(rate - now) < abs(rate - best);
> +}
> +
> +static int ep93xx_mux_determine_rate(struct clk_hw *hw,
> +				struct clk_rate_request *req)
> +{
> +	unsigned long rate = req->rate;
> +	struct clk *parent_best = NULL;
> +	unsigned long parent_rate;
> +	unsigned long best_rate = 0, actual_rate, mclk_rate;
> +	unsigned long parent_rate_best;
> +	int div, pdiv;
> +	int i;
> +
> +	/*
> +	 * Try the two pll's and the external clock
> +	 * Because the valid predividers are 2, 2.5 and 3, we multiply
> +	 * all the clocks by 2 to avoid floating point math.
> +	 *
> +	 * This is based on the algorithm in the ep93xx raster guide:
> +	 * http://be-a-maverick.com/en/pubs/appNote/AN269REV1.pdf
> +	 *
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(mux_parents); i++) {
> +		struct clk *parent = clk_get_sys(mux_parents[i], NULL);
> +
> +		parent_rate = clk_get_rate(parent);
> +		mclk_rate = parent_rate * 2;
> +
> +		/* Try each predivider value */
> +		for (pdiv = 4; pdiv <= 6; pdiv++) {
> +			div = DIV_ROUND_CLOSEST(mclk_rate, rate * pdiv);
> +			if (div < 1 || div > 127)
> +				continue;
> +
> +			actual_rate = DIV_ROUND_CLOSEST(mclk_rate, pdiv * div);
> +
> +			if (is_best(rate, actual_rate, best_rate)) {
> +				best_rate = actual_rate;
> +				parent_rate_best = parent_rate;
> +				parent_best = parent;
> +			}
> +		}
> +	}
> +
> +	if (!parent_best)
> +		return -EINVAL;
> +
> +	req->best_parent_rate = parent_rate_best;
> +	req->best_parent_hw = __clk_get_hw(parent_best);
> +	req->rate = best_rate;
> +
> +	return 0;
> +}
> +
> +static unsigned long ep93xx_ddiv_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	unsigned long rate = 0;
> +	u32 val;
> +	int pdiv, div;
> +
> +	ep93xx_regmap_read(psc->reg, &val);
> +	pdiv = ((val >> EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) & 0x03);
> +	div = val & 0x7f;
> +	if (div > 0)
> +		rate = DIV_ROUND_CLOSEST(parent_rate * 2, (pdiv + 3) * div);
> +
> +	return rate;
> +}
> +
> +static int ep93xx_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	int pdiv, div, npdiv, ndiv;
> +	unsigned long actual_rate, mclk_rate, rate_err = -1;
> +	int found = 0;
> +	u32 val;
> +
> +	ep93xx_regmap_read(psc->reg, &val);
> +	mclk_rate = parent_rate * 2;
> +
> +	for (pdiv = 4; pdiv <= 6; pdiv++) {
> +		div = DIV_ROUND_CLOSEST(mclk_rate, rate * pdiv);
> +		if (div < 1 || div > 127)
> +			continue;
> +
> +		actual_rate = DIV_ROUND_CLOSEST(mclk_rate, pdiv * div);
> +
> +		if (!found || abs(actual_rate - rate) < rate_err) {
> +			npdiv = pdiv - 3;
> +			ndiv = div;
> +			rate_err = abs(actual_rate - rate);
> +			found = 1;
> +		}
> +	}
> +
> +	if (!found)
> +		return -EINVAL;
> +
> +	/* Clear old dividers */
> +	val &= ~0x37f;
> +
> +	/* Set the new pdiv and div bits for the new clock rate */
> +	val |= (npdiv << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | ndiv;
> +
> +	ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops clk_ddiv_ops = {
> +	.enable = ep93xx_clk_enable,
> +	.disable = ep93xx_clk_disable,
> +	.is_enabled = ep93xx_clk_is_enabled,
> +	.get_parent = ep93xx_mux_get_parent,
> +	.set_parent = ep93xx_mux_set_parent_lock,
> +	.determine_rate = ep93xx_mux_determine_rate,
> +	.recalc_rate = ep93xx_ddiv_recalc_rate,
> +	.set_rate = ep93xx_ddiv_set_rate,
> +};
> +
> +static struct clk_hw *clk_hw_register_ddiv(const char *name,
> +					  unsigned int reg,
> +					  u8 bit_idx)
> +{
> +	struct clk_init_data init;
> +	struct clk_psc *psc;
> +	struct clk *clk;
> +
> +	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
> +	if (!psc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &clk_ddiv_ops;
> +	init.flags = 0;
> +	init.parent_names = mux_parents;
> +	init.num_parents = ARRAY_SIZE(mux_parents);
> +
> +	psc->reg = reg;
> +	psc->bit_idx = bit_idx;
> +	psc->lock = &clk_lock;
> +	psc->hw.init = &init;
> +
> +	clk = clk_register(NULL, &psc->hw);
> +	if (IS_ERR(clk)) {
> +		kfree(psc);
> +		return ERR_CAST(clk);
> +	}
> +
> +	return &psc->hw;
> +}
> +
> +static unsigned long ep93xx_div_recalc_rate(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	u32 val;
> +	u8 index;
> +
> +	ep93xx_regmap_read(psc->reg, &val);
> +	index = (val & psc->mask) >> psc->shift;
> +	if (index > psc->num_div)
> +		return 0;
> +
> +	return DIV_ROUND_CLOSEST(parent_rate, psc->div[index]);
> +}
> +
> +static long ep93xx_div_round_rate(struct clk_hw *hw, unsigned long rate,
> +				   unsigned long *parent_rate)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	unsigned long best = 0, now;
> +	bool assigned = false;
> +	int i;
> +
> +	for (i = 0; i < psc->num_div; i++) {
> +		if ((rate * psc->div[i]) == *parent_rate)
> +			return rate;
> +
> +		now = DIV_ROUND_CLOSEST(*parent_rate, psc->div[i]);
> +
> +		if (!assigned || is_best(rate, now, best))
> +			best = now;
> +		assigned = true;
> +	}
> +
> +	return best;
> +}
> +
> +static int ep93xx_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long parent_rate)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	u32 val;
> +	int i;
> +
> +	ep93xx_regmap_read(psc->reg, &val);
> +	val &= ~psc->mask;
> +	for (i = 0; i < psc->num_div; i++)
> +		if (rate == DIV_ROUND_CLOSEST(parent_rate, psc->div[i])) {
> +			val |= i << psc->shift;
> +			break;
> +		}
> +
> +	if (i == psc->num_div)
> +		return -EINVAL;
> +
> +	ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops ep93xx_div_ops = {
> +	.enable = ep93xx_clk_enable,
> +	.disable = ep93xx_clk_disable,
> +	.is_enabled = ep93xx_clk_is_enabled,
> +	.recalc_rate = ep93xx_div_recalc_rate,
> +	.round_rate = ep93xx_div_round_rate,
> +	.set_rate = ep93xx_div_set_rate,
> +};
> +
> +static struct clk_hw *clk_hw_register_div(const char *name,
> +					  const char *parent_name,
> +					  unsigned int reg,
> +					  u8 enable_bit,
> +					  u8 shift,
> +					  u8 width,
> +					  char *clk_divisors,
> +					  u8 num_div)
> +{
> +	struct clk_init_data init;
> +	struct clk_psc *psc;
> +	struct clk *clk;
> +
> +	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
> +	if (!psc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &ep93xx_div_ops;
> +	init.flags = 0;
> +	init.parent_names = (parent_name ? &parent_name : NULL);
> +	init.num_parents = 1;
> +
> +	psc->reg = reg;
> +	psc->bit_idx = enable_bit;
> +	psc->mask = GENMASK(shift + width - 1, shift);
> +	psc->shift = shift;
> +	psc->div = clk_divisors;
> +	psc->num_div = num_div;
> +	psc->lock = &clk_lock;
> +	psc->hw.init = &init;
> +
> +	clk = clk_register(NULL, &psc->hw);
> +	if (IS_ERR(clk)) {
> +		kfree(psc);
> +		return ERR_CAST(clk);
> +	}
> +
> +	return &psc->hw;
> +}
> +
> +struct ep93xx_gate {
> +	unsigned int idx;
> +	unsigned int bit;
> +	const char *dev_id;
> +	const char *con_id;
> +};
> +
> +static struct ep93xx_gate ep93xx_uarts[] = {
> +	{EP93XX_CLK_UART1, EP93XX_SYSCON_DEVCFG_U1EN, "apb:uart1", NULL},
> +	{EP93XX_CLK_UART2, EP93XX_SYSCON_DEVCFG_U2EN, "apb:uart2", NULL},
> +	{EP93XX_CLK_UART3, EP93XX_SYSCON_DEVCFG_U3EN, "apb:uart3", NULL},
> +};
> +
> +static void ep93xx_uart_clock_init(void)
> +{
> +	unsigned int i;
> +	struct clk_hw *hw;
> +	u32 val;
> +	unsigned int clk_uart_div;
> +
> +	ep93xx_regmap_read(EP93XX_SYSCON_PWRCNT, &val);
> +	if (val & EP93XX_SYSCON_PWRCNT_UARTBAUD)
> +		clk_uart_div = 1;
> +	else
> +		clk_uart_div = 2;
> +
> +	hw = clk_hw_register_fixed_factor(NULL, "uart", "xtali", 0, 1, clk_uart_div);
> +	ep93xx_clk_data->hws[EP93XX_CLK_UART] = hw;
> +
> +	/* parenting uart gate clocks to uart clock */
> +	for (i = 0; i < ARRAY_SIZE(ep93xx_uarts); i++) {
> +		hw = ep93xx_clk_register_gate(ep93xx_uarts[i].dev_id,
> +					"uart",
> +					EP93XX_SYSCON_DEVCFG,
> +					ep93xx_uarts[i].bit);
> +
> +		ep93xx_clk_data->hws[ep93xx_uarts[i].idx] = hw;
> +	}
> +}
> +
> +static struct ep93xx_gate ep93xx_dmas[] = {
> +	{EP93XX_CLK_M2P0, EP93XX_SYSCON_PWRCNT_DMA_M2P0, NULL, "m2p0"},
> +	{EP93XX_CLK_M2P1, EP93XX_SYSCON_PWRCNT_DMA_M2P1, NULL, "m2p1"},
> +	{EP93XX_CLK_M2P2, EP93XX_SYSCON_PWRCNT_DMA_M2P2, NULL, "m2p2"},
> +	{EP93XX_CLK_M2P3, EP93XX_SYSCON_PWRCNT_DMA_M2P3, NULL, "m2p3"},
> +	{EP93XX_CLK_M2P4, EP93XX_SYSCON_PWRCNT_DMA_M2P4, NULL, "m2p4"},
> +	{EP93XX_CLK_M2P5, EP93XX_SYSCON_PWRCNT_DMA_M2P5, NULL, "m2p5"},
> +	{EP93XX_CLK_M2P6, EP93XX_SYSCON_PWRCNT_DMA_M2P6, NULL, "m2p6"},
> +	{EP93XX_CLK_M2P7, EP93XX_SYSCON_PWRCNT_DMA_M2P7, NULL, "m2p7"},
> +	{EP93XX_CLK_M2P8, EP93XX_SYSCON_PWRCNT_DMA_M2P8, NULL, "m2p8"},
> +	{EP93XX_CLK_M2P9, EP93XX_SYSCON_PWRCNT_DMA_M2P9, NULL, "m2p9"},
> +	{EP93XX_CLK_M2M0, EP93XX_SYSCON_PWRCNT_DMA_M2M0, NULL, "m2m0"},
> +	{EP93XX_CLK_M2M1, EP93XX_SYSCON_PWRCNT_DMA_M2M1, NULL, "m2m1"},
> +};
> +
> +static void ep93xx_dma_clock_init(void __iomem *base)
> +{
> +	int i;
> +	struct clk_hw *hw;
> +	int ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(ep93xx_dmas); i++) {
> +		hw = clk_hw_register_gate(NULL, ep93xx_dmas[i].con_id,
> +					"hclk", 0,
> +					base + EP93XX_SYSCON_PWRCNT,
> +					ep93xx_dmas[i].bit,
> +					0,
> +					&clk_lock);
> +
> +		ret = clk_hw_register_clkdev(hw, ep93xx_dmas[i].con_id, NULL);
> +		if (ret) {
> +			pr_err("%s: failed to register lookup %s\n",
> +			       __func__, ep93xx_dmas[i].con_id);
> +			continue;
> +		}
> +
> +		ep93xx_clk_data->hws[ep93xx_dmas[i].idx] = hw;
> +	}
> +}
> +
> +static int ep93xx_clk_probe(struct platform_device *pdev)
> +{
> +	void __iomem *base;
> +	unsigned int clk_usb_div;
> +	unsigned long clk_spi_div;
> +	struct clk_hw *hw;
> +	struct device *dev = &pdev->dev;
> +	u32 value;
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	ep93xx_regmap_read(EP93XX_SYSCON_CLKSET2, &value);
> +	clk_usb_div = (((value >> 28) & 0xf) + 1);
> +	hw = clk_hw_register_fixed_factor(NULL, "usb_clk", "pll2", 0, 1, clk_usb_div);
> +	hw = clk_hw_register_gate(NULL, "ohci-platform",
> +				"usb_clk", 0,
> +				base + EP93XX_SYSCON_PWRCNT,
> +				EP93XX_SYSCON_PWRCNT_USH_EN,
> +				0,
> +				&clk_lock);
> +	clk_hw_register_clkdev(hw, NULL, "ohci-platform");
> +	ep93xx_clk_data->hws[EP93XX_CLK_USB] = hw;
> +
> +	/*
> +	 * EP93xx SSP clock rate was doubled in version E2. For more information
> +	 * see:
> +	 *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
> +	 */
> +	clk_spi_div = 1;
> +	if (ep93xx_chip_revision() < EP93XX_CHIP_REV_E2)
> +		clk_spi_div = 2;
> +	hw = clk_hw_register_fixed_factor(NULL, "ep93xx-spi.0", "xtali", 0, 1, clk_spi_div);
> +	clk_hw_register_clkdev(hw, NULL, "ep93xx-spi.0");
> +	ep93xx_clk_data->hws[EP93XX_CLK_SPI] = hw;
> +
> +	/* pwm clock */
> +	hw = clk_hw_register_fixed_factor(NULL, "pwm_clk", "xtali", 0, 1, 1);
> +	clk_hw_register_clkdev(hw, "pwm_clk", NULL);
> +	ep93xx_clk_data->hws[EP93XX_CLK_PWM] = hw;
> +
> +	ep93xx_uart_clock_init();
> +
> +	/* touchscreen/adc clock */
> +	hw = clk_hw_register_div("ep93xx-adc",
> +				"xtali",
> +				EP93XX_SYSCON_KEYTCHCLKDIV,
> +				EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
> +				EP93XX_SYSCON_KEYTCHCLKDIV_ADIV,
> +				1,
> +				adc_divisors,
> +				ARRAY_SIZE(adc_divisors));
> +
> +	clk_hw_register_clkdev(hw, NULL, "ep93xx-adc");
> +	ep93xx_clk_data->hws[EP93XX_CLK_ADC] = hw;
> +
> +	/* keypad clock */
> +	hw = clk_hw_register_div("ep93xx-keypad",
> +				"xtali",
> +				EP93XX_SYSCON_KEYTCHCLKDIV,
> +				EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
> +				EP93XX_SYSCON_KEYTCHCLKDIV_KDIV,
> +				1,
> +				adc_divisors,
> +				ARRAY_SIZE(adc_divisors));
> +
> +	clk_hw_register_clkdev(hw, NULL, "ep93xx-keypad");
> +	ep93xx_clk_data->hws[EP93XX_CLK_KEYPAD] = hw;
> +
> +	/* On reset PDIV and VDIV is set to zero, while PDIV zero
> +	 * means clock disable, VDIV shouldn't be zero.
> +	 * So i set both dividers to minimum.
> +	 */
> +	/* ENA - Enable CLK divider. */
> +	/* PDIV - 00 - Disable clock */
> +	/* VDIV - at least 2 */
> +	/* Check and enable video clk registers */
> +	ep93xx_regmap_read(EP93XX_SYSCON_VIDCLKDIV, &value);
> +	value |= (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
> +	ep93xx_syscon_swlocked_write(value, EP93XX_SYSCON_VIDCLKDIV);
> +
> +	/* check and enable i2s clk registers */
> +	ep93xx_regmap_read(EP93XX_SYSCON_I2SCLKDIV, &value);
> +	value |= (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
> +	/*
> +	 * Override the SAI_MSTR_CLK_CFG from the I2S block and use the
> +	 * I2SClkDiv Register settings. LRCLK transitions on the falling SCLK
> +	 * edge.
> +	 */
> +	value |= EP93XX_SYSCON_I2SCLKDIV_ORIDE | EP93XX_SYSCON_I2SCLKDIV_SPOL;
> +	ep93xx_syscon_swlocked_write(value, EP93XX_SYSCON_I2SCLKDIV);
> +
> +	/* video clk */
> +	hw = clk_hw_register_ddiv("ep93xx-fb",
> +				EP93XX_SYSCON_VIDCLKDIV,
> +				EP93XX_SYSCON_CLKDIV_ENABLE);
> +
> +	clk_hw_register_clkdev(hw, NULL, "ep93xx-fb");
> +	ep93xx_clk_data->hws[EP93XX_CLK_VIDEO] = hw;
> +
> +	/* i2s clk */
> +	hw = clk_hw_register_ddiv("mclk",
> +				EP93XX_SYSCON_I2SCLKDIV,
> +				EP93XX_SYSCON_CLKDIV_ENABLE);
> +
> +	clk_hw_register_clkdev(hw, "mclk", "ep93xx-i2s");
> +	ep93xx_clk_data->hws[EP93XX_CLK_I2S_MCLK] = hw;
> +
> +	/* i2s sclk */
> +#define EP93XX_I2SCLKDIV_SDIV_SHIFT	16
> +#define EP93XX_I2SCLKDIV_SDIV_WIDTH	1
> +	hw = clk_hw_register_div("sclk",
> +				"mclk",
> +				EP93XX_SYSCON_I2SCLKDIV,
> +				EP93XX_SYSCON_I2SCLKDIV_SENA,
> +				EP93XX_I2SCLKDIV_SDIV_SHIFT,
> +				EP93XX_I2SCLKDIV_SDIV_WIDTH,
> +				sclk_divisors,
> +				ARRAY_SIZE(sclk_divisors));
> +
> +	clk_hw_register_clkdev(hw, "sclk", "ep93xx-i2s");
> +	ep93xx_clk_data->hws[EP93XX_CLK_I2S_SCLK] = hw;
> +
> +	/* i2s lrclk */
> +#define EP93XX_I2SCLKDIV_LRDIV32_SHIFT	17
> +#define EP93XX_I2SCLKDIV_LRDIV32_WIDTH	2
> +	hw = clk_hw_register_div("lrclk",
> +				"sclk",
> +				EP93XX_SYSCON_I2SCLKDIV,
> +				EP93XX_SYSCON_I2SCLKDIV_SENA,
> +				EP93XX_I2SCLKDIV_LRDIV32_SHIFT,
> +				EP93XX_I2SCLKDIV_LRDIV32_WIDTH,
> +				lrclk_divisors,
> +				ARRAY_SIZE(lrclk_divisors));
> +
> +	clk_hw_register_clkdev(hw, "lrclk", "ep93xx-i2s");
> +	ep93xx_clk_data->hws[EP93XX_CLK_I2S_LRCLK] = hw;
> +
> +	/* IrDa clk uses same pattern but no init code presents in original clock driver */
> +	return 0;
> +}
> +
> +static const struct of_device_id ep93xx_clk_dt_ids[] = {
> +	{ .compatible = "cirrus,ep9301-syscon", },
> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver ep93xx_clk_driver = {
> +	.probe  = ep93xx_clk_probe,
> +	.driver = {
> +		.name = "ep93xx-clk",
> +		.of_match_table = ep93xx_clk_dt_ids,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver(ep93xx_clk_driver);
> +
> +static void __init ep93xx_clock_init(struct device_node *np)
> +{
> +	void __iomem *base;
> +	int i;
> +	int ret;
> +	u32 value;
> +	struct clk_hw *hw;
> +	unsigned long clk_pll1_rate;
> +	unsigned long clk_f_rate;
> +	unsigned long clk_h_rate;
> +	unsigned long clk_p_rate;
> +	unsigned long clk_pll2_rate;
> +	unsigned int clk_f_div;
> +	unsigned int clk_h_div;
> +	unsigned int clk_p_div;
> +
> +	ep93xx_clk_data = kzalloc(struct_size(ep93xx_clk_data, hws,
> +				EP93XX_NUM_CLKS),
> +				GFP_KERNEL);
> +

Hi,

This is never released if an error occures below.
Missing error handling or it is useless to care about it?

> +	if (!ep93xx_clk_data)
> +		return;
> +
> +	/*
> +	 * This way all clock fetched before the platform device probes,
> +	 * except those we assign here for early use, will be deferred.
> +	 */
> +	for (i = 0; i < EP93XX_NUM_CLKS; i++)
> +		ep93xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> +
> +	base = of_iomap(np, 0);

Same.

> +	/* Remap the system controller for the exclusive register */
> +	if (IS_ERR(base)) {
> +		pr_err("failed to map base\n");
> +		return;
> +	}
> +
> +	ep93xx_map = syscon_node_to_regmap(np);
> +	if (IS_ERR(ep93xx_map)) {
> +		pr_err("no syscon regmap\n");
> +		return;
> +	}
> +
> +	/*
> +	 * We check that the regmap works on this very first access,
> +	 * but as this is an MMIO-backed regmap, subsequent regmap
> +	 * access is not going to fail and we skip error checks from
> +	 * this point.
> +	 */
> +	ret = ep93xx_regmap_read(EP93XX_SYSCON_CHIPID, &value);
> +	if (ret || (value & 0xffff) != EP93XX_SYSCON_CHIPID_ID) {
> +		pr_err("failed to read global status register\n");
> +		return;
> +	}
> +
> +	hw = clk_hw_register_fixed_rate(NULL, "xtali", NULL, 0, EP93XX_EXT_CLK_RATE);
> +	clk_hw_register_clkdev(hw, NULL, "xtali");
> +
> +	/* Determine the bootloader configured pll1 rate */
> +	ep93xx_regmap_read(EP93XX_SYSCON_CLKSET1, &value);
> +	if (!(value & EP93XX_SYSCON_CLKSET1_NBYP1))
> +		clk_pll1_rate = EP93XX_EXT_CLK_RATE;
> +	else
> +		clk_pll1_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
> +
> +	hw = clk_hw_register_fixed_rate(NULL, "pll1", "xtali", 0, clk_pll1_rate);
> +	clk_hw_register_clkdev(hw, NULL, "pll1");
> +	ep93xx_clk_data->hws[EP93XX_CLK_PLL1] = hw;
> +
> +	/* Initialize the pll1 derived clocks */
> +	clk_f_div = fclk_divisors[(value >> 25) & 0x7];
> +	clk_h_div = hclk_divisors[(value >> 20) & 0x7];
> +	clk_p_div = pclk_divisors[(value >> 18) & 0x3];
> +
> +	hw = clk_hw_register_fixed_factor(NULL, "fclk", "pll1", 0, 1, clk_f_div);
> +	clk_f_rate = clk_get_rate(hw->clk);
> +	ep93xx_clk_data->hws[EP93XX_CLK_FCLK] = hw;
> +	hw = clk_hw_register_fixed_factor(NULL, "hclk", "pll1", 0, 1, clk_h_div);
> +	clk_h_rate = clk_get_rate(hw->clk);
> +	ep93xx_clk_data->hws[EP93XX_CLK_HCLK] = hw;
> +	hw = clk_hw_register_fixed_factor(NULL, "pclk", "hclk", 0, 1, clk_p_div);
> +	clk_p_rate = clk_get_rate(hw->clk);
> +	ep93xx_clk_data->hws[EP93XX_CLK_PCLK] = hw;
> +
> +	clk_hw_register_clkdev(hw, "apb_pclk", NULL);
> +
> +	ep93xx_dma_clock_init(base);
> +
> +	/* Determine the bootloader configured pll2 rate */
> +	ep93xx_regmap_read(EP93XX_SYSCON_CLKSET2, &value);
> +	if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
> +		clk_pll2_rate = EP93XX_EXT_CLK_RATE;
> +	else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
> +		clk_pll2_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
> +	else
> +		clk_pll2_rate = 0;
> +
> +	hw = clk_hw_register_fixed_rate(NULL, "pll2", "xtali", 0, clk_pll2_rate);
> +	ep93xx_clk_data->hws[EP93XX_CLK_PLL2] = hw;
> +	clk_hw_register_clkdev(hw, NULL, "pll2");
> +
> +	ep93xx_clk_data->num = EP93XX_NUM_CLKS;
> +	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, ep93xx_clk_data);
> +
> +	pr_info("PLL1 running at %ld MHz, PLL2 at %ld MHz\n",
> +		clk_pll1_rate / 1000000, clk_pll2_rate / 1000000);
> +	pr_info("FCLK %ld MHz, HCLK %ld MHz, PCLK %ld MHz\n",
> +		clk_f_rate / 1000000, clk_h_rate / 1000000,
> +		clk_p_rate / 1000000);
> +}
> +CLK_OF_DECLARE_DRIVER(ep93xx_cc, "cirrus,ep9301-syscon", ep93xx_clock_init);

