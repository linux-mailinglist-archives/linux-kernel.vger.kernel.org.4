Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EBF6D9CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbjDFPuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbjDFPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:50:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A4739750
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:50:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FE5A1C0A;
        Thu,  6 Apr 2023 08:51:30 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9EA3F3F6C4;
        Thu,  6 Apr 2023 08:50:44 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] sched: Consider CPU contention in frequency & load-balance busiest CPU selection
Date:   Thu,  6 Apr 2023 17:50:30 +0200
Message-Id: <20230406155030.1989554-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new cpu_boosted_util_cfs() instead of cpu_util_cfs().

The former returns max(util_avg, runnable_avg) capped by max CPU
capacity. CPU contention is thereby considered through runnable_avg.

The change in load-balance only affects migration type `migrate_util`.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/cpufreq_schedutil.c |  3 ++-
 kernel/sched/fair.c              |  2 +-
 kernel/sched/sched.h             | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e3211455b203..728b186cd367 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -158,7 +158,8 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
-	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
+	sg_cpu->util = effective_cpu_util(sg_cpu->cpu,
+					  cpu_boosted_util_cfs(sg_cpu->cpu),
 					  FREQUENCY_UTIL, NULL);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc358dc4faeb..5ae36224a1c2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10481,7 +10481,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 			break;
 
 		case migrate_util:
-			util = cpu_util_cfs(i);
+			util = cpu_boosted_util_cfs(i);
 
 			/*
 			 * Don't try to pull utilization from a CPU with one
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 060616944d7a..f42c859579d9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2994,6 +2994,25 @@ static inline unsigned long cpu_util_cfs(int cpu)
 	return min(util, capacity_orig_of(cpu));
 }
 
+/*
+ * cpu_boosted_util_cfs() - Estimates the amount of CPU capacity used by
+ *                          CFS tasks.
+ *
+ * Similar to cpu_util_cfs() but also take possible CPU contention into
+ * consideration.
+ */
+static inline unsigned long cpu_boosted_util_cfs(int cpu)
+{
+	unsigned long runnable;
+	struct cfs_rq *cfs_rq;
+
+	cfs_rq = &cpu_rq(cpu)->cfs;
+	runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
+	runnable = min(runnable, capacity_orig_of(cpu));
+
+	return max(cpu_util_cfs(cpu), runnable);
+}
+
 static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_rt.util_avg);
-- 
2.25.1

