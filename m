Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE78664BF9A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiLMWoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiLMWoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:44:04 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1FFF2314D;
        Tue, 13 Dec 2022 14:43:47 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,242,1665414000"; 
   d="scan'208";a="143229849"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2022 07:43:47 +0900
Received: from mulinux.home (unknown [10.226.93.1])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2149140F4527;
        Wed, 14 Dec 2022 07:43:41 +0900 (JST)
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
Subject: [PATCH 5/5] power: reset: Add new driver for RZ/V2M PWC poweroff
Date:   Tue, 13 Dec 2022 22:43:10 +0000
Message-Id: <20221213224310.543243-6-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RZ/V2M PWC IP controls external power supplies and therefore
can turn the power supplies off when powering down the system.

PWC is essentially a Multi-Function Device (MFD), and this driver
relies on syscon and simple-mfd to integrate within the larger
scheme of things.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/power/reset/Kconfig              | 10 +++
 drivers/power/reset/Makefile             |  1 +
 drivers/power/reset/rzv2m-pwc-poweroff.c | 81 ++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 drivers/power/reset/rzv2m-pwc-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a8c46ba5878f..9f7c9ed1a36e 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -303,4 +303,14 @@ config POWER_MLXBF
 	help
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
+config POWER_RESET_RZV2M_PWC
+	tristate "Renesas RZ/V2M PWC Power OFF"
+	depends on MFD_SYSCON
+	depends on ARCH_R9A09G011 || COMPILE_TEST
+	help
+	  The RZ/V2M PWC IP controls external power supplies and therefore can
+	  turn the power supplies off when powering down the system.
+	  Enable this driver when PWC is in control of the system power supplies
+	  and it's the preferred way to shutdown the system.
+
 endif
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0a39424fc558..f05a8abff2eb 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
+obj-$(CONFIG_POWER_RESET_RZV2M_PWC) += rzv2m-pwc-poweroff.o
diff --git a/drivers/power/reset/rzv2m-pwc-poweroff.c b/drivers/power/reset/rzv2m-pwc-poweroff.c
new file mode 100644
index 000000000000..e9bd16e65b6a
--- /dev/null
+++ b/drivers/power/reset/rzv2m-pwc-poweroff.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ *
+ * Reset driver for Renesas RZ/V2M External Power Sequence Controller (PWC)
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+
+#define PWC_PWCRST			0x00
+#define PWC_PWCCKEN			0x04
+#define PWC_PWCCTL			0x50
+
+#define PWC_PWCRST_RSTSOFTAX		0x1
+#define PWC_PWCCKEN_ENGCKMAIN		0x1
+#define PWC_PWCCTL_PWOFF		0x1
+
+struct rzv2m_pwc_poweroff_priv {
+	struct regmap *regmap;
+	struct device *dev;
+};
+
+static int rzv2m_pwc_poweroff(struct sys_off_data *data)
+{
+	struct rzv2m_pwc_poweroff_priv *priv =
+		(struct rzv2m_pwc_poweroff_priv *)data->cb_data;
+
+	regmap_write(priv->regmap, PWC_PWCRST, PWC_PWCRST_RSTSOFTAX);
+	regmap_write(priv->regmap, PWC_PWCCKEN, PWC_PWCCKEN_ENGCKMAIN);
+	regmap_write(priv->regmap, PWC_PWCCTL, PWC_PWCCTL_PWOFF);
+
+	mdelay(150);
+
+	dev_err(priv->dev, "Failed to power off the system");
+
+	return NOTIFY_DONE;
+}
+
+static int rzv2m_pwc_poweroff_probe(struct platform_device *pdev)
+{
+	struct rzv2m_pwc_poweroff_priv *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+						       "regmap");
+
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->regmap),
+				     "Can't find regmap property");
+
+	priv->dev = &pdev->dev;
+
+	return devm_register_power_off_handler(&pdev->dev, rzv2m_pwc_poweroff,
+					       priv);
+}
+
+static const struct of_device_id rzv2m_pwc_poweroff_of_match[] = {
+	{ .compatible = "renesas,rzv2m-pwc-poweroff" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzv2m_pwc_poweroff_of_match);
+
+static struct platform_driver rzv2m_pwc_poweroff_driver = {
+	.probe = rzv2m_pwc_poweroff_probe,
+	.driver = {
+		.name = "rzv2m_pwc_poweroff",
+		.of_match_table = of_match_ptr(rzv2m_pwc_poweroff_of_match),
+	},
+};
+module_platform_driver(rzv2m_pwc_poweroff_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Fabrizio Castro <castro.fabrizio.jz@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2M PWC power OFF driver");
-- 
2.34.1

