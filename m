Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30946C6E25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjCWQwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjCWQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:52:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D47DA;
        Thu, 23 Mar 2023 09:52:31 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:52:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679590349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FB+gp/52L/e/3HLibUapo04FK7VuLMzRq9iLfC2ifGw=;
        b=1Wnv7ClRE/cylYVg2H+QBF2KdRA91kAMmZSmN9KxwLPkGAODiY8YWUTxPLmeZ2Uu04BtQu
        sAEpeP6L2V1eKAvVmfWFgwJxmBuSjEiFG+GOSow0QHkY4l1FsR10JKsrnCi2357Ep32yiY
        MhFM0eLnxb/JHZtnMR8P3Og5/r8uwh2tyR8uoBEbDJK8WtGuJDiU7w7rHJ4DlDgZkvLXH7
        kcExAfNyJXiKFrKaJYIH24HHyziAt2EdvCqej6yx97tNPZvA4XcWVX9XGT/1YL1TJKCPwH
        aalsiXam27ZkmH5Lioga1EKoXPyDW1N2SbZ+LpnUHxTWJe2r/2mmb+Os0ntxKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679590349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FB+gp/52L/e/3HLibUapo04FK7VuLMzRq9iLfC2ifGw=;
        b=tPOK4XlnqERujDtT33mpBQMGUrmlaCIKAXG3Diw+GkOOj2YtDCc4QfEJqCpPQ+e401gjGR
        q+QPVmHCsyG3qSAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.3-rc3-rt5
Message-ID: <20230323165228.X-6qUJBI@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.3-rc3-rt5 patch set. 

Changes since v6.3-rc3-rt4:

  - Small updates to the printk series.

  - Mel Gorman reported that LTP's dio_truncate does not complete on
    PREEMPT_RT because rw_semaphore and rwlock_t locks are always unfair
    to writers. This has been changed by forcing the reader into to slow
    path and so allowing the writer to obtain the lock.

  - Crystal Wood reported that a filesystem (XFS) may deadlock while
    flushing during schedule. This has been mitigated by flushing IO
    before blocking on a lock.
    As a side effect, there will be more flushed IO with RTMUTEX
    debugging enabled because here the fast-path fails always (in order
    to use the slowpath for testing).

  - The TPM and zram patch was slightly altered while they have been
    reposted.

Known issues:
	None.

The delta patch against v6.3-rc3-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/incr/patch-6.3-rc3-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.3-rc3-rt5

The RT patch against v6.3-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patch-6.3-rc3-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patches-6.3-rc3-rt5.tar.xz

Sebastian

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 5d778ea926f3f..513e0d1c349a6 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -53,7 +53,7 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
 #ifdef CONFIG_PREEMPT_RT
 /*
  * Flushes previous write operations to chip so that a subsequent
- * ioread*()s won't stall a cpu.
+ * ioread*()s won't stall a CPU.
  */
 static inline void tpm_tis_flush(void __iomem *iobase)
 {
diff --git a/include/linux/console.h b/include/linux/console.h
index ae4bbec59eea8..1e9d5bc8fa76e 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -490,21 +490,21 @@ static inline bool console_is_registered(const struct console *con)
 	hlist_for_each_entry(con, &console_list, node)
 
 #ifdef CONFIG_PRINTK
+extern enum cons_prio cons_atomic_enter(enum cons_prio prio);
+extern void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio);
 extern bool console_can_proceed(struct cons_write_context *wctxt);
 extern bool console_enter_unsafe(struct cons_write_context *wctxt);
 extern bool console_exit_unsafe(struct cons_write_context *wctxt);
 extern bool console_try_acquire(struct cons_write_context *wctxt);
 extern bool console_release(struct cons_write_context *wctxt);
-extern enum cons_prio cons_atomic_enter(enum cons_prio prio);
-extern void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio);
 #else
+static inline enum cons_prio cons_atomic_enter(enum cons_prio prio) { return CONS_PRIO_NONE; }
+static inline void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio) { }
 static inline bool console_can_proceed(struct cons_write_context *wctxt) { return false; }
 static inline bool console_enter_unsafe(struct cons_write_context *wctxt) { return false; }
 static inline bool console_exit_unsafe(struct cons_write_context *wctxt) { return false; }
 static inline bool console_try_acquire(struct cons_write_context *wctxt) { return false; }
 static inline bool console_release(struct cons_write_context *wctxt) { return false; }
-static inline enum cons_prio cons_atomic_enter(enum cons_prio prio) { return CONS_PRIO_NONE; }
-static inline void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio) { }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 728f434de2bbf..c1bc2cb1522cb 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -23,6 +23,7 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/wake_q.h>
 #include <linux/ww_mutex.h>
+#include <linux/blkdev.h>
 
 #include <trace/events/lock.h>
 
@@ -1700,6 +1701,12 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
 
+	/*
+	 * If we are going to sleep and we have plugged IO queued, make sure to
+	 * submit it to avoid deadlocks.
+	 */
+	blk_flush_plug(current->plug, true);
+
 	return rt_mutex_slowlock(lock, NULL, state);
 }
 #endif /* RT_MUTEX_BUILD_MUTEX */
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index c201aadb93017..96042dca2fd97 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -72,15 +72,6 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 	int ret;
 
 	raw_spin_lock_irq(&rtm->wait_lock);
-	/*
-	 * Allow readers, as long as the writer has not completely
-	 * acquired the semaphore for write.
-	 */
-	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
-		atomic_inc(&rwb->readers);
-		raw_spin_unlock_irq(&rtm->wait_lock);
-		return 0;
-	}
 
 	/*
 	 * Call into the slow lock path with the rtmutex->wait_lock
@@ -143,6 +134,14 @@ static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
 	if (rwbase_read_trylock(rwb))
 		return 0;
 
+	if (state != TASK_RTLOCK_WAIT) {
+		/*
+		 * If we are going to sleep and we have plugged IO queued,
+		 * make sure to submit it to avoid deadlocks.
+		 */
+		blk_flush_plug(current->plug, true);
+	}
+
 	return __rwbase_read_lock(rwb, state);
 }
 
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
index d1473c624105c..472e3622abf09 100644
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -67,6 +67,11 @@ __ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx,
 			ww_mutex_set_context_fastpath(lock, ww_ctx);
 		return 0;
 	}
+	/*
+	 * If we are going to sleep and we have plugged IO queued, make sure to
+	 * submit it to avoid deadlocks.
+	 */
+	blk_flush_plug(current->plug, true);
 
 	ret = rt_mutex_slowlock(&rtm->rtmutex, ww_ctx, state);
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index fb363b495ce92..6631fd70542f9 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -58,6 +58,16 @@ __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
 
 bool printk_percpu_data_ready(void);
 
+/*
+ * The printk_safe_enter()/_exit() macros mark code blocks using locks that
+ * would lead to deadlock if an interrupting context were to call printk()
+ * while the interrupted context was within such code blocks.
+ *
+ * When a CPU is in such a code block, an interrupting context calling
+ * printk() will only log the new message to the lockless ringbuffer and
+ * then trigger console printing using irqwork.
+ */
+
 #define printk_safe_enter_irqsave(flags)	\
 	do {					\
 		__printk_safe_enter(&flags);	\
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f733204f33ee5..e2466366d4f84 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -318,10 +318,6 @@ static int __down_trylock_console_sem(unsigned long ip)
 	int lock_failed;
 	unsigned long flags;
 
-	/* Semaphores are not NMI-safe. */
-	if (in_nmi())
-		return 1;
-
 	/*
 	 * Here and in __up_console_sem() we need to be in safe mode,
 	 * because spindump/WARN/etc from under console ->lock will
@@ -3150,6 +3146,10 @@ void console_unblank(void)
 	 * In that case, attempt a trylock as best-effort.
 	 */
 	if (oops_in_progress) {
+		/* Semaphores are not NMI-safe. */
+		if (in_nmi())
+			return;
+
 		if (down_trylock_console_sem() != 0)
 			return;
 	} else
@@ -3210,8 +3210,12 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	 * that messages are flushed out.  As this can be called from any
 	 * context and we don't want to get preempted while flushing,
 	 * ensure may_schedule is cleared.
+	 *
+	 * Since semaphores are not NMI-safe, the console lock must be
+	 * ignored if the panic is in NMI context.
 	 */
-	console_trylock();
+	if (!in_nmi())
+		console_trylock();
 	console_may_schedule = 0;
 
 	if (mode == CONSOLE_REPLAY_ALL) {
@@ -3226,7 +3230,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		}
 		console_srcu_read_unlock(cookie);
 	}
-	console_unlock();
+	if (!in_nmi())
+		console_unlock();
 }
 
 /*
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 9cd33cddef9fc..5c1470bd60bcb 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -24,6 +24,7 @@ static DEFINE_PER_CPU(struct printk_context, printk_context) = {
 /* Can be preempted by NMI. */
 void __printk_safe_enter(unsigned long *flags)
 {
+	WARN_ON_ONCE(in_nmi());
 	local_lock_irqsave(&printk_context.cpu, *flags);
 	this_cpu_inc(printk_context.recursion);
 }
@@ -31,6 +32,7 @@ void __printk_safe_enter(unsigned long *flags)
 /* Can be preempted by NMI. */
 void __printk_safe_exit(unsigned long *flags)
 {
+	WARN_ON_ONCE(in_nmi());
 	this_cpu_dec(printk_context.recursion);
 	local_unlock_irqrestore(&printk_context.cpu, *flags);
 }
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
