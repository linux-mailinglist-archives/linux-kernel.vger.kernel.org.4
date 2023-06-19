Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F487350DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjFSJsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjFSJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:48:16 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049E21B4;
        Mon, 19 Jun 2023 02:48:06 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8FFBD24E295;
        Mon, 19 Jun 2023 17:48:04 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 17:48:04 +0800
Received: from ubuntu.localdomain (113.72.145.217) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 17:48:03 +0800
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
Subject: [PATCH v7 3/5] phy: starfive: Add JH7110 USB 2.0 PHY driver
Date:   Mon, 19 Jun 2023 17:47:57 +0800
Message-ID: <20230619094759.21013-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230619094759.21013-1-minda.chen@starfivetech.com>
References: <20230619094759.21013-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.217]
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

Add Starfive JH7110 SoC USB 2.0 PHY driver support.
USB 2.0 PHY default connect to Cadence USB controller.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 MAINTAINERS                           |   6 ++
 drivers/phy/Kconfig                   |   1 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/starfive/Kconfig          |  15 +++
 drivers/phy/starfive/Makefile         |   2 +
 drivers/phy/starfive/phy-jh7110-usb.c | 150 ++++++++++++++++++++++++++
 6 files changed, 175 insertions(+)
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f794002a192e..d2ce89a8d31c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20174,6 +20174,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/watchdog/starfive*
 F:	drivers/watchdog/starfive-wdt.c
 
+STARFIVE JH71X0 USB PHY DRIVER
+M:	Minda Chen <minda.chen@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
+F:	drivers/phy/starfive/phy-jh7110-usb.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index f46e3148d286..0000149edbc4 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -91,6 +91,7 @@ source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/samsung/Kconfig"
 source "drivers/phy/socionext/Kconfig"
 source "drivers/phy/st/Kconfig"
+source "drivers/phy/starfive/Kconfig"
 source "drivers/phy/sunplus/Kconfig"
 source "drivers/phy/tegra/Kconfig"
 source "drivers/phy/ti/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 54f312c10a40..fb3dc9de6111 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -31,6 +31,7 @@ obj-y					+= allwinner/	\
 					   samsung/	\
 					   socionext/	\
 					   st/		\
+					   starfive/	\
 					   sunplus/	\
 					   tegra/	\
 					   ti/		\
diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
new file mode 100644
index 000000000000..2283feadfc76
--- /dev/null
+++ b/drivers/phy/starfive/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Phy drivers for StarFive platforms
+#
+
+config PHY_STARFIVE_JH7110_USB
+	tristate "Starfive JH7110 USB 2.0 PHY support"
+	depends on USB_SUPPORT
+	select GENERIC_PHY
+	select USB_PHY
+	help
+	  Enable this to support the StarFive USB 2.0 PHY,
+	  used with the Cadence USB controller.
+	  If M is selected, the module will be called
+	  phy-jh7110-usb.ko.
diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
new file mode 100644
index 000000000000..52e9a09cc619
--- /dev/null
+++ b/drivers/phy/starfive/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)	+= phy-jh7110-usb.o
diff --git a/drivers/phy/starfive/phy-jh7110-usb.c b/drivers/phy/starfive/phy-jh7110-usb.c
new file mode 100644
index 000000000000..90d788423705
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-usb.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * StarFive JH7110 USB 2.0 PHY driver
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
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/usb/of.h>
+
+#define USB_125M_CLK_RATE		125000000
+#define USB_LS_KEEPALIVE_OFF		0x4
+#define USB_LS_KEEPALIVE_ENABLE		BIT(4)
+
+struct jh7110_usb2_phy {
+	struct phy *phy;
+	void __iomem *regs;
+	struct clk *usb_125m_clk;
+	struct clk *app_125m;
+	enum phy_mode mode;
+};
+
+static void jh7110_usb2_mode_set(struct jh7110_usb2_phy *phy)
+{
+	unsigned int val;
+
+	if (phy->mode != PHY_MODE_USB_HOST) {
+		/* Enable the LS speed keep-alive signal */
+		val = readl(phy->regs + USB_LS_KEEPALIVE_OFF);
+		val |= USB_LS_KEEPALIVE_ENABLE;
+		writel(val, phy->regs + USB_LS_KEEPALIVE_OFF);
+	}
+}
+
+static int jh7110_usb2_phy_set_mode(struct phy *_phy,
+				    enum phy_mode mode, int submode)
+{
+	struct jh7110_usb2_phy *phy = phy_get_drvdata(_phy);
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+	case PHY_MODE_USB_DEVICE:
+	case PHY_MODE_USB_OTG:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (mode != phy->mode) {
+		dev_dbg(&_phy->dev, "Changing phy to %d\n", mode);
+		phy->mode = mode;
+		jh7110_usb2_mode_set(phy);
+	}
+
+	return 0;
+}
+
+static int jh7110_usb2_phy_init(struct phy *_phy)
+{
+	struct jh7110_usb2_phy *phy = phy_get_drvdata(_phy);
+	int ret;
+
+	ret = clk_set_rate(phy->usb_125m_clk, USB_125M_CLK_RATE);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(phy->app_125m);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int jh7110_usb2_phy_exit(struct phy *_phy)
+{
+	struct jh7110_usb2_phy *phy = phy_get_drvdata(_phy);
+
+	clk_disable_unprepare(phy->app_125m);
+
+	return 0;
+}
+
+static const struct phy_ops jh7110_usb2_phy_ops = {
+	.init		= jh7110_usb2_phy_init,
+	.exit		= jh7110_usb2_phy_exit,
+	.set_mode	= jh7110_usb2_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static int jh7110_usb_phy_probe(struct platform_device *pdev)
+{
+	struct jh7110_usb2_phy *phy;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->usb_125m_clk = devm_clk_get(dev, "125m");
+	if (IS_ERR(phy->usb_125m_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_125m_clk),
+			"Failed to get 125m clock\n");
+
+	phy->app_125m = devm_clk_get(dev, "app_125m");
+	if (IS_ERR(phy->app_125m))
+		return dev_err_probe(dev, PTR_ERR(phy->app_125m),
+			"Failed to get app 125m clock\n");
+
+	phy->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(phy->regs))
+		return dev_err_probe(dev, PTR_ERR(phy->regs),
+			"Failed to map phy base\n");
+
+	phy->phy = devm_phy_create(dev, NULL, &jh7110_usb2_phy_ops);
+	if (IS_ERR(phy->phy))
+		return dev_err_probe(dev, PTR_ERR(phy->phy),
+			"Failed to create phy\n");
+
+	phy_set_drvdata(phy->phy, phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id jh7110_usb_phy_of_match[] = {
+	{ .compatible = "starfive,jh7110-usb-phy" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, jh7110_usb_phy_of_match);
+
+static struct platform_driver jh7110_usb_phy_driver = {
+	.probe	= jh7110_usb_phy_probe,
+	.driver = {
+		.of_match_table	= jh7110_usb_phy_of_match,
+		.name  = "jh7110-usb-phy",
+	}
+};
+module_platform_driver(jh7110_usb_phy_driver);
+
+MODULE_DESCRIPTION("StarFive JH7110 USB 2.0 PHY driver");
+MODULE_AUTHOR("Minda Chen <minda.chen@starfivetech.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

