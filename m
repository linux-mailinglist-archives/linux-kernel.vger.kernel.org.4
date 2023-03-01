Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7476F6A6E40
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCAOTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjCAOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7E22BF1B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:12 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFuN72QUR/n6TFBpH6jGwM/fR1ePAiONUmDEuywEKXs=;
        b=PNc2YyDdI6KSTzwKK5ZgENc6YvtSeFHLyWCmQ3VuF9VDC/PAiwG5qq8C0g3UuXzRyjG6uX
        Zx2Dmkhcdx0Ffw4aY1JJEyLLnY6CQ6xdiIbe4a9lc4abdJAzCI35GOM77LV05L9QNL7dqa
        IvxFiXix2VtO3YEQx+ljzt4efam+sz+9s8ntXSutVHBXVLRmHMSjF8WcFZzqp2OAM95PYL
        VBYhR6vGzq7jh/MVtNrR90QQTMtAZW3EXSDKbbXxPEeBgJy+yahCHZC+5N5h7E/j/+l4iq
        0AMBt6cJEaSaw2J2u3t/qOxtn7/jKWYAt7ANL6Wjm6KvjLkvEv/a1fjWPxvWVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFuN72QUR/n6TFBpH6jGwM/fR1ePAiONUmDEuywEKXs=;
        b=WEsHSE3dE0sBi2kXUp25bxnvoTYgWHirqXw6wzXWxZ9Vr/Ziaf0Kt0v6bw2uXqOmEqRPrY
        uiZLFfItP5dxi6Bg==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v5 18/18] timer: Always queue timers on the local CPU
Date:   Wed,  1 Mar 2023 15:17:44 +0100
Message-Id: <20230301141744.16063-19-anna-maria@linutronix.de>
In-Reply-To: <20230301141744.16063-1-anna-maria@linutronix.de>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer pull model is in place so we can remove the heuristics which try
to guess the best target CPU at enqueue/modification time.

All non pinned timers are queued on the local CPU in the seperate storage
and eventually pulled at expiry time to a remote CPU.

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v5:
 - Move WARN_ONCE() in add_timer_on() into a previous patch
 - Fold "crystallball magic" related hunks into this patch
---
 include/linux/timer.h |  5 ++---
 kernel/time/timer.c   | 42 ++++++++++++++++++++----------------------
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 9162f275819a..aaedacac0b56 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -50,9 +50,8 @@ struct timer_list {
  * workqueue locking issues. It's not meant for executing random crap
  * with interrupts disabled. Abuse is monitored!
  *
- * @TIMER_PINNED: A pinned timer will not be affected by any timer
- * placement heuristics (like, NOHZ) and will always expire on the CPU
- * on which the timer was enqueued.
+ * @TIMER_PINNED: A pinned timer will always expire on the CPU on which
+ * the timer was enqueued.
  *
  * Note: Because enqueuing of timers can migrate the timer from one
  * CPU to another, pinned timers are not guaranteed to stay on the
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 01e97342ad0d..a441ec9dae39 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -593,10 +593,13 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 
 	/*
 	 * We might have to IPI the remote CPU if the base is idle and the
-	 * timer is not deferrable. If the other CPU is on the way to idle
-	 * then it can't set base->is_idle as we hold the base lock:
+	 * timer is pinned. If it is a non pinned timer, it is only queued
+	 * on the remote CPU, when timer was running during queueing. Then
+	 * everything is handled by remote CPU anyway. If the other CPU is
+	 * on the way to idle then it can't set base->is_idle as we hold
+	 * the base lock:
 	 */
-	if (base->is_idle)
+	if (base->is_idle && timer->flags & TIMER_PINNED)
 		wake_up_nohz_cpu(base->cpu);
 }
 
@@ -944,17 +947,6 @@ static inline struct timer_base *get_timer_base(u32 tflags)
 	return get_timer_cpu_base(tflags, tflags & TIMER_CPUMASK);
 }
 
-static inline struct timer_base *
-get_target_base(struct timer_base *base, unsigned tflags)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-	if (static_branch_likely(&timers_migration_enabled) &&
-	    !(tflags & TIMER_PINNED))
-		return get_timer_cpu_base(tflags, get_nohz_timer_target());
-#endif
-	return get_timer_this_cpu_base(tflags);
-}
-
 static inline void forward_timer_base(struct timer_base *base)
 {
 	unsigned long jnow = READ_ONCE(jiffies);
@@ -1106,7 +1098,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	if (!ret && (options & MOD_TIMER_PENDING_ONLY))
 		goto out_unlock;
 
-	new_base = get_target_base(base, timer->flags);
+	new_base = get_timer_this_cpu_base(timer->flags);
 
 	if (base != new_base) {
 		/*
@@ -2127,8 +2119,14 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		 */
 	}
 
-	/* We need to mark both bases in sync */
-	base_local->is_idle = base_global->is_idle = is_idle;
+	/*
+	 * base->is_idle information is required to wakeup a idle CPU when
+	 * a new timer was enqueued. Only pinned timers could be enqueued
+	 * remotely into a idle base. Therefore do maintain only
+	 * base_local->is_idle information and ignore base_global->is_idle
+	 * information.
+	 */
+	base_local->is_idle = is_idle;
 
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
@@ -2158,13 +2156,13 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 void timer_clear_idle(void)
 {
 	/*
-	 * We do this unlocked. The worst outcome is a remote enqueue sending
-	 * a pointless IPI, but taking the lock would just make the window for
-	 * sending the IPI a few instructions smaller for the cost of taking
-	 * the lock in the exit from idle path.
+	 * We do this unlocked. The worst outcome is a remote pinned timer
+	 * enqueue sending a pointless IPI, but taking the lock would just
+	 * make the window for sending the IPI a few instructions smaller
+	 * for the cost of taking the lock in the exit from idle
+	 * path. Required for BASE_LOCAL only.
 	 */
 	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
-	__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
 
 	/* Activate without holding the timer_base->lock */
 	tmigr_cpu_activate();
-- 
2.30.2

