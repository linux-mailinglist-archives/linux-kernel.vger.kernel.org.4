Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7997021EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbjEOC5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbjEOC5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:57:31 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E31D1984
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f507edcaaaso22329281cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1684119443; x=1686711443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lIJvTsYG8IVqKvLsuCqQCH24IS8rxjIyEsCxC8Ekzo=;
        b=Hxby+KZbvGKNXas4QOqBhpllFeYbMrES+rRzoyIVnS1QVDwALzDUwnxZO75URpkrYR
         mwiIg+/wA6KSUrbA9btdgEAiEtrEVDBK9aIvy6gFaxtZxaCRO5EUHimlzPg6l8Zy0WlQ
         SomjVz1BcH43hpOXqaDrv4+iwh31agTB5z9WbEZp2kwx6KgfhaLYt2SaWFHhKq0XtqcN
         lCPvyoaz+ssqApVUhikBdq9hupM4+2KypiSzBTzxwrE7BQX2zGGvKsbjAYEPF87UZs+V
         BZEYjXPiWMVewNm/UP17KMAu3n1gKhU8iiV2yhEvS6dM0wgvF3dvxGYDdjDukDg76Kb7
         eP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684119443; x=1686711443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lIJvTsYG8IVqKvLsuCqQCH24IS8rxjIyEsCxC8Ekzo=;
        b=caXySOd32fp9nM7zgbeyFJjik0lNJ6Tm3YGMyp4BQVG+M4mhrgW6lalO9c1IpQ81ox
         DSzTBjh3OEHBd07u+hdYSwmdrk1EY+MPGxLMdt7W0V6J2f4e+LfcOGYbXB6eMytuU5bc
         7Jrl7Ld6exgAHChL7sU/GXXn40rGQ9KYGyTVb3/RcPi5+JMeLSCKL1YHsjbU9hcKdPn3
         uOx6yxADeVbBk75y5pBiWrudZVvMYD/StTSw4kKGV7S+MQpJK3hNG6tFfpJQDzyIksYc
         YpY7w1aPGFtgQfQBTaumcGDWMN2HYr+1fuFf4CX82v3Hop/rNGwspsmLzbTx4rBfqOsT
         /SNg==
X-Gm-Message-State: AC+VfDyHM2qHaWOGmxjQPcbz9Z+INlIuWm5lai8IbdSV1lcV2NkqdlPY
        xPZKMI0M5Ldm9jZtX+okQbnWrA==
X-Google-Smtp-Source: ACHHUZ5GH3xBTIDMm/JewA8s5ESdUq296AFA4Tje1Z/oeSz703q+OohHVZ8JympWr6Wt6WAsMByh8Q==
X-Received: by 2002:a05:622a:4c6:b0:3f5:320e:8b14 with SMTP id q6-20020a05622a04c600b003f5320e8b14mr542358qtx.52.1684119443439;
        Sun, 14 May 2023 19:57:23 -0700 (PDT)
Received: from vinz16.lan (c-73-143-21-186.hsd1.ma.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a134300b007339c5114a9sm2308994qkl.103.2023.05.14.19.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 19:57:23 -0700 (PDT)
From:   Vineeth Pillai <vineeth@bitbyteword.org>
To:     luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Vineeth Pillai <vineeth@bitbyteword.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 1/5] sched/deadline: Fix bandwidth reclaim equation in GRUB
Date:   Sun, 14 May 2023 22:57:12 -0400
Message-Id: <20230515025716.316888-2-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515025716.316888-1-vineeth@bitbyteword.org>
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the GRUB[1] rule, the runtime is depreciated as:
  "dq = -max{u, (1 - Uinact - Uextra)} dt" (1)

To guarentee that deadline tasks doesn't starve lower class tasks,
we do not allocate the full bandwidth of the cpu to deadline tasks.
Maximum bandwidth usable by deadline tasks is denoted by "Umax".
Considering Umax, equation (1) becomes:
  "dq = -(max{u, (Umax - Uinact - Uextra)} / Umax) dt" (2)

Current implementation has a minor bug in equation (2). This patch
fixes the bug and also fixes the precision issue by using div64_u64.

The reclamation logic is verified by a sample program which creates
multiple deadline threads and observing their utilization. The tests
were run on an isolated cpu(isolcpus=3) on a 4 cpu system.

Tests on 6.3.0
==============

RUN 1: runtime=7ms, deadline=period=10ms, RT capacity = 95%
TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.33
TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.35
TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.35
TID[693]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 93.29

RUN 2: runtime=1ms, deadline=period=100ms, RT capacity = 95%
TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.69
TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.69
TID[708]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 16.70

RUN 3: 2 tasks
  Task 1: runtime=1ms, deadline=period=10ms
  Task 2: runtime=1ms, deadline=period=100ms
TID[631]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 62.67
TID[632]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 6.37
TID[631]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 62.38
TID[632]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 6.19
TID[631]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 62.60
TID[632]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 6.23
TID[631]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 62.43

As seen above, the reclamation doesn't reclaim the maximum allowed
bandwidth and as the bandwidth of tasks gets smaller, the reclaimed
bandwidth also comes down.

Tests with this patch applied
=============================

RUN 1: runtime=7ms, deadline=period=10ms, RT capacity = 95%
TID[667]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.01
TID[667]: RECLAIM=1, (r=7ms, d=10ms, p=10ms), Util: 95.00

RUN 2: runtime=1ms, deadline=period=100ms, RT capacity = 95%
TID[641]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 94.86
TID[641]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 95.06

RUN 3: 2 tasks
  Task 1: runtime=1ms, deadline=period=10ms
  Task 2: runtime=1ms, deadline=period=100ms
TID[636]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 86.44
TID[637]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 8.67
TID[636]: RECLAIM=1, (r=1ms, d=10ms, p=10ms), Util: 86.34
TID[637]: RECLAIM=1, (r=1ms, d=100ms, p=100ms), Util: 8.61

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
 kernel/sched/deadline.c | 72 ++++++++++++++++++++---------------------
 kernel/sched/sched.h    |  6 ++--
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b24371a6f7..91451c1c7e52 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -487,7 +487,7 @@ static inline int is_leftmost(struct task_struct *p, struct dl_rq *dl_rq)
 	return rb_first_cached(&dl_rq->root) == &dl_se->rb_node;
 }
 
-static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
+static void init_dl_rq_bw(struct dl_rq *dl_rq);
 
 void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime)
 {
@@ -523,7 +523,7 @@ void init_dl_rq(struct dl_rq *dl_rq)
 
 	dl_rq->running_bw = 0;
 	dl_rq->this_bw = 0;
-	init_dl_rq_bw_ratio(dl_rq);
+	init_dl_rq_bw(dl_rq);
 }
 
 #ifdef CONFIG_SMP
@@ -1261,43 +1261,47 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_se)
 
 /*
  * This function implements the GRUB accounting rule:
- * according to the GRUB reclaiming algorithm, the runtime is
- * not decreased as "dq = -dt", but as
- * "dq = -max{u / Umax, (1 - Uinact - Uextra)} dt",
- * where u is the utilization of the task, Umax is the maximum reclaimable
- * utilization, Uinact is the (per-runqueue) inactive utilization, computed
- * as the difference between the "total runqueue utilization" and the
- * runqueue active utilization, and Uextra is the (per runqueue) extra
- * reclaimable utilization.
- * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations
- * multiplied by 2^BW_SHIFT, the result has to be shifted right by
- * BW_SHIFT.
- * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT,
- * dl_bw is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.
+ * As per the GRUB rule,the runtime is not decreased as "dq = -dt", but as
+ *	"dq = -max{u, (1 - Uinact - Uextra)} dt",
+ * where:
+ *	u:		Bandwith of the task.
+ *	running_bw:	Total bandwidth of tasks in active state for this rq.
+ *	this_bw:	Reserved bandwidth for this rq. Includes active and
+ *			inactive bandwidth for this rq.
+ *	Uinact:		Inactive utilization (this_bw - running_bw)
+ *	Umax:		Max usable bandwidth for DL. Currently
+ *			= sched_rt_runtime_us / sched_rt_period_us
+ *	Uextra:		Extra bandwidth not reserved:
+ *			= Umax - \Sum(u_i / #cpus in the root domain)
+ *	u_i:		Bandwidth of an admitted dl task in the
+ *			root domain.
+ *
+ * Deadline tasks are not allowed to use the whole bandwidth of the cpu,
+ * but only a portion of it denoted by "Umax". So the equation becomes:
+ *	"dq = -(max{u, (Umax - Uinact - Uextra)} / Umax) dt",
+ *
  * Since delta is a 64 bit variable, to have an overflow its value
  * should be larger than 2^(64 - 20 - 8), which is more than 64 seconds.
  * So, overflow is not an issue here.
  */
 static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 {
-	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
 	u64 u_act;
-	u64 u_act_min = (dl_se->dl_bw * rq->dl.bw_ratio) >> RATIO_SHIFT;
+	u64 u_inact = rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uact */
 
 	/*
-	 * Instead of computing max{u * bw_ratio, (1 - u_inact - u_extra)},
+	 * Instead of computing max{u, (rq->dl.max_bw - u_inact - u_extra)},
 	 * we compare u_inact + rq->dl.extra_bw with
-	 * 1 - (u * rq->dl.bw_ratio >> RATIO_SHIFT), because
-	 * u_inact + rq->dl.extra_bw can be larger than
-	 * 1 * (so, 1 - u_inact - rq->dl.extra_bw would be negative
-	 * leading to wrong results)
+	 * rq->dl.max_bw - u, because u_inact + rq->dl.extra_bw can be larger
+	 * than rq->dl.max_bw (so, rq->dl.max_bw - u_inact - rq->dl.extra_bw
+	 * would be negative leading to wrong results)
 	 */
-	if (u_inact + rq->dl.extra_bw > BW_UNIT - u_act_min)
-		u_act = u_act_min;
+	if (u_inact + rq->dl.extra_bw > rq->dl.max_bw - dl_se->dl_bw)
+		u_act = dl_se->dl_bw;
 	else
-		u_act = BW_UNIT - u_inact - rq->dl.extra_bw;
+		u_act = rq->dl.max_bw - u_inact - rq->dl.extra_bw;
 
-	return (delta * u_act) >> BW_SHIFT;
+	return div64_u64(delta * u_act, rq->dl.max_bw);
 }
 
 /*
@@ -2780,17 +2784,13 @@ int sched_dl_global_validate(void)
 	return ret;
 }
 
-static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
+static void init_dl_rq_bw(struct dl_rq *dl_rq)
 {
-	if (global_rt_runtime() == RUNTIME_INF) {
-		dl_rq->bw_ratio = 1 << RATIO_SHIFT;
-		dl_rq->extra_bw = 1 << BW_SHIFT;
-	} else {
-		dl_rq->bw_ratio = to_ratio(global_rt_runtime(),
-			  global_rt_period()) >> (BW_SHIFT - RATIO_SHIFT);
-		dl_rq->extra_bw = to_ratio(global_rt_period(),
+	if (global_rt_runtime() == RUNTIME_INF)
+		dl_rq->max_bw = dl_rq->extra_bw = 1 << BW_SHIFT;
+	else
+		dl_rq->max_bw = dl_rq->extra_bw = to_ratio(global_rt_period(),
 						    global_rt_runtime());
-	}
 }
 
 void sched_dl_do_global(void)
@@ -2819,7 +2819,7 @@ void sched_dl_do_global(void)
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
 		rcu_read_unlock_sched();
-		init_dl_rq_bw_ratio(&cpu_rq(cpu)->dl);
+		init_dl_rq_bw(&cpu_rq(cpu)->dl);
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e8df6d31c1e..1bc7ae9ad349 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -754,10 +754,10 @@ struct dl_rq {
 	u64			extra_bw;
 
 	/*
-	 * Inverse of the fraction of CPU utilization that can be reclaimed
-	 * by the GRUB algorithm.
+	 * Maximum available bandwidth for deadline tasks of this rq. This is
+	 * used in calculation of reclaimable bandwidth(GRUB).
 	 */
-	u64			bw_ratio;
+	u64			max_bw;
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.40.1

