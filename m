Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635CD7211B6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjFCS6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFCS6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:58:40 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270D5CA
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 11:58:39 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id a4dc4430-0240-11ee-b972-005056bdfda7;
        Sat, 03 Jun 2023 21:58:36 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 21:58:36 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v1 05/43] clk: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <ZHuNXDjPfOvyTNtp@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-6-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601053546.9574-6-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 08:33:56AM +0300, Nikita Shubin kirjoitti:
> This is a rewrite of EP93xx timer driver in
> arch/arm/mach-ep93xx/clock.c trying to do everything
> the device tree way:
> 
> - convert to syscon driver
> - provide clock acces via of

...

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

Can you keep them sorted?
Missing bits.h.

+ Blank line.

> +#include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +
> +#include <asm/div64.h>

...

> +static const struct clk_parent_data ep93xx_clk_parents[] = {
> +	EP_PARENT("xtali"),
> +	EP_PARENT("pll1"),
> +	EP_PARENT("pll2")

Keep trailing comma, it might help in case it will be extended.

> +};

...

> +static unsigned long calc_pll_rate(u64 rate, u32 config_word)
> +{
> +	int i;
> +
> +	rate *= ((config_word >> 11) & 0x1f) + 1;		/* X1FBD */
> +	rate *= ((config_word >> 5) & 0x3f) + 1;		/* X2FBD */
> +	do_div(rate, (config_word & 0x1f) + 1);			/* X2IPD */

GENMASK() in all three?

> +	for (i = 0; i < ((config_word >> 16) & 3); i++)		/* PS */
> +		rate >>= 1;

I'm not sure I understand why loop is needed.

	rate >>= 1 << ((config_word >> 16) & GENMASK(1, 0));

?

> +	return rate;
> +}

...

> +struct clk_psc {
> +	struct clk_hw hw;
> +	unsigned int reg;
> +	u8 bit_idx;
> +	u32 mask;
> +	u8 shift;
> +	u8 width;
> +	const char *div;
> +	u8 num_div;
> +	spinlock_t *lock;
> +	bool nolock;

Is it important to mix different types like this? pahole can provide you a much
better layout that does not waste a lot of bytes.

> +};

...

> +	return (val & BIT(psc->bit_idx)) ? 1 : 0;

!!(...) also would work, but up to you. Compiler optimizes this anyway.

...

> +	unsigned long flags = 0;

Redundant assignment. *spin_lock*() are macros.
Same for all cases with *spin_lock*().

...

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

Wonder if switch-case can make this more explicit...

> +}

...

> +	if (psc->lock)
> +		spin_lock_irqsave(psc->lock, flags);

Does sparse complain on the lock? If so, the function would need a special
annotation.

...

> +	ep93xx_regmap_read(psc->reg, &val);
> +	val &= ~(EP93XX_SYSCON_CLKDIV_ESEL | EP93XX_SYSCON_CLKDIV_PSEL);
> +

More naturally this blank line looks fter regmap_read.

> +	if (index != 0) {

	if (index)

also works.

> +		val |= EP93XX_SYSCON_CLKDIV_ESEL;
> +		val |= (index - 1) ? EP93XX_SYSCON_CLKDIV_PSEL : 0;
> +	}

...

> +static unsigned long ep93xx_ddiv_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	unsigned long rate = 0;

Instead you can invert the conditional, see below.

> +	u32 val;
> +	int pdiv, div;
> +
> +	ep93xx_regmap_read(psc->reg, &val);
> +	pdiv = ((val >> EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) & 0x03);
> +	div = val & 0x7f;

GENMASK() in both cases?

> +	if (div > 0)

	if (div <= 0)
		return 0;

> +		rate = DIV_ROUND_CLOSEST(parent_rate * 2, (pdiv + 3) * div);

	return DIV_ROUND_CLOSES(...);

> +
> +	return rate;
> +}

...

> +static int ep93xx_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	int pdiv, div, npdiv, ndiv;
> +	unsigned long actual_rate, mclk_rate, rate_err = -1;

ULONG_MAX instead of -1. -1 on 64-bits is not the same as ULONG_MAX
(yes, I know that this is not the case here, simply not the best constant).

> +	int found = 0;

Besides using it as boolean, IIUC it's not needed if you compare
the rate_err to ULONG_MAX where required.

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

Redundant blank line.

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

> +	/* Clear old dividers */
> +	val &= ~0x37f;

GENMASK() ?

> +	/* Set the new pdiv and div bits for the new clock rate */
> +	val |= (npdiv << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | ndiv;
> +
> +	ep93xx_syscon_swlocked_write(val, psc->reg);
> +
> +	return 0;
> +}

...

> +{
> +	struct clk_psc *psc = to_clk_psc(hw);
> +	unsigned long best = 0, now;
> +	bool assigned = false;

You see, you are using here the boolean. But think about it, maybe it can be
refactored as well.

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

...

> +	ep93xx_regmap_read(EP93XX_SYSCON_CLKSET2, &value);
> +	clk_usb_div = (((value >> 28) & 0xf) + 1);

GENMASK() ?

> +	hw = clk_hw_register_fixed_factor(NULL, "usb_clk", "pll2", 0, 1, clk_usb_div);
> +	hw = ep93xx_clk_register_gate("ohci-platform",
> +				"usb_clk", 0,
> +				EP93XX_SYSCON_PWRCNT,
> +				EP93XX_SYSCON_PWRCNT_USH_EN,
> +				true);

...

> +	/* pwm clock */

PWM

...

> +	value |= (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;

BIT() ?

...

> +	value |= (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;

Ditto.

...

> +static const struct of_device_id ep93xx_clk_dt_ids[] = {
> +	{ .compatible = "cirrus,ep9301-clk", },

Inner comma is not needed.

> +	{ /* sentinel */ }
> +};

...

> +	ep93xx_clk_data = kzalloc(struct_size(ep93xx_clk_data, hws,
> +				EP93XX_NUM_CLKS),
> +				GFP_KERNEL);

> +

Redundant blank line.

> +	if (!ep93xx_clk_data)
> +		return;

...

> +	ret = ep93xx_regmap_read(EP93XX_SYSCON_CHIPID, &value);
> +	if (ret || (value & 0xffff) != EP93XX_SYSCON_CHIPID_ID) {

GENMASK() ?

> +		pr_err("failed to read global status register\n");
> +		return;
> +	}

...

> +	/* Initialize the pll1 derived clocks */
> +	clk_f_div = fclk_divisors[(value >> 25) & 0x7];
> +	clk_h_div = hclk_divisors[(value >> 20) & 0x7];
> +	clk_p_div = pclk_divisors[(value >> 18) & 0x3];

Ditto.


...

> +

Unneded blank line.

> +CLK_OF_DECLARE_DRIVER(ep93xx, "cirrus,ep9301-clk", ep93xx_clock_init);

-- 
With Best Regards,
Andy Shevchenko


