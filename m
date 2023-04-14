Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFDB6E20A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjDNKYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjDNKYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:24:20 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86B183D2;
        Fri, 14 Apr 2023 03:24:18 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E9Trub011351;
        Fri, 14 Apr 2023 03:23:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=o3NfsPA1eYPelyWewdGAoP/nTS/DBpUYKLDW2bpX6zI=;
 b=CwmJ21RAHXeURMBjV0BiM8c3i+7BuiyIw1CgLrEmndiiILlNHvkbiv4lL+1Rqm9vq+qr
 zc/E6GSSJ5D4hVOPrn+YAYBLmE/htdqFQwpENgRLqx4RXdwDu4k8Fz8EkLetRC4PvJbJ
 xIsUuC0JRIzjL+l3QHJAbL+HW23L8qwryytvqfSg+RSxt8Yan2r+JEh+cirtiFmOer0x
 hkuWWUwNu5wlu0hWRft63gyGQTfmyzxCDeIJN3Ei5zCEC48cbYpHxG29p5jmZVWIKvLV
 5R4Vbxgzt0gCsxeSGPv5Gyd/STRQsXpdMROksvfZx/gdxY+WScd2D2H2PRTaFAATp1JF hQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3px3fwgcdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 03:23:54 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 14 Apr
 2023 03:23:52 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 14 Apr 2023 03:23:49 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog driver
Date:   Fri, 14 Apr 2023 15:53:42 +0530
Message-ID: <20230414102342.23696-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414102342.23696-1-bbhushan2@marvell.com>
References: <20230414102342.23696-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UpBBPB4vNCSrPdx_2l9SUSl_Szauw7XP
X-Proofpoint-GUID: UpBBPB4vNCSrPdx_2l9SUSl_Szauw7XP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_04,2023-04-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GTI watchdog timer are programmed in "interrupt + del3t + reset mode"
and del3t traps are not enabled.
GTI watchdog exception flow is:
 - 1st timer expiration generates watchdog interrupt.
 - 2nd timer expiration is ignored
 - On 3rd timer expiration will trigger a system-wide core reset.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/watchdog/Kconfig         |   9 ++
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/octeontx2_wdt.c | 238 +++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/watchdog/octeontx2_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f0872970daf9..31ff282c62ad 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2212,4 +2212,13 @@ config KEEMBAY_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called keembay_wdt.
 
+config OCTEONTX2_WATCHDOG
+	tristate "OCTEONTX2 Watchdog driver"
+	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
+	help
+	 OCTEONTX2 GTI hardware supports watchdog timer. This watchdog timer are
+	 programmed in "interrupt + del3t + reset" mode. On first expiry it will
+	 generate interrupt. Second expiry (del3t) is ignored and system will reset
+	 on final timer expiry.
+
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9cbf6580f16c..aa1b813ad1f9 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -230,3 +230,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
 obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
 obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
+obj-$(CONFIG_OCTEONTX2_WATCHDOG) += octeontx2_wdt.o
diff --git a/drivers/watchdog/octeontx2_wdt.c b/drivers/watchdog/octeontx2_wdt.c
new file mode 100644
index 000000000000..7b78a092e83f
--- /dev/null
+++ b/drivers/watchdog/octeontx2_wdt.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell Octeontx2 Watchdog driver
+ *
+ * Copyright (C) 2023 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+#include <linux/sched/debug.h>
+
+#include <asm/arch_timer.h>
+
+/* GTI CWD Watchdog Registers */
+#define GTI_CWD_GLOBAL_WDOG_IDX		63
+#define GTI_CWD_WDOG			(0x8 * GTI_CWD_GLOBAL_WDOG_IDX)
+#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	0x3
+#define GTI_CWD_WDOG_MODE_MASK		0x3
+#define GTI_CWD_WDOG_LEN_SHIFT		4
+#define GTI_CWD_WDOG_CNT_SHIFT		20
+
+/* GTI Per-core Watchdog Interrupt Register */
+#define GTI_CWD_INT			0x200
+#define GTI_CWD_INT_PENDING_STATUS	(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
+
+/* GTI Per-core Watchdog Interrupt Enable Clear Register */
+#define GTI_CWD_INT_ENA_CLR		0x210
+#define GTI_CWD_INT_ENA_CLR_VAL		(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
+
+/* GTI Per-core Watchdog Interrupt Enable Set Register */
+#define GTI_CWD_INT_ENA_SET		0x218
+#define GTI_CWD_INT_ENA_SET_VAL		(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
+
+/* GTI Per-core Watchdog Poke Registers */
+#define GTI_CWD_POKE		(0x10000 + 0x8 * GTI_CWD_GLOBAL_WDOG_IDX)
+#define GTI_CWD_POKE_VAL	(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
+
+struct octeontx2_wdt_priv {
+	struct watchdog_device wdev;
+	void __iomem *base;
+	u64 clock_freq;
+	int irq;
+};
+
+static irqreturn_t octeontx2_wdt_interrupt(int irq, void *data)
+{
+	panic("Kernel Watchdog");
+	return IRQ_HANDLED;
+}
+
+static int octeontx2_wdt_ping(struct watchdog_device *wdev)
+{
+	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	writeq(GTI_CWD_POKE_VAL, priv->base + GTI_CWD_POKE);
+	return 0;
+}
+
+static int octeontx2_wdt_start(struct watchdog_device *wdev)
+{
+	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	u64 regval;
+
+	set_bit(WDOG_HW_RUNNING, &wdev->status);
+
+	/* Clear any pending interrupt */
+	writeq(GTI_CWD_INT_PENDING_STATUS, priv->base + GTI_CWD_INT);
+
+	/* Enable Interrupt */
+	writeq(GTI_CWD_INT_ENA_SET_VAL, priv->base + GTI_CWD_INT_ENA_SET);
+
+	/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode */
+	regval = readq(priv->base + GTI_CWD_WDOG);
+	regval |= GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
+	writeq(regval, priv->base + GTI_CWD_WDOG);
+
+	return 0;
+}
+
+static int octeontx2_wdt_stop(struct watchdog_device *wdev)
+{
+	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	u64 regval;
+
+	/* Disable Interrupt */
+	writeq(GTI_CWD_INT_ENA_CLR_VAL, priv->base + GTI_CWD_INT_ENA_CLR);
+
+	/* Set GTI_CWD_WDOG.Mode = 0 to stop the timer */
+	regval = readq(priv->base + GTI_CWD_WDOG);
+	regval &= ~GTI_CWD_WDOG_MODE_MASK;
+	writeq(regval, priv->base + GTI_CWD_WDOG);
+
+	return 0;
+}
+
+static int octeontx2_wdt_settimeout(struct watchdog_device *wdev,
+					unsigned int timeout)
+{
+	struct octeontx2_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	u64 timeout_wdog, regval;
+
+	/* Update new timeout */
+	wdev->timeout = timeout;
+
+	/* Get clock cycles from timeout in second */
+	timeout_wdog = (u64)timeout * priv->clock_freq;
+
+	/* Watchdog counts in 1024 cycle steps */
+	timeout_wdog = timeout_wdog >> 10;
+
+	/*
+	 * Hardware allows programming of upper 16-bits of 24-bits cycles
+	 * Round up and use upper 16-bits only.
+	 * Set max if timeout more than h/w supported
+	 */
+	timeout_wdog = (timeout_wdog + 0xff) >> 8;
+	if (timeout_wdog >= 0x10000)
+		timeout_wdog = 0xffff;
+
+	/*
+	 * GTI_CWD_WDOG.LEN have only upper 16-bits of 24-bits
+	 * GTI_CWD_WDOG.CNT, need addition shift of 8.
+	 */
+	regval = readq(priv->base + GTI_CWD_WDOG);
+	regval &= GTI_CWD_WDOG_MODE_MASK;
+	regval |= ((timeout_wdog) << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
+		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
+	writeq(regval, priv->base + GTI_CWD_WDOG);
+	return 0;
+}
+
+static const struct watchdog_info octeontx2_wdt_ident = {
+	.identity = "OcteonTX2 watchdog",
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE |
+			  WDIOF_CARDRESET,
+};
+
+static const struct watchdog_ops octeontx2_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = octeontx2_wdt_start,
+	.stop = octeontx2_wdt_stop,
+	.ping = octeontx2_wdt_ping,
+	.set_timeout = octeontx2_wdt_settimeout,
+};
+
+static int octeontx2_wdt_probe(struct platform_device *pdev)
+{
+	struct octeontx2_wdt_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct watchdog_device *wdog_dev;
+	int irq;
+	int err;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
+			      "reg property not valid/found\n");
+
+	priv->clock_freq = arch_timer_get_cntfrq();
+
+	wdog_dev = &priv->wdev;
+	wdog_dev->info = &octeontx2_wdt_ident,
+	wdog_dev->ops = &octeontx2_wdt_ops,
+	wdog_dev->parent = dev;
+	wdog_dev->min_timeout = 1;
+	wdog_dev->max_timeout = 16;
+	wdog_dev->max_hw_heartbeat_ms = 16000;
+	wdog_dev->timeout = 8;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "IRQ resource not found\n");
+		return -ENODEV;
+	}
+
+	err = request_irq(irq, octeontx2_wdt_interrupt, 0, pdev->name, priv);
+	if (err) {
+		dev_err(dev, "cannot register interrupt handler %d\n", err);
+		return err;
+	}
+
+	priv->irq = irq;
+	watchdog_set_drvdata(wdog_dev, priv);
+	platform_set_drvdata(pdev, priv);
+	watchdog_init_timeout(wdog_dev, wdog_dev->timeout, dev);
+	octeontx2_wdt_settimeout(wdog_dev, wdog_dev->timeout);
+	watchdog_stop_on_reboot(wdog_dev);
+	watchdog_stop_on_unregister(wdog_dev);
+
+	err = devm_watchdog_register_device(dev, wdog_dev);
+	if (err) {
+		free_irq(irq, priv);
+		return err;
+	}
+
+	dev_info(dev, "Watchdog enabled (timeout=%d sec)\n", wdog_dev->timeout);
+	return 0;
+}
+
+static int octeontx2_wdt_remove(struct platform_device *pdev)
+{
+	struct octeontx2_wdt_priv *priv = platform_get_drvdata(pdev);
+
+	if (priv->irq)
+		free_irq(priv->irq, priv);
+
+	return 0;
+}
+
+static const struct of_device_id octeontx2_wdt_of_match[] = {
+	{ .compatible = "marvell-octeontx2-wdt", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, octeontx2_wdt_of_match);
+
+static struct platform_driver octeontx2_wdt_driver = {
+	.driver = {
+		.name = "octeontx2-wdt",
+		.of_match_table = octeontx2_wdt_of_match,
+	},
+	.probe = octeontx2_wdt_probe,
+	.remove = octeontx2_wdt_remove,
+};
+module_platform_driver(octeontx2_wdt_driver);
+
+MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
+MODULE_DESCRIPTION("OcteonTX2 watchdog driver");
-- 
2.17.1

