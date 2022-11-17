Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D762D62D289
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbiKQFB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiKQFBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:01:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B86326EC;
        Wed, 16 Nov 2022 21:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668661265; x=1700197265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ULeWXATHxlooqOwDRTF6YtD/vn0X4PQHlOBJWw8Or4=;
  b=jTCSb+H8kp6TuZ9qTkQJ/DRniRNOpaaDD49ledBED9f8H55oK1fxqO//
   ab1dO6nzoszZyDPupeWPs9HqsYISLKNDz9Jb96+dCBD5s6cjod/6Jt3p1
   Mrm0R2VWdSNdCKlmTPUBdj7V0x2sduYFk71KmldMig2ruvYU9bQeu01s0
   ldzpIyYOvyxvjZ4leXfeLtpBo/MLzo9+XeRQQysxkuKavLo6nR/WWS0fC
   +j1azMUlFUE0VUkGhG+73QFbJ2IVHwtvy2nvoy/zXMvvtFyxHn7fDHVfM
   N2GiH1rzdhnoixJoxWb/N0y5Q7OtiVingR8OE/dtshjuBYwUav7F/upyU
   g==;
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="183919258"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2022 22:01:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 16 Nov 2022 22:01:02 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 16 Nov 2022 22:00:56 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <jay.dolan@accesio.com>, <cang1@live.co.uk>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <UNGLinuxDriver@microchip.com>, <colin.i.king@gmail.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v5 tty-next 1/4] 8250: microchip: pci1xxxx: Add driver for quad-uart support.
Date:   Thu, 17 Nov 2022 10:31:23 +0530
Message-ID: <20221117050126.2966714-2-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
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

pci1xxxx is a PCIe switch with a multi-function endpoint on one of
its downstream ports. Quad-uart is one of the functions in the
multi-function endpoint. This driver loads for the quad-uart and
enumerates single or multiple instances of uart based on the PCIe
subsystem device ID.

Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
Changes in v5:
- Used tabs instead of spaces in MACRO definitions for readability
- Removed assignments that are not required
- Removed redundant blank lines

Changes in v4:
- Renamed pci_setup_port to serial8250_pci_setup_port
- Added Copyright information to 8250_pcilib.c

Changes in v3:
- Used NSEC_PER_SEC, HZ_PER_MHZ, FIELD_PREP, FIELD_GET MACROs wherever
  necessary
- Handled failure case of serial8250_register_8250_port properly
- Moved pci_setup_port to 8250_pcilib.c

Changes in v2:
- Use only the 62.5 MHz for baud clock.
- Define custom implementation for get_divisor and set_divisor.
- Use BOTHER instead of UPF_SPD_CUST for non standard baud rates
  (untested).
- Correct indentation in clock divisor computation.
- Remove unnecessary call to pci_save_state in probe function.
- Fix null pointer dereference in probe function.
- Move pci1xxxx_rs485_config to a separate patch.
- Depends on SERIAL_8250_PCI & default to SERIAL_8250.
- Change PORT_MCHP16550A to 100 from 124.
---
 MAINTAINERS                             |   7 +
 drivers/tty/serial/8250/8250_pci1xxxx.c | 372 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |  10 +
 drivers/tty/serial/8250/Makefile        |   1 +
 include/uapi/linux/serial_core.h        |   3 +
 6 files changed, 401 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d30f26e07cd3..aa98deaba249 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13434,6 +13434,13 @@ F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 F:	drivers/nvmem/microchip-otpc.c
 F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
 
+MICROCHIP PCIe UART DRIVER
+M:	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
+M:	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	drivers/tty/serial/8250/8250_pci1xxxx.c
+
 MICROCHIP PWM DRIVER
 M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
new file mode 100644
index 000000000000..9dd7aca76e58
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Probe module for 8250/16550-type MCHP PCI serial ports.
+ *
+ *  Based on drivers/tty/serial/8250/8250_pci.c,
+ *
+ *  Copyright (C) 2022 Microchip Technology Inc., All Rights Reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/units.h>
+#include <linux/tty.h>
+
+#include <asm/byteorder.h>
+
+#include "8250.h"
+
+#define PCI_DEVICE_ID_EFAR_PCI12000		0xa002
+#define PCI_DEVICE_ID_EFAR_PCI11010		0xa012
+#define PCI_DEVICE_ID_EFAR_PCI11101		0xa022
+#define PCI_DEVICE_ID_EFAR_PCI11400		0xa032
+#define PCI_DEVICE_ID_EFAR_PCI11414		0xa042
+
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_4p	0x0001
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p012	0x0002
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013	0x0003
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023	0x0004
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123	0x0005
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p01	0x0006
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02	0x0007
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03	0x0008
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12	0x0009
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13	0x000a
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23	0x000b
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0	0x000c
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1	0x000d
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2	0x000e
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3	0x000f
+
+#define PCI_SUBDEVICE_ID_EFAR_PCI12000		0xa002
+#define PCI_SUBDEVICE_ID_EFAR_PCI11010		0xa012
+#define PCI_SUBDEVICE_ID_EFAR_PCI11101		0xa022
+#define PCI_SUBDEVICE_ID_EFAR_PCI11400		0xa032
+#define PCI_SUBDEVICE_ID_EFAR_PCI11414		0xa042
+
+#define UART_ACTV_REG				0x11
+#define UART_BLOCK_SET_ACTIVE			BIT(0)
+
+#define UART_PCI_CTRL_REG			0x80
+#define UART_PCI_CTRL_SET_MULTIPLE_MSI		BIT(4)
+#define UART_PCI_CTRL_D3_CLK_ENABLE		BIT(0)
+
+#define ADCL_CFG_REG				0x40
+#define ADCL_CFG_POL_SEL			BIT(2)
+#define ADCL_CFG_PIN_SEL			BIT(1)
+#define ADCL_CFG_EN				BIT(0)
+
+#define UART_BIT_SAMPLE_CNT			16
+#define BAUD_CLOCK_DIV_INT_MSK			GENMASK(31, 8)
+#define ADCL_CFG_RTS_DELAY_MASK			GENMASK(11, 8)
+#define UART_CLOCK_DEFAULT			(62.5 * HZ_PER_MHZ)
+
+#define UART_WAKE_REG				0x8C
+#define UART_WAKE_MASK_REG			0x90
+#define UART_WAKE_N_PIN				BIT(2)
+#define UART_WAKE_NCTS				BIT(1)
+#define UART_WAKE_INT				BIT(0)
+#define UART_WAKE_SRCS	\
+	(UART_WAKE_N_PIN | UART_WAKE_NCTS | UART_WAKE_INT)
+
+#define UART_BAUD_CLK_DIVISOR_REG		0x54
+
+#define UART_RESET_REG				0x94
+#define UART_RESET_D3_RESET_DISABLE		BIT(16)
+
+struct pci1xxxx_8250 {
+	struct pci_dev *dev;
+	unsigned int nr;
+	void __iomem *membase;
+	int line[];
+};
+
+static int pci1xxxx_get_num_ports(struct pci_dev *dev)
+{
+	switch (dev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3:
+	default:
+		return 1;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p01:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23:
+		return 2;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p012:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023:
+		return 3;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_4p:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11414:
+		return 4;
+	}
+}
+
+static unsigned int pci1xxxx_get_divisor(struct uart_port *port,
+					 unsigned int baud, unsigned int *frac)
+{
+	unsigned int quot;
+
+	/*
+	 * Calculate baud rate sampling period in nanoseconds.
+	 * Fractional part x denotes x/255 parts of a nanosecond.
+	 */
+	quot = (NSEC_PER_SEC / (baud * UART_BIT_SAMPLE_CNT));
+	*frac = (((NSEC_PER_SEC - (quot * baud * UART_BIT_SAMPLE_CNT)) /
+		  UART_BIT_SAMPLE_CNT) * 255) / baud;
+
+	return quot;
+}
+
+static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
+				 unsigned int quot, unsigned int frac)
+{
+	writel(FIELD_PREP(BAUD_CLOCK_DIV_INT_MSK, quot) | frac,
+	       port->membase + UART_BAUD_CLK_DIVISOR_REG);
+}
+
+static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
+			  struct uart_8250_port *port, int idx)
+{
+	int first_offset;
+	int offset;
+
+	switch (priv->dev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123:
+		first_offset = 256;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23:
+		first_offset = 512;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3:
+		first_offset = 768;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13:
+		first_offset = 256;
+		break;
+	default:
+		first_offset = 0;
+		break;
+	}
+
+	switch (priv->dev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023:
+		if (idx > 0)
+			idx++;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03:
+		if (idx > 0)
+			idx += 2;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13:
+		if (idx > 0)
+			idx++;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013:
+		if (idx > 1)
+			idx++;
+		break;
+	}
+
+	offset = first_offset + idx * 256;
+	port->port.flags |= UPF_FIXED_TYPE | UPF_SKIP_TEST;
+	port->port.type = PORT_MCHP16550A;
+	port->port.set_termios = serial8250_do_set_termios;
+	port->port.get_divisor = pci1xxxx_get_divisor;
+	port->port.set_divisor = pci1xxxx_set_divisor;
+	writeb(UART_BLOCK_SET_ACTIVE, port->port.membase + UART_ACTV_REG);
+	writeb(UART_WAKE_SRCS, port->port.membase + UART_WAKE_REG);
+	writeb(UART_WAKE_N_PIN, port->port.membase + UART_WAKE_MASK_REG);
+
+	return 0;
+}
+
+static void pci1xxxx_irq_assign(struct pci1xxxx_8250 *priv,
+				struct uart_8250_port *uart, int idx)
+{
+	int irq_idx;
+
+	switch (priv->dev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0:
+	case PCI_SUBDEVICE_ID_EFAR_PCI12000:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11010:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11101:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11400:
+	default:
+		irq_idx = 0;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
+		irq_idx = 1;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2:
+		irq_idx = 2;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3:
+		irq_idx = 3;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p01:
+		irq_idx = idx;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02:
+		if (idx > 0)
+			idx++;
+		irq_idx = idx;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03:
+		if (idx > 0)
+			idx += 2;
+		irq_idx = idx;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12:
+		irq_idx = idx + 1;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13:
+		if (idx > 0)
+			idx += 1;
+		irq_idx = idx + 1;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23:
+		irq_idx = idx + 2;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p012:
+		irq_idx = idx;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013:
+		if (idx > 1)
+			idx++;
+		irq_idx = idx;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023:
+		if (idx > 0)
+			idx++;
+		irq_idx = idx;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123:
+		irq_idx = idx + 1;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_4p:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11414:
+		irq_idx = idx;
+		break;
+	}
+	uart->port.irq = pci_irq_vector(priv->dev, irq_idx);
+}
+
+static int pci1xxxx_serial_probe(struct pci_dev *pdev,
+				 const struct pci_device_id *id)
+{
+	unsigned int nr_ports, i;
+	struct pci1xxxx_8250 *priv;
+	struct uart_8250_port uart;
+	struct device *dev;
+	int num_vectors;
+	int rc;
+
+	dev = &pdev->dev;
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	nr_ports = pci1xxxx_get_num_ports(pdev);
+
+	priv = devm_kzalloc(dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->membase = pcim_iomap(pdev, 0, 0);
+	priv->dev = pdev;
+	priv->nr = nr_ports;
+	pci_set_master(pdev);
+
+	num_vectors = pci_alloc_irq_vectors(pdev, 1, 4, PCI_IRQ_ALL_TYPES);
+	if (num_vectors < 0)
+		return num_vectors;
+
+	memset(&uart, 0, sizeof(uart));
+	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT;
+	uart.port.uartclk = UART_CLOCK_DEFAULT;
+	uart.port.dev = dev;
+
+	if (num_vectors == 4)
+		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI,
+		       priv->membase + UART_PCI_CTRL_REG);
+	else
+		uart.port.irq = pci_irq_vector(pdev, 0);
+
+	for (i = 0; i < nr_ports; i++)
+		priv->line[i] = -ENOSPC;
+
+	for (i = 0; i < nr_ports; i++) {
+		if (num_vectors == 4)
+			pci1xxxx_irq_assign(priv, &uart, i);
+
+		rc = pci1xxxx_setup(priv, &uart, i);
+		if (rc) {
+			dev_warn(dev, "Failed to setup port %u\n", i);
+			break;
+		}
+		priv->line[i] = serial8250_register_8250_port(&uart);
+		if (priv->line[i] < 0) {
+			dev_err(dev,
+				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
+				uart.port.iobase, uart.port.irq,
+				uart.port.iotype, priv->line[i]);
+			break;
+		}
+	}
+
+	pci_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static void pci1xxxx_serial_remove(struct pci_dev *dev)
+{
+	struct pci1xxxx_8250 *priv = pci_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < priv->nr; i++) {
+		if (priv->line[i] >= 0)
+			serial8250_unregister_port(priv->line[i]);
+	}
+}
+
+static const struct pci_device_id pci1xxxx_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11010) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11101) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11400) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11414) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI12000) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, pci1xxxx_pci_tbl);
+
+static struct pci_driver pci1xxxx_pci_driver = {
+	.name = "pci1xxxx serial",
+	.probe = pci1xxxx_serial_probe,
+	.remove = pci1xxxx_serial_remove,
+	.id_table = pci1xxxx_pci_tbl,
+};
+module_pci_driver(pci1xxxx_pci_driver);
+
+MODULE_DESCRIPTION("Microchip Technology Inc. PCIe to UART module");
+MODULE_AUTHOR("Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>");
+MODULE_AUTHOR("Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1d2a43214b48..ec2fe5fd7b02 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -313,6 +313,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_MCHP16550A] = {
+		.name           = "MCHP16550A",
+		.fifo_size      = 256,
+		.tx_loadsz      = 256,
+		.fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
+		.rxtrig_bytes   = {2, 66, 130, 194},
+		.flags          = UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d0b49e15fbf5..1c41722d8ac5 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -291,6 +291,16 @@ config SERIAL_8250_HUB6
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8250_hub6.
 
+config SERIAL_8250_PCI1XXXX
+	tristate "Microchip 8250 based serial port"
+	depends on SERIAL_8250_PCI
+	default SERIAL_8250
+	help
+	 Select this option if you have a setup with Microchip PCIe
+	 Switch with serial port enabled and wish to enable 8250
+	 serial driver for the serial interface. This driver support
+	 will ensure to support baud rates upto 1.5Mpbs.
+
 #
 # Misc. options/drivers.
 #
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index bee908f99ea0..fbc7d47c25bd 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
 obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
+obj-$(CONFIG_SERIAL_8250_PCI1XXXX)	+= 8250_pci1xxxx.o
 obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 3ba34d8378bd..281fa286555c 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -207,6 +207,9 @@
 /* Atheros AR933X SoC */
 #define PORT_AR933X	99
 
+/* MCHP 16550A UART with 256 byte FIFOs */
+#define PORT_MCHP16550A	100
+
 /* ARC (Synopsys) on-chip UART */
 #define PORT_ARC       101
 
-- 
2.25.1

