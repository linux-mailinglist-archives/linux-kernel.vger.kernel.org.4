Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19031724646
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbjFFOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjFFOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:36:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CFD10C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:36:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso63157095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686062186; x=1688654186;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=bAwQFxGP8Gu5McMu6H0HUkWlCXCqGtKq3VqK4BfVCTM=;
        b=qEsDUMgmSopuCY07jQFOAXfSstoSLg3LrcKeyzz9UmMCZRpq0gpGFbhiRjD6yU1lmv
         vWoA/wXX6tXfBuiePIbwHsfHISFYtL40V33u/DvnRKLMLlxcqLnP0AmgT80bqBefsKF8
         rJmCzCdi7VFms1+l4sQZGe+LJeMYSuqZimWLvbRvlXPEJNIyEivxegM7tp657mQwyxWv
         X++FNIjTI8POdnKe9NpUjWP0CPsQjR9S/CuKYQz1N87zqmGWi1Fvzto654CvVWJAPGFo
         qxEdvI4bj1FNV1Wwtr+FUtpNKRiaO1uITwabz6XiVJmBFL4wz+C1LP+esguRLOlEs0p0
         SBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686062186; x=1688654186;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAwQFxGP8Gu5McMu6H0HUkWlCXCqGtKq3VqK4BfVCTM=;
        b=J96t7f3HbGC0ZBmls3Jej1sGFzM9XbKKl2Vd0Cy0Iv/3O+9NAqNyLj0Whq0xQI4Qhp
         wik55carIpMTH4sC7sguR6OWiyJU3/9romG+qFRBnAqhp/yHw4jXv3SL8Mg5Zhe1JFNb
         qOgtH91rnq3Iq78kSS0j3ftRSzYYjtIwMO3n8ovTnKUNS86C0aGWGPMEAr3QGxQ5pNEr
         S72Kh6qE9D8dJ/tcJBphaCmi8ubX5LX5TxtbjRmf8j+mgyPLRPmvtlpd1YbsyeaFx3iy
         pd5PpXrULASUY6MuyDtEu+Hhps9qnnxrIUr124ITi5nICIGUUcIMXCb62XDfqppyrMUD
         D/5g==
X-Gm-Message-State: AC+VfDwg8XFMmz+YRc7r4XuSHLzhOFyVR4+IJ1DCBAH+R69FlbEi3MIZ
        F0f7Z1kxEtLUSQ94zhWVwBi6oQ==
X-Google-Smtp-Source: ACHHUZ6hA6vqWdbIfbhdsYAFhfn8BzJcsW9j6FErHaaWYROtwSzajLw1uEVHYuLOopv9fQwWaczxOg==
X-Received: by 2002:a1c:750e:0:b0:3f7:a80a:c676 with SMTP id o14-20020a1c750e000000b003f7a80ac676mr2534192wmc.39.1686062186494;
        Tue, 06 Jun 2023 07:36:26 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003eddc6aa5fasm17747558wmj.39.2023.06.06.07.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:36:26 -0700 (PDT)
References: <20230517070215.28463-1-yu.tu@amlogic.com>
 <20230517070215.28463-4-yu.tu@amlogic.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
Subject: Re: [PATCH V9 3/4] clk: meson: S4: add support for Amlogic S4 SoC
 PLL clock driver
Date:   Tue, 06 Jun 2023 16:34:01 +0200
In-reply-to: <20230517070215.28463-4-yu.tu@amlogic.com>
Message-ID: <1j1qio4pzq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 17 May 2023 at 15:02, Yu Tu <yu.tu@amlogic.com> wrote:

> Add the S4 PLL clock controller driver in the s4 SoC family.
>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig  |  13 +
>  drivers/clk/meson/Makefile |   1 +
>  drivers/clk/meson/s4-pll.c | 907 +++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/s4-pll.h |  87 ++++
>  4 files changed, 1008 insertions(+)
>  create mode 100644 drivers/clk/meson/s4-pll.c
>  create mode 100644 drivers/clk/meson/s4-pll.h
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index fc002c155bc3..a663c90a3f3b 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -115,4 +115,17 @@ config COMMON_CLK_G12A
>  	help
>  	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
>  	  devices, aka g12a. Say Y if you want peripherals to work.
> +
> +config COMMON_CLK_S4_PLL
> +	tristate "S4 SoC PLL clock controllers support"
> +	depends on ARM64
> +	default y
> +	select COMMON_CLK_MESON_MPLL
> +	select COMMON_CLK_MESON_PLL
> +	select COMMON_CLK_MESON_REGMAP
> +	help
> +	  Support for the pll clock controller on Amlogic S805X2 and S905Y4 devices,
> +	  aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.

I'm confused, what are the AQ222 and AQ229 ? are those SoC or boards
like your reference designs ?

If those are boards, it should not be mentionned here

Also, what about the S905X4 ? is it another SoC family ?

> +	  Say Y if you want the board to work, because plls are the parent of most
> +	  peripherals.
>  endmenu
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 6eca2a406ee3..376f49cc13f1 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
> +obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
> diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
> new file mode 100644
> index 000000000000..c70a33586bcd
> --- /dev/null
> +++ b/drivers/clk/meson/s4-pll.c
> @@ -0,0 +1,907 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Amlogic Meson-S4 PLL Clock Controller Driver
> + *
> + * Copyright (c) 2021 Amlogic, inc.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mpll.h"
> +#include "clk-pll.h"
> +#include "clk-regmap.h"
> +#include "s4-pll.h"
> +
> +static DEFINE_SPINLOCK(meson_clk_lock);
> +
> +static struct clk_regmap s4_fixed_pll_dco = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll_dco",
> +		/*
> +		 * This clock is a fixed value (4GHz) that is initialized by ROMcode.
> +		 * This clock won't ever change at runtime.
> +		 * The chip design determines that this clock cannot be changed after
> +		 * initialization. To prevent system crash caused by changing
> +		 * fixed related register in kernel phase. This register is not
> +		 * writable in the kernel phase.
> +		 * So we use ro_ops.
> +		 */
> +		.ops = &meson_clk_pll_ro_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fixed_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_FIXPLL_CTRL0,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fixed_pll",
> +		/*
> +		 * This clock is a fixed value (2GHz) that is initialized by ROMcode.
> +		 * For more information, please refer to s4_fixed_pll_dco.
> +		 */
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * This clock won't ever change at runtime so
> +		 * CLK_SET_RATE_PARENT is not required
> +		 */
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div2_div = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div2 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2",
> +		/*
> +		 * This clock is a fixed value (1GHz) that is initialized by ROMcode.
> +		 * For more information, please refer to s4_fixed_pll_dco.
> +		 */
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div2_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div3_div = {
> +	.mult = 1,
> +	.div = 3,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div3_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div3 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 20,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div3",
> +		/*
> +		 * For more information, please refer to s4_fixed_pll_dco.
> +		 */
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div3_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div4_div = {
> +	.mult = 1,
> +	.div = 4,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div4_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div4 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 21,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div4",
> +		/*
> +		 * For more information, please refer to s4_fixed_pll_dco.
> +		 */
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div4_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div5_div = {
> +	.mult = 1,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div5 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 22,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div5",
> +		/*
> +		 * For more information, please refer to s4_fixed_pll_dco.
> +		 */
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div7_div = {
> +	.mult = 1,
> +	.div = 7,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div7_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div7 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 23,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div7",
> +		/*
> +		 * For more information, please refer to s4_fixed_pll_dco.
> +		 */
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div7_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_fclk_div2p5_div = {
> +	.mult = 2,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2p5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_fclk_div2p5 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL1,
> +		.bit_idx = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2p5",
> +		/*
> +		 * For more information, please refer to s4_fixed_pll_dco.
> +		 */
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fclk_div2p5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct pll_mult_range s4_gp0_pll_mult_range = {
> +	.min = 125,
> +	.max = 250,
> +};
> +
> +/*
> + * Internal gp0 pll emulation configuration parameters
> + */
> +static const struct reg_sequence s4_gp0_init_regs[] = {
> +	{ .reg = ANACTRL_GP0PLL_CTRL1,	.def = 0x00000000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL2,	.def = 0x00000000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL3,	.def = 0x48681c00 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL4,	.def = 0x88770290 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL5,	.def = 0x39272000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL6,	.def = 0x56540000 }
> +};
> +
> +static struct clk_regmap s4_gp0_pll_dco = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &s4_gp0_pll_mult_range,
> +		.init_regs = s4_gp0_init_regs,
> +		.init_count = ARRAY_SIZE(s4_gp0_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gp0_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_gp0_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_GP0PLL_CTRL0,
> +		.shift = 16,
> +		.width = 3,
> +		.flags = (CLK_DIVIDER_POWER_OF_TWO |
> +			  CLK_DIVIDER_ROUND_CLOSEST),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gp0_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_gp0_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/*
> + * Internal hifi pll emulation configuration parameters
> + */
> +static const struct reg_sequence s4_hifi_init_regs[] = {
> +	{ .reg = ANACTRL_HIFIPLL_CTRL1,	.def = 0x00010e56 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL2,	.def = 0x00000000 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL3,	.def = 0x6a285c00 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL4,	.def = 0x65771290 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL5,	.def = 0x39272000 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL6,	.def = 0x56540000 }
> +};
> +
> +static struct clk_regmap s4_hifi_pll_dco = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &s4_gp0_pll_mult_range,
> +		.init_regs = s4_hifi_init_regs,
> +		.init_count = ARRAY_SIZE(s4_hifi_init_regs),
> +		.flags = CLK_MESON_PLL_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hifi_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_hifi_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_HIFIPLL_CTRL0,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = (CLK_DIVIDER_POWER_OF_TWO |
> +			  CLK_DIVIDER_ROUND_CLOSEST),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hifi_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hifi_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hdmi_pll_dco = {
> +	.data = &(struct meson_clk_pll_data){
> +		.en = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_HDMIPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &s4_gp0_pll_mult_range,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", }
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_hdmi_pll_od = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_HDMIPLL_CTRL0,
> +		.shift = 16,
> +		.width = 4,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_pll_od",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hdmi_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap s4_hdmi_pll = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = ANACTRL_HDMIPLL_CTRL0,
> +		.shift = 20,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hdmi_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_hdmi_pll_od.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_mpll_50m_div = {
> +	.mult = 1,
> +	.div = 80,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll_50m_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_mpll_50m = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = ANACTRL_FIXPLL_CTRL3,
> +		.mask = 0x1,
> +		.shift = 5,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll_50m",
> +		.ops = &clk_regmap_mux_ro_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .fw_name = "xtal", },
> +			{ .hw = &s4_mpll_50m_div.hw },
> +		},
> +		.num_parents = 2,
> +	},
> +};
> +
> +static struct clk_fixed_factor s4_mpll_prediv = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll_prediv",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_fixed_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct reg_sequence s4_mpll0_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL2, .def = 0x40000033 }
> +};
> +
> +static struct clk_regmap s4_mpll0_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &meson_clk_lock,
> +		.init_regs = s4_mpll0_init_regs,
> +		.init_count = ARRAY_SIZE(s4_mpll0_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll0_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_mpll0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL1,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_mpll0_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence s4_mpll1_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL4,	.def = 0x40000033 }
> +};
> +
> +static struct clk_regmap s4_mpll1_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &meson_clk_lock,
> +		.init_regs = s4_mpll1_init_regs,
> +		.init_count = ARRAY_SIZE(s4_mpll1_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll1_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_mpll1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL3,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_mpll1_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence s4_mpll2_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL6, .def = 0x40000033 }
> +};
> +
> +static struct clk_regmap s4_mpll2_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &meson_clk_lock,
> +		.init_regs = s4_mpll2_init_regs,
> +		.init_count = ARRAY_SIZE(s4_mpll2_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll2_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_mpll2 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL5,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll2",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_mpll2_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence s4_mpll3_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL8, .def = 0x40000033 }
> +};
> +
> +static struct clk_regmap s4_mpll3_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &meson_clk_lock,
> +		.init_regs = s4_mpll3_init_regs,
> +		.init_count = ARRAY_SIZE(s4_mpll3_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll3_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&s4_mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap s4_mpll3 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL7,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll3",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &s4_mpll3_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* Array of all clocks provided by this provider */
> +static struct clk_hw_onecell_data s4_pll_hw_onecell_data = {
> +	.hws = {
> +		[CLKID_FIXED_PLL_DCO]		= &s4_fixed_pll_dco.hw,
> +		[CLKID_FIXED_PLL]		= &s4_fixed_pll.hw,
> +		[CLKID_FCLK_DIV2_DIV]		= &s4_fclk_div2_div.hw,
> +		[CLKID_FCLK_DIV2]		= &s4_fclk_div2.hw,
> +		[CLKID_FCLK_DIV3_DIV]		= &s4_fclk_div3_div.hw,
> +		[CLKID_FCLK_DIV3]		= &s4_fclk_div3.hw,
> +		[CLKID_FCLK_DIV4_DIV]		= &s4_fclk_div4_div.hw,
> +		[CLKID_FCLK_DIV4]		= &s4_fclk_div4.hw,
> +		[CLKID_FCLK_DIV5_DIV]		= &s4_fclk_div5_div.hw,
> +		[CLKID_FCLK_DIV5]		= &s4_fclk_div5.hw,
> +		[CLKID_FCLK_DIV7_DIV]		= &s4_fclk_div7_div.hw,
> +		[CLKID_FCLK_DIV7]		= &s4_fclk_div7.hw,
> +		[CLKID_FCLK_DIV2P5_DIV]		= &s4_fclk_div2p5_div.hw,
> +		[CLKID_FCLK_DIV2P5]		= &s4_fclk_div2p5.hw,
> +		[CLKID_GP0_PLL_DCO]		= &s4_gp0_pll_dco.hw,
> +		[CLKID_GP0_PLL]			= &s4_gp0_pll.hw,
> +		[CLKID_HIFI_PLL_DCO]		= &s4_hifi_pll_dco.hw,
> +		[CLKID_HIFI_PLL]		= &s4_hifi_pll.hw,
> +		[CLKID_HDMI_PLL_DCO]		= &s4_hdmi_pll_dco.hw,
> +		[CLKID_HDMI_PLL_OD]		= &s4_hdmi_pll_od.hw,
> +		[CLKID_HDMI_PLL]		= &s4_hdmi_pll.hw,
> +		[CLKID_MPLL_50M_DIV]		= &s4_mpll_50m_div.hw,
> +		[CLKID_MPLL_50M]		= &s4_mpll_50m.hw,
> +		[CLKID_MPLL_PREDIV]		= &s4_mpll_prediv.hw,
> +		[CLKID_MPLL0_DIV]		= &s4_mpll0_div.hw,
> +		[CLKID_MPLL0]			= &s4_mpll0.hw,
> +		[CLKID_MPLL1_DIV]		= &s4_mpll1_div.hw,
> +		[CLKID_MPLL1]			= &s4_mpll1.hw,
> +		[CLKID_MPLL2_DIV]		= &s4_mpll2_div.hw,
> +		[CLKID_MPLL2]			= &s4_mpll2.hw,
> +		[CLKID_MPLL3_DIV]		= &s4_mpll3_div.hw,
> +		[CLKID_MPLL3]			= &s4_mpll3.hw,
> +		[NR_PLL_CLKS]			= NULL
> +	},
> +	.num = NR_PLL_CLKS,
> +};
> +
> +static struct clk_regmap *const s4_pll_clk_regmaps[] = {
> +	&s4_fixed_pll_dco,
> +	&s4_fixed_pll,
> +	&s4_fclk_div2,
> +	&s4_fclk_div3,
> +	&s4_fclk_div4,
> +	&s4_fclk_div5,
> +	&s4_fclk_div7,
> +	&s4_fclk_div2p5,
> +	&s4_gp0_pll_dco,
> +	&s4_gp0_pll,
> +	&s4_hifi_pll_dco,
> +	&s4_hifi_pll,
> +	&s4_hdmi_pll_dco,
> +	&s4_hdmi_pll_od,
> +	&s4_hdmi_pll,
> +	&s4_mpll_50m,
> +	&s4_mpll0_div,
> +	&s4_mpll0,
> +	&s4_mpll1_div,
> +	&s4_mpll1,
> +	&s4_mpll2_div,
> +	&s4_mpll2,
> +	&s4_mpll3_div,
> +	&s4_mpll3,
> +};
> +
> +static const struct reg_sequence s4_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL0,	.def = 0x00000543 },
> +};
> +
> +static struct regmap_config clkc_regmap_config = {
> +	.reg_bits       = 32,
> +	.val_bits       = 32,
> +	.reg_stride     = 4,
> +};
> +
> +static int meson_s4_pll_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	int ret, i;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = regmap_multi_reg_write(regmap, s4_init_regs, ARRAY_SIZE(s4_init_regs));
> +	if (ret) {
> +		dev_err(dev, "Failed to init registers\n");
> +		return ret;
> +	}
> +
> +	/* Populate regmap for the regmap backed clocks */
> +	for (i = 0; i < ARRAY_SIZE(s4_pll_clk_regmaps); i++)
> +		s4_pll_clk_regmaps[i]->map = regmap;
> +
> +	for (i = 0; i < s4_pll_hw_onecell_data.num; i++) {
> +		/* array might be sparse */
> +		if (!s4_pll_hw_onecell_data.hws[i])
> +			continue;
> +
> +		ret = devm_clk_hw_register(dev, s4_pll_hw_onecell_data.hws[i]);
> +		if (ret) {
> +			dev_err(dev, "Clock registration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +					   &s4_pll_hw_onecell_data);
> +}
> +
> +static const struct of_device_id clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,s4-pll-clkc",
> +	},
> +	{}
> +};
> +
> +static struct platform_driver s4_driver = {
> +	.probe		= meson_s4_pll_probe,
> +	.driver		= {
> +		.name	= "s4-pll-clkc",
> +		.of_match_table = clkc_match_table,
> +	},
> +};
> +
> +module_platform_driver(s4_driver);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/s4-pll.h b/drivers/clk/meson/s4-pll.h
> new file mode 100644
> index 000000000000..021d9f8b2b30
> --- /dev/null
> +++ b/drivers/clk/meson/s4-pll.h
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2021 Amlogic, inc.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#ifndef __MESON_S4_PLL_H__
> +#define __MESON_S4_PLL_H__
> +
> +/* ANA_CTRL - Registers */
> +
> +#define ANACTRL_FIXPLL_CTRL0                       0x040
> +#define ANACTRL_FIXPLL_CTRL1                       0x044
> +#define ANACTRL_FIXPLL_CTRL2                       0x048
> +#define ANACTRL_FIXPLL_CTRL3                       0x04c
> +#define ANACTRL_FIXPLL_CTRL4                       0x050
> +#define ANACTRL_FIXPLL_CTRL5                       0x054
> +#define ANACTRL_FIXPLL_CTRL6                       0x058
> +#define ANACTRL_FIXPLL_STS                         0x05c
> +#define ANACTRL_GP0PLL_CTRL0                       0x080
> +#define ANACTRL_GP0PLL_CTRL1                       0x084
> +#define ANACTRL_GP0PLL_CTRL2                       0x088
> +#define ANACTRL_GP0PLL_CTRL3                       0x08c
> +#define ANACTRL_GP0PLL_CTRL4                       0x090
> +#define ANACTRL_GP0PLL_CTRL5                       0x094
> +#define ANACTRL_GP0PLL_CTRL6                       0x098
> +#define ANACTRL_GP0PLL_STS                         0x09c
> +#define ANACTRL_HIFIPLL_CTRL0                      0x100
> +#define ANACTRL_HIFIPLL_CTRL1                      0x104
> +#define ANACTRL_HIFIPLL_CTRL2                      0x108
> +#define ANACTRL_HIFIPLL_CTRL3                      0x10c
> +#define ANACTRL_HIFIPLL_CTRL4                      0x110
> +#define ANACTRL_HIFIPLL_CTRL5                      0x114
> +#define ANACTRL_HIFIPLL_CTRL6                      0x118
> +#define ANACTRL_HIFIPLL_STS                        0x11c
> +#define ANACTRL_MPLL_CTRL0                         0x180
> +#define ANACTRL_MPLL_CTRL1                         0x184
> +#define ANACTRL_MPLL_CTRL2                         0x188
> +#define ANACTRL_MPLL_CTRL3                         0x18c
> +#define ANACTRL_MPLL_CTRL4                         0x190
> +#define ANACTRL_MPLL_CTRL5                         0x194
> +#define ANACTRL_MPLL_CTRL6                         0x198
> +#define ANACTRL_MPLL_CTRL7                         0x19c
> +#define ANACTRL_MPLL_CTRL8                         0x1a0
> +#define ANACTRL_MPLL_STS                           0x1a4
> +#define ANACTRL_HDMIPLL_CTRL0                      0x1c0
> +#define ANACTRL_HDMIPLL_CTRL1                      0x1c4
> +#define ANACTRL_HDMIPLL_CTRL2                      0x1c8
> +#define ANACTRL_HDMIPLL_CTRL3                      0x1cc
> +#define ANACTRL_HDMIPLL_CTRL4                      0x1d0
> +#define ANACTRL_HDMIPLL_CTRL5                      0x1d4
> +#define ANACTRL_HDMIPLL_CTRL6                      0x1d8
> +#define ANACTRL_HDMIPLL_STS                        0x1dc
> +#define ANACTRL_HDMIPLL_VLOCK                      0x1e4
> +
> +/*
> + * CLKID index values
> + *
> + * These indices are entirely contrived and do not map onto the hardware.
> + * It has now been decided to expose everything by default in the DT header:
> + * include/dt-bindings/clock/amlogic,s4-pll-clkc.h. Only the clocks ids we don't
> + * want to expose, such as the internal muxes and dividers of composite clocks,
> + * will remain defined here.
> + */
> +#define CLKID_FIXED_PLL_DCO		0
> +#define CLKID_FCLK_DIV2_DIV		2
> +#define CLKID_FCLK_DIV3_DIV		4
> +#define CLKID_FCLK_DIV4_DIV		6
> +#define CLKID_FCLK_DIV5_DIV		8
> +#define CLKID_FCLK_DIV7_DIV		10
> +#define CLKID_FCLK_DIV2P5_DIV		12
> +#define CLKID_GP0_PLL_DCO		14
> +#define CLKID_HIFI_PLL_DCO		16
> +#define CLKID_HDMI_PLL_DCO		18
> +#define CLKID_HDMI_PLL_OD		19
> +#define CLKID_MPLL_50M_DIV		21
> +#define CLKID_MPLL_PREDIV		23
> +#define CLKID_MPLL0_DIV			24
> +#define CLKID_MPLL1_DIV			26
> +#define CLKID_MPLL2_DIV			28
> +#define CLKID_MPLL3_DIV			30
> +
> +#define NR_PLL_CLKS			32
> +/* include the CLKIDs that have been made part of the DT binding */
> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
> +
> +#endif /* __MESON_S4_PLL_H__ */

