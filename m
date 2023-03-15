Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC596BBFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCOWa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjCOWaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B44C65443;
        Wed, 15 Mar 2023 15:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 811C6B81F87;
        Wed, 15 Mar 2023 22:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21477C433D2;
        Wed, 15 Mar 2023 22:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678919411;
        bh=vnw+mEjA4OS2oF9fbVD1tm+YkE80P5Ev5SzgRJD0yVM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mlND77ebyUzGMRQkuFrfqveSnvl9iZNFqgaEkZ7uLYgMO0VWN486/FmVVJcZVysQu
         Zfs6A4CHtoWr8DZyxW2WpYwEgnDfAJji2bisECsGh4nWz58v+ITjVwyAXndfwMpEZ6
         qmFdkzWZ5aDh0iJ/USQz8OmSA2BunJvrKwK0cYVCpXmx0em9MKMwlJhHeKHPijbRNR
         OxBUCHmZhqPQFcagviu0BV9vInkaj8/sXoCZiYix8umVj7oX/D8dqVun3jiRP6t1r3
         0Lf0wXllQVz/Erp/1wySk5C8TZOnVhAJTUJ8g6Ld7dY7FfytFi0NtlB0YqQOf2CSfV
         D1vZvbp3NJIRQ==
Message-ID: <33aa6111d09fa7a75d0e603c3fd3ac11.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230315072902.9298-13-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com> <20230315072902.9298-13-ychuang570808@gmail.com>
Subject: Re: [PATCH 12/15] clk: nuvoton: Add clock driver for ma35d1 clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
To:     Jacky Huang <ychuang570808@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Date:   Wed, 15 Mar 2023 15:30:08 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-03-15 00:28:59)
> diff --git a/drivers/clk/nuvoton/clk-ma35d1-divider.c b/drivers/clk/nuvot=
on/clk-ma35d1-divider.c
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
> +#define div_mask(width)                ((1 << (width)) - 1)

This is clk_div_mask()

> +
> +struct ma35d1_adc_clk_divider {
> +       struct clk_hw hw;
> +       void __iomem *reg;
> +       u8 shift;
> +       u8 width;
> +       u32 mask;
> +       const struct clk_div_table *table;
> +       spinlock_t *lock;
> +};
> +
> +#define to_ma35d1_adc_clk_divider(_hw) \
> +       container_of(_hw, struct ma35d1_adc_clk_divider, hw)
> +
> +static unsigned long ma35d1_clkdiv_recalc_rate(struct clk_hw *hw,
> +                                              unsigned long parent_rate)
> +{
> +       unsigned int val;
> +       struct ma35d1_adc_clk_divider *dclk =3D to_ma35d1_adc_clk_divider=
(hw);
> +
> +       val =3D readl_relaxed(dclk->reg) >> dclk->shift;
> +       val &=3D div_mask(dclk->width);
> +       val +=3D 1;
> +       return divider_recalc_rate(hw, parent_rate, val, dclk->table,
> +                                  CLK_DIVIDER_ROUND_CLOSEST, dclk->width=
);
> +}
> +
> +static long ma35d1_clkdiv_round_rate(struct clk_hw *hw, unsigned long ra=
te,
> +                                    unsigned long *prate)
> +{
> +       struct ma35d1_adc_clk_divider *dclk =3D to_ma35d1_adc_clk_divider=
(hw);
> +
> +       return divider_round_rate(hw, rate, prate, dclk->table,
> +                                 dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
> +}
> +
> +static int ma35d1_clkdiv_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long parent_rate)
> +{
> +       int value;
> +       unsigned long flags =3D 0;
> +       u32 data;
> +       struct ma35d1_adc_clk_divider *dclk =3D to_ma35d1_adc_clk_divider=
(hw);
> +
> +       value =3D divider_get_val(rate, parent_rate, dclk->table,
> +                               dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
> +
> +       if (dclk->lock)
> +               spin_lock_irqsave(dclk->lock, flags);
> +
> +       data =3D readl_relaxed(dclk->reg);
> +       data &=3D ~(div_mask(dclk->width) << dclk->shift);
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
> +                                    unsigned long flags, void __iomem *r=
eg,
> +                                    u8 shift, u8 width, u32 mask_bit)
> +{
> +       struct ma35d1_adc_clk_divider *div;
> +       struct clk_init_data init;
> +       struct clk_div_table *table;
> +       u32 max_div, min_div;
> +       struct clk_hw *hw;
> +       int ret;
> +       int i;
> +
> +       /* allocate the divider */

Please remove useless comment.

> +       div =3D kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /* Init the divider table */

Please remove useless comment.

> +       max_div =3D div_mask(width) + 1;
> +       min_div =3D 1;
> +
> +       table =3D kcalloc(max_div + 1, sizeof(*table), GFP_KERNEL);

Use devm_ allocations please.

> +       if (!table) {
> +               kfree(div);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       for (i =3D 0; i < max_div; i++) {
> +               table[i].val =3D (min_div + i);
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
> +       /* struct ma35d1_adc_clk_divider assignments */

Please remove useless comment.

> +       div->reg =3D reg;
> +       div->shift =3D shift;
> +       div->width =3D width;
> +       div->mask =3D mask_bit ? BIT(mask_bit) : 0;
> +       div->lock =3D &ma35d1_lock;
> +       div->hw.init =3D &init;
> +       div->table =3D table;
> +
> +       /* Register the clock */

Please remove useless comment.

> +       hw =3D &div->hw;
> +       ret =3D clk_hw_register(NULL, hw);

Use devm_clk_hw_register()

> +       if (ret) {
> +               kfree(table);
> +               kfree(div);
> +               return ERR_PTR(ret);
> +       }
> +       return hw;
> +}
> diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c b/drivers/clk/nuvoton/c=
lk-ma35d1-pll.c
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

Do you need to include this header?

> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/bitfield.h>
> +
> +#include "clk-ma35d1.h"
> +
> +#define to_ma35d1_clk_pll(clk) \
> +       (container_of(clk, struct ma35d1_clk_pll, clk))
> +
> +#define PLL0CTL0_FBDIV_MSK     GENMASK(7, 0)
> +#define PLL0CTL0_INDIV_MSK     GENMASK(11, 8)
> +#define PLL0CTL0_OUTDIV_MSK    GENMASK(13, 12)
> +#define PLL0CTL0_PD_MSK                BIT(16)
> +#define PLL0CTL0_BP_MSK                BIT(17)
> +#define PLLXCTL0_FBDIV_MSK     GENMASK(10, 0)
> +#define PLLXCTL0_INDIV_MSK     GENMASK(17, 12)
> +#define PLLXCTL0_MODE_MSK      GENMASK(19, 18)
> +#define PLLXCTL0_SSRATE_MSK    GENMASK(30, 20)
> +#define PLLXCTL1_PD_MSK                BIT(0)
> +#define PLLXCTL1_BP_MSK                BIT(1)
> +#define PLLXCTL1_OUTDIV_MSK    GENMASK(6, 4)
> +#define PLLXCTL1_FRAC_MSK      GENMASK(31, 8)
> +#define PLLXCTL2_SLOPE_MSK     GENMASK(23, 0)
> +
> +struct ma35d1_clk_pll {
> +       struct clk_hw hw;
> +       u8 type;
> +       u8 mode;
> +       unsigned long rate;
> +       void __iomem *ctl0_base;
> +       void __iomem *ctl1_base;
> +       void __iomem *ctl2_base;
> +       struct regmap *regmap;
> +};
> +
> +struct vsipll_freq_conf_reg_tbl {
> +       unsigned long freq;
> +       u8 mode;
> +       u32 ctl0_reg;
> +       u32 ctl1_reg;
> +       u32 ctl2_reg;
> +};
> +
> +static const struct vsipll_freq_conf_reg_tbl ma35d1pll_freq[] =3D {
> +       { 1000000000, VSIPLL_INTEGER_MODE, 0x307d, 0x10, 0 },
> +       { 884736000, VSIPLL_FRACTIONAL_MODE, 0x41024, 0xdd2f1b11, 0 },
> +       { 533000000, VSIPLL_SS_MODE, 0x12b8102c, 0x6aaaab20, 0x12317 },
> +       { }
> +};
> +
> +static void CLK_UnLockReg(struct ma35d1_clk_pll *pll)

Please don't use a mix of upper and lower case function names.
Everything should be lower case. Maybe the name should be

	ma35d1_clk_pll_unlock_reg()

> +{
> +       int ret;
> +
> +       /* Unlock PLL registers */
> +       do {
> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x59);
> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x16);
> +               regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x88);
> +               regmap_read(pll->regmap, REG_SYS_RLKTZNS, &ret);
> +       } while (ret =3D=3D 0);
> +}
> +
> +static void CLK_LockReg(struct ma35d1_clk_pll *pll)
> +{

	ma35d1_clk_pll_lock_reg()

> +       /* Lock PLL registers */

Remove these worthless comments.

> +       regmap_write(pll->regmap, REG_SYS_RLKTZNS, 0x0);
> +}
> +
> +/* SMIC PLL for CAPLL */
> +unsigned long CLK_GetPLLFreq_SMICPLL(struct ma35d1_clk_pll *pll,
> +                                    unsigned long PllSrcClk)
> +{
> +       u32 u32M, u32N, u32P, u32OutDiv;

Variable names should not have the type in them. 'm', 'n', 'p', 'div'
should suffice.

> +       u32 val;
> +       unsigned long u64PllClk;
> +       u32 clk_div_table[] =3D { 1, 2, 4, 8};
> +
> +       val =3D __raw_readl(pll->ctl0_base);

Why do you need to use __raw_readl()? Just use readl() here.

> +
> +       u32N =3D FIELD_GET(PLL0CTL0_FBDIV_MSK, val);
> +       u32M =3D FIELD_GET(PLL0CTL0_INDIV_MSK, val);
> +       u32P =3D FIELD_GET(PLL0CTL0_OUTDIV_MSK, val);
> +       u32OutDiv =3D clk_div_table[u32P];
> +
> +       if (val & PLL0CTL0_BP_MSK) {
> +               u64PllClk =3D PllSrcClk;
> +       } else {
> +               u64PllClk =3D PllSrcClk * u32N;
> +               do_div(u64PllClk, u32M * u32OutDiv);
> +       }

Add a newline here.

> +       return u64PllClk;
> +}
> +
> +/* VSI-PLL: INTEGER_MODE */

I have no idea what this means.

> +unsigned long CLK_CalPLLFreq_Mode0(unsigned long PllSrcClk,
> +                                  unsigned long u64PllFreq, u32 *u32Reg)

Again, don't put types into the variable name.

> +{
> +       u32 u32TmpM, u32TmpN, u32TmpP;
> +       u32 u32RngMinN, u32RngMinM, u32RngMinP;
> +       u32 u32RngMaxN, u32RngMaxM, u32RngMaxP;
> +       u32 u32Tmp, u32Min, u32MinN, u32MinM, u32MinP;
> +       unsigned long u64PllClk;
> +       unsigned long u64Con1, u64Con2, u64Con3;

My eyes! Seriously, kernel style is not this way. Did checkpatch.pl pass
on this?

> +
> +       u64PllClk =3D 0;
> +       u32Min =3D (u32) -1;
> +
> +       if (!((u64PllFreq >=3D VSIPLL_FCLKO_MIN_FREQ) &&
> +           (u64PllFreq <=3D VSIPLL_FCLKO_MAX_FREQ))) {
> +               u32Reg[0] =3D ma35d1pll_freq[0].ctl0_reg;
> +               u32Reg[1] =3D ma35d1pll_freq[0].ctl1_reg;
> +               u64PllClk =3D ma35d1pll_freq[0].freq;
> +               return u64PllClk;
> +       }
> +
> +       u32RngMinM =3D 1UL;
> +       u32RngMaxM =3D 63UL;
> +       u32RngMinM =3D ((PllSrcClk / VSIPLL_FREFDIVM_MAX_FREQ) > 1) ?
> +                    (PllSrcClk / VSIPLL_FREFDIVM_MAX_FREQ) : 1;
> +       u32RngMaxM =3D ((PllSrcClk / VSIPLL_FREFDIVM_MIN_FREQ0) < u32RngM=
axM) ?
> +                    (PllSrcClk / VSIPLL_FREFDIVM_MIN_FREQ0) : u32RngMaxM;
> +
> +       for (u32TmpM =3D u32RngMinM; u32TmpM < (u32RngMaxM + 1); u32TmpM+=
+) {
> +               u64Con1 =3D PllSrcClk / u32TmpM;
> +               u32RngMinN =3D 16UL;
> +               u32RngMaxN =3D 2047UL;
> +               u32RngMinN =3D ((VSIPLL_FCLK_MIN_FREQ / u64Con1) > u32Rng=
MinN) ?
> +                            (VSIPLL_FCLK_MIN_FREQ / u64Con1) : u32RngMin=
N;
> +               u32RngMaxN =3D ((VSIPLL_FCLK_MAX_FREQ / u64Con1) < u32Rng=
MaxN) ?
> +                            (VSIPLL_FCLK_MAX_FREQ / u64Con1) : u32RngMax=
N;

Is this clamp()?

> +
> +               for (u32TmpN =3D u32RngMinN; u32TmpN < (u32RngMaxN + 1);
> +                    u32TmpN++) {
> +                       u64Con2 =3D u64Con1 * u32TmpN;
> +                       u32RngMinP =3D 1UL;
> +                       u32RngMaxP =3D 7UL;
> +                       u32RngMinP =3D ((u64Con2 / VSIPLL_FCLKO_MAX_FREQ)=
 > 1) ?
> +                                     (u64Con2 / VSIPLL_FCLKO_MAX_FREQ) :=
 1;

Is this clamp()?

> +                       u32RngMaxP =3D ((u64Con2 / VSIPLL_FCLKO_MIN_FREQ)=
 <
> +                                     u32RngMaxP) ?
> +                                     (u64Con2 / VSIPLL_FCLKO_MIN_FREQ) :
> +                                     u32RngMaxP;
> +                       for (u32TmpP =3D u32RngMinP; u32TmpP < (u32RngMax=
P + 1);
> +                            u32TmpP++) {
> +                               u64Con3 =3D u64Con2 / u32TmpP;
> +                               if (u64Con3 > u64PllFreq)
> +                                       u32Tmp =3D u64Con3 - u64PllFreq;
> +                               else
> +                                       u32Tmp =3D u64PllFreq - u64Con3;
> +
> +                               if (u32Tmp < u32Min) {
> +                                       u32Min =3D u32Tmp;
> +                                       u32MinM =3D u32TmpM;
> +                                       u32MinN =3D u32TmpN;
> +                                       u32MinP =3D u32TmpP;
> +
> +                                       if (u32Min =3D=3D 0UL) {
> +                                               u32Reg[0] =3D (u32MinM <<=
 12) |
> +                                                           (u32MinN);
> +                                               u32Reg[1] =3D (u32MinP <<=
 4);
> +                                               return ((PllSrcClk * u32M=
inN) /
> +                                                       (u32MinP * u32Min=
M));
> +                                       }
> +                               }
> +                       }
> +               }
> +       }

It's too hard to read this code.=20

> +
> +       u32Reg[0] =3D (u32MinM << 12) | (u32MinN);

FIELD_PREP?

> +       u32Reg[1] =3D (u32MinP << 4);

ditto?

> +       u64PllClk =3D (PllSrcClk * u32MinN) / (u32MinP * u32MinM);
> +       return u64PllClk;
> +}
> +
> +/* VSI-PLL: FRACTIONAL_MODE */
> +unsigned long CLK_CalPLLFreq_Mode1(unsigned long PllSrcClk,
> +                                  unsigned long u64PllFreq, u32 *u32Reg)
> +{
> +       unsigned long u64X, u64N, u64M, u64P, u64tmp;
> +       unsigned long u64PllClk, u64FCLKO;
> +       u32 u32FRAC;
> +
> +       if (u64PllFreq > VSIPLL_FCLKO_MAX_FREQ) {
> +               u32Reg[0] =3D ma35d1pll_freq[1].ctl0_reg;
> +               u32Reg[1] =3D ma35d1pll_freq[1].ctl1_reg;
> +               u64PllClk =3D ma35d1pll_freq[1].freq;
> +               return u64PllClk;
> +       }
> +
> +       if (u64PllFreq > (VSIPLL_FCLKO_MIN_FREQ/(100-1))) {

Use a local variable for the right hand side of the comparison.

> +               u64FCLKO =3D u64PllFreq * ((VSIPLL_FCLKO_MIN_FREQ / u64Pl=
lFreq) +
> +                          ((VSIPLL_FCLKO_MIN_FREQ % u64PllFreq) ? 1 : 0)=
);

Is this DIV_ROUND_UP() or something like that?

> +       } else {
> +               pr_err("Failed to set rate %ld\n", u64PllFreq);
> +               return 0;
> +       }
> +
> +       u64P =3D (u64FCLKO >=3D VSIPLL_FCLK_MIN_FREQ) ? 1 :
> +              ((VSIPLL_FCLK_MIN_FREQ / u64FCLKO) +
> +               ((VSIPLL_FCLK_MIN_FREQ % u64FCLKO) ? 1 : 0));
> +
> +       if ((PllSrcClk > (VSIPLL_FREFDIVM_MAX_FREQ * (64-1))) ||
> +           (PllSrcClk < VSIPLL_FREFDIVM_MIN_FREQ1))
> +               return 0;
> +
[...]
> +               break;
> +       }
> +
> +       return pllfreq;
> +}
> +
> +static long ma35d1_clk_pll_round_rate(struct clk_hw *hw, unsigned long r=
ate,
> +                                     unsigned long *prate)
> +{
> +       return rate;

This needs to do actual math and figure out that some rate will not
work and calculate what the rate will actually be if clk_set_rate() is
called with 'rate'.

> +}
> +
> +static int ma35d1_clk_pll_is_prepared(struct clk_hw *hw)
> +{
> +       struct ma35d1_clk_pll *pll =3D to_ma35d1_clk_pll(hw);
> +       u32 val =3D __raw_readl(pll->ctl1_base);
> +
> +       return (val & VSIPLLCTL1_PD_MSK) ? 0 : 1;
> +}
> +
> +static int ma35d1_clk_pll_prepare(struct clk_hw *hw)
> +{
> +       struct ma35d1_clk_pll *pll =3D to_ma35d1_clk_pll(hw);
> +       u32 val;
> +
> +       if ((pll->type =3D=3D MA35D1_CAPLL) || (pll->type =3D=3D MA35D1_D=
DRPLL)) {
> +               pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
> +               return -EACCES;
> +       }
> +
> +       CLK_UnLockReg(pll);
> +       val =3D __raw_readl(pll->ctl1_base);
> +       val &=3D ~VSIPLLCTL1_PD_MSK;
> +       __raw_writel(val, pll->ctl1_base);
> +       CLK_LockReg(pll);
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
> +               pr_warn("Nuvoton MA35D1 CAPLL/DDRPLL is read only.\n");
> +       } else {
> +               val =3D __raw_readl(pll->ctl1_base);
> +               val |=3D VSIPLLCTL1_PD_MSK;
> +               __raw_writel(val, pll->ctl1_base);
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
> +                                 u8 u8mode, const char *name,
> +                                 const char *parent,
> +                                 unsigned long targetFreq,
> +                                 void __iomem *base,
> +                                 struct regmap *regmap)
> +{
> +       struct ma35d1_clk_pll *pll;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       pll =3D kmalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pll->type =3D type;
> +       pll->mode =3D u8mode;
> +       pll->rate =3D targetFreq;
> +       pll->ctl0_base =3D base + VSIPLL_CTL0;
> +       pll->ctl1_base =3D base + VSIPLL_CTL1;
> +       pll->ctl2_base =3D base + VSIPLL_CTL2;
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
> +       if (ret) {
> +               pr_err("failed to register vsi-pll clock!!!\n");
> +               kfree(pll);
> +               return ERR_PTR(ret);
> +       }
> +       return hw;
> +}
> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-m=
a35d1.c
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

I don't see any clk consumer usage. Please remove.

> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

I don't see any clkdev usage. Please remove.

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

Why not static?

> +
> +static const char *const ca35clk_sel_clks[] =3D {
> +       "hxt", "capll", "ddrpll", "dummy"

Are these parent mappings? Please use 'struct clk_parent_data' instead
if so.

> +};
> +
> +static const char *const sysclk0_sel_clks[] =3D {
> +       "epll_div2", "syspll"
> +};
> +
[...]
> +
> +static struct clk_hw **hws;
> +static struct clk_hw_onecell_data *ma35d1_hw_data;

Any reason to make these global pointers vs local pointers during probe?

> +
> +static int ma35d1_clocks_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *clk_node =3D dev->of_node;
> +       void __iomem *clk_base;
> +       struct regmap *regmap;
> +       u32 pllmode[5] =3D { 0, 0, 0, 0, 0 };
> +       u32 pllfreq[5] =3D { 0, 0, 0, 0, 0 };
> +
> +       dev_info(&pdev->dev, "Nuvoton MA35D1 Clock Driver\n");

Drop this banner message please.

> +       ma35d1_hw_data =3D devm_kzalloc(&pdev->dev, struct_size(ma35d1_hw=
_data,
> +                                     hws, CLK_MAX_IDX), GFP_KERNEL);
> +
> +       if (WARN_ON(!ma35d1_hw_data))
> +               return -ENOMEM;
> +
> +       ma35d1_hw_data->num =3D CLK_MAX_IDX;
> +       hws =3D ma35d1_hw_data->hws;
> +
> +       clk_node =3D of_find_compatible_node(NULL, NULL, "nuvoton,ma35d1-=
clk");
> +       clk_base =3D of_iomap(clk_node, 0);

Use platform_device APIs as you have a platform device here ('pdev').

> +       of_node_put(clk_node);
> +       if (!clk_base) {
> +               pr_err("%s: could not map region\n", __func__);
> +               return -ENOMEM;
> +       }
> +       regmap =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +                                                "nuvoton,sys");

Why is it a syscon?

> +       if (IS_ERR(regmap))
> +               pr_warn("%s: Unable to get syscon\n", __func__);

How can we continue without the regmap?

> +
> +       /* clock sources */
> +       hws[HXT] =3D ma35d1_clk_fixed("hxt", 24000000);
[...]
> +       /* EADC */
> +       hws[EADC_DIV] =3D ma35d1_clk_divider_table("eadc_div", "pclk2",
> +                                                clk_base + REG_CLK_CLKDI=
V4,
> +                                                0, 4, eadc_div_table);
> +       hws[EADC_GATE] =3D ma35d1_clk_gate("eadc_gate", "eadc_div",
> +                                        clk_base + REG_CLK_APBCLK2, 25);
> +
> +       ret =3D of_clk_add_hw_provider(clk_node, of_clk_hw_onecell_get,

Use devm_ variant.

> +                                    ma35d1_hw_data);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to register hws for MA35D1\n");
> +               iounmap(clk_base);

Use devm mapping APIs to avoid unmapping on error path.

> +       }
> +       return ret;
> +}
> +
> +static const struct of_device_id ma35d1_clk_of_match[] =3D {
> +       { .compatible =3D "nuvoton,ma35d1-clk" },
> +       { },

Drop comma above so nothing can come after this.

> +};
> +MODULE_DEVICE_TABLE(of, ma35d1_clk_of_match);
> +
> +static struct platform_driver ma35d1_clk_driver =3D {
> +       .probe =3D ma35d1_clocks_probe,
> +       .driver =3D {
> +               .name =3D "ma35d1-clk",
> +               .of_match_table =3D ma35d1_clk_of_match,
> +       },
> +};
> +
> +static int __init ma35d1_clocks_init(void)
> +{
> +       return platform_driver_register(&ma35d1_clk_driver);
> +}
> +
> +postcore_initcall(ma35d1_clocks_init);
> +
> +MODULE_AUTHOR("Chi-Fang Li<cfli0@nuvoton.com>");
> +MODULE_DESCRIPTION("NUVOTON MA35D1 Clock Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/nuvoton/clk-ma35d1.h b/drivers/clk/nuvoton/clk-m=
a35d1.h
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

Are these includes used?

> +#include <linux/clk-provider.h>
> +#include <linux/spinlock.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/ma35d1-sys.h>

These probably aren't needed to be included here. Just forward declare
structs you need and include the headers in the C file.

> +
[...]
> +
> +struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev,
> +                                   const char *name,
> +                                   const char *parent_name,
> +                                   unsigned long flags,
> +                                   void __iomem *reg, u8 shift,
> +                                   u8 width, u32 mask_bit);
> +
> +extern spinlock_t ma35d1_lock;

Why?
