Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E556A89EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCBT6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCBT5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081E48E00
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:48 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQaoWu8ziTxaQYkBHImtYGFT53DoX5McXDIC69zOSXc=;
        b=vibtepaI9AQNACjD92h8htstYfM9lD/KWP1JQ1XJ3hDVDY86RX43hZvBOksmIXv7fT+9cF
        LmOlLc8Dia6xYHOxJ940DMENQH5+5lpSgOcfnEtogxaUasq4yMGESGxKXCFRaygDG7pl98
        eOoR1wp+WSj1pju5NqKI3Y00cIF1mZHBXDSyPoxGZYzNSrKQbhpIGjIWLznMfouQmnHYBA
        yOnpmsVDjZVJTG+gvTQEhEz1ENW32/Vk2j2C5KivaWstvQhp/824zUgG2OYJ4+gxhq6Rht
        YG5XwiigT3MT0ETCyXCzBAjnU3HaTngiepoRPvLtQx/zKVCXBitqJUssw2ar1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQaoWu8ziTxaQYkBHImtYGFT53DoX5McXDIC69zOSXc=;
        b=liDqf5RNe8L2vRWh6DMg0qe8spuli+CLZsev5BebWhi6aIE0/2dTfJCB3HiJP55XfbUNvq
        fj2V3mycATkGbXDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 14/18] printk: nobkl: Provide functions for atomic write enforcement
Date:   Thu,  2 Mar 2023 21:02:14 +0106
Message-Id: <20230302195618.156940-15-john.ogness@linutronix.de>
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

Threaded printk is the preferred mechanism to tame the noisyness of
printk, but WARN/OOPS/PANIC require printing out immediately since
the printer threads might not be able to run.

Add per CPU state to denote the priority/urgency of the output and
provide functions to flush the printk backlog for priority elevated
contexts and when the printing threads are not available (such as
early boot).

Note that when a CPU is in a priority elevated state, flushing only
occurs when dropping back to a lower priority. This allows the full
set of printk records (WARN/OOPS/PANIC output) to be stored in the
ringbuffer before beginning to flush the backlog.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h      |   8 ++
 include/linux/printk.h       |   9 ++
 kernel/printk/printk.c       |  35 +++--
 kernel/printk/printk_nobkl.c | 240 +++++++++++++++++++++++++++++++++++
 4 files changed, 283 insertions(+), 9 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 089a94a3dd8d..afc683e722bb 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -494,6 +494,14 @@ extern bool console_exit_unsafe(struct cons_write_context *wctxt);
 extern bool console_try_acquire(struct cons_write_context *wctxt);
 extern bool console_release(struct cons_write_context *wctxt);
 
+#ifdef CONFIG_PRINTK
+extern enum cons_prio cons_atomic_enter(enum cons_prio prio);
+extern void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio);
+#else
+static inline enum cons_prio cons_atomic_enter(enum cons_prio prio) { return CONS_PRIO_NONE; }
+static inline void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio) { }
+#endif
+
 extern int console_set_on_cmdline;
 extern struct console *early_console;
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1e..d2aafc79b611 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -139,6 +139,7 @@ void early_printk(const char *s, ...) { }
 #endif
 
 struct dev_printk_info;
+struct cons_write_context;
 
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(4, 0)
@@ -192,6 +193,8 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+extern void cons_atomic_flush(struct cons_write_context *printk_caller_wctxt,
+			      bool skip_unsafe);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -271,6 +274,12 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+
+static inline void cons_atomic_flush(struct cons_write_context *printk_caller_wctxt,
+				     bool skip_unsafe)
+{
+}
+
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 19f682fcae10..015c240f9f04 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2304,6 +2304,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
+	struct cons_write_context wctxt = { };
 	int printed_len;
 	bool in_sched = false;
 
@@ -2324,16 +2325,25 @@ asmlinkage int vprintk_emit(int facility, int level,
 
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
+	/*
+	 * Flush the non-BKL consoles. This only leads to direct atomic
+	 * printing for non-BKL consoles that do not have a printer
+	 * thread available. Otherwise the printer thread will perform
+	 * the printing.
+	 */
+	cons_atomic_flush(&wctxt, true);
+
 	/* If called from the scheduler, we can not call up(). */
 	if (!in_sched && have_bkl_console) {
-		/*
-		 * The caller may be holding system-critical or
-		 * timing-sensitive locks. Disable preemption during
-		 * printing of all remaining records to all consoles so that
-		 * this context can return as soon as possible. Hopefully
-		 * another printk() caller will take over the printing.
-		 */
-		preempt_disable();
 		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore. The release will print out buffers. With the
@@ -2342,9 +2352,10 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 */
 		if (console_trylock_spinning())
 			console_unlock();
-		preempt_enable();
 	}
 
+	preempt_enable();
+
 	cons_wake_threads();
 	if (in_sched)
 		defer_console_output();
@@ -3943,6 +3954,12 @@ void defer_console_output(void)
 
 void printk_trigger_flush(void)
 {
+	struct cons_write_context wctxt = { };
+
+	preempt_disable();
+	cons_atomic_flush(&wctxt, true);
+	preempt_enable();
+
 	cons_wake_threads();
 	defer_console_output();
 }
diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
index 890fc8d44f1d..001a1ca9793f 100644
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -1399,6 +1399,246 @@ void cons_wake_threads(void)
 	console_srcu_read_unlock(cookie);
 }
 
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
+static bool cons_atomic_try_acquire(struct console *con, struct cons_context *ctxt,
+				    enum cons_prio prio, bool skip_unsafe)
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
+	if (!ctxt->old_state.unsafe || !skip_unsafe)
+		ctxt->hostile = 1;
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
+static void cons_atomic_flush_con(struct cons_write_context *wctxt, struct console *con,
+				  enum cons_prio prio, bool skip_unsafe)
+{
+	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	bool wake_thread = false;
+	short flags;
+
+	if (!cons_atomic_try_acquire(con, ctxt, prio, skip_unsafe))
+		return;
+
+	do {
+		flags = console_srcu_read_flags(con);
+
+		if (!console_is_usable(con, flags))
+			break;
+
+		/*
+		 * For normal prio messages let the printer thread handle
+		 * the printing if it is available.
+		 */
+		if (prio <= CONS_PRIO_NORMAL && con->kthread) {
+			wake_thread = true;
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
+void cons_atomic_flush(struct cons_write_context *printk_caller_wctxt, bool skip_unsafe)
+{
+	struct cons_write_context *wctxt;
+	struct cons_cpu_state *cpu_state;
+	struct console *con;
+	short flags;
+	int cookie;
+
+	cpu_state = cons_get_cpu_state();
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
+	 * cpu_state->prio <= CONS_PRIO_NORMAL is not subject to nesting
+	 * and can proceed in order to allow atomic printing when consoles
+	 * do not have a printer thread.
+	 */
+	if (cpu_state->prio > CONS_PRIO_NORMAL &&
+	    cpu_state->nesting[cpu_state->prio] != 1)
+		return;
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		if (!con->write_atomic)
+			continue;
+
+		flags = console_srcu_read_flags(con);
+
+		if (!console_is_usable(con, flags))
+			continue;
+
+		if (cpu_state->prio > CONS_PRIO_NORMAL || !con->kthread) {
+			if (printk_caller_wctxt)
+				wctxt = printk_caller_wctxt;
+			else
+				wctxt = cons_get_wctxt(con, cpu_state->prio);
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
+ * cons_atomic_exit - Exit a context that enforces atomic printing
+ * @prio:	Priority of the context to leave
+ * @prev_prio:	Priority of the previous context for restore
+ *
+ * @prev_prio is the priority returned by the corresponding cons_atomic_enter().
+ */
+void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio)
+{
+	struct cons_cpu_state *cpu_state;
+
+	cons_atomic_flush(NULL, true);
+
+	cpu_state = cons_get_cpu_state();
+
+	if (cpu_state->prio == CONS_PRIO_PANIC)
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
+	cpu_state->prio = prev_prio;
+
+	migrate_enable();
+}
+
 /**
  * cons_kthread_stop - Stop a printk thread
  * @con:	Console to operate on
-- 
2.30.2

