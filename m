Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33416C8084
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjCXO51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjCXO5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:57:22 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFBA4EC8;
        Fri, 24 Mar 2023 07:57:20 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O6Ym7a018470;
        Fri, 24 Mar 2023 07:57:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=zDGtFUqIAVVV28fMS7e0nvbav3/7aaFs9XKBr54WU1c=;
 b=VCQrT3Tacpw4YS9i3Opi8i10xUGPa4wyEJqbLN84c+t6Hq/M4BagB2sVD6dz18KG+SjH
 bvfmeF2FB5EK4jLYe0eWzWSmUn+fxdaEVt9ql6NX3Sq2MZJ/HeDUNDmJvS5lr9kHVpns
 Lz3HnEarU5552X/3+sYqSuY/M28lQA6vOF4JSrxeOerzREJ/BZmCfx8TiI8rRdPb6tZG
 54ygZVCCjD4DnJd5J9+Hj7z1Q5UoaXePfD9xF3iH+F0TBTwzM2h1nsLVsa6xVte6SSex
 u7JolDvs25lv81U51fiG7eN2JHrurPpS1DMV7x2JMsY1CRdKvjiVLkO8+EePNqks7U6U 7g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ph6q3sk1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 07:57:03 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Mar
 2023 07:57:01 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Fri, 24 Mar 2023 07:56:59 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 2/2] Watchdog: octeontx2: Add Pseudo-NMI GTI watchdog driver
Date:   Fri, 24 Mar 2023 20:26:52 +0530
Message-ID: <20230324145652.19221-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230324145652.19221-1-bbhushan2@marvell.com>
References: <20230324145652.19221-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 9WIopST8WCwU2nWBgW0K9tjMdLAVdXrs
X-Proofpoint-ORIG-GUID: 9WIopST8WCwU2nWBgW0K9tjMdLAVdXrs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_08,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GTI hardware supports per-core watchdog timer which are programmed
in "interrupt + del3t + reset mode" and del3t traps are not enabled.
This driver uses ARM64 pseudo-nmi interrupt support.
GTI watchdog exception flow is:
 - 1st timer expiration generates pseudo-nmi interrupt.
   NMI exception handler dumps register/context state on all cpu's.
 - 2nd timer expiration is ignored

 - On 3rd timer expiration will trigger a system-wide core reset.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/watchdog/Kconfig                  |   9 +
 drivers/watchdog/Makefile                 |   1 +
 drivers/watchdog/octeontx2_gti_watchdog.c | 352 ++++++++++++++++++++++
 3 files changed, 362 insertions(+)
 create mode 100644 drivers/watchdog/octeontx2_gti_watchdog.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f0872970daf9..9607d36645f6 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2212,4 +2212,13 @@ config KEEMBAY_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called keembay_wdt.
 
+config OCTEON_GTI_WATCHDOG
+	tristate "OCTEONTX2 GTI Watchdog driver"
+	depends on ARM64
+	help
+	 OCTEONTX2 GTI hardware supports per-core watchdog timer which
+	 are programmed in "interrupt + del3t + reset mode" and del3t
+	 traps are not enabled.
+	 This driver uses ARM64 pseudo-nmi interrupt support.
+
 endif # WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9cbf6580f16c..11af3db62fec 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -230,3 +230,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
 obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
 obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
+obj-$(CONFIG_OCTEON_GTI_WATCHDOG) += octeontx2_gti_watchdog.o
diff --git a/drivers/watchdog/octeontx2_gti_watchdog.c b/drivers/watchdog/octeontx2_gti_watchdog.c
new file mode 100644
index 000000000000..766b7d41defe
--- /dev/null
+++ b/drivers/watchdog/octeontx2_gti_watchdog.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell GTI Watchdog driver
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
+#define GTI_CWD_WDOG(cpu)		(0x8 * cpu)
+#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	(0x3)
+#define GTI_CWD_WDOG_MODE_MASK		(0x3)
+#define GTI_CWD_WDOG_LEN_SHIFT		(4)
+#define GTI_CWD_WDOG_CNT_SHIFT		(20)
+
+/* GTI Per-core Watchdog Interrupt Register */
+#define GTI_CWD_INT			0x200
+
+/* GTI Per-core Watchdog Interrupt Enable Clear Register */
+#define GTI_CWD_INT_ENA_CLR		0x210
+
+/* GTI Per-core Watchdog Interrupt Enable Set Register */
+#define GTI_CWD_INT_ENA_SET		0x218
+
+/* GTI Per-core Watchdog Poke Registers */
+#define GTI_CWD_POKE(cpu)		(0x10000 + 0x8 * cpu)
+
+struct octeontx2_gti_wdt_percpu_priv {
+	struct watchdog_device wdev;
+	int irq;
+};
+
+struct octeontx2_gti_wdt_priv {
+	void __iomem *base;
+	u64 clock_freq;
+	int is_nmi;
+	struct octeontx2_gti_wdt_percpu_priv __percpu *percpu_priv;
+};
+
+static int octeontx2_gti_wdt_get_cpuid(struct watchdog_device *wdev)
+{
+	struct octeontx2_gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	struct octeontx2_gti_wdt_percpu_priv *percpu_priv;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		percpu_priv = per_cpu_ptr(priv->percpu_priv, cpu);
+		if (&percpu_priv->wdev == wdev)
+			return cpu;
+	}
+
+	return -1;
+}
+
+void octeontx2_gti_wdt_callback_other_cpus(void *unused)
+{
+	struct pt_regs *regs = get_irq_regs();
+
+	pr_emerg("GTI Watchdog CPU:%d\n", raw_smp_processor_id());
+
+	if (regs)
+		show_regs(regs);
+	else
+		dump_stack();
+}
+
+static irqreturn_t octeontx2_gti_wdt_interrupt(int irq, void *data)
+{
+	struct octeontx2_gti_wdt_priv *priv = (struct octeontx2_gti_wdt_priv *)data;
+	int cpu = smp_processor_id();
+
+	/* Clear interrupt to fire again if delayed poke happens */
+	writeq(1 << cpu, priv->base + GTI_CWD_INT);
+	dump_stack();
+
+	for_each_online_cpu(cpu) {
+		if (cpu == raw_smp_processor_id())
+			continue;
+
+		smp_call_function_single(cpu,
+					 octeontx2_gti_wdt_callback_other_cpus,
+					 NULL, 1);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int octeontx2_gti_wdt_ping(struct watchdog_device *wdev)
+{
+	struct octeontx2_gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	int cpu = octeontx2_gti_wdt_get_cpuid(wdev);
+
+	if (cpu < 0)
+		return -EINVAL;
+
+	writeq(1, priv->base + GTI_CWD_POKE(cpu));
+	return 0;
+}
+
+static int octeontx2_gti_wdt_start(struct watchdog_device *wdev)
+{
+	struct octeontx2_gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	int cpu = octeontx2_gti_wdt_get_cpuid(wdev);
+	u64 regval;
+
+	if (cpu < 0)
+		return -EINVAL;
+
+	set_bit(WDOG_HW_RUNNING, &wdev->status);
+
+	/* Clear any pending interrupt */
+	writeq(1 << cpu, priv->base + GTI_CWD_INT);
+
+	/* Enable Interrupt */
+	writeq(1 << cpu, priv->base + GTI_CWD_INT_ENA_SET);
+
+	/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode */
+	regval = readq(priv->base + GTI_CWD_WDOG(cpu));
+	regval |= GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
+	writeq(regval, priv->base + GTI_CWD_WDOG(cpu));
+
+	return 0;
+}
+
+static int octeontx2_gti_wdt_stop(struct watchdog_device *wdev)
+{
+	struct octeontx2_gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	u64 regval;
+	int cpu = octeontx2_gti_wdt_get_cpuid(wdev);
+
+	if (cpu < 0)
+		return -EINVAL;
+
+	/* Disable Interrupt */
+	writeq(1 << cpu, priv->base + GTI_CWD_INT_ENA_CLR);
+
+	/* Set GTI_CWD_WDOG.Mode = 0 to stop the timer */
+	regval = readq(priv->base + GTI_CWD_WDOG(cpu));
+	regval &= ~GTI_CWD_WDOG_MODE_MASK;
+	writeq(regval, priv->base + GTI_CWD_WDOG(cpu));
+
+	return 0;
+}
+
+static int octeontx2_gti_wdt_settimeout(struct watchdog_device *wdev,
+					unsigned int timeout)
+{
+	struct octeontx2_gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	int cpu = octeontx2_gti_wdt_get_cpuid(wdev);
+	u64 timeout_wdog, regval;
+
+	if (cpu < 0)
+		return -EINVAL;
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
+	regval = readq(priv->base + GTI_CWD_WDOG(cpu));
+	regval &= GTI_CWD_WDOG_MODE_MASK;
+	regval |= ((timeout_wdog) << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
+		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
+	writeq(regval, priv->base + GTI_CWD_WDOG(cpu));
+	return 0;
+}
+
+static const struct watchdog_info octeontx2_gti_wdt_ident = {
+	.identity = "OcteonTX2 GTI watchdog",
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE |
+			  WDIOF_CARDRESET,
+};
+
+static const struct watchdog_ops octeontx2_gti_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = octeontx2_gti_wdt_start,
+	.stop = octeontx2_gti_wdt_stop,
+	.ping = octeontx2_gti_wdt_ping,
+	.set_timeout = octeontx2_gti_wdt_settimeout,
+};
+
+static void octeontx2_gti_wdt_free_irqs(struct octeontx2_gti_wdt_priv *priv)
+{
+	struct octeontx2_gti_wdt_percpu_priv *percpu_priv;
+	int irq, cpu = 0;
+
+	for_each_online_cpu(cpu) {
+		percpu_priv = per_cpu_ptr(priv->percpu_priv, cpu);
+		irq = percpu_priv->irq;
+		if (irq) {
+			if (priv->is_nmi) {
+				disable_nmi_nosync(irq);
+				free_nmi(irq, priv);
+			} else {
+				disable_irq_nosync(irq);
+				free_irq(irq, priv);
+			}
+
+			percpu_priv->irq = 0;
+		}
+	}
+}
+
+static int octeontx2_gti_wdt_probe(struct platform_device *pdev)
+{
+	struct octeontx2_gti_wdt_percpu_priv *percpu_priv;
+	struct octeontx2_gti_wdt_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct watchdog_device *wdog_dev;
+	unsigned long irq_flags;
+	int irq, cpu, num_irqs;
+	int err;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->percpu_priv = devm_alloc_percpu(&pdev->dev, *priv->percpu_priv);
+	if (!priv->percpu_priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
+			      "reg property not valid/found\n");
+
+	num_irqs = platform_irq_count(pdev);
+	if (num_irqs < 0)
+		return dev_err_probe(dev, num_irqs, "GTI CWD no IRQs\n");
+
+	if (num_irqs < num_online_cpus())
+		return dev_err_probe(dev, -EINVAL, "IRQs (%d) < CPUs (%d)\n",
+				     num_irqs, num_online_cpus());
+
+	priv->clock_freq = arch_timer_get_cntfrq();
+
+	for_each_online_cpu(cpu) {
+		percpu_priv = per_cpu_ptr(priv->percpu_priv, cpu);
+		wdog_dev = &percpu_priv->wdev;
+		wdog_dev->info = &octeontx2_gti_wdt_ident,
+		wdog_dev->ops = &octeontx2_gti_wdt_ops,
+		wdog_dev->parent = dev;
+		wdog_dev->min_timeout = 1;
+		wdog_dev->max_timeout = 16;
+		wdog_dev->max_hw_heartbeat_ms = 16000;
+		wdog_dev->timeout = 8;
+
+		irq = platform_get_irq(pdev, cpu);
+		if (irq < 0) {
+			dev_err(&pdev->dev, "IRQ resource not found\n");
+			err = -ENODEV;
+			goto out;
+		}
+
+		err = irq_force_affinity(irq, cpumask_of(cpu));
+		if (err) {
+			pr_warn("unable to set irq affinity (irq=%d, cpu=%u)\n", irq, cpu);
+			goto out;
+		}
+
+		irq_flags = IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_AUTOEN |
+			    IRQF_NO_THREAD;
+		err = request_nmi(irq, octeontx2_gti_wdt_interrupt, irq_flags,
+				  pdev->name, priv);
+		if (err) {
+			err = request_irq(irq, octeontx2_gti_wdt_interrupt, irq_flags,
+					  pdev->name, priv);
+			if (err) {
+				dev_err(dev, "cannot register interrupt handler %d\n", err);
+				goto out;
+			}
+			enable_irq(irq);
+		} else {
+			priv->is_nmi = 1;
+			enable_nmi(irq);
+		}
+
+		percpu_priv->irq = irq;
+		watchdog_set_drvdata(wdog_dev, priv);
+		platform_set_drvdata(pdev, priv);
+		watchdog_init_timeout(wdog_dev, wdog_dev->timeout, dev);
+		octeontx2_gti_wdt_settimeout(wdog_dev, wdog_dev->timeout);
+		watchdog_stop_on_reboot(wdog_dev);
+		watchdog_stop_on_unregister(wdog_dev);
+
+		err = devm_watchdog_register_device(dev, wdog_dev);
+		if (unlikely(err))
+			goto out;
+		dev_info(dev, "Watchdog enabled (timeout=%d sec)", wdog_dev->timeout);
+	}
+	return 0;
+
+out:
+	octeontx2_gti_wdt_free_irqs(priv);
+	return err;
+}
+
+static int octeontx2_gti_wdt_remove(struct platform_device *pdev)
+{
+	struct octeontx2_gti_wdt_priv *priv = platform_get_drvdata(pdev);
+
+	octeontx2_gti_wdt_free_irqs(priv);
+	return 0;
+}
+
+static const struct of_device_id octeontx2_gti_wdt_of_match[] = {
+	{ .compatible = "mrvl,octeontx2-gti-wdt", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, octeontx2_gti_wdt_of_match);
+
+static struct platform_driver octeontx2_gti_wdt_driver = {
+	.driver = {
+		.name = "octeontx2-gti-wdt",
+		.of_match_table = octeontx2_gti_wdt_of_match,
+	},
+	.probe = octeontx2_gti_wdt_probe,
+	.remove = octeontx2_gti_wdt_remove,
+};
+module_platform_driver(octeontx2_gti_wdt_driver);
+
+MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
+MODULE_DESCRIPTION("OcteonTX2 GTI per cpu watchdog driver");
-- 
2.17.1

