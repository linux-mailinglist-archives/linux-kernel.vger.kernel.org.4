Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA34B6A89E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCBT6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCBT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A146474EB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:48 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+tfDj0YbYrshmUSH6s5mWBls3FqcK+wPi39QFNGqNY=;
        b=pW9iDDImWizt7l6Yp36l+xW2lyyUcO8NSnNTQCD+n8H//EbHA9icdh91NRGNwG8yDgGth1
        SS3ixk+1KbEY7yvuyLTtGFaWpY9mlxOfrav7zCrIA5vKBBwqHrbP3UzUcBQkL2gibHHiiv
        GDcvA5uwGuoGs2TBgxCej2Ofj0eqaFeGty+x2cyWzV3CH+42lF3d0QBPOEoc/wwd54UZr6
        KXhfrmZkm6eQch35DNVxnlxAACAci9xoRhyuMX8uxy0AqYaF2P9tBvqvYthvij3/rTGAVs
        q8FYH/SURTjzZjVNO/osEi55Lh5g4MJo1HvVaZOjyXo62PWF/xDG4IAENPOaMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+tfDj0YbYrshmUSH6s5mWBls3FqcK+wPi39QFNGqNY=;
        b=SEDDKnYjnEkHYb0raNoJEINmESrcMLXBfI4Aqhx+MQm/p/LJhBtyLkXvP+pCEMwUanYkCm
        uZ1B7X/5775OZgCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 11/18] printk: nobkl: Introduce printer threads
Date:   Thu,  2 Mar 2023 21:02:11 +0106
Message-Id: <20230302195618.156940-12-john.ogness@linutronix.de>
In-Reply-To: <20230302195618.156940-1-john.ogness@linutronix.de>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Add the infrastructure to create a printer thread per console along
with the required thread function, which is takeover/handover aware.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h      |  11 ++
 kernel/printk/internal.h     |  54 ++++++++
 kernel/printk/printk.c       |  52 ++-----
 kernel/printk/printk_nobkl.c | 259 ++++++++++++++++++++++++++++++++++-
 4 files changed, 336 insertions(+), 40 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 15f71ccfcd9d..2c120c3f3c6e 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -17,6 +17,7 @@
 #include <linux/atomic.h>
 #include <linux/bits.h>
 #include <linux/rculist.h>
+#include <linux/rcuwait.h>
 #include <linux/types.h>
 
 struct vc_data;
@@ -314,7 +315,12 @@ struct cons_context_data;
  * @atomic_state:	State array for NOBKL consoles; real and handover
  * @atomic_seq:		Sequence for record tracking (32bit only)
  * @thread_pbufs:	Pointer to thread private buffer
+ * @kthread:		Pointer to kernel thread
+ * @rcuwait:		RCU wait for the kernel thread
+ * @kthread_waiting:	Indicator whether the kthread is waiting to be woken
  * @write_atomic:	Write callback for atomic context
+ * @write_thread:	Write callback for printk threaded printing
+ * @port_lock:		Callback to lock/unlock the port lock
  * @pcpu_data:		Pointer to percpu context data
  */
 struct console {
@@ -342,8 +348,13 @@ struct console {
 	atomic_t		__private atomic_seq;
 #endif
 	struct printk_buffers	*thread_pbufs;
+	struct task_struct	*kthread;
+	struct rcuwait		rcuwait;
+	atomic_t		kthread_waiting;
 
 	bool (*write_atomic)(struct console *con, struct cons_write_context *wctxt);
+	bool (*write_thread)(struct console *con, struct cons_write_context *wctxt);
+	void (*port_lock)(struct console *con, bool do_lock, unsigned long *flags);
 
 	struct cons_context_data	__percpu *pcpu_data;
 };
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 13dd0ce23c37..8856beed65da 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -44,6 +44,8 @@ enum printk_info_flags {
 
 extern struct printk_ringbuffer *prb;
 
+extern bool have_boot_console;
+
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
@@ -75,6 +77,55 @@ u64 cons_read_seq(struct console *con);
 void cons_nobkl_cleanup(struct console *con);
 bool cons_nobkl_init(struct console *con);
 bool cons_alloc_percpu_data(struct console *con);
+void cons_kthread_create(struct console *con);
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
 
 #else
 
@@ -82,6 +133,9 @@ bool cons_alloc_percpu_data(struct console *con);
 #define PRINTK_MESSAGE_MAX	0
 #define PRINTKRB_RECORD_MAX	0
 
+static inline void cons_kthread_wake(struct console *con) { }
+static inline void cons_kthread_create(struct console *con) { }
+
 /*
  * In !PRINTK builds we still export console_sem
  * semaphore and some of console functions (console_unlock()/etc.), so
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index eab0358baa6f..4c6abb033ec1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2723,45 +2723,6 @@ static bool abandon_console_lock_in_panic(void)
 	return atomic_read(&panic_cpu) != raw_smp_processor_id();
 }
 
-/*
- * Check if the given console is currently capable and allowed to print
- * records. If the caller only works with certain types of consoles, the
- * caller is responsible for checking the console type before calling
- * this function.
- */
-static inline bool console_is_usable(struct console *con, short flags)
-{
-	if (!(flags & CON_ENABLED))
-		return false;
-
-	if ((flags & CON_SUSPENDED))
-		return false;
-
-	/*
-	 * The usability of a console varies depending on whether
-	 * it is a NOBKL console or not.
-	 */
-
-	if (flags & CON_NO_BKL) {
-		if (have_boot_console)
-			return false;
-
-	} else {
-		if (!con->write)
-			return false;
-		/*
-		 * Console drivers may assume that per-cpu resources have
-		 * been allocated. So unless they're explicitly marked as
-		 * being able to cope (CON_ANYTIME) don't call them until
-		 * this CPU is officially up.
-		 */
-		if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
-			return false;
-	}
-
-	return true;
-}
-
 static void __console_unlock(void)
 {
 	console_locked = 0;
@@ -3573,10 +3534,14 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	struct console *c;
+	bool is_boot_con;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
 
+	is_boot_con = console->flags & CON_BOOT;
+
 	con_printk(KERN_INFO, console, "disabled\n");
 
 	res = _braille_unregister_console(console);
@@ -3620,6 +3585,15 @@ static int unregister_console_locked(struct console *console)
 	if (console->exit)
 		res = console->exit(console);
 
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
 
diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
index 5c591bced1be..bc3b69223897 100644
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -5,6 +5,8 @@
 #include <linux/kernel.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/slab.h>
 #include "printk_ringbuffer.h"
 #include "internal.h"
 /*
@@ -700,6 +702,7 @@ static bool __cons_try_acquire(struct cons_context *ctxt)
 	/* Set up the new state for takeover */
 	copy_full_state(new, old);
 	new.locked = 1;
+	new.thread = ctxt->thread;
 	new.cur_prio = ctxt->prio;
 	new.req_prio = CONS_PRIO_NONE;
 	new.cpu = cpu;
@@ -714,6 +717,14 @@ static bool __cons_try_acquire(struct cons_context *ctxt)
 		goto success;
 	}
 
+	/*
+	 * A threaded printer context will never spin or perform a
+	 * hostile takeover. The atomic writer will wake the thread
+	 * when it is done with the important output.
+	 */
+	if (ctxt->thread)
+		return false;
+
 	/*
 	 * If the active context is on the same CPU then there is
 	 * obviously no handshake possible.
@@ -871,6 +882,9 @@ static bool __cons_release(struct cons_context *ctxt)
 	return true;
 }
 
+static bool printk_threads_enabled __ro_after_init;
+static bool printk_force_atomic __initdata;
+
 /**
  * cons_release - Release the console after output is done
  * @ctxt:	The acquire context that contains the state
@@ -1141,7 +1155,7 @@ static bool cons_get_record(struct cons_write_context *wctxt)
  * When true is returned, @wctxt->ctxt.backlog indicates whether there are
  * still records pending in the ringbuffer,
  */
-static int __maybe_unused cons_emit_record(struct cons_write_context *wctxt)
+static bool cons_emit_record(struct cons_write_context *wctxt)
 {
 	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 	struct console *con = ctxt->console;
@@ -1176,6 +1190,8 @@ static int __maybe_unused cons_emit_record(struct cons_write_context *wctxt)
 
 	if (!ctxt->thread && con->write_atomic) {
 		done = con->write_atomic(con, wctxt);
+	} else if (ctxt->thread && con->write_thread) {
+		done = con->write_thread(con, wctxt);
 	} else {
 		cons_release(ctxt);
 		WARN_ON_ONCE(1);
@@ -1203,6 +1219,243 @@ static int __maybe_unused cons_emit_record(struct cons_write_context *wctxt)
 	return cons_seq_try_update(ctxt);
 }
 
+/**
+ * cons_kthread_should_wakeup - Check whether the printk thread should wakeup
+ * @con:	Console to operate on
+ * @ctxt:	The acquire context that contains the state
+ *		at console_acquire()
+ *
+ * Returns: True if the thread should shutdown or if the console is allowed to
+ * print and a record is available. False otherwise
+ *
+ * After the thread wakes up, it must first check if it should shutdown before
+ * attempting any printing.
+ */
+static bool cons_kthread_should_wakeup(struct console *con, struct cons_context *ctxt)
+{
+	bool is_usable;
+	short flags;
+	int cookie;
+
+	if (kthread_should_stop())
+		return true;
+
+	cookie = console_srcu_read_lock();
+	flags = console_srcu_read_flags(con);
+	is_usable = console_is_usable(con, flags);
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
+	struct console *con = __console;
+	struct cons_write_context wctxt = {
+		.ctxt.console	= con,
+		.ctxt.prio	= CONS_PRIO_NORMAL,
+		.ctxt.thread	= 1,
+	};
+	struct cons_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
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
+		ret = rcuwait_wait_event(&con->rcuwait,
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
+			cookie = console_srcu_read_lock();
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
+			con_flags = console_srcu_read_flags(con);
+
+			if (console_is_usable(con, con_flags)) {
+				/*
+				 * If the emit fails, this context is no
+				 * longer the owner. Abort the processing and
+				 * wait for new records to print.
+				 */
+				if (!cons_emit_record(&wctxt))
+					break;
+				backlog = ctxt->backlog;
+			} else {
+				backlog = false;
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
+	con->kthread = NULL;
+
+	kfree(con->thread_pbufs);
+	con->thread_pbufs = NULL;
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
+	have_boot_console = false;
+
+	con->thread_pbufs = kmalloc(sizeof(*con->thread_pbufs), GFP_KERNEL);
+	if (!con->thread_pbufs) {
+		con_printk(KERN_ERR, con, "failed to allocate printing thread buffers\n");
+		return;
+	}
+
+	kt = kthread_run(cons_kthread_func, con, "pr/%s%d", con->name, con->index);
+	if (IS_ERR(kt)) {
+		con_printk(KERN_ERR, con, "failed to start printing thread\n");
+		kfree(con->thread_pbufs);
+		con->thread_pbufs = NULL;
+		return;
+	}
+
+	con->kthread = kt;
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
+	printk_threads_enabled = true;
+	for_each_console(con)
+		cons_kthread_create(con);
+	console_list_unlock();
+	return 0;
+}
+early_initcall(printk_setup_threads);
+
 /**
  * cons_nobkl_init - Initialize the NOBKL console specific data
  * @con:	Console to initialize
@@ -1216,9 +1469,12 @@ bool cons_nobkl_init(struct console *con)
 	if (!cons_alloc_percpu_data(con))
 		return false;
 
+	rcuwait_init(&con->rcuwait);
+	atomic_set(&con->kthread_waiting, 0);
 	cons_state_set(con, CON_STATE_CUR, &state);
 	cons_state_set(con, CON_STATE_REQ, &state);
 	cons_seq_init(con);
+	cons_kthread_create(con);
 	return true;
 }
 
@@ -1230,6 +1486,7 @@ void cons_nobkl_cleanup(struct console *con)
 {
 	struct cons_state state = { };
 
+	cons_kthread_stop(con);
 	cons_state_set(con, CON_STATE_CUR, &state);
 	cons_state_set(con, CON_STATE_REQ, &state);
 	cons_free_percpu_data(con);
-- 
2.30.2

