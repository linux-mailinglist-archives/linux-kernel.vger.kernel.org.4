Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91D472467E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbjFFOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238295AbjFFOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:39:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E9173C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:38:30 -0700 (PDT)
Message-ID: <20230606142033.330496913@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fTIz5o5hBoARANmS3u0/FKhZKFc8aKqTiazS/c29bx4=;
        b=OdcnS/g7TLtMK5Roc3vTrxXoq8H3HZqVOPPQe3bOqccGbVUkYJB42PX7X5hlIf783ui1oO
        JccgdrWqou7YIRWHS6jaj+Soza9KAIEKCVOXbv5iPcjjXuLMrv5RRkFtA6BdCQZWp/WOEE
        BN0qyQ9T8rtFc/IqQLe/bYDDZA+L5F0HlKgkHnbdhWYKaptYIV8YPYZ7CkfN+GHHhldxhX
        a3fyCXaTjGPKB/9bX1Dm+Qu1FmJrWuWWyyXMq1lWtM8NtCSvqAaLwv7ZXhwiADF4SMJHEY
        LKk0XUphu1XFKyePl6h4gqQTocvR8kxW7WRvEgbkAKEbEz2kcwcHW/eL4jVS1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fTIz5o5hBoARANmS3u0/FKhZKFc8aKqTiazS/c29bx4=;
        b=s07WC/Jk01SKH8mTDohiDizZp7YjucvjsApqlFfGCLQVuTivaxZ/DQYPyoZW6cg7EVClwN
        pjnYijYFiVYxaGBQ==
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
Subject: [patch 41/45] signal: Handle ignored signals in do_sigaction(action
 != SIG_IGN)
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:23 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a real handler (including SIG_DFL) is installed for a signal, which
had previously SIG_IGN set, then the list of ignored posix timers has to be
checked for timers which are affected by this change.

Add a list walk function which checks for the matching signal number and if
found requeues the timers signal, so the timer is rearmed on signal
delivery.

Rearming the timer right away is not possible because that requires to drop
sighand lock.

No functional change as the counter part which queues the timers on the
ignored list is still missing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2027,7 +2027,55 @@ int posixtimer_send_sigqueue(struct k_it
 	rcu_read_unlock();
 	return ret;
 }
-#endif /* CONFIG_POSIX_TIMERS */
+
+static void posixtimer_sig_unignore(struct task_struct *tsk, int sig)
+{
+	struct hlist_head *head = &tsk->signal->ignored_posix_timers;
+	struct hlist_node *tmp;
+	struct k_itimer *tmr;
+
+	if (likely(hlist_empty(head)))
+		return;
+
+	/*
+	 * Rearming a timer with sighand lock held is not possible due to
+	 * lock ordering vs. tmr::it_lock. Just stick the sigqueue back and
+	 * let the signal delivery path deal with it whether it needs to be
+	 * rearmed or not. This cannot be decided here w/o dropping sighand
+	 * lock and creating a loop retry horror show.
+	 */
+	hlist_for_each_entry_safe(tmr, tmp , head, ignored_list) {
+		struct task_struct *target;
+
+		/*
+		 * tmr::sigq.info.si_signo is immutable, so accessing it
+		 * without holding tmr::it_lock is safe.
+		 */
+		if (tmr->sigq.info.si_signo != sig)
+			continue;
+
+		hlist_del_init(&tmr->ignored_list);
+
+		/* This should never happen and leaks a reference count */
+		if (WARN_ON_ONCE(!list_empty(&tmr->sigq.list)))
+			continue;
+
+		/*
+		 * Get the target for the signal. If target is a thread and
+		 * has exited by now, drop the reference count.
+		 */
+		rcu_read_lock();
+		target = posixtimer_get_target(tmr);
+		if (target)
+			posixtimer_queue_sigqueue(&tmr->sigq, target, tmr->it_pid_type);
+		else
+			posixtimer_putref(tmr);
+		rcu_read_unlock();
+	}
+}
+#else /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sig_unignore(struct task_struct *tsk, int sig) { }
+#endif /* !CONFIG_POSIX_TIMERS */
 
 static void do_notify_pidfd(struct task_struct *task)
 {
@@ -4147,6 +4195,8 @@ int do_sigaction(int sig, struct k_sigac
 	sigaction_compat_abi(act, oact);
 
 	if (act) {
+		bool was_ignored = k->sa.sa_handler == SIG_IGN;
+
 		sigdelsetmask(&act->sa.sa_mask,
 			      sigmask(SIGKILL) | sigmask(SIGSTOP));
 		*k = *act;
@@ -4167,6 +4217,8 @@ int do_sigaction(int sig, struct k_sigac
 			flush_sigqueue_mask(&mask, &p->signal->shared_pending, NULL);
 			for_each_thread(p, t)
 				flush_sigqueue_mask(&mask, &t->pending, NULL);
+		} else if (was_ignored) {
+			posixtimer_sig_unignore(p, sig);
 		}
 	}
 

