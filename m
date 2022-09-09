Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFEB5B37EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiIIMcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiIIMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:32:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A807C11779E;
        Fri,  9 Sep 2022 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662726721; x=1694262721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZelFCOozMZ04HIL0HnLE7UPW8i4M2uEzSe0mhE5piAs=;
  b=dLbOn2+dn7IgEKopzAEEVQgBZg9F5iTqCOj5h/3Sua7ptZ0xQomvoC+J
   C6wjVmIVWiUHkiB7xl0wtsbbp+6nTYye6ol7TDJctbpXzyfpfU7vtqRkR
   4F8EWQHT2bBfe1hzHaVrCgvcXNNIjb0wNfMJIXanAkjPVEN0/FTWtCmFe
   yGKIiwcjTbI5isqkJdAckRyxsa7A8F55DI5J3PYrD+OBpT6SjSBtunNO+
   nUSXguqa+zk086XiuGntysFpKmoxZ3ubN3KZCZ7iB1ndygEmh9N1qliIS
   tmXeOAq10PkDod/HVcrBuXt55didvFkNK1vgCA13U1axbaVG9rMe4sQO8
   A==;
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="190137476"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2022 05:32:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 9 Sep 2022 05:32:00 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 9 Sep 2022 05:31:57 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Subject: [PATCH v5 05/14] reset: add polarfire soc reset support
Date:   Fri, 9 Sep 2022 13:31:14 +0100
Message-ID: <20220909123123.2699583-6-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220909123123.2699583-1-conor.dooley@microchip.com>
References: <20220909123123.2699583-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the resets on Microchip's PolarFire SoC (MPFS).
Reset control is a single register, wedged in between registers for
clock control. To fit with existed DT etc, the reset controller is
created using the aux device framework & set up in the clock driver.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/reset/Kconfig      |   7 ++
 drivers/reset/Makefile     |   2 +-
 drivers/reset/reset-mpfs.c | 157 +++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 drivers/reset/reset-mpfs.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 806773e88832..85f7abde3766 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -152,6 +152,13 @@ config RESET_PISTACHIO
 	help
 	  This enables the reset driver for ImgTec Pistachio SoCs.
 
+config RESET_POLARFIRE_SOC
+	bool "Microchip PolarFire SoC (MPFS) Reset Driver"
+	depends on AUXILIARY_BUS && MCHP_CLK_MPFS
+	default MCHP_CLK_MPFS
+	help
+	  This driver supports peripheral reset for the Microchip PolarFire SoC
+
 config RESET_QCOM_AOSS
 	tristate "Qcom AOSS Reset Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index cd5cf8e7c6a7..3e7e5fd633a8 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
+obj-$(CONFIG_RESET_POLARFIRE_SOC) += reset-mpfs.o
 obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
 obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
 obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
@@ -40,4 +41,3 @@ obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
-
diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
new file mode 100644
index 000000000000..e003e50590ec
--- /dev/null
+++ b/drivers/reset/reset-mpfs.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PolarFire SoC (MPFS) Peripheral Clock Reset Controller
+ *
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries.
+ *
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <dt-bindings/clock/microchip,mpfs-clock.h>
+#include <soc/microchip/mpfs.h>
+
+/*
+ * The ENVM reset is the lowest bit in the register & I am using the CLK_FOO
+ * defines in the dt to make things easier to configure - so this is accounting
+ * for the offset of 3 there.
+ */
+#define MPFS_PERIPH_OFFSET	CLK_ENVM
+#define MPFS_NUM_RESETS		30u
+#define MPFS_SLEEP_MIN_US	100
+#define MPFS_SLEEP_MAX_US	200
+
+/* block concurrent access to the soft reset register */
+static DEFINE_SPINLOCK(mpfs_reset_lock);
+
+/*
+ * Peripheral clock resets
+ */
+
+static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&mpfs_reset_lock, flags);
+
+	reg = mpfs_reset_read(rcdev->dev);
+	reg |= BIT(id);
+	mpfs_reset_write(rcdev->dev, reg);
+
+	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
+
+	return 0;
+}
+
+static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&mpfs_reset_lock, flags);
+
+	reg = mpfs_reset_read(rcdev->dev);
+	reg &= ~BIT(id);
+	mpfs_reset_write(rcdev->dev, reg);
+
+	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
+
+	return 0;
+}
+
+static int mpfs_status(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	u32 reg = mpfs_reset_read(rcdev->dev);
+
+	/*
+	 * It is safe to return here as MPFS_NUM_RESETS makes sure the sign bit
+	 * is never hit.
+	 */
+	return (reg & BIT(id));
+}
+
+static int mpfs_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	mpfs_assert(rcdev, id);
+
+	usleep_range(MPFS_SLEEP_MIN_US, MPFS_SLEEP_MAX_US);
+
+	mpfs_deassert(rcdev, id);
+
+	return 0;
+}
+
+static const struct reset_control_ops mpfs_reset_ops = {
+	.reset = mpfs_reset,
+	.assert = mpfs_assert,
+	.deassert = mpfs_deassert,
+	.status = mpfs_status,
+};
+
+static int mpfs_reset_xlate(struct reset_controller_dev *rcdev,
+			    const struct of_phandle_args *reset_spec)
+{
+	unsigned int index = reset_spec->args[0];
+
+	/*
+	 * CLK_RESERVED does not map to a clock, but it does map to a reset,
+	 * so it has to be accounted for here. It is the reset for the fabric,
+	 * so if this reset gets called - do not reset it.
+	 */
+	if (index == CLK_RESERVED) {
+		dev_err(rcdev->dev, "Resetting the fabric is not supported\n");
+		return -EINVAL;
+	}
+
+	if (index < MPFS_PERIPH_OFFSET || index >= (MPFS_PERIPH_OFFSET + rcdev->nr_resets)) {
+		dev_err(rcdev->dev, "Invalid reset index %u\n", index);
+		return -EINVAL;
+	}
+
+	return index - MPFS_PERIPH_OFFSET;
+}
+
+static int mpfs_reset_probe(struct auxiliary_device *adev,
+			    const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct reset_controller_dev *rcdev;
+
+	rcdev = devm_kzalloc(dev, sizeof(*rcdev), GFP_KERNEL);
+	if (!rcdev)
+		return -ENOMEM;
+
+	rcdev->dev = dev;
+	rcdev->dev->parent = dev->parent;
+	rcdev->ops = &mpfs_reset_ops;
+	rcdev->of_node = dev->parent->of_node;
+	rcdev->of_reset_n_cells = 1;
+	rcdev->of_xlate = mpfs_reset_xlate;
+	rcdev->nr_resets = MPFS_NUM_RESETS;
+
+	return devm_reset_controller_register(dev, rcdev);
+}
+
+static const struct auxiliary_device_id mpfs_reset_ids[] = {
+	{
+		.name = "clk_mpfs.reset-mpfs",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, mpfs_reset_ids);
+
+static struct auxiliary_driver mpfs_reset_driver = {
+	.probe		= mpfs_reset_probe,
+	.id_table	= mpfs_reset_ids,
+};
+
+module_auxiliary_driver(mpfs_reset_driver);
+
+MODULE_DESCRIPTION("Microchip PolarFire SoC Reset Driver");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(MCHP_CLK_MPFS);
-- 
2.36.1

