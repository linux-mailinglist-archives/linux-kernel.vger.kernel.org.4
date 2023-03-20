Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEFB6C2265
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjCTUR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCTURY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:17:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B231E02;
        Mon, 20 Mar 2023 13:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C6F0B8100E;
        Mon, 20 Mar 2023 20:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4567C433EF;
        Mon, 20 Mar 2023 20:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679343440;
        bh=/ZtNqAMQPcKkMwrwO1UdBvMa5zg/aN46lvJizXeqpG0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZSW4eNq6R0M8Xe4TWgOKuSTih99Wtnm/OkwE36byhp1NotDPuKYCgKP5S6jKVmnN9
         eVGFCJhxUojoUrh0mKvhFxvuWvQYoFgXBucmSD9QnkZcgZNpe7wAI5jHnO6pKIes4o
         VLByjWzsABlEBzSRcVJY9lyFithqxpK8j7ZpB3rEoJaDpJdevsEoGBbUwE64+WzS0+
         2JxquPcAM6+Us8KzRxv/mICG8qqK85h1LP6/IFYukUfiA/j1SIDc2QGlqlVBiYXF6D
         VPXUlJFViLjV7B8WxjZAgCdL3kj33ykm7AFVaeWq6COkdfcxdfYSEA5HmJ9Ey8/pLP
         rF09mcYmLyATA==
Message-ID: <1bac2baccd4de561944c4a3f8454f7d3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230318075340.22770-2-zhuyinbo@loongson.cn>
References: <20230318075340.22770-1-zhuyinbo@loongson.cn> <20230318075340.22770-2-zhuyinbo@loongson.cn>
Subject: Re: [PATCH v14 2/2] clk: clk-loongson2: add clock controller driver support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 Mar 2023 13:17:17 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yinbo Zhu (2023-03-18 00:53:40)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 1eef05bb1f99..c0f32d9c1cc4 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -325,6 +325,15 @@ config COMMON_CLK_LOCHNAGAR
>           This driver supports the clocking features of the Cirrus Logic
>           Lochnagar audio development board.
> =20
> +config COMMON_CLK_LOONGSON2
> +       bool "Clock driver for Loongson-2 SoC"
> +       depends on COMMON_CLK && OF

It doesn't depend on OF to build, right? If so, remove it. Also, this is
within the 'if COMMON_CLK' section of this file, so the 'depends on
COMMON_CLK' is redundant and should be removed.

> +       help
> +          This driver provides support for clock controller on Loongson-=
2 SoC.
> +          The clock controller can generates and supplies clock to vario=
us
> +          peripherals within the SoC.
> +          Say Y here to support Loongson-2 SoC clock driver.
> +
>  config COMMON_CLK_NXP
>         def_bool COMMON_CLK && (ARCH_LPC18XX || ARCH_LPC32XX)
>         select REGMAP_MMIO if ARCH_LPC32XX
> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
> new file mode 100644
> index 000000000000..c423932b626d
> --- /dev/null
> +++ b/drivers/clk/clk-loongson2.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/of.h>

Don't think this include will be needed.

> +#include <linux/of_address.h>

Don't include this.

> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>

Drop this include. This isn't a clk consumer.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <dt-bindings/clock/loongson,ls2k-clk.h>
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
> +#define LOONGSON2_BOOT_FREQSCALE_SHIFT         8
> +#define LOONGSON2_BOOT_FREQSCALE_WIDTH         3
> +
> +static void __iomem *loongson2_pll_base;
> +
> +static const struct clk_parent_data pdata[] =3D {
> +       { .fw_name =3D "ref_100m", .name =3D "ref_clk", },

Are you mainintain backwards compatibility? If not, which I believe is
the case, drop .name assignment.

> +};
> +
> +static struct clk_hw *loongson2_clk_register(struct device_node *np,

Take a struct device instead.

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
> +       init.num_parents =3D 1;
> +
> +       if (!parent_name)
> +               init.parent_data =3D pdata;
> +       else
> +               init.parent_names =3D &parent_name;
> +
> +       hw->init =3D &init;
> +
> +       /* register the clock */
> +       ret =3D of_clk_hw_register(np, hw);

Use devm_clk_hw_register()

> +       if (ret) {
> +               kfree(hw);
> +               hw =3D ERR_PTR(ret);
> +       }
> +
> +       return hw;
> +}
> +
> +static unsigned long loongson2_calc_pll_rate(int offset, unsigned long r=
ate)
> +{
> +       u64 val;
> +       u32 mult =3D 1, div =3D 1;

Why are these initialized?

> +
> +       val =3D readq(loongson2_pll_base + offset);
> +
> +       mult =3D (val >> LOONGSON2_PLL_MULT_SHIFT) &
> +                       clk_div_mask(LOONGSON2_PLL_MULT_WIDTH);
> +       div =3D (val >> LOONGSON2_PLL_DIV_SHIFT) &
> +                       clk_div_mask(LOONGSON2_PLL_DIV_WIDTH);

They're overwritten here.

> +
> +       return div_u64((u64)rate * mult, div);
> +}
> +
> +static unsigned long loongson2_node_recalc_rate(struct clk_hw *hw,
> +                                         unsigned long parent_rate)
> +{
> +       return loongson2_calc_pll_rate(0x0, parent_rate);
> +}
[...]
> +
> +static inline void loongson2_check_clk_hws(struct clk_hw *clks[], unsign=
ed int count)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < count; i++)
> +               if (IS_ERR(clks[i]))
> +                       pr_err("Loongson2 clk %u: register failed with %l=
d\n",
> +                               i, PTR_ERR(clks[i]));
> +}
> +
> +static void loongson2_clocks_init(struct device_node *np)

Inline this function at the caller.

> +{
> +       struct clk_hw **hws;
> +       struct clk_hw_onecell_data *clk_hw_data;
> +       spinlock_t loongson2_clk_lock;
> +
> +       loongson2_pll_base =3D of_iomap(np, 0);

Use platform device APIs.

> +
> +       if (!loongson2_pll_base) {
> +               pr_err("clk: unable to map loongson2 clk registers\n");

Drop error messages when mapping.

> +               return;
> +       }
> +
> +       clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws, LOONGSON2_C=
LK_END),

Use devm_kzalloc()

> +                                       GFP_KERNEL);
> +       if (WARN_ON(!clk_hw_data))
> +               goto err;
> +
[...]
> +
> +static int loongson2_clk_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device_node *np =3D dev->of_node;
> +
> +       loongson2_clocks_init(np);
> +
> +       return 0;
> +}
> +
