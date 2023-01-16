Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526D466BCCA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjAPLXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjAPLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:23:37 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C591DB96
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:23:36 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id s3so18188494pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tLgP40hKSxsObwN4+snUnnezeQ4wAc0rF/UZlYixKYE=;
        b=ttR4DUNjgwNCiDJGYcKWSjpWkCG8CmI/DGS0PpQhmbyoU1xr6nu3ViH55fG99+iXUJ
         OcvZcAlQ5ZFjsnVoWtthaJnJtTh00fdWSK+PyViI1ruQY2iLLZ/7KZE/0Kwt+F8HdshF
         266Kfy8lzrajKzZ8zSZyZAyx22KTaGOopjgbvzE+w4Xm+NYaBqGWolqsYjGsxKXZtk19
         9AQAUknUn4deuyNXbq2iwtIFHYddWyFRyhuTeDqqNlhN9R4Jv06nLPfe1tC4v66aQmVA
         McitY5RoyfhO6hecFfbq0GOwNrksApJVLnln1cntrTMG6AUaUnzCsgzHNuTmZB3aDpmz
         at+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLgP40hKSxsObwN4+snUnnezeQ4wAc0rF/UZlYixKYE=;
        b=CiEOf0L5z/QEuDZUHH+WpyM+j+uuwQsrx4X4V9egjalSg40v9YdE2bBtxiIDNe2nj1
         sjWmo8m9as8qoxchlJkn/qw/nL+QrLGdUOjVmN0Nw5NHJtKNhsP5BdK07u1afVCs3GXM
         FUnWZXysW7wWgKnZzh7w0NYdpc6P3De2W5CGCrVGuJohIGwFC6WGf92DUiJaY6xdvZ88
         dVWBmTmR/HGxyGc/tx9UT6pUL/TyNeIj163h4+IQ/6gpMcYM957nZ3bP2fSr0AmQ1HRX
         Ef1MfSunCzzMN3/k+4mMhDTzZ4DXF0+gQz3gobVV093MBlM5OlZADJXfDjjUaV4JSSiO
         mtQg==
X-Gm-Message-State: AFqh2kqJYmsq5DwrcsRTDO/H/4fd4Wk/RTOSdkcMF/w3YAnlIbwIBRVz
        H43tiVW9tRYuNUwz4qyOlK97tH8ZnHfBKCfqL2LZ/g==
X-Google-Smtp-Source: AMrXdXt6Ro5iYwvNcd7pUuuLeNcgwA98EKZwPUwhsrTWIrjVP3kyuxP7+nE2mHuJMsng3nW3MuNikEW5jtLg3Zo5f5w=
X-Received: by 2002:aa7:8102:0:b0:58d:a683:bb28 with SMTP id
 b2-20020aa78102000000b0058da683bb28mr222018pfi.36.1673868215665; Mon, 16 Jan
 2023 03:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20230113134056.257691-1-vincent.guittot@linaro.org> <78bf2d91-0076-f748-7c6a-530dad466787@arm.com>
In-Reply-To: <78bf2d91-0076-f748-7c6a-530dad466787@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 16 Jan 2023 12:23:24 +0100
Message-ID: <CAKfTPtCAAOvFak2FqkKv2AwnoBZ3cwbMwfnAAGqDx+Wq4Ng+zw@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@kernel.org, peterz@infradead.org, qyousef@layalina.io,
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

On Mon, 16 Jan 2023 at 10:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 13/01/2023 14:40, Vincent Guittot wrote:
> > By taking into account uclamp_min, the 1:1 relation between task misfit
> > and cpu overutilized is no more true as a task with a small util_avg of
>
> of ?
>
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
> Isn't `uclamp_max <= capacity_orig` always true for `capacity_orig ==
> SCHED_CAPACITY_SCALE`?
>
> uclamp_max = [0..SCHED_CAPACITY_SCALE] , capacity_orig =
> SCHED_CAPACITY_SCALE
>
> >       fits = fits || uclamp_max_fits;
>
> Like Qais I don't understand this change. I read the previous discussion
> from https://lkml.kernel.org/r/20221208140526.vvmjxlz6akgqyoma@airbuntu
> ("Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
> capacity inversion").
>
> I assume Qais wanted to force `uclamp_max_fits = 0` for a big CPU
> (`capacity_orig = 1024`) and a `uclamp_max = 1024` to not lift `fits`
> from 0 to 1.
>
> >       /*
> > @@ -4561,8 +4560,8 @@ static inline int util_fits_cpu(unsigned long util,
> >        * handle the case uclamp_min > uclamp_max.
> >        */
> >       uclamp_min = min(uclamp_min, uclamp_max);
> > -     if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> > -             fits = fits && (uclamp_min <= capacity_orig_thermal);
> > +     if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> > +             return -1;
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
>
> Not sure if people get what `performance requirements` mean here? I know
> we want to use `performance` rather `bandwidth hint` to describe what
> uclamp is. So shouldn't we use `utilization but also uclamp`?
>
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
>
> s/utlization/utilization
> s/its/CPU ?
>
> >       return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
> >  }
>
> cpu_overutilized() is the only place where we now only test for
> !util_fits_cpu(). The new comment says we only care about utilization
> not fitting CPU capacity.
>
> Does this mean the rq uclamp values are not important here and we could
> go back to use fits_capacity()?
>
> Not sure since util_fits_cpu() is still coded differently:

uclamp_min is not important but uclamp_max still cap the utilization

>
>   fits = fits_capacity(util, capacity)
>
>   fits = fits || uclamp_max_fits  <-- uclamp_max_fits can turn fits from
>                                       0 into 1, so util doesn't fit but
>                                       we don't return 1?
>
> That said, I don't understand the current 'uclamp_max_fits = (uclamp_max
> <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE)' in
> util_fits_cpu(), like already mentioned.
>
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
>
> In task_fits_cpu() `utilization and performance (better uclamp)
> requirements` term was used. I assume it's the same thing here?
>
> > +             if (fits > 0)
> >                       return cpu;
> > +             /*
> > +              * Only the min performance (i.e. uclamp_min) doesn't fit. Look
> > +              * for the CPU with highest performance capacity.
>                                             ^^^^^^^^^^^^^^^^^^^^
>
> Do we use a new CPU capacity value `performance capacity (1)` here?
>
> Which I guess is `capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu)`.
>
> I'm asking since util_fits_cpu() still uses: `capacity_orig_thermal (2)
> = capacity_orig - arch_scale_thermal_pressure()` when checking whether
> to return -1. Shouldn't (1) and (2) be the same?

I'm all in favor of both being capacity_orig_of(cpu) -
thermal_load_avg(cpu_rq(cpu) like the capacity inversion detection

>
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
>
> [...]
>
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
>
> IMHO, `performance` stands for `cpu_thermal_cap` which is
> `cpu_capacity_orig - thermal pressure`.
>
> I assume `performance` is equal to `performance capacity` used in
> select_idle_capacity which uses thermal_load_avg() and not thermal
> pressure. Why this difference?
>
> [...]
