Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64BC6486BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiLIQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLIQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:47:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E995F5D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:47:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w15so5759373wrl.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 08:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=avJVqvnujLhnDBG8ZQBmYub0p+CTkKVwDEu5Ug3pISs=;
        b=NdqssR8b2v/1+D2/wUtGmaVzYbNYBxcE1Ms8U2zG3O3NCvLbYF1yPodiT16RX6yZYI
         JYJ+Rt3lkU0ubFuIj9ilu7/Y4lIk+0wn7hGsqnBrRLHIASXO1T3yfLuS/sFUfFJe6ZzO
         bfTV0B6lwWgKbLFh7qtcEsQgT1Xg3rwS49lLz9fxO+qppXqWOLZl3Y1Zh9SyN3tgXXz3
         rBgy+4Qce66/ak5hGD6KD2o/pP4q2UxwdrpyIIh3ivLKmeq3c1hlrCTXdrKBGns1MwTx
         jSKskxLFJOladCFg6bche9MSUTg9i3OKbFf8ZDL5AuhaddhJdA4vpxm9DIcQblfLbo4H
         iy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avJVqvnujLhnDBG8ZQBmYub0p+CTkKVwDEu5Ug3pISs=;
        b=1JtWsLm5OeASA8BvxFlmWl4+SBvzSNIzl+HBU16PoA2IEWf56MhRLUkNCQCtV7UDAH
         TopAo4s1g5I/Dcd0vBEmVh4UFdX2qWDrO220dfVrdG3dx0YmBf0n5QdFtW1KFd623aAI
         tHdmlsheBWlpZw7CAMi/7Po4R2/NnGoEk8KfoXUVqyAQ3TtdUU+sx+mN0BT4Hw+uWNJf
         Soz601/E/CO8jcWm7ENgrBIcfw8B9+myFUAnBLRwGsOVhu4IDSD6Qmp3VLOdhKjL6djw
         AXkBuxgknF7arLxmY6QZP+pW3Bh9yQSyYRoP43PnumDD/k7qCnZkIG1ESMRwvLqtMdQs
         3YMQ==
X-Gm-Message-State: ANoB5pkZuzJgDHV8OUkttwjR8LLIBLxfhcYzpbM3H4+4kVYkNlpYM9Cm
        eLUrNTBZwMOW2cqb6BBQefhAqg==
X-Google-Smtp-Source: AA0mqf617eA13ZVoj41alXoms3DVLuSo+josS2z4MLMe69t74rQ55/8N+yS201sUWVdY55XNwSEA9w==
X-Received: by 2002:adf:e544:0:b0:242:5469:55dd with SMTP id z4-20020adfe544000000b00242546955ddmr4364864wrm.36.1670604462707;
        Fri, 09 Dec 2022 08:47:42 -0800 (PST)
Received: from vingu-book (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d5112000000b0024207478de3sm1764206wrt.93.2022.12.09.08.47.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Dec 2022 08:47:41 -0800 (PST)
Date:   Fri, 9 Dec 2022 17:47:40 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Qais Yousef <qyousef@layalina.io>
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
Message-ID: <20221209164739.GA24368@vingu-book>
References: <20221127141742.1644023-1-qyousef@layalina.io>
 <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu>
 <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu>
 <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
 <20221208140526.vvmjxlz6akgqyoma@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221208140526.vvmjxlz6akgqyoma@airbuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 08 déc. 2022 à 14:05:26 (+0000), Qais Yousef a écrit :
> On 12/06/22 19:12, Vincent Guittot wrote:
> > On Mon, 5 Dec 2022 at 12:02, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 12/04/22 12:35, Vincent Guittot wrote:
> > > > On Sat, 3 Dec 2022 at 15:33, Qais Yousef <qyousef@layalina.io> wrote:
> > > > >
> > > > > On 12/02/22 15:57, Vincent Guittot wrote:
> > > > >
> > > > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > > > > index 7c0dd57e562a..4bbbca85134b 100644
> > > > > > > --- a/kernel/sched/fair.c
> > > > > > > +++ b/kernel/sched/fair.c
> > > > > > > @@ -8856,23 +8856,20 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> > > > > > >          *   * Thermal pressure will impact all cpus in this perf domain
> > > > > > >          *     equally.
> > > > > > >          */
> > > > > > > -       if (sched_energy_enabled()) {
> > > > > > > +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> > > > > > >                 unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> > > > > > > -               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> > > > > > > +               struct cpufreq_policy *policy, __maybe_unused *policy_n;
> > > > > > >
> > > > > > >                 rq->cpu_capacity_inverted = 0;
> > > > > > >
> > > > > > > -               SCHED_WARN_ON(!rcu_read_lock_held());
> > > > > > > -
> > > > > > > -               for (; pd; pd = pd->next) {
> > > > > > > -                       struct cpumask *pd_span = perf_domain_span(pd);
> > > > > > > +               for_each_active_policy_safe(policy, policy_n) {
> > > > > >
> > > > > > So you are looping all cpufreq policy (and before the perf domain) in
> > > > > > the period load balance. That' really not something we should or want
> > > > > > to do
> > > > >
> > > > > Why is it not acceptable in the period load balance but acceptable in the hot
> > > > > wake up path in feec()? What's the difference?
> > > >
> > > > This patch loops on all cpufreq policy in sched softirq, how can this
> > > > be sane ? and not only in eas mode but also in the default asymmetric
> > >
> > > Hmm I'm still puzzled. Why it's not sane to do it here but it's okay to do it
> > > in the wake up path in feec()?
> > 
> > feec() should be considered as an exception not as the default rule.
> > Thing like above which loops for_each on external subsystem should be
> > prevented and the fact that feec loops all PDs doesn't means that we
> > can put that everywhere else
> 
> Fair enough. But really understanding the root cause behind this limitation
> will be very helpful. I don't have the same appreciation of why this is
> a problem, and shedding more light will help me to think more about it in the
> future.
> 

Take the example of 1k cores with per cpu policy. Do you really think a
for_each_cpufreq_policy would be reasonable ?

> I have a pinebook pro that contains 4 littles and 2 bigs. What kind of
> experiment I can run to see the impact of a large loop here? Is trying with 32
> or even 64 policies good? What type of workloads to try this with?
> 
> > 
> > >
> > > AFAICT the number of cpufreq policies and perf domains have 1:1 mapping. In
> > > feec() we not only loop perf domains, but we go through each cpu of each domain
> > > to find max_spare_cap then compute_energy(). Which is more intensive.
> > >
> > > In worst case scenario where there's a perf domain for each cpu, then we'll
> > > loop through every CPU *and* compute energy its energy cost in the wake up
> > > path.
> > >
> > > Why it's deemed acceptable in wake up path which is more critical AFAIU but not
> > > period load balance which is expected to do more work? What am I missing?
> > 
> > Things like util_fits_cpu is not an EAS only feature although it's the
> > only user for now and this must remain usable by another part of the
> > scheduler that wants to check if a workload can fit on a cpu if
> > needed. But adding not scalable behavior makes it not usable by
> > default for anything else than Android big.LITTLE with 8 CPUs and 2/3
> > PDs.
> 
> To be honest I don't see the scalability problem, and that's the problem :-)
> 
> As I said before; I'm not against moving to something else. I didn't think
> scalability is a problem even outside 8 CPUs and 2/3 PDs.
> 
> > 
> > As a summary the rule is to be scalable and don't assume that a
> > for_each loop on another framework can be reasonable thus the above is
> > not.
> > 
> > The fact that feec is not scalable and assumes that a system will not
> > have more than 8 cores and 2/3 PDs is a problem IMO because it
> > prevents other systems from even considering using it.
> > 
> > Also as mentioned before, the above will be called as soon as
> > sched_asym_cpucapacity is enabled even if eas and feec() is not used
> > so you extend the problem outside feec().
> 
> I am even more curious now to understand where we hit a limit.
> 
> The only assumption I'm maybe making here; and I think is inherit in these
> type of systems, is that if your hardware is HMP, then power is concern for you
> and not only performance.

You are also putting a limit in the number of cores and cpufreq policy

> 
> That said; as I mentioned in my previous reply; I did suggest an alternative
> and happy to consider something else. I think I can do something in topology to
> help us making an easier decision here without making both sides ugly. It just
> seemed unnecessary at the time given the simplicity of this approach.
> 
> > 
> > >
> > > > performance  one.
> > > >
> > > > This inverted detection doesn't look like the right way to fix your
> > > > problem IMO. That being said, i agree that I haven't made any other
> > > > proposal apart that I think that you should use a different rules for
> > > > task and for overutilized and part of your problem comes from this.
> > >
> > > We discussed this before; I need to revisit the thread but I can't see how
> > > overutilized different than task will fix the issue. They should be unified by
> > > design.
> > 
> > A unified design doesn't mean one function especially if that includes
> > to loop for_each_active_policy_safe() in sched softirq
> 
> This only makes sense to me if you refer to death by thousand cuts kind of
> problem. I can't see how this on its own being a problem.. I'll run some tests
> to convince myself.

That's exactly the point, the scheduler tries hard to not add any system size
related limitation like: it's fine because it's only for 8 cores system.
I don't want to lock up the uclamp/util_fits_cpu in such limitations so you
can't use for_each_cpufreq or anything similar at runtime in sched softirq

> 
> > 
> > uclamp_min should not be used to set an over utilized cpu  because it
> 
> uclamp_min must set overutilized. If a long running task has its uclamp_min
> changed, we want to upmigrate it if that's necessary to meet the new demand.

I think that you are too much focused on your 8 cores android system.

uclamp_min must not set a CPU overutilized because the CPU is not overutilized
in this case. It's only the task that is misfit. You mostly try to bias some
behavior to fit your use case.

> 
> Keep in mind in android tasks could move between top-app, foreground and
> background groups.
> 
> And keep in mind Android now implement a framework to dynamically change
> uclamp. It's available from Android 12 as part of Android Dynamic Performance
> Framework (ADPF). It's under CPU Hints.
> 
> 	https://developer.android.com/games/optimize/adpf
> 

I have never put any kind of limitation of the task or system behavior

> > doesn means that the cpu is overutilized and uclamp_max should be used
> 
> It is a misfit task; which requires overutilized to be set to re-enable load
> balance for uclamp_min to upgrate it. For uclamp max we should not set
> overutilized, agreed and that's what we should be doing.

That's probably the root of your problem here. The load balance is still
periodically called even when EAS is enabled but the latter prevents task
migration unless overutilized in order to not break the energy aware task
placement. But if a task is misplaced and a cpu finds it can help,
we should let it pull the task without disabling EAS. This will not enable the
performance spread behavior and we can expect the other small tasks to be
packed by EAS on the best cpu at next wakeup.

So intead of trying to detect a very specific capacity inversion use case
during this periodic this load balance, it's better to let a CPU that can
fix the misfit situation to pull the task.

See below

> 
> > for not setting overutilized a cpu with a clamped max value
> > 
> > >
> > > I'm all ears if there's a simpler way to address the problem :-)
> > 
> > let me try to prepare a something to show what I mean
> 
> A PoC just to help me see what you mean would be great, thanks!
> 

I have reverted patches:
Revert "sched/fair: Detect capacity inversion"
Revert "sched/fair: Consider capacity inversion in util_fits_cpu()"
Revert "sched/uclamp: Make cpu_overutilized() use util_fits_cpu()"

---
 kernel/sched/fair.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4423681baf15..6e54afc0a6ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4539,7 +4539,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 * the time.
 	 */
 	capacity_orig = capacity_orig_of(cpu);
-	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
+	capacity_orig_thermal = capacity_orig - thermal_load_avg(cpu_rq(cpu));

 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -4578,8 +4578,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 *     2. The system is being saturated when we're operating near
 	 *        max capacity, it doesn't make sense to block overutilized.
 	 */
-	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
-	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
+	uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
 	fits = fits || uclamp_max_fits;

 	/*
@@ -4614,7 +4613,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
+	if (util < uclamp_min)
 		fits = fits && (uclamp_min <= capacity_orig_thermal);

 	return fits;
@@ -6064,7 +6063,10 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
+	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
+
+	return !(fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu)) ||
+		 rq_util_max <= capacity_orig_of(cpu));
 }

 static inline void update_overutilized_status(struct rq *rq)
@@ -10164,24 +10166,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	 */
 	update_sd_lb_stats(env, &sds);

-	if (sched_energy_enabled()) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
-			goto out_balanced;
-	}
-
-	local = &sds.local_stat;
-	busiest = &sds.busiest_stat;
-
 	/* There is no busy sibling group to pull tasks from */
 	if (!sds.busiest)
 		goto out_balanced;

+	busiest = &sds.busiest_stat;
+
 	/* Misfit tasks should be dealt with regardless of the avg load */
 	if (busiest->group_type == group_misfit_task)
 		goto force_balance;

+	if (sched_energy_enabled()) {
+		struct root_domain *rd = env->dst_rq->rd;
+
+		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
+			goto out_balanced;
+	}
+
 	/* ASYM feature bypasses nice load balance check */
 	if (busiest->group_type == group_asym_packing)
 		goto force_balance;
@@ -10194,6 +10195,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (busiest->group_type == group_imbalanced)
 		goto force_balance;

+	local = &sds.local_stat;
 	/*
 	 * If the local group is busier than the selected busiest group
 	 * don't try and pull any tasks.
--
2.17.1

There are probably some other changes to do here and here like check_misfit_status
but this enable another cpu with more capacity to pull a misfit task without
disabling EAS.

> > 
> > >
> > > The problem is that thermal pressure on big cpu is not important from
> > > uclamp perspective until it is in inversion state. It is quite common to have
> > > a system where the medium capacity is in 500 range. If the big is under thermal
> > > pressure that it drops to 800, then it is still a fitting CPU from uclamp
> > > perspective. Keep in mind uclamp_min is useful for tasks whose utilization is
> > > small So we need to be selective when thermal pressure is actually helping out
> > > or just creating unnecessary problems.
> > 
> > What about medium cores ?  There are often 3 capacity levels now so
> > the same can happen between medium and little.
> 
> We do subtract thermal pressure from capacity for the mediums and littles all
> the time. So that case is handled, no?

you don't need iversion detection for medium vs little ? Why it's acceptable here
and not between bg vs medium

>>
> 
> > 
> > Also we have more and more thermal capping happening ahead of
> > overheating like the power cap interface where we want to cap some
> > CPUs and others even before they reach their thermal limit in order to
> > get more power/thermal room for others. This implies that some CPUs
> > could be under thermal pressure whereas others not. This implies also
> > that a UC with big core capacity being below little and medium cores
> > is not impossible or medium being under little but big staying at high
> > capacity.
> 
> I *think* I am catering for this already. The big is special because it's the
> highest level, so thermal pressure; from uclamp perspective, is not meaningful
> as it's the best you can ever get on this system; untill it becomes capacity
> inverted that is.
> 

That's another point that concerns me, you put some special condition on big
cores to be able to detect an possible inversion.
If a task deosn't fit a cpu because of thermal pressure, it should be tagged misfit
and let other cpu looks if they can do better. That's doesnt mean that we
will find one.

> Getting this not to break easily is really important for the successful
> adoption of this hint.
> 
> > 
> > >
> > > The only other option I had in mind was to do the detection when we update the
> > > thermal_pressure in the topology code. But that didn't look better alternative
> > > to me.
> > >
> > > >
> > > > Then this make eas and util_fits_cpu even more Arm specific and I
> > >
> > > What is the Arm specific part about it? Why it wouldn't work on non-Arm
> > > systems?
> > 
> > Because it assume that for_each_cpufreq loop in not a problem mostly
> > because there will be no more than 3 CPUs and 2/3 PDs (ie Arm based
> > Android smartphone) and as a result, it's acceptable to loop
> > everything everytime
> 
> I did not make this assumption. I genuinely thought (and still think to be
> honest) that it's not a scalability issue. But of course I appreciate your
> knowledge and experience when you say you think this can be a problem.
> 
> I only experienced the issue of too many cgroups causing newidle_cpu() to take
> a long time; if you remember that issue we had with Joel.
> 
> If any assumptions I made here it is that someone creating HMP systems it is
> not for a massive server market where we can have 100s of cores. I probably
> have assumed HMP = average consumer market that wants power efficient devices
> and if we go crazy we can go to 32 cpus or something. Which I didn't think will
> be a problem even if each cpus has its own PD.
> 
> > 
> > >
> > > > still hope to merge sched_asym_cpucapacity and asym_packing a some
> > > > levels because they looks  more and more similar but each side is
> > > > trying to add some SoC specific policy
> > >
> > > Oh, it seems Intel relies on asym_packing for their hybrid support approach?
> > > I think sched_asym_cpucapacity was designed to be generic. If I gathered
> > > correctly lack of support for SMT and inability to provide energy model outside
> > > of DT were some required extensions.
> > 
> > At least merging asym_packing and sched_asym_cpucapacity would be a
> > good starting point even if we don't consider using feec() in the 1st
> > step.
> > 
> > When we have things like below in the code in find_busiest_queue(), it
> > probably means that we have duplicated behavior :
> > 
> > if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> >     !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
> >     nr_running == 1)
> > continue;
> > 
> > /* Make sure we only pull tasks from a CPU of lower priority */
> > if ((env->sd->flags & SD_ASYM_PACKING) &&
> >     sched_asym_prefer(i, env->dst_cpu) &&
> >     nr_running == 1)
> > continue;
> 
> I see.
> 
> Just to make sure, this is only used in LB only, right?

Yes, although I haven't check the IPC patchset

> 
> I do have a problem that might make this more complicated.
> 
> I'm considering if we can enable packing in load_balance by using feec().
> Limiting the search space to only idle CPUs causes problems. And these problems
> relate to both performance and power.
> 
> For example, If a small task is running on a big CPU, it will prevent big-ish
> tasks from migrating there on load balance if the only idle cpu is a little
> one.
> 
> And if a small task moves to a big cpu on load balance because it's the only
> idle one, it could take the cluster out of deep sleep while it could have

Maybe your root problem is that the small task migrates on a big cpu only
because it's the only idle one and not because of utilization (uclamp_min/max
included)

> easily crammed on a little core.
> 
> I can't say I've debugged these problems. But we do get lots of issues related
> to big cpus waking up unnecessarily (it could be per-cpu tasks too); and task
> not migrating fast enough.
> 
> I think the load balance behavior of going with idle cpus first is
> contributing. I hope to dig more into this problem in the near future.

the load balance is not going with idle cpu 1st, the load balance happens on
all cpus but the period of busy cpus is higher to not impact much the running
load whereas idle cpus don't have anything else to do except lokking for work
to pull and saving power

> 
> Can we consider these problems along the way too?
> 
> > They both try to find the cpu with highest capacity that will fit the
> > task requirement
> 
> find the *idl* cpu with highest capacity, right? IIUC, we try to find idle cpu
> then use load if all is busy? Sorry I don't have enough of the load balance
> code in my head yet..
> 
> > 
> > >
> > > To be honest, I personally think EAS can be useful on SMP systems and it would
> > > be nice to enable it outside of sched_asym_cpucapacity.
> > 
> > or even before that task_fits_cpu should probably be useful for some smp case
> 
> I think that should we doable even with the current approach if inversion
> detection is not actually the problem and just the way we do it.
> 
> I chose the current approach because it seemed the simpler to me. I can do
> something in the topology code to help make the inversion detection much easier
> and more generic. But I'll hold on a bit in case you have a thought on another
> way to tackle the problem.
> 
> We do have actually a similar problem for RT that I need to tackle too. So
> maybe moving it to topology will help both CFS and RT.
> 
> > 
> > >
> > > I'm interested to hear more about this unification idea actually. If you feel
> > > a bit chatty to describe in more detail how do you see this being unified, that
> > > could be enlightening for some of us who work in this area :-)
> > 
> > First, keep everything scalable and don't loop on all cpufreq policy
> > or anything else that can't scale so we don't have to take care of the
> > number of cpu of cpufreq policy in the system
> > Then, I think that a good starting point would be to merge the
> 
> If your issue just with that, and not inversion detection in particular,

Looping on all cpufreq policies is the main problem but i also think that capacity
inversion is specific to your system and can be replaced by a generic solution
that will not make any assumption on any CPUs big vs little or 
shared vs per cpu dvfs


> I think I can find an alternative approach. Though for education purposes I'd
> like to make sure to understand how/when this scalability problem manifests.
> 
> > behavior of SD_ASYM_CPUCAPACITY and SD_ASYM_PACKING instead of 2
> > parallel and similar behaviors
> 
> To be clear, you mean load balance path right? If yes, then I'd like us to
> consider how we can cater for some of the potential issues I mentioned above.
> 
> > The misfit task could also be unified to integrate other things than
> > EAS like the IPC that ricardo is working one. I haven't look in
> > details how this could be doable
> 
> To make things more complicated, to increase the effectiveness of uclamp_max,
> we need a 'reverse misfit' behavior (terminology credit to Morten).
> 
> If a busy long running task has its uclamp_max changed such that we can put it
> on a more energy efficient core, we want to extend misfit to handle down
> migrations too. We relied on tasks going to sleep and feec() automatically
> doing the right thing next wake up. With uclamp_max the next wake up might not
> happen for a while.
> 
> 
> Thanks!!
> 
> --
> Qais Yousef
