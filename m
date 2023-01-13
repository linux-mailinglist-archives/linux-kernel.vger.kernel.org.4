Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A75669802
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbjAMNGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjAMNGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:06:18 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E98777F2;
        Fri, 13 Jan 2023 04:53:35 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DCWnIS026966;
        Fri, 13 Jan 2023 04:53:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=ycqFtAOOwfS9XlWn+v2pX9ekogxOMD8GWmRhSEGEx8s=;
 b=HiXI75IQvsUFvDsTq+ZXXbyThIgMwp85g7HTBiYZXyDvtu1dBikMwibLWUCj4FtSZ5X4
 0wOukNZ3Fld8DpT44NRcQPNUPhKaOIc3kqs7f0R1SiKeL0iufgAzKj1kamS89JdJy5E8
 3YlQVV4HX2K14M+BHqSZhbKmPevjJFD75yqRquqZ4SzGGGk1oDpg/yMGkhjMNhJGj5YH
 Wl2+yEeDgHRVDyR42EiBOOfZaWCxKh+8MaFlAV2ebmCdbiP94W/lrIl+QG26SeOG7L2z
 0/7wgQh0lrbEetiKEdkIotskXuA7FNL6qCqFbO9c/hsuWpNnE0eP5hyBXxtga1XWxxU2 BQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3n1k574xh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 04:53:31 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 13 Jan
 2023 04:53:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Fri, 13 Jan 2023 04:53:28 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 90CFA3F705E;
        Fri, 13 Jan 2023 04:53:28 -0800 (PST)
From:   Wojciech Zmuda <wzmuda@marvell.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <sgoutham@marvell.com>,
        <devicetree@vger.kernel.org>,
        Wojciech Bartczak <wbartczak@marvell.com>,
        Sujeet Baranwal <sbaranwal@marvell.com>,
        Wojciech Zmuda <wzmuda@marvell.com>
Subject: [PATCH v3 1/2] mailbox: marvell-mhu: add Marvell MHU
Date:   Fri, 13 Jan 2023 04:53:22 -0800
Message-ID: <20230113125323.3744-2-wzmuda@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113125323.3744-1-wzmuda@marvell.com>
References: <20230113125323.3744-1-wzmuda@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ryHnjI0ndPmhFk1YGlAclq_dri6AC5e2
X-Proofpoint-GUID: ryHnjI0ndPmhFk1YGlAclq_dri6AC5e2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_05,2023-01-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wojciech Bartczak <wbartczak@marvell.com>

Add driver for Marvell OcteonTX and OcteonTX2 Messaging Handling
Unit mailbox driver. It supports communication with SCP using
SCMI and AVS protocols. The driver supports two channels for
ARM SCMI protocol. Aside SCMI, the AVS events are supported.

SCP is AVS bus master regulating the VRM. In case of an error
detected on AVS bus during the periodic communication from SCP
to VRM, erros are anticipated. SCP now raises an interrupt to
AP in case of any such error detected.

At this moment, interrupts are being raised by SCP to AP in case
of a SCMI work being completed or AVS failure being detected but
the code has been architected in a scalable way to  accommodate
any number of interrupt sources.

Signed-off-by: Sujeet Baranwal <sbaranwal@marvell.com>
Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
Signed-off-by: Wojciech Zmuda <wzmuda@marvell.com>
---
 MAINTAINERS                   |   8 +
 drivers/mailbox/Kconfig       |  10 ++
 drivers/mailbox/Makefile      |   2 +
 drivers/mailbox/marvell_mhu.c | 295 ++++++++++++++++++++++++++++++++++
 4 files changed, 315 insertions(+)
 create mode 100644 drivers/mailbox/marvell_mhu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7af5cd38d7c1..57db5055cdd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11322,6 +11322,14 @@ S:	Supported
 F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 F:	drivers/mmc/host/sdhci-xenon*
 
+MARVELL MESSAGE HANDLING UNIT DRIVER
+M:	Sujeet Baranwal <sbaranwal@marvell.com>
+M:	Sunil Goutham <sgoutham@marvell.com>
+M:	Wojciech Bartczak <wbartczak@marvell.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/mailbox/marvell_mhu.c
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev@vger.kernel.org
 S:	Orphan
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c9fc06c7e685..af916007db2c 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -160,6 +160,16 @@ config MAILBOX_TEST
 	  Test client to help with testing new Controller driver
 	  implementations.
 
+config MARVELL_MHU
+	tristate "Marvell Message Handling Unit"
+	depends on OF
+	help
+	  This driver adds support for Marvell MHU controller.
+	  The MHU mailbox is used by SCMI for OcteonTX and OcteonTX2
+	  to control various aspects of platform operation like cpufreq
+	  or sensors. The controller supports single channel to SCP.
+	  Say Y here to build this module. If unsure say N.
+
 config POLARFIRE_SOC_MAILBOX
 	tristate "PolarFire SoC (MPFS) Mailbox"
 	depends on HAS_IOMEM
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index c2089f04887e..50468444123b 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -41,6 +41,8 @@ obj-$(CONFIG_BCM_PDC_MBOX)	+= bcm-pdc-mailbox.o
 
 obj-$(CONFIG_BCM_FLEXRM_MBOX)	+= bcm-flexrm-mailbox.o
 
+obj-$(CONFIG_MARVELL_MHU)	+= marvell_mhu.o
+
 obj-$(CONFIG_POLARFIRE_SOC_MAILBOX)	+= mailbox-mpfs.o
 
 obj-$(CONFIG_QCOM_APCS_IPC)	+= qcom-apcs-ipc-mailbox.o
diff --git a/drivers/mailbox/marvell_mhu.c b/drivers/mailbox/marvell_mhu.c
new file mode 100644
index 000000000000..82f9f9eefe55
--- /dev/null
+++ b/drivers/mailbox/marvell_mhu.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Marvell Message Handling Unit
+ *
+ * Copyright (c) 2023 Marvell
+ *
+ * https://spdx.org/licenses/GPL-2.0-only.html
+ */
+
+#define DRIVER_NAME	"marvell-mhu"
+
+#define pr_fmt(fmt)	DRIVER_NAME ": " fmt
+
+
+#include <linux/pci.h>
+#include <linux/acpi.h>
+#include <linux/mailbox_controller.h>
+
+#define BAR0		0
+#define SCP_INDEX	0x0
+#define DEV_AP0		0x2
+#define SCP_TO_AP_INTERRUPT	2
+#define INT_VECS_MIN	0
+#define INT_VECS_MAX	3
+
+#define XCPX_DEVY_XCP_MBOX_LINT_OFFSET	0x000E1C00
+#define XCP_TO_DEV_XCP_MBOX_LINT(xcp_core, device_id)  \
+	(XCPX_DEVY_XCP_MBOX_LINT_OFFSET | \
+	((uint64_t)(xcp_core) << 36) | \
+	((uint64_t)(device_id) << 4))
+
+#define AP0_TO_SCP_MBOX_LINT    XCP_TO_DEV_XCP_MBOX_LINT(SCP_INDEX, DEV_AP0)
+
+/*
+ * Doorbell-Register: XCP(0..1)_DEV(0..7)_XCP_MBOX
+ * Communication data from devices to XCP. When written, sets
+ * XCP(0..1)_DEV(0..7)_XCP_MBOX.
+ * PS: it doesn't matter what is written into this register,
+ * Attempting to writing 'anything' would cause an interrupt
+ * to the target!
+ */
+
+#define XCPX_DEVY_XCP_MBOX_OFFSET	0x000E1000
+#define XCP_TO_DEV_XCP_MBOX(xcp_core, device_id) \
+	(XCPX_DEVY_XCP_MBOX_OFFSET | \
+	((uint64_t)(xcp_core) << 36) | \
+	((uint64_t)(device_id) << 4))
+
+/* AP0-to-SCP doorbell */
+#define AP0_TO_SCP_MBOX         XCP_TO_DEV_XCP_MBOX(SCP_INDEX, DEV_AP0)
+
+/*  Register offset: Enable interrupt from SCP to AP */
+#define XCP0_XCP_DEV0_MBOX_RINT_ENA_W1S	0x000D1C40
+#define XCP0_XCP_DEV1_MBOX_RINT_ENA_W1S	0x000D1C50
+#define XCP0_XCP_DEV2_MBOX_RINT_ENA_W1S	0x000D1C60
+#define XCP0_XCP_DEV3_MBOX_RINT_ENA_W1S	0x000D1C70
+
+/* Rx interrupt from SCP to Non-secure AP (linux kernel) */
+#define XCPX_XCP_DEVY_MBOX_RINT_OFFSET 0x000D1C00
+#define XCPX_XCP_DEVY_MBOX_RINT(xcp_core, device_id) \
+	(XCPX_XCP_DEVY_MBOX_RINT_OFFSET | \
+	((uint64_t)(xcp_core) << 36) | \
+	((uint64_t)(device_id) << 4))
+
+/* The interrupt status register */
+#define SCP_TO_AP0_MBOX_RINT  XCPX_XCP_DEVY_MBOX_RINT(SCP_INDEX, DEV_AP0)
+
+#define XCPX_XCP_DEVY_MBOX_RINT_OFFSET	0x000D1C00
+#define XCPX_XCP_DEVY_MBOX_RINT(xcp_core, device_id) \
+	(XCPX_XCP_DEVY_MBOX_RINT_OFFSET | \
+	((uint64_t)(xcp_core) << 36) | \
+	((uint64_t)(device_id) << 4))
+
+#define SCP_TO_AP0_MBOX_RINT  XCPX_XCP_DEVY_MBOX_RINT(SCP_INDEX, DEV_AP0)
+#define SCP_TO_DEV0 XCPX_XCP_DEVY_MBOX_RINT(0, 0)
+#define SCP_TO_DEV1 XCPX_XCP_DEVY_MBOX_RINT(0, 1)
+#define SCP_TO_DEV2 XCPX_XCP_DEVY_MBOX_RINT(0, 2)
+#define SCP_TO_DEV3 XCPX_XCP_DEVY_MBOX_RINT(0, 3)
+
+struct mhu {
+	struct device *dev;
+
+	/* SCP link information */
+	void __iomem *base; /* tx_reg, rx_reg */
+	struct mbox_chan *chan;
+};
+
+static irqreturn_t mhu_rx_interrupt(int irq, void *p)
+{
+	struct mhu *mhu = (struct mhu *)p;
+	u64 val;
+
+	/* Read interrupt status register */
+	val = readq_relaxed(mhu->base + SCP_TO_AP0_MBOX_RINT);
+	if (val) {
+		/* Clear the interrupt : Write on clear */
+		writeq_relaxed(1ul, mhu->base + SCP_TO_AP0_MBOX_RINT);
+		/* Poke mbox */
+		mbox_chan_received_data(mhu->chan, (void *)&val);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int mhu_send_data(struct mbox_chan *chan, void *data)
+{
+	const u64 doorbell = 0xff;  /* Arbitrary value, SCP requires a value */
+	struct mhu *mhu = chan->con_priv;
+
+	/* signal SCP */
+	iowrite64(doorbell, mhu->base + AP0_TO_SCP_MBOX);
+
+	return 0;
+}
+
+static bool mhu_last_tx_done(struct mbox_chan *chan)
+{
+	struct mhu *mhu = chan->con_priv;
+	u64 status;
+
+	status = ioread64(mhu->base + XCPX_XCP_DEVY_MBOX_RINT(0, 2));
+
+	return status != 0;
+}
+
+static int mhu_startup(struct mbox_chan *chan)
+{
+	struct mhu *mhu = chan->con_priv;
+
+	/* Enable interrupts only if there is client for data */
+	writeq_relaxed(1ul, mhu->base + XCP0_XCP_DEV2_MBOX_RINT_ENA_W1S);
+
+	return 0;
+}
+
+/* Define operations related to mbox */
+static const struct mbox_chan_ops mhu_chan_ops = {
+	.startup = mhu_startup,
+	.send_data = mhu_send_data,
+	.last_tx_done = mhu_last_tx_done,
+};
+
+static struct mbox_chan mhu_chan = {};
+
+static struct mbox_controller mhu_mbox_ctrl = {
+	.chans = &mhu_chan,
+	.num_chans = 1,
+	.txdone_irq = false,
+	.txdone_poll = true,
+	.txpoll_period = 100,
+	.ops = &mhu_chan_ops,
+};
+
+static int mhu_setup_mbox(struct device *dev)
+{
+	struct mhu *mhu;
+	struct mbox_chan *chan;
+
+	mhu = dev_get_drvdata(dev);
+
+	chan = &mhu_mbox_ctrl.chans[0];
+	chan->con_priv = mhu;
+	mhu->chan = chan;
+	mhu_mbox_ctrl.dev = dev;
+
+	return mbox_controller_register(&mhu_mbox_ctrl);
+}
+
+static int mhu_setup_irq(struct pci_dev *pdev)
+{
+	struct device *dev;
+	struct mhu *mhu;
+	int irq, ret, nvec;
+
+	mhu = pci_get_drvdata(pdev);
+	dev = &pdev->dev;
+
+	nvec = pci_alloc_irq_vectors(pdev, INT_VECS_MIN, INT_VECS_MAX, PCI_IRQ_MSIX);
+	if (nvec < 0)
+		return nvec;
+
+	irq = pci_irq_vector(pdev, SCP_TO_AP_INTERRUPT);
+	if (irq < 0) {
+		ret = irq;
+		goto irq_err;
+	}
+
+	ret = devm_request_irq(dev, irq, mhu_rx_interrupt, 0, "mvl-mhu", mhu);
+	if (ret)
+		goto irq_err;
+
+	return 0;
+
+irq_err:
+	pci_free_irq_vectors(pdev);
+
+	return ret;
+}
+
+static const struct of_device_id mhu_dt_ids[] = {
+	{ .compatible = "marvell,octeontx-mhu" },
+	{ .compatible = "marvell,octeontx2-mhu" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mhu_dt_ids);
+
+static const struct pci_device_id mhu_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xA067) },
+	{ 0 },
+};
+MODULE_DEVICE_TABLE(pci, mhu_ids);
+
+
+static int mhu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct mhu *mhu;
+	struct device *dev;
+	int ret;
+
+	/* This driver doesn't support ACPI */
+	if (!acpi_disabled)
+		return -ENODEV;
+
+	dev = &pdev->dev;
+	/* Enable only configured instances */
+	if (!dev->of_node)
+		return -ENODEV;
+	if (!of_match_node(mhu_dt_ids, dev->of_node))
+		return -EINVAL;
+
+	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
+	if (!mhu)
+		return -ENOMEM;
+
+	/* Enable PCI device */
+	pci_set_drvdata(pdev, mhu);
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = pci_request_region(pdev, BAR0, DRIVER_NAME);
+	if (ret)
+		return ret;
+
+	mhu->base = pcim_iomap(pdev, BAR0, pci_resource_len(pdev, BAR0));
+	if (!mhu->base)
+		return -EINVAL;
+
+	/* Configure IRQ from SCP to AP */
+	ret = mhu_setup_irq(pdev);
+	if (ret)
+		goto irq_err;
+	/* Configure mbox controller */
+	ret = mhu_setup_mbox(dev);
+	if (!ret) /* Success */
+		return 0;
+
+	/* In case of error, release the resources */
+	pci_free_irq_vectors(pdev);
+irq_err:
+	pci_release_region(pdev, BAR0);
+
+	return ret;
+}
+
+static void mhu_remove(struct pci_dev *pdev)
+{
+	struct mhu *mhu;
+
+	mhu = pci_get_drvdata(pdev);
+	mbox_controller_unregister(&mhu_mbox_ctrl);
+
+	pci_free_irq_vectors(pdev);
+	pcim_iounmap(pdev, mhu->base);
+	pci_release_region(pdev, BAR0);
+}
+
+static struct pci_driver mhu_driver = {
+	.name = DRIVER_NAME,
+	.id_table = mhu_ids,
+	.probe = mhu_probe,
+	.remove = mhu_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = mhu_dt_ids,
+	},
+};
+
+module_pci_driver(mhu_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Marvell Message Handling Unit");
+MODULE_AUTHOR("Sujeet Baranwal <sbaranwal@marvell.com>");
+MODULE_AUTHOR("Wojciech Bartczak <wbartczak@marvell.com>");
-- 
2.17.1

