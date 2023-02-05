Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2A68B11A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 18:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBERaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 12:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBER37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 12:29:59 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8CB1CF40
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 09:29:58 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z1so9944340plg.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 09:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fNnzz5KT3mzaOc1TqS1v/TnHm4rcviiItj9G5wod/+w=;
        b=oB5aBM77EfonHlarLC/GDCZJY/LUxQQN8fwQ3VwA9rRQY7ldsoVo49z0mXNcz0Hmx/
         5NqvdUKHsv/+UXc79mENTO55I+fC1mRkcoD6w6xa56G/9A41J2AInA8K0/5Ym4sCGvfB
         VScDltIim7Ag6ixlg+MhTsaIRsuZ2mMLH7Bq+6exFDBY+3rRbZwNIdrC4Yh1ECsryaVQ
         Zrwpu2vxyUZ1p3R12/wM53nZ3NDb4DoV0jKLo3wJ9IkonTYbTuEi0IVTLPLAO4hMRBtX
         5gWMu4vwM04z5mttMtxubxL0tfSVoqyo9XcF+pynxskGRaD5YU1xXzwg1QWt0R7JB9Zy
         fY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNnzz5KT3mzaOc1TqS1v/TnHm4rcviiItj9G5wod/+w=;
        b=W2g0AAq/RF5W4wTuGvii5FKnN270kBqW3Uh11to779WdiLtw1qyf5579L4Me4ZeyhN
         YQ0CB3mSe2X1XZFtL/KKKFeIrgUiQhea6klyyy2J/5XmGmyQsSCbDHhM70I2fRFJ1sD4
         vZlCQMMIzs/pT2KEIm0AD/nmSrG9CRqLMmZcz+3oygvva/ISFW3H94bkr5y2tI/hejyc
         mvtqlkEp5BkqATtIe8VIQAt8OIURf2SDHy9YSqAA4L1WnH7CV7kvR96cZastlK6+dd6D
         JcPjh3cT7UKZ1O0V+SBnjiLGHFeZPhGFPvvqLOxf89pVzXfBS695Pn/idhHcqDemSGuC
         qHaw==
X-Gm-Message-State: AO0yUKWZAP9QefxRKHbUxgNlp61NcpmVnUIxGHE3Z0t5Dd7+gPuVfVT7
        SdqG7SjVf1E3N229rpDNBcqzBywa1Q4WX6Nb3RScAg==
X-Google-Smtp-Source: AK7set/b+jqgwbY14K1WAA7Xdziz3kuF/ITwmfTlHbot/dKQWLTNtCAi/DxAAUs1rvpiJwtgl+7T2rSRotdkmBbziQU=
X-Received: by 2002:a17:90a:3844:b0:230:7ea2:1a04 with SMTP id
 l4-20020a17090a384400b002307ea21a04mr1392972pjf.112.1675618197267; Sun, 05
 Feb 2023 09:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20230201143628.270912-1-vincent.guittot@linaro.org>
 <20230201143628.270912-3-vincent.guittot@linaro.org> <20230204184231.zx6oo52r5q2nvij7@airbuntu>
In-Reply-To: <20230204184231.zx6oo52r5q2nvij7@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sun, 5 Feb 2023 18:29:46 +0100
Message-ID: <CAKfTPtAGRY8duSnvafntYJ20H1JGPeuhyLCvVRk0MEUsoTY_Tg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v5] sched/fair: Remove capacity inversion detection
To:     Qais Yousef <qyousef@layalina.io>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kajetan.puchalski@arm.com, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2023 at 19:42, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 02/01/23 15:36, Vincent Guittot wrote:
> > Remove the capacity inversion detection which is now handled by
> > util_fits_cpu() returning -1 when we need to continue to look for a
> > potential CPU with better performance.
> >
> > This ends up almost reverting patches below except for some comments:
>
> nit: I think this comment must be removed/reworeded though

This comment has already been removed. That's why I said almost revert
except for some comments in the commit message

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 691a2f9c4efa..c6c8e7f52935 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4476,10 +4476,6 @@ static inline int util_fits_cpu(unsigned long util,
>          *
>          * For uclamp_max, we can tolerate a drop in performance level as the
>          * goal is to cap the task. So it's okay if it's getting less.
> -        *
> -        * In case of capacity inversion, which is not handled yet, we should
> -        * honour the inverted capacity for both uclamp_min and uclamp_max all
> -        * the time.
>          */
>         capacity_orig = capacity_orig_of(cpu);
>         capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
>
> > commit da07d2f9c153 ("sched/fair: Fixes for capacity inversion detection")
> > commit aa69c36f31aa ("sched/fair: Consider capacity inversion in util_fits_cpu()")
> > commit 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Apart from that, LGTM.
>
> Reviewed-by: Qais Yousef <qyousef@layalina.io>

Thanks

>
>
> Thanks!
>
> --
> Qais Yousef
>
> > ---
> >  kernel/sched/fair.c  | 84 +++-----------------------------------------
> >  kernel/sched/sched.h | 19 ----------
> >  2 files changed, 5 insertions(+), 98 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 074742f107c0..c6c8e7f52935 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4476,17 +4476,9 @@ static inline int util_fits_cpu(unsigned long util,
> >        *
> >        * For uclamp_max, we can tolerate a drop in performance level as the
> >        * goal is to cap the task. So it's okay if it's getting less.
> > -      *
> > -      * In case of capacity inversion we should honour the inverted capacity
> > -      * for both uclamp_min and uclamp_max all the time.
> >        */
> > -     capacity_orig = cpu_in_capacity_inversion(cpu);
> > -     if (capacity_orig) {
> > -             capacity_orig_thermal = capacity_orig;
> > -     } else {
> > -             capacity_orig = capacity_orig_of(cpu);
> > -             capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> > -     }
> > +     capacity_orig = capacity_orig_of(cpu);
> > +     capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> >
> >       /*
> >        * We want to force a task to fit a cpu as implied by uclamp_max.
> > @@ -9027,82 +9019,16 @@ static unsigned long scale_rt_capacity(int cpu)
> >
> >  static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> >  {
> > -     unsigned long capacity_orig = arch_scale_cpu_capacity(cpu);
> >       unsigned long capacity = scale_rt_capacity(cpu);
> >       struct sched_group *sdg = sd->groups;
> > -     struct rq *rq = cpu_rq(cpu);
> >
> > -     rq->cpu_capacity_orig = capacity_orig;
> > +     cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
> >
> >       if (!capacity)
> >               capacity = 1;
> >
> > -     rq->cpu_capacity = capacity;
> > -
> > -     /*
> > -      * Detect if the performance domain is in capacity inversion state.
> > -      *
> > -      * Capacity inversion happens when another perf domain with equal or
> > -      * lower capacity_orig_of() ends up having higher capacity than this
> > -      * domain after subtracting thermal pressure.
> > -      *
> > -      * We only take into account thermal pressure in this detection as it's
> > -      * the only metric that actually results in *real* reduction of
> > -      * capacity due to performance points (OPPs) being dropped/become
> > -      * unreachable due to thermal throttling.
> > -      *
> > -      * We assume:
> > -      *   * That all cpus in a perf domain have the same capacity_orig
> > -      *     (same uArch).
> > -      *   * Thermal pressure will impact all cpus in this perf domain
> > -      *     equally.
> > -      */
> > -     if (sched_energy_enabled()) {
> > -             unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> > -             struct perf_domain *pd;
> > -
> > -             rcu_read_lock();
> > -
> > -             pd = rcu_dereference(rq->rd->pd);
> > -             rq->cpu_capacity_inverted = 0;
> > -
> > -             for (; pd; pd = pd->next) {
> > -                     struct cpumask *pd_span = perf_domain_span(pd);
> > -                     unsigned long pd_cap_orig, pd_cap;
> > -
> > -                     /* We can't be inverted against our own pd */
> > -                     if (cpumask_test_cpu(cpu_of(rq), pd_span))
> > -                             continue;
> > -
> > -                     cpu = cpumask_any(pd_span);
> > -                     pd_cap_orig = arch_scale_cpu_capacity(cpu);
> > -
> > -                     if (capacity_orig < pd_cap_orig)
> > -                             continue;
> > -
> > -                     /*
> > -                      * handle the case of multiple perf domains have the
> > -                      * same capacity_orig but one of them is under higher
> > -                      * thermal pressure. We record it as capacity
> > -                      * inversion.
> > -                      */
> > -                     if (capacity_orig == pd_cap_orig) {
> > -                             pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
> > -
> > -                             if (pd_cap > inv_cap) {
> > -                                     rq->cpu_capacity_inverted = inv_cap;
> > -                                     break;
> > -                             }
> > -                     } else if (pd_cap_orig > inv_cap) {
> > -                             rq->cpu_capacity_inverted = inv_cap;
> > -                             break;
> > -                     }
> > -             }
> > -
> > -             rcu_read_unlock();
> > -     }
> > -
> > -     trace_sched_cpu_capacity_tp(rq);
> > +     cpu_rq(cpu)->cpu_capacity = capacity;
> > +     trace_sched_cpu_capacity_tp(cpu_rq(cpu));
> >
> >       sdg->sgc->capacity = capacity;
> >       sdg->sgc->min_capacity = capacity;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 1072502976df..3e8df6d31c1e 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1044,7 +1044,6 @@ struct rq {
> >
> >       unsigned long           cpu_capacity;
> >       unsigned long           cpu_capacity_orig;
> > -     unsigned long           cpu_capacity_inverted;
> >
> >       struct balance_callback *balance_callback;
> >
> > @@ -2899,24 +2898,6 @@ static inline unsigned long capacity_orig_of(int cpu)
> >       return cpu_rq(cpu)->cpu_capacity_orig;
> >  }
> >
> > -/*
> > - * Returns inverted capacity if the CPU is in capacity inversion state.
> > - * 0 otherwise.
> > - *
> > - * Capacity inversion detection only considers thermal impact where actual
> > - * performance points (OPPs) gets dropped.
> > - *
> > - * Capacity inversion state happens when another performance domain that has
> > - * equal or lower capacity_orig_of() becomes effectively larger than the perf
> > - * domain this CPU belongs to due to thermal pressure throttling it hard.
> > - *
> > - * See comment in update_cpu_capacity().
> > - */
> > -static inline unsigned long cpu_in_capacity_inversion(int cpu)
> > -{
> > -     return cpu_rq(cpu)->cpu_capacity_inverted;
> > -}
> > -
> >  /**
> >   * enum cpu_util_type - CPU utilization type
> >   * @FREQUENCY_UTIL:  Utilization used to select frequency
> > --
> > 2.34.1
> >
