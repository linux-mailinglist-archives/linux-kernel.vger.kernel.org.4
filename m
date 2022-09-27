Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01205EC201
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiI0MAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiI0MAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:00:34 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85D8B14C2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:00:31 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1od8pc-00CJn4-27
        for linux-kernel@vger.kernel.org; Tue, 27 Sep 2022 13:32:56 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1od8pF-00CJj9-PV; Tue, 27 Sep 2022 13:32:33 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1od8pF-0055tN-7S; Tue, 27 Sep 2022 13:32:33 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>, John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
Subject: [PATCH v2 2/3] spi: Add support for the Airoha EN7523 SoC SPI controller
Date:   Tue, 27 Sep 2022 13:32:28 +0200
Message-Id: <20220927113229.1214224-3-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927113229.1214224-1-bert@biot.com>
References: <20220927113229.1214224-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SPI driver primarily drives the SoC-internal state machine doing
the actual transfers. This allows transfers to be transparently queued
in hardware.

DMA mode is not yet supported.

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 drivers/spi/Kconfig      |   7 +
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-en7523.c | 305 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+)
 create mode 100644 drivers/spi/spi-en7523.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e32f6a2058ae..11b8c7ea0226 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -57,6 +57,13 @@ config SPI_MEM
 
 comment "SPI Master Controller Drivers"
 
+config SPI_AIROHA_EN7523
+	bool "Airoha EN7523 SPI controller support"
+	depends on ARCH_AIROHA
+	default ARCH_AIROHA
+	help
+	  This enables SPI controller support for the Airoha EN7523 SoC.
+
 config SPI_ALTERA
 	tristate "Altera SPI Controller platform driver"
 	select SPI_ALTERA_CORE
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 15d2f3835e45..8c360f764869 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 
 # SPI master controller drivers (bus)
+obj-$(CONFIG_SPI_AIROHA_EN7523)		+= spi-en7523.o
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera-platform.o
 obj-$(CONFIG_SPI_ALTERA_CORE)		+= spi-altera-core.o
 obj-$(CONFIG_SPI_ALTERA_DFL)		+= spi-altera-dfl.o
diff --git a/drivers/spi/spi-en7523.c b/drivers/spi/spi-en7523.c
new file mode 100644
index 000000000000..e8e12cd6f597
--- /dev/null
+++ b/drivers/spi/spi-en7523.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/clk.h>
+#include <linux/spi/spi.h>
+#include <dt-bindings/clock/en7523-clk.h>
+
+
+#define ENSPI_READ_IDLE_EN			0x0004
+#define ENSPI_MTX_MODE_TOG			0x0014
+#define ENSPI_RDCTL_FSM				0x0018
+#define ENSPI_MANUAL_EN				0x0020
+#define ENSPI_MANUAL_OPFIFO_EMPTY		0x0024
+#define ENSPI_MANUAL_OPFIFO_WDATA		0x0028
+#define ENSPI_MANUAL_OPFIFO_FULL		0x002C
+#define ENSPI_MANUAL_OPFIFO_WR			0x0030
+#define ENSPI_MANUAL_DFIFO_FULL			0x0034
+#define ENSPI_MANUAL_DFIFO_WDATA		0x0038
+#define ENSPI_MANUAL_DFIFO_EMPTY		0x003C
+#define ENSPI_MANUAL_DFIFO_RD			0x0040
+#define ENSPI_MANUAL_DFIFO_RDATA		0x0044
+#define ENSPI_IER				0x0090
+#define ENSPI_NFI2SPI_EN			0x0130
+
+#define	OP_CSH					0x00
+#define	OP_CSL					0x01
+#define	OP_CK					0x02
+#define	OP_OUTS					0x08
+#define	OP_OUTD					0x09
+#define	OP_OUTQ					0x0A
+#define	OP_INS					0x0C
+#define	OP_INS0					0x0D
+#define	OP_IND					0x0E
+#define	OP_INQ					0x0F
+#define	OP_OS2IS				0x10
+#define	OP_OS2ID				0x11
+#define	OP_OS2IQ				0x12
+#define	OP_OD2IS				0x13
+#define	OP_OD2ID				0x14
+#define	OP_OD2IQ				0x15
+#define	OP_OQ2IS				0x16
+#define	OP_OQ2ID				0x17
+#define	OP_OQ2IQ				0x18
+#define	OP_OSNIS				0x19
+#define	OP_ODNID				0x1A
+
+#define MATRIX_MODE_AUTO		1
+#define   CONF_MTX_MODE_AUTO		0
+#define   MANUALEN_AUTO			0
+#define MATRIX_MODE_MANUAL		0
+#define   CONF_MTX_MODE_MANUAL		9
+#define   MANUALEN_MANUAL		1
+
+#define ENSPI_MAX_XFER			0x1ff
+
+#define REG(x)			(iobase + x)
+
+static void __iomem *iobase;
+
+
+static void opfifo_write(u32 cmd, u32 len)
+{
+	u32 tmp = ((cmd & 0x1f) << 9) | (len & 0x1ff);
+
+	writel(tmp, REG(ENSPI_MANUAL_OPFIFO_WDATA));
+
+	/* Wait for room in OPFIFO */
+	while (readl(REG(ENSPI_MANUAL_OPFIFO_FULL)))
+		cpu_relax();
+
+	/* Shift command into OPFIFO */
+	writel(1, REG(ENSPI_MANUAL_OPFIFO_WR));
+
+	/* Wait for command to finish */
+	while (!readl(REG(ENSPI_MANUAL_OPFIFO_EMPTY)))
+		cpu_relax();
+}
+
+static void set_cs(int state)
+{
+	if (state)
+		opfifo_write(OP_CSH, 1);
+	else
+		opfifo_write(OP_CSL, 1);
+}
+
+static void manual_begin_cmd(void)
+{
+	/* Disable read idle state */
+	writel(0, REG(ENSPI_READ_IDLE_EN));
+
+	/* Wait for FSM to reach idle state */
+	while (readl(REG(ENSPI_RDCTL_FSM)))
+		cpu_relax();
+
+	/* Set SPI core to manual mode */
+	writel(CONF_MTX_MODE_MANUAL, REG(ENSPI_MTX_MODE_TOG));
+	writel(MANUALEN_MANUAL, REG(ENSPI_MANUAL_EN));
+}
+
+static void manual_end_cmd(void)
+{
+	/* Set SPI core to auto mode */
+	writel(CONF_MTX_MODE_AUTO, REG(ENSPI_MTX_MODE_TOG));
+	writel(MANUALEN_AUTO, REG(ENSPI_MANUAL_EN));
+
+	/* Enable read idle state */
+	writel(1, REG(ENSPI_READ_IDLE_EN));
+}
+
+static void dfifo_read(u8 *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		/* Wait for requested data to show up in DFIFO */
+		while (readl(REG(ENSPI_MANUAL_DFIFO_EMPTY)))
+			cpu_relax();
+		buf[i] = readl(REG(ENSPI_MANUAL_DFIFO_RDATA));
+		/* Queue up next byte */
+		writel(1, REG(ENSPI_MANUAL_DFIFO_RD));
+	}
+}
+
+static void dfifo_write(const u8 *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		/* Wait for room in DFIFO */
+		while (readl(REG(ENSPI_MANUAL_DFIFO_FULL)))
+			cpu_relax();
+		writel(buf[i], REG(ENSPI_MANUAL_DFIFO_WDATA));
+	}
+}
+
+static int init_hw(struct device *dev)
+{
+	struct clk *clk;
+	int ret;
+
+	/* Disable manual/auto mode clash interrupt */
+	writel(0, REG(ENSPI_IER));
+
+	/* Disable DMA */
+	writel(0, REG(ENSPI_NFI2SPI_EN));
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(clk, 40000000);
+	if (ret) {
+		clk_disable_unprepare(clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int xfer_read(struct spi_transfer *xfer)
+{
+	int opcode;
+	uint8_t *buf = xfer->rx_buf;
+
+	switch (xfer->rx_nbits) {
+	case SPI_NBITS_SINGLE:
+		opcode = OP_INS;
+		break;
+	case SPI_NBITS_DUAL:
+		opcode = OP_IND;
+		break;
+	}
+
+	opfifo_write(opcode, xfer->len);
+	dfifo_read(buf, xfer->len);
+
+	return xfer->len;
+}
+
+static int xfer_write(struct spi_transfer *xfer, int next_xfer_is_rx)
+{
+	int opcode;
+	const uint8_t *buf = xfer->tx_buf;
+
+	if (next_xfer_is_rx) {
+		/* need to use Ox2Ix opcode to set the core to input afterwards */
+		switch (xfer->tx_nbits) {
+		case SPI_NBITS_SINGLE:
+			opcode = OP_OS2IS;
+			break;
+		case SPI_NBITS_DUAL:
+			opcode = OP_OD2ID;
+			break;
+		}
+	} else {
+		switch (xfer->tx_nbits) {
+		case SPI_NBITS_SINGLE:
+			opcode = OP_OUTS;
+			break;
+		case SPI_NBITS_DUAL:
+			opcode = OP_OUTD;
+			break;
+		}
+	}
+
+	opfifo_write(opcode, xfer->len);
+	dfifo_write(buf, xfer->len);
+
+	return xfer->len;
+}
+
+static size_t max_transfer_size(struct spi_device *spi)
+{
+	return ENSPI_MAX_XFER;
+}
+
+static int transfer_one_message(struct spi_controller *ctrl, struct spi_message *msg)
+{
+	struct spi_transfer *xfer;
+	int next_xfer_is_rx = 0;
+
+	manual_begin_cmd();
+	set_cs(0);
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (xfer->tx_buf) {
+			if (!list_is_last(&xfer->transfer_list, &msg->transfers)
+			    && list_next_entry(xfer, transfer_list)->rx_buf != NULL)
+				next_xfer_is_rx = 1;
+			else
+				next_xfer_is_rx = 0;
+			msg->actual_length += xfer_write(xfer, next_xfer_is_rx);
+		} else if (xfer->rx_buf) {
+			msg->actual_length += xfer_read(xfer);
+		}
+	}
+	set_cs(1);
+	manual_end_cmd();
+
+	msg->status = 0;
+	spi_finalize_current_message(ctrl);
+
+	return 0;
+}
+
+static int spi_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctrl;
+	int err;
+
+	ctrl = devm_spi_alloc_master(&pdev->dev, 0);
+	if (!ctrl) {
+		dev_err(&pdev->dev, "Error allocating SPI controller\n");
+		return -ENOMEM;
+	}
+
+	iobase = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(iobase)) {
+		dev_err(&pdev->dev, "Could not map SPI register address");
+		return -ENOMEM;
+	}
+
+	err = init_hw(&pdev->dev);
+	if (err)
+		return err;
+
+	ctrl->dev.of_node = pdev->dev.of_node;
+	ctrl->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	ctrl->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL;
+	ctrl->max_transfer_size = max_transfer_size;
+	ctrl->transfer_one_message = transfer_one_message;
+	err = devm_spi_register_controller(&pdev->dev, ctrl);
+	if (err) {
+		dev_err(&pdev->dev, "Could not register SPI controller\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id spi_of_ids[] = {
+	{ .compatible = "airoha,en7523-spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, spi_of_ids);
+
+static struct platform_driver spi_driver = {
+	.probe = spi_probe,
+	.driver = {
+		.name = "airoha-en7523-spi",
+		.of_match_table = spi_of_ids,
+	},
+};
+
+module_platform_driver(spi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Bert Vermeulen <bert@biot.com>");
+MODULE_DESCRIPTION("Airoha EN7523 SPI driver");
-- 
2.25.1

