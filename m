Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595A46B9C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCNRFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCNRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:05:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7BF15141;
        Tue, 14 Mar 2023 10:05:06 -0700 (PDT)
Date:   Tue, 14 Mar 2023 18:05:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678813504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OekAF2ObEo0H6MRqlvRrZ/XGmYlEx8GHemndNVTkVBw=;
        b=k0X+/anFq5NEhFyg9aTxCHnJlKwSGjCRIf1caQtBYL7vKrtu5yGRGSgvsBFDwSYCHz+Xo8
        JXKddobtBsd8qbx44gfJ+cp7gHc0ZZlG+pT90eW1S3lBDJNZfcJws6UvJW6alzDKA54iFp
        r2095wtmjlXRMQkua9G1r+rHHaM5r94gQ4uw94syHsLqesosbdgWgbjnQ08P3u4UJJzP/d
        +GtivL9uKH28GqoLrG0mqYb6KHe+w/zUmE7vmokWrc+m06vjzygCbPcI4sBV8uC7S/fgZ5
        f2j9m9mx/djvuTyO4/MJ91ispd9JqSfJbpqWd9w+hneja7usxgpk5YGcrw+X4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678813504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OekAF2ObEo0H6MRqlvRrZ/XGmYlEx8GHemndNVTkVBw=;
        b=j5c/iKGEXH10cmhHMNRAT5toq10EZ+E55ZpXwIVAaZTOFzF78k3k0y+xjKwWgtiE00NjQ+
        Y7hqBAQJINDTL/CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.3-rc2-rt3
Message-ID: <20230314170502.OHw1_FK3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.3-rc2-rt3 patch set.=20

Changes since v6.3-rc2-rt2:

  - The i915 and other driver using io_mapping_map_atomic_wc() function
    could deadlock. Reported by Richard Weinberger.

  - A larger printk rework by John Ogness. This printk series is based
    on the latest work by John and most of the patches have been
    submitted for upstream review.
    As in the previous version the concept of an atomic console
    remained. That means a crash (BUG(), panic(), =E2=80=A6) without a atom=
ic
    console driver remains invisible on PREEMPT_RT. The only available
    atomic console driver is the 8250 UART and has been tested on X86.

Known issues
     - Crystal Wood reported that a filesystem (XFS) may deadlock while
       flushing during schedule.

The delta patch against v6.3-rc2-rt2 is appended below and can be found her=
e:
=20
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/incr/patch-6.3=
-rc2-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.=
3-rc2-rt3

The RT patch against v6.3-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patch-6.3=
-rc2-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patches-6=
=2E3-rc2-rt3.tar.xz

Sebastian

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 82cbe22a96338..d834fbc0c9135 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -177,41 +177,269 @@ static inline void serial_dl_write(struct uart_8250_=
port *up, int value)
 	up->dl_write(up, value);
 }
=20
+static inline bool serial8250_is_console(struct uart_port *port)
+{
+	return uart_console(port) && !hlist_unhashed_lockless(&port->cons->node);
+}
+
+/**
+ * serial8250_init_wctxt - Initialize a write context for
+ *	non-console-printing usage
+ * @wctxt:	The write context to initialize
+ * @cons:	The console to assign to the write context
+ *
+ * In order to mark an unsafe region, drivers must acquire the console. Th=
is
+ * requires providing an initialized write context (even if that driver wi=
ll
+ * not be doing any printing).
+ *
+ * This function should not be used for console printing contexts.
+ */
+static inline void serial8250_init_wctxt(struct cons_write_context *wctxt,
+					 struct console *cons)
+{
+	struct cons_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
+
+	memset(wctxt, 0, sizeof(*wctxt));
+	ctxt->console =3D cons;
+	ctxt->prio =3D CONS_PRIO_NORMAL;
+}
+
+/**
+ * __serial8250_console_acquire - Acquire a console for
+ *	non-console-printing usage
+ * @wctxt:	An uninitialized write context to use for acquiring
+ * @cons:	The console to assign to the write context
+ *
+ * The caller is holding the port->lock.
+ * The caller is holding the console_srcu_read_lock.
+ *
+ * This function should not be used for console printing contexts.
+ */
+static inline void __serial8250_console_acquire(struct cons_write_context =
*wctxt,
+						struct console *cons)
+{
+	for (;;) {
+		serial8250_init_wctxt(wctxt, cons);
+		if (console_try_acquire(wctxt))
+			break;
+		cpu_relax();
+	}
+}
+
+/**
+ * serial8250_enter_unsafe - Mark the beginning of an unsafe region for
+ *		non-console-printing usage
+ * @up:	The port that is entering the unsafe state
+ *
+ * The caller should ensure @up is a console before calling this function.
+ *
+ * The caller is holding the port->lock.
+ * This function takes the console_srcu_read_lock and becomes owner of the
+ * console associated with @up.
+ *
+ * This function should not be used for console printing contexts.
+ */
+static inline void serial8250_enter_unsafe(struct uart_8250_port *up)
+{
+	struct uart_port *port =3D &up->port;
+
+	lockdep_assert_held_once(&port->lock);
+
+	for (;;) {
+		up->cookie =3D console_srcu_read_lock();
+
+		__serial8250_console_acquire(&up->wctxt, port->cons);
+
+		if (console_enter_unsafe(&up->wctxt))
+			break;
+
+		console_srcu_read_unlock(up->cookie);
+		cpu_relax();
+	}
+}
+
+/**
+ * serial8250_exit_unsafe - Mark the end of an unsafe region for
+ *		non-console-printing usage
+ * @up:	The port that is exiting the unsafe state
+ *
+ * The caller is holding the port->lock.
+ * This function releases ownership of the console associated with @up and
+ * releases the console_srcu_read_lock.
+ *
+ * This function should not be used for console printing contexts.
+ */
+static inline void serial8250_exit_unsafe(struct uart_8250_port *up)
+{
+	struct uart_port *port =3D &up->port;
+
+	lockdep_assert_held_once(&port->lock);
+
+	if (console_exit_unsafe(&up->wctxt))
+		console_release(&up->wctxt);
+
+	console_srcu_read_unlock(up->cookie);
+}
+
+/**
+ * serial8250_in_IER - Read the IER register for
+ *		non-console-printing usage
+ * @up:	The port to work on
+ *
+ * Returns:	The value read from IER
+ *
+ * The caller is holding the port->lock.
+ *
+ * This is the top-level function for non-console-printing contexts to
+ * read the IER register. The caller does not need to care if @up is a
+ * console before calling this function.
+ *
+ * This function should not be used for printing contexts.
+ */
 static inline int serial8250_in_IER(struct uart_8250_port *up)
 {
 	struct uart_port *port =3D &up->port;
-	unsigned long flags;
 	bool is_console;
 	int ier;
=20
-	is_console =3D uart_console(port);
+	is_console =3D serial8250_is_console(port);
=20
 	if (is_console)
-		printk_cpu_sync_get_irqsave(flags);
+		serial8250_enter_unsafe(up);
=20
 	ier =3D serial_in(up, UART_IER);
=20
 	if (is_console)
-		printk_cpu_sync_put_irqrestore(flags);
+		serial8250_exit_unsafe(up);
=20
 	return ier;
 }
=20
+/**
+ * __serial8250_set_IER - Directly write to the IER register
+ * @up:		The port to work on
+ * @wctxt:	The current write context
+ * @ier:	The value to write
+ *
+ * Returns:	True if IER was written to. False otherwise
+ *
+ * The caller is holding the port->lock.
+ * The caller is holding the console_srcu_read_unlock.
+ * The caller is the owner of the console associated with @up.
+ *
+ * This function should only be directly called within console printing
+ * contexts. Other contexts should use serial8250_set_IER().
+ */
+static inline bool __serial8250_set_IER(struct uart_8250_port *up,
+					struct cons_write_context *wctxt,
+					int ier)
+{
+	if (wctxt && !console_can_proceed(wctxt))
+		return false;
+	serial_out(up, UART_IER, ier);
+	return true;
+}
+
+/**
+ * serial8250_set_IER - Write a new value to the IER register for
+ *	non-console-printing usage
+ * @up:		The port to work on
+ * @ier:	The value to write
+ *
+ * The caller is holding the port->lock.
+ *
+ * This is the top-level function for non-console-printing contexts to
+ * write to the IER register. The caller does not need to care if @up is a
+ * console before calling this function.
+ *
+ * This function should not be used for printing contexts.
+ */
 static inline void serial8250_set_IER(struct uart_8250_port *up, int ier)
 {
 	struct uart_port *port =3D &up->port;
-	unsigned long flags;
 	bool is_console;
=20
-	is_console =3D uart_console(port);
+	is_console =3D serial8250_is_console(port);
=20
-	if (is_console)
-		printk_cpu_sync_get_irqsave(flags);
+	if (is_console) {
+		serial8250_enter_unsafe(up);
+		while (!__serial8250_set_IER(up, &up->wctxt, ier)) {
+			console_srcu_read_unlock(up->cookie);
+			console_enter_unsafe(&up->wctxt);
+		}
+		serial8250_exit_unsafe(up);
+	} else {
+		__serial8250_set_IER(up, NULL, ier);
+	}
+}
=20
-	serial_out(up, UART_IER, ier);
+/**
+ * __serial8250_clear_IER - Directly clear the IER register
+ * @up:		The port to work on
+ * @wctxt:	The current write context
+ * @prior:	Gets set to the previous value of IER
+ *
+ * Returns:	True if IER was cleared and @prior points to the previous
+ *		value of IER. False otherwise and @prior is invalid
+ *
+ * The caller is holding the port->lock.
+ * The caller is holding the console_srcu_read_unlock.
+ * The caller is the owner of the console associated with @up.
+ *
+ * This function should only be directly called within console printing
+ * contexts. Other contexts should use serial8250_clear_IER().
+ */
+static inline bool __serial8250_clear_IER(struct uart_8250_port *up,
+					  struct cons_write_context *wctxt,
+					  int *prior)
+{
+	unsigned int clearval =3D 0;
=20
-	if (is_console)
-		printk_cpu_sync_put_irqrestore(flags);
+	if (up->capabilities & UART_CAP_UUE)
+		clearval =3D UART_IER_UUE;
+
+	*prior =3D serial_in(up, UART_IER);
+	if (wctxt && !console_can_proceed(wctxt))
+		return false;
+	serial_out(up, UART_IER, clearval);
+	return true;
+}
+
+/**
+ * serial8250_clear_IER - Clear the IER register for
+ *		non-console-printing usage
+ * @up:	The port to work on
+ *
+ * Returns:	The previous value of IER
+ *
+ * The caller is holding the port->lock.
+ *
+ * This is the top-level function for non-console-printing contexts to
+ * clear the IER register. The caller does not need to care if @up is a
+ * console before calling this function.
+ *
+ * This function should not be used for printing contexts.
+ */
+static inline int serial8250_clear_IER(struct uart_8250_port *up)
+{
+	struct uart_port *port =3D &up->port;
+	bool is_console;
+	int prior;
+
+	is_console =3D serial8250_is_console(port);
+
+	if (is_console) {
+		serial8250_enter_unsafe(up);
+		while (!__serial8250_clear_IER(up, &up->wctxt, &prior)) {
+			console_srcu_read_unlock(up->cookie);
+			console_enter_unsafe(&up->wctxt);
+		}
+		serial8250_exit_unsafe(up);
+	} else {
+		__serial8250_clear_IER(up, NULL, &prior);
+	}
+
+	return prior;
 }
=20
 static inline bool serial8250_set_THRI(struct uart_8250_port *up)
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/82=
50/8250_bcm7271.c
index 8a9444890365a..c6f2cd3f19b5d 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -606,8 +606,10 @@ static int brcmuart_startup(struct uart_port *port)
 	 * Disable the Receive Data Interrupt because the DMA engine
 	 * will handle this.
 	 */
+	spin_lock_irq(&port->lock);
 	up->ier &=3D ~UART_IER_RDI;
 	serial8250_set_IER(up, up->ier);
+	spin_unlock_irq(&port->lock);
=20
 	priv->tx_running =3D false;
 	priv->dma.rx_dma =3D NULL;
@@ -773,12 +775,10 @@ static int brcmuart_handle_irq(struct uart_port *p)
 	unsigned int iir =3D serial_port_in(p, UART_IIR);
 	struct brcmuart_priv *priv =3D p->private_data;
 	struct uart_8250_port *up =3D up_to_u8250p(p);
-	unsigned long cs_flags;
 	unsigned int status;
 	unsigned long flags;
 	unsigned int ier;
 	unsigned int mcr;
-	bool is_console;
 	int handled =3D 0;
=20
 	/*
@@ -789,10 +789,12 @@ static int brcmuart_handle_irq(struct uart_port *p)
 		spin_lock_irqsave(&p->lock, flags);
 		status =3D serial_port_in(p, UART_LSR);
 		if ((status & UART_LSR_DR) =3D=3D 0) {
-			is_console =3D uart_console(p);
+			bool is_console;
+
+			is_console =3D serial8250_is_console(p);
=20
 			if (is_console)
-				printk_cpu_sync_get_irqsave(cs_flags);
+				serial8250_enter_unsafe(up);
=20
 			ier =3D serial_port_in(p, UART_IER);
 			/*
@@ -814,7 +816,7 @@ static int brcmuart_handle_irq(struct uart_port *p)
 			}
=20
 			if (is_console)
-				printk_cpu_sync_put_irqrestore(cs_flags);
+				serial8250_exit_unsafe(up);
=20
 			handled =3D 1;
 		}
@@ -830,10 +832,8 @@ static enum hrtimer_restart brcmuart_hrtimer_func(stru=
ct hrtimer *t)
 	struct brcmuart_priv *priv =3D container_of(t, struct brcmuart_priv, hrt);
 	struct uart_port *p =3D priv->up;
 	struct uart_8250_port *up =3D up_to_u8250p(p);
-	unsigned long cs_flags;
 	unsigned int status;
 	unsigned long flags;
-	bool is_console;
=20
 	if (priv->shutdown)
 		return HRTIMER_NORESTART;
@@ -855,10 +855,12 @@ static enum hrtimer_restart brcmuart_hrtimer_func(str=
uct hrtimer *t)
 	/* re-enable receive unless upper layer has disabled it */
 	if ((up->ier & (UART_IER_RLSI | UART_IER_RDI)) =3D=3D
 	    (UART_IER_RLSI | UART_IER_RDI)) {
-		is_console =3D uart_console(p);
+		bool is_console;
+
+		is_console =3D serial8250_is_console(p);
=20
 		if (is_console)
-			printk_cpu_sync_get_irqsave(cs_flags);
+			serial8250_enter_unsafe(up);
=20
 		status =3D serial_port_in(p, UART_IER);
 		status |=3D (UART_IER_RLSI | UART_IER_RDI);
@@ -868,7 +870,7 @@ static enum hrtimer_restart brcmuart_hrtimer_func(struc=
t hrtimer *t)
 		serial_port_out(p, UART_MCR, status);
=20
 		if (is_console)
-			printk_cpu_sync_put_irqrestore(cs_flags);
+			serial8250_exit_unsafe(up);
 	}
 	spin_unlock_irqrestore(&p->lock, flags);
 	return HRTIMER_NORESTART;
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/=
8250_core.c
index f1702da430f21..8e89bffa1f121 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -258,9 +258,7 @@ static void serial8250_backup_timeout(struct timer_list=
 *t)
 	struct uart_8250_port *up =3D from_timer(up, t, timer);
 	struct uart_port *port =3D &up->port;
 	unsigned int iir, ier =3D 0, lsr;
-	unsigned long cs_flags;
 	unsigned long flags;
-	bool is_console;
=20
 	spin_lock_irqsave(&up->port.lock, flags);
=20
@@ -269,16 +267,23 @@ static void serial8250_backup_timeout(struct timer_li=
st *t)
 	 * based handler.
 	 */
 	if (up->port.irq) {
-		is_console =3D uart_console(port);
+		bool is_console;
+
+		/*
+		 * Do not use serial8250_clear_IER() because this code
+		 * ignores capabilties.
+		 */
+
+		is_console =3D serial8250_is_console(port);
=20
 		if (is_console)
-			printk_cpu_sync_get_irqsave(cs_flags);
+			serial8250_enter_unsafe(up);
=20
 		ier =3D serial_in(up, UART_IER);
 		serial_out(up, UART_IER, 0);
=20
 		if (is_console)
-			printk_cpu_sync_put_irqrestore(cs_flags);
+			serial8250_exit_unsafe(up);
 	}
=20
 	iir =3D serial_in(up, UART_IIR);
@@ -587,20 +592,30 @@ serial8250_register_ports(struct uart_driver *drv, st=
ruct device *dev)
=20
 #ifdef CONFIG_SERIAL_8250_CONSOLE
=20
-static void univ8250_console_write_atomic(struct console *co, const char *=
s,
-					  unsigned int count)
+static void univ8250_console_port_lock(struct console *con, bool do_lock, =
unsigned long *flags)
 {
-	struct uart_8250_port *up =3D &serial8250_ports[co->index];
+	struct uart_8250_port *up =3D &serial8250_ports[con->index];
=20
-	serial8250_console_write_atomic(up, s, count);
+	if (do_lock)
+		spin_lock_irqsave(&up->port.lock, *flags);
+	else
+		spin_unlock_irqrestore(&up->port.lock, *flags);
 }
=20
-static void univ8250_console_write(struct console *co, const char *s,
-				   unsigned int count)
+static bool univ8250_console_write_atomic(struct console *co,
+					  struct cons_write_context *wctxt)
 {
 	struct uart_8250_port *up =3D &serial8250_ports[co->index];
=20
-	serial8250_console_write(up, s, count);
+	return serial8250_console_write_atomic(up, wctxt);
+}
+
+static bool univ8250_console_write_thread(struct console *co,
+					  struct cons_write_context *wctxt)
+{
+	struct uart_8250_port *up =3D &serial8250_ports[co->index];
+
+	return serial8250_console_write_thread(up, wctxt);
 }
=20
 static int univ8250_console_setup(struct console *co, char *options)
@@ -689,12 +704,13 @@ static int univ8250_console_match(struct console *co,=
 char *name, int idx,
 static struct console univ8250_console =3D {
 	.name		=3D "ttyS",
 	.write_atomic	=3D univ8250_console_write_atomic,
-	.write		=3D univ8250_console_write,
+	.write_thread	=3D univ8250_console_write_thread,
+	.port_lock	=3D univ8250_console_port_lock,
 	.device		=3D uart_console_device,
 	.setup		=3D univ8250_console_setup,
 	.exit		=3D univ8250_console_exit,
 	.match		=3D univ8250_console_match,
-	.flags		=3D CON_PRINTBUFFER | CON_ANYTIME,
+	.flags		=3D CON_PRINTBUFFER | CON_ANYTIME | CON_NO_BKL,
 	.index		=3D -1,
 	.data		=3D &serial8250_reg,
 };
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/=
8250_exar.c
index c756c30c70c3a..ccb70b20b1f4f 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -187,6 +187,8 @@ static int xr17v35x_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up =3D up_to_u8250p(port);
=20
+	spin_lock_irq(&port->lock);
+
 	/*
 	 * First enable access to IER [7:5], ISR [5:4], FCR [5:4],
 	 * MCR [7:5] and MSR [7:0]
@@ -199,6 +201,8 @@ static int xr17v35x_startup(struct uart_port *port)
 	 */
 	serial8250_set_IER(up, 0);
=20
+	spin_unlock_irq(&port->lock);
+
 	return serial8250_do_startup(port);
 }
=20
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/82=
50/8250_ingenic.c
index 548904c3d11bf..617b8ce60d6b5 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -171,7 +171,6 @@ OF_EARLYCON_DECLARE(x1000_uart, "ingenic,x1000-uart",
=20
 static void ingenic_uart_serial_out(struct uart_port *p, int offset, int v=
alue)
 {
-	struct uart_8250_port *up =3D up_to_u8250p(p);
 	int ier;
=20
 	switch (offset) {
@@ -193,7 +192,7 @@ static void ingenic_uart_serial_out(struct uart_port *p=
, int offset, int value)
 		 * If we have enabled modem status IRQs we should enable
 		 * modem mode.
 		 */
-		ier =3D serial8250_in_IER(up);
+		ier =3D p->serial_in(p, UART_IER);
=20
 		if (ier & UART_IER_MSI)
 			value |=3D UART_MCR_MDCE | UART_MCR_FCM;
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8=
250_mtk.c
index 3e7203909d6ae..bf7ab55c8923f 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -223,39 +223,37 @@ static void mtk8250_shutdown(struct uart_port *port)
 static void mtk8250_disable_intrs(struct uart_8250_port *up, int mask)
 {
 	struct uart_port *port =3D &up->port;
-	unsigned long flags;
 	bool is_console;
 	int ier;
=20
-	is_console =3D uart_console(port);
+	is_console =3D serial8250_is_console(port);
=20
 	if (is_console)
-		printk_cpu_sync_get_irqsave(flags);
+		serial8250_enter_unsafe(up);
=20
 	ier =3D serial_in(up, UART_IER);
 	serial_out(up, UART_IER, ier & (~mask));
=20
 	if (is_console)
-		printk_cpu_sync_put_irqrestore(flags);
+		serial8250_exit_unsafe(up);
 }
=20
 static void mtk8250_enable_intrs(struct uart_8250_port *up, int mask)
 {
 	struct uart_port *port =3D &up->port;
-	unsigned long flags;
 	bool is_console;
 	int ier;
=20
-	is_console =3D uart_console(port);
+	is_console =3D serial8250_is_console(port);
=20
 	if (is_console)
-		printk_cpu_sync_get_irqsave(flags);
+		serial8250_enter_unsafe(up);
=20
 	ier =3D serial_in(up, UART_IER);
 	serial_out(up, UART_IER, ier | mask);
=20
 	if (is_console)
-		printk_cpu_sync_put_irqrestore(flags);
+		serial8250_exit_unsafe(up);
 }
=20
 static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/=
8250_omap.c
index 3d124a1116e5a..bfa50a26349dd 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -334,7 +334,6 @@ static void omap8250_restore_regs(struct uart_8250_port=
 *up)
=20
 	/* drop TCR + TLR access, we setup XON/XOFF later */
 	serial8250_out_MCR(up, mcr);
-
 	serial8250_set_IER(up, up->ier);
=20
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
@@ -523,6 +522,9 @@ static void omap_8250_pm(struct uart_port *port, unsign=
ed int state,
 	u8 efr;
=20
 	pm_runtime_get_sync(port->dev);
+
+	spin_lock_irq(&port->lock);
+
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	efr =3D serial_in(up, UART_EFR);
 	serial_out(up, UART_EFR, efr | UART_EFR_ECB);
@@ -533,6 +535,8 @@ static void omap_8250_pm(struct uart_port *port, unsign=
ed int state,
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
=20
+	spin_unlock_irq(&port->lock);
+
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 }
@@ -649,6 +653,7 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 	if ((lsr & UART_LSR_OE) && up->overrun_backoff_time_ms > 0) {
 		unsigned long delay;
=20
+		spin_lock(&port->lock);
 		up->ier =3D serial8250_in_IER(up);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
@@ -658,6 +663,7 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 			 */
 			cancel_delayed_work(&up->overrun_backoff);
 		}
+		spin_unlock(&port->lock);
=20
 		delay =3D msecs_to_jiffies(up->overrun_backoff_time_ms);
 		schedule_delayed_work(&up->overrun_backoff, delay);
@@ -707,8 +713,10 @@ static int omap_8250_startup(struct uart_port *port)
 	if (ret < 0)
 		goto err;
=20
+	spin_lock_irq(&port->lock);
 	up->ier =3D UART_IER_RLSI | UART_IER_RDI;
 	serial8250_set_IER(up, up->ier);
+	spin_unlock_irq(&port->lock);
=20
 #ifdef CONFIG_PM
 	up->capabilities |=3D UART_CAP_RPM;
@@ -748,8 +756,10 @@ static void omap_8250_shutdown(struct uart_port *port)
 	if (priv->habit & UART_HAS_EFR2)
 		serial_out(up, UART_OMAP_EFR2, 0x0);
=20
+	spin_lock_irq(&port->lock);
 	up->ier =3D 0;
 	serial8250_set_IER(up, 0);
+	spin_unlock_irq(&port->lock);
=20
 	if (up->dma)
 		serial8250_release_dma(up);
@@ -1717,12 +1727,16 @@ static int omap8250_runtime_resume(struct device *d=
ev)
=20
 	up =3D serial8250_get_port(priv->line);
=20
+	spin_lock_irq(&up->port.lock);
+
 	if (omap8250_lost_context(up))
 		omap8250_restore_regs(up);
=20
 	if (up->dma && up->dma->rxchan && !(priv->habit & UART_HAS_EFR2))
 		omap_8250_rx_dma(up);
=20
+	spin_unlock_irq(&up->port.lock);
+
 	priv->latency =3D priv->calc_latency;
 	schedule_work(&priv->qos_work);
 	return 0;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index 63bac53ac8471..c9b1d9af43286 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -744,6 +744,7 @@ static void serial8250_set_sleep(struct uart_8250_port =
*p, int sleep)
 	serial8250_rpm_get(p);
=20
 	if (p->capabilities & UART_CAP_SLEEP) {
+		spin_lock_irq(&p->port.lock);
 		if (p->capabilities & UART_CAP_EFR) {
 			lcr =3D serial_in(p, UART_LCR);
 			efr =3D serial_in(p, UART_EFR);
@@ -757,36 +758,12 @@ static void serial8250_set_sleep(struct uart_8250_por=
t *p, int sleep)
 			serial_out(p, UART_EFR, efr);
 			serial_out(p, UART_LCR, lcr);
 		}
+		spin_unlock_irq(&p->port.lock);
 	}
=20
 	serial8250_rpm_put(p);
 }
=20
-static unsigned int serial8250_clear_IER(struct uart_8250_port *up)
-{
-	struct uart_port *port =3D &up->port;
-	unsigned int clearval =3D 0;
-	unsigned long flags;
-	bool is_console;
-	unsigned int prior;
-
-	is_console =3D uart_console(port);
-
-	if (up->capabilities & UART_CAP_UUE)
-		clearval =3D UART_IER_UUE;
-
-	if (is_console)
-		printk_cpu_sync_get_irqsave(flags);
-
-	prior =3D serial_in(up, UART_IER);
-	serial_out(up, UART_IER, clearval);
-
-	if (is_console)
-		printk_cpu_sync_put_irqrestore(flags);
-
-	return prior;
-}
-
 #ifdef CONFIG_SERIAL_8250_RSA
 /*
  * Attempts to turn on the RSA FIFO.  Returns zero on failure.
@@ -1053,7 +1030,6 @@ static void autoconfig_16550a(struct uart_8250_port *=
up)
 	struct uart_port *port =3D &up->port;
 	unsigned char status1, status2;
 	unsigned int iersave;
-	unsigned long flags;
 	bool is_console;
=20
 	up->port.type =3D PORT_16550A;
@@ -1170,10 +1146,10 @@ static void autoconfig_16550a(struct uart_8250_port=
 *up)
 		return;
 	}
=20
-	is_console =3D uart_console(port);
+	is_console =3D serial8250_is_console(port);
=20
 	if (is_console)
-		printk_cpu_sync_get_irqsave(flags);
+		serial8250_enter_unsafe(up);
=20
 	/*
 	 * Try writing and reading the UART_IER_UUE bit (b6).
@@ -1211,7 +1187,7 @@ static void autoconfig_16550a(struct uart_8250_port *=
up)
 	serial_out(up, UART_IER, iersave);
=20
 	if (is_console)
-		printk_cpu_sync_put_irqrestore(flags);
+		serial8250_exit_unsafe(up);
=20
 	/*
 	 * We distinguish between 16550A and U6 16550A by counting
@@ -1235,10 +1211,8 @@ static void autoconfig(struct uart_8250_port *up)
 	unsigned char status1, scratch, scratch2, scratch3;
 	unsigned char save_lcr, save_mcr;
 	struct uart_port *port =3D &up->port;
-	unsigned long cs_flags;
 	unsigned long flags;
 	unsigned int old_capabilities;
-	bool is_console;
=20
 	if (!port->iobase && !port->mapbase && !port->membase)
 		return;
@@ -1256,10 +1230,12 @@ static void autoconfig(struct uart_8250_port *up)
 	up->bugs =3D 0;
=20
 	if (!(port->flags & UPF_BUGGY_UART)) {
-		is_console =3D uart_console(port);
+		bool is_console;
+
+		is_console =3D serial8250_is_console(port);
=20
 		if (is_console)
-			printk_cpu_sync_get_irqsave(cs_flags);
+			serial8250_enter_unsafe(up);
=20
 		/*
 		 * Do a simple existence test first; if we fail this,
@@ -1292,7 +1268,7 @@ static void autoconfig(struct uart_8250_port *up)
 		serial_out(up, UART_IER, scratch);
=20
 		if (is_console)
-			printk_cpu_sync_put_irqrestore(cs_flags);
+			serial8250_exit_unsafe(up);
=20
 		if (scratch2 !=3D 0 || scratch3 !=3D UART_IER_ALL_INTR) {
 			/*
@@ -1414,7 +1390,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	unsigned char save_mcr, save_ier;
 	unsigned char save_ICP =3D 0;
 	unsigned int ICP =3D 0;
-	unsigned long flags;
 	unsigned long irqs;
 	bool is_console;
 	int irq;
@@ -1426,11 +1401,11 @@ static void autoconfig_irq(struct uart_8250_port *u=
p)
 		inb_p(ICP);
 	}
=20
-	is_console =3D uart_console(port);
+	is_console =3D serial8250_is_console(port);
=20
 	if (is_console) {
 		console_lock();
-		printk_cpu_sync_get_irqsave(flags);
+		serial8250_enter_unsafe(up);
 	}
=20
 	/* forget possible initially masked and pending IRQ */
@@ -1464,7 +1439,7 @@ static void autoconfig_irq(struct uart_8250_port *up)
 		outb_p(save_ICP, ICP);
=20
 	if (is_console) {
-		printk_cpu_sync_put_irqrestore(flags);
+		serial8250_exit_unsafe(up);
 		console_unlock();
 	}
=20
@@ -2207,8 +2182,10 @@ static void serial8250_put_poll_char(struct uart_por=
t *port,
 	serial8250_rpm_get(up);
 	/*
 	 *	First save the IER then disable the interrupts
+	 *
+	 *	Best-effort IER access because other CPUs are quiesced.
 	 */
-	ier =3D serial8250_clear_IER(up);
+	__serial8250_clear_IER(up, NULL, &ier);
=20
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 	/*
@@ -2221,7 +2198,7 @@ static void serial8250_put_poll_char(struct uart_port=
 *port,
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
-	serial8250_set_IER(up, ier);
+	__serial8250_set_IER(up, NULL, ier);
 	serial8250_rpm_put(up);
 }
=20
@@ -2230,7 +2207,6 @@ static void serial8250_put_poll_char(struct uart_port=
 *port,
 int serial8250_do_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up =3D up_to_u8250p(port);
-	unsigned long cs_flags;
 	unsigned long flags;
 	unsigned char iir;
 	bool is_console;
@@ -2251,6 +2227,7 @@ int serial8250_do_startup(struct uart_port *port)
 	serial8250_rpm_get(up);
 	if (port->type =3D=3D PORT_16C950) {
 		/* Wake up and initialize UART */
+		spin_lock_irqsave(&port->lock, flags);
 		up->acr =3D 0;
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
@@ -2260,12 +2237,15 @@ int serial8250_do_startup(struct uart_port *port)
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
 		serial_port_out(port, UART_LCR, 0);
+		spin_unlock_irqrestore(&port->lock, flags);
 	}
=20
 	if (port->type =3D=3D PORT_DA830) {
 		/* Reset the port */
+		spin_lock_irqsave(&port->lock, flags);
 		serial8250_set_IER(up, 0);
 		serial_port_out(port, UART_DA830_PWREMU_MGMT, 0);
+		spin_unlock_irqrestore(&port->lock, flags);
 		mdelay(10);
=20
 		/* Enable Tx, Rx and free run mode */
@@ -2363,7 +2343,7 @@ int serial8250_do_startup(struct uart_port *port)
 	if (retval)
 		goto out;
=20
-	is_console =3D uart_console(port);
+	is_console =3D serial8250_is_console(port);
=20
 	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
 		unsigned char iir1;
@@ -2382,7 +2362,7 @@ int serial8250_do_startup(struct uart_port *port)
 		spin_lock_irqsave(&port->lock, flags);
=20
 		if (is_console)
-			printk_cpu_sync_get_irqsave(cs_flags);
+			serial8250_enter_unsafe(up);
=20
 		wait_for_xmitr(up, UART_LSR_THRE);
 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
@@ -2395,7 +2375,7 @@ int serial8250_do_startup(struct uart_port *port)
 		serial_port_out(port, UART_IER, 0);
=20
 		if (is_console)
-			printk_cpu_sync_put_irqrestore(cs_flags);
+			serial8250_exit_unsafe(up);
=20
 		spin_unlock_irqrestore(&port->lock, flags);
=20
@@ -2452,13 +2432,13 @@ int serial8250_do_startup(struct uart_port *port)
 	 * the TX irq.
 	 */
 	if (is_console)
-		printk_cpu_sync_get_irqsave(cs_flags);
+		serial8250_enter_unsafe(up);
 	serial_port_out(port, UART_IER, UART_IER_THRI);
 	lsr =3D serial_port_in(port, UART_LSR);
 	iir =3D serial_port_in(port, UART_IIR);
 	serial_port_out(port, UART_IER, 0);
 	if (is_console)
-		printk_cpu_sync_put_irqrestore(cs_flags);
+		serial8250_exit_unsafe(up);
=20
 	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
 		if (!(up->bugs & UART_BUG_TXEN)) {
@@ -3372,24 +3352,21 @@ EXPORT_SYMBOL_GPL(serial8250_set_defaults);
=20
 #ifdef CONFIG_SERIAL_8250_CONSOLE
=20
-static void serial8250_console_putchar_locked(struct uart_port *port, unsi=
gned char ch)
+static bool serial8250_console_putchar(struct uart_port *port, unsigned ch=
ar ch,
+				       struct cons_write_context *wctxt)
 {
 	struct uart_8250_port *up =3D up_to_u8250p(port);
=20
 	wait_for_xmitr(up, UART_LSR_THRE);
+	if (!console_can_proceed(wctxt))
+		return false;
 	serial_port_out(port, UART_TX, ch);
-}
+	if (ch =3D=3D '\n')
+		up->console_newline_needed =3D false;
+	else
+		up->console_newline_needed =3D true;
=20
-static void serial8250_console_putchar(struct uart_port *port, unsigned ch=
ar ch)
-{
-	struct uart_8250_port *up =3D up_to_u8250p(port);
-	unsigned long flags;
-
-	wait_for_xmitr(up, UART_LSR_THRE);
-
-	printk_cpu_sync_get_irqsave(flags);
-	serial8250_console_putchar_locked(port, ch);
-	printk_cpu_sync_put_irqrestore(flags);
+	return true;
 }
=20
 /*
@@ -3418,59 +3395,119 @@ static void serial8250_console_restore(struct uart=
_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
=20
-void serial8250_console_write_atomic(struct uart_8250_port *up,
-				     const char *s, unsigned int count)
+static bool __serial8250_console_write(struct uart_port *port, struct cons=
_write_context *wctxt,
+		const char *s, unsigned int count,
+		bool (*putchar)(struct uart_port *, unsigned char, struct cons_write_con=
text *))
+{
+	bool finished =3D false;
+	unsigned int i;
+
+	for (i =3D 0; i < count; i++, s++) {
+		if (*s =3D=3D '\n') {
+			if (!putchar(port, '\r', wctxt))
+				goto out;
+		}
+		if (!putchar(port, *s, wctxt))
+			goto out;
+	}
+	finished =3D true;
+out:
+	return finished;
+}
+
+static bool serial8250_console_write(struct uart_port *port, struct cons_w=
rite_context *wctxt,
+		const char *s, unsigned int count,
+		bool (*putchar)(struct uart_port *, unsigned char, struct cons_write_con=
text *))
+{
+	return __serial8250_console_write(port, wctxt, s, count, putchar);
+}
+
+static bool atomic_print_line(struct uart_8250_port *up,
+			      struct cons_write_context *wctxt)
 {
 	struct uart_port *port =3D &up->port;
-	unsigned long flags;
-	unsigned int ier;
=20
-	printk_cpu_sync_get_irqsave(flags);
+	if (up->console_newline_needed &&
+	    !__serial8250_console_write(port, wctxt, "\n", 1, serial8250_console_=
putchar)) {
+		return false;
+	}
+
+	return __serial8250_console_write(port, wctxt, wctxt->outbuf, wctxt->len,
+					  serial8250_console_putchar);
+}
+
+static void atomic_console_reacquire(struct cons_write_context *wctxt,
+				     struct cons_write_context *wctxt_init)
+{
+	memcpy(wctxt, wctxt_init, sizeof(*wctxt));
+	while (!console_try_acquire(wctxt)) {
+		cpu_relax();
+		memcpy(wctxt, wctxt_init, sizeof(*wctxt));
+	}
+}
+
+bool serial8250_console_write_atomic(struct uart_8250_port *up,
+				     struct cons_write_context *wctxt)
+{
+	struct cons_write_context wctxt_init =3D { };
+	struct cons_context *ctxt_init =3D &ACCESS_PRIVATE(&wctxt_init, ctxt);
+	struct cons_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
+	bool finished =3D false;
+	unsigned int ier;
=20
 	touch_nmi_watchdog();
=20
-	ier =3D serial8250_clear_IER(up);
+	/* With write_atomic, another context may hold the port->lock. */
=20
-	if (atomic_fetch_inc(&up->console_printing)) {
-		uart_console_write(port, "\n", 1,
-				   serial8250_console_putchar_locked);
+	ctxt_init->console =3D ctxt->console;
+	ctxt_init->prio =3D ctxt->prio;
+	ctxt_init->thread =3D ctxt->thread;
+
+	/*
+	 * Enter unsafe in order to disable interrupts. If the console is
+	 * lost before the interrupts are disabled, bail out because another
+	 * context took over the printing. If the console is lost after the
+	 * interrutps are disabled, the console must be reacquired in order
+	 * to re-enable the interrupts. However in that case no printing is
+	 * allowed because another context took over the printing.
+	 */
+
+	if (!console_enter_unsafe(wctxt))
+		return false;
+
+	if (!__serial8250_clear_IER(up, wctxt, &ier))
+		return false;
+
+	if (!console_exit_unsafe(wctxt)) {
+		atomic_console_reacquire(wctxt, &wctxt_init);
+		goto enable_irq;
+	}
+
+	if (!atomic_print_line(up, wctxt)) {
+		atomic_console_reacquire(wctxt, &wctxt_init);
+		goto enable_irq;
 	}
-	uart_console_write(port, s, count, serial8250_console_putchar_locked);
-	atomic_dec(&up->console_printing);
=20
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
-	serial8250_set_IER(up, ier);
-
-	printk_cpu_sync_put_irqrestore(flags);
-}
-
-/*
- * Print a string to the serial port using the device FIFO
- *
- * It sends fifosize bytes and then waits for the fifo
- * to get empty.
- */
-static void serial8250_console_fifo_write(struct uart_8250_port *up,
-					  const char *s, unsigned int count)
-{
-	int i;
-	const char *end =3D s + count;
-	unsigned int fifosize =3D up->tx_loadsz;
-	bool cr_sent =3D false;
-
-	while (s !=3D end) {
-		wait_for_lsr(up, UART_LSR_THRE);
-
-		for (i =3D 0; i < fifosize && s !=3D end; ++i) {
-			if (*s =3D=3D '\n' && !cr_sent) {
-				serial_out(up, UART_TX, '\r');
-				cr_sent =3D true;
-			} else {
-				serial_out(up, UART_TX, *s++);
-				cr_sent =3D false;
-			}
+	finished =3D true;
+enable_irq:
+	/*
+	 * Enter unsafe in order to enable interrupts. If the console is
+	 * lost before the interrupts are enabled, the console must be
+	 * reacquired in order to re-enable the interrupts.
+	 */
+	for (;;) {
+		if (console_enter_unsafe(wctxt) &&
+		    __serial8250_set_IER(up, wctxt, ier)) {
+			break;
 		}
+
+		/* HW-IRQs still disabled. Reacquire to enable them. */
+		atomic_console_reacquire(wctxt, &wctxt_init);
 	}
+	console_exit_unsafe(wctxt);
+
+	return finished;
 }
=20
 /*
@@ -3482,74 +3519,116 @@ static void serial8250_console_fifo_write(struct u=
art_8250_port *up,
  *	Doing runtime PM is really a bad idea for the kernel console.
  *	Thus, we assume the function is called when device is powered up.
  */
-void serial8250_console_write(struct uart_8250_port *up, const char *s,
-			      unsigned int count)
+bool serial8250_console_write_thread(struct uart_8250_port *up,
+				     struct cons_write_context *wctxt)
 {
+	struct cons_write_context wctxt_init =3D { };
+	struct cons_context *ctxt_init =3D &ACCESS_PRIVATE(&wctxt_init, ctxt);
+	struct cons_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
 	struct uart_8250_em485 *em485 =3D up->em485;
 	struct uart_port *port =3D &up->port;
-	unsigned long flags;
-	unsigned int ier, use_fifo;
+	unsigned int count =3D wctxt->len;
+	const char *s =3D wctxt->outbuf;
+	bool rs485_started =3D false;
+	bool finished =3D false;
+	unsigned int ier;
=20
-	touch_nmi_watchdog();
-
-	spin_lock_irqsave(&port->lock, flags);
+	ctxt_init->console =3D ctxt->console;
+	ctxt_init->prio =3D ctxt->prio;
+	ctxt_init->thread =3D ctxt->thread;
=20
 	/*
-	 *	First save the IER then disable the interrupts
+	 * Enter unsafe in order to disable interrupts. If the console is
+	 * lost before the interrupts are disabled, bail out because another
+	 * context took over the printing. If the console is lost after the
+	 * interrutps are disabled, the console must be reacquired in order
+	 * to re-enable the interrupts. However in that case no printing is
+	 * allowed because another context took over the printing.
 	 */
-	ier =3D serial8250_clear_IER(up);
+
+	if (!console_enter_unsafe(wctxt))
+		return false;
+
+	if (!__serial8250_clear_IER(up, wctxt, &ier))
+		return false;
+
+	if (!console_exit_unsafe(wctxt)) {
+		atomic_console_reacquire(wctxt, &wctxt_init);
+		goto enable_irq;
+	}
=20
 	/* check scratch reg to see if port powered off during system sleep */
 	if (up->canary && (up->canary !=3D serial_port_in(port, UART_SCR))) {
+		if (!console_enter_unsafe(wctxt)) {
+			atomic_console_reacquire(wctxt, &wctxt_init);
+			goto enable_irq;
+		}
 		serial8250_console_restore(up);
+		if (!console_exit_unsafe(wctxt)) {
+			atomic_console_reacquire(wctxt, &wctxt_init);
+			goto enable_irq;
+		}
 		up->canary =3D 0;
 	}
=20
 	if (em485) {
-		if (em485->tx_stopped)
+		if (em485->tx_stopped) {
+			if (!console_enter_unsafe(wctxt)) {
+				atomic_console_reacquire(wctxt, &wctxt_init);
+				goto enable_irq;
+			}
 			up->rs485_start_tx(up);
-		mdelay(port->rs485.delay_rts_before_send);
+			rs485_started =3D true;
+			if (!console_exit_unsafe(wctxt)) {
+				atomic_console_reacquire(wctxt, &wctxt_init);
+				goto enable_irq;
+			}
+		}
+		if (port->rs485.delay_rts_before_send) {
+			mdelay(port->rs485.delay_rts_before_send);
+			if (!console_can_proceed(wctxt)) {
+				atomic_console_reacquire(wctxt, &wctxt_init);
+				goto enable_irq;
+			}
+		}
 	}
=20
-	use_fifo =3D (up->capabilities & UART_CAP_FIFO) &&
-		/*
-		 * BCM283x requires to check the fifo
-		 * after each byte.
-		 */
-		!(up->capabilities & UART_CAP_MINI) &&
-		/*
-		 * tx_loadsz contains the transmit fifo size
-		 */
-		up->tx_loadsz > 1 &&
-		(up->fcr & UART_FCR_ENABLE_FIFO) &&
-		port->state &&
-		test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags) &&
-		/*
-		 * After we put a data in the fifo, the controller will send
-		 * it regardless of the CTS state. Therefore, only use fifo
-		 * if we don't use control flow.
-		 */
-		!(up->port.flags & UPF_CONS_FLOW);
+	if (!serial8250_console_write(port, wctxt, s, count, serial8250_console_p=
utchar)) {
+		atomic_console_reacquire(wctxt, &wctxt_init);
+		goto enable_irq;
+	}
=20
-	atomic_inc(&up->console_printing);
-	if (likely(use_fifo))
-		serial8250_console_fifo_write(up, s, count);
-	else
-		uart_console_write(port, s, count, serial8250_console_putchar);
-	atomic_dec(&up->console_printing);
-
-	/*
-	 *	Finally, wait for transmitter to become empty
-	 *	and restore the IER
-	 */
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
-
+	finished =3D true;
+enable_irq:
+	/*
+	 * Enter unsafe in order to stop rs485_tx. If the console is
+	 * lost before the rs485_tx is stopped, the console must be
+	 * reacquired in order to stop rs485_tx.
+	 */
 	if (em485) {
 		mdelay(port->rs485.delay_rts_after_send);
-		if (em485->tx_stopped)
+		if (em485->tx_stopped && rs485_started) {
+			while (!console_enter_unsafe(wctxt))
+				atomic_console_reacquire(wctxt, &wctxt_init);
 			up->rs485_stop_tx(up);
+			if (!console_exit_unsafe(wctxt))
+				atomic_console_reacquire(wctxt, &wctxt_init);
+		}
+	}
+
+	/*
+	 * Enter unsafe in order to enable interrupts. If the console is
+	 * lost before the interrupts are enabled, the console must be
+	 * reacquired in order to re-enable the interrupts.
+	 */
+	for (;;) {
+		if (console_enter_unsafe(wctxt) &&
+		    __serial8250_set_IER(up, wctxt, ier)) {
+			break;
+		}
+		atomic_console_reacquire(wctxt, &wctxt_init);
 	}
-	serial8250_set_IER(up, ier);
=20
 	/*
 	 *	The receive handling will happen properly because the
@@ -3561,7 +3640,9 @@ void serial8250_console_write(struct uart_8250_port *=
up, const char *s,
 	if (up->msr_saved_flags)
 		serial8250_modem_status(up);
=20
-	spin_unlock_irqrestore(&port->lock, flags);
+	console_exit_unsafe(wctxt);
+
+	return finished;
 }
=20
 static unsigned int probe_baud(struct uart_port *port)
@@ -3591,7 +3672,7 @@ int serial8250_console_setup(struct uart_port *port, =
char *options, bool probe)
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
=20
-	atomic_set(&up->console_printing, 0);
+	up->console_newline_needed =3D false;
=20
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_c=
ore.c
index 2bd32c8ece393..9901f916dc1ad 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2336,8 +2336,11 @@ int uart_suspend_port(struct uart_driver *drv, struc=
t uart_port *uport)
 	 * able to Re-start_rx later.
 	 */
 	if (!console_suspend_enabled && uart_console(uport)) {
-		if (uport->ops->start_rx)
+		if (uport->ops->start_rx) {
+			spin_lock_irq(&uport->lock);
 			uport->ops->stop_rx(uport);
+			spin_unlock_irq(&uport->lock);
+		}
 		goto unlock;
 	}
=20
@@ -2430,8 +2433,11 @@ int uart_resume_port(struct uart_driver *drv, struct=
 uart_port *uport)
 		if (console_suspend_enabled)
 			uart_change_pm(state, UART_PM_STATE_ON);
 		uport->ops->set_termios(uport, &termios, NULL);
-		if (!console_suspend_enabled && uport->ops->start_rx)
+		if (!console_suspend_enabled && uport->ops->start_rx) {
+			spin_lock_irq(&uport->lock);
 			uport->ops->start_rx(uport);
+			spin_unlock_irq(&uport->lock);
+		}
 		if (console_suspend_enabled)
 			console_start(uport->cons);
 	}
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index fd87e95fa5630..b6e70c5cfa174 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -581,7 +581,6 @@ void __handle_sysrq(int key, bool check_mask)
=20
 	rcu_sysrq_start();
 	rcu_read_lock();
-	printk_prefer_direct_enter();
 	/*
 	 * Raise the apparent loglevel to maximum so that the sysrq header
 	 * is shown to provide the user with positive feedback.  We do not
@@ -623,7 +622,6 @@ void __handle_sysrq(int key, bool check_mask)
 		pr_cont("\n");
 		console_loglevel =3D orig_log_level;
 	}
-	printk_prefer_direct_exit();
 	rcu_read_unlock();
 	rcu_sysrq_end();
=20
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 36fb945fdad48..af0f53cec843f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3543,8 +3543,13 @@ static ssize_t show_cons_active(struct device *dev,
 	for_each_console(c) {
 		if (!c->device)
 			continue;
-		if (!c->write)
-			continue;
+		if (c->flags & CON_NO_BKL) {
+			if (!(c->write_thread || c->write_atomic))
+				continue;
+		} else {
+			if (!c->write)
+				continue;
+		}
 		if ((c->flags & CON_ENABLED) =3D=3D 0)
 			continue;
 		cs[i++] =3D c;
diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index e0758fe7936dc..ab9f42d478c8c 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -21,12 +21,14 @@ static int show_console_dev(struct seq_file *m, void *v)
 		{ CON_ENABLED,		'E' },
 		{ CON_CONSDEV,		'C' },
 		{ CON_BOOT,		'B' },
+		{ CON_NO_BKL,		'N' },
 		{ CON_PRINTBUFFER,	'p' },
 		{ CON_BRL,		'b' },
 		{ CON_ANYTIME,		'a' },
 	};
 	char flags[ARRAY_SIZE(con_flags) + 1];
 	struct console *con =3D v;
+	char con_write =3D '-';
 	unsigned int a;
 	dev_t dev =3D 0;
=20
@@ -57,9 +59,15 @@ static int show_console_dev(struct seq_file *m, void *v)
 	seq_setwidth(m, 21 - 1);
 	seq_printf(m, "%s%d", con->name, con->index);
 	seq_pad(m, ' ');
-	seq_printf(m, "%c%c%c (%s)", con->read ? 'R' : '-',
-			con->write ? 'W' : '-', con->unblank ? 'U' : '-',
-			flags);
+	if (con->flags & CON_NO_BKL) {
+		if (con->write_thread || con->write_atomic)
+			con_write =3D 'W';
+	} else {
+		if (con->write)
+			con_write =3D 'W';
+	}
+	seq_printf(m, "%c%c%c (%s)", con->read ? 'R' : '-', con_write,
+		   con->unblank ? 'U' : '-', flags);
 	if (dev)
 		seq_printf(m, " %4d:%d", MAJOR(dev), MINOR(dev));
=20
diff --git a/include/linux/console.h b/include/linux/console.h
index 983d5e48e6635..ae4bbec59eea8 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,9 +16,10 @@
=20
 #include <linux/atomic.h>
 #include <linux/bits.h>
+#include <linux/irq_work.h>
 #include <linux/rculist.h>
+#include <linux/rcuwait.h>
 #include <linux/types.h>
-#include <linux/mutex.h>
=20
 struct vc_data;
 struct console_font_op;
@@ -155,6 +156,10 @@ static inline int con_debug_leave(void)
  *			receiving the printk spam for obvious reasons.
  * @CON_EXTENDED:	The console supports the extended output format of
  *			/dev/kmesg which requires a larger output buffer.
+ * @CON_SUSPENDED:	Indicates if a console is suspended. If true, the
+ *			printing callbacks must not be called.
+ * @CON_NO_BKL:		Console can operate outside of the BKL style console_lock
+ *			constraints.
  */
 enum cons_flags {
 	CON_PRINTBUFFER		=3D BIT(0),
@@ -164,16 +169,132 @@ enum cons_flags {
 	CON_ANYTIME		=3D BIT(4),
 	CON_BRL			=3D BIT(5),
 	CON_EXTENDED		=3D BIT(6),
+	CON_SUSPENDED		=3D BIT(7),
+	CON_NO_BKL		=3D BIT(8),
 };
=20
-#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
-struct console_atomic_data {
-	u64	seq;
-	char	*text;
-	char	*ext_text;
-	char	*dropped_text;
-};
+/**
+ * struct cons_state - console state for NOBKL consoles
+ * @atom:	Compound of the state fields for atomic operations
+ * @seq:	Sequence for record tracking (64bit only)
+ * @bits:	Compound of the state bits below
+ *
+ * @locked:	Console is locked by a writer
+ * @unsafe:	Console is busy in a non takeover region
+ * @thread:	Current owner is the printk thread
+ * @cur_prio:	The priority of the current output
+ * @req_prio:	The priority of a handover request
+ * @cpu:	The CPU on which the writer runs
+ *
+ * To be used for state read and preparation of atomic_long_cmpxchg()
+ * operations.
+ *
+ * The @req_prio field is particularly important to allow spin-waiting to
+ * timeout and give up without the risk of it being assigned the lock
+ * after giving up. The @req_prio field has a nice side-effect that it
+ * also makes it possible for a single read+cmpxchg in the common case of
+ * acquire and release.
+ */
+struct cons_state {
+	union {
+		unsigned long	atom;
+		struct {
+#ifdef CONFIG_64BIT
+			u32	seq;
 #endif
+			union {
+				u32	bits;
+				struct {
+					u32 locked	:  1;
+					u32 unsafe	:  1;
+					u32 thread	:  1;
+					u32 cur_prio	:  2;
+					u32 req_prio	:  2;
+					u32 cpu		: 18;
+				};
+			};
+		};
+	};
+};
+
+/**
+ * cons_prio - console writer priority for NOBKL consoles
+ * @CONS_PRIO_NONE:		Unused
+ * @CONS_PRIO_NORMAL:		Regular printk
+ * @CONS_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
+ * @CONS_PRIO_PANIC:		Panic output
+ * @CONS_PRIO_MAX:		The number of priority levels
+ *
+ * Emergency output can carefully takeover the console even without consent
+ * of the owner, ideally only when @cons_state::unsafe is not set. Panic
+ * output can ignore the unsafe flag as a last resort. If panic output is
+ * active no takeover is possible until the panic output releases the
+ * console.
+ */
+enum cons_prio {
+	CONS_PRIO_NONE =3D 0,
+	CONS_PRIO_NORMAL,
+	CONS_PRIO_EMERGENCY,
+	CONS_PRIO_PANIC,
+	CONS_PRIO_MAX,
+};
+
+struct console;
+struct printk_buffers;
+
+/**
+ * struct cons_context - Context for console acquire/release
+ * @console:		The associated console
+ * @state:		The state at acquire time
+ * @old_state:		The old state when try_acquire() failed for analysis
+ *			by the caller
+ * @hov_state:		The handover state for spin and cleanup
+ * @req_state:		The request state for spin and cleanup
+ * @spinwait_max_us:	Limit for spinwait acquire
+ * @oldseq:		The sequence number at acquire()
+ * @newseq:		The sequence number for progress
+ * @prio:		Priority of the context
+ * @pbufs:		Pointer to the text buffer for this context
+ * @dropped:		Dropped counter for the current context
+ * @thread:		The acquire is printk thread context
+ * @hostile:		Hostile takeover requested. Cleared on normal
+ *			acquire or friendly handover
+ * @spinwait:		Spinwait on acquire if possible
+ * @backlog:		Ringbuffer has pending records
+ */
+struct cons_context {
+	struct console		*console;
+	struct cons_state	state;
+	struct cons_state	old_state;
+	struct cons_state	hov_state;
+	struct cons_state	req_state;
+	u64			oldseq;
+	u64			newseq;
+	unsigned int		spinwait_max_us;
+	enum cons_prio		prio;
+	struct printk_buffers	*pbufs;
+	unsigned long		dropped;
+	unsigned int		thread		: 1;
+	unsigned int		hostile		: 1;
+	unsigned int		spinwait	: 1;
+	unsigned int		backlog		: 1;
+};
+
+/**
+ * struct cons_write_context - Context handed to the write callbacks
+ * @ctxt:	The core console context
+ * @outbuf:	Pointer to the text buffer for output
+ * @len:	Length to write
+ * @unsafe:	Invoked in unsafe state due to force takeover
+ */
+struct cons_write_context {
+	struct cons_context	__private ctxt;
+	char			*outbuf;
+	unsigned int		len;
+	bool			unsafe;
+};
+
+struct cons_context_data;
=20
 /**
  * struct console - The console descriptor structure
@@ -194,11 +315,22 @@ struct console_atomic_data {
  * @dropped:		Number of unreported dropped ringbuffer records
  * @data:		Driver private data
  * @node:		hlist node for the console list
+ *
+ * @atomic_state:	State array for NOBKL consoles; real and handover
+ * @atomic_seq:		Sequence for record tracking (32bit only)
+ * @thread_pbufs:	Pointer to thread private buffer
+ * @kthread:		Pointer to kernel thread
+ * @rcuwait:		RCU wait for the kernel thread
+ * @irq_work:		IRQ work for thread wakeup
+ * @kthread_waiting:	Indicator whether the kthread is waiting to be woken
+ * @write_atomic:	Write callback for atomic context
+ * @write_thread:	Write callback for printk threaded printing
+ * @port_lock:		Callback to lock/unlock the port lock
+ * @pcpu_data:		Pointer to percpu context data
  */
 struct console {
 	char			name[16];
 	void			(*write)(struct console *co, const char *s, unsigned int count);
-	void			(*write_atomic)(struct console *, const char *, unsigned);
 	int			(*read)(struct console *co, char *s, unsigned int count);
 	struct tty_driver	*(*device)(struct console *co, int *index);
 	void			(*unblank)(void);
@@ -211,27 +343,26 @@ struct console {
 	uint			ispeed;
 	uint			ospeed;
 	u64			seq;
-	atomic_long_t		dropped;
-#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
-	struct console_atomic_data *atomic_data;
-#endif
-	struct task_struct	*thread;
-	bool blocked;
-	/*
-	 * The per-console lock is used by printing kthreads to synchronize
-	 * this console with callers of console_lock(). This is necessary in
-	 * order to allow printing kthreads to run in parallel to each other,
-	 * while each safely accessing the @blocked field and synchronizing
-	 * against direct printing via console_lock/console_unlock.
-	 *
-	 * Note: For synchronizing against direct printing via
-	 *	console_trylock/console_unlock, see the static global
-	 *	variable @console_kthreads_active.
-	 */
-	struct mutex lock;
-
+	unsigned long		dropped;
 	void			*data;
 	struct hlist_node	node;
+
+	/* NOBKL console specific members */
+	atomic_long_t		__private atomic_state[2];
+#ifndef CONFIG_64BIT
+	atomic_t		__private atomic_seq;
+#endif
+	struct printk_buffers	*thread_pbufs;
+	struct task_struct	*kthread;
+	struct rcuwait		rcuwait;
+	struct irq_work		irq_work;
+	atomic_t		kthread_waiting;
+
+	bool (*write_atomic)(struct console *con, struct cons_write_context *wctx=
t);
+	bool (*write_thread)(struct console *con, struct cons_write_context *wctx=
t);
+	void (*port_lock)(struct console *con, bool do_lock, unsigned long *flags=
);
+
+	struct cons_context_data	__percpu *pcpu_data;
 };
=20
 #ifdef CONFIG_LOCKDEP
@@ -358,11 +489,28 @@ static inline bool console_is_registered(const struct=
 console *con)
 	lockdep_assert_console_list_lock_held();			\
 	hlist_for_each_entry(con, &console_list, node)
=20
+#ifdef CONFIG_PRINTK
+extern bool console_can_proceed(struct cons_write_context *wctxt);
+extern bool console_enter_unsafe(struct cons_write_context *wctxt);
+extern bool console_exit_unsafe(struct cons_write_context *wctxt);
+extern bool console_try_acquire(struct cons_write_context *wctxt);
+extern bool console_release(struct cons_write_context *wctxt);
+extern enum cons_prio cons_atomic_enter(enum cons_prio prio);
+extern void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio=
);
+#else
+static inline bool console_can_proceed(struct cons_write_context *wctxt) {=
 return false; }
+static inline bool console_enter_unsafe(struct cons_write_context *wctxt) =
{ return false; }
+static inline bool console_exit_unsafe(struct cons_write_context *wctxt) {=
 return false; }
+static inline bool console_try_acquire(struct cons_write_context *wctxt) {=
 return false; }
+static inline bool console_release(struct cons_write_context *wctxt) { ret=
urn false; }
+static inline enum cons_prio cons_atomic_enter(enum cons_prio prio) { retu=
rn CONS_PRIO_NONE; }
+static inline void cons_atomic_exit(enum cons_prio prio, enum cons_prio pr=
ev_prio) { }
+#endif
+
 extern int console_set_on_cmdline;
 extern struct console *early_console;
=20
 enum con_flush_mode {
-	CONSOLE_ATOMIC_FLUSH_PENDING,
 	CONSOLE_FLUSH_PENDING,
 	CONSOLE_REPLAY_ALL,
 };
diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index 09d4f17c8d3b6..7376c1df9c901 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -69,7 +69,10 @@ io_mapping_map_atomic_wc(struct io_mapping *mapping,
=20
 	BUG_ON(offset >=3D mapping->size);
 	phys_addr =3D mapping->base + offset;
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+	else
+		migrate_disable();
 	pagefault_disable();
 	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
 }
@@ -79,7 +82,10 @@ io_mapping_unmap_atomic(void __iomem *vaddr)
 {
 	kunmap_local_indexed((void __force *)vaddr);
 	pagefault_enable();
-	preempt_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+	else
+		migrate_enable();
 }
=20
 static inline void __iomem *
@@ -162,7 +168,10 @@ static inline void __iomem *
 io_mapping_map_atomic_wc(struct io_mapping *mapping,
 			 unsigned long offset)
 {
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+	else
+		migrate_disable();
 	pagefault_disable();
 	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
 }
@@ -172,7 +181,10 @@ io_mapping_unmap_atomic(void __iomem *vaddr)
 {
 	io_mapping_unmap(vaddr);
 	pagefault_enable();
-	preempt_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+	else
+		migrate_enable();
 }
=20
 static inline void __iomem *
diff --git a/include/linux/printk.h b/include/linux/printk.h
index f8ece667f7117..b55662624ff87 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -139,6 +139,7 @@ void early_printk(const char *s, ...) { }
 #endif
=20
 struct dev_printk_info;
+struct cons_write_context;
=20
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(4, 0)
@@ -157,18 +158,17 @@ int _printk(const char *fmt, ...);
  */
 __printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
=20
-extern void __printk_safe_enter(void);
-extern void __printk_safe_exit(void);
+extern void __printk_safe_enter(unsigned long *flags);
+extern void __printk_safe_exit(unsigned long *flags);
+extern void __printk_deferred_enter(void);
+extern void __printk_deferred_exit(void);
 /*
  * The printk_deferred_enter/exit macros are available only as a hack for
  * some code paths that need to defer all printk console printing. Interru=
pts
  * must be disabled for the deferred duration.
  */
-#define printk_deferred_enter __printk_safe_enter
-#define printk_deferred_exit __printk_safe_exit
-extern void printk_prefer_direct_enter(void);
-extern void printk_prefer_direct_exit(void);
-extern void try_block_console_kthreads(int timeout_ms);
+#define printk_deferred_enter() __printk_deferred_enter()
+#define printk_deferred_exit() __printk_deferred_exit()
=20
 /*
  * Please don't use printk_ratelimit(), because it shares ratelimiting sta=
te
@@ -195,6 +195,8 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+extern void cons_atomic_flush(struct cons_write_context *printk_caller_wct=
xt,
+			      bool skip_unsafe);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -220,18 +222,6 @@ static inline void printk_deferred_exit(void)
 {
 }
=20
-static inline void printk_prefer_direct_enter(void)
-{
-}
-
-static inline void printk_prefer_direct_exit(void)
-{
-}
-
-static inline void try_block_console_kthreads(int timeout_ms)
-{
-}
-
 static inline int printk_ratelimit(void)
 {
 	return 0;
@@ -286,6 +276,12 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+
+static inline void cons_atomic_flush(struct cons_write_context *printk_cal=
ler_wctxt,
+				     bool skip_unsafe)
+{
+}
+
 #endif
=20
 #ifdef CONFIG_SMP
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 4be94aa44d43c..9055a22992edc 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -7,7 +7,6 @@
 #ifndef _LINUX_SERIAL_8250_H
 #define _LINUX_SERIAL_8250_H
=20
-#include <linux/atomic.h>
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/platform_device.h>
@@ -126,7 +125,7 @@ struct uart_8250_port {
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
=20
-	atomic_t		console_printing;
+	bool			console_newline_needed;
=20
 	struct uart_8250_dma	*dma;
 	const struct uart_8250_ops *ops;
@@ -142,6 +141,9 @@ struct uart_8250_port {
 	/* Serial port overrun backoff */
 	struct delayed_work overrun_backoff;
 	u32 overrun_backoff_time_ms;
+
+	struct cons_write_context wctxt;
+	int cookie;
 };
=20
 static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
@@ -181,10 +183,10 @@ void serial8250_tx_chars(struct uart_8250_port *up);
 unsigned int serial8250_modem_status(struct uart_8250_port *up);
 void serial8250_init_port(struct uart_8250_port *up);
 void serial8250_set_defaults(struct uart_8250_port *up);
-void serial8250_console_write(struct uart_8250_port *up, const char *s,
-			      unsigned int count);
-void serial8250_console_write_atomic(struct uart_8250_port *up, const char=
 *s,
-				     unsigned int count);
+bool serial8250_console_write_atomic(struct uart_8250_port *up,
+				     struct cons_write_context *wctxt);
+bool serial8250_console_write_thread(struct uart_8250_port *up,
+				     struct cons_write_context *wctxt);
 int serial8250_console_setup(struct uart_port *port, char *options, bool p=
robe);
 int serial8250_console_exit(struct uart_port *port);
=20
diff --git a/init/Kconfig b/init/Kconfig
index cd987d895e738..1fb5f313d18f0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1607,10 +1607,6 @@ config PRINTK
 	  very difficult to diagnose system problems, saying N here is
 	  strongly discouraged.
=20
-config HAVE_ATOMIC_CONSOLE
-	bool
-	default n
-
 config BUG
 	bool "BUG() support" if EXPERT
 	default y
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 5c7e9ba7cd6b2..e9139dfc1f0a8 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -576,6 +576,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
 			continue;
 		if (c =3D=3D dbg_io_ops->cons)
 			continue;
+		if (!c->write)
+			continue;
 		/*
 		 * Set oops_in_progress to encourage the console drivers to
 		 * disregard their internal spin locks: in the current calling
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 7f70fe65dfd14..322813366c6c6 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -127,8 +127,6 @@ static void check_hung_task(struct task_struct *t, unsi=
gned long timeout)
 	 * complain:
 	 */
 	if (sysctl_hung_task_warnings) {
-		printk_prefer_direct_enter();
-
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
@@ -146,7 +144,6 @@ static void check_hung_task(struct task_struct *t, unsi=
gned long timeout)
 			hung_task_show_all_bt =3D true;
 		if (!sysctl_hung_task_warnings)
 			pr_info("Future hung task reports are suppressed, see sysctl kernel.hun=
g_task_warnings\n");
-		printk_prefer_direct_exit();
 	}
=20
 	touch_nmi_watchdog();
@@ -217,17 +214,12 @@ static void check_hung_uninterruptible_tasks(unsigned=
 long timeout)
 	}
  unlock:
 	rcu_read_unlock();
-	if (hung_task_show_lock) {
-		printk_prefer_direct_enter();
+	if (hung_task_show_lock)
 		debug_show_all_locks();
-		printk_prefer_direct_exit();
-	}
=20
 	if (hung_task_show_all_bt) {
 		hung_task_show_all_bt =3D false;
-		printk_prefer_direct_enter();
 		trigger_all_cpu_backtrace();
-		printk_prefer_direct_exit();
 	}
=20
 	if (hung_task_call_panic)
diff --git a/kernel/panic.c b/kernel/panic.c
index 34ad83f40075e..190f7f2bc6cfd 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -178,7 +178,6 @@ void __weak crash_smp_send_stop(void)
 	 * unfortunately means it may not be hardened to work in a panic
 	 * situation.
 	 */
-	try_block_console_kthreads(10000);
 	smp_send_stop();
 	cpus_stopped =3D 1;
 }
@@ -260,7 +259,6 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 	 * bits in addition to stopping other CPUs, hence we rely on
 	 * crash_smp_send_stop() for that.
 	 */
-	try_block_console_kthreads(10000);
 	if (!crash_kexec)
 		smp_send_stop();
 	else
@@ -277,6 +275,7 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
  */
 void panic(const char *fmt, ...)
 {
+	enum cons_prio prev_prio;
 	static char buf[1024];
 	va_list args;
 	long i, i_next =3D 0, len;
@@ -324,7 +323,10 @@ void panic(const char *fmt, ...)
 	if (old_cpu !=3D PANIC_CPU_INVALID && old_cpu !=3D this_cpu)
 		panic_smp_self_stop();
=20
+	prev_prio =3D cons_atomic_enter(CONS_PRIO_PANIC);
+
 	console_verbose();
+	bust_spinlocks(1);
 	va_start(args, fmt);
 	len =3D vscnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
@@ -341,11 +343,6 @@ void panic(const char *fmt, ...)
 		dump_stack();
 #endif
=20
-	/* If atomic consoles are available, flush the kernel log. */
-	console_flush_on_panic(CONSOLE_ATOMIC_FLUSH_PENDING);
-
-	bust_spinlocks(1);
-
 	/*
 	 * If kgdb is enabled, give it a chance to run before we stop all
 	 * the other CPUs or else we won't be able to debug processes left
@@ -388,6 +385,8 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
=20
+	cons_atomic_flush(NULL, true);
+
 	console_unblank();
=20
 	/*
@@ -412,6 +411,7 @@ void panic(const char *fmt, ...)
 		 * We can't use the "normal" timers since we just panicked.
 		 */
 		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
+		cons_atomic_flush(NULL, true);
=20
 		for (i =3D 0; i < panic_timeout * 1000; i +=3D PANIC_TIMER_STEP) {
 			touch_nmi_watchdog();
@@ -430,6 +430,7 @@ void panic(const char *fmt, ...)
 		 */
 		if (panic_reboot_mode !=3D REBOOT_UNDEFINED)
 			reboot_mode =3D panic_reboot_mode;
+		cons_atomic_flush(NULL, true);
 		emergency_restart();
 	}
 #ifdef __sparc__
@@ -442,12 +443,16 @@ void panic(const char *fmt, ...)
 	}
 #endif
 #if defined(CONFIG_S390)
+	cons_atomic_flush(NULL, true);
 	disabled_wait();
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
=20
 	/* Do not scroll important messages printed above */
 	suppress_printk =3D 1;
+
+	cons_atomic_exit(CONS_PRIO_PANIC, prev_prio);
+
 	local_irq_enable();
 	for (i =3D 0; ; i +=3D PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
@@ -658,9 +663,11 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
-	disable_trace_on_warning();
+	enum cons_prio prev_prio;
=20
-	printk_prefer_direct_enter();
+	prev_prio =3D cons_atomic_enter(CONS_PRIO_EMERGENCY);
+
+	disable_trace_on_warning();
=20
 	if (file)
 		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
@@ -691,7 +698,7 @@ void __warn(const char *file, int line, void *caller, u=
nsigned taint,
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
=20
-	printk_prefer_direct_exit();
+	cons_atomic_exit(CONS_PRIO_EMERGENCY, prev_prio);
 }
=20
 #ifndef __WARN_FLAGS
diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index f5b388e810b9f..b36683bd2f821 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y	=3D printk.o
-obj-$(CONFIG_PRINTK)	+=3D printk_safe.o
+obj-$(CONFIG_PRINTK)	+=3D printk_safe.o printk_nobkl.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+=3D braille.o
 obj-$(CONFIG_PRINTK_INDEX)	+=3D index.o
=20
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 57d118babb756..fb363b495ce92 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -3,6 +3,8 @@
  * internal.h - printk internal definitions
  */
 #include <linux/percpu.h>
+#include <linux/console.h>
+#include "printk_ringbuffer.h"
=20
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 void __init printk_sysctl_init(void);
@@ -12,8 +14,13 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, i=
nt write,
 #define printk_sysctl_init() do { } while (0)
 #endif
=20
-#ifdef CONFIG_PRINTK
+#define con_printk(lvl, con, fmt, ...)				\
+	printk(lvl pr_fmt("%s%sconsole [%s%d] " fmt),		\
+	       (con->flags & CON_NO_BKL) ? "" : "legacy ",	\
+	       (con->flags & CON_BOOT) ? "boot" : "",		\
+	       con->name, con->index, ##__VA_ARGS__)
=20
+#ifdef CONFIG_PRINTK
 #ifdef CONFIG_PRINTK_CALLER
 #define PRINTK_PREFIX_MAX	48
 #else
@@ -35,7 +42,11 @@ enum printk_info_flags {
 	LOG_CONT	=3D 8,	/* text is a fragment of a continuation line */
 };
=20
-extern bool block_console_kthreads;
+extern struct printk_ringbuffer *prb;
+extern bool have_bkl_console;
+extern bool printk_threads_enabled;
+
+extern bool have_boot_console;
=20
 __printf(4, 0)
 int vprintk_store(int facility, int level,
@@ -49,26 +60,86 @@ bool printk_percpu_data_ready(void);
=20
 #define printk_safe_enter_irqsave(flags)	\
 	do {					\
-		local_irq_save(flags);		\
-		__printk_safe_enter();		\
+		__printk_safe_enter(&flags);	\
 	} while (0)
=20
 #define printk_safe_exit_irqrestore(flags)	\
 	do {					\
-		__printk_safe_exit();		\
-		local_irq_restore(flags);	\
+		__printk_safe_exit(&flags);	\
 	} while (0)
=20
 void defer_console_output(void);
=20
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
+
+u64 cons_read_seq(struct console *con);
+void cons_nobkl_cleanup(struct console *con);
+bool cons_nobkl_init(struct console *con);
+bool cons_alloc_percpu_data(struct console *con);
+void cons_kthread_create(struct console *con);
+void cons_wake_threads(void);
+void cons_force_seq(struct console *con, u64 seq);
+void console_bkl_kthread_create(void);
+
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records. If the caller only works with certain types of consoles, the
+ * caller is responsible for checking the console type before calling
+ * this function.
+ */
+static inline bool console_is_usable(struct console *con, short flags)
+{
+	if (!(flags & CON_ENABLED))
+		return false;
+
+	if ((flags & CON_SUSPENDED))
+		return false;
+
+	/*
+	 * The usability of a console varies depending on whether
+	 * it is a NOBKL console or not.
+	 */
+
+	if (flags & CON_NO_BKL) {
+		if (have_boot_console)
+			return false;
+
+	} else {
+		if (!con->write)
+			return false;
+		/*
+		 * Console drivers may assume that per-cpu resources have
+		 * been allocated. So unless they're explicitly marked as
+		 * being able to cope (CON_ANYTIME) don't call them until
+		 * this CPU is officially up.
+		 */
+		if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * cons_kthread_wake - Wake up a printk thread
+ * @con:        Console to operate on
+ */
+static inline void cons_kthread_wake(struct console *con)
+{
+	rcuwait_wake_up(&con->rcuwait);
+}
+
 #else
=20
 #define PRINTK_PREFIX_MAX	0
 #define PRINTK_MESSAGE_MAX	0
 #define PRINTKRB_RECORD_MAX	0
=20
+static inline void cons_kthread_wake(struct console *con) { }
+static inline void cons_kthread_create(struct console *con) { }
+#define printk_threads_enabled	(false)
+
 /*
  * In !PRINTK builds we still export console_sem
  * semaphore and some of console functions (console_unlock()/etc.), so
@@ -78,8 +149,15 @@ u16 printk_parse_prefix(const char *text, int *level,
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
=20
 static inline bool printk_percpu_data_ready(void) { return false; }
+static inline bool cons_nobkl_init(struct console *con) { return true; }
+static inline void cons_nobkl_cleanup(struct console *con) { }
+static inline bool console_is_usable(struct console *con, short flags) { r=
eturn false; }
+static inline void cons_force_seq(struct console *con, u64 seq) { }
+
 #endif /* CONFIG_PRINTK */
=20
+extern bool have_boot_console;
+
 /**
  * struct printk_buffers - Buffers to read/format/output printk messages.
  * @outbuf:	After formatting, contains text to output.
@@ -105,3 +183,28 @@ struct printk_message {
 	u64			seq;
 	unsigned long		dropped;
 };
+
+/**
+ * struct cons_context_data - console context data
+ * @wctxt:		Write context per priority level
+ * @pbufs:		Buffer for storing the text
+ *
+ * Used for early boot and for per CPU data.
+ *
+ * The write contexts are allocated to avoid having them on stack, e.g. in
+ * warn() or panic().
+ */
+struct cons_context_data {
+	struct cons_write_context	wctxt[CONS_PRIO_MAX];
+	struct printk_buffers		pbufs;
+};
+
+bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+			     bool is_extended, bool may_supress);
+
+#ifdef CONFIG_PRINTK
+
+void console_prepend_dropped(struct printk_message *pmsg,
+			     unsigned long dropped);
+
+#endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d045614172787..f733204f33ee5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -44,7 +44,6 @@
 #include <linux/irq_work.h>
 #include <linux/ctype.h>
 #include <linux/uio.h>
-#include <linux/clocksource.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
@@ -305,36 +304,6 @@ void console_srcu_read_unlock(int cookie)
 }
 EXPORT_SYMBOL(console_srcu_read_unlock);
=20
-/*
- * Used to synchronize printing kthreads against direct printing via
- * console_trylock/console_unlock.
- *
- * Values:
- * -1 =3D console kthreads atomically blocked (via global trylock)
- *  0 =3D no kthread printing, console not locked (via trylock)
- * >0 =3D kthread(s) actively printing
- *
- * Note: For synchronizing against direct printing via
- *       console_lock/console_unlock, see the @lock variable in
- *       struct console.
- */
-static atomic_t console_kthreads_active =3D ATOMIC_INIT(0);
-
-#define console_kthreads_atomic_tryblock() \
-       (atomic_cmpxchg(&console_kthreads_active, 0, -1) =3D=3D 0)
-#define console_kthreads_atomic_unblock() \
-       atomic_cmpxchg(&console_kthreads_active, -1, 0)
-#define console_kthreads_atomically_blocked() \
-       (atomic_read(&console_kthreads_active) =3D=3D -1)
-
-#define console_kthread_printing_tryenter() \
-       atomic_inc_unless_negative(&console_kthreads_active)
-#define console_kthread_printing_exit() \
-       atomic_dec(&console_kthreads_active)
-
-/* Block console kthreads to avoid processing new messages. */
-bool block_console_kthreads;
-
 /*
  * Helper macros to handle lockdep when locking/unlocking console_sem. We =
use
  * macros instead of functions so that _RET_IP_ contains useful informatio=
n.
@@ -349,6 +318,10 @@ static int __down_trylock_console_sem(unsigned long ip)
 	int lock_failed;
 	unsigned long flags;
=20
+	/* Semaphores are not NMI-safe. */
+	if (in_nmi())
+		return 1;
+
 	/*
 	 * Here and in __up_console_sem() we need to be in safe mode,
 	 * because spindump/WARN/etc from under console ->lock will
@@ -383,54 +356,14 @@ static bool panic_in_progress(void)
 }
=20
 /*
- * Tracks whether kthread printers are all blocked. A value of true implies
- * that the console is locked via console_lock() or the console is suspend=
ed.
- * Writing to this variable requires holding @console_sem.
+ * This is used for debugging the mess that is the VT code by
+ * keeping track if we have the console semaphore held. It's
+ * definitely not the perfect debug tool (we don't know if _WE_
+ * hold it and are racing, but it helps tracking those weird code
+ * paths in the console code where we end up in places I want
+ * locked without the console semaphore held).
  */
-static bool console_kthreads_blocked;
-
-/*
- * Block all kthread printers from a schedulable context.
- *
- * Requires holding @console_sem.
- */
-static void console_kthreads_block(void)
-{
-	struct console *con;
-	int cookie;
-
-	cookie =3D console_srcu_read_lock();
-	for_each_console_srcu(con) {
-		mutex_lock(&con->lock);
-		con->blocked =3D true;
-		mutex_unlock(&con->lock);
-	}
-	console_srcu_read_unlock(cookie);
-
-	console_kthreads_blocked =3D true;
-}
-
-/*
- * Unblock all kthread printers from a schedulable context.
- *
- * Requires holding @console_sem.
- */
-static void console_kthreads_unblock(void)
-{
-	struct console *con;
-	int cookie;
-
-	cookie =3D console_srcu_read_lock();
-	for_each_console_srcu(con) {
-		mutex_lock(&con->lock);
-		con->blocked =3D false;
-		mutex_unlock(&con->lock);
-	}
-	console_srcu_read_unlock(cookie);
-	console_kthreads_blocked =3D false;
-}
-
-static int console_suspended;
+static int console_locked, console_suspended;
=20
 /*
  *	Array of consoles built from command line options (console=3D)
@@ -514,74 +447,21 @@ static int console_msg_format =3D MSG_FORMAT_DEFAULT;
 static DEFINE_MUTEX(syslog_lock);
=20
 /*
- * A flag to signify if printk_activate_kthreads() has already started the
- * kthread printers. If true, any later registered consoles must start the=
ir
- * own kthread directly. The flag is write protected by the console_lock.
+ * Specifies if a BKL console was ever registered. Used to determine if the
+ * console lock/unlock dance is needed for console printing.
  */
-static bool printk_kthreads_available;
-
-#ifdef CONFIG_PRINTK
-static atomic_t printk_prefer_direct =3D ATOMIC_INIT(0);
-
-/**
- * printk_prefer_direct_enter - cause printk() calls to attempt direct
- *                              printing to all enabled consoles
- *
- * Since it is not possible to call into the console printing code from any
- * context, there is no guarantee that direct printing will occur.
- *
- * This globally effects all printk() callers.
- *
- * Context: Any context.
- */
-void printk_prefer_direct_enter(void)
-{
-	atomic_inc(&printk_prefer_direct);
-}
-
-/**
- * printk_prefer_direct_exit - restore printk() behavior
- *
- * Context: Any context.
- */
-void printk_prefer_direct_exit(void)
-{
-	WARN_ON(atomic_dec_if_positive(&printk_prefer_direct) < 0);
-}
+bool have_bkl_console;
=20
 /*
- * Calling printk() always wakes kthread printers so that they can
- * flush the new message to their respective consoles. Also, if direct
- * printing is allowed, printk() tries to flush the messages directly.
- *
- * Direct printing is allowed in situations when the kthreads
- * are not available or the system is in a problematic state.
- *
- * See the implementation about possible races.
+ * Specifies if a boot console is registered. Used to determine if NOBKL
+ * consoles may be used since NOBKL consoles cannot synchronize with boot
+ * consoles.
  */
-static inline bool allow_direct_printing(void)
-{
-	/*
-	 * Checking kthread availability is a possible race because the
-	 * kthread printers can become permanently disabled during runtime.
-	 * However, doing that requires holding the console_lock, so any
-	 * pending messages will be direct printed by console_unlock().
-	 */
-	if (!printk_kthreads_available)
-		return true;
+bool have_boot_console;
=20
-	/*
-	 * Prefer direct printing when the system is in a problematic state.
-	 * The context that sets this state will always see the updated value.
-	 * The other contexts do not care. Anyway, direct printing is just a
-	 * best effort. The direct output is only possible when console_lock
-	 * is not already taken and no kthread printers are actively printing.
-	 */
-	return (system_state > SYSTEM_RUNNING ||
-		oops_in_progress ||
-		atomic_read(&printk_prefer_direct));
-}
+static int unregister_console_locked(struct console *console);
=20
+#ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
@@ -631,7 +511,7 @@ _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT=
 - PRB_AVGBITS,
=20
 static struct printk_ringbuffer printk_rb_dynamic;
=20
-static struct printk_ringbuffer *prb =3D &printk_rb_static;
+struct printk_ringbuffer *prb =3D &printk_rb_static;
=20
 /*
  * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
@@ -835,9 +715,6 @@ static ssize_t msg_print_ext_body(char *buf, size_t siz=
e,
 	return len;
 }
=20
-static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-				    bool is_extended, bool may_supress);
-
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	atomic64_t seq;
@@ -1239,7 +1116,19 @@ static inline void log_buf_add_cpu(void) {}
=20
 static void __init set_percpu_data_ready(void)
 {
+	struct hlist_node *tmp;
+	struct console *con;
+
+	console_list_lock();
+
+	hlist_for_each_entry_safe(con, tmp, &console_list, node) {
+		if (!cons_alloc_percpu_data(con))
+			unregister_console_locked(con);
+	}
+
 	__printk_percpu_data_ready =3D true;
+
+	console_list_unlock();
 }
=20
 static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
@@ -2055,7 +1944,6 @@ static int console_lock_spinning_disable_and_check(in=
t cookie)
 	return 1;
 }
=20
-#if !IS_ENABLED(CONFIG_PREEMPT_RT)
 /**
  * console_trylock_spinning - try to get console_lock by busy waiting
  *
@@ -2129,7 +2017,6 @@ static int console_trylock_spinning(void)
=20
 	return 1;
 }
-#endif /* CONFIG_PREEMPT_RT */
=20
 /*
  * Recursion is tracked separately on each CPU. If NMIs are supported, an
@@ -2417,6 +2304,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
+	struct cons_write_context wctxt =3D { };
 	int printed_len;
 	bool in_sched =3D false;
=20
@@ -2437,28 +2325,25 @@ asmlinkage int vprintk_emit(int facility, int level,
=20
 	printed_len =3D vprintk_store(facility, level, dev_info, fmt, args);
=20
+	/*
+	 * The caller may be holding system-critical or
+	 * timing-sensitive locks. Disable preemption during
+	 * printing of all remaining records to all consoles so that
+	 * this context can return as soon as possible. Hopefully
+	 * another printk() caller will take over the printing.
+	 */
+	preempt_disable();
+
+	/*
+	 * Flush the non-BKL consoles. This only leads to direct atomic
+	 * printing for non-BKL consoles that do not have a printer
+	 * thread available. Otherwise the printer thread will perform
+	 * the printing.
+	 */
+	cons_atomic_flush(&wctxt, true);
+
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched && allow_direct_printing()) {
-#if IS_ENABLED(CONFIG_PREEMPT_RT)
-		/*
-		 * Use the non-spinning trylock since PREEMPT_RT does not
-		 * support console lock handovers.
-		 *
-		 * Direct printing will most likely involve taking spinlocks.
-		 * For PREEMPT_RT, this is only allowed if in a preemptible
-		 * context.
-		 */
-		if (preemptible() && console_trylock())
-			console_unlock();
-#else
-		/*
-		 * The caller may be holding system-critical or
-		 * timing-sensitive locks. Disable preemption during direct
-		 * printing of all remaining records to all consoles so that
-		 * this context can return as soon as possible. Hopefully
-		 * another printk() caller will take over the printing.
-		 */
-		preempt_disable();
+	if (!in_sched && have_bkl_console && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore. The release will print out buffers. With the
@@ -2467,11 +2352,15 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 */
 		if (console_trylock_spinning())
 			console_unlock();
-		preempt_enable();
-#endif
 	}
=20
-	wake_up_klogd();
+	preempt_enable();
+
+	cons_wake_threads();
+	if (in_sched)
+		defer_console_output();
+	else
+		wake_up_klogd();
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);
@@ -2495,64 +2384,9 @@ asmlinkage __visible int _printk(const char *fmt, ..=
=2E)
 }
 EXPORT_SYMBOL(_printk);
=20
-#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
-static void __free_atomic_data(struct console_atomic_data *d)
-{
-}
-
-static void free_atomic_data(struct console_atomic_data *d)
-{
-	int count =3D 1;
-	int i;
-
-	if (!d)
-		return;
-
-#ifdef CONFIG_HAVE_NMI
-	count =3D 2;
-#endif
-
-	for (i =3D 0; i < count; i++)
-		__free_atomic_data(&d[i]);
-	kfree(d);
-}
-
-static int __alloc_atomic_data(struct console_atomic_data *d, short flags)
-{
-	return 0;
-}
-
-static struct console_atomic_data *alloc_atomic_data(short flags)
-{
-	struct console_atomic_data *d;
-	int count =3D 1;
-	int i;
-
-#ifdef CONFIG_HAVE_NMI
-	count =3D 2;
-#endif
-
-	d =3D kzalloc(sizeof(*d) * count, GFP_KERNEL);
-	if (!d)
-		goto err_out;
-
-	for (i =3D 0; i < count; i++) {
-		if (__alloc_atomic_data(&d[i], flags) !=3D 0)
-			goto err_out;
-	}
-
-	return d;
-err_out:
-	free_atomic_data(d);
-	return NULL;
-}
-#endif /* CONFIG_HAVE_ATOMIC_CONSOLE */
-
 static bool pr_flush(int timeout_ms, bool reset_on_progress);
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_=
progress);
=20
-static void printk_start_kthread(struct console *con);
-
 #else /* CONFIG_PRINTK */
=20
 #define printk_time		false
@@ -2561,8 +2395,6 @@ static void printk_start_kthread(struct console *con);
 #define prb_first_valid_seq(rb)		0
 #define prb_next_seq(rb)		0
=20
-#define free_atomic_data(d)
-
 static u64 syslog_seq;
=20
 static size_t record_print_text(const struct printk_record *r,
@@ -2583,8 +2415,6 @@ static int console_lock_spinning_disable_and_check(in=
t cookie) { return 0; }
 static bool suppress_message_printing(int level) { return false; }
 static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true=
; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_=
progress) { return true; }
-static void printk_start_kthread(struct console *con) { }
-static bool allow_direct_printing(void) { return true; }
=20
 #endif /* CONFIG_PRINTK */
=20
@@ -2769,10 +2599,26 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable =
console loglevel raise to hig
  */
 void suspend_console(void)
 {
+	struct console *con;
+
 	if (!console_suspend_enabled)
 		return;
 	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
 	pr_flush(1000, true);
+
+	console_list_lock();
+	for_each_console(con)
+		console_srcu_write_flags(con, con->flags | CON_SUSPENDED);
+	console_list_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. All printing
+	 * contexts must be able to see that they are suspended so that it
+	 * is guaranteed that all printing has stopped when this function
+	 * completes.
+	 */
+	synchronize_srcu(&console_srcu);
+
 	console_lock();
 	console_suspended =3D 1;
 	up_console_sem();
@@ -2780,11 +2626,39 @@ void suspend_console(void)
=20
 void resume_console(void)
 {
+	struct console *con;
+	short flags;
+	int cookie;
+
 	if (!console_suspend_enabled)
 		return;
 	down_console_sem();
 	console_suspended =3D 0;
 	console_unlock();
+
+	console_list_lock();
+	for_each_console(con)
+		console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
+	console_list_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. All printing
+	 * contexts must be able to see they are no longer suspended so
+	 * that they are guaranteed to wake up and resume printing.
+	 */
+	synchronize_srcu(&console_srcu);
+
+	cookie =3D console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		flags =3D console_srcu_read_flags(con);
+		if (flags & CON_NO_BKL)
+			cons_kthread_wake(con);
+	}
+	console_srcu_read_unlock(cookie);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && have_bkl_console)
+		wake_up_interruptible(&log_wait);
+
 	pr_flush(1000, true);
 }
=20
@@ -2799,18 +2673,10 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen) {
+	if (!cpuhp_tasks_frozen && have_bkl_console) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
-		else {
-			/*
-			 * If a new CPU comes online, the conditions for
-			 * printer_should_wake() may have changed for some
-			 * kthread printer with !CON_ANYTIME.
-			 */
-			wake_up_klogd();
-		}
 	}
 	return 0;
 }
@@ -2830,7 +2696,7 @@ void console_lock(void)
 	down_console_sem();
 	if (console_suspended)
 		return;
-	console_kthreads_block();
+	console_locked =3D 1;
 	console_may_schedule =3D 1;
 }
 EXPORT_SYMBOL(console_lock);
@@ -2851,30 +2717,15 @@ int console_trylock(void)
 		up_console_sem();
 		return 0;
 	}
-	if (!console_kthreads_atomic_tryblock()) {
-		up_console_sem();
-		return 0;
-	}
+	console_locked =3D 1;
 	console_may_schedule =3D 0;
 	return 1;
 }
 EXPORT_SYMBOL(console_trylock);
=20
-/*
- * This is used to help to make sure that certain paths within the VT code=
 are
- * running with the console lock held. It is definitely not the perfect de=
bug
- * tool (it is not known if the VT code is the task holding the console lo=
ck),
- * but it helps tracking those weird code paths in the console code such as
- * when the console is suspended: where the console is not locked but no
- * console printing may occur.
- *
- * Note: This returns true when the console is suspended but is not locked.
- *       This is intentional because the VT code must consider that situat=
ion
- *       the same as if the console was locked.
- */
 int is_console_locked(void)
 {
-	return (console_kthreads_blocked || atomic_read(&console_kthreads_active)=
);
+	return console_locked;
 }
 EXPORT_SYMBOL(is_console_locked);
=20
@@ -2897,137 +2748,12 @@ static bool abandon_console_lock_in_panic(void)
 	return atomic_read(&panic_cpu) !=3D raw_smp_processor_id();
 }
=20
-/*
- * Check if the given console is currently capable and allowed to print
- * records.
- *
- * Requires the console_srcu_read_lock.
- */
-static inline bool console_is_usable(struct console *con, bool atomic_prin=
ting)
-{
-	short flags;
-
-	if (atomic_printing) {
-#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
-		if (!con->write_atomic)
-			return false;
-		if (!con->atomic_data)
-			return false;
-#else
-		return false;
-#endif
-	}
-	flags =3D console_srcu_read_flags(con);
-
-	if (!(flags & CON_ENABLED))
-		return false;
-
-	if (!con->write)
-		return false;
-
-	/*
-	 * Console drivers may assume that per-cpu resources have been
-	 * allocated. So unless they're explicitly marked as being able to
-	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
-	 */
-	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
-		return false;
-
-	return true;
-}
-
-static bool console_is_usable_unlocked(struct console *con)
-{
-	int cookie;
-	bool ret;
-
-	cookie =3D console_srcu_read_lock();
-	ret =3D console_is_usable(con, false);
-	console_srcu_read_unlock(cookie);
-
-	return ret;
-}
-
 static void __console_unlock(void)
 {
-	/*
-	 * Depending on whether console_lock() or console_trylock() was used,
-	 * appropriately allow the kthread printers to continue.
-	 */
-	if (console_kthreads_blocked)
-		console_kthreads_unblock();
-	else
-		console_kthreads_atomic_unblock();
-
-	/*
-	 * New records may have arrived while the console was locked.
-	 * Wake the kthread printers to print them.
-	 */
-	wake_up_klogd();
-
+	console_locked =3D 0;
 	up_console_sem();
 }
=20
-static u64 read_console_seq(struct console *con)
-{
-#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
-	unsigned long flags;
-	u64 seq2;
-	u64 seq;
-
-	if (!con->atomic_data)
-		return con->seq;
-
-	printk_cpu_sync_get_irqsave(flags);
-
-	seq =3D con->seq;
-	seq2 =3D con->atomic_data[0].seq;
-	if (seq2 > seq)
-		seq =3D seq2;
-#ifdef CONFIG_HAVE_NMI
-	seq2 =3D con->atomic_data[1].seq;
-	if (seq2 > seq)
-		seq =3D seq2;
-#endif
-
-	printk_cpu_sync_put_irqrestore(flags);
-
-	return seq;
-#else /* CONFIG_HAVE_ATOMIC_CONSOLE */
-	return con->seq;
-#endif
-}
-
-static void write_console_seq(struct console *con, u64 val, bool atomic_pr=
inting)
-{
-#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
-	unsigned long flags;
-	u64 *seq;
-
-	if (!con->atomic_data) {
-		con->seq =3D val;
-		return;
-	}
-
-	printk_cpu_sync_get_irqsave(flags);
-
-	if (atomic_printing) {
-		seq =3D &con->atomic_data[0].seq;
-#ifdef CONFIG_HAVE_NMI
-		if (in_nmi())
-			seq =3D &con->atomic_data[1].seq;
-#endif
-	} else {
-		seq =3D &con->seq;
-	}
-	*seq =3D val;
-
-	printk_cpu_sync_put_irqrestore(flags);
-#else /* CONFIG_HAVE_ATOMIC_CONSOLE */
-	con->seq =3D val;
-#endif
-}
-
 /*
  * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message". T=
his
  * is achieved by shifting the existing message over and inserting the dro=
pped
@@ -3043,7 +2769,7 @@ static void write_console_seq(struct console *con, u6=
4 val, bool atomic_printing
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
 #ifdef CONFIG_PRINTK
-static void console_prepend_dropped(struct printk_message *pmsg, unsigned =
long dropped)
+void console_prepend_dropped(struct printk_message *pmsg, unsigned long dr=
opped)
 {
 	struct printk_buffers *pbufs =3D pmsg->pbufs;
 	const size_t scratchbuf_sz =3D sizeof(pbufs->scratchbuf);
@@ -3075,7 +2801,8 @@ static void console_prepend_dropped(struct printk_mes=
sage *pmsg, unsigned long d
 	pmsg->outbuf_len +=3D len;
 }
 #else
-#define console_prepend_dropped(pmsg, dropped)
+static inline void console_prepend_dropped(struct printk_message *pmsg,
+					   unsigned long dropped) { }
 #endif /* CONFIG_PRINTK */
=20
 /*
@@ -3097,10 +2824,10 @@ static void console_prepend_dropped(struct printk_m=
essage *pmsg, unsigned long d
  * of @pmsg are valid. (See the documentation of struct printk_message
  * for information about the @pmsg fields.)
  */
-static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-				    bool is_extended, bool may_suppress)
+bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+			     bool is_extended, bool may_suppress)
 {
-	static atomic_t panic_console_dropped =3D ATOMIC_INIT(0);
+	static int panic_console_dropped;
=20
 	struct printk_buffers *pbufs =3D pmsg->pbufs;
 	const size_t scratchbuf_sz =3D sizeof(pbufs->scratchbuf);
@@ -3135,7 +2862,7 @@ static bool printk_get_next_message(struct printk_mes=
sage *pmsg, u64 seq,
 	 */
 	if (pmsg->dropped &&
 	    panic_in_progress() &&
-	    atomic_fetch_inc_relaxed(&panic_console_dropped) > 10) {
+	    panic_console_dropped++ > 10) {
 		suppress_panic_printk =3D 1;
 		pr_warn_once("Too many dropped messages. Suppress messages on non-panic =
CPUs to prevent livelock.\n");
 	}
@@ -3171,102 +2898,64 @@ static bool printk_get_next_message(struct printk_=
message *pmsg, u64 seq,
  *
  * Requires the console_lock and the SRCU read lock.
  */
-static bool __console_emit_next_record(struct console *con, bool *handover,
-				       int cookie, bool atomic_printing)
+static bool console_emit_next_record(struct console *con, bool *handover, =
int cookie)
 {
 	static struct printk_buffers pbufs;
=20
-	bool is_extended =3D con->flags & CON_EXTENDED;
+	bool is_extended =3D console_srcu_read_flags(con) & CON_EXTENDED;
 	char *outbuf =3D &pbufs.outbuf[0];
 	struct printk_message pmsg =3D {
 		.pbufs =3D &pbufs,
 	};
 	unsigned long flags;
-	unsigned long dropped =3D 0;
-	u64 seq;
=20
-	if (handover)
-		*handover =3D false;
+	*handover =3D false;
=20
-	seq =3D read_console_seq(con);
-	if (!printk_get_next_message(&pmsg, seq, is_extended, true))
+	if (!printk_get_next_message(&pmsg, con->seq, is_extended, true))
 		return false;
=20
-	atomic_long_add((unsigned long)(pmsg.dropped), &con->dropped);
+	con->dropped +=3D pmsg.dropped;
=20
 	/* Skip messages of formatted length 0. */
 	if (pmsg.outbuf_len =3D=3D 0) {
-		write_console_seq(con, pmsg.seq + 1, atomic_printing);
+		con->seq =3D pmsg.seq + 1;
 		goto skip;
 	}
=20
-	dropped =3D atomic_long_xchg_relaxed(&con->dropped, 0);
-	if (dropped && !is_extended)
-		console_prepend_dropped(&pmsg, dropped);
-
-	if (handover) {
-		/*
-		 * While actively printing out messages, if another printk()
-		 * were to occur on another CPU, it may wait for this one to
-		 * finish. This task can not be preempted if there is a
-		 * waiter waiting to take over.
-		 *
-		 * Interrupts are disabled because the hand over to a waiter
-		 * must not be interrupted until the hand over is completed
-		 * (@console_waiter is cleared).
-		 */
-		printk_safe_enter_irqsave(flags);
-		console_lock_spinning_enable();
-
-		/* Do not trace print latency. */
-		stop_critical_timings();
+	if (con->dropped && !is_extended) {
+		console_prepend_dropped(&pmsg, con->dropped);
+		con->dropped =3D 0;
 	}
=20
+	/*
+	 * While actively printing out messages, if another printk()
+	 * were to occur on another CPU, it may wait for this one to
+	 * finish. This task can not be preempted if there is a
+	 * waiter waiting to take over.
+	 *
+	 * Interrupts are disabled because the hand over to a waiter
+	 * must not be interrupted until the hand over is completed
+	 * (@console_waiter is cleared).
+	 */
+	printk_safe_enter_irqsave(flags);
+	console_lock_spinning_enable();
+
+	/* Do not trace print latency. */
+	stop_critical_timings();
+
 	/* Write everything out to the hardware. */
-	if (atomic_printing)
-		con->write_atomic(con, outbuf, pmsg.outbuf_len);
-	else
-		con->write(con, outbuf, pmsg.outbuf_len);
+	con->write(con, outbuf, pmsg.outbuf_len);
=20
-	write_console_seq(con, pmsg.seq + 1, atomic_printing);
-	if (handover) {
-		start_critical_timings();
+	start_critical_timings();
=20
-		*handover =3D console_lock_spinning_disable_and_check(cookie);
-		printk_safe_exit_irqrestore(flags);
-	}
+	con->seq =3D pmsg.seq + 1;
+
+	*handover =3D console_lock_spinning_disable_and_check(cookie);
+	printk_safe_exit_irqrestore(flags);
 skip:
 	return true;
 }
=20
-/*
- * Print a record for a given console, but allow another printk() caller to
- * take over the console_lock and continue printing.
- *
- * Requires the console_lock, but depending on @handover after the call, t=
he
- * caller may no longer have the console_lock.
- *
- * See __console_emit_next_record() for argument and return details.
- */
-static bool console_emit_next_record_transferable(struct console *con,
-						  bool *handover, int cookie)
-{
-	/*
-	 * Handovers are only supported if threaded printers are atomically
-	 * blocked. The context taking over the console_lock may be atomic.
-	 *
-	 * PREEMPT_RT also does not support handovers because the spinning
-	 * waiter can cause large latencies.
-	 */
-	if (!console_kthreads_atomically_blocked() ||
-	    IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		*handover =3D false;
-		handover =3D NULL;
-	}
-
-	return __console_emit_next_record(con, handover, cookie, false);
-}
-
 /*
  * Print out all remaining records to all consoles.
  *
@@ -3285,8 +2974,8 @@ static bool console_emit_next_record_transferable(str=
uct console *con,
  * were flushed to all usable consoles. A returned false informs the caller
  * that everything was not flushed (either there were no usable consoles or
  * another context has taken over printing or it is a panic situation and =
this
- * is not the panic CPU or direct printing is not preferred). Regardless t=
he
- * reason, the caller should assume it is not useful to immediately try ag=
ain.
+ * is not the panic CPU). Regardless the reason, the caller should assume =
it
+ * is not useful to immediately try again.
  *
  * Requires the console_lock.
  */
@@ -3301,21 +2990,22 @@ static bool console_flush_all(bool do_cond_resched,=
 u64 *next_seq, bool *handove
 	*handover =3D false;
=20
 	do {
-		/* Let the kthread printers do the work if they can. */
-		if (!allow_direct_printing())
-			return false;
-
 		any_progress =3D false;
=20
 		cookie =3D console_srcu_read_lock();
 		for_each_console_srcu(con) {
+			short flags =3D console_srcu_read_flags(con);
 			bool progress;
=20
-			if (!console_is_usable(con, false))
+			/* console_flush_all() is only for legacy consoles. */
+			if (flags & CON_NO_BKL)
+				continue;
+
+			if (!console_is_usable(con, flags))
 				continue;
 			any_usable =3D true;
=20
-			progress =3D console_emit_next_record_transferable(con, handover, cooki=
e);
+			progress =3D console_emit_next_record(con, handover, cookie);
=20
 			/*
 			 * If a handover has occurred, the SRCU read lock
@@ -3349,81 +3039,13 @@ static bool console_flush_all(bool do_cond_resched,=
 u64 *next_seq, bool *handove
 	return false;
 }
=20
-#if defined(CONFIG_HAVE_ATOMIC_CONSOLE) && defined(CONFIG_PRINTK)
-static bool console_emit_next_record(struct console *con, bool atomic_prin=
ting);
-
-static void atomic_console_flush_all(void)
-{
-	unsigned long flags;
-	struct console *con;
-	bool any_progress;
-	int index =3D 0;
-
-	if (console_suspended)
-		return;
-
-#ifdef CONFIG_HAVE_NMI
-	if (in_nmi())
-		index =3D 1;
-#endif
-
-	printk_cpu_sync_get_irqsave(flags);
-
-	do {
-		int cookie;
-
-		any_progress =3D false;
-
-		cookie =3D console_srcu_read_lock();
-		for_each_console_srcu(con) {
-			bool progress;
-
-			if (!console_is_usable(con, true))
-				continue;
-
-			progress =3D console_emit_next_record(con, true);
-			if (!progress)
-				continue;
-			any_progress =3D true;
-
-			touch_softlockup_watchdog_sync();
-			clocksource_touch_watchdog();
-			rcu_cpu_stall_reset();
-			touch_nmi_watchdog();
-		}
-		console_srcu_read_unlock(cookie);
-	} while (any_progress);
-
-	printk_cpu_sync_put_irqrestore(flags);
-}
-#else /* CONFIG_HAVE_ATOMIC_CONSOLE && CONFIG_PRINTK */
-#define atomic_console_flush_all()
-#endif
-
-/**
- * console_unlock - unblock the console subsystem from printing
- *
- * Releases the console_lock which the caller holds to block printing of
- * the console subsystem.
- *
- * While the console_lock was held, console output may have been buffered
- * by printk().  If this is the case, console_unlock(); emits
- * the output prior to releasing the lock.
- *
- * console_unlock(); may be called from any context.
- */
-void console_unlock(void)
+static u64 console_flush_and_unlock(void)
 {
 	bool do_cond_resched;
 	bool handover;
 	bool flushed;
 	u64 next_seq;
=20
-	if (console_suspended) {
-		up_console_sem();
-		return;
-	}
-
 	/*
 	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
@@ -3460,6 +3082,39 @@ void console_unlock(void)
 		 * fails, another context is already handling the printing.
 		 */
 	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock());
+
+	return next_seq;
+}
+
+/**
+ * console_unlock - unblock the console subsystem from printing
+ *
+ * Releases the console_lock which the caller holds to block printing of
+ * the console subsystem.
+ *
+ * While the console_lock was held, console output may have been buffered
+ * by printk().  If this is the case, console_unlock(); emits
+ * the output prior to releasing the lock.
+ *
+ * console_unlock(); may be called from any context.
+ */
+void console_unlock(void)
+{
+	if (console_suspended) {
+		up_console_sem();
+		return;
+	}
+
+	/*
+	 * PREEMPT_RT relies on kthread and atomic consoles for printing.
+	 * It never attempts to print from console_unlock().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		__console_unlock();
+		return;
+	}
+
+	console_flush_and_unlock();
 }
 EXPORT_SYMBOL(console_unlock);
=20
@@ -3484,6 +3139,9 @@ void console_unblank(void)
 	struct console *c;
 	int cookie;
=20
+	if (!have_bkl_console)
+		return;
+
 	/*
 	 * Stop console printing because the unblank() callback may
 	 * assume the console is not within its write() callback.
@@ -3494,13 +3152,10 @@ void console_unblank(void)
 	if (oops_in_progress) {
 		if (down_trylock_console_sem() !=3D 0)
 			return;
-		if (!console_kthreads_atomic_tryblock()) {
-			up_console_sem();
-			return;
-		}
 	} else
 		console_lock();
=20
+	console_locked =3D 1;
 	console_may_schedule =3D 0;
=20
 	cookie =3D console_srcu_read_lock();
@@ -3524,10 +3179,30 @@ void console_unblank(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
-	if (mode =3D=3D CONSOLE_ATOMIC_FLUSH_PENDING) {
-		atomic_console_flush_all();
-		return;
+	struct console *c;
+	short flags;
+	int cookie;
+	u64 seq;
+
+	seq =3D prb_first_valid_seq(prb);
+
+	/*
+	 * Safely flush the atomic consoles before trying to flush any
+	 * BKL/legacy consoles.
+	 */
+	if (mode =3D=3D CONSOLE_REPLAY_ALL) {
+		cookie =3D console_srcu_read_lock();
+		for_each_console_srcu(c) {
+			flags =3D console_srcu_read_flags(c);
+			if (flags & CON_NO_BKL)
+				cons_force_seq(c, seq);
+		}
+		console_srcu_read_unlock(cookie);
 	}
+	cons_atomic_flush(NULL, true);
+
+	if (!have_bkl_console)
+		return;
=20
 	/*
 	 * If someone else is holding the console lock, trylock will fail
@@ -3540,12 +3215,6 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	console_may_schedule =3D 0;
=20
 	if (mode =3D=3D CONSOLE_REPLAY_ALL) {
-		struct console *c;
-		int cookie;
-		u64 seq;
-
-		seq =3D prb_first_valid_seq(prb);
-
 		cookie =3D console_srcu_read_lock();
 		for_each_console_srcu(c) {
 			/*
@@ -3553,7 +3222,7 @@ void console_flush_on_panic(enum con_flush_mode mode)
 			 * unsynchronized assignment. But in that case, the
 			 * kernel is in "hope and pray" mode anyway.
 			 */
-			write_console_seq(c, seq, false);
+			c->seq =3D seq;
 		}
 		console_srcu_read_unlock(cookie);
 	}
@@ -3614,13 +3283,118 @@ EXPORT_SYMBOL(console_stop);
=20
 void console_start(struct console *console)
 {
+	short flags;
+
 	console_list_lock();
 	console_srcu_write_flags(console, console->flags | CON_ENABLED);
+	flags =3D console->flags;
 	console_list_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. The related
+	 * printing context must be able to see it is enabled so that
+	 * it is guaranteed to wake up and resume printing.
+	 */
+	synchronize_srcu(&console_srcu);
+
+	if (flags & CON_NO_BKL)
+		cons_kthread_wake(console);
+	else if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		wake_up_interruptible(&log_wait);
+
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
=20
+static struct task_struct *console_bkl_kthread;
+
+static bool printer_should_wake(u64 seq)
+{
+	bool available =3D false;
+	struct console *con;
+	int cookie;
+
+	if (kthread_should_stop())
+		return true;
+
+	cookie =3D console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		short flags =3D console_srcu_read_flags(con);
+
+		if (flags & CON_NO_BKL)
+			continue;
+		if (!console_is_usable(con, flags))
+			continue;
+		/*
+		 * It is safe to read @seq because only this
+		 * thread context updates @seq.
+		 */
+		if (prb_read_valid(prb, con->seq, NULL)) {
+			available =3D true;
+			break;
+		}
+	}
+	console_srcu_read_unlock(cookie);
+
+	return available;
+}
+
+static int console_bkl_kthread_func(void *unused)
+{
+	u64 seq =3D 0;
+	int error;
+
+	for (;;) {
+		error =3D wait_event_interruptible(log_wait, printer_should_wake(seq));
+
+		if (kthread_should_stop())
+			break;
+
+		if (error)
+			continue;
+
+		console_lock();
+		if (console_suspended)
+			up_console_sem();
+		else
+			seq =3D console_flush_and_unlock();
+	}
+	return 0;
+}
+
+void console_bkl_kthread_create(void)
+{
+	struct task_struct *kt;
+	struct console *c;
+
+	lockdep_assert_held(&console_mutex);
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		return;
+
+	if (!printk_threads_enabled || console_bkl_kthread)
+		return;
+
+	for_each_console(c) {
+		if (c->flags & CON_BOOT)
+			return;
+	}
+
+	kt =3D kthread_run(console_bkl_kthread_func, NULL, "pr/bkl");
+	if (IS_ERR(kt)) {
+		pr_err("unable to start BKL printing thread\n");
+		return;
+	}
+
+	console_bkl_kthread =3D kt;
+
+	/*
+	 * It is important that console printing threads are scheduled
+	 * shortly after a printk call and with generous runtime budgets.
+	 */
+	sched_set_normal(console_bkl_kthread, -20);
+}
+
 static int __read_mostly keep_bootcon;
=20
 static int __init keep_bootcon_setup(char *str)
@@ -3704,11 +3478,6 @@ static void try_enable_default_console(struct consol=
e *newcon)
 		newcon->flags |=3D CON_CONSDEV;
 }
=20
-#define con_printk(lvl, con, fmt, ...)			\
-	printk(lvl pr_fmt("%sconsole [%s%d] " fmt),	\
-	       (con->flags & CON_BOOT) ? "boot" : "",	\
-	       con->name, con->index, ##__VA_ARGS__)
-
 static void console_init_seq(struct console *newcon, bool bootcon_register=
ed)
 {
 	struct console *con;
@@ -3717,11 +3486,11 @@ static void console_init_seq(struct console *newcon=
, bool bootcon_registered)
 	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
-		write_console_seq(newcon, syslog_seq, false);
+		newcon->seq =3D syslog_seq;
 		mutex_unlock(&syslog_lock);
 	} else {
 		/* Begin with next message added to ringbuffer. */
-		write_console_seq(newcon, prb_next_seq(prb), false);
+		newcon->seq =3D prb_next_seq(prb);
=20
 		/*
 		 * If any enabled boot consoles are due to be unregistered
@@ -3773,8 +3542,6 @@ static void console_init_seq(struct console *newcon, =
bool bootcon_registered)
 #define console_first()				\
 	hlist_entry(console_list.first, struct console, node)
=20
-static int unregister_console_locked(struct console *console);
-
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -3863,16 +3630,19 @@ void register_console(struct console *newcon)
 		newcon->flags &=3D ~CON_PRINTBUFFER;
 	}
=20
-	atomic_long_set(&newcon->dropped, 0);
-	newcon->thread =3D NULL;
-	newcon->blocked =3D true;
-	mutex_init(&newcon->lock);
-#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
-	newcon->atomic_data =3D NULL;
-#endif
-
+	newcon->dropped =3D 0;
 	console_init_seq(newcon, bootcon_registered);
=20
+	if (!(newcon->flags & CON_NO_BKL)) {
+		have_bkl_console =3D true;
+		console_bkl_kthread_create();
+	} else if (!cons_nobkl_init(newcon)) {
+		goto unlock;
+	}
+
+	if (newcon->flags & CON_BOOT)
+		have_boot_console =3D true;
+
 	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
@@ -3891,9 +3661,6 @@ void register_console(struct console *newcon)
 		hlist_add_behind_rcu(&newcon->node, console_list.first);
 	}
=20
-	if (printk_kthreads_available)
-		printk_start_kthread(newcon);
-
 	/*
 	 * No need to synchronize SRCU here! The caller does not rely
 	 * on all contexts being able to see the new console before
@@ -3919,6 +3686,9 @@ void register_console(struct console *newcon)
 			if (con->flags & CON_BOOT)
 				unregister_console_locked(con);
 		}
+
+		/* All boot consoles have been unregistered. */
+		have_boot_console =3D false;
 	}
 unlock:
 	console_list_unlock();
@@ -3928,12 +3698,13 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
-	struct task_struct *thd;
+	struct console *c;
+	bool is_boot_con;
 	int res;
=20
 	lockdep_assert_console_list_lock_held();
=20
-	con_printk(KERN_INFO, console, "disabled\n");
+	is_boot_con =3D console->flags & CON_BOOT;
=20
 	res =3D _braille_unregister_console(console);
 	if (res < 0)
@@ -3941,21 +3712,14 @@ static int unregister_console_locked(struct console=
 *console)
 	if (res > 0)
 		return 0;
=20
-	/* Disable it unconditionally */
-	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
-
 	if (!console_is_registered_locked(console))
 		return -ENODEV;
=20
-	hlist_del_init_rcu(&console->node);
+	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
=20
-	/*
-	 * console->thread can only be cleared under the console lock. But
-	 * stopping the thread must be done without the console lock. The
-	 * task that clears @thread is the task that stops the kthread.
-	 */
-	thd =3D console->thread;
-	console->thread =3D NULL;
+	con_printk(KERN_INFO, console, "disabled\n");
+
+	hlist_del_init_rcu(&console->node);
=20
 	/*
 	 * <HISTORICAL>
@@ -3976,18 +3740,23 @@ static int unregister_console_locked(struct console=
 *console)
 	 */
 	synchronize_srcu(&console_srcu);
=20
+	if (console->flags & CON_NO_BKL)
+		cons_nobkl_cleanup(console);
+
 	console_sysfs_notify();
=20
-	if (thd)
-		kthread_stop(thd);
-
-#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
-	free_atomic_data(console->atomic_data);
-#endif
-
 	if (console->exit)
 		res =3D console->exit(console);
=20
+	/*
+	 * Each time a boot console unregisters, try to start up the printing
+	 * threads. They will only start if this was the last boot console.
+	 */
+	if (is_boot_con) {
+		for_each_console(c)
+			cons_kthread_create(c);
+	}
+
 	return res;
 }
=20
@@ -4128,22 +3897,6 @@ static int __init printk_late_init(void)
 }
 late_initcall(printk_late_init);
=20
-static int __init printk_activate_kthreads(void)
-{
-	struct console *con;
-	int cookie;
-
-	printk_kthreads_available =3D true;
-
-	cookie =3D console_srcu_read_lock();
-	for_each_console_srcu(con)
-		printk_start_kthread(con);
-	console_srcu_read_unlock(cookie);
-
-	return 0;
-}
-early_initcall(printk_activate_kthreads);
-
 #if defined CONFIG_PRINTK
 /* If @con is specified, only wait for that console. Otherwise wait for al=
l. */
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_=
progress)
@@ -4165,31 +3918,36 @@ static bool __pr_flush(struct console *con, int tim=
eout_ms, bool reset_on_progre
=20
 		/*
 		 * Hold the console_lock to guarantee safe access to
-		 * console->seq and to prevent changes to @console_suspended
-		 * until all consoles have been processed.
+		 * console->seq.
 		 */
 		console_lock();
=20
 		cookie =3D console_srcu_read_lock();
 		for_each_console_srcu(c) {
+			short flags;
+
 			if (con && con !=3D c)
 				continue;
-			if (!console_is_usable(c, false))
+
+			flags =3D console_srcu_read_flags(c);
+
+			if (!console_is_usable(c, flags))
 				continue;
+
+			/*
+			 * Since the console is locked, use this opportunity
+			 * to update console->seq for NOBKL consoles.
+			 */
+			if (flags & CON_NO_BKL)
+				c->seq =3D cons_read_seq(c);
+
 			printk_seq =3D c->seq;
 			if (printk_seq < seq)
 				diff +=3D seq - printk_seq;
 		}
 		console_srcu_read_unlock(cookie);
=20
-		/*
-		 * If consoles are suspended, it cannot be expected that they
-		 * make forward progress, so timeout immediately. @diff is
-		 * still used to return a valid flush status.
-		 */
-		if (console_suspended)
-			remaining =3D 0;
-		else if (diff !=3D last_diff && reset_on_progress)
+		if (diff !=3D last_diff && reset_on_progress)
 			remaining =3D timeout_ms;
=20
 		console_unlock();
@@ -4234,156 +3992,11 @@ static bool pr_flush(int timeout_ms, bool reset_on=
_progress)
 	return __pr_flush(NULL, timeout_ms, reset_on_progress);
 }
=20
-static void __printk_fallback_preferred_direct(void)
-{
-	printk_prefer_direct_enter();
-	pr_err("falling back to preferred direct printing\n");
-	printk_kthreads_available =3D false;
-}
-
-/*
- * Print a record for a given console, not allowing another printk() caller
- * to take over. This is appropriate for contexts that do not have the
- * console_lock.
- *
- * See __console_emit_next_record() for argument and return details.
- */
-static bool console_emit_next_record(struct console *con, bool atomic_prin=
ting)
-{
-	return __console_emit_next_record(con, NULL, 0, atomic_printing);
-}
-
-static bool printer_should_wake(struct console *con, u64 seq)
-{
-	if (kthread_should_stop() || !printk_kthreads_available)
-		return true;
-
-	if (con->blocked ||
-	    console_kthreads_atomically_blocked() ||
-	    block_console_kthreads ||
-	    system_state > SYSTEM_RUNNING ||
-	    oops_in_progress) {
-		return false;
-	}
-
-	if (!console_is_usable_unlocked(con))
-		return false;
-
-	return prb_read_valid(prb, seq, NULL);
-}
-
-static int printk_kthread_func(void *data)
-{
-	struct console *con =3D data;
-	u64 seq =3D 0;
-	int error;
-
-#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
-	if (con->write_atomic)
-		con->atomic_data =3D alloc_atomic_data(con->flags);
-#endif
-
-	con_printk(KERN_INFO, con, "printing thread started\n");
-	for (;;) {
-		/*
-		 * Guarantee this task is visible on the waitqueue before
-		 * checking the wake condition.
-		 *
-		 * The full memory barrier within set_current_state() of
-		 * prepare_to_wait_event() pairs with the full memory barrier
-		 * within wq_has_sleeper().
-		 *
-		 * This pairs with __wake_up_klogd:A.
-		 */
-		error =3D wait_event_interruptible(log_wait,
-						 printer_should_wake(con, seq)); /* LMM(printk_kthread_func:A) */
-
-		if (kthread_should_stop() || !printk_kthreads_available)
-			break;
-
-		if (error)
-			continue;
-
-		error =3D mutex_lock_interruptible(&con->lock);
-		if (error)
-			continue;
-
-		if (con->blocked ||
-		    !console_kthread_printing_tryenter()) {
-			/* Another context has locked the console_lock. */
-			mutex_unlock(&con->lock);
-			continue;
-		}
-
-		/*
-		 * Although this context has not locked the console_lock, it
-		 * is known that the console_lock is not locked and it is not
-		 * possible for any other context to lock the console_lock.
-		 * Therefore it is safe to read con->flags.
-		 */
-
-		if (!console_is_usable_unlocked(con)) {
-			console_kthread_printing_exit();
-			mutex_unlock(&con->lock);
-			continue;
-		}
-
-		/*
-		 * Even though the printk kthread is always preemptible, it is
-		 * still not allowed to call cond_resched() from within
-		 * console drivers. The task may become non-preemptible in the
-		 * console driver call chain. For example, vt_console_print()
-		 * takes a spinlock and then can call into fbcon_redraw(),
-		 * which can conditionally invoke cond_resched().
-		 */
-		console_may_schedule =3D 0;
-		console_emit_next_record(con, false);
-
-		seq =3D con->seq;
-
-		console_kthread_printing_exit();
-
-		mutex_unlock(&con->lock);
-	}
-
-	con_printk(KERN_INFO, con, "printing thread stopped\n");
-	console_lock();
-	/*
-	 * If this kthread is being stopped by another task, con->thread will
-	 * already be NULL. That is fine. The important thing is that it is
-	 * NULL after the kthread exits.
-	 */
-	con->thread =3D NULL;
-	console_unlock();
-
-	return 0;
-}
-
-/* Must be called under console_lock. */
-static void printk_start_kthread(struct console *con)
-{
-	/*
-	 * Do not start a kthread if there is no write() callback. The
-	 * kthreads assume the write() callback exists.
-	 */
-	if (!con->write)
-		return;
-
-	con->thread =3D kthread_run(printk_kthread_func, con,
-				  "pr/%s%d", con->name, con->index);
-	if (IS_ERR(con->thread)) {
-		con->thread =3D NULL;
-		con_printk(KERN_ERR, con, "unable to start printing thread\n");
-		__printk_fallback_preferred_direct();
-		return;
-	}
-}
-
 /*
  * Delayed printk version, for scheduler-internal messages:
  */
-#define PRINTK_PENDING_WAKEUP		0x01
-#define PRINTK_PENDING_DIRECT_OUTPUT	0x02
+#define PRINTK_PENDING_WAKEUP	0x01
+#define PRINTK_PENDING_OUTPUT	0x02
=20
 static DEFINE_PER_CPU(int, printk_pending);
=20
@@ -4391,14 +4004,18 @@ static void wake_up_klogd_work_func(struct irq_work=
 *irq_work)
 {
 	int pending =3D this_cpu_xchg(printk_pending, 0);
=20
-	if (pending & PRINTK_PENDING_DIRECT_OUTPUT) {
-		printk_prefer_direct_enter();
-
-		/* If trylock fails, someone else is doing the printing */
-		if (console_trylock())
-			console_unlock();
-
-		printk_prefer_direct_exit();
+	if (pending & PRINTK_PENDING_OUTPUT) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			/* The BKL thread waits on @log_wait. */
+			pending |=3D PRINTK_PENDING_WAKEUP;
+		} else {
+			/*
+			 * If trylock fails, some other context
+			 * will do the printing.
+			 */
+			if (console_trylock())
+				console_unlock();
+		}
 	}
=20
 	if (pending & PRINTK_PENDING_WAKEUP)
@@ -4423,54 +4040,68 @@ static void __wake_up_klogd(int val)
 	 * prepare_to_wait_event(), which is called after ___wait_event() adds
 	 * the waiter but before it has checked the wait condition.
 	 *
-	 * This pairs with devkmsg_read:A, syslog_print:A, and
-	 * printk_kthread_func:A.
+	 * This pairs with devkmsg_read:A and syslog_print:A.
 	 */
 	if (wq_has_sleeper(&log_wait) || /* LMM(__wake_up_klogd:A) */
-	    (val & PRINTK_PENDING_DIRECT_OUTPUT)) {
+	    (val & PRINTK_PENDING_OUTPUT)) {
 		this_cpu_or(printk_pending, val);
 		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	}
 	preempt_enable();
 }
=20
+/**
+ * wake_up_klogd - Wake kernel logging daemon
+ *
+ * Use this function when new records have been added to the ringbuffer
+ * and the console printing for those records is handled elsewhere. In
+ * this case only the logging daemon needs to be woken.
+ *
+ * Context: Any context.
+ */
 void wake_up_klogd(void)
 {
 	__wake_up_klogd(PRINTK_PENDING_WAKEUP);
 }
=20
+/**
+ * defer_console_output - Wake kernel logging daemon and trigger
+ *	console printing in a deferred context
+ *
+ * Use this function when new records have been added to the ringbuffer
+ * but the current context is unable to perform the console printing.
+ * This function also wakes the logging daemon.
+ *
+ * Context: Any context.
+ */
 void defer_console_output(void)
 {
+	int val =3D PRINTK_PENDING_WAKEUP;
+
 	/*
 	 * New messages may have been added directly to the ringbuffer
 	 * using vprintk_store(), so wake any waiters as well.
 	 */
-	int val =3D PRINTK_PENDING_WAKEUP;
-
-	/*
-	 * Make sure that some context will print the messages when direct
-	 * printing is allowed. This happens in situations when the kthreads
-	 * may not be as reliable or perhaps unusable.
-	 */
-	if (allow_direct_printing())
-		val |=3D PRINTK_PENDING_DIRECT_OUTPUT;
-
+	if (have_bkl_console)
+		val |=3D PRINTK_PENDING_OUTPUT;
 	__wake_up_klogd(val);
 }
=20
 void printk_trigger_flush(void)
 {
+	struct cons_write_context wctxt =3D { };
+
+	preempt_disable();
+	cons_atomic_flush(&wctxt, true);
+	preempt_enable();
+
+	cons_wake_threads();
 	defer_console_output();
 }
=20
 int vprintk_deferred(const char *fmt, va_list args)
 {
-	int r;
-
-	r =3D vprintk_emit(0, LOGLEVEL_SCHED, NULL, fmt, args);
-	defer_console_output();
-
-	return r;
+	return vprintk_emit(0, LOGLEVEL_SCHED, NULL, fmt, args);
 }
=20
 int _printk_deferred(const char *fmt, ...)
diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
new file mode 100644
index 0000000000000..e0b818a4f8b38
--- /dev/null
+++ b/kernel/printk/printk_nobkl.c
@@ -0,0 +1,1825 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH, John Ogness
+// Copyright (C) 2022 Intel, Thomas Gleixner
+
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
+#include <linux/syscore_ops.h>
+#include "printk_ringbuffer.h"
+#include "internal.h"
+/*
+ * Printk implementation for consoles that do not depend on the BKL style
+ * console_lock mechanism.
+ *
+ * Console is locked on a CPU when state::locked is set and state:cpu =3D=
=3D
+ * current CPU. This is valid for the current execution context.
+ *
+ * Nesting execution contexts on the same CPU can carefully take over
+ * if the driver allows reentrancy via state::unsafe =3D false. When the
+ * interrupted context resumes it checks the state before entering
+ * an unsafe region and aborts the operation if it detects a takeover.
+ *
+ * In case of panic or emergency the nesting context can take over the
+ * console forcefully. The write callback is then invoked with the unsafe
+ * flag set in the write context data, which allows the driver side to avo=
id
+ * locks and to evaluate the driver state so it can use an emergency path
+ * or repair the state instead of blindly assuming that it works.
+ *
+ * If the interrupted context touches the assigned record buffer after
+ * takeover, it does not cause harm because at the same execution level
+ * there is no concurrency on the same CPU. A threaded printer always has
+ * its own record buffer so it can never interfere with any of the per CPU
+ * record buffers.
+ *
+ * A concurrent writer on a different CPU can request to take over the
+ * console by:
+ *
+ *	1) Carefully writing the desired state into state[REQ]
+ *	   if there is no same or higher priority request pending.
+ *	   This locks state[REQ] except for higher priority
+ *	   waiters.
+ *
+ *	2) Setting state[CUR].req_prio unless a same or higher
+ *	   priority waiter won the race.
+ *
+ *	3) Carefully spin on state[CUR] until that is locked with the
+ *	   expected state. When the state is not the expected one then it
+ *	   has to verify that state[REQ] is still the same and that
+ *	   state[CUR] has not been taken over or unlocked.
+ *
+ *      The unlocker hands over to state[REQ], but only if state[CUR]
+ *	matches.
+ *
+ * In case that the owner does not react on the request and does not make
+ * observable progress, the waiter will timeout and can then decide to do
+ * a hostile takeover.
+ */
+
+#define copy_full_state(_dst, _src)	do { _dst =3D _src; } while (0)
+#define copy_bit_state(_dst, _src)	do { _dst.bits =3D _src.bits; } while (=
0)
+
+#ifdef CONFIG_64BIT
+#define copy_seq_state64(_dst, _src)	do { _dst.seq =3D _src.seq; } while (=
0)
+#else
+#define copy_seq_state64(_dst, _src)	do { } while (0)
+#endif
+
+enum state_selector {
+	CON_STATE_CUR,
+	CON_STATE_REQ,
+};
+
+/**
+ * cons_state_set - Helper function to set the console state
+ * @con:	Console to update
+ * @which:	Selects real state or handover state
+ * @new:	The new state to write
+ *
+ * Only to be used when the console is not yet or no longer visible in the
+ * system. Otherwise use cons_state_try_cmpxchg().
+ */
+static inline void cons_state_set(struct console *con, enum state_selector=
 which,
+				  struct cons_state *new)
+{
+	atomic_long_set(&ACCESS_PRIVATE(con, atomic_state[which]), new->atom);
+}
+
+/**
+ * cons_state_read - Helper function to read the console state
+ * @con:	Console to update
+ * @which:	Selects real state or handover state
+ * @state:	The state to store the result
+ */
+static inline void cons_state_read(struct console *con, enum state_selecto=
r which,
+				   struct cons_state *state)
+{
+	state->atom =3D atomic_long_read(&ACCESS_PRIVATE(con, atomic_state[which]=
));
+}
+
+/**
+ * cons_state_try_cmpxchg() - Helper function for atomic_long_try_cmpxchg(=
) on console state
+ * @con:	Console to update
+ * @which:	Selects real state or handover state
+ * @old:	Old/expected state
+ * @new:	New state
+ *
+ * Returns: True on success, false on fail
+ */
+static inline bool cons_state_try_cmpxchg(struct console *con,
+					  enum state_selector which,
+					  struct cons_state *old,
+					  struct cons_state *new)
+{
+	return atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, atomic_state[which]),
+				       &old->atom, new->atom);
+}
+
+/**
+ * cons_state_full_match - Check whether the full state matches
+ * @cur:	The state to check
+ * @prev:	The previous state
+ *
+ * Returns: True if matching, false otherwise.
+ *
+ * Check the full state including state::seq on 64bit. For take over
+ * detection.
+ */
+static inline bool cons_state_full_match(struct cons_state cur,
+					 struct cons_state prev)
+{
+	/*
+	 * req_prio can be set by a concurrent writer for friendly
+	 * handover. Ignore it in the comparison.
+	 */
+	cur.req_prio =3D prev.req_prio;
+	return cur.atom =3D=3D prev.atom;
+}
+
+/**
+ * cons_state_bits_match - Check for matching state bits
+ * @cur:	The state to check
+ * @prev:	The previous state
+ *
+ * Returns: True if state matches, false otherwise.
+ *
+ * Contrary to cons_state_full_match this checks only the bits and ignores
+ * a sequence change on 64bits. On 32bit the two functions are identical.
+ */
+static inline bool cons_state_bits_match(struct cons_state cur, struct con=
s_state prev)
+{
+	/*
+	 * req_prio can be set by a concurrent writer for friendly
+	 * handover. Ignore it in the comparison.
+	 */
+	cur.req_prio =3D prev.req_prio;
+	return cur.bits =3D=3D prev.bits;
+}
+
+/**
+ * cons_check_panic - Check whether a remote CPU is in panic
+ *
+ * Returns: True if a remote CPU is in panic, false otherwise.
+ */
+static inline bool cons_check_panic(void)
+{
+	unsigned int pcpu =3D atomic_read(&panic_cpu);
+
+	return pcpu !=3D PANIC_CPU_INVALID && pcpu !=3D smp_processor_id();
+}
+
+static struct cons_context_data early_cons_ctxt_data __initdata;
+
+/**
+ * cons_context_set_pbufs - Set the output text buffer for the current con=
text
+ * @ctxt:	Pointer to the acquire context
+ *
+ * Buffer selection:
+ *   1) Early boot uses the global (initdata) buffer
+ *   2) Printer threads use the dynamically allocated per-console buffers
+ *   3) All other contexts use the per CPU buffers
+ *
+ * This guarantees that there is no concurrency on the output records ever.
+ * Early boot and per CPU nesting is not a problem. The takeover logic
+ * tells the interrupted context that the buffer has been overwritten.
+ *
+ * There are two critical regions that matter:
+ *
+ * 1) Context is filling the buffer with a record. After interruption
+ *    it continues to sprintf() the record and before it goes to
+ *    write it out, it checks the state, notices the takeover, discards
+ *    the content and backs out.
+ *
+ * 2) Context is in a unsafe critical region in the driver. After
+ *    interruption it might read overwritten data from the output
+ *    buffer. When it leaves the critical region it notices and backs
+ *    out. Hostile takeovers in driver critical regions are best effort
+ *    and there is not much that can be done about that.
+ */
+static __ref void cons_context_set_pbufs(struct cons_context *ctxt)
+{
+	struct console *con =3D ctxt->console;
+
+	/* Thread context or early boot? */
+	if (ctxt->thread)
+		ctxt->pbufs =3D con->thread_pbufs;
+	else if (!con->pcpu_data)
+		ctxt->pbufs =3D &early_cons_ctxt_data.pbufs;
+	else
+		ctxt->pbufs =3D &(this_cpu_ptr(con->pcpu_data)->pbufs);
+}
+
+/**
+ * cons_seq_init - Helper function to initialize the console sequence
+ * @con:	Console to work on
+ *
+ * Set @con->atomic_seq to the starting record, or if that record no
+ * longer exists, the oldest available record. For init only. Do not
+ * use for runtime updates.
+ */
+static void cons_seq_init(struct console *con)
+{
+	u32 seq =3D (u32)max_t(u64, con->seq, prb_first_valid_seq(prb));
+#ifdef CONFIG_64BIT
+	struct cons_state state;
+
+	cons_state_read(con, CON_STATE_CUR, &state);
+	state.seq =3D seq;
+	cons_state_set(con, CON_STATE_CUR, &state);
+#else
+	atomic_set(&ACCESS_PRIVATE(con, atomic_seq), seq);
+#endif
+}
+
+/**
+ * cons_force_seq - Force a specified sequence number for a console
+ * @con:	Console to work on
+ * @seq:	Sequence number to force
+ *
+ * This function is only intended to be used in emergency situations. In
+ * particular: console_flush_on_panic(CONSOLE_REPLAY_ALL)
+ */
+void cons_force_seq(struct console *con, u64 seq)
+{
+#ifdef CONFIG_64BIT
+	struct cons_state old;
+	struct cons_state new;
+
+	do {
+		cons_state_read(con, CON_STATE_CUR, &old);
+		copy_bit_state(new, old);
+		new.seq =3D seq;
+	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new));
+#else
+	atomic_set(&ACCESS_PRIVATE(con, atomic_seq), seq);
+#endif
+}
+
+static inline u64 cons_expand_seq(u64 seq)
+{
+	u64 rbseq;
+
+	/*
+	 * The provided sequence is only the lower 32bits of the ringbuffer
+	 * sequence. It needs to be expanded to 64bit. Get the next sequence
+	 * number from the ringbuffer and fold it.
+	 */
+	rbseq =3D prb_next_seq(prb);
+	seq =3D rbseq - ((u32)rbseq - (u32)seq);
+
+	return seq;
+}
+
+/**
+ * cons_read_seq - Read the current console sequence
+ * @con:	Console to read the sequence of
+ *
+ * Returns:	Sequence number of the next record to print on @con.
+ */
+u64 cons_read_seq(struct console *con)
+{
+	u64 seq;
+#ifdef CONFIG_64BIT
+	struct cons_state state;
+
+	cons_state_read(con, CON_STATE_CUR, &state);
+	seq =3D state.seq;
+#else
+	seq =3D atomic_read(&ACCESS_PRIVATE(con, atomic_seq));
+#endif
+	return cons_expand_seq(seq);
+}
+
+/**
+ * cons_context_set_seq - Setup the context with the next sequence to print
+ * @ctxt:	Pointer to an acquire context that contains
+ *		all information about the acquire mode
+ *
+ * On return the retrieved sequence number is stored in ctxt->oldseq.
+ *
+ * The sequence number is safe in forceful takeover situations.
+ *
+ * Either the writer succeeded to update before it got interrupted
+ * or it failed. In the latter case the takeover will print the
+ * same line again.
+ *
+ * The sequence is only the lower 32bits of the ringbuffer sequence. The
+ * ringbuffer must be 2^31 records ahead to get out of sync. This needs
+ * some care when starting a console, i.e setting the sequence to 0 is
+ * wrong. It has to be set to the oldest valid sequence in the ringbuffer
+ * as that cannot be more than 2^31 records away
+ *
+ * On 64bit the 32bit sequence is part of console::state, which is saved
+ * in @ctxt->state. This prevents the 32bit update race.
+ */
+static void cons_context_set_seq(struct cons_context *ctxt)
+{
+#ifdef CONFIG_64BIT
+	ctxt->oldseq =3D ctxt->state.seq;
+#else
+	ctxt->oldseq =3D atomic_read(&ACCESS_PRIVATE(ctxt->console, atomic_seq));
+#endif
+	ctxt->oldseq =3D cons_expand_seq(ctxt->oldseq);
+	ctxt->newseq =3D ctxt->oldseq;
+}
+
+/**
+ * cons_seq_try_update - Try to update the console sequence number
+ * @ctxt:	Pointer to an acquire context that contains
+ *		all information about the acquire mode
+ *
+ * Returns:	True if the console sequence was updated, false otherwise.
+ *
+ * Internal helper as the logic is different on 32bit and 64bit.
+ *
+ * On 32 bit the sequence is separate from state and therefore
+ * subject to a subtle race in the case of hostile takeovers.
+ *
+ * On 64 bit the sequence is part of the state and therefore safe
+ * vs. hostile takeovers.
+ *
+ * In case of fail the console has been taken over and @ctxt is
+ * invalid. Caller has to reacquire the console.
+ */
+#ifdef CONFIG_64BIT
+static bool cons_seq_try_update(struct cons_context *ctxt)
+{
+	struct console *con =3D ctxt->console;
+	struct cons_state old;
+	struct cons_state new;
+
+	cons_state_read(con, CON_STATE_CUR, &old);
+	do {
+		/* Make sure this context is still the owner. */
+		if (!cons_state_bits_match(old, ctxt->state))
+			return false;
+
+		/* Preserve bit state */
+		copy_bit_state(new, old);
+		new.seq =3D ctxt->newseq;
+
+		/*
+		 * Can race with hostile takeover or with a handover
+		 * request.
+		 */
+	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new));
+
+	copy_full_state(ctxt->state, new);
+	ctxt->oldseq =3D ctxt->newseq;
+
+	return true;
+}
+#else
+static bool cons_release(struct cons_context *ctxt);
+static bool cons_seq_try_update(struct cons_context *ctxt)
+{
+	struct console *con =3D ctxt->console;
+	struct cons_state state;
+	int pcpu;
+	u32 old;
+	u32 new;
+
+	/*
+	 * There is a corner case that needs to be considered here:
+	 *
+	 * CPU0			CPU1
+	 * printk()
+	 *  acquire()		-> emergency
+	 *  write()		   acquire()
+	 *  update_seq()
+	 *    state =3D=3D OK
+	 * --> NMI
+	 *			   takeover()
+	 * <---			     write()
+	 *  cmpxchg() succeeds	     update_seq()
+	 *			     cmpxchg() fails
+	 *
+	 * There is nothing that can be done about this other than having
+	 * yet another state bit that needs to be tracked and analyzed,
+	 * but fails to cover the problem completely.
+	 *
+	 * No other scenarios expose such a problem. On same CPU takeovers
+	 * the cmpxchg() always fails on the interrupted context after the
+	 * interrupting context finished printing, but that's fine as it
+	 * does not own the console anymore. The state check after the
+	 * failed cmpxchg prevents that.
+	 */
+	cons_state_read(con, CON_STATE_CUR, &state);
+	/* Make sure this context is still the owner. */
+	if (!cons_state_bits_match(state, ctxt->state))
+		return false;
+
+	/*
+	 * Get the original sequence number that was retrieved
+	 * from @con->atomic_seq. @con->atomic_seq should be still
+	 * the same. 32bit truncates. See cons_context_set_seq().
+	 */
+	old =3D (u32)ctxt->oldseq;
+	new =3D (u32)ctxt->newseq;
+	if (atomic_try_cmpxchg(&ACCESS_PRIVATE(con, atomic_seq), &old, new)) {
+		ctxt->oldseq =3D ctxt->newseq;
+		return true;
+	}
+
+	/*
+	 * Reread the state. If this context does not own the console anymore
+	 * then it cannot touch the sequence again.
+	 */
+	cons_state_read(con, CON_STATE_CUR, &state);
+	if (!cons_state_bits_match(state, ctxt->state))
+		return false;
+
+	pcpu =3D atomic_read(&panic_cpu);
+	if (pcpu =3D=3D smp_processor_id()) {
+		/*
+		 * This is the panic CPU. Emitting a warning here does not
+		 * help at all. The callchain is clear and the priority is
+		 * to get the messages out. In the worst case duplicated
+		 * ones. That's a job for postprocessing.
+		 */
+		atomic_set(&ACCESS_PRIVATE(con, atomic_seq), new);
+		ctxt->oldseq =3D ctxt->newseq;
+		return true;
+	}
+
+	/*
+	 * Only emit a warning when this happens outside of a panic
+	 * situation as on panic it's neither useful nor helping to let the
+	 * panic CPU get the important stuff out.
+	 */
+	WARN_ON_ONCE(pcpu =3D=3D PANIC_CPU_INVALID);
+
+	cons_release(ctxt);
+	return false;
+}
+#endif
+
+/**
+ * cons_cleanup_handover - Cleanup a handover request
+ * @ctxt:	Pointer to acquire context
+ *
+ * @ctxt->hov_state contains the state to clean up
+ */
+static void cons_cleanup_handover(struct cons_context *ctxt)
+{
+	struct console *con =3D ctxt->console;
+	struct cons_state new;
+
+	/*
+	 * No loop required. Either hov_state is still the same or
+	 * not.
+	 */
+	new.atom =3D 0;
+	cons_state_try_cmpxchg(con, CON_STATE_REQ, &ctxt->hov_state, &new);
+}
+
+/**
+ * cons_setup_handover - Setup a handover request
+ * @ctxt:	Pointer to acquire context
+ *
+ * Returns: True if a handover request was setup, false otherwise.
+ *
+ * On success @ctxt->hov_state contains the requested handover state
+ *
+ * On failure this context is not allowed to request a handover from the
+ * current owner. Reasons would be priority too low or a remote CPU in pan=
ic.
+ * In both cases this context should give up trying to acquire the console.
+ */
+static bool cons_setup_handover(struct cons_context *ctxt)
+{
+	unsigned int cpu =3D smp_processor_id();
+	struct console *con =3D ctxt->console;
+	struct cons_state old;
+	struct cons_state hstate =3D {
+		.locked		=3D 1,
+		.cur_prio	=3D ctxt->prio,
+		.cpu		=3D cpu,
+	};
+
+	/*
+	 * Try to store hstate in @con->atomic_state[REQ]. This might
+	 * race with a higher priority waiter.
+	 */
+	cons_state_read(con, CON_STATE_REQ, &old);
+	do {
+		if (cons_check_panic())
+			return false;
+
+		/* Same or higher priority waiter exists? */
+		if (old.cur_prio >=3D ctxt->prio)
+			return false;
+
+	} while (!cons_state_try_cmpxchg(con, CON_STATE_REQ, &old, &hstate));
+
+	/* Save that state for comparison in spinwait */
+	copy_full_state(ctxt->hov_state, hstate);
+	return true;
+}
+
+/**
+ * cons_setup_request - Setup a handover request in state[CUR]
+ * @ctxt:	Pointer to acquire context
+ * @old:	The state that was used to make the decision to spin wait
+ *
+ * Returns: True if a handover request was setup in state[CUR], false
+ * otherwise.
+ *
+ * On success @ctxt->req_state contains the request state that was set in
+ * state[CUR]
+ *
+ * On failure this context encountered unexpected state values. This
+ * context should retry the full handover request setup process (the
+ * handover request setup by cons_setup_handover() is now invalidated
+ * and must be performed again).
+ */
+static bool cons_setup_request(struct cons_context *ctxt, struct cons_stat=
e old)
+{
+	struct console *con =3D ctxt->console;
+	struct cons_state cur;
+	struct cons_state new;
+
+	/* Now set the request in state[CUR] */
+	cons_state_read(con, CON_STATE_CUR, &cur);
+	do {
+		if (cons_check_panic())
+			goto cleanup;
+
+		/* Bit state changed vs. the decision to spinwait? */
+		if (!cons_state_bits_match(cur, old))
+			goto cleanup;
+
+		/*
+		 * A higher or equal priority context already setup a
+		 * request?
+		 */
+		if (cur.req_prio >=3D ctxt->prio)
+			goto cleanup;
+
+		/* Setup a request for handover. */
+		copy_full_state(new, cur);
+		new.req_prio =3D ctxt->prio;
+	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &cur, &new));
+
+	/* Save that state for comparison in spinwait */
+	copy_bit_state(ctxt->req_state, new);
+	return true;
+
+cleanup:
+	cons_cleanup_handover(ctxt);
+	return false;
+}
+
+/**
+ * cons_try_acquire_spin - Complete the spinwait attempt
+ * @ctxt:	Pointer to an acquire context that contains
+ *		all information about the acquire mode
+ *
+ * @ctxt->hov_state contains the handover state that was set in
+ * state[REQ]
+ * @ctxt->req_state contains the request state that was set in
+ * state[CUR]
+ *
+ * Returns: 0 if successfully locked. -EBUSY on timeout. -EAGAIN on
+ * unexpected state values.
+ *
+ * On success @ctxt->state contains the new state that was set in
+ * state[CUR]
+ *
+ * On -EBUSY failure this context timed out. This context should either
+ * give up or attempt a hostile takeover.
+ *
+ * On -EAGAIN failure this context encountered unexpected state values.
+ * This context should retry the full handover request setup process (the
+ * handover request setup by cons_setup_handover() is now invalidated and
+ * must be performed again).
+ */
+static int cons_try_acquire_spin(struct cons_context *ctxt)
+{
+	struct console *con =3D ctxt->console;
+	struct cons_state cur;
+	struct cons_state new;
+	int err =3D -EAGAIN;
+	int timeout;
+
+	/* Now wait for the other side to hand over */
+	for (timeout =3D ctxt->spinwait_max_us; timeout >=3D 0; timeout--) {
+		/* Timeout immediately if a remote panic is detected. */
+		if (cons_check_panic())
+			break;
+
+		cons_state_read(con, CON_STATE_CUR, &cur);
+
+		/*
+		 * If the real state of the console matches the handover state
+		 * that this context setup, then the handover was a success
+		 * and this context is now the owner.
+		 *
+		 * Note that this might have raced with a new higher priority
+		 * requester coming in after the lock was handed over.
+		 * However, that requester will see that the owner changes and
+		 * setup a new request for the current owner (this context).
+		 */
+		if (cons_state_bits_match(cur, ctxt->hov_state))
+			goto success;
+
+		/*
+		 * If state changed since the request was made, give up as
+		 * it is no longer consistent. This must include
+		 * state::req_prio since there could be a higher priority
+		 * request available.
+		 */
+		if (cur.bits !=3D ctxt->req_state.bits)
+			goto cleanup;
+
+		/*
+		 * Finally check whether the handover state is still
+		 * the same.
+		 */
+		cons_state_read(con, CON_STATE_REQ, &cur);
+		if (cur.atom !=3D ctxt->hov_state.atom)
+			goto cleanup;
+
+		/* Account time */
+		if (timeout > 0)
+			udelay(1);
+	}
+
+	/*
+	 * Timeout. Cleanup the handover state and carefully try to reset
+	 * req_prio in the real state. The reset is important to ensure
+	 * that the owner does not hand over the lock after this context
+	 * has given up waiting.
+	 */
+	cons_cleanup_handover(ctxt);
+
+	cons_state_read(con, CON_STATE_CUR, &cur);
+	do {
+		/*
+		 * The timeout might have raced with the owner coming late
+		 * and handing it over gracefully.
+		 */
+		if (cons_state_bits_match(cur, ctxt->hov_state))
+			goto success;
+
+		/*
+		 * Validate that the state matches with the state at request
+		 * time. If this check fails, there is already a higher
+		 * priority context waiting or the owner has changed (either
+		 * by higher priority or by hostile takeover). In all fail
+		 * cases this context is no longer in line for a handover to
+		 * take place, so no reset is necessary.
+		 */
+		if (cur.bits !=3D ctxt->req_state.bits)
+			goto cleanup;
+
+		copy_full_state(new, cur);
+		new.req_prio =3D 0;
+	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &cur, &new));
+	/* Reset worked. Report timeout. */
+	return -EBUSY;
+
+success:
+	/* Store the real state */
+	copy_full_state(ctxt->state, cur);
+	ctxt->hostile =3D false;
+	err =3D 0;
+
+cleanup:
+	cons_cleanup_handover(ctxt);
+	return err;
+}
+
+/**
+ * __cons_try_acquire - Try to acquire the console for printk output
+ * @ctxt:	Pointer to an acquire context that contains
+ *		all information about the acquire mode
+ *
+ * Returns: True if the acquire was successful. False on fail.
+ *
+ * In case of success @ctxt->state contains the acquisition
+ * state.
+ *
+ * In case of fail @ctxt->old_state contains the state
+ * that was read from @con->state for analysis by the caller.
+ */
+static bool __cons_try_acquire(struct cons_context *ctxt)
+{
+	unsigned int cpu =3D smp_processor_id();
+	struct console *con =3D ctxt->console;
+	short flags =3D console_srcu_read_flags(con);
+	struct cons_state old;
+	struct cons_state new;
+	int err;
+
+	if (WARN_ON_ONCE(!(flags & CON_NO_BKL)))
+		return false;
+again:
+	cons_state_read(con, CON_STATE_CUR, &old);
+
+	/* Preserve it for the caller and for spinwait */
+	copy_full_state(ctxt->old_state, old);
+
+	if (cons_check_panic())
+		return false;
+
+	/* Set up the new state for takeover */
+	copy_full_state(new, old);
+	new.locked =3D 1;
+	new.thread =3D ctxt->thread;
+	new.cur_prio =3D ctxt->prio;
+	new.req_prio =3D CONS_PRIO_NONE;
+	new.cpu =3D cpu;
+
+	/* Attempt to acquire it directly if unlocked */
+	if (!old.locked) {
+		if (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new))
+			goto again;
+
+		ctxt->hostile =3D false;
+		copy_full_state(ctxt->state, new);
+		goto success;
+	}
+
+	/*
+	 * A threaded printer context will never spin or perform a
+	 * hostile takeover. The atomic writer will wake the thread
+	 * when it is done with the important output.
+	 */
+	if (ctxt->thread)
+		return false;
+
+	/*
+	 * If the active context is on the same CPU then there is
+	 * obviously no handshake possible.
+	 */
+	if (old.cpu =3D=3D cpu)
+		goto check_hostile;
+
+	/*
+	 * If a handover request with same or higher priority is already
+	 * pending then this context cannot setup a handover request.
+	 */
+	if (old.req_prio >=3D ctxt->prio)
+		goto check_hostile;
+
+	/*
+	 * If the caller did not request spin-waiting then performing a
+	 * handover is not an option.
+	 */
+	if (!ctxt->spinwait)
+		goto check_hostile;
+
+	/*
+	 * Setup the request in state[REQ]. If this fails then this
+	 * context is not allowed to setup a handover request.
+	 */
+	if (!cons_setup_handover(ctxt))
+		goto check_hostile;
+
+	/*
+	 * Setup the request in state[CUR]. Hand in the state that was
+	 * used to make the decision to spinwait above, for comparison. If
+	 * this fails then unexpected state values were encountered and the
+	 * full request setup process is retried.
+	 */
+	if (!cons_setup_request(ctxt, old))
+		goto again;
+
+	/*
+	 * Spin-wait to acquire the console. If this fails then unexpected
+	 * state values were encountered (for example, a hostile takeover by
+	 * another context) and the full request setup process is retried.
+	 */
+	err =3D cons_try_acquire_spin(ctxt);
+	if (err) {
+		if (err =3D=3D -EAGAIN)
+			goto again;
+		goto check_hostile;
+	}
+success:
+	/* Common updates on success */
+	cons_context_set_seq(ctxt);
+	cons_context_set_pbufs(ctxt);
+	return true;
+
+check_hostile:
+	if (!ctxt->hostile)
+		return false;
+
+	if (cons_check_panic())
+		return false;
+
+	if (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new))
+		goto again;
+
+	copy_full_state(ctxt->state, new);
+	goto success;
+}
+
+/**
+ * cons_try_acquire - Try to acquire the console for printk output
+ * @ctxt:	Pointer to an acquire context that contains
+ *		all information about the acquire mode
+ *
+ * Returns: True if the acquire was successful. False on fail.
+ *
+ * In case of success @ctxt->state contains the acquisition
+ * state.
+ *
+ * In case of fail @ctxt->old_state contains the state
+ * that was read from @con->state for analysis by the caller.
+ */
+static bool cons_try_acquire(struct cons_context *ctxt)
+{
+	if (__cons_try_acquire(ctxt))
+		return true;
+
+	ctxt->state.atom =3D 0;
+	return false;
+}
+
+/**
+ * __cons_release - Release the console after output is done
+ * @ctxt:	The acquire context that contains the state
+ *		at cons_try_acquire()
+ *
+ * Returns:	True if the release was regular
+ *
+ *		False if the console is in unusable state or was handed over
+ *		with handshake or taken	over hostile without handshake.
+ *
+ * The return value tells the caller whether it needs to evaluate further
+ * printing.
+ */
+static bool __cons_release(struct cons_context *ctxt)
+{
+	struct console *con =3D ctxt->console;
+	short flags =3D console_srcu_read_flags(con);
+	struct cons_state hstate;
+	struct cons_state old;
+	struct cons_state new;
+
+	if (WARN_ON_ONCE(!(flags & CON_NO_BKL)))
+		return false;
+
+	cons_state_read(con, CON_STATE_CUR, &old);
+again:
+	if (!cons_state_bits_match(old, ctxt->state))
+		return false;
+
+	/* Release it directly when no handover request is pending. */
+	if (!old.req_prio)
+		goto unlock;
+
+	/* Read the handover target state */
+	cons_state_read(con, CON_STATE_REQ, &hstate);
+
+	/* If the waiter gave up hstate is 0 */
+	if (!hstate.atom)
+		goto unlock;
+
+	/*
+	 * If a higher priority waiter raced against a lower priority
+	 * waiter then unlock instead of handing over to either. The
+	 * higher priority waiter will notice the updated state and
+	 * retry.
+	 */
+	if (hstate.cur_prio !=3D old.req_prio)
+		goto unlock;
+
+	/* Switch the state and preserve the sequence on 64bit */
+	copy_bit_state(new, hstate);
+	copy_seq_state64(new, old);
+	if (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new))
+		goto again;
+
+	return true;
+
+unlock:
+	/* Clear the state and preserve the sequence on 64bit */
+	new.atom =3D 0;
+	copy_seq_state64(new, old);
+	if (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new))
+		goto again;
+
+	return true;
+}
+
+bool printk_threads_enabled __ro_after_init;
+static bool printk_force_atomic __initdata;
+
+/**
+ * cons_release - Release the console after output is done
+ * @ctxt:	The acquire context that contains the state
+ *		at cons_try_acquire()
+ *
+ * Returns:	True if the release was regular
+ *
+ *		False if the console is in unusable state or was handed over
+ *		with handshake or taken	over hostile without handshake.
+ *
+ * The return value tells the caller whether it needs to evaluate further
+ * printing.
+ */
+static bool cons_release(struct cons_context *ctxt)
+{
+	bool ret =3D __cons_release(ctxt);
+
+	/* Invalidate the buffer pointer. It is no longer valid. */
+	ctxt->pbufs =3D NULL;
+
+	ctxt->state.atom =3D 0;
+	return ret;
+}
+
+bool console_try_acquire(struct cons_write_context *wctxt)
+{
+	struct cons_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
+
+	return cons_try_acquire(ctxt);
+}
+EXPORT_SYMBOL_GPL(console_try_acquire);
+
+bool console_release(struct cons_write_context *wctxt)
+{
+	struct cons_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
+
+	return cons_release(ctxt);
+}
+EXPORT_SYMBOL_GPL(console_release);
+
+/**
+ * cons_alloc_percpu_data - Allocate percpu data for a console
+ * @con:	Console to allocate for
+ *
+ * Returns: True on success. False otherwise and the console cannot be use=
d.
+ *
+ * If it is not yet possible to allocate per CPU data, success is returned.
+ * When per CPU data becomes possible, set_percpu_data_ready() will call
+ * this function again for all registered consoles.
+ */
+bool cons_alloc_percpu_data(struct console *con)
+{
+	if (!printk_percpu_data_ready())
+		return true;
+
+	con->pcpu_data =3D alloc_percpu(typeof(*con->pcpu_data));
+	if (con->pcpu_data)
+		return true;
+
+	con_printk(KERN_WARNING, con, "failed to allocate percpu buffers\n");
+	return false;
+}
+
+/**
+ * cons_free_percpu_data - Free percpu data of a console on unregister
+ * @con:	Console to clean up
+ */
+static void cons_free_percpu_data(struct console *con)
+{
+	if (!con->pcpu_data)
+		return;
+
+	free_percpu(con->pcpu_data);
+	con->pcpu_data =3D NULL;
+}
+
+/**
+ * console_can_proceed - Check whether printing can proceed
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Returns:	True if the state is correct. False if a handover
+ *		has been requested or if the console was taken
+ *		over.
+ *
+ * Must be invoked after the record was dumped into the assigned record
+ * buffer and at appropriate safe places in the driver.  For unsafe driver
+ * sections see console_enter_unsafe().
+ *
+ * When this function returns false then the calling context is not allowed
+ * to go forward and has to back out immediately and carefully. The buffer
+ * content is no longer trusted either and the console lock is no longer
+ * held.
+ */
+bool console_can_proceed(struct cons_write_context *wctxt)
+{
+	struct cons_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con =3D ctxt->console;
+	struct cons_state state;
+
+	cons_state_read(con, CON_STATE_CUR, &state);
+	/* Store it for analysis or reuse */
+	copy_full_state(ctxt->old_state, state);
+
+	/* Make sure this context is still the owner. */
+	if (!cons_state_full_match(state, ctxt->state))
+		return false;
+
+	/*
+	 * Having a safe point for take over and eventually a few
+	 * duplicated characters or a full line is way better than a
+	 * hostile takeover. Post processing can take care of the garbage.
+	 * Continue if the requested priority is not sufficient.
+	 */
+	if (state.req_prio <=3D state.cur_prio)
+		return true;
+
+	/*
+	 * A console printer within an unsafe region is allowed to continue.
+	 * It can perform the handover when exiting the safe region. Otherwise
+	 * a hostile takeover will be necessary.
+	 */
+	if (state.unsafe)
+		return true;
+
+	/* Release and hand over */
+	cons_release(ctxt);
+	/*
+	 * This does not check whether the handover succeeded. The
+	 * outermost callsite has to make the final decision whether printing
+	 * should continue or not (via reacquire, possibly hostile). The
+	 * console is unlocked already so go back all the way instead of
+	 * trying to implement heuristics in tons of places.
+	 */
+	return false;
+}
+EXPORT_SYMBOL_GPL(console_can_proceed);
+
+/**
+ * __console_update_unsafe - Update the unsafe bit in @con->atomic_state
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Returns:	True if the state is correct. False if a handover
+ *		has been requested or if the console was taken
+ *		over.
+ *
+ * Must be invoked before an unsafe driver section is entered.
+ *
+ * When this function returns false then the calling context is not allowed
+ * to go forward and has to back out immediately and carefully. The buffer
+ * content is no longer trusted either and the console lock is no longer
+ * held.
+ *
+ * Internal helper to avoid duplicated code
+ */
+static bool __console_update_unsafe(struct cons_write_context *wctxt, bool=
 unsafe)
+{
+	struct cons_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con =3D ctxt->console;
+	struct cons_state new;
+
+	do  {
+		if (!console_can_proceed(wctxt))
+			return false;
+		/*
+		 * console_can_proceed() saved the real state in
+		 * ctxt->old_state
+		 */
+		copy_full_state(new, ctxt->old_state);
+		new.unsafe =3D unsafe;
+
+	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &ctxt->old_state, &n=
ew));
+
+	copy_full_state(ctxt->state, new);
+	return true;
+}
+
+/**
+ * console_enter_unsafe - Enter an unsafe region in the driver
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Returns:	True if the state is correct. False if a handover
+ *		has been requested or if the console was taken
+ *		over.
+ *
+ * Must be invoked before an unsafe driver section is entered.
+ *
+ * When this function returns false then the calling context is not allowed
+ * to go forward and has to back out immediately and carefully. The buffer
+ * content is no longer trusted either and the console lock is no longer
+ * held.
+ */
+bool console_enter_unsafe(struct cons_write_context *wctxt)
+{
+	return __console_update_unsafe(wctxt, true);
+}
+EXPORT_SYMBOL_GPL(console_enter_unsafe);
+
+/**
+ * console_exit_unsafe - Exit an unsafe region in the driver
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Returns:	True if the state is correct. False if a handover
+ *		has been requested or if the console was taken
+ *		over.
+ *
+ * Must be invoked before an unsafe driver section is exited.
+ *
+ * When this function returns false then the calling context is not allowed
+ * to go forward and has to back out immediately and carefully. The buffer
+ * content is no longer trusted either and the console lock is no longer
+ * held.
+ */
+bool console_exit_unsafe(struct cons_write_context *wctxt)
+{
+	return __console_update_unsafe(wctxt, false);
+}
+EXPORT_SYMBOL_GPL(console_exit_unsafe);
+
+/**
+ * cons_get_record - Fill the buffer with the next pending ringbuffer reco=
rd
+ * @wctxt:	The write context which will be handed to the write function
+ *
+ * Returns:	True if there are records available. If the next record should
+ *		be printed, the output buffer is filled and @wctxt->outbuf
+ *		points to the text to print. If @wctxt->outbuf is NULL after
+ *		the call, the record should not be printed but the caller must
+ *		still update the console sequence number.
+ *
+ *		False means that there are no pending records anymore and the
+ *		printing can stop.
+ */
+static bool cons_get_record(struct cons_write_context *wctxt)
+{
+	struct cons_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con =3D ctxt->console;
+	bool is_extended =3D console_srcu_read_flags(con) & CON_EXTENDED;
+	struct printk_message pmsg =3D {
+		.pbufs =3D ctxt->pbufs,
+	};
+
+	if (!printk_get_next_message(&pmsg, ctxt->newseq, is_extended, true))
+		return false;
+
+	ctxt->newseq =3D pmsg.seq;
+	ctxt->dropped +=3D pmsg.dropped;
+
+	if (pmsg.outbuf_len =3D=3D 0) {
+		wctxt->outbuf =3D NULL;
+	} else {
+		if (ctxt->dropped && !is_extended)
+			console_prepend_dropped(&pmsg, ctxt->dropped);
+		wctxt->outbuf =3D &pmsg.pbufs->outbuf[0];
+	}
+
+	wctxt->len =3D pmsg.outbuf_len;
+
+	return true;
+}
+
+/**
+ * cons_emit_record - Emit record in the acquired context
+ * @wctxt:	The write context that will be handed to the write function
+ *
+ * Returns:	False if the operation was aborted (takeover or handover).
+ *		True otherwise
+ *
+ * When false is returned, the caller is not allowed to touch console stat=
e.
+ * The console is owned by someone else. If the caller wants to print more
+ * it has to reacquire the console first.
+ *
+ * When true is returned, @wctxt->ctxt.backlog indicates whether there are
+ * still records pending in the ringbuffer,
+ */
+static bool cons_emit_record(struct cons_write_context *wctxt)
+{
+	struct cons_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con =3D ctxt->console;
+	bool done =3D false;
+
+	/*
+	 * @con->dropped is not protected in case of hostile takeovers so
+	 * the update below is racy. Annotate it accordingly.
+	 */
+	ctxt->dropped =3D data_race(READ_ONCE(con->dropped));
+
+	/* Fill the output buffer with the next record */
+	ctxt->backlog =3D cons_get_record(wctxt);
+	if (!ctxt->backlog)
+		return true;
+
+	/* Safety point. Don't touch state in case of takeover */
+	if (!console_can_proceed(wctxt))
+		return false;
+
+	/* Counterpart to the read above */
+	WRITE_ONCE(con->dropped, ctxt->dropped);
+
+	/*
+	 * In case of skipped records, Update sequence state in @con.
+	 */
+	if (!wctxt->outbuf)
+		goto update;
+
+	/* Tell the driver about potential unsafe state */
+	wctxt->unsafe =3D ctxt->state.unsafe;
+
+	if (!ctxt->thread && con->write_atomic) {
+		done =3D con->write_atomic(con, wctxt);
+	} else if (ctxt->thread && con->write_thread) {
+		done =3D con->write_thread(con, wctxt);
+	} else {
+		cons_release(ctxt);
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/* If not done, the write was aborted due to takeover */
+	if (!done)
+		return false;
+
+	/* If there was a dropped message, it has now been output. */
+	if (ctxt->dropped) {
+		ctxt->dropped =3D 0;
+		/* Counterpart to the read above */
+		WRITE_ONCE(con->dropped, ctxt->dropped);
+	}
+update:
+	ctxt->newseq++;
+	/*
+	 * The sequence update attempt is not part of console_release()
+	 * because in panic situations the console is not released by
+	 * the panic CPU until all records are written. On 32bit the
+	 * sequence is separate from state anyway.
+	 */
+	return cons_seq_try_update(ctxt);
+}
+
+/**
+ * cons_kthread_should_wakeup - Check whether the printk thread should wak=
eup
+ * @con:	Console to operate on
+ * @ctxt:	The acquire context that contains the state
+ *		at console_acquire()
+ *
+ * Returns: True if the thread should shutdown or if the console is allowe=
d to
+ * print and a record is available. False otherwise
+ *
+ * After the thread wakes up, it must first check if it should shutdown be=
fore
+ * attempting any printing.
+ */
+static bool cons_kthread_should_wakeup(struct console *con, struct cons_co=
ntext *ctxt)
+{
+	bool is_usable;
+	short flags;
+	int cookie;
+
+	if (kthread_should_stop())
+		return true;
+
+	cookie =3D console_srcu_read_lock();
+	flags =3D console_srcu_read_flags(con);
+	is_usable =3D console_is_usable(con, flags);
+	console_srcu_read_unlock(cookie);
+
+	if (!is_usable)
+		return false;
+
+	/* This reads state and sequence on 64bit. On 32bit only state */
+	cons_state_read(con, CON_STATE_CUR, &ctxt->state);
+
+	/*
+	 * Atomic printing is running on some other CPU. The owner
+	 * will wake the console thread on unlock if necessary.
+	 */
+	if (ctxt->state.locked)
+		return false;
+
+	/* Bring the sequence in @ctxt up to date */
+	cons_context_set_seq(ctxt);
+
+	return prb_read_valid(prb, ctxt->oldseq, NULL);
+}
+
+/**
+ * cons_kthread_func - The printk thread function
+ * @__console:	Console to operate on
+ */
+static int cons_kthread_func(void *__console)
+{
+	struct console *con =3D __console;
+	struct cons_write_context wctxt =3D {
+		.ctxt.console	=3D con,
+		.ctxt.prio	=3D CONS_PRIO_NORMAL,
+		.ctxt.thread	=3D 1,
+	};
+	struct cons_context *ctxt =3D &ACCESS_PRIVATE(&wctxt, ctxt);
+	unsigned long flags;
+	short con_flags;
+	bool backlog;
+	int cookie;
+	int ret;
+
+	for (;;) {
+		atomic_inc(&con->kthread_waiting);
+
+		/*
+		 * Provides a full memory barrier vs. cons_kthread_wake().
+		 */
+		ret =3D rcuwait_wait_event(&con->rcuwait,
+					 cons_kthread_should_wakeup(con, ctxt),
+					 TASK_INTERRUPTIBLE);
+
+		atomic_dec(&con->kthread_waiting);
+
+		if (kthread_should_stop())
+			break;
+
+		/* Wait was interrupted by a spurious signal, go back to sleep */
+		if (ret)
+			continue;
+
+		for (;;) {
+			cookie =3D console_srcu_read_lock();
+
+			/*
+			 * Ensure this stays on the CPU to make handover and
+			 * takeover possible.
+			 */
+			if (con->port_lock)
+				con->port_lock(con, true, &flags);
+			else
+				migrate_disable();
+
+			/*
+			 * Try to acquire the console without attempting to
+			 * take over. If an atomic printer wants to hand
+			 * back to the thread it simply wakes it up.
+			 */
+			if (!cons_try_acquire(ctxt))
+				break;
+
+			con_flags =3D console_srcu_read_flags(con);
+
+			if (console_is_usable(con, con_flags)) {
+				/*
+				 * If the emit fails, this context is no
+				 * longer the owner. Abort the processing and
+				 * wait for new records to print.
+				 */
+				if (!cons_emit_record(&wctxt))
+					break;
+				backlog =3D ctxt->backlog;
+			} else {
+				backlog =3D false;
+			}
+
+			/*
+			 * If the release fails, this context was not the
+			 * owner. Abort the processing and wait for new
+			 * records to print.
+			 */
+			if (!cons_release(ctxt))
+				break;
+
+			/* Backlog done? */
+			if (!backlog)
+				break;
+
+			if (con->port_lock)
+				con->port_lock(con, false, &flags);
+			else
+				migrate_enable();
+
+			console_srcu_read_unlock(cookie);
+
+			cond_resched();
+		}
+		if (con->port_lock)
+			con->port_lock(con, false, &flags);
+		else
+			migrate_enable();
+
+		console_srcu_read_unlock(cookie);
+	}
+	return 0;
+}
+
+/**
+ * cons_irq_work - irq work to wake printk thread
+ * @irq_work:	The irq work to operate on
+ */
+static void cons_irq_work(struct irq_work *irq_work)
+{
+	struct console *con =3D container_of(irq_work, struct console, irq_work);
+
+	cons_kthread_wake(con);
+}
+
+/**
+ * cons_wake_threads - Wake up printing threads
+ *
+ * A printing thread is only woken if it is within the @kthread_waiting
+ * block. If it is not within the block (or enters the block later), it
+ * will see any new records and continue printing on its own.
+ */
+void cons_wake_threads(void)
+{
+	struct console *con;
+	int cookie;
+
+	cookie =3D console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		if (con->kthread && atomic_read(&con->kthread_waiting))
+			irq_work_queue(&con->irq_work);
+	}
+	console_srcu_read_unlock(cookie);
+}
+
+/**
+ * struct cons_cpu_state - Per CPU printk context state
+ * @prio:	The current context priority level
+ * @nesting:	Per priority nest counter
+ */
+struct cons_cpu_state {
+	enum cons_prio	prio;
+	int		nesting[CONS_PRIO_MAX];
+};
+
+static DEFINE_PER_CPU(struct cons_cpu_state, cons_pcpu_state);
+static struct cons_cpu_state early_cons_pcpu_state __initdata;
+
+/**
+ * cons_get_cpu_state - Get the per CPU console state pointer
+ *
+ * Returns either a pointer to the per CPU state of the current CPU or to
+ * the init data state during early boot.
+ */
+static __ref struct cons_cpu_state *cons_get_cpu_state(void)
+{
+	if (!printk_percpu_data_ready())
+		return &early_cons_pcpu_state;
+
+	return this_cpu_ptr(&cons_pcpu_state);
+}
+
+/**
+ * cons_get_wctxt - Get the write context for atomic printing
+ * @con:	Console to operate on
+ * @prio:	Priority of the context
+ *
+ * Returns either the per CPU context or the builtin context for
+ * early boot.
+ */
+static __ref struct cons_write_context *cons_get_wctxt(struct console *con,
+						       enum cons_prio prio)
+{
+	if (!con->pcpu_data)
+		return &early_cons_ctxt_data.wctxt[prio];
+
+	return &this_cpu_ptr(con->pcpu_data)->wctxt[prio];
+}
+
+/**
+ * cons_atomic_try_acquire - Try to acquire the console for atomic printing
+ * @con:	The console to acquire
+ * @ctxt:	The console context instance to work on
+ * @prio:	The priority of the current context
+ */
+static bool cons_atomic_try_acquire(struct console *con, struct cons_conte=
xt *ctxt,
+				    enum cons_prio prio, bool skip_unsafe)
+{
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->console		=3D con;
+	ctxt->spinwait_max_us	=3D 2000;
+	ctxt->prio		=3D prio;
+	ctxt->spinwait		=3D 1;
+
+	/* Try to acquire it directly or via a friendly handover */
+	if (cons_try_acquire(ctxt))
+		return true;
+
+	/* Investigate whether a hostile takeover is due */
+	if (ctxt->old_state.cur_prio >=3D prio)
+		return false;
+
+	if (!ctxt->old_state.unsafe || !skip_unsafe)
+		ctxt->hostile =3D 1;
+	return cons_try_acquire(ctxt);
+}
+
+/**
+ * cons_atomic_flush_con - Flush one console in atomic mode
+ * @wctxt:		The write context struct to use for this context
+ * @con:		The console to flush
+ * @prio:		The priority of the current context
+ * @skip_unsafe:	True, to avoid unsafe hostile takeovers
+ */
+static void cons_atomic_flush_con(struct cons_write_context *wctxt, struct=
 console *con,
+				  enum cons_prio prio, bool skip_unsafe)
+{
+	struct cons_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
+	bool wake_thread =3D false;
+	short flags;
+
+	if (!cons_atomic_try_acquire(con, ctxt, prio, skip_unsafe))
+		return;
+
+	do {
+		flags =3D console_srcu_read_flags(con);
+
+		if (!console_is_usable(con, flags))
+			break;
+
+		/*
+		 * For normal prio messages let the printer thread handle
+		 * the printing if it is available.
+		 */
+		if (prio <=3D CONS_PRIO_NORMAL && con->kthread) {
+			wake_thread =3D true;
+			break;
+		}
+
+		/*
+		 * cons_emit_record() returns false when the console was
+		 * handed over or taken over. In both cases the context is
+		 * no longer valid.
+		 */
+		if (!cons_emit_record(wctxt))
+			return;
+	} while (ctxt->backlog);
+
+	cons_release(ctxt);
+
+	if (wake_thread && atomic_read(&con->kthread_waiting))
+		irq_work_queue(&con->irq_work);
+}
+
+/**
+ * cons_atomic_flush - Flush consoles in atomic mode if required
+ * @printk_caller_wctxt:	The write context struct to use for this
+ *				context (for printk() context only)
+ * @skip_unsafe:		True, to avoid unsafe hostile takeovers
+ */
+void cons_atomic_flush(struct cons_write_context *printk_caller_wctxt, boo=
l skip_unsafe)
+{
+	struct cons_write_context *wctxt;
+	struct cons_cpu_state *cpu_state;
+	struct console *con;
+	short flags;
+	int cookie;
+
+	cpu_state =3D cons_get_cpu_state();
+
+	/*
+	 * When in an elevated priority, the printk() calls are not
+	 * individually flushed. This is to allow the full output to
+	 * be dumped to the ringbuffer before starting with printing
+	 * the backlog.
+	 */
+	if (cpu_state->prio > CONS_PRIO_NORMAL && printk_caller_wctxt)
+		return;
+
+	/*
+	 * Let the outermost write of this priority print. This avoids
+	 * nasty hackery for nested WARN() where the printing itself
+	 * generates one.
+	 *
+	 * cpu_state->prio <=3D CONS_PRIO_NORMAL is not subject to nesting
+	 * and can proceed in order to allow atomic printing when consoles
+	 * do not have a printer thread.
+	 */
+	if (cpu_state->prio > CONS_PRIO_NORMAL &&
+	    cpu_state->nesting[cpu_state->prio] !=3D 1)
+		return;
+
+	cookie =3D console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		if (!con->write_atomic)
+			continue;
+
+		flags =3D console_srcu_read_flags(con);
+
+		if (!console_is_usable(con, flags))
+			continue;
+
+		if (cpu_state->prio > CONS_PRIO_NORMAL || !con->kthread) {
+			if (printk_caller_wctxt)
+				wctxt =3D printk_caller_wctxt;
+			else
+				wctxt =3D cons_get_wctxt(con, cpu_state->prio);
+			cons_atomic_flush_con(wctxt, con, cpu_state->prio, skip_unsafe);
+		}
+	}
+	console_srcu_read_unlock(cookie);
+}
+
+/**
+ * cons_atomic_enter - Enter a context that enforces atomic printing
+ * @prio:	Priority of the context
+ *
+ * Returns:	The previous priority that needs to be fed into
+ *		the corresponding cons_atomic_exit()
+ */
+enum cons_prio cons_atomic_enter(enum cons_prio prio)
+{
+	struct cons_cpu_state *cpu_state;
+	enum cons_prio prev_prio;
+
+	migrate_disable();
+	cpu_state =3D cons_get_cpu_state();
+
+	prev_prio =3D cpu_state->prio;
+	if (prev_prio < prio)
+		cpu_state->prio =3D prio;
+
+	/*
+	 * Increment the nesting on @cpu_state->prio so a WARN()
+	 * nested into a panic printout does not attempt to
+	 * scribble state.
+	 */
+	cpu_state->nesting[cpu_state->prio]++;
+
+	return prev_prio;
+}
+
+/**
+ * cons_atomic_exit - Exit a context that enforces atomic printing
+ * @prio:	Priority of the context to leave
+ * @prev_prio:	Priority of the previous context for restore
+ *
+ * @prev_prio is the priority returned by the corresponding cons_atomic_en=
ter().
+ */
+void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio)
+{
+	struct cons_cpu_state *cpu_state;
+
+	cons_atomic_flush(NULL, true);
+
+	cpu_state =3D cons_get_cpu_state();
+
+	if (cpu_state->prio =3D=3D CONS_PRIO_PANIC)
+		cons_atomic_flush(NULL, false);
+
+	/*
+	 * Undo the nesting of cons_atomic_enter() at the CPU state
+	 * priority.
+	 */
+	cpu_state->nesting[cpu_state->prio]--;
+
+	/*
+	 * Restore the previous priority, which was returned by
+	 * cons_atomic_enter().
+	 */
+	cpu_state->prio =3D prev_prio;
+
+	migrate_enable();
+}
+
+/**
+ * cons_kthread_stop - Stop a printk thread
+ * @con:	Console to operate on
+ */
+static void cons_kthread_stop(struct console *con)
+{
+	lockdep_assert_console_list_lock_held();
+
+	if (!con->kthread)
+		return;
+
+	kthread_stop(con->kthread);
+	con->kthread =3D NULL;
+
+	kfree(con->thread_pbufs);
+	con->thread_pbufs =3D NULL;
+}
+
+/**
+ * cons_kthread_create - Create a printk thread
+ * @con:	Console to operate on
+ *
+ * If it fails, let the console proceed. The atomic part might
+ * be usable and useful.
+ */
+void cons_kthread_create(struct console *con)
+{
+	struct task_struct *kt;
+	struct console *c;
+
+	lockdep_assert_console_list_lock_held();
+
+	if (!(con->flags & CON_NO_BKL) || !con->write_thread)
+		return;
+
+	if (!printk_threads_enabled || con->kthread)
+		return;
+
+	/*
+	 * Printer threads cannot be started as long as any boot console is
+	 * registered because there is no way to synchronize the hardware
+	 * registers between boot console code and regular console code.
+	 */
+	for_each_console(c) {
+		if (c->flags & CON_BOOT)
+			return;
+	}
+	have_boot_console =3D false;
+
+	con->thread_pbufs =3D kmalloc(sizeof(*con->thread_pbufs), GFP_KERNEL);
+	if (!con->thread_pbufs) {
+		con_printk(KERN_ERR, con, "failed to allocate printing thread buffers\n"=
);
+		return;
+	}
+
+	kt =3D kthread_run(cons_kthread_func, con, "pr/%s%d", con->name, con->ind=
ex);
+	if (IS_ERR(kt)) {
+		con_printk(KERN_ERR, con, "failed to start printing thread\n");
+		kfree(con->thread_pbufs);
+		con->thread_pbufs =3D NULL;
+		return;
+	}
+
+	con->kthread =3D kt;
+
+	/*
+	 * It is important that console printing threads are scheduled
+	 * shortly after a printk call and with generous runtime budgets.
+	 */
+	sched_set_normal(con->kthread, -20);
+}
+
+static int __init printk_setup_threads(void)
+{
+	struct console *con;
+
+	if (printk_force_atomic)
+		return 0;
+
+	console_list_lock();
+	printk_threads_enabled =3D true;
+	for_each_console(con)
+		cons_kthread_create(con);
+	if (have_bkl_console)
+		console_bkl_kthread_create();
+	console_list_unlock();
+	return 0;
+}
+early_initcall(printk_setup_threads);
+
+/**
+ * cons_nobkl_init - Initialize the NOBKL console specific data
+ * @con:	Console to initialize
+ *
+ * Returns: True on success. False otherwise and the console cannot be use=
d.
+ */
+bool cons_nobkl_init(struct console *con)
+{
+	struct cons_state state =3D { };
+
+	if (!cons_alloc_percpu_data(con))
+		return false;
+
+	rcuwait_init(&con->rcuwait);
+	atomic_set(&con->kthread_waiting, 0);
+	init_irq_work(&con->irq_work, cons_irq_work);
+	cons_state_set(con, CON_STATE_CUR, &state);
+	cons_state_set(con, CON_STATE_REQ, &state);
+	cons_seq_init(con);
+	cons_kthread_create(con);
+	return true;
+}
+
+/**
+ * cons_nobkl_cleanup - Cleanup the NOBKL console specific data
+ * @con:	Console to cleanup
+ */
+void cons_nobkl_cleanup(struct console *con)
+{
+	struct cons_state state =3D { };
+
+	cons_kthread_stop(con);
+	cons_state_set(con, CON_STATE_CUR, &state);
+	cons_state_set(con, CON_STATE_REQ, &state);
+	cons_free_percpu_data(con);
+}
+
+/**
+ * printk_kthread_shutdown - shutdown all threaded printers
+ *
+ * On system shutdown all threaded printers are stopped. This allows printk
+ * to transition back to atomic printing, thus providing a robust mechanism
+ * for the final shutdown/reboot messages to be output.
+ */
+static void printk_kthread_shutdown(void)
+{
+	struct console *con;
+
+	console_list_lock();
+	for_each_console(con) {
+		if (con->flags & CON_NO_BKL)
+			cons_kthread_stop(con);
+	}
+	console_list_unlock();
+}
+
+static struct syscore_ops printk_syscore_ops =3D {
+	.shutdown =3D printk_kthread_shutdown,
+};
+
+static int __init printk_init_ops(void)
+{
+	register_syscore_ops(&printk_syscore_ops);
+	return 0;
+}
+device_initcall(printk_init_ops);
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index caac4de1ea59a..9cd33cddef9fc 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -8,24 +8,43 @@
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/printk.h>
-#include <linux/console.h>
 #include <linux/kprobes.h>
-#include <linux/delay.h>
=20
 #include "internal.h"
=20
-static DEFINE_PER_CPU(int, printk_context);
+struct printk_context {
+	local_lock_t cpu;
+	int recursion;
+};
+
+static DEFINE_PER_CPU(struct printk_context, printk_context) =3D {
+	.cpu =3D INIT_LOCAL_LOCK(cpu),
+};
=20
 /* Can be preempted by NMI. */
-void __printk_safe_enter(void)
+void __printk_safe_enter(unsigned long *flags)
 {
-	this_cpu_inc(printk_context);
+	local_lock_irqsave(&printk_context.cpu, *flags);
+	this_cpu_inc(printk_context.recursion);
 }
=20
 /* Can be preempted by NMI. */
-void __printk_safe_exit(void)
+void __printk_safe_exit(unsigned long *flags)
 {
-	this_cpu_dec(printk_context);
+	this_cpu_dec(printk_context.recursion);
+	local_unlock_irqrestore(&printk_context.cpu, *flags);
+}
+
+void __printk_deferred_enter(void)
+{
+	WARN_ON_ONCE(!in_atomic());
+	this_cpu_inc(printk_context.recursion);
+}
+
+void __printk_deferred_exit(void)
+{
+	WARN_ON_ONCE(!in_atomic());
+	this_cpu_dec(printk_context.recursion);
 }
=20
 asmlinkage int vprintk(const char *fmt, va_list args)
@@ -40,45 +59,10 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if (this_cpu_read(printk_context) || in_nmi()) {
-		int len;
-
-		len =3D vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
-		defer_console_output();
-		return len;
-	}
+	if (this_cpu_read(printk_context.recursion) || in_nmi())
+		return vprintk_deferred(fmt, args);
=20
 	/* No obstacles. */
 	return vprintk_default(fmt, args);
 }
 EXPORT_SYMBOL(vprintk);
-
-/**
- * try_block_console_kthreads() - Try to block console kthreads and
- *	make the global console_lock() avaialble
- *
- * @timeout_ms:        The maximum time (in ms) to wait.
- *
- * Prevent console kthreads from starting processing new messages. Wait
- * until the global console_lock() become available.
- *
- * Context: Can be called in any context.
- */
-void try_block_console_kthreads(int timeout_ms)
-{
-	block_console_kthreads =3D true;
-
-	/* Do not wait when the console lock could not be safely taken. */
-	if (this_cpu_read(printk_context) || in_nmi())
-		return;
-
-	while (timeout_ms > 0) {
-		if (console_trylock()) {
-			console_unlock();
-			return;
-		}
-
-		udelay(1000);
-		timeout_ms -=3D 1;
-	}
-}
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4cb347a2932c5..804306204d0d0 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -8,6 +8,7 @@
  */
=20
 #include <linux/kvm_para.h>
+#include <linux/console.h>
=20
 //////////////////////////////////////////////////////////////////////////=
////
 //
@@ -582,6 +583,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
=20
 static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
+	enum cons_prio prev_prio;
 	int cpu;
 	unsigned long flags;
 	unsigned long gpa;
@@ -597,6 +599,8 @@ static void print_other_cpu_stall(unsigned long gp_seq,=
 unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
=20
+	prev_prio =3D cons_atomic_enter(CONS_PRIO_EMERGENCY);
+
 	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -651,6 +655,8 @@ static void print_other_cpu_stall(unsigned long gp_seq,=
 unsigned long gps)
 	panic_on_rcu_stall();
=20
 	rcu_force_quiescent_state();  /* Kick them all. */
+
+	cons_atomic_exit(CONS_PRIO_EMERGENCY, prev_prio);
 }
=20
 static void print_cpu_stall(unsigned long gps)
@@ -673,7 +679,6 @@ static void print_cpu_stall(unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
-	printk_prefer_direct_enter();
 	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
 	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
 	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
@@ -708,7 +713,6 @@ static void print_cpu_stall(unsigned long gps)
 	 */
 	set_tsk_need_resched(current);
 	set_preempt_need_resched();
-	printk_prefer_direct_exit();
 }
=20
 static void check_cpu_stall(struct rcu_data *rdp)
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 57cedc3306603..3bba88c7ffc6b 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -82,7 +82,6 @@ void kernel_restart_prepare(char *cmd)
 {
 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state =3D SYSTEM_RESTART;
-	try_block_console_kthreads(10000);
 	usermodehelper_disable();
 	device_shutdown();
 }
@@ -283,7 +282,6 @@ static void kernel_shutdown_prepare(enum system_states =
state)
 	blocking_notifier_call_chain(&reboot_notifier_list,
 		(state =3D=3D SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
 	system_state =3D state;
-	try_block_console_kthreads(10000);
 	usermodehelper_disable();
 	device_shutdown();
 }
@@ -838,11 +836,9 @@ static int __orderly_reboot(void)
 	ret =3D run_cmd(reboot_cmd);
=20
 	if (ret) {
-		printk_prefer_direct_enter();
 		pr_warn("Failed to start orderly reboot: forcing the issue\n");
 		emergency_sync();
 		kernel_restart(NULL);
-		printk_prefer_direct_exit();
 	}
=20
 	return ret;
@@ -855,7 +851,6 @@ static int __orderly_poweroff(bool force)
 	ret =3D run_cmd(poweroff_cmd);
=20
 	if (ret && force) {
-		printk_prefer_direct_enter();
 		pr_warn("Failed to start orderly shutdown: forcing the issue\n");
=20
 		/*
@@ -865,7 +860,6 @@ static int __orderly_poweroff(bool force)
 		 */
 		emergency_sync();
 		kernel_power_off();
-		printk_prefer_direct_exit();
 	}
=20
 	return ret;
@@ -923,8 +917,6 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
  */
 static void hw_failure_emergency_poweroff_func(struct work_struct *work)
 {
-	printk_prefer_direct_enter();
-
 	/*
 	 * We have reached here after the emergency shutdown waiting period has
 	 * expired. This means orderly_poweroff has not been able to shut off
@@ -941,8 +933,6 @@ static void hw_failure_emergency_poweroff_func(struct w=
ork_struct *work)
 	 */
 	pr_emerg("Hardware protection shutdown failed. Trying emergency restart\n=
");
 	emergency_restart();
-
-	printk_prefer_direct_exit();
 }
=20
 static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
@@ -981,13 +971,11 @@ void hw_protection_shutdown(const char *reason, int m=
s_until_forced)
 {
 	static atomic_t allow_proceed =3D ATOMIC_INIT(1);
=20
-	printk_prefer_direct_enter();
-
 	pr_emerg("HARDWARE PROTECTION shutdown (%s)\n", reason);
=20
 	/* Shutdown should be initiated only once. */
 	if (!atomic_dec_and_test(&allow_proceed))
-		goto out;
+		return;
=20
 	/*
 	 * Queue a backup emergency shutdown in the event of
@@ -995,8 +983,6 @@ void hw_protection_shutdown(const char *reason, int ms_=
until_forced)
 	 */
 	hw_failure_emergency_poweroff(ms_until_forced);
 	orderly_poweroff(true);
-out:
-	printk_prefer_direct_exit();
 }
 EXPORT_SYMBOL_GPL(hw_protection_shutdown);
=20
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 41596c415111b..8e61f21e7e33e 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -424,8 +424,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hr=
timer *hrtimer)
 		/* Start period for the next softlockup warning. */
 		update_report_ts();
=20
-		printk_prefer_direct_enter();
-
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
@@ -444,8 +442,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hr=
timer *hrtimer)
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
-
-		printk_prefer_direct_exit();
 	}
=20
 	return HRTIMER_RESTART;
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 701f35f0e2d44..247bf0b1582ca 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -135,8 +135,6 @@ static void watchdog_overflow_callback(struct perf_even=
t *event,
 		if (__this_cpu_read(hard_watchdog_warn) =3D=3D true)
 			return;
=20
-		printk_prefer_direct_enter();
-
 		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n",
 			 this_cpu);
 		print_modules();
@@ -157,8 +155,6 @@ static void watchdog_overflow_callback(struct perf_even=
t *event,
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
=20
-		printk_prefer_direct_exit();
-
 		__this_cpu_write(hard_watchdog_warn, true);
 		return;
 	}
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
