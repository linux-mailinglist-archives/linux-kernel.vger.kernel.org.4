Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0465E6ABE2E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCFLbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCFLbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:31:51 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A4125E05
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:31:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bx12so8412658wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678102307;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=nnlcQ9BMkF8waA7bPhK9VWqd4dpYj1ZoQnDYqo4mOfE=;
        b=bVX8s2GN3q6PpSkCba1aWnSI90a08cvYhaxFPHFsVXrDdgrtQSUhr+2tP8/QhciMAD
         75hFj6rSq+OLiXeIRYV/AN2ynd5Ml+Og0pBiqdEw279tV0TmvalyrW/uBWItVG/bWlda
         0ccBMIi3AwLOR3p9tM/jDgSoh7HGnz09Ptws84mfdUD7W+wHwdZdfYvAWlY51unP84vo
         aTwSCd1I2Jwj5ObRujVZE/oFuNqZpu56hfREWhn98BpdmyaLZNm5iDt1UJa1+vxr0TIF
         7Lb6oyEQ+NURJd9Yx9zZ/mSgs4Y8PtxU+hm3dY4kSoiKgTyvWIr6glwAmVExXlPsw69z
         eEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678102307;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnlcQ9BMkF8waA7bPhK9VWqd4dpYj1ZoQnDYqo4mOfE=;
        b=pc22p/XtocTX9RG31s3PhLqQIxyozTYdxDGWCOXwd33kgqg9EBxLy0mj3arslTgH4n
         /z6BUQoVIxNPYsAbTIhbecZLR9nuvW82gol2UbmJHLEjXwvpaGZQbj8shgkGXRDcjIaF
         lFlJWVc86toS/AL/9i8AFWiIS+x0y1m14fyyWAOSAb8hdUfyqxbEWSuGE3pGNieb0OWV
         mgbgZrhCM7HfuZ482RY0JfXKO5R8hNgbivP3EC1Snxm5Fjy3HBacYyY5MDK5qLmKgwRp
         qrb8D+vtDlT7gC6JvzZFjIvsPnaa+Pgc76Qc5C5N2SBMGK3sq/ohIt7kbL4ENthCr8JJ
         8KzQ==
X-Gm-Message-State: AO0yUKUOPx7xM1pLoBvmemR3uiJ5/UDqNfuqjxudaJSeWd2ybcu6KAj1
        9kIS9XYeNEZtXtrjaqE7i5/RFxhIacT3kFjS/UA=
X-Google-Smtp-Source: AK7set9TXIhj/F7Wc0bIk7vwZU1tUUJx2VynrxW4tLjr1wGsRz7gqz3+pE0SN8Ys5JjDvOP3hkuY/w==
X-Received: by 2002:a05:6000:1ce:b0:2c7:e909:5fcf with SMTP id t14-20020a05600001ce00b002c7e9095fcfmr6430048wrx.3.1678102306731;
        Mon, 06 Mar 2023 03:31:46 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d4103000000b002c55521903bsm9537724wrp.51.2023.03.06.03.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 03:31:46 -0800 (PST)
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-3-ddrokosov@sberdevices.ru>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 2/5] clk: meson: a1: add Amlogic A1 PLL clock
 controller driver
Date:   Mon, 06 Mar 2023 12:17:23 +0100
In-reply-to: <20230301183759.16163-3-ddrokosov@sberdevices.ru>
Message-ID: <1jr0u2azfi.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 01 Mar 2023 at 21:37, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> Introduce PLL clock controller for Amlogic A1 SoC family.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/clk/meson/Kconfig  |  10 +
>  drivers/clk/meson/Makefile |   1 +
>  drivers/clk/meson/a1-pll.c | 365 +++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/a1-pll.h |  47 +++++
>  4 files changed, 423 insertions(+)
>  create mode 100644 drivers/clk/meson/a1-pll.c
>  create mode 100644 drivers/clk/meson/a1-pll.h
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index fc002c155bc3..f56da2a4b000 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -99,6 +99,16 @@ config COMMON_CLK_AXG_AUDIO
>  	  Support for the audio clock controller on AmLogic A113D devices,
>  	  aka axg, Say Y if you want audio subsystem to work.
>  
> +config COMMON_CLK_A1_PLL
> +	tristate "Meson A1 SoC PLL controller support"
> +	depends on ARM64
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_PLL
> +	help
> +	  Support for the PLL clock controller on Amlogic A113L based
> +	  device, A1 SoC Family. Say Y if you want A1 PLL clock controller
> +	  to work.
> +
>  config COMMON_CLK_G12A
>  	tristate "G12 and SM1 SoC clock controllers support"
>  	depends on ARM64
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 6eca2a406ee3..2f17f475a48f 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
>  
>  obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
> +obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> new file mode 100644
> index 000000000000..c565f9b2a8dd
> --- /dev/null
> +++ b/drivers/clk/meson/a1-pll.c
> @@ -0,0 +1,365 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + * Author: Jian Hu <jian.hu@amlogic.com>
> + *
> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "meson-a1-clkc.h"

As pointed out by the kernel robot, there is a problem here

> +#include "a1-pll.h"
> +#include "clk-regmap.h"
> +
> +static struct clk_regmap fixed_pll_dco = {
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
> +			.width   = 19,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_FIXPLL_STS,
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
> +		.ops = &meson_clk_pll_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fixpll_in",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fixed_pll = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL0,
> +		.bit_idx = 20,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fixed_pll",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * It is enough that the fdiv leaf has critical flag,
> +		 * No critical or unused flag here.
> +		 */

The comment is not useful

> +	},
> +};
> +
> +static const struct pll_mult_range hifi_pll_mult_range = {
> +	.min = 32,
> +	.max = 64,
> +};
> +
> +static const struct reg_sequence hifi_init_regs[] = {
> +	{ .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x01800000 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00001100 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x100a1100 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x00302000 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x01f18440 },

This last poke should not bits otherwise handled by parms.
This is a rate init in disguise.

> +};
> +
> +static struct clk_regmap hifi_pll = {
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
> +			.width   = 19,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_HIFIPLL_STS,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.current_en = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 26,
> +			.width   = 1,
> +		},
> +		.l_detect = {

What is this ?

> +			.reg_off = ANACTRL_HIFIPLL_CTRL2,
> +			.shift   = 6,
> +			.width   = 1,
> +		},
> +		.range = &hifi_pll_mult_range,
> +		.init_regs = hifi_init_regs,
> +		.init_count = ARRAY_SIZE(hifi_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "hifi_pll",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "hifipll_in",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div2_div = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div2 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL0,
> +		.bit_idx = 21,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div2",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div2_div.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * This clock is used by DDR clock in BL2 firmware
> +		 * and is required by the platform to operate correctly.
> +		 * Until the following condition are met, we need this clock to
> +		 * be marked as critical:
> +		 * a) Mark the clock used by a firmware resource, if possible
> +		 * b) CCF has a clock hand-off mechanism to make the sure the
> +		 *    clock stays on until the proper driver comes along
> +		 */
> +		.flags = CLK_IS_CRITICAL,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div3_div = {
> +	.mult = 1,
> +	.div = 3,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div3_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div3 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL0,
> +		.bit_idx = 22,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div3",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div3_div.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * This clock is used by APB bus which is set in boot ROM code
> +		 * and is required by the platform to operate correctly.
> +		 * About critical, refer to fclk_div2.

This last line is not useful. Same for other occurences

> +		 */
> +		.flags = CLK_IS_CRITICAL,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div5_div = {
> +	.mult = 1,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div5 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL0,
> +		.bit_idx = 23,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div5",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div5_div.hw
> +		},
> +		.num_parents = 1,
> +		/*
> +		 * This clock is used by AXI bus which setted in Romcode
> +		 * and is required by the platform to operate correctly.
> +		 * About critical, refer to fclk_div2.
> +		 */
> +		.flags = CLK_IS_CRITICAL,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div7_div = {
> +	.mult = 1,
> +	.div = 7,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div7_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div7 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_FIXPLL_CTRL0,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "fclk_div7",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div7_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +/* Array of all clocks provided by this provider */
> +static struct clk_hw_onecell_data a1_pll_hw_onecell_data = {
> +	.hws = {
> +		[CLKID_FIXED_PLL_DCO]	= &fixed_pll_dco.hw,
> +		[CLKID_FIXED_PLL]	= &fixed_pll.hw,
> +		[CLKID_FCLK_DIV2_DIV]	= &fclk_div2_div.hw,
> +		[CLKID_FCLK_DIV3_DIV]	= &fclk_div3_div.hw,
> +		[CLKID_FCLK_DIV5_DIV]	= &fclk_div5_div.hw,
> +		[CLKID_FCLK_DIV7_DIV]	= &fclk_div7_div.hw,
> +		[CLKID_FCLK_DIV2]	= &fclk_div2.hw,
> +		[CLKID_FCLK_DIV3]	= &fclk_div3.hw,
> +		[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
> +		[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
> +		[CLKID_HIFI_PLL]	= &hifi_pll.hw,
> +		[NR_PLL_CLKS]		= NULL,
> +	},
> +	.num = NR_PLL_CLKS,
> +};
> +
> +static struct clk_regmap *const a1_pll_regmaps[] = {
> +	&fixed_pll_dco,
> +	&fixed_pll,
> +	&fclk_div2,
> +	&fclk_div3,
> +	&fclk_div5,
> +	&fclk_div7,
> +	&hifi_pll,
> +};
> +
> +static struct regmap_config a1_pll_regmap_cfg = {
> +	.reg_bits   = 32,
> +	.val_bits   = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int meson_a1_pll_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct clk_hw *hw;
> +	void __iomem *base;
> +	struct regmap *map;
> +	int clkid, i, err;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base),
> +				     "can't ioremap resource\n");
> +
> +	map = devm_regmap_init_mmio(dev, base, &a1_pll_regmap_cfg);
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map),
> +				     "can't init regmap mmio region\n");
> +
> +	/* Populate regmap for the regmap backed clocks */
> +	for (i = 0; i < ARRAY_SIZE(a1_pll_regmaps); i++)
> +		a1_pll_regmaps[i]->map = map;
> +
> +	for (clkid = 0; clkid < a1_pll_hw_onecell_data.num; clkid++) {
> +		hw = a1_pll_hw_onecell_data.hws[clkid];
> +		err = devm_clk_hw_register(dev, hw);
> +		if (err)
> +			return dev_err_probe(dev, err,
> +					     "clock registration failed\n");
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +					   &a1_pll_hw_onecell_data);
> +}
> +
> +#ifdef CONFIG_OF

This config is selected by ARM64 which this driver depends on

> +static const struct of_device_id a1_pll_clkc_match_table[] = {
> +	{ .compatible = "amlogic,a1-pll-clkc", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, a1_pll_clkc_match_table);
> +#endif /* CONFIG_OF */
> +
> +static struct platform_driver a1_pll_clkc_driver = {
> +	.probe = meson_a1_pll_probe,
> +	.driver = {
> +		.name = "a1-pll-clkc",
> +		.of_match_table = of_match_ptr(a1_pll_clkc_match_table),
> +	},
> +};
> +
> +module_platform_driver(a1_pll_clkc_driver);
> +MODULE_AUTHOR("Jian Hu <jian.hu@amlogic.com>");
> +MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
> new file mode 100644
> index 000000000000..de2eebce98af
> --- /dev/null
> +++ b/drivers/clk/meson/a1-pll.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Amlogic Meson-A1 PLL Clock Controller internals
> + *
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + * Author: Jian Hu <jian.hu@amlogic.com>
> + *
> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> + */
> +
> +#ifndef __A1_PLL_H
> +#define __A1_PLL_H
> +
> +#include "clk-pll.h"
> +
> +/* PLL register offset */
> +#define ANACTRL_FIXPLL_CTRL0	0x0
> +#define ANACTRL_FIXPLL_CTRL1	0x4
> +#define ANACTRL_FIXPLL_STS	0x14
> +#define ANACTRL_HIFIPLL_CTRL0	0xc0
> +#define ANACTRL_HIFIPLL_CTRL1	0xc4
> +#define ANACTRL_HIFIPLL_CTRL2	0xc8
> +#define ANACTRL_HIFIPLL_CTRL3	0xcc
> +#define ANACTRL_HIFIPLL_CTRL4	0xd0
> +#define ANACTRL_HIFIPLL_STS	0xd4
> +
> +/*
> + * CLKID index values
> + *
> + * These indices are entirely contrived and do not map onto the hardware.
> + * It has now been decided to expose everything by default in the DT header:
> + * include/dt-bindings/clock/a1-pll-clkc.h. Only the clocks ids we don't want
> + * to expose, such as the internal muxes and dividers of composite clocks,
> + * will remain defined here.
> + */
> +#define CLKID_FIXED_PLL_DCO	0
> +#define CLKID_FCLK_DIV2_DIV	2
> +#define CLKID_FCLK_DIV3_DIV	3
> +#define CLKID_FCLK_DIV5_DIV	4
> +#define CLKID_FCLK_DIV7_DIV	5
> +#define NR_PLL_CLKS		11
> +
> +/* include the CLKIDs that have been made part of the DT binding */
> +#include <dt-bindings/clock/a1-pll-clkc.h>
> +
> +#endif /* __A1_PLL_H */

