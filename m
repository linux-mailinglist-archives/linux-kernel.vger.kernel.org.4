Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D69D5B4A86
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiIJWas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiIJW3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:29:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6594362F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:18 -0700 (PDT)
Message-ID: <20220910222301.995758602@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VZUWuBMYzpylNgKty5AYXdXV5NIO5g3BN7mnRpIJyQI=;
        b=miw4BK4yfyLsSznSNCFH+QPZZMkQf8sjXxAwQ94j2ePBjarXEkM1RQThIWzU5MSy8/6zUc
        Lk9YlEBAv1GPsVH3BKu1lpl6WvOvzYCGbfh5e+krS63cSdRZjkC/GxoDaaCBNcPC4xIYkL
        9DXq+h+GdrJxDH7nH66hUPfJbRfKPWrHvM78bjgLWT3TTAvfJxpl82cYzBq0OGqUHuF27F
        QBJ3iNP70MbXaqz4cLtjcC+jsaGAve3QbaIT9G+ef5kwOOHK96TDeJRHgeWxJ+do+YSACJ
        UdNjn5J9rdWoHQUSS2kBKP58jn1nlVZyMZaW4lmgI2FETKlCvEDz4XBZwrmY1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VZUWuBMYzpylNgKty5AYXdXV5NIO5g3BN7mnRpIJyQI=;
        b=xk8vHRV0cwsYr2A7RNo8WDo0uuPCKYJ/VlyOBa7ShHBh9M3st77fC2XOs2XgqUbud2I33p
        xNZHXkM52nwFHXCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
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
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Ogness <jogness@linutronix.de>
Subject: [patch RFC 28/29] printk: Provide functions for atomic write enforcement
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:28:15 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <jogness@linutronix.de>

Threaded printk is the preferred mechanism to tame the noisyness of printk,
but WARN/OOPS/PANIC require to print out immediately as the printer threads
might not be able to run.

Add per CPU state which denotes the priority/urgency of the output and
provide functions which flush the printk backlog during early boot and in
priority elevated contexts.

Signed-off-by: John Ogness <jogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h      |    6 +
 kernel/printk/printk.c       |   26 +++--
 kernel/printk/printk_nobkl.c |  217 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+), 9 deletions(-)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,6 +16,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bits.h>
+#include <linux/irq_work.h>
 #include <linux/rculist.h>
 #include <linux/rcuwait.h>
 #include <linux/types.h>
@@ -367,6 +368,7 @@ struct cons_context_data {
  * @atomic_seq:		Sequence for record tracking (32bit only)
  * @kthread:		Pointer to kernel thread
  * @rcuwait:		RCU wait for the kernel thread
+ * @irq_work:		IRQ work for thread wakeup
  * @kthread_running:	Indicator whether the kthread is running
  * @thread_txtbuf:	Pointer to thread private buffer
  * @write_atomic:	Write callback for atomic context
@@ -400,6 +402,7 @@ struct console {
 #endif
 	struct task_struct	*kthread;
 	struct rcuwait		rcuwait;
+	struct irq_work		irq_work;
 	atomic_t		kthread_running;
 	struct cons_text_buf	*thread_txtbuf;
 
@@ -471,6 +474,9 @@ extern bool console_can_proceed(struct c
 extern bool console_enter_unsafe(struct cons_write_context *wctxt);
 extern bool console_exit_unsafe(struct cons_write_context *wctxt);
 
+extern enum cons_prio cons_atomic_enter(enum cons_prio prio);
+extern void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio);
+
 extern int console_set_on_cmdline;
 extern struct console *early_console;
 
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1072,6 +1072,8 @@ static inline void log_buf_add_cpu(void)
 #endif /* CONFIG_SMP */
 
 static void cons_alloc_percpu_data(struct console *con);
+static void cons_atomic_flush(void);
+static void cons_wake_threads(void);
 
 static void __init set_percpu_data_ready(void)
 {
@@ -2270,17 +2272,21 @@ asmlinkage int vprintk_emit(int facility
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
+	/*
+	 * The caller may be holding system-critical or
+	 * timing-sensitive locks. Disable preemption during
+	 * printing of all remaining records to all consoles so that
+	 * this context can return as soon as possible. Hopefully
+	 * another printk() caller will take over the printing.
+	 */
+	preempt_disable();
+
+	/* Flush the non-BKL consoles if required */
+	cons_atomic_flush();
+
 	/* If called from the scheduler, we can not call up(). */
 	if (!in_sched) {
 		/*
-		 * The caller may be holding system-critical or
-		 * timing-sensitive locks. Disable preemption during
-		 * printing of all remaining records to all consoles so that
-		 * this context can return as soon as possible. Hopefully
-		 * another printk() caller will take over the printing.
-		 */
-		preempt_disable();
-		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore. The release will print out buffers. With the
 		 * spinning variant, this context tries to take over the
@@ -2288,9 +2294,11 @@ asmlinkage int vprintk_emit(int facility
 		 */
 		if (console_trylock_spinning())
 			console_unlock();
-		preempt_enable();
 	}
 
+	preempt_enable();
+
+	cons_wake_threads();
 	wake_up_klogd();
 	return printed_len;
 }
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -1231,6 +1231,222 @@ static inline void cons_kthread_wake(str
 }
 
 /**
+ * cons_irq_work - irq work to wake printk thread
+ * @irq_work:	The irq work to operate on
+ */
+static void cons_irq_work(struct irq_work *irq_work)
+{
+	struct console *con = container_of(irq_work, struct console, irq_work);
+
+	cons_kthread_wake(con);
+}
+
+/**
+ * cons_wake_threads - Wake up printing threads
+ */
+static void cons_wake_threads(void)
+{
+	struct console *con;
+	int cookie;
+
+	cookie = srcu_read_lock(&console_srcu);
+	for_each_console_srcu(con) {
+		if (con->kthread && !atomic_read(&con->kthread_running))
+			irq_work_queue(&con->irq_work);
+	}
+	srcu_read_unlock(&console_srcu, cookie);
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
+	else
+		return this_cpu_ptr(&cons_pcpu_state);
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
+static struct cons_write_context *cons_get_wctxt(struct console *con,
+						 enum cons_prio prio)
+{
+	if (!con->pcpu_data)
+		return &con->ctxt_data.wctxt[prio];
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
+static bool cons_atomic_try_acquire(struct console *con, struct cons_context *ctxt,
+				    enum cons_prio prio)
+{
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->console		= con;
+	ctxt->spinwait_max_us	= 2000;
+	ctxt->prio		= prio;
+	ctxt->spinwait		= 1;
+
+	/* Try to acquire it directly or via a friendly handover */
+	if (cons_try_acquire(ctxt))
+		return true;
+
+	/* Investigate whether a hostile takeover is due */
+	if (ctxt->old_state.cur_prio >= prio)
+		return false;
+
+	ctxt->hostile = 1;
+	return cons_try_acquire(ctxt);
+}
+
+/**
+ * cons_atomic_flush_one - Flush one console in atomic mode
+ * @con:	The console to flush
+ * @prio:	The priority of the current context
+ */
+static void cons_atomic_flush_one(struct console *con, enum cons_prio prio)
+{
+	struct cons_write_context *wctxt = cons_get_wctxt(con, prio);
+	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	if (!cons_atomic_try_acquire(con, ctxt, prio))
+		return;
+
+	do {
+		/*
+		 * cons_emit_record() returns false when the console was
+		 * handed over or taken over. In both cases the context is
+		 * not longer valid.
+		 */
+		if (!cons_emit_record(wctxt))
+			return;
+	} while (ctxt->backlog);
+
+	cons_release(ctxt);
+}
+
+/**
+ * cons_atomic_flush - Flush consoles in atomic mode if required
+ */
+static void cons_atomic_flush(void)
+{
+	struct cons_cpu_state *cpu_state;
+	struct console *con;
+	int cookie;
+
+	cpu_state = cons_get_cpu_state();
+
+	/*
+	 * Let the outermost write of this priority print. This avoids
+	 * nasty hackery for nested WARN() where the printing itself
+	 * generates one.
+	 *
+	 * cpu_state->prio <= CONS_PRIO_NORMAL is not subject to nesting
+	 * and it can fall through for early boot and for consoles which do
+	 * not have a kthread (yet). For simplicity sake just fall through.
+	 */
+	if (cpu_state->prio > CONS_PRIO_NORMAL &&
+	    cpu_state->nesting[cpu_state->prio] != 1)
+		return;
+
+	cookie = srcu_read_lock(&console_srcu);
+	for_each_console_srcu(con) {
+		if (!con->write_atomic)
+			continue;
+
+		if (cpu_state->prio > CONS_PRIO_NORMAL || !con->kthread)
+			cons_atomic_flush_one(con, cpu_state->prio);
+	}
+	srcu_read_unlock(&console_srcu, cookie);
+}
+
+/**
+ * cons_atomic_enter - Enter a context which enforces atomic printing
+ * @prio:	Priority of the context
+ *
+ * Returns:	The previous priority which needs to be fed into
+ *		the corresponding cons_atomic_exit()
+ */
+enum cons_prio cons_atomic_enter(enum cons_prio prio)
+{
+	struct cons_cpu_state *cpu_state;
+	enum cons_prio prev_prio;
+
+	migrate_disable();
+	cpu_state = cons_get_cpu_state();
+
+	prev_prio = cpu_state->prio;
+	if (prev_prio < prio)
+		cpu_state->prio = prio;
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
+ * cons_atomic_exit - Exit a context which enforces atomic printing
+ * @prio:	Priority of the context to leave
+ * @prev_prio:	Priority of the previous context for restore
+ *
+ * @prev_prio is the priority returned by the corresponding cons_atomic_enter().
+ */
+void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio)
+{
+	struct cons_cpu_state *cpu_state;
+
+	cpu_state = cons_get_cpu_state();
+
+	/*
+	 * Undo the nesting of cons_atomic_enter() at the CPU state
+	 * priority.
+	 */
+	cpu_state->nesting[cpu_state->prio]--;
+
+	/*
+	 * Restore the previous priority which was returned by
+	 * cons_atomic_enter().
+	 */
+	cpu_state->prio = prev_prio;
+
+	migrate_enable();
+}
+
+/**
  * cons_kthread_stop - Stop a printk thread
  * @con:	Console to operate on
  */
@@ -1321,6 +1537,7 @@ static void cons_nobkl_init(struct conso
 	cons_alloc_percpu_data(con);
 	cons_forward_sequence(con);
 	rcuwait_init(&con->rcuwait);
+	init_irq_work(&con->irq_work, cons_irq_work);
 	cons_kthread_create(con);
 	cons_state_set(con, STATE_REAL, &state);
 	cons_kthread_wake(con);

