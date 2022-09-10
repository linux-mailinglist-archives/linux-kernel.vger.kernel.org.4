Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5FA5B4A99
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiIJWag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiIJW3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:29:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5877459B3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:15 -0700 (PDT)
Message-ID: <20220910222301.881787284@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ITvwnhbMRopkU0uxXaBKIS73OwMZbbp3Ns73njgnTns=;
        b=XQ6dwSdqrlUVAuW3dX/LuWdVHeZpXNuW3M3+eyEcQZdTBGwFiooRC8wSHLNwFpOv+L/ARH
        k58mDsb4ZRQsfEdfEA1L4xjPT0+WEClV3odQlhH7DxneySw58JPc4hjhIJfT45sFZ2F5gG
        +0KZHXokixbeDTskHf7UbF73+nTQY81EDmiqJqlzn2lUmEKHlDwy5GKahwxAL3qzZbugww
        9TUaw6X6BXjKOyQODIa+M9XS5QqrJdwn14WjAprE/g5RLVLLTriqR4Ql7gzM5U6aZ0eoF4
        rrLlX0dOjJNg+QviT12lCampD9AoI0OgSQnqAHdNyuZCY3qsQG1z6XRsu2hfdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ITvwnhbMRopkU0uxXaBKIS73OwMZbbp3Ns73njgnTns=;
        b=v8KQzrfnlvNiRc91Fuxuq5tIQO3uH/GaInbYC1wywePeZeEix9WhTTbTfYFQL32ZzxigNg
        GUF9GXZn1tJrjADw==
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
Subject: [patch RFC 26/29] printk: Add threaded printing support
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:28:12 +0200 (CEST)
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

Add the infrastructure to create a printer thread per console along with
the required thread function which is takeover/handover aware.

Signed-off-by: John Ogness <jogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h      |   12 ++
 kernel/printk/printk_nobkl.c |  207 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 214 insertions(+), 5 deletions(-)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -17,6 +17,7 @@
 #include <linux/atomic.h>
 #include <linux/bits.h>
 #include <linux/rculist.h>
+#include <linux/rcuwait.h>
 #include <linux/types.h>
 
 struct vc_data;
@@ -357,6 +358,12 @@ struct cons_context_data {
  *
  * @atomic_state:	State array for non-BKL consoles. Real and handover
  * @atomic_seq:		Sequence for record tracking (32bit only)
+ * @kthread:		Pointer to kernel thread
+ * @rcuwait:		RCU wait for the kernel thread
+ * @kthread_running:	Indicator whether the kthread is running
+ * @thread_txtbuf:	Pointer to thread private buffer
+ * @write_atomic:	Write callback for atomic context
+ * @write_thread:	Write callback for threaded printing
  * @pcpu_data:		Pointer to percpu context data
  * @ctxt_data:		Builtin context data for early boot and threaded printing
  */
@@ -384,8 +391,13 @@ struct console {
 #ifndef CONFIG_64BIT
 	atomic_t __private	atomic_seq;
 #endif
+	struct task_struct	*kthread;
+	struct rcuwait		rcuwait;
+	atomic_t		kthread_running;
+	struct cons_text_buf	*thread_txtbuf;
 
 	bool (*write_atomic)(struct console *con, struct cons_write_context *wctxt);
+	bool (*write_thread)(struct console *con, struct cons_write_context *wctxt);
 
 	struct cons_context_data __percpu	*pcpu_data;
 	struct cons_context_data		ctxt_data;
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -50,6 +50,8 @@
  */
 
 #ifdef CONFIG_PRINTK
+static bool printk_threads_enabled __ro_after_init;
+static bool printk_force_atomic __initdata;
 
 static bool cons_release(struct cons_context *ctxt);
 
@@ -238,8 +240,8 @@ static void cons_context_set_text_buf(st
 {
 	struct console *con = ctxt->console;
 
-	/* Early boot or allocation fail? */
-	if (!con->pcpu_data)
+	/* Early boot, allocation fail or thread context? */
+	if (!con->pcpu_data || ctxt->thread)
 		ctxt->txtbuf = &con->ctxt_data.txtbuf;
 	else
 		ctxt->txtbuf = &(this_cpu_ptr(con->pcpu_data)->txtbuf);
@@ -840,6 +842,8 @@ static bool __maybe_unused cons_release(
 {
 	bool ret = __cons_release(ctxt);
 
+	/* Invalidate the record pointer. It's not longer valid */
+	ctxt->txtbuf = NULL;
 	ctxt->state.atom = 0;
 	return ret;
 }
@@ -1022,10 +1026,9 @@ static bool cons_fill_outbuf(struct cons
 static bool cons_get_record(struct cons_write_context *wctxt)
 {
 	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
-	struct console *con = ctxt->console;
 	struct cons_outbuf_desc desc = {
 		.txtbuf		= ctxt->txtbuf,
-		.extmsg		= con->flags & CON_EXTENDED,
+		.extmsg		= ctxt->console->flags & CON_EXTENDED,
 		.seq		= ctxt->newseq,
 		.dropped	= ctxt->dropped,
 	};
@@ -1054,7 +1057,7 @@ static bool cons_get_record(struct cons_
  * If it returns true @wctxt->ctxt.backlog indicates whether there are
  * still records pending in the ringbuffer,
  */
-static int __maybe_unused cons_emit_record(struct cons_write_context *wctxt)
+static bool cons_emit_record(struct cons_write_context *wctxt)
 {
 	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 	struct console *con = ctxt->console;
@@ -1089,6 +1092,8 @@ static int __maybe_unused cons_emit_reco
 
 	if (!ctxt->thread && con->write_atomic) {
 		done = con->write_atomic(con, wctxt);
+	} else if (ctxt->thread && con->write_thread) {
+		done = con->write_thread(con, wctxt);
 	} else {
 		cons_release(ctxt);
 		WARN_ON_ONCE(1);
@@ -1111,6 +1116,194 @@ static int __maybe_unused cons_emit_reco
 }
 
 /**
+ * cons_kthread_should_run - Check whether the printk thread should run
+ * @con:	Console to operate on
+ * @ctxt:	The acquire context which contains the state
+ *		at console_acquire()
+ */
+static bool cons_kthread_should_run(struct console *con, struct cons_context *ctxt)
+{
+	if (kthread_should_stop())
+		return true;
+
+	/* This reads state and sequence on 64bit. On 32bit only state */
+	cons_state_read(con, STATE_REAL, &ctxt->state);
+	/* Bring the sequence in @ctxt up to date */
+	cons_context_sequence_init(ctxt);
+
+	if (!cons_state_ok(ctxt->state))
+		return false;
+
+	/*
+	 * Atomic printing is running on some other CPU. The owner
+	 * will wake the console thread on unlock if necessary.
+	 */
+	if (ctxt->state.locked)
+		return false;
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
+	int ret;
+
+	atomic_set(&con->kthread_running, 1);
+
+	for (;;) {
+		atomic_dec(&con->kthread_running);
+		/*
+		 * Provides a full memory barrier vs. cons_kthread_wake().
+		 */
+		ret = rcuwait_wait_event(&con->rcuwait, cons_kthread_should_run(con, ctxt),
+					 TASK_INTERRUPTIBLE);
+
+		if (kthread_should_stop())
+			break;
+
+		atomic_inc(&con->kthread_running);
+
+		/* Wait was interrupted by a spurious signal, go back to sleep */
+		if (ret)
+			continue;
+
+		for (;;) {
+			bool backlog;
+
+			/*
+			 * Ensure this stays on the CPU to make handover and
+			 * takeover possible.
+			 */
+			migrate_disable();
+
+			/*
+			 * Try to acquire the console without attempting to
+			 * take over.  If an atomic printer wants to hand
+			 * back to the thread it simply wakes it up.
+			 */
+			if (!cons_try_acquire(ctxt))
+				break;
+
+			/* Stop when the console was handed/taken over */
+			if (!cons_emit_record(&wctxt))
+				break;
+
+			backlog = ctxt->backlog;
+
+			/* Stop when the console was handed/taken over */
+			if (!cons_release(ctxt))
+				break;
+
+			/* Backlog done? */
+			if (!backlog)
+				break;
+
+			migrate_enable();
+			cond_resched();
+		}
+		migrate_enable();
+	}
+	return 0;
+}
+
+/**
+ * cons_kthread_wake - Wake up a printk thread
+ * @con:	Console to operate on
+ */
+static inline void cons_kthread_wake(struct console *con)
+{
+	rcuwait_wake_up(&con->rcuwait);
+}
+
+/**
+ * cons_kthread_stop - Stop a printk thread
+ * @con:	Console to operate on
+ */
+static void cons_kthread_stop(struct console *con)
+{
+	struct task_struct *kt;
+
+	lockdep_assert_held(&console_mutex);
+
+	if (!con->kthread)
+		return;
+
+	/*
+	 * Nothing else than the thread itself can see @con->kthread
+	 * anymore. @con is unhashed and all list walkers are synchronized.
+	 */
+	kt = con->kthread;
+	con->kthread = NULL;
+	kthread_stop(kt);
+
+	kfree(con->thread_txtbuf);
+	con->thread_txtbuf = NULL;
+}
+
+/**
+ * cons_kthread_create - Create a printk thread
+ * @con:	Console to operate on
+ *
+ * If it fails, let the console proceed. The atomic part might
+ * be usable and useful.
+ */
+static void cons_kthread_create(struct console *con)
+{
+	struct task_struct *kt;
+
+	lockdep_assert_held(&console_mutex);
+
+	if (!(con->flags & CON_NO_BKL) || !con->write_thread)
+		return;
+
+	if (!printk_threads_enabled || con->kthread)
+		return;
+
+	con->thread_txtbuf = kmalloc(sizeof(*con->thread_txtbuf), GFP_KERNEL);
+	if (!con->thread_txtbuf) {
+		con_printk(KERN_ERR, con, "unable to allocate memory for printing thread\n");
+		return;
+	}
+
+	kt = kthread_run(cons_kthread_func, con, "pr/%s%d", con->name, con->index);
+	if (IS_ERR(kt)) {
+		con_printk(KERN_ERR, con, "unable to start printing thread\n");
+		kfree(con->thread_txtbuf);
+		con->thread_txtbuf = NULL;
+		return;
+	}
+
+	con->kthread = kt;
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
+	for_each_registered_console(con)
+		cons_kthread_create(con);
+	console_list_unlock();
+	return 0;
+}
+early_initcall(printk_setup_threads);
+
+/**
  * cons_nobkl_init - Initialize the NOBKL console state
  * @con:	Console to initialize
  */
@@ -1123,7 +1316,10 @@ static void cons_nobkl_init(struct conso
 
 	cons_alloc_percpu_data(con);
 	cons_forward_sequence(con);
+	rcuwait_init(&con->rcuwait);
+	cons_kthread_create(con);
 	cons_state_set(con, STATE_REAL, &state);
+	cons_kthread_wake(con);
 }
 
 /**
@@ -1134,6 +1330,7 @@ static void cons_nobkl_cleanup(struct co
 {
 	struct cons_state state = { };
 
+	cons_kthread_stop(con);
 	cons_state_set(con, STATE_REAL, &state);
 	cons_free_percpu_data(con);
 }

