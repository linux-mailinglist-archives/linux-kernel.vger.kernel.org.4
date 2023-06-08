Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94949728083
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbjFHMx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbjFHMxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C705E1FE9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686228755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DF3P0wokkY59dQPGQ29NnzPHZoAXS481A55AVnfvnBg=;
        b=GIEAarmzNiLOJWjWvZkoUQCIzN4wNRpYwGtFm8FayN9g+sm+/v1YaX0sqz4pfukaRoJPTG
        byfRyRHlrKGAQ6wW4X7kcUja9AZJ4jymp0IeJp2Y9+SAZpHS09ALwAmxkll/Uq4eUWnZ64
        DgvbeYzsKQ6sWWwDPFG9oM6Ibp0MOVo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-b6Uwn8SQPf6DLs0AqZGcHQ-1; Thu, 08 Jun 2023 08:52:30 -0400
X-MC-Unique: b6Uwn8SQPf6DLs0AqZGcHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C503280BC5D;
        Thu,  8 Jun 2023 12:52:30 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9653C0448E;
        Thu,  8 Jun 2023 12:52:29 +0000 (UTC)
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
        Mel Gorman <mgorman@suse.de>, Phil Auld <pauld@redhat.com>
Subject: [PATCH v2] sched/nohz: Add HRTICK_BW for using cfs bandwidth with nohz_full
Date:   Thu,  8 Jun 2023 08:52:28 -0400
Message-Id: <20230608125228.56097-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CFS bandwidth limits and NOHZ full don't play well together.  Tasks
can easily run well past their quotas before a remote tick does
accounting.  This leads to long, multi-period stalls before such
tasks can run again.  Use the hrtick mechanism to set a sched
tick to fire at remaining_runtime in the future if we are on
a nohz full cpu, if the task has quota and if we are likely to
disable the tick (nr_running == 1).  This allows for bandwidth
accounting before tasks go too far over quota.

A number of container workloads use a dynamic number of real
nohz tasks but also have other work that is limited which ends
up running on the "spare" nohz cpus.  This is an artifact of
having to specify nohz_full cpus at boot. Adding this hrtick
resolves the issue of long stalls on these tasks. Currently
the scheduler, when faced with these conflicting requirements
choosed to favor nohz_full even though that is already best
effort. Here we make it favor respecting the bandwidth
limitations which are not supposed to be best effort.

Add the sched_feat HRTICK_BW off by default to allow users to
enable this only when needed.

Signed-off-by: Phil Auld <pauld@redhat.com>
Suggested-by: Juri Lelli <jlelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Ben Segall <bsegall@google.com>
---

v2: Clean up building issues with various related CONFIG changes. Add a
check to start the hrtick in __account_cfs_rq_runtime() for when the
task gets more runtime.

 kernel/sched/core.c     |  2 +-
 kernel/sched/fair.c     | 28 ++++++++++++++++++++++++++--
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    | 12 ++++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..76425c377245 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6562,7 +6562,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 	schedule_debug(prev, !!sched_mode);
 
-	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
+	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL) || sched_feat(HRTICK_BW))
 		hrtick_clear(rq);
 
 	local_irq_disable();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..95e4b70ebb0a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5190,6 +5190,11 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 		check_preempt_tick(cfs_rq, curr);
 }
 
+#if !defined(CONFIG_SCHED_HRTICK) || !defined(CONFIG_NO_HZ_FULL) || !defined(CONFIG_CFS_BANDWIDTH)
+static void start_hrtick_cfs_bw(struct rq *rq, struct cfs_rq *cfs_rq)
+{
+}
+#endif
 
 /**************************************************
  * CFS bandwidth control machinery
@@ -5309,6 +5314,18 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	return ret;
 }
 
+#if defined(CONFIG_SCHED_HRTICK) && defined(CONFIG_NO_HZ_FULL)
+static void start_hrtick_cfs_bw(struct rq *rq, struct cfs_rq *cfs_rq)
+{
+	if (!tick_nohz_full_cpu(rq->cpu) || !cfs_bandwidth_used() || !cfs_rq->runtime_enabled)
+		return;
+
+	/* runtime_remaining should never be negative here but just in case */
+	if (rq->nr_running == 1 && cfs_rq->runtime_remaining > 0)
+		hrtick_start(rq, cfs_rq->runtime_remaining);
+}
+#endif
+
 static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 {
 	/* dock delta_exec before expiring quota (as it could span periods) */
@@ -5323,8 +5340,12 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	 * if we're unable to extend our runtime we resched so that the active
 	 * hierarchy can be throttled
 	 */
-	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->curr))
-		resched_curr(rq_of(cfs_rq));
+	if (likely(cfs_rq->curr)) {
+		if (!assign_cfs_rq_runtime(cfs_rq))
+			resched_curr(rq_of(cfs_rq));
+		else if (hrtick_enabled_bw(rq_of(cfs_rq)))
+			start_hrtick_cfs_bw(rq_of(cfs_rq), cfs_rq);
+	}
 }
 
 static __always_inline
@@ -8096,6 +8117,9 @@ done: __maybe_unused;
 	if (hrtick_enabled_fair(rq))
 		hrtick_start_fair(rq, p);
 
+	if (hrtick_enabled_bw(rq))
+		start_hrtick_cfs_bw(rq, task_cfs_rq(p));
+
 	update_misfit_status(p, rq);
 
 	return p;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..c9d4fa0c1430 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -39,6 +39,7 @@ SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(HRTICK_DL, false)
+SCHED_FEAT(HRTICK_BW, false)
 SCHED_FEAT(DOUBLE_TICK, false)
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..db3a3b4b5746 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2507,6 +2507,13 @@ static inline int hrtick_enabled_dl(struct rq *rq)
 	return hrtick_enabled(rq);
 }
 
+static inline int hrtick_enabled_bw(struct rq *rq)
+{
+	if (!sched_feat(HRTICK_BW))
+		return 0;
+	return hrtick_enabled(rq);
+}
+
 void hrtick_start(struct rq *rq, u64 delay);
 
 #else
@@ -2521,6 +2528,11 @@ static inline int hrtick_enabled_dl(struct rq *rq)
 	return 0;
 }
 
+static inline int hrtick_enabled_bw(struct rq *rq)
+{
+	return 0;
+}
+
 static inline int hrtick_enabled(struct rq *rq)
 {
 	return 0;
-- 
2.31.1

