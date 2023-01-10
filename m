Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EFA664E14
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjAJVbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjAJVbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:31:11 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5256718A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:23 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id bq10-20020a056a000e0a00b00581221976c0so5810223pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=168RoWZtH8izLuFq/qvBuIIwN3CImpi6a5tV66j3lJE=;
        b=M/U4lN6P2nNVPkbo2DMsRtb9YjHDgL7JgQBN0SOCGpKWJ4Hp5JP9+ou5aT9092WuMB
         tgM+VDO8LDjQiaO5NKk9wyQXWoPGpjGV72fjOYO0PsEjA8N+vzHujKp02feFpHhyffkm
         a8aBm/VbAPyZOCT0+pU4Z1c+Rp92g9F0AImVTiSOi7imJ5ZSammmPPMnzYVAj0LEPy8T
         /k+zmFp3NHhJm//uRR8MkD6N7MM/FPA/pAFMRsZXpKwsYfSDn8Dqc15pwPoJvX0SJ+E5
         uLCKtOyr8OaQuT9glDWtN6H8KOhBI5vCbCvEsggEtSzqriwrdkOHP7yLvLu+OBGsduBj
         Z4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=168RoWZtH8izLuFq/qvBuIIwN3CImpi6a5tV66j3lJE=;
        b=LwO7h0AgUkGYdDJchSau0gX8CzPq1ENKvbIXxorhGW81j4OBRAw+ZhDlyWP0rGeDnI
         aXHzhElGe78+7ylEUmtc6ikaNOLMs0LkwQ6LyZCBxkUfP3yWjhRAERV9afZ4TtXNfCKH
         4JQuzDHwl/yiOnhm7r9fKwSkT4nQJhIegQlYKdFwz3ZAPyhunUaEQFs6OOpeG9Cnwyko
         tOMRC8tC8lZ8/nqTGV9RGMzjHv1/AbgeZA3+JjtikuZJ4DcnC28xi+ImR/w8XWDU22Nc
         sjOux2oCAqNDSboSffOuDRQMuUua75aT1yNmSdiJJ1ic5hbQZzQDIZ5X9UY+yRXw9Roo
         YlnQ==
X-Gm-Message-State: AFqh2kpHBY0VZWmWVP9q8BokkXcLaEOH1Ke+hLo9C3/kIBfDrn0eKtx2
        4VGd4JrrqwhXpxfX9e/IAsxU0cDbV7M=
X-Google-Smtp-Source: AMrXdXuCrUxyyCG3lMb5F4T7c25ZCFef+GV4+b0QTGExhGw0/1FdwhfME1TSR+Ee0OiOls9xJmMXNv691FI=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:6203:13b5:2d85:b75c])
 (user=avagin job=sendgmr) by 2002:a17:90a:206:b0:226:9980:67f3 with SMTP id
 c6-20020a17090a020600b00226998067f3mr8656pjc.1.1673386223090; Tue, 10 Jan
 2023 13:30:23 -0800 (PST)
Date:   Tue, 10 Jan 2023 13:30:08 -0800
In-Reply-To: <20230110213010.2683185-1-avagin@google.com>
Mime-Version: 1.0
References: <20230110213010.2683185-1-avagin@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230110213010.2683185-4-avagin@google.com>
Subject: [PATCH 3/5] sched: add a few helpers to wake up tasks on the current cpu
From:   Andrei Vagin <avagin@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
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
 include/linux/swait.h      |  1 +
 include/linux/wait.h       |  3 +++
 kernel/sched/completion.c  | 12 ++++++++++++
 kernel/sched/core.c        |  2 +-
 kernel/sched/swait.c       | 11 +++++++++++
 kernel/sched/wait.c        |  5 +++++
 7 files changed, 34 insertions(+), 1 deletion(-)

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
index 6a8c22b8c2a5..1f27b254adf5 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -147,6 +147,7 @@ static inline bool swq_has_sleeper(struct swait_queue_head *wq)
 extern void swake_up_one(struct swait_queue_head *q);
 extern void swake_up_all(struct swait_queue_head *q);
 extern void swake_up_locked(struct swait_queue_head *q);
+extern void swake_up_locked_on_current_cpu(struct swait_queue_head *q);
 
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
index d57a5c1c1cd9..a1931a79c05a 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -38,6 +38,18 @@ void complete(struct completion *x)
 }
 EXPORT_SYMBOL(complete);
 
+void complete_on_current_cpu(struct completion *x)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
+
+	if (x->done != UINT_MAX)
+		x->done++;
+	swake_up_locked_on_current_cpu(&x->wait);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
+}
+
 /**
  * complete_all: - signals all threads waiting on this completion
  * @x:  holds the state of this particular completion
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6478e819eb99..c81866821139 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6874,7 +6874,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
 			  void *key)
 {
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~(WF_SYNC|WF_CURRENT_CPU));
 	return try_to_wake_up(curr->private, mode, wake_flags);
 }
 EXPORT_SYMBOL(default_wake_function);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 76b9b796e695..9ebe23868942 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -31,6 +31,17 @@ void swake_up_locked(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_locked);
 
+void swake_up_locked_on_current_cpu(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+
+	if (list_empty(&q->task_list))
+		return;
+
+	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
+	try_to_wake_up(curr->task, TASK_NORMAL, WF_CURRENT_CPU);
+	list_del_init(&curr->task_list);
+}
 /*
  * Wake up all waiters. This is an interface which is solely exposed for
  * completions and not for general usage.
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
2.39.0.314.g84b9a713c41-goog

