Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890B86FABF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjEHLTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjEHLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:19:11 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61F0037C46;
        Mon,  8 May 2023 04:19:10 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 1F39D8111;
        Mon,  8 May 2023 11:19:07 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, Andrew Davis <afd@ti.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS
Date:   Mon,  8 May 2023 14:19:02 +0300
Message-Id: <20230508111903.39339-1-tony@atomide.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already allocate CONFIG_SERIAL_8250_NR_UARTS, but only allow using
CONFIG_SERIAL_8250_RUNTIME_UARTS uarts unless nr_uarts module params
is set. This causes issues for using distro kernels on SoCs with a
large number of serial ports.

Let's allow up to CONFIG_SERIAL_8250_NR_UARTS instead. To do this, we init
the ports as needed if the initial uarts was too low. This way there's no
need to set the value for CONFIG_SERIAL_8250_RUNTIME_UARTS to some SoC
specific higher value. Typically the default value of 4 can be used as
set for legacy reasons.

Note that limiting the number of intial uarts still works as before
unless a serial console on a higher port is specified. In this case we
will increase the nr_ports up to the console port specified.

Suggested-by: Andrew Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_core.c | 86 +++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -488,6 +488,34 @@ static inline void serial8250_apply_quirks(struct uart_8250_port *up)
 	up->port.quirks |= skip_txen_test ? UPQ_NO_TXEN_TEST : 0;
 }
 
+static struct uart_8250_port *serial8250_setup_port(int index)
+{
+	struct uart_8250_port *up;
+
+	if (index >= UART_NR)
+		return NULL;
+
+	up = &serial8250_ports[index];
+	up->port.line = index;
+
+	serial8250_init_port(up);
+	if (!base_ops)
+		base_ops = up->port.ops;
+	up->port.ops = &univ8250_port_ops;
+
+	timer_setup(&up->timer, serial8250_timeout, 0);
+
+	up->ops = &univ8250_driver_ops;
+
+	if (IS_ENABLED(CONFIG_ALPHA_JENSEN) ||
+	    (IS_ENABLED(CONFIG_ALPHA_GENERIC) && alpha_jensen()))
+		up->port.set_mctrl = alpha_jensen_set_mctrl;
+
+	serial8250_set_defaults(up);
+
+	return up;
+}
+
 static void __init serial8250_isa_init_ports(void)
 {
 	struct uart_8250_port *up;
@@ -501,26 +529,13 @@ static void __init serial8250_isa_init_ports(void)
 	if (nr_uarts > UART_NR)
 		nr_uarts = UART_NR;
 
-	for (i = 0; i < nr_uarts; i++) {
-		struct uart_8250_port *up = &serial8250_ports[i];
-		struct uart_port *port = &up->port;
-
-		port->line = i;
-		serial8250_init_port(up);
-		if (!base_ops)
-			base_ops = port->ops;
-		port->ops = &univ8250_port_ops;
-
-		timer_setup(&up->timer, serial8250_timeout, 0);
-
-		up->ops = &univ8250_driver_ops;
-
-		if (IS_ENABLED(CONFIG_ALPHA_JENSEN) ||
-		    (IS_ENABLED(CONFIG_ALPHA_GENERIC) && alpha_jensen()))
-			port->set_mctrl = alpha_jensen_set_mctrl;
-
-		serial8250_set_defaults(up);
-	}
+	/*
+	 * Set up initial isa ports based on nr_uart module param, or else
+	 * default to CONFIG_SERIAL_8250_RUNTIME_UARTS. Note that we do not
+	 * need to increase nr_uarts when setting up the initial isa ports.
+	 */
+	for (i = 0; i < nr_uarts; i++)
+		serial8250_setup_port(i);
 
 	/* chain base port ops to support Remote Supervisor Adapter */
 	univ8250_port_ops = *base_ops;
@@ -586,16 +601,29 @@ static void univ8250_console_write(struct console *co, const char *s,
 
 static int univ8250_console_setup(struct console *co, char *options)
 {
+	struct uart_8250_port *up;
 	struct uart_port *port;
-	int retval;
+	int retval, i;
 
 	/*
 	 * Check whether an invalid uart number has been specified, and
 	 * if so, search for the first available port that does have
 	 * console support.
 	 */
-	if (co->index >= nr_uarts)
+	if (co->index >= UART_NR)
 		co->index = 0;
+
+	/*
+	 * If the console is past the initial isa ports, init more ports up to
+	 * co->index as needed and increment nr_uarts accordingly.
+	 */
+	for (i = nr_uarts; i <= co->index; i++) {
+		up = serial8250_setup_port(i);
+		if (!up)
+			return -ENODEV;
+		nr_uarts++;
+	}
+
 	port = &serial8250_ports[co->index].port;
 	/* link port to console */
 	port->cons = co;
@@ -990,7 +1018,18 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	mutex_lock(&serial_mutex);
 
 	uart = serial8250_find_match_or_unused(&up->port);
-	if (uart && uart->port.type != PORT_8250_CIR) {
+	if (!uart) {
+		/*
+		 * If the port is past the initial isa ports, initialize a new
+		 * port and increment nr_uarts accordingly.
+		 */
+		uart = serial8250_setup_port(nr_uarts);
+		if (!uart)
+			goto unlock;
+		nr_uarts++;
+	}
+
+	if (uart->port.type != PORT_8250_CIR) {
 		struct mctrl_gpios *gpios;
 
 		if (uart->port.dev)
@@ -1120,6 +1159,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		}
 	}
 
+unlock:
 	mutex_unlock(&serial_mutex);
 
 	return ret;
-- 
2.40.1
