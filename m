Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B43D6E14AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDMSzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjDMSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BDC4200;
        Thu, 13 Apr 2023 11:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 726FA640F9;
        Thu, 13 Apr 2023 18:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81522C433D2;
        Thu, 13 Apr 2023 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681412132;
        bh=5KFNFdBIW2BvW60iizymJtZDW3ElqffE4eMRAKWlN0w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=n7j4X7z7/w6hG3RTaCyYq1pNHJfwCoJ8w1/eLyoZ2Qf8Yt8OXChaykHHDdCmsz3zt
         pioBPIS3kp2Q+GD1Z5JNFUTvFlW4gkrXxxtgdFv1MZaY5vLxrAmB0pn0VQX8UEOl5p
         Hf3qAbHY1W2jd+vbnhIFFbCGtC7V4V0HlAIv1FW1IDNwm8QjBQI7ow3ZkpQSMAAdGq
         TOcmXoNOpHn88qHuaTfVKozHsVmRDIG8jrYctOe1QC7GISmMcNyyUt+OJQdqBvms68
         w8O0I1HXgHInU6ZiSrGqu4Yb5tIQE22F25RfsQu8TGq8kvnYK9BbjPnZTTE7jpfaQ8
         e/fFJBZt43xFA==
Message-ID: <2d848bc03aacb41a708ba2794eb043ff.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230321050034.1431379-3-sergio.paracuellos@gmail.com>
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com> <20230321050034.1431379-3-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH v2 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 13 Apr 2023 11:55:30 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2023-03-20 22:00:27)
> diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtm=
ips.c
> new file mode 100644
> index 000000000000..6b4b5ae9384d
> --- /dev/null
> +++ b/drivers/clk/ralink/clk-mtmips.c
> @@ -0,0 +1,985 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MTMIPS SoCs Clock Driver
> + * Author: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>

Drop unused include.

> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +
[..]
> +
> +/*
> + * There are drivers for these SoCs that are older than clock driver
> + * and are not prepared for the clock. We don't want the kernel to
> + * disable anything so we add CLK_IS_CRITICAL flag here.
> + */
> +#define CLK_PERIPH(_name, _parent) {                           \
> +       .init =3D &(struct clk_init_data) {                       \

const?

> +               .name =3D _name,                                  \
> +               .ops =3D &(const struct clk_ops) {                \

Make this into a named variable? Otherwise I suspect the compiler will
want to duplicate it.

> +                       .recalc_rate =3D mtmips_pherip_clk_rate   \
> +               },                                              \
> +               .parent_data =3D &(const struct clk_parent_data) {\
> +                       .name =3D _parent,                        \
> +                       .fw_name =3D _parent                      \
> +               },                                              \
> +               .num_parents =3D 1,                               \
> +               .flags =3D CLK_SET_RATE_PARENT | CLK_IS_CRITICAL  \

Why is everything critical? Put the comment here instead of above the
macro

> +       },                                                      \
> +}
> +
[...]
> +
> +static int mtmips_register_pherip_clocks(struct device_node *np,
> +                                        struct clk_hw_onecell_data *clk_=
data,
> +                                        struct mtmips_clk_priv *priv)
> +{
> +       struct clk_hw **hws =3D clk_data->hws;
> +       struct mtmips_clk *sclk;
> +       int ret, i;
> +
> +       for (i =3D 0; i < priv->data->num_clk_periph; i++) {
> +               int idx =3D (priv->data->num_clk_base - 1) + i;
> +
> +               sclk =3D &priv->data->clk_periph[i];
> +               ret =3D of_clk_hw_register(np, &sclk->hw);
> +               if (ret) {
> +                       pr_err("Couldn't register peripheral clock %d\n",=
 idx);
> +                       goto err_clk_unreg;
> +               }
> +
> +               hws[idx] =3D &sclk->hw;
> +       }
> +
> +       return 0;
> +
> +err_clk_unreg:
> +       while (--i >=3D 0) {
> +               sclk =3D &priv->data->clk_periph[i];
> +               clk_hw_unregister(&sclk->hw);
> +       }
> +       return ret;
> +}
> +
> +static inline struct mtmips_clk *to_mtmips_clk(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct mtmips_clk, hw);
> +}
> +
> +static unsigned long rt5350_xtal_recalc_rate(struct clk_hw *hw,
> +                                            unsigned long parent_rate)
> +{
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       u32 val;
> +
> +       regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &val);
> +       if (!(val & RT5350_CLKCFG0_XTAL_SEL))
> +               return 20000000;
> +
> +       return 40000000;
> +}
> +
> +static unsigned long rt5350_cpu_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long xtal_clk)
> +{
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       u32 t;
> +
> +       regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
> +       t =3D (t >> RT5350_SYSCFG0_CPUCLK_SHIFT) & RT5350_SYSCFG0_CPUCLK_=
MASK;
> +
> +       switch (t) {
> +       case RT5350_SYSCFG0_CPUCLK_360:
> +               return 360000000;
> +       case RT5350_SYSCFG0_CPUCLK_320:
> +               return 320000000;
> +       case RT5350_SYSCFG0_CPUCLK_300:
> +               return 300000000;
> +       default:
> +               BUG();
> +       }
> +}
> +
> +static unsigned long rt5350_bus_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       if (parent_rate =3D=3D 320000000)
> +               return parent_rate / 4;
> +
> +       return parent_rate / 3;
> +}
> +
> +static unsigned long rt3352_cpu_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long xtal_clk)
> +{
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       u32 t;
> +
> +       regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
> +       t =3D (t >> RT3352_SYSCFG0_CPUCLK_SHIFT) & RT3352_SYSCFG0_CPUCLK_=
MASK;
> +
> +       switch (t) {
> +       case RT3352_SYSCFG0_CPUCLK_LOW:
> +               return 384000000;
> +       case RT3352_SYSCFG0_CPUCLK_HIGH:
> +               return 400000000;
> +       default:
> +               BUG();
> +       }
> +}
> +
> +static unsigned long rt3352_periph_recalc_rate(struct clk_hw *hw,
> +                                              unsigned long parent_rate)
> +{
> +       return 40000000;
> +}
> +
> +static unsigned long rt3352_bus_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       return parent_rate / 3;
> +}
> +
> +static unsigned long rt305x_xtal_recalc_rate(struct clk_hw *hw,
> +                                            unsigned long parent_rate)
> +{
> +       return 40000000;
> +}

Register fixed factor and fixed rate clks in software instead of
duplicating the code here.

> +
> +static unsigned long rt305x_cpu_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long xtal_clk)
> +{
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       u32 t;
> +
> +       regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
> +       t =3D (t >> RT305X_SYSCFG_CPUCLK_SHIFT) & RT305X_SYSCFG_CPUCLK_MA=
SK;
> +
> +       switch (t) {
> +       case RT305X_SYSCFG_CPUCLK_LOW:
> +               return 320000000;
> +       case RT305X_SYSCFG_CPUCLK_HIGH:
> +               return 384000000;
> +       default:
> +               BUG();
> +       }
> +}
> +
> +static unsigned long rt3883_cpu_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long xtal_clk)
> +{
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       u32 t;
> +
> +       regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
> +       t =3D (t >> RT3883_SYSCFG0_CPUCLK_SHIFT) & RT3883_SYSCFG0_CPUCLK_=
MASK;
> +
> +       switch (t) {
> +       case RT3883_SYSCFG0_CPUCLK_250:
> +               return 250000000;
> +       case RT3883_SYSCFG0_CPUCLK_384:
> +               return 384000000;
> +       case RT3883_SYSCFG0_CPUCLK_480:
> +               return 480000000;
> +       case RT3883_SYSCFG0_CPUCLK_500:
> +               return 500000000;
> +       default:
> +               BUG();
> +       }
> +}
> +
> +static unsigned long rt3883_bus_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       u32 ddr2;
> +       u32 t;
> +
> +       regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
> +       ddr2 =3D t & RT3883_SYSCFG0_DRAM_TYPE_DDR2;
> +
> +       switch (parent_rate) {
> +       case 250000000:
> +               return (ddr2) ? 125000000 : 83000000;
> +       case 384000000:
> +               return (ddr2) ? 128000000 : 96000000;
> +       case 480000000:
> +               return (ddr2) ? 160000000 : 120000000;
> +       case 500000000:
> +               return (ddr2) ? 166000000 : 125000000;
> +       default:
> +               BUG();

Why? Depending on clk registration order 'parent_rate' could be 0, and
then this will crash the system.

> +       }
> +}
> +
> +static unsigned long rt2880_cpu_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long xtal_clk)
> +{
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       u32 t;
> +
> +       regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
> +       t =3D (t >> RT2880_CONFIG_CPUCLK_SHIFT) & RT2880_CONFIG_CPUCLK_MA=
SK;
> +
> +       switch (t) {
> +       case RT2880_CONFIG_CPUCLK_250:
> +               return 250000000;
> +       case RT2880_CONFIG_CPUCLK_266:
> +               return 266000000;
> +       case RT2880_CONFIG_CPUCLK_280:
> +               return 280000000;
> +       case RT2880_CONFIG_CPUCLK_300:
> +               return 300000000;
> +       default:
> +               BUG();
> +       }
> +}
> +
> +static unsigned long rt2880_bus_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       return parent_rate / 2;
> +}

A fixed factor clk?

> +
> +static u32 mt7620_calc_rate(u32 ref_rate, u32 mul, u32 div)
> +{
> +       u64 t;
> +
> +       t =3D ref_rate;
> +       t *=3D mul;
> +       do_div(t, div);

Do we really need to do 64-bit math? At the least use div_u64().

> +
> +       return t;
> +}
> +
> +static unsigned long mt7620_pll_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       static const u32 clk_divider[] =3D { 2, 3, 4, 8 };
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       unsigned long cpu_pll;
> +       u32 t;
> +       u32 mul;
> +       u32 div;
> +
> +       regmap_read(sysc, SYSC_REG_CPLL_CONFIG0, &t);
> +       if (t & CPLL_CFG0_BYPASS_REF_CLK) {
> +               cpu_pll =3D parent_rate;
> +       } else if ((t & CPLL_CFG0_SW_CFG) =3D=3D 0) {
> +               cpu_pll =3D 600000000;
> +       } else {
> +               mul =3D (t >> CPLL_CFG0_PLL_MULT_RATIO_SHIFT) &
> +                       CPLL_CFG0_PLL_MULT_RATIO_MASK;
> +               mul +=3D 24;
> +               if (t & CPLL_CFG0_LC_CURFCK)
> +                       mul *=3D 2;
> +
> +               div =3D (t >> CPLL_CFG0_PLL_DIV_RATIO_SHIFT) &
> +                       CPLL_CFG0_PLL_DIV_RATIO_MASK;
> +
> +               WARN_ON(div >=3D ARRAY_SIZE(clk_divider));

WARN_ON_ONCE() so that this doesn't spam the system.

> +
> +               cpu_pll =3D mt7620_calc_rate(parent_rate, mul, clk_divide=
r[div]);
> +       }
> +
> +       regmap_read(sysc, SYSC_REG_CPLL_CONFIG1, &t);
> +       if (t & CPLL_CFG1_CPU_AUX1)
> +               return parent_rate;
> +
> +       if (t & CPLL_CFG1_CPU_AUX0)
> +               return 480000000;
> +
> +       return cpu_pll;
> +}
> +
> +static unsigned long mt7620_cpu_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       u32 t;
> +       u32 mul;
> +       u32 div;
> +
> +       regmap_read(sysc, SYSC_REG_CPU_SYS_CLKCFG, &t);
> +       mul =3D t & CPU_SYS_CLKCFG_CPU_FFRAC_MASK;
> +       div =3D (t >> CPU_SYS_CLKCFG_CPU_FDIV_SHIFT) &
> +               CPU_SYS_CLKCFG_CPU_FDIV_MASK;
> +
> +       return mt7620_calc_rate(parent_rate, mul, div);
> +}
> +
> +static unsigned long mt7620_bus_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       static const u32 ocp_dividers[16] =3D {
> +               [CPU_SYS_CLKCFG_OCP_RATIO_2] =3D 2,
> +               [CPU_SYS_CLKCFG_OCP_RATIO_3] =3D 3,
> +               [CPU_SYS_CLKCFG_OCP_RATIO_4] =3D 4,
> +               [CPU_SYS_CLKCFG_OCP_RATIO_5] =3D 5,
> +               [CPU_SYS_CLKCFG_OCP_RATIO_10] =3D 10,
> +       };
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       u32 t;
> +       u32 ocp_ratio;
> +       u32 div;
> +
> +       if (IS_ENABLED(CONFIG_USB)) {
> +               /*
> +               * When the CPU goes into sleep mode, the BUS
> +               * clock will be too low for USB to function properly.
> +               * Adjust the busses fractional divider to fix this
> +               */
> +               regmap_read(sysc, SYSC_REG_CPU_SYS_CLKCFG, &t);
> +               t &=3D ~(CLKCFG_FDIV_MASK | CLKCFG_FFRAC_MASK);
> +               t |=3D CLKCFG_FDIV_USB_VAL | CLKCFG_FFRAC_USB_VAL;
> +               regmap_write(sysc, SYSC_REG_CPU_SYS_CLKCFG, t);

Why can't we do this unconditionally? And recalc_rate() shouldn't be
writing registers. It should be calculating the frequency of the clk
based on 'parent_rate' and whatever the hardware is configured for.

> +       }
> +
> +       regmap_read(sysc, SYSC_REG_CPU_SYS_CLKCFG, &t);
> +       ocp_ratio =3D (t >> CPU_SYS_CLKCFG_OCP_RATIO_SHIFT) &
> +               CPU_SYS_CLKCFG_OCP_RATIO_MASK;
> +
> +       if (WARN_ON(ocp_ratio >=3D ARRAY_SIZE(ocp_dividers)))
> +               return parent_rate;
> +
> +       div =3D ocp_dividers[ocp_ratio];
> +       if (WARN(!div, "invalid divider for OCP ratio %u", ocp_ratio))

Missing newline.

> +               return parent_rate;
> +
> +       return parent_rate / div;
> +}
> +
> +static unsigned long mt7620_periph_recalc_rate(struct clk_hw *hw,
> +                                              unsigned long parent_rate)
> +{
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       u32 t;
> +
> +       regmap_read(sysc, SYSC_REG_CLKCFG0, &t);
> +       if (t & CLKCFG0_PERI_CLK_SEL)
> +               return parent_rate;
> +
> +       return 40000000;
> +}
> +
> +static unsigned long mt76x8_xtal_recalc_rate(struct clk_hw *hw,
> +                                            unsigned long parent_rate)
> +{
> +       struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> +       struct regmap *sysc =3D clk->priv->sysc;
> +       u32 t;
> +
> +       regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
> +       if (t & MT7620_XTAL_FREQ_SEL)
> +               return 40000000;
> +
> +       return 20000000;
> +}
> +
> +static unsigned long mt76x8_cpu_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long xtal_clk)
> +{
> +       if (xtal_clk =3D=3D 40000000)
> +               return 580000000;
> +
> +       return 575000000;
> +}
> +
> +static unsigned long mt76x8_pcmi2s_recalc_rate(struct clk_hw *hw,
> +                                              unsigned long xtal_clk)
> +{
> +       return 480000000;
> +}

Use fixed rate clk.

> +
> +#define CLK_BASE(_name, _parent, _recalc) {                            \
> +       .init =3D &(struct clk_init_data) {                              =
 \

const

> +               .name =3D _name,                                         =
 \
> +               .ops =3D &(const struct clk_ops) {                       =
 \
> +                       .recalc_rate =3D _recalc,                        =
 \
> +               },                                                      \
> +               .parent_data =3D &(const struct clk_parent_data) {       =
 \
> +                       .name =3D _parent,                               =
 \
> +                       .fw_name =3D _parent                             =
 \
> +               },                                                      \
> +               .num_parents =3D _parent ? 1 : 0                         =
 \
> +       },                                                              \
> +}
> +
[...]
> +
> +static void __init mtmips_clk_init(struct device_node *node)
> +{
> +       const struct of_device_id *match;
> +       const struct mtmips_clk_data *data;
> +       struct mtmips_clk_priv *priv;
> +       struct clk_hw_onecell_data *clk_data;
> +       int ret, i, count;
> +
> +       if (!of_find_property(node, "#clock-cells", NULL)) {
> +               pr_err("No '#clock-cells' property found\n");

We don't need to validate the bindings in the driver.

> +               return;
> +       }
> +
> +       priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return;
> +
> +       priv->sysc =3D syscon_node_to_regmap(node);
> +       if (IS_ERR(priv->sysc)) {
> +               pr_err("Could not get sysc syscon regmap\n");
> +               goto free_clk_priv;
> +       }
> +
> +       match =3D of_match_node(mtmips_of_match, node);
> +       if (WARN_ON(!match))
> +               return;
> +
> +       data =3D match->data;
> +       priv->data =3D data;
> +       count =3D priv->data->num_clk_base + priv->data->num_clk_periph;
> +       clk_data =3D kzalloc(struct_size(clk_data, hws, count), GFP_KERNE=
L);
> +       if (!clk_data)
> +               goto free_clk_priv;
> +
> +       ret =3D mtmips_register_clocks(node, clk_data, priv);
> +       if (ret) {
> +               pr_err("Couldn't register top clocks\n");
> +               goto free_clk_data;
> +       }
> +
> +       ret =3D mtmips_register_pherip_clocks(node, clk_data, priv);
> +       if (ret) {
> +               pr_err("Couldn't register peripheral clocks\n");
> +               goto unreg_clk_top;
> +       }
> +
> +       clk_data->num =3D count;
> +
> +       ret =3D of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_d=
ata);
> +       if (ret) {
> +               pr_err("Couldn't add clk hw provider\n");
> +               goto unreg_clk_periph;
> +       }
> +
> +       return;
> +
> +unreg_clk_periph:
> +       for (i =3D 0; i < priv->data->num_clk_periph; i++) {
> +               struct mtmips_clk *sclk =3D &priv->data->clk_periph[i];
> +
> +               clk_hw_unregister(&sclk->hw);
> +       }
> +
> +unreg_clk_top:
> +       for (i =3D 0; i < priv->data->num_clk_base; i++) {
> +               struct mtmips_clk *sclk =3D &priv->data->clk_base[i];
> +
> +               clk_hw_unregister(&sclk->hw);
> +       }
> +
> +free_clk_data:
> +       kfree(clk_data);
> +
> +free_clk_priv:
> +       kfree(priv);
> +}
> +CLK_OF_DECLARE_DRIVER(rt2880_clk, "ralink,rt2880-sysc", mtmips_clk_init);
> +CLK_OF_DECLARE_DRIVER(rt3050_clk, "ralink,rt3050-sysc", mtmips_clk_init);
> +CLK_OF_DECLARE_DRIVER(rt3052_clk, "ralink,rt3052-sysc", mtmips_clk_init);
> +CLK_OF_DECLARE_DRIVER(rt3352_clk, "ralink,rt3352-sysc", mtmips_clk_init);
> +CLK_OF_DECLARE_DRIVER(rt3883_clk, "ralink,rt3883-sysc", mtmips_clk_init);
> +CLK_OF_DECLARE_DRIVER(rt5350_clk, "ralink,rt5350-sysc", mtmips_clk_init);
> +CLK_OF_DECLARE_DRIVER(mt7620_clk, "ralink,mt7620-sysc", mtmips_clk_init);
> +CLK_OF_DECLARE_DRIVER(mt7620a_clk, "ralink,mt7620a-sysc", mtmips_clk_ini=
t);
> +CLK_OF_DECLARE_DRIVER(mt7628_clk, "ralink,mt7628-sysc", mtmips_clk_init);
> +CLK_OF_DECLARE_DRIVER(mt7688_clk, "ralink,mt7688-sysc", mtmips_clk_init);

Is there any reason why these can't be platform drivers?

> +
[..]
> +
> +static int mtmips_clk_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np =3D pdev->dev.of_node;
> +       struct device *dev =3D &pdev->dev;
> +       struct mtmips_clk_priv *priv;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->sysc =3D syscon_node_to_regmap(np);
> +       if (IS_ERR(priv->sysc)) {
> +               ret =3D PTR_ERR(priv->sysc);
> +               dev_err(dev, "Could not get sysc syscon regmap\n");

Use dev_err_probe()?

> +               return ret;
> +       }
> +
> +       ret =3D mtmips_reset_init(dev, priv->sysc);
> +       if (ret) {
> +               dev_err(dev, "Could not init reset controller\n");

Use dev_err_probe()?

> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
