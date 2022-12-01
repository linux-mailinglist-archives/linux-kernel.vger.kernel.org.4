Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3098263E904
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLAEvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLAEvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:51:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C7099F6B;
        Wed, 30 Nov 2022 20:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669870274; x=1701406274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lfpVGRH8pltqZXjI3RqjNSR9YB5pgEh4vVlSlb798AM=;
  b=1iWqUzk9Kv6+6ABeG3GRtngghbpXvYPybiv7qslLbG1L0towejSdS3tv
   d8ZkrxD2xkenw1kWWuh4hpXvODv6GPX46zmc1qIZS4ItWMiIfAohIfUR+
   P2hfcufI/QaZrtxbb9ajgR6WVWJxTp0sk9bpCwhVD5Jqid8Nu3/pu9LAB
   LEHqUb89NIB6/66qXl0Y1joaH8GOdoaAWH3ZwwhQTS/TNdwNOPx2BVQ6V
   1lvDLC/OpYXvwTSLHidyC77l3nTAIhOzkJg9c4oE8uyetapdfPNOXh8ju
   71NUKrDYODee3nWBRloW+3KrZ4oZ+cixkUz4v5oS+AM4BL7tWGqjiC7zb
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="125921825"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Nov 2022 21:51:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 30 Nov 2022 21:51:12 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 30 Nov 2022 21:51:06 -0700
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
Subject: [PATCH v6 tty-next 1/4] serial: 8250_pci: Add serial8250_pci_setup_port definition in 8250_pcilib.c
Date:   Thu, 1 Dec 2022 10:21:43 +0530
Message-ID: <20221201045146.1055913-2-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
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
Changes in v6:
- Made this patch first patch of the patch series

Changes in v5:
- This is the new patch added in v5 version of this patchset
- Moved implementation of setup_port from 8250_pci.c to 8250_pcilib.c

---
 drivers/tty/serial/8250/8250_pci.c    | 24 ++---------------
 drivers/tty/serial/8250/8250_pcilib.c | 38 +++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.h |  9 +++++++
 drivers/tty/serial/8250/Kconfig       |  4 +++
 drivers/tty/serial/8250/Makefile      |  1 +
 5 files changed, 54 insertions(+), 22 deletions(-)
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
index d0b49e15fbf5..3088eaff3ad0 100644
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
@@ -500,6 +501,9 @@ config SERIAL_8250_MID
 	  Intel Medfield SOC and various other Intel platforms that is not
 	  covered by the more generic SERIAL_8250_PCI option.
 
+config SERIAL_8250_PCILIB
+	bool
+
 config SERIAL_8250_PERICOM
 	tristate "Support for Pericom and Acces I/O serial ports"
 	default SERIAL_8250
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

