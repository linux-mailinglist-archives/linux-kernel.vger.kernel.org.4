Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E49774B78A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGGT6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGGT6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3521FE0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688759875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdQJAH2GV9D+apACz4qjKNGn83rt3wnWrm7JM2Vt7n0=;
        b=F1FPhMH2ySuix1LdTYaFS7k0uPeBl0wZ4NqaQSOah4xKKWyAvah3emvWK7fWAmLCMZkOtF
        AE3Sgakb2/xBY/PEXKRcKWSLZ/CCAo3TKwKG1xEzIcGR7Kg33SYOEaeRbjkzSYuhrh+3J9
        JVvQwdIXMGxZIPebG6KNNMxTrmQ2Jn8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-eOrWyeOhM7myaHoAKz3Cwg-1; Fri, 07 Jul 2023 15:57:51 -0400
X-MC-Unique: eOrWyeOhM7myaHoAKz3Cwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2B3A38294B3;
        Fri,  7 Jul 2023 19:57:50 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 832D34087C6A;
        Fri,  7 Jul 2023 19:57:50 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Phil Auld <pauld@redhat.com>
Subject: [PATCH v5 2/2] Sched/fair: Block nohz tick_stop when cfs bandwidth in use
Date:   Fri,  7 Jul 2023 15:57:48 -0400
Message-Id: <20230707195748.2918490-3-pauld@redhat.com>
In-Reply-To: <20230707195748.2918490-1-pauld@redhat.com>
References: <20230707195748.2918490-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CFS bandwidth limits and NOHZ full don't play well together.  Tasks
can easily run well past their quotas before a remote tick does
accounting.  This leads to long, multi-period stalls before such
tasks can run again. Currently, when presented with these conflicting
requirements the scheduler is favoring nohz_full and letting the tick
be stopped. However, nohz tick stopping is already best-effort, there
are a number of conditions that can prevent it, whereas cfs runtime
bandwidth is expected to be enforced.

Make the scheduler favor bandwidth over stopping the tick by setting
TICK_DEP_BIT_SCHED when the only running task is a cfs task with
runtime limit enabled. We use cfs_b->hierarchical_quota to
determine if the task requires the tick.

Add check in pick_next_task_fair() as well since that is where
we have a handle on the task that is actually going to be running.

Add check in sched_can_stop_tick() to cover some edge cases such 
as nr_running going from 2->1 and the 1 remains the running task.

Add sched_feat HZ_BW (off by default) to control the tick_stop
behavior.

Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c     | 12 ++++++++++
 kernel/sched/fair.c     | 49 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  2 ++
 kernel/sched/sched.h    |  1 +
 4 files changed, 64 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1b214e10c25d..4b8534abdf4f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1229,6 +1229,18 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (rq->nr_running > 1)
 		return false;
 
+	/*
+	 * If there is one task and it has CFS runtime bandwidth constraints
+	 * and it's on the cpu now we don't want to stop the tick.
+	 * This check prevents clearing the bit if a newly enqueued task here is
+	 * dequeued by migrating while the constrained task continues to run.
+	 * E.g. going from 2->1 without going through pick_next_task().
+	 */
+	if (sched_feat(HZ_BW) && rq->nr_running == 1 && task_on_rq_queued(rq->curr)) {
+		if (cfs_task_bw_constrained(rq->curr))
+			return false;
+	}
+
 	return true;
 }
 #endif /* CONFIG_NO_HZ_FULL */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 92381f9ecf37..70429abd8df5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6140,6 +6140,46 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 	rcu_read_unlock();
 }
 
+bool cfs_task_bw_constrained(struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq = task_cfs_rq(p);
+
+	if (!cfs_bandwidth_used())
+		return false;
+
+	if (cfs_rq->runtime_enabled ||
+	    tg_cfs_bandwidth(cfs_rq->tg)->hierarchical_quota != RUNTIME_INF)
+		return true;
+
+	return false;
+}
+
+#ifdef CONFIG_NO_HZ_FULL
+/* called from pick_next_task_fair() */
+static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
+{
+	int cpu = cpu_of(rq);
+
+	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
+		return;
+
+	if (!tick_nohz_full_cpu(cpu))
+		return;
+
+	if (rq->nr_running != 1)
+		return;
+
+	/*
+	 *  We know there is only one task runnable and we've just picked it. The
+	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
+	 *  be otherwise able to stop the tick. Just need to check if we are using
+	 *  bandwidth control.
+	 */
+	if (cfs_task_bw_constrained(p))
+		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
+}
+#endif
+
 #else /* CONFIG_CFS_BANDWIDTH */
 
 static inline bool cfs_bandwidth_used(void)
@@ -6182,9 +6222,17 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
 static inline void update_runtime_enabled(struct rq *rq) {}
 static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
+bool cfs_task_bw_constrained(struct task_struct *p)
+{
+	return false;
+}
 
 #endif /* CONFIG_CFS_BANDWIDTH */
 
+#if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
+static inline void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p) {}
+#endif
+
 /**************************************************
  * CFS operations on tasks:
  */
@@ -8098,6 +8146,7 @@ done: __maybe_unused;
 		hrtick_start_fair(rq, p);
 
 	update_misfit_status(p, rq);
+	sched_fair_update_stop_tick(rq, p);
 
 	return p;
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..6fdf1fdf6b17 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -101,3 +101,5 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+
+SCHED_FEAT(HZ_BW, false)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 63822c9238cc..d6d346bc78aa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -465,6 +465,7 @@ extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth
 extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
+extern bool cfs_task_bw_constrained(struct task_struct *p);
 
 extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 		struct sched_rt_entity *rt_se, int cpu,
-- 
2.31.1

