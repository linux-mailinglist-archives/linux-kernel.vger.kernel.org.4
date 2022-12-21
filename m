Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C387765380E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiLUVJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiLUVJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:09:50 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89BC2264B9;
        Wed, 21 Dec 2022 13:09:45 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,263,1665414000"; 
   d="scan'208";a="144108268"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2022 06:09:44 +0900
Received: from mulinux.example.org (unknown [10.226.92.211])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CD59B40DC546;
        Thu, 22 Dec 2022 06:09:39 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
Date:   Wed, 21 Dec 2022 21:09:15 +0000
Message-Id: <20221221210917.458537-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The External Power Sequence Controller (PWC) IP (found in the
RZ/V2M SoC) is a controller for external power supplies (regulators
and power switches), and it supports the following features: it
generates a power on/off sequence for external power supplies,
it generates an on/off sequence for the LPDDR4 core power supply
(LPVDD), it comes with General-Purpose Outputs, and it processes
key input signals.

The PWC is basically a Multi-Function Device (MFD), its software
support comes with a core driver, and specialized drivers for
its specific features.

This patch adds the core driver for the RZ/V2M PWC IP.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---

v1->v2: This is a new driver, to match the relevant compatible string
	and instantiate the relevant mfd device drivers

 drivers/mfd/Kconfig     | 14 +++++++++
 drivers/mfd/Makefile    |  1 +
 drivers/mfd/rzv2m-pwc.c | 70 +++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/rzv2m-pwc.h | 18 +++++++++++
 4 files changed, 103 insertions(+)
 create mode 100644 drivers/mfd/rzv2m-pwc.c
 create mode 100644 drivers/mfd/rzv2m-pwc.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 30db49f31866..ac4403e4f3cb 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2265,5 +2265,19 @@ config MFD_RSMU_SPI
 	  Additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_RZV2M_PWC_CORE
+	tristate "Renesas RZ/V2M PWC Core Driver"
+	select MFD_CORE
+	depends on ARCH_R9A09G011 || COMPILE_TEST
+	help
+	  Select this option to enable the RZ/V2M External Power Sequence
+	  Controller (PWC) core driver.
+
+	  The PWC is a controller for external power supplies (regulators and
+	  power switches), and it supports the following features: it generates
+	  a power on/off sequence for external power supplies, it generates an
+	  on/off sequence for the LPDDR4 core power supply (LPVDD), it comes
+	  with General-Purpose Outputs, and it processes key input signals.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 457471478a93..e39252a2df23 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -278,3 +278,4 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
 rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
 obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
+obj-$(CONFIG_MFD_RZV2M_PWC_CORE) += rzv2m-pwc.o
diff --git a/drivers/mfd/rzv2m-pwc.c b/drivers/mfd/rzv2m-pwc.c
new file mode 100644
index 000000000000..f9055fcafda2
--- /dev/null
+++ b/drivers/mfd/rzv2m-pwc.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ *
+ * Core driver for the Renesas RZ/V2M External Power Sequence Controller (PWC)
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/core.h>
+#include "rzv2m-pwc.h"
+
+static const struct mfd_cell rzv2m_pwc_gpio_devs[] = {
+	{ .name = "gpio_rzv2m_pwc", },
+};
+
+static const struct mfd_cell rzv2m_pwc_poweroff_devs[] = {
+	{ .name = "rzv2m_pwc_poweroff", },
+};
+
+static int rzv2m_pwc_probe(struct platform_device *pdev)
+{
+	struct rzv2m_pwc_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+				   rzv2m_pwc_gpio_devs,
+				   ARRAY_SIZE(rzv2m_pwc_gpio_devs), NULL, 0,
+				   NULL);
+	if (ret)
+		return ret;
+
+	if (of_property_read_bool(pdev->dev.of_node, "renesas,rzv2m-pwc-power"))
+		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+					   rzv2m_pwc_poweroff_devs,
+					   ARRAY_SIZE(rzv2m_pwc_poweroff_devs),
+					   NULL, 0, NULL);
+
+	return ret;
+}
+
+static const struct of_device_id rzv2m_pwc_of_match[] = {
+	{ .compatible = "renesas,rzv2m-pwc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzv2m_pwc_of_match);
+
+static struct platform_driver rzv2m_pwc_driver = {
+	.probe = rzv2m_pwc_probe,
+	.driver = {
+		.name = "rzv2m_pwc",
+		.of_match_table = of_match_ptr(rzv2m_pwc_of_match),
+	},
+};
+module_platform_driver(rzv2m_pwc_driver);
+
+MODULE_SOFTDEP("post: gpio_rzv2m_pwc rzv2m_pwc_poweroff");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Fabrizio Castro <castro.fabrizio.jz@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2M PWC core driver");
diff --git a/drivers/mfd/rzv2m-pwc.h b/drivers/mfd/rzv2m-pwc.h
new file mode 100644
index 000000000000..8f3d777557c9
--- /dev/null
+++ b/drivers/mfd/rzv2m-pwc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#ifndef __LINUX_RZV2M_PWC_H__
+#define __LINUX_RZV2M_PWC_H__
+
+#define PWC_PWCRST			0x00
+#define PWC_PWCCKEN			0x04
+#define PWC_PWCCTL			0x50
+#define PWC_GPIO			0x80
+
+struct rzv2m_pwc_priv {
+	void __iomem *base;
+};
+
+#endif /* __LINUX_RZV2M_PWC_H__ */
-- 
2.34.1

