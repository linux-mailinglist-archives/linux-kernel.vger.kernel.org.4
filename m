Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E1D712A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244214AbjEZQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbjEZQKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:10:12 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6181B3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:10:06 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-623a6c15aacso10892356d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1685117405; x=1687709405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIkdz8z+pVsEhGeYAIhUFgTzgr78YTJYs/mvYCf1QV0=;
        b=jcZKhG9gF2DbXevwjQ4Hx8HC2gjmfDNlRkT3SELuiInPVHfMSfrEtedwiNO4nzNwx+
         W4uAqKNnbNnFh/qSH9LA646AXtiIRmqicrYfUFcXJQsObySG9Lcxf11pZvIZ5dWLt5mI
         Z/PrbUe195n74vBXKH0nkaNa2B/WMVe9FUuiLzTaKU2plWMAwIMTWV+lif6HEv0e8ilG
         5v4Z22yg45hwtuRBO5I0URlCqyFgwy+tPpyKPjN//u6+VvaDBMqtZSbVlRj+VEkjI8L5
         Yzq5+E/kY9GH2uV8IPP2KOsz9zVJ9LggtCJ3c0oG05uwJ4I3222zZJK5n2jl0rcaCW5Q
         IR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685117405; x=1687709405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIkdz8z+pVsEhGeYAIhUFgTzgr78YTJYs/mvYCf1QV0=;
        b=S3LLQhsJjb68K/e+/H4BY/cT1JJ4DP3Gv82iHCNUaS/qGUvpRtkWHF8YGyGbVzes3H
         dirEaUP+KqSdft4PkzdwON4iuVjhm3Pmb0FovL4U+zUh+a/SiW6om5MU1cW0O3Q0m61b
         CSd2AdVxAZvLBunQ1qQi5niFVkReh8BwZfnJPVuIeDPdIMxjHTTtiNhFNQ3EXSVv2YjV
         uhdUukBXei0mGfQnPeVc6wm1djWFjZ5Ry+hICphJeD/5SElbZf2GJN2FIlOWMObXwcmD
         7XxRFaAC3v/ihHIHNZexd9RL3BxvOCWZSiUIZ5dXehCn/D1sV5iki4ReV5+OyjLxs7Vd
         ZGFw==
X-Gm-Message-State: AC+VfDwlfdzOPtvwn4Cfii4RG15fLJ99NKm/tyUq8mrigHa3EYDQH7Fu
        hyfbmYlD6+g0AYBjPus+irezjQ==
X-Google-Smtp-Source: ACHHUZ6CuhRBtqhyw4S18qGek5BfE1VPSKVf3HDAzZVuXhFxOYzZUBTNWzePH2PrtD5PLI6uKLlyAg==
X-Received: by 2002:a05:6214:622:b0:616:5c8b:582 with SMTP id a2-20020a056214062200b006165c8b0582mr2355568qvx.37.1685117405150;
        Fri, 26 May 2023 09:10:05 -0700 (PDT)
Received: from vinz16.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id n18-20020a056214009200b0061b721f27b3sm1293682qvr.123.2023.05.26.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 09:10:04 -0700 (PDT)
From:   Vineeth Pillai <vineeth@bitbyteword.org>
To:     luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Vineeth Pillai <vineeth@bitbyteword.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 1/2] sched/deadline: Fix bandwidth reclaim equation in GRUB
Date:   Fri, 26 May 2023 12:09:56 -0400
Message-Id: <20230526160956.2283479-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526145519.2282062-1-vineeth@bitbyteword.org>
References: <20230526145519.2282062-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/sched/deadline.c | 56 +++++++++++++++++++----------------------
 kernel/sched/sched.h    |  6 +++++
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b24371a6f7..ea5db080f008 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1260,43 +1260,39 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
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
- * utilization, Uinact is the (per-runqueue) inactive utilization, computed
- * as the difference between the "total runqueue utilization" and the
- * runqueue active utilization, and Uextra is the (per runqueue) extra
- * reclaimable utilization.
- * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations
- * multiplied by 2^BW_SHIFT, the result has to be shifted right by
- * BW_SHIFT.
- * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT,
- * dl_bw is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.
- * Since delta is a 64 bit variable, to have an overflow its value
- * should be larger than 2^(64 - 20 - 8), which is more than 64 seconds.
- * So, overflow is not an issue here.
+ * bandwidth, Uinact is the (per-runqueue) inactive utilization, computed as
+ * the difference between the "total runqueue utilization" and the runqueue
+ * active utilization, and Uextra is the (per runqueue) extra reclaimable
+ * utilization.
+ * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations multiplied
+ * by 2^BW_SHIFT, the result has to be shifted right by BW_SHIFT.
+ * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT, dl_bw
+ * is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.i
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
 
@@ -2784,12 +2780,12 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
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
index 3e8df6d31c1e..73027c2806dc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -753,6 +753,12 @@ struct dl_rq {
 	u64			this_bw;
 	u64			extra_bw;
 
+	/*
+	 * Maximum available bandwidth for reclaiming by SCHED_FLAG_RECLAIM
+	 * tasks of this rq. Used in calculation of reclaimable bandwidth(GRUB).
+	 */
+	u64			max_bw;
+
 	/*
 	 * Inverse of the fraction of CPU utilization that can be reclaimed
 	 * by the GRUB algorithm.
-- 
2.40.1

