Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6B85F0477
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiI3GDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiI3GDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:03:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED4C1A20C;
        Thu, 29 Sep 2022 23:03:30 -0700 (PDT)
X-QQ-mid: bizesmtp62t1664517799tij3bsc6
Received: from ubuntu.localdomain ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 14:03:17 +0800 (CST)
X-QQ-SSF: 01000000000000305000000A0000000
X-QQ-FEAT: LFB8ggNdtfegzutrEXPYDv00uQ8pocNn9ktPPbgopVIjFmZr5mHwBtGv88KAm
        YkBj/38u/8717JdCow+h+e/xagBU379mRuVsRTRFoo15YXVoPrgxtgnoBZQoMFKYqytYMZo
        UMnB536yha3K8gTlxOUzLHATtMtkYl88EAu6Xb9+VrGlbh/7/wgOZNXrJL7VukuVvf9KKMQ
        f9bqP251X7p9CdM9VyF8zr3d+oSN2KD14iNQamdW2KdenMPODVIek8qWQzjFe6Br5CFWj3T
        AluEpdhqIyLKM8WI47nbVUvlcXA1Ebw16kZEe/pQiOoRWvZwXYfSP9RdKy1iNp1HBvMzG1q
        4PNnvhUD8ODAERuejw+1KoLk2EInUIHPXHCmdK29sEf3hDRDN1C8yIU1YoaqnGbdf17eiyx
        WJg0V1GY+Ew=
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 21/30] clk: starfive: Add StarFive JH7110 always-on clock driver
Date:   Fri, 30 Sep 2022 14:03:16 +0800
Message-Id: <20220930060316.5232-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add driver for the StarFive JH7110 always-on clock controller.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   9 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh7110-aon.c    | 161 ++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-aon.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index c13096543a8b..42aad3b553cb 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -29,3 +29,12 @@ config CLK_STARFIVE_JH7110_SYS
 	help
 	  Say yes here to support the system clock controller on the
 	  StarFive JH7110 SoC.
+
+config CLK_STARFIVE_JH7110_AON
+	tristate "StarFive JH7110 always-on clock support"
+	depends on SOC_STARFIVE || COMPILE_TEST
+	select CLK_STARFIVE
+	default m if SOC_STARFIVE
+	help
+	  Say yes here to support the always-on clock controller on the
+	  StarFive JH7110 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 2bc126cc91f2..b54d11340704 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
 obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
 
 obj-$(CONFIG_CLK_STARFIVE_JH7110_SYS)	+= clk-starfive-jh7110-sys.o
+obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-aon.c b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
new file mode 100644
index 000000000000..4975e7ad67be
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH7110 Always-On Clock Driver
+ *
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/starfive-jh7110-aon.h>
+
+#include "clk-starfive.h"
+
+/* external clocks */
+#define JH7110_AONCLK_OSC		(JH7110_AONCLK_END + 0)
+#define JH7110_AONCLK_RTC		(JH7110_AONCLK_END + 1)
+#define JH7110_AONCLK_GMAC0_RMII_REFIN	(JH7110_AONCLK_END + 2)
+#define JH7110_AONCLK_GMAC0_RGMII_RXIN	(JH7110_AONCLK_END + 3)
+#define JH7110_AONCLK_STG_AXIAHB	(JH7110_AONCLK_END + 4)
+#define JH7110_AONCLK_APB_BUS_FUNC	(JH7110_AONCLK_END + 5)
+#define JH7110_AONCLK_GMAC0_GTXCLK	(JH7110_AONCLK_END + 6)
+
+static const struct starfive_clk_data jh7110_aonclk_data[] = {
+	/* source */
+	STARFIVE__DIV(JH7110_AONCLK_OSC_DIV4, "osc_div4", 4,
+		      JH7110_AONCLK_OSC),
+	STARFIVE__MUX(JH7110_AONCLK_APB_FUNC, "aon_apb_func", 2,
+		      JH7110_AONCLK_OSC_DIV4,
+		      JH7110_AONCLK_OSC),
+	/* gmac0 */
+	STARFIVE_GATE(JH7110_AONCLK_GMAC0_AHB, "gmac0_ahb", 0,
+		      JH7110_AONCLK_STG_AXIAHB),
+	STARFIVE_GATE(JH7110_AONCLK_GMAC0_AXI, "gmac0_axi", 0,
+		      JH7110_AONCLK_STG_AXIAHB),
+	STARFIVE__DIV(JH7110_AONCLK_GMAC0_RMII_RTX, "gmac0_rmii_rtx", 30,
+		      JH7110_AONCLK_GMAC0_RMII_REFIN),
+	STARFIVE_GMUX(JH7110_AONCLK_GMAC0_TX, "gmac0_tx", 0, 2,
+		      JH7110_AONCLK_GMAC0_GTXCLK,
+		      JH7110_AONCLK_GMAC0_RMII_RTX),
+	STARFIVE__INV(JH7110_AONCLK_GMAC0_TX_INV, "gmac0_tx_inv",
+		      JH7110_AONCLK_GMAC0_TX),
+	STARFIVE__MUX(JH7110_AONCLK_GMAC0_RX, "gmac0_rx", 2,
+		      JH7110_AONCLK_GMAC0_RGMII_RXIN,
+		      JH7110_AONCLK_GMAC0_RMII_RTX),
+	STARFIVE__INV(JH7110_AONCLK_GMAC0_RX_INV, "gmac0_rx_inv",
+		      JH7110_AONCLK_GMAC0_RX),
+	/* otpc */
+	STARFIVE_GATE(JH7110_AONCLK_OTPC_APB, "otpc_apb", CLK_IGNORE_UNUSED,
+		      JH7110_AONCLK_APB_BUS_FUNC),
+	/* rtc */
+	STARFIVE_GATE(JH7110_AONCLK_RTC_APB, "rtc_apb", CLK_IGNORE_UNUSED,
+		      JH7110_AONCLK_APB_BUS_FUNC),
+	STARFIVE__DIV(JH7110_AONCLK_RTC_INTERNAL, "rtc_internal", 1022,
+		      JH7110_AONCLK_OSC),
+	STARFIVE__MUX(JH7110_AONCLK_RTC_32K, "rtc_32k", 2,
+		      JH7110_AONCLK_RTC,
+		      JH7110_AONCLK_RTC_INTERNAL),
+	STARFIVE_GATE(JH7110_AONCLK_RTC_CAL, "rtc_cal", 0,
+		      JH7110_AONCLK_OSC),
+};
+
+static struct clk_hw *jh7110_aonclk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct starfive_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < JH7110_AONCLK_END)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh7110_aoncrg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH7110_AONCLK_END),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	priv->regmap = syscon_node_to_regmap(priv->dev->of_node->parent);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(priv->dev, "failed to get regmap (error %ld)\n",
+			PTR_ERR(priv->regmap));
+		return PTR_ERR(priv->regmap);
+	}
+
+	for (idx = 0; idx < JH7110_AONCLK_END; idx++) {
+		u32 max = jh7110_aonclk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh7110_aonclk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents = ((max & STARFIVE_CLK_MUX_MASK)
+					>> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jh7110_aonclk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh7110_aonclk_data[idx].parents[i];
+
+			if (pidx < JH7110_AONCLK_END)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JH7110_AONCLK_OSC)
+				parents[i].fw_name = "osc";
+			else if (pidx == JH7110_AONCLK_RTC)
+				parents[i].fw_name = "clk_rtc";
+			else if (pidx == JH7110_AONCLK_GMAC0_RMII_REFIN)
+				parents[i].fw_name = "gmac0_rmii_refin";
+			else if (pidx == JH7110_AONCLK_GMAC0_RGMII_RXIN)
+				parents[i].fw_name = "gmac0_rgmii_rxin";
+			else if (pidx == JH7110_AONCLK_STG_AXIAHB)
+				parents[i].fw_name = "stg_axiahb";
+			else if (pidx == JH7110_AONCLK_APB_BUS_FUNC)
+				parents[i].fw_name = "apb_bus_func";
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	return devm_of_clk_add_hw_provider(&pdev->dev, jh7110_aonclk_get, priv);
+}
+
+static const struct of_device_id jh7110_aoncrg_match[] = {
+	{ .compatible = "starfive,jh7110-clkgen-aon" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_aoncrg_match);
+
+static struct platform_driver jh7110_aoncrg_driver = {
+	.probe = jh7110_aoncrg_probe,
+	.driver = {
+		.name = "clk-starfive-jh7110-aon",
+		.of_match_table = jh7110_aoncrg_match,
+	},
+};
+module_platform_driver(jh7110_aoncrg_driver);
+
+MODULE_AUTHOR("Emil Renner Berthing");
+MODULE_DESCRIPTION("StarFive JH7110 always-on clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

