Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2914E69DC1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjBUIeB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Feb 2023 03:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjBUIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:33:42 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0A5B447;
        Tue, 21 Feb 2023 00:33:36 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 265C624E398;
        Tue, 21 Feb 2023 16:33:35 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 16:33:35 +0800
Received: from localhost.localdomain (183.27.98.67) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 16:33:33 +0800
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
Subject: [PATCH v2 06/11] clk: starfive: Add StarFive JH7110 Image-Signal-Process clock driver
Date:   Tue, 21 Feb 2023 16:33:18 +0800
Message-ID: <20230221083323.302471-7-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.67]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the StarFive JH7110 Image-Signal-Process clock controller.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |  11 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh7110-isp.c    | 254 ++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-isp.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index a462b6e53543..59499acb95f7 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -53,3 +53,14 @@ config CLK_STARFIVE_JH7110_STG
 	help
 	  Say yes here to support the System-Top-Group clock controller
 	  on the StarFive JH7110 SoC.
+
+config CLK_STARFIVE_JH7110_ISP
+	tristate "StarFive JH7110 Image-Signal-Process clock support"
+	depends on CLK_STARFIVE_JH7110_SYS && JH71XX_PMU
+	select AUXILIARY_BUS
+	select CLK_STARFIVE_JH71X0
+	select RESET_STARFIVE_JH7110
+	default CLK_STARFIVE_JH7110_SYS
+	help
+	  Say yes here to support the Image-Signal-Process clock controller
+	  on the StarFive JH7110 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index b81e97ee2659..76fb9f8d628b 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_SYS)	+= clk-starfive-jh7110-sys.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)	+= clk-starfive-jh7110-stg.o
+obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-isp.c b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
new file mode 100644
index 000000000000..b5bce1ac22e0
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH7110 Image-Signal-Process Clock Driver
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
+#define JH7110_ISPCLK_ISP_TOP_CORE		(JH7110_ISPCLK_END + 0)
+#define JH7110_ISPCLK_ISP_TOP_AXI		(JH7110_ISPCLK_END + 1)
+#define JH7110_ISPCLK_NOC_BUS_ISP_AXI		(JH7110_ISPCLK_END + 2)
+#define JH7110_ISPCLK_DVP_CLK			(JH7110_ISPCLK_END + 3)
+#define JH7110_ISPCLK_EXT_END			(JH7110_ISPCLK_END + 4)
+
+static const struct jh71x0_clk_data jh7110_ispclk_data[] = {
+	/* syscon */
+	JH71X0__DIV(JH7110_ISPCLK_DOM4_APB_FUNC, "dom4_apb_func", 15,
+		    JH7110_ISPCLK_ISP_TOP_AXI),
+	JH71X0__DIV(JH7110_ISPCLK_MIPI_RX0_PXL, "mipi_rx0_pxl", 8,
+		    JH7110_ISPCLK_ISP_TOP_CORE),
+	JH71X0__INV(JH7110_ISPCLK_DVP_INV, "dvp_inv", JH7110_ISPCLK_DVP_CLK),
+	/* vin */
+	JH71X0__DIV(JH7110_ISPCLK_M31DPHY_CFGCLK_IN, "m31dphy_cfgclk_in", 16,
+		    JH7110_ISPCLK_ISP_TOP_CORE),
+	JH71X0__DIV(JH7110_ISPCLK_M31DPHY_REFCLK_IN, "m31dphy_refclk_in", 16,
+		    JH7110_ISPCLK_ISP_TOP_CORE),
+	JH71X0__DIV(JH7110_ISPCLK_M31DPHY_TXCLKESC_LAN0, "m31dphy_txclkesc_lan0", 60,
+		    JH7110_ISPCLK_ISP_TOP_CORE),
+	JH71X0_GATE(JH7110_ISPCLK_VIN_PCLK, "vin_pclk", CLK_IGNORE_UNUSED,
+		    JH7110_ISPCLK_DOM4_APB_FUNC),
+	JH71X0__DIV(JH7110_ISPCLK_VIN_SYS_CLK, "vin_sys_clk", 8, JH7110_ISPCLK_ISP_TOP_CORE),
+	JH71X0_GATE(JH7110_ISPCLK_VIN_PIXEL_CLK_IF0, "vin_pixel_clk_if0", CLK_IGNORE_UNUSED,
+		    JH7110_ISPCLK_MIPI_RX0_PXL),
+	JH71X0_GATE(JH7110_ISPCLK_VIN_PIXEL_CLK_IF1, "vin_pixel_clk_if1", CLK_IGNORE_UNUSED,
+		    JH7110_ISPCLK_MIPI_RX0_PXL),
+	JH71X0_GATE(JH7110_ISPCLK_VIN_PIXEL_CLK_IF2, "vin_pixel_clk_if2", CLK_IGNORE_UNUSED,
+		    JH7110_ISPCLK_MIPI_RX0_PXL),
+	JH71X0_GATE(JH7110_ISPCLK_VIN_PIXEL_CLK_IF3, "vin_pixel_clk_if3", CLK_IGNORE_UNUSED,
+		    JH7110_ISPCLK_MIPI_RX0_PXL),
+	JH71X0__MUX(JH7110_ISPCLK_VIN_CLK_P_AXIWR, "vin_clk_p_axiwr", 2,
+		    JH7110_ISPCLK_MIPI_RX0_PXL,
+		    JH7110_ISPCLK_DVP_INV),
+	/* ispv2_top_wrapper */
+	JH71X0_GMUX(JH7110_ISPCLK_ISPV2_TOP_WRAPPER_CLK_C, "ispv2_top_wrapper_clk_c",
+		    CLK_IGNORE_UNUSED, 2,
+		    JH7110_ISPCLK_MIPI_RX0_PXL,
+		    JH7110_ISPCLK_DVP_INV),
+};
+
+struct isp_top_crg {
+	struct clk_bulk_data *top_clks;
+	struct reset_control *top_rsts;
+	int top_clks_num;
+	void __iomem *base;
+};
+
+static struct clk_bulk_data jh7110_isp_top_clks[] = {
+	{ .id = "isp_top_core" },
+	{ .id = "isp_top_axi" }
+};
+
+static struct isp_top_crg *top_crg_from(void __iomem **base)
+{
+	return container_of(base, struct isp_top_crg, base);
+}
+
+static int jh7110_isp_top_crg_get(struct jh71x0_clk_priv *priv, struct isp_top_crg *top)
+{
+	int ret;
+
+	top->top_clks = jh7110_isp_top_clks;
+	top->top_clks_num = ARRAY_SIZE(jh7110_isp_top_clks);
+	ret = devm_clk_bulk_get(priv->dev, top->top_clks_num, top->top_clks);
+	if (ret) {
+		dev_err(priv->dev, "top clks get failed: %d\n", ret);
+		return ret;
+	}
+
+	/* The resets should be shared and other ISP modules will use its. */
+	top->top_rsts = devm_reset_control_array_get_shared(priv->dev);
+	if (IS_ERR(top->top_rsts)) {
+		dev_err(priv->dev, "top rsts get failed\n");
+		return PTR_ERR(top->top_rsts);
+	}
+
+	return 0;
+}
+
+static int jh7110_isp_top_crg_enable(struct isp_top_crg *top)
+{
+	int ret;
+
+	ret = clk_bulk_prepare_enable(top->top_clks_num, top->top_clks);
+	if (ret)
+		return ret;
+
+	return reset_control_deassert(top->top_rsts);
+}
+
+static void jh7110_isp_top_crg_disable(struct isp_top_crg *top)
+{
+	clk_bulk_disable_unprepare(top->top_clks_num, top->top_clks);
+}
+
+static struct clk_hw *jh7110_ispclk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct jh71x0_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < JH7110_ISPCLK_END)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh7110_ispcrg_probe(struct platform_device *pdev)
+{
+	struct jh71x0_clk_priv *priv;
+	struct isp_top_crg *top;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH7110_ISPCLK_END),
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
+	top->base = priv->base;
+	dev_set_drvdata(priv->dev, (void *)(&top->base));
+
+	pm_runtime_enable(priv->dev);
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to turn on power: %d\n", ret);
+		return ret;
+	}
+
+	ret = jh7110_isp_top_crg_get(priv, top);
+	if (ret)
+		goto err_clk;
+
+	ret = jh7110_isp_top_crg_enable(top);
+	if (ret)
+		goto err_clk;
+
+	for (idx = 0; idx < JH7110_ISPCLK_END; idx++) {
+		u32 max = jh7110_ispclk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh7110_ispclk_data[idx].name,
+			.ops = starfive_jh71x0_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
+			.flags = jh7110_ispclk_data[idx].flags,
+		};
+		struct jh71x0_clk *clk = &priv->reg[idx];
+		unsigned int i;
+		char *fw_name[JH7110_ISPCLK_EXT_END - JH7110_ISPCLK_END] = {
+			"isp_top_core",
+			"isp_top_axi",
+			"noc_bus_isp_axi",
+			"dvp_clk"
+		};
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh7110_ispclk_data[idx].parents[i];
+
+			if (pidx < JH7110_ISPCLK_END)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else
+				parents[i].fw_name = fw_name[pidx - JH7110_ISPCLK_END];
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & JH71X0_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			goto err_exit;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_ispclk_get, priv);
+	if (ret)
+		goto err_exit;
+
+	ret = jh7110_reset_controller_register(priv, "reset-isp", 3);
+	if (ret)
+		goto err_exit;
+
+	return 0;
+
+err_exit:
+	jh7110_isp_top_crg_disable(top);
+err_clk:
+	pm_runtime_put_sync(priv->dev);
+	pm_runtime_disable(priv->dev);
+	return ret;
+}
+
+static int jh7110_ispcrg_remove(struct platform_device *pdev)
+{
+	void __iomem **base = dev_get_drvdata(&pdev->dev);
+	struct isp_top_crg *top = top_crg_from(base);
+
+	jh7110_isp_top_crg_disable(top);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id jh7110_ispcrg_match[] = {
+	{ .compatible = "starfive,jh7110-ispcrg" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_ispcrg_match);
+
+static struct platform_driver jh7110_ispcrg_driver = {
+	.probe = jh7110_ispcrg_probe,
+	.remove = jh7110_ispcrg_remove,
+	.driver = {
+		.name = "clk-starfive-jh7110-isp",
+		.of_match_table = jh7110_ispcrg_match,
+	},
+};
+module_platform_driver(jh7110_ispcrg_driver);
+
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH7110 Image-Signal-Process clock driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

