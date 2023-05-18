Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58721708288
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjERNVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjERNV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A58D93
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684416044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RqtokjOkOF+2lAk9iGKu2GhNiZhdNYr4CZGeZFdMbr0=;
        b=OU85ss+sRkrN5BQAkHHf2Ke3WbST3Yo4ipRDMKnJsVXKsXxh4nARWNxc41+UAI4B+KjL41
        FYwio6lL21rfqAcsRUxRDrjc8W4lKnznRXrov/2fM/KWtZoZEpF+1b4G5YfxWbEaZ3JVjU
        rYSa3I7FmFuUmi74kZtTq4mo9m1lRNs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-xXxmC--zNICbjoK52KL_iQ-1; Thu, 18 May 2023 09:20:40 -0400
X-MC-Unique: xXxmC--zNICbjoK52KL_iQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83567101A54F;
        Thu, 18 May 2023 13:20:39 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 228272166B31;
        Thu, 18 May 2023 13:20:39 +0000 (UTC)
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
Subject: [PATCH RESEND] sched/nohz: Add HRTICK_BW for using cfs bandwidth with nohz_full
Date:   Thu, 18 May 2023 09:20:38 -0400
Message-Id: <20230518132038.3534728-1-pauld@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
resolves the issue of long stalls on these tasks.

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

Resend with LKML address instead of rh list...

 kernel/sched/core.c     |  2 +-
 kernel/sched/fair.c     | 20 ++++++++++++++++++++
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    | 12 ++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

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
index 373ff5f55884..0dd1f6a874bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5309,6 +5309,22 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
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
+#else
+static void start_hrtick_cfs_bw(struct rq *rq, struct cfs_rq *cfs_rq)
+{
+}
+#endif
+
 static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 {
 	/* dock delta_exec before expiring quota (as it could span periods) */
@@ -5481,6 +5497,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 */
 	cfs_rq->throttled = 1;
 	cfs_rq->throttled_clock = rq_clock(rq);
+
 	return true;
 }
 
@@ -8096,6 +8113,9 @@ done: __maybe_unused;
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

