Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40062EB32
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbiKRBof convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Nov 2022 20:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbiKRBo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:44:27 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECDD73BAC;
        Thu, 17 Nov 2022 17:44:22 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1D2D324E1E1;
        Fri, 18 Nov 2022 09:06:38 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:06:38 +0800
Received: from ubuntu.localdomain (183.27.96.116) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 18 Nov
 2022 09:06:37 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/14] clk: starfive: Add StarFive JH7110 always-on clock driver
Date:   Fri, 18 Nov 2022 09:06:25 +0800
Message-ID: <20221118010627.70576-13-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118010627.70576-1-hal.feng@starfivetech.com>
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.116]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add driver for the StarFive JH7110 always-on clock controller
and register an auxiliary device for always-on reset controller
which is named as "reset-aon".

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  10 ++
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh7110-aon.c    | 165 ++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-aon.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 7a6ff6614c74..baa602d384b7 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -30,3 +30,13 @@ config CLK_STARFIVE_JH7110_SYS
 	help
 	  Say yes here to support the system clock controller on the
 	  StarFive JH7110 SoC.
+
+config CLK_STARFIVE_JH7110_AON
+	tristate "StarFive JH7110 always-on clock support"
+	depends on CLK_STARFIVE_JH7110_SYS
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_JH71X0
+	default CLK_STARFIVE_JH7110_SYS
+	help
+	  Say yes here to support the always-on clock controller on the
+	  StarFive JH7110 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 5ca4e887fb9c..f3df7d957b1e 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
 obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
 
 obj-$(CONFIG_CLK_STARFIVE_JH7110_SYS)	+= clk-starfive-jh7110-sys.o
+obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-aon.c b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
new file mode 100644
index 000000000000..643728f9904a
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH7110 Always-On Clock Driver
+ *
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/starfive-jh7110.h>
+
+#include "clk-starfive-jh71x0.h"
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
+static const struct jh71x0_clk_data jh7110_aonclk_data[] = {
+	/* source */
+	JH71X0__DIV(JH7110_AONCLK_OSC_DIV4, "osc_div4", 4,
+		    JH7110_AONCLK_OSC),
+	JH71X0__MUX(JH7110_AONCLK_APB_FUNC, "aon_apb_func", 2,
+		    JH7110_AONCLK_OSC_DIV4,
+		    JH7110_AONCLK_OSC),
+	/* gmac0 */
+	JH71X0_GATE(JH7110_AONCLK_GMAC0_AHB, "gmac0_ahb", 0,
+		    JH7110_AONCLK_STG_AXIAHB),
+	JH71X0_GATE(JH7110_AONCLK_GMAC0_AXI, "gmac0_axi", 0,
+		    JH7110_AONCLK_STG_AXIAHB),
+	JH71X0__DIV(JH7110_AONCLK_GMAC0_RMII_RTX, "gmac0_rmii_rtx", 30,
+		    JH7110_AONCLK_GMAC0_RMII_REFIN),
+	JH71X0_GMUX(JH7110_AONCLK_GMAC0_TX, "gmac0_tx", 0, 2,
+		    JH7110_AONCLK_GMAC0_GTXCLK,
+		    JH7110_AONCLK_GMAC0_RMII_RTX),
+	JH71X0__INV(JH7110_AONCLK_GMAC0_TX_INV, "gmac0_tx_inv",
+		    JH7110_AONCLK_GMAC0_TX),
+	JH71X0__MUX(JH7110_AONCLK_GMAC0_RX, "gmac0_rx", 2,
+		    JH7110_AONCLK_GMAC0_RGMII_RXIN,
+		    JH7110_AONCLK_GMAC0_RMII_RTX),
+	JH71X0__INV(JH7110_AONCLK_GMAC0_RX_INV, "gmac0_rx_inv",
+		    JH7110_AONCLK_GMAC0_RX),
+	/* otpc */
+	JH71X0_GATE(JH7110_AONCLK_OTPC_APB, "otpc_apb", CLK_IGNORE_UNUSED,
+		    JH7110_AONCLK_APB_BUS_FUNC),
+	/* rtc */
+	JH71X0_GATE(JH7110_AONCLK_RTC_APB, "rtc_apb", CLK_IGNORE_UNUSED,
+		    JH7110_AONCLK_APB_BUS_FUNC),
+	JH71X0__DIV(JH7110_AONCLK_RTC_INTERNAL, "rtc_internal", 1022,
+		    JH7110_AONCLK_OSC),
+	JH71X0__MUX(JH7110_AONCLK_RTC_32K, "rtc_32k", 2,
+		    JH7110_AONCLK_RTC,
+		    JH7110_AONCLK_RTC_INTERNAL),
+	JH71X0_GATE(JH7110_AONCLK_RTC_CAL, "rtc_cal", 0,
+		    JH7110_AONCLK_OSC),
+};
+
+static struct clk_hw *jh7110_aonclk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct jh71x0_clk_priv *priv = data;
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
+	struct jh71x0_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH7110_AONCLK_END),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	dev_set_drvdata(priv->dev, priv->base);
+
+	for (idx = 0; idx < JH7110_AONCLK_END; idx++) {
+		u32 max = jh7110_aonclk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh7110_aonclk_data[idx].name,
+			.ops = starfive_jh71x0_clk_ops(max),
+			.parent_data = parents,
+			.num_parents = ((max & JH71X0_CLK_MUX_MASK)
+					>> JH71X0_CLK_MUX_SHIFT) + 1,
+			.flags = jh7110_aonclk_data[idx].flags,
+		};
+		struct jh71x0_clk *clk = &priv->reg[idx];
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
+			else if (pidx == JH7110_AONCLK_GMAC0_GTXCLK)
+				parents[i].fw_name = "gmac0_gtxclk";
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & JH71X0_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_aonclk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh7110_reset_controller_register(priv, "reset-aon", 1);
+}
+
+static const struct of_device_id jh7110_aoncrg_match[] = {
+	{ .compatible = "starfive,jh7110-aoncrg" },
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
2.38.1

