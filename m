Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14056597DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 12:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiL3Lq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 06:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiL3LqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:46:18 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C02E62DB;
        Fri, 30 Dec 2022 03:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672400777; x=1703936777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtSkcYMzGm6Fn5IM9TXvRFRsB0XXHaEyliLgw9/jX7I=;
  b=kSP8KF0GiWWTCspcwHHqXD70zcgW/B6N5g7wLvuZMJdF9dSv4Q74/+OY
   9P1vl/WGkre2QhFqXLrxW+8W+wvwdVEMZo1NxUo/53ACMa7XS6aRaYl5r
   BhLkQOuqSC4iFe9B2Z1hDCvxFoO9GRofIREckCk3s7ttl5jdviD/vpEcp
   duTv3uQhCfURZMhm3kB7A3nVSx3YocdfN4ILeWLg2D+Jqk5xXDlg9aHI4
   z05nhQGTrGUefBoF8N3nUjGNaULqYbSxIg/Swmv+AW82sa5dnD2Ix5JFA
   cNsjGWdnfF4UQDbt9fn3i1IFUzTRXbJw+XaqZCVrk9P8jQDdyawEdsUns
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="301568004"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="301568004"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 03:46:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="653865350"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="653865350"
Received: from vsemouch-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 03:46:13 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     inux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] serial: 8250: RT288x/Au1xxx code away from core
Date:   Fri, 30 Dec 2022 13:46:01 +0200
Message-Id: <20221230114603.16946-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221230114603.16946-1-ilpo.jarvinen@linux.intel.com>
References: <20221230114603.16946-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A non-trivial amount of RT288x/Au1xxx code is encapsulated into
ifdeffery in 8250_port / 8250_early and some if/switch UPIO_AU blocks.

Create a separate file from them. Add mapsize, bugs, and divisor latch
read/write functions into plat_serial8250_port to carry the setup
necessary for these devices over to uart port.

Also handle errors properly in the cases where RT288x/Au1xxx code is
not configured.

It seems that 0x1000 mapsize is likely overkill but I've kept it the
same as previously (the value was shrunk to that value in b2b13cdfd05e
("SERIAL 8250: Fixes for Alchemy UARTs.")). Seemingly, the driver only
needs to access register at 0x28 for the divisor latch.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/mips/alchemy/common/platform.c   |  10 +-
 drivers/tty/serial/8250/8250_core.c   |   4 +
 drivers/tty/serial/8250/8250_early.c  |  21 ----
 drivers/tty/serial/8250/8250_of.c     |   4 +-
 drivers/tty/serial/8250/8250_port.c   |  78 --------------
 drivers/tty/serial/8250/8250_rt288x.c | 141 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/Makefile      |   1 +
 include/linux/serial_8250.h           |  14 ++-
 8 files changed, 169 insertions(+), 104 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_rt288x.c

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index b8f3397c59c9..d4ab34b3b404 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -51,9 +51,9 @@ static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 #define PORT(_base, _irq)					\
 	{							\
 		.mapbase	= _base,			\
+		.mapsize	= 0x1000,			\
 		.irq		= _irq,				\
 		.regshift	= 2,				\
-		.iotype		= UPIO_AU,			\
 		.flags		= UPF_SKIP_TEST | UPF_IOREMAP | \
 				  UPF_FIXED_TYPE,		\
 		.type		= PORT_16550A,			\
@@ -124,8 +124,14 @@ static void __init alchemy_setup_uarts(int ctype)
 	au1xx0_uart_device.dev.platform_data = ports;
 
 	/* Fill up uartclk. */
-	for (s = 0; s < c; s++)
+	for (s = 0; s < c; s++) {
 		ports[s].uartclk = uartclk;
+		if (au_platform_setup(&ports[s]) < 0) {
+			kfree(ports);
+			printk(KERN_INFO "Alchemy: missing support for UARTs\n");
+			return;
+		}
+	}
 	if (platform_device_register(&au1xx0_uart_device))
 		printk(KERN_INFO "Alchemy: failed to register UARTs\n");
 }
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index ab63c308be0a..a5cc3dcb7572 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -822,12 +822,16 @@ static int serial8250_probe(struct platform_device *dev)
 		uart.port.iotype	= p->iotype;
 		uart.port.flags		= p->flags;
 		uart.port.mapbase	= p->mapbase;
+		uart.port.mapsize	= p->mapsize;
 		uart.port.hub6		= p->hub6;
 		uart.port.has_sysrq	= p->has_sysrq;
 		uart.port.private_data	= p->private_data;
 		uart.port.type		= p->type;
+		uart.bugs		= p->bugs;
 		uart.port.serial_in	= p->serial_in;
 		uart.port.serial_out	= p->serial_out;
+		uart.dl_read		= p->dl_read;
+		uart.dl_write		= p->dl_write;
 		uart.port.handle_irq	= p->handle_irq;
 		uart.port.handle_break	= p->handle_break;
 		uart.port.set_termios	= p->set_termios;
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index f271becfc46c..77a2e4441920 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -36,7 +36,6 @@
 
 static unsigned int serial8250_early_in(struct uart_port *port, int offset)
 {
-	int reg_offset = offset;
 	offset <<= port->regshift;
 
 	switch (port->iotype) {
@@ -50,8 +49,6 @@ static unsigned int serial8250_early_in(struct uart_port *port, int offset)
 		return ioread32be(port->membase + offset);
 	case UPIO_PORT:
 		return inb(port->iobase + offset);
-	case UPIO_AU:
-		return port->serial_in(port, reg_offset);
 	default:
 		return 0;
 	}
@@ -59,7 +56,6 @@ static unsigned int serial8250_early_in(struct uart_port *port, int offset)
 
 static void serial8250_early_out(struct uart_port *port, int offset, int value)
 {
-	int reg_offset = offset;
 	offset <<= port->regshift;
 
 	switch (port->iotype) {
@@ -78,9 +74,6 @@ static void serial8250_early_out(struct uart_port *port, int offset, int value)
 	case UPIO_PORT:
 		outb(value, port->iobase + offset);
 		break;
-	case UPIO_AU:
-		port->serial_out(port, reg_offset, value);
-		break;
 	}
 }
 
@@ -199,17 +192,3 @@ OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
 
 #endif
-
-#ifdef CONFIG_SERIAL_8250_RT288X
-
-static int __init early_au_setup(struct earlycon_device *dev, const char *opt)
-{
-	dev->port.serial_in = au_serial_in;
-	dev->port.serial_out = au_serial_out;
-	dev->port.iotype = UPIO_AU;
-	dev->con->write = early_serial8250_write;
-	return 0;
-}
-OF_EARLYCON_DECLARE(palmchip, "ralink,rt2880-uart", early_au_setup);
-
-#endif
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 1b461fba15a3..c9f6bd7a7038 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -171,7 +171,9 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	switch (type) {
 	case PORT_RT2880:
-		port->iotype = UPIO_AU;
+		ret = rt288x_setup(port);
+		if (ret)
+			goto err_unprepare;
 		break;
 	}
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index beba8f38b3dc..c9c5c864e1c3 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -332,66 +332,6 @@ static void default_serial_dl_write(struct uart_8250_port *up, int value)
 	serial_out(up, UART_DLM, value >> 8 & 0xff);
 }
 
-#ifdef CONFIG_SERIAL_8250_RT288X
-
-#define UART_REG_UNMAPPED	-1
-
-/* Au1x00/RT288x UART hardware has a weird register layout */
-static const s8 au_io_in_map[8] = {
-	[UART_RX]	= 0,
-	[UART_IER]	= 2,
-	[UART_IIR]	= 3,
-	[UART_LCR]	= 5,
-	[UART_MCR]	= 6,
-	[UART_LSR]	= 7,
-	[UART_MSR]	= 8,
-	[UART_SCR]	= UART_REG_UNMAPPED,
-};
-
-static const s8 au_io_out_map[8] = {
-	[UART_TX]	= 1,
-	[UART_IER]	= 2,
-	[UART_FCR]	= 4,
-	[UART_LCR]	= 5,
-	[UART_MCR]	= 6,
-	[UART_LSR]	= UART_REG_UNMAPPED,
-	[UART_MSR]	= UART_REG_UNMAPPED,
-	[UART_SCR]	= UART_REG_UNMAPPED,
-};
-
-unsigned int au_serial_in(struct uart_port *p, int offset)
-{
-	if (offset >= ARRAY_SIZE(au_io_in_map))
-		return UINT_MAX;
-	offset = au_io_in_map[offset];
-	if (offset == UART_REG_UNMAPPED)
-		return UINT_MAX;
-	return __raw_readl(p->membase + (offset << p->regshift));
-}
-
-void au_serial_out(struct uart_port *p, int offset, int value)
-{
-	if (offset >= ARRAY_SIZE(au_io_out_map))
-		return;
-	offset = au_io_out_map[offset];
-	if (offset == UART_REG_UNMAPPED)
-		return;
-	__raw_writel(value, p->membase + (offset << p->regshift));
-}
-
-/* Au1x00 haven't got a standard divisor latch */
-static int au_serial_dl_read(struct uart_8250_port *up)
-{
-	return __raw_readl(up->port.membase + 0x28);
-}
-
-static void au_serial_dl_write(struct uart_8250_port *up, int value)
-{
-	__raw_writel(value, up->port.membase + 0x28);
-}
-
-#endif
-
 static unsigned int hub6_serial_in(struct uart_port *p, int offset)
 {
 	offset = offset << p->regshift;
@@ -501,15 +441,6 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_out = mem32be_serial_out;
 		break;
 
-#ifdef CONFIG_SERIAL_8250_RT288X
-	case UPIO_AU:
-		p->serial_in = au_serial_in;
-		p->serial_out = au_serial_out;
-		up->dl_read = au_serial_dl_read;
-		up->dl_write = au_serial_dl_write;
-		break;
-#endif
-
 	default:
 		p->serial_in = io_serial_in;
 		p->serial_out = io_serial_out;
@@ -2945,11 +2876,6 @@ static unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
 	if (pt->port.mapsize)
 		return pt->port.mapsize;
-	if (pt->port.iotype == UPIO_AU) {
-		if (pt->port.type == PORT_RT2880)
-			return 0x100;
-		return 0x1000;
-	}
 	if (is_omap1_8250(pt))
 		return 0x16 << pt->port.regshift;
 
@@ -3199,10 +3125,6 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 	if (flags & UART_CONFIG_TYPE)
 		autoconfig(up);
 
-	/* if access method is AU, it is a 16550 with a quirk */
-	if (port->type == PORT_16550A && port->iotype == UPIO_AU)
-		up->bugs |= UART_BUG_NOMSR;
-
 	/* HW bugs may trigger IRQ while IIR == NO_INT */
 	if (port->type == PORT_TEGRA)
 		up->bugs |= UART_BUG_NOMSR;
diff --git a/drivers/tty/serial/8250/8250_rt288x.c b/drivers/tty/serial/8250/8250_rt288x.c
new file mode 100644
index 000000000000..cb9a86bd3a07
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_rt288x.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RT288x/Au1xxx driver
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+
+#include "8250.h"
+
+#define UART_REG_UNMAPPED	-1
+
+/* Au1x00/RT288x UART hardware has a weird register layout */
+static const s8 au_io_in_map[8] = {
+	[UART_RX]	= 0,
+	[UART_IER]	= 2,
+	[UART_IIR]	= 3,
+	[UART_LCR]	= 5,
+	[UART_MCR]	= 6,
+	[UART_LSR]	= 7,
+	[UART_MSR]	= 8,
+	[UART_SCR]	= UART_REG_UNMAPPED,
+};
+
+static const s8 au_io_out_map[8] = {
+	[UART_TX]	= 1,
+	[UART_IER]	= 2,
+	[UART_FCR]	= 4,
+	[UART_LCR]	= 5,
+	[UART_MCR]	= 6,
+	[UART_LSR]	= UART_REG_UNMAPPED,
+	[UART_MSR]	= UART_REG_UNMAPPED,
+	[UART_SCR]	= UART_REG_UNMAPPED,
+};
+
+static unsigned int au_serial_in(struct uart_port *p, int offset)
+{
+	if (offset >= ARRAY_SIZE(au_io_in_map))
+		return UINT_MAX;
+	offset = au_io_in_map[offset];
+	if (offset == UART_REG_UNMAPPED)
+		return UINT_MAX;
+	return __raw_readl(p->membase + (offset << p->regshift));
+}
+
+static void au_serial_out(struct uart_port *p, int offset, int value)
+{
+	if (offset >= ARRAY_SIZE(au_io_out_map))
+		return;
+	offset = au_io_out_map[offset];
+	if (offset == UART_REG_UNMAPPED)
+		return;
+	__raw_writel(value, p->membase + (offset << p->regshift));
+}
+
+/* Au1x00 haven't got a standard divisor latch */
+static int au_serial_dl_read(struct uart_8250_port *up)
+{
+	return __raw_readl(up->port.membase + 0x28);
+}
+
+static void au_serial_dl_write(struct uart_8250_port *up, int value)
+{
+	__raw_writel(value, up->port.membase + 0x28);
+}
+
+int au_platform_setup(struct plat_serial8250_port *p)
+{
+	p->iotype = UPIO_AU;
+
+	p->serial_in = au_serial_in;
+	p->serial_out = au_serial_out;
+	p->dl_read = au_serial_dl_read;
+	p->dl_write = au_serial_dl_write;
+
+	p->mapsize = 0x1000;
+
+	p->bugs |= UART_BUG_NOMSR;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(au_platform_setup);
+
+int rt288x_setup(struct uart_port *p) {
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	p->iotype = UPIO_AU;
+
+	p->serial_in = au_serial_in;
+	p->serial_out = au_serial_out;
+	up->dl_read = au_serial_dl_read;
+	up->dl_write = au_serial_dl_write;
+
+	p->mapsize = 0x100;
+
+	up->bugs |= UART_BUG_NOMSR;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt288x_setup);
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+static void au_putc(struct uart_port *port, unsigned char c)
+{
+	unsigned int status;
+
+	au_serial_out(port, UART_TX, c);
+
+	for (;;) {
+		status = au_serial_in(port, UART_LSR);
+		if (uart_lsr_tx_empty(status))
+			break;
+		cpu_relax();
+	}
+}
+
+static void au_early_serial8250_write(struct console *console,
+				      const char *s, unsigned int count)
+{
+	struct earlycon_device *device = console->data;
+	struct uart_port *port = &device->port;
+
+	uart_console_write(port, s, count, au_putc);
+}
+
+static int __init early_au_setup(struct earlycon_device *dev, const char *opt)
+{
+	rt288x_setup(&dev->port);
+	dev->con->write = au_early_serial8250_write;
+
+	return 0;
+}
+OF_EARLYCON_DECLARE(palmchip, "ralink,rt2880-uart", early_au_setup);
+#endif
+
+MODULE_DESCRIPTION("RT288x/Au1xxx UART driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 1615bfdde2a0..7ac162c1c79b 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
+8250_base-$(CONFIG_SERIAL_8250_RT288X)	+= 8250_rt288x.o
 obj-$(CONFIG_SERIAL_8250_PARISC)	+= 8250_parisc.o
 obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
 obj-$(CONFIG_SERIAL_8250_EXAR)		+= 8250_exar.o
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 19376bee9667..66318658f8bc 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -7,10 +7,13 @@
 #ifndef _LINUX_SERIAL_8250_H
 #define _LINUX_SERIAL_8250_H
 
+#include <linux/errno.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/platform_device.h>
 
+struct uart_8250_port;
+
 /*
  * This is the platform device platform_data structure
  */
@@ -18,6 +21,7 @@ struct plat_serial8250_port {
 	unsigned long	iobase;		/* io base address */
 	void __iomem	*membase;	/* ioremap cookie or NULL */
 	resource_size_t	mapbase;	/* resource base */
+	resource_size_t	mapsize;
 	unsigned int	irq;		/* interrupt number */
 	unsigned long	irqflags;	/* request_irq flags */
 	unsigned int	uartclk;	/* UART clock rate */
@@ -28,8 +32,11 @@ struct plat_serial8250_port {
 	unsigned char	has_sysrq;	/* supports magic SysRq */
 	upf_t		flags;		/* UPF_* flags */
 	unsigned int	type;		/* If UPF_FIXED_TYPE */
+	unsigned short	bugs;		/* port bugs */
 	unsigned int	(*serial_in)(struct uart_port *, int);
 	void		(*serial_out)(struct uart_port *, int, int);
+	int		(*dl_read)(struct uart_8250_port *);
+	void		(*dl_write)(struct uart_8250_port *, int);
 	void		(*set_termios)(struct uart_port *,
 			               struct ktermios *new,
 			               const struct ktermios *old);
@@ -188,8 +195,11 @@ extern void serial8250_set_isa_configurator(void (*v)
 						u32 *capabilities));
 
 #ifdef CONFIG_SERIAL_8250_RT288X
-unsigned int au_serial_in(struct uart_port *p, int offset);
-void au_serial_out(struct uart_port *p, int offset, int value);
+int rt288x_setup(struct uart_port *p);
+int au_platform_setup(struct plat_serial8250_port *p);
+#else
+static inline int rt288x_setup(struct uart_port *p) { return -ENODEV; }
+static inline int au_platform_setup(struct plat_serial8250_port *p) { return -ENODEV; }
 #endif
 
 #endif
-- 
2.30.2

