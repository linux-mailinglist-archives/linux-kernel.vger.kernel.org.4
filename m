Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E25EFBBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiI2RQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbiI2RP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:15:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609F314FE1C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:15:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j16so3235256lfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FmPE2/2w87SJQdIQ2Ja/f18zhJ688ZmXtdzvRgxBQGQ=;
        b=CpIx0bKmEHDkl83KnmV+tnSEWDeI80d33J7MUpeVy0Wlxl4VIW918+QIRuK7Uf92Ml
         pTE8OGscCUgnUVhZDrQvRFN/6SGWBba6XlWr4k84/c5fRXbyJ345ur5Fj6qAwN2qhpkL
         5p9HWL9CpDr7lFdaAtcWDkETOSFS7DNEYMcDFsJkA6adZ5szODyenTWRqocD/ovo3e7v
         xeOBx23dMzqbWXgb7WCY19qZ2+uzlpp/QZPeioR7xFB0NBwWwN1FENFQDuRM6O8jh3AG
         CNRJfeyWxNWBWOi/IyxG5ZY9J+7ngxgiaDnIdq5nKS+Iyb6DZPsZAZMdi6AcksHLN/ip
         dEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FmPE2/2w87SJQdIQ2Ja/f18zhJ688ZmXtdzvRgxBQGQ=;
        b=gkLGpNM186A9T4AhZFm6gX196dbIALkLFLsP9bFhz5PewmJX8RcMewCz9Su+SYxjBZ
         0q9Kk1mWEOlWZTI+fA+xIzDg7QoRNJti2J4jMhhXz0tS339fVwTsA8316NjnJUQlTEzM
         AEYWBsR4mCDKRf08rdmkliB2iDQfPnFCDfy5OyaQQtGSXe5O0uqXrNf4ULKEPYEn8qIy
         cZ1SbbGMeA9vtm/RC8pRT48tXi/u4kluE9f6n9Vxw1p2e+AOs58n5EANi8pZ4csE8IXZ
         bV/5klb1I7z5heWfgHtBYvSKLeglCYVIWgnl1xK0FyBBZ8sITQBiKRku/alh+YrtGNjB
         kT1g==
X-Gm-Message-State: ACrzQf2RzN1CS2J/bzgkiS5qhgR/xBiIgrayFddCTslzc1QBbYx7FMbh
        jSNnSSTFSLrPBfI90zW5rubzIUoJB73s6eP3wS0WUtbN20V2vQ==
X-Google-Smtp-Source: AMsMyM6SEv6EIl8GAfHiFZDam2KPVbL2JxHC8wKrGGIU0d9TH6nCDPE+5RzvUlZVTGb3bre0lDgB7mjWv1tzLv6LTTY=
X-Received: by 2002:a05:6512:2286:b0:49e:eb:ea19 with SMTP id
 f6-20020a056512228600b0049e00ebea19mr1901220lfu.645.1664471753691; Thu, 29
 Sep 2022 10:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220916131538.24706-1-vincent.guittot@linaro.org> <YzXEZnH6CAtZ+V4R@hirez.programming.kicks-ass.net>
In-Reply-To: <YzXEZnH6CAtZ+V4R@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Sep 2022 19:15:42 +0200
Message-ID: <CAKfTPtDkQuA9ghEVJZieLfeXLMpimE-jjuLB-1wLntYSD6RoxQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: limit sched slice duration
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 18:14, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Sep 16, 2022 at 03:15:38PM +0200, Vincent Guittot wrote:
> > In presence of a lot of small weight tasks like sched_idle tasks, normal
> > or high weight tasks can see their ideal runtime (sched_slice) to increase
> > to hundreds ms whereas it normally stays below sysctl_sched_latency.
> >
> > 2 normal tasks running on a CPU will have a max sched_slice of 12ms
> > (half of the sched_period). This means that they will make progress
> > every sysctl_sched_latency period.
> >
> > If we now add 1000 idle tasks on the CPU, the sched_period becomes
> > 3006 ms and the ideal runtime of the normal tasks becomes 609 ms.
> > It will even become 1500ms if the idle tasks belongs to an idle cgroup.
> > This means that the scheduler will look for picking another waiting task
> > after 609ms running time (1500ms respectively). The idle tasks change
> > significantly the way the 2 normal tasks interleave their running time
> > slot whereas they should have a small impact.
> >
> > Such long sched_slice can delay significantly the release of resources
> > as the tasks can wait hundreds of ms before the next running slot just
> > because of idle tasks queued on the rq.
> >
> > Cap the ideal_runtime to the weighted version of sysctl_sched_latency when
> > comparing with the vruntime of the next waiting task to make sure that
> > tasks will regularly make progress and will not be significantly impacted
> > by idle/background tasks queued on the rq.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > I have kept the test if (delta < 0) as calc_delta_fair() can't handle negative
> > value.
> >
> > Change since v1:
> >   - the first 3 patches have been already queued
> >   - use the weight of curr to scale sysctl_sched_latency before capping
> >     the ideal_runtime so we can compare vruntime values.
> >
> >  kernel/sched/fair.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5ffec4370602..ba451bb25929 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4610,6 +4610,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >       if (delta < 0)
> >               return;
> >
> > +     ideal_runtime = min_t(u64, ideal_runtime,
> > +                                calc_delta_fair(sysctl_sched_latency, curr));
> >       if (delta > ideal_runtime)
> >               resched_curr(rq_of(cfs_rq));
> >  }
>
> Since I'm suffering from a cold and constant interruptions I had to
> write down my thinking and ended up with the below.
>
> Does that make sense or did I go sideways somewhere (entirely possible).
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5ffec4370602..2b218167fadf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4575,17 +4575,33 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  }
>
>  /*
> - * Preempt the current task with a newly woken task if needed:
> + * Tick driven preemption; preempt the task if it has ran long enough.
> + * Allows other tasks to have a go.
>   */
>  static void
>  check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  {
> -       unsigned long ideal_runtime, delta_exec;
>         struct sched_entity *se;
> -       s64 delta;
> +       s64 delta, delta_exec;
> +       u64 ideal_runtime;
>
> -       ideal_runtime = sched_slice(cfs_rq, curr);
> +       /* How long has this task been on the CPU for [walltime]. */
>         delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
> +
> +       /*
> +        * Ensure that a task that missed wakeup preemption by a
> +        * narrow margin doesn't have to wait for a full slice.
> +        * This also mitigates buddy induced latencies under load.
> +        */
> +       if (delta_exec < sysctl_sched_min_granularity)
> +               return;

ideal_runtime can be lower than sysctl_sched_min_granularity. It can
be as low as sysctl_sched_idle_min_granularity for idle task. In this
case, we want to resched even if(delta_exec <
sysctl_sched_min_granularity). That's why the 1st test was still done
before

> +
> +       /*
> +        * When many tasks blow up the sched_period; it is possible that
> +        * sched_slice() reports unusually large results (when many tasks are
> +        * very light for example). Therefore impose a maximum.
> +        */
> +       ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);

I didn't cap ideal_runtime before this test because we have situations
where large ideal_runtime is ok: If there is only one normal thread
with hundreds of idle threads as an example: Is it acceptable to
trigger a useless resched in this case ? That's why I have computed
the virtual time generated by the capped version of ideal_runtime.

>         if (delta_exec > ideal_runtime) {
>                 resched_curr(rq_of(cfs_rq));
>                 /*
> @@ -4597,19 +4613,24 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>         }
>
>         /*
> -        * Ensure that a task that missed wakeup preemption by a
> -        * narrow margin doesn't have to wait for a full slice.
> -        * This also mitigates buddy induced latencies under load.
> +        * Strictly speaking the above is sufficient; however due to
> +        * imperfections it is possible to have a leftmost task left of
> +        * min_vruntime.
> +        *
> +        * Also impose limits on the delta in vtime.
>          */
> -       if (delta_exec < sysctl_sched_min_granularity)
> -               return;
>
>         se = __pick_first_entity(cfs_rq);
>         delta = curr->vruntime - se->vruntime;
> -
>         if (delta < 0)
>                 return;
>
> +       /*
> +        * Compare @delta [vtime] to @ideal_runtime [walltime]. This means that
> +        * heavy tasks (for which vtime goes slower) get relatively more time
> +        * before preemption, while light tasks (for which vtime goes faster)
> +        * get relatively less time.  IOW, heavy task get to run longer.
> +        */

After your comment on v1, I looked more deeply on this and the
comparison of [vtime] with [walltime] can create a large unfairness.
vtime of nice-20 increases by ~250us for 24ms of walltime which means
that the nice-20 will have to run for a long time before reaching this
walltime delta (assuming the vruntime were similar at the beg)

>         if (delta > ideal_runtime)
>                 resched_curr(rq_of(cfs_rq));
>  }
