Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4013A707F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjERL2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjERL2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:28:06 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7365C19A3;
        Thu, 18 May 2023 04:28:00 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E807C80E1;
        Thu, 18 May 2023 19:27:58 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 19:27:58 +0800
Received: from ubuntu.localdomain (113.72.146.100) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 19:27:57 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Minda Chen" <minda.chen@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: [PATCH v6 6/7] usb: cdns3: Add StarFive JH7110 USB driver
Date:   Thu, 18 May 2023 19:27:49 +0800
Message-ID: <20230518112750.57924-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518112750.57924-1-minda.chen@starfivetech.com>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.100]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Specific Glue layer to support USB peripherals on
StarFive JH7110 SoC.
There is a Cadence USB3 core for JH7110 SoCs, the cdns
core is the child of this USB wrapper module device.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
---
 MAINTAINERS                        |   6 +
 drivers/usb/cdns3/Kconfig          |  11 ++
 drivers/usb/cdns3/Makefile         |   1 +
 drivers/usb/cdns3/cdns3-starfive.c | 246 +++++++++++++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5519f81c8296..06c63f43bb17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20168,6 +20168,12 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
 
+STARFIVE JH71X0 USB DRIVERS
+M:	Minda Chen <minda.chen@starfivetech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
+F:	drivers/usb/cdns3/cdns3-starfive.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
index b98ca0a1352a..0a514b591527 100644
--- a/drivers/usb/cdns3/Kconfig
+++ b/drivers/usb/cdns3/Kconfig
@@ -78,6 +78,17 @@ config USB_CDNS3_IMX
 
 	  For example, imx8qm and imx8qxp.
 
+config USB_CDNS3_STARFIVE
+	tristate "Cadence USB3 support on StarFive SoC platforms"
+	depends on ARCH_STARFIVE || COMPILE_TEST
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
index 000000000000..fc1f003b145d
--- /dev/null
+++ b/drivers/usb/cdns3/cdns3-starfive.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * cdns3-starfive.c - StarFive specific Glue layer for Cadence USB Controller
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
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
+#include <linux/reset.h>
+#include <linux/regmap.h>
+#include <linux/usb/otg.h>
+#include "core.h"
+
+#define USB_STRAP_HOST			BIT(17)
+#define USB_STRAP_DEVICE		BIT(18)
+#define USB_STRAP_MASK			GENMASK(18, 16)
+
+#define USB_SUSPENDM_HOST		BIT(19)
+#define USB_SUSPENDM_MASK		BIT(19)
+
+#define USB_MISC_CFG_MASK		GENMASK(23, 20)
+#define USB_SUSPENDM_BYPS		BIT(20)
+#define USB_PLL_EN			BIT(22)
+#define USB_REFCLK_MODE			BIT(23)
+
+struct cdns_starfive {
+	struct device *dev;
+	struct regmap *stg_syscon;
+	struct reset_control *resets;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	u32 stg_usb_mode;
+};
+
+static void cdns_mode_init(struct platform_device *pdev,
+			   struct cdns_starfive *data)
+{
+	enum usb_dr_mode mode;
+
+	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
+			   USB_MISC_CFG_MASK,
+			   USB_SUSPENDM_BYPS | USB_PLL_EN | USB_REFCLK_MODE);
+
+	/* dr mode setting */
+	mode = usb_get_dr_mode(&pdev->dev);
+
+	switch (mode) {
+	case USB_DR_MODE_HOST:
+		regmap_update_bits(data->stg_syscon,
+				   data->stg_usb_mode,
+				   USB_STRAP_MASK,
+				   USB_STRAP_HOST);
+		regmap_update_bits(data->stg_syscon,
+				   data->stg_usb_mode,
+				   USB_SUSPENDM_MASK,
+				   USB_SUSPENDM_HOST);
+		break;
+
+	case USB_DR_MODE_PERIPHERAL:
+		regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
+				   USB_STRAP_MASK, USB_STRAP_DEVICE);
+		regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
+				   USB_SUSPENDM_MASK, 0);
+		break;
+	default:
+		break;
+	}
+}
+
+static int cdns_clk_rst_init(struct cdns_starfive *data)
+{
+	int ret;
+
+	ret = clk_bulk_prepare_enable(data->num_clks, data->clks);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "failed to enable clocks\n");
+
+	ret = reset_control_deassert(data->resets);
+	if (ret) {
+		dev_err(data->dev, "failed to reset clocks\n");
+		goto err_clk_init;
+	}
+
+	return ret;
+
+err_clk_init:
+	clk_bulk_disable_unprepare(data->num_clks, data->clks);
+	return ret;
+}
+
+static void cdns_clk_rst_deinit(struct cdns_starfive *data)
+{
+	reset_control_assert(data->resets);
+	clk_bulk_disable_unprepare(data->num_clks, data->clks);
+}
+
+static int cdns_starfive_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cdns_starfive *data;
+	unsigned int args;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+
+	data->stg_syscon =
+		syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
+						     "starfive,stg-syscon", 1, &args);
+
+	if (IS_ERR(data->stg_syscon))
+		return dev_err_probe(dev, PTR_ERR(data->stg_syscon),
+				     "Failed to parse starfive,stg-syscon\n");
+
+	data->stg_usb_mode = args;
+
+	data->num_clks = devm_clk_bulk_get_all(data->dev, &data->clks);
+	if (data->num_clks < 0)
+		return dev_err_probe(data->dev, -ENODEV,
+				     "Failed to get clocks\n");
+
+	data->resets = devm_reset_control_array_get_exclusive(data->dev);
+	if (IS_ERR(data->resets))
+		return dev_err_probe(data->dev, PTR_ERR(data->resets),
+				     "Failed to get resets");
+
+	cdns_mode_init(pdev, data);
+	ret = cdns_clk_rst_init(data);
+	if (ret)
+		return ret;
+
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "Failed to create children\n");
+		cdns_clk_rst_deinit(data);
+		return ret;
+	}
+
+	device_set_wakeup_capable(dev, true);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	platform_set_drvdata(pdev, data);
+
+	return 0;
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
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	cdns_clk_rst_deinit(data);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int cdns_starfive_runtime_resume(struct device *dev)
+{
+	struct cdns_starfive *data = dev_get_drvdata(dev);
+
+	return clk_bulk_prepare_enable(data->num_clks, data->clks);
+}
+
+static int cdns_starfive_runtime_suspend(struct device *dev)
+{
+	struct cdns_starfive *data = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(data->num_clks, data->clks);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int cdns_starfive_resume(struct device *dev)
+{
+	struct cdns_starfive *data = dev_get_drvdata(dev);
+
+	return cdns_clk_rst_init(data);
+}
+
+static int cdns_starfive_suspend(struct device *dev)
+{
+	struct cdns_starfive *data = dev_get_drvdata(dev);
+
+	cdns_clk_rst_deinit(data);
+
+	return 0;
+}
+#endif
+#endif
+
+static const struct dev_pm_ops cdns_starfive_pm_ops = {
+	SET_RUNTIME_PM_OPS(cdns_starfive_runtime_suspend,
+			   cdns_starfive_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(cdns_starfive_suspend, cdns_starfive_resume)
+};
+
+static const struct of_device_id cdns_starfive_of_match[] = {
+	{ .compatible = "starfive,jh7110-usb", },
+	{ /* sentinel */ }
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
+module_platform_driver(cdns_starfive_driver);
+
+MODULE_ALIAS("platform:cdns3-starfive");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Cadence USB3 StarFive Glue Layer");
-- 
2.17.1

