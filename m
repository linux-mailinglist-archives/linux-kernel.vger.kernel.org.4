Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF1735575
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjFSLGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjFSLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:05:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DF410DE;
        Mon, 19 Jun 2023 04:04:55 -0700 (PDT)
Date:   Mon, 19 Jun 2023 11:04:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687172693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBk6SVQF8hbLqgrYb7zBnRJ0TouOnsyxVPTI0vV8hDc=;
        b=hbmtd5SEN1CPWEFk6+CLULGU5Bp1u7moVRZ3FQHARFXXBFi3GZcS0Z4vYVCl9hOtwWpcIr
        pmJ2HPaxCP4OmY1gdHVSxNz8FOV8SvgjNZjtLLTGXSPU/gJ8mMIMehSAqg4GnVMlUylj1T
        Hb1sJpp+GpH9HxS3WRZwA4WRnkAnhrMCqzFu1NG6Y5EiCc9jyH7B8qMbKYqCApUmqSPeAl
        nkHNilI1mdyDgrCj5ebwB4881Jcw+c9WXeZMxtZEOcx6I/vMoDPVyvyrD7/KvQaADm5Imj
        F7YkLzBRfMFFqA8sKDfmCKF65AXVEpYNFxiM7fsCWZOzvJE7yqKiREhW5vW49Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687172693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBk6SVQF8hbLqgrYb7zBnRJ0TouOnsyxVPTI0vV8hDc=;
        b=Ggq39IJsydop6sOJbiJ8PF2HeS7F/itIyzGezceFf3T8PkKMOmrkcBZYWuF2y21oO1O5YY
        DI4s2dDFowUT99Dw==
From:   "tip-bot2 for Vineeth Pillai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix bandwidth reclaim equation in GRUB
Cc:     "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230530135526.2385378-1-vineeth@bitbyteword.org>
References: <20230530135526.2385378-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Message-ID: <168717269311.404.14622042036287952781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6a9d623aad89539eca71eb264db6b9d538620ad5
Gitweb:        https://git.kernel.org/tip/6a9d623aad89539eca71eb264db6b9d538620ad5
Author:        Vineeth Pillai <vineeth@bitbyteword.org>
AuthorDate:    Tue, 30 May 2023 09:55:25 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 22:08:11 +02:00

sched/deadline: Fix bandwidth reclaim equation in GRUB

According to the GRUB[1] rule, the runtime is depreciated as:
  "dq = -max{u, (1 - Uinact - Uextra)} dt" (1)

To guarantee that deadline tasks doesn't starve lower class tasks,
we do not allocate the full bandwidth of the cpu to deadline tasks.
Maximum bandwidth usable by deadline tasks is denoted by "Umax".
Considering Umax, equation (1) becomes:
  "dq = -(max{u, (Umax - Uinact - Uextra)} / Umax) dt" (2)

Current implementation has a minor bug in equation (2), which this
patch fixes.

The reclamation logic is verified by a sample program which creates
multiple deadline threads and observing their utilization. The tests
were run on an isolated cpu(isolcpus=3) on a 4 cpu system.

Tests on 6.3.0
==============

RUN 1: runtime=7ms, deadline=period=10ms, RT capacity = 95%
TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.33
TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.35

RUN 2: runtime=1ms, deadline=period=100ms, RT capacity = 95%
TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.69
TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.69

RUN 3: 2 tasks
  Task 1: runtime=1ms, deadline=period=10ms
  Task 2: runtime=1ms, deadline=period=100ms
TID[631]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 62.67
TID[632]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 6.37
TID[631]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 62.38
TID[632]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 6.23

As seen above, the reclamation doesn't reclaim the maximum allowed
bandwidth and as the bandwidth of tasks gets smaller, the reclaimed
bandwidth also comes down.

Tests with this patch applied
=============================

RUN 1: runtime=7ms, deadline=period=10ms, RT capacity = 95%
TID[608]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.19
TID[608]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.16

RUN 2: runtime=1ms, deadline=period=100ms, RT capacity = 95%
TID[616]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 95.27
TID[616]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 95.21

RUN 3: 2 tasks
  Task 1: runtime=1ms, deadline=period=10ms
  Task 2: runtime=1ms, deadline=period=100ms
TID[620]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 86.64
TID[621]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 8.66
TID[620]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 86.45
TID[621]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 8.73

Running tasks on all cpus allowing for migration also showed that
the utilization is reclaimed to the maximum. Running 10 tasks on
3 cpus SCHED_FLAG_RECLAIM - top shows:
%Cpu0  : 94.6 us,  0.0 sy,  0.0 ni,  5.4 id,  0.0 wa
%Cpu1  : 95.2 us,  0.0 sy,  0.0 ni,  4.8 id,  0.0 wa
%Cpu2  : 95.8 us,  0.0 sy,  0.0 ni,  4.2 id,  0.0 wa

[1]: Abeni, Luca & Lipari, Giuseppe & Parri, Andrea & Sun, Youcheng.
     (2015). Parallel and sequential reclaiming in multicore
     real-time global scheduling.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20230530135526.2385378-1-vineeth@bitbyteword.org
---
 kernel/sched/deadline.c | 50 ++++++++++++++++++----------------------
 kernel/sched/sched.h    |  6 +++++-
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f827067..e41a36b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1253,43 +1253,39 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
 }
 
 /*
- * This function implements the GRUB accounting rule:
- * according to the GRUB reclaiming algorithm, the runtime is
- * not decreased as "dq = -dt", but as
- * "dq = -max{u / Umax, (1 - Uinact - Uextra)} dt",
+ * This function implements the GRUB accounting rule. According to the
+ * GRUB reclaiming algorithm, the runtime is not decreased as "dq = -dt",
+ * but as "dq = -(max{u, (Umax - Uinact - Uextra)} / Umax) dt",
  * where u is the utilization of the task, Umax is the maximum reclaimable
  * utilization, Uinact is the (per-runqueue) inactive utilization, computed
  * as the difference between the "total runqueue utilization" and the
- * runqueue active utilization, and Uextra is the (per runqueue) extra
+ * "runqueue active utilization", and Uextra is the (per runqueue) extra
  * reclaimable utilization.
- * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations
- * multiplied by 2^BW_SHIFT, the result has to be shifted right by
- * BW_SHIFT.
- * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT,
- * dl_bw is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.
- * Since delta is a 64 bit variable, to have an overflow its value
- * should be larger than 2^(64 - 20 - 8), which is more than 64 seconds.
- * So, overflow is not an issue here.
+ * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations multiplied
+ * by 2^BW_SHIFT, the result has to be shifted right by BW_SHIFT.
+ * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT, dl_bw
+ * is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.
+ * Since delta is a 64 bit variable, to have an overflow its value should be
+ * larger than 2^(64 - 20 - 8), which is more than 64 seconds. So, overflow is
+ * not an issue here.
  */
 static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 {
-	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
 	u64 u_act;
-	u64 u_act_min = (dl_se->dl_bw * rq->dl.bw_ratio) >> RATIO_SHIFT;
+	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
 
 	/*
-	 * Instead of computing max{u * bw_ratio, (1 - u_inact - u_extra)},
-	 * we compare u_inact + rq->dl.extra_bw with
-	 * 1 - (u * rq->dl.bw_ratio >> RATIO_SHIFT), because
-	 * u_inact + rq->dl.extra_bw can be larger than
-	 * 1 * (so, 1 - u_inact - rq->dl.extra_bw would be negative
-	 * leading to wrong results)
+	 * Instead of computing max{u, (u_max - u_inact - u_extra)}, we
+	 * compare u_inact + u_extra with u_max - u, because u_inact + u_extra
+	 * can be larger than u_max. So, u_max - u_inact - u_extra would be
+	 * negative leading to wrong results.
 	 */
-	if (u_inact + rq->dl.extra_bw > BW_UNIT - u_act_min)
-		u_act = u_act_min;
+	if (u_inact + rq->dl.extra_bw > rq->dl.max_bw - dl_se->dl_bw)
+		u_act = dl_se->dl_bw;
 	else
-		u_act = BW_UNIT - u_inact - rq->dl.extra_bw;
+		u_act = rq->dl.max_bw - u_inact - rq->dl.extra_bw;
 
+	u_act = (u_act * rq->dl.bw_ratio) >> RATIO_SHIFT;
 	return (delta * u_act) >> BW_SHIFT;
 }
 
@@ -2788,12 +2784,12 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 {
 	if (global_rt_runtime() == RUNTIME_INF) {
 		dl_rq->bw_ratio = 1 << RATIO_SHIFT;
-		dl_rq->extra_bw = 1 << BW_SHIFT;
+		dl_rq->max_bw = dl_rq->extra_bw = 1 << BW_SHIFT;
 	} else {
 		dl_rq->bw_ratio = to_ratio(global_rt_runtime(),
 			  global_rt_period()) >> (BW_SHIFT - RATIO_SHIFT);
-		dl_rq->extra_bw = to_ratio(global_rt_period(),
-						    global_rt_runtime());
+		dl_rq->max_bw = dl_rq->extra_bw =
+			to_ratio(global_rt_period(), global_rt_runtime());
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 556496c..36e23e4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -748,6 +748,12 @@ struct dl_rq {
 	u64			extra_bw;
 
 	/*
+	 * Maximum available bandwidth for reclaiming by SCHED_FLAG_RECLAIM
+	 * tasks of this rq. Used in calculation of reclaimable bandwidth(GRUB).
+	 */
+	u64			max_bw;
+
+	/*
 	 * Inverse of the fraction of CPU utilization that can be reclaimed
 	 * by the GRUB algorithm.
 	 */
