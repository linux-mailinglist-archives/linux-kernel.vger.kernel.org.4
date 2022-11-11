Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48D5625471
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiKKHcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiKKHcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:32:11 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E5D69DC7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:32:10 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 138-20020a630290000000b004708e8a8dcfso2283123pgc.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTRv55T0nJN4SwjHA1GUh+2SQie0Oys8BK6pYjQjoOc=;
        b=OfXu9ejHMD7esXQ7C780sPXMvVo/q4vIc/de3NtU+Qt4LDV+CSbHFojkuIB6PCFHmu
         7SeR+HH1auCzbOWhqb7uXuz6W7zViQXYpDvnGuDIbQP12CYy6xmZx4Dx/XjKbCOnHgUS
         O/ZnV1GGNeaIdhmp9BYnf9TOjqQjHDl1wn6Bzh+/QXMXPaBrT0iWeQ9/D1w8nYpzbqVo
         piNCi0mjX18EOfWnIukqf/jNewjJx1si/OUJTSErlGvyidgUlWZA4UolXHYrLKuMtfQ/
         tOgDXw/Dmn2djbTjhyy3S+AvZuUwp9g/OLqQ+w/oNAkwa1nVrAodeG/f+zhvW/NcCcCB
         NTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTRv55T0nJN4SwjHA1GUh+2SQie0Oys8BK6pYjQjoOc=;
        b=tfAjDm9ZmiOD4L7o942cclxyPwGvKBNA1tIxhQ1GbDLT2Z3QUmQD8rPAy/yJyjB/nB
         38v4ogxgQTb+EeHxjeSn+/DUzFcn78xVqaNQMUujt+A0EGsx7cZsO3eR7ROZLR8J4PkH
         amJtgYOSjZAPA7GRNyOi9b3WkuOXY1sc7GcWJtH7bgINK+LGYi7WLG3J7xQfPiP6d6zf
         a79LCg7NYRTR8N4TY4cXACCPxh6VHEw99DJFDJ/tjKjNF4/kF8S2aRj2gpCZn/8rZGWD
         P1x3WTiRmb4KPx3ZjOj0s21GEixastGomnns2nGFtv1SZVBWhQpLekpgI4RHrKMY/frP
         vPkA==
X-Gm-Message-State: ANoB5pl1F/nJuslhCVpi7CO7ZIRAi2HwtKbo8/1EPhHKte2QzsmBvesX
        DPFGdd07D4Q4OS7YHCo98Hzq+BF/KKg=
X-Google-Smtp-Source: AA0mqf45JlHLe27QAKztPTbsgrecXvcO6GGgxUcarPrIL58Z2jUtMub7d0laI0RNQnMOFqHe4S5Hk2B7DkQ=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:8cf3:f53:2863:82a3])
 (user=avagin job=sendgmr) by 2002:a62:6446:0:b0:565:c122:b63 with SMTP id
 y67-20020a626446000000b00565c1220b63mr1378271pfb.49.1668151929765; Thu, 10
 Nov 2022 23:32:09 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:31:52 -0800
In-Reply-To: <20221111073154.784261-1-avagin@google.com>
Mime-Version: 1.0
References: <20221111073154.784261-1-avagin@google.com>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221111073154.784261-4-avagin@google.com>
Subject: [PATCH 3/5] sched: add a few helpers to wake up tasks on the current cpu
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
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
index 7f5a51aae0a7..c7d3e78a500d 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -210,6 +210,7 @@ __remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq
 }
 
 void __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *key);
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
index 4b591e7773fd..8125e02efd2c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6822,7 +6822,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
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
index 9860bb9a847c..9a78bca79419 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -157,6 +157,11 @@ void __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
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
2.38.1.493.g58b659f92b-goog

