Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEF5743D17
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjF3N6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjF3N6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3086E1FDF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688133441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/Mb3/vAXvYSOXJ0WoEaEg/3Fwgn4e3x4h9lc+0POYcw=;
        b=GF6uQ5L9BcjuORbGT+klwig7h0HR70IygsenP4EdSPBn8kapnQwXP3aZsNMPizdG7StfPm
        dGepwlXWrgFhf1J2aWT3iv0PkbU8NDPKIy/eQtE9Jl0/sa6jnX9LmmYN1ASmAMSsnTvTZ6
        glF61et35ZJ9EmK8dIvY0FZ548xC+Ws=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-jn7JcaiPM2Cea50w1EuwZg-1; Fri, 30 Jun 2023 09:57:17 -0400
X-MC-Unique: jn7JcaiPM2Cea50w1EuwZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A4671C03D82;
        Fri, 30 Jun 2023 13:57:16 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22471F5CEF;
        Fri, 30 Jun 2023 13:57:16 +0000 (UTC)
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
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v4] Sched/fair: Block nohz tick_stop when cfs bandwidth in use
Date:   Fri, 30 Jun 2023 09:57:14 -0400
Message-Id: <20230630135714.1018434-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
Cc: Frederic Weisbecker <frederic@kernel.org>
---
v4: Made checks for runtime_enabled hierarchical. 

v3: Moved sched_cfs_bandwidth_active() prototype to sched.h outside of
guards to silence -Wmissing-prototypes.

v2:  Ben pointed out that the bit could get cleared in the dequeue path
if we migrate a newly enqueued task without preempting curr. Added a
check for that edge case to sched_can_stop_tick. Removed the call to
sched_can_stop_tick from sched_fair_update_stop_tick since it was
redundant.

 kernel/sched/core.c     | 10 ++++++++
 kernel/sched/fair.c     | 53 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  2 ++
 kernel/sched/sched.h    |  1 +
 4 files changed, 66 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..2685373e12f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1229,6 +1229,16 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (rq->nr_running > 1)
 		return false;
 
+	/*
+	 * If there is one task and it has CFS runtime bandwidth constraints
+	 * and it's on the cpu now we don't want to stop the tick.
+	 */
+	if (sched_feat(HZ_BW) && rq->nr_running == 1 && rq->curr
+	    && rq->curr->sched_class == &fair_sched_class && task_on_rq_queued(rq->curr)) {
+		if (sched_cfs_bandwidth_active(rq->curr))
+			return false;
+	}
+
 	return true;
 }
 #endif /* CONFIG_NO_HZ_FULL */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..125b1ec4476f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6139,6 +6139,50 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 	rcu_read_unlock();
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+static inline bool cfs_se_bandwidth_enabled(struct sched_entity *se)
+{
+	int ret = 0;
+
+	for_each_sched_entity(se)
+		ret += cfs_rq_of(se)->runtime_enabled;
+
+	return ret != 0;
+}
+
+bool sched_cfs_bandwidth_active(struct task_struct *p)
+{
+	if (cfs_bandwidth_used() && cfs_se_bandwidth_enabled(&p->se))
+		return true;
+
+	return false;
+}
+
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
+	if (cfs_se_bandwidth_enabled(&p->se))
+		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
+}
+#endif
+
 #else /* CONFIG_CFS_BANDWIDTH */
 
 static inline bool cfs_bandwidth_used(void)
@@ -6181,9 +6225,17 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
 static inline void update_runtime_enabled(struct rq *rq) {}
 static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
+bool sched_cfs_bandwidth_active(struct task_struct *p)
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
@@ -8097,6 +8149,7 @@ done: __maybe_unused;
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
index ec7b3e0a2b20..41f80dd5538d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2789,6 +2789,7 @@ extern void init_dl_rq(struct dl_rq *dl_rq);
 
 extern void cfs_bandwidth_usage_inc(void);
 extern void cfs_bandwidth_usage_dec(void);
+extern bool sched_cfs_bandwidth_active(struct task_struct *p);
 
 #ifdef CONFIG_NO_HZ_COMMON
 #define NOHZ_BALANCE_KICK_BIT	0
-- 
2.31.1

