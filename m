Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930A762D042
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiKQAyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiKQAyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:54:51 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67868C7A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:54:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-37010fefe48so3778327b3.19
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ysfoct986L/TAyEzj4NN4Xf6t7q4aA6POs/aJRiGOSg=;
        b=GmKpKpq7X0BrIzb8T5z4kmz4STkbzJrWU4ED/JTV4tTELmNFxNSW0bpDYShHdSwZqT
         28/rxzH5nsPtd1029+N0dEHqqmmhXGOkRBnnk2bnhCtZLVkxFTk0YSo7/PZUGlqjZwJg
         HKv5Ck3xRYUP7F/Sn/UeVYGX0Ym+sZB6fTho49o0PtpGa7U9jYpZVA89jQNzLF+VQCcC
         FCLW6/A6Yj6Xudt5xwlwvgnjQL6fBaFo/1d70zqq7bz/ulJdhpHBBgPCKyEP8Sb2cOG6
         LfAgUEEhgFAaH7UlySoEkK+c/YP1Sxj5FQlLyocK5FabqXshRPci/qWP8MWu02ph2XCO
         eE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ysfoct986L/TAyEzj4NN4Xf6t7q4aA6POs/aJRiGOSg=;
        b=ZG4oILi57k/5SvDzW+lNHJHfz9cyecdp7Hx9rwGI2U1KkO7eRhm5m7Pz99Jd/UZ25f
         SBsJhrDkuVbEev+unEuEcNC50pZjA7So8s+4JRzZ2wUNWkyw5eHfTQuwol48S4WQTaSi
         uO4karFEOYZi8ugrQIO6rYcOxM9TyUW3CpVlhRwx4PweAjoPgIWoTaexGkvEizvFJv8W
         mpMO9SvofxKRMuFojX08Q4n2MftZ/bcAhMMLgSO2/fIP5gRAG7Jj7EB5xz8hxjukIM+3
         5pr9HNBCAz7XfPpR8vLP4hoak5KtYv+n1moCf8bYTrmWABdLvOJZXDPHrrxqdUfv0UI1
         wzpA==
X-Gm-Message-State: ANoB5pnZ+P8zmCHOXCL1qqgaYR6MWFUf7Rbw8VqNEQvlDr28ExKsnlGx
        QpEv5Uv5v7ooKk4kB/0K6esnvYPRFKVk
X-Google-Smtp-Source: AA0mqf7Bd8W0sktwvEbQRR6dzyUkgZRgnOUohF6qMoB5jQqoqk8u2Vgt51fj/6o7bYtqZRlDUTlng/JPFr2s
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2d4:203:9cde:7d17:70eb:e746])
 (user=joshdon job=sendgmr) by 2002:a25:55c6:0:b0:6cf:dda2:54f9 with SMTP id
 j189-20020a2555c6000000b006cfdda254f9mr169786ybb.525.1668646489803; Wed, 16
 Nov 2022 16:54:49 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:54:18 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221117005418.3499691-1-joshdon@google.com>
Subject: [PATCH v3] sched: async unthrottling for cfs bandwidth
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Josh Don <joshdon@google.com>
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

CFS bandwidth currently distributes new runtime and unthrottles cfs_rq's
inline in an hrtimer callback. Runtime distribution is a per-cpu
operation, and unthrottling is a per-cgroup operation, since a tg walk
is required. On machines with a large number of cpus and large cgroup
hierarchies, this cpus*cgroups work can be too much to do in a single
hrtimer callback: since IRQ are disabled, hard lockups may easily occur.
Specifically, we've found this scalability issue on configurations with
256 cpus, O(1000) cgroups in the hierarchy being throttled, and high
memory bandwidth usage.

To fix this, we can instead unthrottle cfs_rq's asynchronously via a
CSD. Each cpu is responsible for unthrottling itself, thus sharding the
total work more fairly across the system, and avoiding hard lockups.

Signed-off-by: Josh Don <joshdon@google.com>
---
v2: Fixed !CONFIG_SMP build errors
v3: Removed the throttled_csd_count atomic

 kernel/sched/fair.c  | 127 ++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h |   8 +++
 2 files changed, 126 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4cc56c91e06e..012ec9d03811 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5449,10 +5449,77 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		resched_curr(rq);
 }
 
-static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
+#ifdef CONFIG_SMP
+static void __cfsb_csd_unthrottle(void *arg)
+{
+	struct rq *rq = arg;
+	struct rq_flags rf;
+	struct cfs_rq *cursor, *tmp;
+
+	rq_lock(rq, &rf);
+
+	/*
+	 * Since we hold rq lock we're safe from concurrent manipulation of
+	 * the CSD list. However, this RCU critical section annotates the
+	 * fact that we pair with sched_free_group_rcu(), so that we cannot
+	 * race with group being freed in the window between removing it
+	 * from the list and advancing to the next entry in the list.
+	 */
+	rcu_read_lock();
+
+	list_for_each_entry_safe(cursor, tmp, &rq->cfsb_csd_list,
+				 throttled_csd_list) {
+		list_del_init(&cursor->throttled_csd_list);
+
+		if (cfs_rq_throttled(cursor))
+			unthrottle_cfs_rq(cursor);
+	}
+
+	rcu_read_unlock();
+
+	rq_unlock(rq, &rf);
+}
+
+static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
+{
+	struct rq *rq = rq_of(cfs_rq);
+
+	if (rq == this_rq()) {
+		unthrottle_cfs_rq(cfs_rq);
+		return;
+	}
+
+	/* Already enqueued */
+	if (SCHED_WARN_ON(!list_empty(&cfs_rq->throttled_csd_list)))
+		return;
+
+	list_add_tail(&cfs_rq->throttled_csd_list, &rq->cfsb_csd_list);
+
+	smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);
+}
+#else
+static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
+{
+	unthrottle_cfs_rq(cfs_rq);
+}
+#endif
+
+static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
+{
+	lockdep_assert_rq_held(rq_of(cfs_rq));
+
+	if (SCHED_WARN_ON(!cfs_rq_throttled(cfs_rq) ||
+	    cfs_rq->runtime_remaining <= 0))
+		return;
+
+	__unthrottle_cfs_rq_async(cfs_rq);
+}
+
+static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 {
 	struct cfs_rq *cfs_rq;
 	u64 runtime, remaining = 1;
+	bool throttled = false;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
@@ -5460,11 +5527,22 @@ static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 		struct rq *rq = rq_of(cfs_rq);
 		struct rq_flags rf;
 
+		if (!remaining) {
+			throttled = true;
+			break;
+		}
+
 		rq_lock_irqsave(rq, &rf);
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
-		/* By the above check, this should never be true */
+#ifdef CONFIG_SMP
+		/* Already queued for async unthrottle */
+		if (!list_empty(&cfs_rq->throttled_csd_list))
+			goto next;
+#endif
+
+		/* By the above checks, this should never be true */
 		SCHED_WARN_ON(cfs_rq->runtime_remaining > 0);
 
 		raw_spin_lock(&cfs_b->lock);
@@ -5479,15 +5557,14 @@ static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 
 		/* we check whether we're throttled above */
 		if (cfs_rq->runtime_remaining > 0)
-			unthrottle_cfs_rq(cfs_rq);
+			unthrottle_cfs_rq_async(cfs_rq);
 
 next:
 		rq_unlock_irqrestore(rq, &rf);
-
-		if (!remaining)
-			break;
 	}
 	rcu_read_unlock();
+
+	return throttled;
 }
 
 /*
@@ -5532,10 +5609,8 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	while (throttled && cfs_b->runtime > 0) {
 		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
-		distribute_cfs_runtime(cfs_b);
+		throttled = distribute_cfs_runtime(cfs_b);
 		raw_spin_lock_irqsave(&cfs_b->lock, flags);
-
-		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
 	}
 
 	/*
@@ -5812,6 +5887,9 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->runtime_enabled = 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
+#ifdef CONFIG_SMP
+	INIT_LIST_HEAD(&cfs_rq->throttled_csd_list);
+#endif
 }
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
@@ -5828,12 +5906,38 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 
 static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
+	int __maybe_unused i;
+
 	/* init_cfs_bandwidth() was not called */
 	if (!cfs_b->throttled_cfs_rq.next)
 		return;
 
 	hrtimer_cancel(&cfs_b->period_timer);
 	hrtimer_cancel(&cfs_b->slack_timer);
+
+	/*
+	 * It is possible that we still have some cfs_rq's pending on a CSD
+	 * list, though this race is very rare. In order for this to occur, we
+	 * must have raced with the last task leaving the group while there
+	 * exist throttled cfs_rq(s), and the period_timer must have queued the
+	 * CSD item but the remote cpu has not yet processed it. To handle this,
+	 * we can simply flush all pending CSD work inline here. We're
+	 * guaranteed at this point that no additional cfs_rq of this group can
+	 * join a CSD list.
+	 */
+#ifdef CONFIG_SMP
+	for_each_possible_cpu(i) {
+		struct rq *rq = cpu_rq(i);
+		unsigned long flags;
+
+		if (list_empty(&rq->cfsb_csd_list))
+			continue;
+
+		local_irq_save(flags);
+		__cfsb_csd_unthrottle(rq);
+		local_irq_restore(flags);
+	}
+#endif
 }
 
 /*
@@ -12462,6 +12566,11 @@ __init void init_sched_fair_class(void)
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i), GFP_KERNEL, cpu_to_node(i));
 		zalloc_cpumask_var_node(&per_cpu(select_rq_mask,    i), GFP_KERNEL, cpu_to_node(i));
+
+#ifdef CONFIG_CFS_BANDWIDTH
+		INIT_CSD(&cpu_rq(i)->cfsb_csd, __cfsb_csd_unthrottle, cpu_rq(i));
+		INIT_LIST_HEAD(&cpu_rq(i)->cfsb_csd_list);
+#endif
 	}
 
 	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 771f8ddb7053..b3d6e819127c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -645,6 +645,9 @@ struct cfs_rq {
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;
+#ifdef CONFIG_SMP
+	struct list_head	throttled_csd_list;
+#endif
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
@@ -1154,6 +1157,11 @@ struct rq {
 
 	/* Scratch cpumask to be temporarily used under rq_lock */
 	cpumask_var_t		scratch_mask;
+
+#if defined(CONFIG_CFS_BANDWIDTH) && defined(CONFIG_SMP)
+	call_single_data_t	cfsb_csd;
+	struct list_head	cfsb_csd_list;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.38.1.431.g37b22c650d-goog

