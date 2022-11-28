Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406C863AA5E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiK1ODz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiK1ODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:03:50 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D08A478;
        Mon, 28 Nov 2022 06:02:50 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 28 Nov
 2022 22:02:47 +0800
Message-ID: <c9551542-6224-f443-bfce-cc537771220b@amlogic.com>
Date:   Mon, 28 Nov 2022 22:02:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V5 3/4] clk: meson: s4: add s4 SoC peripheral clock
 controller driver and bindings
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <kelvin.zhang@amlogic.com>
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-4-yu.tu@amlogic.com>
 <1jbkov2vb9.fsf@starbuckisacylon.baylibre.com>
 <81d9a794-2920-64f1-1d80-50653113624c@amlogic.com>
 <1jilizp8bs.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jilizp8bs.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On 2022/11/28 20:23, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Mon 28 Nov 2022 at 16:08, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>>>> +
>>>> +/*
>>>> + * This RTC clock can be supplied by an external 32KHz crystal oscillator.
>>>> + * If it is used, it should be documented in using fw_name and documented in the
>>>> + * Bindings. Not currently in use on this board, so skip it.
>>>> + */
>>>> +static u32 rtc_clk_sel[] = { 0, 1 };
>>> No reason to do that
>>
>> I'm going to change it to static u32 rtc_clk_sel[] = { 0, 1, 2 };.
>> I don't know if that's okay with you?
> 
> ... then there is no need to specify this table.
> 

I got it.I'll change it as you suggest.

> 
> 
>>
>>>
>>>> +static const struct clk_parent_data rtc_clk_sel_parent_data[] = {
>>>> +	{ .hw = &s4_rtc_32k_by_oscin.hw },
>>>> +	{ .hw = &s4_rtc_32k_by_oscin_div.hw },
>>>> +	{ .fw_name = "ext_32k",  }
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_rtc_clk = {
>>>> +	.data = &(struct clk_regmap_mux_data) {
>>>> +		.offset = CLKCTRL_RTC_CTRL,
>>>> +		.mask = 0x3,
>>>> +		.shift = 0,
>>>> +		.table = rtc_clk_sel,
>>>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>>>> +	},
>>>> +	.hw.init = &(struct clk_init_data){
>>>> +		.name = "rtc_clk_sel",
>>>> +		.ops = &clk_regmap_mux_ops,
>>>> +		.parent_data = rtc_clk_sel_parent_data,
>>>> +		.num_parents = 2,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>> +	},
>>>> +};
>>>> +
> 
> [...]
> 
>>>> +
>>>> +/* Video Clocks */
>>>> +static struct clk_regmap s4_vid_pll_div = {
>>>> +	.data = &(struct meson_vid_pll_div_data){
>>>> +		.val = {
>>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>>> +			.shift   = 0,
>>>> +			.width   = 15,
>>>> +		},
>>>> +		.sel = {
>>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>>> +			.shift   = 16,
>>>> +			.width   = 2,
>>>> +		},
>>>> +	},
>>>> +	.hw.init = &(struct clk_init_data) {
>>>> +		.name = "vid_pll_div",
>>>> +		/* Same to g12a */
>>>> +		.ops = &meson_vid_pll_div_ro_ops,
>>> Please add an helpful explanation.
>>> 'Same to g12a' is not helpful.
>>>
>>
>> "Because the vid_pll_div clock is a clock that does not need to change the
>> divisor, ops only provides meson_vid_pll_div_ro_ops."
>> I wonder if this description is ok for you?
> 
> I understand this divider will not change with RO ops.
> I'm interrested why it does not change and how it is expected to be setup.
> 

Maybe you can be more specific, I don't understand, you're interested in 
that part of it specifically.

I don't know if you have the document of chip. If not, I can provide it 
to you privately. You can ask specific questions in conjunction with 
your documentation and submission(The original submission came from you.).
I can give you a specific answer or ask the chip designer to give you a 
reply.Do you think that's okay with you

>>
>>>> +		.parent_data = (const struct clk_parent_data []) {
>>>> +			{ .fw_name = "hdmi_pll", }
>>>> +		},
>>>> +		.num_parents = 1,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>> +	},
>>>> +};
> 
> [...]
> 
>>>> +
>>>> +static struct clk_regmap s4_vclk_sel = {
>>>> +	.data = &(struct clk_regmap_mux_data){
>>>> +		.offset = CLKCTRL_VID_CLK_CTRL,
>>>> +		.mask = 0x7,
>>>> +		.shift = 16,
>>>> +	},
>>>> +	.hw.init = &(struct clk_init_data){
>>>> +		.name = "vclk_sel",
>>>> +		.ops = &clk_regmap_mux_ops,
>>>> +		.parent_data = s4_vclk_parent_data,
>>>> +		.num_parents = ARRAY_SIZE(s4_vclk_parent_data),
>>>> +	},
>>> You are stopping rate propagation here.
>>> It deserves an explanation. Same goes below.
>>
>> "When the driver uses this clock, needs to specify the patent clock he
>> wants in the dts."
>> Is ok for you?
> 
> Then you still don't understand the clock flag usage.
> 
> Preserving the parent selection (CLK_SET_RATE_NO_REPARENT) and rate
> propagation (CLK_SET_RATE_PARENT) is not the same thing.
> 
> As it stands, your comment is not aliged with what you do.
> 

Thanks for the explanation of flag.
My goal is to have the clock user describe themselves in DTS using the 
parent, or using the assigned-clocks and assigned-clock-parents settings 
in DTS. According to your explanation, some clocks like this should use 
CLK_SET_RATE_NO_REPARENT, right?

>>
>>>
>>>> +};
> 
> .
