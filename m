Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8172467D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjFFOks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbjFFOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:39:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5535B1FDE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:38:29 -0700 (PDT)
Message-ID: <20230606142033.278111872@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Uv3+NRg/Kf1yCAL/nMP1t/I/1XH205FZqRDMC4g6F7E=;
        b=Nt7Cp8cks3GA6mTuqXJmwXQsjXCEORcSPqUYS7EZkdTdEUAPwg6tMSXVbab6r4bownb+1I
        xOvqJUeBBA+eRMtdMWauNtYTmPrcXPFSOBSD5WCeWES6yZyG6gS8CyGS6zISG0nZaKPl5a
        VboyMwT5HJHmvVIJQ0FvVydOxhLx1akpwG+Vt0RHyFl3TrI/N4AJx1nsu+jNQ+wYXHhKwd
        TYlqOpe4ijaMUFlgM3oY+xOBcFX0slYk5iwAT/G7o68wiD4/QS2M7qv+VQ9roAvlx06a5H
        oe34ahABp5FcXz76n8VG0Ba2Z2F4Bc94vfi4351U9FyyuGPO1FcjxOno9r+XOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Uv3+NRg/Kf1yCAL/nMP1t/I/1XH205FZqRDMC4g6F7E=;
        b=rSKcKGs6zOPvDRlV0uIw8qAWPWHuL2cEJvKN1zMRHu51x0sQPhlDha8JpkYs/qCMdMAoLs
        PjOUop+JBZVpT+DQ==
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
Subject: [patch 40/45] posix-timers: Handle ignored list on delete and exit
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:22 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To handle posix timer signals on sigaction(SIG_IGN) properly, the timers
will be queued on a separate ignored list.

Add the necessary cleanup code for timer_delete() and exit_itimers().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    4 +++-
 kernel/time/posix-timers.c   |   22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -214,7 +214,8 @@ static inline void posix_cputimers_init_
 
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
- * @list:		List head for binding the timer to signals->posix_timers
+ * @list:		List node for binding the timer to tsk::signal::posix_timers
+ * @ignored_list:	List node for tracking ignored timers in tsk::signal::ignored_posix_timers
  * @t_hash:		Entry in the posix timer hash table
  * @it_lock:		Lock protecting the timer
  * @kclock:		Pointer to the k_clock struct handling this timer
@@ -237,6 +238,7 @@ static inline void posix_cputimers_init_
  */
 struct k_itimer {
 	struct hlist_node	list;
+	struct hlist_node	ignored_list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1032,6 +1032,18 @@ int common_timer_del(struct k_itimer *ti
 	return 0;
 }
 
+/*
+ * If the deleted timer is on the ignored list, remove it and
+ * drop the associated reference.
+ */
+static inline void posix_timer_cleanup_ignored(struct k_itimer *tmr)
+{
+	if (!hlist_unhashed(&tmr->ignored_list)) {
+		hlist_del_init(&tmr->ignored_list);
+		posixtimer_putref(tmr);
+	}
+}
+
 static inline int timer_delete_hook(struct k_itimer *timer)
 {
 	const struct k_clock *kc = timer->kclock;
@@ -1064,6 +1076,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 
 	spin_lock(&current->sighand->siglock);
 	hlist_del(&timer->list);
+	posix_timer_cleanup_ignored(timer);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1115,6 +1128,8 @@ static void itimer_delete(struct k_itime
 	}
 	hlist_del(&timer->list);
 
+	posix_timer_cleanup_ignored(timer);
+
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
 	 * here as nothing can access the timer anymore legitimately via
@@ -1150,6 +1165,13 @@ void exit_itimers(struct task_struct *ts
 		tmr = hlist_entry(timers.first, struct k_itimer, list);
 		itimer_delete(tmr);
 	}
+
+	/* Mop up timers which are on the ignored list */
+	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
+	while (!hlist_empty(&timers)) {
+		tmr = hlist_entry(timers.first, struct k_itimer, list);
+		posix_timer_cleanup_ignored(tmr);
+	}
 }
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,

