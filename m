Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20E570DE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjEWNy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjEWNyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:54:11 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB4133;
        Tue, 23 May 2023 06:54:06 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 387BC5FD67;
        Tue, 23 May 2023 16:54:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684850045;
        bh=DyJQ2Zx+sDj5CbE4dMe8X5DKPk55/KFK99bu8+GoP8k=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=FrmOKmZhINbL0xqddrT2nkUZaEltg1qLZBwGYvP0mGr6eqhnBJ9IeZR+gGh9JKqL/
         MfmlPNyLibD51B6X31zrkg3TKHCqt1ZsMP40nbn99C0u7JTzYFkr4G+D3+rg50Ox64
         UhKTABkQbFvV5RIh8JOdEVKK12DOCpDNJdh3/1tUzl9bzEefVNpPdj9ZMsehuwUifh
         a4EUDpD98XaN4E/At08j8bbJSqpq5m/qsipWE4lz1u8l7AUpIHvtk6JOkkAlpH9tew
         g9e2LgIW8FcCujoEY7iVSiS+rbg/kL4rDhQo30//SHQomfeeLOhmuX8wnIiDbm0tEs
         SBvdzFAzWiXTA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 23 May 2023 16:54:05 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v16 4/6] clk: meson: a1: add Amlogic A1 PLL clock controller driver
Date:   Tue, 23 May 2023 16:53:49 +0300
Message-ID: <20230523135351.19133-5-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230523135351.19133-1-ddrokosov@sberdevices.ru>
References: <20230523135351.19133-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/23 12:15:00 #21372692
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce PLL clock controller for Amlogic A1 SoC family.
The clock unit is an APB slave module that is designed for generating all
of the internal and system clocks.
The SoC uses an external 24MHz crystal; there are 4 internal PLLs:
SYS_PLL/HIFI_PLL/USB_PLL/(FIXPLL), these PLLs generate 27 clock sources.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/Kconfig  |  10 ++
 drivers/clk/meson/Makefile |   1 +
 drivers/clk/meson/a1-pll.c | 356 +++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/a1-pll.h |  47 +++++
 4 files changed, 414 insertions(+)
 create mode 100644 drivers/clk/meson/a1-pll.c
 create mode 100644 drivers/clk/meson/a1-pll.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index fc002c155bc3..693c4cf60f27 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -99,6 +99,16 @@ config COMMON_CLK_AXG_AUDIO
 	  Support for the audio clock controller on AmLogic A113D devices,
 	  aka axg, Say Y if you want audio subsystem to work.
 
+config COMMON_CLK_A1_PLL
+	tristate "Amlogic A1 SoC PLL controller support"
+	depends on ARM64
+	select COMMON_CLK_MESON_REGMAP
+	select COMMON_CLK_MESON_PLL
+	help
+	  Support for the PLL clock controller on Amlogic A113L based
+	  device, A1 SoC Family. Say Y if you want A1 PLL clock controller
+	  to work.
+
 config COMMON_CLK_G12A
 	tristate "G12 and SM1 SoC clock controllers support"
 	depends on ARM64
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 6eca2a406ee3..2f17f475a48f 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
 
 obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
+obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
 obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
 obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
new file mode 100644
index 000000000000..bd2f1d1ec6e4
--- /dev/null
+++ b/drivers/clk/meson/a1-pll.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Jian Hu <jian.hu@amlogic.com>
+ *
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include "a1-pll.h"
+#include "clk-regmap.h"
+
+static struct clk_regmap fixed_pll_dco = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = ANACTRL_FIXPLL_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = ANACTRL_FIXPLL_CTRL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.n = {
+			.reg_off = ANACTRL_FIXPLL_CTRL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = ANACTRL_FIXPLL_CTRL1,
+			.shift   = 0,
+			.width   = 19,
+		},
+		.l = {
+			.reg_off = ANACTRL_FIXPLL_STS,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = ANACTRL_FIXPLL_CTRL0,
+			.shift   = 29,
+			.width   = 1,
+		},
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fixed_pll_dco",
+		.ops = &meson_clk_pll_ro_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "fixpll_in",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap fixed_pll = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_FIXPLL_CTRL0,
+		.bit_idx = 20,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "fixed_pll",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&fixed_pll_dco.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static const struct pll_mult_range hifi_pll_mult_range = {
+	.min = 32,
+	.max = 64,
+};
+
+static const struct reg_sequence hifi_init_regs[] = {
+	{ .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x01800000 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00001100 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x100a1100 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x00302000 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x01f18000 },
+};
+
+static struct clk_regmap hifi_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.n = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL1,
+			.shift   = 0,
+			.width   = 19,
+		},
+		.l = {
+			.reg_off = ANACTRL_HIFIPLL_STS,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.current_en = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL0,
+			.shift   = 26,
+			.width   = 1,
+		},
+		.l_detect = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL2,
+			.shift   = 6,
+			.width   = 1,
+		},
+		.range = &hifi_pll_mult_range,
+		.init_regs = hifi_init_regs,
+		.init_count = ARRAY_SIZE(hifi_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hifi_pll",
+		.ops = &meson_clk_pll_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "hifipll_in",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor fclk_div2_div = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&fixed_pll.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap fclk_div2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_FIXPLL_CTRL0,
+		.bit_idx = 21,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&fclk_div2_div.hw
+		},
+		.num_parents = 1,
+		/*
+		 * This clock is used by DDR clock in BL2 firmware
+		 * and is required by the platform to operate correctly.
+		 * Until the following condition are met, we need this clock to
+		 * be marked as critical:
+		 * a) Mark the clock used by a firmware resource, if possible
+		 * b) CCF has a clock hand-off mechanism to make the sure the
+		 *    clock stays on until the proper driver comes along
+		 */
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_fixed_factor fclk_div3_div = {
+	.mult = 1,
+	.div = 3,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div3_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&fixed_pll.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap fclk_div3 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_FIXPLL_CTRL0,
+		.bit_idx = 22,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div3",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&fclk_div3_div.hw
+		},
+		.num_parents = 1,
+		/*
+		 * This clock is used by APB bus which is set in boot ROM code
+		 * and is required by the platform to operate correctly.
+		 */
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_fixed_factor fclk_div5_div = {
+	.mult = 1,
+	.div = 5,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div5_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&fixed_pll.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap fclk_div5 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_FIXPLL_CTRL0,
+		.bit_idx = 23,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div5",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&fclk_div5_div.hw
+		},
+		.num_parents = 1,
+		/*
+		 * This clock is used by AXI bus which setted in Romcode
+		 * and is required by the platform to operate correctly.
+		 */
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_fixed_factor fclk_div7_div = {
+	.mult = 1,
+	.div = 7,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div7_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&fixed_pll.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap fclk_div7 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_FIXPLL_CTRL0,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div7",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&fclk_div7_div.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+/* Array of all clocks registered by this provider */
+static struct clk_hw_onecell_data a1_pll_clks = {
+	.hws = {
+		[CLKID_FIXED_PLL_DCO]	= &fixed_pll_dco.hw,
+		[CLKID_FIXED_PLL]	= &fixed_pll.hw,
+		[CLKID_FCLK_DIV2_DIV]	= &fclk_div2_div.hw,
+		[CLKID_FCLK_DIV3_DIV]	= &fclk_div3_div.hw,
+		[CLKID_FCLK_DIV5_DIV]	= &fclk_div5_div.hw,
+		[CLKID_FCLK_DIV7_DIV]	= &fclk_div7_div.hw,
+		[CLKID_FCLK_DIV2]	= &fclk_div2.hw,
+		[CLKID_FCLK_DIV3]	= &fclk_div3.hw,
+		[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
+		[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
+		[CLKID_HIFI_PLL]	= &hifi_pll.hw,
+		[NR_PLL_CLKS]		= NULL,
+	},
+	.num = NR_PLL_CLKS,
+};
+
+static struct clk_regmap *const a1_pll_regmaps[] = {
+	&fixed_pll_dco,
+	&fixed_pll,
+	&fclk_div2,
+	&fclk_div3,
+	&fclk_div5,
+	&fclk_div7,
+	&hifi_pll,
+};
+
+static struct regmap_config a1_pll_regmap_cfg = {
+	.reg_bits   = 32,
+	.val_bits   = 32,
+	.reg_stride = 4,
+};
+
+static int meson_a1_pll_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	struct regmap *map;
+	int clkid, i, err;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "can't ioremap resource\n");
+
+	map = devm_regmap_init_mmio(dev, base, &a1_pll_regmap_cfg);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
+				     "can't init regmap mmio region\n");
+
+	/* Populate regmap for the regmap backed clocks */
+	for (i = 0; i < ARRAY_SIZE(a1_pll_regmaps); i++)
+		a1_pll_regmaps[i]->map = map;
+
+	/* Register clocks */
+	for (clkid = 0; clkid < a1_pll_clks.num; clkid++) {
+		err = devm_clk_hw_register(dev, a1_pll_clks.hws[clkid]);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "clock[%d] registration failed\n",
+					     clkid);
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   &a1_pll_clks);
+}
+
+static const struct of_device_id a1_pll_clkc_match_table[] = {
+	{ .compatible = "amlogic,a1-pll-clkc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, a1_pll_clkc_match_table);
+
+static struct platform_driver a1_pll_clkc_driver = {
+	.probe = meson_a1_pll_probe,
+	.driver = {
+		.name = "a1-pll-clkc",
+		.of_match_table = a1_pll_clkc_match_table,
+	},
+};
+
+module_platform_driver(a1_pll_clkc_driver);
+MODULE_AUTHOR("Jian Hu <jian.hu@amlogic.com>");
+MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
new file mode 100644
index 000000000000..29726651b056
--- /dev/null
+++ b/drivers/clk/meson/a1-pll.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Amlogic A1 PLL Clock Controller internals
+ *
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Jian Hu <jian.hu@amlogic.com>
+ *
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#ifndef __A1_PLL_H
+#define __A1_PLL_H
+
+#include "clk-pll.h"
+
+/* PLL register offset */
+#define ANACTRL_FIXPLL_CTRL0	0x0
+#define ANACTRL_FIXPLL_CTRL1	0x4
+#define ANACTRL_FIXPLL_STS	0x14
+#define ANACTRL_HIFIPLL_CTRL0	0xc0
+#define ANACTRL_HIFIPLL_CTRL1	0xc4
+#define ANACTRL_HIFIPLL_CTRL2	0xc8
+#define ANACTRL_HIFIPLL_CTRL3	0xcc
+#define ANACTRL_HIFIPLL_CTRL4	0xd0
+#define ANACTRL_HIFIPLL_STS	0xd4
+
+/* include the CLKIDs that have been made part of the DT binding */
+#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
+
+/*
+ * CLKID index values for internal clocks
+ *
+ * These indices are entirely contrived and do not map onto the hardware.
+ * It has now been decided to expose everything by default in the DT header:
+ * include/dt-bindings/clock/a1-pll-clkc.h. Only the clocks ids we don't want
+ * to expose, such as the internal muxes and dividers of composite clocks,
+ * will remain defined here.
+ */
+#define CLKID_FIXED_PLL_DCO	0
+#define CLKID_FCLK_DIV2_DIV	2
+#define CLKID_FCLK_DIV3_DIV	3
+#define CLKID_FCLK_DIV5_DIV	4
+#define CLKID_FCLK_DIV7_DIV	5
+#define NR_PLL_CLKS		11
+
+#endif /* __A1_PLL_H */
-- 
2.36.0

