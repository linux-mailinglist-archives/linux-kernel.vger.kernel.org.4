Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7595173F294
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjF0DXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjF0DWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:22:39 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EC13C30
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:17:36 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-763c997ee0aso428869985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835855; x=1690427855;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnI2PfaZuNUEtGUqro3mQY3XzfITSnWzQArJu64Bhyo=;
        b=KLfvmdtYpQbxhI8Xg3EWS7v0PuqreQBfaZAr71bFgGNos4yQs5oBn/+x5W38PLw4Gg
         IfC09NB3nJQ+itC8IkJW23LGXPHERLRkNBcMH64YD9C+N8QXU6cguev8otYC9t8aSWea
         oVku3z5+c+ZTKpBcW8OgmG3je54Y0X6q19eDTwsodi5euO6I4q+VSAsppDriZ2ASnyx2
         K0nDAtp1tROfBv4RtwE41jQl9EVrR9E/H352mlGrbXzM4zHszbBxiJRoFKkidTHZcrKa
         BftIyns+Ji5Y26NIdj6XZLxOb7Xy70DNcZkT+EmehPx+ymE2oS5gm38abqv+6JwPSsQX
         4tTw==
X-Gm-Message-State: AC+VfDwSmOAamORdpDBHFTkQVUvSlTb7nhrkCdCDtuLmlqbfgd/Wpt0Q
        mT4iNyaMP2VsoZQ3l+JkGuk=
X-Google-Smtp-Source: ACHHUZ4dPtcIEAWe+1y9ZniKhdFi1hYAqnOc0FhtHBlbUMOzxzmgVexEYk5Hoi7vnr8hGJKry/UsCA==
X-Received: by 2002:a05:6214:4116:b0:635:ec47:bfb4 with SMTP id kc22-20020a056214411600b00635ec47bfb4mr1557688qvb.40.1687835855531;
        Mon, 26 Jun 2023 20:17:35 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:58aa])
        by smtp.gmail.com with ESMTPSA id y11-20020ad457cb000000b00631eb444e6esm3819732qvx.51.2023.06.26.20.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:17:34 -0700 (PDT)
Date:   Mon, 26 Jun 2023 22:17:32 -0500
From:   David Vernet <void@manifault.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com, K Prateek Nayak <kprateek.nayak@amd.com>,
        clm@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230627031732.GD6750@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <ZI/x+RkSqpct4bM3@BLR-5CG11610CF.amd.com>
 <20230620200822.GC3027191@maniforge>
 <ZJKx/LQwc3bWS5nh@BLR-5CG11610CF.amd.com>
 <20230622014329.GD15990@maniforge>
 <ZJQQXQ/+p4f5FcAd@BLR-5CG11610CF.amd.com>
 <20230622102935.GG4253@hirez.programming.kicks-ass.net>
 <ZJVq1+dSkMAsOIKw@BLR-5CG11610CF.amd.com>
 <ZJkqeXkPJMTl49GB@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJkqeXkPJMTl49GB@BLR-5CG11610CF.amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:34:41AM +0530, Gautham R. Shenoy wrote:
> Hello Peter, David,

Hello Gautham,

Thanks a lot for running these experiments and experimenting with some
variations.

> 
> On Fri, Jun 23, 2023 at 03:20:15PM +0530, Gautham R. Shenoy wrote:
> > On Thu, Jun 22, 2023 at 12:29:35PM +0200, Peter Zijlstra wrote:
> > > On Thu, Jun 22, 2023 at 02:41:57PM +0530, Gautham R. Shenoy wrote:
> 
> > 
> > I will post more results later.
> 
> I was able to get some numbers for hackbench, schbench (old), and
> tbench over the weekend on a 2 Socket Zen3 box with 64 cores 128
> threads per socket configured in NPS1 mode.
> 
> The legend is as follows:
> 
> tip : tip/sched/core with HEAD being commit e2a1f85bf9f5 ("sched/psi:
>       Avoid resetting the min update period when it is unnecessary")
> 
> 
> david : This patchset
> 
> david-ego-1 : David's patchset + my modification to allow SIS signal
>               that a task should be queued on the shared-wakequeue when SIS cannot
>               find an idle CPU to wake up the task.
> 
> david-ego-2 : David's patchset + david-ego-1 + my modification to
> 	      remove the first task from the shared-wakequeue whose
> 	      cpus_allowed contains this CPU. Currently we don't do
> 	      this check and always remove the first task. 
> 
> 
> david-ego-1 and david-ego-2 are attached with this mail.
> 
> hackbench (Measure: time taken to complete, in seconds)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Test:         tip                david                david-ego-1          david-ego-2
> 1-groups:     3.92 (0.00 pct)    3.35 (14.54 pct)     3.53 (9.94 pct)      3.30 (15.81 pct)
> 2-groups:     4.58 (0.00 pct)    3.89 (15.06 pct)     3.95 (13.75 pct)     3.79 (17.24 pct)
> 4-groups:     4.99 (0.00 pct)    4.42 (11.42 pct)     4.76 (4.60 pct)      4.77 (4.40 pct)
> 8-groups:     5.67 (0.00 pct)    5.08 (10.40 pct)     6.16 (-8.64 pct)     6.33 (-11.64 pct)
> 16-groups:    7.88 (0.00 pct)    7.32 (7.10 pct)      8.57 (-8.75 pct)     9.77 (-23.98 pct)

Nice, these are pretty significant improvements.

> Observation: We see that David's patchset does very well across all
> the groups.  Expanding the scope of the shared-wakequeue with
> david-ego-1 doesn't give us much and in fact hurts at higher
> utilization. Same is the case with david-ego-2 which only pulls
> allowed tasks from the shared-wakequeue. In david-ego-2 we see a
> greater amount of spin-lock contention for 8 and 16 groups, as the
> code holds the spinlock and iterates through the list members while
> checking cpu-affinity.

Peter's idea to shard may help with the contention here. I also wonder
how we'd do with david-ego-2 minus david-ego-1. Perhaps the slightly
less aggressive enqueing would somewhat lower the contention?

> so, david's original patchset wins this one.
> 
> 
> 
> 
> schbench (measure : 99th percentile latency, in us)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> #workers: tip                     david                   david-ego-1             david-ego-2
>  1:      26.00 (0.00 pct)         21.00 (19.23 pct)       28.00 (-7.69 pct)       22.00 (15.38 pct)
>  2:      27.00 (0.00 pct)         29.00 (-7.40 pct)       28.00 (-3.70 pct)       30.00 (-11.11 pct)
>  4:      31.00 (0.00 pct)         31.00 (0.00 pct)        31.00 (0.00 pct)        28.00 (9.67 pct)
>  8:      36.00 (0.00 pct)         37.00 (-2.77 pct)       34.00 (5.55 pct)        39.00 (-8.33 pct)
> 16:      49.00 (0.00 pct)         49.00 (0.00 pct)        48.00 (2.04 pct)        50.00 (-2.04 pct)
> 32:      80.00 (0.00 pct)         80.00 (0.00 pct)        88.00 (-10.00 pct)      79.00 (1.25 pct)
> 64:     169.00 (0.00 pct)        180.00 (-6.50 pct)      174.00 (-2.95 pct)      168.00 (0.59 pct)
> 128:     343.00 (0.00 pct)       355.00 (-3.49 pct)      356.00 (-3.79 pct)      344.00 (-0.29 pct)
> 256:     42048.00 (0.00 pct)   46528.00 (-10.65 pct)   51904.00 (-23.43 pct)   48064.00 (-14.30 pct)
> 512:     95104.00 (0.00 pct)   95872.00 (-0.80 pct)    95360.00 (-0.26 pct)    97152.00 (-2.15 pct)
> 
> 
> observations: there are run-to-run variations with this benchmark. i
> will try with the newer schbench later this week. 

+cc Chris. He showed how you can use schbench to cause painful
contention with swqueue in [0]. Chris -- any other schbench incantations
that you'd recommend we try with Gautham's patches?

[0]: https://lore.kernel.org/lkml/c8419d9b-2b31-2190-3058-3625bdbcb13d@meta.com/

> tbench (measure: throughput, records/s)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> clients: tip			 sis-node		 david			 david-ego-1		 ego-david-2
>     1	 452.49 (0.00 pct)	 457.94 (1.20 pct)	 448.52 (-0.87 pct)	 447.11 (-1.18 pct)	 458.45 (1.31 pct)
>     2	 862.44 (0.00 pct)	 879.99 (2.03 pct)	 860.14 (-0.26 pct)	 873.27 (1.25 pct)	 891.72 (3.39 pct)
>     4	 1604.27 (0.00 pct)	 1618.87 (0.91 pct)	 1610.95 (0.41 pct)	 1628.45 (1.50 pct)	 1657.26 (3.30 pct)
>     8	 2966.77 (0.00 pct)	 3040.90 (2.49 pct)	 2991.07 (0.81 pct)	 3063.31 (3.25 pct)	 3106.50 (4.70 pct)
>    16	 5176.70 (0.00 pct)	 5292.29 (2.23 pct)	 5478.32 (5.82 pct)	 5462.05 (5.51 pct)	 5537.15 (6.96 pct)
>    32	 8205.24 (0.00 pct)	 8949.12 (9.06 pct)	 9039.63 (10.16 pct)	 9466.07 (15.36 pct)	 9365.06 (14.13 pct)
>    64	 13956.71 (0.00 pct)	 14461.42 (3.61 pct)	 16337.65 (17.05 pct)	 16941.63 (21.38 pct)	 15697.47 (12.47 pct)
>   128	 24005.50 (0.00 pct)	 26052.75 (8.52 pct)	 25605.24 (6.66 pct)	 27243.19 (13.48 pct)	 24854.60 (3.53 pct)
>   256	 32457.61 (0.00 pct)	 21999.41 (-32.22 pct)	 36953.22 (13.85 pct)	 32299.31 (-0.48 pct)	 33037.03 (1.78 pct)
>   512	 34345.24 (0.00 pct)	 41166.39 (19.86 pct)	 40845.23 (18.92 pct)	 40797.97 (18.78 pct)	 38150.17 (11.07 pct)
>  1024	 33432.92 (0.00 pct)	 40900.84 (22.33 pct)	 39749.35 (18.89 pct)	 41133.82 (23.03 pct)	 38464.26 (15.04 pct)
> 
> 
>  observations: tbench really likes all variants of shared-wakeueue. i

It's encouraging to see how well swqueue is handling these benchmarks;
especially on CPUs with larger LLCs and with a lot of clients. I'm keen
to see how we do with the sharding approach and your patches.

>  have also included sis-node numbers since we saw that tbench liked
>  sis-node.
> 
> also, it can be noted that except for the 256 clients case (number of
> clients == number of threads in the system), in all other cases, we
> see a benefit with david-ego-1 which extends the usage of
> shared-wakequeue to the waker's target when the waker's llc is busy.

Also confused why the 256 client case would perform worse for SIS_NODE
and david-ego-1. Was it consistently negative if you do multiple runs?

Overall, my handwavey impression is that david-ego-1 doesn't seem to
significantly improve over david, though I'd very much like to see the
results of the other benchmarks you listed below. Iterating over tasks
until you find a usable cpus->ptr also makes sense, and I'm hoping that
the sharding idea will help with the contention there.

> will try and get the netperf, postgresql, specjbb and deathstarbench
> numbers this week.

Thanks, that would be great. I'll be on vacation this week starting
Wednesday, but will try to put together a v2 that includes Peter's
suggestions by the end of the day tomorrow. Otherwise, I'll likely send
it out next week (along with your patch(es) if they're shown to be an
improvement over the baseline).

Thanks,
David

> 
> --
> thanks and regards
> gautham.
> 
> 
> 
> 
> 
> 

> from 05d8efe2f3ae3abafd4bf94a0579d378dba63bb6 mon sep 17 00:00:00 2001
> from: "gautham r. shenoy" <gautham.shenoy@amd.com>
> date: fri, 23 jun 2023 11:02:03 +0530
> subject: [patch 1/2] swqueue: control if a task should be queued on swq in
>  select_idle_sibling()
> 
> if select_idle_sibling() fails to find an idle cpu to wakeup the task
> on, then update the newly defined sched_add_to_swq field in its task
> struct.
> 
> use the value in this field to later on to determine if the task
> should also be queued on the shared-wakequeue of the llc of the target
> cpu.
> 
> this extends the use of shared-wakequeue to cases when the target of a
> wakeup is the current cpu instead of the task's previous cpu.
> 
> signed-off-by: gautham r. shenoy <gautham.shenoy@amd.com>
> ---
>  include/linux/sched.h |  6 ++++++
>  kernel/sched/fair.c   | 15 ++++++++-------
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b64fec55a381..38005262a7fe 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -910,6 +910,12 @@ struct task_struct {
>  	 */
>  	unsigned			sched_remote_wakeup:1;
>  
> +	/*
> +	 * bit used by select_idle_sibling() to signal enqueuing the
> +	 * task on a shared wakequeue when it failed find an idle cpu.
> +	 */
> +	unsigned			sched_add_to_swq:1;
> +
>  	/* bit to tell lsms we're in execve(): */
>  	unsigned			in_execve:1;
>  	unsigned			in_iowait:1;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e311d1c3b992..fe33f6b13299 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -215,21 +215,17 @@ static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
>  {
>  	unsigned long flags;
>  	struct swqueue *swqueue;
> -	bool task_migrated = enq_flags & enqueue_migrated;
> -	bool task_wakeup = enq_flags & enqueue_wakeup;
>  
>  	/*
>  	 * only enqueue the task in the shared wakequeue if:
>  	 *
>  	 * - swqueue is enabled
> -	 * - the task is on the wakeup path
> -	 * - the task wasn't purposefully migrated to the current rq by
> -	 *   select_task_rq()
> -	 * - the task isn't pinned to a specific cpu
> +	 * - select_idle_sibling() didn't find an idle cpu to enqueue this wakee task.
>  	 */
> -	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> +	if (!p->sched_add_to_swq)
>  		return;
>  
> +	p->sched_add_to_swq = 0;
>  	swqueue = rq_swqueue(rq);
>  	spin_lock_irqsave(&swqueue->lock, flags);
>  	list_add_tail(&p->swqueue_node, &swqueue->list);
> @@ -7361,6 +7357,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
>  
> +	/*
> +	 * no idle sibling was found. ok to queue this task on the
> +	 * shared wakequeue of the target.
> +	 */
> +	p->sched_add_to_swq = 1;
>  	return target;
>  }
>  
> -- 
> 2.25.1
> 

> from 88f52c2df8a2d92423ddd12c92edec949148bf3c mon sep 17 00:00:00 2001
> from: "gautham r. shenoy" <gautham.shenoy@amd.com>
> date: fri, 23 jun 2023 23:25:04 +0530
> subject: [patch 2/2] swqueue: only pull a task with valid affinity from
>  swqueue
> 
> currently swqueue_pull_task() dequeues the task at the head of the
> shared-wakequeue and then tries to migrate the task onto the current
> cpu.
> 
> this may fail, since the current cpu may not be set in the task's
> affinity mask.
> 
> hence in swqueue_pull_task(), pull the first task from the
> shared-wakequeue that can be run on this cpu. with this,
> swqueue_pick_next_task() can return a 0/1 instead of 0/-1/1 as it is
> done now.
> 
> singed-off-by: gautham r. shenoy <gautham.shenoy@amd.com>
> ---
>  kernel/sched/fair.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fe33f6b13299..e78b8302b4c8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -195,17 +195,21 @@ static struct swqueue *rq_swqueue(struct rq *rq)
>  	return rq->cfs.swqueue;
>  }
>  
> -static struct task_struct *swqueue_pull_task(struct swqueue *swqueue)
> +static struct task_struct *swqueue_pull_task(struct swqueue *swqueue, int cpu)
>  {
>  	unsigned long flags;
>  
>  	struct task_struct *p;
>  
>  	spin_lock_irqsave(&swqueue->lock, flags);
> -	p = list_first_entry_or_null(&swqueue->list, struct task_struct,
> -				     swqueue_node);
> -	if (p)
> -		list_del_init(&p->swqueue_node);
> +	list_for_each_entry(p, &swqueue->list, swqueue_node) {
> +		if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +			list_del_init(&p->swqueue_node);
> +			goto found;
> +		}
> +	}
> +	p = null;
> +found:
>  	spin_unlock_irqrestore(&swqueue->lock, flags);
>  
>  	return p;
> @@ -238,11 +242,11 @@ static int swqueue_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  	struct task_struct *p = null;
>  	struct rq *src_rq;
>  	struct rq_flags src_rf;
> -	int ret;
> +	int ret = 0;
>  
>  	swqueue = rq_swqueue(rq);
>  	if (!list_empty(&swqueue->list))
> -		p = swqueue_pull_task(swqueue);
> +		p = swqueue_pull_task(swqueue, rq->cpu);
>  
>  	if (!p)
>  		return 0;
> @@ -255,10 +259,8 @@ static int swqueue_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  	if (task_on_rq_queued(p) && !task_on_cpu(rq, p))
>  		src_rq = migrate_task_to(src_rq, &src_rf, p, cpu_of(rq));
>  
> -	if (src_rq->cpu != rq->cpu)
> +	if (src_rq->cpu == rq->cpu)
>  		ret = 1;
> -	else
> -		ret = -1;
>  
>  	task_rq_unlock(src_rq, p, &src_rf);
>  
> -- 
> 2.25.1
> 

