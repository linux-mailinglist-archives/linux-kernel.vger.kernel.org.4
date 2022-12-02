Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BCE640655
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiLBMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiLBMDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:03:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6D5A896E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:03:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q7so7477545wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=5NCDHCksP02n/WwMUNJwMgsCp3OSuflm0cGPUWAzLDk=;
        b=hRDArryATGVP7CzDr0DEshSiZeCGHD6MbJ3LuxPtOTba9l0Bz1B2bpiJ6GLIqp8vTS
         yeRhtXPD9qfctch9HexIdVJ+tpN6k1TbmZpeI1ndYJhaFkk5anxIqI908Eiwao2+rAYJ
         IdtZyBZkXOkyVTERJmUzoiE40IbSnvZjzRt74ew4KKTP4bqMi6fRYTeGrnhJFchzU7wN
         FUOyU2BUUG/dSTeZu9PPxm2/4gUDBEeHjU++Y9eqhHIUPeTXtUet5jhy9qa+aohJrGLE
         qcH6oK5OapnKWffihJK+FNLmL+psBKqQroQ7tdk4NWHLYwapeI/TbAGqdqag9jSFMgwi
         P9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NCDHCksP02n/WwMUNJwMgsCp3OSuflm0cGPUWAzLDk=;
        b=MeMDBA2iswLF6uCZBICK4/L68B0wVw+30IinL1Igz3SEamnFse9JdmHbSpfCzZvwp2
         mmzcGWKmukGz0VNg530VXC0EhggOsYSEw9RPW+0IUJAqW8DeXu9dAaZrSDR8NCgmAnZ7
         H12wy/TQ6Q7bG7x0oiy2HAJHZ8wm2eQ369Z9E7ESw08syi/jl6gZ7Ne4wTlzT+tl0jkh
         YSj6kaIyF/kynGowek1u0a+VXxLc6gZYmFwSI7iTuAQXJtMu3BJblf9HhlhpYKJcmaDe
         W/UcTl7tJlPAcO8Mm/WL76cY1WwITprvogGOxFetwV7aQpfMDXFZXMIRIPDhneKThnXQ
         PrxA==
X-Gm-Message-State: ANoB5plloVtgWNjkZTSBBAgbZJP5MVOZkvE3bKY59ASAW5zyrYanyyIw
        RUBxUTGpxxjLTSJeTc3bUUgc3g==
X-Google-Smtp-Source: AA0mqf62bItNTzmUHbQjqq7vloEDeJMVeZbMIvKx540LAZ9amGmagxe6fFFs1G0T+UszACSjga6JHw==
X-Received: by 2002:a5d:58c6:0:b0:242:da2:7f50 with SMTP id o6-20020a5d58c6000000b002420da27f50mr17619290wrf.507.1669982614363;
        Fri, 02 Dec 2022 04:03:34 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bc5d6000000b003c6c5a5a651sm8424185wmk.28.2022.12.02.04.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 04:03:33 -0800 (PST)
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-10-ddrokosov@sberdevices.ru>
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
Subject: Re: [PATCH v8 09/11] clk: meson: redesign A1 Peripherals CLK
 controller
Date:   Fri, 02 Dec 2022 13:01:52 +0100
In-reply-to: <20221201225703.6507-10-ddrokosov@sberdevices.ru>
Message-ID: <1jpmd26mi2.fsf@starbuckisacylon.baylibre.com>
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


On Fri 02 Dec 2022 at 01:57, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> Summary changes:
>     - fixed up clk_summary kernel panic due to missing a1_pad_ctrl
>       clk_regmap definition
>     - supported meson-a1-clkc common driver
>     - aligned CLKID-related definitions with CLKID list from order
>       perspective to remove holes and permutations
>     - corrected Kconfig dependencies and types
>     - provided correct MODULE_AUTHORs() and MODULE_LICENSE()
>     - optimized and fix up some clock relationships and parents
>       references
>     - removed unused register offset definitions

again, list in commit description a hint things are mixed up

>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/clk/meson/Kconfig |   7 +-
>  drivers/clk/meson/a1.c    | 591 ++++++++++++++++++--------------------
>  drivers/clk/meson/a1.h    |  16 +-
>  3 files changed, 292 insertions(+), 322 deletions(-)
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index deb273673ec1..cabe63bf23f5 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -114,13 +114,14 @@ config COMMON_CLK_A1_PLL
>  	  aka a1. Say Y if you want PLL to work.
>  
>  config COMMON_CLK_A1
> -	bool
> -	depends on ARCH_MESON
> +	tristate "Meson A1 SoC clock controller support"
> +	depends on ARM64
>  	select COMMON_CLK_MESON_DUALDIV
>  	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_A1_CLKC
>  	help
>  	  Support for the Peripheral clock controller on Amlogic A113L device,
> -	  aka a1. Say Y if you want Peripherals to work.
> +	  aka a1. Say Y if you want clock peripherals controller to work.
>  
>  config COMMON_CLK_G12A
>  	tristate "G12 and SM1 SoC clock controllers support"
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index 2cf20ae1db75..c9b7f09823f8 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -2,6 +2,9 @@
>  /*
>   * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>   * Author: Jian Hu <jian.hu@amlogic.com>
> + *
> + * Copyright (c) 2022, SberDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>   */
>  
>  #include <linux/clk-provider.h>
> @@ -10,6 +13,7 @@
>  #include "a1.h"
>  #include "clk-dualdiv.h"
>  #include "clk-regmap.h"
> +#include "meson-a1-clkc.h"
>  
>  static struct clk_regmap a1_xtal_clktree = {
>  	.data = &(struct clk_regmap_gate_data){
> @@ -116,11 +120,128 @@ static struct clk_regmap a1_xtal_dds = {
>  	},
>  };
>  
> +static struct clk_regmap a1_rtc_32k_clkin = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = RTC_BY_OSCIN_CTRL0,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_32k_clkin",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct meson_clk_dualdiv_param a1_32k_div_table[] = {
> +	{
> +		.dual		= 1,
> +		.n1		= 733,
> +		.m1		= 8,
> +		.n2		= 732,
> +		.m2		= 11,
> +	},
> +	{}
> +};
> +
> +static struct clk_regmap a1_rtc_32k_div = {
> +	.data = &(struct meson_clk_dualdiv_data){
> +		.n1 = {
> +			.reg_off = RTC_BY_OSCIN_CTRL0,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.n2 = {
> +			.reg_off = RTC_BY_OSCIN_CTRL0,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.m1 = {
> +			.reg_off = RTC_BY_OSCIN_CTRL1,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.m2 = {
> +			.reg_off = RTC_BY_OSCIN_CTRL1,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.dual = {
> +			.reg_off = RTC_BY_OSCIN_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.table = a1_32k_div_table,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "rtc_32k_div",
> +		.ops = &meson_clk_dualdiv_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&a1_rtc_32k_clkin.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap a1_rtc_32k_xtal = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = RTC_BY_OSCIN_CTRL1,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_32k_xtal",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&a1_rtc_32k_clkin.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap a1_rtc_32k_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = RTC_CTRL,
> +		.mask = 0x3,
> +		.shift = 0,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "rtc_32k_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&a1_rtc_32k_xtal.hw,
> +			&a1_rtc_32k_div.hw,
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +struct clk_regmap a1_rtc_clk = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = RTC_BY_OSCIN_CTRL0,
> +		.bit_idx = 30,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "rtc_clk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&a1_rtc_32k_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static u32 mux_table_sys_clk[] = { 0, 1, 2, 3, 7 };
>  static const struct clk_parent_data sys_clk_parents[] = {
>  	{ .fw_name = "xtal" },
>  	{ .fw_name = "fclk_div2" },
>  	{ .fw_name = "fclk_div3" },
>  	{ .fw_name = "fclk_div5" },
> +	{ .hw = &a1_rtc_clk.hw },
>  };
>  
>  static struct clk_regmap a1_sys_b_sel = {
> @@ -128,6 +249,7 @@ static struct clk_regmap a1_sys_b_sel = {
>  		.offset = SYS_CLK_CTRL0,
>  		.mask = 0x7,
>  		.shift = 26,
> +		.table = mux_table_sys_clk,
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "sys_b_sel",
> @@ -175,6 +297,7 @@ static struct clk_regmap a1_sys_a_sel = {
>  		.offset = SYS_CLK_CTRL0,
>  		.mask = 0x7,
>  		.shift = 10,
> +		.table = mux_table_sys_clk,
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "sys_a_sel",
> @@ -227,7 +350,8 @@ static struct clk_regmap a1_sys_clk = {
>  		.name = "sys_clk",
>  		.ops = &clk_regmap_mux_ro_ops,
>  		.parent_hws = (const struct clk_hw *[]) {
> -			&a1_sys_a.hw, &a1_sys_b.hw,
> +			&a1_sys_a.hw,
> +			&a1_sys_b.hw,
>  		},
>  		.num_parents = 2,
>  		/*
> @@ -243,121 +367,6 @@ static struct clk_regmap a1_sys_clk = {
>  	},
>  };
>  
> -static struct clk_regmap a1_rtc_32k_clkin = {
> -	.data = &(struct clk_regmap_gate_data){
> -		.offset = RTC_BY_OSCIN_CTRL0,
> -		.bit_idx = 31,
> -	},
> -	.hw.init = &(struct clk_init_data) {
> -		.name = "rtc_32k_clkin",
> -		.ops = &clk_regmap_gate_ops,
> -		.parent_data = &(const struct clk_parent_data) {
> -			.fw_name = "xtal",
> -		},
> -		.num_parents = 1,
> -	},
> -};
> -
> -static const struct meson_clk_dualdiv_param a1_32k_div_table[] = {
> -	{
> -		.dual		= 1,
> -		.n1		= 733,
> -		.m1		= 8,
> -		.n2		= 732,
> -		.m2		= 11,
> -	},
> -	{}
> -};
> -
> -static struct clk_regmap a1_rtc_32k_div = {
> -	.data = &(struct meson_clk_dualdiv_data){
> -		.n1 = {
> -			.reg_off = RTC_BY_OSCIN_CTRL0,
> -			.shift   = 0,
> -			.width   = 12,
> -		},
> -		.n2 = {
> -			.reg_off = RTC_BY_OSCIN_CTRL0,
> -			.shift   = 12,
> -			.width   = 12,
> -		},
> -		.m1 = {
> -			.reg_off = RTC_BY_OSCIN_CTRL1,
> -			.shift   = 0,
> -			.width   = 12,
> -		},
> -		.m2 = {
> -			.reg_off = RTC_BY_OSCIN_CTRL1,
> -			.shift   = 12,
> -			.width   = 12,
> -		},
> -		.dual = {
> -			.reg_off = RTC_BY_OSCIN_CTRL0,
> -			.shift   = 28,
> -			.width   = 1,
> -		},
> -		.table = a1_32k_div_table,
> -	},
> -	.hw.init = &(struct clk_init_data){
> -		.name = "rtc_32k_div",
> -		.ops = &meson_clk_dualdiv_ops,
> -		.parent_hws = (const struct clk_hw *[]) {
> -			&a1_rtc_32k_clkin.hw
> -		},
> -		.num_parents = 1,
> -	},
> -};
> -
> -static struct clk_regmap a1_rtc_32k_xtal = {
> -	.data = &(struct clk_regmap_gate_data){
> -		.offset = RTC_BY_OSCIN_CTRL1,
> -		.bit_idx = 24,
> -	},
> -	.hw.init = &(struct clk_init_data) {
> -		.name = "rtc_32k_xtal",
> -		.ops = &clk_regmap_gate_ops,
> -		.parent_hws = (const struct clk_hw *[]) {
> -			&a1_rtc_32k_clkin.hw
> -		},
> -		.num_parents = 1,
> -	},
> -};
> -
> -static struct clk_regmap a1_rtc_32k_sel = {
> -	.data = &(struct clk_regmap_mux_data) {
> -		.offset = RTC_CTRL,
> -		.mask = 0x3,
> -		.shift = 0,
> -		.flags = CLK_MUX_ROUND_CLOSEST,
> -	},
> -	.hw.init = &(struct clk_init_data){
> -		.name = "rtc_32k_sel",
> -		.ops = &clk_regmap_mux_ops,
> -		.parent_hws = (const struct clk_hw *[]) {
> -			&a1_rtc_32k_xtal.hw,
> -			&a1_rtc_32k_div.hw,
> -		},
> -		.num_parents = 2,
> -		.flags = CLK_SET_RATE_PARENT,
> -	},
> -};
> -
> -struct clk_regmap a1_rtc_clk = {
> -	.data = &(struct clk_regmap_gate_data){
> -		.offset = RTC_BY_OSCIN_CTRL0,
> -		.bit_idx = 30,
> -	},
> -	.hw.init = &(struct clk_init_data){
> -		.name = "rtc_clk",
> -		.ops = &clk_regmap_gate_ops,
> -		.parent_hws = (const struct clk_hw *[]) {
> -			&a1_rtc_32k_sel.hw
> -		},
> -		.num_parents = 1,
> -		.flags = CLK_SET_RATE_PARENT,
> -	},
> -};
> -
>  static u32 mux_table_dsp_ab[] = { 0, 1, 2, 3, 4, 7 };
>  static const struct clk_parent_data dsp_ab_clk_parent_data[] = {
>  	{ .fw_name = "xtal", },
> @@ -475,9 +484,9 @@ static struct clk_regmap a1_dspa_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "dspa_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		.parent_data = (const struct clk_parent_data []) {
> -			{ .hw = &a1_dspa_a.hw },
> -			{ .hw = &a1_dspa_b.hw },
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&a1_dspa_a.hw,
> +			&a1_dspa_b.hw,
>  		},
>  		.num_parents = 2,
>  		.flags = CLK_SET_RATE_PARENT,
> @@ -624,7 +633,8 @@ static struct clk_regmap a1_dspb_sel = {
>  		.name = "dspb_sel",
>  		.ops = &clk_regmap_mux_ops,
>  		.parent_hws = (const struct clk_hw *[]) {
> -			&a1_dspb_a.hw, &a1_dspb_b.hw,
> +			&a1_dspb_a.hw,
> +			&a1_dspb_b.hw,
>  		},
>  		.num_parents = 2,
>  		.flags = CLK_SET_RATE_PARENT,
> @@ -852,6 +862,12 @@ static struct clk_regmap a1_saradc_clk = {
>  	},
>  };
>  
> +static const struct clk_parent_data pwm_abcd_parents[] = {
> +	{ .fw_name = "xtal", },
> +	{ .hw = &a1_sys_clk.hw },
> +	{ .hw = &a1_rtc_clk.hw },
> +};
> +
>  static struct clk_regmap a1_pwm_a_sel = {
>  	.data = &(struct clk_regmap_mux_data){
>  		.offset = PWM_CLK_AB_CTRL,
> @@ -861,11 +877,8 @@ static struct clk_regmap a1_pwm_a_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pwm_a_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		.parent_data = (const struct clk_parent_data []) {
> -			{ .fw_name = "xtal", },
> -			{ .hw = &a1_sys_clk.hw, },
> -		},
> -		.num_parents = 2,
> +		.parent_data = pwm_abcd_parents,
> +		.num_parents = ARRAY_SIZE(pwm_abcd_parents),
>  	},
>  };
>  
> @@ -918,11 +931,8 @@ static struct clk_regmap a1_pwm_b_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pwm_b_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		.parent_data = (const struct clk_parent_data []) {
> -			{ .fw_name = "xtal", },
> -			{ .hw = &a1_sys_clk.hw, },
> -		},
> -		.num_parents = 2,
> +		.parent_data = pwm_abcd_parents,
> +		.num_parents = ARRAY_SIZE(pwm_abcd_parents),
>  	},
>  };
>  
> @@ -968,11 +978,8 @@ static struct clk_regmap a1_pwm_c_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pwm_c_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		.parent_data = (const struct clk_parent_data []) {
> -			{ .fw_name = "xtal", },
> -			{ .hw = &a1_sys_clk.hw, },
> -		},
> -		.num_parents = 2,
> +		.parent_data = pwm_abcd_parents,
> +		.num_parents = ARRAY_SIZE(pwm_abcd_parents),
>  	},
>  };
>  
> @@ -1018,11 +1025,8 @@ static struct clk_regmap a1_pwm_d_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pwm_d_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		.parent_data = (const struct clk_parent_data []) {
> -			{ .fw_name = "xtal", },
> -			{ .hw = &a1_sys_clk.hw, },
> -		},
> -		.num_parents = 2,
> +		.parent_data = pwm_abcd_parents,
> +		.num_parents = ARRAY_SIZE(pwm_abcd_parents),
>  	},
>  };
>  
> @@ -1059,7 +1063,7 @@ static struct clk_regmap a1_pwm_d = {
>  	},
>  };
>  
> -static const struct clk_parent_data pwm_ef_parent_data[] = {
> +static const struct clk_parent_data pwm_ef_parents[] = {
>  	{ .fw_name = "xtal", },
>  	{ .hw = &a1_sys_clk.hw },
>  	{ .fw_name = "fclk_div5", },
> @@ -1075,8 +1079,8 @@ static struct clk_regmap a1_pwm_e_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pwm_e_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		.parent_data = pwm_ef_parent_data,
> -		.num_parents = ARRAY_SIZE(pwm_ef_parent_data),
> +		.parent_data = pwm_ef_parents,
> +		.num_parents = ARRAY_SIZE(pwm_ef_parents),
>  	},
>  };
>  
> @@ -1122,8 +1126,8 @@ static struct clk_regmap a1_pwm_f_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "pwm_f_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		.parent_data = pwm_ef_parent_data,
> -		.num_parents = ARRAY_SIZE(pwm_ef_parent_data),
> +		.parent_data = pwm_ef_parents,
> +		.num_parents = ARRAY_SIZE(pwm_ef_parents),
>  	},
>  };
>  
> @@ -1169,7 +1173,7 @@ static struct clk_regmap a1_pwm_f = {
>   *  --------------------|/
>   *                 24M
>   */
> -static const struct clk_parent_data spicc_parents[] = {
> +static const struct clk_parent_data spicc_spifc_parents[] = {
>  	{ .fw_name = "fclk_div2"},
>  	{ .fw_name = "fclk_div3"},
>  	{ .fw_name = "fclk_div5"},
> @@ -1185,8 +1189,8 @@ static struct clk_regmap a1_spicc_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "spicc_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		.parent_data = spicc_parents,
> -		.num_parents = 4,
> +		.parent_data = spicc_spifc_parents,
> +		.num_parents = ARRAY_SIZE(spicc_spifc_parents),
>  	},
>  };
>  
> @@ -1282,9 +1286,8 @@ static struct clk_regmap a1_spifc_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "spifc_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		/* the same parent with spicc */
> -		.parent_data = spicc_parents,
> -		.num_parents = 4,
> +		.parent_data = spicc_spifc_parents,
> +		.num_parents = ARRAY_SIZE(spicc_spifc_parents),
>  	},
>  };
>  
> @@ -1339,7 +1342,7 @@ static struct clk_regmap a1_spifc = {
>  	},
>  };
>  
> -static const struct clk_parent_data usb_bus_parent_data[] = {
> +static const struct clk_parent_data usb_bus_parents[] = {
>  	{ .fw_name = "xtal", },
>  	{ .hw = &a1_sys_clk.hw },
>  	{ .fw_name = "fclk_div3", },
> @@ -1355,8 +1358,8 @@ static struct clk_regmap a1_usb_bus_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "usb_bus_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		.parent_data = usb_bus_parent_data,
> -		.num_parents = ARRAY_SIZE(usb_bus_parent_data),
> +		.parent_data = usb_bus_parents,
> +		.num_parents = ARRAY_SIZE(usb_bus_parents),
>  		.flags = CLK_SET_RATE_PARENT,
>  	},
>  };
> @@ -1394,7 +1397,7 @@ static struct clk_regmap a1_usb_bus = {
>  	},
>  };
>  
> -static const struct clk_parent_data sd_emmc_parents[] = {
> +static const struct clk_parent_data sd_emmc_psram_dmc_parents[] = {
>  	{ .fw_name = "fclk_div2", },
>  	{ .fw_name = "fclk_div3", },
>  	{ .fw_name = "fclk_div5", },
> @@ -1410,8 +1413,8 @@ static struct clk_regmap a1_sd_emmc_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "sd_emmc_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		.parent_data = sd_emmc_parents,
> -		.num_parents = 4,
> +		.parent_data = sd_emmc_psram_dmc_parents,
> +		.num_parents = ARRAY_SIZE(sd_emmc_psram_dmc_parents),
>  	},
>  };
>  
> @@ -1475,9 +1478,8 @@ static struct clk_regmap a1_psram_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "psram_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		/* the same parent with sd_emmc */
> -		.parent_data = sd_emmc_parents,
> -		.num_parents = 4,
> +		.parent_data = sd_emmc_psram_dmc_parents,
> +		.num_parents = ARRAY_SIZE(sd_emmc_psram_dmc_parents),
>  	},
>  };
>  
> @@ -1541,8 +1543,8 @@ static struct clk_regmap a1_dmc_sel = {
>  	.hw.init = &(struct clk_init_data){
>  		.name = "dmc_sel",
>  		.ops = &clk_regmap_mux_ops,
> -		.parent_data = sd_emmc_parents,
> -		.num_parents = 4,
> +		.parent_data = sd_emmc_psram_dmc_parents,
> +		.num_parents = ARRAY_SIZE(sd_emmc_psram_dmc_parents),
>  	},
>  };
>  
> @@ -1873,13 +1875,6 @@ static MESON_GATE(a1_prod_i2c,		AXI_CLK_EN,	12);
>  /* Array of all clocks provided by this provider */
>  static struct clk_hw_onecell_data a1_periphs_hw_onecell_data = {
>  	.hws = {
> -		[CLKID_SYS_B_SEL]		= &a1_sys_b_sel.hw,
> -		[CLKID_SYS_B_DIV]		= &a1_sys_b_div.hw,
> -		[CLKID_SYS_B]			= &a1_sys_b.hw,
> -		[CLKID_SYS_A_SEL]		= &a1_sys_a_sel.hw,
> -		[CLKID_SYS_A_DIV]		= &a1_sys_a_div.hw,
> -		[CLKID_SYS_A]			= &a1_sys_a.hw,
> -		[CLKID_SYS_CLK]			= &a1_sys_clk.hw,
>  		[CLKID_XTAL_CLKTREE]		= &a1_xtal_clktree.hw,
>  		[CLKID_XTAL_FIXPLL]		= &a1_xtal_fixpll.hw,
>  		[CLKID_XTAL_USB_PHY]		= &a1_xtal_usb_phy.hw,
> @@ -1887,6 +1882,7 @@ static struct clk_hw_onecell_data a1_periphs_hw_onecell_data = {
>  		[CLKID_XTAL_HIFIPLL]		= &a1_xtal_hifipll.hw,
>  		[CLKID_XTAL_SYSPLL]		= &a1_xtal_syspll.hw,
>  		[CLKID_XTAL_DDS]		= &a1_xtal_dds.hw,
> +		[CLKID_SYS_CLK]			= &a1_sys_clk.hw,
>  		[CLKID_CLKTREE]			= &a1_clk_tree.hw,
>  		[CLKID_RESET_CTRL]		= &a1_reset_ctrl.hw,
>  		[CLKID_ANALOG_CTRL]		= &a1_analog_ctrl.hw,
> @@ -1940,93 +1936,99 @@ static struct clk_hw_onecell_data a1_periphs_hw_onecell_data = {
>  		[CLKID_CPU_CTRL]		= &a1_cpu_ctrl.hw,
>  		[CLKID_ROM]			= &a1_rom.hw,
>  		[CLKID_PROC_I2C]		= &a1_prod_i2c.hw,
> +		[CLKID_DSPA_SEL]		= &a1_dspa_sel.hw,
> +		[CLKID_DSPB_SEL]		= &a1_dspb_sel.hw,
> +		[CLKID_DSPA_EN]			= &a1_dspa_en.hw,
> +		[CLKID_DSPA_EN_NIC]		= &a1_dspa_en_nic.hw,
> +		[CLKID_DSPB_EN]			= &a1_dspb_en.hw,
> +		[CLKID_DSPB_EN_NIC]		= &a1_dspb_en_nic.hw,
> +		[CLKID_RTC_CLK]			= &a1_rtc_clk.hw,
> +		[CLKID_CECA_32K]		= &a1_ceca_32k_clkout.hw,
> +		[CLKID_CECB_32K]		= &a1_cecb_32k_clkout.hw,
> +		[CLKID_24M]			= &a1_24m.hw,
> +		[CLKID_12M]			= &a1_12m.hw,
> +		[CLKID_FCLK_DIV2_DIVN]		= &a1_fclk_div2_divn.hw,
> +		[CLKID_GEN]			= &a1_gen.hw,
> +		[CLKID_SARADC_SEL]		= &a1_saradc_sel.hw,
> +		[CLKID_SARADC_CLK]		= &a1_saradc_clk.hw,
> +		[CLKID_PWM_A]			= &a1_pwm_a.hw,
> +		[CLKID_PWM_B]			= &a1_pwm_b.hw,
> +		[CLKID_PWM_C]			= &a1_pwm_c.hw,
> +		[CLKID_PWM_D]			= &a1_pwm_d.hw,
> +		[CLKID_PWM_E]			= &a1_pwm_e.hw,
> +		[CLKID_PWM_F]			= &a1_pwm_f.hw,
> +		[CLKID_SPICC]			= &a1_spicc.hw,
> +		[CLKID_TS]			= &a1_ts.hw,
> +		[CLKID_SPIFC]			= &a1_spifc.hw,
> +		[CLKID_USB_BUS]			= &a1_usb_bus.hw,
> +		[CLKID_SD_EMMC]			= &a1_sd_emmc.hw,
> +		[CLKID_PSRAM]			= &a1_psram.hw,
> +		[CLKID_DMC]			= &a1_dmc.hw,
> +		[CLKID_SYS_A_SEL]		= &a1_sys_a_sel.hw,
> +		[CLKID_SYS_A_DIV]		= &a1_sys_a_div.hw,
> +		[CLKID_SYS_A]			= &a1_sys_a.hw,
> +		[CLKID_SYS_B_SEL]		= &a1_sys_b_sel.hw,
> +		[CLKID_SYS_B_DIV]		= &a1_sys_b_div.hw,
> +		[CLKID_SYS_B]			= &a1_sys_b.hw,
>  		[CLKID_DSPA_A_SEL]		= &a1_dspa_a_sel.hw,
>  		[CLKID_DSPA_A_DIV]		= &a1_dspa_a_div.hw,
>  		[CLKID_DSPA_A]			= &a1_dspa_a.hw,
>  		[CLKID_DSPA_B_SEL]		= &a1_dspa_b_sel.hw,
>  		[CLKID_DSPA_B_DIV]		= &a1_dspa_b_div.hw,
>  		[CLKID_DSPA_B]			= &a1_dspa_b.hw,
> -		[CLKID_DSPA_SEL]		= &a1_dspa_sel.hw,
>  		[CLKID_DSPB_A_SEL]		= &a1_dspb_a_sel.hw,
>  		[CLKID_DSPB_A_DIV]		= &a1_dspb_a_div.hw,
>  		[CLKID_DSPB_A]			= &a1_dspb_a.hw,
>  		[CLKID_DSPB_B_SEL]		= &a1_dspb_b_sel.hw,
>  		[CLKID_DSPB_B_DIV]		= &a1_dspb_b_div.hw,
>  		[CLKID_DSPB_B]			= &a1_dspb_b.hw,
> -		[CLKID_DSPB_SEL]		= &a1_dspb_sel.hw,
> -		[CLKID_DSPA_EN]			= &a1_dspa_en.hw,
> -		[CLKID_DSPA_EN_NIC]		= &a1_dspa_en_nic.hw,
> -		[CLKID_DSPB_EN]			= &a1_dspb_en.hw,
> -		[CLKID_DSPB_EN_NIC]		= &a1_dspb_en_nic.hw,
> -		[CLKID_24M]			= &a1_24m.hw,
> -		[CLKID_24M_DIV2]		= &a1_24m_div2.hw,
> -		[CLKID_12M]			= &a1_12m.hw,
> +		[CLKID_RTC_32K_CLKIN]		= &a1_rtc_32k_clkin.hw,
> +		[CLKID_RTC_32K_DIV]		= &a1_rtc_32k_div.hw,
> +		[CLKID_RTC_32K_XTAL]		= &a1_rtc_32k_xtal.hw,
> +		[CLKID_RTC_32K_SEL]		= &a1_rtc_32k_sel.hw,
> +		[CLKID_CECB_32K_CLKIN]		= &a1_cecb_32k_clkin.hw,
> +		[CLKID_CECB_32K_DIV]		= &a1_cecb_32k_div.hw,
> +		[CLKID_CECB_32K_SEL_PRE]	= &a1_cecb_32k_sel_pre.hw,
> +		[CLKID_CECB_32K_SEL]		= &a1_cecb_32k_sel.hw,
> +		[CLKID_CECA_32K_CLKIN]		= &a1_ceca_32k_clkin.hw,
> +		[CLKID_CECA_32K_DIV]		= &a1_ceca_32k_div.hw,
> +		[CLKID_CECA_32K_SEL_PRE]	= &a1_ceca_32k_sel_pre.hw,
> +		[CLKID_CECA_32K_SEL]		= &a1_ceca_32k_sel.hw,
>  		[CLKID_DIV2_PRE]		= &a1_fclk_div2_divn_pre.hw,
> -		[CLKID_FCLK_DIV2_DIVN]		= &a1_fclk_div2_divn.hw,
> +		[CLKID_24M_DIV2]		= &a1_24m_div2.hw,
>  		[CLKID_GEN_SEL]			= &a1_gen_sel.hw,
>  		[CLKID_GEN_DIV]			= &a1_gen_div.hw,
> -		[CLKID_GEN]			= &a1_gen.hw,
> -		[CLKID_SARADC_SEL]		= &a1_saradc_sel.hw,
>  		[CLKID_SARADC_DIV]		= &a1_saradc_div.hw,
> -		[CLKID_SARADC_CLK]		= &a1_saradc_clk.hw,
>  		[CLKID_PWM_A_SEL]		= &a1_pwm_a_sel.hw,
>  		[CLKID_PWM_A_DIV]		= &a1_pwm_a_div.hw,
> -		[CLKID_PWM_A]			= &a1_pwm_a.hw,
>  		[CLKID_PWM_B_SEL]		= &a1_pwm_b_sel.hw,
>  		[CLKID_PWM_B_DIV]		= &a1_pwm_b_div.hw,
> -		[CLKID_PWM_B]			= &a1_pwm_b.hw,
>  		[CLKID_PWM_C_SEL]		= &a1_pwm_c_sel.hw,
>  		[CLKID_PWM_C_DIV]		= &a1_pwm_c_div.hw,
> -		[CLKID_PWM_C]			= &a1_pwm_c.hw,
>  		[CLKID_PWM_D_SEL]		= &a1_pwm_d_sel.hw,
>  		[CLKID_PWM_D_DIV]		= &a1_pwm_d_div.hw,
> -		[CLKID_PWM_D]			= &a1_pwm_d.hw,
>  		[CLKID_PWM_E_SEL]		= &a1_pwm_e_sel.hw,
>  		[CLKID_PWM_E_DIV]		= &a1_pwm_e_div.hw,
> -		[CLKID_PWM_E]			= &a1_pwm_e.hw,
>  		[CLKID_PWM_F_SEL]		= &a1_pwm_f_sel.hw,
>  		[CLKID_PWM_F_DIV]		= &a1_pwm_f_div.hw,
> -		[CLKID_PWM_F]			= &a1_pwm_f.hw,
>  		[CLKID_SPICC_SEL]		= &a1_spicc_sel.hw,
>  		[CLKID_SPICC_DIV]		= &a1_spicc_div.hw,
>  		[CLKID_SPICC_SEL2]		= &a1_spicc_sel2.hw,
> -		[CLKID_SPICC]			= &a1_spicc.hw,
>  		[CLKID_TS_DIV]			= &a1_ts_div.hw,
> -		[CLKID_TS]			= &a1_ts.hw,
>  		[CLKID_SPIFC_SEL]		= &a1_spifc_sel.hw,
>  		[CLKID_SPIFC_DIV]		= &a1_spifc_div.hw,
>  		[CLKID_SPIFC_SEL2]		= &a1_spifc_sel2.hw,
> -		[CLKID_SPIFC]			= &a1_spifc.hw,
>  		[CLKID_USB_BUS_SEL]		= &a1_usb_bus_sel.hw,
>  		[CLKID_USB_BUS_DIV]		= &a1_usb_bus_div.hw,
> -		[CLKID_USB_BUS]			= &a1_usb_bus.hw,
>  		[CLKID_SD_EMMC_SEL]		= &a1_sd_emmc_sel.hw,
>  		[CLKID_SD_EMMC_DIV]		= &a1_sd_emmc_div.hw,
>  		[CLKID_SD_EMMC_SEL2]		= &a1_sd_emmc_sel2.hw,
> -		[CLKID_SD_EMMC]			= &a1_sd_emmc.hw,
>  		[CLKID_PSRAM_SEL]		= &a1_psram_sel.hw,
>  		[CLKID_PSRAM_DIV]		= &a1_psram_div.hw,
>  		[CLKID_PSRAM_SEL2]		= &a1_psram_sel2.hw,
> -		[CLKID_PSRAM]			= &a1_psram.hw,
>  		[CLKID_DMC_SEL]			= &a1_dmc_sel.hw,
>  		[CLKID_DMC_DIV]			= &a1_dmc_div.hw,
>  		[CLKID_DMC_SEL2]		= &a1_dmc_sel2.hw,
> -		[CLKID_DMC]			= &a1_dmc.hw,
> -		[CLKID_RTC_32K_CLKIN]		= &a1_rtc_32k_clkin.hw,
> -		[CLKID_RTC_32K_DIV]		= &a1_rtc_32k_div.hw,
> -		[CLKID_RTC_32K_XTAL]		= &a1_rtc_32k_xtal.hw,
> -		[CLKID_RTC_32K_SEL]		= &a1_rtc_32k_sel.hw,
> -		[CLKID_RTC_CLK]			= &a1_rtc_clk.hw,
> -		[CLKID_CECA_32K_CLKIN]		= &a1_ceca_32k_clkin.hw,
> -		[CLKID_CECA_32K_DIV]		= &a1_ceca_32k_div.hw,
> -		[CLKID_CECA_32K_SEL_PRE]	= &a1_ceca_32k_sel_pre.hw,
> -		[CLKID_CECA_32K_SEL]		= &a1_ceca_32k_sel.hw,
> -		[CLKID_CECA_32K]		= &a1_ceca_32k_clkout.hw,
> -		[CLKID_CECB_32K_CLKIN]		= &a1_cecb_32k_clkin.hw,
> -		[CLKID_CECB_32K_DIV]		= &a1_cecb_32k_div.hw,
> -		[CLKID_CECB_32K_SEL_PRE]	= &a1_cecb_32k_sel_pre.hw,
> -		[CLKID_CECB_32K_SEL]		= &a1_cecb_32k_sel.hw,
> -		[CLKID_CECB_32K]		= &a1_cecb_32k_clkout.hw,
>  		[NR_CLKS]			= NULL,
>  	},

Please avoid this ordering change - It is borderline impossible to
review.

Keep the ID Order


>  	.num = NR_CLKS,
> @@ -2041,10 +2043,12 @@ static struct clk_regmap *const a1_periphs_regmaps[] = {
>  	&a1_xtal_hifipll,
>  	&a1_xtal_syspll,
>  	&a1_xtal_dds,
> +	&a1_sys_clk,
>  	&a1_clk_tree,
>  	&a1_reset_ctrl,
>  	&a1_analog_ctrl,
>  	&a1_pwr_ctrl,
> +	&a1_pad_ctrl,
>  	&a1_sys_ctrl,
>  	&a1_temp_sensor,
>  	&a1_am2axi_dev,
> @@ -2093,157 +2097,126 @@ static struct clk_regmap *const a1_periphs_regmaps[] = {
>  	&a1_cpu_ctrl,
>  	&a1_rom,
>  	&a1_prod_i2c,
> +	&a1_dspa_sel,
> +	&a1_dspb_sel,
> +	&a1_dspa_en,
> +	&a1_dspa_en_nic,
> +	&a1_dspb_en,
> +	&a1_dspb_en_nic,
> +	&a1_rtc_clk,
> +	&a1_ceca_32k_clkout,
> +	&a1_cecb_32k_clkout,
> +	&a1_24m,
> +	&a1_12m,
> +	&a1_fclk_div2_divn,
> +	&a1_gen,
> +	&a1_saradc_sel,
> +	&a1_saradc_clk,
> +	&a1_pwm_a,
> +	&a1_pwm_b,
> +	&a1_pwm_c,
> +	&a1_pwm_d,
> +	&a1_pwm_e,
> +	&a1_pwm_f,
> +	&a1_spicc,
> +	&a1_ts,
> +	&a1_spifc,
> +	&a1_usb_bus,
> +	&a1_sd_emmc,
> +	&a1_psram,
> +	&a1_dmc,
> +	&a1_sys_a_sel,
> +	&a1_sys_a_div,
> +	&a1_sys_a,
> +	&a1_sys_b_sel,
> +	&a1_sys_b_div,
> +	&a1_sys_b,
>  	&a1_dspa_a_sel,
>  	&a1_dspa_a_div,
>  	&a1_dspa_a,
>  	&a1_dspa_b_sel,
>  	&a1_dspa_b_div,
>  	&a1_dspa_b,
> -	&a1_dspa_sel,
>  	&a1_dspb_a_sel,
>  	&a1_dspb_a_div,
>  	&a1_dspb_a,
>  	&a1_dspb_b_sel,
>  	&a1_dspb_b_div,
>  	&a1_dspb_b,
> -	&a1_dspb_sel,
> -	&a1_dspa_en,
> -	&a1_dspa_en_nic,
> -	&a1_dspb_en,
> -	&a1_dspb_en_nic,
> -	&a1_24m,
> -	&a1_12m,
> +	&a1_rtc_32k_clkin,
> +	&a1_rtc_32k_div,
> +	&a1_rtc_32k_xtal,
> +	&a1_rtc_32k_sel,
> +	&a1_cecb_32k_clkin,
> +	&a1_cecb_32k_div,
> +	&a1_cecb_32k_sel_pre,
> +	&a1_cecb_32k_sel,
> +	&a1_ceca_32k_clkin,
> +	&a1_ceca_32k_div,
> +	&a1_ceca_32k_sel_pre,
> +	&a1_ceca_32k_sel,
>  	&a1_fclk_div2_divn_pre,
> -	&a1_fclk_div2_divn,
>  	&a1_gen_sel,
>  	&a1_gen_div,
> -	&a1_gen,
> -	&a1_saradc_sel,
>  	&a1_saradc_div,
> -	&a1_saradc_clk,
>  	&a1_pwm_a_sel,
>  	&a1_pwm_a_div,
> -	&a1_pwm_a,
>  	&a1_pwm_b_sel,
>  	&a1_pwm_b_div,
> -	&a1_pwm_b,
>  	&a1_pwm_c_sel,
>  	&a1_pwm_c_div,
> -	&a1_pwm_c,
>  	&a1_pwm_d_sel,
>  	&a1_pwm_d_div,
> -	&a1_pwm_d,
>  	&a1_pwm_e_sel,
>  	&a1_pwm_e_div,
> -	&a1_pwm_e,
>  	&a1_pwm_f_sel,
>  	&a1_pwm_f_div,
> -	&a1_pwm_f,
>  	&a1_spicc_sel,
>  	&a1_spicc_div,
>  	&a1_spicc_sel2,
> -	&a1_spicc,
>  	&a1_ts_div,
> -	&a1_ts,
>  	&a1_spifc_sel,
>  	&a1_spifc_div,
>  	&a1_spifc_sel2,
> -	&a1_spifc,
>  	&a1_usb_bus_sel,
>  	&a1_usb_bus_div,
> -	&a1_usb_bus,
>  	&a1_sd_emmc_sel,
>  	&a1_sd_emmc_div,
>  	&a1_sd_emmc_sel2,
> -	&a1_sd_emmc,
>  	&a1_psram_sel,
>  	&a1_psram_div,
>  	&a1_psram_sel2,
> -	&a1_psram,
>  	&a1_dmc_sel,
>  	&a1_dmc_div,
>  	&a1_dmc_sel2,
> -	&a1_dmc,
> -	&a1_sys_b_sel,
> -	&a1_sys_b_div,
> -	&a1_sys_b,
> -	&a1_sys_a_sel,
> -	&a1_sys_a_div,
> -	&a1_sys_a,
> -	&a1_sys_clk,
> -	&a1_rtc_32k_clkin,
> -	&a1_rtc_32k_div,
> -	&a1_rtc_32k_xtal,
> -	&a1_rtc_32k_sel,
> -	&a1_rtc_clk,
> -	&a1_ceca_32k_clkin,
> -	&a1_ceca_32k_div,
> -	&a1_ceca_32k_sel_pre,
> -	&a1_ceca_32k_sel,
> -	&a1_ceca_32k_clkout,
> -	&a1_cecb_32k_clkin,
> -	&a1_cecb_32k_div,
> -	&a1_cecb_32k_sel_pre,
> -	&a1_cecb_32k_sel,
> -	&a1_cecb_32k_clkout,
>  };
>  
> -static struct regmap_config clkc_regmap_config = {
> -	.reg_bits       = 32,
> -	.val_bits       = 32,
> -	.reg_stride     = 4,
> +static const struct meson_a1_clkc_data a1_periphs_clkc __maybe_unused = {
> +	.hw = &a1_periphs_hw_onecell_data,
> +	.regs = a1_periphs_regmaps,
> +	.num_regs = ARRAY_SIZE(a1_periphs_regmaps),
>  };
>  
> -static int meson_a1_periphs_probe(struct platform_device *pdev)
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
> -	for (i = 0; i < ARRAY_SIZE(a1_periphs_regmaps); i++)
> -		a1_periphs_regmaps[i]->map = map;
> -
> -	for (i = 0; i < a1_periphs_hw_onecell_data.num; i++) {
> -		/* array might be sparse */
> -		if (!a1_periphs_hw_onecell_data.hws[i])
> -			continue;
> -
> -		ret = devm_clk_hw_register(dev,
> -					   a1_periphs_hw_onecell_data.hws[i]);
> -		if (ret) {
> -			dev_err(dev, "Clock registration failed\n");
> -			return ret;
> -		}
> -	}
> -
> -	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> -					   &a1_periphs_hw_onecell_data);
> -}
> -
> -static const struct of_device_id clkc_match_table[] = {
> -	{ .compatible = "amlogic,a1-periphs-clkc", },
> -	{}
> +#ifdef CONFIG_OF
> +static const struct of_device_id a1_periphs_clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,a1-periphs-clkc",
> +		.data = &a1_periphs_clkc,
> +	},
> +	{},
>  };
> +MODULE_DEVICE_TABLE(of, a1_periphs_clkc_match_table);
> +#endif /* CONFIG_OF */
>  
> -static struct platform_driver a1_periphs_driver = {
> -	.probe		= meson_a1_periphs_probe,
> -	.driver		= {
> -		.name	= "a1-periphs-clkc",
> -		.of_match_table = clkc_match_table,
> +static struct platform_driver a1_periphs_clkc_driver = {
> +	.probe = meson_a1_clkc_probe,
> +	.driver = {
> +		.name = "a1-periphs-clkc",
> +		.of_match_table = of_match_ptr(a1_periphs_clkc_match_table),
>  	},
>  };
>  
> -builtin_platform_driver(a1_periphs_driver);
> +module_platform_driver(a1_periphs_clkc_driver);
> +MODULE_AUTHOR("Jian Hu <jian.hu@amlogic.com>");
> +MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/a1.h b/drivers/clk/meson/a1.h
> index 1ae5e04848d6..94b155e33568 100644
> --- a/drivers/clk/meson/a1.h
> +++ b/drivers/clk/meson/a1.h
> @@ -1,6 +1,12 @@
>  /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>  /*
> + * Amlogic Meson-A1 Peripheral Clock Controller internals
> + *
>   * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + * Author: Jian Hu <jian.hu@amlogic.com>
> + *
> + * Copyright (c) 2022, SberDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>   */
>  
>  #ifndef __A1_H
> @@ -12,7 +18,6 @@
>  #define RTC_BY_OSCIN_CTRL1		0x8
>  #define RTC_CTRL			0xc
>  #define SYS_CLK_CTRL0			0x10
> -#define AXI_CLK_CTRL0			0x14
>  #define SYS_CLK_EN0			0x1c
>  #define SYS_CLK_EN1			0x20
>  #define AXI_CLK_EN			0x24
> @@ -22,13 +27,6 @@
>  #define DSPB_CLK_CTRL0			0x34
>  #define CLK12_24_CTRL			0x38
>  #define GEN_CLK_CTRL			0x3c
> -#define TIMESTAMP_CTRL0			0x40
> -#define TIMESTAMP_CTRL1			0x44
> -#define TIMESTAMP_CTRL2			0x48
> -#define TIMESTAMP_VAL0			0x4c
> -#define TIMESTAMP_VAL1			0x50
> -#define TIMEBASE_CTRL0			0x54
> -#define TIMEBASE_CTRL1			0x58
>  #define SAR_ADC_CLK_CTRL		0xc0
>  #define PWM_CLK_AB_CTRL			0xc4
>  #define PWM_CLK_CD_CTRL			0xc8
> @@ -44,8 +42,6 @@
>  #define CECB_CLK_CTRL1			0xf0
>  #define PSRAM_CLK_CTRL			0xf4
>  #define DMC_CLK_CTRL			0xf8
> -#define FCLK_DIV1_SEL			0xfc
> -#define TST_CTRL			0x100
>  
>  #define CLKID_XTAL_CLKTREE		0
>  #define CLKID_SYS_A_SEL			89

