Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0CB5F6067
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJFFFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJFFFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:05:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290F61758D;
        Wed,  5 Oct 2022 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665032708; x=1696568708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/RVgDAix4hRDbTOVoBEsgxdvhxOVT171OOwhxnBVyRo=;
  b=WC3FY9t8WyBtm81YOvsaT/Mu1g0G5MI488l7BVn8+3yZy730CB111FM1
   Lu9bbgnAi476KXZ/EhURxbxishR0ULEguZeF4wk7zZx/Nyq0xnX7cDT/I
   2kTS2kUylPYaIUmsF4uMQCDA+PhwVCqfYJIm8vZP1OD2nvZFfyh2yiUQy
   Mum/1Zrncd3rYa/7n97aoxhv4+JLvLd8RU/STdRcH4G7fmusGbyaNL5eK
   ky9CcRfnGSxfWQw+FpE3WEOxiYoSTWBK+8TjmWRrXqvxhGyaFLqlD2aHk
   h8Kg00aNHR8NIlL2ORPT0LNhSS1H5O6443kRFyfCIBVBqcT/mID+2DfBG
   g==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="177283752"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2022 22:05:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 5 Oct 2022 22:05:06 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 5 Oct 2022 22:05:05 -0700
From:   Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
To:     <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2 SPI for-next 1/2] spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX PCIe switch
Date:   Thu, 6 Oct 2022 10:35:13 +0530
Message-ID: <20221006050514.115564-2-tharunkumar.pasumarthi@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006050514.115564-1-tharunkumar.pasumarthi@microchip.com>
References: <20221006050514.115564-1-tharunkumar.pasumarthi@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
downstream ports. SPI is one of the functions in the multi-function endpoint. This
function has 2 SPI masters, operates at a maximum frequency of 30 MHz and supports
7 client devices per master. This patch adds complete functionality to the SPI
function except for suspend and resume.

Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>

---
 drivers/spi/Kconfig        |   9 +
 drivers/spi/Makefile       |   1 +
 drivers/spi/spi-pci1xxxx.c | 397 +++++++++++++++++++++++++++++++++++++
 3 files changed, 407 insertions(+)
 create mode 100644 drivers/spi/spi-pci1xxxx.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9987c3f2bd1c..08ca811440f9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -701,6 +701,15 @@ config SPI_ORION
 	  This enables using the SPI master controller on the Orion
 	  and MVEBU chips.
 
+config SPI_PCI1XXXX
+	tristate "PCI1XXXX SPI Bus support"
+	depends on PCI
+	help
+	  Say "yes" to Enable the SPI Bus support for the PCI1xxxx card
+	  This is a PCI to SPI Bus driver
+	  This driver can be built as module. If so, the module will be
+	  called as spi-pci1xxxx.
+
 config SPI_PIC32
 	tristate "Microchip PIC32 series SPI"
 	depends on MACH_PIC32 || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 15d2f3835e45..b75fa3988f96 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_SPI_OMAP_100K)		+= spi-omap-100k.o
 obj-$(CONFIG_SPI_OMAP24XX)		+= spi-omap2-mcspi.o
 obj-$(CONFIG_SPI_TI_QSPI)		+= spi-ti-qspi.o
 obj-$(CONFIG_SPI_ORION)			+= spi-orion.o
+obj-$(CONFIG_SPI_PCI1XXXX)		+= spi-pci1xxxx.o
 obj-$(CONFIG_SPI_PIC32)			+= spi-pic32.o
 obj-$(CONFIG_SPI_PIC32_SQI)		+= spi-pic32-sqi.o
 obj-$(CONFIG_SPI_PL022)			+= spi-pl022.o
diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
new file mode 100644
index 000000000000..958503a4d911
--- /dev/null
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0
+// PCI1xxxx SPI driver
+// Copyright (C) 2022 Microchip Technology Inc.
+// Authors: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
+//          Kumaravel Thiagarajan <Kumaravel.Thiagarajan@microchip.com>
+
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
+
+#define DRV_NAME "spi-pci1xxxx"
+
+#define	SYS_FREQ_DEFAULT		(62500000)
+
+#define	PCI1XXXX_SPI_MAX_CLOCK_HZ	(30000000)
+#define	PCI1XXXX_SPI_CLK_20MHZ		(20000000)
+#define	PCI1XXXX_SPI_CLK_15MHZ		(15000000)
+#define	PCI1XXXX_SPI_CLK_12MHZ		(12000000)
+#define	PCI1XXXX_SPI_CLK_10MHZ		(10000000)
+#define	PCI1XXXX_SPI_MIN_CLOCK_HZ	(2000000)
+
+#define	PCI1XXXX_SPI_BUFFER_SIZE	(320)
+
+#define	SPI_MST_CTL_DEVSEL_MASK		(GENMASK(27, 25))
+#define	SPI_MST_CTL_CMD_LEN_MASK	(GENMASK(16, 8))
+#define	SPI_MST_CTL_SPEED_MASK		(GENMASK(7, 5))
+#define	SPI_MSI_VECTOR_SEL_MASK		(GENMASK(4, 4))
+
+#define	SPI_MST_CTL_FORCE_CE		(BIT(4))
+#define	SPI_MST_CTL_MODE_SEL		(BIT(2))
+#define	SPI_MST_CTL_GO			(BIT(0))
+
+#define	SPI_MST1_ADDR_BASE		(0x800)
+
+/* x refers to SPI Host Controller HW instance id in the below macros - 0 or 1 */
+
+#define	SPI_MST_CMD_BUF_OFFSET(x)		(((x) * SPI_MST1_ADDR_BASE) + 0x00)
+#define	SPI_MST_RSP_BUF_OFFSET(x)		(((x) * SPI_MST1_ADDR_BASE) + 0x200)
+#define	SPI_MST_CTL_REG_OFFSET(x)		(((x) * SPI_MST1_ADDR_BASE) + 0x400)
+#define	SPI_MST_EVENT_REG_OFFSET(x)		(((x) * SPI_MST1_ADDR_BASE) + 0x420)
+#define	SPI_MST_EVENT_MASK_REG_OFFSET(x)	(((x) * SPI_MST1_ADDR_BASE) + 0x424)
+#define	SPI_MST_PAD_CTL_REG_OFFSET(x)		(((x) * SPI_MST1_ADDR_BASE) + 0x460)
+#define	SPIALERT_MST_DB_REG_OFFSET(x)		(((x) * SPI_MST1_ADDR_BASE) + 0x464)
+#define	SPIALERT_MST_VAL_REG_OFFSET(x)		(((x) * SPI_MST1_ADDR_BASE) + 0x468)
+#define	SPI_PCI_CTRL_REG_OFFSET(x)		(((x) * SPI_MST1_ADDR_BASE) + 0x480)
+
+#define PCI1XXXX_IRQ_FLAGS			(IRQF_NO_SUSPEND | IRQF_TRIGGER_NONE)
+#define SPI_MAX_DATA_LEN			320
+
+#define PCI1XXXX_SPI_TIMEOUT			(msecs_to_jiffies(100))
+
+#define SPI_INTR		BIT(8)
+#define SPI_FORCE_CE		BIT(4)
+
+#define SPI_CHIP_SEL_COUNT 7
+#define VENDOR_ID_MCHP 0x1055
+
+struct pci1xxxx_spi_internal {
+	u8 hw_inst;
+	bool spi_xfer_in_progress;
+	int irq;
+	struct completion spi_xfer_done;
+	struct spi_master *spi_host;
+	struct pci1xxxx_spi *parent;
+	struct {
+		unsigned int dev_sel : 3;
+		unsigned int msi_vector_sel : 1;
+	} prev_val;
+};
+
+struct pci1xxxx_spi {
+	struct pci_dev *dev;
+	u8 total_hw_instances;
+	void __iomem *reg_base;
+	struct pci1xxxx_spi_internal *spi_int[];
+};
+
+static const struct pci_device_id pci1xxxx_spi_pci_id_table[] = {
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, 0x0001), 0, 0, 0x02},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, 0x0002), 0, 0, 0x01},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, 0x0003), 0, 0, 0x11},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, PCI_ANY_ID), 0, 0, 0x01},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, 0x0001), 0, 0, 0x02},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, 0x0002), 0, 0, 0x01},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, 0x0003), 0, 0, 0x11},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, PCI_ANY_ID), 0, 0, 0x01},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, 0x0001), 0, 0, 0x02},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, 0x0002), 0, 0, 0x01},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, 0x0003), 0, 0, 0x11},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, PCI_ANY_ID), 0, 0, 0x01},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, 0x0001), 0, 0, 0x02},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, 0x0002), 0, 0, 0x01},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, 0x0003), 0, 0, 0x11},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, PCI_ANY_ID), 0, 0, 0x01},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, 0x0001), 0, 0, 0x02},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, 0x0002), 0, 0, 0x01},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, 0x0003), 0, 0, 0x11},
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, PCI_ANY_ID), 0, 0, 0x01},
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, pci1xxxx_spi_pci_id_table);
+
+static void pci1xxxx_spi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi->controller);
+	struct pci1xxxx_spi *par = p->parent;
+	u32 regval;
+
+	/* Set the DEV_SEL bits of the SPI_MST_CTL_REG */
+	regval = readl(par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
+	if (enable) {
+		regval &= ~SPI_MST_CTL_DEVSEL_MASK;
+		regval |= (spi->chip_select << 25);
+		writel(regval,
+		       par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
+	} else {
+		regval &= ~(spi->chip_select << 25);
+		writel(regval,
+		       par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
+
+	}
+}
+
+static u8 pci1xxxx_get_clock_div(u32 hz)
+{
+	u8 val = 0;
+
+	if (hz >= PCI1XXXX_SPI_MAX_CLOCK_HZ)
+		val = 2;
+	else if ((hz < PCI1XXXX_SPI_MAX_CLOCK_HZ) && (hz >= PCI1XXXX_SPI_CLK_20MHZ))
+		val = 3;
+	else if ((hz < PCI1XXXX_SPI_CLK_20MHZ) && (hz >= PCI1XXXX_SPI_CLK_15MHZ))
+		val = 4;
+	else if ((hz < PCI1XXXX_SPI_CLK_15MHZ) && (hz >= PCI1XXXX_SPI_CLK_12MHZ))
+		val = 5;
+	else if ((hz < PCI1XXXX_SPI_CLK_12MHZ) && (hz >= PCI1XXXX_SPI_CLK_10MHZ))
+		val = 6;
+	else if ((hz < PCI1XXXX_SPI_CLK_10MHZ) && (hz >= PCI1XXXX_SPI_MIN_CLOCK_HZ))
+		val = 7;
+	else
+		val = 2;
+
+	return val;
+}
+
+static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
+				     struct spi_device *spi, struct spi_transfer *xfer)
+{
+	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi_ctlr);
+	int mode, len, loop_iter, transfer_len;
+	struct pci1xxxx_spi *par = p->parent;
+	unsigned long bytes_transfered;
+	unsigned long bytes_recvd;
+	unsigned long loop_count;
+	u8 *rx_buf, result;
+	const u8 *tx_buf;
+	u32 regval;
+	u8 clkdiv;
+
+	p->spi_xfer_in_progress = true;
+	mode = spi->mode;
+	clkdiv = pci1xxxx_get_clock_div(xfer->speed_hz);
+	tx_buf = xfer->tx_buf;
+	rx_buf = xfer->rx_buf;
+	transfer_len = xfer->len;
+	regval = readl(par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
+	writel(regval, par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
+
+	if (tx_buf) {
+		bytes_transfered = 0;
+		bytes_recvd = 0;
+		loop_count = transfer_len / SPI_MAX_DATA_LEN;
+		if (transfer_len % SPI_MAX_DATA_LEN != 0)
+			loop_count += 1;
+
+		for (loop_iter = 0; loop_iter < loop_count; loop_iter++) {
+			len = SPI_MAX_DATA_LEN;
+			if ((transfer_len % SPI_MAX_DATA_LEN != 0) &&
+			    (loop_iter == loop_count - 1))
+				len = transfer_len % SPI_MAX_DATA_LEN;
+
+			reinit_completion(&p->spi_xfer_done);
+			memcpy_toio(par->reg_base + SPI_MST_CMD_BUF_OFFSET(p->hw_inst),
+				    &tx_buf[bytes_transfered], len);
+			bytes_transfered += len;
+			regval = readl(par->reg_base +
+				       SPI_MST_CTL_REG_OFFSET(p->hw_inst));
+			regval &= ~(SPI_MST_CTL_MODE_SEL | SPI_MST_CTL_CMD_LEN_MASK |
+				    SPI_MST_CTL_SPEED_MASK);
+
+			if (mode == SPI_MODE_3)
+				regval |= SPI_MST_CTL_MODE_SEL;
+			else
+				regval &= ~SPI_MST_CTL_MODE_SEL;
+
+			regval |= ((clkdiv << 5) | SPI_FORCE_CE | (len << 8));
+			regval &= ~SPI_MST_CTL_CMD_LEN_MASK;
+			writel(regval, par->reg_base +
+			       SPI_MST_CTL_REG_OFFSET(p->hw_inst));
+			regval = readl(par->reg_base +
+				       SPI_MST_CTL_REG_OFFSET(p->hw_inst));
+			regval |= SPI_MST_CTL_GO;
+			writel(regval, par->reg_base +
+			       SPI_MST_CTL_REG_OFFSET(p->hw_inst));
+
+			/* Wait for DMA_TERM interrupt */
+			result = wait_for_completion_timeout(&p->spi_xfer_done,
+							     PCI1XXXX_SPI_TIMEOUT);
+			if (!result)
+				return -ETIMEDOUT;
+
+			if (rx_buf) {
+				memcpy_fromio(&rx_buf[bytes_recvd], par->reg_base +
+					      SPI_MST_RSP_BUF_OFFSET(p->hw_inst), len);
+				bytes_recvd += len;
+			}
+		}
+	}
+
+	regval = readl(par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
+	regval &= ~SPI_FORCE_CE;
+	writel(regval, par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
+	p->spi_xfer_in_progress = false;
+
+	return 0;
+}
+
+static irqreturn_t pci1xxxx_spi_isr(int irq, void *dev)
+{
+	struct pci1xxxx_spi_internal *p = dev;
+	irqreturn_t spi_int_fired = IRQ_NONE;
+	u32 regval;
+
+	/* Clear the SPI GO_BIT Interrupt */
+	regval = readl(p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
+	if (regval & SPI_INTR) {
+		/* Clear xfer_done */
+		complete(&p->spi_xfer_done);
+		spi_int_fired = IRQ_HANDLED;
+	}
+
+	writel(regval, p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
+
+	return spi_int_fired;
+}
+
+static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	u8 hw_inst_cnt, iter, start, only_sec_inst;
+	struct pci1xxxx_spi_internal *spi_sub_ptr;
+	struct device *dev = &pdev->dev;
+	struct pci1xxxx_spi *spi_bus;
+	struct spi_master *spi_host;
+	u32 regval;
+	int ret;
+
+	hw_inst_cnt = ent->driver_data & 0x0f;
+	start = (ent->driver_data & 0xf0) >> 4;
+	if (start == 1)
+		only_sec_inst = 1;
+	else
+		only_sec_inst = 0;
+
+	spi_bus = devm_kzalloc(&pdev->dev,
+			       struct_size(spi_bus, spi_int, hw_inst_cnt),
+			       GFP_KERNEL);
+	if (!spi_bus)
+		return -ENOMEM;
+
+	spi_bus->dev = pdev;
+	spi_bus->total_hw_instances = hw_inst_cnt;
+	pci_set_master(pdev);
+
+	for (iter = 0; iter < hw_inst_cnt; iter++) {
+		spi_bus->spi_int[iter] = devm_kzalloc(&pdev->dev,
+						      sizeof(struct pci1xxxx_spi_internal),
+						      GFP_KERNEL);
+		spi_sub_ptr = spi_bus->spi_int[iter];
+		spi_sub_ptr->spi_host = devm_spi_alloc_master(dev, sizeof(struct spi_master));
+		if (!spi_sub_ptr->spi_host)
+			return -ENOMEM;
+
+		spi_sub_ptr->parent = spi_bus;
+		spi_sub_ptr->spi_xfer_in_progress = false;
+
+		if (!iter) {
+			ret = pcim_enable_device(pdev);
+			if (ret)
+				return -ENOMEM;
+
+			ret = pci_request_regions(pdev, DRV_NAME);
+			if (ret)
+				return -ENOMEM;
+
+			spi_bus->reg_base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
+			if (!spi_bus->reg_base) {
+				ret = -EINVAL;
+				goto error;
+			}
+
+			ret = pci_alloc_irq_vectors(pdev, hw_inst_cnt, hw_inst_cnt,
+						    PCI_IRQ_ALL_TYPES);
+			if (ret < 0) {
+				dev_err(&pdev->dev, "Error allocating MSI vectors\n");
+				goto error;
+			}
+
+			init_completion(&spi_sub_ptr->spi_xfer_done);
+			/* Initialize Interrupts - SPI_INT */
+			regval = readl(spi_bus->reg_base +
+				       SPI_MST_EVENT_MASK_REG_OFFSET(spi_sub_ptr->hw_inst));
+			regval &= ~SPI_INTR;
+			writel(regval, spi_bus->reg_base +
+			       SPI_MST_EVENT_MASK_REG_OFFSET(spi_sub_ptr->hw_inst));
+			spi_sub_ptr->irq = pci_irq_vector(pdev, 0);
+
+			ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq,
+					       pci1xxxx_spi_isr, PCI1XXXX_IRQ_FLAGS,
+					       pci_name(pdev), spi_sub_ptr);
+			if (ret < 0) {
+				dev_err(&pdev->dev, "Unable to request irq : %d",
+					spi_sub_ptr->irq);
+				ret = -ENODEV;
+				goto error;
+			}
+
+			/* This register is only applicable for 1st instance */
+			regval = readl(spi_bus->reg_base + SPI_PCI_CTRL_REG_OFFSET(0));
+			if (!only_sec_inst)
+				regval |= (BIT(4));
+			else
+				regval &= ~(BIT(4));
+
+			writel(regval, spi_bus->reg_base + SPI_PCI_CTRL_REG_OFFSET(0));
+		}
+
+		spi_sub_ptr->hw_inst = start++;
+
+		if (iter == 1) {
+			init_completion(&spi_sub_ptr->spi_xfer_done);
+			/* Initialize Interrupts - SPI_INT */
+			regval = readl(spi_bus->reg_base +
+			       SPI_MST_EVENT_MASK_REG_OFFSET(spi_sub_ptr->hw_inst));
+			regval &= ~SPI_INTR;
+			writel(regval, spi_bus->reg_base +
+			       SPI_MST_EVENT_MASK_REG_OFFSET(spi_sub_ptr->hw_inst));
+			spi_sub_ptr->irq = pci_irq_vector(pdev, iter);
+			ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq,
+					       pci1xxxx_spi_isr, PCI1XXXX_IRQ_FLAGS,
+					       pci_name(pdev), spi_sub_ptr);
+			if (ret < 0) {
+				dev_err(&pdev->dev, "Unable to request irq : %d",
+					spi_sub_ptr->irq);
+				ret = -ENODEV;
+				goto error;
+			}
+		}
+
+		spi_host = spi_sub_ptr->spi_host;
+		spi_host->num_chipselect = SPI_CHIP_SEL_COUNT;
+		spi_host->mode_bits = SPI_MODE_0 | SPI_MODE_3 | SPI_RX_DUAL |
+				      SPI_TX_DUAL | SPI_LOOP;
+		spi_host->transfer_one = pci1xxxx_spi_transfer_one;
+		spi_host->set_cs = pci1xxxx_spi_set_cs;
+		spi_host->bits_per_word_mask = SPI_BPW_MASK(8);
+		spi_host->max_speed_hz = PCI1XXXX_SPI_MAX_CLOCK_HZ;
+		spi_host->min_speed_hz = PCI1XXXX_SPI_MIN_CLOCK_HZ;
+		spi_host->flags = SPI_MASTER_MUST_TX;
+		spi_master_set_devdata(spi_host, spi_sub_ptr);
+		ret = devm_spi_register_master(dev, spi_host);
+		if (ret)
+			goto error;
+	}
+	pci_set_drvdata(pdev, spi_bus);
+
+	return 0;
+
+error:
+	pci_release_regions(pdev);
+	return ret;
+}
+
+static struct pci_driver pci1xxxx_spi_driver = {
+	.name		= DRV_NAME,
+	.id_table	= pci1xxxx_spi_pci_id_table,
+	.probe		= pci1xxxx_spi_probe,
+};
+
+module_pci_driver(pci1xxxx_spi_driver);
+
+MODULE_DESCRIPTION("Microchip Technology Inc. pci1xxxx SPI bus driver");
+MODULE_AUTHOR("Tharun Kumar P<tharunkumar.pasumarthi@microchip.com>");
+MODULE_AUTHOR("Kumaravel Thiagarajan<kumaravel.thiagarajan@microchip.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

