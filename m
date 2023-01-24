Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB567A700
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjAXXmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjAXXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:42:09 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E8F4A1D7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:42:08 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id om10-20020a17090b3a8a00b002299e350deaso136322pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qi7EKreQxkEoaHFcnKjib1WJc2fpRwlVhvJbtYcJB8A=;
        b=HiNOz2UDVT2ZAczIQ2k4nyb+4XwJ/ePZO7Aw6FmWsnmQlWlzz1eJqh+wfP307mGIwm
         YVQ3zX5pLPTwVYThBKcGJ5D+/a3sk/oeQrDSB7NROq4JfVzMztqRn9DBoyVnjAx+ZWOC
         Kvs/OlgRdFjQUzeq8w/mzCclINwTxgpL79SA2eoFw2nK2QwcywyFJmFdrIK0DEEOQIA6
         d/I92h2HYkrjwrXEWr+/eWU7K2TiWzyaK9ALU9I0Q9k2IjG/XnTyP2jlkE96a4WL2UNg
         r9MFj1mvsSoG4Wi2BXwUBOHqsZiyohuahjnK77kZy9J70GxvTpwbvBc6LP4lDpMHFl1x
         t/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qi7EKreQxkEoaHFcnKjib1WJc2fpRwlVhvJbtYcJB8A=;
        b=piokAKYc4klhMbbtyveLK1ghKoPxwUSbpY2tEv4Oo4LBuYUrzAoDSyRraNLxYwYXjt
         don7JLMLwTjVdGmpezzgO9VihMnR625xi+I9LsNxUdkd+SJ+qmqRo2BP2A+g/G5HrP/P
         kw0pg5C7hmBTJEyA9RAptO+clNTmsn2BFR3fJ7HDAWt0I/Y6GjajSgXkbwj2dIDS1Fju
         6DN259rgD/ckoL8F939v6Ep5S0WAVNKBILBhHmsNY0Ec4rtG7/cM5K7OXgX2nHp5fIan
         HFJBhLou6g4mOC7oJOaM6dljPF3W2rEponKPquvc1BWpPjCmL65Ute7FybC+pXaBIBC/
         LrmA==
X-Gm-Message-State: AFqh2krvwTxYF4mWxkOaYKwF+tUMM724INDx0uFgplvbftUqBpL+BHvE
        WJuOW0hmkLc5GxT5iGUPqEQC8kiCX54=
X-Google-Smtp-Source: AMrXdXtck2yNa+dEWPCjDo5K5lNC1hb6NZDTWtsjJ7NE+Ey//R2+sU+nOQxdjD0jhMNynGRkcXaHrGyfAKc=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:cf1b:2f7f:3ca1:6488])
 (user=avagin job=sendgmr) by 2002:a17:902:ce01:b0:18c:5dae:6f2 with SMTP id
 k1-20020a170902ce0100b0018c5dae06f2mr3065462plg.24.1674603727622; Tue, 24 Jan
 2023 15:42:07 -0800 (PST)
Date:   Tue, 24 Jan 2023 15:41:53 -0800
In-Reply-To: <20230124234156.211569-1-avagin@google.com>
Mime-Version: 1.0
References: <20230124234156.211569-1-avagin@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230124234156.211569-4-avagin@google.com>
Subject: [PATCH 3/6] sched: add a few helpers to wake up tasks on the current cpu
From:   Andrei Vagin <avagin@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Add complete_on_current_cpu, wake_up_poll_on_current_cpu helpers to wake
up tasks on the current CPU.

These two helpers are useful when the task needs to make a synchronous context
switch to another task. In this context, synchronous means it wakes up the
target task and falls asleep right after that.

One example of such workloads is seccomp user notifies. This mechanism allows
the  supervisor process handles system calls on behalf of a target process.
While the supervisor is handling an intercepted system call, the target process
will be blocked in the kernel, waiting for a response to come back.

On-CPU context switches are much faster than regular ones.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 include/linux/completion.h |  1 +
 include/linux/swait.h      |  2 +-
 include/linux/wait.h       |  3 +++
 kernel/sched/completion.c  | 26 ++++++++++++++++++--------
 kernel/sched/core.c        |  2 +-
 kernel/sched/swait.c       |  8 ++++----
 kernel/sched/wait.c        |  5 +++++
 7 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 62b32b19e0a8..fb2915676574 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -116,6 +116,7 @@ extern bool try_wait_for_completion(struct completion *x);
 extern bool completion_done(struct completion *x);
 
 extern void complete(struct completion *);
+extern void complete_on_current_cpu(struct completion *x);
 extern void complete_all(struct completion *);
 
 #endif
diff --git a/include/linux/swait.h b/include/linux/swait.h
index 6a8c22b8c2a5..d324419482a0 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -146,7 +146,7 @@ static inline bool swq_has_sleeper(struct swait_queue_head *wq)
 
 extern void swake_up_one(struct swait_queue_head *q);
 extern void swake_up_all(struct swait_queue_head *q);
-extern void swake_up_locked(struct swait_queue_head *q);
+extern void swake_up_locked(struct swait_queue_head *q, int wake_flags);
 
 extern void prepare_to_swait_exclusive(struct swait_queue_head *q, struct swait_queue *wait, int state);
 extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
diff --git a/include/linux/wait.h b/include/linux/wait.h
index a0307b516b09..5ec7739400f4 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -210,6 +210,7 @@ __remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq
 }
 
 int __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *key);
+void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
 		unsigned int mode, void *key, wait_queue_entry_t *bookmark);
@@ -237,6 +238,8 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define key_to_poll(m) ((__force __poll_t)(uintptr_t)(void *)(m))
 #define wake_up_poll(x, m)							\
 	__wake_up(x, TASK_NORMAL, 1, poll_to_key(m))
+#define wake_up_poll_on_current_cpu(x, m)					\
+	__wake_up_on_current_cpu(x, TASK_NORMAL, poll_to_key(m))
 #define wake_up_locked_poll(x, m)						\
 	__wake_up_locked_key((x), TASK_NORMAL, poll_to_key(m))
 #define wake_up_interruptible_poll(x, m)					\
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index d57a5c1c1cd9..3561ab533dd4 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -13,6 +13,23 @@
  * Waiting for completion is a typically sync point, but not an exclusion point.
  */
 
+static void complete_with_flags(struct completion *x, int wake_flags)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
+
+	if (x->done != UINT_MAX)
+		x->done++;
+	swake_up_locked(&x->wait, wake_flags);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
+}
+
+void complete_on_current_cpu(struct completion *x)
+{
+	return complete_with_flags(x, WF_CURRENT_CPU);
+}
+
 /**
  * complete: - signals a single thread waiting on this completion
  * @x:  holds the state of this particular completion
@@ -27,14 +44,7 @@
  */
 void complete(struct completion *x)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&x->wait.lock, flags);
-
-	if (x->done != UINT_MAX)
-		x->done++;
-	swake_up_locked(&x->wait);
-	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
+	complete_with_flags(x, 0);
 }
 EXPORT_SYMBOL(complete);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 028c2840baa6..a4cb1b5fd52d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6925,7 +6925,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
 			  void *key)
 {
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~(WF_SYNC|WF_CURRENT_CPU));
 	return try_to_wake_up(curr->private, mode, wake_flags);
 }
 EXPORT_SYMBOL(default_wake_function);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 76b9b796e695..72505cd3b60a 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -18,7 +18,7 @@ EXPORT_SYMBOL(__init_swait_queue_head);
  * If for some reason it would return 0, that means the previously waiting
  * task is already running, so it will observe condition true (or has already).
  */
-void swake_up_locked(struct swait_queue_head *q)
+void swake_up_locked(struct swait_queue_head *q, int wake_flags)
 {
 	struct swait_queue *curr;
 
@@ -26,7 +26,7 @@ void swake_up_locked(struct swait_queue_head *q)
 		return;
 
 	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
-	wake_up_process(curr->task);
+	try_to_wake_up(curr->task, TASK_NORMAL, wake_flags);
 	list_del_init(&curr->task_list);
 }
 EXPORT_SYMBOL(swake_up_locked);
@@ -41,7 +41,7 @@ EXPORT_SYMBOL(swake_up_locked);
 void swake_up_all_locked(struct swait_queue_head *q)
 {
 	while (!list_empty(&q->task_list))
-		swake_up_locked(q);
+		swake_up_locked(q, 0);
 }
 
 void swake_up_one(struct swait_queue_head *q)
@@ -49,7 +49,7 @@ void swake_up_one(struct swait_queue_head *q)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&q->lock, flags);
-	swake_up_locked(q);
+	swake_up_locked(q, 0);
 	raw_spin_unlock_irqrestore(&q->lock, flags);
 }
 EXPORT_SYMBOL(swake_up_one);
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 133b74730738..47803a0b8d5d 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -161,6 +161,11 @@ int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
 }
 EXPORT_SYMBOL(__wake_up);
 
+void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
+{
+	__wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
+}
+
 /*
  * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
  */
-- 
2.39.1.405.gd4c25cc71f-goog

