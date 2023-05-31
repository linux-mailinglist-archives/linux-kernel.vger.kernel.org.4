Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4471804D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbjEaMtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbjEaMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:49:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5396BE4D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PBSWmj9vFVjjLqcL4+nxKoAvy2PS0YCtwS6oEGVZY9I=; b=HK+Caj9r6h1z6KIgMujfd8PAKB
        ZyhYVnYFBeMYPB7WX57TqP32+u0yeT7U7Nhea18FLdt0lWvyIVCWR10Ieg0LEd6hAA+uWLqLRw8Yx
        zozyJIqLEgDwspR4NESvHqogFaIjwHmgSDuvnmgxYI84l6stgVybvmcgQfr9L5fNtFiRobXeI0Pax
        hZ08j6NEAkXdCYkYP6RpYrs7oqJi31Kf1knppewryVJd9c2hRTS7k685Fpke3uQJUcNAMq9naeJnz
        ZCQoFempJQHna20ZC4wyKBSRyL2SrypVYUc2VlkgmGIRFYDU8gasck+Z7Pj9WnGMuT2yl86Giyrff
        YeBji3fA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4LEq-007GRd-0U; Wed, 31 May 2023 12:47:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 956C9300F2D;
        Wed, 31 May 2023 14:47:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1F0CD22BA6460; Wed, 31 May 2023 14:47:34 +0200 (CEST)
Message-ID: <20230531124604.477939524@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:52 +0200
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
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: [RFC][PATCH 13/15] sched/fair: Implement latency-nice
References: <20230531115839.089944915@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement latency-nice as a modulation of the EEVDF r_i parameter,
specifically apply the inverse sched_prio_to_weight[] relation on
base_slice.

Given a base slice of 3 [ms], this gives a range of:

  latency-nice  19: 3*1024 / 15    ~= 204.8 [ms]
  latency-nice -20: 3*1024 / 88761 ~= 0.034 [ms]

(which might not make sense)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/core.c  |   14 ++++++++++----
 kernel/sched/fair.c  |   22 +++++++++++++++-------
 kernel/sched/sched.h |    2 ++
 3 files changed, 27 insertions(+), 11 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1305,6 +1305,12 @@ static void set_load_weight(struct task_
 	}
 }
 
+static inline void set_latency_prio(struct task_struct *p, int prio)
+{
+	p->latency_prio = prio;
+	set_latency_fair(&p->se, prio - MAX_RT_PRIO);
+}
+
 #ifdef CONFIG_UCLAMP_TASK
 /*
  * Serializes updates of utilization clamp values
@@ -4464,9 +4470,10 @@ static void __sched_fork(unsigned long c
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
-	p->se.slice			= sysctl_sched_base_slice;
 	INIT_LIST_HEAD(&p->se.group_node);
 
+	set_latency_prio(p, p->latency_prio);
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
 #endif
@@ -4718,8 +4725,7 @@ int sched_fork(unsigned long clone_flags
 
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
-
-		p->latency_prio = NICE_TO_PRIO(0);
+		set_latency_prio(p, NICE_TO_PRIO(0));
 
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
@@ -7507,7 +7513,7 @@ static void __setscheduler_latency(struc
 				   const struct sched_attr *attr)
 {
 	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
-		p->latency_prio = NICE_TO_PRIO(attr->sched_latency_nice);
+		set_latency_prio(p, NICE_TO_PRIO(attr->sched_latency_nice));
 }
 
 /*
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -952,6 +952,21 @@ int sched_update_scaling(void)
 }
 #endif
 
+void set_latency_fair(struct sched_entity *se, int prio)
+{
+	u32 weight = sched_prio_to_weight[prio];
+	u64 base = sysctl_sched_base_slice;
+
+	/*
+	 * For EEVDF the virtual time slope is determined by w_i (iow.
+	 * nice) while the request time r_i is determined by
+	 * latency-nice.
+	 *
+	 * Smaller request gets better latency.
+	 */
+	se->slice = div_u64(base << SCHED_FIXEDPOINT_SHIFT, weight);
+}
+
 static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 /*
@@ -964,13 +979,6 @@ static void update_deadline(struct cfs_r
 		return;
 
 	/*
-	 * For EEVDF the virtual time slope is determined by w_i (iow.
-	 * nice) while the request time r_i is determined by
-	 * sysctl_sched_base_slice.
-	 */
-	se->slice = sysctl_sched_base_slice;
-
-	/*
 	 * EEVDF: vd_i = ve_i + r_i / w_i
 	 */
 	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2495,6 +2495,8 @@ extern unsigned int sysctl_numa_balancin
 extern unsigned int sysctl_numa_balancing_hot_threshold;
 #endif
 
+extern void set_latency_fair(struct sched_entity *se, int prio);
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*


