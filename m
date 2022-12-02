Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD60D640646
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiLBMAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiLBMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:00:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBACA4339
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:00:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h11so7424890wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=GWX70xn0dqSqHiT7lrRzVs8OYH7GF30kjWfCIFDZh4M=;
        b=cFgJucSgoRYbYoM8zA7Z9qcf8b5uwYjZE+VSAPjLikZsvDatCS0k1ZnRsVSiVzHVOj
         FM1tyCTQq3HCl/rhvlSaQiIZX8+ddcedfaVjz7bQKDN7ZXziMmnPeXZSQ2g7Y3U6fWwa
         Zrc7aqnZgoqOv9WSKhqEzGAi+Od8L2slPYR/PIE+O9bTQ36VwIla0t302mgYiBJnHVrF
         M1XG8jtbjp5nEYuHAmZ0wnzkgyRU8qVpq9vmkb6XeJxelvclLaROpBSef3oRays+jP8Y
         k21xuW4+QA9WVQuAjc1hbZm0dpw+RpeZerNhJ+G5yWplAa01IXJNdNs1N1jiQpYR8xb5
         NOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWX70xn0dqSqHiT7lrRzVs8OYH7GF30kjWfCIFDZh4M=;
        b=LA+zExIDae5lYBOXS/8o7oYxPRHkRn7jTfRCTcocGbSXiCjErY30ASKFk7gXEKUVW+
         htH3XSQHrfmEfmJ8gXePxdbEbJIY924D0aXDNj+CHkATqBS+5qO0JBnerHm2xJKsksVP
         vxIVmREFbZL+eJ4ef8w4MOaanLgvRK96T28J/VHswYtU8uyvb02LOWZRh0PTt+IV5AcM
         /H9c4OEAgxJdDv25WKy8PPdIHUQnRl64mRGAMlh99YDoDs48dUppfwRPgMMjfPbDlTeQ
         4T2jPnGH2jHF139qyD8MslI3kERZjXe1XaisVkJTm3iTnRdbU0MNC3M5FzcUMtU6TJ72
         ymLA==
X-Gm-Message-State: ANoB5pmp6jpImO2oRU400sFKL7FCWbioXT/02O8211qgE2p/jTqsyQLT
        ILO50jRuX6MuwO2kqNu05rJbTQ==
X-Google-Smtp-Source: AA0mqf5uehRfOkHDS7jQMGx7cQbU+U6OshnEnwzn+lkFfpLF/wdTC+qh/ak8h4SxexJSA4YKZGxG7w==
X-Received: by 2002:a5d:698b:0:b0:242:768:8aef with SMTP id g11-20020a5d698b000000b0024207688aefmr21831064wru.544.1669982432716;
        Fri, 02 Dec 2022 04:00:32 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c419200b003d0777b527asm6524229wmh.20.2022.12.02.04.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 04:00:32 -0800 (PST)
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-8-ddrokosov@sberdevices.ru>
User-agent: mu4e 1.8.10; emacs 28.2
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
Subject: Re: [PATCH v8 07/11] clk: meson: a1: redesign Amlogic A1 PLL clock
 controller
Date:   Fri, 02 Dec 2022 12:42:17 +0100
In-reply-to: <20221201225703.6507-8-ddrokosov@sberdevices.ru>
Message-ID: <1jtu2e6mn5.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 02 Dec 2022 at 01:56, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> Summary changes:
>     - supported meson-a1-clkc common driver
>     - inherited from the base clk-pll driver, implemented own version of
>       init/enable/disable/enabled routines; rate calculating logic is
>       fully the same
>     - aligned CLKID-related definitions with CLKID list from order
>       perspective to remove holes and permutations
>     - corrected Kconfig dependencies and types
>     - provided correct MODULE_AUTHORs() and MODULE_LICENSE()
>     - optimized and fix up some clock relationships
>     - removed unused register offset definitions (ANACTRL_* group)

This patch mix PLL stuff, factorization change, etc ...
In general, when your commit description is a list, it is a hint that
you are doing more than one thing in it. It is unlikely to be OK then

>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/clk/meson/Kconfig  |   5 +-
>  drivers/clk/meson/a1-pll.c | 267 +++++++++++++++++++++++++------------
>  drivers/clk/meson/a1-pll.h |  37 ++---
>  3 files changed, 202 insertions(+), 107 deletions(-)
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 1c885541c3a9..deb273673ec1 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -104,10 +104,11 @@ config COMMON_CLK_AXG_AUDIO
>  	  aka axg, Say Y if you want audio subsystem to work.
>  
>  config COMMON_CLK_A1_PLL
> -	bool
> -	depends on ARCH_MESON
> +	tristate "Meson A1 SoC PLL controller support"
> +	depends on ARM64
>  	select COMMON_CLK_MESON_REGMAP
>  	select COMMON_CLK_MESON_PLL
> +	select COMMON_CLK_MESON_A1_CLKC
>  	help
>  	  Support for the PLL clock controller on Amlogic A113L device,
>  	  aka a1. Say Y if you want PLL to work.
> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> index 69c1ca07d041..23487ca797b3 100644
> --- a/drivers/clk/meson/a1-pll.c
> +++ b/drivers/clk/meson/a1-pll.c
> @@ -2,15 +2,133 @@
>  /*
>   * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>   * Author: Jian Hu <jian.hu@amlogic.com>
> + *
> + * Copyright (c) 2022, SberDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>   */
>  
>  #include <linux/clk-provider.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include "meson-a1-clkc.h"
>  #include "a1-pll.h"
> -#include "clk-pll.h"
>  #include "clk-regmap.h"
>  
> +static inline
> +struct meson_a1_pll_data *meson_a1_pll_data(struct clk_regmap *clk)
> +{
> +	return (struct meson_a1_pll_data *)clk->data;
> +}
> +
> +static int meson_a1_pll_init(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_a1_pll_data *pll = meson_a1_pll_data(clk);
> +
> +	regmap_multi_reg_write(clk->map, pll->base.init_regs,
> +			       pll->base.init_count);
> +
> +	return 0;

Looks the the default init mostly

Looks like you are trying the handle the absence of the rst bit.
I'm pretty sure the hifi PLL of the SoC as one but you really don't want
to poke, this can be in the generic driver, with MESON_PARM_APPLICABLE()
test.

No need to redefine this

> +}
> +
> +static int meson_a1_pll_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_a1_pll_data *pll = meson_a1_pll_data(clk);
> +
> +	if (MESON_PARM_APPLICABLE(&pll->base.rst) &&
> +	    meson_parm_read(clk->map, &pll->base.rst))
> +		return 0;
> +
> +	if (!meson_parm_read(clk->map, &pll->base.en) ||
> +	    !meson_parm_read(clk->map, &pll->base.l))
> +		return 0;
> +

Same here, pretty sure rst is there and the generic function works but
if this update is required, it seems safe to do in the generic driver.

> +	return 1;
> +}
> +
> +static int meson_a1_pll_enable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_a1_pll_data *pll = meson_a1_pll_data(clk);
> +
> +	/* Do nothing if the PLL is already enabled */
> +	if (clk_hw_is_enabled(hw))
> +		return 0;
> +
> +	/* Enable the pll */
> +	meson_parm_write(clk->map, &pll->base.en, 1);
> +
> +	/*
> +	 * Compared with the previous SoCs, self-adaption current module
> +	 * is newly added for A1, keep the new power-on sequence to enable the
> +	 * PLL. The sequence is:
> +	 * 1. enable the pll, delay for 10us
> +	 * 2. enable the pll self-adaption current module, delay for 40us
> +	 * 3. enable the lock detect module
> +	 */
> +	usleep_range(10, 20);
> +	meson_parm_write(clk->map, &pll->current_en, 1);

this base.en vs current_en needs some explanation.

Again I think there is room to handle this through the pll driver

> +	usleep_range(40, 50);
> +
> +	meson_parm_write(clk->map, &pll->l_detect, 1);
> +	meson_parm_write(clk->map, &pll->l_detect, 0);
> +
> +	if (meson_clk_pll_wait_lock(hw))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static void meson_a1_pll_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_a1_pll_data *pll = meson_a1_pll_data(clk);
> +
> +	/* Disable the pll */
> +	meson_parm_write(clk->map, &pll->base.en, 0);
> +
> +	/* Disable PLL internal self-adaption current module */
> +	meson_parm_write(clk->map, &pll->current_en, 0);
> +}
> +
> +/*
> + * A1 PLL clock controller driver is based on meson clk_pll driver,
> + * so some rate calculating routines are reused
> + */
> +static unsigned long meson_a1_pll_recalc_rate(struct clk_hw *hw,
> +					      unsigned long parent_rate)
> +{
> +	return meson_clk_pll_ops.recalc_rate(hw, parent_rate);
> +}
> +
> +static int meson_a1_pll_determine_rate(struct clk_hw *hw,
> +				       struct clk_rate_request *req)
> +{
> +	return meson_clk_pll_ops.determine_rate(hw, req);
> +}
> +
> +static int meson_a1_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long parent_rate)
> +{
> +	return meson_clk_pll_ops.set_rate(hw, rate, parent_rate);
> +}
> +

This really does not scale well

> +static const struct clk_ops meson_a1_pll_ops = {
> +	.init		= meson_a1_pll_init,
> +	.recalc_rate	= meson_a1_pll_recalc_rate,
> +	.determine_rate	= meson_a1_pll_determine_rate,
> +	.set_rate	= meson_a1_pll_set_rate,
> +	.is_enabled	= meson_a1_pll_is_enabled,
> +	.enable		= meson_a1_pll_enable,
> +	.disable	= meson_a1_pll_disable
> +};
> +
> +static const struct clk_ops meson_a1_pll_ro_ops = {
> +	.recalc_rate	= meson_a1_pll_recalc_rate,
> +	.is_enabled	= meson_a1_pll_is_enabled,
> +};
> +
>  static struct clk_regmap a1_fixed_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
> @@ -46,7 +164,7 @@ static struct clk_regmap a1_fixed_pll_dco = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "fixed_pll_dco",
> -		.ops = &meson_clk_pll_ro_ops,
> +		.ops = &meson_a1_pll_ro_ops,
>  		.parent_data = &(const struct clk_parent_data) {
>  			.fw_name = "xtal_fixpll",
>  		},
> @@ -87,31 +205,36 @@ static const struct reg_sequence a1_hifi_init_regs[] = {
>  };
>  
>  static struct clk_regmap a1_hifi_pll = {
> -	.data = &(struct meson_clk_pll_data){
> -		.en = {
> -			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> -			.shift   = 28,
> -			.width   = 1,
> -		},
> -		.m = {
> -			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> -			.shift   = 0,
> -			.width   = 8,
> -		},
> -		.n = {
> -			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> -			.shift   = 10,
> -			.width   = 5,
> -		},
> -		.frac = {
> -			.reg_off = ANACTRL_HIFIPLL_CTRL1,
> -			.shift   = 0,
> -			.width   = 19,
> -		},
> -		.l = {
> -			.reg_off = ANACTRL_HIFIPLL_STS,
> -			.shift   = 31,
> -			.width   = 1,
> +	.data = &(struct meson_a1_pll_data){
> +		.base = {
> +			.en = {
> +				.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +				.shift   = 28,
> +				.width   = 1,
> +			},
> +			.m = {
> +				.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +				.shift   = 0,
> +				.width   = 8,
> +			},
> +			.n = {
> +				.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +				.shift   = 10,
> +				.width   = 5,
> +			},
> +			.frac = {
> +				.reg_off = ANACTRL_HIFIPLL_CTRL1,
> +				.shift   = 0,
> +				.width   = 19,
> +			},
> +			.l = {
> +				.reg_off = ANACTRL_HIFIPLL_STS,
> +				.shift   = 31,
> +				.width   = 1,
> +			},
> +			.range = &a1_hifi_pll_mult_range,
> +			.init_regs = a1_hifi_init_regs,
> +			.init_count = ARRAY_SIZE(a1_hifi_init_regs),
>  		},
>  		.current_en = {
>  			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> @@ -123,13 +246,10 @@ static struct clk_regmap a1_hifi_pll = {
>  			.shift   = 6,
>  			.width   = 1,
>  		},
> -		.range = &a1_hifi_pll_mult_range,
> -		.init_regs = a1_hifi_init_regs,
> -		.init_count = ARRAY_SIZE(a1_hifi_init_regs),
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "hifi_pll",
> -		.ops = &meson_clk_pll_ops,
> +		.ops = &meson_a1_pll_ops,
>  		.parent_data = &(const struct clk_parent_data) {
>  			.fw_name = "xtal_hifipll",
>  		},
> @@ -276,15 +396,15 @@ static struct clk_hw_onecell_data a1_pll_hw_onecell_data = {
>  	.hws = {
>  		[CLKID_FIXED_PLL_DCO]		= &a1_fixed_pll_dco.hw,
>  		[CLKID_FIXED_PLL]		= &a1_fixed_pll.hw,
> -		[CLKID_HIFI_PLL]		= &a1_hifi_pll.hw,
> -		[CLKID_FCLK_DIV2]		= &a1_fclk_div2.hw,
> -		[CLKID_FCLK_DIV3]		= &a1_fclk_div3.hw,
> -		[CLKID_FCLK_DIV5]		= &a1_fclk_div5.hw,
> -		[CLKID_FCLK_DIV7]		= &a1_fclk_div7.hw,
>  		[CLKID_FCLK_DIV2_DIV]		= &a1_fclk_div2_div.hw,
>  		[CLKID_FCLK_DIV3_DIV]		= &a1_fclk_div3_div.hw,
>  		[CLKID_FCLK_DIV5_DIV]		= &a1_fclk_div5_div.hw,
>  		[CLKID_FCLK_DIV7_DIV]		= &a1_fclk_div7_div.hw,
> +		[CLKID_FCLK_DIV2]		= &a1_fclk_div2.hw,
> +		[CLKID_FCLK_DIV3]		= &a1_fclk_div3.hw,
> +		[CLKID_FCLK_DIV5]		= &a1_fclk_div5.hw,
> +		[CLKID_FCLK_DIV7]		= &a1_fclk_div7.hw,
> +		[CLKID_HIFI_PLL]		= &a1_hifi_pll.hw,

I get you are trying to do but keep the ID order here 

>  		[NR_PLL_CLKS]			= NULL,
>  	},
>  	.num = NR_PLL_CLKS,
> @@ -293,68 +413,39 @@ static struct clk_hw_onecell_data a1_pll_hw_onecell_data = {
>  static struct clk_regmap *const a1_pll_regmaps[] = {
>  	&a1_fixed_pll_dco,
>  	&a1_fixed_pll,
> -	&a1_hifi_pll,
>  	&a1_fclk_div2,
>  	&a1_fclk_div3,
>  	&a1_fclk_div5,
>  	&a1_fclk_div7,
> +	&a1_hifi_pll,

?

>  };
>  
> -static struct regmap_config clkc_regmap_config = {
> -	.reg_bits       = 32,
> -	.val_bits       = 32,
> -	.reg_stride     = 4,
> +static const struct meson_a1_clkc_data a1_pll_clkc __maybe_unused = {
> +	.hw = &a1_pll_hw_onecell_data,
> +	.regs = a1_pll_regmaps,
> +	.num_regs = ARRAY_SIZE(a1_pll_regmaps),
>  };
>  
> -static int meson_a1_pll_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct resource *res;
> -	void __iomem *base;
> -	struct regmap *map;
> -	int ret, i;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> -
> -	map = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
> -	if (IS_ERR(map))
> -		return PTR_ERR(map);
> -
> -	/* Populate regmap for the regmap backed clocks */
> -	for (i = 0; i < ARRAY_SIZE(a1_pll_regmaps); i++)
> -		a1_pll_regmaps[i]->map = map;
> -
> -	for (i = 0; i < a1_pll_hw_onecell_data.num; i++) {
> -		/* array might be sparse */
> -		if (!a1_pll_hw_onecell_data.hws[i])
> -			continue;
> -
> -		ret = devm_clk_hw_register(dev, a1_pll_hw_onecell_data.hws[i]);
> -		if (ret) {
> -			dev_err(dev, "Clock registration failed\n");
> -			return ret;
> -		}
> -	}
> -
> -	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> -					   &a1_pll_hw_onecell_data);
> -}
> -
> -static const struct of_device_id clkc_match_table[] = {
> -	{ .compatible = "amlogic,a1-pll-clkc", },
> -	{}
> +#ifdef CONFIG_OF
> +static const struct of_device_id a1_pll_clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,a1-pll-clkc",
> +		.data = &a1_pll_clkc,
> +	},
> +	{},
>  };
> +MODULE_DEVICE_TABLE(of, a1_pll_clkc_match_table);
> +#endif /* CONFIG_OF */
>  
> -static struct platform_driver a1_pll_driver = {
> -	.probe		= meson_a1_pll_probe,
> -	.driver		= {
> -		.name	= "a1-pll-clkc",
> -		.of_match_table = clkc_match_table,
> +static struct platform_driver a1_pll_clkc_driver = {
> +	.probe = meson_a1_clkc_probe,
> +	.driver = {
> +		.name = "a1-pll-clkc",
> +		.of_match_table = of_match_ptr(a1_pll_clkc_match_table),
>  	},
>  };
>  
> -builtin_platform_driver(a1_pll_driver);
> +module_platform_driver(a1_pll_clkc_driver);
> +MODULE_AUTHOR("Jian Hu <jian.hu@amlogic.com>");
> +MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
> index 8ded267061ad..2ff5a2042a97 100644
> --- a/drivers/clk/meson/a1-pll.h
> +++ b/drivers/clk/meson/a1-pll.h
> @@ -1,38 +1,29 @@
>  /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>  /*
> + * Amlogic Meson-A1 PLL Clock Controller internals
> + *
>   * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + * Author: Jian Hu <jian.hu@amlogic.com>
> + *
> + * Copyright (c) 2022, SberDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>   */
>  
>  #ifndef __A1_PLL_H
>  #define __A1_PLL_H
>  
> +#include "clk-pll.h"
> +
>  /* PLL register offset */
>  #define ANACTRL_FIXPLL_CTRL0		0x0
>  #define ANACTRL_FIXPLL_CTRL1		0x4
> -#define ANACTRL_FIXPLL_CTRL2		0x8
> -#define ANACTRL_FIXPLL_CTRL3		0xc
> -#define ANACTRL_FIXPLL_CTRL4		0x10
>  #define ANACTRL_FIXPLL_STS		0x14
> -#define ANACTRL_SYSPLL_CTRL0		0x80
> -#define ANACTRL_SYSPLL_CTRL1		0x84
> -#define ANACTRL_SYSPLL_CTRL2		0x88
> -#define ANACTRL_SYSPLL_CTRL3		0x8c
> -#define ANACTRL_SYSPLL_CTRL4		0x90
> -#define ANACTRL_SYSPLL_STS		0x94
>  #define ANACTRL_HIFIPLL_CTRL0		0xc0
>  #define ANACTRL_HIFIPLL_CTRL1		0xc4
>  #define ANACTRL_HIFIPLL_CTRL2		0xc8
>  #define ANACTRL_HIFIPLL_CTRL3		0xcc
>  #define ANACTRL_HIFIPLL_CTRL4		0xd0
>  #define ANACTRL_HIFIPLL_STS		0xd4
> -#define ANACTRL_AUDDDS_CTRL0		0x100
> -#define ANACTRL_AUDDDS_CTRL1		0x104
> -#define ANACTRL_AUDDDS_CTRL2		0x108
> -#define ANACTRL_AUDDDS_CTRL3		0x10c
> -#define ANACTRL_AUDDDS_CTRL4		0x110
> -#define ANACTRL_AUDDDS_STS		0x114
> -#define ANACTRL_MISCTOP_CTRL0		0x140
> -#define ANACTRL_POR_CNTL		0x188
>  
>  /*
>   * CLKID index values
> @@ -53,4 +44,16 @@
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/a1-pll-clkc.h>
>  
> +/**
> + * struct meson_a1_pll_data - A1 PLL state
> + * @base: Basic CLK PLL state
> + * @current_en: Enable or disable the PLL self-adaption current module
> + * @l_detect: Enable or disable the lock detect module
> + */
> +struct meson_a1_pll_data {
> +	struct meson_clk_pll_data base;
> +	struct parm current_en;
> +	struct parm l_detect;
> +};
> +
>  #endif /* __A1_PLL_H */

