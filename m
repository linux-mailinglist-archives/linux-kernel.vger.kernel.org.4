Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0A665E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbjAKOwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbjAKOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:51:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AB819C24;
        Wed, 11 Jan 2023 06:51:57 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673448715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C3ShpcOwOQrvdccdvZNmwpq5oNx/F35tbPLB2fWoef8=;
        b=IxLWTMd44vVjt+DirBUWgQYJI/UOfvIW8vYd8ssjsPkHlrjpioQhApzLpwEmh6T3hICiOK
        Vt2UE6NAVZRw8JydZxC6ukdxTmTvhFNNfeYB6iaDvBaVTy5AvSeNOvR86IL7KWStfVNQIR
        L2Y6VwUxDpieUmqyo2V6KO6QtsF3syndBf7DzhElOpiQCMAgpF/lAhX6LtxuNHWmS/kROt
        Rr5cOPYJDcRnA9mzbOMx7+vgmgG4htzS8p4gDm9NTTnMcR25EP/SQgr3TViTvmemDLzlUM
        qRgM803Rro8yMRdOMR++SSbuhZV3WYHoTt44/mIo4BBvs2aRUGGenk0A87jyCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673448715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C3ShpcOwOQrvdccdvZNmwpq5oNx/F35tbPLB2fWoef8=;
        b=uoOqLfetODlsE968Zaka7g/1SL5Ga0HewEV2DZsZZXbcna0JECOq1/c8A+3uvgPhsO5i6W
        v6OdmN8tCIo0HEDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: kgdboc: fix mutex locking order for configure_kgdboc()
Date:   Wed, 11 Jan 2023 15:57:10 +0106
Message-Id: <20230111145110.1327831-1-john.ogness@linutronix.de>
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

Several mutexes are taken while setting up console serial ports. In
particular, the tty_port->mutex and @console_mutex are taken:

  serial_pnp_probe
    serial8250_register_8250_port
      uart_add_one_port (locks tty_port->mutex)
        uart_configure_port
          register_console (locks @console_mutex)

In order to synchronize kgdb's tty_find_polling_driver() with
register_console(), commit 6193bc90849a ("tty: serial: kgdboc:
synchronize tty_find_polling_driver() and register_console()") takes
the @console_mutex. However, this leads to the following call chain
(with locking):

  platform_probe
    kgdboc_probe
      configure_kgdboc (locks @console_mutex)
        tty_find_polling_driver
          uart_poll_init (locks tty_port->mutex)
            uart_set_options

This is clearly deadlock potential due to the reverse lock ordering.

Since uart_set_options() requires holding @console_mutex in order to
serialize early initialization of the serial-console lock, take the
@console_mutex in uart_poll_init() instead of configure_kgdboc().

Since configure_kgdboc() was using @console_mutex for safe traversal
of the console list, change it to use the SRCU iterator instead.

Add comments to uart_set_options() kerneldoc mentioning that it
requires holding @console_mutex (aka the console_list_lock).

Fixes: 6193bc90849a ("tty: serial: kgdboc: synchronize tty_find_polling_driver() and register_console()")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/kgdboc.c      | 16 ++++------------
 drivers/tty/serial/serial_core.c |  5 +++++
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index a3ed9b34e2ab..f7df46cc1890 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -171,6 +171,7 @@ static int configure_kgdboc(void)
 	int err = -ENODEV;
 	char *cptr = config;
 	struct console *cons;
+	int cookie;
 
 	if (!strlen(config) || isspace(config[0])) {
 		err = 0;
@@ -189,15 +190,6 @@ static int configure_kgdboc(void)
 	if (kgdboc_register_kbd(&cptr))
 		goto do_register;
 
-	/*
-	 * tty_find_polling_driver() can call uart_set_options()
-	 * (via poll_init) to configure the uart. Take the console_list_lock
-	 * in order to synchronize against register_console(), which can also
-	 * configure the uart via uart_set_options(). This also allows safe
-	 * traversal of the console list.
-	 */
-	console_list_lock();
-
 	p = tty_find_polling_driver(cptr, &tty_line);
 	if (!p) {
 		console_list_unlock();
@@ -211,7 +203,8 @@ static int configure_kgdboc(void)
 	 */
 	console_lock();
 
-	for_each_console(cons) {
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(cons) {
 		int idx;
 		if (cons->device && cons->device(cons, &idx) == p &&
 		    idx == tty_line) {
@@ -219,11 +212,10 @@ static int configure_kgdboc(void)
 			break;
 		}
 	}
+	console_srcu_read_unlock(cookie);
 
 	console_unlock();
 
-	console_list_unlock();
-
 	kgdb_tty_driver = p;
 	kgdb_tty_line = tty_line;
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b9fbbee598b8..ec874f3a567c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2212,6 +2212,9 @@ EXPORT_SYMBOL_GPL(uart_parse_options);
  * @parity: parity character - 'n' (none), 'o' (odd), 'e' (even)
  * @bits: number of data bits
  * @flow: flow control character - 'r' (rts)
+ *
+ * Locking: Caller must hold console_list_lock in order to serialize
+ * early initialization of the serial-console lock.
  */
 int
 uart_set_options(struct uart_port *port, struct console *co,
@@ -2619,7 +2622,9 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 
 	if (!ret && options) {
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
+		console_list_lock();
 		ret = uart_set_options(port, NULL, baud, parity, bits, flow);
+		console_list_unlock();
 	}
 out:
 	mutex_unlock(&tport->mutex);

base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
-- 
2.30.2

