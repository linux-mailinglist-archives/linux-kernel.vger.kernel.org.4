Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C14724676
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbjFFOk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbjFFOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:39:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4AA10E0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:38:18 -0700 (PDT)
Message-ID: <20230606142032.768353204@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WBARrxgJ0Fo3O3pXIjgjYSXb/czDjqPuA7NhGPJIs00=;
        b=oEOxb0sUym1Pwy7Z9NDCrzBqaCSSmmAuNYE8cNhD9uSA2Muk9RagSHTmhGzOUEUlWgY6mh
        Gh6EqnielU4dcz0Ho51Yng5JazPPiIWqHbA/EiQvyPzKjh+c+NaWZjzfA6XffeZwNJZRvn
        cGsHnK+TGhN1FzHt4cyF62HJCIHlokHGgqa07A8imVK6kY5bdtdEErPjSUxk0lTiyMvZwg
        kHR1DIJXAabMZVX4mksvN86FGlGiRfQi4f1EqtWH7evD0FwPlOz31EX4syi6IKLj0WUxQ/
        +3xkOPBlEEj+bgzm18F0jdJCAMUn+dg+CUL9qpsSbxljvgRr28/ITciir3PY7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WBARrxgJ0Fo3O3pXIjgjYSXb/czDjqPuA7NhGPJIs00=;
        b=EiH4wIJOOX9gXUPVuG+4+zy6hy9FQTz/fYU92XeTosFRTHiKSnOBst+MAfEaLsjuTBN8dH
        sh5zPjLfVn7Wc8CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 31/45] posix-timers: Add a refcount to struct k_itimer
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:08 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

To make this work correctly this needs reference counting so that timer
deletion does not free the timer prematuraly when there is a signal queued
or delivered concurrently.

Add a rcuref to the posix timer part.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |   14 ++++++++++++++
 kernel/time/posix-timers.c   |    7 ++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -6,10 +6,12 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/alarmtimer.h>
+#include <linux/rcuref.h>
 #include <linux/timerqueue.h>
 
 struct kernel_siginfo;
 struct task_struct;
+struct k_itimer;
 
 /*
  * Bit fields within a clockid:
@@ -167,6 +169,7 @@ static inline void posix_cputimers_rt_wa
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
+void posixtimer_free_timer(struct k_itimer *timer);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -192,6 +195,7 @@ static inline void posix_cputimers_group
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
 static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
+static inline void posixtimer_free_timer(struct k_itimer *timer) { }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
@@ -219,6 +223,7 @@ static inline void posix_cputimers_init_
  * @it_signal:		Pointer to the creators signal struct
  * @it_pid:		The pid of the process/task targeted by the signal
  * @it_process:		The task to wakeup on clock_nanosleep (CPU timers)
+ * @rcuref:		Reference count for life time management
  * @sigq:		Pointer to preallocated sigqueue
  * @it:			Union representing the various posix timer type
  *			internals.
@@ -243,6 +248,7 @@ struct k_itimer {
 		struct task_struct	*it_process;
 	};
 	struct sigqueue		*sigq;
+	rcuref_t		rcuref;
 	union {
 		struct {
 			struct hrtimer	timer;
@@ -263,4 +269,12 @@ void set_process_cpu_timer(struct task_s
 
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
+#ifdef CONFIG_POSIX_TIMERS
+static inline void posixtimer_putref(struct k_itimer *tmr)
+{
+	if (rcuref_put(&tmr->rcuref))
+		posixtimer_free_timer(tmr);
+}
+#endif /* !CONFIG_POSIX_TIMERS */
+
 #endif
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -417,6 +417,7 @@ static struct k_itimer * alloc_posix_tim
 		return NULL;
 	}
 	clear_siginfo(&tmr->sigq->info);
+	rcuref_init(&tmr->rcuref, 1);
 	return tmr;
 }
 
@@ -427,7 +428,7 @@ static void k_itimer_rcu_free(struct rcu
 	kmem_cache_free(posix_timers_cache, tmr);
 }
 
-static void posix_timer_free(struct k_itimer *tmr)
+void posixtimer_free_timer(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
@@ -439,7 +440,7 @@ static void posix_timer_unhash_and_free(
 	spin_lock(&hash_lock);
 	hlist_del_rcu(&tmr->t_hash);
 	spin_unlock(&hash_lock);
-	posix_timer_free(tmr);
+	posixtimer_putref(tmr);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
@@ -474,7 +475,7 @@ static int do_timer_create(clockid_t whi
 	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
-		posix_timer_free(new_timer);
+		posixtimer_free_timer(new_timer);
 		return new_timer_id;
 	}
 

