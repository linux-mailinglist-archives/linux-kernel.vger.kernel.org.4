Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF2E6A04DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjBWJco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjBWJcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:32:43 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4134D17159;
        Thu, 23 Feb 2023 01:32:41 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id D85AB24E294;
        Thu, 23 Feb 2023 17:32:39 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 17:32:39 +0800
Received: from [192.168.125.128] (113.72.147.165) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 17:32:38 +0800
Message-ID: <5e4007b7-6522-4c81-ca15-15a98c586aad@starfivetech.com>
Date:   Thu, 23 Feb 2023 17:32:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/3] clk: starfive: Add StarFive JH7110 PLL clock
 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230221141147.303642-1-xingyu.wu@starfivetech.com>
 <20230221141147.303642-3-xingyu.wu@starfivetech.com>
 <3f50066b-f967-b9fa-1e0d-5337ec1ed194@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <3f50066b-f967-b9fa-1e0d-5337ec1ed194@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.165]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/23 16:56, Krzysztof Kozlowski wrote:
> On 21/02/2023 15:11, Xingyu Wu wrote:
>> Add driver for the StarFive JH7110 PLL clock controller and
>> modify the JH7110 system clock driver to rely on this PLL clocks.
>> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
> 
> 
>> +
>> +static int jh7110_pll_clk_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct of_phandle_args args;
>> +	struct regmap *pll_syscon_regmap;
>> +	unsigned int idx;
>> +	struct jh7110_clk_pll_priv *priv;
>> +	struct jh7110_clk_pll_data *data;
>> +	char *pll_name[JH7110_PLLCLK_END] = {
>> +		"pll0_out",
>> +		"pll1_out",
>> +		"pll2_out"
>> +	};
>> +
>> +	priv = devm_kzalloc(&pdev->dev,
>> +			    struct_size(priv, data, JH7110_PLLCLK_END),
>> +			    GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->dev = &pdev->dev;
>> +	ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node, "starfive,sysreg", 0, 0, &args);
> 
> 1. Wrong wrapping. Wrap code at 80 as coding style asks.
> 
> 2. Why you are using syscon for normal, device MMIO operation? Your DTS
> also points that this is incorrect, hacky representation of hardware.
> Don't add devices to DT to fake places and then overuse syscon to fix
> that fake placement. The clock is in system registers, thus it must be
> there.
> 
> 3. Even if this stays, why so complicated code instead of
> syscon_regmap_lookup_by_phandle()?
> 

Thanks for your advice. Will use syscon_regmap_lookup_by_phandle instead it
and remove useless part.

> 
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to parse starfive,sys-syscon : %d\n", ret);
> 
> dev_err_probe and in other places as well, if applicable.

Will drop.

Best regards,
Xingyu Wu

