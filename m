Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1906806E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbjA3IGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjA3IGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:06:48 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8E718AA7;
        Mon, 30 Jan 2023 00:06:44 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1154F24E3A6;
        Mon, 30 Jan 2023 16:06:37 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 16:06:37 +0800
Received: from [192.168.125.128] (183.27.97.127) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 16:06:35 +0800
Message-ID: <0e77bf23-b359-9884-6a8c-368e31d718a4@starfivetech.com>
Date:   Mon, 30 Jan 2023 16:02:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 03/11] clk: starfive: Add StarFive JH7110
 System-Top-Group clock driver
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230120024445.244345-1-xingyu.wu@starfivetech.com>
 <20230120024445.244345-4-xingyu.wu@starfivetech.com>
 <5bb5263d26b157548d7ba39f80989c69.sboyd@kernel.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <5bb5263d26b157548d7ba39f80989c69.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.127]
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

On 2023/1/26 10:33, Stephen Boyd wrote:
> Quoting Xingyu Wu (2023-01-19 18:44:37)
>> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-stg.c b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
>> new file mode 100644
>> index 000000000000..c2740f44e796
>> --- /dev/null
>> +++ b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
>> @@ -0,0 +1,180 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * StarFive JH7110 System-Top-Group Clock Driver
>> + *
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
> 
> Is this include used? If not, please remove.

Will drop in next patch.


> 
>> +#include <linux/clk-provider.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
>> +
>> +#include "clk-starfive-jh71x0.h"
>> +
> [...]
>> +static int jh7110_stgcrg_probe(struct platform_device *pdev)
>> +{
>> +       struct jh71x0_clk_priv *priv;
>> +       unsigned int idx;
>> +       int ret;
>> +
>> +       priv = devm_kzalloc(&pdev->dev,
>> +                           struct_size(priv, reg, JH7110_STGCLK_END),
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
>> +       for (idx = 0; idx < JH7110_STGCLK_END; idx++) {
>> +               u32 max = jh7110_stgclk_data[idx].max;
>> +               struct clk_parent_data parents[4] = {};
>> +               struct clk_init_data init = {
>> +                       .name = jh7110_stgclk_data[idx].name,
>> +                       .ops = starfive_jh71x0_clk_ops(max),
>> +                       .parent_data = parents,
>> +                       .num_parents =
>> +                               ((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
>> +                       .flags = jh7110_stgclk_data[idx].flags,
>> +               };
>> +               struct jh71x0_clk *clk = &priv->reg[idx];
>> +               unsigned int i;
>> +
>> +               for (i = 0; i < init.num_parents; i++) {
>> +                       unsigned int pidx = jh7110_stgclk_data[idx].parents[i];
>> +
>> +                       if (pidx < JH7110_STGCLK_END)
>> +                               parents[i].hw = &priv->reg[pidx].hw;
>> +                       else if (pidx == JH7110_STGCLK_OSC)
>> +                               parents[i].fw_name = "osc";
>> +                       else if (pidx == JH7110_STGCLK_HIFI4_CORE)
>> +                               parents[i].fw_name = "hifi4_core";
>> +                       else if (pidx == JH7110_STGCLK_STG_AXIAHB)
>> +                               parents[i].fw_name = "stg_axiahb";
>> +                       else if (pidx == JH7110_STGCLK_USB_125M)
>> +                               parents[i].fw_name = "usb_125m";
>> +                       else if (pidx == JH7110_STGCLK_CPU_BUS)
>> +                               parents[i].fw_name = "cpu_bus";
>> +                       else if (pidx == JH7110_STGCLK_HIFI4_AXI)
>> +                               parents[i].fw_name = "hifi4_axi";
>> +                       else if (pidx == JH7110_STGCLK_NOCSTG_BUS)
>> +                               parents[i].fw_name = "nocstg_bus";
>> +                       else if (pidx == JH7110_STGCLK_APB_BUS)
>> +                               parents[i].fw_name = "apb_bus";
> 
> Can this be an array lookup instead of a pile of conditions?
> 
> 	if (pidx < JH7110_STGCLK_END)
> 		...
> 	else
> 		parents[i].fw_name = fw_table[pidx - JH7110_STGCLK_END];
> 
> Or even better, don't use strings at all and just make the 'pidx' number
> (possibly minus the end constant) be the 'clocks' property index that
> you want.

It seen to be a good way that there uses an array.
Based on the another way, can I use the 'pidx' number to get the 'clock-names' property
to be the parent clock name?

> 
>> +               }
>> +
>> +               clk->hw.init = &init;
>> +               clk->idx = idx;
>> +               clk->max_div = max & JH71X0_CLK_DIV_MASK;
>> +
>> +               ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_stgclk_get, priv);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return jh7110_reset_controller_register(priv, "reset-stg", 2);
> 
> Is this also devm-ified?

No, it need to be freed actively. I will advise Hal Feng this.


Best regards,
Xingyu Wu
