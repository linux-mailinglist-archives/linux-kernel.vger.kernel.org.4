Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5CB68CE09
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjBGEN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBGENP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:13:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1AA34328;
        Mon,  6 Feb 2023 20:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675743192; x=1707279192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mbMapLMfaepblPBzGut3IKGndujycKkNu/dXcw4KGcc=;
  b=JDBuQ3cKI6zRcQxT3+yLpxUw0c71RlVzwor7wouWX7Z14DdFEVTmL2fo
   /yCPfsXmDGY4MVA05IQyAZxeVY8sAphLr2+yLHnIMlpzseo2dWkyqKuHo
   OyjKqJaR8Ozm1xfVzeM6qA8qRcIVfjustq3wAAmJ73wl48yDcL8QiVdom
   0swGiHv54Sl1ej4DiVgsr8acZ54/pXrSOpgvGi5XFTwuGWNG10D12I84w
   2b2NEzRTbaV7nw9gWpmTMCMESTqGa73hvE2ZcaLxYdMKu6w8ctjoEpp6h
   ONlgaeODFGT04tW9CHXjWxIEZscdzf7aRUQlFAdVA8RQgih+gv35mJUgK
   g==;
X-IronPort-AV: E=Sophos;i="5.97,278,1669100400"; 
   d="scan'208";a="195671483"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Feb 2023 21:13:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 21:13:09 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 21:13:03 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <macro@orcam.me.uk>, <andriy.shevchenko@linux.intel.com>,
        <lukas@wunner.de>, <cang1@live.co.uk>,
        <matthew.gerlach@linux.intel.com>, <deller@gmx.de>,
        <phil.edworthy@renesas.com>, <geert+renesas@glider.be>,
        <marpagan@redhat.com>, <u.kleine-koenig@pengutronix.de>,
        <etremblay@distech-controls.com>, <wander@redhat.com>,
        <UNGLinuxDriver@microchip.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v13 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for quad-uart support
Date:   Tue, 7 Feb 2023 22:18:12 +0530
Message-ID: <20230207164814.3104605-3-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207164814.3104605-1-kumaravel.thiagarajan@microchip.com>
References: <20230207164814.3104605-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v13:
- No Change

Changes in v12:
- No Change

Changes in v11:
- Code rebased to linux-next master branch as suggested by Greg

Changes in v10:
- Added spaces to improve readability
- Used macro for PORT_OFFSET
- Used pci_free_irq_vectors API

Changes in v9:
- Reshuffled code logically
- Modified datatype of few variables
- Removed un-necessary else
- Used PCI_VDEVICE()

Changes in v8:
- Requested only required number of interrupt vectors in
  pci_alloc_irq_vectors
  API based on sub-device id

Changes in v7:
- Used appropriate error codes
- Moved logical_to_physical_port_idx array to a function

Changes in v6:
- Removed un-necessary paranthesis
- Used array and removed switch cases to reduce complexity
- Handled failure case of pcim_iomap

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
 drivers/tty/serial/8250/8250_pci1xxxx.c | 329 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |  11 +
 drivers/tty/serial/8250/Makefile        |   1 +
 include/uapi/linux/serial_core.h        |   3 +
 6 files changed, 359 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index abed40db41f0..20da292fcadf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13692,6 +13692,13 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-mchp-pci1xxxx.c
 
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
index 000000000000..ea04c014edb9
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -0,0 +1,329 @@
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
+#include "8250_pcilib.h"
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
+#define PCI_SUBDEVICE_ID_EFAR_PCI12000		PCI_DEVICE_ID_EFAR_PCI12000
+#define PCI_SUBDEVICE_ID_EFAR_PCI11010		PCI_DEVICE_ID_EFAR_PCI11010
+#define PCI_SUBDEVICE_ID_EFAR_PCI11101		PCI_DEVICE_ID_EFAR_PCI11101
+#define PCI_SUBDEVICE_ID_EFAR_PCI11400		PCI_DEVICE_ID_EFAR_PCI11400
+#define PCI_SUBDEVICE_ID_EFAR_PCI11414		PCI_DEVICE_ID_EFAR_PCI11414
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
+#define UART_CLOCK_DEFAULT			(62500 * HZ_PER_KHZ)
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
+#define MAX_PORTS				4
+#define PORT_OFFSET				0x100
+
+static const int logical_to_physical_port_idx[][MAX_PORTS] = {
+	{0,  1,  2,  3}, /* PCI12000, PCI11010, PCI11101, PCI11400, PCI11414 */
+	{0,  1,  2,  3}, /* PCI4p */
+	{0,  1,  2, -1}, /* PCI3p012 */
+	{0,  1,  3, -1}, /* PCI3p013 */
+	{0,  2,  3, -1}, /* PCI3p023 */
+	{1,  2,  3, -1}, /* PCI3p123 */
+	{0,  1, -1, -1}, /* PCI2p01 */
+	{0,  2, -1, -1}, /* PCI2p02 */
+	{0,  3, -1, -1}, /* PCI2p03 */
+	{1,  2, -1, -1}, /* PCI2p12 */
+	{1,  3, -1, -1}, /* PCI2p13 */
+	{2,  3, -1, -1}, /* PCI2p23 */
+	{0, -1, -1, -1}, /* PCI1p0 */
+	{1, -1, -1, -1}, /* PCI1p1 */
+	{2, -1, -1, -1}, /* PCI1p2 */
+	{3, -1, -1, -1}, /* PCI1p3 */
+};
+
+struct pci1xxxx_8250 {
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
+	case PCI_SUBDEVICE_ID_EFAR_PCI12000:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11010:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11101:
+	case PCI_SUBDEVICE_ID_EFAR_PCI11400:
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
+	quot = NSEC_PER_SEC / (baud * UART_BIT_SAMPLE_CNT);
+	*frac = (NSEC_PER_SEC - quot * baud * UART_BIT_SAMPLE_CNT) *
+		  255 / UART_BIT_SAMPLE_CNT / baud;
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
+static int pci1xxxx_setup(struct pci_dev *pdev,
+			  struct uart_8250_port *port, int port_idx)
+{
+	int ret;
+
+	port->port.flags |= UPF_FIXED_TYPE | UPF_SKIP_TEST;
+	port->port.type = PORT_MCHP16550A;
+	port->port.set_termios = serial8250_do_set_termios;
+	port->port.get_divisor = pci1xxxx_get_divisor;
+	port->port.set_divisor = pci1xxxx_set_divisor;
+
+	ret = serial8250_pci_setup_port(pdev, port, 0, PORT_OFFSET * port_idx, 0);
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
+static unsigned int pci1xxxx_get_max_port(int subsys_dev)
+{
+	unsigned int i = MAX_PORTS;
+
+	if (subsys_dev < ARRAY_SIZE(logical_to_physical_port_idx))
+		while (i--) {
+			if (logical_to_physical_port_idx[subsys_dev][i] != -1)
+				return logical_to_physical_port_idx[subsys_dev][i] + 1;
+		}
+
+	if (subsys_dev == PCI_SUBDEVICE_ID_EFAR_PCI11414)
+		return 4;
+
+	return 1;
+}
+
+static int pci1xxxx_logical_to_physical_port_translate(int subsys_dev, int port)
+{
+	if (subsys_dev < ARRAY_SIZE(logical_to_physical_port_idx))
+		return logical_to_physical_port_idx[subsys_dev][port];
+
+	return logical_to_physical_port_idx[0][port];
+}
+
+static int pci1xxxx_serial_probe(struct pci_dev *pdev,
+				 const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct pci1xxxx_8250 *priv;
+	struct uart_8250_port uart;
+	unsigned int max_vec_reqd;
+	unsigned int nr_ports, i;
+	int num_vectors;
+	int subsys_dev;
+	int port_idx;
+	int rc;
+
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
+	priv->membase = pci_ioremap_bar(pdev, 0);
+	if (!priv->membase)
+		return -ENOMEM;
+
+	pci_set_master(pdev);
+
+	priv->nr = nr_ports;
+
+	subsys_dev = pdev->subsystem_device;
+	max_vec_reqd = pci1xxxx_get_max_port(subsys_dev);
+
+	num_vectors = pci_alloc_irq_vectors(pdev, 1, max_vec_reqd, PCI_IRQ_ALL_TYPES);
+	if (num_vectors < 0) {
+		pci_iounmap(pdev, priv->membase);
+		return num_vectors;
+	}
+
+	memset(&uart, 0, sizeof(uart));
+	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT;
+	uart.port.uartclk = UART_CLOCK_DEFAULT;
+	uart.port.dev = dev;
+
+	if (num_vectors == max_vec_reqd)
+		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI, priv->membase + UART_PCI_CTRL_REG);
+
+	for (i = 0; i < nr_ports; i++) {
+		priv->line[i] = -ENODEV;
+
+		port_idx = pci1xxxx_logical_to_physical_port_translate(subsys_dev, i);
+
+		if (num_vectors == max_vec_reqd)
+			uart.port.irq = pci_irq_vector(pdev, port_idx);
+		else
+			uart.port.irq = pci_irq_vector(pdev, 0);
+
+		rc = pci1xxxx_setup(pdev, &uart, port_idx);
+		if (rc) {
+			dev_warn(dev, "Failed to setup port %u\n", i);
+			continue;
+		}
+
+		priv->line[i] = serial8250_register_8250_port(&uart);
+		if (priv->line[i] < 0) {
+			dev_warn(dev,
+				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
+				uart.port.iobase, uart.port.irq, uart.port.iotype,
+				priv->line[i]);
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
+	unsigned int i;
+
+	for (i = 0; i < priv->nr; i++) {
+		if (priv->line[i] >= 0)
+			serial8250_unregister_port(priv->line[i]);
+	}
+
+	pci_free_irq_vectors(dev);
+	pci_iounmap(dev, priv->membase);
+}
+
+static const struct pci_device_id pci1xxxx_pci_tbl[] = {
+	{ PCI_VDEVICE(EFAR, PCI_DEVICE_ID_EFAR_PCI11010) },
+	{ PCI_VDEVICE(EFAR, PCI_DEVICE_ID_EFAR_PCI11101) },
+	{ PCI_VDEVICE(EFAR, PCI_DEVICE_ID_EFAR_PCI11400) },
+	{ PCI_VDEVICE(EFAR, PCI_DEVICE_ID_EFAR_PCI11414) },
+	{ PCI_VDEVICE(EFAR, PCI_DEVICE_ID_EFAR_PCI12000) },
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
+static_assert((ARRAY_SIZE(logical_to_physical_port_idx) == PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3 + 1));
+
+MODULE_IMPORT_NS(SERIAL_8250_PCI);
+MODULE_DESCRIPTION("Microchip Technology Inc. PCIe to UART module");
+MODULE_AUTHOR("Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>");
+MODULE_AUTHOR("Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 33be7aad11ef..bb375a7f0328 100644
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
index 9b3ba28cc562..978dc196c29b 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -295,6 +295,17 @@ config SERIAL_8250_HUB6
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8250_hub6.
 
+config SERIAL_8250_PCI1XXXX
+	tristate "Microchip 8250 based serial port"
+	depends on SERIAL_8250 && PCI
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
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index ce63a250da3b..4fc2fc1f41b6 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
 obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
+obj-$(CONFIG_SERIAL_8250_PCI1XXXX)	+= 8250_pci1xxxx.o
 obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
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

