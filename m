Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA38074B78B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjGGT6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjGGT6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC26D171F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688759874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQpIFIWdoNzqtFmzvTdy1ogknI8HTink88rGlIIVM54=;
        b=PPJwi2USLmTEOGeESBqdUEIkEICC6zzsBt4Iz0kxqkDEzwOOUTHn8y1gvmj+sjq/9w4YM1
        ya71iQclRu6EpAMxl2kMcP35jM2lb8s41nmNF2/Em0oE5qqT6NycOMkRDlbYVvr1gNICT3
        FOkj+rHrR5S0JEeSNbn5mS6wUhChaIw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-65Ufl6ofOaGZ9F2mc4SXZw-1; Fri, 07 Jul 2023 15:57:51 -0400
X-MC-Unique: 65Ufl6ofOaGZ9F2mc4SXZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B478805951;
        Fri,  7 Jul 2023 19:57:50 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AF384087C6A;
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
Subject: [PATCH v5 1/2] sched, cgroup: Restore meaning to hierarchical_quota
Date:   Fri,  7 Jul 2023 15:57:47 -0400
Message-Id: <20230707195748.2918490-2-pauld@redhat.com>
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

In cgroupv2 cfs_b->hierarchical_quota is set to -1 for all task
groups due to the previous fix simply taking the min.  It should
reflect a limit imposed at that level or by an ancestor. Even
though cgroupv2 does not require child quota to be less than or
equal to that of its ancestors the task group will still be
constrained by such a quota so this should be shown here. Cgroupv1
continues to set this correctly.

In both cases, add initialization when a new task group is created
based on the current parent's value (or RUNTIME_INF in the case of
root_task_group). Otherwise, the field is wrong until a quota is
changed after creation and __cfs_schedulable() is called.

Fixes: c53593e5cb69 ("sched, cgroup: Don't reject lower cpu.max on ancestors")
Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c  | 11 +++++++----
 kernel/sched/fair.c  |  7 ++++---
 kernel/sched/sched.h |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..1b214e10c25d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9904,7 +9904,7 @@ void __init sched_init(void)
 		ptr += nr_cpu_ids * sizeof(void **);
 
 		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
-		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
+		init_cfs_bandwidth(&root_task_group.cfs_bandwidth, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
 		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
@@ -11038,11 +11038,14 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
 
 		/*
 		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
-		 * always take the min.  On cgroup1, only inherit when no
-		 * limit is set:
+		 * always take the non-RUNTIME_INF min.  On cgroup1, only
+		 * inherit when no limit is set:
 		 */
 		if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
-			quota = min(quota, parent_quota);
+			if (quota == RUNTIME_INF)
+				quota = parent_quota;
+			else if (parent_quota != RUNTIME_INF)
+				quota = min(quota, parent_quota);
 		} else {
 			if (quota == RUNTIME_INF)
 				quota = parent_quota;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..92381f9ecf37 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6005,13 +6005,14 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
 }
 
-void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
+void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent)
 {
 	raw_spin_lock_init(&cfs_b->lock);
 	cfs_b->runtime = 0;
 	cfs_b->quota = RUNTIME_INF;
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 	cfs_b->burst = 0;
+	cfs_b->hierarchical_quota = ((parent) ? parent->hierarchical_quota : RUNTIME_INF);
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
@@ -6168,7 +6169,7 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	return 0;
 }
 
-void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
+void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent) {}
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
@@ -12373,7 +12374,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	tg->shares = NICE_0_LOAD;
 
-	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
+	init_cfs_bandwidth(tg_cfs_bandwidth(tg), tg_cfs_bandwidth(parent));
 
 	for_each_possible_cpu(i) {
 		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..63822c9238cc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -460,7 +460,7 @@ extern void unregister_fair_sched_group(struct task_group *tg);
 extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *se, int cpu,
 			struct sched_entity *parent);
-extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
+extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent);
 
 extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
-- 
2.31.1

