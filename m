Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7112C724681
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbjFFOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbjFFOj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:39:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DF2173B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:38:31 -0700 (PDT)
Message-ID: <20230606142033.384181292@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LYF80Bk8/VFt3/Zfq3hqFvDVFoPNEcj4ORUMtha4AAY=;
        b=cZacQ8wYAB7Fb9DsCdI9e5upBjaTR3/GonogUx1w32o7gnoJL8+oGIBsGZRjWoLL+9KRvV
        ZF8AjijMZ6myMI0e5MjuVzggO9U6nzZvgkZ4NM5NmQBDDbozZgEm/bzfeQ9yFWJR7n2kp9
        DoYdIPD8R/+9CdHtmfpldGwPzv8AdJudlXDytEpOKs1/HM/QvBGZusnYeGZvZGZ92pYiag
        IyM7pJ/3zaWS/wNloxDpFu1X3UENzr9+5RgPiZ9iJcC7TN4UgfeNEr+j5xFWK8U9QJbpCF
        X0TEOM1VbVURlL97TkNbqOjr32eMih58SBLQy7kpnwzA4iNKDLcf01PslOTFwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LYF80Bk8/VFt3/Zfq3hqFvDVFoPNEcj4ORUMtha4AAY=;
        b=BqlduYM4tBY34xpYtNtBJa2wlNU+kRrBw7+Hr5IfTnIWZ4dF+Q1zbvXE49vkvTgr9KSJwU
        m4OySW2lELrVxJCQ==
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
Subject: [patch 42/45] signal: Queue ignored posixtimers on ignore list
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:25 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queue posixtimers which have their signal ignored on the ignored list:

   1) When the timer fires and the signal has SIG_IGN set

   2) When SIG_IGN is installed via sigaction() and a timer signal
      is queued

This completes the SIG_IGN handling and such timers are not longer self
rearmed which avoids pointless wakeups.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -725,6 +725,16 @@ void signal_wake_up_state(struct task_st
 		kick_process(t);
 }
 
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q);
+
+static void sigqueue_free_ignored(struct task_struct *ptmr_tsk, struct sigqueue *q)
+{
+	if (likely(!ptmr_tsk || q->info.si_code != SI_TIMER))
+		__sigqueue_free(q);
+	else
+		posixtimer_sig_ignore(ptmr_tsk, q);
+}
+
 /*
  * Remove signals in mask from the pending set and queue.
  *
@@ -743,7 +753,7 @@ static void flush_sigqueue_mask(sigset_t
 	list_for_each_entry_safe(q, n, &s->list, list) {
 		if (sigismember(mask, q->info.si_signo)) {
 			list_del_init(&q->list);
-			__sigqueue_free(q);
+			sigqueue_free_ignored(ptmr_tsk, q);
 		}
 	}
 }
@@ -1956,9 +1966,8 @@ int posixtimer_send_sigqueue(struct k_it
 	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
-	int ret, result;
+	int result;
 
-	ret = -1;
 	rcu_read_lock();
 
 	t = posixtimer_get_target(tmr);
@@ -2004,13 +2013,24 @@ int posixtimer_send_sigqueue(struct k_it
 	 */
 	q->info.si_overrun = 0;
 
-	ret = 1; /* the signal is ignored */
 	if (!prepare_signal(sig, t, false)) {
 		result = TRACE_SIGNAL_IGNORED;
+
+		/* Paranoia check. Try to survive. */
+		if (WARN_ON_ONCE(!list_empty(&q->list)))
+			goto out;
+
+		if (hlist_unhashed(&tmr->ignored_list)) {
+			hlist_add_head(&tmr->ignored_list, &t->signal->ignored_posix_timers);
+			posixtimer_sigqueue_getref(q);
+		}
 		goto out;
 	}
 
-	ret = 0;
+	/* This should never happen and leaks a reference count */
+	if (WARN_ON_ONCE(!hlist_unhashed(&tmr->ignored_list)))
+		hlist_del_init(&tmr->ignored_list);
+
 	if (unlikely(!list_empty(&q->list))) {
 		/* This holds a reference count already */
 		result = TRACE_SIGNAL_ALREADY_PENDING;
@@ -2025,7 +2045,14 @@ int posixtimer_send_sigqueue(struct k_it
 	unlock_task_sighand(t, &flags);
 ret:
 	rcu_read_unlock();
-	return ret;
+	return 0;
+}
+
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
 }
 
 static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
@@ -2074,6 +2101,7 @@ static void posixtimer_sig_unignore(stru
 	}
 }
 #else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q) { }
 static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 
@@ -4214,9 +4242,9 @@ int do_sigaction(int sig, struct k_sigac
 		if (sig_handler_ignored(sig_handler(p, sig), sig)) {
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
-			flush_sigqueue_mask(&mask, &p->signal->shared_pending, NULL);
+			flush_sigqueue_mask(&mask, &p->signal->shared_pending, p);
 			for_each_thread(p, t)
-				flush_sigqueue_mask(&mask, &t->pending, NULL);
+				flush_sigqueue_mask(&mask, &t->pending, p);
 		} else if (was_ignored) {
 			posixtimer_sig_unignore(p, sig);
 		}

