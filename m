Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118EC69DAB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjBUGoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjBUGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:44:28 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7661C7FA;
        Mon, 20 Feb 2023 22:44:19 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4757F24E31E;
        Tue, 21 Feb 2023 14:44:12 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 14:44:12 +0800
Received: from [192.168.125.82] (183.27.98.67) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 14:44:11 +0800
Message-ID: <d7880fbb-ee6a-751b-4372-9d3154257c6c@starfivetech.com>
Date:   Tue, 21 Feb 2023 14:44:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 09/11] clk: starfive: Add StarFive JH7110 system clock
 driver
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-10-hal.feng@starfivetech.com>
 <CAJM55Z-qpQkLjSFN33ELGE8DtoygY+vL6zi2raPh6POJ69pjbg@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z-qpQkLjSFN33ELGE8DtoygY+vL6zi2raPh6POJ69pjbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.67]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2023 22:23:39 +0100, Emil Renner Berthing wrote:
> On Tue, 20 Dec 2022 at 01:51, Hal Feng <hal.feng@starfivetech.com> wrote:
>> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> new file mode 100644
>> index 000000000000..abc1c280bbe3
>> --- /dev/null
>> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> @@ -0,0 +1,448 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * StarFive JH7110 System Clock Driver
[...]
>> +static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>> +{
>> +       struct jh71x0_clk_priv *priv;
>> +       unsigned int idx;
>> +       int ret;
>> +
>> +       priv = devm_kzalloc(&pdev->dev,
>> +                           struct_size(priv, reg, JH7110_SYSCLK_PLL0_OUT),
>> +                           GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       spin_lock_init(&priv->rmw_lock);
>> +       priv->dev = &pdev->dev;
>> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
>> +       if (IS_ERR(priv->base))
>> +               return PTR_ERR(priv->base);
>> +
>> +       dev_set_drvdata(priv->dev, priv->base);
>> +
>> +       /* 24MHz -> 1250.0MHz */
>> +       priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
>> +                                                        "osc", 0, 625, 12);
>> +       if (IS_ERR(priv->pll[0]))
>> +               return PTR_ERR(priv->pll[0]);
> 
> Hi Hal,
> 
> Are you sure this should be 1.25GHz and not 1GHz? I can't seem to make
> the ethernet driver work unless I set it to 1GHz. This also makes
> other derived clocks that should be 125MHz show up as such in the
> clock tree. Eg. "usb_125m".
> 
> Perhaps it's because I updated my board to the latest u-boot
> release[1]. I know these PLLs are just placeholders until you add
> proper code to control them, but until then it's important that these
> values match the defaults or whatever the latest u-boot sets them to.
> Please check the PLLs below with the latest u-boot too.
> 
> /Emil
> 
> [1]: https://github.com/starfive-tech/VisionFive2/releases

After this series sent out, we found a bug in the u-boot when cpu
running at 1.25 GHz, so now the cpu runs at 1GHz in the latest
u-boot. I have updated it in v4. Thanks for reminding.
What's more, we will support adjusting the cpu frequency in the
future, so the cpu can run at a higher frequency.

Best regards,
Hal

> 
>> +       /* 24MHz -> 1066.0MHz */
>> +       priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
>> +                                                        "osc", 0, 533, 12);
>> +       if (IS_ERR(priv->pll[1]))
>> +               return PTR_ERR(priv->pll[1]);
>> +
>> +       /* 24MHz -> 1188.0MHz */
>> +       priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
>> +                                                        "osc", 0, 99, 2);
>> +       if (IS_ERR(priv->pll[2]))
>> +               return PTR_ERR(priv->pll[2]);

