Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7DD6CBD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjC1LHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjC1LHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD422101
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Th+8KN7gw9xQ3Ie5C5sF47B/Af5VSq6Fs9EGC7kUB74=; b=Ey292Cg1NPfNDAUzxpJjTyufdI
        LfR8+0PUcX4VvWZhdE7pC6j+WAUTN7n56irCa3A0GgHjhDFJ9qIJVJ6cg5OMzLePfaAK2Fi8hkLOC
        It3IVQuH1PZ++W0YjbZNh8ayNU8EKArAUMzGJAOWtf+AhI7j+zEYSdTHtuQ85d/FiT+KwBETNwPnl
        KZpBkQhdUyTAyDwcxV1h4t9EeiaoglisievtW0jUGWo5DKnsK+0Tdq9UkE6fDY/kEEWTolXgPDrSG
        CjcAn38qFIzQXEa9oc5syT+Q8vNm1ntdixpVAA1I//1fa8cq7qESMNd3wnBBlmuxE7xe1LY4Lwq8x
        cad4EhcQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ph79l-008MDC-GL; Tue, 28 Mar 2023 11:06:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 514BB302E82;
        Tue, 28 Mar 2023 13:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BD1EF2CB8CEC0; Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Message-ID: <20230328110353.988000317@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de
Subject: [PATCH 06/17] sched/fair: Add lag based placement
References: <20230328092622.062917921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of avg_vruntime, it is possible to approximate
lag (the entire purpose of introducing it in fact). Use this to do lag
based placement over sleep+wake.

Specifically, the FAIR_SLEEPERS thing places things too far to the
left and messes up the deadline aspect of EEVDF.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |    1 
 kernel/sched/core.c     |    1 
 kernel/sched/fair.c     |  129 ++++++++++++++++++++++++++++++++++--------------
 kernel/sched/features.h |    8 ++
 4 files changed, 104 insertions(+), 35 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -555,6 +555,7 @@ struct sched_entity {
 	u64				sum_exec_runtime;
 	u64				vruntime;
 	u64				prev_sum_exec_runtime;
+	s64				vlag;
 
 	u64				nr_migrations;
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4439,6 +4439,7 @@ static void __sched_fork(unsigned long c
 	p->se.prev_sum_exec_runtime	= 0;
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
+	p->se.vlag			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 	set_latency_offset(p);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -689,6 +689,15 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 	return cfs_rq->min_vruntime + avg;
 }
 
+/*
+ * lag_i = S - s_i = w_i * (V - v_i)
+ */
+void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	SCHED_WARN_ON(!se->on_rq);
+	se->vlag = avg_vruntime(cfs_rq) - se->vruntime;
+}
+
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 {
 	u64 min_vruntime = cfs_rq->min_vruntime;
@@ -3417,6 +3426,8 @@ dequeue_load_avg(struct cfs_rq *cfs_rq,
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
+	unsigned long old_weight = se->load.weight;
+
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
@@ -3429,6 +3440,14 @@ static void reweight_entity(struct cfs_r
 
 	update_load_set(&se->load, weight);
 
+	if (!se->on_rq) {
+		/*
+		 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v),
+		 * we need to scale se->vlag when w_i changes.
+		 */
+		se->vlag = div_s64(se->vlag * old_weight, weight);
+	}
+
 #ifdef CONFIG_SMP
 	do {
 		u32 divider = get_pelt_divider(&se->avg);
@@ -4778,49 +4797,86 @@ static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
 	u64 vruntime = avg_vruntime(cfs_rq);
+	s64 lag = 0;
 
-	/* sleeps up to a single latency don't count. */
-	if (!initial) {
-		unsigned long thresh;
+	/*
+	 * Due to how V is constructed as the weighted average of entities,
+	 * adding tasks with positive lag, or removing tasks with negative lag
+	 * will move 'time' backwards, this can screw around with the lag of
+	 * other tasks.
+	 *
+	 * EEVDF: placement strategy #1 / #2
+	 */
+	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running > 1) {
+		struct sched_entity *curr = cfs_rq->curr;
+		unsigned long load;
 
-		if (se_is_idle(se))
-			thresh = sysctl_sched_min_granularity;
-		else
-			thresh = sysctl_sched_latency;
+		lag = se->vlag;
 
 		/*
-		 * Halve their sleep time's effect, to allow
-		 * for a gentler effect of sleepers:
+		 * If we want to place a task and preserve lag, we have to
+		 * consider the effect of the new entity on the weighted
+		 * average and compensate for this, otherwise lag can quickly
+		 * evaporate:
+		 *
+		 * l_i = V - v_i <=> v_i = V - l_i
+		 *
+		 * V = v_avg = W*v_avg / W
+		 *
+		 * V' = (W*v_avg + w_i*v_i) / (W + w_i)
+		 *    = (W*v_avg + w_i(v_avg - l_i)) / (W + w_i)
+		 *    = v_avg + w_i*l_i/(W + w_i)
+		 *
+		 * l_i' = V' - v_i = v_avg + w_i*l_i/(W + w_i) - (v_avg - l)
+		 *      = l_i - w_i*l_i/(W + w_i)
+		 *
+		 * l_i = (W + w_i) * l_i' / W
 		 */
-		if (sched_feat(GENTLE_FAIR_SLEEPERS))
-			thresh >>= 1;
+		load = cfs_rq->avg_load;
+		if (curr && curr->on_rq)
+			load += curr->load.weight;
+
+		lag *= load + se->load.weight;
+		if (WARN_ON_ONCE(!load))
+			load = 1;
+		lag = div_s64(lag, load);
 
-		vruntime -= thresh;
+		vruntime -= lag;
 	}
 
-	/*
-	 * Pull vruntime of the entity being placed to the base level of
-	 * cfs_rq, to prevent boosting it if placed backwards.
-	 * However, min_vruntime can advance much faster than real time, with
-	 * the extreme being when an entity with the minimal weight always runs
-	 * on the cfs_rq. If the waking entity slept for a long time, its
-	 * vruntime difference from min_vruntime may overflow s64 and their
-	 * comparison may get inversed, so ignore the entity's original
-	 * vruntime in that case.
-	 * The maximal vruntime speedup is given by the ratio of normal to
-	 * minimal weight: scale_load_down(NICE_0_LOAD) / MIN_SHARES.
-	 * When placing a migrated waking entity, its exec_start has been set
-	 * from a different rq. In order to take into account a possible
-	 * divergence between new and prev rq's clocks task because of irq and
-	 * stolen time, we take an additional margin.
-	 * So, cutting off on the sleep time of
-	 *     2^63 / scale_load_down(NICE_0_LOAD) ~ 104 days
-	 * should be safe.
-	 */
-	if (entity_is_long_sleeper(se))
-		se->vruntime = vruntime;
-	else
-		se->vruntime = max_vruntime(se->vruntime, vruntime);
+	if (sched_feat(FAIR_SLEEPERS)) {
+
+		/* sleeps up to a single latency don't count. */
+		if (!initial) {
+			unsigned long thresh;
+
+			if (se_is_idle(se))
+				thresh = sysctl_sched_min_granularity;
+			else
+				thresh = sysctl_sched_latency;
+
+			/*
+			 * Halve their sleep time's effect, to allow
+			 * for a gentler effect of sleepers:
+			 */
+			if (sched_feat(GENTLE_FAIR_SLEEPERS))
+				thresh >>= 1;
+
+			vruntime -= thresh;
+		}
+
+		/*
+		 * Pull vruntime of the entity being placed to the base level of
+		 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
+		 * slept for a long time, don't even try to compare its vruntime with
+		 * the base as it may be too far off and the comparison may get
+		 * inversed due to s64 overflow.
+		 */
+		if (!entity_is_long_sleeper(se))
+			vruntime = max_vruntime(se->vruntime, vruntime);
+	}
+
+	se->vruntime = vruntime;
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
@@ -4991,6 +5047,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 
 	clear_buddies(cfs_rq, se);
 
+	if (flags & DEQUEUE_SLEEP)
+		update_entity_lag(cfs_rq, se);
+
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
 	se->on_rq = 0;
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -1,12 +1,20 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Only give sleepers 50% of their service deficit. This allows
  * them to run sooner, but does not allow tons of sleepers to
  * rip the spread apart.
  */
+SCHED_FEAT(FAIR_SLEEPERS, false)
 SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true)
 
 /*
+ * Using the avg_vruntime, do the right thing and preserve lag across
+ * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
+ */
+SCHED_FEAT(PLACE_LAG, true)
+
+/*
  * Prefer to schedule the task we woke last (assuming it failed
  * wakeup-preemption), since its likely going to consume data we
  * touched, increases cache locality.


