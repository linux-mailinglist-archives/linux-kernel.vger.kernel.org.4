Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF7B6CC9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjC1SS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjC1SSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:18:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF4910EF;
        Tue, 28 Mar 2023 11:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4452B618EE;
        Tue, 28 Mar 2023 18:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F30C433EF;
        Tue, 28 Mar 2023 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680027528;
        bh=Myk8TTKMLwvWBKvs9sA5M9dhfm7LWY5HIA0E1Ic6Ti4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=D0OcT/OXNWP1LeClctFdsMYx+uzKaRLE3goB6b5Sf9qqbFpWNixsFZ/VaUtpMe3l7
         AyHO+rqa3smd2x5RxDwOLTydn1BvflLT0Jwj6TGikWttS3EPwPwp+63RbOKt5KwmE7
         hQ9wq86Hg6/Y9lXeVqsWzBVVK/paIX3kKWr10Dl6e2pf+SFn/rZVkx1kfjPyChkGhh
         YDORq1lrFotLeGnGCvVPVnPiLPWB6Xljh6vVb2JnwB2HUVylx1I9U5RIRzHfMxjRUD
         1WP7elNl3mJLtjyjR+zPl8e+RBl8/GshoYMxvgBEk/xP2qBmOmzVVoCgAvGgPrIy0W
         WnSR40M9YPjhw==
Message-ID: <b425f98de9378ea8c725fef34fabade4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230328021912.177301-10-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com> <20230328021912.177301-10-ychuang570808@gmail.com>
Subject: Re: [PATCH v6 09/12] clk: nuvoton: Add clock driver for ma35d1 clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
To:     Jacky Huang <ychuang570808@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Date:   Tue, 28 Mar 2023 11:18:46 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-03-27 19:19:09)
> diff --git a/drivers/clk/nuvoton/Kconfig b/drivers/clk/nuvoton/Kconfig
> new file mode 100644
> index 000000000000..c1324efedcb9
> --- /dev/null
> +++ b/drivers/clk/nuvoton/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# common clock support for Nuvoton SoC family.
> +
> +config COMMON_CLK_NUVOTON
> +       bool "Nuvoton clock controller common support"
> +       depends on ARCH_NUVOTON

Add || COMPILE_TEST

> +       default ARCH_NUVOTON
> +       help
> +         Say y here to enable common clock controller for Nuvoton platfo=
rms.
> +
> +if COMMON_CLK_NUVOTON

Add a newline here.

> +config CLK_MA35D1
> +       bool "Nuvoton MA35D1 clock controller support"
> +       depends on ARM64 || COMPILE_TEST

Drop this

> +       default y

And this.

> +       help
> +         Build the driver for MA35D1 Clock Driver.

This says driver twice. "Build the clk driver for MA35D1 SoCs"?

> +
> +endif
> diff --git a/drivers/clk/nuvoton/clk-ma35d1-divider.c b/drivers/clk/nuvot=
on/clk-ma35d1-divider.c
> new file mode 100644
> index 000000000000..340a889a1417
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
> +#include "clk-ma35d1.h"
> +
> +#define clk_div_mask(width)    ((1 << (width)) - 1)

clk-provider.h defines this already, use that?

> +
> +struct ma35d1_adc_clk_div {
> +       struct clk_hw hw;
> +       void __iomem *reg;
> +       u8 shift;
> +       u8 width;
> +       u32 mask;
> +       const struct clk_div_table *table;
> +       /* protects concurrent access to clock divider registers */
> +       spinlock_t *lock;
> +};
> +
> +static inline struct ma35d1_adc_clk_div *to_ma35d1_adc_clk_div(struct cl=
k_hw *_hw)
> +{
> +       return container_of(_hw, struct ma35d1_adc_clk_div, hw);
> +}
> +
> +static inline unsigned long ma35d1_clkdiv_recalc_rate(struct clk_hw *hw,
> +                                                     unsigned long paren=
t_rate)
> +{
> +       unsigned int val;
> +       struct ma35d1_adc_clk_div *dclk =3D to_ma35d1_adc_clk_div(hw);
> +
> +       val =3D readl_relaxed(dclk->reg) >> dclk->shift;
> +       val &=3D clk_div_mask(dclk->width);
> +       val +=3D 1;
> +       return divider_recalc_rate(hw, parent_rate, val, dclk->table,
> +                                  CLK_DIVIDER_ROUND_CLOSEST, dclk->width=
);
> +}
> +
> +static inline long ma35d1_clkdiv_round_rate(struct clk_hw *hw,
> +                                           unsigned long rate,
> +                                           unsigned long *prate)
> +{
> +       struct ma35d1_adc_clk_div *dclk =3D to_ma35d1_adc_clk_div(hw);
> +
> +       return divider_round_rate(hw, rate, prate, dclk->table,
> +                                 dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
> +}
> +
> +static inline int ma35d1_clkdiv_set_rate(struct clk_hw *hw,
> +                                        unsigned long rate,
> +                                        unsigned long parent_rate)
> +{
> +       int value;
> +       unsigned long flags =3D 0;
> +       u32 data;
> +       struct ma35d1_adc_clk_div *dclk =3D to_ma35d1_adc_clk_div(hw);
> +
> +       value =3D divider_get_val(rate, parent_rate, dclk->table,
> +                               dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
> +
> +       if (dclk->lock)
> +               spin_lock_irqsave(dclk->lock, flags);

Can you just always lock? That makes the conditional locking go away.

> +
> +       data =3D readl_relaxed(dclk->reg);
> +       data &=3D ~(clk_div_mask(dclk->width) << dclk->shift);
> +       data |=3D (value - 1) << dclk->shift;
> +       data |=3D dclk->mask;
> +
> +       writel_relaxed(data, dclk->reg);
> +
> +       if (dclk->lock)
> +               spin_unlock_irqrestore(dclk->lock, flags);
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops ma35d1_adc_clkdiv_ops =3D {
> +       .recalc_rate =3D ma35d1_clkdiv_recalc_rate,
> +       .round_rate =3D ma35d1_clkdiv_round_rate,
> +       .set_rate =3D ma35d1_clkdiv_set_rate,
> +};
> +
> +struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev, const char *nam=
e,
> +                                    const char *parent_name,
> +                                    spinlock_t *lock,
> +                                    unsigned long flags, void __iomem *r=
eg,
> +                                    u8 shift, u8 width, u32 mask_bit)
> +{
> +       struct ma35d1_adc_clk_div *div;
> +       struct clk_init_data init;
> +       struct clk_div_table *table;
> +       u32 max_div, min_div;
> +       struct clk_hw *hw;
> +       int ret;
> +       int i;
> +
> +       div =3D devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return ERR_PTR(-ENOMEM);
> +
> +       max_div =3D clk_div_mask(width) + 1;
> +       min_div =3D 1;
> +
> +       table =3D devm_kcalloc(dev, max_div + 1, sizeof(*table), GFP_KERN=
EL);
> +       if (!table)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (i =3D 0; i < max_div; i++) {
> +               table[i].val =3D (min_div + i);

Drop useless parenthesis.

> +               table[i].div =3D 2 * table[i].val;
> +       }
> +       table[max_div].val =3D 0;
> +       table[max_div].div =3D 0;
> +
> +       init.name =3D name;
> +       init.ops =3D &ma35d1_adc_clkdiv_ops;
> +       init.flags |=3D flags;
> +       init.parent_names =3D parent_name ? &parent_name : NULL;
> +       init.num_parents =3D parent_name ? 1 : 0;
> +
> +       div->reg =3D reg;
> +       div->shift =3D shift;
> +       div->width =3D width;
> +       div->mask =3D mask_bit ? BIT(mask_bit) : 0;
> +       div->lock =3D lock;
> +       div->hw.init =3D &init;
> +       div->table =3D table;
> +
> +       hw =3D &div->hw;
> +       ret =3D devm_clk_hw_register(dev, hw);
> +       if (ret < 0)

Use if (ret) instead.

> +               return ERR_PTR(ret);
> +       return hw;
> +}
> diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c b/drivers/clk/nuvoton/c=
lk-ma35d1-pll.c
> new file mode 100644
> index 000000000000..b36fbda4fa0a
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1-pll.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +
> +#include "clk-ma35d1.h"
> +
> +#define REG_SYS_RLKTZNS                0x1a4 /* Register Lock Control */
> +
> +struct ma35d1_clk_pll {
> +       struct clk_hw hw;
> +       u8 type;
> +       u8 mode;
> +       unsigned long rate;
> +       void __iomem *ctl0_base;

This needs an include for __iomem define. Just include kernel.h for now.

> +       void __iomem *ctl1_base;
> +       void __iomem *ctl2_base;
> +       struct regmap *regmap;
> +};
> +
> +static inline struct ma35d1_clk_pll *to_ma35d1_clk_pll(struct clk_hw *_h=
w)
> +{
> +       return container_of(_hw, struct ma35d1_clk_pll, hw);

Missing include as well.

> +}
> +
> +static void ma35d1_unlock_regs(struct ma35d1_clk_pll *pll)
> +{
> +       int ret;
> +
> +       do {
> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x59);
> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x16);
> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x88);
> +               regmap_read(pll->regmap, REG_SYS_RLKTZNS, &ret);
> +       } while (ret =3D=3D 0);

Any sort of timeout?

> +}
> +
> +static void ma35d1_lock_regs(struct ma35d1_clk_pll *pll)
> +{
> +       regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x0);
> +}
> +
> +static unsigned long ma35d1_calc_smic_pll_freq(u32 pll0_ctl0,
> +                                              unsigned long parent_rate)
> +{
> +       u32 m, n, p, outdiv;
> +       u64 pll_freq;
> +       u32 clk_div_table[] =3D { 1, 2, 4, 8 };

const

> +
> +       if (pll0_ctl0 & SPLL0_CTL0_BP)
> +               return parent_rate;
> +
> +       n =3D FIELD_GET(SPLL0_CTL0_FBDIV, pll0_ctl0);
> +       m =3D FIELD_GET(SPLL0_CTL0_INDIV, pll0_ctl0);
> +       p =3D FIELD_GET(SPLL0_CTL0_OUTDIV, pll0_ctl0);
> +       outdiv =3D clk_div_table[p];
> +       pll_freq =3D (u64)parent_rate * n;
> +       do_div(pll_freq, m * outdiv);
> +       return (unsigned long)pll_freq;

Remove useless cast.

> +}
> +
> +static unsigned long ma35d1_calc_pll_freq(u8 mode, u32 *reg_ctl,
> +                                         unsigned long parent_rate)
> +{
> +       u32 m, n, p;
> +       u64 pll_freq, x;
> +
> +       if (reg_ctl[1] & PLL_CTL1_BP)
> +               return parent_rate;
> +
> +       if (mode =3D=3D PLL_MODE_INT) {
> +               n =3D FIELD_GET(PLL_CTL0_FBDIV, reg_ctl[0]);
> +               m =3D FIELD_GET(PLL_CTL0_INDIV, reg_ctl[0]);
> +               p =3D FIELD_GET(PLL_CTL1_OUTDIV, reg_ctl[1]);
> +               pll_freq =3D (u64)parent_rate * n;
> +               do_div(pll_freq, m * p);
> +       } else {
> +               n =3D FIELD_GET(PLL_CTL0_FBDIV, reg_ctl[0]);
> +               m =3D FIELD_GET(PLL_CTL0_INDIV, reg_ctl[0]);
> +               p =3D FIELD_GET(PLL_CTL1_OUTDIV, reg_ctl[1]);

The n, m, p are the same, so pull them out of the if-else to deduplicate.

> +               x =3D FIELD_GET(PLL_CTL1_FRAC, reg_ctl[1]);
> +               /* 2 decimal places floating to integer (ex. 1.23 to 123)=
 */
> +               n =3D n * 100 + ((x * 100) / FIELD_MAX(PLL_CTL1_FRAC));

Is this mult_frac()?

> +               pll_freq =3D ((u64)parent_rate * n) / 100 / m / p;
> +       }

Add a newline

> +       return (unsigned long)pll_freq;

Remove useless cast.

> +}
> +
> +static int ma35d1_pll_find_closest(struct ma35d1_clk_pll *pll,
> +                                  unsigned long rate,
> +                                  unsigned long parent_rate,
> +                                  u32 *reg_ctl, unsigned long *freq)
> +{
> +       int p, m, n;
> +       int fbdiv_min, fbdiv_max;
> +       unsigned long diff =3D 0xffffffff;
> +
> +       *freq =3D 0;
> +       if ((rate < PLL_FCLKO_MIN_FREQ) || (rate > PLL_FCLKO_MAX_FREQ))
> +               return -EINVAL;
> +
> +       if (pll->mode =3D=3D PLL_MODE_INT) {
> +               fbdiv_min =3D FBDIV_MIN;
> +               fbdiv_max =3D FBDIV_MAX;
> +       } else {
> +               fbdiv_min =3D FBDIV_FRAC_MIN;
> +               fbdiv_max =3D FBDIV_FRAC_MAX;
> +       }
> +
> +       for (m =3D INDIV_MIN; m <=3D INDIV_MAX; m++) {
> +               for (n =3D fbdiv_min; n <=3D fbdiv_max; n++) {
> +                       for (p =3D OUTDIV_MIN; p <=3D OUTDIV_MAX; p++) {
> +                               unsigned long tmp, fout;
> +                               u64 fclk;
> +
> +                               tmp =3D parent_rate / m;
> +                               if (tmp < PLL_FREF_M_MIN_FREQ ||
> +                                   tmp > PLL_FREF_M_MAX_FREQ)
> +                                       continue; /* constrain */
> +
> +                               fclk =3D (u64)parent_rate * n / m;
> +                               /* for 2 decimal places */
> +                               if (pll->mode !=3D PLL_MODE_INT)
> +                                       fclk /=3D 100;
> +
> +                               if (fclk < PLL_FCLK_MIN_FREQ ||
> +                                   fclk > PLL_FCLK_MAX_FREQ)
> +                                       continue; /* constrain */
> +
> +                               fout =3D (unsigned long)(fclk / p);
> +                               if (fout < PLL_FCLKO_MIN_FREQ ||
> +                                   fout > PLL_FCLKO_MAX_FREQ)
> +                                       continue; /* constrain */
> +
> +                               if (abs(rate - fout) < diff) {
> +                                       reg_ctl[0] =3D FIELD_PREP(PLL_CTL=
0_INDIV, m) |
> +                                                    FIELD_PREP(PLL_CTL0_=
FBDIV, n);
> +                                       reg_ctl[1] =3D FIELD_PREP(PLL_CTL=
1_OUTDIV, p);
> +                                       *freq =3D fout;
> +                                       diff =3D abs(rate - fout);
> +                                       if (diff =3D=3D 0)
> +                                               break;
> +                               }
> +                       }
> +               }
> +       }
> +       if (*freq =3D=3D 0)
> +               return -EINVAL; /* cannot find even one valid setting */
> +       return 0;
> +}
> +
> +static int ma35d1_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                  unsigned long parent_rate)
> +{
> +       struct ma35d1_clk_pll *pll =3D to_ma35d1_clk_pll(hw);
> +       u32 reg_ctl[3] =3D { 0 };
> +       unsigned long pll_freq;
> +       int ret;
> +
> +       if ((parent_rate < PLL_FREF_MIN_FREQ) ||
> +           (parent_rate > PLL_FREF_MAX_FREQ))

Remove useless parenthesis.

> +               return -EINVAL;
> +
> +       if ((pll->type =3D=3D MA35D1_CAPLL) || (pll->type =3D=3D MA35D1_D=
DRPLL)) {

Remove useless parenthesis.

> +               pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
> +               return -EACCES;
> +       }
> +
> +       ret =3D ma35d1_pll_find_closest(pll, rate, parent_rate, reg_ctl, =
&pll_freq);
> +       if (ret !=3D 0)
> +               return ret;
> +       pll->rate =3D pll_freq;
> +
> +       switch (pll->mode) {
> +       case PLL_MODE_INT:
> +               reg_ctl[0] |=3D FIELD_PREP(PLL_CTL0_MODE, PLL_MODE_INT);
> +               break;
> +       case PLL_MODE_FRAC:
> +               reg_ctl[0] |=3D FIELD_PREP(PLL_CTL0_MODE, PLL_MODE_FRAC);
> +               break;
> +       case PLL_MODE_SS:
> +               reg_ctl[0] |=3D FIELD_PREP(PLL_CTL0_MODE, PLL_MODE_SS) |
> +                             FIELD_PREP(PLL_CTL0_SSRATE, PLL_SS_RATE);
> +               reg_ctl[2] =3D FIELD_PREP(PLL_CTL2_SLOPE, PLL_SLOPE);
> +               break;
> +       }
> +       reg_ctl[1] |=3D PLL_CTL1_PD;
> +
> +       ma35d1_unlock_regs(pll);
> +       writel_relaxed(reg_ctl[0], pll->ctl0_base);
> +       writel_relaxed(reg_ctl[1], pll->ctl1_base);
> +       writel_relaxed(reg_ctl[2], pll->ctl2_base);
> +       ma35d1_lock_regs(pll);
> +       return 0;
> +}
> +
> +static unsigned long ma35d1_clk_pll_recalc_rate(struct clk_hw *hw,
> +                                               unsigned long parent_rate)
> +{
> +       struct ma35d1_clk_pll *pll =3D to_ma35d1_clk_pll(hw);
> +       u32 reg_ctl[3];
> +       unsigned long pll_freq;
> +
> +       if ((parent_rate < PLL_FREF_MIN_FREQ) || (parent_rate > PLL_FREF_=
MAX_FREQ))

Remove useless parenthesis.

> +               return 0;
> +
> +       switch (pll->type) {
> +       case MA35D1_CAPLL:
> +               reg_ctl[0] =3D readl_relaxed(pll->ctl0_base);
> +               pll_freq =3D ma35d1_calc_smic_pll_freq(reg_ctl[0], parent=
_rate);

return?

> +               break;
> +       case MA35D1_DDRPLL:
> +       case MA35D1_APLL:
> +       case MA35D1_EPLL:
> +       case MA35D1_VPLL:
> +               reg_ctl[0] =3D readl_relaxed(pll->ctl0_base);
> +               reg_ctl[1] =3D readl_relaxed(pll->ctl1_base);
> +               pll_freq =3D ma35d1_calc_pll_freq(pll->mode, reg_ctl, par=
ent_rate);

return?

> +               break;
> +       }
> +       return pll_freq;

return 0?

> +}
> +
> +static long ma35d1_clk_pll_round_rate(struct clk_hw *hw, unsigned long r=
ate,
> +                                     unsigned long *parent_rate)
> +{
> +       struct ma35d1_clk_pll *pll =3D to_ma35d1_clk_pll(hw);
> +       u32 reg_ctl[3] =3D { 0 };
> +       unsigned long pll_freq;
> +       long ret;
> +
> +       if (*parent_rate < PLL_FREF_MIN_FREQ || *parent_rate > PLL_FREF_M=
AX_FREQ)
> +               return -EINVAL;
> +
> +       ret =3D ma35d1_pll_find_closest(pll, rate, *parent_rate, reg_ctl,=
 &pll_freq);
> +       if (ret !=3D 0)
> +               return ret;
> +
> +       switch (pll->type) {
> +       case MA35D1_CAPLL:
> +               reg_ctl[0] =3D readl_relaxed(pll->ctl0_base);
> +               pll_freq =3D ma35d1_calc_smic_pll_freq(reg_ctl[0], *paren=
t_rate);

return?

> +               break;
> +       case MA35D1_DDRPLL:
> +       case MA35D1_APLL:
> +       case MA35D1_EPLL:
> +       case MA35D1_VPLL:
> +               reg_ctl[0] =3D readl_relaxed(pll->ctl0_base);
> +               reg_ctl[1] =3D readl_relaxed(pll->ctl1_base);
> +               pll_freq =3D ma35d1_calc_pll_freq(pll->mode, reg_ctl, *pa=
rent_rate);

return?

> +               break;
> +       }
> +       return pll_freq;

return 0?

> +}
> +
> +static int ma35d1_clk_pll_is_prepared(struct clk_hw *hw)
> +{
> +       struct ma35d1_clk_pll *pll =3D to_ma35d1_clk_pll(hw);
> +       u32 val =3D readl_relaxed(pll->ctl1_base);
> +
> +       return val & PLL_CTL1_PD ? 0 : 1;
> +}
> +
> +static int ma35d1_clk_pll_prepare(struct clk_hw *hw)
> +{
> +       struct ma35d1_clk_pll *pll =3D to_ma35d1_clk_pll(hw);
> +       u32 val;
> +
> +       if ((pll->type =3D=3D MA35D1_CAPLL) || (pll->type =3D=3D MA35D1_D=
DRPLL)) {

Drop useless parenthesis.

> +               pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
> +               return -EACCES;
> +       }
> +
> +       ma35d1_unlock_regs(pll);
> +       val =3D readl_relaxed(pll->ctl1_base);
> +       val &=3D ~PLL_CTL1_PD;
> +       writel_relaxed(val, pll->ctl1_base);
> +       ma35d1_lock_regs(pll);
> +       return 0;
> +}
> +
> +static void ma35d1_clk_pll_unprepare(struct clk_hw *hw)
> +{
> +       struct ma35d1_clk_pll *pll =3D to_ma35d1_clk_pll(hw);
> +       u32 val;
> +
> +       if ((pll->type =3D=3D MA35D1_CAPLL) || (pll->type =3D=3D MA35D1_D=
DRPLL)) {

Drop useless parenthesis.

> +               pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");

These read-only checks should be removed and different clk_ops should be
assigned for the read-only type of clks.

> +       } else {
> +               val =3D readl_relaxed(pll->ctl1_base);
> +               val |=3D PLL_CTL1_PD;
> +               writel_relaxed(val, pll->ctl1_base);
> +       }
> +}
> +
> +static const struct clk_ops ma35d1_clk_pll_ops =3D {
> +       .is_prepared =3D ma35d1_clk_pll_is_prepared,
> +       .prepare =3D ma35d1_clk_pll_prepare,
> +       .unprepare =3D ma35d1_clk_pll_unprepare,
> +       .set_rate =3D ma35d1_clk_pll_set_rate,
> +       .recalc_rate =3D ma35d1_clk_pll_recalc_rate,
> +       .round_rate =3D ma35d1_clk_pll_round_rate,
> +};
> +
> +struct clk_hw *ma35d1_reg_clk_pll(enum ma35d1_pll_type type,

Pass a device here.

> +                                 u8 u8mode, const char *name,
> +                                 const char *parent,
> +                                 unsigned long targetFreq,
> +                                 void __iomem *base,
> +                                 struct regmap *regmap)
> +{
> +       struct ma35d1_clk_pll *pll;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;

init =3D {};

> +       int ret;
> +
> +       pll =3D kmalloc(sizeof(*pll), GFP_KERNEL);

Just use kzalloc(). This isn't a hot path.

> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pll->type =3D type;
> +       pll->mode =3D u8mode;
> +       pll->rate =3D targetFreq;
> +       pll->ctl0_base =3D base + REG_PLL_CTL0_OFFSET;
> +       pll->ctl1_base =3D base + REG_PLL_CTL1_OFFSET;
> +       pll->ctl2_base =3D base + REG_PLL_CTL2_OFFSET;
> +       pll->regmap =3D regmap;
> +
> +       init.name =3D name;
> +       init.flags =3D 0;
> +       init.parent_names =3D &parent;
> +       init.num_parents =3D 1;
> +       init.ops =3D &ma35d1_clk_pll_ops;
> +       pll->hw.init =3D &init;
> +       hw =3D &pll->hw;
> +
> +       ret =3D clk_hw_register(NULL, hw);

Use devm_

> +       if (ret) {
> +               pr_err("failed to register vsi-pll clock!!!\n");

I'm going to put a dev_err_probe() into clk registration code. Remove
this printk.

> +               kfree(pll);
> +               return ERR_PTR(ret);
> +       }
> +       return hw;
> +}
> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-m=
a35d1.c
> new file mode 100644
> index 000000000000..e4d3ced396a3
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
> @@ -0,0 +1,963 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +
> +#include "clk-ma35d1.h"
> +
> +static DEFINE_SPINLOCK(ma35d1_lock);
> +
> +static const char *const ca35clk_sel_clks[] =3D {

Use clk_parent_data instead.

> +       "hxt", "capll", "ddrpll", "dummy"
> +};
> +
[...]
> +
> +static inline struct clk_hw *ma35d1_clk_fixed(const char *name, int rate)
> +{
> +       return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_mux(const char *name,
> +                                           void __iomem *reg,
> +                                           u8 shift, u8 width,
> +                                           const char *const *parents,
> +                                           int num_parents)
> +{
> +       return clk_hw_register_mux(NULL, name, parents, num_parents,
> +                                  CLK_SET_RATE_NO_REPARENT, reg, shift,
> +                                  width, 0, &ma35d1_lock);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_divider(const char *name,
> +                                               const char *parent,
> +                                               void __iomem *reg, u8 shi=
ft,
> +                                               u8 width)
> +{
> +       return clk_hw_register_divider(NULL, name, parent, CLK_SET_RATE_P=
ARENT,
> +                                      reg, shift, width, 0, &ma35d1_lock=
);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_divider_pow2(const char *name,
> +                                                    const char *parent,
> +                                                    void __iomem *reg,
> +                                                    u8 shift, u8 width)
> +{
> +       return clk_hw_register_divider(NULL, name, parent,
> +                                      CLK_DIVIDER_POWER_OF_TWO, reg, shi=
ft,
> +                                      width, 0, &ma35d1_lock);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_divider_table(const char *name,
> +                                       const char *parent,
> +                                       void __iomem *reg,
> +                                       u8 shift, u8 width,
> +                                       const struct clk_div_table *table)
> +{
> +       return clk_hw_register_divider_table(NULL, name, parent, 0,
> +                                            reg, shift, width, 0, table,
> +                                            &ma35d1_lock);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_fixed_factor(const char *name,
> +                                                    const char *parent,
> +                                                    unsigned int mult,
> +                                                    unsigned int div)
> +{
> +       return clk_hw_register_fixed_factor(NULL, name, parent,
> +                                           CLK_SET_RATE_PARENT, mult, di=
v);
> +}
> +
> +static inline struct clk_hw *ma35d1_clk_gate(const char *name,
> +                                            const char *parent,
> +                                            void __iomem *reg, u8 shift)
> +{
> +       return clk_hw_register_gate(NULL, name, parent, CLK_SET_RATE_PARE=
NT,
> +                                   reg, shift, 0, &ma35d1_lock);
> +}

These need to use devm_ to unregister on failure.

> +
> +static int ma35d1_get_pll_setting(struct device_node *clk_node,
> +                                 u32 *pllmode, u32 *pllfreq)
> +{
> +       const char *of_str;
> +       int i;
> +
> +       for (i =3D 0; i < PLL_MAX_NUM; i++) {
> +               if (of_property_read_string_index(clk_node, "nuvoton,pll-=
mode", i, &of_str))
> +                       return -EINVAL;
> +               if (!strcmp(of_str, "integer"))
> +                       pllmode[i] =3D PLL_MODE_INT;
> +               else if (!strcmp(of_str, "fractional"))
> +                       pllmode[i] =3D PLL_MODE_FRAC;
> +               else if (!strcmp(of_str, "spread-spectrum"))
> +                       pllmode[i] =3D PLL_MODE_SS;
> +               else
> +                       return -EINVAL;
> +       }
> +       return of_property_read_u32_array(clk_node, "assigned-clock-rates=
",

The clk framework looks at this property. Why is the driver looking at
it too?

> +                                         pllfreq, PLL_MAX_NUM);
> +}
> +
