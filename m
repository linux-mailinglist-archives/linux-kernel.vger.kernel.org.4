Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC4C62D284
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiKQFBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbiKQFB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:01:29 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907755EFBC;
        Wed, 16 Nov 2022 21:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668661271; x=1700197271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kAX5MQqJTgNHv4iAalM8+t7MxjisXhGhjV5aIh817HM=;
  b=VaN6XOoH+7bIKLDF8ZChyKuy8X3ugk8jP7ot8pMRwuakmlbBS4d153bd
   A1OdlOXRLiCsx5B0kaBLXgKxTIbjaTwc4rDyy/F/0AUAfKKZEV/9uy8xy
   R/NZ/upBHw9f7HkKKhphopU5iPuUZxz+BLOzwwfDgSz4xVyGTJEhYzG0c
   IrpSmIaMn0bZyQeqROizTeb1PjaG8QiQcSXX2xvciCAgJF0oj1Haq2KBy
   6pc3rz8eA/UAuBSrWbUTm2RzaiElmooFZwmO97IMsbAekE625ZT9ruQmy
   JJmdJEO8GUK2Zfpq7f9tXnN+sm5NKvcLoWi42pZV6nBjXtL3AKq1x3au/
   A==;
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="123828817"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2022 22:01:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 16 Nov 2022 22:01:10 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 16 Nov 2022 22:01:04 -0700
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
Subject: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add serial8250_pci_setup_port definition in 8250_pcilib.c
Date:   Thu, 17 Nov 2022 10:31:24 +0530
Message-ID: <20221117050126.2966714-3-kumaravel.thiagarajan@microchip.com>
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

Move implementation of setup_port API to serial8250_pci_setup_port

Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
Changes in v5:
- This is the new patch added in v5 version of this patchset
- Moved implementation of setup_port from 8250_pci.c to 8250_pcilib.c

---
 drivers/tty/serial/8250/8250_pci.c      | 24 ++--------------
 drivers/tty/serial/8250/8250_pci1xxxx.c |  6 ++++
 drivers/tty/serial/8250/8250_pcilib.c   | 38 +++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.h   |  9 ++++++
 drivers/tty/serial/8250/Kconfig         |  5 ++++
 drivers/tty/serial/8250/Makefile        |  1 +
 6 files changed, 61 insertions(+), 22 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.h

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6f66dc2ebacc..69ff367b08de 100644
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
+	return serial8250_pci_setup_port(priv->dev, port, bar, offset, regshift);
 }
 
 /*
diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 9dd7aca76e58..02b9c6959dcc 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -22,6 +22,7 @@
 #include <asm/byteorder.h>
 
 #include "8250.h"
+#include "8250_pcilib.h"
 
 #define PCI_DEVICE_ID_EFAR_PCI12000		0xa002
 #define PCI_DEVICE_ID_EFAR_PCI11010		0xa012
@@ -143,6 +144,7 @@ static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
 {
 	int first_offset;
 	int offset;
+	int ret;
 
 	switch (priv->dev->subsystem_device) {
 	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
@@ -191,6 +193,10 @@ static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
 	port->port.set_termios = serial8250_do_set_termios;
 	port->port.get_divisor = pci1xxxx_get_divisor;
 	port->port.set_divisor = pci1xxxx_set_divisor;
+	ret = serial8250_pci_setup_port(priv->dev, port, 0, offset, 0);
+	if (ret < 0)
+		return ret;
+
 	writeb(UART_BLOCK_SET_ACTIVE, port->port.membase + UART_ACTV_REG);
 	writeb(UART_WAKE_SRCS, port->port.membase + UART_WAKE_REG);
 	writeb(UART_WAKE_N_PIN, port->port.membase + UART_WAKE_MASK_REG);
diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
new file mode 100644
index 000000000000..e5a4a9b22c81
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 8250 PCI library.
+ *
+ * Copyright (C) 2001 Russell King, All Rights Reserved.
+ */
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "8250.h"
+
+int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
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
+EXPORT_SYMBOL_GPL(serial8250_pci_setup_port);
diff --git a/drivers/tty/serial/8250/8250_pcilib.h b/drivers/tty/serial/8250/8250_pcilib.h
new file mode 100644
index 000000000000..41ef01d5c3c5
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pcilib.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * 8250 PCI library header file.
+ *
+ * Copyright (C) 2001 Russell King, All Rights Reserved.
+ */
+
+int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port, u8 bar,
+		   unsigned int offset, int regshift);
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 1c41722d8ac5..f67542470eae 100644
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
@@ -294,6 +295,7 @@ config SERIAL_8250_HUB6
 config SERIAL_8250_PCI1XXXX
 	tristate "Microchip 8250 based serial port"
 	depends on SERIAL_8250_PCI
+	select SERIAL_8250_PCILIB
 	default SERIAL_8250
 	help
 	 Select this option if you have a setup with Microchip PCIe
@@ -510,6 +512,9 @@ config SERIAL_8250_MID
 	  Intel Medfield SOC and various other Intel platforms that is not
 	  covered by the more generic SERIAL_8250_PCI option.
 
+config SERIAL_8250_PCILIB
+	bool
+
 config SERIAL_8250_PERICOM
 	tristate "Support for Pericom and Acces I/O serial ports"
 	default SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index fbc7d47c25bd..98202fdf39f8 100644
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
-- 
2.25.1

