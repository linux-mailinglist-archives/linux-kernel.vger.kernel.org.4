Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5D46AFFBA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCHHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCHHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:32:21 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C39A6771
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:32:16 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id cl18-20020a17090af69200b0023470d96ae6so1760656pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678260736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/licageW3tiOFRclAqIq9/0fYCCwDsQhp71Jqd1wdrY=;
        b=BuHMGtzH4pt/PW4rWmjgn3Ha71ZQ/6mC8Z1SpFucrs9JEGH54JgaPSCPpWSo581/1L
         MZL6dnSj+6eqJZfzF+zNpzX0T/2E6A3Bn8dtfQ9ppRkvU1A+/vDPmTkShzVtPxgh9/av
         ui+hcw+fozEiacx4JU3XGX3A2i+vjMUbV6tdlyoT2iNF8MOvbBwsV6w7xTBO3mDejv1c
         mNlv9GkNN2mReCMQ3BwA5iswQ9UB8/DEQQ1qIMYQ8jUm/00O1yIOt3R+seZWmUHjaH7R
         Gh4w3YhNu1wsQgO+7lFyIzJ5oIENbvWjrnNJIRFLkArYdDUjrKDfyboWPYUAXSzc/boo
         gukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/licageW3tiOFRclAqIq9/0fYCCwDsQhp71Jqd1wdrY=;
        b=TlImcbtPgDqu/WIN8bgFomzkELEHkLsJ8PPfsvwftqwCEg6HsVlVCVXoVoPrSaATcX
         AHEQYgV2k9FqSZ4IcsX9FzFHfOsgeV5tIvjOLnDbly4aDaFsXpl2rRb573W/Upd6irjj
         manNeO5BcFUIdV3RrJ80jW9VLyJImmSqYFwdDvIly4vQLcTpaVqESXshRCEP1IZYANtd
         tsAH09uLFGWT/+CEWpPThr2yyxINEn1ulIEbmkQ2AucIy3OwUVgK+7h1FgAzQYKgvd7t
         ANqZDvqEdIoUwsA2z2Avy9BDwmkk1wg/SdABRhQiWoxP6QyGrHIjIGSlCO3nYF2D9yGI
         4Uyg==
X-Gm-Message-State: AO0yUKWtub5Aiaa/PkkA5/30USyC/s/ELJFFfY+KdszKmgkHMj0jvLz5
        wsLQBtOiwYtY8oo9kXvpDvT0l8/dJbk=
X-Google-Smtp-Source: AK7set9KESVJYpyAVXKY3k549PUNqM49vQO+34cR9hPQWNlTpTWAsFhYFSKc5aSTEMbV9mStc/O+yg+5wqA=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:b53:99a6:b4fe:b30b])
 (user=avagin job=sendgmr) by 2002:a17:902:f807:b0:19a:a411:92ba with SMTP id
 ix7-20020a170902f80700b0019aa41192bamr6963804plb.8.1678260736548; Tue, 07 Mar
 2023 23:32:16 -0800 (PST)
Date:   Tue,  7 Mar 2023 23:31:58 -0800
In-Reply-To: <20230308073201.3102738-1-avagin@google.com>
Mime-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308073201.3102738-4-avagin@google.com>
Subject: [PATCH 3/6] sched: add a few helpers to wake up tasks on the current cpu
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, avagin@gmail.com,
        Andrei Vagin <avagin@google.com>,
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

Signed-off-by: Andrei Vagin <avagin@google.com>
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
index 386a0c40d341..c5f7bfbc4967 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6941,7 +6941,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
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
2.40.0.rc0.216.gc4246ad0f0-goog

