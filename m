Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C053A5EFA02
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbiI2QP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbiI2QO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:14:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8FE4F69B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OPck0VJyM7bO16UPacFIE4sdcn9Bc4TQ+v+IAp5LVkY=; b=oWi7u6UHUKio8rfYHQub4orzkl
        uKaCXtiJW+coLCVJ7SlCk8OQ8/06xoueAbx/3uxaIXCjlRJsNyYHcRTtea71QhDa2Tk+bcPkrIFWS
        CvKbQuXPvN7tCUHyVk0EeBqgEH7G94P1g0IcqMjK9fmkXyVU6TPW6wwdq/PAfiaoFdGoRYuS3pZ6m
        zxRmX+rAELj8Fnil4xAjearXdFA87I3MiVVrokcZzLjZuJ+y7E6rZQcM7cpWQSW6HQPjVwJl9PWrk
        GUi5TXU2Eqr4swgRy+wMIkoHdfGNeihHPSx4oLO4cLNrv9Ebt5gabT+Hi1+Ncwx7MDJTQLPFG2MQT
        mmHPXUQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odwBH-00DPfk-Jr; Thu, 29 Sep 2022 16:14:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A71E93001E3;
        Thu, 29 Sep 2022 18:14:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A468203C88A6; Thu, 29 Sep 2022 18:14:30 +0200 (CEST)
Date:   Thu, 29 Sep 2022 18:14:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Subject: Re: [PATCH v2] sched/fair: limit sched slice duration
Message-ID: <YzXEZnH6CAtZ+V4R@hirez.programming.kicks-ass.net>
References: <20220916131538.24706-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916131538.24706-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 03:15:38PM +0200, Vincent Guittot wrote:
> In presence of a lot of small weight tasks like sched_idle tasks, normal
> or high weight tasks can see their ideal runtime (sched_slice) to increase
> to hundreds ms whereas it normally stays below sysctl_sched_latency.
> 
> 2 normal tasks running on a CPU will have a max sched_slice of 12ms
> (half of the sched_period). This means that they will make progress
> every sysctl_sched_latency period.
> 
> If we now add 1000 idle tasks on the CPU, the sched_period becomes
> 3006 ms and the ideal runtime of the normal tasks becomes 609 ms.
> It will even become 1500ms if the idle tasks belongs to an idle cgroup.
> This means that the scheduler will look for picking another waiting task
> after 609ms running time (1500ms respectively). The idle tasks change
> significantly the way the 2 normal tasks interleave their running time
> slot whereas they should have a small impact.
> 
> Such long sched_slice can delay significantly the release of resources
> as the tasks can wait hundreds of ms before the next running slot just
> because of idle tasks queued on the rq.
> 
> Cap the ideal_runtime to the weighted version of sysctl_sched_latency when
> comparing with the vruntime of the next waiting task to make sure that
> tasks will regularly make progress and will not be significantly impacted
> by idle/background tasks queued on the rq.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> I have kept the test if (delta < 0) as calc_delta_fair() can't handle negative
> value.
> 
> Change since v1:
>   - the first 3 patches have been already queued
>   - use the weight of curr to scale sysctl_sched_latency before capping
>     the ideal_runtime so we can compare vruntime values.
> 
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5ffec4370602..ba451bb25929 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4610,6 +4610,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  	if (delta < 0)
>  		return;
>  
> +	ideal_runtime = min_t(u64, ideal_runtime,
> +				   calc_delta_fair(sysctl_sched_latency, curr));
>  	if (delta > ideal_runtime)
>  		resched_curr(rq_of(cfs_rq));
>  }

Since I'm suffering from a cold and constant interruptions I had to
write down my thinking and ended up with the below.

Does that make sense or did I go sideways somewhere (entirely possible).

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5ffec4370602..2b218167fadf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4575,17 +4575,33 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 }
 
 /*
- * Preempt the current task with a newly woken task if needed:
+ * Tick driven preemption; preempt the task if it has ran long enough.
+ * Allows other tasks to have a go.
  */
 static void
 check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
-	unsigned long ideal_runtime, delta_exec;
 	struct sched_entity *se;
-	s64 delta;
+	s64 delta, delta_exec;
+	u64 ideal_runtime;
 
-	ideal_runtime = sched_slice(cfs_rq, curr);
+	/* How long has this task been on the CPU for [walltime]. */
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
+
+	/*
+	 * Ensure that a task that missed wakeup preemption by a
+	 * narrow margin doesn't have to wait for a full slice.
+	 * This also mitigates buddy induced latencies under load.
+	 */
+	if (delta_exec < sysctl_sched_min_granularity)
+		return;
+
+	/*
+	 * When many tasks blow up the sched_period; it is possible that
+	 * sched_slice() reports unusually large results (when many tasks are
+	 * very light for example). Therefore impose a maximum.
+	 */
+	ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
 	if (delta_exec > ideal_runtime) {
 		resched_curr(rq_of(cfs_rq));
 		/*
@@ -4597,19 +4613,24 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	}
 
 	/*
-	 * Ensure that a task that missed wakeup preemption by a
-	 * narrow margin doesn't have to wait for a full slice.
-	 * This also mitigates buddy induced latencies under load.
+	 * Strictly speaking the above is sufficient; however due to
+	 * imperfections it is possible to have a leftmost task left of
+	 * min_vruntime.
+	 *
+	 * Also impose limits on the delta in vtime.
 	 */
-	if (delta_exec < sysctl_sched_min_granularity)
-		return;
 
 	se = __pick_first_entity(cfs_rq);
 	delta = curr->vruntime - se->vruntime;
-
 	if (delta < 0)
 		return;
 
+	/*
+	 * Compare @delta [vtime] to @ideal_runtime [walltime]. This means that
+	 * heavy tasks (for which vtime goes slower) get relatively more time
+	 * before preemption, while light tasks (for which vtime goes faster)
+	 * get relatively less time.  IOW, heavy task get to run longer.
+	 */
 	if (delta > ideal_runtime)
 		resched_curr(rq_of(cfs_rq));
 }
