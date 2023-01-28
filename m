Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9208467F707
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjA1KS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjA1KSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:18:34 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4071732;
        Sat, 28 Jan 2023 02:17:46 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Sat, 28 Jan
 2023 18:17:43 +0800
Message-ID: <a4ad6ac6-60c2-8f7b-fdb0-509de31db282@amlogic.com>
Date:   Sat, 28 Jan 2023 18:17:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V6 3/3] clk: meson: s4: add support for Amlogic S4 SoC
 peripheral clock controller
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
CC:     "kelvin . zhang" <Kelvin.Zhang@amlogic.com>,
        "qi . duan" <qi.duan@amlogic.com>
References: <20230116074214.2326-1-yu.tu@amlogic.com>
 <20230116074214.2326-4-yu.tu@amlogic.com>
 <1ja62eybrv.fsf@starbuckisacylon.baylibre.com>
 <aedb0764-b5cb-7f49-f279-51dbec070e80@amlogic.com>
 <1jwn5hwn0w.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jwn5hwn0w.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/20 17:47, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Fri 20 Jan 2023 at 11:33, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Hi
>> On 2023/1/19 19:37, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>> On Mon 16 Jan 2023 at 15:42, Yu Tu <yu.tu@amlogic.com> wrote:
>>>
>>>> Add the peripherals clock controller driver in the s4 SoC family.
>>>>
>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>> [...]
>>>
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
>>>> +		/*
>>>> +		 * The frequency division from the hdmi_pll clock to the vid_pll_div
>>>> +		 * clock is the default value of this register. When designing the
>>>> +		 * video module of the chip, a default value that can meet the
>>>> +		 * requirements of the video module will be solidified according
>>>> +		 * to the usage requirements of the chip, so as to facilitate chip
>>>> +		 * simulation. So this is ro_ops.
>>>> +		 * It is important to note that this clock is not used on this
>>>> +		 * chip and is described only for the integrity of the clock tree.
>>>> +		 */
>>> If it is reset value and will be applicable to all the design, regarless
>>> of the use-case, then yes RO ops is OK
>>>
>>> >From what I understand here, the value will depend on the use-case requirements.
>>> This is a typical case where the DT prop "assigned-rate" should be used, not RO ops.
>>
>> Check the previous chip history, the actual scene is not used at all,
>> basically is used in simulation. So the previous SOC was "ro_ops" without
>> any problems.  This S4 SOC is not actually useful either.
>>
>> So when you were upstream, you had no problem making "ro_ops". I wonder if
>> I could delete this useless clock, so you don't have to worry about it.
> 
> I don't know what to make of this. What is the point of adding a useless
> clock ?

As explained earlier this "vid_pll_div" is actually used in chip 
emulation. So next I'd like to know what you suggest to do with the clock?

By the way, the late S-Series chips removed this clock.

> 
>>
>>>
>>>> +		.ops = &meson_vid_pll_div_ro_ops,
>>>> +		.parent_data = (const struct clk_parent_data []) {
>>>> +			{ .fw_name = "hdmi_pll", }
>>>> +		},
>>>> +		.num_parents = 1,
>>>> +		.flags = CLK_SET_RATE_PARENT,
>>>> +	},
>>>> +};
>>>> +
>>>
>>>> +
>>>> +/* VDEC clocks */
>>>> +static const struct clk_parent_data s4_dec_parent_data[] = {
>>>> +	{ .fw_name = "fclk_div2p5", },
>>>> +	{ .fw_name = "fclk_div3", },
>>>> +	{ .fw_name = "fclk_div4", },
>>>> +	{ .fw_name = "fclk_div5", },
>>>> +	{ .fw_name = "fclk_div7", },
>>>> +	{ .fw_name = "hifi_pll", },
>>>> +	{ .fw_name = "gp0_pll", },
>>>> +	{ .fw_name = "xtal", }
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_vdec_p0_mux = {
>>>> +	.data = &(struct clk_regmap_mux_data){
>>>> +		.offset = CLKCTRL_VDEC_CLK_CTRL,
>>>> +		.mask = 0x7,
>>>> +		.shift = 9,
>>>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>>>> +	},
>>>> +	.hw.init = &(struct clk_init_data) {
>>>> +		.name = "vdec_p0_mux",
>>>> +		.ops = &clk_regmap_mux_ops,
>>>> +		.parent_data = s4_dec_parent_data,
>>>> +		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
>>>> +		/*
>>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>>> +		 * he wants in the dts.
>>> s/patent/parent ?
>>> s/he wants/it requires ?
>>
>> Okay.
>>
>>>
>>>> +		 */
>>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>>> +	},
>>>> +};
>>>> +
>>> [...]
>>>
>>>> +static const struct clk_parent_data s4_vpu_clkc_parent_data[] = {
>>>> +	{ .fw_name = "fclk_div4", },
>>>> +	{ .fw_name = "fclk_div3", },
>>>> +	{ .fw_name = "fclk_div5", },
>>>> +	{ .fw_name = "fclk_div7", },
>>>> +	{ .fw_name = "mpll1", },
>>>> +	{ .hw = &s4_vid_pll.hw },
>>>> +	{ .fw_name = "mpll2", },
>>>> +	{ .fw_name = "gp0_pll", },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_vpu_clkc_p0_mux  = {
>>>> +	.data = &(struct clk_regmap_mux_data){
>>>> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
>>>> +		.mask = 0x7,
>>>> +		.shift = 9,
>>>> +	},
>>>> +	.hw.init = &(struct clk_init_data) {
>>>> +		.name = "vpu_clkc_p0_mux",
>>>> +		.ops = &clk_regmap_mux_ops,
>>>> +		.parent_data = s4_vpu_clkc_parent_data,
>>>> +		.num_parents = ARRAY_SIZE(s4_vpu_clkc_parent_data),
>>>> +		/*
>>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>>> +		 * he wants in the dts.
>>>> +		 */
>>> That's quite a lot of occurences of the same comment.
>>> At the same time, other clocks with the same flag have no comment.
>>> Please make general comment, before the Video/VPU section, explaining
>>> which clocks needs on a use-case basis (through DT) and possibly how it
>>> should be set, what should drive the choices.
>>>
>>
>> The owner of the corresponding driver module wants to have a fixed clock,
>> but I can't explain every specific reason.
> 
> Why can't you ?
> 
>> So I'm going to change it all
>> to.flags = CLK_SET_RATE_PARENT in the next version. Let CCF choose the
>> appropriate clock as you suggested. If there is a corresponding module you
>> want to change, ask him to give you a specific explanation. Do you think
>> that's all right?
> 
> If the flag is actually required and there is a reason, no it is not.
> 

I will try to communicate with each module that uses the corresponding 
clock and provide an explanation if necessary in next edition.

>>
>> I will not reply to you below.
> 
> Noted.
> 
>>
>>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>>> +	},
>>>> +};
>>>> +
>>>
>>>> +
>>>> +/* EMMC/NAND clock */
>>>> +static const struct clk_parent_data s4_sd_emmc_clk0_parent_data[] = {
>>>> +	{ .fw_name = "xtal", },
>>>> +	{ .fw_name = "fclk_div2", },
>>>> +	{ .fw_name = "fclk_div3", },
>>>> +	{ .fw_name = "hifi_pll", },
>>>> +	{ .fw_name = "fclk_div2p5", },
>>>> +	{ .fw_name = "mpll2", },
>>>> +	{ .fw_name = "mpll3", },
>>>> +	{ .fw_name = "gp0_pll", },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_sd_emmc_c_clk0_sel = {
>>>> +	.data = &(struct clk_regmap_mux_data){
>>>> +		.offset = CLKCTRL_NAND_CLK_CTRL,
>>>> +		.mask = 0x7,
>>>> +		.shift = 9,
>>>> +	},
>>>> +	.hw.init = &(struct clk_init_data) {
>>>> +		.name = "sd_emmc_c_clk0_sel",
>>>> +		.ops = &clk_regmap_mux_ops,
>>>> +		.parent_data = s4_sd_emmc_clk0_parent_data,
>>>> +		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
>>>> +		/*
>>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>>> +		 * he wants in the dts.
>>>> +		 */
>>> I'm getting a bit suspicious about the use (and abuse ...) of this flag.
>>> I don't quite get how selecting the base PLL for MMC should be done on
>>> use-case basis and should be up the board DT ...
>>> Other SoC have all used fdiv2 so far. Do you expect this setting to be
>>> part of the dtsi SoC file ?
>>>
>>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>>> +	},
>>>> +};
>>>> +
>>>
>>>> +
>>>> +/* SPICC Clock */
>>>> +static const struct clk_parent_data s4_spicc_parent_data[] = {
>>>> +	{ .fw_name = "xtal", },
>>>> +	{ .hw = &s4_sys_clk.hw },
>>>> +	{ .fw_name = "fclk_div4", },
>>>> +	{ .fw_name = "fclk_div3", },
>>>> +	{ .fw_name = "fclk_div2", },
>>>> +	{ .fw_name = "fclk_div5", },
>>>> +	{ .fw_name = "fclk_div7", },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_spicc0_mux = {
>>>> +	.data = &(struct clk_regmap_mux_data){
>>>> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
>>>> +		.mask = 0x7,
>>>> +		.shift = 7,
>>>> +	},
>>>> +	.hw.init = &(struct clk_init_data) {
>>>> +		.name = "spicc0_mux",
>>>> +		.ops = &clk_regmap_mux_ops,
>>>> +		.parent_data = s4_spicc_parent_data,
>>>> +		.num_parents = ARRAY_SIZE(s4_spicc_parent_data),
>>>> +		/*
>>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>>> +		 * he wants in the dts.
>>>> +		 */
>>> This is getting too far. All the parent clocks are fixed.
>>> Let CCF do the job of picking the most adequate clock for the job
>>> instead of manually settings things
>>>
>>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>>> +	},
>>>> +};
>>>> +
>>>
>>>> +
>>>> +/* PWM Clock */
>>>> +static const struct clk_parent_data s4_pwm_parent_data[] = {
>>>> +	{ .fw_name = "xtal", },
>>>> +	{ .hw = &s4_vid_pll.hw },
>>>> +	{ .fw_name = "fclk_div4", },
>>>> +	{ .fw_name = "fclk_div3", },
>>>> +};
>>>> +
>>>> +static struct clk_regmap s4_pwm_a_mux = {
>>>> +	.data = &(struct clk_regmap_mux_data) {
>>>> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
>>>> +		.mask = 0x3,
>>>> +		.shift = 9,
>>>> +	},
>>>> +	.hw.init = &(struct clk_init_data){
>>>> +		.name = "pwm_a_mux",
>>>> +		.ops = &clk_regmap_mux_ops,
>>>> +		.parent_data = s4_pwm_parent_data,
>>>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>>>> +		/*
>>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>>> +		 * he wants in the dts.
>>>> +		 */
>>> Same here ... this is really going to far.
>>>
>>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>>> +	},
>>>> +};
>>>> +
>>>
>>>> +
>>>> +static struct clk_regmap s4_saradc_mux = {
>>>> +	.data = &(struct clk_regmap_mux_data) {
>>>> +		.offset = CLKCTRL_SAR_CLK_CTRL,
>>>> +		.mask = 0x3,
>>>> +		.shift = 9,
>>>> +	},
>>>> +	.hw.init = &(struct clk_init_data){
>>>> +		.name = "saradc_mux",
>>>> +		.ops = &clk_regmap_mux_ops,
>>>> +		.parent_data = (const struct clk_parent_data []) {
>>>> +			{ .fw_name = "xtal", },
>>>> +			{ .hw = &s4_sys_clk.hw },
>>>> +		},
>>>> +		.num_parents = 2,
>>>> +		/*
>>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>>> +		 * he wants in the dts.
>>>> +		 */
>>> For each clock type, if this flag is going to be used, I'd like a clear
>>> explanation about why it is use-case dependent and why you need manual
>>> control over this. Same applies to all the occurence.
>>>
>>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>>> +	},
>>>> +};
>>>
> 
