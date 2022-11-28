Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E0563A87C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiK1Mdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiK1Mdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:33:32 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78C1A062
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:33:31 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so11527246wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=+gmo9nIirdbed4J/LDnU4BNvdJRcxPBpHK1YwQWHx3A=;
        b=Ov/KaEuWs1Y8eHtYdGfDUCbL84zNHUFESCRmPJbwiL4b4IkVYPUs0G1f90nHsfQ/zv
         ehKTVNWofEcOeyX9H++dsbFfqvqpLv4UI5SpMeltJX+7PhkxVUhqbOS5sWWAgao/afWy
         Vmu2IYeujw1lNxavecWXZtBV2Xt7zVVCw10XpuwEZq0dkxd13hpGwtmlvIqyQeE/KNoX
         rA3Xh3b7GEY59tYVfwF7IRQcBMpp4dMqeAK/0dBG+Bw03kgBT6s60v17KxK+pPdPro6G
         FLxZbP+uH3QEA3DqFca6aUkawOebjlWwlLD1jmOpKkTr40d27MyLfvvmN0ta9OMOThQY
         4WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gmo9nIirdbed4J/LDnU4BNvdJRcxPBpHK1YwQWHx3A=;
        b=4gEeHJ+WBdCla5Oyd3oUDlLFNhxxaWqrFAVWPn9fN17S/lf4aFlSSXsl2pfcJzNf+t
         rx0Fy5oMqOSdz45zWc/gi8D/wYjKv3h3yZbOAF8YbJAyobnueQEHYlsGCDr951fmOHQZ
         gm2eIjZtRkhDw7VM2oEjml2d7Fl8j6s+0uH3Pu3fnAFQqjagZlSks9C5r1+W3RHW1JaB
         vn9t8Tq2ak5MivLZp8nXTpRWlnBgJQ/SZdOEDBl+UQqW7D4iT+7VY472YyGSQlHFDCTz
         V41Nv3uPGzz1m0UL1CgiFhRJTrcmkucNvHUL+luw+tyBA8sCQzlPlnVODuDxguCRMuWd
         jzLw==
X-Gm-Message-State: ANoB5pnvRT8LrjtnSv2MhsRm6WMRfbgF+FPK0sSEQ0i6k8H8X/lktXZ9
        GerlvxCb/W9pJB6J+omz1dsqFw==
X-Google-Smtp-Source: AA0mqf4jVHezM2bL21HVhzKH1EZ/A3CxuShkRmJj0N14THKAhU4L/c00faHr4CoC1CPZ4bH3MFrAHA==
X-Received: by 2002:a05:600c:35cf:b0:3cf:aa11:93a8 with SMTP id r15-20020a05600c35cf00b003cfaa1193a8mr41173747wmq.31.1669638809617;
        Mon, 28 Nov 2022 04:33:29 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id bs30-20020a056000071e00b002364c77bcacsm10489898wrb.38.2022.11.28.04.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:33:28 -0800 (PST)
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-4-yu.tu@amlogic.com>
 <1jbkov2vb9.fsf@starbuckisacylon.baylibre.com>
 <81d9a794-2920-64f1-1d80-50653113624c@amlogic.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com
Subject: Re: [PATCH V5 3/4] clk: meson: s4: add s4 SoC peripheral clock
 controller driver and bindings
Date:   Mon, 28 Nov 2022 13:23:08 +0100
In-reply-to: <81d9a794-2920-64f1-1d80-50653113624c@amlogic.com>
Message-ID: <1jilizp8bs.fsf@starbuckisacylon.baylibre.com>
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


On Mon 28 Nov 2022 at 16:08, Yu Tu <yu.tu@amlogic.com> wrote:

>>> +
>>> +/*
>>> + * This RTC clock can be supplied by an external 32KHz crystal oscillator.
>>> + * If it is used, it should be documented in using fw_name and documented in the
>>> + * Bindings. Not currently in use on this board, so skip it.
>>> + */
>>> +static u32 rtc_clk_sel[] = { 0, 1 };
>> No reason to do that
>
> I'm going to change it to static u32 rtc_clk_sel[] = { 0, 1, 2 };.
> I don't know if that's okay with you?

... then there is no need to specify this table.



>
>> 
>>> +static const struct clk_parent_data rtc_clk_sel_parent_data[] = {
>>> +	{ .hw = &s4_rtc_32k_by_oscin.hw },
>>> +	{ .hw = &s4_rtc_32k_by_oscin_div.hw },
>>> +	{ .fw_name = "ext_32k",  }
>>> +};
>>> +
>>> +static struct clk_regmap s4_rtc_clk = {
>>> +	.data = &(struct clk_regmap_mux_data) {
>>> +		.offset = CLKCTRL_RTC_CTRL,
>>> +		.mask = 0x3,
>>> +		.shift = 0,
>>> +		.table = rtc_clk_sel,
>>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data){
>>> +		.name = "rtc_clk_sel",
>>> +		.ops = &clk_regmap_mux_ops,
>>> +		.parent_data = rtc_clk_sel_parent_data,
>>> +		.num_parents = 2,
>>> +		.flags = CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +

[...]

>>> +
>>> +/* Video Clocks */
>>> +static struct clk_regmap s4_vid_pll_div = {
>>> +	.data = &(struct meson_vid_pll_div_data){
>>> +		.val = {
>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>> +			.shift   = 0,
>>> +			.width   = 15,
>>> +		},
>>> +		.sel = {
>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>> +			.shift   = 16,
>>> +			.width   = 2,
>>> +		},
>>> +	},
>>> +	.hw.init = &(struct clk_init_data) {
>>> +		.name = "vid_pll_div",
>>> +		/* Same to g12a */
>>> +		.ops = &meson_vid_pll_div_ro_ops,
>> Please add an helpful explanation.
>> 'Same to g12a' is not helpful.
>> 
>
> "Because the vid_pll_div clock is a clock that does not need to change the
> divisor, ops only provides meson_vid_pll_div_ro_ops."
> I wonder if this description is ok for you?

I understand this divider will not change with RO ops.
I'm interrested why it does not change and how it is expected to be setup.

>
>>> +		.parent_data = (const struct clk_parent_data []) {
>>> +			{ .fw_name = "hdmi_pll", }
>>> +		},
>>> +		.num_parents = 1,
>>> +		.flags = CLK_SET_RATE_PARENT,
>>> +	},
>>> +};

[...]

>>> +
>>> +static struct clk_regmap s4_vclk_sel = {
>>> +	.data = &(struct clk_regmap_mux_data){
>>> +		.offset = CLKCTRL_VID_CLK_CTRL,
>>> +		.mask = 0x7,
>>> +		.shift = 16,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data){
>>> +		.name = "vclk_sel",
>>> +		.ops = &clk_regmap_mux_ops,
>>> +		.parent_data = s4_vclk_parent_data,
>>> +		.num_parents = ARRAY_SIZE(s4_vclk_parent_data),
>>> +	},
>> You are stopping rate propagation here.
>> It deserves an explanation. Same goes below.
>
> "When the driver uses this clock, needs to specify the patent clock he
> wants in the dts."
> Is ok for you?

Then you still don't understand the clock flag usage.

Preserving the parent selection (CLK_SET_RATE_NO_REPARENT) and rate
propagation (CLK_SET_RATE_PARENT) is not the same thing.

As it stands, your comment is not aliged with what you do.

>
>> 
>>> +};
