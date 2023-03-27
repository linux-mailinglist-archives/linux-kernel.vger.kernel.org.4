Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816906CACBA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjC0SI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjC0SIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:08:20 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561D9B3;
        Mon, 27 Mar 2023 11:08:13 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RA6FpP010874;
        Mon, 27 Mar 2023 11:08:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=jvbRqIrffcgToqDJjevSrIjDQBRoZOjcO28Lu3COs3c=;
 b=bKabij+KTptXFJWd30jlrTC+oFCRemo415fUZzSM30Mx8K262eMgwj/yHlJUh/E92+87
 UXRUm7XbEBjBx7E85A7G6ognuHVEXHvsf9Qkbwqw4dZZvG31o6bUYxs0nasta1BrYmbY
 oSV2KH8fE2HF+0/OY760Qx4tjbjuFsTr3kZQNlXfJJEsKI3N9y4AFe/kUf6t6uHjAQKx
 Y8hfzjKdtY4uIv74bkzMo4pDwTuJ7e/XrSMdRhVpW/cYJQGqSozBV5JpomJHcK0y1VbX
 +G2p+U1ib+NkHy3VlBo69rDkVOrqaQZklJlTCU50z/h1CAfTfxWGu7TsKASIirqj7Fdd 4A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3phxas85u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 11:08:10 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 27 Mar
 2023 11:08:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 27 Mar 2023 11:08:08 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 866813F7088;
        Mon, 27 Mar 2023 11:08:08 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Suneel Garapati <sgarapati@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 1/2] spi: octeontx2: Add support for octeontx2 spi controller
Date:   Mon, 27 Mar 2023 11:07:52 -0700
Message-ID: <20230327180753.2279-2-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230327180753.2279-1-pmalgujar@marvell.com>
References: <20230327180753.2279-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3SR8YUpnc_4IImso-6yxM6Hi6cfrpa8z
X-Proofpoint-ORIG-GUID: 3SR8YUpnc_4IImso-6yxM6Hi6cfrpa8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suneel Garapati <sgarapati@marvell.com>

Enable use of spi controller on Marvell OcteonTX2 SoC's. This supports
for 1KB data buffer and 4-bit bus width.
Also, support for using fixed time base (TBI Clk) or system
clock (SCLK) as reference clock for SPI bus is provided using
module param tbi_clk_en with default value to 1 (TBI clk).

Signed-off-by: Suneel Garapati <sgarapati@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/spi/Kconfig         |   8 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-octeontx2.c | 378 ++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-octeontx2.h | 152 +++++++++++++++
 4 files changed, 539 insertions(+)
 create mode 100644 drivers/spi/spi-octeontx2.c
 create mode 100644 drivers/spi/spi-octeontx2.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 47bbba04fe3aedc667f54ce3ea930ff0361f6eeb..a81ec7e3532a923902f82d93c5a0c3f57b9bb277 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -694,6 +694,14 @@ config SPI_OCTEON
 	  SPI host driver for the hardware found on some Cavium OCTEON
 	  SOCs.
 
+config SPI_OCTEONTX2
+	tristate "Marvell OcteonTX2 SPI controller"
+	depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
+	help
+	  This driver supports the OcteonTX2 SPI controller in master
+	  mode. It supports single, dual and quad mode transfers.
+	  This controller hardware is found on Marvell OcteonTX2 SoCs.
+
 config SPI_OMAP_UWIRE
 	tristate "OMAP1 MicroWire"
 	depends on ARCH_OMAP1 || (ARM && COMPILE_TEST)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d87cf75bee6a45c4244a78f89c5c871bd0257555..64d4311e4cc529df401bd151b5f2e568c768ee24 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_SPI_NXP_FLEXSPI)		+= spi-nxp-fspi.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
 spi-octeon-objs				:= spi-cavium.o spi-cavium-octeon.o
 obj-$(CONFIG_SPI_OCTEON)		+= spi-octeon.o
+obj-$(CONFIG_SPI_OCTEONTX2)		+= spi-octeontx2.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)		+= spi-omap-uwire.o
 obj-$(CONFIG_SPI_OMAP24XX)		+= spi-omap2-mcspi.o
 obj-$(CONFIG_SPI_TI_QSPI)		+= spi-ti-qspi.o
diff --git a/drivers/spi/spi-octeontx2.c b/drivers/spi/spi-octeontx2.c
new file mode 100644
index 0000000000000000000000000000000000000000..80d9355d119de5486a1a3803f798dd0673b0adf1
--- /dev/null
+++ b/drivers/spi/spi-octeontx2.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Marvell OcteonTX2 SPI driver.
+ *
+ * Copyright (C) 2018 Marvell International Ltd.
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/spi/spi.h>
+
+#include "spi-octeontx2.h"
+
+#define DRV_NAME "spi-octeontx2"
+
+#define TBI_FREQ 100000000 /* 100 Mhz */
+#define SYS_FREQ_DEFAULT 700000000 /* 700 Mhz */
+
+static int tbi_clk_en = 1;
+module_param(tbi_clk_en, uint, 0644);
+MODULE_PARM_DESC(tbi_clk_en,
+		 "Use Fixed Time Base 100MHz Reference Clock (0=Disable, 1=Enable [default])");
+
+static int cfg_mode_delay = 30;
+module_param(cfg_mode_delay, uint, 0644);
+MODULE_PARM_DESC(cfg_mode_delay,
+		 "Delay in micro-seconds for mode change in MPI CFG register (30 [default])");
+
+static void octeontx2_spi_wait_ready(struct octeontx2_spi *p)
+{
+	union mpix_sts mpi_sts;
+	unsigned int loops = 0;
+
+	mpi_sts.u64 = 0;
+	do {
+		if (loops++)
+			__delay(500);
+		mpi_sts.u64 = readq(p->register_base + OCTEONTX2_SPI_STS(p));
+	} while (mpi_sts.s.busy);
+}
+
+static int octeontx2_spi_do_transfer(struct octeontx2_spi *p,
+				     struct spi_message *msg,
+				     struct spi_transfer *xfer,
+				     bool last_xfer,
+				     int cs)
+{
+	void __iomem *wbuf_ptr = p->register_base + OCTEONTX2_SPI_WBUF(p);
+	struct spi_device *spi = msg->spi;
+	void __iomem *rx_ptr = wbuf_ptr;
+	unsigned int clkdiv, calc_spd;
+	union mpix_xmit mpi_xmit;
+	union mpix_cfg mpi_cfg;
+	int mode, len, rem, i;
+	const u8 *tx_buf;
+	bool cpha, cpol;
+	u8 *rx_buf;
+
+	mode = spi->mode;
+	cpha = mode & SPI_CPHA;
+	cpol = mode & SPI_CPOL;
+
+	clkdiv = p->sys_freq / (2 * xfer->speed_hz);
+	/* Perform check to not exceed requested speed */
+	while (1) {
+		calc_spd = p->sys_freq / (2 * clkdiv);
+		if (calc_spd <= xfer->speed_hz)
+			break;
+		clkdiv += 1;
+	}
+
+	if (clkdiv > 8191 || (!tbi_clk_en && clkdiv == 1)) {
+		dev_err(&spi->dev,
+			"can't support xfer->speed_hz %d for reference clock %d\n",
+			xfer->speed_hz,	p->sys_freq);
+		return -EINVAL;
+	}
+
+	mpi_cfg.u64 = 0;
+	mpi_cfg.s.clkdiv = clkdiv;
+	mpi_cfg.s.cshi = (mode & SPI_CS_HIGH) ? 1 : 0;
+	mpi_cfg.s.lsbfirst = (mode & SPI_LSB_FIRST) ? 1 : 0;
+	mpi_cfg.s.wireor = (mode & SPI_3WIRE) ? 1 : 0;
+	mpi_cfg.s.idlelo = cpha != cpol;
+	mpi_cfg.s.cslate = cpha ? 1 : 0;
+	mpi_cfg.s.tritx = 1;
+	mpi_cfg.s.enable = 1;
+	mpi_cfg.s.cs_sticky = 1;
+	mpi_cfg.s.legacy_dis = 1;
+	if (tbi_clk_en)
+		mpi_cfg.s.tb100_en = 1;
+
+	/* Set x1 mode as default */
+	mpi_cfg.s.iomode = 0;
+	/* Set x2 mode if either tx or rx request dual */
+	if (xfer->tx_nbits == SPI_NBITS_DUAL ||
+	    xfer->rx_nbits == SPI_NBITS_DUAL)
+		mpi_cfg.s.iomode = 2;
+	/* Set x4 mode if either tx or rx request quad */
+	if (xfer->tx_nbits == SPI_NBITS_QUAD ||
+	    xfer->rx_nbits == SPI_NBITS_QUAD)
+		mpi_cfg.s.iomode = 3;
+
+	p->cs_enax |= (0xFull << 12);
+	mpi_cfg.u64 |= p->cs_enax;
+
+	if (mpi_cfg.u64 != p->last_cfg) {
+		p->last_cfg = mpi_cfg.u64;
+		writeq(mpi_cfg.u64, p->register_base + OCTEONTX2_SPI_CFG(p));
+		mpi_cfg.u64 = readq(p->register_base + OCTEONTX2_SPI_CFG(p));
+		udelay(cfg_mode_delay); /* allow CS change to settle */
+	}
+	tx_buf = xfer->tx_buf;
+	rx_buf = xfer->rx_buf;
+	len = xfer->len;
+
+	if (!mpi_cfg.s.iomode && p->rcvd_present)
+		rx_ptr = p->register_base + OCTEONTX2_SPI_RCVD(p);
+
+	while (len > OCTEONTX2_SPI_MAX_BYTES) {
+		if (tx_buf) {
+			/* 8 bytes per iteration */
+			for (i = 0; i < OCTEONTX2_SPI_MAX_BYTES / 8; i++) {
+				u64 data = *(uint64_t *)tx_buf;
+
+				tx_buf += 8;
+				writeq(data, wbuf_ptr + (8 * i));
+			}
+		}
+		mpi_xmit.u64 = 0;
+		mpi_xmit.s.csid = cs;
+		mpi_xmit.s.leavecs = 1;
+		mpi_xmit.s.txnum = tx_buf ? OCTEONTX2_SPI_MAX_BYTES : 0;
+		mpi_xmit.s.totnum = OCTEONTX2_SPI_MAX_BYTES;
+		writeq(mpi_xmit.u64, p->register_base + OCTEONTX2_SPI_XMIT(p));
+
+		octeontx2_spi_wait_ready(p);
+		if (rx_buf) {
+			/* 8 bytes per iteration */
+			for (i = 0; i < OCTEONTX2_SPI_MAX_BYTES / 8; i++) {
+				u64 v;
+
+				v = readq(rx_ptr + (8 * i));
+				*(uint64_t *)rx_buf = v;
+				rx_buf += 8;
+			}
+		}
+		len -= OCTEONTX2_SPI_MAX_BYTES;
+	}
+
+	rem = len % 8;
+
+	if (tx_buf) {
+		u64 data;
+		/* 8 bytes per iteration */
+		for (i = 0; i < len / 8; i++) {
+			data = *(uint64_t *)tx_buf;
+			tx_buf += 8;
+			writeq(data, wbuf_ptr + (8 * i));
+		}
+		/* remaining <8 bytes */
+		if (rem) {
+			data = 0;
+			memcpy(&data, tx_buf, rem);
+			writeq(data, wbuf_ptr + (8 * i));
+		}
+	}
+
+	mpi_xmit.u64 = 0;
+	mpi_xmit.s.csid = cs;
+	if (last_xfer)
+		mpi_xmit.s.leavecs = xfer->cs_change;
+	else
+		mpi_xmit.s.leavecs = !xfer->cs_change;
+	mpi_xmit.s.txnum = tx_buf ? len : 0;
+	mpi_xmit.s.totnum = len;
+	writeq(mpi_xmit.u64, p->register_base + OCTEONTX2_SPI_XMIT(p));
+
+	octeontx2_spi_wait_ready(p);
+	if (rx_buf) {
+		u64 v;
+		/* 8 bytes per iteration */
+		for (i = 0; i < len / 8; i++) {
+			v = readq(rx_ptr + (8 * i));
+			*(uint64_t *)rx_buf = v;
+			rx_buf += 8;
+		}
+		/* remaining <8 bytes */
+		if (rem) {
+			v = readq(rx_ptr + (8 * i));
+			memcpy(rx_buf, &v, rem);
+			rx_buf += rem;
+		}
+	}
+
+	spi_transfer_delay_exec(xfer);
+
+	return xfer->len;
+}
+
+int octeontx2_spi_transfer_one_message(struct spi_master *master,
+				       struct spi_message *msg)
+{
+	struct octeontx2_spi *p = spi_master_get_devdata(master);
+	int cs = msg->spi->chip_select;
+	unsigned int total_len = 0;
+	struct spi_transfer *xfer;
+	int status = 0;
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		bool last_xfer = list_is_last(&xfer->transfer_list,
+					      &msg->transfers);
+		int r = octeontx2_spi_do_transfer(p, msg, xfer, last_xfer, cs);
+
+		if (r < 0) {
+			status = r;
+			goto err;
+		}
+		total_len += r;
+	}
+err:
+	msg->status = status;
+	msg->actual_length = total_len;
+	spi_finalize_current_message(master);
+	return status;
+}
+
+static int octeontx2_spi_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_master *master;
+	struct octeontx2_spi *p;
+	union mpix_sts mpi_sts;
+	int ret = -ENOENT;
+
+	/* may need to hunt for devtree entry */
+	if (!pdev->dev.of_node) {
+		struct device_node *np = of_find_node_by_name(NULL, "spi");
+
+		if (IS_ERR(np)) {
+			ret = PTR_ERR(np);
+			goto error;
+		}
+		pdev->dev.of_node = np;
+		of_node_put(np);
+	}
+
+	master = spi_alloc_master(dev, sizeof(struct octeontx2_spi));
+	if (!master) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	p = spi_master_get_devdata(master);
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		goto error_put;
+
+	ret = pci_request_regions(pdev, DRV_NAME);
+	if (ret)
+		goto error_disable;
+
+	p->register_base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
+	if (!p->register_base) {
+		ret = -EINVAL;
+		goto error_disable;
+	}
+
+	p->regs.config = 0x1000;
+	p->regs.status = 0x1008;
+	p->regs.xmit = 0x1018;
+	p->regs.wbuf = 0x1800;
+	p->regs.rcvd = 0x2800;
+	p->last_cfg = 0x0;
+
+	mpi_sts.u64 = readq(p->register_base + OCTEONTX2_SPI_STS(p));
+	p->rcvd_present = mpi_sts.u64 & 0x4 ? true : false;
+
+	p->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(p->clk)) {
+		p->clk = devm_clk_get(dev, "sclk");
+		p->sys_freq = 0;
+	} else {
+		ret = clk_prepare_enable(p->clk);
+		if (!ret)
+			p->sys_freq = clk_get_rate(p->clk);
+	}
+
+	if (!p->sys_freq)
+		p->sys_freq = SYS_FREQ_DEFAULT;
+	if (tbi_clk_en)
+		p->sys_freq = TBI_FREQ;
+	dev_info(dev, "Reference clock is %u\n", p->sys_freq);
+
+	master->num_chipselect = 4;
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
+			    SPI_LSB_FIRST | SPI_3WIRE |
+			    SPI_TX_DUAL | SPI_RX_DUAL |
+			    SPI_TX_QUAD | SPI_RX_QUAD;
+	master->transfer_one_message = octeontx2_spi_transfer_one_message;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->max_speed_hz = OCTEONTX2_SPI_MAX_CLOCK_HZ;
+	master->dev.of_node = pdev->dev.of_node;
+
+	pci_set_drvdata(pdev, master);
+
+	ret = devm_spi_register_master(dev, master);
+	if (ret)
+		goto error_disable;
+
+	return 0;
+
+error_disable:
+	clk_disable_unprepare(p->clk);
+error_put:
+	spi_master_put(master);
+error:
+	return ret;
+}
+
+static void octeontx2_spi_remove(struct pci_dev *pdev)
+{
+	struct spi_master *master = pci_get_drvdata(pdev);
+	struct octeontx2_spi *p;
+
+	p = spi_master_get_devdata(master);
+	/* Put everything in a known state. */
+	if (p) {
+		clk_disable_unprepare(p->clk);
+		writeq(0, p->register_base + OCTEONTX2_SPI_CFG(p));
+	}
+
+	pci_disable_device(pdev);
+	spi_master_put(master);
+}
+
+static const struct pci_device_id octeontx2_spi_pci_id_table[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM,
+			 PCI_DEVID_OCTEONTX2_SPI,
+			 PCI_VENDOR_ID_CAVIUM,
+			 PCI_SUBSYS_DEVID_OTX2_98XX) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM,
+			 PCI_DEVID_OCTEONTX2_SPI,
+			 PCI_VENDOR_ID_CAVIUM,
+			 PCI_SUBSYS_DEVID_OTX2_96XX) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM,
+			 PCI_DEVID_OCTEONTX2_SPI,
+			 PCI_VENDOR_ID_CAVIUM,
+			 PCI_SUBSYS_DEVID_OTX2_95XX) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM,
+			 PCI_DEVID_OCTEONTX2_SPI,
+			 PCI_VENDOR_ID_CAVIUM,
+			 PCI_SUBSYS_DEVID_OTX2_LOKI) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM,
+			 PCI_DEVID_OCTEONTX2_SPI,
+			 PCI_VENDOR_ID_CAVIUM,
+			 PCI_SUBSYS_DEVID_OTX2_95MM) },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, octeontx2_spi_pci_id_table);
+
+static struct pci_driver octeontx2_spi_driver = {
+	.name		= DRV_NAME,
+	.id_table	= octeontx2_spi_pci_id_table,
+	.probe		= octeontx2_spi_probe,
+	.remove		= octeontx2_spi_remove,
+};
+
+module_pci_driver(octeontx2_spi_driver);
+
+MODULE_DESCRIPTION("OcteonTX2 SPI bus driver");
+MODULE_AUTHOR("Marvell Inc.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-octeontx2.h b/drivers/spi/spi-octeontx2.h
new file mode 100644
index 0000000000000000000000000000000000000000..3b09a735e8575faaf59a4562ee16632754764c09
--- /dev/null
+++ b/drivers/spi/spi-octeontx2.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SPI_OCTEONTX2_H
+#define __SPI_OCTEONTX2_H
+
+#include <linux/clk.h>
+
+#define PCI_DEVID_OCTEONTX2_SPI 0xA00B
+#define PCI_SUBSYS_DEVID_OTX2_98XX 0xB100
+#define PCI_SUBSYS_DEVID_OTX2_96XX 0xB200
+#define PCI_SUBSYS_DEVID_OTX2_95XX 0xB300
+#define PCI_SUBSYS_DEVID_OTX2_LOKI 0xB400
+#define PCI_SUBSYS_DEVID_OTX2_95MM 0xB500
+
+#define OCTEONTX2_SPI_MAX_BYTES 1024
+#define OCTEONTX2_SPI_MAX_CLOCK_HZ 25000000
+
+struct octeontx2_spi_regs {
+	int config;
+	int status;
+	int xmit;
+	int wbuf;
+	int rcvd;
+};
+
+struct octeontx2_spi {
+	void __iomem *register_base;
+	u64 last_cfg;
+	u64 cs_enax;
+	int sys_freq;
+	bool rcvd_present;
+	struct octeontx2_spi_regs regs;
+	struct clk *clk;
+};
+
+#define OCTEONTX2_SPI_CFG(x)	((x)->regs.config)
+#define OCTEONTX2_SPI_STS(x)	((x)->regs.status)
+#define OCTEONTX2_SPI_XMIT(x)	((x)->regs.xmit)
+#define OCTEONTX2_SPI_WBUF(x)	((x)->regs.wbuf)
+#define OCTEONTX2_SPI_RCVD(x)	((x)->regs.rcvd)
+
+int octeontx2_spi_transfer_one_message(struct spi_master *master,
+				       struct spi_message *msg);
+
+union mpix_cfg {
+	u64 u64;
+	struct mpix_cfg_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_50_63:14;
+		uint64_t tb100_en:1;
+		uint64_t reserved_48:1;
+		uint64_t cs_espi_en:4;
+		uint64_t reserved_36_43:8;
+		uint64_t iomode:2;
+		uint64_t reserved_32_33:2;
+		uint64_t legacy_dis:1;
+		uint64_t reserved_29_30:2;
+		uint64_t clkdiv:13;
+		uint64_t csena3:1;
+		uint64_t csena2:1;
+		uint64_t csena1:1;
+		uint64_t csena0:1;
+		uint64_t cslate:1;
+		uint64_t tritx:1;
+		uint64_t idleclks:2;
+		uint64_t cshi:1;
+		uint64_t reserved_6:1;
+		uint64_t cs_sticky:1;
+		uint64_t lsbfirst:1;
+		uint64_t wireor:1;
+		uint64_t clk_cont:1;
+		uint64_t idlelo:1;
+		uint64_t enable:1;
+#else
+		uint64_t enable:1;
+		uint64_t idlelo:1;
+		uint64_t clk_cont:1;
+		uint64_t wireor:1;
+		uint64_t lsbfirst:1;
+		uint64_t cs_sticky:1;
+		uint64_t reserved_6:1;
+		uint64_t cshi:1;
+		uint64_t idleclks:2;
+		uint64_t tritx:1;
+		uint64_t cslate:1;
+		uint64_t csena0:1;
+		uint64_t csena1:1;
+		uint64_t csena2:1;
+		uint64_t csena3:1;
+		uint64_t clkdiv:13;
+		uint64_t reserved_29_30:2;
+		uint64_t legacy_dis:1;
+		uint64_t reserved_32_33:2;
+		uint64_t iomode:2;
+		uint64_t reserved_36_43:8;
+		uint64_t cs_espi_en:4;
+		uint64_t reserved_48:1;
+		uint64_t tb100_en:1;
+		uint64_t reserved_50_63:14;
+#endif
+	} s;
+};
+
+union mpix_sts {
+	u64 u64;
+	struct mpix_sts_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_40_63:24;
+		uint64_t crc:8;
+		uint64_t reserved_27_31:5;
+		uint64_t crc_err:1;
+		uint64_t reserved_19_25:7;
+		uint64_t rxnum:11;
+		uint64_t reserved_2_7:6;
+		uint64_t mpi_intr:1;
+		uint64_t busy:1;
+#else
+		uint64_t busy:1;
+		uint64_t mpi_intr:1;
+		uint64_t reserved_2_7:6;
+		uint64_t rxnum:11;
+		uint64_t reserved_19_25:7;
+		uint64_t crc_err:1;
+		uint64_t reserved_27_31:5;
+		uint64_t crc:8;
+		uint64_t reserved_40_63:24;
+#endif
+	} s;
+};
+
+union mpix_xmit {
+	u64 u64;
+	struct mpix_xmit_s {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_63:1;
+		uint64_t csid:2;
+		uint64_t leavecs:1;
+		uint64_t reserved_31_59:29;
+		uint64_t txnum:11;
+		uint64_t reserved_11_19:9;
+		uint64_t totnum:11;
+#else
+		uint64_t totnum:11;
+		uint64_t reserved_11_19:9;
+		uint64_t txnum:11;
+		uint64_t reserved_31_59:29;
+		uint64_t leavecs:1;
+		uint64_t csid:2;
+		uint64_t reserved_63:1;
+#endif
+	} s;
+};
+#endif /* __SPI_OCTEONTX2_H */
-- 
2.17.1

