Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1997B6CBD25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjC1LH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjC1LHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342687AB7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=rFkZWbr6epe4ysBPcRnlqJMbFVzCAlpZk+mTEWDb3+8=; b=h+aPeTz936eH8XwSGnoE8yDWVa
        8dIb19pjAJ9gA48QJ34XYOJtoMlbLNEUlpE47vwjjNxuz/IbjJunRn51Z8NHJmiQhbHF17F6g/fpa
        SNn7oW9rkVSUiKxdDr8XKDXftPo8z+M9/WNstyhf57DvydrId68Z50Ym0CJR+Km/ODR2gGD8nsFWF
        K3Xe/his6HITHHUyIS48hdrW1xcxI4MrUEHJQ+57wCgQu48dcqCJLynxIyf9ezvg9JMx7FHVsTei/
        mg69Q96RhBJAVLq1X6x+kps6j+lCSKJAumk96m6BnnwckON0udVwXcvKMFPnVLCW0coKSUbY9AZUp
        lVP5/7Zg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph79m-006XV5-0W;
        Tue, 28 Mar 2023 11:06:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68A743030F1;
        Tue, 28 Mar 2023 13:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EF17E2CB8D7A8; Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Message-ID: <20230328110354.494493579@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:35 +0200
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
Subject: [PATCH 13/17] sched: Merge latency_offset into slice
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


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    2 --
 kernel/sched/core.c   |   17 +++++++----------
 kernel/sched/fair.c   |   29 ++++++++++++-----------------
 kernel/sched/sched.h  |    2 +-
 4 files changed, 20 insertions(+), 30 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -573,8 +573,6 @@ struct sched_entity {
 	/* cached value of my_q->h_nr_running */
 	unsigned long			runnable_weight;
 #endif
-	/* preemption offset in ns */
-	long				latency_offset;
 
 #ifdef CONFIG_SMP
 	/*
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1285,9 +1285,10 @@ static void set_load_weight(struct task_
 	}
 }
 
-static void set_latency_offset(struct task_struct *p)
+static inline void set_latency_prio(struct task_struct *p, int prio)
 {
-	p->se.latency_offset = calc_latency_offset(p->latency_prio - MAX_RT_PRIO);
+	p->latency_prio = prio;
+	set_latency_fair(&p->se, prio - MAX_RT_PRIO);
 }
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -4442,7 +4443,7 @@ static void __sched_fork(unsigned long c
 	p->se.vlag			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
-	set_latency_offset(p);
+	set_latency_prio(p, p->latency_prio);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
@@ -4694,9 +4695,7 @@ int sched_fork(unsigned long clone_flags
 
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
-
-		p->latency_prio = NICE_TO_PRIO(0);
-		set_latency_offset(p);
+		set_latency_prio(p, NICE_TO_PRIO(0));
 
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
@@ -7469,10 +7468,8 @@ static void __setscheduler_params(struct
 static void __setscheduler_latency(struct task_struct *p,
 				   const struct sched_attr *attr)
 {
-	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
-		p->latency_prio = NICE_TO_PRIO(attr->sched_latency_nice);
-		set_latency_offset(p);
-	}
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
+		set_latency_prio(p, NICE_TO_PRIO(attr->sched_latency_nice));
 }
 
 /*
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -919,12 +919,19 @@ int sched_update_scaling(void)
 }
 #endif
 
-long calc_latency_offset(int prio)
+void set_latency_fair(struct sched_entity *se, int prio)
 {
 	u32 weight = sched_prio_to_weight[prio];
 	u64 base = sysctl_sched_base_slice;
 
-	return div_u64(base << SCHED_FIXEDPOINT_SHIFT, weight);
+	/*
+	 * For EEVDF the virtual time slope is determined by w_i (iow.
+	 * nice) while the request time r_i is determined by
+	 * latency-nice.
+	 *
+	 * Smaller request gets better latency.
+	 */
+	se->slice = div_u64(base << SCHED_FIXEDPOINT_SHIFT, weight);
 }
 
 /*
@@ -937,13 +944,6 @@ static void update_deadline(struct cfs_r
 		return;
 
 	/*
-	 * For EEVDF the virtual time slope is determined by w_i (iow.
-	 * nice) while the request time r_i is determined by
-	 * latency-nice.
-	 */
-	se->slice = se->latency_offset;
-
-	/*
 	 * EEVDF: vd_i = ve_i + r_i / w_i
 	 */
 	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
@@ -12231,7 +12231,7 @@ void init_tg_cfs_entry(struct task_group
 
 	se->my_q = cfs_rq;
 
-	se->latency_offset = calc_latency_offset(tg->latency_prio - MAX_RT_PRIO);
+	set_latency_fair(se, tg->latency_prio - MAX_RT_PRIO);
 
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
@@ -12365,7 +12365,6 @@ int sched_group_set_idle(struct task_gro
 
 int sched_group_set_latency(struct task_group *tg, int prio)
 {
-	long latency_offset;
 	int i;
 
 	if (tg == &root_task_group)
@@ -12379,13 +12378,9 @@ int sched_group_set_latency(struct task_
 	}
 
 	tg->latency_prio = prio;
-	latency_offset = calc_latency_offset(prio - MAX_RT_PRIO);
 
-	for_each_possible_cpu(i) {
-		struct sched_entity *se = tg->se[i];
-
-		WRITE_ONCE(se->latency_offset, latency_offset);
-	}
+	for_each_possible_cpu(i)
+		set_latency_fair(tg->se[i], prio - MAX_RT_PRIO);
 
 	mutex_unlock(&shares_mutex);
 	return 0;
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2477,7 +2477,7 @@ extern unsigned int sysctl_numa_balancin
 extern unsigned int sysctl_numa_balancing_hot_threshold;
 #endif
 
-extern long calc_latency_offset(int prio);
+extern void set_latency_fair(struct sched_entity *se, int prio);
 
 #ifdef CONFIG_SCHED_HRTICK
 


