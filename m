Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F720707F46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjERL22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjERL17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:27:59 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BCAE45;
        Thu, 18 May 2023 04:27:57 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id AECC624E25B;
        Thu, 18 May 2023 19:27:56 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 19:27:56 +0800
Received: from ubuntu.localdomain (113.72.146.100) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 19:27:55 +0800
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
Subject: [PATCH v6 4/7] phy: starfive: Add JH7110 PCIE 2.0 PHY driver
Date:   Thu, 18 May 2023 19:27:47 +0800
Message-ID: <20230518112750.57924-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518112750.57924-1-minda.chen@starfivetech.com>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.100]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
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
---
 MAINTAINERS                            |   4 +-
 drivers/phy/starfive/Kconfig           |  10 ++
 drivers/phy/starfive/Makefile          |   1 +
 drivers/phy/starfive/phy-jh7110-pcie.c | 204 +++++++++++++++++++++++++
 4 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b900f661c2e0..5519f81c8296 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20160,10 +20160,12 @@ S:	Supported
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
index 2c013c390dee..38eb0c0c8e91 100644
--- a/drivers/phy/starfive/Kconfig
+++ b/drivers/phy/starfive/Kconfig
@@ -12,6 +12,16 @@ config PHY_STARFIVE_DPHY_RX
 	  system. If M is selected, the module will be called
 	  phy-starfive-dphy-rx.
 
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
index 176443852f4d..03a55aad53a2 100644
--- a/drivers/phy/starfive/Makefile
+++ b/drivers/phy/starfive/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PHY_STARFIVE_DPHY_RX)      += phy-starfive-dphy-rx.o
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

