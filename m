Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060A06DD0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjDKE0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjDKEZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:25:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB5426BE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54ed65e1fe0so87127487b3.18
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187131; x=1683779131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZla9n0aM3/MbVHsUXpKu5CiwnUuagyO7/qCT5IzdPE=;
        b=QgrPUMQ4AA3eVZQ4ghVfek3Gc3xqtPPMbZT2DjmZOsjUgJvusTMnJckJ1dCZOaQ2kF
         E91JWypF1eri8NsLZUfgMt8MHZLaEqjlL3yCu/oEB0GE2GZjEsH59ojPBbQzbowypI9S
         cDZWLJE1eOx+k1tBskmh8g6ZRbKvFNZkyHhy4RNY3nanXVOCDjIR9UUAERGLW8ZJNyve
         S6CEu362lgW5F3Jt9LqlwKBTwaR76lkKFfeGjS+AW6vAIJZKWSaSPrw61g4CZVQxCCVf
         IM+z6gFBNtSRNzU2azn1ynxSZYt8IhXeqk2a9z49pI1CrThqFtPH6WhJZ5tq3snIVTck
         SoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187131; x=1683779131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZla9n0aM3/MbVHsUXpKu5CiwnUuagyO7/qCT5IzdPE=;
        b=y6h8l6MLMl4sHXMJSkmjMt6fZ3Sw1/gxI5w+oXr6n69jA8Xqudnrr0pviHC1p4BUph
         FOMIYjJ55Bz3pxbHhzsUrccyKEhbdgwf+A/utYH+nCzEvuLLKtQBaNQIkXbbVcyNCSR3
         b3UWyJbqqQ3xRI+DXM0xX6LgCA41NPlMD4aHzzXSnU6UmxtjcsAwjD+PFWsyK1nXj923
         htKuzpNLJIkEuMZ5LSE13aJlbzQzHYwLOOCSg9EIErhkDMJDdKhy1dM9wpJtHK+krpo9
         mYwVEyed/xAUArBEwYlkh8bpAOenrEKW3en5ZLP0yHywrPfgyF9H5i+SxHEsa9nyz2nv
         pNzw==
X-Gm-Message-State: AAQBX9dy41FRzGdGJTclYGOhM7/vp2WGjTV9cI0tgBuPTa1UI3uz7scw
        cfEKFNlPXio5U6JoIXvVYWKy1b1vT4+ANN0exZICGZJWqziJSkgC91CsmRs82KqvumyDRJb1fnn
        pfBoso2sC1JkF3Z41lm2W7BOfVMM9/7YzoNYxFpc14Yn6+xXqx7tzDL4MdrvuQ4lC4rq5rAY=
X-Google-Smtp-Source: AKy350bwDuf02aEKP6ebTPqyNNygPJcSPuWQV2n8z5zqdUCEHMtRzX4QiMSPHzifYdY4NZMa/E/CwORnEN6j
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:909:b0:a27:3ecc:ffe7 with SMTP id
 bu9-20020a056902090900b00a273eccffe7mr10920720ybb.3.1681187130882; Mon, 10
 Apr 2023 21:25:30 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:04 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-8-jstultz@google.com>
Subject: [PATCH v3 07/14] sched: Unify runtime accounting across classes
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

All classes use sched_entity::exec_start to track runtime and have
copies of the exact same code around to compute runtime.

Collapse all that.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[fix conflicts, fold in update_current_exec_runtime]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: rebased, resovling minor conflicts]
Signed-off-by: John Stultz <jstultz@google.com>
---
 include/linux/sched.h    |  2 +-
 kernel/sched/deadline.c  | 13 +++-------
 kernel/sched/fair.c      | 56 ++++++++++++++++++++++++++++++----------
 kernel/sched/rt.c        | 13 +++-------
 kernel/sched/sched.h     | 12 ++-------
 kernel/sched/stop_task.c | 13 +---------
 6 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9d46ca8ac221..6d22542d3648 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -519,7 +519,7 @@ struct sched_statistics {
 	u64				block_max;
 	s64				sum_block_runtime;
 
-	u64				exec_max;
+	s64				exec_max;
 	u64				slice_max;
 
 	u64				nr_migrations_cold;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b24371a6f7..5a7c4edd5b13 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1308,9 +1308,8 @@ static void update_curr_dl(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_dl_entity *dl_se = &curr->dl;
-	u64 delta_exec, scaled_delta_exec;
+	s64 delta_exec, scaled_delta_exec;
 	int cpu = cpu_of(rq);
-	u64 now;
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1323,21 +1322,15 @@ static void update_curr_dl(struct rq *rq)
 	 * natural solution, but the full ramifications of this
 	 * approach need further study.
 	 */
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec <= 0)) {
+	delta_exec = update_curr_common(rq);
+	if (unlikely(delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
 		return;
 	}
 
-	schedstat_set(curr->stats.exec_max,
-		      max(curr->stats.exec_max, delta_exec));
-
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	update_current_exec_runtime(curr, now, delta_exec);
-
 	if (dl_entity_is_special(dl_se))
 		return;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6986ea31c984..bea9a31c76ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -891,23 +891,17 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-/*
- * Update the current task's runtime statistics.
- */
-static void update_curr(struct cfs_rq *cfs_rq)
+static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 {
-	struct sched_entity *curr = cfs_rq->curr;
-	u64 now = rq_clock_task(rq_of(cfs_rq));
-	u64 delta_exec;
-
-	if (unlikely(!curr))
-		return;
+	u64 now = rq_clock_task(rq);
+	s64 delta_exec;
 
 	delta_exec = now - curr->exec_start;
-	if (unlikely((s64)delta_exec <= 0))
-		return;
+	if (unlikely(delta_exec <= 0))
+		return delta_exec;
 
 	curr->exec_start = now;
+	curr->sum_exec_runtime += delta_exec;
 
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
@@ -917,9 +911,43 @@ static void update_curr(struct cfs_rq *cfs_rq)
 				max(delta_exec, stats->exec_max));
 	}
 
-	curr->sum_exec_runtime += delta_exec;
-	schedstat_add(cfs_rq->exec_clock, delta_exec);
+	return delta_exec;
+}
+
+/*
+ * Used by other classes to account runtime.
+ */
+s64 update_curr_common(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	s64 delta_exec;
 
+	delta_exec = update_curr_se(rq, &curr->se);
+	if (unlikely(delta_exec <= 0))
+		return delta_exec;
+
+	account_group_exec_runtime(curr, delta_exec);
+	cgroup_account_cputime(curr, delta_exec);
+
+	return delta_exec;
+}
+
+/*
+ * Update the current task's runtime statistics.
+ */
+static void update_curr(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	s64 delta_exec;
+
+	if (unlikely(!curr))
+		return;
+
+	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
+	if (unlikely(delta_exec <= 0))
+		return;
+
+	schedstat_add(cfs_rq->exec_clock, delta_exec);
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	update_min_vruntime(cfs_rq);
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0a11f44adee5..18eb6ce60c5c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1046,24 +1046,17 @@ static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_rt_entity *rt_se = &curr->rt;
-	u64 delta_exec;
-	u64 now;
+	s64 delta_exec;
 
 	if (curr->sched_class != &rt_sched_class)
 		return;
 
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec <= 0))
+	delta_exec = update_curr_common(rq);
+	if (unlikely(delta_exec < 0))
 		return;
 
-	schedstat_set(curr->stats.exec_max,
-		      max(curr->stats.exec_max, delta_exec));
-
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	update_current_exec_runtime(curr, now, delta_exec);
-
 	if (!rt_bandwidth_enabled())
 		return;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..d18e3c3a3f40 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2166,6 +2166,8 @@ struct affinity_context {
 	unsigned int flags;
 };
 
+extern s64 update_curr_common(struct rq *rq);
+
 struct sched_class {
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -3238,16 +3240,6 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
-static inline void update_current_exec_runtime(struct task_struct *curr,
-						u64 now, u64 delta_exec)
-{
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
-}
-
 #ifdef CONFIG_SCHED_MM_CID
 static inline int __mm_cid_get(struct mm_struct *mm)
 {
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 85590599b4d6..7595494ceb6d 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -70,18 +70,7 @@ static void yield_task_stop(struct rq *rq)
 
 static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 {
-	struct task_struct *curr = rq->curr;
-	u64 now, delta_exec;
-
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec < 0))
-		delta_exec = 0;
-
-	schedstat_set(curr->stats.exec_max,
-		      max(curr->stats.exec_max, delta_exec));
-
-	update_current_exec_runtime(curr, now, delta_exec);
+	update_curr_common(rq);
 }
 
 /*
-- 
2.40.0.577.gac1e443424-goog

