Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F7B700812
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbjELMaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbjELM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:29:55 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D6B1386E;
        Fri, 12 May 2023 05:29:18 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CCOUor001858;
        Fri, 12 May 2023 07:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=raLUE1r/+MZGwXGgjOqNmbbdT+5cBvFrw6NX5OKkxec=;
 b=GAo9EEBgVMuDcQMfR9hMzLBMQjN+GFpSUSGskbztVtCyd3fnJap6sDBvqBf3hdYPikY5
 bwsXrWuLFR9//1s6en4g7tmANEEWx8WanpafL11YG42PkOlzTL2lBrn1UVOGRNhVQ3dt
 C2wkvYjJTm+N6fGKcvUNUr6oaGmaoDFh+P6RNaqUZ895MwdDOp2O4T5yrxnI0e+NycWs
 sqrw+9+iK9R/AGA13qLzmVfKyFOJ14SuVKYAPdnM97Gz+EOheM+3L7hm0G2nE8MlBTK+
 POtKQCITXev37Cb8dKt+FkprdiGBoV8oI/iNeNgQWutaLJ+hM3KheOTLhjRpkvnowAnb Hw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7nb5dqx-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 07:28:43 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 12 May
 2023 07:28:38 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 07:28:38 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DC3E845;
        Fri, 12 May 2023 12:28:38 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>
CC:     <lgirdwood@gmail.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/10] irqchip/cs42l43: Add support for the cs42l43 IRQs
Date:   Fri, 12 May 2023 13:28:35 +0100
Message-ID: <20230512122838.243002-8-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Eor36xOpC61mpC-Gp0R8Hdn4XbpTUO8w
X-Proofpoint-GUID: Eor36xOpC61mpC-Gp0R8Hdn4XbpTUO8w
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
(Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
for portable applications. It provides a high dynamic range, stereo
DAC for headphone output, two integrated Class D amplifiers for
loudspeakers, and two ADCs for wired headset microphone input or
stereo line input. PDM inputs are provided for digital microphones.

The IRQ chip provides IRQ functionality both to other parts of the
cs42l43 device and to external devices that wish to use its IRQs.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 MAINTAINERS                     |   2 +
 drivers/irqchip/Kconfig         |   9 ++
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-cs42l43.c   | 170 ++++++++++++++++++++++++++++++++
 include/linux/irqchip/cs42l43.h |  61 ++++++++++++
 5 files changed, 243 insertions(+)
 create mode 100644 drivers/irqchip/irq-cs42l43.c
 create mode 100644 include/linux/irqchip/cs42l43.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d2076941ff36..13945ee6cdcfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4928,8 +4928,10 @@ L:	patches@opensource.cirrus.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/cirrus,cs*
 F:	Documentation/devicetree/bindings/sound/cirrus,cs*
+F:	drivers/irqchip/irq-cs42l43*
 F:	drivers/mfd/cs42l43*
 F:	include/dt-bindings/sound/cs*
+F:	include/linux/irqchip/cs42l43*
 F:	include/linux/mfd/cs42l43*
 F:	include/sound/cs*
 F:	sound/pci/hda/cs*
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 09e422da482ff..05f58015749e3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -138,6 +138,15 @@ config BRCMSTB_L2_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config IRQ_CS42L43
+	tristate "Cirrus Logic CS42L43 IRQ Controller"
+	depends on MFD_CS42L43
+	select REGMAP_IRQ
+	help
+	  Select this to support the IRQ functions of the Cirrus Logic
+	  CS42L43 PC CODEC, note the IRQs are required for most other
+	  functions of the device.
+
 config DAVINCI_CP_INTC
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ffd945fe71aa2..d00330c1b0b95 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_BCM6345_L1_IRQ)		+= irq-bcm6345-l1.o
 obj-$(CONFIG_BCM7038_L1_IRQ)		+= irq-bcm7038-l1.o
 obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
 obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
+obj-$(CONFIG_IRQ_CS42L43)		+= irq-cs42l43.o
 obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o irq-mtk-cirq.o
diff --git a/drivers/irqchip/irq-cs42l43.c b/drivers/irqchip/irq-cs42l43.c
new file mode 100644
index 0000000000000..fc55cbdc08647
--- /dev/null
+++ b/drivers/irqchip/irq-cs42l43.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// CS42L43 IRQ driver
+//
+// Copyright (C) 2022-2023 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/cs42l43.h>
+#include <linux/mfd/cs42l43.h>
+#include <linux/mfd/cs42l43-regs.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#define CS42L43_IRQ_OFFSET(reg) ((CS42L43_##reg##_INT) - CS42L43_DECIM_INT)
+
+#define CS42L43_IRQ_REG(name, reg) REGMAP_IRQ_REG(CS42L43_##name, \
+						  CS42L43_IRQ_OFFSET(reg), \
+						  CS42L43_##name##_INT_MASK)
+
+static const struct regmap_irq cs42l43_regmap_irqs[] = {
+	CS42L43_IRQ_REG(PLL_LOST_LOCK,				PLL),
+	CS42L43_IRQ_REG(PLL_READY,				PLL),
+
+	CS42L43_IRQ_REG(HP_STARTUP_DONE,			MSM),
+	CS42L43_IRQ_REG(HP_SHUTDOWN_DONE,			MSM),
+	CS42L43_IRQ_REG(HSDET_DONE,				MSM),
+	CS42L43_IRQ_REG(TIPSENSE_UNPLUG_DB,			MSM),
+	CS42L43_IRQ_REG(TIPSENSE_PLUG_DB,			MSM),
+	CS42L43_IRQ_REG(RINGSENSE_UNPLUG_DB,			MSM),
+	CS42L43_IRQ_REG(RINGSENSE_PLUG_DB,			MSM),
+	CS42L43_IRQ_REG(TIPSENSE_UNPLUG_PDET,			MSM),
+	CS42L43_IRQ_REG(TIPSENSE_PLUG_PDET,			MSM),
+	CS42L43_IRQ_REG(RINGSENSE_UNPLUG_PDET,			MSM),
+	CS42L43_IRQ_REG(RINGSENSE_PLUG_PDET,			MSM),
+
+	CS42L43_IRQ_REG(HS2_BIAS_SENSE,				ACC_DET),
+	CS42L43_IRQ_REG(HS1_BIAS_SENSE,				ACC_DET),
+	CS42L43_IRQ_REG(DC_DETECT1_FALSE,			ACC_DET),
+	CS42L43_IRQ_REG(DC_DETECT1_TRUE,			ACC_DET),
+	CS42L43_IRQ_REG(HSBIAS_CLAMPED,				ACC_DET),
+	CS42L43_IRQ_REG(HS3_4_BIAS_SENSE,			ACC_DET),
+
+	CS42L43_IRQ_REG(AMP2_CLK_STOP_FAULT,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP1_CLK_STOP_FAULT,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP2_VDDSPK_FAULT,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP1_VDDSPK_FAULT,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP2_SHUTDOWN_DONE,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP1_SHUTDOWN_DONE,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP2_STARTUP_DONE,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP1_STARTUP_DONE,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP2_THERM_SHDN,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP1_THERM_SHDN,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP2_THERM_WARN,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP1_THERM_WARN,			CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP2_SCDET,				CLASS_D_AMP),
+	CS42L43_IRQ_REG(AMP1_SCDET,				CLASS_D_AMP),
+
+	CS42L43_IRQ_REG(GPIO3_FALL,				GPIO),
+	CS42L43_IRQ_REG(GPIO3_RISE,				GPIO),
+	CS42L43_IRQ_REG(GPIO2_FALL,				GPIO),
+	CS42L43_IRQ_REG(GPIO2_RISE,				GPIO),
+	CS42L43_IRQ_REG(GPIO1_FALL,				GPIO),
+	CS42L43_IRQ_REG(GPIO1_RISE,				GPIO),
+
+	CS42L43_IRQ_REG(HP_ILIMIT,				HPOUT),
+	CS42L43_IRQ_REG(HP_LOADDET_DONE,			HPOUT),
+};
+
+static const struct regmap_irq_chip cs42l43_irq_chip = {
+	.name = "cs42l43",
+
+	.status_base = CS42L43_DECIM_INT,
+	.mask_base = CS42L43_DECIM_MASK,
+	.num_regs = 16,
+
+	.irqs = cs42l43_regmap_irqs,
+	.num_irqs = ARRAY_SIZE(cs42l43_regmap_irqs),
+
+	.runtime_pm = true,
+};
+
+struct cs42l43_irq {
+	struct device *dev;
+
+	struct regmap_irq_chip irq_chip;
+	struct regmap_irq_chip_data *irq_data;
+};
+
+static int cs42l43_irq_probe(struct platform_device *pdev)
+{
+	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
+	struct cs42l43_irq *priv;
+	struct irq_data *irq_data;
+	unsigned long irq_flags;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	priv->irq_chip = cs42l43_irq_chip;
+	priv->irq_chip.irq_drv_data = priv;
+
+	irq_data = irq_get_irq_data(cs42l43->irq);
+	if (!irq_data) {
+		dev_err(priv->dev, "Invalid IRQ: %d\n", cs42l43->irq);
+		return -EINVAL;
+	}
+
+	irq_flags = irqd_get_trigger_type(irq_data);
+	switch (irq_flags) {
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_HIGH:
+	case IRQF_TRIGGER_RISING:
+	case IRQF_TRIGGER_FALLING:
+		break;
+	case IRQ_TYPE_NONE:
+	default:
+		irq_flags = IRQF_TRIGGER_LOW;
+		break;
+	}
+
+	irq_flags |= IRQF_ONESHOT;
+
+	pm_runtime_enable(priv->dev);
+	pm_runtime_idle(priv->dev);
+
+	ret = devm_regmap_add_irq_chip(priv->dev, cs42l43->regmap,
+				       cs42l43->irq, irq_flags, 0,
+				       &priv->irq_chip, &priv->irq_data);
+	if (ret) {
+		dev_err(priv->dev, "Failed to add IRQ chip: %d\n", ret);
+		pm_runtime_disable(priv->dev);
+		return ret;
+	}
+
+	dev_dbg(priv->dev, "Configured IRQ %d with flags 0x%lx\n",
+		cs42l43->irq, irq_flags);
+
+	return 0;
+}
+
+static int cs42l43_irq_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver cs42l43_irq_driver = {
+	.driver = {
+		.name	= "cs42l43-irq",
+	},
+
+	.probe		= cs42l43_irq_probe,
+	.remove		= cs42l43_irq_remove,
+};
+module_platform_driver(cs42l43_irq_driver);
+
+MODULE_DESCRIPTION("CS42L43 IRQ Driver");
+MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cs42l43-irq");
diff --git a/include/linux/irqchip/cs42l43.h b/include/linux/irqchip/cs42l43.h
new file mode 100644
index 0000000000000..99ce0dbc96a77
--- /dev/null
+++ b/include/linux/irqchip/cs42l43.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CS42L43 IRQ driver external data
+ *
+ * Copyright (C) 2022-2023 Cirrus Logic, Inc. and
+ *                         Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef CS42L43_IRQ_EXT_H
+#define CS42L43_IRQ_EXT_H
+
+enum cs42l43_irq_numbers {
+	CS42L43_PLL_LOST_LOCK,
+	CS42L43_PLL_READY,
+
+	CS42L43_HP_STARTUP_DONE,
+	CS42L43_HP_SHUTDOWN_DONE,
+	CS42L43_HSDET_DONE,
+	CS42L43_TIPSENSE_UNPLUG_DB,
+	CS42L43_TIPSENSE_PLUG_DB,
+	CS42L43_RINGSENSE_UNPLUG_DB,
+	CS42L43_RINGSENSE_PLUG_DB,
+	CS42L43_TIPSENSE_UNPLUG_PDET,
+	CS42L43_TIPSENSE_PLUG_PDET,
+	CS42L43_RINGSENSE_UNPLUG_PDET,
+	CS42L43_RINGSENSE_PLUG_PDET,
+
+	CS42L43_HS2_BIAS_SENSE,
+	CS42L43_HS1_BIAS_SENSE,
+	CS42L43_DC_DETECT1_FALSE,
+	CS42L43_DC_DETECT1_TRUE,
+	CS42L43_HSBIAS_CLAMPED,
+	CS42L43_HS3_4_BIAS_SENSE,
+
+	CS42L43_AMP2_CLK_STOP_FAULT,
+	CS42L43_AMP1_CLK_STOP_FAULT,
+	CS42L43_AMP2_VDDSPK_FAULT,
+	CS42L43_AMP1_VDDSPK_FAULT,
+	CS42L43_AMP2_SHUTDOWN_DONE,
+	CS42L43_AMP1_SHUTDOWN_DONE,
+	CS42L43_AMP2_STARTUP_DONE,
+	CS42L43_AMP1_STARTUP_DONE,
+	CS42L43_AMP2_THERM_SHDN,
+	CS42L43_AMP1_THERM_SHDN,
+	CS42L43_AMP2_THERM_WARN,
+	CS42L43_AMP1_THERM_WARN,
+	CS42L43_AMP2_SCDET,
+	CS42L43_AMP1_SCDET,
+
+	CS42L43_GPIO3_FALL,
+	CS42L43_GPIO3_RISE,
+	CS42L43_GPIO2_FALL,
+	CS42L43_GPIO2_RISE,
+	CS42L43_GPIO1_FALL,
+	CS42L43_GPIO1_RISE,
+
+	CS42L43_HP_ILIMIT,
+	CS42L43_HP_LOADDET_DONE,
+};
+
+#endif /* CS42L43_IRQ_EXT_H */
-- 
2.30.2

