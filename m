Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69902653818
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiLUVKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiLUVKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:10:07 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8B8E27B00;
        Wed, 21 Dec 2022 13:09:57 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,263,1665414000"; 
   d="scan'208";a="146995973"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Dec 2022 06:09:56 +0900
Received: from mulinux.example.org (unknown [10.226.92.211])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3E65F40DC546;
        Thu, 22 Dec 2022 06:09:50 +0900 (JST)
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
Subject: [PATCH v2 4/4] power: reset: Add new driver for RZ/V2M PWC poweroff
Date:   Wed, 21 Dec 2022 21:09:17 +0000
Message-Id: <20221221210917.458537-5-fabrizio.castro.jz@renesas.com>
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

The RZ/V2M PWC IP controls external power supplies and therefore
can turn the power supplies off when powering down the system.

Add driver to poweroff the system.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---

v1->v2: Dropped OF match table and syscon as a result of the change in
        DT model

 drivers/power/reset/Kconfig              |  9 ++++
 drivers/power/reset/Makefile             |  1 +
 drivers/power/reset/rzv2m-pwc-poweroff.c | 67 ++++++++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 drivers/power/reset/rzv2m-pwc-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a8c46ba5878f..1fcf691ae68e 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -303,4 +303,13 @@ config POWER_MLXBF
 	help
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
+config POWER_RESET_RZV2M_PWC
+	tristate "Renesas RZ/V2M PWC Power OFF support"
+	depends on MFD_RZV2M_PWC_CORE || COMPILE_TEST
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
index 000000000000..f5bc383c22e1
--- /dev/null
+++ b/drivers/power/reset/rzv2m-pwc-poweroff.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ *
+ * Reset driver for Renesas RZ/V2M External Power Sequence Controller (PWC)
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include "../../mfd/rzv2m-pwc.h"
+
+#define PWC_PWCRST_RSTSOFTAX		0x1
+#define PWC_PWCCKEN_ENGCKMAIN		0x1
+#define PWC_PWCCTL_PWOFF		0x1
+
+struct rzv2m_pwc_poweroff_priv {
+	void __iomem *base;
+	struct device *dev;
+};
+
+static int rzv2m_pwc_poweroff(struct sys_off_data *data)
+{
+	struct rzv2m_pwc_poweroff_priv *priv =
+		(struct rzv2m_pwc_poweroff_priv *)data->cb_data;
+
+	writel(PWC_PWCRST_RSTSOFTAX, priv->base + PWC_PWCRST);
+	writel(PWC_PWCCKEN_ENGCKMAIN, priv->base + PWC_PWCCKEN);
+	writel(PWC_PWCCTL_PWOFF, priv->base + PWC_PWCCTL);
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
+	struct rzv2m_pwc_priv *pdata = dev_get_drvdata(pdev->dev.parent);
+	struct rzv2m_pwc_poweroff_priv *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = pdata->base;
+	priv->dev = &pdev->dev;
+
+	return devm_register_power_off_handler(&pdev->dev, rzv2m_pwc_poweroff,
+					       priv);
+}
+
+static struct platform_driver rzv2m_pwc_poweroff_driver = {
+	.probe = rzv2m_pwc_poweroff_probe,
+	.driver = {
+		.name = "rzv2m_pwc_poweroff",
+	},
+};
+module_platform_driver(rzv2m_pwc_poweroff_driver);
+
+MODULE_ALIAS("platform:rzv2m_pwc_poweroff");
+MODULE_SOFTDEP("pre: rzv2m_pwc");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Fabrizio Castro <castro.fabrizio.jz@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2M PWC power OFF driver");
-- 
2.34.1

