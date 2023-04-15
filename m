Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63966E3156
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 14:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDOMQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 08:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDOMQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 08:16:19 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B218C114
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 05:16:15 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nep7pQmHwxZmMnep7pYjtW; Sat, 15 Apr 2023 14:16:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681560973;
        bh=oaPZSLKdrABf1h1Krxj/JAchE9UFaxR56+UJQa8Br+c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VxL/oOX0wNjy5nN1pSUJEJaCRISTlLLgnQt25YBRmaUAafnO+qqd4SDR6ttBOwgeK
         4/ap2fK6aU4pyRiHsl7oEKcJRFc/EtjXX35bNzs9i7UKaYvVCNeEBIyF63+0l1aoBw
         kMBQPkx9GrXubTccZWX3sgVxX7+iA/UFWvzAthok6JJK2f+al44GHWIlI16C5eyt/T
         EugS05IB1hoIcNkBGVUhthXrM6YdfATY6sqqeV4m9cU1zOM/+sNYtivNv/O0MpHHRW
         Xb4tkYeRiMUuHgELPgFZ1VOSO5AklvXSg8FbAvqBIbkBZsxBUHOB8Uc9/W7YktdUed
         y2D7NffMlsGNg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 15 Apr 2023 14:16:13 +0200
X-ME-IP: 86.243.2.178
Message-ID: <c04038f2-b7aa-7c37-df93-6950831579f6@wanadoo.fr>
Date:   Sat, 15 Apr 2023 14:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 2/2] clk: wpcm450: Add Nuvoton WPCM450 clock/reset
 controller driver
To:     j.neuschaefer@gmx.net
Cc:     avifishman70@gmail.com, benjaminfair@google.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, mturquette@baylibre.com,
        openbmc@lists.ozlabs.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sboyd@kernel.org, tali.perry1@gmail.com,
        tglx@linutronix.de, tmaimon77@gmail.com, venture@google.com,
        wim@linux-watchdog.org, yuenn@google.com
References: <20230415111355.696738-1-j.neuschaefer@gmx.net>
 <20230415111355.696738-3-j.neuschaefer@gmx.net>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230415111355.696738-3-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/04/2023 à 13:13, Jonathan Neuschäfer a écrit :
> This driver implements the following features w.r.t. the clock and reset
> controller in the WPCM450 SoC:
> 
> - It calculates the rates for all clocks managed by the clock controller
> - It leaves the clock tree mostly unchanged, except that it enables/
>    disables clock gates based on usage.
> - It exposes the reset lines managed by the controller using the
>    Generic Reset Controller subsystem
> 
> NOTE: If the driver and the corresponding devicetree node are present,
>        the driver will disable "unused" clocks. This is problem until
>        the clock relations are properly declared in the devicetree (in a
>        later patch). Until then, the clk_ignore_unused kernel parameter
>        can be used as a workaround.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
> ---

[...]

> +
> +static void __init wpcm450_clk_init(struct device_node *clk_np)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	static struct clk_hw **hws;
> +	static struct clk_hw *hw;
> +	void __iomem *clk_base;
> +	int i, ret;
> +	struct reset_simple_data *reset;
> +
> +	clk_base = of_iomap(clk_np, 0);
> +	if (!clk_base) {
> +		pr_err("%pOFP: failed to map registers\n", clk_np);
> +		of_node_put(clk_np);
> +		return;
> +	}
> +	of_node_put(clk_np);
> +
> +	clk_data = kzalloc(struct_size(clk_data, hws, WPCM450_NUM_CLKS), GFP_KERNEL);
> +	if (!clk_data)
> +		goto err_unmap;
> +
> +	clk_data->num = WPCM450_NUM_CLKS;
> +	hws = clk_data->hws;
> +
> +	for (i = 0; i < WPCM450_NUM_CLKS; i++)
> +		hws[i] = ERR_PTR(-ENOENT);
> +
> +	// PLLs
> +	for (i = 0; i < ARRAY_SIZE(pll_data); i++) {
> +		const struct wpcm450_pll_data *data = &pll_data[i];
> +
> +		hw = wpcm450_clk_register_pll(clk_base + data->reg, data->name,
> +					      &data->parent, data->flags);
> +		if (IS_ERR(hw)) {
> +			pr_info("Failed to register PLL: %pe", hw);
> +			goto err_free;
> +		}
> +	}
> +
> +	// Early divisors (REF/2)
> +	for (i = 0; i < ARRAY_SIZE(clkdiv_data_early); i++) {
> +		const struct wpcm450_clkdiv_data *data = &clkdiv_data_early[i];
> +
> +		hw = clk_hw_register_divider_table_parent_data(NULL, data->name, &data->parent,
> +							       data->flags, clk_base + REG_CLKDIV,
> +							       data->shift, data->width,
> +							       data->div_flags, data->table,
> +							       &wpcm450_clk_lock);
> +		if (IS_ERR(hw)) {
> +			pr_err("Failed to register div table: %pe\n", hw);
> +			goto err_free;
> +		}
> +	}
> +
> +	// Selects/muxes
> +	for (i = 0; i < ARRAY_SIZE(clksel_data); i++) {
> +		const struct wpcm450_clksel_data *data = &clksel_data[i];
> +
> +		hw = clk_hw_register_mux_parent_data(NULL, data->name, data->parents,
> +						     data->num_parents, data->flags,
> +						     clk_base + REG_CLKSEL, data->shift,
> +						     data->width, 0,
> +						     &wpcm450_clk_lock);
> +		if (IS_ERR(hw)) {
> +			pr_err("Failed to register mux: %pe\n", hw);
> +			goto err_free;
> +		}
> +		if (data->index >= 0)
> +			clk_data->hws[data->index] = hw;
> +	}
> +
> +	// Divisors
> +	for (i = 0; i < ARRAY_SIZE(clkdiv_data); i++) {
> +		const struct wpcm450_clkdiv_data *data = &clkdiv_data[i];
> +
> +		hw = clk_hw_register_divider_table_parent_data(NULL, data->name, &data->parent,
> +							       data->flags, clk_base + REG_CLKDIV,
> +							       data->shift, data->width,
> +							       data->div_flags, data->table,
> +							       &wpcm450_clk_lock);
> +		if (IS_ERR(hw)) {
> +			pr_err("Failed to register divider: %pe\n", hw);
> +			goto err_free;
> +		}
> +	}
> +
> +	// Enables/gates
> +	for (i = 0; i < ARRAY_SIZE(clken_data); i++) {
> +		const struct wpcm450_clken_data *data = &clken_data[i];
> +
> +		hw = clk_hw_register_gate_parent_data(NULL, data->name, &data->parent, data->flags,
> +						      clk_base + REG_CLKEN, data->bitnum,
> +						      data->flags, &wpcm450_clk_lock);

If an error occures in the 'for' loop or after it, should this be 
clk_hw_unregister_gate()'ed somewhere?

CJ

> +		if (IS_ERR(hw)) {
> +			pr_err("Failed to register gate: %pe\n", hw);
> +			goto err_free;
> +		}
> +		clk_data->hws[data->bitnum] = hw;
> +	}
> +
> +	ret = of_clk_add_hw_provider(clk_np, of_clk_hw_onecell_get, clk_data);
> +	if (ret)
> +		pr_err("Failed to add DT provider: %d\n", ret);
> +
> +	// Reset controller
> +	reset = kzalloc(sizeof(*reset), GFP_KERNEL);
> +	if (!reset)
> +		goto err_free;
> +	reset->rcdev.owner = THIS_MODULE;
> +	reset->rcdev.nr_resets = WPCM450_NUM_RESETS;
> +	reset->rcdev.ops = &reset_simple_ops;
> +	reset->rcdev.of_node = clk_np;
> +	reset->membase = clk_base + REG_IPSRST;
> +	ret = reset_controller_register(&reset->rcdev);
> +	if (ret)
> +		pr_err("Failed to register reset controller: %d\n", ret);
> +
> +	of_node_put(clk_np);
> +	return;
> +
> +err_free:
> +	kfree(clk_data->hws);
> +err_unmap:
> +	iounmap(clk_base);
> +	of_node_put(clk_np);
> +}
> +
> +CLK_OF_DECLARE(wpcm450_clk_init, "nuvoton,wpcm450-clk", wpcm450_clk_init);
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 2a52c990d4fec..16e111d213560 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -208,7 +208,7 @@ config RESET_SCMI
> 
>   config RESET_SIMPLE
>   	bool "Simple Reset Controller Driver" if COMPILE_TEST || EXPERT
> -	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
> +	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC || ARCH_WPCM450
>   	depends on HAS_IOMEM
>   	help
>   	  This enables a simple reset controller driver for reset lines that
> --
> 2.39.2
> 
> 

