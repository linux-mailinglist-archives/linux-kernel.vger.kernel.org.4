Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51116FC528
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjEILkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjEILj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:39:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200903AB9;
        Tue,  9 May 2023 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683632385; x=1715168385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bkJgaLj7zK96fyaXORrKNOWGAI9VWJOsk35I/PUkbQk=;
  b=Z8X/yBrO/qKMjNBqFkVHccn6tjqxoGr6obJ1IxOj61kxzS55eGCpKPLG
   sJVPCYUT19VkJJ9UOkXUKz3cRCPxZZO1/J6EK0Pq62JJ19635VtSOw93G
   0evEyuGIF39SsIu/nVXSpSDKYlUqCL0h9Wo4zvEv47qwmdx1Om1xnyiAV
   miTD66urIVOSgteNzpKN48L3KzM9GSZUvZPI91sMa5j+eHhYnKW9Fiza/
   YlQCvnvVHqjCDlPX6tAhgTJJP0fVW5iL2Deo7rJrPV4E1RC7vwqOBa8Kz
   hsfkGZ8rRSMzDKHugC+C0paHXJ80TuZLmNFEjflwEAO5jWMw3LoW+iPxL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347362077"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="347362077"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 04:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="763805943"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="763805943"
Received: from mbrdon-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.219.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 04:39:42 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 3/6] serial: 8250: Add dl_read/write, bugs and mapsize into plat_serial8250_port
Date:   Tue,  9 May 2023 14:39:21 +0300
Message-Id: <20230509113924.19540-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230509113924.19540-1-ilpo.jarvinen@linux.intel.com>
References: <20230509113924.19540-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c |  4 ++++
 include/linux/serial_8250.h         | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

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
index d64e7bbe1f2f..82cd8d90a040 100644
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
+	unsigned short	bugs;		/* port bugs */
 	unsigned int	(*serial_in)(struct uart_port *, int);
 	void		(*serial_out)(struct uart_port *, int, int);
+	u32		(*dl_read)(struct uart_8250_port *up);
+	void		(*dl_write)(struct uart_8250_port *up, u32 value);
 	void		(*set_termios)(struct uart_port *,
 			               struct ktermios *new,
 			               const struct ktermios *old);
-- 
2.30.2

