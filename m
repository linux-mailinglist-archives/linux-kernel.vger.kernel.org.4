Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BC566BC78
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjAPLJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjAPLIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:08:43 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C896D15565
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:08:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9so29967270pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j4YHO4LEMfTmTcqYPEJ5tKfv5llGMA5fDN69knFDKmk=;
        b=X66jwea1Ws7TsOhdyu9x6HeXn54NEGl9byptDb4ou9vgOdENcFgYzUe5s4rK5ArfBs
         IMQ4PWEHCt3pRPs3g/RUY5iHmkct1cSh4Ayq22oTmEmllTwMLJvBqZ7cRhdXbK2CKP3Q
         tGoVO4y4aPC0alMqeYQsPWj4Kdup5auwgOlHhA8yzvyD+HiW6QkUI/b2AXi/ERCiucXd
         SihyAuNNQog3CRhP5tQfIsDzzKE9RKTyWlDoFqaN7/UA8X/3FCgMSGPnP7ZhBP//VZTr
         jgBV891QpSJSJW7Q5G0RDRMJqhjYwpoZO8cyGXuqfTSKiYTJ3ejV4VPqjS9+vMlyNbhS
         hhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4YHO4LEMfTmTcqYPEJ5tKfv5llGMA5fDN69knFDKmk=;
        b=DMhuRenPgilpYYMBXrSuT0Qco+9/7cSNdjTQsKlnJS6qOsV6z7uLaFTqvufh+zZuM1
         ylor9x8PZTYzLhLzd+VvDELc6Qk1B8f+2lfaD4yOFq7/F1V5ZDhgNAAahGBhH9iZ1rjU
         OjLmjjHQCJRY/wr+6Hyd7KbmDEInjCWGt1jmr1C5WrSBfiAstL2IWehozFIQXt6PXIc+
         DTCclvTcZyUbqo5uAc8FB7URFkszeXq2iCJAHQ5jqj2jZY1XMJT7xx9rtYvQuuXA6lhZ
         odfwDPTWSlRgKP2e1MHVREZBxpG3a2oBw2bPoSdpymiJD/HG564ngM5ACN9vxpgcFAiD
         fr8w==
X-Gm-Message-State: AFqh2krv5Nk7yMOE+px740YtetIElWl0UPULlls22Toslsc36Za3kdR6
        y/uwAEy7E+om8kRSkMk7PdZ+j3WHygsgLRvV3+mJ3A==
X-Google-Smtp-Source: AMrXdXuH8DP10SBmOU7T8qoEve9ZhYoH3jXaHZetinyTBa0v5rdC02ml/96wPrqGf0K4SxGiwRfJAjWNqmj6a6p16JY=
X-Received: by 2002:a17:90a:6505:b0:223:fd3b:538e with SMTP id
 i5-20020a17090a650500b00223fd3b538emr8419868pjj.120.1673867319197; Mon, 16
 Jan 2023 03:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20230113134056.257691-1-vincent.guittot@linaro.org> <20230115001906.v7uq4ddodrbvye7d@airbuntu>
In-Reply-To: <20230115001906.v7uq4ddodrbvye7d@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 16 Jan 2023 12:08:27 +0100
Message-ID: <CAKfTPtB7hk=7SinWAbs7SMQEs4OHSCC1hQQHRtfzN-JxnV7Jvg@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
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

On Sun, 15 Jan 2023 at 01:19, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/13/23 14:40, Vincent Guittot wrote:
> > By taking into account uclamp_min, the 1:1 relation between task misfit
> > and cpu overutilized is no more true as a task with a small util_avg of
> > may not fit a high capacity cpu because of uclamp_min constraint.
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
> >
> > Change since v2:
> > - fix a condition in feec()
> > - add comments
> >
> >  kernel/sched/fair.c | 108 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 83 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e9d906a9bba9..29adb9e27b3d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4525,8 +4525,7 @@ static inline int util_fits_cpu(unsigned long util,
> >        *     2. The system is being saturated when we're operating near
> >        *        max capacity, it doesn't make sense to block overutilized.
> >        */
> > -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> > -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> > +     uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
>
> I think this hunk is what is causing the overutilized issues Kajetan reported
> against your patch.

Yeah, I have been to agressive with uclamp_max

>
> For the big cpu, this expression will always be true. So overutilized will
> trigger only for little and medium cores.
>
> I appreciate writing the boolean in a shorter form might appear like less code,
> but it makes things harder to read too; the compiler should be good at
> simplifying the expression if it can, no?
>
> Shall we leave the original expression as-is since it's easier to reason about?
>
> I think already by 'saving' using another variable we reduced readability and
> lead to this error. First line checks if we are the max_capacity which is
> the corner case we'd like to avoid and accidentally lost
>
> v1 code was:
>
> +       max_capacity = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> +       uclamp_max_fits = !max_capacity && (uclamp_max <= capacity_orig);
> +       fits = fits || uclamp_max_fits;
>
> I think that extra variable was well named to help make it obvious what corner
> case we're trying to catch here. Especially it matches the comment above it
> explaining this corner case. This auto variable should be free, no?
>
> Can we go back to this form please?

Yes, I'm going to come back to previous version

>
> >       fits = fits || uclamp_max_fits;
> >
> >       /*
> > @@ -4561,8 +4560,8 @@ static inline int util_fits_cpu(unsigned long util,
> >        * handle the case uclamp_min > uclamp_max.
> >        */
> >       uclamp_min = min(uclamp_min, uclamp_max);
> > -     if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> > -             fits = fits && (uclamp_min <= capacity_orig_thermal);
> > +     if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> > +             return -1;
>
> Here shouldn't this be
>
>         if (util < uclamp_min) {
>                 fits = fits && (uclamp_min <= capacity_orig);
>                 if (fits && (uclamp_min > capacity_orig_thermal))
>                         return -1;
>         }
>
> uclamp_min should fit capacity_orig first then we'd check for the corner case

I don't get why we should test capacity_orig first ?

case 1:
  capacity_orig = 800
  uclamp_min = 512
  capacity_orig_thermal = 400
  util = 200
util_fits_cpu should return -1

case 2:
  uclamp_min = 900
  capacity_orig = 800
  capacity_orig_thermal = 400
  utili_avg = 200
util_fits_cpu should return -1 whereas with your proposal above it will return 0

> if thermal pressure is causing it not to fit. And all of this should only
> matter if utill < uclamp_min. Otherwise util_avg should be driving force if
> uclamp_max is not trumping it.
>
> I need time to update my unit test [1] to catch these error cases as I didn't
> see them. In the next version I think it's worth including the changes to
> remove the capacity inversion in the patch.
>
> [1] https://github.com/qais-yousef/uclamp_test/blob/master/uclamp_test_thermal_pressure.c
>
>
> Thanks!
>
> --
> Qais Yousef
>
> >
> >       return fits;
> >  }
> > @@ -4572,7 +4571,11 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
> >       unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> >       unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> >       unsigned long util = task_util_est(p);
> > -     return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
> > +     /*
> > +      * Return true only if the cpu fully fits the task requirements, which
> > +      * include the utilization but also the performance.
> > +      */
> > +     return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
> >  }
> >
> >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > @@ -6132,6 +6135,7 @@ static inline bool cpu_overutilized(int cpu)
> >       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> >       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> >
> > +     /* Return true only if the utlization doesn't fit its capacity */
> >       return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
> >  }
> >
> > @@ -6925,6 +6929,7 @@ static int
> >  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >  {
> >       unsigned long task_util, util_min, util_max, best_cap = 0;
> > +     int fits, best_fits = 0;
> >       int cpu, best_cpu = -1;
> >       struct cpumask *cpus;
> >
> > @@ -6940,12 +6945,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
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
> > @@ -6958,7 +6979,11 @@ static inline bool asym_fits_cpu(unsigned long util,
> >                                int cpu)
> >  {
> >       if (sched_asym_cpucap_active())
> > -             return util_fits_cpu(util, util_min, util_max, cpu);
> > +             /*
> > +              * Return true only if the cpu fully fits the task requirements
> > +              * which include the utilization but also the performance.
> > +              */
> > +             return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
> >
> >       return true;
> >  }
> > @@ -7325,6 +7350,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >       unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
> >       struct root_domain *rd = this_rq()->rd;
> >       int cpu, best_energy_cpu, target = -1;
> > +     int prev_fits = -1, best_fits = -1;
> > +     unsigned long best_thermal_cap = 0;
> > +     unsigned long prev_thermal_cap = 0;
> >       struct sched_domain *sd;
> >       struct perf_domain *pd;
> >       struct energy_env eenv;
> > @@ -7360,6 +7388,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >               unsigned long prev_spare_cap = 0;
> >               int max_spare_cap_cpu = -1;
> >               unsigned long base_energy;
> > +             int fits, max_fits = -1;
> >
> >               cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> >
> > @@ -7412,7 +7441,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
> > @@ -7420,7 +7451,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
> > @@ -7428,6 +7461,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                                */
> >                               max_spare_cap = cpu_cap;
> >                               max_spare_cap_cpu = cpu;
> > +                             max_fits = fits;
> >                       }
> >               }
> >
> > @@ -7446,26 +7480,50 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
> > @@ -10259,24 +10317,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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
> > @@ -10289,6 +10346,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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
