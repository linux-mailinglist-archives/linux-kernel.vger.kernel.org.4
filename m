Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66DF67498E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjATCpn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Jan 2023 21:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjATCo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:44:58 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC60A5004;
        Thu, 19 Jan 2023 18:44:55 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id CF4C124E114;
        Fri, 20 Jan 2023 10:44:53 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 20 Jan
 2023 10:44:53 +0800
Received: from localhost.localdomain (113.72.144.40) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 20 Jan
 2023 10:44:53 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
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
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v1 09/11] clk: starfive: Add StarFive JH7110 Video-Output clock driver
Date:   Fri, 20 Jan 2023 10:44:43 +0800
Message-ID: <20230120024445.244345-10-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120024445.244345-1-xingyu.wu@starfivetech.com>
References: <20230120024445.244345-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.40]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX161.cuchost.com
 (172.16.6.71)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the StarFive JH7110 Video-Output clock controller.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  11 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh7110-vout.c   | 227 ++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-vout.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 59499acb95f7..5ebf1ed08627 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -64,3 +64,14 @@ config CLK_STARFIVE_JH7110_ISP
 	help
 	  Say yes here to support the Image-Signal-Process clock controller
 	  on the StarFive JH7110 SoC.
+
+config CLK_STARFIVE_JH7110_VOUT
+	tristate "StarFive JH7110 Video-Output clock support"
+	depends on CLK_STARFIVE_JH7110_SYS && JH71XX_PMU
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_JH71X0
+	select RESET_STARFIVE_JH7110
+	default CLK_STARFIVE_JH7110_SYS
+	help
+	  Say yes here to support the Video-Output clock controller
+	  on the StarFive JH7110 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 76fb9f8d628b..841377e45bb6 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_SYS)	+= clk-starfive-jh7110-sys.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)	+= clk-starfive-jh7110-stg.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
+obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
new file mode 100644
index 000000000000..459e8d111bf8
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH7110 Video-Output Clock Driver
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#include <dt-bindings/clock/starfive,jh7110-crg.h>
+
+#include "clk-starfive-jh71x0.h"
+
+/* external clocks */
+#define JH7110_VOUTCLK_VOUT_SRC			(JH7110_VOUTCLK_END + 0)
+#define JH7110_VOUTCLK_VOUT_TOP_AHB		(JH7110_VOUTCLK_END + 1)
+#define JH7110_VOUTCLK_VOUT_TOP_AXI		(JH7110_VOUTCLK_END + 2)
+#define JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK	(JH7110_VOUTCLK_END + 3)
+#define JH7110_VOUTCLK_I2STX0_BCLK		(JH7110_VOUTCLK_END + 4)
+#define JH7110_VOUTCLK_HDMITX0_PIXELCLK		(JH7110_VOUTCLK_END + 5)
+
+static const struct jh71x0_clk_data jh7110_voutclk_data[] = {
+	/* divider */
+	JH71X0__DIV(JH7110_VOUTCLK_APB, "apb", 8, JH7110_VOUTCLK_VOUT_TOP_AHB),
+	JH71X0__DIV(JH7110_VOUTCLK_DC8200_PIX, "dc8200_pix", 63, JH7110_VOUTCLK_VOUT_SRC),
+	JH71X0__DIV(JH7110_VOUTCLK_DSI_SYS, "dsi_sys", 31, JH7110_VOUTCLK_VOUT_SRC),
+	JH71X0__DIV(JH7110_VOUTCLK_TX_ESC, "tx_esc", 31, JH7110_VOUTCLK_VOUT_TOP_AHB),
+	/* dc8200 */
+	JH71X0_GATE(JH7110_VOUTCLK_DC8200_AXI, "dc8200_axi", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
+	JH71X0_GATE(JH7110_VOUTCLK_DC8200_CORE, "dc8200_core", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
+	JH71X0_GATE(JH7110_VOUTCLK_DC8200_AHB, "dc8200_ahb", 0, JH7110_VOUTCLK_VOUT_TOP_AHB),
+	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX0, "dc8200_pix0", 0, 2,
+		    JH7110_VOUTCLK_DC8200_PIX,
+		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
+	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX1, "dc8200_pix1", 0, 2,
+		    JH7110_VOUTCLK_DC8200_PIX,
+		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
+	/* LCD */
+	JH71X0_GMUX(JH7110_VOUTCLK_DOM_VOUT_TOP_LCD, "dom_vout_top_lcd", 0, 2,
+		    JH7110_VOUTCLK_DC8200_PIX0,
+		    JH7110_VOUTCLK_DC8200_PIX1),
+	/* dsiTx */
+	JH71X0_GATE(JH7110_VOUTCLK_DSITX_APB, "dsiTx_apb", 0, JH7110_VOUTCLK_DSI_SYS),
+	JH71X0_GATE(JH7110_VOUTCLK_DSITX_SYS, "dsiTx_sys", 0, JH7110_VOUTCLK_DSI_SYS),
+	JH71X0_GMUX(JH7110_VOUTCLK_DSITX_DPI, "dsiTx_dpi", 0, 2,
+		    JH7110_VOUTCLK_DC8200_PIX,
+		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
+	JH71X0_GATE(JH7110_VOUTCLK_DSITX_TXESC, "dsiTx_txesc", 0, JH7110_VOUTCLK_TX_ESC),
+	/* mipitx DPHY */
+	JH71X0_GATE(JH7110_VOUTCLK_MIPITX_DPHY_TXESC, "mipitx_dphy_txesc", 0,
+		    JH7110_VOUTCLK_TX_ESC),
+	/* hdmi */
+	JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_MCLK, "hdmi_tx_mclk", 0,
+		    JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK),
+	JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_BCLK, "hdmi_tx_bclk", 0,
+		    JH7110_VOUTCLK_I2STX0_BCLK),
+	JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_SYS, "hdmi_tx_sys", 0, JH7110_VOUTCLK_APB),
+};
+
+struct vout_top_crg {
+	struct clk_bulk_data *top_clks;
+	struct reset_control *top_rst;
+	int top_clks_num;
+};
+
+static struct clk_bulk_data jh7110_vout_top_clks[] = {
+	{ .id = "vout_src" },
+	{ .id = "vout_top_ahb" }
+};
+
+static int jh7110_vout_top_crg_get(struct jh71x0_clk_priv *priv, struct vout_top_crg *top)
+{
+	int ret;
+
+	top->top_clks = jh7110_vout_top_clks;
+	top->top_clks_num = ARRAY_SIZE(jh7110_vout_top_clks);
+	ret = devm_clk_bulk_get(priv->dev, top->top_clks_num, top->top_clks);
+	if (ret) {
+		dev_err(priv->dev, "top clks get failed: %d\n", ret);
+		return ret;
+	}
+
+	/* The reset should be shared and other Vout modules will use its. */
+	top->top_rst = devm_reset_control_get_shared(priv->dev, NULL);
+	if (IS_ERR(top->top_rst)) {
+		dev_err(priv->dev, "top rst get failed\n");
+		return PTR_ERR(top->top_rst);
+	}
+
+	return 0;
+}
+
+static int jh7110_vout_top_crg_enable(struct vout_top_crg *top)
+{
+	int ret;
+
+	ret = clk_bulk_prepare_enable(top->top_clks_num, top->top_clks);
+	if (ret)
+		return ret;
+
+	return reset_control_deassert(top->top_rst);
+}
+
+static struct clk_hw *jh7110_voutclk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct jh71x0_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < JH7110_VOUTCLK_END)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh7110_voutcrg_probe(struct platform_device *pdev)
+{
+	struct jh71x0_clk_priv *priv;
+	struct vout_top_crg *top;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH7110_VOUTCLK_END),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	top = devm_kzalloc(&pdev->dev, sizeof(*top), GFP_KERNEL);
+	if (!top)
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
+	pm_runtime_enable(priv->dev);
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to turn power: %d\n", ret);
+		return ret;
+	}
+
+	ret = jh7110_vout_top_crg_get(priv, top);
+	if (ret)
+		return ret;
+
+	ret = jh7110_vout_top_crg_enable(top);
+	if (ret)
+		return ret;
+
+	for (idx = 0; idx < JH7110_VOUTCLK_END; idx++) {
+		u32 max = jh7110_voutclk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh7110_voutclk_data[idx].name,
+			.ops = starfive_jh71x0_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
+			.flags = jh7110_voutclk_data[idx].flags,
+		};
+		struct jh71x0_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh7110_voutclk_data[idx].parents[i];
+
+			if (pidx < JH7110_VOUTCLK_END)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JH7110_VOUTCLK_VOUT_SRC)
+				parents[i].fw_name = "vout_src";
+			else if (pidx == JH7110_VOUTCLK_VOUT_TOP_AHB)
+				parents[i].fw_name = "vout_top_ahb";
+			else if (pidx == JH7110_VOUTCLK_VOUT_TOP_AXI)
+				parents[i].fw_name = "vout_top_axi";
+			else if (pidx == JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK)
+				parents[i].fw_name = "vout_top_hdmitx0_mclk";
+			else if (pidx == JH7110_VOUTCLK_I2STX0_BCLK)
+				parents[i].fw_name = "i2stx0_bclk";
+			else if (pidx == JH7110_VOUTCLK_HDMITX0_PIXELCLK)
+				parents[i].fw_name = "hdmitx0_pixelclk";
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
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_voutclk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh7110_reset_controller_register(priv, "reset-vout", 4);
+}
+
+static const struct of_device_id jh7110_voutcrg_match[] = {
+	{ .compatible = "starfive,jh7110-voutcrg" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_voutcrg_match);
+
+static struct platform_driver jh7110_voutcrg_driver = {
+	.probe = jh7110_voutcrg_probe,
+	.driver = {
+		.name = "clk-starfive-jh7110-vout",
+		.of_match_table = jh7110_voutcrg_match,
+	},
+};
+module_platform_driver(jh7110_voutcrg_driver);
+
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH7110 Video-Output clock driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

