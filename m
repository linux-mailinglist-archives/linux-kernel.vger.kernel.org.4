Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C14472466A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbjFFOjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjFFOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:38:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07791BCC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:55 -0700 (PDT)
Message-ID: <20230606142032.265274690@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pTwgQriJEXYz/BGSH2oQaAJz9q8TYA27uj1w2y/zcJc=;
        b=0IRnAHwIhJIqglZvpXDrkZu/M/QwBgEWV0yLKYPAXoPN4kfedaIOLiuO2Z5c5hn3FtPUuu
        QGE7N7o7rl5iQg6iHrhjKFaYtTqIYjNsJ6DOC5S4bM6SAHBATUCGLkAfbT6FK3BzBe5nFL
        Toi2QxVGSgU74Ak5v8wR34tC742JhdqyFhqjxrji1CFbDYfrtvN7/O7kEy7xIlJgu+BgAm
        mXFgL6K7p6gPkpg9uQ87lk9akugxVrSUwIAa8xb2ye54ygC3fodE8dLn+4A76CIHznpTrr
        sEcWOjihR7swEfGfh9xix9cOzwsBw/E7KojqlxpE3vxK3kVlvU5nDusbj6TCTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pTwgQriJEXYz/BGSH2oQaAJz9q8TYA27uj1w2y/zcJc=;
        b=JRFbBcCjP4x4iocN+ozTdkGi1p1nb01JhhQ6f5PJp6rE0q/eY9U36wAeEw+i+XMHN5fnK4
        KpBY5EooAmYsNODQ==
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
Subject: [patch 22/45] signal: Get rid of resched_timer logic
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:53 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason for handing the *resched pointer argument through
several functions just to check whether the signal is related to a self
rearming posix timer.

SI_TIMER is only used by the posix timer code and cannot be queued from
user space. The only extra check in collect_signal() to verify whether the
queued signal is preallocated is not really useful. Some other places
already check purely the SI_TIMER type.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -529,8 +529,7 @@ bool unhandled_signal(struct task_struct
 	return !tsk->ptrace;
 }
 
-static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info,
-			   bool *resched_timer)
+static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info)
 {
 	struct sigqueue *q, *first = NULL;
 
@@ -552,12 +551,6 @@ static void collect_signal(int sig, stru
 still_pending:
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
-
-		*resched_timer =
-			(first->flags & SIGQUEUE_PREALLOC) &&
-			(info->si_code == SI_TIMER) &&
-			(info->si_sys_private);
-
 		__sigqueue_free(first);
 	} else {
 		/*
@@ -574,13 +567,12 @@ static void collect_signal(int sig, stru
 	}
 }
 
-static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
-			kernel_siginfo_t *info, bool *resched_timer)
+static int __dequeue_signal(struct sigpending *pending, sigset_t *mask, kernel_siginfo_t *info)
 {
 	int sig = next_signal(pending, mask);
 
 	if (sig)
-		collect_signal(sig, pending, info, resched_timer);
+		collect_signal(sig, pending, info);
 	return sig;
 }
 
@@ -592,17 +584,15 @@ static int __dequeue_signal(struct sigpe
 int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 {
 	struct task_struct *tsk = current;
-	bool resched_timer = false;
 	int signr;
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
 	*type = PIDTYPE_PID;
-	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
+	signr = __dequeue_signal(&tsk->pending, mask, info);
 	if (!signr) {
 		*type = PIDTYPE_TGID;
-		signr = __dequeue_signal(&tsk->signal->shared_pending,
-					 mask, info, &resched_timer);
+		signr = __dequeue_signal(&tsk->signal->shared_pending, mask, info);
 
 		if (unlikely(signr == SIGALRM))
 			posixtimer_rearm_itimer(tsk);
@@ -629,7 +619,7 @@ int dequeue_signal(sigset_t *mask, kerne
 	}
 
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-		if (unlikely(resched_timer))
+		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private))
 			posixtimer_rearm(info);
 	}
 
@@ -1015,6 +1005,9 @@ static int __send_signal_locked(int sig,
 
 	lockdep_assert_held(&t->sighand->siglock);
 
+	if (WARN_ON_ONCE(!is_si_special(info) && info->si_code == SI_TIMER))
+		return 0;
+
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, force))
 		goto ret;

