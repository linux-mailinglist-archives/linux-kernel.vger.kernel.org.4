Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF37E64DF00
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiLOQwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLOQw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:52:29 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DD33C3D;
        Thu, 15 Dec 2022 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671123140; x=1702659140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hd14m/OsgZY2FCMy8bN9j1ZGbVOmF9fQe17XOneFFzc=;
  b=GUWEJtTItXXhRgHaQGPa2tG9oagif/KF4oH65M3ih+BeGgm8g6RuqSGv
   vgNf1+iJ+g378fhtDxLyh1QBagsorwh8SFM/VZT1DjH5x9CrTws/vaGA/
   WsqXE8rQqEkMRgRnno5sUMqEDRf1RIHsbHXfHfTxDuVV1duwjNzs3MzBp
   X+LgyVtCqno9eizoKhhulb8Pj2GXRXqI611pgS5GtiQXm39WVrqe7iul+
   MxZ5uiy6FGOxQQVmgrU9uaZ5pBW9u04im+Yjv7hxaZFfKGw72nEXDQ3Qf
   QJOQpLHkerpt0EPJ/uYwF6gvBGiU71JJMPGnUm/GZX5sP5X3N0yv2g8r6
   g==;
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="193245119"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2022 09:52:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:52:17 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:52:12 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <macro@orcam.me.uk>, <andriy.shevchenko@linux.intel.com>,
        <cang1@live.co.uk>, <colin.i.king@gmail.com>,
        <phil.edworthy@renesas.com>, <biju.das.jz@bp.renesas.com>,
        <geert+renesas@glider.be>, <lukas@wunner.de>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <UNGLinuxDriver@microchip.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v9 tty-next 1/4] serial: 8250_pci: Add serial8250_pci_setup_port definition in 8250_pcilib.c
Date:   Fri, 16 Dec 2022 10:56:53 +0530
Message-ID: <20221216052656.2098100-2-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
References: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move implementation of setup_port func() to serial8250_pci_setup_port.

Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v9:
- Added License in 8250_pcilib.c file

Changes in v8:
- Moved SERIAL_8250_PCILIB above 8250_PCI

Changes in v7:
- Used namespace 'SERIAL_8250_PCI' while exporting and importing symbols
- Included structures used in function declaration in 8250_pcilib.h file

Changes in v6:
- Made this patch first patch of the patch series

Changes in v5:
- This is the new patch added in v5 version of this patchset
- Moved implementation of setup_port from 8250_pci.c to 8250_pcilib.c
---
 drivers/tty/serial/8250/8250_pci.c    | 25 +++--------------
 drivers/tty/serial/8250/8250_pcilib.c | 39 +++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.h | 15 +++++++++++
 drivers/tty/serial/8250/Kconfig       |  4 +++
 drivers/tty/serial/8250/Makefile      |  1 +
 5 files changed, 62 insertions(+), 22 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.h

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6f66dc2ebacc..58cc9e19bd20 100644
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
@@ -5759,3 +5739,4 @@ module_pci_driver(serial_pci_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 PCI serial probe module");
 MODULE_DEVICE_TABLE(pci, serial_pci_tbl);
+MODULE_IMPORT_NS(SERIAL_8250_PCI);
diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
new file mode 100644
index 000000000000..a7124cda1871
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -0,0 +1,39 @@
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
+EXPORT_SYMBOL_NS_GPL(serial8250_pci_setup_port, SERIAL_8250_PCI);
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_pcilib.h b/drivers/tty/serial/8250/8250_pcilib.h
new file mode 100644
index 000000000000..1aaf1b50ce9c
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pcilib.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * 8250 PCI library header file.
+ *
+ * Copyright (C) 2001 Russell King, All Rights Reserved.
+ */
+
+#include <linux/types.h>
+
+struct pci_dev;
+
+struct uart_8250_port;
+
+int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port, u8 bar,
+		   unsigned int offset, int regshift);
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d0b49e15fbf5..768b73d5cb9a 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -129,9 +129,13 @@ config SERIAL_8250_DMA
 	  This builds DMA support that can be used with 8250/16650
 	  compatible UART controllers that support DMA signaling.
 
+config SERIAL_8250_PCILIB
+	bool
+
 config SERIAL_8250_PCI
 	tristate "8250/16550 PCI device support"
 	depends on SERIAL_8250 && PCI
+	select SERIAL_8250_PCILIB
 	default SERIAL_8250
 	help
 	  This builds standard PCI serial support. You may be able to
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index bee908f99ea0..b9179d1f104b 100644
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

