Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2CA6749A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjATC7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjATC7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:59:00 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0589EE3F;
        Thu, 19 Jan 2023 18:58:11 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 20 Jan
 2023 10:58:09 +0800
Message-ID: <55659095-86d7-91b6-2db6-5cdca228bc09@amlogic.com>
Date:   Fri, 20 Jan 2023 10:58:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V6 2/3] clk: meson: S4: add support for Amlogic S4 SoC PLL
 clock driver
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
 <20230116074214.2326-3-yu.tu@amlogic.com>
 <1jedrqyd3w.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jedrqyd3w.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On 2023/1/19 19:20, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Mon 16 Jan 2023 at 15:42, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> Add the S4 PLL clock controller driver in the s4 SoC family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
> 
> [...]
> 
>> +
>> +static struct clk_regmap s4_fclk_div2 = {
>> +	.data = &(struct clk_regmap_gate_data){
>> +		.offset = ANACTRL_FIXPLL_CTRL1,
>> +		.bit_idx = 24,
>> +	},
>> +	.hw.init = &(struct clk_init_data){
>> +		.name = "fclk_div2",
>> +		.ops = &clk_regmap_gate_ro_ops,
> 
> On the previous SoC, these fixed divider gate were not read-only.
> They are marked as critical when necessary, with the appropriate
> comment.
> 
> Why is it different on the s4 ?

In fact, this part of the SOC is no different from the previous G12a/b 
and so on.

I remember that my first version was made according to G12A, and I 
changed this way under your suggestion.

Maybe you were busy and forgot. For me, this mode and the previous g12a 
mode function is ok. I can do either. So now how do you decide to go 
that way?

> 
>> +		.parent_hws = (const struct clk_hw *[]) {
>> +			&s4_fclk_div2_div.hw
>> +		},
>> +		.num_parents = 1,
>> +	},
>> +};
>> +
> 
> [...]
> 
>> +#ifndef __MESON_S4_PLL_H__
>> +#define __MESON_S4_PLL_H__
>> +
>> +/* ANA_CTRL - Registers
>> + * REG_BASE:  REGISTER_BASE_ADDR = 0xfe008000
> 
> This multi-line comment style is wrong in clk/
> REG_BASE is not used so I'm not sure this is useful

I will remove REG_BASE and  change this format in next version.

> 
>> + */
>> +#define ANACTRL_FIXPLL_CTRL0                       0x040
>> +#define ANACTRL_FIXPLL_CTRL1                       0x044
>> +#define ANACTRL_FIXPLL_CTRL2                       0x048
>> +#define ANACTRL_FIXPLL_CTRL3                       0x04c
>> +#define ANACTRL_FIXPLL_CTRL4                       0x050
>> +#define ANACTRL_FIXPLL_CTRL5                       0x054
>> +#define ANACTRL_FIXPLL_CTRL6                       0x058
>> +#define ANACTRL_FIXPLL_STS                         0x05c
>> +#define ANACTRL_GP0PLL_CTRL0                       0x080
>> +#define ANACTRL_GP0PLL_CTRL1                       0x084
>> +#define ANACTRL_GP0PLL_CTRL2                       0x088
>> +#define ANACTRL_GP0PLL_CTRL3                       0x08c
>> +#define ANACTRL_GP0PLL_CTRL4                       0x090
>> +#define ANACTRL_GP0PLL_CTRL5                       0x094
>> +#define ANACTRL_GP0PLL_CTRL6                       0x098
>> +#define ANACTRL_GP0PLL_STS                         0x09c
>> +#define ANACTRL_HIFIPLL_CTRL0                      0x100
>> +#define ANACTRL_HIFIPLL_CTRL1                      0x104
>> +#define ANACTRL_HIFIPLL_CTRL2                      0x108
>> +#define ANACTRL_HIFIPLL_CTRL3                      0x10c
>> +#define ANACTRL_HIFIPLL_CTRL4                      0x110
>> +#define ANACTRL_HIFIPLL_CTRL5                      0x114
>> +#define ANACTRL_HIFIPLL_CTRL6                      0x118
>> +#define ANACTRL_HIFIPLL_STS                        0x11c
>> +#define ANACTRL_MPLL_CTRL0                         0x180
>> +#define ANACTRL_MPLL_CTRL1                         0x184
>> +#define ANACTRL_MPLL_CTRL2                         0x188
>> +#define ANACTRL_MPLL_CTRL3                         0x18c
>> +#define ANACTRL_MPLL_CTRL4                         0x190
>> +#define ANACTRL_MPLL_CTRL5                         0x194
>> +#define ANACTRL_MPLL_CTRL6                         0x198
>> +#define ANACTRL_MPLL_CTRL7                         0x19c
>> +#define ANACTRL_MPLL_CTRL8                         0x1a0
>> +#define ANACTRL_MPLL_STS                           0x1a4
>> +#define ANACTRL_HDMIPLL_CTRL0                      0x1c0
>> +#define ANACTRL_HDMIPLL_CTRL1                      0x1c4
>> +#define ANACTRL_HDMIPLL_CTRL2                      0x1c8
>> +#define ANACTRL_HDMIPLL_CTRL3                      0x1cc
>> +#define ANACTRL_HDMIPLL_CTRL4                      0x1d0
>> +#define ANACTRL_HDMIPLL_CTRL5                      0x1d4
>> +#define ANACTRL_HDMIPLL_CTRL6                      0x1d8
>> +#define ANACTRL_HDMIPLL_STS                        0x1dc
>> +#define ANACTRL_HDMIPLL_VLOCK                      0x1e4
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
>> +#define CLKID_FIXED_PLL_DCO		0
>> +#define CLKID_FCLK_DIV2_DIV		2
>> +#define CLKID_FCLK_DIV3_DIV		4
>> +#define CLKID_FCLK_DIV4_DIV		6
>> +#define CLKID_FCLK_DIV5_DIV		8
>> +#define CLKID_FCLK_DIV7_DIV		10
>> +#define CLKID_FCLK_DIV2P5_DIV		12
>> +#define CLKID_GP0_PLL_DCO		14
>> +#define CLKID_HIFI_PLL_DCO		16
>> +#define CLKID_HDMI_PLL_DCO		18
>> +#define CLKID_HDMI_PLL_OD		19
>> +#define CLKID_MPLL_50M_DIV		21
>> +#define CLKID_MPLL_PREDIV		23
>> +#define CLKID_MPLL0_DIV			24
>> +#define CLKID_MPLL1_DIV			26
>> +#define CLKID_MPLL2_DIV			28
>> +#define CLKID_MPLL3_DIV			30
>> +
>> +#define NR_PLL_CLKS			32
>> +/* include the CLKIDs that have been made part of the DT binding */
>> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
>> +
>> +#endif /* __MESON_S4_PLL_H__ */
> 
