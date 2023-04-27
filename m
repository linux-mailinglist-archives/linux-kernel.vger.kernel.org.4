Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857156F01F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbjD0Hlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbjD0Hln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:41:43 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764C1FD4;
        Thu, 27 Apr 2023 00:41:42 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R7CHl8006786;
        Thu, 27 Apr 2023 00:14:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=jNamH3IUPTvVLJQrKIQKVTwok/+yKL3JteXdR78KPok=;
 b=Br3n2H+8UWb4BDHT5BhlIcW3LiyuBS1C8wH50B0auLnHSEIpZxd6WLEy8tSGh3opEyYZ
 sjIsXn0PnBzJGS2eJxtSQBJdV3iRZeU89m0mT+WTEhWz9FDa5ZcL1x8qK3QXy2VTSi3k
 rB0OWZqR4Q94qASEd7CDS2Gfx3gtpFP8v5FQMANtn2O7odydvIiKG8NX6r057DDdmuD1
 44wueUKFDOA1/YqeMJYCxNMRIcJMAbwheIlMdSMAYRzxz4C/4P2KNIKQSkpKZ9jkSrix
 UGmC1/nqJgQUsh2QlzjOUpelBeXDAMNuLng82fVnDoTaemets4VXclAonukc29kbVfP+ hg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3q7apa2c5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 00:14:19 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 27 Apr
 2023 00:14:17 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 27 Apr 2023 00:14:15 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 2/2 v4] Watchdog: Add marvell GTI watchdog driver
Date:   Thu, 27 Apr 2023 12:44:08 +0530
Message-ID: <20230427071408.8493-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230427071408.8493-1-bbhushan2@marvell.com>
References: <20230427071408.8493-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QwyukqyB6RlR0UMB_E6OF900zNU7-wtr
X-Proofpoint-GUID: QwyukqyB6RlR0UMB_E6OF900zNU7-wtr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_05,2023-04-26_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Marvell GTI watchdog.  Global timer
unit (GTI) support hardware watchdog timer. Software programs
watchdog timer to generate interrupt on first timeout, second
timeout is configured to be ignored and system reboots on
third timeout.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v4:
 - Use generic name "GTI (Global Timer)" and removed OcteonTX2 as this driver
   is applicable for other marvell devices as well.

 drivers/watchdog/Kconfig           |  11 ++
 drivers/watchdog/Makefile          |   1 +
 drivers/watchdog/marvell_gti_wdt.c | 271 +++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 drivers/watchdog/marvell_gti_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f0872970daf9..a96e7d7c0ad2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1779,6 +1779,17 @@ config OCTEON_WDT
 	  from the first interrupt, it is then only poked when the
 	  device is written.
 
+config MARVELL_GTI_WDT
+	tristate "Marvell GTI Watchdog driver"
+	depends on ARCH_THUNDER || COMPILE_TEST
+	help
+	 Marvell GTI hardware supports watchdog timer. First timeout
+	 works as watchdog pretimeout and installed interrupt handler
+	 will be called on first timeout. Hardware can generate interrupt
+	 to SCP on second timeout but it is not enabled, So second
+	 timeout is ignored. If device poke does not happen then system
+	 will reboot on third timeout.
+
 config BCM2835_WDT
 	tristate "Broadcom BCM2835 hardware watchdog"
 	depends on ARCH_BCM2835 || (OF && COMPILE_TEST)
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9cbf6580f16c..bd425408fcaa 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
 obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
 obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o
 obj-$(CONFIG_SUNPLUS_WATCHDOG) += sunplus_wdt.o
+obj-$(CONFIG_MARVELL_GTI_WDT) += marvell_gti_wdt.o
 
 # X86 (i386 + ia64 + x86_64) Architecture
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
new file mode 100644
index 000000000000..a3f0740dedca
--- /dev/null
+++ b/drivers/watchdog/marvell_gti_wdt.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell GTI Watchdog driver
+ *
+ * Copyright (C) 2023 Marvell.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+#include <asm/arch_timer.h>
+
+/*
+ * Hardware supports following mode of operation:
+ * 1) Interrupt Only:
+ *    This will generate the interrupt to arm core whenever timeout happens.
+ *
+ * 2) Interrupt + del3t (Interrupt to firmware (SCP processor)).
+ *    This will generate interrupt to arm core on 1st timeout happens
+ *    This will generate interrupt to SCP processor on 2nd timeout happens
+ *
+ * 3) Interrupt + Interrupt to SCP processor (called delt3t) + reboot.
+ *    This will generate interrupt to arm core on 1st timeout happens
+ *    Will generate interrupt to SCP processor on 2nd timeout happens,
+ *    if interrupt is configured.
+ *    Reboot on 3rd timeout.
+ *
+ * Driver will use hardware in mode-3 above so that system can reboot in case
+ * a hardware hang. Also h/w is configured not to generate SCP interrupt, so
+ * effectively 2nd timeout is ignored within hardware.
+ */
+
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
+struct gti_wdt_priv {
+	struct watchdog_device wdev;
+	void __iomem *base;
+	u64 clock_freq;
+	int irq;
+};
+
+static irqreturn_t gti_wdt_interrupt(int irq, void *data)
+{
+	struct watchdog_device *wdev = data;
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	/* Clear Interrupt Pending Status */
+	writeq(GTI_CWD_INT_PENDING_STATUS, priv->base + GTI_CWD_INT);
+
+	watchdog_notify_pretimeout(wdev);
+
+	return IRQ_HANDLED;
+}
+
+static int gti_wdt_ping(struct watchdog_device *wdev)
+{
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	writeq(GTI_CWD_POKE_VAL, priv->base + GTI_CWD_POKE);
+
+	return 0;
+}
+
+static int gti_wdt_start(struct watchdog_device *wdev)
+{
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	u64 regval;
+
+	if (!wdev->pretimeout)
+		return -EINVAL;
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
+static int gti_wdt_stop(struct watchdog_device *wdev)
+{
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
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
+static int gti_wdt_settimeout(struct watchdog_device *wdev,
+					unsigned int timeout)
+{
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	u64 timeout_wdog, regval;
+
+	/* Update new timeout */
+	wdev->timeout = timeout;
+
+	/* Pretimeout is 1/3 of timeout */
+	wdev->pretimeout = timeout / 3;
+	if (!wdev->pretimeout)
+		return -EINVAL;
+
+	/* Get clock cycles from timeout in second */
+	timeout_wdog = wdev->pretimeout * priv->clock_freq;
+
+	/* Watchdog counts in 1024 cycle steps */
+	timeout_wdog = timeout_wdog >> 10;
+
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
+	regval |= (timeout_wdog << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
+		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
+	writeq(regval, priv->base + GTI_CWD_WDOG);
+
+	return 0;
+}
+
+static int gti_wdt_set_pretimeout(struct watchdog_device *wdev,
+					unsigned int timeout)
+{
+	struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	struct watchdog_device *wdog_dev = &priv->wdev;
+
+	/* pretimeout should 1/3 of max_timeout */
+	if ((timeout * 3) <= wdog_dev->max_timeout)
+		return gti_wdt_settimeout(wdev, timeout * 3);
+
+	return -EINVAL;
+}
+
+static const struct watchdog_info gti_wdt_ident = {
+	.identity = "Marvell GTI watchdog",
+	.options = WDIOF_SETTIMEOUT | WDIOF_PRETIMEOUT | WDIOF_KEEPALIVEPING |
+		   WDIOF_MAGICCLOSE | WDIOF_CARDRESET,
+};
+
+static const struct watchdog_ops gti_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = gti_wdt_start,
+	.stop = gti_wdt_stop,
+	.ping = gti_wdt_ping,
+	.set_timeout = gti_wdt_settimeout,
+	.set_pretimeout = gti_wdt_set_pretimeout,
+};
+
+static int gti_wdt_probe(struct platform_device *pdev)
+{
+	struct gti_wdt_priv *priv;
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
+	wdog_dev->info = &gti_wdt_ident,
+	wdog_dev->ops = &gti_wdt_ops,
+	wdog_dev->parent = dev;
+	/*
+	 * Watchdog counter is 24 bit where lower 8 bits are zeros, so maximum
+	 * value that can be programmed in hardware is 0xffff00. This counter
+	 * decrements every one microsec.
+	 * Hardware will generate interrupt on first timeout (pretimeout)
+	 * reset the system on 3rd timeout.
+	 * Max watchdog pretimeout can be 16 sec, so max timeout is 48 sec.
+	 * Let's have min pretimeout to 1sec, so min timeout is 3sec.
+	 */
+	wdog_dev->max_timeout = 48;
+	wdog_dev->min_timeout = 3;
+	wdog_dev->timeout = 30;
+	wdog_dev->pretimeout = wdog_dev->timeout / 3;
+
+	priv->irq = irq;
+	watchdog_set_drvdata(wdog_dev, priv);
+	platform_set_drvdata(pdev, priv);
+	gti_wdt_settimeout(wdog_dev, wdog_dev->timeout);
+	watchdog_stop_on_reboot(wdog_dev);
+	watchdog_stop_on_unregister(wdog_dev);
+
+	err = devm_watchdog_register_device(dev, wdog_dev);
+	if (err)
+		return err;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(&pdev->dev, irq, "IRQ resource not found\n");
+
+	err = devm_request_irq(dev, irq, gti_wdt_interrupt, 0,
+			       pdev->name, &priv->wdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register interrupt handler\n");
+
+	dev_info(dev, "Watchdog enabled (timeout=%d sec)\n", wdog_dev->timeout);
+	return 0;
+}
+
+static const struct of_device_id gti_wdt_of_match[] = {
+	{ .compatible = "marvell,gti-wdt", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, gti_wdt_of_match);
+
+static struct platform_driver gti_wdt_driver = {
+	.driver = {
+		.name = "gti-wdt",
+		.of_match_table = gti_wdt_of_match,
+	},
+	.probe = gti_wdt_probe,
+};
+module_platform_driver(gti_wdt_driver);
+
+MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
+MODULE_DESCRIPTION("Marvell GTI watchdog driver");
-- 
2.17.1

