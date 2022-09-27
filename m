Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687785EBE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiI0JQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiI0JQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:16:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AA1B089C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fVt9SBxMubuJsK6285/X6ye0apMEGBc2pWjgWDYGOmU=; b=PyblJSgjtFsfgawJh9QtIS0RM2
        aFo/0gR8yRHSkU5NDr809AchK6U6LqecFBJ7mSwTwKJ+jcCybAoAsIExvjXJs4EICwkdsa6t8I/g6
        YSfGjdjfGW1p5//+wSMDLyjnrQCJalIryNCjCwWvix2RjcQIBWFqh4kjB+Lg2ZDzW9WVxDCbPAReW
        efEqEUMb0mF8sMszt3eXXnPRSpTkGbP26tcLinCUu1xcr99deSHkHh7obvy6BOgSBjmrvYyQ0KfqE
        8BVhWRC3qHF2FfLJeTx5cDMlD+Gn06czMTAxRozIp2TcIIuyhzvqcboBeg6XqYc/ngo4xFalgMjdr
        CKnExe7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od6gx-00BIXl-Ao; Tue, 27 Sep 2022 09:15:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39C1630007E;
        Tue, 27 Sep 2022 11:15:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1753220424F71; Tue, 27 Sep 2022 11:15:46 +0200 (CEST)
Date:   Tue, 27 Sep 2022 11:15:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 08/23] sched/fair: Compute task-class performance
 scores for load balancing
Message-ID: <YzK/QisKmix6hrKG@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-9-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909231205.14009-9-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:11:50PM -0700, Ricardo Neri wrote:

> +static void compute_ilb_sg_task_class_scores(struct sg_lb_task_class_stats *class_sgs,
> +					     struct sg_lb_stats *sgs,
> +					     int dst_cpu)
> +{
> +	int group_score, group_score_without, score_on_dst_cpu;
> +	int busy_cpus = sgs->group_weight - sgs->idle_cpus;
> +
> +	if (!sched_task_classes_enabled())
> +		return;
> +
> +	/* No busy CPUs in the group. No tasks to move. */
> +	if (!busy_cpus)
> +		return;
> +
> +	score_on_dst_cpu = arch_get_task_class_score(class_sgs->p_min_score->class,
> +						     dst_cpu);
> +
> +	/*
> +	 * The simpest case. The single busy CPU in the current group will
> +	 * become idle after pulling its current task. The destination CPU is
> +	 * idle.
> +	 */
> +	if (busy_cpus == 1) {
> +		sgs->task_class_score_before = class_sgs->sum_score;
> +		sgs->task_class_score_after = score_on_dst_cpu;
> +		return;
> +	}
> +
> +	/*
> +	 * Now compute the group score with and without the task with the
> +	 * lowest score. We assume that the tasks that remain in the group share
> +	 * the CPU resources equally.
> +	 */
> +	group_score = class_sgs->sum_score / busy_cpus;
> +
> +	group_score_without =  (class_sgs->sum_score - class_sgs->min_score) /
> +			       (busy_cpus - 1);
> +
> +	sgs->task_class_score_after = group_score_without + score_on_dst_cpu;
> +	sgs->task_class_score_before = group_score;
> +}

That's just plain broken; also lots of cleanups done...

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8405,12 +8405,14 @@ struct sg_lb_stats {
 	enum group_type group_type;
 	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
-	long task_class_score_after; /* Prospective task-class score after load balancing */
-	long task_class_score_before; /* Task-class score before load balancing */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
 #endif
+#ifdef CONFIG_SCHED_TASK_CLASSES
+	long task_class_score_after;  /* Prospective task-class score after load balancing */
+	long task_class_score_before; /* Task-class score before load balancing */
+#endif
 };
 
 /*
@@ -8689,58 +8691,54 @@ group_type group_classify(unsigned int i
 }
 
 struct sg_lb_task_class_stats {
-	/*
-	 * Score of the task with lowest score among the current tasks (i.e.,
-	 * runqueue::curr) of all runqueues in the scheduling group.
-	 */
-	int min_score;
-	/*
-	 * Sum of the scores of the current tasks of all runqueues in the
-	 * scheduling group.
-	 */
-	long sum_score;
-	/* The task with score equal to @min_score */
-	struct task_struct *p_min_score;
+	int min_score;                   /* Min(rq->curr->score) */
+	int min_class;
+	long sum_score;                  /* Sum(rq->curr->score) */
 };
 
 #ifdef CONFIG_SCHED_TASK_CLASSES
-static void init_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs)
+static void init_sg_lb_task_class_stats(struct sg_lb_task_class_stats *sgcs)
 {
-	class_sgs->min_score = INT_MAX;
-	class_sgs->sum_score = 0;
-	class_sgs->p_min_score = NULL;
+	*sgcs = (struct sg_lb_task_class_stats){
+		.min_score = INT_MAX,
+	};
 }
 
 /** Called only if cpu_of(@rq) is not idle and has tasks running. */
-static void update_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs,
-					 struct rq *rq)
+static void update_sg_lb_task_class_stats(struct sg_lb_task_class_stats *sgcs,
+					  struct rq *rq)
 {
-	int score;
+	struct task_struct *curr;
+	int class, score;
 
 	if (!sched_task_classes_enabled())
 		return;
 
+	curr = rcu_dereference(rq->curr);
+	if (!curr || (curr->flags & PF_EXITING) || is_idle_task(curr))
+		return;
+
 	/*
 	 * TODO: if nr_running > 1 we may want go through all the tasks behind
 	 * rq->curr.
 	 */
-	score = arch_get_task_class_score(rq->curr->class, cpu_of(rq));
-
-	class_sgs->sum_score += score;
+	class = curr->class;
+	score = arch_get_task_class_score(class, cpu_of(rq));
 
-	if (score >= class_sgs->min_score)
-		return;
+	sgcs->sum_score += score;
 
-	class_sgs->min_score = score;
-	class_sgs->p_min_score = rq->curr;
+	if (score < sgcs->min_score) {
+		sgcs->min_score = score;
+		sgcs->min_class = class;
+	}
 }
 
-static void compute_ilb_sg_task_class_scores(struct sg_lb_task_class_stats *class_sgs,
-					     struct sg_lb_stats *sgs,
-					     int dst_cpu)
+static void update_sg_lb_stats_scores(struct sg_lb_task_class_stats *sgcs,
+				      struct sg_lb_stats *sgs,
+				      int dst_cpu)
 {
-	int group_score, group_score_without, score_on_dst_cpu;
 	int busy_cpus = sgs->group_weight - sgs->idle_cpus;
+	long before, after;
 
 	if (!sched_task_classes_enabled())
 		return;
@@ -8749,32 +8747,18 @@ static void compute_ilb_sg_task_class_sc
 	if (!busy_cpus)
 		return;
 
-	score_on_dst_cpu = arch_get_task_class_score(class_sgs->p_min_score->class,
-						     dst_cpu);
+	score_on_dst_cpu = arch_get_task_class_score(sgcs->min_class, dst_cpu);
 
-	/*
-	 * The simpest case. The single busy CPU in the current group will
-	 * become idle after pulling its current task. The destination CPU is
-	 * idle.
-	 */
-	if (busy_cpus == 1) {
-		sgs->task_class_score_before = class_sgs->sum_score;
-		sgs->task_class_score_after = score_on_dst_cpu;
-		return;
-	}
+	before = sgcs->sum_score
+	after  = before - sgcs->min_score + score_on_dst_cpu;
 
-	/*
-	 * Now compute the group score with and without the task with the
-	 * lowest score. We assume that the tasks that remain in the group share
-	 * the CPU resources equally.
-	 */
-	group_score = class_sgs->sum_score / busy_cpus;
-
-	group_score_without =  (class_sgs->sum_score - class_sgs->min_score) /
-			       (busy_cpus - 1);
+	if (busy_cpus > 1) {
+		before /= busy_cpus;
+		after  /= busy_cpus;
+	}
 
-	sgs->task_class_score_after = group_score_without + score_on_dst_cpu;
-	sgs->task_class_score_before = group_score;
+	sgs->task_class_score_before = before;
+	sgs->task_class_score_after  = after;
 }
 
 /**
@@ -8832,18 +8816,19 @@ static bool sched_asym_class_pick(struct
 }
 
 #else /* CONFIG_SCHED_TASK_CLASSES */
-static void update_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs,
-					 struct rq *rq)
+
+static void init_sg_lb_task_class_stats(struct sg_lb_task_class_stats *sgcs)
 {
 }
 
-static void init_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs)
+static void update_sg_lb_task_class_stats(struct sg_lb_task_class_stats *sgcs,
+					  struct rq *rq)
 {
 }
 
-static void compute_ilb_sg_task_class_scores(struct sg_lb_task_class_stats *class_sgs,
-					     struct sg_lb_stats *sgs,
-					     int dst_cpu)
+static void update_sg_lb_stats_scores(struct sg_lb_task_class_stats *sgcs,
+				      struct sg_lb_stats *sgs,
+				      int dst_cpu)
 {
 }
 
@@ -8854,7 +8839,6 @@ static bool sched_asym_class_pick(struct
 {
 	return false;
 }
-
 #endif /* CONFIG_SCHED_TASK_CLASSES */
 
 /**
@@ -8979,11 +8963,11 @@ static inline void update_sg_lb_stats(st
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
 {
-	struct sg_lb_task_class_stats class_stats;
+	struct sg_lb_task_class_stats sgcs;
 	int i, nr_running, local_group;
 
 	memset(sgs, 0, sizeof(*sgs));
-	init_rq_task_classes_stats(&class_stats);
+	init_sg_lb_task_class_stats(&sgcs);
 
 	local_group = group == sds->local;
 
@@ -9034,7 +9018,7 @@ static inline void update_sg_lb_stats(st
 				sgs->group_misfit_task_load = load;
 		}
 
-		update_rq_task_classes_stats(&class_stats, rq);
+		update_sg_lb_task_class_stats(&sgcs, rq);
 	}
 
 	sgs->group_capacity = group->sgc->capacity;
@@ -9045,7 +9029,7 @@ static inline void update_sg_lb_stats(st
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
 	    sched_asym(env, sds, sgs, group)) {
-		compute_ilb_sg_task_class_scores(&class_stats, sgs, env->dst_cpu);
+		update_sg_lb_stats_scores(&sgcs, sgs, env->dst_cpu);
 		sgs->group_asym_packing = 1;
 	}
 
