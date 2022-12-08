Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5736164714A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLHOFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiLHOFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:05:40 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089963AC1A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:05:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so3433419wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 06:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOG/hAcKc+HI3hGxV2YH/HoTm/mqbWws4K2VReryACg=;
        b=v1Ns/q48mdrmbuiDuhjUB6l+tRFUX9QtBfH3bCQSwulZbFLySxaqt3QK2+RZuUYG/T
         YMo9shNJJCQTi+lnUGqTyt824fG28adoSOprVrpzP5UAszUOrHdHm83hdIBFuk8NON96
         15+d3glxM4V+4bJsY4DOTR2rUZPOE5VlwbwZJQ+LuuNn8ifMQUWHRKKzI7Vm19dmozdn
         wGElL5HseyrW1gqaFegtgItXhCK4urBdRkCUtk9jcecFuV/04k6naa/Knt9kVykuoEOX
         9sf4FRMhvSHfY2DGgtJSYk7dvGDxZ9ylfyU+TvDgjqodA6fqmM3s1kK/L8u/5BVtEtFi
         SvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOG/hAcKc+HI3hGxV2YH/HoTm/mqbWws4K2VReryACg=;
        b=N8dizOH1W/brcY+Ux5sVHz0dthV7d6zDHLHMUszbWI8MxEs7DUCPxjiE2t2Th3F4i3
         hXNh9MGFxyumezxcCAUwiqwBr5RqjucTi/opMgTz0MBu6DeG6CqXiEa7ftKAKl49RMkM
         gjPicOd+0cvBrXnWAaYpxoC5f3mNaXY7K6GJDbSYa7bsIC0Wd7VQpTITjXWN4Tqp005/
         LmHun7pmiaKQSRz2Cy9rNSzKzos7Bwzq4o77UFi+fjcD7ADazO6zDqQuAZ4JeVtDuXoY
         uQb2eOtYNMOwekuy0UfaH7ht8+13zrdIWYlEKQnm3/2LebB7ny5/APjnFKfDeKfOyQDi
         jK4w==
X-Gm-Message-State: ANoB5pk7fu+XM+wwKMNlA/sRMAPEENKh1TWs8C53lf9XQzhgKJ1KfXog
        25DIYPIP9gu3qVi36CiMjtV+Pg==
X-Google-Smtp-Source: AA0mqf6Bspq92Y6n5RQKHT/kSu9aZ0qqcxyGAjYEDGS/3NZpi2kP1dyYvZoDS5vhzMOdGvHbwTq4eQ==
X-Received: by 2002:a05:600c:1da0:b0:3cf:ac89:f9f0 with SMTP id p32-20020a05600c1da000b003cfac89f9f0mr2190509wms.25.1670508329201;
        Thu, 08 Dec 2022 06:05:29 -0800 (PST)
Received: from airbuntu ([2a00:79e1:abc:9:c7d:8d2a:a83c:450a])
        by smtp.gmail.com with ESMTPSA id az5-20020a05600c600500b003a6125562e1sm5424852wmb.46.2022.12.08.06.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 06:05:28 -0800 (PST)
Date:   Thu, 8 Dec 2022 14:05:26 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
Message-ID: <20221208140526.vvmjxlz6akgqyoma@airbuntu>
References: <20221127141742.1644023-1-qyousef@layalina.io>
 <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu>
 <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu>
 <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/22 19:12, Vincent Guittot wrote:
> On Mon, 5 Dec 2022 at 12:02, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 12/04/22 12:35, Vincent Guittot wrote:
> > > On Sat, 3 Dec 2022 at 15:33, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 12/02/22 15:57, Vincent Guittot wrote:
> > > >
> > > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > > index 7c0dd57e562a..4bbbca85134b 100644
> > > > > > --- a/kernel/sched/fair.c
> > > > > > +++ b/kernel/sched/fair.c
> > > > > > @@ -8856,23 +8856,20 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> > > > > >          *   * Thermal pressure will impact all cpus in this perf domain
> > > > > >          *     equally.
> > > > > >          */
> > > > > > -       if (sched_energy_enabled()) {
> > > > > > +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> > > > > >                 unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> > > > > > -               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> > > > > > +               struct cpufreq_policy *policy, __maybe_unused *policy_n;
> > > > > >
> > > > > >                 rq->cpu_capacity_inverted = 0;
> > > > > >
> > > > > > -               SCHED_WARN_ON(!rcu_read_lock_held());
> > > > > > -
> > > > > > -               for (; pd; pd = pd->next) {
> > > > > > -                       struct cpumask *pd_span = perf_domain_span(pd);
> > > > > > +               for_each_active_policy_safe(policy, policy_n) {
> > > > >
> > > > > So you are looping all cpufreq policy (and before the perf domain) in
> > > > > the period load balance. That' really not something we should or want
> > > > > to do
> > > >
> > > > Why is it not acceptable in the period load balance but acceptable in the hot
> > > > wake up path in feec()? What's the difference?
> > >
> > > This patch loops on all cpufreq policy in sched softirq, how can this
> > > be sane ? and not only in eas mode but also in the default asymmetric
> >
> > Hmm I'm still puzzled. Why it's not sane to do it here but it's okay to do it
> > in the wake up path in feec()?
> 
> feec() should be considered as an exception not as the default rule.
> Thing like above which loops for_each on external subsystem should be
> prevented and the fact that feec loops all PDs doesn't means that we
> can put that everywhere else

Fair enough. But really understanding the root cause behind this limitation
will be very helpful. I don't have the same appreciation of why this is
a problem, and shedding more light will help me to think more about it in the
future.

I have a pinebook pro that contains 4 littles and 2 bigs. What kind of
experiment I can run to see the impact of a large loop here? Is trying with 32
or even 64 policies good? What type of workloads to try this with?

> 
> >
> > AFAICT the number of cpufreq policies and perf domains have 1:1 mapping. In
> > feec() we not only loop perf domains, but we go through each cpu of each domain
> > to find max_spare_cap then compute_energy(). Which is more intensive.
> >
> > In worst case scenario where there's a perf domain for each cpu, then we'll
> > loop through every CPU *and* compute energy its energy cost in the wake up
> > path.
> >
> > Why it's deemed acceptable in wake up path which is more critical AFAIU but not
> > period load balance which is expected to do more work? What am I missing?
> 
> Things like util_fits_cpu is not an EAS only feature although it's the
> only user for now and this must remain usable by another part of the
> scheduler that wants to check if a workload can fit on a cpu if
> needed. But adding not scalable behavior makes it not usable by
> default for anything else than Android big.LITTLE with 8 CPUs and 2/3
> PDs.

To be honest I don't see the scalability problem, and that's the problem :-)

As I said before; I'm not against moving to something else. I didn't think
scalability is a problem even outside 8 CPUs and 2/3 PDs.

> 
> As a summary the rule is to be scalable and don't assume that a
> for_each loop on another framework can be reasonable thus the above is
> not.
> 
> The fact that feec is not scalable and assumes that a system will not
> have more than 8 cores and 2/3 PDs is a problem IMO because it
> prevents other systems from even considering using it.
> 
> Also as mentioned before, the above will be called as soon as
> sched_asym_cpucapacity is enabled even if eas and feec() is not used
> so you extend the problem outside feec().

I am even more curious now to understand where we hit a limit.

The only assumption I'm maybe making here; and I think is inherit in these
type of systems, is that if your hardware is HMP, then power is concern for you
and not only performance.

That said; as I mentioned in my previous reply; I did suggest an alternative
and happy to consider something else. I think I can do something in topology to
help us making an easier decision here without making both sides ugly. It just
seemed unnecessary at the time given the simplicity of this approach.

> 
> >
> > > performance  one.
> > >
> > > This inverted detection doesn't look like the right way to fix your
> > > problem IMO. That being said, i agree that I haven't made any other
> > > proposal apart that I think that you should use a different rules for
> > > task and for overutilized and part of your problem comes from this.
> >
> > We discussed this before; I need to revisit the thread but I can't see how
> > overutilized different than task will fix the issue. They should be unified by
> > design.
> 
> A unified design doesn't mean one function especially if that includes
> to loop for_each_active_policy_safe() in sched softirq

This only makes sense to me if you refer to death by thousand cuts kind of
problem. I can't see how this on its own being a problem.. I'll run some tests
to convince myself.

> 
> uclamp_min should not be used to set an over utilized cpu  because it

uclamp_min must set overutilized. If a long running task has its uclamp_min
changed, we want to upmigrate it if that's necessary to meet the new demand.

Keep in mind in android tasks could move between top-app, foreground and
background groups.

And keep in mind Android now implement a framework to dynamically change
uclamp. It's available from Android 12 as part of Android Dynamic Performance
Framework (ADPF). It's under CPU Hints.

	https://developer.android.com/games/optimize/adpf

> doesn means that the cpu is overutilized and uclamp_max should be used

It is a misfit task; which requires overutilized to be set to re-enable load
balance for uclamp_min to upgrate it. For uclamp max we should not set
overutilized, agreed and that's what we should be doing.

> for not setting overutilized a cpu with a clamped max value
> 
> >
> > I'm all ears if there's a simpler way to address the problem :-)
> 
> let me try to prepare a something to show what I mean

A PoC just to help me see what you mean would be great, thanks!

> 
> >
> > The problem is that thermal pressure on big cpu is not important from
> > uclamp perspective until it is in inversion state. It is quite common to have
> > a system where the medium capacity is in 500 range. If the big is under thermal
> > pressure that it drops to 800, then it is still a fitting CPU from uclamp
> > perspective. Keep in mind uclamp_min is useful for tasks whose utilization is
> > small So we need to be selective when thermal pressure is actually helping out
> > or just creating unnecessary problems.
> 
> What about medium cores ?  There are often 3 capacity levels now so
> the same can happen between medium and little.

We do subtract thermal pressure from capacity for the mediums and littles all
the time. So that case is handled, no?

> 
> Also we have more and more thermal capping happening ahead of
> overheating like the power cap interface where we want to cap some
> CPUs and others even before they reach their thermal limit in order to
> get more power/thermal room for others. This implies that some CPUs
> could be under thermal pressure whereas others not. This implies also
> that a UC with big core capacity being below little and medium cores
> is not impossible or medium being under little but big staying at high
> capacity.

I *think* I am catering for this already. The big is special because it's the
highest level, so thermal pressure; from uclamp perspective, is not meaningful
as it's the best you can ever get on this system; untill it becomes capacity
inverted that is.

Getting this not to break easily is really important for the successful
adoption of this hint.

> 
> >
> > The only other option I had in mind was to do the detection when we update the
> > thermal_pressure in the topology code. But that didn't look better alternative
> > to me.
> >
> > >
> > > Then this make eas and util_fits_cpu even more Arm specific and I
> >
> > What is the Arm specific part about it? Why it wouldn't work on non-Arm
> > systems?
> 
> Because it assume that for_each_cpufreq loop in not a problem mostly
> because there will be no more than 3 CPUs and 2/3 PDs (ie Arm based
> Android smartphone) and as a result, it's acceptable to loop
> everything everytime

I did not make this assumption. I genuinely thought (and still think to be
honest) that it's not a scalability issue. But of course I appreciate your
knowledge and experience when you say you think this can be a problem.

I only experienced the issue of too many cgroups causing newidle_cpu() to take
a long time; if you remember that issue we had with Joel.

If any assumptions I made here it is that someone creating HMP systems it is
not for a massive server market where we can have 100s of cores. I probably
have assumed HMP = average consumer market that wants power efficient devices
and if we go crazy we can go to 32 cpus or something. Which I didn't think will
be a problem even if each cpus has its own PD.

> 
> >
> > > still hope to merge sched_asym_cpucapacity and asym_packing a some
> > > levels because they looks  more and more similar but each side is
> > > trying to add some SoC specific policy
> >
> > Oh, it seems Intel relies on asym_packing for their hybrid support approach?
> > I think sched_asym_cpucapacity was designed to be generic. If I gathered
> > correctly lack of support for SMT and inability to provide energy model outside
> > of DT were some required extensions.
> 
> At least merging asym_packing and sched_asym_cpucapacity would be a
> good starting point even if we don't consider using feec() in the 1st
> step.
> 
> When we have things like below in the code in find_busiest_queue(), it
> probably means that we have duplicated behavior :
> 
> if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
>     !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
>     nr_running == 1)
> continue;
> 
> /* Make sure we only pull tasks from a CPU of lower priority */
> if ((env->sd->flags & SD_ASYM_PACKING) &&
>     sched_asym_prefer(i, env->dst_cpu) &&
>     nr_running == 1)
> continue;

I see.

Just to make sure, this is only used in LB only, right?

I do have a problem that might make this more complicated.

I'm considering if we can enable packing in load_balance by using feec().
Limiting the search space to only idle CPUs causes problems. And these problems
relate to both performance and power.

For example, If a small task is running on a big CPU, it will prevent big-ish
tasks from migrating there on load balance if the only idle cpu is a little
one.

And if a small task moves to a big cpu on load balance because it's the only
idle one, it could take the cluster out of deep sleep while it could have
easily crammed on a little core.

I can't say I've debugged these problems. But we do get lots of issues related
to big cpus waking up unnecessarily (it could be per-cpu tasks too); and task
not migrating fast enough.

I think the load balance behavior of going with idle cpus first is
contributing. I hope to dig more into this problem in the near future.

Can we consider these problems along the way too?

> They both try to find the cpu with highest capacity that will fit the
> task requirement

find the *idl* cpu with highest capacity, right? IIUC, we try to find idle cpu
then use load if all is busy? Sorry I don't have enough of the load balance
code in my head yet..

> 
> >
> > To be honest, I personally think EAS can be useful on SMP systems and it would
> > be nice to enable it outside of sched_asym_cpucapacity.
> 
> or even before that task_fits_cpu should probably be useful for some smp case

I think that should we doable even with the current approach if inversion
detection is not actually the problem and just the way we do it.

I chose the current approach because it seemed the simpler to me. I can do
something in the topology code to help make the inversion detection much easier
and more generic. But I'll hold on a bit in case you have a thought on another
way to tackle the problem.

We do have actually a similar problem for RT that I need to tackle too. So
maybe moving it to topology will help both CFS and RT.

> 
> >
> > I'm interested to hear more about this unification idea actually. If you feel
> > a bit chatty to describe in more detail how do you see this being unified, that
> > could be enlightening for some of us who work in this area :-)
> 
> First, keep everything scalable and don't loop on all cpufreq policy
> or anything else that can't scale so we don't have to take care of the
> number of cpu of cpufreq policy in the system
> Then, I think that a good starting point would be to merge the

If your issue just with that, and not inversion detection in particular,
I think I can find an alternative approach. Though for education purposes I'd
like to make sure to understand how/when this scalability problem manifests.

> behavior of SD_ASYM_CPUCAPACITY and SD_ASYM_PACKING instead of 2
> parallel and similar behaviors

To be clear, you mean load balance path right? If yes, then I'd like us to
consider how we can cater for some of the potential issues I mentioned above.

> The misfit task could also be unified to integrate other things than
> EAS like the IPC that ricardo is working one. I haven't look in
> details how this could be doable

To make things more complicated, to increase the effectiveness of uclamp_max,
we need a 'reverse misfit' behavior (terminology credit to Morten).

If a busy long running task has its uclamp_max changed such that we can put it
on a more energy efficient core, we want to extend misfit to handle down
migrations too. We relied on tasks going to sleep and feec() automatically
doing the right thing next wake up. With uclamp_max the next wake up might not
happen for a while.


Thanks!!

--
Qais Yousef
