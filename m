Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A468A73A1D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjFVN2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFVN2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395FC1997
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687440487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=m0MsYlp7FICmkkjzEoJpY6Zv2dtdWzKtFpA83D/IL1A=;
        b=CMY07IHOQ1il/kP8KGNAPqV8B95XOs/BF3ykHdXhq5hUNkVnmL3xpG0ts+UZMP0HSZZ5oG
        o2T3SjDTcvDMGCmRbddCumLhIPP8+gNBREd22cnyKb7BVn8B+jji6WLZ3Lx7MplQSuLqyN
        xMYL75eKIFOTAlj44bFZ0xuhYS5kgBs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-AjFBXJlnPoW1hXfIwXoWBQ-1; Thu, 22 Jun 2023 09:28:02 -0400
X-MC-Unique: AjFBXJlnPoW1hXfIwXoWBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09DE338117E3;
        Thu, 22 Jun 2023 13:27:53 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F5F9200B402;
        Thu, 22 Jun 2023 13:27:52 +0000 (UTC)
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
Subject: [PATCH] Sched/fair: Block nohz tick_stop when cfs bandwidth in use
Date:   Thu, 22 Jun 2023 09:27:51 -0400
Message-Id: <20230622132751.2900081-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CFS bandwidth limits and NOHZ full don't play well together.  Tasks
can easily run well past their quotas before a remote tick does
accounting.  This leads to long, multi-period stalls before such
tasks can run again. Currentlyi, when presented with these conflicting
requirements the scheduler is favoring nohz_full and letting the tick
be stopped. However, nohz tick stopping is already best-effort, there
are a number of conditions that can prevent it, whereas cfs runtime
bandwidth is expected to be enforced.

Make the scheduler favor bandwidth over stopping the tick by setting
TICK_DEP_BIT_SCHED when the only running task is a cfs task with
runtime limit enabled.

Add sched_feat HZ_BW (off by default) to control this behavior.

Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Ben Segall <bsegall@google.com>
---
 kernel/sched/fair.c     | 33 ++++++++++++++++++++++++++++++++-
 kernel/sched/features.h |  2 ++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..880eadfac330 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6139,6 +6139,33 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 	rcu_read_unlock();
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+/* called from pick_next_task_fair() */
+static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq = task_cfs_rq(p);
+	int cpu = cpu_of(rq);
+
+	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
+		return;
+
+	if (!tick_nohz_full_cpu(cpu))
+		return;
+
+	if (rq->nr_running != 1 || !sched_can_stop_tick(rq))
+		return;
+
+	/*
+	 *  We know there is only one task runnable and we've just picked it. The
+	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
+	 *  be otherwise able to stop the tick. Just need to check if we are using
+	 *  bandwidth control.
+	 */
+	if (cfs_rq->runtime_enabled)
+		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
+}
+#endif
+
 #else /* CONFIG_CFS_BANDWIDTH */
 
 static inline bool cfs_bandwidth_used(void)
@@ -6181,9 +6208,12 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
 static inline void update_runtime_enabled(struct rq *rq) {}
 static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
-
 #endif /* CONFIG_CFS_BANDWIDTH */
 
+#if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
+static inline void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p) {}
+#endif
+
 /**************************************************
  * CFS operations on tasks:
  */
@@ -8097,6 +8127,7 @@ done: __maybe_unused;
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
-- 
2.31.1

