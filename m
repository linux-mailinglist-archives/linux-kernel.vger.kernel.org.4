Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B33663B91B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 05:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiK2E0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 23:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiK2E0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 23:26:01 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62D145084
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 20:25:49 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so8354172oti.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 20:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvqTRiUBNFfregTvvcTT9yeHN90bJZgjQrsVN2qOozM=;
        b=jQTl7Of06BUYrLfxk99FH6RycYP62d9buA8TVcpG38QpxaryCAEYHBjTzAO2EWPD14
         ZeKfPReoClS1snZgrf4FzRabkFnoyaBZFlHkvaQN298TfEsBiitFidVmPXGmFoQCu33V
         UPLOZhoLn04FPKjBNZO/9u7pp76Ybsigc51pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvqTRiUBNFfregTvvcTT9yeHN90bJZgjQrsVN2qOozM=;
        b=4r1KQr5bo3y2TQtfn2HILX+Mrr1jkx+bkJUa4qkY7S3+Z5hY2luOC63gLeo4AYtsyx
         T+vTpdV6RdXtDJXi6rU3S2Rs67XDSyXS2+OUEb2c5z+VMK1frtzsh0QB1ywhk+gGTF13
         17RoGqJthzlWNsVf/ILw799g/fbNnyiqXQvT/CtdHpS+Yu20o+Wg2BhOGRAq7qmk29E0
         bsW4fKhjm/ejMH6I5ICnspIEoXkVCApFgDqscs8MqVBUoS2vaSLwqFnpCQUv5K7aeGhh
         THIAfRMYCb/tpbur72KNQAhhc9jSW47NjgFRMOhuHujCzNtlQQ7Hu6+HykcrfMUB2bNV
         YvNQ==
X-Gm-Message-State: ANoB5pmcQ6YOywxCdNlIyve00CBl278PDVS+oCjIUF2IX4otNppMz6VP
        sfeQlYqfGP1zMPh0BbwiyJPVVN0e9aHcbmQIneEgpQ==
X-Google-Smtp-Source: AA0mqf5Mh7g4y7UYTj51xZJaBdwwzYILqgIWD//V3xwmVjcwZtbXOr4KfkwAC05uyVoFLAdmVvzPS7QXZeCRHx4EHus=
X-Received: by 2002:a05:6830:d03:b0:66d:3e45:8e5a with SMTP id
 bu3-20020a0568300d0300b0066d3e458e5amr17246583otb.177.1669695948895; Mon, 28
 Nov 2022 20:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20221115171851.835-1-vincent.guittot@linaro.org> <20221115171851.835-6-vincent.guittot@linaro.org>
In-Reply-To: <20221115171851.835-6-vincent.guittot@linaro.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 28 Nov 2022 23:25:38 -0500
Message-ID: <CAEXW_YSXveyBjVVGQCRdmiZP=r_L5+7ZU-BJujskpxw9ecw9xQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] sched/fair: Take into account latency priority at wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:19 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Take into account the latency priority of a thread when deciding to
> preempt the current running thread. We don't want to provide more CPU
> bandwidth to a thread but reorder the scheduling to run latency sensitive
> task first whenever possible.
>
> As long as a thread didn't use its bandwidth, it will be able to preempt
> the current thread.
>
> At the opposite, a thread with a low latency priority will preempt current
> thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
> wait for the tick to get its sched slice.
>
>                                    curr vruntime
>                                        |
>                       sysctl_sched_wakeup_granularity
>                                    <-->
> ----------------------------------|----|-----------------------|---------------
>                                   |    |<--------------------->
>                                   |    .  sysctl_sched_latency
>                                   |    .
> default/current latency entity    |    .
>                                   |    .
> 1111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-
> se preempts curr at wakeup ------>|<- se doesn't preempt curr -----------------
>                                   |    .
>                                   |    .
>                                   |    .
> low latency entity                |    .
>                                    ---------------------->|
>                                % of sysctl_sched_latency  |
> 1111111111111111111111111111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-
> preempt ------------------------------------------------->|<- do not preempt --
>                                   |    .
>                                   |    .
>                                   |    .
> high latency entity               |    .
>          |<-----------------------|----.
>          | % of sysctl_sched_latency   .
> 111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1
> preempt->|<- se doesn't preempt curr ------------------------------------------
> Tests results of nice latency impact on heavy load like hackbench:
>
> hackbench -l (2560 / group) -g group
> group        latency 0             latency 19
> 1            1.378(+/-  1%)      1.337(+/- 1%) + 3%
> 4            1.393(+/-  3%)      1.312(+/- 3%) + 6%
> 8            1.308(+/-  2%)      1.279(+/- 1%) + 2%
> 16           1.347(+/-  1%)      1.317(+/- 1%) + 2%
>
> hackbench -p -l (2560 / group) -g group
> group
> 1            1.836(+/- 17%)      1.148(+/- 5%) +37%
> 4            1.586(+/-  6%)      1.109(+/- 8%) +30%
> 8            1.209(+/-  4%)      0.780(+/- 4%) +35%
> 16           0.805(+/-  5%)      0.728(+/- 4%) +10%
>
> By deacreasing the latency prio, we reduce the number of preemption at
> wakeup and help hackbench making progress.
>
> Test results of nice latency impact on short live load like cyclictest
> while competing with heavy load like hackbench:
>
> hackbench -l 10000 -g $group &
> cyclictest --policy other -D 5 -q -n
>         latency 0           latency -20
> group   min  avg    max     min  avg    max
> 0       16    19     29      17   18     29
> 1       43   299   7359      63   84   3422
> 4       56   449  14806      45   83    284
> 8       63   820  51123      63   83    283
> 16      64  1326  70684      41  157  26852
>
> group = 0 means that hackbench is not running.
>
> The avg is significantly improved with nice latency -20 especially with
> large number of groups but min and max remain quite similar. If we add the
> histogram parameter to get details of latency, we have :
>
> hackbench -l 10000 -g 16 &
> cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
>               latency 0    latency -20
> Min Latencies:    64           62
> Avg Latencies:  1170          107
> Max Latencies: 88069        10417
> 50% latencies:   122           86
> 75% latencies:   614           91
> 85% latencies:   961           94
> 90% latencies:  1225           97
> 95% latencies:  6120          102
> 99% latencies: 18328          159
>
> With percentile details, we see the benefit of nice latency -20 as
> only 1% of the latencies are above 159us whereas the default latency
> has got 15% around ~1ms or above and 5% over the 6ms.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  include/linux/sched.h      |  4 ++-
>  include/linux/sched/prio.h |  9 ++++++
>  init/init_task.c           |  2 +-
>  kernel/sched/core.c        | 38 +++++++++++++++++++---
>  kernel/sched/debug.c       |  2 +-
>  kernel/sched/fair.c        | 66 ++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h       |  6 ++++
>  7 files changed, 112 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 856240573300..2f33326adb8d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -568,6 +568,8 @@ struct sched_entity {
>         /* cached value of my_q->h_nr_running */
>         unsigned long                   runnable_weight;
>  #endif
> +       /* preemption offset in ns */
> +       long                            latency_offset;
>
>  #ifdef CONFIG_SMP
>         /*
> @@ -784,7 +786,7 @@ struct task_struct {
>         int                             static_prio;
>         int                             normal_prio;
>         unsigned int                    rt_priority;
> -       int                             latency_nice;
> +       int                             latency_prio;
>
>         struct sched_entity             se;
>         struct sched_rt_entity          rt;
> diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
> index bfcd7f1d1e11..be79503d86af 100644
> --- a/include/linux/sched/prio.h
> +++ b/include/linux/sched/prio.h
> @@ -59,5 +59,14 @@ static inline long rlimit_to_nice(long prio)
>   * Default tasks should be treated as a task with latency_nice = 0.
>   */
>  #define DEFAULT_LATENCY_NICE   0
> +#define DEFAULT_LATENCY_PRIO   (DEFAULT_LATENCY_NICE + LATENCY_NICE_WIDTH/2)
> +
> +/*
> + * Convert user-nice values [ -20 ... 0 ... 19 ]
> + * to static latency [ 0..39 ],
> + * and back.
> + */
> +#define NICE_TO_LATENCY(nice)  ((nice) + DEFAULT_LATENCY_PRIO)
> +#define LATENCY_TO_NICE(prio)  ((prio) - DEFAULT_LATENCY_PRIO)
>
>  #endif /* _LINUX_SCHED_PRIO_H */
> diff --git a/init/init_task.c b/init/init_task.c
> index 7dd71dd2d261..071deff8dbd1 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -78,7 +78,7 @@ struct task_struct init_task
>         .prio           = MAX_PRIO - 20,
>         .static_prio    = MAX_PRIO - 20,
>         .normal_prio    = MAX_PRIO - 20,
> -       .latency_nice   = DEFAULT_LATENCY_NICE,
> +       .latency_prio   = DEFAULT_LATENCY_PRIO,
>         .policy         = SCHED_NORMAL,
>         .cpus_ptr       = &init_task.cpus_mask,
>         .user_cpus_ptr  = NULL,
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 18c31a68eb18..b2b8cb6c08cd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1283,6 +1283,16 @@ static void set_load_weight(struct task_struct *p, bool update_load)
>         }
>  }
>
> +static void set_latency_offset(struct task_struct *p)
> +{
> +       long weight = sched_latency_to_weight[p->latency_prio];
> +       s64 offset;
> +
> +       offset = weight * get_sleep_latency(false);
> +       offset = div_s64(offset, NICE_LATENCY_WEIGHT_MAX);
> +       p->se.latency_offset = (long)offset;
> +}
> +
>  #ifdef CONFIG_UCLAMP_TASK
>  /*
>   * Serializes updates of utilization clamp values
> @@ -4592,7 +4602,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>                 p->prio = p->normal_prio = p->static_prio;
>                 set_load_weight(p, false);
>
> -               p->latency_nice = DEFAULT_LATENCY_NICE;
> +               p->latency_prio = NICE_TO_LATENCY(0);
> +               set_latency_offset(p);
> +
>                 /*
>                  * We don't need the reset flag anymore after the fork. It has
>                  * fulfilled its duty:
> @@ -7358,8 +7370,10 @@ static void __setscheduler_params(struct task_struct *p,
>  static void __setscheduler_latency(struct task_struct *p,
>                 const struct sched_attr *attr)
>  {
> -       if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> -               p->latency_nice = attr->sched_latency_nice;
> +       if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
> +               p->latency_prio = NICE_TO_LATENCY(attr->sched_latency_nice);
> +               set_latency_offset(p);
> +       }
>  }
>
>  /*
> @@ -7544,7 +7558,7 @@ static int __sched_setscheduler(struct task_struct *p,
>                 if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
>                         goto change;
>                 if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
> -                   attr->sched_latency_nice != p->latency_nice)
> +                   attr->sched_latency_nice != LATENCY_TO_NICE(p->latency_prio))
>                         goto change;
>
>                 p->sched_reset_on_fork = reset_on_fork;
> @@ -8085,7 +8099,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>         get_params(p, &kattr);
>         kattr.sched_flags &= SCHED_FLAG_ALL;
>
> -       kattr.sched_latency_nice = p->latency_nice;
> +       kattr.sched_latency_nice = LATENCY_TO_NICE(p->latency_prio);
>
>  #ifdef CONFIG_UCLAMP_TASK
>         /*
> @@ -11294,6 +11308,20 @@ const u32 sched_prio_to_wmult[40] = {
>   /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
>  };
>
> +/*
> + * latency weight for wakeup preemption
> + */
> +const int sched_latency_to_weight[40] = {
> + /* -20 */     -1024,     -973,     -922,      -870,      -819,
> + /* -15 */      -768,     -717,     -666,      -614,      -563,
> + /* -10 */      -512,     -461,     -410,      -358,      -307,
> + /*  -5 */      -256,     -205,     -154,      -102,       -51,
> + /*   0 */         0,       51,      102,       154,       205,
> + /*   5 */       256,      307,      358,       410,       461,
> + /*  10 */       512,      563,      614,       666,       717,
> + /*  15 */       768,      819,      870,       922,       973,
> +};
> +

The table is linear. You could approximate this as: weight = nice * 51
since it is a linear scale and do the conversion in place.

Or, since the only place you are using the latency_to_weight is in
set_latency_offset(), can we drop the sched_latency_to_weight array
and simplify as follows?

static void set_latency_offset(struct task_struct *p)
{
  s64 offset = p->latency_prio * get_sleep_latency(false);
  p->latency_prio = (long)div_s64(offset, 40);
}

>  void call_trace_sched_update_nr_running(struct rq *rq, int count)
>  {
>          trace_sched_update_nr_running_tp(rq, count);
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 68be7a3e42a3..b3922184af91 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1043,7 +1043,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  #endif
>         P(policy);
>         P(prio);
> -       P(latency_nice);
> +       P(latency_prio);
>         if (task_has_dl_policy(p)) {
>                 P(dl.runtime);
>                 P(dl.deadline);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c8a697f8db88..0e80e65113bd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4858,6 +4858,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>                 update_idle_cfs_rq_clock_pelt(cfs_rq);
>  }
>
> +static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se);
> +
>  /*
>   * Preempt the current task with a newly woken task if needed:
>   */
> @@ -4866,7 +4868,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  {
>         unsigned long ideal_runtime, delta_exec;
>         struct sched_entity *se;
> -       s64 delta;
> +       s64 delta, offset;
>
>         ideal_runtime = sched_slice(cfs_rq, curr);
>         delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
> @@ -4891,10 +4893,12 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>         se = __pick_first_entity(cfs_rq);
>         delta = curr->vruntime - se->vruntime;
>
> -       if (delta < 0)
> +       offset = wakeup_latency_gran(curr, se);
> +       if (delta < offset)
>                 return;

Agreed.

> -       if (delta > ideal_runtime)
> +       if ((delta > ideal_runtime) ||
> +           (delta > get_latency_max()))
>                 resched_curr(rq_of(cfs_rq));
>  }
>
> @@ -6019,6 +6023,35 @@ static int sched_idle_cpu(int cpu)
>  }
>  #endif
>
> +static void set_next_buddy(struct sched_entity *se);
> +
> +static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_entity *se)
> +{
> +       struct sched_entity *next;
> +
> +       if (se->latency_offset >= 0)
> +               return;
> +
> +       if (cfs->nr_running <= 1)
> +               return;
> +       /*
> +        * When waking from another class, we don't need to check to preempt at
> +        * wakeup and don't set next buddy as a candidate for being picked in
> +        * priority.
> +        * In case of simultaneous wakeup when current is another class, the
> +        * latency sensitive tasks lost opportunity to preempt non sensitive
> +        * tasks which woke up simultaneously.
> +        */
> +
> +       if (cfs->next)
> +               next = cfs->next;
> +       else
> +               next = __pick_first_entity(cfs);
> +
> +       if (next && wakeup_preempt_entity(next, se) == 1)
> +               set_next_buddy(se);
> +}
> +
>  /*
>   * The enqueue_task method is called before nr_running is
>   * increased. Here we update the fair scheduling stats and
> @@ -6105,14 +6138,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>         if (!task_new)
>                 update_overutilized_status(rq);
>
> +       if (rq->curr->sched_class != &fair_sched_class)
> +               check_preempt_from_others(cfs_rq_of(&p->se), &p->se);
> +
>  enqueue_throttle:
>         assert_list_leaf_cfs_rq(rq);
>
>         hrtick_update(rq);
>  }
>
> -static void set_next_buddy(struct sched_entity *se);
> -
>  /*
>   * The dequeue_task method is called before nr_running is
>   * decreased. We remove the task from the rbtree and
> @@ -7461,6 +7495,23 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  }
>  #endif /* CONFIG_SMP */
>
> +static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se)
> +{
> +       long latency_offset = se->latency_offset;
> +
> +       /*
> +        * A negative latency offset means that the sched_entity has latency
> +        * requirement that needs to be evaluated versus other entity.
> +        * Otherwise, use the latency weight to evaluate how much scheduling
> +        * delay is acceptable by se.
> +        */
> +       if ((latency_offset < 0) || (curr->latency_offset < 0))
> +               latency_offset -= curr->latency_offset;
> +       latency_offset = min_t(long, latency_offset, get_latency_max());

Over here can we make positive latency offsets also be evaluated
"versus other entity"?

It feels strange to have different rules for positive latency_offset
when comparing curr and se. IMO we should also factor in latency
requirements by comparing 2 positive nice values. It should be
relative even for positive values, just like regular nice IMO and not
have hidden meaning. If there is hidden meaning, it confuses the user
and requires documentation that most users will not read. Especially
because latency_nice shares the word "nice" with regular nice values.

Thanks,

 - Joel
.

> +
> +       return latency_offset;
> +}
> +
>  static unsigned long wakeup_gran(struct sched_entity *se)
>  {
>         unsigned long gran = sysctl_sched_wakeup_granularity;
> @@ -7499,11 +7550,12 @@ static int
>  wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
>  {
>         s64 gran, vdiff = curr->vruntime - se->vruntime;
> +       s64 offset = wakeup_latency_gran(curr, se);
>
> -       if (vdiff <= 0)
> +       if (vdiff < offset)
>                 return -1;
>
> -       gran = wakeup_gran(se);
> +       gran = offset + wakeup_gran(se);
>
>         /*
>          * At wake up, the vruntime of a task is capped to not be older than
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 842ce0094d9c..7292652731d0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -125,6 +125,11 @@ extern int sched_rr_timeslice;
>   */
>  #define NS_TO_JIFFIES(TIME)    ((unsigned long)(TIME) / (NSEC_PER_SEC / HZ))
>
> +/* Maximum nice latency weight used to scale the latency_offset */
> +
> +#define NICE_LATENCY_SHIFT     (SCHED_FIXEDPOINT_SHIFT)
> +#define NICE_LATENCY_WEIGHT_MAX        (1L << NICE_LATENCY_SHIFT)
> +
>  /*
>   * Increase resolution of nice-level calculations for 64-bit architectures.
>   * The extra resolution improves shares distribution and load balancing of
> @@ -2115,6 +2120,7 @@ static_assert(WF_TTWU == SD_BALANCE_WAKE);
>
>  extern const int               sched_prio_to_weight[40];
>  extern const u32               sched_prio_to_wmult[40];
> +extern const int               sched_latency_to_weight[40];
>
>  /*
>   * {de,en}queue flags:
> --
> 2.17.1
>
