Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD78B63FDFE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiLBCJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiLBCJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:09:20 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93017BDCD5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:09:16 -0800 (PST)
X-QQ-mid: bizesmtp83t1669946943t6c3bau7
Received: from localhost ( [202.85.220.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 02 Dec 2022 10:09:01 +0800 (CST)
X-QQ-SSF: 0140000000000080B000000A0000000
X-QQ-FEAT: CEO3k+BsRkLZAYo3YfPK1U8EaV0nt11rPrIYBPYhQlJVBsb4FvncigvVXi41a
        qI7R30XUi01xi2j7OxY5JBLopoC77oS++OWu3TMp7F2c8ZSzHJq9AYxTcwwfHtI7c7pwrfA
        Q9QWEs6/gfs4Se5/H/DJM0OH3QhwNsaKhSNudPEYzMG+/3DA+fGkJQlGQIwKZ/RdXJP6Y+0
        FUdYKB4ha9zoHpT+xUP956fVJ2QTIya++dCnCHCJY8P6VndcBEqYvtNjPLpXBzXaAzC7vO8
        rW+5Db0uhi6+/lPPxG4fH0mFs18yNPL3mAaS78judpRbkn0h2CwwEZHrebV9e0UathmjxW3
        ip50gl8k8dzaIlVh+pwJOXCG6PtxETqryPVnRdo
X-QQ-GoodBg: 2
Date:   Fri, 2 Dec 2022 10:09:01 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Mailbox: add for Phytium FT2000/4 CPUs
Message-ID: <9AE980AA9AA0C6D1+Y4lePSm3uZUWsiji@TP-P15V>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:ucas.com.cn:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mailbox: add for Phytium FT2000/4 CPUs. 

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 drivers/mailbox/Kconfig           |   6 +
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/phytium_mailbox.c | 193 ++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/mailbox/phytium_mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05d6fae800e3..4d08e8ebc831 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -41,6 +41,12 @@ config IMX_MBOX
 	help
 	  Mailbox implementation for i.MX Messaging Unit (MU).
 
+config PHYTIUM_MBOX
+        tristate "Phytium SoC Mailbox Support"
+        depends on ARM_AMBA || COMPILE_TEST
+        help
+          This driver provides the support for the Phytium mailbox controller.
+
 config PLATFORM_MHU
 	tristate "Platform MHU Mailbox"
 	depends on OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index fc9376117111..e46cb9b29369 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_ARM_MHU_V2)	+= arm_mhuv2.o
 
 obj-$(CONFIG_IMX_MBOX)	+= imx-mailbox.o
 
+obj-$(CONFIG_PHYTIUM_MBOX)      += phytium_mailbox.o
+
 obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)	+= armada-37xx-rwtm-mailbox.o
 
 obj-$(CONFIG_PLATFORM_MHU)	+= platform_mhu.o
diff --git a/drivers/mailbox/phytium_mailbox.c b/drivers/mailbox/phytium_mailbox.c
new file mode 100644
index 000000000000..8211db1d2ca0
--- /dev/null
+++ b/drivers/mailbox/phytium_mailbox.c
@@ -0,0 +1,193 @@
+/*
+ * Phytium SoC mailbox driver
+ *
+ * Copyright (c) 2020 Phytium Corporation.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define INTR_STAT	0x0
+#define INTR_SET	0x8
+#define INTR_CLR	0x10
+
+#define TX_REG		0x100
+
+#define NR_CHANS	1
+
+struct phytium_mbox_link {
+	unsigned irq;
+	void __iomem *tx_reg;
+	void __iomem *rx_reg;
+};
+
+struct phytium_mbox {
+	void __iomem *base;
+	struct phytium_mbox_link mlink;
+	struct mbox_chan chan;
+	struct mbox_controller mbox;
+};
+
+static irqreturn_t phytium_mbox_rx_irq(int irq, void *ch)
+{
+	struct mbox_chan *chan = ch;
+	struct phytium_mbox_link *mlink = chan->con_priv;
+	u32 val;
+
+	val = readl_relaxed(mlink->rx_reg + INTR_STAT);
+	if (!val)
+		return IRQ_NONE;
+
+	mbox_chan_received_data(chan, (void *)&val);
+
+	writel_relaxed(val, mlink->rx_reg + INTR_CLR);
+
+	return IRQ_HANDLED;
+}
+
+static int phytium_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct phytium_mbox_link *mlink = chan->con_priv;
+	u32 *arg = data;
+
+	writel_relaxed(*arg, mlink->tx_reg + INTR_SET);
+
+	return 0;
+}
+
+static int phytium_mbox_startup(struct mbox_chan *chan)
+{
+	struct phytium_mbox_link *mlink = chan->con_priv;
+	u32 val;
+	int ret;
+
+	val = readl_relaxed(mlink->tx_reg + INTR_STAT);
+	writel_relaxed(val, mlink->tx_reg + INTR_CLR);
+
+	ret = request_irq(mlink->irq, phytium_mbox_rx_irq,
+			  IRQF_SHARED, "phytium_mbox_link", chan);
+	if (ret) {
+		dev_err(chan->mbox->dev,
+			"Unable to acquire IRQ %d\n", mlink->irq);
+	}
+
+	return ret;
+}
+
+static void phytium_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct phytium_mbox_link *mlink = chan->con_priv;
+
+	free_irq(mlink->irq, chan);
+}
+
+static bool phytium_mbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct phytium_mbox_link *mlink = chan->con_priv;
+	u32 val = readl_relaxed(mlink->tx_reg + INTR_STAT);
+
+	return (val == (u32)(1U << 31));
+}
+
+static const struct mbox_chan_ops phytium_mbox_ops = {
+	.send_data = phytium_mbox_send_data,
+	.startup = phytium_mbox_startup,
+	.shutdown = phytium_mbox_shutdown,
+	.last_tx_done = phytium_mbox_last_tx_done,
+};
+
+static const struct of_device_id phytium_mbox_of_match[] = {
+	{ .compatible = "phytium,mbox", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, phytium_mbox_of_match);
+
+static int phytium_mbox_probe(struct platform_device *pdev)
+{
+	struct phytium_mbox *mbox;
+	struct resource *res;
+	int err, irq;
+
+	/* Allocate memory for device */
+	mbox = devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mbox->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mbox->base)) {
+		dev_err(&pdev->dev, "ioremap base failed\n");
+		return PTR_ERR(mbox->base);
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "cannot obtain irq\n");
+		return irq;
+	}
+
+	mbox->chan.con_priv = &mbox->mlink;
+	mbox->mlink.irq = irq;
+	mbox->mlink.rx_reg = mbox->base;
+	mbox->mlink.tx_reg = mbox->mlink.rx_reg + TX_REG;
+
+	mbox->mbox.dev = &pdev->dev;
+	mbox->mbox.chans = &mbox->chan;
+	mbox->mbox.num_chans = NR_CHANS;
+	mbox->mbox.ops = &phytium_mbox_ops;
+	mbox->mbox.txdone_irq = false;
+	mbox->mbox.txdone_poll = true;
+	mbox->mbox.txpoll_period = 1;
+
+	platform_set_drvdata(pdev, mbox);
+
+	err = mbox_controller_register(&mbox->mbox);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register mailboxes %d\n", err);
+		goto fail;
+	}
+
+	dev_info(&pdev->dev, "Phytium SoC Mailbox registered\n");
+fail:
+	return err;
+}
+
+static int phytium_mbox_remove(struct platform_device *pdev)
+{
+	struct phytium_mbox *mbox = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&mbox->mbox);
+
+	return 0;
+}
+
+static struct platform_driver phytium_mbox_driver = {
+	.probe = phytium_mbox_probe,
+	.remove = phytium_mbox_remove,
+	.driver = {
+		.name = "phytium-mbox",
+		.of_match_table = of_match_ptr(phytium_mbox_of_match),
+	},
+};
+
+module_platform_driver(phytium_mbox_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Phytium SoC Mailbox Driver");
+MODULE_AUTHOR("Chen Baozi <chenbaozi@phytium.com.cn>");
-- 
2.34.1

