Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B735763A27A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiK1IJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiK1IJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:09:51 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42C0140ED;
        Mon, 28 Nov 2022 00:08:56 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 28 Nov
 2022 16:08:54 +0800
Message-ID: <81d9a794-2920-64f1-1d80-50653113624c@amlogic.com>
Date:   Mon, 28 Nov 2022 16:08:53 +0800
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
        Neil Armstrong <narmstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <kelvin.zhang@amlogic.com>
References: <20221123021346.18136-1-yu.tu@amlogic.com>
 <20221123021346.18136-4-yu.tu@amlogic.com>
 <1jbkov2vb9.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jbkov2vb9.fsf@starbuckisacylon.baylibre.com>
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

On 2022/11/25 17:54, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Wed 23 Nov 2022 at 10:13, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Add the peripherals clock controller found and bindings in the s4 SoC family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   .../clock/amlogic,s4-peripherals-clkc.yaml    |  105 +
>>   drivers/clk/meson/Kconfig                     |   12 +
>>   drivers/clk/meson/Makefile                    |    1 +
>>   drivers/clk/meson/s4-peripherals.c            | 3783 +++++++++++++++++
>>   drivers/clk/meson/s4-peripherals.h            |  218 +
>>   .../clock/amlogic,s4-peripherals-clkc.h       |  131 +
>>   6 files changed, 4250 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>   create mode 100644 drivers/clk/meson/s4-peripherals.c
>>   create mode 100644 drivers/clk/meson/s4-peripherals.h
>>   create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>> new file mode 100644
>> index 000000000000..d1ea05ab7ec9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>> @@ -0,0 +1,105 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-peripherals-clkc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic Meson S serials Peripherals Clock Controller
>> +
>> +maintainers:
>> +  - Neil Armstrong <narmstrong@baylibre.com>
>> +  - Jerome Brunet <jbrunet@baylibre.com>
>> +  - Yu Tu <yu.hu@amlogic.com>
>> +
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,s4-peripherals-clkc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: input fixed pll div2
>> +      - description: input fixed pll div2p5
>> +      - description: input fixed pll div3
>> +      - description: input fixed pll div4
>> +      - description: input fixed pll div5
>> +      - description: input fixed pll div7
>> +      - description: input hifi pll
>> +      - description: input gp0 pll
>> +      - description: input mpll0
>> +      - description: input mpll1
>> +      - description: input mpll2
>> +      - description: input mpll3
>> +      - description: input hdmi pll
>> +      - description: input oscillator (usually at 24MHz)
>> +      - description: input external 32kHz reference (optional)
>> +
>> +  clock-names:
>> +    items:
>> +      - const: fclk_div2
>> +      - const: fclk_div2p5
>> +      - const: fclk_div3
>> +      - const: fclk_div4
>> +      - const: fclk_div5
>> +      - const: fclk_div7
>> +      - const: hifi_pll
>> +      - const: gp0_pll
>> +      - const: mpll0
>> +      - const: mpll1
>> +      - const: mpll2
>> +      - const: mpll3
>> +      - const: hdmi_pll
>> +      - const: xtal
>> +      - const: ext_32k
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>> +
>> +    /* 32KHz reference crystal */
>> +    ext_32k: ref32k {
>> +        compatible = "fixed-clock";
>> +        #clock-cells = <0>;
>> +        clock-frequency = <32000>;
>> +    };
>> +
>> +    clkc_periphs: clock-controller@fe000000 {
>> +      compatible = "amlogic,s4-peripherals-clkc";
>> +      reg = <0xfe000000 0x49c>;
>> +      clocks = <&clkc_pll 3>,
>> +              <&clkc_pll 13>,
>> +              <&clkc_pll 5>,
>> +              <&clkc_pll 7>,
>> +              <&clkc_pll 9>,
>> +              <&clkc_pll 11>,
>> +              <&clkc_pll 17>,
>> +              <&clkc_pll 15>,
>> +              <&clkc_pll 25>,
>> +              <&clkc_pll 27>,
>> +              <&clkc_pll 29>,
>> +              <&clkc_pll 31>,
>> +              <&clkc_pll 20>,
>> +              <&xtal>,
>> +              <&ext_32k>;
>> +      clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3", "fclk_div4",
>> +                    "fclk_div5", "fclk_div7", "hifi_pll", "gp0_pll",
>> +                    "mpll0", "mpll1", "mpll2", "mpll3", "hdmi_pll", "xtal",
>> +                    "ext_32k";
>> +      #clock-cells = <1>;
>> +    };
>> +...
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index a663c90a3f3b..a6eb9fa15c74 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -128,4 +128,16 @@ config COMMON_CLK_S4_PLL
>>   	  aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>>   	  Say Y if you want the board to work, because plls are the parent of most
>>   	  peripherals.
>> +
>> +config COMMON_CLK_S4
>> +	tristate "S4 SoC Peripherals clock controllers support"
>> +	depends on ARM64
>> +	default y
>> +	select COMMON_CLK_MESON_REGMAP
>> +	select COMMON_CLK_MESON_DUALDIV
>> +	select COMMON_CLK_MESON_VID_PLL_DIV
>> +	help
>> +	  Support for the Peripherals clock controller on Amlogic S805X2 and S905Y4
>> +	  devices, aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>> +	  Say Y if you want peripherals to work.
>>   endmenu
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 376f49cc13f1..c9130afccb48 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -20,3 +20,4 @@ obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>>   obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
>> +obj-$(CONFIG_COMMON_CLK_S4) += s4-peripherals.o
>> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
>> new file mode 100644
>> index 000000000000..8ce5156d3510
>> --- /dev/null
>> +++ b/drivers/clk/meson/s4-peripherals.c
>> @@ -0,0 +1,3783 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Amlogic Meson-S4 Peripherals Clock Controller Driver
>> + *
>> + * Copyright (c) 2021 Amlogic, inc.
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "clk-regmap.h"
>> +#include "vid-pll-div.h"
>> +#include "clk-dualdiv.h"
>> +#include "s4-peripherals.h"
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin_clkin = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +		.bit_idx = 31,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "rtc_32k_by_oscin_clkin",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_data = (const struct clk_parent_data []) {
>> +			{ .fw_name = "xtal", }
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static const struct meson_clk_dualdiv_param s4_32k_div_table[] = {
>> +	{
>> +		.dual	= 1,
>> +		.n1	= 733,
>> +		.m1	= 8,
>> +		.n2	= 732,
>> +		.m2	= 11,
>> +	},
>> +	{}
>> +};
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin_div = {
>> +	.data = &(struct meson_clk_dualdiv_data){
>> +		.n1 = {
>> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +			.shift   = 0,
>> +			.width   = 12,
>> +		},
>> +		.n2 = {
>> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +			.shift   = 12,
>> +			.width   = 12,
>> +		},
>> +		.m1 = {
>> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +			.shift   = 0,
>> +			.width   = 12,
>> +		},
>> +		.m2 = {
>> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +			.shift   = 12,
>> +			.width   = 12,
>> +		},
>> +		.dual = {
>> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +			.shift   = 28,
>> +			.width   = 1,
>> +		},
>> +		.table = s4_32k_div_table,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "rtc_32k_by_oscin_div",
>> +		.ops = &meson_clk_dualdiv_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_rtc_32k_by_oscin_clkin.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin_sel = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL1,
>> +		.mask = 0x1,
>> +		.shift = 24,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "rtc_32k_by_oscin_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_rtc_32k_by_oscin_div.hw,
>> +			&s4_rtc_32k_by_oscin_clkin.hw,
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_rtc_32k_by_oscin = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
>> +		.bit_idx = 30,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "rtc_32k_by_oscin",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_rtc_32k_by_oscin_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/*
>> + * This RTC clock can be supplied by an external 32KHz crystal oscillator.
>> + * If it is used, it should be documented in using fw_name and documented in the
>> + * Bindings. Not currently in use on this board, so skip it.
>> + */
>> +static u32 rtc_clk_sel[] = { 0, 1 };
> 
> No reason to do that

I'm going to change it to static u32 rtc_clk_sel[] = { 0, 1, 2 };.
I don't know if that's okay with you?

> 
>> +static const struct clk_parent_data rtc_clk_sel_parent_data[] = {
>> +	{ .hw = &s4_rtc_32k_by_oscin.hw },
>> +	{ .hw = &s4_rtc_32k_by_oscin_div.hw },
>> +	{ .fw_name = "ext_32k",  }
>> +};
>> +
>> +static struct clk_regmap s4_rtc_clk = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_RTC_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 0,
>> +		.table = rtc_clk_sel,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "rtc_clk_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = rtc_clk_sel_parent_data,
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* The index 5 is AXI_CLK, which is dedicated to AXI. So skip it. */
>> +static u32 mux_table_sys_ab_clk_sel[] = { 0, 1, 2, 3, 4, 6, 7 };
>> +static const struct clk_parent_data sys_ab_clk_parent_data[] = {
>> +	{ .fw_name = "xtal" },
>> +	{ .fw_name = "fclk_div2" },
>> +	{ .fw_name = "fclk_div3" },
>> +	{ .fw_name = "fclk_div4" },
>> +	{ .fw_name = "fclk_div5" },
>> +	{ .fw_name = "fclk_div7" },
>> +	{ .hw = &s4_rtc_clk.hw }
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_b_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
>> +		.mask = 0x7,
>> +		.shift = 26,
>> +		.table = mux_table_sys_ab_clk_sel,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sysclk_b_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = sys_ab_clk_parent_data,
>> +		.num_parents = ARRAY_SIZE(sys_ab_clk_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_b_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
>> +		.shift = 16,
>> +		.width = 10,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sysclk_b_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sysclk_b_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_b = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
>> +		.bit_idx = 29,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sysclk_b",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sysclk_b_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_a_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
>> +		.mask = 0x7,
>> +		.shift = 10,
>> +		.table = mux_table_sys_ab_clk_sel,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sysclk_a_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = sys_ab_clk_parent_data,
>> +		.num_parents = ARRAY_SIZE(sys_ab_clk_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_a_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
>> +		.shift = 0,
>> +		.width = 10,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sysclk_a_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sysclk_a_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sysclk_a = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
>> +		.bit_idx = 13,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sysclk_a",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sysclk_a_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sys_clk = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
>> +		.mask = 0x1,
>> +		.shift = 31,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sys_clk",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sysclk_a.hw,
>> +			&s4_sysclk_b.hw
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_clkin = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_CECA_CTRL0,
>> +		.bit_idx = 31,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "ceca_32k_clkin",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_data = (const struct clk_parent_data []) {
>> +			{ .fw_name = "xtal", }
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_div = {
>> +	.data = &(struct meson_clk_dualdiv_data){
>> +		.n1 = {
>> +			.reg_off = CLKCTRL_CECA_CTRL0,
>> +			.shift   = 0,
>> +			.width   = 12,
>> +		},
>> +		.n2 = {
>> +			.reg_off = CLKCTRL_CECA_CTRL0,
>> +			.shift   = 12,
>> +			.width   = 12,
>> +		},
>> +		.m1 = {
>> +			.reg_off = CLKCTRL_CECA_CTRL1,
>> +			.shift   = 0,
>> +			.width   = 12,
>> +		},
>> +		.m2 = {
>> +			.reg_off = CLKCTRL_CECA_CTRL1,
>> +			.shift   = 12,
>> +			.width   = 12,
>> +		},
>> +		.dual = {
>> +			.reg_off = CLKCTRL_CECA_CTRL0,
>> +			.shift   = 28,
>> +			.width   = 1,
>> +		},
>> +		.table = s4_32k_div_table,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "ceca_32k_div",
>> +		.ops = &meson_clk_dualdiv_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_ceca_32k_clkin.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_sel_pre = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_CECA_CTRL1,
>> +		.mask = 0x1,
>> +		.shift = 24,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "ceca_32k_sel_pre",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_ceca_32k_div.hw,
>> +			&s4_ceca_32k_clkin.hw
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_sel = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_CECA_CTRL1,
>> +		.mask = 0x1,
>> +		.shift = 31,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "ceca_32k_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_ceca_32k_sel_pre.hw,
>> +			&s4_rtc_clk.hw
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_ceca_32k_clkout = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_CECA_CTRL0,
>> +		.bit_idx = 30,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "ceca_32k_clkout",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_ceca_32k_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_clkin = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_CECB_CTRL0,
>> +		.bit_idx = 31,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "cecb_32k_clkin",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_data = (const struct clk_parent_data []) {
>> +			{ .fw_name = "xtal", }
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_div = {
>> +	.data = &(struct meson_clk_dualdiv_data){
>> +		.n1 = {
>> +			.reg_off = CLKCTRL_CECB_CTRL0,
>> +			.shift   = 0,
>> +			.width   = 12,
>> +		},
>> +		.n2 = {
>> +			.reg_off = CLKCTRL_CECB_CTRL0,
>> +			.shift   = 12,
>> +			.width   = 12,
>> +		},
>> +		.m1 = {
>> +			.reg_off = CLKCTRL_CECB_CTRL1,
>> +			.shift   = 0,
>> +			.width   = 12,
>> +		},
>> +		.m2 = {
>> +			.reg_off = CLKCTRL_CECB_CTRL1,
>> +			.shift   = 12,
>> +			.width   = 12,
>> +		},
>> +		.dual = {
>> +			.reg_off = CLKCTRL_CECB_CTRL0,
>> +			.shift   = 28,
>> +			.width   = 1,
>> +		},
>> +		.table = s4_32k_div_table,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "cecb_32k_div",
>> +		.ops = &meson_clk_dualdiv_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_cecb_32k_clkin.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_sel_pre = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_CECB_CTRL1,
>> +		.mask = 0x1,
>> +		.shift = 24,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "cecb_32k_sel_pre",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_cecb_32k_div.hw,
>> +			&s4_cecb_32k_clkin.hw
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_sel = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_CECB_CTRL1,
>> +		.mask = 0x1,
>> +		.shift = 31,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "cecb_32k_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_cecb_32k_sel_pre.hw,
>> +			&s4_rtc_clk.hw
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_cecb_32k_clkout = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_CECB_CTRL0,
>> +		.bit_idx = 30,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "cecb_32k_clkout",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_cecb_32k_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_parent_data s4_sc_parent_data[] = {
>> +	{ .fw_name = "fclk_div4" },
>> +	{ .fw_name = "fclk_div3" },
>> +	{ .fw_name = "fclk_div5" },
>> +	{ .fw_name = "xtal", }
>> +};
>> +
>> +static struct clk_regmap s4_sc_clk_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_SC_CLK_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sc_clk_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_sc_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_sc_parent_data),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sc_clk_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_SC_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sc_clk_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sc_clk_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sc_clk_gate = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_SC_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sc_clk_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sc_clk_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_12_24M_clk_gate = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_CLK12_24_CTRL,
>> +		.bit_idx = 11,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "12_24m_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_data = (const struct clk_parent_data []) {
>> +			{ .fw_name = "xtal", }
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor s4_12M_clk_div = {
>> +	.mult = 1,
>> +	.div = 2,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "12M",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_12_24M_clk_gate.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_12_24M_clk = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_CLK12_24_CTRL,
>> +		.mask = 0x1,
>> +		.shift = 10,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "12_24m",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_12_24M_clk_gate.hw,
>> +			&s4_12M_clk_div.hw,
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* Video Clocks */
>> +static struct clk_regmap s4_vid_pll_div = {
>> +	.data = &(struct meson_vid_pll_div_data){
>> +		.val = {
>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>> +			.shift   = 0,
>> +			.width   = 15,
>> +		},
>> +		.sel = {
>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>> +			.shift   = 16,
>> +			.width   = 2,
>> +		},
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vid_pll_div",
>> +		/* Same to g12a */
>> +		.ops = &meson_vid_pll_div_ro_ops,
> 
> Please add an helpful explanation.
> 
> 'Same to g12a' is not helpful.
> 

"Because the vid_pll_div clock is a clock that does not need to change 
the divisor, ops only provides meson_vid_pll_div_ro_ops."
I wonder if this description is ok for you?

>> +		.parent_data = (const struct clk_parent_data []) {
>> +			{ .fw_name = "hdmi_pll", }
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vid_pll_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VID_PLL_CLK_DIV,
>> +		.mask = 0x1,
>> +		.shift = 18,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vid_pll_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = (const struct clk_parent_data []) {
>> +			{ .hw = &s4_vid_pll_div.hw },
>> +			{ .fw_name = "hdmi_pll", }
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vid_pll = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_PLL_CLK_DIV,
>> +		.bit_idx = 19,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vid_pll",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vid_pll_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_parent_data s4_vclk_parent_data[] = {
>> +	{ .hw = &s4_vid_pll.hw },
>> +	{ .fw_name = "gp0_pll", },
>> +	{ .fw_name = "hifi_pll", },
>> +	{ .fw_name = "mpll1", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .fw_name = "fclk_div7", },
>> +};
>> +
>> +static struct clk_regmap s4_vclk_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VID_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 16,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_vclk_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_vclk_parent_data),
>> +	},
> 
> You are stopping rate propagation here.
> It deserves an explanation. Same goes below.

"When the driver uses this clock, needs to specify the patent clock he 
wants in the dts."
Is ok for you?

> 
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VIID_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 16,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_vclk_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_vclk_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk_input = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_CLK_DIV,
>> +		.bit_idx = 16,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_input",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk_sel.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_input = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VIID_CLK_DIV,
>> +		.bit_idx = 16,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_input",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2_sel.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VID_CLK_DIV,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vclk_input.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VIID_CLK_DIV,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vclk2_input.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_CLK_CTRL,
>> +		.bit_idx = 19,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk_div.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk2 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VIID_CLK_CTRL,
>> +		.bit_idx = 19,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2_div.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_CLK_CTRL,
>> +		.bit_idx = 0,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_div1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div2_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_CLK_CTRL,
>> +		.bit_idx = 1,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_div2_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div4_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_CLK_CTRL,
>> +		.bit_idx = 2,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_div4_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div6_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_CLK_CTRL,
>> +		.bit_idx = 3,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_div6_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk_div12_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_CLK_CTRL,
>> +		.bit_idx = 4,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk_div12_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VIID_CLK_CTRL,
>> +		.bit_idx = 0,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_div1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div2_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VIID_CLK_CTRL,
>> +		.bit_idx = 1,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_div2_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div4_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VIID_CLK_CTRL,
>> +		.bit_idx = 2,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_div4_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div6_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VIID_CLK_CTRL,
>> +		.bit_idx = 3,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_div6_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vclk2_div12_en = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VIID_CLK_CTRL,
>> +		.bit_idx = 4,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vclk2_div12_en",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div2 = {
>> +	.mult = 1,
>> +	.div = 2,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_div2",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vclk_div2_en.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div4 = {
>> +	.mult = 1,
>> +	.div = 4,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_div4",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vclk_div4_en.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div6 = {
>> +	.mult = 1,
>> +	.div = 6,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_div6",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vclk_div6_en.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk_div12 = {
>> +	.mult = 1,
>> +	.div = 12,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk_div12",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vclk_div12_en.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div2 = {
>> +	.mult = 1,
>> +	.div = 2,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_div2",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vclk2_div2_en.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div4 = {
>> +	.mult = 1,
>> +	.div = 4,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_div4",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vclk2_div4_en.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div6 = {
>> +	.mult = 1,
>> +	.div = 6,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_div6",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vclk2_div6_en.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor s4_vclk2_div12 = {
>> +	.mult = 1,
>> +	.div = 12,
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vclk2_div12",
>> +		.ops = &clk_fixed_factor_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vclk2_div12_en.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* The 5,6,7 indexes corresponds to no real clock, so there are not used. */
>> +static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
>> +static const struct clk_hw *s4_cts_parent_hws[] = {
>> +	&s4_vclk_div1.hw,
>> +	&s4_vclk_div2.hw,
>> +	&s4_vclk_div4.hw,
>> +	&s4_vclk_div6.hw,
>> +	&s4_vclk_div12.hw,
>> +	&s4_vclk2_div1.hw,
>> +	&s4_vclk2_div2.hw,
>> +	&s4_vclk2_div4.hw,
>> +	&s4_vclk2_div6.hw,
>> +	&s4_vclk2_div12.hw
>> +};
>> +
>> +static struct clk_regmap s4_cts_enci_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VID_CLK_DIV,
>> +		.mask = 0xf,
>> +		.shift = 28,
>> +		.table = mux_table_cts_sel,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "cts_enci_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = s4_cts_parent_hws,
>> +		.num_parents = ARRAY_SIZE(s4_cts_parent_hws),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_cts_encp_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VID_CLK_DIV,
>> +		.mask = 0xf,
>> +		.shift = 20,
>> +		.table = mux_table_cts_sel,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "cts_encp_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = s4_cts_parent_hws,
>> +		.num_parents = ARRAY_SIZE(s4_cts_parent_hws),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_cts_vdac_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VIID_CLK_DIV,
>> +		.mask = 0xf,
>> +		.shift = 28,
>> +		.table = mux_table_cts_sel,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "cts_vdac_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = s4_cts_parent_hws,
>> +		.num_parents = ARRAY_SIZE(s4_cts_parent_hws),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* The 5,6,7 indexes corresponds to no real clock, so there are not used. */
>> +static u32 mux_table_hdmi_tx_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
>> +static const struct clk_hw *s4_cts_hdmi_tx_parent_hws[] = {
>> +	&s4_vclk_div1.hw,
>> +	&s4_vclk_div2.hw,
>> +	&s4_vclk_div4.hw,
>> +	&s4_vclk_div6.hw,
>> +	&s4_vclk_div12.hw,
>> +	&s4_vclk2_div1.hw,
>> +	&s4_vclk2_div2.hw,
>> +	&s4_vclk2_div4.hw,
>> +	&s4_vclk2_div6.hw,
>> +	&s4_vclk2_div12.hw
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_tx_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_HDMI_CLK_CTRL,
>> +		.mask = 0xf,
>> +		.shift = 16,
>> +		.table = mux_table_hdmi_tx_sel,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "hdmi_tx_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = s4_cts_hdmi_tx_parent_hws,
>> +		.num_parents = ARRAY_SIZE(s4_cts_hdmi_tx_parent_hws),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_cts_enci = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_CLK_CTRL2,
>> +		.bit_idx = 0,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "cts_enci",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_cts_enci_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_cts_encp = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_CLK_CTRL2,
>> +		.bit_idx = 2,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "cts_encp",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_cts_encp_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_cts_vdac = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_CLK_CTRL2,
>> +		.bit_idx = 4,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "cts_vdac",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_cts_vdac_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_tx = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VID_CLK_CTRL2,
>> +		.bit_idx = 5,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "hdmi_tx",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_hdmi_tx_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* HDMI Clocks */
>> +static const struct clk_parent_data s4_hdmi_parent_data[] = {
>> +	{ .fw_name = "xtal", },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div5", }
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_HDMI_CLK_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "hdmi_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_hdmi_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_hdmi_parent_data),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hdmi_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_HDMI_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "hdmi_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_hdmi_sel.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hdmi = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_HDMI_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "hdmi",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_hdmi_div.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_ts_clk_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_TS_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "ts_clk_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_data = &(const struct clk_parent_data) {
>> +			.fw_name = "xtal",
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_ts_clk_gate = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_TS_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "ts_clk",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_ts_clk_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/*
>> + * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
>> + * muxed by a glitch-free switch. The CCF can manage this glitch-free
>> + * mux because it does top-to-bottom updates the each clock tree and
>> + * switches to the "inactive" one when CLK_SET_RATE_GATE is set.
>> + */
>> +static const struct clk_parent_data s4_mali_0_1_parent_data[] = {
>> +	{ .fw_name = "xtal", },
>> +	{ .fw_name = "gp0_pll", },
>> +	{ .fw_name = "hifi_pll", },
>> +	{ .fw_name = "fclk_div2p5", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .fw_name = "fclk_div7", }
>> +};
>> +
>> +static struct clk_regmap s4_mali_0_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_MALI_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "mali_0_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_mali_0_1_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_mali_0_1_parent_data),
>> +		/*
>> +		 * Don't request the parent to change the rate because
>> +		 * all GPU frequencies can be derived from the fclk_*
>> +		 * clocks and one special GP0_PLL setting. This is
>> +		 * important because we need the MPLL clocks for audio.
>> +		 */
>> +		.flags = 0,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_mali_0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_MALI_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "mali_0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_mali_0_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_mali_0 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_MALI_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "mali_0",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_mali_0_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_mali_1_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_MALI_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "mali_1_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_mali_0_1_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_mali_0_1_parent_data),
>> +		.flags = 0,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_mali_1_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_MALI_CLK_CTRL,
>> +		.shift = 16,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "mali_1_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_mali_1_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_mali_1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_MALI_CLK_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "mali_1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_mali_1_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_hw *s4_mali_parent_hws[] = {
>> +	&s4_mali_0.hw,
>> +	&s4_mali_1.hw
>> +};
>> +
>> +static struct clk_regmap s4_mali_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_MALI_CLK_CTRL,
>> +		.mask = 1,
>> +		.shift = 31,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "mali",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = s4_mali_parent_hws,
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* VDEC clocks */
>> +static const struct clk_parent_data s4_dec_parent_data[] = {
>> +	{ .fw_name = "fclk_div2p5", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .fw_name = "fclk_div7", },
>> +	{ .fw_name = "hifi_pll", },
>> +	{ .fw_name = "gp0_pll", },
>> +	{ .fw_name = "xtal", }
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p0_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VDEC_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 9,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vdec_p0_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_dec_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VDEC_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vdec_p0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vdec_p0_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p0 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VDEC_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vdec_p0",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vdec_p0_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p1_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 9,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vdec_p1_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_dec_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p1_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vdec_p1_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vdec_p1_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vdec_p1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vdec_p1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vdec_p1_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_hw *s4_vdec_mux_parent_hws[] = {
>> +	&s4_vdec_p0.hw,
>> +	&s4_vdec_p1.hw
>> +};
>> +
>> +static struct clk_regmap s4_vdec_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VDEC3_CLK_CTRL,
>> +		.mask = 0x1,
>> +		.shift = 15,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vdec_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = s4_vdec_mux_parent_hws,
>> +		.num_parents = ARRAY_SIZE(s4_vdec_mux_parent_hws),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p0_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VDEC2_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 9,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "hevcf_p0_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_dec_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VDEC2_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "hevcf_p0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_hevcf_p0_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p0 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VDEC2_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "hevcf_p0_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_hevcf_p0_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p1_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 9,
>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "hevcf_p1_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_dec_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p1_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +		.flags = CLK_DIVIDER_ROUND_CLOSEST,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "hevcf_p1_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_hevcf_p1_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_p1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "hevcf_p1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_hevcf_p1_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_hw *s4_hevcf_mux_parent_hws[] = {
>> +	&s4_hevcf_p0.hw,
>> +	&s4_hevcf_p1.hw
>> +};
>> +
>> +static struct clk_regmap s4_hevcf_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VDEC4_CLK_CTRL,
>> +		.mask = 0x1,
>> +		.shift = 15,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "hevcf",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = s4_hevcf_mux_parent_hws,
>> +		.num_parents = ARRAY_SIZE(s4_hevcf_mux_parent_hws),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* VPU Clock */
>> +static const struct clk_parent_data s4_vpu_parent_data[] = {
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .fw_name = "fclk_div7", },
>> +	{ .fw_name = "mpll1", },
>> +	{ .hw = &s4_vid_pll.hw },
>> +	{ .fw_name = "hifi_pll", },
>> +	{ .fw_name = "gp0_pll", },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_0_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VPU_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_0_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_vpu_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_vpu_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VPU_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_sel.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_0 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VPU_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_0",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_div.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_1_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VPU_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_1_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_vpu_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_vpu_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_1_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VPU_CLK_CTRL,
>> +		.shift = 16,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_1_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_sel.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VPU_CLK_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_div.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VPU_CLK_CTRL,
>> +		.mask = 1,
>> +		.shift = 31,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vpu_0.hw,
>> +			&s4_vpu_1.hw,
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_parent_data vpu_clkb_tmp_parent_data[] = {
>> +	{ .hw = &s4_vpu.hw },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .fw_name = "fclk_div7", }
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_tmp_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VPU_CLKB_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 20,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_clkb_tmp_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = vpu_clkb_tmp_parent_data,
>> +		.num_parents = ARRAY_SIZE(vpu_clkb_tmp_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_tmp_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VPU_CLKB_CTRL,
>> +		.shift = 16,
>> +		.width = 4,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_clkb_tmp_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vpu_clkb_tmp_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_tmp = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VPU_CLKB_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_clkb_tmp",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vpu_clkb_tmp_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VPU_CLKB_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_clkb_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vpu_clkb_tmp.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkb = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VPU_CLKB_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_clkb",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vpu_clkb_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_parent_data s4_vpu_clkc_parent_data[] = {
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .fw_name = "fclk_div7", },
>> +	{ .fw_name = "mpll1", },
>> +	{ .hw = &s4_vid_pll.hw },
>> +	{ .fw_name = "mpll2", },
>> +	{ .fw_name = "gp0_pll", },
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p0_mux  = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_clkc_p0_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_vpu_clkc_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_vpu_clkc_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_clkc_p0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vpu_clkc_p0_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p0 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_clkc_p0",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vpu_clkc_p0_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p1_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_clkc_p1_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_vpu_clkc_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_vpu_clkc_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p1_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
>> +		.shift = 16,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_clkc_p1_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vpu_clkc_p1_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_p1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vpu_clkc_p1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vpu_clkc_p1_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_hw *s4_vpu_mux_parent_hws[] = {
>> +	&s4_vpu_clkc_p0.hw,
>> +	&s4_vpu_clkc_p1.hw
>> +};
>> +
>> +static struct clk_regmap s4_vpu_clkc_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
>> +		.mask = 0x1,
>> +		.shift = 31,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vpu_clkc_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = s4_vpu_mux_parent_hws,
>> +		.num_parents = ARRAY_SIZE(s4_vpu_mux_parent_hws),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* VAPB Clock */
>> +static const struct clk_parent_data s4_vapb_parent_data[] = {
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .fw_name = "fclk_div7", },
>> +	{ .fw_name = "mpll1", },
>> +	{ .hw = &s4_vid_pll.hw },
>> +	{ .fw_name = "mpll2", },
>> +	{ .fw_name = "fclk_div2p5", },
>> +};
>> +
>> +static struct clk_regmap s4_vapb_0_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VAPBCLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vapb_0_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_vapb_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_vapb_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vapb_0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VAPBCLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vapb_0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vapb_0_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vapb_0 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VAPBCLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vapb_0",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vapb_0_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vapb_1_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VAPBCLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vapb_1_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_vapb_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_vapb_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vapb_1_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VAPBCLK_CTRL,
>> +		.shift = 16,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vapb_1_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vapb_1_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vapb_1 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VAPBCLK_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vapb_1",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vapb_1_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vapb = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VAPBCLK_CTRL,
>> +		.mask = 1,
>> +		.shift = 31,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vapb_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vapb_0.hw,
>> +			&s4_vapb_1.hw
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_ge2d_gate = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VAPBCLK_CTRL,
>> +		.bit_idx = 30,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "ge2d_clk",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) { &s4_vapb.hw },
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_parent_data s4_esmclk_parent_data[] = {
>> +	{ .fw_name = "fclk_div7", },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div5", },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_esmclk_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_HDCP22_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "hdcp22_esmclk_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_esmclk_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_esmclk_parent_data),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_esmclk_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_HDCP22_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "hdcp22_esmclk_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_hdcp22_esmclk_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_esmclk_gate = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_HDCP22_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "hdcp22_esmclk_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_hdcp22_esmclk_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_parent_data s4_skpclk_parent_data[] = {
>> +	{ .fw_name = "xtal", },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div5", },
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_skpclk_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_HDCP22_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "hdcp22_skpclk_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_skpclk_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_skpclk_parent_data),
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_skpclk_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_HDCP22_CTRL,
>> +		.shift = 16,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "hdcp22_skpclk_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_hdcp22_skpclk_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_hdcp22_skpclk_gate = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_HDCP22_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "hdcp22_skpclk_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_hdcp22_skpclk_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static const struct clk_parent_data s4_vdin_parent_data[]  = {
>> +	{ .fw_name = "xtal", },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .hw = &s4_vid_pll.hw }
>> +};
>> +
>> +static struct clk_regmap s4_vdin_meas_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vdin_meas_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_vdin_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_vdin_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vdin_meas_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "vdin_meas_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vdin_meas_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_vdin_meas_gate = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "vdin_meas_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_vdin_meas_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* EMMC/NAND clock */
>> +static const struct clk_parent_data s4_sd_emmc_clk0_parent_data[] = {
>> +	{ .fw_name = "xtal", },
>> +	{ .fw_name = "fclk_div2", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "hifi_pll", },
>> +	{ .fw_name = "fclk_div2p5", },
>> +	{ .fw_name = "mpll2", },
>> +	{ .fw_name = "mpll3", },
>> +	{ .fw_name = "gp0_pll", },
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_c_clk0_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_NAND_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sd_emmc_c_clk0_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_sd_emmc_clk0_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_c_clk0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_NAND_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sd_emmc_c_clk0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sd_emmc_c_clk0_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_c_clk0 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_NAND_CLK_CTRL,
>> +		.bit_idx = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sd_emmc_c_clk0",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sd_emmc_c_clk0_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_a_clk0_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sd_emmc_a_clk0_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_sd_emmc_clk0_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_a_clk0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sd_emmc_a_clk0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sd_emmc_a_clk0_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_a_clk0 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +		.bit_idx = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sd_emmc_a_clk0",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sd_emmc_a_clk0_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_b_clk0_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sd_emmc_b_clk0_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_sd_emmc_clk0_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_b_clk0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +		.shift = 16,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "sd_emmc_b_clk0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sd_emmc_b_clk0_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_sd_emmc_b_clk0 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
>> +		.bit_idx = 23,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "sd_emmc_b_clk0",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_sd_emmc_b_clk0_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* SPICC Clock */
>> +static const struct clk_parent_data s4_spicc_parent_data[] = {
>> +	{ .fw_name = "xtal", },
>> +	{ .hw = &s4_sys_clk.hw },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div2", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .fw_name = "fclk_div7", },
>> +};
>> +
>> +static struct clk_regmap s4_spicc0_mux = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "spicc0_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_spicc_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_spicc_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_spicc0_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 6,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "spicc0_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_spicc0_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_spicc0_gate = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
>> +		.bit_idx = 6,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "spicc0",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_spicc0_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/* PWM Clock */
>> +static const struct clk_parent_data s4_pwm_parent_data[] = {
>> +	{ .fw_name = "xtal", },
>> +	{ .hw = &s4_vid_pll.hw },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div3", },
>> +};
>> +
>> +static struct clk_regmap s4_pwm_a_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_a_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_a_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_a_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_a_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_a_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_a_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_a_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_b_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_b_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_b_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +		.shift = 16,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_b_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_b_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_b_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_b_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_b_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_c_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_c_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_c_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_c_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_c_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_c_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_c_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_c_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_d_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_d_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_d_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +		.shift = 16,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_d_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_d_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_d_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_d_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_d_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_e_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_e_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_e_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_e_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_e_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_e_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_e_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_e_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_f_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_f_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_f_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +		.shift = 16,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_f_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_f_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_f_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_f_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_f_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_g_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_g_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_g_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_g_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_g_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_g_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_g_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_g_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_h_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_h_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_h_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +		.shift = 16,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_h_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_h_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_h_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_h_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_h_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_i_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_i_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_i_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_i_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_i_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_i_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_i_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_i_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_j_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_j_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_pwm_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_j_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +		.shift = 16,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_j_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_h_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_pwm_j_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "pwm_j_gate",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_pwm_j_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_saradc_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_SAR_CLK_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "saradc_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = (const struct clk_parent_data []) {
>> +			{ .fw_name = "xtal", },
>> +			{ .hw = &s4_sys_clk.hw },
>> +		},
>> +		.num_parents = 2,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_saradc_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_SAR_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "saradc_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_saradc_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_saradc_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_SAR_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "saradc_clk",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_saradc_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +/*
>> + * gen clk is designed for debug/monitor some internal clock quality. Some of the
>> + * corresponding clock sources are not described in the clock tree and internal clock
>> + * for debug, so they are skipped.
>> + */
>> +static u32 s4_gen_clk_mux_table[] = { 0, 4, 5, 7, 19, 21, 22,
>> +				      23, 24, 25, 26, 27, 28 };
>> +static const struct clk_parent_data s4_gen_clk_parent_data[] = {
>> +	{ .fw_name = "xtal", },
>> +	{ .hw = &s4_vid_pll.hw },
>> +	{ .fw_name = "gp0_pll", },
>> +	{ .fw_name = "hifi_pll", },
>> +	{ .fw_name = "fclk_div2", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .fw_name = "fclk_div7", },
>> +	{ .fw_name = "mpll0", },
>> +	{ .fw_name = "mpll1", },
>> +	{ .fw_name = "mpll2", },
>> +	{ .fw_name = "mpll3", },
>> +};
>> +
>> +static struct clk_regmap s4_gen_clk_sel = {
>> +	.data = &(struct clk_regmap_mux_data){
>> +		.offset = CLKCTRL_GEN_CLK_CTRL,
>> +		.mask = 0x1f,
>> +		.shift = 12,
>> +		.table = s4_gen_clk_mux_table,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "gen_clk_sel",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_gen_clk_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_gen_clk_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_gen_clk_div = {
>> +	.data = &(struct clk_regmap_div_data){
>> +		.offset = CLKCTRL_GEN_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 11,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "gen_clk_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_gen_clk_sel.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_gen_clk = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = CLKCTRL_GEN_CLK_CTRL,
>> +		.bit_idx = 11,
>> +	},
>> +	.hw.init = &(struct clk_init_data) {
>> +		.name = "gen_clk",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_gen_clk_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
>> +	},
>> +};
>> +
>> +static const struct clk_parent_data s4_adc_extclk_in_parent_data[]  = {
>> +	{ .fw_name = "xtal", },
>> +	{ .fw_name = "fclk_div4", },
>> +	{ .fw_name = "fclk_div3", },
>> +	{ .fw_name = "fclk_div5", },
>> +	{ .fw_name = "fclk_div7", },
>> +	{ .fw_name = "mpll2", },
>> +	{ .fw_name = "gp0_pll", },
>> +	{ .fw_name = "hifi_pll", },
>> +};
>> +
>> +static struct clk_regmap s4_adc_extclk_in_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +		.mask = 0x7,
>> +		.shift = 25,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "adc_extclk_in_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = s4_adc_extclk_in_parent_data,
>> +		.num_parents = ARRAY_SIZE(s4_adc_extclk_in_parent_data),
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_adc_extclk_in_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +		.shift = 16,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "adc_extclk_in_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_adc_extclk_in_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_adc_extclk_in_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "adc_extclk_in",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_adc_extclk_in_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_demod_core_clk_mux = {
>> +	.data = &(struct clk_regmap_mux_data) {
>> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +		.mask = 0x3,
>> +		.shift = 9,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "demod_core_clk_mux",
>> +		.ops = &clk_regmap_mux_ops,
>> +		.parent_data = (const struct clk_parent_data []) {
>> +			{ .fw_name = "xtal", },
>> +			{ .fw_name = "fclk_div7", },
>> +			{ .fw_name = "fclk_div4", },
>> +			{ .hw = &s4_adc_extclk_in_gate.hw }
>> +		},
>> +		.num_parents = 4,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_demod_core_clk_div = {
>> +	.data = &(struct clk_regmap_div_data) {
>> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +		.shift = 0,
>> +		.width = 7,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "demod_core_clk_div",
>> +		.ops = &clk_regmap_divider_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_demod_core_clk_mux.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +static struct clk_regmap s4_demod_core_clk_gate = {
>> +	.data = &(struct clk_regmap_gate_data) {
>> +		.offset = CLKCTRL_DEMOD_CLK_CTRL,
>> +		.bit_idx = 8,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "demod_core_clk",
>> +		.ops = &clk_regmap_gate_ops,
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_demod_core_clk_div.hw
>> +		},
>> +		.num_parents = 1,
>> +		.flags = CLK_SET_RATE_PARENT,
>> +	},
>> +};
>> +
>> +#define MESON_GATE(_name, _reg, _bit) \
>> +	MESON_PCLK(_name, _reg, _bit, &s4_sys_clk.hw)
>> +
>> +static MESON_GATE(s4_ddr,		CLKCTRL_SYS_CLK_EN0_REG0, 0);
>> +static MESON_GATE(s4_dos,		CLKCTRL_SYS_CLK_EN0_REG0, 1);
>> +static MESON_GATE(s4_ethphy,		CLKCTRL_SYS_CLK_EN0_REG0, 4);
>> +static MESON_GATE(s4_mali,		CLKCTRL_SYS_CLK_EN0_REG0, 6);
>> +static MESON_GATE(s4_aocpu,		CLKCTRL_SYS_CLK_EN0_REG0, 13);
>> +static MESON_GATE(s4_aucpu,		CLKCTRL_SYS_CLK_EN0_REG0, 14);
>> +static MESON_GATE(s4_cec,		CLKCTRL_SYS_CLK_EN0_REG0, 16);
>> +static MESON_GATE(s4_sdemmca,		CLKCTRL_SYS_CLK_EN0_REG0, 24);
>> +static MESON_GATE(s4_sdemmcb,		CLKCTRL_SYS_CLK_EN0_REG0, 25);
>> +static MESON_GATE(s4_nand,		CLKCTRL_SYS_CLK_EN0_REG0, 26);
>> +static MESON_GATE(s4_smartcard,		CLKCTRL_SYS_CLK_EN0_REG0, 27);
>> +static MESON_GATE(s4_acodec,		CLKCTRL_SYS_CLK_EN0_REG0, 28);
>> +static MESON_GATE(s4_spifc,		CLKCTRL_SYS_CLK_EN0_REG0, 29);
>> +static MESON_GATE(s4_msr_clk,		CLKCTRL_SYS_CLK_EN0_REG0, 30);
>> +static MESON_GATE(s4_ir_ctrl,		CLKCTRL_SYS_CLK_EN0_REG0, 31);
>> +static MESON_GATE(s4_audio,		CLKCTRL_SYS_CLK_EN0_REG1, 0);
>> +static MESON_GATE(s4_eth,		CLKCTRL_SYS_CLK_EN0_REG1, 3);
>> +static MESON_GATE(s4_uart_a,		CLKCTRL_SYS_CLK_EN0_REG1, 5);
>> +static MESON_GATE(s4_uart_b,		CLKCTRL_SYS_CLK_EN0_REG1, 6);
>> +static MESON_GATE(s4_uart_c,		CLKCTRL_SYS_CLK_EN0_REG1, 7);
>> +static MESON_GATE(s4_uart_d,		CLKCTRL_SYS_CLK_EN0_REG1, 8);
>> +static MESON_GATE(s4_uart_e,		CLKCTRL_SYS_CLK_EN0_REG1, 9);
>> +static MESON_GATE(s4_aififo,		CLKCTRL_SYS_CLK_EN0_REG1, 11);
>> +static MESON_GATE(s4_ts_ddr,		CLKCTRL_SYS_CLK_EN0_REG1, 15);
>> +static MESON_GATE(s4_ts_pll,		CLKCTRL_SYS_CLK_EN0_REG1, 16);
>> +static MESON_GATE(s4_g2d,		CLKCTRL_SYS_CLK_EN0_REG1, 20);
>> +static MESON_GATE(s4_spicc0,		CLKCTRL_SYS_CLK_EN0_REG1, 21);
>> +static MESON_GATE(s4_usb,		CLKCTRL_SYS_CLK_EN0_REG1, 26);
>> +static MESON_GATE(s4_i2c_m_a,		CLKCTRL_SYS_CLK_EN0_REG1, 30);
>> +static MESON_GATE(s4_i2c_m_b,		CLKCTRL_SYS_CLK_EN0_REG1, 31);
>> +static MESON_GATE(s4_i2c_m_c,		CLKCTRL_SYS_CLK_EN0_REG2, 0);
>> +static MESON_GATE(s4_i2c_m_d,		CLKCTRL_SYS_CLK_EN0_REG2, 1);
>> +static MESON_GATE(s4_i2c_m_e,		CLKCTRL_SYS_CLK_EN0_REG2, 2);
>> +static MESON_GATE(s4_hdmitx_apb,	CLKCTRL_SYS_CLK_EN0_REG2, 4);
>> +static MESON_GATE(s4_i2c_s_a,		CLKCTRL_SYS_CLK_EN0_REG2, 5);
>> +static MESON_GATE(s4_usb1_to_ddr,	CLKCTRL_SYS_CLK_EN0_REG2, 8);
>> +static MESON_GATE(s4_hdcp22,		CLKCTRL_SYS_CLK_EN0_REG2, 10);
>> +static MESON_GATE(s4_mmc_apb,		CLKCTRL_SYS_CLK_EN0_REG2, 11);
>> +static MESON_GATE(s4_rsa,		CLKCTRL_SYS_CLK_EN0_REG2, 18);
>> +static MESON_GATE(s4_cpu_debug,		CLKCTRL_SYS_CLK_EN0_REG2, 19);
>> +static MESON_GATE(s4_vpu_intr,		CLKCTRL_SYS_CLK_EN0_REG2, 25);
>> +static MESON_GATE(s4_demod,		CLKCTRL_SYS_CLK_EN0_REG2, 27);
>> +static MESON_GATE(s4_sar_adc,		CLKCTRL_SYS_CLK_EN0_REG2, 28);
>> +static MESON_GATE(s4_gic,		CLKCTRL_SYS_CLK_EN0_REG2, 30);
>> +static MESON_GATE(s4_pwm_ab,		CLKCTRL_SYS_CLK_EN0_REG3, 7);
>> +static MESON_GATE(s4_pwm_cd,		CLKCTRL_SYS_CLK_EN0_REG3, 8);
>> +static MESON_GATE(s4_pwm_ef,		CLKCTRL_SYS_CLK_EN0_REG3, 9);
>> +static MESON_GATE(s4_pwm_gh,		CLKCTRL_SYS_CLK_EN0_REG3, 10);
>> +static MESON_GATE(s4_pwm_ij,		CLKCTRL_SYS_CLK_EN0_REG3, 11);
>> +
>> +/* Array of all clocks provided by this provider */
>> +static struct clk_hw_onecell_data s4_periphs_hw_onecell_data = {
>> +	.hws = {
>> +		[CLKID_RTC_32K_CLKIN]		= &s4_rtc_32k_by_oscin_clkin.hw,
>> +		[CLKID_RTC_32K_DIV]		= &s4_rtc_32k_by_oscin_div.hw,
>> +		[CLKID_RTC_32K_SEL]		= &s4_rtc_32k_by_oscin_sel.hw,
>> +		[CLKID_RTC_32K_XATL]		= &s4_rtc_32k_by_oscin.hw,
>> +		[CLKID_RTC_CLK]			= &s4_rtc_clk.hw,
>> +		[CLKID_SYS_CLK_B_SEL]		= &s4_sysclk_b_sel.hw,
>> +		[CLKID_SYS_CLK_B_DIV]		= &s4_sysclk_b_div.hw,
>> +		[CLKID_SYS_CLK_B_GATE]		= &s4_sysclk_b.hw,
>> +		[CLKID_SYS_CLK_A_SEL]		= &s4_sysclk_a_sel.hw,
>> +		[CLKID_SYS_CLK_A_DIV]		= &s4_sysclk_a_div.hw,
>> +		[CLKID_SYS_CLK_A_GATE]		= &s4_sysclk_a.hw,
>> +		[CLKID_SYS_CLK]			= &s4_sys_clk.hw,
>> +		[CLKID_CECA_32K_CLKIN]		= &s4_ceca_32k_clkin.hw,
>> +		[CLKID_CECA_32K_DIV]		= &s4_ceca_32k_div.hw,
>> +		[CLKID_CECA_32K_SEL_PRE]	= &s4_ceca_32k_sel_pre.hw,
>> +		[CLKID_CECA_32K_SEL]		= &s4_ceca_32k_sel.hw,
>> +		[CLKID_CECA_32K_CLKOUT]		= &s4_ceca_32k_clkout.hw,
>> +		[CLKID_CECB_32K_CLKIN]		= &s4_cecb_32k_clkin.hw,
>> +		[CLKID_CECB_32K_DIV]		= &s4_cecb_32k_div.hw,
>> +		[CLKID_CECB_32K_SEL_PRE]	= &s4_cecb_32k_sel_pre.hw,
>> +		[CLKID_CECB_32K_SEL]		= &s4_cecb_32k_sel.hw,
>> +		[CLKID_CECB_32K_CLKOUT]		= &s4_cecb_32k_clkout.hw,
>> +		[CLKID_SC_CLK_SEL]		= &s4_sc_clk_mux.hw,
>> +		[CLKID_SC_CLK_DIV]		= &s4_sc_clk_div.hw,
>> +		[CLKID_SC_CLK_GATE]		= &s4_sc_clk_gate.hw,
>> +		[CLKID_12_24M_CLK_GATE]		= &s4_12_24M_clk_gate.hw,
>> +		[CLKID_12M_CLK_DIV]		= &s4_12M_clk_div.hw,
>> +		[CLKID_12_24M_CLK_SEL]		= &s4_12_24M_clk.hw,
>> +		[CLKID_VID_PLL_DIV]		= &s4_vid_pll_div.hw,
>> +		[CLKID_VID_PLL_SEL]		= &s4_vid_pll_sel.hw,
>> +		[CLKID_VID_PLL]			= &s4_vid_pll.hw,
>> +		[CLKID_VCLK_SEL]		= &s4_vclk_sel.hw,
>> +		[CLKID_VCLK2_SEL]		= &s4_vclk2_sel.hw,
>> +		[CLKID_VCLK_INPUT]		= &s4_vclk_input.hw,
>> +		[CLKID_VCLK2_INPUT]		= &s4_vclk2_input.hw,
>> +		[CLKID_VCLK_DIV]		= &s4_vclk_div.hw,
>> +		[CLKID_VCLK2_DIV]		= &s4_vclk2_div.hw,
>> +		[CLKID_VCLK]			= &s4_vclk.hw,
>> +		[CLKID_VCLK2]			= &s4_vclk2.hw,
>> +		[CLKID_VCLK_DIV1]		= &s4_vclk_div1.hw,
>> +		[CLKID_VCLK_DIV2_EN]		= &s4_vclk_div2_en.hw,
>> +		[CLKID_VCLK_DIV4_EN]		= &s4_vclk_div4_en.hw,
>> +		[CLKID_VCLK_DIV6_EN]		= &s4_vclk_div6_en.hw,
>> +		[CLKID_VCLK_DIV12_EN]		= &s4_vclk_div12_en.hw,
>> +		[CLKID_VCLK2_DIV1]		= &s4_vclk2_div1.hw,
>> +		[CLKID_VCLK2_DIV2_EN]		= &s4_vclk2_div2_en.hw,
>> +		[CLKID_VCLK2_DIV4_EN]		= &s4_vclk2_div4_en.hw,
>> +		[CLKID_VCLK2_DIV6_EN]		= &s4_vclk2_div6_en.hw,
>> +		[CLKID_VCLK2_DIV12_EN]		= &s4_vclk2_div12_en.hw,
>> +		[CLKID_VCLK_DIV2]		= &s4_vclk_div2.hw,
>> +		[CLKID_VCLK_DIV4]		= &s4_vclk_div4.hw,
>> +		[CLKID_VCLK_DIV6]		= &s4_vclk_div6.hw,
>> +		[CLKID_VCLK_DIV12]		= &s4_vclk_div12.hw,
>> +		[CLKID_VCLK2_DIV2]		= &s4_vclk2_div2.hw,
>> +		[CLKID_VCLK2_DIV4]		= &s4_vclk2_div4.hw,
>> +		[CLKID_VCLK2_DIV6]		= &s4_vclk2_div6.hw,
>> +		[CLKID_VCLK2_DIV12]		= &s4_vclk2_div12.hw,
>> +		[CLKID_CTS_ENCI_SEL]		= &s4_cts_enci_sel.hw,
>> +		[CLKID_CTS_ENCP_SEL]		= &s4_cts_encp_sel.hw,
>> +		[CLKID_CTS_VDAC_SEL]		= &s4_cts_vdac_sel.hw,
>> +		[CLKID_HDMI_TX_SEL]		= &s4_hdmi_tx_sel.hw,
>> +		[CLKID_CTS_ENCI]		= &s4_cts_enci.hw,
>> +		[CLKID_CTS_ENCP]		= &s4_cts_encp.hw,
>> +		[CLKID_CTS_VDAC]		= &s4_cts_vdac.hw,
>> +		[CLKID_HDMI_TX]			= &s4_hdmi_tx.hw,
>> +		[CLKID_HDMI_SEL]		= &s4_hdmi_sel.hw,
>> +		[CLKID_HDMI_DIV]		= &s4_hdmi_div.hw,
>> +		[CLKID_HDMI]			= &s4_hdmi.hw,
>> +		[CLKID_TS_CLK_DIV]		= &s4_ts_clk_div.hw,
>> +		[CLKID_TS_CLK_GATE]		= &s4_ts_clk_gate.hw,
>> +		[CLKID_MALI_0_SEL]		= &s4_mali_0_sel.hw,
>> +		[CLKID_MALI_0_DIV]		= &s4_mali_0_div.hw,
>> +		[CLKID_MALI_0]			= &s4_mali_0.hw,
>> +		[CLKID_MALI_1_SEL]		= &s4_mali_1_sel.hw,
>> +		[CLKID_MALI_1_DIV]		= &s4_mali_1_div.hw,
>> +		[CLKID_MALI_1]			= &s4_mali_1.hw,
>> +		[CLKID_MALI]			= &s4_mali_mux.hw,
>> +		[CLKID_VDEC_P0_SEL]		= &s4_vdec_p0_mux.hw,
>> +		[CLKID_VDEC_P0_DIV]		= &s4_vdec_p0_div.hw,
>> +		[CLKID_VDEC_P0]			= &s4_vdec_p0.hw,
>> +		[CLKID_VDEC_P1_SEL]		= &s4_vdec_p1_mux.hw,
>> +		[CLKID_VDEC_P1_DIV]		= &s4_vdec_p1_div.hw,
>> +		[CLKID_VDEC_P1]			= &s4_vdec_p1.hw,
>> +		[CLKID_VDEC_SEL]		= &s4_vdec_mux.hw,
>> +		[CLKID_HEVCF_P0_SEL]		= &s4_hevcf_p0_mux.hw,
>> +		[CLKID_HEVCF_P0_DIV]		= &s4_hevcf_p0_div.hw,
>> +		[CLKID_HEVCF_P0]		= &s4_hevcf_p0.hw,
>> +		[CLKID_HEVCF_P1_SEL]		= &s4_hevcf_p1_mux.hw,
>> +		[CLKID_HEVCF_P1_DIV]		= &s4_hevcf_p1_div.hw,
>> +		[CLKID_HEVCF_P1]		= &s4_hevcf_p1.hw,
>> +		[CLKID_HEVCF_SEL]		= &s4_hevcf_mux.hw,
>> +		[CLKID_VPU_0_SEL]		= &s4_vpu_0_sel.hw,
>> +		[CLKID_VPU_0_DIV]		= &s4_vpu_0_div.hw,
>> +		[CLKID_VPU_0]			= &s4_vpu_0.hw,
>> +		[CLKID_VPU_1_SEL]		= &s4_vpu_1_sel.hw,
>> +		[CLKID_VPU_1_DIV]		= &s4_vpu_1_div.hw,
>> +		[CLKID_VPU_1]			= &s4_vpu_1.hw,
>> +		[CLKID_VPU]			= &s4_vpu.hw,
>> +		[CLKID_VPU_CLKB_TMP_SEL]	= &s4_vpu_clkb_tmp_mux.hw,
>> +		[CLKID_VPU_CLKB_TMP_DIV]	= &s4_vpu_clkb_tmp_div.hw,
>> +		[CLKID_VPU_CLKB_TMP]		= &s4_vpu_clkb_tmp.hw,
>> +		[CLKID_VPU_CLKB_DIV]		= &s4_vpu_clkb_div.hw,
>> +		[CLKID_VPU_CLKB]		= &s4_vpu_clkb.hw,
>> +		[CLKID_VPU_CLKC_P0_SEL]		= &s4_vpu_clkc_p0_mux.hw,
>> +		[CLKID_VPU_CLKC_P0_DIV]		= &s4_vpu_clkc_p0_div.hw,
>> +		[CLKID_VPU_CLKC_P0]		= &s4_vpu_clkc_p0.hw,
>> +		[CLKID_VPU_CLKC_P1_SEL]		= &s4_vpu_clkc_p1_mux.hw,
>> +		[CLKID_VPU_CLKC_P1_DIV]		= &s4_vpu_clkc_p1_div.hw,
>> +		[CLKID_VPU_CLKC_P1]		= &s4_vpu_clkc_p1.hw,
>> +		[CLKID_VPU_CLKC_SEL]		= &s4_vpu_clkc_mux.hw,
>> +		[CLKID_VAPB_0_SEL]		= &s4_vapb_0_sel.hw,
>> +		[CLKID_VAPB_0_DIV]		= &s4_vapb_0_div.hw,
>> +		[CLKID_VAPB_0]			= &s4_vapb_0.hw,
>> +		[CLKID_VAPB_1_SEL]		= &s4_vapb_1_sel.hw,
>> +		[CLKID_VAPB_1_DIV]		= &s4_vapb_1_div.hw,
>> +		[CLKID_VAPB_1]			= &s4_vapb_1.hw,
>> +		[CLKID_VAPB]			= &s4_vapb.hw,
>> +		[CLKID_GE2D]			= &s4_ge2d_gate.hw,
>> +		[CLKID_VDIN_MEAS_SEL]		= &s4_vdin_meas_mux.hw,
>> +		[CLKID_VDIN_MEAS_DIV]		= &s4_vdin_meas_div.hw,
>> +		[CLKID_VDIN_MEAS_GATE]		= &s4_vdin_meas_gate.hw,
>> +		[CLKID_SD_EMMC_C_CLK_SEL]	= &s4_sd_emmc_c_clk0_sel.hw,
>> +		[CLKID_SD_EMMC_C_CLK_DIV]	= &s4_sd_emmc_c_clk0_div.hw,
>> +		[CLKID_SD_EMMC_C_CLK]		= &s4_sd_emmc_c_clk0.hw,
>> +		[CLKID_SD_EMMC_A_CLK_SEL]	= &s4_sd_emmc_a_clk0_sel.hw,
>> +		[CLKID_SD_EMMC_A_CLK_DIV]	= &s4_sd_emmc_a_clk0_div.hw,
>> +		[CLKID_SD_EMMC_A_CLK]		= &s4_sd_emmc_a_clk0.hw,
>> +		[CLKID_SD_EMMC_B_CLK_SEL]	= &s4_sd_emmc_b_clk0_sel.hw,
>> +		[CLKID_SD_EMMC_B_CLK_DIV]	= &s4_sd_emmc_b_clk0_div.hw,
>> +		[CLKID_SD_EMMC_B_CLK]		= &s4_sd_emmc_b_clk0.hw,
>> +		[CLKID_SPICC0_SEL]		= &s4_spicc0_mux.hw,
>> +		[CLKID_SPICC0_DIV]		= &s4_spicc0_div.hw,
>> +		[CLKID_SPICC0_GATE]		= &s4_spicc0_gate.hw,
>> +		[CLKID_PWM_A_SEL]		= &s4_pwm_a_mux.hw,
>> +		[CLKID_PWM_A_DIV]		= &s4_pwm_a_div.hw,
>> +		[CLKID_PWM_A_GATE]		= &s4_pwm_a_gate.hw,
>> +		[CLKID_PWM_B_SEL]		= &s4_pwm_b_mux.hw,
>> +		[CLKID_PWM_B_DIV]		= &s4_pwm_b_div.hw,
>> +		[CLKID_PWM_B_GATE]		= &s4_pwm_b_gate.hw,
>> +		[CLKID_PWM_C_SEL]		= &s4_pwm_c_mux.hw,
>> +		[CLKID_PWM_C_DIV]		= &s4_pwm_c_div.hw,
>> +		[CLKID_PWM_C_GATE]		= &s4_pwm_c_gate.hw,
>> +		[CLKID_PWM_D_SEL]		= &s4_pwm_d_mux.hw,
>> +		[CLKID_PWM_D_DIV]		= &s4_pwm_d_div.hw,
>> +		[CLKID_PWM_D_GATE]		= &s4_pwm_d_gate.hw,
>> +		[CLKID_PWM_E_SEL]		= &s4_pwm_e_mux.hw,
>> +		[CLKID_PWM_E_DIV]		= &s4_pwm_e_div.hw,
>> +		[CLKID_PWM_E_GATE]		= &s4_pwm_e_gate.hw,
>> +		[CLKID_PWM_F_SEL]		= &s4_pwm_f_mux.hw,
>> +		[CLKID_PWM_F_DIV]		= &s4_pwm_f_div.hw,
>> +		[CLKID_PWM_F_GATE]		= &s4_pwm_f_gate.hw,
>> +		[CLKID_PWM_G_SEL]		= &s4_pwm_g_mux.hw,
>> +		[CLKID_PWM_G_DIV]		= &s4_pwm_g_div.hw,
>> +		[CLKID_PWM_G_GATE]		= &s4_pwm_g_gate.hw,
>> +		[CLKID_PWM_H_SEL]		= &s4_pwm_h_mux.hw,
>> +		[CLKID_PWM_H_DIV]		= &s4_pwm_h_div.hw,
>> +		[CLKID_PWM_H_GATE]		= &s4_pwm_h_gate.hw,
>> +		[CLKID_PWM_I_SEL]		= &s4_pwm_i_mux.hw,
>> +		[CLKID_PWM_I_DIV]		= &s4_pwm_i_div.hw,
>> +		[CLKID_PWM_I_GATE]		= &s4_pwm_i_gate.hw,
>> +		[CLKID_PWM_J_SEL]		= &s4_pwm_j_mux.hw,
>> +		[CLKID_PWM_J_DIV]		= &s4_pwm_j_div.hw,
>> +		[CLKID_PWM_J_GATE]		= &s4_pwm_j_gate.hw,
>> +		[CLKID_SARADC_SEL]		= &s4_saradc_mux.hw,
>> +		[CLKID_SARADC_DIV]		= &s4_saradc_div.hw,
>> +		[CLKID_SARADC_GATE]		= &s4_saradc_gate.hw,
>> +		[CLKID_GEN_SEL]			= &s4_gen_clk_sel.hw,
>> +		[CLKID_GEN_DIV]			= &s4_gen_clk_div.hw,
>> +		[CLKID_GEN_GATE]		= &s4_gen_clk.hw,
>> +		[CLKID_DDR]			= &s4_ddr.hw,
>> +		[CLKID_DOS]			= &s4_dos.hw,
>> +		[CLKID_ETHPHY]			= &s4_ethphy.hw,
>> +		[CLKID_MALI_GATE]		= &s4_mali.hw,
>> +		[CLKID_AOCPU]			= &s4_aocpu.hw,
>> +		[CLKID_AUCPU]			= &s4_aucpu.hw,
>> +		[CLKID_CEC]			= &s4_cec.hw,
>> +		[CLKID_SD_EMMC_A]		= &s4_sdemmca.hw,
>> +		[CLKID_SD_EMMC_B]		= &s4_sdemmcb.hw,
>> +		[CLKID_NAND]			= &s4_nand.hw,
>> +		[CLKID_SMARTCARD]		= &s4_smartcard.hw,
>> +		[CLKID_ACODEC]			= &s4_acodec.hw,
>> +		[CLKID_SPIFC]			= &s4_spifc.hw,
>> +		[CLKID_MSR_CLK]			= &s4_msr_clk.hw,
>> +		[CLKID_IR_CTRL]			= &s4_ir_ctrl.hw,
>> +		[CLKID_AUDIO]			= &s4_audio.hw,
>> +		[CLKID_ETH]			= &s4_eth.hw,
>> +		[CLKID_UART_A]			= &s4_uart_a.hw,
>> +		[CLKID_UART_B]			= &s4_uart_b.hw,
>> +		[CLKID_UART_C]			= &s4_uart_c.hw,
>> +		[CLKID_UART_D]			= &s4_uart_d.hw,
>> +		[CLKID_UART_E]			= &s4_uart_e.hw,
>> +		[CLKID_AIFIFO]			= &s4_aififo.hw,
>> +		[CLKID_TS_DDR]			= &s4_ts_ddr.hw,
>> +		[CLKID_TS_PLL]			= &s4_ts_pll.hw,
>> +		[CLKID_G2D]			= &s4_g2d.hw,
>> +		[CLKID_SPICC0]			= &s4_spicc0.hw,
>> +		[CLKID_USB]			= &s4_usb.hw,
>> +		[CLKID_I2C_M_A]			= &s4_i2c_m_a.hw,
>> +		[CLKID_I2C_M_B]			= &s4_i2c_m_b.hw,
>> +		[CLKID_I2C_M_C]			= &s4_i2c_m_c.hw,
>> +		[CLKID_I2C_M_D]			= &s4_i2c_m_d.hw,
>> +		[CLKID_I2C_M_E]			= &s4_i2c_m_e.hw,
>> +		[CLKID_HDMITX_APB]		= &s4_hdmitx_apb.hw,
>> +		[CLKID_I2C_S_A]			= &s4_i2c_s_a.hw,
>> +		[CLKID_USB1_TO_DDR]		= &s4_usb1_to_ddr.hw,
>> +		[CLKID_HDCP22]			= &s4_hdcp22.hw,
>> +		[CLKID_MMC_APB]			= &s4_mmc_apb.hw,
>> +		[CLKID_RSA]			= &s4_rsa.hw,
>> +		[CLKID_CPU_DEBUG]		= &s4_cpu_debug.hw,
>> +		[CLKID_VPU_INTR]		= &s4_vpu_intr.hw,
>> +		[CLKID_DEMOD]			= &s4_demod.hw,
>> +		[CLKID_SAR_ADC]			= &s4_sar_adc.hw,
>> +		[CLKID_GIC]			= &s4_gic.hw,
>> +		[CLKID_PWM_AB]			= &s4_pwm_ab.hw,
>> +		[CLKID_PWM_CD]			= &s4_pwm_cd.hw,
>> +		[CLKID_PWM_EF]			= &s4_pwm_ef.hw,
>> +		[CLKID_PWM_GH]			= &s4_pwm_gh.hw,
>> +		[CLKID_PWM_IJ]			= &s4_pwm_ij.hw,
>> +		[CLKID_HDCP22_ESMCLK_SEL]	= &s4_hdcp22_esmclk_mux.hw,
>> +		[CLKID_HDCP22_ESMCLK_DIV]	= &s4_hdcp22_esmclk_div.hw,
>> +		[CLKID_HDCP22_ESMCLK_GATE]	= &s4_hdcp22_esmclk_gate.hw,
>> +		[CLKID_HDCP22_SKPCLK_SEL]	= &s4_hdcp22_skpclk_mux.hw,
>> +		[CLKID_HDCP22_SKPCLK_DIV]	= &s4_hdcp22_skpclk_div.hw,
>> +		[CLKID_HDCP22_SKPCLK_GATE]	= &s4_hdcp22_skpclk_gate.hw,
>> +		[NR_CLKS]			= NULL
>> +	},
>> +	.num = NR_CLKS,
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const s4_periphs_clk_regmaps[] = {
>> +	&s4_rtc_32k_by_oscin_clkin,
>> +	&s4_rtc_32k_by_oscin_div,
>> +	&s4_rtc_32k_by_oscin_sel,
>> +	&s4_rtc_32k_by_oscin,
>> +	&s4_rtc_clk,
>> +	&s4_sysclk_b_sel,
>> +	&s4_sysclk_b_div,
>> +	&s4_sysclk_b,
>> +	&s4_sysclk_a_sel,
>> +	&s4_sysclk_a_div,
>> +	&s4_sysclk_a,
>> +	&s4_sys_clk,
>> +	&s4_ceca_32k_clkin,
>> +	&s4_ceca_32k_div,
>> +	&s4_ceca_32k_sel_pre,
>> +	&s4_ceca_32k_sel,
>> +	&s4_ceca_32k_clkout,
>> +	&s4_cecb_32k_clkin,
>> +	&s4_cecb_32k_div,
>> +	&s4_cecb_32k_sel_pre,
>> +	&s4_cecb_32k_sel,
>> +	&s4_cecb_32k_clkout,
>> +	&s4_sc_clk_mux,
>> +	&s4_sc_clk_div,
>> +	&s4_sc_clk_gate,
>> +	&s4_12_24M_clk_gate,
>> +	&s4_12_24M_clk,
>> +	&s4_vid_pll_div,
>> +	&s4_vid_pll_sel,
>> +	&s4_vid_pll,
>> +	&s4_vclk_sel,
>> +	&s4_vclk2_sel,
>> +	&s4_vclk_input,
>> +	&s4_vclk2_input,
>> +	&s4_vclk_div,
>> +	&s4_vclk2_div,
>> +	&s4_vclk,
>> +	&s4_vclk2,
>> +	&s4_vclk_div1,
>> +	&s4_vclk_div2_en,
>> +	&s4_vclk_div4_en,
>> +	&s4_vclk_div6_en,
>> +	&s4_vclk_div12_en,
>> +	&s4_vclk2_div1,
>> +	&s4_vclk2_div2_en,
>> +	&s4_vclk2_div4_en,
>> +	&s4_vclk2_div6_en,
>> +	&s4_vclk2_div12_en,
>> +	&s4_cts_enci_sel,
>> +	&s4_cts_encp_sel,
>> +	&s4_cts_vdac_sel,
>> +	&s4_hdmi_tx_sel,
>> +	&s4_cts_enci,
>> +	&s4_cts_encp,
>> +	&s4_cts_vdac,
>> +	&s4_hdmi_tx,
>> +	&s4_hdmi_sel,
>> +	&s4_hdmi_div,
>> +	&s4_hdmi,
>> +	&s4_ts_clk_div,
>> +	&s4_ts_clk_gate,
>> +	&s4_mali_0_sel,
>> +	&s4_mali_0_div,
>> +	&s4_mali_0,
>> +	&s4_mali_1_sel,
>> +	&s4_mali_1_div,
>> +	&s4_mali_1,
>> +	&s4_mali_mux,
>> +	&s4_vdec_p0_mux,
>> +	&s4_vdec_p0_div,
>> +	&s4_vdec_p0,
>> +	&s4_vdec_p1_mux,
>> +	&s4_vdec_p1_div,
>> +	&s4_vdec_p1,
>> +	&s4_vdec_mux,
>> +	&s4_hevcf_p0_mux,
>> +	&s4_hevcf_p0_div,
>> +	&s4_hevcf_p0,
>> +	&s4_hevcf_p1_mux,
>> +	&s4_hevcf_p1_div,
>> +	&s4_hevcf_p1,
>> +	&s4_hevcf_mux,
>> +	&s4_vpu_0_sel,
>> +	&s4_vpu_0_div,
>> +	&s4_vpu_0,
>> +	&s4_vpu_1_sel,
>> +	&s4_vpu_1_div,
>> +	&s4_vpu_1,
>> +	&s4_vpu,
>> +	&s4_vpu_clkb_tmp_mux,
>> +	&s4_vpu_clkb_tmp_div,
>> +	&s4_vpu_clkb_tmp,
>> +	&s4_vpu_clkb_div,
>> +	&s4_vpu_clkb,
>> +	&s4_vpu_clkc_p0_mux,
>> +	&s4_vpu_clkc_p0_div,
>> +	&s4_vpu_clkc_p0,
>> +	&s4_vpu_clkc_p1_mux,
>> +	&s4_vpu_clkc_p1_div,
>> +	&s4_vpu_clkc_p1,
>> +	&s4_vpu_clkc_mux,
>> +	&s4_vapb_0_sel,
>> +	&s4_vapb_0_div,
>> +	&s4_vapb_0,
>> +	&s4_vapb_1_sel,
>> +	&s4_vapb_1_div,
>> +	&s4_vapb_1,
>> +	&s4_vapb,
>> +	&s4_ge2d_gate,
>> +	&s4_hdcp22_esmclk_mux,
>> +	&s4_hdcp22_esmclk_div,
>> +	&s4_hdcp22_esmclk_gate,
>> +	&s4_hdcp22_skpclk_mux,
>> +	&s4_hdcp22_skpclk_div,
>> +	&s4_hdcp22_skpclk_gate,
>> +	&s4_vdin_meas_mux,
>> +	&s4_vdin_meas_div,
>> +	&s4_vdin_meas_gate,
>> +	&s4_sd_emmc_c_clk0_sel,
>> +	&s4_sd_emmc_c_clk0_div,
>> +	&s4_sd_emmc_c_clk0,
>> +	&s4_sd_emmc_a_clk0_sel,
>> +	&s4_sd_emmc_a_clk0_div,
>> +	&s4_sd_emmc_a_clk0,
>> +	&s4_sd_emmc_b_clk0_sel,
>> +	&s4_sd_emmc_b_clk0_div,
>> +	&s4_sd_emmc_b_clk0,
>> +	&s4_spicc0_mux,
>> +	&s4_spicc0_div,
>> +	&s4_spicc0_gate,
>> +	&s4_pwm_a_mux,
>> +	&s4_pwm_a_div,
>> +	&s4_pwm_a_gate,
>> +	&s4_pwm_b_mux,
>> +	&s4_pwm_b_div,
>> +	&s4_pwm_b_gate,
>> +	&s4_pwm_c_mux,
>> +	&s4_pwm_c_div,
>> +	&s4_pwm_c_gate,
>> +	&s4_pwm_d_mux,
>> +	&s4_pwm_d_div,
>> +	&s4_pwm_d_gate,
>> +	&s4_pwm_e_mux,
>> +	&s4_pwm_e_div,
>> +	&s4_pwm_e_gate,
>> +	&s4_pwm_f_mux,
>> +	&s4_pwm_f_div,
>> +	&s4_pwm_f_gate,
>> +	&s4_pwm_g_mux,
>> +	&s4_pwm_g_div,
>> +	&s4_pwm_g_gate,
>> +	&s4_pwm_h_mux,
>> +	&s4_pwm_h_div,
>> +	&s4_pwm_h_gate,
>> +	&s4_pwm_i_mux,
>> +	&s4_pwm_i_div,
>> +	&s4_pwm_i_gate,
>> +	&s4_pwm_j_mux,
>> +	&s4_pwm_j_div,
>> +	&s4_pwm_j_gate,
>> +	&s4_saradc_mux,
>> +	&s4_saradc_div,
>> +	&s4_saradc_gate,
>> +	&s4_gen_clk_sel,
>> +	&s4_gen_clk_div,
>> +	&s4_gen_clk,
>> +	&s4_ddr,
>> +	&s4_dos,
>> +	&s4_ethphy,
>> +	&s4_mali,
>> +	&s4_aocpu,
>> +	&s4_aucpu,
>> +	&s4_cec,
>> +	&s4_sdemmca,
>> +	&s4_sdemmcb,
>> +	&s4_nand,
>> +	&s4_smartcard,
>> +	&s4_acodec,
>> +	&s4_spifc,
>> +	&s4_msr_clk,
>> +	&s4_ir_ctrl,
>> +	&s4_audio,
>> +	&s4_eth,
>> +	&s4_uart_a,
>> +	&s4_uart_b,
>> +	&s4_uart_c,
>> +	&s4_uart_d,
>> +	&s4_uart_e,
>> +	&s4_aififo,
>> +	&s4_ts_ddr,
>> +	&s4_ts_pll,
>> +	&s4_g2d,
>> +	&s4_spicc0,
>> +	&s4_usb,
>> +	&s4_i2c_m_a,
>> +	&s4_i2c_m_b,
>> +	&s4_i2c_m_c,
>> +	&s4_i2c_m_d,
>> +	&s4_i2c_m_e,
>> +	&s4_hdmitx_apb,
>> +	&s4_i2c_s_a,
>> +	&s4_usb1_to_ddr,
>> +	&s4_hdcp22,
>> +	&s4_mmc_apb,
>> +	&s4_rsa,
>> +	&s4_cpu_debug,
>> +	&s4_vpu_intr,
>> +	&s4_demod,
>> +	&s4_sar_adc,
>> +	&s4_gic,
>> +	&s4_pwm_ab,
>> +	&s4_pwm_cd,
>> +	&s4_pwm_ef,
>> +	&s4_pwm_gh,
>> +	&s4_pwm_ij,
>> +	&s4_demod_core_clk_mux,
>> +	&s4_demod_core_clk_div,
>> +	&s4_demod_core_clk_gate,
>> +	&s4_adc_extclk_in_mux,
>> +	&s4_adc_extclk_in_div,
>> +	&s4_adc_extclk_in_gate,
>> +};
>> +
>> +static struct regmap_config clkc_regmap_config = {
>> +	.reg_bits       = 32,
>> +	.val_bits       = 32,
>> +	.reg_stride     = 4,
>> +};
>> +
>> +static int meson_s4_periphs_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct regmap *regmap;
>> +	void __iomem *base;
>> +	int ret, i;
>> +
>> +	base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	/* Populate regmap for the regmap backed clocks */
>> +	for (i = 0; i < ARRAY_SIZE(s4_periphs_clk_regmaps); i++)
>> +		s4_periphs_clk_regmaps[i]->map = regmap;
>> +
>> +	for (i = 0; i < s4_periphs_hw_onecell_data.num; i++) {
>> +		/* array might be sparse */
>> +		if (!s4_periphs_hw_onecell_data.hws[i])
>> +			continue;
>> +
>> +		ret = devm_clk_hw_register(dev, s4_periphs_hw_onecell_data.hws[i]);
>> +		if (ret) {
>> +			dev_err(dev, "Clock registration failed\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> +					   &s4_periphs_hw_onecell_data);
>> +}
>> +
>> +static const struct of_device_id clkc_match_table[] = {
>> +	{
>> +		.compatible = "amlogic,s4-peripherals-clkc",
>> +	},
>> +	{}
>> +};
>> +
>> +static struct platform_driver s4_driver = {
>> +	.probe		= meson_s4_periphs_probe,
>> +	.driver		= {
>> +		.name	= "s4-periphs-clkc",
>> +		.of_match_table = clkc_match_table,
>> +	},
>> +};
>> +
>> +module_platform_driver(s4_driver);
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/clk/meson/s4-peripherals.h b/drivers/clk/meson/s4-peripherals.h
>> new file mode 100644
>> index 000000000000..13ef07bada83
>> --- /dev/null
>> +++ b/drivers/clk/meson/s4-peripherals.h
>> @@ -0,0 +1,218 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2021 Amlogic, inc.
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#ifndef __MESON_S4_PERIPHERALS_H__
>> +#define __MESON_S4_PERIPHERALS_H__
>> +
>> +/*
>> + * Clock controller register offsets
>> + * REG_BASE:  REGISTER_BASE_ADDR = 0xfe000000
>> + */
>> +#define CLKCTRL_OSCIN_CTRL                         0x004
>> +#define CLKCTRL_RTC_BY_OSCIN_CTRL0                 0x008
>> +#define CLKCTRL_RTC_BY_OSCIN_CTRL1                 0x00c
>> +#define CLKCTRL_RTC_CTRL                           0x010
>> +#define CLKCTRL_CHECK_CLK_RESULT                   0x014
>> +#define CLKCTRL_MBIST_ATSPEED_CTRL                 0x018
>> +#define CLKCTRL_LOCK_BIT_REG0                      0x020
>> +#define CLKCTRL_LOCK_BIT_REG1                      0x024
>> +#define CLKCTRL_LOCK_BIT_REG2                      0x028
>> +#define CLKCTRL_LOCK_BIT_REG3                      0x02c
>> +#define CLKCTRL_PROT_BIT_REG0                      0x030
>> +#define CLKCTRL_PROT_BIT_REG1                      0x034
>> +#define CLKCTRL_PROT_BIT_REG2                      0x038
>> +#define CLKCTRL_PROT_BIT_REG3                      0x03c
>> +#define CLKCTRL_SYS_CLK_CTRL0                      0x040
>> +#define CLKCTRL_SYS_CLK_EN0_REG0                   0x044
>> +#define CLKCTRL_SYS_CLK_EN0_REG1                   0x048
>> +#define CLKCTRL_SYS_CLK_EN0_REG2                   0x04c
>> +#define CLKCTRL_SYS_CLK_EN0_REG3                   0x050
>> +#define CLKCTRL_SYS_CLK_EN1_REG0                   0x054
>> +#define CLKCTRL_SYS_CLK_EN1_REG1                   0x058
>> +#define CLKCTRL_SYS_CLK_EN1_REG2                   0x05c
>> +#define CLKCTRL_SYS_CLK_EN1_REG3                   0x060
>> +#define CLKCTRL_SYS_CLK_VPU_EN0                    0x064
>> +#define CLKCTRL_SYS_CLK_VPU_EN1                    0x068
>> +#define CLKCTRL_AXI_CLK_CTRL0                      0x06c
>> +#define CLKCTRL_TST_CTRL0                          0x080
>> +#define CLKCTRL_TST_CTRL1                          0x084
>> +#define CLKCTRL_CECA_CTRL0                         0x088
>> +#define CLKCTRL_CECA_CTRL1                         0x08c
>> +#define CLKCTRL_CECB_CTRL0                         0x090
>> +#define CLKCTRL_CECB_CTRL1                         0x094
>> +#define CLKCTRL_SC_CLK_CTRL                        0x098
>> +#define CLKCTRL_RAMA_CLK_CTRL0                     0x0a4
>> +#define CLKCTRL_CLK12_24_CTRL                      0x0a8
>> +#define CLKCTRL_VID_CLK_CTRL                       0x0c0
>> +#define CLKCTRL_VID_CLK_CTRL2                      0x0c4
>> +#define CLKCTRL_VID_CLK_DIV                        0x0c8
>> +#define CLKCTRL_VIID_CLK_DIV                       0x0cc
>> +#define CLKCTRL_VIID_CLK_CTRL                      0x0d0
>> +#define CLKCTRL_HDMI_CLK_CTRL                      0x0e0
>> +#define CLKCTRL_VID_PLL_CLK_DIV                    0x0e4
>> +#define CLKCTRL_VPU_CLK_CTRL                       0x0e8
>> +#define CLKCTRL_VPU_CLKB_CTRL                      0x0ec
>> +#define CLKCTRL_VPU_CLKC_CTRL                      0x0f0
>> +#define CLKCTRL_VID_LOCK_CLK_CTRL                  0x0f4
>> +#define CLKCTRL_VDIN_MEAS_CLK_CTRL                 0x0f8
>> +#define CLKCTRL_VAPBCLK_CTRL                       0x0fc
>> +#define CLKCTRL_HDCP22_CTRL                        0x100
>> +#define CLKCTRL_CDAC_CLK_CTRL                      0x108
>> +#define CLKCTRL_VDEC_CLK_CTRL                      0x140
>> +#define CLKCTRL_VDEC2_CLK_CTRL                     0x144
>> +#define CLKCTRL_VDEC3_CLK_CTRL                     0x148
>> +#define CLKCTRL_VDEC4_CLK_CTRL                     0x14c
>> +#define CLKCTRL_TS_CLK_CTRL                        0x158
>> +#define CLKCTRL_MALI_CLK_CTRL                      0x15c
>> +#define CLKCTRL_ETH_CLK_CTRL                       0x164
>> +#define CLKCTRL_NAND_CLK_CTRL                      0x168
>> +#define CLKCTRL_SD_EMMC_CLK_CTRL                   0x16c
>> +#define CLKCTRL_SPICC_CLK_CTRL                     0x174
>> +#define CLKCTRL_GEN_CLK_CTRL                       0x178
>> +#define CLKCTRL_SAR_CLK_CTRL                       0x17c
>> +#define CLKCTRL_PWM_CLK_AB_CTRL                    0x180
>> +#define CLKCTRL_PWM_CLK_CD_CTRL                    0x184
>> +#define CLKCTRL_PWM_CLK_EF_CTRL                    0x188
>> +#define CLKCTRL_PWM_CLK_GH_CTRL                    0x18c
>> +#define CLKCTRL_PWM_CLK_IJ_CTRL                    0x190
>> +#define CLKCTRL_DEMOD_CLK_CTRL                     0x200
>> +#define CLKCTRL_TIMESTAMP_CTRL                     0x400
>> +#define CLKCTRL_TIMESTAMP_CTRL1                    0x404
>> +#define CLKCTRL_TIMESTAMP_CTRL2                    0x40c
>> +#define CLKCTRL_TIMESTAMP_RD0                      0x410
>> +#define CLKCTRL_TIMESTAMP_RD1                      0x414
>> +#define CLKCTRL_TIMEBASE_CTRL0                     0x418
>> +#define CLKCTRL_TIMEBASE_CTRL1                     0x41c
>> +#define CLKCTRL_EFUSE_CPU_CFG01                    0x480
>> +#define CLKCTRL_EFUSE_CPU_CFG2                     0x484
>> +#define CLKCTRL_EFUSE_ENCP_CFG0                    0x488
>> +#define CLKCTRL_EFUSE_MALI_CFG01                   0x48c
>> +#define CLKCTRL_EFUSE_LOCK                         0x498
>> +
>> +/*
>> + * CLKID index values
>> + *
>> + * These indices are entirely contrived and do not map onto the hardware.
>> + * It has now been decided to expose everything by default in the DT header:
>> + * include/dt-bindings/clock/axg-clkc.h. Only the clocks ids we don't want
>> + * to expose, such as the internal muxes and dividers of composite clocks,
>> + * will remain defined here.
>> + */
>> +#define CLKID_RTC_32K_CLKIN		0
>> +#define CLKID_RTC_32K_DIV		1
>> +#define CLKID_RTC_32K_SEL		2
>> +#define CLKID_RTC_32K_XATL		3
>> +#define CLKID_SYS_CLK_B_SEL		5
>> +#define CLKID_SYS_CLK_B_DIV		6
>> +#define CLKID_SYS_CLK_A_SEL		8
>> +#define CLKID_SYS_CLK_A_DIV		9
>> +#define CLKID_CECA_32K_CLKIN		12
>> +#define CLKID_CECA_32K_DIV		13
>> +#define CLKID_CECA_32K_SEL_PRE		14
>> +#define CLKID_CECA_32K_SEL		15
>> +#define CLKID_CECB_32K_CLKIN		17
>> +#define CLKID_CECB_32K_DIV		18
>> +#define CLKID_CECB_32K_SEL_PRE		19
>> +#define CLKID_CECB_32K_SEL		20
>> +#define CLKID_SC_CLK_SEL		22
>> +#define CLKID_SC_CLK_DIV		23
>> +#define CLKID_12_24M_CLK_GATE		25
>> +#define CLKID_12M_CLK_DIV		26
>> +#define CLKID_VID_PLL_DIV		28
>> +#define CLKID_VID_PLL_SEL		29
>> +#define CLKID_VCLK_SEL			31
>> +#define CLKID_VCLK2_SEL			32
>> +#define CLKID_VCLK_INPUT		33
>> +#define CLKID_VCLK2_INPUT		34
>> +#define CLKID_VCLK_DIV			35
>> +#define CLKID_VCLK2_DIV			36
>> +#define CLKID_VCLK_DIV2_EN		40
>> +#define CLKID_VCLK_DIV4_EN		41
>> +#define CLKID_VCLK_DIV6_EN		42
>> +#define CLKID_VCLK_DIV12_EN		43
>> +#define CLKID_VCLK2_DIV2_EN		45
>> +#define CLKID_VCLK2_DIV4_EN		46
>> +#define CLKID_VCLK2_DIV6_EN		47
>> +#define CLKID_VCLK2_DIV12_EN		48
>> +#define CLKID_CTS_ENCI_SEL		57
>> +#define CLKID_CTS_ENCP_SEL		58
>> +#define CLKID_CTS_VDAC_SEL		59
>> +#define CLKID_HDMI_TX_SEL		60
>> +#define CLKID_HDMI_TX			64
>> +#define CLKID_HDMI_SEL			65
>> +#define CLKID_HDMI_DIV			66
>> +#define CLKID_TS_CLK_DIV		68
>> +#define CLKID_MALI_0_SEL		70
>> +#define CLKID_MALI_0_DIV		71
>> +#define CLKID_MALI_1_SEL		73
>> +#define CLKID_MALI_1_DIV		74
>> +#define CLKID_VDEC_P0_SEL		77
>> +#define CLKID_VDEC_P0_DIV		78
>> +#define CLKID_VDEC_P1_SEL		80
>> +#define CLKID_VDEC_P1_DIV		81
>> +#define CLKID_HEVCF_P0_SEL		84
>> +#define CLKID_HEVCF_P0_DIV		85
>> +#define CLKID_HEVCF_P1_SEL		87
>> +#define CLKID_HEVCF_P1_DIV		88
>> +#define CLKID_VPU_0_SEL			91
>> +#define CLKID_VPU_0_DIV			92
>> +#define CLKID_VPU_1_SEL			94
>> +#define CLKID_VPU_1_DIV			95
>> +#define CLKID_VPU_CLKB_TMP_SEL		98
>> +#define CLKID_VPU_CLKB_TMP_DIV		99
>> +#define CLKID_VPU_CLKB_DIV		101
>> +#define CLKID_VPU_CLKC_P0_SEL		103
>> +#define CLKID_VPU_CLKC_P0_DIV		104
>> +#define CLKID_VPU_CLKC_P1_SEL		106
>> +#define CLKID_VPU_CLKC_P1_DIV		107
>> +#define CLKID_VAPB_0_SEL		110
>> +#define CLKID_VAPB_0_DIV		111
>> +#define CLKID_VAPB_1_SEL		113
>> +#define CLKID_VAPB_1_DIV		114
>> +#define CLKID_VDIN_MEAS_SEL		118
>> +#define CLKID_VDIN_MEAS_DIV		119
>> +#define CLKID_SD_EMMC_C_CLK_SEL		121
>> +#define CLKID_SD_EMMC_C_CLK_DIV		122
>> +#define CLKID_SD_EMMC_A_CLK_SEL		124
>> +#define CLKID_SD_EMMC_A_CLK_DIV		125
>> +#define CLKID_SD_EMMC_B_CLK_SEL		127
>> +#define CLKID_SD_EMMC_B_CLK_DIV		128
>> +#define CLKID_SPICC0_SEL		130
>> +#define CLKID_SPICC0_DIV		131
>> +#define CLKID_PWM_A_SEL			133
>> +#define CLKID_PWM_A_DIV			134
>> +#define CLKID_PWM_B_SEL			136
>> +#define CLKID_PWM_B_DIV			137
>> +#define CLKID_PWM_C_SEL			139
>> +#define CLKID_PWM_C_DIV			140
>> +#define CLKID_PWM_D_SEL			142
>> +#define CLKID_PWM_D_DIV			143
>> +#define CLKID_PWM_E_SEL			145
>> +#define CLKID_PWM_E_DIV			146
>> +#define CLKID_PWM_F_SEL			148
>> +#define CLKID_PWM_F_DIV			149
>> +#define CLKID_PWM_G_SEL			151
>> +#define CLKID_PWM_G_DIV			152
>> +#define CLKID_PWM_H_SEL			154
>> +#define CLKID_PWM_H_DIV			155
>> +#define CLKID_PWM_I_SEL			157
>> +#define CLKID_PWM_I_DIV			158
>> +#define CLKID_PWM_J_SEL			160
>> +#define CLKID_PWM_J_DIV			161
>> +#define CLKID_SARADC_SEL		163
>> +#define CLKID_SARADC_DIV		164
>> +#define CLKID_GEN_SEL			166
>> +#define CLKID_GEN_DIV			167
>> +#define CLKID_HDCP22_ESMCLK_SEL		219
>> +#define CLKID_HDCP22_ESMCLK_DIV		220
>> +#define CLKID_HDCP22_SKPCLK_SEL		222
>> +#define CLKID_HDCP22_SKPCLK_DIV		223
>> +
>> +#define NR_CLKS				225
>> +/* include the CLKIDs that have been made part of the DT binding */
>> +#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>> +
>> +#endif /* __MESON_S4_PERIPHERALS_H__ */
>> diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>> new file mode 100644
>> index 000000000000..bbec5094d5c3
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>> @@ -0,0 +1,131 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>> + * Author: Yu Tu <yu.tu@amlogic.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
>> +
>> +/*
>> + * CLKID index values
>> + */
>> +
>> +#define CLKID_RTC_CLK			4
>> +#define CLKID_SYS_CLK_B_GATE		7
>> +#define CLKID_SYS_CLK_A_GATE		10
>> +#define CLKID_SYS_CLK			11
>> +#define CLKID_CECA_32K_CLKOUT		16
>> +#define CLKID_CECB_32K_CLKOUT		21
>> +#define CLKID_SC_CLK_GATE		24
>> +#define CLKID_12_24M_CLK_SEL		27
>> +#define CLKID_VID_PLL			30
>> +#define CLKID_VCLK			37
>> +#define CLKID_VCLK2			38
>> +#define CLKID_VCLK_DIV1			39
>> +#define CLKID_VCLK2_DIV1		44
>> +#define CLKID_VCLK_DIV2			49
>> +#define CLKID_VCLK_DIV4			50
>> +#define CLKID_VCLK_DIV6			51
>> +#define CLKID_VCLK_DIV12		52
>> +#define CLKID_VCLK2_DIV2		53
>> +#define CLKID_VCLK2_DIV4		54
>> +#define CLKID_VCLK2_DIV6		55
>> +#define CLKID_VCLK2_DIV12		56
>> +#define CLKID_CTS_ENCI			61
>> +#define CLKID_CTS_ENCP			62
>> +#define CLKID_CTS_VDAC			63
>> +#define CLKID_HDMI			67
>> +#define CLKID_TS_CLK_GATE		69
>> +#define CLKID_MALI_0			72
>> +#define CLKID_MALI_1			75
>> +#define CLKID_MALI			76
>> +#define CLKID_VDEC_P0			79
>> +#define CLKID_VDEC_P1			82
>> +#define CLKID_VDEC_SEL			83
>> +#define CLKID_HEVCF_P0			86
>> +#define CLKID_HEVCF_P1			89
>> +#define CLKID_HEVCF_SEL			90
>> +#define CLKID_VPU_0			93
>> +#define CLKID_VPU_1			96
>> +#define CLKID_VPU			97
>> +#define CLKID_VPU_CLKB_TMP		100
>> +#define CLKID_VPU_CLKB			102
>> +#define CLKID_VPU_CLKC_P0		105
>> +#define CLKID_VPU_CLKC_P1		108
>> +#define CLKID_VPU_CLKC_SEL		109
>> +#define CLKID_VAPB_0			112
>> +#define CLKID_VAPB_1			115
>> +#define CLKID_VAPB			116
>> +#define CLKID_GE2D			117
>> +#define CLKID_VDIN_MEAS_GATE		120
>> +#define CLKID_SD_EMMC_C_CLK		123
>> +#define CLKID_SD_EMMC_A_CLK		126
>> +#define CLKID_SD_EMMC_B_CLK		129
>> +#define CLKID_SPICC0_GATE		132
>> +#define CLKID_PWM_A_GATE		135
>> +#define CLKID_PWM_B_GATE		138
>> +#define CLKID_PWM_C_GATE		141
>> +#define CLKID_PWM_D_GATE		144
>> +#define CLKID_PWM_E_GATE		147
>> +#define CLKID_PWM_F_GATE		150
>> +#define CLKID_PWM_G_GATE		153
>> +#define CLKID_PWM_H_GATE		156
>> +#define CLKID_PWM_I_GATE		159
>> +#define CLKID_PWM_J_GATE		162
>> +#define CLKID_SARADC_GATE		165
>> +#define CLKID_GEN_GATE			168
>> +#define CLKID_DDR			169
>> +#define CLKID_DOS			170
>> +#define CLKID_ETHPHY			171
>> +#define CLKID_MALI_GATE			172
>> +#define CLKID_AOCPU			173
>> +#define CLKID_AUCPU			174
>> +#define CLKID_CEC			175
>> +#define CLKID_SD_EMMC_A			176
>> +#define CLKID_SD_EMMC_B			177
>> +#define CLKID_NAND			178
>> +#define CLKID_SMARTCARD			179
>> +#define CLKID_ACODEC			180
>> +#define CLKID_SPIFC			181
>> +#define CLKID_MSR_CLK			182
>> +#define CLKID_IR_CTRL			183
>> +#define CLKID_AUDIO			184
>> +#define CLKID_ETH			185
>> +#define CLKID_UART_A			186
>> +#define CLKID_UART_B			187
>> +#define CLKID_UART_C			188
>> +#define CLKID_UART_D			189
>> +#define CLKID_UART_E			190
>> +#define CLKID_AIFIFO			191
>> +#define CLKID_TS_DDR			192
>> +#define CLKID_TS_PLL			193
>> +#define CLKID_G2D			194
>> +#define CLKID_SPICC0			195
>> +#define CLKID_SPICC1			196
>> +#define CLKID_USB			197
>> +#define CLKID_I2C_M_A			198
>> +#define CLKID_I2C_M_B			199
>> +#define CLKID_I2C_M_C			200
>> +#define CLKID_I2C_M_D			201
>> +#define CLKID_I2C_M_E			202
>> +#define CLKID_HDMITX_APB		203
>> +#define CLKID_I2C_S_A			204
>> +#define CLKID_USB1_TO_DDR		205
>> +#define CLKID_HDCP22			206
>> +#define CLKID_MMC_APB			207
>> +#define CLKID_RSA			208
>> +#define CLKID_CPU_DEBUG			209
>> +#define CLKID_VPU_INTR			210
>> +#define CLKID_DEMOD			211
>> +#define CLKID_SAR_ADC			212
>> +#define CLKID_GIC			213
>> +#define CLKID_PWM_AB			214
>> +#define CLKID_PWM_CD			215
>> +#define CLKID_PWM_EF			216
>> +#define CLKID_PWM_GH			217
>> +#define CLKID_PWM_IJ			218
>> +#define CLKID_HDCP22_ESMCLK_GATE	221
>> +#define CLKID_HDCP22_SKPCLK_GATE	224
>> +
>> +#endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */
> 
> .
