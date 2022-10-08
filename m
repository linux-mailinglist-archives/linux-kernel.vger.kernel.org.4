Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262A05F816E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 02:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJHAIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 20:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJHAIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 20:08:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E14B7ED5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 17:08:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c24so5888728plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 17:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlW3S21aB17kz+hO99Vc8HR6vIw08YfR7FPkbou1rqI=;
        b=YUwW3DM3eVNXQ0J7TR66mjmagj8fwa3AjQWZzxpPWDkWrS8aPK43yGxzQSIJXQCOO5
         9WtZP9OR0JH7XDkw4rzIT/eGRhqnieXfdjCb3WOMF7KEug6iJ9mkq2vqwqR8xo+sSKqZ
         dq6ozOgIStDrFNWp3qC+UQQtA5pXu6zWmvYW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlW3S21aB17kz+hO99Vc8HR6vIw08YfR7FPkbou1rqI=;
        b=DAXaKBeOEtNBpy4Y2bEEhq3owVlKfgOV3QPt2kfnVx0hQPOeM+F97QZcZCgO65rkhj
         qKTeeCcQyQU0BX6tPPUTijlPZoSN5FHgMlsROzlB/7dWn++IbJ7z/lm1W9rqTROyZ5zP
         YXuwjqFdSnUVwsc4iAArzkQhGmuH/o/M/DYhtjZjXSFyTmelmpoLgkNxu0KcaMsekmWL
         eNMwlOVYS3YXdP8Z+KSuxLviJbCIGumiawiOb9sNqRpALOU05c214SZ7tnQVnAhpI5tH
         Xin3xjSuzdrHErGxRMj1jalfM27qcV/bGmxtd7XGl60JzDT1EbiqdMvjLT/H6+EnkZqS
         Wm/A==
X-Gm-Message-State: ACrzQf1hJ7Ul3Xo1Bn4mQLWQge24MHBy3yf7uRnhM7+KhYsdT8YDAu6C
        MgizXCZb8OA15pwPJz+yslpw4Q==
X-Google-Smtp-Source: AMsMyM61xr/OSe8K8MUMddSaiOVwHip7L4sV2kGdel2YqGmxFIpRzCXEtyst7Hfj7hUup2Nyfnf6CQ==
X-Received: by 2002:a17:903:48e:b0:17e:ea4a:394e with SMTP id jj14-20020a170903048e00b0017eea4a394emr7074349plb.48.1665187681785;
        Fri, 07 Oct 2022 17:08:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d11-20020a621d0b000000b00537a6b81bb7sm2258075pfd.148.2022.10.07.17.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 17:08:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] sched: Introduce struct balance_callback to avoid CFI mismatches
Date:   Fri,  7 Oct 2022 17:07:58 -0700
Message-Id: <20221008000758.2957718-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7690; h=from:subject; bh=vtUdQvXcgLg7lLbcB7N1QxPY/Psk0BrTFtb/HcD8az4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjQL9dv9/yvcfpo5w1cqoU117GXd2PPTiylBxoftly ebuP4DGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0C/XQAKCRCJcvTf3G3AJhmBEA Cx2LMbLCW0zguV2psixD8uu11ir2aHPYkgqHS0rZL2T6/92XE6b440n6R9vKDQr+5H1gItbDiFNa+X LvjoOK5cZpDL6Qy7rRdwIpjl4Xci9hgK9lXkZ3VN9e6RcMNmufrHUPfDHHbxxFFquxupUvEh6udElH dLKGeX83SDGRceSVOFn0/NaSoe4bm4U6t/MLaIQ0APETNM03Z1jlnruNtuoegUK1S69a4+s8eVYpm3 lhXwtm9LGJAqm7vx+HcYDePR4uCAln9TSFc2U0WyOdOqWkKFOU8vIsEJv7YtbbdAPZN4W+mw9S3Uy2 k1Fsiy5iILkb1PG49d6qD6do7Lk8R1IkLV4Vg9Yu/mOyu+F9LYNF2+q3qTHod/qkh5V/gMWGrXDAhm rYo/rc6kICIHIrMe45bPIaWTWB7lcPUr5nZtaZm4A/91oXKGRUBmFlxuBGpP2rxewjWXeWVERrLMKb 2cas3GUGGYh0PAV1gZWYSyvpw+ruOfU6ModfgwIdHql4HVay9J9eHjPzvMO75T8JVmmeQNTeamQ6AG EXNrwQeBMEdnw5LeS/yOTmf3ZxG3qwItSZCRTwjahE6AEl+4nNmGFkjZOBdfzRTVCrFg9IADnd1Z01 3YMRns9jVM7HDz84Jkz6iwDsFFAcWjhdMODPg7TNArWhTYyTPwwwttgeT8zg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Link: https://github.com/ClangBuiltLinux/linux/issues/1724
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/sched/core.c     | 24 ++++++++++++------------
 kernel/sched/deadline.c |  4 ++--
 kernel/sched/rt.c       |  4 ++--
 kernel/sched/sched.h    | 14 ++++++++++----
 4 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..911db628092e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4815,10 +4815,10 @@ static inline void finish_task(struct task_struct *prev)
 
 #ifdef CONFIG_SMP
 
-static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
+static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	void (*func)(struct rq *rq);
-	struct callback_head *next;
+	struct balance_callback *next;
 
 	lockdep_assert_rq_held(rq);
 
@@ -4845,15 +4845,15 @@ static void balance_push(struct rq *rq);
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
@@ -4875,7 +4875,7 @@ __splice_balance_callbacks(struct rq *rq, bool split)
 	return head;
 }
 
-static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
+static inline struct balance_callback *splice_balance_callbacks(struct rq *rq)
 {
 	return __splice_balance_callbacks(rq, true);
 }
@@ -4885,7 +4885,7 @@ static void __balance_callbacks(struct rq *rq)
 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
 
-static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
+static inline void balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	unsigned long flags;
 
@@ -4902,12 +4902,12 @@ static inline void __balance_callbacks(struct rq *rq)
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
 
@@ -6179,7 +6179,7 @@ static void sched_core_balance(struct rq *rq)
 	preempt_enable();
 }
 
-static DEFINE_PER_CPU(struct callback_head, core_balance_head);
+static DEFINE_PER_CPU(struct balance_callback, core_balance_head);
 
 static void queue_core_balance(struct rq *rq)
 {
@@ -7410,7 +7410,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int oldpolicy = -1, policy = attr->sched_policy;
 	int retval, oldprio, newprio, queued, running;
 	const struct sched_class *prev_class;
-	struct callback_head *head;
+	struct balance_callback *head;
 	struct rq_flags rf;
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0ab79d819a0d..6498951b7d41 100644
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
index 55f39c8f4203..ad020a2a72f3 100644
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
index e26688d387ae..54971a57a4ea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -953,6 +953,12 @@ struct uclamp_rq {
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
@@ -1051,7 +1057,7 @@ struct rq {
 	unsigned long		cpu_capacity;
 	unsigned long		cpu_capacity_orig;
 
-	struct callback_head	*balance_callback;
+	struct balance_callback *balance_callback;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1559,7 +1565,7 @@ struct rq_flags {
 #endif
 };
 
-extern struct callback_head balance_push_callback;
+extern struct balance_callback balance_push_callback;
 
 /*
  * Lockdep annotation that avoids accidental unlocks; it's like a
@@ -1739,7 +1745,7 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 
 static inline void
 queue_balance_callback(struct rq *rq,
-		       struct callback_head *head,
+		       struct balance_callback *head,
 		       void (*func)(struct rq *rq))
 {
 	lockdep_assert_rq_held(rq);
@@ -1752,7 +1758,7 @@ queue_balance_callback(struct rq *rq,
 	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
 		return;
 
-	head->func = (void (*)(struct callback_head *))func;
+	head->func = func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
 }
-- 
2.34.1

