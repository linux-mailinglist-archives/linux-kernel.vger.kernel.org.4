Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7C96ABA6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCFJxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCFJxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:53:52 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7952128E;
        Mon,  6 Mar 2023 01:53:43 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1E4CD24DBBD;
        Mon,  6 Mar 2023 17:53:42 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 17:53:42 +0800
Received: from ubuntu.localdomain (183.27.97.46) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 17:53:41 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Peter Chen" <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        "Aswath Govindraju" <a-govindraju@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH 2/3] usb: cdns3: add StarFive JH7110 USB glue layer
Date:   Mon, 6 Mar 2023 17:53:39 +0800
Message-ID: <20230306095339.26006-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX071.cuchost.com
 (172.16.6.81)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a Cadence USB3 core for JH7110 SoCs, the cdns
core is the child for this glue layer device.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 MAINTAINERS                        |   7 +
 drivers/usb/cdns3/Kconfig          |  11 +
 drivers/usb/cdns3/Makefile         |   1 +
 drivers/usb/cdns3/cdns3-starfive.c | 399 +++++++++++++++++++++++++++++
 4 files changed, 418 insertions(+)
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ee21213d4388..2a9e89922cad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19957,6 +19957,13 @@ M:	William Qiu <william.qiu@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
 
+STARFIVE JH71X0 USB PHY DRIVERS
+M:	Emil Renner Berthing <kernel@esmil.dk>
+M:	Minda Chen <minda.chen@starfivetech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb*.yaml
+F:	drivers/usb/cdns3/cdns3-starfive.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
index b98ca0a1352a..a0b0a2c5430b 100644
--- a/drivers/usb/cdns3/Kconfig
+++ b/drivers/usb/cdns3/Kconfig
@@ -78,6 +78,17 @@ config USB_CDNS3_IMX
 
 	  For example, imx8qm and imx8qxp.
 
+config USB_CDNS3_STARFIVE
+	tristate "Cadence USB3 support on StarFive SoC platforms"
+	depends on SOC_STARFIVE || COMPILE_TEST || USB_CDNS3
+	help
+	  Say 'Y' or 'M' here if you are building for StarFive SoCs
+	  platforms that contain Cadence USB3 controller core.
+
+	  e.g. JH7110.
+
+	  If you choose to build this driver as module it will
+	  be dynamically linked and module will be called cdns3-starfive.ko
 endif
 
 if USB_CDNS_SUPPORT
diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index 61edb2f89276..48dfae75b5aa 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -24,6 +24,7 @@ endif
 obj-$(CONFIG_USB_CDNS3_PCI_WRAP)		+= cdns3-pci-wrap.o
 obj-$(CONFIG_USB_CDNS3_TI)			+= cdns3-ti.o
 obj-$(CONFIG_USB_CDNS3_IMX)			+= cdns3-imx.o
+obj-$(CONFIG_USB_CDNS3_STARFIVE)		+= cdns3-starfive.o
 
 cdnsp-udc-pci-y					:= cdnsp-pci.o
 
diff --git a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/cdns3-starfive.c
new file mode 100644
index 000000000000..54d9978cfa59
--- /dev/null
+++ b/drivers/usb/cdns3/cdns3-starfive.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * cdns-starfive.c - StarFive specific Glue layer for Cadence USB Controller
+ *
+ * Copyright (C) 2022 Starfive, Inc.
+ * Author:	yanhong <yanhong.wang@starfivetech.com>
+ * Author:	Mason Huo <mason.huo@starfivetech.com>
+ * Author:	Minda Chen <minda.chen@starfivetech.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/usb/otg.h>
+#include "core.h"
+
+#define USB_STRAP_HOST			BIT(17)
+#define USB_STRAP_DEVICE		BIT(18)
+#define USB_STRAP_MASK			GENMASK(18, 16)
+
+#define USB_SUSPENDM_HOST		BIT(19)
+#define USB_SUSPENDM_DEVICE		(0 << 19)
+#define USB_SUSPENDM_MASK		BIT(19)
+
+#define USB_SUSPENDM_BYPS		BIT(20)
+#define USB_REFCLK_MODE			BIT(23)
+#define USB_PLL_EN			BIT(22)
+#define USB_PDRSTN_SPLIT		BIT(17)
+
+#define PCIE_CKREF_SRC_MASK		GENMASK(19, 18)
+#define PCIE_CLK_SEL_MASK		GENMASK(21, 20)
+#define PCIE_PHY_MODE			BIT(20)
+#define PCIE_PHY_MODE_MASK		GENMASK(21, 20)
+#define PCIE_USB3_BUS_WIDTH_MASK	GENMASK(3, 2)
+#define PCIE_USB3_RATE_MASK		GENMASK(6, 5)
+#define PCIE_USB3_RX_STANDBY_MASK	BIT(7)
+#define PCIE_USB3_PHY_ENABLE		BIT(4)
+#define PCIE_USB3_PHY_PLL_CTL_OFF	(0x1f * 4)
+
+#define USB_125M_CLK_RATE		125000000
+
+#define USB_LS_KEEPALIVE_OFF		0x4
+#define USB_LS_KEEPALIVE_ENABLE		BIT(4)
+
+#define USB3_DOWN_SS_MODE		BIT(4)
+
+struct cdns_starfive {
+	struct device *dev;
+	struct regmap *stg_syscon;
+	struct regmap *sys_syscon;
+	struct reset_control *resets;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	struct clk *usb_125m_clk;
+	u32 sys_offset;
+	u32 stg_offset_4;
+	u32 stg_offset_196;
+	u32 stg_offset_328;
+	u32 stg_offset_500;
+	bool usb2_only;
+	enum usb_dr_mode mode;
+	void __iomem *phybase_20;
+	void __iomem *phybase_30;
+};
+
+static int cdns_mode_init(struct platform_device *pdev,
+				struct cdns_starfive *data)
+{
+	enum usb_dr_mode mode;
+
+	/* Init usb 2.0 utmi phy */
+	regmap_update_bits(data->stg_syscon, data->stg_offset_4,
+		USB_SUSPENDM_BYPS, USB_SUSPENDM_BYPS);
+	regmap_update_bits(data->stg_syscon, data->stg_offset_4,
+		USB_PLL_EN, USB_PLL_EN);
+	regmap_update_bits(data->stg_syscon, data->stg_offset_4,
+		USB_REFCLK_MODE, USB_REFCLK_MODE);
+
+	if (data->usb2_only) {
+		/* Disconnect usb 3.0 phy mode */
+		regmap_update_bits(data->sys_syscon, data->sys_offset,
+			USB_PDRSTN_SPLIT, USB_PDRSTN_SPLIT);
+	} else {
+		/* Config usb 3.0 pipe phy */
+		regmap_update_bits(data->stg_syscon, data->stg_offset_196,
+			PCIE_CKREF_SRC_MASK, 0);
+		regmap_update_bits(data->stg_syscon, data->stg_offset_196,
+			PCIE_CLK_SEL_MASK, 0);
+		regmap_update_bits(data->stg_syscon, data->stg_offset_328,
+			PCIE_PHY_MODE_MASK, PCIE_PHY_MODE);
+		regmap_update_bits(data->stg_syscon, data->stg_offset_500,
+			PCIE_USB3_BUS_WIDTH_MASK, 0);
+		regmap_update_bits(data->stg_syscon, data->stg_offset_500,
+			PCIE_USB3_RATE_MASK, 0);
+		regmap_update_bits(data->stg_syscon, data->stg_offset_500,
+			PCIE_USB3_RX_STANDBY_MASK, 0);
+		regmap_update_bits(data->stg_syscon, data->stg_offset_500,
+			PCIE_USB3_PHY_ENABLE, PCIE_USB3_PHY_ENABLE);
+
+		/* Connect usb 3.0 phy mode */
+		regmap_update_bits(data->sys_syscon, data->sys_offset,
+			USB_PDRSTN_SPLIT, 0);
+	}
+	mode = usb_get_dr_mode(&pdev->dev);
+	data->mode = mode;
+
+	switch (mode) {
+	case USB_DR_MODE_HOST:
+		regmap_update_bits(data->stg_syscon,
+			data->stg_offset_4,
+			USB_STRAP_MASK,
+			USB_STRAP_HOST);
+		regmap_update_bits(data->stg_syscon,
+			data->stg_offset_4,
+			USB_SUSPENDM_MASK,
+			USB_SUSPENDM_HOST);
+		break;
+
+	case USB_DR_MODE_PERIPHERAL:
+		regmap_update_bits(data->stg_syscon, data->stg_offset_4,
+			USB_STRAP_MASK, USB_STRAP_DEVICE);
+		regmap_update_bits(data->stg_syscon, data->stg_offset_4,
+			USB_SUSPENDM_MASK, USB_SUSPENDM_DEVICE);
+		break;
+
+	case USB_DR_MODE_UNKNOWN:
+	case USB_DR_MODE_OTG:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+
+static int cdns_clk_rst_init(struct cdns_starfive *data)
+{
+	int ret;
+
+	data->usb_125m_clk = devm_clk_get(data->dev, "usb_125m");
+	if (IS_ERR(data->usb_125m_clk)) {
+		dev_err(data->dev, "Failed to get usb 125m clock\n");
+		ret = PTR_ERR(data->usb_125m_clk);
+		goto exit;
+	}
+
+	data->num_clks = devm_clk_bulk_get_all(data->dev, &data->clks);
+	if (data->num_clks < 0) {
+		dev_err(data->dev, "Failed to get usb clocks\n");
+		ret = -ENODEV;
+		goto exit;
+	}
+
+	/* Needs to set the USB_125M clock explicitly,
+	 * since it's divided from pll0 clock, and the pll0 clock
+	 * changes per the cpu frequency.
+	 */
+	ret = clk_set_rate(data->usb_125m_clk, USB_125M_CLK_RATE);
+	if (ret) {
+		dev_err(data->dev, "Failed to set usb 125m clock\n");
+		goto exit;
+	}
+	ret = clk_bulk_prepare_enable(data->num_clks, data->clks);
+	if (ret) {
+		dev_err(data->dev, "Failed to enable clocks\n");
+		goto exit;
+	}
+
+	data->resets = devm_reset_control_array_get_exclusive(data->dev);
+	if (IS_ERR(data->resets)) {
+		ret = PTR_ERR(data->resets);
+		dev_err(data->dev, "Failed to get usb resets");
+		goto err_clk_init;
+	}
+	ret = reset_control_deassert(data->resets);
+	goto exit;
+
+err_clk_init:
+	clk_bulk_disable_unprepare(data->num_clks, data->clks);
+exit:
+	return ret;
+}
+
+static void cdns_starfive_set_phy(struct cdns_starfive *data)
+{
+	unsigned int val;
+
+	if (data->mode != USB_DR_MODE_PERIPHERAL) {
+		/* Enable the LS speed keep-alive signal */
+		val = readl(data->phybase_20 + USB_LS_KEEPALIVE_OFF);
+		val |= USB_LS_KEEPALIVE_ENABLE;
+		writel(val, data->phybase_20 + USB_LS_KEEPALIVE_OFF);
+	}
+
+	if (!data->usb2_only) {
+		/* Configuare spread-spectrum mode: down-spread-spectrum */
+		writel(USB3_DOWN_SS_MODE, data->phybase_30 + PCIE_USB3_PHY_PLL_CTL_OFF);
+	}
+}
+
+static int cdns_starfive_phy_init(struct platform_device *pdev,
+							struct cdns_starfive *data)
+{
+	struct device *dev = &pdev->dev;
+	int ret = 0;
+
+	data->phybase_20 = devm_platform_ioremap_resource_byname(pdev, "usb2");
+	if (IS_ERR(data->phybase_20)) {
+		dev_err(dev, "Can't map phybase_20 IOMEM resource\n");
+		ret = PTR_ERR(data->phybase_20);
+		goto get_res_err;
+	}
+
+	data->phybase_30 = devm_platform_ioremap_resource_byname(pdev, "usb3");
+	if (IS_ERR(data->phybase_30)) {
+		dev_err(dev, "Can't map phybase_30 IOMEM resource\n");
+		ret = PTR_ERR(data->phybase_30);
+		goto get_res_err;
+	}
+
+	cdns_starfive_set_phy(data);
+
+get_res_err:
+	return ret;
+}
+
+static int cdns_starfive_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = pdev->dev.of_node;
+	struct cdns_starfive *data;
+	struct of_phandle_args args;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, data);
+
+	data->dev = dev;
+
+	data->usb2_only = device_property_read_bool(dev, "starfive,usb2-only");
+	ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+						"starfive,stg-syscon", 4, 0, &args);
+	if (ret < 0) {
+		dev_err(dev, "Failed to parse starfive,stg-syscon\n");
+		return -EINVAL;
+	}
+
+	data->stg_syscon = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
+	if (IS_ERR(data->stg_syscon))
+		return PTR_ERR(data->stg_syscon);
+	data->stg_offset_4 = args.args[0];
+	data->stg_offset_196 = args.args[1];
+	data->stg_offset_328 = args.args[2];
+	data->stg_offset_500 = args.args[3];
+
+	ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+						"starfive,sys-syscon", 1, 0, &args);
+	if (ret < 0) {
+		dev_err(dev, "Failed to parse starfive,sys-syscon\n");
+		return -EINVAL;
+	}
+
+	data->sys_syscon = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
+	if (IS_ERR(data->sys_syscon))
+		return PTR_ERR(data->sys_syscon);
+	data->sys_offset = args.args[0];
+
+	cdns_mode_init(pdev, data);
+
+	ret = cdns_clk_rst_init(data);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to init usb clk reset: %d\n", ret);
+		goto exit;
+	}
+
+	ret = cdns_starfive_phy_init(pdev, data);
+	if (ret) {
+		dev_err(dev, "Failed to init sratfive usb phy: %d\n", ret);
+		goto exit;
+	}
+
+	ret = of_platform_populate(node, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "Failed to create children: %d\n", ret);
+		goto exit;
+	}
+
+	device_set_wakeup_capable(dev, true);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	dev_info(dev, "usb mode %d %s probe success\n",
+		data->mode, data->usb2_only ? "2.0" : "3.0");
+
+	return 0;
+exit:
+	return ret;
+}
+
+static int cdns_starfive_remove_core(struct device *dev, void *c)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
+static int cdns_starfive_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cdns_starfive *data = dev_get_drvdata(dev);
+
+	pm_runtime_get_sync(dev);
+	device_for_each_child(dev, NULL, cdns_starfive_remove_core);
+
+	reset_control_assert(data->resets);
+	clk_bulk_disable_unprepare(data->num_clks, data->clks);
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int cdns_starfive_resume(struct device *dev)
+{
+	struct cdns_starfive *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_set_rate(data->usb_125m_clk, USB_125M_CLK_RATE);
+	if (ret)
+		goto err;
+
+	ret = clk_bulk_prepare_enable(data->num_clks, data->clks);
+	if (ret)
+		goto err;
+
+	ret = reset_control_deassert(data->resets);
+	if (ret)
+		goto err;
+
+	cdns_starfive_set_phy(data);
+err:
+	return ret;
+}
+
+static int cdns_starfive_suspend(struct device *dev)
+{
+	struct cdns_starfive *data = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(data->num_clks, data->clks);
+	reset_control_assert(data->resets);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops cdns_starfive_pm_ops = {
+	SET_RUNTIME_PM_OPS(cdns_starfive_suspend, cdns_starfive_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(cdns_starfive_suspend, cdns_starfive_resume)
+};
+
+static const struct of_device_id cdns_starfive_of_match[] = {
+	{ .compatible = "starfive,jh7110-usb", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cdns_starfive_of_match);
+
+static struct platform_driver cdns_starfive_driver = {
+	.probe		= cdns_starfive_probe,
+	.remove		= cdns_starfive_remove,
+	.driver		= {
+		.name	= "cdns3-starfive",
+		.of_match_table	= cdns_starfive_of_match,
+		.pm	= &cdns_starfive_pm_ops,
+	},
+};
+
+module_platform_driver(cdns_starfive_driver);
+
+MODULE_ALIAS("platform:cdns3-starfive");
+MODULE_AUTHOR("YanHong Wang <yanhong.wang@starfivetech.com>");
+MODULE_AUTHOR("Mason Huo <mason.huo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Cadence USB3 StarFive Glue Layer");
-- 
2.17.1

