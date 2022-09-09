Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEED5B361B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIILOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiIILOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:14:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C3DDCC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HPekeP0jePbPI9lePYI40tGghCvYmY6tb3i734cwDDQ=; b=ulp5z8gCfshUdNTKwqAjPWj8Ep
        S9PSR6XxIbFYjr21D49XszuYTJf5Ydd/mGLgsnqkTomXfWvDKan8GT6oX5zNDWMQXTycR7qu6cp1U
        elfFhFw0ZzJ8aUQDHsa2m4EmHPmCS0KR+VwI7X9Sj/+QAjplYrHePj4FOqmTGp5wIsmYtK4nyjntY
        bupFNxCBaqBBcA1siaSEgEix0UKfr99djIdIKC0y3zfQj6l6NOb69nSYMvcjtfdPPRB1hzmbTQ5eB
        dH//uRqP+OssPwb83hUsIzN669qJKVKeBGsVMGeekmjnEdk3o1tdvBAseAsHBiJXD13fPpHR+WBJl
        czBiyAzQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWbxb-00DD3D-RU; Fri, 09 Sep 2022 11:14:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05831300023;
        Fri,  9 Sep 2022 13:14:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAC9329A2CD66; Fri,  9 Sep 2022 13:14:07 +0200 (CEST)
Date:   Fri, 9 Sep 2022 13:14:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Subject: Re: [PATCH 4/4] sched/fair: limit sched slice duration
Message-ID: <Yxsf/5ErmVoKFucb@hirez.programming.kicks-ass.net>
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-5-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825122726.20819-5-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Picked up the first three.

On Thu, Aug 25, 2022 at 02:27:26PM +0200, Vincent Guittot wrote:
> In presence of a lot of small weight tasks like sched_idle tasks, normal
> or high weight tasks can see their ideal runtime (sched_slice) to increase
> to hundreds ms whereas it normally stays below sysctl_sched_latency.
> 
> 2 normal tasks running on a CPU will have a max sched_slice of 12ms
> (half of the sched_period). This means that they will make progress
> every sysctl_sched_latency period.
> 
> If we now add 1000 idle tasks on the CPU, the sched_period becomes

Surely people aren't actually having that many runnable tasks and this
is a device for the argument?

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
> Cap the ideal_runtime to sysctl_sched_latency when comparing to the next
> waiting task to make sure that tasks will regularly make progress and will
> not be significantly impacted by idle/background tasks queued on the rq.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> While studying the problem, I have also considered to substract
> cfs.idle_h_nr_running before computing the sched_slice but we can have
> quite similar problem with low weight bormal task/cgroup so I have decided
> to keep this solution.

That ^... my proposal below has the same problem.

This:

> Also, this solution doesn't completly remove the impact of idle tasks
> in the scheduling pattern but cap the running slice of a task to a max
> value of 2*sysctl_sched_latency.

I'm failing to see how.

>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 260a55ac462f..96fedd0ab5fa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4599,6 +4599,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  	if (delta < 0)
>  		return;

(I'm thinking that early return is a bit pointless, a negative value
won't be larger than ideal_time anyway)

> +	ideal_runtime =  min_t(u64, ideal_runtime, sysctl_sched_latency);
> +

(superfluous whitespace -- twice, once after the = once this whole extra
line)

>  	if (delta > ideal_runtime)
>  		resched_curr(rq_of(cfs_rq));
>  }

Urgghhhh..

so delta is in vtime here, while sched_latency is not, so the heavier
the queue, the larger this value becomes.

Given those 1000 idle tasks, rq-weight would be around 2048; however due
to nr_running being insane, sched_slice() ends up being something like:

  1000 * min_gran * 2 / 2048

which is around ~min_gran and so won't come near to latency.


since we already have idle_min_gran; how about something like this?


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index efceb670e755..8dd18fc0affa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -706,12 +706,14 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
  *
  * p = (nr <= nl) ? l : l*nr/nl
  */
-static u64 __sched_period(unsigned long nr_running)
+static u64 __sched_period(unsigned long nr_running, unsigned long nr_idle)
 {
-	if (unlikely(nr_running > sched_nr_latency))
-		return nr_running * sysctl_sched_min_granularity;
-	else
-		return sysctl_sched_latency;
+	u64 period = 0;
+
+	period += nr_running * sysctl_sched_min_granularity;
+	period += nr_idle    * sysctl_sched_idle_min_granularity;
+
+	return max_t(u64, period, sysctl_sched_latency);
 }
 
 static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
@@ -724,15 +726,25 @@ static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
  */
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	unsigned int nr_running = cfs_rq->nr_running;
+	unsigned int nr_idle = cfs_rq->idle_nr_running;
+	unsigned int nr_running = cfs_rq->nr_running - nr_idle;
 	struct sched_entity *init_se = se;
 	unsigned int min_gran;
 	u64 slice;
 
-	if (sched_feat(ALT_PERIOD))
-		nr_running = rq_of(cfs_rq)->cfs.h_nr_running;
+	if (sched_feat(ALT_PERIOD)) {
+		nr_idle = rq_of(cfs_rq)->cfs.idle_h_nr_running;
+		nr_running = rq_of(cfs_rq)->cfs.h_nr_running - nr_idle;
+	}
+
+	if (!se->on_rq) {
+		if (se_is_idle(se))
+			nr_idle++;
+		else
+			nr_running++;
+	}
 
-	slice = __sched_period(nr_running + !se->on_rq);
+	slice = __sched_period(nr_running, nr_idle);
 
 	for_each_sched_entity(se) {
 		struct load_weight *load;


This changes how the compute the period depending on the composition. It
suffers the exact same problem you had earlier though in that it doesn't
work for the other low-weight cases. But perhaps we can come up with a
better means of computing the period that *does* consider them?

As said before;... urgh! bit of a sticky problem this.
