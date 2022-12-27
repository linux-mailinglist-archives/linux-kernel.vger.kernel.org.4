Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76232656ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiL0MRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiL0MOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3647960E1;
        Tue, 27 Dec 2022 04:13:56 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujyVg/s4AQQQ6UtTl7yr86u4Dr/6yIKm5A8C26cSDAI=;
        b=PAGp4LGct8rT6tgUota960RX0QP4qmRLqPQD0nVozHSma0SIHKSz+5HVg/ybi+zNskC/v3
        RnpfEC6DkkYWWNJrxOds6VRNVYCLB6FHQcyc3oYsNjHnjTMsNHpjK4ldIVsrfJEmYI/Eml
        +Nz8az+S7RZn9s6c4VdcsB2M+RMxlrtlzlVVKqXzrX8xqImD+Kv556Tt0SprnHbYZW3q4R
        vDPu5kqL7zFsAMwt5TH89wcbQ3yR/e5Xxvz2g1ntoZaD751ywdX54n4FEPUf3AfJEj4YZd
        3iq6ylJQMf8LPd+CeBq9oRfGhSy/iVHgJEYOl7/WJuHBbktyipJtyTc91muFyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujyVg/s4AQQQ6UtTl7yr86u4Dr/6yIKm5A8C26cSDAI=;
        b=UfW3j6pidnesc/cs3oNZgOLe81+p3j43rN7/QauVElIpYaod1w52B8pIkyoKbRo5bOfhPU
        gNNV1ocfF+HErPCw==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Async unthrottling for cfs bandwidth
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117005418.3499691-1-joshdon@google.com>
References: <20221117005418.3499691-1-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <167214323301.4906.13009767372433209180.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8ad075c2eb1f6b4b33436144ea1ef2619f3b6398
Gitweb:        https://git.kernel.org/tip/8ad075c2eb1f6b4b33436144ea1ef2619f3b6398
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Wed, 16 Nov 2022 16:54:18 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:09 +01:00

sched: Async unthrottling for cfs bandwidth

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221117005418.3499691-1-joshdon@google.com
---
 kernel/sched/fair.c  | 155 ++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |   8 ++-
 2 files changed, 150 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c36aa54..ea81d48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5461,22 +5461,105 @@ unthrottle_throttle:
 		resched_curr(rq);
 }
 
-static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
+#ifdef CONFIG_SMP
+static void __cfsb_csd_unthrottle(void *arg)
 {
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cursor, *tmp;
+	struct rq *rq = arg;
+	struct rq_flags rf;
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
+	bool first;
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
+	first = list_empty(&rq->cfsb_csd_list);
+	list_add_tail(&cfs_rq->throttled_csd_list, &rq->cfsb_csd_list);
+	if (first)
+		smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);
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
+{
+	struct cfs_rq *local_unthrottle = NULL;
+	int this_cpu = smp_processor_id();
 	u64 runtime, remaining = 1;
+	bool throttled = false;
+	struct cfs_rq *cfs_rq;
+	struct rq_flags rf;
+	struct rq *rq;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
 				throttled_list) {
-		struct rq *rq = rq_of(cfs_rq);
-		struct rq_flags rf;
+		rq = rq_of(cfs_rq);
+
+		if (!remaining) {
+			throttled = true;
+			break;
+		}
 
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
@@ -5490,16 +5573,30 @@ static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 		cfs_rq->runtime_remaining += runtime;
 
 		/* we check whether we're throttled above */
-		if (cfs_rq->runtime_remaining > 0)
-			unthrottle_cfs_rq(cfs_rq);
+		if (cfs_rq->runtime_remaining > 0) {
+			if (cpu_of(rq) != this_cpu ||
+			    SCHED_WARN_ON(local_unthrottle))
+				unthrottle_cfs_rq_async(cfs_rq);
+			else
+				local_unthrottle = cfs_rq;
+		} else {
+			throttled = true;
+		}
 
 next:
 		rq_unlock_irqrestore(rq, &rf);
-
-		if (!remaining)
-			break;
 	}
 	rcu_read_unlock();
+
+	if (local_unthrottle) {
+		rq = cpu_rq(this_cpu);
+		rq_lock_irqsave(rq, &rf);
+		if (cfs_rq_throttled(local_unthrottle))
+			unthrottle_cfs_rq(local_unthrottle);
+		rq_unlock_irqrestore(rq, &rf);
+	}
+
+	return throttled;
 }
 
 /*
@@ -5544,10 +5641,8 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
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
@@ -5824,6 +5919,9 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->runtime_enabled = 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
+#ifdef CONFIG_SMP
+	INIT_LIST_HEAD(&cfs_rq->throttled_csd_list);
+#endif
 }
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
@@ -5840,12 +5938,38 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 
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
@@ -12474,6 +12598,11 @@ __init void init_sched_fair_class(void)
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
index 771f8dd..b3d6e81 100644
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
