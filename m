Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA4469776C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBOHfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjBOHf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:35:29 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFEBA28D31;
        Tue, 14 Feb 2023 23:35:26 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Dx_5c8i+xjQ9gAAA--.1131S3;
        Wed, 15 Feb 2023 15:35:24 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxjb46i+xjua4zAA--.34600S3;
        Wed, 15 Feb 2023 15:35:22 +0800 (CST)
Subject: Re: [PATCH v10 2/4] clk: clk-loongson2: add clock controller driver
 support
To:     Stephen Boyd <sboyd@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yang Li <yang.lee@linux.alibaba.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        wanghongliang@loongson.cn, liupeibao@loongson.cn,
        zhuyinbo@loongson.cn
References: <20221129034157.15036-1-zhuyinbo@loongson.cn>
 <20221129034157.15036-2-zhuyinbo@loongson.cn>
 <31c690a347f858a477bbba9c838984ed.sboyd@kernel.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <4b5fd886-57ce-01ef-8224-432898b7fb1c@loongson.cn>
Date:   Wed, 15 Feb 2023 15:35:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <31c690a347f858a477bbba9c838984ed.sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxjb46i+xjua4zAA--.34600S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Zr13AF4DKw4kZw15urW3ZFb_yoWkKFWUpF
        yfAayUWFWUtr48ur4jqryDGF98A343t3W7AF43JFyUCrZ2v3sYgr4UWFy29F4UZrWkCry2
        vFWDWrZruFs8trJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8FAp5UUUUU==
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/11 上午7:42, Stephen Boyd 写道:
> Quoting Yinbo Zhu (2022-11-28 19:41:55)
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 903096bd87f8..4f8f1b8f796d 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -127,6 +127,7 @@ config LOONGARCH
>>          select USE_PERCPU_NUMA_NODE_ID
>>          select USER_STACKTRACE_SUPPORT
>>          select ZONE_DMA32
>> +       select COMMON_CLK
> Any reason to put this at the end instead of alphabetically?
okay, I will change it as alphabetically.
>>   
>>   config 32BIT
>>          bool
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index d79905f3e174..d13626f63739 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -326,6 +326,15 @@ config COMMON_CLK_LOCHNAGAR
>>            This driver supports the clocking features of the Cirrus Logic
>>            Lochnagar audio development board.
>>   
>> +config COMMON_CLK_LOONGSON2
>> +       bool "Clock driver for Loongson-2 SoC"
>> +       depends on COMMON_CLK && OF
>> +       help
>> +         This driver provides support for Clock Controller that base on
> Don't capitalize 'Clock Controller'
okay, I got it.
>
>> +         Common Clock Framework Controller (CCF) on Loongson-2 SoC. The
> CCF doesn't really matter. Just say "support for clock controller on
> Loongson-2 SoC"
okay, I got it.
>
>> +         Clock Controller can generates and supplies clock to various
> Same capitalization comment.
okay, I got it.
>
>> +         peripherals within the SoC.
>> +
>>   config COMMON_CLK_NXP
>>          def_bool COMMON_CLK && (ARCH_LPC18XX || ARCH_LPC32XX)
>>          select REGMAP_MMIO if ARCH_LPC32XX
>> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
>> new file mode 100644
>> index 000000000000..7487effceeab
>> --- /dev/null
>> +++ b/drivers/clk/clk-loongson2.c
>> @@ -0,0 +1,286 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
>> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/clkdev.h>
> Drop include that isn't used.
okay, I got it.
>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <dt-bindings/clock/loongson,ls2k-clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk.h>
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
>> +
>> +static void __iomem *loongson2_pll_base;
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
>> +       hw = kzalloc(sizeof(*hw), GFP_KERNEL);
>> +       if (!hw)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init.name = name;
>> +       init.ops = ops;
>> +       init.flags = flags;
>> +       init.parent_names = (parent_name ? &parent_name : NULL);
>> +       init.num_parents = (parent_name ? 1 : 0);
>> +       hw->init = &init;
>> +
>> +       /* register the clock */
>> +       ret = clk_hw_register(dev, hw);
>> +       if (ret) {
>> +               kfree(hw);
>> +               hw = ERR_PTR(ret);
>> +       }
>> +
>> +       return hw;
>> +}
>> +
>> +static struct clk_hw *loongson2_clk_pll_register(const char *name,
>> +                               const char *parent, void __iomem *reg)
>> +{
>> +       u64 val;
>> +       u32 mult = 1, div = 1;
>> +
>> +       val = readq((void *)reg);
> Drop the cast.
I will remove the (void *).
>
>> +
>> +       mult = (val >> LOONGSON2_PLL_MULT_SHIFT) &
>> +                       clk_div_mask(LOONGSON2_PLL_MULT_WIDTH);
>> +       div = (val >> LOONGSON2_PLL_DIV_SHIFT) &
>> +                       clk_div_mask(LOONGSON2_PLL_DIV_WIDTH);
>> +
>> +       return clk_hw_register_fixed_factor(NULL, name, parent,
>> +                               CLK_SET_RATE_PARENT, mult, div);
>> +}
>> +
>> +static unsigned long loongson2_apb_recalc_rate(struct clk_hw *hw,
>> +                                         unsigned long parent_rate)
>> +{
>> +       u64 val;
>> +       u32 mult;
>> +       unsigned long rate;
>> +
>> +       val = readq((void *)(loongson2_pll_base + 0x50));
> Drop the cast.
I will remove the (void *).
>
>> +
>> +       mult = (val >> LOONGSON2_APB_FREQSCALE_SHIFT) &
>> +                       clk_div_mask(LOONGSON2_APB_FREQSCALE_WIDTH);
>> +
>> +       rate = parent_rate * (mult + 1);
>> +       do_div(rate, 8);
>> +
>> +       return rate;
>> +}
>> +
>> +static const struct clk_ops loongson2_apb_clk_ops = {
>> +       .recalc_rate = loongson2_apb_recalc_rate,
>> +};
>> +
>> +static unsigned long loongson2_usb_recalc_rate(struct clk_hw *hw,
>> +                                         unsigned long parent_rate)
>> +{
>> +       u64 val;
>> +       u32 mult;
>> +       unsigned long rate;
>> +
>> +       val = readq((void *)(loongson2_pll_base + 0x50));
> Drop the cast.
I will remove the (void *).
>
>> +
>> +       mult = (val >> LOONGSON2_USB_FREQSCALE_SHIFT) &
>> +                       clk_div_mask(LOONGSON2_USB_FREQSCALE_WIDTH);
>> +
>> +       rate = parent_rate * (mult + 1);
>> +       do_div(rate, 8);
> Why is do_div() being used?
no expecial reason, I only want to get a result that rate divide 8.
>
>> +
>> +       return rate;
>> +}
>> +
>> +static const struct clk_ops loongson2_usb_clk_ops = {
>> +       .recalc_rate = loongson2_usb_recalc_rate,
>> +};
>> +
>> +static unsigned long loongson2_sata_recalc_rate(struct clk_hw *hw,
>> +                                         unsigned long parent_rate)
>> +{
>> +       u64 val;
>> +       u32 mult;
>> +       unsigned long rate;
>> +
>> +       val = readq((void *)(loongson2_pll_base + 0x50));
> Drop the cast.
I will remove the (void *).
>
>> +
>> +       mult = (val >> LOONGSON2_SATA_FREQSCALE_SHIFT) &
>> +                       clk_div_mask(LOONGSON2_SATA_FREQSCALE_WIDTH);
>> +
>> +       rate = parent_rate * (mult + 1);
>> +       do_div(rate, 8);
>> +
>> +       return rate;
>> +}
>> +
>> +static const struct clk_ops loongson2_sata_clk_ops = {
>> +       .recalc_rate = loongson2_sata_recalc_rate,
>> +};
>> +
>> +static void loongson2_check_clk_hws(struct clk_hw *clks[], unsigned int count)
> Inline this function.
I will add it.
>
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < count; i++)
>> +               if (IS_ERR(clks[i]))
>> +                       pr_err("Loongson2 clk %u: register failed with %ld\n"
>> +                               , i, PTR_ERR(clks[i]));
> Put the comma on the line above please.
okay, I got it.
>
>> +}
>> +
>> +static struct clk_hw *loongson2_obtain_fixed_clk_hw(
>> +                                       struct device_node *np,
>> +                                       const char *name)
>> +{
>> +       struct clk *clk;
>> +
>> +       clk = of_clk_get_by_name(np, name);
>> +       if (IS_ERR(clk))
>> +               return ERR_PTR(-ENOENT);
>> +
>> +       return __clk_get_hw(clk);
> Please don't implement this whole function. Instead, use clk_parent_data
> and the 'fw_name' or 'index' members to assign clk parents.

at present,  the child clk doesn't depend on the clk_parent_data,   eg.

hws[LOONGSON2_NODE_PLL] = loongson2_clk_pll_register("node_pll", 
"ref_100m", loongson2_pll_base);

static struct clk_hw *loongson2_clk_pll_register(const char *name,
                                 const char *parent, void __iomem *reg)
{
         u64 val;
         u32 mult = 1, div = 1;

         val = readq((void *)reg);

         mult = (val >> LOONGSON2_PLL_MULT_SHIFT) &
                         clk_div_mask(LOONGSON2_PLL_MULT_WIDTH);
         div = (val >> LOONGSON2_PLL_DIV_SHIFT) &
                         clk_div_mask(LOONGSON2_PLL_DIV_WIDTH);

         return clk_hw_register_fixed_factor(NULL, name, parent,
                                 CLK_SET_RATE_PARENT, mult, div);
}

you meaning is to use clk_parent_data to rework 
loongson2_clk_pll_register  and drop

loongson2_obtain_fixed_clk_hw ?

>
>> +}
>> +
>> +static void __init loongson2_clocks_init(struct device_node *np)
>> +{
>> +       struct clk_hw **hws;
>> +       struct clk_hw_onecell_data *clk_hw_data;
>> +       spinlock_t loongson2_clk_lock;
>> +
>> +       loongson2_pll_base = of_iomap(np, 0);
>> +
>> +       if (!loongson2_pll_base) {
>> +               pr_err("clk: unable to map loongson2 clk registers\n");
>> +               goto err;
> return?
sorry, I don't get it.  you meaning is that  remove "goto err". Instead, 
add a "return".
>
>> +       }
>> +
>> +       clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, LOONGSON2_CLK_END),
>> +                                       GFP_KERNEL);
>> +       if (WARN_ON(!clk_hw_data))
>> +               goto err;
>> +
>> +       clk_hw_data->num = LOONGSON2_CLK_END;
>> +       hws = clk_hw_data->hws;
>> +
>> +       hws[LOONGSON2_REF_100M] = loongson2_obtain_fixed_clk_hw(np,
>> +                                               "ref_100m");
>> +
>> +       hws[LOONGSON2_NODE_PLL] = loongson2_clk_pll_register("node_pll",
>> +                                               "ref_100m",
>> +                                               loongson2_pll_base);
>> +
>> +       hws[LOONGSON2_DDR_PLL] = loongson2_clk_pll_register("ddr_pll",
>> +                                               "ref_100m",
>> +                                               loongson2_pll_base + 0x10);
>> +
>> +       hws[LOONGSON2_DC_PLL] = loongson2_clk_pll_register("dc_pll",
>> +                                               "ref_100m",
>> +                                               loongson2_pll_base + 0x20);
>> +
>> +       hws[LOONGSON2_PIX0_PLL] = loongson2_clk_pll_register("pix0_pll",
>> +                                               "ref_100m",
>> +                                               loongson2_pll_base + 0x30);
>> +
>> +       hws[LOONGSON2_PIX1_PLL] = loongson2_clk_pll_register("pix1_pll",
>> +                                               "ref_100m",
>> +                                               loongson2_pll_base + 0x40);
>> +
>> +       hws[LOONGSON2_NODE_CLK] = clk_hw_register_divider(NULL, "node",
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
>> +       hws[LOONGSON2_APB_CLK] = loongson2_clk_register(NULL, "apb",
>> +                                               "gmac",
>> +                                               &loongson2_apb_clk_ops, 0);
>> +
>> +       hws[LOONGSON2_USB_CLK] = loongson2_clk_register(NULL, "usb",
>> +                                               "gmac",
>> +                                               &loongson2_usb_clk_ops, 0);
>> +
>> +       hws[LOONGSON2_SATA_CLK] = loongson2_clk_register(NULL, "sata",
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
>> +       of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
>> +
>> +err:
>> +       iounmap(loongson2_pll_base);
>> +}
>> +
>> +CLK_OF_DECLARE(loongson2_clk, "loongson,ls2k-clk", loongson2_clocks_init);
> Any reason this can't be a platform driver?

For the compatible consideration of other clock controllers of 
Loongson-2 series in the future, the way of using dts can be

better compatible.

