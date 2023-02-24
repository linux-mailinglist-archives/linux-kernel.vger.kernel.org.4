Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC46A1774
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBXHpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBXHpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:45:03 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AB517CC0;
        Thu, 23 Feb 2023 23:45:01 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 467D724E154;
        Fri, 24 Feb 2023 15:44:48 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 15:44:48 +0800
Received: from [192.168.125.128] (113.72.147.165) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 15:44:46 +0800
Message-ID: <3d9679f8-45c6-3f27-b671-a0828a1a4ad3@starfivetech.com>
Date:   Fri, 24 Feb 2023 15:45:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/3] clk: starfive: Add StarFive JH7110 PLL clock
 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230221141147.303642-1-xingyu.wu@starfivetech.com>
 <20230221141147.303642-3-xingyu.wu@starfivetech.com>
 <3f50066b-f967-b9fa-1e0d-5337ec1ed194@linaro.org>
 <5e4007b7-6522-4c81-ca15-15a98c586aad@starfivetech.com>
 <50b6fb73-afb2-051b-7969-d7fbbe1e6175@linaro.org>
 <f23b3755-e2dd-f858-02ad-3f1b58934bc6@starfivetech.com>
 <d76f25ff-3c60-4e9b-87d7-8c4043b2e47f@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <d76f25ff-3c60-4e9b-87d7-8c4043b2e47f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.165]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/23 18:10, Krzysztof Kozlowski wrote:
> On 23/02/2023 11:03, Xingyu Wu wrote:
>> On 2023/2/23 17:35, Krzysztof Kozlowski wrote:
>>> On 23/02/2023 10:32, Xingyu Wu wrote:
>>>> On 2023/2/23 16:56, Krzysztof Kozlowski wrote:
>>>>> On 21/02/2023 15:11, Xingyu Wu wrote:
>>>>>> Add driver for the StarFive JH7110 PLL clock controller and
>>>>>> modify the JH7110 system clock driver to rely on this PLL clocks.
>>>>>>
>>>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>>>> ---
>>>>>
>>>>>
>>>>>> +
>>>>>> +static int jh7110_pll_clk_probe(struct platform_device *pdev)
>>>>>> +{
>>>>>> +	int ret;
>>>>>> +	struct of_phandle_args args;
>>>>>> +	struct regmap *pll_syscon_regmap;
>>>>>> +	unsigned int idx;
>>>>>> +	struct jh7110_clk_pll_priv *priv;
>>>>>> +	struct jh7110_clk_pll_data *data;
>>>>>> +	char *pll_name[JH7110_PLLCLK_END] = {
>>>>>> +		"pll0_out",
>>>>>> +		"pll1_out",
>>>>>> +		"pll2_out"
>>>>>> +	};
>>>>>> +
>>>>>> +	priv = devm_kzalloc(&pdev->dev,
>>>>>> +			    struct_size(priv, data, JH7110_PLLCLK_END),
>>>>>> +			    GFP_KERNEL);
>>>>>> +	if (!priv)
>>>>>> +		return -ENOMEM;
>>>>>> +
>>>>>> +	priv->dev = &pdev->dev;
>>>>>> +	ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node, "starfive,sysreg", 0, 0, &args);
>>>>>
>>>>> 1. Wrong wrapping. Wrap code at 80 as coding style asks.
>>>>>
>>>>> 2. Why you are using syscon for normal, device MMIO operation? Your DTS
>>>>> also points that this is incorrect, hacky representation of hardware.
>>>>> Don't add devices to DT to fake places and then overuse syscon to fix
>>>>> that fake placement. The clock is in system registers, thus it must be
>>>>> there.
>>>>>
>>>>> 3. Even if this stays, why so complicated code instead of
>>>>> syscon_regmap_lookup_by_phandle()?
>>>>>
>>>>
>>>> Thanks for your advice. Will use syscon_regmap_lookup_by_phandle instead it
>>>> and remove useless part.
>>>
>>> So you ignored entirely part 2? This was the main comment... I am going
>>> to keep NAK-ing it then.
>> 
>> What I understand to mean is that I cannot use a fake node to operate syscon
>> registers. So I should move the PLL node under syscon node directly. Is it ok?
> 
> Yes, because it looks like entire PLL clock control is from the syscon
> node, thus the clocks are there.

Thanks for the guidance, I will modify it in the next patch.

Best regards,
Xingyu Wu
