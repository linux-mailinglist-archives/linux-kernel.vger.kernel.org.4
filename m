Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71AE6691D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjAMIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjAMIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:54:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6EB2624
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:54:02 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id bj3so18572602pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4u3/M5VTCpvE3XjRnXNkUdNbAojWHWsxwEoqDU6hlhI=;
        b=aT5eg8Rk9iRbWgpQkYAoibV6s2DZj4Civ2ffzlZgs8ZJECIuZhERfD82Llspilhe2y
         6KvVMDR8ExZucIe8EMHPI9DuGflz7+KHeXGnCyPKx0DVgcZ64F/Vo2oWMKDe9inASuxf
         hqdY6CeibT12cB3ck0D+C05JQW2ceAD8SfNMH01VlhW4ChfwARN1uO/OYCHG56bjZ2uJ
         7OWjP5l1qiMs8kYEMzwQ6Mz6KLVzs0Txg8GsV90W+nlgilHcL03bFEj1UdyzEBnc1TH4
         t4wpI+0tfX9lfEtnHPS40IR+IgxPLZPA+wWAtSUlKMNVHJ4ZQvZclws5dUiDU6xyhlfI
         1OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4u3/M5VTCpvE3XjRnXNkUdNbAojWHWsxwEoqDU6hlhI=;
        b=dXiF1p8lsZO/x83nV18iGMgmxrkNlraZBILsBJAwToataQODSbs6mCAku2fRQTW54S
         NVEXgi74pt8k8+m5jU7AO9h+ccnTchjpCKbrsIDSikVLA1ni311DKVkI8i/8tIERlXki
         SRsV+3TwRnye2Bb6E9gT4B3y0LMeNLlwRwnVYEeAppUPnaUzosNvPZ0h+fnGfsmb/2uo
         TZBL8ljcra2d1Vp/PuhYpwJTGMC3fZoY9lY5RyNGRXKdKwMWapp4yultW9n/tQYYDr0M
         sb8cbUBlLQugNtiS/0luz40RPke3KBSCeZ3hyqcnI8kDEz3NrktCNXhUzRNBhYLhXWkG
         KWWA==
X-Gm-Message-State: AFqh2kp7kh9PpYvT3a0r2aNEk0tMjOAJpqtkJhhcb7OC/YJODXMl5FK0
        Lpzj98EPELsNm9HFYjmfaiSW7sHWe92KaJ5CkDKYKw==
X-Google-Smtp-Source: AMrXdXvDPTt/06BeKfOgTbuzl0GhsDO2G6OPG2ufLEomiyrqu+xc2sqCEgIarlfgM8tOCbux1SmD1B7GgZ7Cb1kijVw=
X-Received: by 2002:a17:90b:110d:b0:215:f80c:18e6 with SMTP id
 gi13-20020a17090b110d00b00215f80c18e6mr7902580pjb.45.1673600041496; Fri, 13
 Jan 2023 00:54:01 -0800 (PST)
MIME-Version: 1.0
References: <20221228165415.3436-1-vincent.guittot@linaro.org> <20230112142603.yj5dtleksi6sfrzp@airbuntu>
In-Reply-To: <20230112142603.yj5dtleksi6sfrzp@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Jan 2023 09:53:49 +0100
Message-ID: <CAKfTPtCPedS22+0QHS65ixMELAvjRnn6XMCu0DzickEcpjkMFQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: unlink misfit task from cpu overutilized
To:     Qais Yousef <qyousef@layalina.io>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 at 15:26, Qais Yousef <qyousef@layalina.io> wrote:
>
> Hi Vincent
>
> On 12/28/22 17:54, Vincent Guittot wrote:
> > By taking into account uclamp_min, the 1:1 relation between task misfit
> > and cpu overutilized is no more true as a task with a small util_avg of
> > may not may not fit a high capacity cpu because of uclamp_min constraint.
>
> Wouldn't it be better to split this into two patches
>
>         * Unlink/Decouple misfit ...
>         * Unlink/Decouple util_fits_cpu from HMP
>
> ?

I'm afraid that git bisect could then raise a false positive between
the 2 commits

>
> >
> > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > a CPU except for the uclamp_min hint which is a performance requirement.
> >
> > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > can use this new value to take additional action to select the best CPU
> > that doesn't match uclamp_min hint.
>
> This part has nothing to do with the commit subject. I think it's better to
> split the patches if it's not too much work for you.
>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > Change since v1:
> > - fix some wrong conditions
> > - take into account more cases
> >
> >  kernel/sched/fair.c | 99 +++++++++++++++++++++++++++++++++------------
> >  1 file changed, 74 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1649e7d71d24..57077f0a897e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4582,8 +4582,7 @@ static inline int util_fits_cpu(unsigned long util,
> >        *     2. The system is being saturated when we're operating near
> >        *        max capacity, it doesn't make sense to block overutilized.
> >        */
> > -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> > +     uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
> >       fits = fits || uclamp_max_fits;
> >
> >       /*
> > @@ -4618,8 +4617,8 @@ static inline int util_fits_cpu(unsigned long util,
> >        * handle the case uclamp_min > uclamp_max.
> >        */
> >       uclamp_min = min(uclamp_min, uclamp_max);
> > -     if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> > -             fits = fits && (uclamp_min <= capacity_orig_thermal);
> > +     if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> > +             return -1;
> >
> >       return fits;
> >  }
> > @@ -4629,7 +4628,7 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> >       unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> >       unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> >       unsigned long util = task_util_est(p);
> > -     return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
> > +     return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
>
> So the big difference between your approach and my approach is that
> task_fits_cpu() and asym_fits_cpu() now are very strict in regards to thermal
> pressure since with your approach we delegate the smartness to the caller.
>
> Should we add a comment for these 2 users to make it obvious we intentionally
> ignore the '-1' value and why it is okay?

I can probably add something saying that a positive value (1 in this
case) is the only one that says that a task fits to a cpu. Other
returned values imply that either the utilization or the uclamp
constraints are not meet
>
> I'm not sure I can write a reasonable rationale myself. I'm actually worried
> this might subtly break decisions made by select_idle_capacity() or feec() when
> doing the LB.
>
> Have you considered this?

Yes, that why i have keep the changes in 1 patch

>
> >  }
> >
> >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > @@ -6864,6 +6863,7 @@ static int
> >  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >  {
> >       unsigned long task_util, util_min, util_max, best_cap = 0;
> > +     int fits, best_fits = 0;
> >       int cpu, best_cpu = -1;
> >       struct cpumask *cpus;
> >
> > @@ -6879,12 +6879,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >
> >               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> >                       continue;
> > -             if (util_fits_cpu(task_util, util_min, util_max, cpu))
> > +
> > +             fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> > +
> > +             /* This CPU fits with all capacity and performance requirements */
> > +             if (fits > 0)
> >                       return cpu;
> > +             /*
> > +              * Only the min performance (i.e. uclamp_min) doesn't fit. Look
> > +              * for the CPU with highest performance capacity.
> > +              */
> > +             else if (fits < 0)
> > +                     cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
> >
> > -             if (cpu_cap > best_cap) {
> > +             /*
> > +              * First, select cpu which fits better (-1 being better than 0).
> > +              * Then, select the one with largest capacity at same level.
> > +              */
> > +             if ((fits < best_fits) ||
> > +                 ((fits == best_fits) && (cpu_cap > best_cap))) {
> >                       best_cap = cpu_cap;
> >                       best_cpu = cpu;
> > +                     best_fits = fits;
> >               }
> >       }
> >
> > @@ -6897,7 +6913,7 @@ static inline bool asym_fits_cpu(unsigned long util,
> >                                int cpu)
> >  {
> >       if (sched_asym_cpucap_active())
> > -             return util_fits_cpu(util, util_min, util_max, cpu);
> > +             return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
> >
> >       return true;
> >  }
> > @@ -7264,6 +7280,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >       unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
> >       struct root_domain *rd = this_rq()->rd;
> >       int cpu, best_energy_cpu, target = -1;
> > +     int prev_fits = -1, best_fits = -1;
> > +     unsigned long best_thermal_cap = 0;
> > +     unsigned long prev_thermal_cap = 0;
> >       struct sched_domain *sd;
> >       struct perf_domain *pd;
> >       struct energy_env eenv;
> > @@ -7299,6 +7318,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >               unsigned long prev_spare_cap = 0;
> >               int max_spare_cap_cpu = -1;
> >               unsigned long base_energy;
> > +             int fits, max_fits = -1;
> >
> >               cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> >
> > @@ -7351,7 +7371,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                                       util_max = max(rq_util_max, p_util_max);
> >                               }
> >                       }
> > -                     if (!util_fits_cpu(util, util_min, util_max, cpu))
> > +
> > +                     fits = util_fits_cpu(util, util_min, util_max, cpu);
> > +                     if (!fits)
> >                               continue;
> >
> >                       lsub_positive(&cpu_cap, util);
> > @@ -7359,7 +7381,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                       if (cpu == prev_cpu) {
> >                               /* Always use prev_cpu as a candidate. */
> >                               prev_spare_cap = cpu_cap;
> > -                     } else if (cpu_cap > max_spare_cap) {
> > +                             prev_fits = fits;
> > +                     } else if ((fits > max_fits) ||
> > +                                ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> >                               /*
> >                                * Find the CPU with the maximum spare capacity
> >                                * among the remaining CPUs in the performance
> > @@ -7367,6 +7391,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                                */
> >                               max_spare_cap = cpu_cap;
> >                               max_spare_cap_cpu = cpu;
> > +                             max_fits = fits;
> >                       }
> >               }
> >
> > @@ -7385,26 +7410,50 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                       if (prev_delta < base_energy)
> >                               goto unlock;
> >                       prev_delta -= base_energy;
> > +                     prev_thermal_cap = cpu_thermal_cap;
> >                       best_delta = min(best_delta, prev_delta);
> >               }
> >
> >               /* Evaluate the energy impact of using max_spare_cap_cpu. */
> >               if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
> > +                     /* Current best energy cpu fits better */
> > +                     if (max_fits < best_fits)
> > +                             continue;
> > +
> > +                     /*
> > +                      * Both don't fit performance (i.e. uclamp_min) but
> > +                      * best energy cpu has better performance.
> > +                      */
> > +                     if ((max_fits < 0) &&
> > +                         (cpu_thermal_cap <= best_thermal_cap))
> > +                             continue;
> > +
> >                       cur_delta = compute_energy(&eenv, pd, cpus, p,
> >                                                  max_spare_cap_cpu);
> >                       /* CPU utilization has changed */
> >                       if (cur_delta < base_energy)
> >                               goto unlock;
> >                       cur_delta -= base_energy;
> > -                     if (cur_delta < best_delta) {
> > -                             best_delta = cur_delta;
> > -                             best_energy_cpu = max_spare_cap_cpu;
> > -                     }
> > +
> > +                     /*
> > +                      * Both fit for the task but best energy cpu has lower
> > +                      * energy impact.
> > +                      */
> > +                     if ((max_fits > 0) &&
>
> Shouldn't this be
>
>                         if ((max_fits > 0) && (max_fits == best_fits) &&
> ?

I will use the below which match better the comment and the fact that
both fit for the task:

+                    if ((max_fits > 0) && (best_fits > 0) &&

>
> We should update best_delta unconditionally first time we hit max_fits = 1, no?
>
> I think it's worth extending the comment with something along the lines of
>
>                         * ... except for the first time max_fits becomes 1
>                         * then we must update best_delta unconditionally

With the new condition above this is not needed anymore

>
> > +                         (cur_delta >= best_delta))
> > +                             continue;
> > +
> > +                     best_delta = cur_delta;
> > +                     best_energy_cpu = max_spare_cap_cpu;
> > +                     best_fits = max_fits;
> > +                     best_thermal_cap = cpu_thermal_cap;
> >               }
> >       }
> >       rcu_read_unlock();
> >
> > -     if (best_delta < prev_delta)
> > +     if ((best_fits > prev_fits) ||
> > +         ((best_fits > 0) && (best_delta < prev_delta)) ||
> > +         ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
> >               target = best_energy_cpu;
>
> Overall I think the approach is sound. I tested it on my pinebook pro and
> couldn't catch obvious breakage at least.
>
> I am still worried though about spilling the knowledge outside of
> util_fits_cpu() is creating extra complexity in the callers and potentially
> more fragility when these callers evolve overtime e.g:
> task_fits_cpu()/asym_fits_cpu() gain a new user that must actually care about
> the -1 return value.

ask_fits_cpu()/asym_fits_cpu() remain simple booleans that return true
if the task fits the cpu in regards to all requirements. If a new user
wants to make smarter decisions like select_idle_capacity() or feec(),
it will have to use util_fits_cpu(). Both handle the case where
uclamp_min is not met differently.

>
> I think we can still optimize the capacity inversion logic to use no loops
> without having to spill the knowledge to the users/callers of util_fits_cpu(),
> no?

TBH, I don't know how because we are not always comparing the same
things depending of the reason it doesn't fit

>
> That said except for the few comments I had this LGTM anyway. Thanks for your
> effort!

Thanks

I'm going to prepare  v2

>
>
> Cheers
>
> --
> Qais Yousef
>
> >
> >       return target;
> > @@ -10228,24 +10277,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> >        */
> >       update_sd_lb_stats(env, &sds);
> >
> > -     if (sched_energy_enabled()) {
> > -             struct root_domain *rd = env->dst_rq->rd;
> > -
> > -             if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> > -                     goto out_balanced;
> > -     }
> > -
> > -     local = &sds.local_stat;
> > -     busiest = &sds.busiest_stat;
> > -
> >       /* There is no busy sibling group to pull tasks from */
> >       if (!sds.busiest)
> >               goto out_balanced;
> >
> > +     busiest = &sds.busiest_stat;
> > +
> >       /* Misfit tasks should be dealt with regardless of the avg load */
> >       if (busiest->group_type == group_misfit_task)
> >               goto force_balance;
> >
> > +     if (sched_energy_enabled()) {
> > +             struct root_domain *rd = env->dst_rq->rd;
> > +
> > +             if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> > +                     goto out_balanced;
> > +     }
> > +
> >       /* ASYM feature bypasses nice load balance check */
> >       if (busiest->group_type == group_asym_packing)
> >               goto force_balance;
> > @@ -10258,6 +10306,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> >       if (busiest->group_type == group_imbalanced)
> >               goto force_balance;
> >
> > +     local = &sds.local_stat;
> >       /*
> >        * If the local group is busier than the selected busiest group
> >        * don't try and pull any tasks.
> > --
> > 2.17.1
> >
