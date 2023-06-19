Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415BF7350DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjFSJs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjFSJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:48:16 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93011B0;
        Mon, 19 Jun 2023 02:48:06 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 640B7855B;
        Mon, 19 Jun 2023 17:48:05 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 17:48:05 +0800
Received: from ubuntu.localdomain (113.72.145.217) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 17:48:04 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Minda Chen <minda.chen@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: [PATCH v7 4/5] phy: starfive: Add JH7110 PCIE 2.0 PHY driver
Date:   Mon, 19 Jun 2023 17:47:58 +0800
Message-ID: <20230619094759.21013-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230619094759.21013-1-minda.chen@starfivetech.com>
References: <20230619094759.21013-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.217]
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

Add Starfive JH7110 SoC PCIe 2.0 PHY driver support.
PCIe 2.0 PHY default connect to PCIe controller.
PCIe PHY can connect to USB 3.0 controller.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 MAINTAINERS                            |   4 +-
 drivers/phy/starfive/Kconfig           |  10 ++
 drivers/phy/starfive/Makefile          |   1 +
 drivers/phy/starfive/phy-jh7110-pcie.c | 204 +++++++++++++++++++++++++
 4 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d2ce89a8d31c..b5d0a9e391bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20174,10 +20174,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/watchdog/starfive*
 F:	drivers/watchdog/starfive-wdt.c
 
-STARFIVE JH71X0 USB PHY DRIVER
+STARFIVE JH71X0 PCIE AND USB PHY DRIVER
 M:	Minda Chen <minda.chen@starfivetech.com>
 S:	Supported
+F:	Documentation/devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml
 F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
+F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
 
 STATIC BRANCH/CALL
diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
index 2283feadfc76..3df2ff654a10 100644
--- a/drivers/phy/starfive/Kconfig
+++ b/drivers/phy/starfive/Kconfig
@@ -3,6 +3,16 @@
 # Phy drivers for StarFive platforms
 #
 
+config PHY_STARFIVE_JH7110_PCIE
+	tristate "Starfive JH7110 PCIE 2.0/USB 3.0 PHY support"
+	select GENERIC_PHY
+	select USB_PHY
+	help
+	  Enable this to support the StarFive PCIe 2.0 PHY,
+	  or used as USB 3.0 PHY.
+	  If M is selected, the module will be called
+	  phy-jh7110-pcie.ko.
+
 config PHY_STARFIVE_JH7110_USB
 	tristate "Starfive JH7110 USB 2.0 PHY support"
 	depends on USB_SUPPORT
diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
index 52e9a09cc619..1c62d93e3280 100644
--- a/drivers/phy/starfive/Makefile
+++ b/drivers/phy/starfive/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)	+= phy-jh7110-pcie.o
 obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)	+= phy-jh7110-usb.o
diff --git a/drivers/phy/starfive/phy-jh7110-pcie.c b/drivers/phy/starfive/phy-jh7110-pcie.c
new file mode 100644
index 000000000000..cbe79c1f59d3
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-pcie.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * StarFive JH7110 PCIe 2.0 PHY driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Minda Chen <minda.chen@starfivetech.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define PCIE_KVCO_LEVEL_OFF		0x28
+#define PCIE_USB3_PHY_PLL_CTL_OFF	0x7c
+#define PCIE_KVCO_TUNE_SIGNAL_OFF	0x80
+#define PCIE_USB3_PHY_ENABLE		BIT(4)
+#define PHY_KVCO_FINE_TUNE_LEVEL	0x91
+#define PHY_KVCO_FINE_TUNE_SIGNALS	0xc
+
+#define USB_PDRSTN_SPLIT		BIT(17)
+
+#define PCIE_PHY_MODE			BIT(20)
+#define PCIE_PHY_MODE_MASK		GENMASK(21, 20)
+#define PCIE_USB3_BUS_WIDTH_MASK	GENMASK(3, 2)
+#define PCIE_USB3_BUS_WIDTH		BIT(3)
+#define PCIE_USB3_RATE_MASK		GENMASK(6, 5)
+#define PCIE_USB3_RX_STANDBY_MASK	BIT(7)
+#define PCIE_USB3_PHY_ENABLE		BIT(4)
+
+struct jh7110_pcie_phy {
+	struct phy *phy;
+	struct regmap *stg_syscon;
+	struct regmap *sys_syscon;
+	void __iomem *regs;
+	u32 sys_phy_connect;
+	u32 stg_pcie_mode;
+	u32 stg_pcie_usb;
+	enum phy_mode mode;
+};
+
+static int phy_usb3_mode_set(struct jh7110_pcie_phy *data)
+{
+	if (!data->stg_syscon || !data->sys_syscon) {
+		dev_err(&data->phy->dev, "doesn't support usb3 mode\n");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_mode,
+			   PCIE_PHY_MODE_MASK, PCIE_PHY_MODE);
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
+			   PCIE_USB3_BUS_WIDTH_MASK, 0);
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
+			   PCIE_USB3_PHY_ENABLE, PCIE_USB3_PHY_ENABLE);
+
+	/* Connect usb 3.0 phy mode */
+	regmap_update_bits(data->sys_syscon, data->sys_phy_connect,
+			   USB_PDRSTN_SPLIT, 0);
+
+	/* Configuare spread-spectrum mode: down-spread-spectrum */
+	writel(PCIE_USB3_PHY_ENABLE, data->regs + PCIE_USB3_PHY_PLL_CTL_OFF);
+
+	return 0;
+}
+
+static void phy_pcie_mode_set(struct jh7110_pcie_phy *data)
+{
+	u32 val;
+
+	/* default is PCIe mode */
+	if (!data->stg_syscon || !data->sys_syscon)
+		return;
+
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_mode,
+			   PCIE_PHY_MODE_MASK, 0);
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
+			   PCIE_USB3_BUS_WIDTH_MASK,
+			   PCIE_USB3_BUS_WIDTH);
+	regmap_update_bits(data->stg_syscon, data->stg_pcie_usb,
+			   PCIE_USB3_PHY_ENABLE, 0);
+
+	regmap_update_bits(data->sys_syscon, data->sys_phy_connect,
+			   USB_PDRSTN_SPLIT, 0);
+
+	val = readl(data->regs + PCIE_USB3_PHY_PLL_CTL_OFF);
+	val &= ~PCIE_USB3_PHY_ENABLE;
+	writel(val, data->regs + PCIE_USB3_PHY_PLL_CTL_OFF);
+}
+
+static void phy_kvco_gain_set(struct jh7110_pcie_phy *phy)
+{
+	/* PCIe Multi-PHY PLL KVCO Gain fine tune settings: */
+	writel(PHY_KVCO_FINE_TUNE_LEVEL, phy->regs + PCIE_KVCO_LEVEL_OFF);
+	writel(PHY_KVCO_FINE_TUNE_SIGNALS, phy->regs + PCIE_KVCO_TUNE_SIGNAL_OFF);
+}
+
+static int jh7110_pcie_phy_set_mode(struct phy *_phy,
+				    enum phy_mode mode, int submode)
+{
+	struct jh7110_pcie_phy *phy = phy_get_drvdata(_phy);
+	int ret;
+
+	if (mode == phy->mode)
+		return 0;
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+	case PHY_MODE_USB_DEVICE:
+	case PHY_MODE_USB_OTG:
+		ret = phy_usb3_mode_set(phy);
+		if (ret)
+			return ret;
+		break;
+	case PHY_MODE_PCIE:
+		phy_pcie_mode_set(phy);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(&_phy->dev, "Changing phy mode to %d\n", mode);
+	phy->mode = mode;
+
+	return 0;
+}
+
+static const struct phy_ops jh7110_pcie_phy_ops = {
+	.set_mode	= jh7110_pcie_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static int jh7110_pcie_phy_probe(struct platform_device *pdev)
+{
+	struct jh7110_pcie_phy *phy;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	u32 args[2];
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(phy->regs))
+		return PTR_ERR(phy->regs);
+
+	phy->phy = devm_phy_create(dev, NULL, &jh7110_pcie_phy_ops);
+	if (IS_ERR(phy->phy))
+		return dev_err_probe(dev, PTR_ERR(phy->regs),
+				     "Failed to map phy base\n");
+
+	phy->sys_syscon =
+		syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
+						     "starfive,sys-syscon",
+						     1, args);
+
+	if (!IS_ERR_OR_NULL(phy->sys_syscon))
+		phy->sys_phy_connect = args[0];
+	else
+		phy->sys_syscon = NULL;
+
+	phy->stg_syscon =
+		syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
+						     "starfive,stg-syscon",
+						     2, args);
+
+	if (!IS_ERR_OR_NULL(phy->stg_syscon)) {
+		phy->stg_pcie_mode = args[0];
+		phy->stg_pcie_usb = args[1];
+	} else {
+		phy->stg_syscon = NULL;
+	}
+
+	phy_kvco_gain_set(phy);
+
+	phy_set_drvdata(phy->phy, phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id jh7110_pcie_phy_of_match[] = {
+	{ .compatible = "starfive,jh7110-pcie-phy" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, jh7110_pcie_phy_of_match);
+
+static struct platform_driver jh7110_pcie_phy_driver = {
+	.probe	= jh7110_pcie_phy_probe,
+	.driver = {
+		.of_match_table	= jh7110_pcie_phy_of_match,
+		.name  = "jh7110-pcie-phy",
+	}
+};
+module_platform_driver(jh7110_pcie_phy_driver);
+
+MODULE_DESCRIPTION("StarFive JH7110 PCIe 2.0 PHY driver");
+MODULE_AUTHOR("Minda Chen <minda.chen@starfivetech.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

