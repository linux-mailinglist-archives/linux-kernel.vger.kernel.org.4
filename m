Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C7681185
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbjA3OOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbjA3OOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:14:05 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A718A9F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:14:02 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g9so7775145pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EFb3ucouMi9GeurBoPDb8PaQ5mb90zs5lh9a+AaIcnw=;
        b=FuFlIRNS+E1QUDugxLLaSi3shF29lNflcy61gnkJGBdv7+gkP3NwCiOrjK4jbn1B8t
         2A4loP9hsfFAho5Y1fPthcruRpPXGnnaA+UakA5UXMB37DTyhdNw00nIoXs+4qSaWeCW
         zqdDmvI22sEdh+fhFiEsdlIb4zgIHCD67IVfRJMXG7b577i53QEKOFWOoFEx2DShTgCc
         Av89Xcnh9c4MxJO4kO8bixS0ia1jVYfO3PW//UnqjhzPqIPxb8N2Kf/wKeicHYuI5P8w
         amflROmaEV+JPEzolUbEaZuFZVLfBJXTzL2YtRdEfebEFyl0bJsbnqo0ABxd2Aazh+Kr
         3NJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFb3ucouMi9GeurBoPDb8PaQ5mb90zs5lh9a+AaIcnw=;
        b=FldS8Cwh1IEu+9w5iM9O9Sd9pL2KMmrsI4rHAid680JfhY0u3Onbj99ESdbqUpVNZj
         9NZvYtY8kSTEDYuKV9vT1078NWI2fvptWEBdegvsKaa/LanfQha8HHFDXz+7EHz/0+3a
         c84i4nH4NDJw7P+CI19LRVsYSYggyzfPD6KpoLz71SCTfTHBjgYPllEuI/TA+w3xSq5h
         cFqT5o2DMlTJVmQOj9zQ/4C+badbjrV+BOkBqMIoYs1u4veI/EaqNfg7tbSb9DbFjFzh
         Vmf/4qPQi07NpEL0kWermTKK9LfuYYlFNJqEPZB7ewoIbYtgKI//+s25BJKUMp+EWDrM
         2Mnw==
X-Gm-Message-State: AO0yUKV8ZF4XzRhR6NJl16mwfJ79jkRRAyqXq3ZPqEO1R2EdZgke1jOL
        bIORdf0wmhJdRKPCKCigLSi8MZs5yO3jbaBMzbV/AQ==
X-Google-Smtp-Source: AK7set+kReaiwSXQCu6z1neyxlZltvwyN3CmZ0z55q1aPEpNG+yVbQLgz7sIVQQlJMf+/TKuzdy9mbr+yuhHHQ/q5IM=
X-Received: by 2002:aa7:8381:0:b0:590:bfd1:b980 with SMTP id
 u1-20020aa78381000000b00590bfd1b980mr2431325pfm.64.1675088042025; Mon, 30 Jan
 2023 06:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20230119174244.2059628-1-vincent.guittot@linaro.org> <20230129163538.mxkr5ib2glqu36ww@airbuntu>
In-Reply-To: <20230129163538.mxkr5ib2glqu36ww@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 Jan 2023 15:13:50 +0100
Message-ID: <CAKfTPtADvhtXGn71P_1LoHDm=soUZu3Qi9ziAGfQE9Ob-cs-CA@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
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

On Sun, 29 Jan 2023 at 17:35, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/19/23 18:42, Vincent Guittot wrote:
> > By taking into account uclamp_min, the 1:1 relation between task misfit
> > and cpu overutilized is no more true as a task with a small util_avg may
> > not fit a high capacity cpu because of uclamp_min constraint.
> >
> > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > a CPU except for the uclamp_min hint which is a performance requirement.
> >
> > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > can use this new value to take additional action to select the best CPU
> > that doesn't match uclamp_min hint.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
>
> I did improve my unit test so that I look at overutilized and misfit condition.
>
> Of course I had to hack the kernel to expose something to manipulate the
> thermal pressure signal. I also made sure to use the sched_energy_aware knob to
> switch between using EAS/CAS so that both feec() and sic() are exercised.
>
> My test system is pinebook pro which has a simple 2 level capacities - but
> I couldn't catch anything wrong. Only one unrelated failure - see below.
>
> I'd be happy to give this my Reviewed-and-tested-by. What's the plan for the
> removal the capacity_inversion logic?

Thanks for the  Reviewed-and-tested-by.

Regarding the removal of capacity_inversion logic , I don't know how
Peter prefers to handle this in one step with this patch then the
reverts or revert capacity_inversion logic in a 2nd step

>
> And nit: subject line could still be improved :) This is a lot more than
> unlinking misfit from OU.
>
> >
> > Change since v3:
> > - Keep current condition for uclamp_max_fits in util_fits_cpu()
> > - Update some comments
> >
> >  kernel/sched/fair.c | 105 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 82 insertions(+), 23 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d4db72f8f84e..54e14da53274 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4561,8 +4561,8 @@ static inline int util_fits_cpu(unsigned long util,
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
> > @@ -4572,7 +4572,11 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> >       unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> >       unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> >       unsigned long util = task_util_est(p);
> > -     return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
> > +     /*
> > +      * Return true only if the cpu fully fits the task requirements, which
> > +      * include the utilization but also the performance hints.
> > +      */
> > +     return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
> >  }
> >
> >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > @@ -6138,6 +6142,7 @@ static inline bool cpu_overutilized(int cpu)
> >       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> >       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> >
> > +     /* Return true only if the utilization doesn't fits CPU's capacity */
> >       return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
> >  }
> >
> > @@ -6931,6 +6936,7 @@ static int
> >  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >  {
> >       unsigned long task_util, util_min, util_max, best_cap = 0;
> > +     int fits, best_fits = 0;
> >       int cpu, best_cpu = -1;
> >       struct cpumask *cpus;
> >
> > @@ -6946,12 +6952,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >
> >               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> >                       continue;
> > -             if (util_fits_cpu(task_util, util_min, util_max, cpu))
> > +
> > +             fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> > +
> > +             /* This CPU fits with all requirements */
> > +             if (fits > 0)
> >                       return cpu;
> > +             /*
> > +              * Only the min performance hint (i.e. uclamp_min) doesn't fit.
> > +              * Look for the CPU with best capacity.
> > +              */
> > +             else if (fits < 0)
> > +                     cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
> >
> > -             if (cpu_cap > best_cap) {
> > +             /*
> > +              * First, select CPU which fits better (-1 being better than 0).
> > +              * Then, select the one with best capacity at same level.
> > +              */
> > +             if ((fits < best_fits) ||
> > +                 ((fits == best_fits) && (cpu_cap > best_cap))) {
> >                       best_cap = cpu_cap;
> >                       best_cpu = cpu;
> > +                     best_fits = fits;
> >               }
> >       }
>
> Not something you introduced, but I had a 'failure' case when I ran a task with
> (uclamp_min, uclamp_max) = (1024, 1024) followed by (0, 0) in CAS.
>
> The task was basically stuck on big core and I check if the task can run on the
> smallest possible capacity in my test.
>
> This is a separate problem that we should address out of this patch. One can
> argue CAS is not energy aware, so any fitting cpu is okay. But one of the goals
> of uclamp_max is to help keep some busy tasks away from bigger cores when
> possible - not only for power reasons, but also for perf reasons as they can
> 'steal' resources from other tasks. So the lack of a more comprehensive search
> is a weakness and something we can improve on.
>
> feec() behaves fine - but after applying some fixes that I've been sleeping on
> for a bit. Should see them in your inbox now.
>
> Thanks for the patch! I am still wary of the complexity, but the fallback
> search could lead to better placement results now.
>
>
> Cheers
>
> --
> Qais Yousef
>
> >
> > @@ -6964,7 +6986,11 @@ static inline bool asym_fits_cpu(unsigned long util,
> >                                int cpu)
> >  {
> >       if (sched_asym_cpucap_active())
> > -             return util_fits_cpu(util, util_min, util_max, cpu);
> > +             /*
> > +              * Return true only if the cpu fully fits the task requirements
> > +              * which include the utilization and the performance hints.
> > +              */
> > +             return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
> >
> >       return true;
> >  }
> > @@ -7331,6 +7357,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >       unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
> >       struct root_domain *rd = this_rq()->rd;
> >       int cpu, best_energy_cpu, target = -1;
> > +     int prev_fits = -1, best_fits = -1;
> > +     unsigned long best_thermal_cap = 0;
> > +     unsigned long prev_thermal_cap = 0;
> >       struct sched_domain *sd;
> >       struct perf_domain *pd;
> >       struct energy_env eenv;
> > @@ -7366,6 +7395,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >               unsigned long prev_spare_cap = 0;
> >               int max_spare_cap_cpu = -1;
> >               unsigned long base_energy;
> > +             int fits, max_fits = -1;
> >
> >               cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> >
> > @@ -7418,7 +7448,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
> > @@ -7426,7 +7458,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
> > @@ -7434,6 +7468,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                                */
> >                               max_spare_cap = cpu_cap;
> >                               max_spare_cap_cpu = cpu;
> > +                             max_fits = fits;
> >                       }
> >               }
> >
> > @@ -7452,26 +7487,50 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
> > +                      * Both don't fit performance hint (i.e. uclamp_min)
> > +                      * but best energy cpu has better capacity.
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
> > +                     if ((max_fits > 0) && (best_fits > 0) &&
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
> >
> >       return target;
> > @@ -10265,24 +10324,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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
> > @@ -10295,6 +10353,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> >       if (busiest->group_type == group_imbalanced)
> >               goto force_balance;
> >
> > +     local = &sds.local_stat;
> >       /*
> >        * If the local group is busier than the selected busiest group
> >        * don't try and pull any tasks.
> > --
> > 2.34.1
> >
