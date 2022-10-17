Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754D1601167
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiJQOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJQOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:45:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9FB6716D;
        Mon, 17 Oct 2022 07:45:49 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:45:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666017947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNqu8xQaCQMJ9oLEvvDINdBaIfWwcTJnfbqsb9WxGo8=;
        b=tZNKm4YTHhQZqp6yGyAiXsV05dZQm89PbA8YduJwf/hE8I4NX5rG+mIz/LMbDBHNrP5okW
        AeBUCGkVbrDbizz0DVvQp/UozSY0a2lpGiNKd8ohk8NWp8A8r5wnRsnQ740CVAsjJUNvFT
        jAQPv/LlGdHXi21zz46zH+PuzOdSWWfzSaOdfootmEENML1BCFybLIxglBm9hfezJSoK45
        milh88jflTk23IJYhDdijK+kekk7Fgul+Kg0Cql/hhjghSJu5gGfTq138uXYcEXTcviLpk
        oDguUdRUOnSw9g7Tx20TKRmj0HN+lQrMH4vSENncpoJWWuDeOotLwgWJBfM7yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666017947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNqu8xQaCQMJ9oLEvvDINdBaIfWwcTJnfbqsb9WxGo8=;
        b=l4ewSzNOnYvm48kqSzLe5IkxIjXIdLZ191HropsaBvWmnJsW95r7E/kYz6OpOmQ2HuxGmg
        Ry9rgWLm++I2+NBQ==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Introduce struct balance_callback to avoid
 CFI mismatches
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221008000758.2957718-1-keescook@chromium.org>
References: <20221008000758.2957718-1-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <166601794615.401.5251438438173107260.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     8e5bad7dccec2014f24497b57d8a8ee0b752c290
Gitweb:        https://git.kernel.org/tip/8e5bad7dccec2014f24497b57d8a8ee0b752c290
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 07 Oct 2022 17:07:58 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:25 +02:00

sched: Introduce struct balance_callback to avoid CFI mismatches

Introduce distinct struct balance_callback instead of performing function
pointer casting which will trip CFI. Avoids warnings as found by Clang's
future -Wcast-function-type-strict option:

In file included from kernel/sched/core.c:84:
kernel/sched/sched.h:1755:15: warning: cast from 'void (*)(struct rq *)' to 'void (*)(struct callback_head *)' converts to incompatible function type [-Wcast-function-type-strict]
        head->func = (void (*)(struct callback_head *))func;
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

No binary differences result from this change.

This patch is a cleanup based on Brad Spengler/PaX Team's modifications
to sched code in their last public patch of grsecurity/PaX based on my
understanding of the code. Changes or omissions from the original code
are mine and don't reflect the original grsecurity/PaX code.

Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/1724
Link: https://lkml.kernel.org/r/20221008000758.2957718-1-keescook@chromium.org
---
 kernel/sched/core.c     | 24 ++++++++++++------------
 kernel/sched/deadline.c |  4 ++--
 kernel/sched/rt.c       |  4 ++--
 kernel/sched/sched.h    | 14 ++++++++++----
 4 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5800b06..cb2aa2b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4823,10 +4823,10 @@ static inline void finish_task(struct task_struct *prev)
 
 #ifdef CONFIG_SMP
 
-static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
+static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	void (*func)(struct rq *rq);
-	struct callback_head *next;
+	struct balance_callback *next;
 
 	lockdep_assert_rq_held(rq);
 
@@ -4853,15 +4853,15 @@ static void balance_push(struct rq *rq);
  * This abuse is tolerated because it places all the unlikely/odd cases behind
  * a single test, namely: rq->balance_callback == NULL.
  */
-struct callback_head balance_push_callback = {
+struct balance_callback balance_push_callback = {
 	.next = NULL,
-	.func = (void (*)(struct callback_head *))balance_push,
+	.func = balance_push,
 };
 
-static inline struct callback_head *
+static inline struct balance_callback *
 __splice_balance_callbacks(struct rq *rq, bool split)
 {
-	struct callback_head *head = rq->balance_callback;
+	struct balance_callback *head = rq->balance_callback;
 
 	if (likely(!head))
 		return NULL;
@@ -4883,7 +4883,7 @@ __splice_balance_callbacks(struct rq *rq, bool split)
 	return head;
 }
 
-static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+static inline struct balance_callback *splice_balance_callbacks(struct rq *rq)
 {
 	return __splice_balance_callbacks(rq, true);
 }
@@ -4893,7 +4893,7 @@ static void __balance_callbacks(struct rq *rq)
 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
 
-static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+static inline void balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	unsigned long flags;
 
@@ -4910,12 +4910,12 @@ static inline void __balance_callbacks(struct rq *rq)
 {
 }
 
-static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+static inline struct balance_callback *splice_balance_callbacks(struct rq *rq)
 {
 	return NULL;
 }
 
-static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+static inline void balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 }
 
@@ -6188,7 +6188,7 @@ static void sched_core_balance(struct rq *rq)
 	preempt_enable();
 }
 
-static DEFINE_PER_CPU(struct callback_head, core_balance_head);
+static DEFINE_PER_CPU(struct balance_callback, core_balance_head);
 
 static void queue_core_balance(struct rq *rq)
 {
@@ -7419,7 +7419,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int oldpolicy = -1, policy = attr->sched_policy;
 	int retval, oldprio, newprio, queued, running;
 	const struct sched_class *prev_class;
-	struct callback_head *head;
+	struct balance_callback *head;
 	struct rq_flags rf;
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 86dea6a..9ae8f41 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -644,8 +644,8 @@ static inline bool need_pull_dl_task(struct rq *rq, struct task_struct *prev)
 	return rq->online && dl_task(prev);
 }
 
-static DEFINE_PER_CPU(struct callback_head, dl_push_head);
-static DEFINE_PER_CPU(struct callback_head, dl_pull_head);
+static DEFINE_PER_CPU(struct balance_callback, dl_push_head);
+static DEFINE_PER_CPU(struct balance_callback, dl_pull_head);
 
 static void push_dl_tasks(struct rq *);
 static void pull_dl_task(struct rq *);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index d869bcf..ed2a47e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -410,8 +410,8 @@ static inline int has_pushable_tasks(struct rq *rq)
 	return !plist_head_empty(&rq->rt.pushable_tasks);
 }
 
-static DEFINE_PER_CPU(struct callback_head, rt_push_head);
-static DEFINE_PER_CPU(struct callback_head, rt_pull_head);
+static DEFINE_PER_CPU(struct balance_callback, rt_push_head);
+static DEFINE_PER_CPU(struct balance_callback, rt_pull_head);
 
 static void push_rt_tasks(struct rq *);
 static void pull_rt_task(struct rq *);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0d08511..a4a2004 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -938,6 +938,12 @@ struct uclamp_rq {
 DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 #endif /* CONFIG_UCLAMP_TASK */
 
+struct rq;
+struct balance_callback {
+	struct balance_callback *next;
+	void (*func)(struct rq *rq);
+};
+
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -1036,7 +1042,7 @@ struct rq {
 	unsigned long		cpu_capacity;
 	unsigned long		cpu_capacity_orig;
 
-	struct callback_head	*balance_callback;
+	struct balance_callback *balance_callback;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1544,7 +1550,7 @@ struct rq_flags {
 #endif
 };
 
-extern struct callback_head balance_push_callback;
+extern struct balance_callback balance_push_callback;
 
 /*
  * Lockdep annotation that avoids accidental unlocks; it's like a
@@ -1724,7 +1730,7 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 static inline void
 queue_balance_callback(struct rq *rq,
-		       struct callback_head *head,
+		       struct balance_callback *head,
 		       void (*func)(struct rq *rq))
 {
 	lockdep_assert_rq_held(rq);
@@ -1737,7 +1743,7 @@ queue_balance_callback(struct rq *rq,
 	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
 		return;
 
-	head->func = (void (*)(struct callback_head *))func;
+	head->func = func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
 }
