Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A4710903
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbjEYJe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbjEYJek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:34:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF70919C;
        Thu, 25 May 2023 02:34:30 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685007268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NGWDH2m9xz3zGie63zl1kcLGjTJ0fX1VflVrGzz2ZQ=;
        b=Kja8EByGHMg80rkSKT9+A6oAP7Ytw5mSKQu0+uGfVfwe5tVdGCEi5josuEM1SwN606+mom
        tJOhrFWIt2zJG+DlK5DjPmWfVz6loRqSChpbkp8HXvZab2zEzJXhmgL0k+AWUZunXGh4bK
        ZB+SftTZW59pKhVFlzUNZNYOpZMdX8zxvpepVbJv55/P+jYmWnd8ln/AejbG3dDoZJevAa
        J7Qto8rkUPaEA13Qh78iauHtxD9/MNjhQsamwocWO64h7fGgSzp5rGrAHv5Xn4mRXNmpig
        fi0pD7NC4PYFiEdTiZBJclw3eqzxfLzFQqzujGa99ba9O296DwZrG+8YpmfJ+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685007268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NGWDH2m9xz3zGie63zl1kcLGjTJ0fX1VflVrGzz2ZQ=;
        b=mmiTP6jCW1+KvC8QM+LWeB5WcVHbyStKgJqzDNEQsZrG0o3PYsrEqd/a7KE5S+4YPNPZjx
        20P+WWxS57IdbmBQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Matthew Howell <matthew.howell@sealevel.com>,
        Tony Lindgren <tony@atomide.com>,
        Lukas Wunner <lukas@wunner.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org
Subject: [PATCH tty v1 1/8] serial: 8250: lock port in startup() callbacks
Date:   Thu, 25 May 2023 11:37:52 +0206
Message-Id: <20230525093159.223817-2-john.ogness@linutronix.de>
In-Reply-To: <20230525093159.223817-1-john.ogness@linutronix.de>
References: <20230525093159.223817-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart_ops startup() callback is called without interrupts
disabled and without port->lock locked, relatively late during the
boot process (from the call path of console_on_rootfs()). If the
device is a console, it was already previously registered and could
be actively printing messages.

The console printing function serial8250_console_write() modifies
the interrupt register (UART_IER) under the port->lock with the
pattern: read, clear, restore.

Since some startup() callbacks are modifying UART_IER without the
port->lock locked, it is possible that the value intended to be
written by the startup() callback will get overwritten and be
lost.

CPU0                           CPU1
serial8250_console_write       omap_8250_startup
--------------------------     -----------------
spin_lock(port->lock)
oldval = read(UART_IER)
uart_console_write()
                               write(newval, UART_IER)
write(oldval, UART_IER)
spin_unlock(port->lock)

Add port->lock synchronization to the 8250 startup() callbacks
where they need to access UART_IER. This avoids racing with
serial8250_console_write().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_bcm7271.c |  4 ++++
 drivers/tty/serial/8250/8250_exar.c    |  4 ++++
 drivers/tty/serial/8250/8250_omap.c    |  3 +++
 drivers/tty/serial/8250/8250_port.c    | 18 ++++++++++++++++--
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index f801b1f5b46c..2b38bcc5112e 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -605,9 +605,13 @@ static int brcmuart_startup(struct uart_port *port)
 	/*
 	 * Disable the Receive Data Interrupt because the DMA engine
 	 * will handle this.
+	 *
+	 * Synchronize UART_IER access against the console.
 	 */
+	spin_lock_irq(&port->lock);
 	up->ier &= ~UART_IER_RDI;
 	serial_port_out(port, UART_IER, up->ier);
+	spin_unlock_irq(&port->lock);
 
 	priv->tx_running = false;
 	priv->dma.rx_dma = NULL;
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 64770c62bbec..ae66ef9d863c 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -194,8 +194,12 @@ static int xr17v35x_startup(struct uart_port *port)
 	/*
 	 * Make sure all interrups are masked until initialization is
 	 * complete and the FIFOs are cleared
+	 *
+	 * Synchronize UART_IER access against the console.
 	 */
+	spin_lock_irq(&port->lock);
 	serial_port_out(port, UART_IER, 0);
+	spin_unlock_irq(&port->lock);
 
 	return serial8250_do_startup(port);
 }
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 5c093dfcee1d..fbca0692aa51 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -710,8 +710,11 @@ static int omap_8250_startup(struct uart_port *port)
 		up->dma = NULL;
 	}
 
+	/* Synchronize UART_IER access against the console. */
+	spin_lock_irq(&port->lock);
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);
+	spin_unlock_irq(&port->lock);
 
 #ifdef CONFIG_PM
 	up->capabilities |= UART_CAP_RPM;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 0cef9bfd0471..b3971302d8e5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2149,7 +2149,12 @@ int serial8250_do_startup(struct uart_port *port)
 
 	serial8250_rpm_get(up);
 	if (port->type == PORT_16C950) {
-		/* Wake up and initialize UART */
+		/*
+		 * Wake up and initialize UART
+		 *
+		 * Synchronize UART_IER access against the console.
+		 */
+		spin_lock_irqsave(&port->lock, flags);
 		up->acr = 0;
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
@@ -2159,12 +2164,19 @@ int serial8250_do_startup(struct uart_port *port)
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
 		serial_port_out(port, UART_LCR, 0);
+		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
 	if (port->type == PORT_DA830) {
-		/* Reset the port */
+		/*
+		 * Reset the port
+		 *
+		 * Synchronize UART_IER access against the console.
+		 */
+		spin_lock_irqsave(&port->lock, flags);
 		serial_port_out(port, UART_IER, 0);
 		serial_port_out(port, UART_DA830_PWREMU_MGMT, 0);
+		spin_unlock_irqrestore(&port->lock, flags);
 		mdelay(10);
 
 		/* Enable Tx, Rx and free run mode */
@@ -2275,6 +2287,8 @@ int serial8250_do_startup(struct uart_port *port)
 		 * this interrupt whenever the transmitter is idle and
 		 * the interrupt is enabled.  Delays are necessary to
 		 * allow register changes to become visible.
+		 *
+		 * Synchronize UART_IER access against the console.
 		 */
 		spin_lock_irqsave(&port->lock, flags);
 
-- 
2.30.2

