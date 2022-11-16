Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1A262C438
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiKPQYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiKPQWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EDD56EE1;
        Wed, 16 Nov 2022 08:22:08 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvYIlIwdOZX0ToDjYltIx1ojqweQggTLKVs/EsUfUxM=;
        b=cDkHuByF8QExd1GzBvcO0Kt+WxLMtwjdTUOjC1Nx7dklHUvQJAlA1sNg5coF7q2rC7AWD6
        P3Z+ORdHR1pxbm0K+YzrMnac67OvU46jjMVNB7LL2GLWgE3+XblyNAEe8rVxvs70fmg0Fv
        KQX2bhp26f4Yk3zWfZCiVXeY0XqKN4WNDJR3L6WfeAlrwmmDou0KZJE/vHWLddRiaV7G8Y
        n74SjpC07KjR+Jr6Gqru1CCO9E+ATUGtJv9vG4IBuhfNyKphfYgIF/sdXFFB/YIdEe5jxI
        vV2QkFv9raU0RxhKR/c5A+3SNDgWx5JRSl5OCOKDbCCiZyJLfnbuyo5T3r6Xmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvYIlIwdOZX0ToDjYltIx1ojqweQggTLKVs/EsUfUxM=;
        b=UMmPPfjn/9pjYQ1xq/OO3fIsM130tZbyDJI1u9YMmWJRne9j/mf6hd2YYK5HXxEuJS3gbM
        uNscX4mSzGEWblAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-serial@vger.kernel.org
Subject: [PATCH printk v5 22/40] serial_core: replace uart_console_enabled() with uart_console_registered()
Date:   Wed, 16 Nov 2022 17:27:34 +0106
Message-Id: <20221116162152.193147-23-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of uart_console_enabled() really want to know if a console
is registered. It is not reliable to check for CON_ENABLED in order
to identify if a console is registered. Use console_is_registered()
instead.

A _locked() variant is provided because uart_set_options() is always
called with the console_list_lock held and must check if a console
is registered in order to synchronize with kgdboc.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/8250/8250_core.c |  2 +-
 drivers/tty/serial/pic32_uart.c     |  2 +-
 drivers/tty/serial/serial_core.c    | 14 +++++++-------
 include/linux/serial_core.h         | 10 ++++++++--
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 94fbf0add2ce..74568292186f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -565,7 +565,7 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 
 		up->port.dev = dev;
 
-		if (uart_console_enabled(&up->port))
+		if (uart_console_registered(&up->port))
 			pm_runtime_get_sync(up->port.dev);
 
 		serial8250_apply_quirks(up);
diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 2beada66c824..1183b2a26539 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -919,7 +919,7 @@ static int pic32_uart_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_SERIAL_PIC32_CONSOLE
-	if (uart_console_enabled(port)) {
+	if (uart_console_registered(port)) {
 		/* The peripheral clock has been enabled by console_setup,
 		 * so disable it till the port is used.
 		 */
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 179ee199df34..b9fbbee598b8 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2223,11 +2223,11 @@ uart_set_options(struct uart_port *port, struct console *co,
 	/*
 	 * Ensure that the serial-console lock is initialised early.
 	 *
-	 * Note that the console-enabled check is needed because of kgdboc,
-	 * which can end up calling uart_set_options() for an already enabled
+	 * Note that the console-registered check is needed because
+	 * kgdboc can call uart_set_options() for an already registered
 	 * console via tty_find_polling_driver() and uart_poll_init().
 	 */
-	if (!uart_console_enabled(port) && !port->console_reinit)
+	if (!uart_console_registered_locked(port) && !port->console_reinit)
 		uart_port_spin_lock_init(port);
 
 	memset(&termios, 0, sizeof(struct ktermios));
@@ -2573,7 +2573,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * successfully registered yet, try to re-register it.
 		 * It may be that the port was not available.
 		 */
-		if (port->cons && !(port->cons->flags & CON_ENABLED))
+		if (port->cons && !console_is_registered(port->cons))
 			register_console(port->cons);
 
 		/*
@@ -2956,7 +2956,7 @@ static ssize_t console_show(struct device *dev,
 	mutex_lock(&port->mutex);
 	uport = uart_port_check(state);
 	if (uport)
-		console = uart_console_enabled(uport);
+		console = uart_console_registered(uport);
 	mutex_unlock(&port->mutex);
 
 	return sprintf(buf, "%c\n", console ? 'Y' : 'N');
@@ -2978,7 +2978,7 @@ static ssize_t console_store(struct device *dev,
 	mutex_lock(&port->mutex);
 	uport = uart_port_check(state);
 	if (uport) {
-		oldconsole = uart_console_enabled(uport);
+		oldconsole = uart_console_registered(uport);
 		if (oldconsole && !newconsole) {
 			ret = unregister_console(uport->cons);
 		} else if (!oldconsole && newconsole) {
@@ -3086,7 +3086,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	 * If this port is in use as a console then the spinlock is already
 	 * initialised.
 	 */
-	if (!uart_console_enabled(uport))
+	if (!uart_console_registered(uport))
 		uart_port_spin_lock_init(uport);
 
 	if (uport->cons && uport->dev)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d657f2a42a7b..91871464b99d 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -743,9 +743,15 @@ static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;
 static inline int setup_earlycon(char *buf) { return 0; }
 #endif
 
-static inline bool uart_console_enabled(struct uart_port *port)
+/* Variant of uart_console_registered() when the console_list_lock is held. */
+static inline bool uart_console_registered_locked(struct uart_port *port)
 {
-	return uart_console(port) && (port->cons->flags & CON_ENABLED);
+	return uart_console(port) && console_is_registered_locked(port->cons);
+}
+
+static inline bool uart_console_registered(struct uart_port *port)
+{
+	return uart_console(port) && console_is_registered(port->cons);
 }
 
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
-- 
2.30.2

