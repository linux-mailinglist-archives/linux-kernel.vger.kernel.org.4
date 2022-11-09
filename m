Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE11C6230B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiKIQzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiKIQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:55:04 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50108275FE;
        Wed,  9 Nov 2022 08:53:58 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EDNjZ027347;
        Wed, 9 Nov 2022 10:53:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=L7wlWbL5uEHVlUgGNogFf74St6uXnoRWkEOZtPEuo60=;
 b=aj0ow1uYt9Lpd/pLYXEvpFrna+L0my93R33bJf1qPa12TQXgD2WmIEjhwB7zXONN120E
 vGgp5PwlcemZca4Qu2aEhfX4ytYhKo/roLc3GxQRuK8jU+w5mCjWX2BipEVLrNEcJIXm
 WBr0Acn39CWeWMDeLvFQ1ZDfkhVGXQSjyi/v++0c1YnvR0kM2MK9QME+eyXzmZOQ4ePJ
 P9kP/x1V3lFSGyrw8YQ9I3hb5D28+Z48txkFCjmSm0WHBN6I/0UIT1UHsQcQknVoENk3
 DyTcyrUGTJFkcDp1paxsbl64hay3byId5wIQj+sI9pbbjf6QZEqWiCvMCoumoFIqqM2i 5w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pde7v-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:53:40 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 9 Nov
 2022 10:53:37 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Wed, 9 Nov 2022 10:53:37 -0600
Received: from debianA11184.ad.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A0103478;
        Wed,  9 Nov 2022 16:53:36 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 09/12] irqchip: cirrus: Add driver for Cirrus Logic CS48L31/32/33 codecs
Date:   Wed, 9 Nov 2022 16:53:28 +0000
Message-ID: <20221109165331.29332-10-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109165331.29332-1-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: P9X1g0Q0gFoCRfeVf1Z6ZXct2yQIe8Zd
X-Proofpoint-GUID: P9X1g0Q0gFoCRfeVf1Z6ZXct2yQIe8Zd
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cirrus Logic CS48L31/32/33 audio codecs contain a programmable
interrupt controller with a variety of interrupt sources, including
GPIOs that can be used as interrupt inputs.

This driver provides the handling for the interrupt controller. As the
codec is accessed via regmap, the generic regmap_irq functionality
is used to do most of the work.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS                                |   2 +
 drivers/irqchip/Kconfig                    |   3 +
 drivers/irqchip/Makefile                   |   1 +
 drivers/irqchip/irq-cirrus-cs48l32.c       | 281 +++++++++++++++++++++
 drivers/irqchip/irq-cirrus-cs48l32.h       |  74 ++++++
 include/linux/irqchip/irq-cirrus-cs48l32.h | 101 ++++++++
 6 files changed, 462 insertions(+)
 create mode 100644 drivers/irqchip/irq-cirrus-cs48l32.c
 create mode 100644 drivers/irqchip/irq-cirrus-cs48l32.h
 create mode 100644 include/linux/irqchip/irq-cirrus-cs48l32.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cd1773d39dd8..f52e9a6e290c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5015,12 +5015,14 @@ F:	Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
 F:	Documentation/devicetree/bindings/sound/cirrus,madera.yaml
 F:	drivers/gpio/gpio-madera*
+F:	drivers/irqchip/irq-cirrus-cs48l32*
 F:	drivers/irqchip/irq-madera*
 F:	drivers/mfd/cs47l*
 F:	drivers/mfd/cs48l*
 F:	drivers/mfd/madera*
 F:	drivers/pinctrl/cirrus/*
 F:	include/dt-bindings/sound/madera*
+F:	include/linux/irqchip/irq-cirrus-cs48l32*
 F:	include/linux/irqchip/irq-madera*
 F:	include/linux/mfd/cs48l32/*
 F:	include/linux/mfd/madera/*
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..d4521158849c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -136,6 +136,9 @@ config BRCMSTB_L2_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config CIRRUS_CS48L32_IRQ
+	tristate
+
 config DAVINCI_AINTC
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 87b49a10962c..049796365232 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -121,3 +121,4 @@ obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
+obj-$(CONFIG_CIRRUS_CS48L32_IRQ)	+= irq-cirrus-cs48l32.o
diff --git a/drivers/irqchip/irq-cirrus-cs48l32.c b/drivers/irqchip/irq-cirrus-cs48l32.c
new file mode 100644
index 000000000000..3ca9f34a6289
--- /dev/null
+++ b/drivers/irqchip/irq-cirrus-cs48l32.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Interrupt support for Cirrus Logic CS48L32 audio codec
+//
+// Copyright (C) 2020, 2022 Cirrus Logic, Inc. and
+//               Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/irq-cirrus-cs48l32.h>
+#include <linux/irqdomain.h>
+#include <linux/mfd/cs48l32/core.h>
+#include <linux/mfd/cs48l32/registers.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "irq-cirrus-cs48l32.h"
+
+#define CS48L32_IRQ(_irq, _reg)					\
+	[CS48L32_IRQ_ ## _irq] = {				\
+		.reg_offset = (_reg) - CS48L32_IRQ1_EINT_1,	\
+		.mask = CS48L32_ ## _irq ## _EINT1_MASK		\
+	}
+
+static const struct regmap_irq cs48l32_irqs[] = {
+	CS48L32_IRQ(DSP1_IRQ0,		 CS48L32_IRQ1_EINT_9),
+	CS48L32_IRQ(DSP1_IRQ1,		 CS48L32_IRQ1_EINT_9),
+	CS48L32_IRQ(DSP1_IRQ2,		 CS48L32_IRQ1_EINT_9),
+	CS48L32_IRQ(DSP1_IRQ3,		 CS48L32_IRQ1_EINT_9),
+
+	CS48L32_IRQ(US1_ACT_DET_RISE,	 CS48L32_IRQ1_EINT_5),
+	CS48L32_IRQ(US1_ACT_DET_FALL,	 CS48L32_IRQ1_EINT_5),
+	CS48L32_IRQ(US2_ACT_DET_RISE,	 CS48L32_IRQ1_EINT_5),
+	CS48L32_IRQ(US2_ACT_DET_FALL,	 CS48L32_IRQ1_EINT_5),
+
+	CS48L32_IRQ(INPUTS_SIG_DET_RISE, CS48L32_IRQ1_EINT_5),
+	CS48L32_IRQ(INPUTS_SIG_DET_FALL, CS48L32_IRQ1_EINT_5),
+
+	CS48L32_IRQ(GPIO1_RISE,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO1_FALL,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO2_RISE,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO2_FALL,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO3_RISE,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO3_FALL,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO4_RISE,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO4_FALL,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO5_RISE,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO5_FALL,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO6_RISE,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO6_FALL,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO7_RISE,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO7_FALL,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO8_RISE,		 CS48L32_IRQ1_EINT_11),
+	CS48L32_IRQ(GPIO8_FALL,		 CS48L32_IRQ1_EINT_11),
+
+	CS48L32_IRQ(DRC1_SIG_DET_RISE,	 CS48L32_IRQ1_EINT_5),
+	CS48L32_IRQ(DRC1_SIG_DET_FALL,	 CS48L32_IRQ1_EINT_5),
+	CS48L32_IRQ(DRC2_SIG_DET_RISE,	 CS48L32_IRQ1_EINT_5),
+	CS48L32_IRQ(DRC2_SIG_DET_FALL,	 CS48L32_IRQ1_EINT_5),
+
+	CS48L32_IRQ(FLL1_LOCK_RISE,	 CS48L32_IRQ1_EINT_6),
+	CS48L32_IRQ(FLL1_LOCK_FALL,	 CS48L32_IRQ1_EINT_6),
+	CS48L32_IRQ(FLL1_REF_LOST,	 CS48L32_IRQ1_EINT_6),
+
+	CS48L32_IRQ(SYSCLK_FAIL,	 CS48L32_IRQ1_EINT_1),
+	CS48L32_IRQ(CTRLIF_ERR,		 CS48L32_IRQ1_EINT_1),
+	CS48L32_IRQ(SYSCLK_ERR,		 CS48L32_IRQ1_EINT_1),
+	CS48L32_IRQ(DSPCLK_ERR,		 CS48L32_IRQ1_EINT_1),
+
+	CS48L32_IRQ(DSP1_NMI_ERR,	 CS48L32_IRQ1_EINT_7),
+	CS48L32_IRQ(DSP1_WDT_EXPIRE,	 CS48L32_IRQ1_EINT_7),
+	CS48L32_IRQ(DSP1_MPU_ERR,	 CS48L32_IRQ1_EINT_7),
+
+	CS48L32_IRQ(BOOT_DONE,		 CS48L32_IRQ1_EINT_2),
+};
+
+static const struct regmap_irq_chip cs48l32_irqchip = {
+	.name		= "CS48L32 IRQ",
+	.status_base	= CS48L32_IRQ1_EINT_1,
+	.mask_base	= CS48L32_IRQ1_MASK_1,
+	.ack_base	= CS48L32_IRQ1_EINT_1,
+	.runtime_pm	= true,
+	.num_regs	= 11,
+	.irqs		= cs48l32_irqs,
+	.num_irqs	= ARRAY_SIZE(cs48l32_irqs),
+};
+
+static int __maybe_unused cs48l32_suspend(struct device *dev)
+{
+	struct cs48l32_mfd *mfd = dev_get_drvdata(dev->parent);
+
+	dev_dbg(mfd->irq_dev, "Suspend, disabling IRQ\n");
+
+	/*
+	 * A runtime resume would be needed to access the chip interrupt
+	 * controller but runtime pm doesn't function during suspend.
+	 * Temporarily disable interrupts until we reach suspend_noirq state.
+	 */
+	disable_irq(mfd->irq);
+
+	return 0;
+}
+
+static int __maybe_unused cs48l32_suspend_noirq(struct device *dev)
+{
+	struct cs48l32_mfd *mfd = dev_get_drvdata(dev->parent);
+
+	dev_dbg(mfd->irq_dev, "No IRQ suspend, reenabling IRQ\n");
+
+	/* Re-enable interrupts to service wakeup interrupts from the chip */
+	enable_irq(mfd->irq);
+
+	return 0;
+}
+
+static int __maybe_unused cs48l32_resume_noirq(struct device *dev)
+{
+	struct cs48l32_mfd *mfd = dev_get_drvdata(dev->parent);
+
+	dev_dbg(mfd->irq_dev, "No IRQ resume, disabling IRQ\n");
+
+	/*
+	 * We can't handle interrupts until runtime pm is available again.
+	 * Disable them temporarily.
+	 */
+	disable_irq(mfd->irq);
+
+	return 0;
+}
+
+static int __maybe_unused cs48l32_resume(struct device *dev)
+{
+	struct cs48l32_mfd *mfd = dev_get_drvdata(dev->parent);
+
+	dev_dbg(mfd->irq_dev, "Resume, enabling IRQ\n");
+
+	/* Interrupts can now be handled */
+	enable_irq(mfd->irq);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cs48l32_irq_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cs48l32_suspend, cs48l32_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cs48l32_suspend_noirq, cs48l32_resume_noirq)
+};
+
+static irqreturn_t cs48l32_sysclk_fail(int irq, void *data)
+{
+	struct cs48l32_mfd *mfd = data;
+
+	dev_warn(mfd->dev, "SYSCLK fail\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cs48l32_sysclk_error(int irq, void *data)
+{
+	struct cs48l32_mfd *mfd = data;
+
+	dev_warn(mfd->dev, "SYSCLK error\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cs48l32_ctrlif_error(int irq, void *data)
+{
+	struct cs48l32_mfd *mfd = data;
+
+	dev_warn(mfd->dev, "CTRLIF error\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t cs48l32_boot_done(int irq, void *data)
+{
+	struct cs48l32_mfd *mfd = data;
+
+	dev_dbg(mfd->dev, "BOOT_DONE\n");
+
+	return IRQ_HANDLED;
+}
+
+static int cs48l32_irq_probe(struct platform_device *pdev)
+{
+	struct cs48l32_mfd *mfd = dev_get_drvdata(pdev->dev.parent);
+	struct irq_data *irq_data;
+	unsigned int irq_flags;
+	int ret;
+
+	irq_data = irq_get_irq_data(mfd->irq);
+	if (!irq_data)
+		return dev_err_probe(&pdev->dev, -EINVAL, "Invalid IRQ: %d\n", mfd->irq);
+
+	irq_flags = irqd_get_trigger_type(irq_data);
+
+	/* Codec defaults to trigger low, use this if no flags given */
+	if (irq_flags == IRQ_TYPE_NONE)
+		irq_flags = IRQF_TRIGGER_LOW;
+
+	if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
+		return dev_err_probe(&pdev->dev, -EINVAL, "Host interrupt not level-triggered\n");
+
+	/*
+	 * The silicon always starts at active-low, check if we need to
+	 * switch to active-high.
+	 */
+	if (irq_flags & IRQF_TRIGGER_HIGH)
+		ret = regmap_clear_bits(mfd->regmap, CS48L32_IRQ1_CTRL_AOD,
+					CS48L32_IRQ_POL_MASK);
+	else
+		ret = regmap_set_bits(mfd->regmap, CS48L32_IRQ1_CTRL_AOD,
+				      CS48L32_IRQ_POL_MASK);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to set IRQ polarity\n");
+
+	/*
+	 * NOTE: regmap registers this against the OF node of the parent of
+	 * the regmap - that is, against the mfd driver
+	 */
+	ret = regmap_add_irq_chip(mfd->regmap, mfd->irq, IRQF_ONESHOT, 0,
+				  &cs48l32_irqchip, &mfd->irq_data);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "add_irq_chip failed\n");
+
+	/* Save dev in parent MFD struct so it is accessible to siblings */
+	mfd->irq_dev = &pdev->dev;
+
+	/*
+	 * Log global chip error conditions that aren't specific to
+	 * any particular sibling driver.
+	 */
+	cs48l32_request_irq(mfd, CS48L32_IRQ_SYSCLK_FAIL, "SYSCLK fail",
+			    cs48l32_sysclk_fail, mfd);
+	cs48l32_request_irq(mfd, CS48L32_IRQ_SYSCLK_ERR, "SYSCLK error",
+			    cs48l32_sysclk_error, mfd);
+	cs48l32_request_irq(mfd, CS48L32_IRQ_CTRLIF_ERR, "CTRLIF error",
+			    cs48l32_ctrlif_error, mfd);
+	cs48l32_request_irq(mfd, CS48L32_IRQ_BOOT_DONE, "BOOT_DONE",
+			    cs48l32_boot_done, mfd);
+
+	return 0;
+}
+
+static int cs48l32_irq_remove(struct platform_device *pdev)
+{
+	struct cs48l32_mfd *mfd = dev_get_drvdata(pdev->dev.parent);
+
+	/*
+	 * The IRQ is disabled by the parent MFD driver before
+	 * it starts cleaning up all child drivers
+	 */
+	cs48l32_free_irq(mfd, CS48L32_IRQ_BOOT_DONE, mfd);
+	cs48l32_free_irq(mfd, CS48L32_IRQ_CTRLIF_ERR, mfd);
+	cs48l32_free_irq(mfd, CS48L32_IRQ_SYSCLK_ERR, mfd);
+	cs48l32_free_irq(mfd, CS48L32_IRQ_SYSCLK_FAIL, mfd);
+
+	mfd->irq_dev = NULL;
+	regmap_del_irq_chip(mfd->irq, mfd->irq_data);
+
+	return 0;
+}
+
+static struct platform_driver cs48l32_irq_driver = {
+	.probe = &cs48l32_irq_probe,
+	.remove = &cs48l32_irq_remove,
+	.driver = {
+		.name	= "cs48l32-irq",
+		.pm = &cs48l32_irq_pm_ops,
+	}
+};
+
+module_platform_driver(cs48l32_irq_driver);
+
+MODULE_DESCRIPTION("CS48L32 IRQ driver");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/irqchip/irq-cirrus-cs48l32.h b/drivers/irqchip/irq-cirrus-cs48l32.h
new file mode 100644
index 000000000000..6dae6ddf724d
--- /dev/null
+++ b/drivers/irqchip/irq-cirrus-cs48l32.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Interrupt support for Cirrus Logic CS48L32 audio codec
+ *
+ * Copyright (C) 2020, 2022 Cirrus Logic, Inc. and
+ *               Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef IRQ_CIRRUS_CS48L32_H
+#define IRQ_CIRRUS_CS48L32_H
+
+/* (0x18010) IRQ1_EINT_1 */
+#define CS48L32_DSPCLK_ERR_EINT1_MASK		0x00001000
+#define CS48L32_SYSCLK_ERR_EINT1_MASK		0x00000400
+#define CS48L32_CTRLIF_ERR_EINT1_MASK		0x00000200
+#define CS48L32_SYSCLK_FAIL_EINT1_MASK		0x00000100
+
+/* (0x18014) IRQ1_EINT_2 */
+#define CS48L32_BOOT_DONE_EINT1_MASK		0x00000008
+
+/* (0x18020) IRQ1_EINT_5 */
+#define CS48L32_US2_ACT_DET_FALL_EINT1_MASK	0x02000000
+#define CS48L32_US2_ACT_DET_RISE_EINT1_MASK	0x01000000
+#define CS48L32_US1_ACT_DET_FALL_EINT1_MASK	0x00800000
+#define CS48L32_US1_ACT_DET_RISE_EINT1_MASK	0x00400000
+#define CS48L32_INPUTS_SIG_DET_FALL_EINT1_MASK	0x00200000
+#define CS48L32_INPUTS_SIG_DET_RISE_EINT1_MASK	0x00100000
+#define CS48L32_DRC2_SIG_DET_FALL_EINT1_MASK	0x00080000
+#define CS48L32_DRC2_SIG_DET_RISE_EINT1_MASK	0x00040000
+#define CS48L32_DRC1_SIG_DET_FALL_EINT1_MASK	0x00020000
+#define CS48L32_DRC1_SIG_DET_RISE_EINT1_MASK	0x00010000
+
+/* (0x18024) IRQ1_EINT_6 */
+#define CS48L32_FLL1_REF_LOST_EINT1_MASK	0x00000100
+#define CS48L32_FLL1_LOCK_FALL_EINT1_MASK	0x00000002
+#define CS48L32_FLL1_LOCK_RISE_EINT1_MASK	0x00000001
+
+/* (0x18028) IRQ1_EINT_7 */
+#define CS48L32_DSP1_MPU_ERR_EINT1_MASK		0x00200000
+#define CS48L32_DSP1_WDT_EXPIRE_EINT1_MASK	0x00100000
+#define CS48L32_DSP1_IHB_ERR_EINT1_MASK		0x00080000
+#define CS48L32_DSP1_AHB_SYS_ERR_EINT1_MASK	0x00040000
+#define CS48L32_DSP1_AHB_PACK_ERR_EINT1_MASK	0x00020000
+#define CS48L32_DSP1_NMI_ERR_EINT1_MASK		0x00010000
+
+/* (0x18030) IRQ1_EINT_9 */
+#define CS48L32_MCU_HWERR_IRQ_OUT_EINT1_MASK	0x80000000
+#define CS48L32_DSP1_IRQ3_EINT1_MASK		0x00000008
+#define CS48L32_DSP1_IRQ2_EINT1_MASK		0x00000004
+#define CS48L32_DSP1_IRQ1_EINT1_MASK		0x00000002
+#define CS48L32_DSP1_IRQ0_EINT1_MASK		0x00000001
+
+/* (0x18034) IRQ1_EINT_10 */
+#define CS48L32_CLOCK_DETECT_EINT1_MASK		0x01000000
+
+/* (0x18038) IRQ1_EINT_11 */
+#define CS48L32_GPIO8_FALL_EINT1_MASK		0x80000000
+#define CS48L32_GPIO8_RISE_EINT1_MASK		0x40000000
+#define CS48L32_GPIO7_FALL_EINT1_MASK		0x20000000
+#define CS48L32_GPIO7_RISE_EINT1_MASK		0x10000000
+#define CS48L32_GPIO6_FALL_EINT1_MASK		0x08000000
+#define CS48L32_GPIO6_RISE_EINT1_MASK		0x04000000
+#define CS48L32_GPIO5_FALL_EINT1_MASK		0x02000000
+#define CS48L32_GPIO5_RISE_EINT1_MASK		0x01000000
+#define CS48L32_GPIO4_FALL_EINT1_MASK		0x00800000
+#define CS48L32_GPIO4_RISE_EINT1_MASK		0x00400000
+#define CS48L32_GPIO3_FALL_EINT1_MASK		0x00200000
+#define CS48L32_GPIO3_RISE_EINT1_MASK		0x00100000
+#define CS48L32_GPIO2_FALL_EINT1_MASK		0x00080000
+#define CS48L32_GPIO2_RISE_EINT1_MASK		0x00040000
+#define CS48L32_GPIO1_FALL_EINT1_MASK		0x00020000
+#define CS48L32_GPIO1_RISE_EINT1_MASK		0x00010000
+
+#endif
diff --git a/include/linux/irqchip/irq-cirrus-cs48l32.h b/include/linux/irqchip/irq-cirrus-cs48l32.h
new file mode 100644
index 000000000000..c94d31cef96f
--- /dev/null
+++ b/include/linux/irqchip/irq-cirrus-cs48l32.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Interrupt support for Cirrus Logic CS48L32 audio codec
+ *
+ * Copyright (C) 2017-2020, 2022 Cirrus Logic, Inc. and
+ *               Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef IRQCHIP_CIRRUS_CS48L32_H
+#define IRQCHIP_CIRRUS_CS48L32_H
+
+#include <linux/interrupt.h>
+#include <linux/mfd/cs48l32/core.h>
+
+/* Main interrupts, organized by priority order - highest first */
+#define CS48L32_IRQ_DSP1_IRQ0			0
+#define CS48L32_IRQ_DSP1_IRQ1			1
+#define CS48L32_IRQ_DSP1_IRQ2			2
+#define CS48L32_IRQ_DSP1_IRQ3			3
+#define CS48L32_IRQ_US1_ACT_DET_RISE		4
+#define CS48L32_IRQ_US1_ACT_DET_FALL		5
+#define CS48L32_IRQ_US2_ACT_DET_RISE		6
+#define CS48L32_IRQ_US2_ACT_DET_FALL		7
+#define CS48L32_IRQ_INPUTS_SIG_DET_RISE		8
+#define CS48L32_IRQ_INPUTS_SIG_DET_FALL		9
+#define CS48L32_IRQ_GPIO1_RISE			10
+#define CS48L32_IRQ_GPIO1_FALL			11
+#define CS48L32_IRQ_GPIO2_RISE			12
+#define CS48L32_IRQ_GPIO2_FALL			13
+#define CS48L32_IRQ_GPIO3_RISE			14
+#define CS48L32_IRQ_GPIO3_FALL			15
+#define CS48L32_IRQ_GPIO4_RISE			16
+#define CS48L32_IRQ_GPIO4_FALL			17
+#define CS48L32_IRQ_GPIO5_RISE			18
+#define CS48L32_IRQ_GPIO5_FALL			19
+#define CS48L32_IRQ_GPIO6_RISE			20
+#define CS48L32_IRQ_GPIO6_FALL			21
+#define CS48L32_IRQ_GPIO7_RISE			22
+#define CS48L32_IRQ_GPIO7_FALL			23
+#define CS48L32_IRQ_GPIO8_RISE			24
+#define CS48L32_IRQ_GPIO8_FALL			25
+#define CS48L32_IRQ_DRC1_SIG_DET_RISE		26
+#define CS48L32_IRQ_DRC1_SIG_DET_FALL		27
+#define CS48L32_IRQ_DRC2_SIG_DET_RISE		28
+#define CS48L32_IRQ_DRC2_SIG_DET_FALL		29
+#define CS48L32_IRQ_FLL1_LOCK_RISE		30
+#define CS48L32_IRQ_FLL1_LOCK_FALL		31
+#define CS48L32_IRQ_FLL1_REF_LOST		32
+#define CS48L32_IRQ_SYSCLK_FAIL			33
+#define CS48L32_IRQ_CTRLIF_ERR			34
+#define CS48L32_IRQ_SYSCLK_ERR			35
+#define CS48L32_IRQ_DSPCLK_ERR			36
+#define CS48L32_IRQ_DSP1_NMI_ERR		37
+#define CS48L32_IRQ_DSP1_WDT_EXPIRE		38
+#define CS48L32_IRQ_DSP1_MPU_ERR		39
+#define CS48L32_IRQ_BOOT_DONE			40
+
+struct cs48l32_mfd;
+
+/*
+ * These wrapper functions are for use by other child drivers of the
+ * same parent MFD.
+ */
+static inline int cs48l32_get_irq_mapping(struct cs48l32_mfd *cs48l32, int irq)
+{
+	if (!cs48l32->irq_dev)
+		return -ENODEV;
+
+	return regmap_irq_get_virq(cs48l32->irq_data, irq);
+}
+
+static inline int cs48l32_request_irq(struct cs48l32_mfd *cs48l32, int irq,
+				      const char *name,
+				      irq_handler_t handler, void *data)
+{
+	irq = cs48l32_get_irq_mapping(cs48l32, irq);
+	if (irq < 0)
+		return irq;
+
+	return request_threaded_irq(irq, NULL, handler, IRQF_ONESHOT, name, data);
+}
+
+static inline void cs48l32_free_irq(struct cs48l32_mfd *cs48l32, int irq, void *data)
+{
+	irq = cs48l32_get_irq_mapping(cs48l32, irq);
+	if (irq < 0)
+		return;
+
+	free_irq(irq, data);
+}
+
+static inline int cs48l32_set_irq_wake(struct cs48l32_mfd *cs48l32, int irq, int on)
+{
+	irq = cs48l32_get_irq_mapping(cs48l32, irq);
+	if (irq < 0)
+		return irq;
+
+	return irq_set_irq_wake(irq, on);
+}
+
+#endif
-- 
2.30.2

