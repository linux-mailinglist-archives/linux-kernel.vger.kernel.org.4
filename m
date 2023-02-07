Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E8E68CE08
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBGENZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBGENP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:13:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B06E34322;
        Mon,  6 Feb 2023 20:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675743183; x=1707279183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RXzPIrgCmIKSn3pfFwcJ9Y/F7zmkat1rzWbUZPlHwSk=;
  b=frlyG3r0Om52XPFMcCS4C6MP0AIz7PUcWzR59+1k0tlvlRHC1CDCwcUG
   Q2BjVGL82sj4G756XrhxLieoUQtxRL/LiBUhdRzf1237fpIcn6mLffEpY
   SDiteTIbmfu4cQJ0MjXGuuQyRbPqloc1fZApC5xEyH3M2lCkspoCHzaOs
   5NR8mEqCLpD6J/z2YbNA+FqSoDNJZ9SXjilBIrnrmWMLd+MupdH3I8dq3
   GLg8RHnV8yMrZbsFZN3+bxfEKcJ5x2WNasjIiel/RkCp6lsKJqTApVwoK
   OJXXWz7MuOEgIhyD0A38ymadgQG5xeebA71ucFAYQ2fEEjFVxP8ByFqSW
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,278,1669100400"; 
   d="scan'208";a="199598322"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Feb 2023 21:13:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 21:13:00 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 21:12:54 -0700
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
Subject: [PATCH v13 tty-next 1/4] serial: 8250_pci: Add serial8250_pci_setup_port definition in 8250_pcilib.c
Date:   Tue, 7 Feb 2023 22:18:11 +0530
Message-ID: <20230207164814.3104605-2-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207164814.3104605-1-kumaravel.thiagarajan@microchip.com>
References: <20230207164814.3104605-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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
Changes in v13:
- Include 8250_pcilib.h after 8250.h in 8250_pcilib.c to maintain consistency

Changes in v12:
- Fix warnings reported by Kernel test robot <lkp@intel.com>

Changes in v11:
- Code rebased to linux-next master branch as suggested by Greg

Changes in v10:
- No Change

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
 drivers/tty/serial/8250/8250_pci.c    | 25 ++---------------
 drivers/tty/serial/8250/8250_pcilib.c | 40 +++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.h | 15 ++++++++++
 drivers/tty/serial/8250/Kconfig       |  4 +++
 drivers/tty/serial/8250/Makefile      |  1 +
 5 files changed, 63 insertions(+), 22 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.h

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 8e9f247590bd..c55be6fda0ca 100644
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
@@ -5757,3 +5737,4 @@ module_pci_driver(serial_pci_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 PCI serial probe module");
 MODULE_DEVICE_TABLE(pci, serial_pci_tbl);
+MODULE_IMPORT_NS(SERIAL_8250_PCI);
diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
new file mode 100644
index 000000000000..d234e9194feb
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_pcilib.c
@@ -0,0 +1,40 @@
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
+#include "8250_pcilib.h"
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
index 020ef532940d..9b3ba28cc562 100644
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
index 4e1a32812683..ce63a250da3b 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
+8250_base-$(CONFIG_SERIAL_8250_PCILIB)	+= 8250_pcilib.o
 obj-$(CONFIG_SERIAL_8250_PARISC)	+= 8250_parisc.o
 obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
 obj-$(CONFIG_SERIAL_8250_EXAR)		+= 8250_exar.o
-- 
2.25.1

