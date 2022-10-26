Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0308260EBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiJZWqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiJZWqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:46:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192614DF13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:45:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so16140833ybr.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nDwUkzOGIY/oIkFRkpfjLktxkIpm6KbAmOOaw1hHvjY=;
        b=o9NDa4bpyT46MS1DqRu2fOx06z8OOtLzHwV8E2wlHgp0NtbgJCEsalb+GEgJyDXhkS
         7lIqWqnfWXeTaMKfT4ew1IjmSVj4sK7vjJEAgHDYbEnYr6edTSHS1eADUIwkpuPW0KnY
         EiMM31lSoetw12k5TLBAOs5hEXNuGzy1juaoMp7c7RNvuQcyjMqrmVTAiTIy1H7J7sum
         FregvEutJbDfPNv/HZikFMN3Vv19CahndOZeh1JxVQJasKqRc+/He8uWMxj77bbsw0h/
         ZUh4Kr4W0CpeX0cXZf+WjtkEz/C5tHz1E/3g+/qGaP1G1yjsg2SAXiYxg2NxmHiZQAC9
         jqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDwUkzOGIY/oIkFRkpfjLktxkIpm6KbAmOOaw1hHvjY=;
        b=1QfraMyu5hivCmamhbWBBKAhfrDBtYv7gehXdX5xoyc3GIHS4A4/UynCum58ZN+gDf
         OL92KD2+Ql4d4W/+TV8Bkumw2RswZQpHEEA64rPKqg7wFsxc6v30tUcPlWRta3jpZoUM
         yTFKMSkBdw8UDr9x9VLz5RFznRTl/SsRQmlPVy08YRaUNEyB33lzWXWnUAkAxC3Is8KE
         EV4qgvzooNSIPQjtmac+hGNeqKuFlyv6/plikxRXNhGYxp0pBsDuHoNWLNzBzWn84QAP
         h0Uld0KB3GwWFnwhF54a+X2bxOKJ/1GCq5PX7Flu1mza5GESzGQ9LcKL5KdWd7S2jx+9
         92Iw==
X-Gm-Message-State: ACrzQf2CZdpjOoqGo94x9Qpw9kty59H14VaV0mFTHqBke8nwIZt9uIop
        PVBhcCFNYRAe4wy/K8fYSoWWSp4Ksvd8
X-Google-Smtp-Source: AMsMyM5UHeqIWFj4iK1934FaFCGqFlD0/J1wC7bJovZvQq8bzSpmQzsgat5A1dv27As1VNnB+FMSHt3xsyt4
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2d4:203:9a17:338e:7a9c:169b])
 (user=joshdon job=sendgmr) by 2002:a05:6902:124d:b0:66d:5ce6:5924 with SMTP
 id t13-20020a056902124d00b0066d5ce65924mr42604866ybu.320.1666824300879; Wed,
 26 Oct 2022 15:45:00 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:44:49 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221026224449.214839-1-joshdon@google.com>
Subject: [PATCH v2] sched: async unthrottling for cfs bandwidth
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
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
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

 kernel/sched/fair.c  | 123 +++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |   9 ++++
 2 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..ff5548013979 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5318,10 +5318,73 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
+	list_for_each_entry_safe(cursor, tmp, &rq->cfsb_csd_list,
+				 throttled_csd_list) {
+		struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cursor->tg);
+
+		list_del_init(&cursor->throttled_csd_list);
+		atomic_dec(&cfs_b->throttled_csd_count);
+
+		if (cfs_rq_throttled(cursor))
+			unthrottle_cfs_rq(cursor);
+	}
+
+	rq_unlock(rq, &rf);
+}
+
+static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
+{
+	struct rq *rq = rq_of(cfs_rq);
+	struct cfs_bandwidth *cfs_b;
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
+	cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
+
+	list_add_tail(&cfs_rq->throttled_csd_list, &rq->cfsb_csd_list);
+	atomic_inc(&cfs_b->throttled_csd_count);
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
@@ -5329,11 +5392,22 @@ static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
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
@@ -5348,15 +5422,14 @@ static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 
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
@@ -5401,10 +5474,8 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
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
@@ -5675,12 +5746,16 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 	cfs_b->slack_started = false;
+	atomic_set(&cfs_b->throttled_csd_count, 0);
 }
 
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->runtime_enabled = 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
+#ifdef CONFIG_SMP
+	INIT_LIST_HEAD(&cfs_rq->throttled_csd_list);
+#endif
 }
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
@@ -5703,6 +5778,31 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 
 	hrtimer_cancel(&cfs_b->period_timer);
 	hrtimer_cancel(&cfs_b->slack_timer);
+
+	/*
+	 * It is possible that we still have some cfs_rq's pending on the CSD
+	 * list, but this race is very rare. In order for this to occur, we must
+	 * have raced with the last task leaving the group while there exist throttled
+	 * cfs_rq(s), and the period_timer must have queued the CSD item but the remote
+	 * cpu has not yet processed it. In this case, we can simply process all CSD
+	 * work inline here.
+	 */
+#ifdef CONFIG_SMP
+	if (unlikely(atomic_read(&cfs_b->throttled_csd_count) > 0)) {
+		unsigned long flags;
+		int i;
+
+		for_each_possible_cpu(i) {
+			struct rq *rq = cpu_rq(i);
+
+			local_irq_save(flags);
+			__cfsb_csd_unthrottle(rq);
+			local_irq_restore(flags);
+		}
+
+		SCHED_WARN_ON(atomic_read(&cfs_b->throttled_csd_count) > 0);
+	}
+#endif
 }
 
 /*
@@ -12237,6 +12337,11 @@ __init void init_sched_fair_class(void)
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
index 1644242ecd11..e6f505f8c351 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -355,6 +355,7 @@ struct cfs_bandwidth {
 	struct hrtimer		period_timer;
 	struct hrtimer		slack_timer;
 	struct list_head	throttled_cfs_rq;
+	atomic_t		throttled_csd_count;
 
 	/* Statistics: */
 	int			nr_periods;
@@ -645,6 +646,9 @@ struct cfs_rq {
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;
+#ifdef CONFIG_SMP
+	struct list_head	throttled_csd_list;
+#endif
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
@@ -1144,6 +1148,11 @@ struct rq {
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
 #endif
+
+#if defined(CONFIG_CFS_BANDWIDTH) && defined(CONFIG_SMP)
+	call_single_data_t	cfsb_csd;
+	struct list_head	cfsb_csd_list;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.38.1.273.g43a17bfeac-goog

