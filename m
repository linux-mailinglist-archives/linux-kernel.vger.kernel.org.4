Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7627D5B4AAB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiIJW4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIJW4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:56:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1B42AE32
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:56:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662850572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZoaZUiuVv6BWFHO/m2g0FWD+9Or5kBIzh3/01/yDsQo=;
        b=bYi/U4oQOoJzKcvrEjXqp5vVjwjOzmhwtvXqKQhpVhByvXQlT3rggCwyozTRyKLVzTYSWM
        UAVUQxzTxKqYePri6C90P0fQRa/zAVaEwzl36NCTI1JQ0stHe4F83i2hx+D2Obn+UYfU7y
        wOJ9qb+IBk4QEQxRLvsybIyz4WuUxXQBaki6hddx02jw+pPHwHvW/cRhVlILyaaipbL1K7
        5OtyeBtjyDFGZys+ALkd4jZxg23FW5YdJHq97sVrpGy+Up/sXh5bzjKUirag5ajNfFTvOf
        CehX63kJ217oYKgCilQhV1zl1aAgXhgOgpWh8nuIUNW05Q8ZRZnpJpGKV2DcGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662850572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZoaZUiuVv6BWFHO/m2g0FWD+9Or5kBIzh3/01/yDsQo=;
        b=tJRwI9zq908yfq7rDVmpR5UZlFOgZiWRV511efJJ06yxC9CYZv4mTlvnM2KbGZcgFbVXdD
        y5jMgAJfj9T3NWAA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [patch RFC 00/29] printk: A new approach - WIP
In-Reply-To: <20220910221947.171557773@linutronix.de>
References: <20220910221947.171557773@linutronix.de>
Date:   Sun, 11 Sep 2022 00:56:11 +0200
Message-ID: <877d2ayh2s.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11 2022 at 00:27, Thomas Gleixner wrote:
> For testing we used the most simple driver: a hacked up version of the
> early uart8250 console as we wanted to concentrate on validating the core
> mechanisms of friendly handover and hostile takeovers instead of dealing
> with the horrors of port locks or whatever at the same time. That's the
> next challenge. Hack patch will be provided in a reply.

Here you go.

---
Subject: serial: 8250: Use 8250 serial for exploring noBKL consoles
From: John Ogness <jogness@linutronix.de>
Date: Sat, 10 Sep 2022 01:05:34 +0200

From: John Ogness <jogness@linutronix.de>

Utilize 8250 early console - the only console in the kernel which is
reentrancy and NMI safe - to explore the noBKL console infrastructure.

Not-Signed-off-by: John Ogness <jogness@linutronix.de>
Not-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/tty/serial/8250/8250_early.c |   32 ++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig      |   11 ++++++++++-
 drivers/tty/serial/8250/Makefile     |    2 +-
 3 files changed, 43 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -107,6 +107,34 @@ static void early_serial8250_write(struc
 	uart_console_write(port, s, count, serial_putc);
 }
 
+static bool __early_serial8250_write(struct console *con, struct cons_write_context *wctxt,
+				     unsigned char c)
+{
+	struct earlycon_device *device = con->data;
+	struct uart_port *port = &device->port;
+	unsigned char *s = wctxt->outbuf;
+
+	serial_putc(port, c);
+
+	for (; wctxt->pos < wctxt->len; wctxt->pos++, s++) {
+		if (!console_can_proceed(wctxt))
+			return false;
+
+		uart_console_write(port, s, 1, serial_putc);
+	}
+	return true;
+}
+
+static bool early_serial8250_write_thread(struct console *con, struct cons_write_context *wctxt)
+{
+	return __early_serial8250_write(con, wctxt, 'T');
+}
+
+static bool early_serial8250_write_atomic(struct console *con, struct cons_write_context *wctxt)
+{
+	return __early_serial8250_write(con, wctxt, 'A');
+}
+
 #ifdef CONFIG_CONSOLE_POLL
 static int early_serial8250_read(struct console *console,
 				 char *s, unsigned int count)
@@ -170,6 +198,10 @@ int __init early_serial8250_setup(struct
 
 	device->con->write = early_serial8250_write;
 	device->con->read = early_serial8250_read;
+	device->con->flags &= ~CON_BOOT;
+	device->con->flags |= CON_NO_BKL;
+	device->con->write_thread = early_serial8250_write_thread;
+	device->con->write_atomic = early_serial8250_write_atomic;
 	return 0;
 }
 EARLYCON_DECLARE(uart8250, early_serial8250_setup);
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -82,9 +82,18 @@ config SERIAL_8250_FINTEK
 
 	  If unsure, say N.
 
+config SERIAL_8250_CONSOLE_EARLY
+	bool "Console on 8250/16550 and compatible noBKL console mockup"
+	default SERIAL_8250
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Mockup to demonstrate the core capabilities for noBKL consoles.
+	  OTOH, the _only_ reliable reentrant and NMI safe console...
+
 config SERIAL_8250_CONSOLE
 	bool "Console on 8250/16550 and compatible serial port"
-	depends on SERIAL_8250=y
+	depends on SERIAL_8250=y && !SERIAL_8250_CONSOLE_EARLY
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_SERIAL_8250_CS)		+= serial_
 obj-$(CONFIG_SERIAL_8250_ACORN)		+= 8250_acorn.o
 obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)	+= 8250_aspeed_vuart.o
 obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
-obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
+obj-$(CONFIG_SERIAL_8250_CONSOLE_EARLY)	+= 8250_early.o
 obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
 obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
