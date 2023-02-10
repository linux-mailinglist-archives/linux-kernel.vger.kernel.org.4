Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D44692B92
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBJXoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBJXoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:44:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B381C7E8E3;
        Fri, 10 Feb 2023 15:43:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B021B8261A;
        Fri, 10 Feb 2023 23:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23305C433D2;
        Fri, 10 Feb 2023 23:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676072553;
        bh=YioKUuQt5ggXpaHj14/wuWxn7QsrCCTVDyc1qzXUyU4=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=a4wwlrheJZuH6XC9P+QNj41GjVHjs4oayK3zo0VMtTeCd+ar+wwOMSsnqFIsTcExw
         qD7E6D5ko2jrjXIt+Xn7wxuKerRSZXFvdQsGw2CbgT8TuE5tWawLLBfBwrnADneRZ2
         KgFPkwmze7KIc6p7iOcsD6hVjOfhRhRk2l8Azas6CWZxiuYCXRIbWJmHlX4AMF+sAZ
         N7WRA3H3+n0yRq1ATUTrzF+cvB+xx4QbAwaCl2J3GLjivcjs3LMZhDoyqkTJge1vKv
         +y/4t+IM/rGx3aHEmOIznGgNmn9uQXxp5v8jYg2W47i2q/PzjKJiDIhA+bTETWuHGY
         96ZWfZm/vKOlQ==
Message-ID: <31c690a347f858a477bbba9c838984ed.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221129034157.15036-2-zhuyinbo@loongson.cn>
References: <20221129034157.15036-1-zhuyinbo@loongson.cn> <20221129034157.15036-2-zhuyinbo@loongson.cn>
Subject: Re: [PATCH v10 2/4] clk: clk-loongson2: add clock controller driver support
From:   Stephen Boyd <sboyd@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev
Date:   Fri, 10 Feb 2023 15:42:30 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yinbo Zhu (2022-11-28 19:41:55)
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 903096bd87f8..4f8f1b8f796d 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -127,6 +127,7 @@ config LOONGARCH
>         select USE_PERCPU_NUMA_NODE_ID
>         select USER_STACKTRACE_SUPPORT
>         select ZONE_DMA32
> +       select COMMON_CLK

Any reason to put this at the end instead of alphabetically?

> =20
>  config 32BIT
>         bool
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index d79905f3e174..d13626f63739 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -326,6 +326,15 @@ config COMMON_CLK_LOCHNAGAR
>           This driver supports the clocking features of the Cirrus Logic
>           Lochnagar audio development board.
> =20
> +config COMMON_CLK_LOONGSON2
> +       bool "Clock driver for Loongson-2 SoC"
> +       depends on COMMON_CLK && OF
> +       help
> +         This driver provides support for Clock Controller that base on

Don't capitalize 'Clock Controller'

> +         Common Clock Framework Controller (CCF) on Loongson-2 SoC. The

CCF doesn't really matter. Just say "support for clock controller on
Loongson-2 SoC"

> +         Clock Controller can generates and supplies clock to various

Same capitalization comment.

> +         peripherals within the SoC.
> +
>  config COMMON_CLK_NXP
>         def_bool COMMON_CLK && (ARCH_LPC18XX || ARCH_LPC32XX)
>         select REGMAP_MMIO if ARCH_LPC32XX
> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
> new file mode 100644
> index 000000000000..7487effceeab
> --- /dev/null
> +++ b/drivers/clk/clk-loongson2.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/clkdev.h>

Drop include that isn't used.

> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <dt-bindings/clock/loongson,ls2k-clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +
> +#define LOONGSON2_PLL_MULT_SHIFT               32
> +#define LOONGSON2_PLL_MULT_WIDTH               10
> +#define LOONGSON2_PLL_DIV_SHIFT                        26
> +#define LOONGSON2_PLL_DIV_WIDTH                        6
> +#define LOONGSON2_APB_FREQSCALE_SHIFT          20
> +#define LOONGSON2_APB_FREQSCALE_WIDTH          3
> +#define LOONGSON2_USB_FREQSCALE_SHIFT          16
> +#define LOONGSON2_USB_FREQSCALE_WIDTH          3
> +#define LOONGSON2_SATA_FREQSCALE_SHIFT         12
> +#define LOONGSON2_SATA_FREQSCALE_WIDTH         3
> +
> +static void __iomem *loongson2_pll_base;
> +
> +static struct clk_hw *loongson2_clk_register(struct device *dev,
> +                                         const char *name,
> +                                         const char *parent_name,
> +                                         const struct clk_ops *ops,
> +                                         unsigned long flags)
> +{
> +       int ret;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +
> +       /* allocate the divider */
> +       hw =3D kzalloc(sizeof(*hw), GFP_KERNEL);
> +       if (!hw)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D ops;
> +       init.flags =3D flags;
> +       init.parent_names =3D (parent_name ? &parent_name : NULL);
> +       init.num_parents =3D (parent_name ? 1 : 0);
> +       hw->init =3D &init;
> +
> +       /* register the clock */
> +       ret =3D clk_hw_register(dev, hw);
> +       if (ret) {
> +               kfree(hw);
> +               hw =3D ERR_PTR(ret);
> +       }
> +
> +       return hw;
> +}
> +
> +static struct clk_hw *loongson2_clk_pll_register(const char *name,
> +                               const char *parent, void __iomem *reg)
> +{
> +       u64 val;
> +       u32 mult =3D 1, div =3D 1;
> +
> +       val =3D readq((void *)reg);

Drop the cast.

> +
> +       mult =3D (val >> LOONGSON2_PLL_MULT_SHIFT) &
> +                       clk_div_mask(LOONGSON2_PLL_MULT_WIDTH);
> +       div =3D (val >> LOONGSON2_PLL_DIV_SHIFT) &
> +                       clk_div_mask(LOONGSON2_PLL_DIV_WIDTH);
> +
> +       return clk_hw_register_fixed_factor(NULL, name, parent,
> +                               CLK_SET_RATE_PARENT, mult, div);
> +}
> +
> +static unsigned long loongson2_apb_recalc_rate(struct clk_hw *hw,
> +                                         unsigned long parent_rate)
> +{
> +       u64 val;
> +       u32 mult;
> +       unsigned long rate;
> +
> +       val =3D readq((void *)(loongson2_pll_base + 0x50));

Drop the cast.

> +
> +       mult =3D (val >> LOONGSON2_APB_FREQSCALE_SHIFT) &
> +                       clk_div_mask(LOONGSON2_APB_FREQSCALE_WIDTH);
> +
> +       rate =3D parent_rate * (mult + 1);
> +       do_div(rate, 8);
> +
> +       return rate;
> +}
> +
> +static const struct clk_ops loongson2_apb_clk_ops =3D {
> +       .recalc_rate =3D loongson2_apb_recalc_rate,
> +};
> +
> +static unsigned long loongson2_usb_recalc_rate(struct clk_hw *hw,
> +                                         unsigned long parent_rate)
> +{
> +       u64 val;
> +       u32 mult;
> +       unsigned long rate;
> +
> +       val =3D readq((void *)(loongson2_pll_base + 0x50));

Drop the cast.

> +
> +       mult =3D (val >> LOONGSON2_USB_FREQSCALE_SHIFT) &
> +                       clk_div_mask(LOONGSON2_USB_FREQSCALE_WIDTH);
> +
> +       rate =3D parent_rate * (mult + 1);
> +       do_div(rate, 8);

Why is do_div() being used?

> +
> +       return rate;
> +}
> +
> +static const struct clk_ops loongson2_usb_clk_ops =3D {
> +       .recalc_rate =3D loongson2_usb_recalc_rate,
> +};
> +
> +static unsigned long loongson2_sata_recalc_rate(struct clk_hw *hw,
> +                                         unsigned long parent_rate)
> +{
> +       u64 val;
> +       u32 mult;
> +       unsigned long rate;
> +
> +       val =3D readq((void *)(loongson2_pll_base + 0x50));

Drop the cast.

> +
> +       mult =3D (val >> LOONGSON2_SATA_FREQSCALE_SHIFT) &
> +                       clk_div_mask(LOONGSON2_SATA_FREQSCALE_WIDTH);
> +
> +       rate =3D parent_rate * (mult + 1);
> +       do_div(rate, 8);
> +
> +       return rate;
> +}
> +
> +static const struct clk_ops loongson2_sata_clk_ops =3D {
> +       .recalc_rate =3D loongson2_sata_recalc_rate,
> +};
> +
> +static void loongson2_check_clk_hws(struct clk_hw *clks[], unsigned int =
count)

Inline this function.

> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < count; i++)
> +               if (IS_ERR(clks[i]))
> +                       pr_err("Loongson2 clk %u: register failed with %l=
d\n"
> +                               , i, PTR_ERR(clks[i]));

Put the comma on the line above please.

> +}
> +
> +static struct clk_hw *loongson2_obtain_fixed_clk_hw(
> +                                       struct device_node *np,
> +                                       const char *name)
> +{
> +       struct clk *clk;
> +
> +       clk =3D of_clk_get_by_name(np, name);
> +       if (IS_ERR(clk))
> +               return ERR_PTR(-ENOENT);
> +
> +       return __clk_get_hw(clk);

Please don't implement this whole function. Instead, use clk_parent_data
and the 'fw_name' or 'index' members to assign clk parents.

> +}
> +
> +static void __init loongson2_clocks_init(struct device_node *np)
> +{
> +       struct clk_hw **hws;
> +       struct clk_hw_onecell_data *clk_hw_data;
> +       spinlock_t loongson2_clk_lock;
> +
> +       loongson2_pll_base =3D of_iomap(np, 0);
> +
> +       if (!loongson2_pll_base) {
> +               pr_err("clk: unable to map loongson2 clk registers\n");
> +               goto err;

return?

> +       }
> +
> +       clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws, LOONGSON2_C=
LK_END),
> +                                       GFP_KERNEL);
> +       if (WARN_ON(!clk_hw_data))
> +               goto err;
> +
> +       clk_hw_data->num =3D LOONGSON2_CLK_END;
> +       hws =3D clk_hw_data->hws;
> +
> +       hws[LOONGSON2_REF_100M] =3D loongson2_obtain_fixed_clk_hw(np,
> +                                               "ref_100m");
> +
> +       hws[LOONGSON2_NODE_PLL] =3D loongson2_clk_pll_register("node_pll",
> +                                               "ref_100m",
> +                                               loongson2_pll_base);
> +
> +       hws[LOONGSON2_DDR_PLL] =3D loongson2_clk_pll_register("ddr_pll",
> +                                               "ref_100m",
> +                                               loongson2_pll_base + 0x10=
);
> +
> +       hws[LOONGSON2_DC_PLL] =3D loongson2_clk_pll_register("dc_pll",
> +                                               "ref_100m",
> +                                               loongson2_pll_base + 0x20=
);
> +
> +       hws[LOONGSON2_PIX0_PLL] =3D loongson2_clk_pll_register("pix0_pll",
> +                                               "ref_100m",
> +                                               loongson2_pll_base + 0x30=
);
> +
> +       hws[LOONGSON2_PIX1_PLL] =3D loongson2_clk_pll_register("pix1_pll",
> +                                               "ref_100m",
> +                                               loongson2_pll_base + 0x40=
);
> +
> +       hws[LOONGSON2_NODE_CLK] =3D clk_hw_register_divider(NULL, "node",
> +                                               "node_pll", 0,
> +                                               loongson2_pll_base + 0x8,=
 0,
> +                                               6, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       /*
> +        * The hda clk divisor in the upper 32bits and the clk-prodiver
> +        * layer code doesn't support 64bit io operation thus a conversion
> +        * is required that subtract shift by 32 and add 4byte to the hda
> +        * address
> +        */
> +       hws[LOONGSON2_HDA_CLK] =3D clk_hw_register_divider(NULL, "hda",
> +                                               "ddr_pll", 0,
> +                                               loongson2_pll_base + 0x22=
, 12,
> +                                               7, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_GPU_CLK] =3D clk_hw_register_divider(NULL, "gpu",
> +                                               "ddr_pll", 0,
> +                                               loongson2_pll_base + 0x18=
, 22,
> +                                               6, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_DDR_CLK] =3D clk_hw_register_divider(NULL, "ddr",
> +                                               "ddr_pll", 0,
> +                                               loongson2_pll_base + 0x18=
, 0,
> +                                               6, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_GMAC_CLK] =3D clk_hw_register_divider(NULL, "gmac",
> +                                               "dc_pll", 0,
> +                                               loongson2_pll_base + 0x28=
, 22,
> +                                               6, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_DC_CLK] =3D clk_hw_register_divider(NULL, "dc",
> +                                               "dc_pll", 0,
> +                                               loongson2_pll_base + 0x28=
, 0,
> +                                               6, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_APB_CLK] =3D loongson2_clk_register(NULL, "apb",
> +                                               "gmac",
> +                                               &loongson2_apb_clk_ops, 0=
);
> +
> +       hws[LOONGSON2_USB_CLK] =3D loongson2_clk_register(NULL, "usb",
> +                                               "gmac",
> +                                               &loongson2_usb_clk_ops, 0=
);
> +
> +       hws[LOONGSON2_SATA_CLK] =3D loongson2_clk_register(NULL, "sata",
> +                                               "gmac",
> +                                               &loongson2_sata_clk_ops, =
0);
> +
> +       hws[LOONGSON2_PIX0_CLK] =3D clk_hw_register_divider(NULL, "pix0",
> +                                               "pix0_pll", 0,
> +                                               loongson2_pll_base + 0x38=
, 0, 6,
> +                                               CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_PIX1_CLK] =3D clk_hw_register_divider(NULL, "pix1",
> +                                               "pix1_pll", 0,
> +                                               loongson2_pll_base + 0x48=
, 0, 6,
> +                                               CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       loongson2_check_clk_hws(hws, LOONGSON2_CLK_END);
> +
> +       of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +
> +err:
> +       iounmap(loongson2_pll_base);
> +}
> +
> +CLK_OF_DECLARE(loongson2_clk, "loongson,ls2k-clk", loongson2_clocks_init=
);

Any reason this can't be a platform driver?
