Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F16FF13A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbjEKMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbjEKMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:12:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561F5D2D3;
        Thu, 11 May 2023 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683807095; x=1715343095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bQwaBMF4EB3l67IdUfgyOuMgjhNUpTmDntlOCO37oHg=;
  b=dnRLwUd6FBYvQ5bizdHcnKPa5vyvRhvjKXU+CyMefiOunRMoKy2ILnnA
   kd1fSZJDkgfUB8HwuFK2KbMz/Mc4qqSJM90ebOzCc7iYcr3ABASDY1geV
   mFPhnidnhVr25pCbI2UqXLG9xFSMlVRErTUWtdTDLn0l0qry6EYcioJ0h
   b0mZ2s+MSteaaMdvKtAxbCQx2fLNVDOZhJ7cOqaZ3a2mnc3WcJd4gKgph
   mxvca2UfdHg68wSKvYep3/j3bc02wbz20hWTgTvF+APJCs7+ffhen+Efk
   iXbtsqcdMMnl2swIAtS+8QR++gEVJZhCjlaVBFXgQyOqrN9zrrld4Ocot
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="330839217"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="330839217"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:11:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="843921343"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="843921343"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:11:08 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 3/6] serial: 8250: Add dl_read/write, bugs and mapsize into plat_serial8250_port
Date:   Thu, 11 May 2023 15:10:26 +0300
Message-Id: <20230511121029.13128-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230511121029.13128-1-ilpo.jarvinen@linux.intel.com>
References: <20230511121029.13128-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mapsize, bugs, and divisor latch read/write functions
(->dl_read/write()) into plat_serial8250_port to carry the setup
necessary for RT288x/Au1xxx devices over to uart port.

Document the added members with kerneldoc style but do not enable
kerneldoc yet as there are many fields which remain undocumented.

While at it, convert .bugs in struct uart_8250_port to u16 to match it
with the type used in struct plat_serial8250_port.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c |  4 ++++
 include/linux/serial_8250.h         | 21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 13bf535eedcd..21b15b130d12 100644
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
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index d64e7bbe1f2f..42fc8f64f48e 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -11,13 +11,29 @@
 #include <linux/serial_reg.h>
 #include <linux/platform_device.h>
 
+struct uart_8250_port;
+
 /*
  * This is the platform device platform_data structure
+ *
+ * @mapsize:	Port size for ioremap()
+ * @bugs:	Port bugs
+ *
+ * @dl_read: ``u32 ()(struct uart_8250_port *up)``
+ *
+ *	UART divisor latch read.
+ *
+ * @dl_write: ``void ()(struct uart_8250_port *up, u32 value)``
+ *
+ *	Write @value into UART divisor latch.
+ *
+ *	Locking: Caller holds port's lock.
  */
 struct plat_serial8250_port {
 	unsigned long	iobase;		/* io base address */
 	void __iomem	*membase;	/* ioremap cookie or NULL */
 	resource_size_t	mapbase;	/* resource base */
+	resource_size_t	mapsize;
 	unsigned int	uartclk;	/* UART clock rate */
 	unsigned int	irq;		/* interrupt number */
 	unsigned long	irqflags;	/* request_irq flags */
@@ -28,8 +44,11 @@ struct plat_serial8250_port {
 	unsigned char	has_sysrq;	/* supports magic SysRq */
 	unsigned int	type;		/* If UPF_FIXED_TYPE */
 	upf_t		flags;		/* UPF_* flags */
+	u16		bugs;		/* port bugs */
 	unsigned int	(*serial_in)(struct uart_port *, int);
 	void		(*serial_out)(struct uart_port *, int, int);
+	u32		(*dl_read)(struct uart_8250_port *up);
+	void		(*dl_write)(struct uart_8250_port *up, u32 value);
 	void		(*set_termios)(struct uart_port *,
 			               struct ktermios *new,
 			               const struct ktermios *old);
@@ -106,7 +125,7 @@ struct uart_8250_port {
 	struct timer_list	timer;		/* "no irq" timer */
 	struct list_head	list;		/* ports on this IRQ */
 	u32			capabilities;	/* port capabilities */
-	unsigned short		bugs;		/* port bugs */
+	u16			bugs;		/* port bugs */
 	bool			fifo_bug;	/* min RX trigger if enabled */
 	unsigned int		tx_loadsz;	/* transmit fifo load size */
 	unsigned char		acr;
-- 
2.30.2

