Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528CB61F395
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiKGMpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiKGMpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:45:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA811BEBF;
        Mon,  7 Nov 2022 04:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667825123; x=1699361123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iclWdSWeHmbZFONaLI3RpASfF6KaujICDxZWOd46ABc=;
  b=jGqxcEf+W727PjqLkRYlZEHQtvW6zmMCl5vJRYRVGNm/W+cE2LrDaES1
   ckMZZqZxHfMA2kEbzJRVc2nC/Ksq3QomHxfUcBVIZGuB5wC27hQw2JR0Q
   hfmTeDQKHbMnsBLTTLVDmYFmH4fvNwWXhe5EMMv6GSVUluLAfHMb/tlJP
   q3sltfWQSTJ1Ub4UsDWD4evJBD4o/X/1zpApcdRZmzxjdyjeu9BWGskbi
   FRvBstwqkxFK9CxVb+0FRCgqzbDrRNnRgMiDED2wH/K6zluJ0cTVILG52
   0btNOrB7cakjFa7BtBv9oE77Jbw3k4x1nRMGXoyuICrAKsbbiS+h3tjFL
   A==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="182255404"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2022 05:45:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 7 Nov 2022 05:45:21 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 7 Nov 2022 05:45:15 -0700
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
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v3 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for quad-uart support.
Date:   Mon, 7 Nov 2022 18:15:15 +0530
Message-ID: <20221107124517.1364484-2-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107124517.1364484-1-kumaravel.thiagarajan@microchip.com>
References: <20221107124517.1364484-1-kumaravel.thiagarajan@microchip.com>
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

Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
---
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
 drivers/tty/serial/8250/8250_pci.c      |  24 +-
 drivers/tty/serial/8250/8250_pci1xxxx.c | 370 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.c   |  31 ++
 drivers/tty/serial/8250/8250_pcilib.h   |   5 +
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |  15 +
 drivers/tty/serial/8250/Makefile        |   2 +
 include/uapi/linux/serial_core.h        |   3 +
 9 files changed, 443 insertions(+), 22 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.h

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
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6f66dc2ebacc..e7023f1b9b2c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 
 #include "8250.h"
+#include "8250_pcilib.h"
 
 /*
  * init function returns:
@@ -89,28 +90,7 @@ static int
 setup_port(struct serial_private *priv, struct uart_8250_port *port,
 	   u8 bar, unsigned int offset, int regshift)
 {
-	struct pci_dev *dev = priv->dev;
-
-	if (bar >= PCI_STD_NUM_BARS)
-		return -EINVAL;
-
-	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
-		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
-			return -ENOMEM;
-
-		port->port.iotype = UPIO_MEM;
-		port->port.iobase = 0;
-		port->port.mapbase = pci_resource_start(dev, bar) + offset;
-		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
-		port->port.regshift = regshift;
-	} else {
-		port->port.iotype = UPIO_PORT;
-		port->port.iobase = pci_resource_start(dev, bar) + offset;
-		port->port.mapbase = 0;
-		port->port.membase = NULL;
-		port->port.regshift = 0;
-	}
-	return 0;
+	return pci_setup_port(priv->dev, port, bar, offset, regshift);
 }
 
 /*
diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
new file mode 100644
index 000000000000..e74e8d63daee
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Probe module for 8250/16550-type MCHP PCI serial ports.
+ *
+ *  Based on drivers/tty/serial/8250/8250_pci.c,
+ *
+ *  Copyright (C) 2022 Microchip Technology Inc., All Rights Reserved.
+ */
+
+#include <asm/byteorder.h>
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
+#include "8250.h"
+#include "8250_pcilib.h"
+
+#define PCI_DEVICE_ID_EFAR_PCI12000 0xa002
+#define PCI_DEVICE_ID_EFAR_PCI11010 0xa012
+#define PCI_DEVICE_ID_EFAR_PCI11101 0xa022
+#define PCI_DEVICE_ID_EFAR_PCI11400 0xa032
+#define PCI_DEVICE_ID_EFAR_PCI11414 0xa042
+
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_4p 0x0001
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p012 0x0002
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013 0x0003
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023 0x0004
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123 0x0005
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p01 0x0006
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02 0x0007
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03 0x0008
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12 0x0009
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13 0x000a
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23 0x000b
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0 0x000c
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1 0x000d
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2 0x000e
+#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3 0x000f
+
+#define PCI_SUBDEVICE_ID_EFAR_PCI12000 0xa002
+#define PCI_SUBDEVICE_ID_EFAR_PCI11010 0xa012
+#define PCI_SUBDEVICE_ID_EFAR_PCI11101 0xa022
+#define PCI_SUBDEVICE_ID_EFAR_PCI11400 0xa032
+#define PCI_SUBDEVICE_ID_EFAR_PCI11414 0xa042
+
+#define UART_ACTV_REG 0x11
+#define UART_BLOCK_SET_ACTIVE BIT(0)
+
+#define UART_PCI_CTRL_REG 0x80
+#define UART_PCI_CTRL_SET_MULTIPLE_MSI BIT(4)
+#define UART_PCI_CTRL_D3_CLK_ENABLE BIT(0)
+
+#define ADCL_CFG_REG 0x40
+#define ADCL_CFG_POL_SEL BIT(2)
+#define ADCL_CFG_PIN_SEL BIT(1)
+#define ADCL_CFG_EN BIT(0)
+
+#define UART_BIT_SAMPLE_CNT 16
+#define BAUD_CLOCK_DIV_INT_MSK GENMASK(31, 8)
+#define ADCL_CFG_RTS_DELAY_MASK GENMASK(11, 8)
+#define UART_CLOCK_DEFAULT (62.5 * HZ_PER_MHZ)
+
+#define UART_WAKE_REG 0x8C
+#define UART_WAKE_MASK_REG 0x90
+#define UART_WAKE_N_PIN BIT(2)
+#define UART_WAKE_NCTS BIT(1)
+#define UART_WAKE_INT BIT(0)
+#define UART_WAKE_SRCS (UART_WAKE_N_PIN | UART_WAKE_NCTS | UART_WAKE_INT)
+
+#define UART_BAUD_CLK_DIVISOR_REG 0x54
+
+#define UART_RESET_REG 0x94
+#define UART_RESET_D3_RESET_DISABLE BIT(16)
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
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2:
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3:
+	default:
+		return 1;
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
+	int ret;
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
+		first_offset = 256;
+		if (idx > 0)
+			idx++;
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013:
+		if (idx > 1)
+			idx++;
+		break;
+	default:
+		first_offset = 0;
+		break;
+	}
+
+	offset = first_offset + idx * 256;
+	port->port.flags |= UPF_FIXED_TYPE | UPF_SKIP_TEST;
+	port->port.type = PORT_MCHP16550A;
+	port->port.set_termios = serial8250_do_set_termios;
+	port->port.get_divisor = pci1xxxx_get_divisor;
+	port->port.set_divisor = pci1xxxx_set_divisor;
+	ret = pci_setup_port(priv->dev, port, 0, offset, 0);
+	if (ret < 0)
+		return ret;
+
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
+	switch (priv->dev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
+		uart->port.irq = pci_irq_vector(priv->dev, 1);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2:
+		uart->port.irq = pci_irq_vector(priv->dev, 2);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3:
+		uart->port.irq = pci_irq_vector(priv->dev, 3);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p01:
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02:
+		if (idx > 0)
+			idx++;
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03:
+		if (idx > 0)
+			idx += 2;
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12:
+		uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13:
+		if (idx > 0)
+			idx += 1;
+		uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23:
+		uart->port.irq = pci_irq_vector(priv->dev, idx + 2);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p012:
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013:
+		if (idx > 1)
+			idx++;
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023:
+		if (idx > 0)
+			idx++;
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123:
+		uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_4p:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11414:
+		uart->port.irq = pci_irq_vector(priv->dev, idx);
+		break;
+	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0:
+	case PCI_SUBDEVICE_ID_EFAR_PCI12000:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11010:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11101:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11400:
+	default:
+		uart->port.irq = pci_irq_vector(priv->dev, 0);
+		break;
+	}
+}
+
+static int pci1xxxx_serial_probe(struct pci_dev *dev,
+				 const struct pci_device_id *ent)
+{
+	unsigned int nr_ports, i, j;
+	struct pci1xxxx_8250 *priv;
+	struct uart_8250_port uart;
+	int num_vectors = 0;
+	int rc;
+
+	rc = pcim_enable_device(dev);
+	if (rc)
+		return rc;
+
+	nr_ports = pci1xxxx_get_num_ports(dev);
+
+	priv = devm_kzalloc(&dev->dev, struct_size(priv, line, nr_ports),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->membase = pcim_iomap(dev, 0, 0);
+	priv->dev = dev;
+	priv->nr = nr_ports;
+	pci_set_master(dev);
+
+	num_vectors = pci_alloc_irq_vectors(dev, 1, 4, PCI_IRQ_ALL_TYPES);
+	if (num_vectors < 0)
+		return num_vectors;
+
+	memset(&uart, 0, sizeof(uart));
+	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT;
+	uart.port.uartclk = UART_CLOCK_DEFAULT;
+	uart.port.dev = &dev->dev;
+
+	if (num_vectors == 4)
+		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI,
+		       priv->membase + UART_PCI_CTRL_REG);
+	else
+		uart.port.irq = pci_irq_vector(dev, 0);
+
+	for (i = 0; i < nr_ports; i++) {
+		if (num_vectors == 4)
+			pci1xxxx_irq_assign(priv, &uart, i);
+
+		priv->line[i] = -ENOSPC;
+		rc = pci1xxxx_setup(priv, &uart, i);
+		if (rc) {
+			dev_err(&dev->dev, "Failed to setup port %u\n", i);
+			break;
+		}
+		priv->line[i] = serial8250_register_8250_port(&uart);
+
+		if (priv->line[i] < 0) {
+			for (j = i + 1; j < nr_ports; j++)
+				priv->line[j] = -ENOSPC;
+
+			dev_err(&dev->dev,
+				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
+				uart.port.iobase, uart.port.irq,
+				uart.port.iotype, priv->line[i]);
+			break;
+		}
+	}
+
+	pci_set_drvdata(dev, priv);
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
+
+module_pci_driver(pci1xxxx_pci_driver);
+
+MODULE_DESCRIPTION("Microchip Technology Inc. PCIe to UART module");
+MODULE_AUTHOR("Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>");
+MODULE_AUTHOR("Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
new file mode 100644
index 000000000000..07040781b43f
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Microchip pci1xxxx 8250 library. */
+
+#include <linux/pci.h>
+#include "8250.h"
+
+int pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
+		   u8 bar, unsigned int offset, int regshift)
+{
+	if (bar >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
+	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
+		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
+			return -ENOMEM;
+
+		port->port.iotype = UPIO_MEM;
+		port->port.iobase = 0;
+		port->port.mapbase = pci_resource_start(dev, bar) + offset;
+		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
+		port->port.regshift = regshift;
+	} else {
+		port->port.iotype = UPIO_PORT;
+		port->port.iobase = pci_resource_start(dev, bar) + offset;
+		port->port.mapbase = 0;
+		port->port.membase = NULL;
+		port->port.regshift = 0;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_setup_port);
diff --git a/drivers/tty/serial/8250/8250_pcilib.h b/drivers/tty/serial/8250/8250_pcilib.h
new file mode 100644
index 000000000000..c33b7eb44222
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pcilib.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Microchip pci1xxxx 8250 library header file. */
+
+int pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port, u8 bar,
+		   unsigned int offset, int regshift);
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
index d0b49e15fbf5..f67542470eae 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -132,6 +132,7 @@ config SERIAL_8250_DMA
 config SERIAL_8250_PCI
 	tristate "8250/16550 PCI device support"
 	depends on SERIAL_8250 && PCI
+	select SERIAL_8250_PCILIB
 	default SERIAL_8250
 	help
 	  This builds standard PCI serial support. You may be able to
@@ -291,6 +292,17 @@ config SERIAL_8250_HUB6
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8250_hub6.
 
+config SERIAL_8250_PCI1XXXX
+	tristate "Microchip 8250 based serial port"
+	depends on SERIAL_8250_PCI
+	select SERIAL_8250_PCILIB
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
@@ -500,6 +512,9 @@ config SERIAL_8250_MID
 	  Intel Medfield SOC and various other Intel platforms that is not
 	  covered by the more generic SERIAL_8250_PCI option.
 
+config SERIAL_8250_PCILIB
+	bool
+
 config SERIAL_8250_PERICOM
 	tristate "Support for Pericom and Acces I/O serial ports"
 	default SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index bee908f99ea0..98202fdf39f8 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
+8250_base-$(CONFIG_SERIAL_8250_PCILIB)	+= 8250_pcilib.o
 obj-$(CONFIG_SERIAL_8250_GSC)		+= 8250_gsc.o
 obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
 obj-$(CONFIG_SERIAL_8250_EXAR)		+= 8250_exar.o
@@ -26,6 +27,7 @@ obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
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

