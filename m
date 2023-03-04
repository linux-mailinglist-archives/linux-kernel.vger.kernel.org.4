Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320846AA8B7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCDI3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDI3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:29:47 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D46158BF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 00:29:45 -0800 (PST)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PTHyh50P9z9tFb;
        Sat,  4 Mar 2023 16:27:40 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 4 Mar 2023 16:29:42 +0800
Message-ID: <79850642-ebac-5c23-d32d-b28737dcb91e@huawei.com>
Date:   Sat, 4 Mar 2023 16:29:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
From:   Zhang Qiao <zhangqiao22@huawei.com>
Subject: [PATCH] sched/fair: sanitize vruntime of entity being migrated
To:     lkml <linux-kernel@vger.kernel.org>
CC:     Valentin Schneider <vschneid@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ben Segall <bsegall@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
entity being placed") fix an overflowing bug, but ignore
a case that se->exec_start is reset after a migration.

For fix this case, we reset the vruntime of a loog sleep
task in migrate_task_rq_fair().

Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/fair.c | 73 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff4dbbae3b10..6697462baf0f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4648,6 +4648,41 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #endif
 }
 +static inline bool entity_is_long_sleep(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq;
+	u64 sleep_time;
+
+	if (se->exec_start == 0)
+		return false;
+
+	cfs_rq = cfs_rq_of(se);
+	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
+	if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
+		return true;
+
+	return false;
+}
+
+static inline u64 sched_sleeper_credit(struct sched_entity *se)
+{
+	unsigned long thresh;
+
+	if (se_is_idle(se))
+		thresh = sysctl_sched_min_granularity;
+	else
+		thresh = sysctl_sched_latency;
+
+	/*
+	 * Halve their sleep time's effect, to allow
+	 * for a gentler effect of sleepers:
+	 */
+	if (sched_feat(GENTLE_FAIR_SLEEPERS))
+		thresh >>= 1;
+
+	return thresh;
+}
+
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
@@ -4664,23 +4699,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 		vruntime += sched_vslice(cfs_rq, se);
  	/* sleeps up to a single latency don't count. */
-	if (!initial) {
-		unsigned long thresh;
-
-		if (se_is_idle(se))
-			thresh = sysctl_sched_min_granularity;
-		else
-			thresh = sysctl_sched_latency;
-
-		/*
-		 * Halve their sleep time's effect, to allow
-		 * for a gentler effect of sleepers:
-		 */
-		if (sched_feat(GENTLE_FAIR_SLEEPERS))
-			thresh >>= 1;
-
-		vruntime -= thresh;
-	}
+	if (!initial)
+		vruntime -= sched_sleeper_credit(se);
  	/*
 	 * Pull vruntime of the entity being placed to the base level of
@@ -4689,8 +4709,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 	 * the base as it may be too far off and the comparison may get
 	 * inversed due to s64 overflow.
 	 */
-	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
-	if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
+	if (entity_is_long_sleep(se))
 		se->vruntime = vruntime;
 	else
 		se->vruntime = max_vruntime(se->vruntime, vruntime);
@@ -7635,7 +7654,21 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	if (READ_ONCE(p->__state) == TASK_WAKING) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 -		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
+		/*
+		 * We determine a task whether sleep for long by checking se->exec_start,
+		 * and if it is, sanitize its vruntime at place_entity(). However, after
+		 * a migration, this detection method fails due to se->exec_start is reset.
+		 *
+		 * For fix this case, we add the same check at here. For a task which has
+		 * slept for long, its vruntime should be reset cfs_rq->min_vruntime and get
+		 * a sleep credit. Because waking task's vruntime will be added cfs_rq->min_vruntime
+		 * when enqueue, so we only need resetting the se->vruntime of waking task
+		 * to a credit at here.
+		 */
+		if (entity_is_long_sleep(se))
+			se->vruntime = -sched_sleeper_credit(se);
+		else
+			se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
 	}
  	if (!task_on_rq_migrating(p)) {
-- 
2.17.1

.
