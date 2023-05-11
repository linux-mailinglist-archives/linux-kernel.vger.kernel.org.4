Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C036FF133
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbjEKMLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjEKMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:11:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3504C9EE4;
        Thu, 11 May 2023 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683807066; x=1715343066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w5yXdZv/UjA/KEHxfuCkXVmrB4pRybYt9dFnF1/VjLA=;
  b=nezD5+bKa8q4FOZ7UBrpM0KJSmA10ufCoRQaXGQhHmAde/CtlC3hWuv0
   NM8iyPw9a1Y9IuZH3zJLOhfad/PT5P8TzO1XFcFZgrF+KMrpyMMcLrSgs
   dZXqYtcAa3CYRcmhIqelM5XOqHTUfX6CpobKZTDnUuOZXo1NkevdWCs4K
   jkiQ6Xr7V7ShHJ5M5RbLc5nJXU84onEnRkGiwAbEvLf4i/8uG/rBRsDOc
   xFCKIteTBiGOs6vufFWAEsAYsDnbzvIanUtV3IGO7A9+OrZOvdYZonRK9
   SkwNVUemiPT4+iI8CyBWTlrqoYwoENuD1ZCBI3K5FnUvRNz4+JpD0QUUG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="330839044"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="330839044"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="843921188"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="843921188"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:10:40 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 1/6] serial: 8250: Change dl_read/write to handle value as u32
Date:   Thu, 11 May 2023 15:10:24 +0300
Message-Id: <20230511121029.13128-2-ilpo.jarvinen@linux.intel.com>
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

Divisor latch read/write functions currently handle the value is int.
As the value is related to HW context, u32 makes much more sense than a
signed type.

While at it, name the parameters in the callback signature.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h          |  4 ++--
 drivers/tty/serial/8250/8250_em.c       |  4 ++--
 drivers/tty/serial/8250/8250_port.c     | 10 +++++-----
 drivers/tty/serial/8250/8250_pxa.c      |  2 +-
 drivers/tty/serial/8250/8250_uniphier.c |  4 ++--
 include/linux/serial_8250.h             |  4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 1e8fe44a7099..5418708f4631 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -167,12 +167,12 @@ static unsigned int __maybe_unused serial_icr_read(struct uart_8250_port *up,
 
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
 
-static inline int serial_dl_read(struct uart_8250_port *up)
+static inline u32 serial_dl_read(struct uart_8250_port *up)
 {
 	return up->dl_read(up);
 }
 
-static inline void serial_dl_write(struct uart_8250_port *up, int value)
+static inline void serial_dl_write(struct uart_8250_port *up, u32 value)
 {
 	up->dl_write(up, value);
 }
diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index 25a9ecf26be6..ef5019e944ea 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -139,12 +139,12 @@ static void serial8250_em_serial_out(struct uart_port *p, int offset, int value)
 	}
 }
 
-static int serial8250_em_serial_dl_read(struct uart_8250_port *up)
+static u32 serial8250_em_serial_dl_read(struct uart_8250_port *up)
 {
 	return serial_in(up, UART_DLL_EM) | serial_in(up, UART_DLM_EM) << 8;
 }
 
-static void serial8250_em_serial_dl_write(struct uart_8250_port *up, int value)
+static void serial8250_em_serial_dl_write(struct uart_8250_port *up, u32 value)
 {
 	serial_out(up, UART_DLL_EM, value & 0xff);
 	serial_out(up, UART_DLM_EM, value >> 8 & 0xff);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fe8d79c4ae95..344bd447639b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -325,7 +325,7 @@ static const struct serial8250_config uart_config[] = {
 };
 
 /* Uart divisor latch read */
-static int default_serial_dl_read(struct uart_8250_port *up)
+static u32 default_serial_dl_read(struct uart_8250_port *up)
 {
 	/* Assign these in pieces to truncate any bits above 7.  */
 	unsigned char dll = serial_in(up, UART_DLL);
@@ -335,7 +335,7 @@ static int default_serial_dl_read(struct uart_8250_port *up)
 }
 
 /* Uart divisor latch write */
-static void default_serial_dl_write(struct uart_8250_port *up, int value)
+static void default_serial_dl_write(struct uart_8250_port *up, u32 value)
 {
 	serial_out(up, UART_DLL, value & 0xff);
 	serial_out(up, UART_DLM, value >> 8 & 0xff);
@@ -389,12 +389,12 @@ void au_serial_out(struct uart_port *p, int offset, int value)
 }
 
 /* Au1x00 haven't got a standard divisor latch */
-static int au_serial_dl_read(struct uart_8250_port *up)
+static u32 au_serial_dl_read(struct uart_8250_port *up)
 {
 	return __raw_readl(up->port.membase + 0x28);
 }
 
-static void au_serial_dl_write(struct uart_8250_port *up, int value)
+static void au_serial_dl_write(struct uart_8250_port *up, u32 value)
 {
 	__raw_writel(value, up->port.membase + 0x28);
 }
@@ -847,7 +847,7 @@ static void disable_rsa(struct uart_8250_port *up)
 static int size_fifo(struct uart_8250_port *up)
 {
 	unsigned char old_fcr, old_mcr, old_lcr;
-	unsigned short old_dl;
+	u32 old_dl;
 	int count;
 
 	old_lcr = serial_in(up, UART_LCR);
diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 795e55142d4c..28b341f602c6 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -60,7 +60,7 @@ static const struct of_device_id serial_pxa_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
 
 /* Uart divisor latch write */
-static void serial_pxa_dl_write(struct uart_8250_port *up, int value)
+static void serial_pxa_dl_write(struct uart_8250_port *up, u32 value)
 {
 	unsigned int dll;
 
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index a2978abab0db..a405155264b1 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -145,12 +145,12 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
  * The divisor latch register exists at different address.
  * Override dl_read/write callbacks.
  */
-static int uniphier_serial_dl_read(struct uart_8250_port *up)
+static u32 uniphier_serial_dl_read(struct uart_8250_port *up)
 {
 	return readl(up->port.membase + UNIPHIER_UART_DLR);
 }
 
-static void uniphier_serial_dl_write(struct uart_8250_port *up, int value)
+static void uniphier_serial_dl_write(struct uart_8250_port *up, u32 value)
 {
 	writel(value, up->port.membase + UNIPHIER_UART_DLR);
 }
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 6f78f302d272..7b5d558e4e0c 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -129,8 +129,8 @@ struct uart_8250_port {
 	const struct uart_8250_ops *ops;
 
 	/* 8250 specific callbacks */
-	int			(*dl_read)(struct uart_8250_port *);
-	void			(*dl_write)(struct uart_8250_port *, int);
+	u32			(*dl_read)(struct uart_8250_port *up);
+	void			(*dl_write)(struct uart_8250_port *up, u32 value);
 
 	struct uart_8250_em485 *em485;
 	void			(*rs485_start_tx)(struct uart_8250_port *);
-- 
2.30.2

