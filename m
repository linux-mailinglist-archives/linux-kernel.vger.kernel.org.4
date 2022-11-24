Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA1B637144
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKXDv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKXDvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:51:24 -0500
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6414716E8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:51:18 -0800 (PST)
X-QQ-mid: bizesmtpipv602t1669261869tazr
Received: from localhost ( [255.189.44.3])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 24 Nov 2022 11:51:08 +0800 (CST)
X-QQ-SSF: 01400000000000506000000A0000000
X-QQ-FEAT: QityeSR92A3taB+Cs8W34f+r2Ry1LIxpKTjJomZPgWMPYdozgqhkojV/8oEoH
        0qrR7sGKMS1kZ69nJmAbchu+DMeKvhLCJuanBcRNTLnTEHwZRMHlNyYPIbcbsKADnFMwkFQ
        zYJOfR774zqvp2dYJxagLdPxMBaixdu36mtyjzpbc3COX/WcVDaOuso/dnOF2vDhSxrbWnu
        34gXuHJ1axqKmHsggzl8kgPaRLmiCmf0oi1FKdBOiE/Uvxrb9H94Jb6P6FrYGXayeiDL2Om
        Wt78k2eYeisAygXHWsdyJuEQpdCLp2ODoLTy43gecDZFRvWy1SC54/Sg+pb18uyrqdMgBk2
        EePVzZ3l3gkkgPAsxDzEU9bptlpKaee+mL4Q0BUqJ38//VH86KW3p/9MukVHw==
X-QQ-GoodBg: 2
Date:   Thu, 24 Nov 2022 11:51:08 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3]mailbox: Add to support Phytium FT2000/4 CPU
Message-ID: <D75CB8B4C938EA72+Y37qLHaP9gMI7yit@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_NONE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add to support Phytium FT2000/4 CPU

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 drivers/mailbox/Kconfig           |   6 +
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/phytium_mailbox.c | 200 ++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 drivers/mailbox/phytium_mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05d6fae800e3..ae5ec83d9cbd 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -41,6 +41,12 @@ config IMX_MBOX
 	help
 	  Mailbox implementation for i.MX Messaging Unit (MU).
 
+config PHYTIUM_MBOX
+        tristate "Phytium SoC Mailbox Support"
+        depends on ARCH_PHYTIUM || COMPILE_TEST
+        help
+          This driver provides the support for the Phytium mailbox controller.
+
 config PLATFORM_MHU
 	tristate "Platform MHU Mailbox"
 	depends on OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index fc9376117111..687aa19043f5 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_ARM_MHU_V2)	+= arm_mhuv2.o
 
 obj-$(CONFIG_IMX_MBOX)	+= imx-mailbox.o
 
+obj-$(CONFIG_PHYTIUM_MBOX)	+= phytium_mailbox.o
+
 obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)	+= armada-37xx-rwtm-mailbox.o
 
 obj-$(CONFIG_PLATFORM_MHU)	+= platform_mhu.o
diff --git a/drivers/mailbox/phytium_mailbox.c b/drivers/mailbox/phytium_mailbox.c
new file mode 100644
index 000000000000..c797d4b4769f
--- /dev/null
+++ b/drivers/mailbox/phytium_mailbox.c
@@ -0,0 +1,200 @@
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
+static const struct acpi_device_id phytium_mbox_acpi_match[] = {
+	{ "PHYT0009", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, phytium_mbox_acpi_match);
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
+		.acpi_match_table = ACPI_PTR(phytium_mbox_acpi_match),
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

