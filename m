Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599236C4029
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCVCHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVCHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:07:35 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66F8546157;
        Tue, 21 Mar 2023 19:07:32 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxPNriYhpkk8sPAA--.12190S3;
        Wed, 22 Mar 2023 10:07:30 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxSL3eYhpkL0kJAA--.381S3;
        Wed, 22 Mar 2023 10:07:29 +0800 (CST)
Subject: Re: [PATCH v15 2/2] clk: clk-loongson2: add clock controller driver
 support
To:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230321130710.20236-1-zhuyinbo@loongson.cn>
 <20230321130710.20236-2-zhuyinbo@loongson.cn>
 <26c4712672de6c4f70f88c6846bc892f.sboyd@kernel.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <79ceb9c5-2657-ca9b-e017-5ec14acfcda1@loongson.cn>
Date:   Wed, 22 Mar 2023 10:07:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <26c4712672de6c4f70f88c6846bc892f.sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxSL3eYhpkL0kJAA--.381S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Jr1DWr4kJFyfGFykZFWkWFg_yoW3XryxpF
        yfAay7Wa4jqr429rnIqFyDGFn8AryfK3W7CF43Jryjkr92v3s3Wr48CFyfC3Z5ZrWkCa42
        vrWDurZ8uFs0grJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bTAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64
        vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
        14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
        4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
        WIevJa73UjIFyTuYvjxU7J3vUUUUU
X-Spam-Status: No, score=3.6 required=5.0 tests=NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/22 上午7:42, Stephen Boyd 写道:
> Quoting Yinbo Zhu (2023-03-21 06:07:10)
>> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
>> new file mode 100644
>> index 000000000000..090810655511
>> --- /dev/null
>> +++ b/drivers/clk/clk-loongson2.c
>> @@ -0,0 +1,344 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
>> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/slab.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>> +#include <dt-bindings/clock/loongson,ls2k-clk.h>
>> +
>> +#define LOONGSON2_PLL_MULT_SHIFT               32
>> +#define LOONGSON2_PLL_MULT_WIDTH               10
>> +#define LOONGSON2_PLL_DIV_SHIFT                        26
>> +#define LOONGSON2_PLL_DIV_WIDTH                        6
>> +#define LOONGSON2_APB_FREQSCALE_SHIFT          20
>> +#define LOONGSON2_APB_FREQSCALE_WIDTH          3
>> +#define LOONGSON2_USB_FREQSCALE_SHIFT          16
>> +#define LOONGSON2_USB_FREQSCALE_WIDTH          3
>> +#define LOONGSON2_SATA_FREQSCALE_SHIFT         12
>> +#define LOONGSON2_SATA_FREQSCALE_WIDTH         3
>> +#define LOONGSON2_BOOT_FREQSCALE_SHIFT         8
>> +#define LOONGSON2_BOOT_FREQSCALE_WIDTH         3
>> +
>> +static void __iomem *loongson2_pll_base;
> Why is this a global?

Normally, this should be an element in the structure, but since there is 
only one

element, It is directly defined as a global variable for use by other 
function.

>
>> +
>> +static const struct clk_parent_data pdata[] = {
>> +       { .fw_name = "ref_100m",},
>> +};
>> +
>> +static struct clk_hw *loongson2_clk_register(struct device *dev,
>> +                                         const char *name,
>> +                                         const char *parent_name,
>> +                                         const struct clk_ops *ops,
>> +                                         unsigned long flags)
>> +{
>> +       int ret;
>> +       struct clk_hw *hw;
>> +       struct clk_init_data init;
>> +
>> +       /* allocate the divider */
> Remove useless comment.
okay , I will remove it.
>
>> +       hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
>> +       if (!hw)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init.name = name;
>> +       init.ops = ops;
>> +       init.flags = flags;
>> +       init.num_parents = 1;
>> +
>> +       if (!parent_name)
>> +               init.parent_data = pdata;
>> +       else
>> +               init.parent_names = &parent_name;
>> +
>> +       hw->init = &init;
>> +
>> +       /* register the clock */
> Remove useless comment.
okay, I will remove it.
>
>> +       ret = devm_clk_hw_register(dev, hw);
>> +       if (ret)
>> +               hw = ERR_PTR(ret);
>> +
>> +       return hw;
>> +}
>> +
> [....]
>> +
>> +static const struct clk_ops loongson2_sata_clk_ops = {
>> +       .recalc_rate = loongson2_sata_recalc_rate,
>> +};
>> +
>> +static inline void loongson2_check_clk_hws(struct clk_hw *clks[], unsigned int count)
> This needs to return an error instead of be void.
okay, I got it.
>
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < count; i++)
>> +               if (IS_ERR(clks[i]))
>> +                       pr_err("Loongson2 clk %u: register failed with %ld\n",
>> +                               i, PTR_ERR(clks[i]));
>> +}
>> +
>> +static inline void loongson2_clocks_init(struct device *dev)
>> +{
>> +       struct clk_hw **hws;
>> +       struct clk_hw_onecell_data *clk_hw_data;
>> +       spinlock_t loongson2_clk_lock;
>> +
>> +       clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, LOONGSON2_CLK_END),
>> +                                       GFP_KERNEL);
>> +       if (WARN_ON(!clk_hw_data))
>> +               return;
>> +
>> +       clk_hw_data->num = LOONGSON2_CLK_END;
>> +       hws = clk_hw_data->hws;
>> +
>> +       hws[LOONGSON2_NODE_PLL] = loongson2_clk_register(dev, "node_pll",
>> +                                               NULL,
>> +                                               &loongson2_node_clk_ops, 0);
>> +
>> +       hws[LOONGSON2_DDR_PLL] = loongson2_clk_register(dev, "ddr_pll",
>> +                                               NULL,
>> +                                               &loongson2_ddr_clk_ops, 0);
>> +
>> +       hws[LOONGSON2_DC_PLL] = loongson2_clk_register(dev, "dc_pll",
>> +                                               NULL,
>> +                                               &loongson2_dc_clk_ops, 0);
>> +
>> +       hws[LOONGSON2_PIX0_PLL] = loongson2_clk_register(dev, "pix0_pll",
>> +                                               NULL,
>> +                                               &loongson2_pix0_clk_ops, 0);
>> +
>> +       hws[LOONGSON2_PIX1_PLL] = loongson2_clk_register(dev, "pix1_pll",
>> +                                               NULL,
>> +                                               &loongson2_pix1_clk_ops, 0);
>> +
>> +       hws[LOONGSON2_BOOT_CLK] = loongson2_clk_register(dev, "boot",
>> +                                               NULL,
>> +                                               &loongson2_boot_clk_ops, 0);
>> +
>> +       hws[LOONGSON2_NODE_CLK] = clk_hw_register_divider(NULL, "node",
> These should be devm_ variants so they're undone on failure.
okay , I will use devm_clk_hw_register_divider
>
>> +                                               "node_pll", 0,
>> +                                               loongson2_pll_base + 0x8, 0,
>> +                                               6, CLK_DIVIDER_ONE_BASED,
>> +                                               &loongson2_clk_lock);
>> +
>> +       /*
>> +        * The hda clk divisor in the upper 32bits and the clk-prodiver
>> +        * layer code doesn't support 64bit io operation thus a conversion
>> +        * is required that subtract shift by 32 and add 4byte to the hda
>> +        * address
>> +        */
>> +       hws[LOONGSON2_HDA_CLK] = clk_hw_register_divider(NULL, "hda",
>> +                                               "ddr_pll", 0,
>> +                                               loongson2_pll_base + 0x22, 12,
>> +                                               7, CLK_DIVIDER_ONE_BASED,
>> +                                               &loongson2_clk_lock);
>> +
>> +       hws[LOONGSON2_GPU_CLK] = clk_hw_register_divider(NULL, "gpu",
>> +                                               "ddr_pll", 0,
>> +                                               loongson2_pll_base + 0x18, 22,
>> +                                               6, CLK_DIVIDER_ONE_BASED,
>> +                                               &loongson2_clk_lock);
>> +
>> +       hws[LOONGSON2_DDR_CLK] = clk_hw_register_divider(NULL, "ddr",
>> +                                               "ddr_pll", 0,
>> +                                               loongson2_pll_base + 0x18, 0,
>> +                                               6, CLK_DIVIDER_ONE_BASED,
>> +                                               &loongson2_clk_lock);
>> +
>> +       hws[LOONGSON2_GMAC_CLK] = clk_hw_register_divider(NULL, "gmac",
>> +                                               "dc_pll", 0,
>> +                                               loongson2_pll_base + 0x28, 22,
>> +                                               6, CLK_DIVIDER_ONE_BASED,
>> +                                               &loongson2_clk_lock);
>> +
>> +       hws[LOONGSON2_DC_CLK] = clk_hw_register_divider(NULL, "dc",
>> +                                               "dc_pll", 0,
>> +                                               loongson2_pll_base + 0x28, 0,
>> +                                               6, CLK_DIVIDER_ONE_BASED,
>> +                                               &loongson2_clk_lock);
>> +
>> +       hws[LOONGSON2_APB_CLK] = loongson2_clk_register(dev, "apb",
>> +                                               "gmac",
>> +                                               &loongson2_apb_clk_ops, 0);
>> +
>> +       hws[LOONGSON2_USB_CLK] = loongson2_clk_register(dev, "usb",
>> +                                               "gmac",
>> +                                               &loongson2_usb_clk_ops, 0);
>> +
>> +       hws[LOONGSON2_SATA_CLK] = loongson2_clk_register(dev, "sata",
>> +                                               "gmac",
>> +                                               &loongson2_sata_clk_ops, 0);
>> +
>> +       hws[LOONGSON2_PIX0_CLK] = clk_hw_register_divider(NULL, "pix0",
>> +                                               "pix0_pll", 0,
>> +                                               loongson2_pll_base + 0x38, 0, 6,
>> +                                               CLK_DIVIDER_ONE_BASED,
>> +                                               &loongson2_clk_lock);
>> +
>> +       hws[LOONGSON2_PIX1_CLK] = clk_hw_register_divider(NULL, "pix1",
>> +                                               "pix1_pll", 0,
>> +                                               loongson2_pll_base + 0x48, 0, 6,
>> +                                               CLK_DIVIDER_ONE_BASED,
>> +                                               &loongson2_clk_lock);
>> +
>> +       loongson2_check_clk_hws(hws, LOONGSON2_CLK_END);
>> +
>> +       devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
> Return this error code.
okay, I got it.
>
>> +}
>> +
>> +static const struct of_device_id loongson2_clk_match_table[] = {
>> +       { .compatible = "loongson,ls2k-clk" },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, loongson2_clk_match_table);
> This table can go next to the driver instead of be above probe.
okay, I will move it above loongson2_clk_driver.
>
>> +
>> +static int loongson2_clk_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +
>> +       loongson2_pll_base = devm_platform_ioremap_resource(pdev, 0);
>> +       if (!loongson2_pll_base)
> Should be IS_ERR(loongson2_pll_base)
okay, I got it.
>
>> +               return PTR_ERR(loongson2_pll_base);
>> +
>> +       loongson2_clocks_init(dev);
> Please inline this function here.

The loongson2_clocks_init had inline in this version, or do you mean something else ? Need to inline the probe?

