Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50F06C3247
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjCUNHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCUNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:07:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F390719F28;
        Tue, 21 Mar 2023 06:07:16 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxfdoDrBlkGmwPAA--.11500S3;
        Tue, 21 Mar 2023 21:07:15 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxMuX_qxlke6AIAA--.36902S3;
        Tue, 21 Mar 2023 21:07:14 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v15 2/2] clk: clk-loongson2: add clock controller driver support
Date:   Tue, 21 Mar 2023 21:07:10 +0800
Message-Id: <20230321130710.20236-2-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230321130710.20236-1-zhuyinbo@loongson.cn>
References: <20230321130710.20236-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxMuX_qxlke6AIAA--.36902S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoW3ZFW7CrW7Cr43ZF1DZFyDGFg_yoW8Gw4fGo
        WfuFnxJr4fJ348XFWIvw15tr47XFsxZFsxA3WfArn8GayY9r98XrW8A3W3GFn7ZFyrKFnx
        AryrKayrJF4Iqrsrn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UU9E1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFV
        AK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0ow
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq
        07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
        vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
        14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4U
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
        4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU8AuctUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver provides support for clock controller on Loongson-2 SoC,
the Loongson-2 SoC uses a 100MHz clock as the PLL reference clock,
there are five independent PLLs inside, each of which PLL can
provide up to three sets of frequency dependent clock outputs.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v15:
		1. Remove the depends on COMMON_CLK  && OF and add depend on
		   LOONGARCH || COMPILE_TEST.
		2. Remove some head file that include "linux/of.h", "linux/of_address.h"
		   and "linux/clk.h".
		3. Remove the initialization of .name in struct clk_parent_data.
		4. Replace device node with struct device.
		5. Replace of_clk_hw_register with devm_clk_hw_register.
		6. Remove the initialized operaion in loongson2_calc_pll_rate.
		7. Inline the function about loongson2_clocks_init.
		8. Replace of_iomap with devm_platform_ioremap_resource.
		9. Drop error messages when mapping.
		10. Replace kzalloc with devm_kzalloc.
Change in v14:
		1. For some board's config file doesn't enable CONFIG_64BIT and
		   will report readq undefine error, and this version was to
		   add include <linux/io-64-nonatomic-lo-hi.h> to fix this issue.
Change in v13:
		1. Add the Loongson-2 boot clk support.
Change in v12:
		1. Change driver register way that use platform driver register.
Change in v11:
		1. Remove the repetitive COMMON_CLK config in loongarch Kconfig.
		2. Fixup the help paragraph descprition in COMMON_CLK_LOONGSON2.
		3. Drop the <linux/clkdev.h>.
		4. Drop the cast in clock driver.
		5. Use div_u64() replace do_div().
		6. Inline this function for loongson2_check_clk_hws.
		7. Fixup the comma deposition on the loongson2_check_clk_hws.
		8. Drop the loongson2_obtain_fixed_clk_hw and rework this driver
		   use clk_parent_data and the 'fw_name'.
Change in v10:
		1. Detach of_clk_init to another patch. 
Change in v9:
		1. Add all history changelog information.
Change in v8:
		1. Remove the flag "CLK_IS_BASIC".
Change in v7:
		1. Adjust position alphabetically in Kconfig and Makefile.
		2. Add static for loongson2_pll_base.
		3. Move other file-scope variables in probe.
Change in v6:
		1. NO change, but other patch in this series of patches has
		   changes.
Change in v5:
		1. Replace loongson2 with Loongson-2 in commit info.
		2. Replace Loongson2 with Loongson-2 in binding and
		   Kconfig file.
		3. Replace soc with SoC.
Change in v4:
		1. Fixup clock-names that replace "xxx-clk" with "xxx".
Change in v3:
		1. NO change, but other patch in this series of patches has
		   changes.
Change in v2:
		1. Update the include filename.
		2. Change string from refclk/REFCLK to ref/REF.

 MAINTAINERS                 |   1 +
 drivers/clk/Kconfig         |   9 +
 drivers/clk/Makefile        |   1 +
 drivers/clk/clk-loongson2.c | 344 ++++++++++++++++++++++++++++++++++++
 4 files changed, 355 insertions(+)
 create mode 100644 drivers/clk/clk-loongson2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 25a0981c74b6..a6983bf85956 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12155,6 +12155,7 @@ M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-clk@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/loongson,ls2k-clk.yaml
+F:	drivers/clk/clk-loongson2.c
 F:	include/dt-bindings/clock/loongson,ls2k-clk.h
 
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 1eef05bb1f99..6da372fcc56a 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -325,6 +325,15 @@ config COMMON_CLK_LOCHNAGAR
 	  This driver supports the clocking features of the Cirrus Logic
 	  Lochnagar audio development board.
 
+config COMMON_CLK_LOONGSON2
+	bool "Clock driver for Loongson-2 SoC"
+	depends on LOONGARCH || COMPILE_TEST
+	help
+          This driver provides support for clock controller on Loongson-2 SoC.
+          The clock controller can generates and supplies clock to various
+          peripherals within the SoC.
+          Say Y here to support Loongson-2 SoC clock driver.
+
 config COMMON_CLK_NXP
 	def_bool COMMON_CLK && (ARCH_LPC18XX || ARCH_LPC32XX)
 	select REGMAP_MMIO if ARCH_LPC32XX
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e3ca0d058a25..b298c5dabc1a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_COMMON_CLK_K210)		+= clk-k210.o
 obj-$(CONFIG_LMK04832)			+= clk-lmk04832.o
 obj-$(CONFIG_COMMON_CLK_LAN966X)	+= clk-lan966x.o
 obj-$(CONFIG_COMMON_CLK_LOCHNAGAR)	+= clk-lochnagar.o
+obj-$(CONFIG_COMMON_CLK_LOONGSON2)	+= clk-loongson2.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 obj-$(CONFIG_COMMON_CLK_MAX9485)	+= clk-max9485.o
 obj-$(CONFIG_ARCH_MILBEAUT_M10V)	+= clk-milbeaut.o
diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
new file mode 100644
index 000000000000..090810655511
--- /dev/null
+++ b/drivers/clk/clk-loongson2.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
+ * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <dt-bindings/clock/loongson,ls2k-clk.h>
+
+#define LOONGSON2_PLL_MULT_SHIFT		32
+#define LOONGSON2_PLL_MULT_WIDTH		10
+#define LOONGSON2_PLL_DIV_SHIFT			26
+#define LOONGSON2_PLL_DIV_WIDTH			6
+#define LOONGSON2_APB_FREQSCALE_SHIFT		20
+#define LOONGSON2_APB_FREQSCALE_WIDTH		3
+#define LOONGSON2_USB_FREQSCALE_SHIFT		16
+#define LOONGSON2_USB_FREQSCALE_WIDTH		3
+#define LOONGSON2_SATA_FREQSCALE_SHIFT		12
+#define LOONGSON2_SATA_FREQSCALE_WIDTH		3
+#define LOONGSON2_BOOT_FREQSCALE_SHIFT		8
+#define LOONGSON2_BOOT_FREQSCALE_WIDTH		3
+
+static void __iomem *loongson2_pll_base;
+
+static const struct clk_parent_data pdata[] = {
+	{ .fw_name = "ref_100m",},
+};
+
+static struct clk_hw *loongson2_clk_register(struct device *dev,
+					  const char *name,
+					  const char *parent_name,
+					  const struct clk_ops *ops,
+					  unsigned long flags)
+{
+	int ret;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+
+	/* allocate the divider */
+	hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = ops;
+	init.flags = flags;
+	init.num_parents = 1;
+
+	if (!parent_name)
+		init.parent_data = pdata;
+	else
+		init.parent_names = &parent_name;
+
+	hw->init = &init;
+
+	/* register the clock */
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		hw = ERR_PTR(ret);
+
+	return hw;
+}
+
+static unsigned long loongson2_calc_pll_rate(int offset, unsigned long rate)
+{
+	u64 val;
+	u32 mult, div;
+
+	val = readq(loongson2_pll_base + offset);
+
+	mult = (val >> LOONGSON2_PLL_MULT_SHIFT) &
+			clk_div_mask(LOONGSON2_PLL_MULT_WIDTH);
+	div = (val >> LOONGSON2_PLL_DIV_SHIFT) &
+			clk_div_mask(LOONGSON2_PLL_DIV_WIDTH);
+
+	return div_u64((u64)rate * mult, div);
+}
+
+static unsigned long loongson2_node_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return loongson2_calc_pll_rate(0x0, parent_rate);
+}
+
+static const struct clk_ops loongson2_node_clk_ops = {
+	.recalc_rate = loongson2_node_recalc_rate,
+};
+
+static unsigned long loongson2_ddr_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return loongson2_calc_pll_rate(0x10, parent_rate);
+}
+
+static const struct clk_ops loongson2_ddr_clk_ops = {
+	.recalc_rate = loongson2_ddr_recalc_rate,
+};
+
+static unsigned long loongson2_dc_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return loongson2_calc_pll_rate(0x20, parent_rate);
+}
+
+static const struct clk_ops loongson2_dc_clk_ops = {
+	.recalc_rate = loongson2_dc_recalc_rate,
+};
+
+static unsigned long loongson2_pix0_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return loongson2_calc_pll_rate(0x30, parent_rate);
+}
+
+static const struct clk_ops loongson2_pix0_clk_ops = {
+	.recalc_rate = loongson2_pix0_recalc_rate,
+};
+
+static unsigned long loongson2_pix1_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return loongson2_calc_pll_rate(0x40, parent_rate);
+}
+
+static const struct clk_ops loongson2_pix1_clk_ops = {
+	.recalc_rate = loongson2_pix1_recalc_rate,
+};
+
+static unsigned long loongson2_calc_rate(unsigned long rate,
+					 int shift, int width)
+{
+	u64 val;
+	u32 mult;
+
+	val = readq(loongson2_pll_base + 0x50);
+
+	mult = (val >> shift) & clk_div_mask(width);
+
+	return div_u64((u64)rate * (mult + 1), 8);
+}
+
+static unsigned long loongson2_boot_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return loongson2_calc_rate(parent_rate,
+				   LOONGSON2_BOOT_FREQSCALE_SHIFT,
+				   LOONGSON2_BOOT_FREQSCALE_WIDTH);
+}
+
+static const struct clk_ops loongson2_boot_clk_ops = {
+	.recalc_rate = loongson2_boot_recalc_rate,
+};
+
+static unsigned long loongson2_apb_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return loongson2_calc_rate(parent_rate,
+				   LOONGSON2_APB_FREQSCALE_SHIFT,
+				   LOONGSON2_APB_FREQSCALE_WIDTH);
+}
+
+static const struct clk_ops loongson2_apb_clk_ops = {
+	.recalc_rate = loongson2_apb_recalc_rate,
+};
+
+static unsigned long loongson2_usb_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return loongson2_calc_rate(parent_rate,
+				   LOONGSON2_USB_FREQSCALE_SHIFT,
+				   LOONGSON2_USB_FREQSCALE_WIDTH);
+}
+
+static const struct clk_ops loongson2_usb_clk_ops = {
+	.recalc_rate = loongson2_usb_recalc_rate,
+};
+
+static unsigned long loongson2_sata_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return loongson2_calc_rate(parent_rate,
+				   LOONGSON2_SATA_FREQSCALE_SHIFT,
+				   LOONGSON2_SATA_FREQSCALE_WIDTH);
+}
+
+static const struct clk_ops loongson2_sata_clk_ops = {
+	.recalc_rate = loongson2_sata_recalc_rate,
+};
+
+static inline void loongson2_check_clk_hws(struct clk_hw *clks[], unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (IS_ERR(clks[i]))
+			pr_err("Loongson2 clk %u: register failed with %ld\n",
+				i, PTR_ERR(clks[i]));
+}
+
+static inline void loongson2_clocks_init(struct device *dev)
+{
+	struct clk_hw **hws;
+	struct clk_hw_onecell_data *clk_hw_data;
+	spinlock_t loongson2_clk_lock;
+
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, LOONGSON2_CLK_END),
+					GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
+		return;
+
+	clk_hw_data->num = LOONGSON2_CLK_END;
+	hws = clk_hw_data->hws;
+
+	hws[LOONGSON2_NODE_PLL] = loongson2_clk_register(dev, "node_pll",
+						NULL,
+						&loongson2_node_clk_ops, 0);
+
+	hws[LOONGSON2_DDR_PLL] = loongson2_clk_register(dev, "ddr_pll",
+						NULL,
+						&loongson2_ddr_clk_ops, 0);
+
+	hws[LOONGSON2_DC_PLL] = loongson2_clk_register(dev, "dc_pll",
+						NULL,
+						&loongson2_dc_clk_ops, 0);
+
+	hws[LOONGSON2_PIX0_PLL] = loongson2_clk_register(dev, "pix0_pll",
+						NULL,
+						&loongson2_pix0_clk_ops, 0);
+
+	hws[LOONGSON2_PIX1_PLL] = loongson2_clk_register(dev, "pix1_pll",
+						NULL,
+						&loongson2_pix1_clk_ops, 0);
+
+	hws[LOONGSON2_BOOT_CLK] = loongson2_clk_register(dev, "boot",
+						NULL,
+						&loongson2_boot_clk_ops, 0);
+
+	hws[LOONGSON2_NODE_CLK] = clk_hw_register_divider(NULL, "node",
+						"node_pll", 0,
+						loongson2_pll_base + 0x8, 0,
+						6, CLK_DIVIDER_ONE_BASED,
+						&loongson2_clk_lock);
+
+	/*
+	 * The hda clk divisor in the upper 32bits and the clk-prodiver
+	 * layer code doesn't support 64bit io operation thus a conversion
+	 * is required that subtract shift by 32 and add 4byte to the hda
+	 * address
+	 */
+	hws[LOONGSON2_HDA_CLK] = clk_hw_register_divider(NULL, "hda",
+						"ddr_pll", 0,
+						loongson2_pll_base + 0x22, 12,
+						7, CLK_DIVIDER_ONE_BASED,
+						&loongson2_clk_lock);
+
+	hws[LOONGSON2_GPU_CLK] = clk_hw_register_divider(NULL, "gpu",
+						"ddr_pll", 0,
+						loongson2_pll_base + 0x18, 22,
+						6, CLK_DIVIDER_ONE_BASED,
+						&loongson2_clk_lock);
+
+	hws[LOONGSON2_DDR_CLK] = clk_hw_register_divider(NULL, "ddr",
+						"ddr_pll", 0,
+						loongson2_pll_base + 0x18, 0,
+						6, CLK_DIVIDER_ONE_BASED,
+						&loongson2_clk_lock);
+
+	hws[LOONGSON2_GMAC_CLK] = clk_hw_register_divider(NULL, "gmac",
+						"dc_pll", 0,
+						loongson2_pll_base + 0x28, 22,
+						6, CLK_DIVIDER_ONE_BASED,
+						&loongson2_clk_lock);
+
+	hws[LOONGSON2_DC_CLK] = clk_hw_register_divider(NULL, "dc",
+						"dc_pll", 0,
+						loongson2_pll_base + 0x28, 0,
+						6, CLK_DIVIDER_ONE_BASED,
+						&loongson2_clk_lock);
+
+	hws[LOONGSON2_APB_CLK] = loongson2_clk_register(dev, "apb",
+						"gmac",
+						&loongson2_apb_clk_ops, 0);
+
+	hws[LOONGSON2_USB_CLK] = loongson2_clk_register(dev, "usb",
+						"gmac",
+						&loongson2_usb_clk_ops, 0);
+
+	hws[LOONGSON2_SATA_CLK] = loongson2_clk_register(dev, "sata",
+						"gmac",
+						&loongson2_sata_clk_ops, 0);
+
+	hws[LOONGSON2_PIX0_CLK] = clk_hw_register_divider(NULL, "pix0",
+						"pix0_pll", 0,
+						loongson2_pll_base + 0x38, 0, 6,
+						CLK_DIVIDER_ONE_BASED,
+						&loongson2_clk_lock);
+
+	hws[LOONGSON2_PIX1_CLK] = clk_hw_register_divider(NULL, "pix1",
+						"pix1_pll", 0,
+						loongson2_pll_base + 0x48, 0, 6,
+						CLK_DIVIDER_ONE_BASED,
+						&loongson2_clk_lock);
+
+	loongson2_check_clk_hws(hws, LOONGSON2_CLK_END);
+
+	devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
+}
+
+static const struct of_device_id loongson2_clk_match_table[] = {
+	{ .compatible = "loongson,ls2k-clk" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, loongson2_clk_match_table);
+
+static int loongson2_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	loongson2_pll_base = devm_platform_ioremap_resource(pdev, 0);
+	if (!loongson2_pll_base)
+		return PTR_ERR(loongson2_pll_base);
+
+	loongson2_clocks_init(dev);
+
+	return 0;
+}
+
+static struct platform_driver loongson2_clk_driver = {
+	.probe	= loongson2_clk_probe,
+	.driver	= {
+		.name	= "loongson2-clk",
+		.of_match_table	= loongson2_clk_match_table,
+	},
+};
+module_platform_driver(loongson2_clk_driver);
+
+MODULE_DESCRIPTION("Loongson2 clock driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1

