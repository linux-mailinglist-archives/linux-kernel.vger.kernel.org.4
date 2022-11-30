Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9E63CDD6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiK3Dc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK3Dcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:32:53 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6419627B38;
        Tue, 29 Nov 2022 19:32:50 -0800 (PST)
Received: from loongson.cn (unknown [112.94.31.56])
        by gateway (Coremail) with SMTP id _____8Dx_+vgzoZj2kACAA--.5203S3;
        Wed, 30 Nov 2022 11:32:48 +0800 (CST)
Received: from [127.0.0.1] (unknown [112.94.31.56])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxNlfezoZjVjQiAA--.1228S3;
        Wed, 30 Nov 2022 11:32:47 +0800 (CST)
Message-ID: <f0399e7d-d9be-d72f-2693-fb07984a4be6@loongson.cn>
Date:   Wed, 30 Nov 2022 11:32:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v10 2/4] clk: clk-loongson2: add clock controller driver
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20221129034157.15036-1-zhuyinbo@loongson.cn>
 <20221129034157.15036-2-zhuyinbo@loongson.cn>
From:   XiaochuanMao <maoxiaochuan@loongson.cn>
In-Reply-To: <20221129034157.15036-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxNlfezoZjVjQiAA--.1228S3
X-CM-SenderInfo: xpdr5xxdrfx3ldqnw6o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjvAXoWfJw1UGFykAr4rWF1xZw1kZrb_yoW8Jr48Wo
        W3uFn3Zr4fJ348Jay0qr15tr42qFnI9rsrAFyxZrs8JFWSkr98JrW8Gr43CF4xAFyrKFnx
        Aa4S9ayrJF4IqrZ8n29KB7ZKAUJUUUUt529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2
        IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUShiSDUUUU
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, yinbo

On 2022/11/29 11:41, Yinbo Zhu wrote:
> This driver provides support for clock controller on Loongson-2 SoC,
> the Loongson-2 SoC uses a 100MHz clock as the PLL reference clock,
> there are five independent PLLs inside, each of which PLL can
> provide up to three sets of frequency dependent clock outputs.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v10:
> 		1. Detach of_clk_init to another patch.
> Change in v9:
> 		1. Add all history changelog information.
> Change in v8:
> 		1. Remove the flag "CLK_IS_BASIC".
> Change in v7:
> 		1. Adjust position alphabetically in Kconfig and Makefile.
> 		2. Add static for loongson2_pll_base.
> 		3. Move other file-scope variables in probe.
> Change in v6:
> 		1. NO change, but other patch in this series of patches has
> 		   changes.
> Change in v5:
> 		1. Replace loongson2 with Loongson-2 in commit info.
> 		2. Replace Loongson2 with Loongson-2 in binding and
> 		   Kconfig file.
> 		3. Replace soc with SoC.
> Change in v4:
> 		1. Fixup clock-names that replace "xxx-clk" with "xxx".
> Change in v3:
> 		1. NO change, but other patch in this series of patches has
> 		   changes.
> Change in v2:
> 		1. Update the include filename.
> 		2. Change string from refclk/REFCLK to ref/REF.
>
>   MAINTAINERS                 |   1 +
>   arch/loongarch/Kconfig      |   1 +
>   drivers/clk/Kconfig         |   9 ++
>   drivers/clk/Makefile        |   1 +
>   drivers/clk/clk-loongson2.c | 286 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 298 insertions(+)
>   create mode 100644 drivers/clk/clk-loongson2.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ab94893fe2f6..73fa56f1fd5d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12025,6 +12025,7 @@ LOONGSON-2 SOC SERIES CLOCK DRIVER
>   M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>   L:	linux-clk@vger.kernel.org
>   S:	Maintained
> +F:	drivers/clk/clk-loongson2.c
>   F:	include/dt-bindings/clock/loongson,ls2k-clk.h
>   
>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 903096bd87f8..4f8f1b8f796d 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -127,6 +127,7 @@ config LOONGARCH
>   	select USE_PERCPU_NUMA_NODE_ID
>   	select USER_STACKTRACE_SUPPORT
>   	select ZONE_DMA32
> +	select COMMON_CLK
>   
>   config 32BIT
>   	bool
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index d79905f3e174..d13626f63739 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -326,6 +326,15 @@ config COMMON_CLK_LOCHNAGAR
>   	  This driver supports the clocking features of the Cirrus Logic
>   	  Lochnagar audio development board.
>   
> +config COMMON_CLK_LOONGSON2
> +	bool "Clock driver for Loongson-2 SoC"
> +	depends on COMMON_CLK && OF
> +	help
> +	  This driver provides support for Clock Controller that base on
> +	  Common Clock Framework Controller (CCF) on Loongson-2 SoC. The
> +	  Clock Controller can generates and supplies clock to various
> +	  peripherals within the SoC.
> +
>   config COMMON_CLK_NXP
>   	def_bool COMMON_CLK && (ARCH_LPC18XX || ARCH_LPC32XX)
>   	select REGMAP_MMIO if ARCH_LPC32XX
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e3ca0d058a25..b298c5dabc1a 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_COMMON_CLK_K210)		+= clk-k210.o
>   obj-$(CONFIG_LMK04832)			+= clk-lmk04832.o
>   obj-$(CONFIG_COMMON_CLK_LAN966X)	+= clk-lan966x.o
>   obj-$(CONFIG_COMMON_CLK_LOCHNAGAR)	+= clk-lochnagar.o
> +obj-$(CONFIG_COMMON_CLK_LOONGSON2)	+= clk-loongson2.o
>   obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
>   obj-$(CONFIG_COMMON_CLK_MAX9485)	+= clk-max9485.o
>   obj-$(CONFIG_ARCH_MILBEAUT_M10V)	+= clk-milbeaut.o
> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
> new file mode 100644
> index 000000000000..7487effceeab
> --- /dev/null
> +++ b/drivers/clk/clk-loongson2.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/clkdev.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <dt-bindings/clock/loongson,ls2k-clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +
> +#define LOONGSON2_PLL_MULT_SHIFT		32
> +#define LOONGSON2_PLL_MULT_WIDTH		10
> +#define LOONGSON2_PLL_DIV_SHIFT			26
> +#define LOONGSON2_PLL_DIV_WIDTH			6
> +#define LOONGSON2_APB_FREQSCALE_SHIFT		20
> +#define LOONGSON2_APB_FREQSCALE_WIDTH		3
> +#define LOONGSON2_USB_FREQSCALE_SHIFT		16
> +#define LOONGSON2_USB_FREQSCALE_WIDTH		3
> +#define LOONGSON2_SATA_FREQSCALE_SHIFT		12
> +#define LOONGSON2_SATA_FREQSCALE_WIDTH		3
> +
> +static void __iomem *loongson2_pll_base;
> +
> +static struct clk_hw *loongson2_clk_register(struct device *dev,
> +					  const char *name,
> +					  const char *parent_name,
> +					  const struct clk_ops *ops,
> +					  unsigned long flags)
> +{
> +	int ret;
> +	struct clk_hw *hw;
> +	struct clk_init_data init;
> +
> +	/* allocate the divider */
> +	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
> +	if (!hw)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = ops;
> +	init.flags = flags;
> +	init.parent_names = (parent_name ? &parent_name : NULL);
> +	init.num_parents = (parent_name ? 1 : 0);
> +	hw->init = &init;
> +
> +	/* register the clock */
> +	ret = clk_hw_register(dev, hw);
> +	if (ret) {
> +		kfree(hw);
> +		hw = ERR_PTR(ret);
> +	}
> +
> +	return hw;
> +}
> +
> +static struct clk_hw *loongson2_clk_pll_register(const char *name,
> +				const char *parent, void __iomem *reg)
> +{
> +	u64 val;
> +	u32 mult = 1, div = 1;
> +
> +	val = readq((void *)reg);
> +
> +	mult = (val >> LOONGSON2_PLL_MULT_SHIFT) &
> +			clk_div_mask(LOONGSON2_PLL_MULT_WIDTH);
> +	div = (val >> LOONGSON2_PLL_DIV_SHIFT) &
> +			clk_div_mask(LOONGSON2_PLL_DIV_WIDTH);
> +
> +	return clk_hw_register_fixed_factor(NULL, name, parent,
> +				CLK_SET_RATE_PARENT, mult, div);
> +}
> +
> +static unsigned long loongson2_apb_recalc_rate(struct clk_hw *hw,
> +					  unsigned long parent_rate)
> +{
> +	u64 val;
> +	u32 mult;
> +	unsigned long rate;
> +
> +	val = readq((void *)(loongson2_pll_base + 0x50));
> +
> +	mult = (val >> LOONGSON2_APB_FREQSCALE_SHIFT) &
> +			clk_div_mask(LOONGSON2_APB_FREQSCALE_WIDTH);
> +
> +	rate = parent_rate * (mult + 1);
> +	do_div(rate, 8);
> +
> +	return rate;
> +}
> +
> +static const struct clk_ops loongson2_apb_clk_ops = {
> +	.recalc_rate = loongson2_apb_recalc_rate,
> +};
> +
> +static unsigned long loongson2_usb_recalc_rate(struct clk_hw *hw,
> +					  unsigned long parent_rate)
> +{
> +	u64 val;
> +	u32 mult;
> +	unsigned long rate;
> +
> +	val = readq((void *)(loongson2_pll_base + 0x50));
> +
> +	mult = (val >> LOONGSON2_USB_FREQSCALE_SHIFT) &
> +			clk_div_mask(LOONGSON2_USB_FREQSCALE_WIDTH);
> +
> +	rate = parent_rate * (mult + 1);
> +	do_div(rate, 8);
> +
> +	return rate;
> +}
> +
> +static const struct clk_ops loongson2_usb_clk_ops = {
> +	.recalc_rate = loongson2_usb_recalc_rate,
> +};
> +
> +static unsigned long loongson2_sata_recalc_rate(struct clk_hw *hw,
> +					  unsigned long parent_rate)
> +{
> +	u64 val;
> +	u32 mult;
> +	unsigned long rate;
> +
> +	val = readq((void *)(loongson2_pll_base + 0x50));
it may be more common to use macro defintions instead of magic number. 
the clock configuration logic of  2k500 is  same as 2k1000, only the 
base  and offset are different。
> +
> +	mult = (val >> LOONGSON2_SATA_FREQSCALE_SHIFT) &
> +			clk_div_mask(LOONGSON2_SATA_FREQSCALE_WIDTH);
> +
> +	rate = parent_rate * (mult + 1);
> +	do_div(rate, 8);
> +
> +	return rate;
> +}
> +
> +static const struct clk_ops loongson2_sata_clk_ops = {
> +	.recalc_rate = loongson2_sata_recalc_rate,
> +};
> +
> +static void loongson2_check_clk_hws(struct clk_hw *clks[], unsigned int count)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < count; i++)
> +		if (IS_ERR(clks[i]))
> +			pr_err("Loongson2 clk %u: register failed with %ld\n"
> +				, i, PTR_ERR(clks[i]));
> +}
> +
> +static struct clk_hw *loongson2_obtain_fixed_clk_hw(
> +					struct device_node *np,
> +					const char *name)
> +{
> +	struct clk *clk;
> +
> +	clk = of_clk_get_by_name(np, name);
> +	if (IS_ERR(clk))
> +		return ERR_PTR(-ENOENT);
> +
> +	return __clk_get_hw(clk);
> +}
> +
> +static void __init loongson2_clocks_init(struct device_node *np)
> +{
> +	struct clk_hw **hws;
> +	struct clk_hw_onecell_data *clk_hw_data;
> +	spinlock_t loongson2_clk_lock;
> +
> +	loongson2_pll_base = of_iomap(np, 0);
> +
> +	if (!loongson2_pll_base) {
> +		pr_err("clk: unable to map loongson2 clk registers\n");
> +		goto err;
> +	}
> +
> +	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, LOONGSON2_CLK_END),
> +					GFP_KERNEL);
> +	if (WARN_ON(!clk_hw_data))
> +		goto err;
> +
> +	clk_hw_data->num = LOONGSON2_CLK_END;
> +	hws = clk_hw_data->hws;
> +
> +	hws[LOONGSON2_REF_100M] = loongson2_obtain_fixed_clk_hw(np,
> +						"ref_100m");
> +
> +	hws[LOONGSON2_NODE_PLL] = loongson2_clk_pll_register("node_pll",
> +						"ref_100m",
> +						loongson2_pll_base);
> +
> +	hws[LOONGSON2_DDR_PLL] = loongson2_clk_pll_register("ddr_pll",
> +						"ref_100m",
> +						loongson2_pll_base + 0x10);
> +
> +	hws[LOONGSON2_DC_PLL] = loongson2_clk_pll_register("dc_pll",
> +						"ref_100m",
> +						loongson2_pll_base + 0x20);
> +
> +	hws[LOONGSON2_PIX0_PLL] = loongson2_clk_pll_register("pix0_pll",
> +						"ref_100m",
> +						loongson2_pll_base + 0x30);
> +
> +	hws[LOONGSON2_PIX1_PLL] = loongson2_clk_pll_register("pix1_pll",
> +						"ref_100m",
> +						loongson2_pll_base + 0x40);
> +
> +	hws[LOONGSON2_NODE_CLK] = clk_hw_register_divider(NULL, "node",
> +						"node_pll", 0,
> +						loongson2_pll_base + 0x8, 0,
> +						6, CLK_DIVIDER_ONE_BASED,
> +						&loongson2_clk_lock);
> +
> +	/*
> +	 * The hda clk divisor in the upper 32bits and the clk-prodiver
> +	 * layer code doesn't support 64bit io operation thus a conversion
> +	 * is required that subtract shift by 32 and add 4byte to the hda
> +	 * address
> +	 */
> +	hws[LOONGSON2_HDA_CLK] = clk_hw_register_divider(NULL, "hda",
> +						"ddr_pll", 0,
> +						loongson2_pll_base + 0x22, 12,
> +						7, CLK_DIVIDER_ONE_BASED,
> +						&loongson2_clk_lock);
> +
> +	hws[LOONGSON2_GPU_CLK] = clk_hw_register_divider(NULL, "gpu",
> +						"ddr_pll", 0,
> +						loongson2_pll_base + 0x18, 22,
> +						6, CLK_DIVIDER_ONE_BASED,
> +						&loongson2_clk_lock);
> +
> +	hws[LOONGSON2_DDR_CLK] = clk_hw_register_divider(NULL, "ddr",
> +						"ddr_pll", 0,
> +						loongson2_pll_base + 0x18, 0,
> +						6, CLK_DIVIDER_ONE_BASED,
> +						&loongson2_clk_lock);
> +
> +	hws[LOONGSON2_GMAC_CLK] = clk_hw_register_divider(NULL, "gmac",
> +						"dc_pll", 0,
> +						loongson2_pll_base + 0x28, 22,
> +						6, CLK_DIVIDER_ONE_BASED,
> +						&loongson2_clk_lock);
> +
> +	hws[LOONGSON2_DC_CLK] = clk_hw_register_divider(NULL, "dc",
> +						"dc_pll", 0,
> +						loongson2_pll_base + 0x28, 0,
> +						6, CLK_DIVIDER_ONE_BASED,
> +						&loongson2_clk_lock);
> +
> +	hws[LOONGSON2_APB_CLK] = loongson2_clk_register(NULL, "apb",
> +						"gmac",
> +						&loongson2_apb_clk_ops, 0);
> +
> +	hws[LOONGSON2_USB_CLK] = loongson2_clk_register(NULL, "usb",
> +						"gmac",
> +						&loongson2_usb_clk_ops, 0);
> +
> +	hws[LOONGSON2_SATA_CLK] = loongson2_clk_register(NULL, "sata",
> +						"gmac",
> +						&loongson2_sata_clk_ops, 0);
> +
> +	hws[LOONGSON2_PIX0_CLK] = clk_hw_register_divider(NULL, "pix0",
> +						"pix0_pll", 0,
> +						loongson2_pll_base + 0x38, 0, 6,
> +						CLK_DIVIDER_ONE_BASED,
> +						&loongson2_clk_lock);
> +
> +	hws[LOONGSON2_PIX1_CLK] = clk_hw_register_divider(NULL, "pix1",
> +						"pix1_pll", 0,
> +						loongson2_pll_base + 0x48, 0, 6,
> +						CLK_DIVIDER_ONE_BASED,
> +						&loongson2_clk_lock);
> +
above this,   it may be more common to use macro defintions instead of 
magic number. the clock configuration logic of 2k500 is same as 2k1000， 
only the base  and offset are different
> +	loongson2_check_clk_hws(hws, LOONGSON2_CLK_END);
> +
> +	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +
> +err:
> +	iounmap(loongson2_pll_base);
> +}
> +
> +CLK_OF_DECLARE(loongson2_clk, "loongson,ls2k-clk", loongson2_clocks_init);

