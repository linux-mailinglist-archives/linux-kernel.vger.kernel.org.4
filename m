Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABC3732986
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242303AbjFPIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjFPIJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:09:13 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A56295C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:09:09 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39ce0ab782fso410012b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686902948; x=1689494948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QrTJcLvIKNz9zrsBoq48Gq/xv9UCy6JJCTwjm5PeoE0=;
        b=TmDUUtskLVFy6rYI1vYpWfZLcgtCSZzIuun7Tq+ZDV0cS0HobLmN8RQuShBaQ0KCYR
         K6za4WhAkkP6hpUVAYgzgF3SD6xE28B1vXAWZ40sQIMWHQlaaB48bh1bWGaB8GdhQeiM
         4ILKnU7KAGq9z/KtT8EbQQSP6pfhPVSn+hB2QZQjJBfrTGBZ1jNRomOzVwyZw2UCJqJ5
         ZljccHQcSBhqy3OhkRmmdP6a/X7M4wJqlViac3uJUGcAFbjwupOhcrmroh6c5cWyWRaF
         a65k7m7mYJ812NW/pDr2YQx/y2XJdxPDDviS2ENCxA1wDG49IUWFOzIu62mw8p7ezsQt
         fmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686902948; x=1689494948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrTJcLvIKNz9zrsBoq48Gq/xv9UCy6JJCTwjm5PeoE0=;
        b=Uvcj9zTULczHTFJO6l7Q8IeXpJbSQmbU09OgImLJV/Hp8P7rr7I/RLvYXwIqnOco/I
         k8pXrU0VL/pjqbZ+AdwhnMzUQH1HxnPahRD8WQ2X2sZR3KJjAfBNEvTSfFu3UDxMozeb
         YsXfvb7tQxuycxKVO38gBMg0KogDvQvjHNGVT+/L37J/+gUq7SZzkm3f0ZsUcKQ2ZmmN
         J+UuStmSYlbb6v+R2Xm1bw0PCGWHjys++LVLGFi57T7hxfSUnhicL+1bHUPJTGn7Wxk9
         rtrp440h/2ddMMVeE+niqPEGLrZiWVzqIHwAeMVhWyX6j33IOvGADfdOU5se5ZPLHiHa
         EMPw==
X-Gm-Message-State: AC+VfDyt+lZUQ6G2NlCABoWAtQEtrqMRirTvNJYyMMLsOrAjudz8Wi5g
        o+zIW+qqUjhCfU8UOKcTR1VFKet+oF5wart7izIJBg==
X-Google-Smtp-Source: ACHHUZ7L6+V8PgK0SGsF/QyPrE7BuIFAKVKNKwwLimiClUpVPFqAsh5kLYa244IjpErh8p3f9MqqFfch8BXiBqxNvUA=
X-Received: by 2002:aca:1e07:0:b0:39c:59e2:dd79 with SMTP id
 m7-20020aca1e07000000b0039c59e2dd79mr1340896oic.36.1686902948386; Fri, 16 Jun
 2023 01:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230613052004.2836135-1-void@manifault.com> <20230613052004.2836135-4-void@manifault.com>
In-Reply-To: <20230613052004.2836135-4-void@manifault.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 16 Jun 2023 10:08:57 +0200
Message-ID: <CAKfTPtCT==N_r1Vp-e_cFtVmcdo_YN1aD45AfbLMSpGpu1oU=w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 at 07:20, David Vernet <void@manifault.com> wrote:
>
> Overview
> ========
>
> The scheduler must constantly strike a balance between work
> conservation, and avoiding costly migrations which harm performance due
> to e.g. decreased cache locality. The matter is further complicated by
> the topology of the system. Migrating a task between cores on the same
> LLC may be more optimal than keeping a task local to the CPU, whereas
> migrating a task between LLCs or NUMA nodes may tip the balance in the
> other direction.
>
> With that in mind, while CFS is by and large mostly a work conserving
> scheduler, there are certain instances where the scheduler will choose
> to keep a task local to a CPU, when it would have been more optimal to
> migrate it to an idle core.
>
> An example of such a workload is the HHVM / web workload at Meta. HHVM
> is a VM that JITs Hack and PHP code in service of web requests. Like
> other JIT / compilation workloads, it tends to be heavily CPU bound, and
> exhibit generally poor cache locality. To try and address this, we set
> several debugfs (/sys/kernel/debug/sched) knobs on our HHVM workloads:
>
> - migration_cost_ns -> 0
> - latency_ns -> 20000000
> - min_granularity_ns -> 10000000
> - wakeup_granularity_ns -> 12000000
>
> These knobs are intended both to encourage the scheduler to be as work
> conserving as possible (migration_cost_ns -> 0), and also to keep tasks
> running for relatively long time slices so as to avoid the overhead of
> context switching (the other knobs). Collectively, these knobs provide a
> substantial performance win; resulting in roughly a 20% improvement in
> throughput. Worth noting, however, is that this improvement is _not_ at
> full machine saturation.
>
> That said, even with these knobs, we noticed that CPUs were still going
> idle even when the host was overcommitted. In response, we wrote the
> "shared wakequeue" (swqueue) feature proposed in this patch set. The
> idea behind swqueue is simple: it enables the scheduler to be
> aggressively work conserving by placing a waking task into a per-LLC
> FIFO queue that can be pulled from by another core in the LLC FIFO queue
> which can then be pulled from before it goes idle.

This seems to be just another newly idle load balance outside the current one !

The knobs above are not the only thing preventing a rq to pull a new
task. We have rq->avg_idle, curr_cost and sd->max_newidle_lb_cost
stuff which might be one main root cause for one of your cpu not
pulling a waiting task

It's not clear in your explanation why fixing newly_idle_load_balance
was not possible instead of adding outside code and what prevents
newly_idle_load balance from picking a task in your case ?

For example, have you tried to disable the early break because of avg_idle ?

>
> With this simple change, we were able to achieve a 1 - 1.6% improvement
> in throughput, as well as a small, consistent improvement in p95 and p99
> latencies, in HHVM. These performance improvements were in addition to
> the wins from the debugfs knobs mentioned above.
>
> Design
> ======
>
> The design of swqueue is quite simple. An swqueue is simply a struct
> list_head, and a spinlock:
>
> struct swqueue {
>         struct list_head list;
>         spinlock_t lock;
> } ____cacheline_aligned;
>
> We create a struct swqueue per LLC, ensuring they're in their own
> cachelines to avoid false sharing between CPUs on different LLCs.
>
> When a task first wakes up, it enqueues itself in the swqueue of its
> current LLC at the end of enqueue_task_fair(). Enqueues only happen if
> the task was not manually migrated to the current core by
> select_task_rq(), and is not pinned to a specific CPU.
>
> A core will pull a task from its LLC's swqueue before calling
> newidle_balance().
>
> Difference between SIS_NODE
> ===========================
>
> In [0] Peter proposed a patch that addresses Tejun's observations that
> when workqueues are targeted towards a specific LLC on his Zen2 machine
> with small CCXs, that there would be significant idle time due to
> select_idle_sibling() not considering anything outside of the current
> LLC.
>
> This patch (SIS_NODE) is essentially the complement to the proposal
> here. SID_NODE causes waking tasks to look for idle cores in neighboring
> LLCs on the same die, whereas swqueue causes cores about to go idle to
> look for enqueued tasks. That said, in its current form, the two
> features at are a different scope as SIS_NODE searches for idle cores
> between LLCs, while swqueue enqueues tasks within a single LLC.
>
> The patch was since removed in [1], but we elect to compare its
> performance to swqueue given that as described above, it's conceptually
> complementary.
>
> [0]: https://lore.kernel.org/all/20230530113249.GA156198@hirez.programming.kicks-ass.net/
> [1]: https://lore.kernel.org/all/20230605175636.GA4253@hirez.programming.kicks-ass.net/
>
> I observed that while SIS_NODE works quite well for hosts with small
> CCXs, it can result in degraded performance on machines either with a
> large number of total cores in a CCD, or for which the cache miss
> penalty of migrating between CCXs is high, even on the same die.
>
> For example, on Zen 4c hosts (Bergamo), CCXs within a CCD are muxed
> through a single link to the IO die, and thus have similar cache miss
> latencies as cores in remote CCDs.
>
> Such subtleties could be taken into account with SIS_NODE, but
> regardless, both features are conceptually complementary sides of the
> same coin.  SIS_NODE searches for idle cores for waking threads, whereas
> swqueue searches for available work before a core goes idle.
>
> Results
> =======
>
> Note that the motivation for the shared wakequeue feature was originally
> arrived at using experiments in the sched_ext framework that's currently
> being proposed upstream. The ~1 - 1.6% improvement in HHVM throughput
> is similarly visible using work-conserving sched_ext schedulers (even
> very simple ones like global FIFO).
>
> In both single and multi socket / CCX hosts, this can measurably improve
> performance. In addition to the performance gains observed on our
> internal web workloads, we also observed an improvement in common
> workloads such as kernel compile when running shared wakequeue. Here are
> the results of running make -j$(nproc) built-in.a on several different
> types of hosts configured with make allyesconfig on commit a27648c74210
> ("afs: Fix setting of mtime when creating a file/dir/symlink") on Linus'
> tree (boost was disabled on all of these hosts when the experiments were
> performed):
>
> Single-socket | 32-core | 2-CCX | AMD 7950X Zen4
>
> CPU max MHz:                     5879.8818
> CPU min MHz:                     3000.0000
>                                 o____________o_______o
>                                 |    mean    | CPU   |
>                                 o------------o-------o
> NO_SWQUEUE + NO_SIS_NODE:       | 590.52s    | 3103% |
> NO_SWQUEUE + SIS_NODE:          | 590.80s    | 3102% |
> SWQUEUE + NO_SIS_NODE:          | 589.65s    | 3116% |
> SWQUEUE + SIS_NODE:             | 589.99s    | 3115% |
>                                 o------------o-------o
>
> Takeaway: swqueue doesn't seem to provide a statistically significant
> improvement for kernel compile on my 7950X. SIS_NODE similarly does not
> have a noticeable effect on performance.
>
> -------------------------------------------------------------------------------
>
> Single-socket | 72-core | 6-CCX | AMD Milan Zen3
>
> CPU max MHz:                     3245.0190
> CPU min MHz:                     700.0000
>                                 o_____________o_______o
>                                 |    mean     | CPU   |
>                                 o-------------o-------o
> NO_SWQUEUE + NO_SIS_NODE:       | 1608.69s    | 6488% |
> NO_SWQUEUE + SIS_NODE:          | 1610.24s    | 6473% |
> SWQUEUE + NO_SIS_NODE:          | 1605.80s    | 6504% |
> SWQUEUE + SIS_NODE:             | 1606.96s    | 6488% |
>                                 o-------------o-------o
>
> Takeaway: swqueue does provide a small statistically significant
> improvement on Milan, but the compile times in general were quite long
> relative to the 7950X Zen4, and the Bergamo Zen4c due to the lower clock
> frequency. Milan also has larger CCXs than Bergamo, so it stands to
> reason that select_idle_sibling() will have an easier time finding idle
> cores inside the current CCX.
>
> It also seems logical that SIS_NODE would hurt performance a bit here,
> as all cores / CCXs are in the same NUMA node, so select_idle_sibling()
> has to iterate over 72 cores; delaying task wakeup. That said, I'm not
> sure that's a viable theory if total CPU% is lower with SIS_NODE.
>
> -------------------------------------------------------------------------------
>
> Single-socket | 176-core | 11-CCX | 2-CCX per CCD | AMD Bergamo Zen4c
>
> CPU max MHz:                     1200.0000
> CPU min MHz:                     1000.0000
>
>                                 o____________o________o
>                                 |    mean    | CPU    |
>                                 o------------o--------o
> NO_SWQUEUE + NO_SIS_NODE:       | 322.44s    | 15534% |
> NO_SWQUEUE + SIS_NODE:          | 324.39s    | 15508% |
> SWQUEUE + NO_SIS_NODE:          | 321.54s    | 15603% |
> SWQUEUE + SIS_NODE:             | 321.88s    | 15622% |
>                                 o------------o--------o
>
> Takeaway: swqueue barely beats NO_SWQUEUE + NO_SIS_NODE, to the point
> that it's arguably not statistically significant.
> SIS_NODE results in a ~.9% performance degradation, for likely the same
> reason as Milan: the host has a large number of LLCs within a single
> socket, so task wakeup latencies suffer due to select_idle_node()
> searching up to 11 CCXs.
>
> Conclusion
> ==========
>
> swqueue in this form seems to provide a small, but noticeable win for
> front-end CPU-bound workloads spread over multiple CCXs. The reason
> seems fairly straightforward: swqueue encourages work conservation
> inside of a CCX by having a CPU do an O(1) pull from a per-LLC queue of
> runnable tasks. As mentioned above, it is complementary to SIS_NODE,
> which searches for idle cores on the wakeup path.
>
> While swqueue in this form encourages work conservation, it of course
> does not guarantee it given that we don't implement any kind of work
> stealing between swqueues. In the future, we could potentially push CPU
> utilization even higher by enabling work stealing between swqueues,
> likely between CCXs on the same NUMA node.
>
> Originally-by: Roman Gushchin <roman.gushchin@linux.dev>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  include/linux/sched.h |   2 +
>  kernel/sched/core.c   |   2 +
>  kernel/sched/fair.c   | 175 ++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/sched.h  |   2 +
>  4 files changed, 176 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1292d38d66cc..1f4fd22f88a8 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -770,6 +770,8 @@ struct task_struct {
>         unsigned long                   wakee_flip_decay_ts;
>         struct task_struct              *last_wakee;
>
> +       struct list_head                swqueue_node;
> +
>         /*
>          * recent_used_cpu is initially set as the last CPU used by a task
>          * that wakes affine another task. Waker/wakee relationships can
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d911b0631e7b..e04f0daf1f05 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4533,6 +4533,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>  #ifdef CONFIG_SMP
>         p->wake_entry.u_flags = CSD_TYPE_TTWU;
>         p->migration_pending = NULL;
> +       INIT_LIST_HEAD(&p->swqueue_node);
>  #endif
>         init_sched_mm_cid(p);
>  }
> @@ -9872,6 +9873,7 @@ void __init sched_init_smp(void)
>
>         init_sched_rt_class();
>         init_sched_dl_class();
> +       init_sched_fair_class_late();
>
>         sched_smp_initialized = true;
>  }
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 807986bd6ea6..29fe25794884 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -139,17 +139,151 @@ static int __init setup_sched_thermal_decay_shift(char *str)
>  }
>  __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
>
> +/**
> + * struct swqueue - Per-LLC queue structure for enqueuing and pulling waking
> + * tasks.
> + *
> + * WHAT
> + * ====
> + *
> + * This structure enables the scheduler to be more aggressively work
> + * conserving, by placing waking tasks on a per-LLC FIFO queue that can then be
> + * pulled from when another core in the LLC is going to go idle.
> + *
> + * struct rq stores a pointer to its LLC's swqueue via struct cfs_rq. Waking
> + * tasks are enqueued in a swqueue at the end of enqueue_task_fair(), and are
> + * opportunistically pulled from the swqueue in pick_next_task_fair() prior to
> + * invoking newidle_balance(). Tasks enqueued in a swqueue be scheduled prior
> + * to being pulled from the swqueue, in which case they're simply removed from
> + * the swqueue. A waking task is only enqueued to a swqueue when it was _not_
> + * manually migrated to the current runqueue by select_task_rq_fair().
> + *
> + * There is currently no task-stealing between swqueues in different LLCs,
> + * which means that swqueue is not fully work conserving. This could be added
> + * at a later time, with tasks likely only being stolen across swqueues on the
> + * same NUMA node to avoid violating NUMA affinities.
> + *
> + * HOW
> + * ===
> + *
> + * An swqueue is comprised of a list, and a spinlock for synchronization. Given
> + * that the critical section for a swqueue is typically a fast list operation,
> + * and that the swqueue is localized to a single LLC, the spinlock does not
> + * seem to be contended; even on a heavily utilized host. struct swqueues are
> + * also cacheline aligned to prevent false sharing between CPUs manipulating
> + * swqueues in other LLCs.
> + *
> + * WHY
> + * ===
> + *
> + * As mentioned above, the main benefit of swqueue is that it enables more
> + * aggressive work conservation in the scheduler. This can benefit workloads
> + * that benefit more from CPU utilization than from L1/L2 cache locality.
> + *
> + * swqueues are segmented across LLCs both to avoid contention on the swqueue
> + * spinlock by minimizing the number of CPUs that could contend on it, as well
> + * as to strike a balance between work conservation, and L3 cache locality.
> + */
> +struct swqueue {
> +       struct list_head list;
> +       spinlock_t lock;
> +} ____cacheline_aligned;
> +
>  #ifdef CONFIG_SMP
> -static void swqueue_enqueue(struct rq *rq, struct task_struct *p,
> -                           int enq_flags)
> -{}
> +static struct swqueue *rq_swqueue(struct rq *rq)
> +{
> +       return rq->cfs.swqueue;
> +}
> +
> +static struct task_struct *swqueue_pull_task(struct swqueue *swqueue)
> +{
> +       unsigned long flags;
> +
> +       struct task_struct *p;
> +
> +       spin_lock_irqsave(&swqueue->lock, flags);
> +       p = list_first_entry_or_null(&swqueue->list, struct task_struct,
> +                                    swqueue_node);
> +       if (p)
> +               list_del_init(&p->swqueue_node);
> +       spin_unlock_irqrestore(&swqueue->lock, flags);
> +
> +       return p;
> +}
> +
> +static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
> +{
> +       unsigned long flags;
> +       struct swqueue *swqueue;
> +       bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> +       bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> +
> +       /*
> +        * Only enqueue the task in the shared wakequeue if:
> +        *
> +        * - SWQUEUE is enabled
> +        * - The task is on the wakeup path
> +        * - The task wasn't purposefully migrated to the current rq by
> +        *   select_task_rq()
> +        * - The task isn't pinned to a specific CPU
> +        */
> +       if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> +               return;
> +
> +       swqueue = rq_swqueue(rq);
> +       spin_lock_irqsave(&swqueue->lock, flags);
> +       list_add_tail(&p->swqueue_node, &swqueue->list);
> +       spin_unlock_irqrestore(&swqueue->lock, flags);
> +}
> +
>  static int swqueue_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  {
> -       return 0;
> +       struct swqueue *swqueue;
> +       struct task_struct *p = NULL;
> +       struct rq *src_rq;
> +       struct rq_flags src_rf;
> +       int ret;
> +
> +       swqueue = rq_swqueue(rq);
> +       if (!list_empty(&swqueue->list))
> +               p = swqueue_pull_task(swqueue);
> +
> +       if (!p)
> +               return 0;
> +
> +       rq_unpin_lock(rq, rf);
> +       raw_spin_rq_unlock(rq);
> +
> +       src_rq = task_rq_lock(p, &src_rf);
> +
> +       if (task_on_rq_queued(p) && !task_on_cpu(rq, p))
> +               src_rq = migrate_task_to(src_rq, &src_rf, p, cpu_of(rq));
> +
> +       if (src_rq->cpu != rq->cpu)
> +               ret = 1;
> +       else
> +               ret = -1;
> +
> +       task_rq_unlock(src_rq, p, &src_rf);
> +
> +       raw_spin_rq_lock(rq);
> +       rq_repin_lock(rq, rf);
> +
> +       return ret;
>  }
>
>  static void swqueue_remove_task(struct task_struct *p)
> -{}
> +{
> +       unsigned long flags;
> +       struct swqueue *swqueue;
> +
> +       if (!list_empty(&p->swqueue_node)) {
> +               swqueue = rq_swqueue(task_rq(p));
> +               spin_lock_irqsave(&swqueue->lock, flags);
> +               list_del_init(&p->swqueue_node);
> +               spin_unlock_irqrestore(&swqueue->lock, flags);
> +       }
> +}
>
>  /*
>   * For asym packing, by default the lower numbered CPU has higher priority.
> @@ -12839,3 +12973,34 @@ __init void init_sched_fair_class(void)
>  #endif /* SMP */
>
>  }
> +
> +__init void init_sched_fair_class_late(void)
> +{
> +#ifdef CONFIG_SMP
> +       int i;
> +       struct swqueue *swqueue;
> +       struct rq *rq;
> +       struct rq *llc_rq;
> +
> +       for_each_possible_cpu(i) {
> +               if (per_cpu(sd_llc_id, i) == i) {
> +                       llc_rq = cpu_rq(i);
> +
> +                       swqueue = kzalloc_node(sizeof(struct swqueue),
> +                                              GFP_KERNEL, cpu_to_node(i));
> +                       INIT_LIST_HEAD(&swqueue->list);
> +                       spin_lock_init(&swqueue->lock);
> +                       llc_rq->cfs.swqueue = swqueue;
> +               }
> +       }
> +
> +       for_each_possible_cpu(i) {
> +               rq = cpu_rq(i);
> +               llc_rq = cpu_rq(per_cpu(sd_llc_id, i));
> +
> +               if (rq == llc_rq)
> +                       continue;
> +               rq->cfs.swqueue = llc_rq->cfs.swqueue;
> +       }
> +#endif /* SMP */
> +}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 5a86e9795731..daee5c64af87 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -575,6 +575,7 @@ struct cfs_rq {
>  #endif
>
>  #ifdef CONFIG_SMP
> +       struct swqueue          *swqueue;
>         /*
>          * CFS load tracking
>          */
> @@ -2380,6 +2381,7 @@ extern void update_max_interval(void);
>  extern void init_sched_dl_class(void);
>  extern void init_sched_rt_class(void);
>  extern void init_sched_fair_class(void);
> +extern void init_sched_fair_class_late(void);
>
>  extern void reweight_task(struct task_struct *p, int prio);
>
> --
> 2.40.1
>
