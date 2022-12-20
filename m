Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035136521BD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiLTNuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLTNum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:50:42 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773CF1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:50:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h11so11746724wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqH32xsStn0G9na+VdZpZcWtzxpsMVkQAQ6inAnrBJE=;
        b=tvBMplrAiR0vQZHV4Ai26CRfc7dsJTvgurar8PSfgVcou0YCuZXgqtzjKXPnQeqiWj
         1vNSgZoh5H9ZxSEYXnPLFZobHacmyF0nnsFNJA5HdYnplbyKbJ8JS9Yedpi9blv/vAZN
         afs0XUy2wt7LYLN2pur81ttXTOvUL59182L0bPGHo2sMwTdeZ683imOdMP6s8xrxnGSx
         9GrzCMTcm4qFxzb04hVCt8tVHlYEHkjM1zNtlVRosjpvY33T7GDNkVNaff6+bbqbGyhM
         gz42Gj8ZvNPo9Thkg5sCpIx+5MktglhlcUK0uCctJZQWDXWrG73culr4KXOBFBC3hSl0
         dN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqH32xsStn0G9na+VdZpZcWtzxpsMVkQAQ6inAnrBJE=;
        b=SzFV4VgMBJOQQh/KKarKTNMvGUARvMYVPN0bxZiOPlgAz8D894ZTtPKnz4mI2bJdFT
         jByLNVZ7j/Dja6u5lso04QloTPPaRBbH7FzjLrkOv0oLmFOX6EGEVQn9itaGa3hslH8M
         QTTDfRgDTRDs42ktTNRhblvybCtiZbgQQm/zPJhxz+/ZWi3QdEl1ag7bBH5Na7nhPv+6
         ehTg+FIgz+PqKZZPI2uLdHUp1JJjqKyKRSe0pD8XR1ZqA41dR8ENP7hDRCjzlchFfVsU
         i1QHqnZj8NXkT9ou/w089lDbLg4ZsQQL1mLNkcAvJjfWJSOFRHlsFr1HvMx6CopU2x+F
         ffmA==
X-Gm-Message-State: AFqh2kov62PwgWnqrx4DKajiLFeiy4m2Xp+DrxW36II5aVrI3HW6w8A0
        ilF3FK/1s8oqdSnbBRkATO9iRA==
X-Google-Smtp-Source: AMrXdXt2ctmgHLNX7d7YnF70l0l3JEKiJ+pODJaww4+6k9NypcmIZEdpjMYRVr1gwnoP8BqaTXWiTw==
X-Received: by 2002:adf:fd88:0:b0:242:18c5:7899 with SMTP id d8-20020adffd88000000b0024218c57899mr1369399wrr.61.1671544237446;
        Tue, 20 Dec 2022 05:50:37 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:6da8:89b4:610c:3ed5])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d4412000000b00235da296623sm12887956wrq.31.2022.12.20.05.50.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Dec 2022 05:50:36 -0800 (PST)
Date:   Tue, 20 Dec 2022 14:50:34 +0100
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
Message-ID: <20221220135034.GA12359@vingu-book>
References: <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu>
 <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu>
 <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
 <20221208140526.vvmjxlz6akgqyoma@airbuntu>
 <20221209164739.GA24368@vingu-book>
 <20221212184317.sntxy3h6k44oz4mo@airbuntu>
 <CAKfTPtBX0ugM87CEjAXUbVhnTZTwAAnjXu2fRfc6ezHE8=aC6w@mail.gmail.com>
 <20221220123254.to6tzznxloxq725q@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221220123254.to6tzznxloxq725q@airbuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 20 déc. 2022 à 12:32:54 (+0000), Qais Yousef a écrit :
> On 12/15/22 18:39, Vincent Guittot wrote:
> > On Mon, 12 Dec 2022 at 19:43, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 12/09/22 17:47, Vincent Guittot wrote:
> > >
> > > [...]
> > >
> > > > > > > > This patch loops on all cpufreq policy in sched softirq, how can this
> > > > > > > > be sane ? and not only in eas mode but also in the default asymmetric
> > > > > > >
> > > > > > > Hmm I'm still puzzled. Why it's not sane to do it here but it's okay to do it
> > > > > > > in the wake up path in feec()?
> > > > > >
> > > > > > feec() should be considered as an exception not as the default rule.
> > > > > > Thing like above which loops for_each on external subsystem should be
> > > > > > prevented and the fact that feec loops all PDs doesn't means that we
> > > > > > can put that everywhere else
> > > > >
> > > > > Fair enough. But really understanding the root cause behind this limitation
> > > > > will be very helpful. I don't have the same appreciation of why this is
> > > > > a problem, and shedding more light will help me to think more about it in the
> > > > > future.
> > > > >
> > > >
> > > > Take the example of 1k cores with per cpu policy. Do you really think a
> > > > for_each_cpufreq_policy would be reasonable ?
> > >
> > > Hmm I don't think such an HMP system makes sense to ever exist.
> > >
> > > That system has to be a multi-socket system and I doubt inversion detection is
> > > something of value.
> > >
> > > Point taken anyway. Let's find another way to do this.
> > >
> > > [...]
> > >
> > > > > This only makes sense to me if you refer to death by thousand cuts kind of
> > > > > problem. I can't see how this on its own being a problem.. I'll run some tests
> > > > > to convince myself.
> > > >
> > > > That's exactly the point, the scheduler tries hard to not add any system size
> > > > related limitation like: it's fine because it's only for 8 cores system.
> > > > I don't want to lock up the uclamp/util_fits_cpu in such limitations so you
> > > > can't use for_each_cpufreq or anything similar at runtime in sched softirq
> > >
> > > I'm happy to make things more generic so more users can benefit :-)
> > >
> > > >
> > > > >
> > > > > >
> > > > > > uclamp_min should not be used to set an over utilized cpu  because it
> > > > >
> > > > > uclamp_min must set overutilized. If a long running task has its uclamp_min
> > > > > changed, we want to upmigrate it if that's necessary to meet the new demand.
> > > >
> > > > I think that you are too much focused on your 8 cores android system.
> > >
> > > I am not; you're making an assumption here :-)
> > >
> > > HMP systems for 1k servers just don't make any sense. A desktop with 128 or
> > > even 256 HMP cores is a big stretch; and if that exist I don't think there's an
> > > overhead to worry about here; and I *did* consider this. I measured the impact
> > > if we have 128 and it was mere 1 or 2 us extra.  And that's on under powered
> > > pine book pro. If such a system exist it'd probably be more performant.
> > >
> > > > uclamp_min must not set a CPU overutilized because the CPU is not overutilized
> > > > in this case. It's only the task that is misfit. You mostly try to bias some
> > > > behavior to fit your use case.
> > >
> > > Maybe we are talking about different things over here. As long as we agree it's
> > > a misfit task then we are aligned.
> > >
> > > As far as I know misfit required overutilized to re-enable load balance. But
> > > maybe there's a detail that's creating this confusion.
> > 
> > The current implementation uses overutilized to fix misfit task
> > placement because it was assumed that misfit task also means that the
> > cpu is overutilized as only the utilization was used but It's not
> > mandatory as proposed below and there is no direct relation anymore
> > with uclamp_min
> 
> Okay. As we discussed offline - this is independent improvement to decouple
> misfit load balance from overutilized. And I agree it's a good thing to have
> and will mean that uclamp_min will no longer have to raise overutilized too,
> which is the right thing to do indeed.
> 
> > 
> > >
> > > >
> > > > >
> > > > > Keep in mind in android tasks could move between top-app, foreground and
> > > > > background groups.
> > > > >
> > > > > And keep in mind Android now implement a framework to dynamically change
> > > > > uclamp. It's available from Android 12 as part of Android Dynamic Performance
> > > > > Framework (ADPF). It's under CPU Hints.
> > > > >
> > > > >     https://developer.android.com/games/optimize/adpf
> > > > >
> > > >
> > > > I have never put any kind of limitation of the task or system behavior
> > >
> > > Nope you didn't. I was just trying to highlight some additional problems we're
> > > seeing that we'd need to consider :-)
> > 
> > I don't see any additional problem TBH.
> 
> Okay. I'll raise these issues in another venue/time.
> 
> > 
> > >
> > > >
> > > > > > doesn means that the cpu is overutilized and uclamp_max should be used
> > > > >
> > > > > It is a misfit task; which requires overutilized to be set to re-enable load
> > > > > balance for uclamp_min to upgrate it. For uclamp max we should not set
> > > > > overutilized, agreed and that's what we should be doing.
> > > >
> > > > That's probably the root of your problem here. The load balance is still
> > > > periodically called even when EAS is enabled but the latter prevents task
> > > > migration unless overutilized in order to not break the energy aware task
> > >
> > > Okay. For me this means load_balance is disabled since it's effectively doing
> > > nothing. So maybe it's a terminology problem of what I meant with load balance
> > > is disabled.
> > 
> > This is not doing nothing and your patch is using load_balance to
> > detect inversion as an example
> > 
> > >
> > > > placement. But if a task is misplaced and a cpu finds it can help,
> > > > we should let it pull the task without disabling EAS. This will not enable the
> > > > performance spread behavior and we can expect the other small tasks to be
> > > > packed by EAS on the best cpu at next wakeup.
> > > >
> > > > So intead of trying to detect a very specific capacity inversion use case
> > > > during this periodic this load balance, it's better to let a CPU that can
> > > > fix the misfit situation to pull the task.
> > >
> > > I can't see the relation here.
> > >
> > > Capacity inversion is required NOT in load balance. In every place will look
> > 
> > You are using periodic load_balance to detect capacity inversion:
> > update_cpu_capacity() is called during periodic load_balance. Instead
> > of detecting capacity inversion, use load_balance to pull a misfit
> > task.
> > Either there is a cpu on which the task can fit better and it will
> > pull it or there is no better place and it will not
> > 
> > > for a fitting CPU; we need to ensure hints to place the task on big cpu works
> > > even under thermal pressure.
> > >
> > > If uclamp_min = 1024, but big core has 5% thermal pressure, it should still fit
> > > there. And feec() a long with all other callers should respect that too.
> > 
> > That's probably where I disagree, task should probably stay on this
> > cpu because there is no better option (ie cpu with higher compute
> > capacity) but the task doesn't fit on the cpu because its capacity is
> > below uclamp_min. You might think that I niptick there but that makes
> > a difference in the way to handle the situation.
> 
> Hmm. When we spoke offline I thought we agree on this point..
> 
> > 
> > >
> > > How better overutilized detection helps here? EAS needs to consider this as
> > > a candidate CPU and place it there at wake up.
> > 
> > If uclamp_min = 1024, but big core has 5% thermal pressure, big cpu
> > doesn't fit, otherwise uclamp_min is meaningless. But it can still
> > remain the best choice and feec should select it.
> 
> .. okay so we agree that we should still select it.

yes, never said something else

> 
> As we agreed offline I'll refactor the code so that util_fits_cpu() returns
> multiple reasons to help feec() and select_idle_capacity() and other call sites
> make better decision. ie: make feec() have a fallback CPU for the next best fit
> under thermal pressure cases so if there's no CPU truly fits we can fallback to
> the next best thing - which should mimic what we do in capacity inversion but
> should be more generic.
> 
> I have to say, I still prefer the current approach as it keeps the logic
> encapsulated in util_fits_cpu() and leads to the similar results. I am worried
> about spilling the details out to users now - something I tried hard to avoid.
> I'll trust your judgement call here though. I'll post patches as soon as
> they're ready :-).
> 
> > > I need time to digest this. But so far I see this is still irrelevant as the
> > > problem with the definition of what *fits* a CPU and what doesn't.
> > >
> > > On a system where:
> > >
> > >         LITTLE=160, MEDIUM=480, BIG=1024
> > >
> > > A task
> > >
> > >         p->util_avg = 200
> > >         p->util_min = 1024
> > >
> > > Should always be placed on a big core unless the big core is capacity inverted.
> > > That means most importantly in feec().
> > >
> > > How does the above fix that?
> > 
> > Not differently than if BIG is under thermal pressure and its capacity
> > goes below 480. In this case, MEDIUM is the best CPU and should be
> > selected. Note that the task still doesn't fit on any cpu but neither
> > BIG nor MEDIUM are over utilized and there is no need to disable EAS
> > and spread the tasks everywhere. feec() and select_idle_capacity()
> > should take care of this case and as a result of yours. I don't see
> > any difference in the way both cases should be handled whereas
> > capacity inversion makes a difference.
> 
> I was relying here that select_idle_capacity() will actually do the right thing
> and pick the highest spare capacity CPU. And maybe I have the wrong threshold
> here for 'this is a disaster anyway' - I just thought if big gets that badly
> throttled; there are bigger issues to worry about. I need to raise my bar! :-P
> 
> 
> > >
> > > Because it's the highest level. You have no option to do better. uclamp_min is
> > > a hint; if the util_avg is small (ie: it still fits_capacity()); best effort is
> > > to keep giving the task the performance it needs. While on a big core; you
> > > can't upmigrate to any other level; so thermal pressure on big core is
> > > meaningless until it is in capacity inversion.
> > 
> > >
> > > If the user asks for something and finds that their task is placed randomly
> > > that's not good, no?
> > 
> > nobody says to place the task randomly.
> 
> With the new proposal to make util_fits_cpu() return multiple reason, yes.
> Previously I understood to just subtract thermal pressure blindly all the time
> - which will lead to non desirable behavior that will confuse userspace that
> uses uclamp. I think the task placement part of uclamp is important even if we
> sometimes fail to get the right frequency due to thermal pressure - which is
> invisible to userspace and I don't want them to worry about these details when
> setting uclamp values.
> 
> > 
> > >
> > > What you say makes sense against util_avg; the rule of which is still the same
> > > as before.
> > >
> > > >
> > > > >>
> > > > >
> > > > > >
> > > > > > Also we have more and more thermal capping happening ahead of
> > > > > > overheating like the power cap interface where we want to cap some
> > > > > > CPUs and others even before they reach their thermal limit in order to
> > > > > > get more power/thermal room for others. This implies that some CPUs
> > > > > > could be under thermal pressure whereas others not. This implies also
> > > > > > that a UC with big core capacity being below little and medium cores
> > > > > > is not impossible or medium being under little but big staying at high
> > > > > > capacity.
> > > > >
> > > > > I *think* I am catering for this already. The big is special because it's the
> > > > > highest level, so thermal pressure; from uclamp perspective, is not meaningful
> > > > > as it's the best you can ever get on this system; untill it becomes capacity
> > > > > inverted that is.
> > > > >
> > > >
> > > > That's another point that concerns me, you put some special condition on big
> > > > cores to be able to detect an possible inversion.
> > > > If a task deosn't fit a cpu because of thermal pressure, it should be tagged misfit
> > > > and let other cpu looks if they can do better. That's doesnt mean that we
> > > > will find one.
> > >
> > > This breaks the usefulness of the hint. What you say means a small task that
> > > wants to run as fast as possible will find itself placed randomly instead
> > 
> > Why randomly ? feec() and others should continue to select the best
> > cpu even if it may not fit util_min constraint, whatever the cpu BIG,
> > MEDIUM or LITTLE
> 
> Without capacity inversion or your new proposal of making util_fits_cpu()
> return multiple reasons; feec() will not find any fitting cpu and we'll end up
> falling back to prev_cpu or an idle cpu in select_task_rq_fair(). Given how
> temporary these thermal pressure on big cores can be; the task will be moving
> between cpus in what appears as random from userspace point of view when
> looking at perfetto traces at least.
> 
> So we can't consider thermal pressure blindly is what I am trying to say.
> I think we see the same thing now. We do have the same problem for RT - which
> I had a patch to do what you're suggesting to do  with util_fits_cpu(). So
> maybe in a sense this will unify the two approaches.

Hereafter is what I came with in order to decouple misfit task with cpu
overutilized. We keep using util_fits_cpu but with 3 values so we can keep
using it with cpu_overutilized but exclude the case of misfit task
because uclmap_min. Also select_idle_capacity() and feec() keep selecting the
big cpu even if it doesn't fit only because of uclamp_min


Subject: [PATCH] sched/fair: unlink misfit task from cpu overutilized

By taking into account uclamp_min, the 1:1 relation between task misfit and
cpu overutilized is no more true as a task with a util_avg of 20as an
example may not fit a 1024 capacity cpu because of a uclamp_min constraint.

Add a new state in util_fits_cpu() to reflect the case that task would fit
a CPU except for the uclamp_min hint which is a bandwidth requriement.

Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
can use this new value to take additional action to select the best cpu
that doesn't match uclamp_min.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 73 ++++++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4423681baf15..705335d6af65 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4578,8 +4578,7 @@ static inline int util_fits_cpu(unsigned long util,
 	 *     2. The system is being saturated when we're operating near
 	 *        max capacity, it doesn't make sense to block overutilized.
 	 */
-	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
-	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
+	uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
 	fits = fits || uclamp_max_fits;
 
 	/*
@@ -4614,8 +4613,8 @@ static inline int util_fits_cpu(unsigned long util,
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
-		fits = fits && (uclamp_min <= capacity_orig_thermal);
+	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
+		return -1;
 
 	return fits;
 }
@@ -4625,7 +4624,7 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
 	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
 	unsigned long util = task_util_est(p);
-	return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
+	return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) == 1);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -6064,7 +6063,10 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
+	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
+	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
+
+	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }
 
 static inline void update_overutilized_status(struct rq *rq)
@@ -6857,6 +6859,7 @@ static int
 select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	unsigned long task_util, util_min, util_max, best_cap = 0;
+	int fits, best_fits = -1;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
@@ -6872,12 +6875,24 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
 			continue;
-		if (util_fits_cpu(task_util, util_min, util_max, cpu))
+
+		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
+
+		/* This cpu fits with all capacity requirements */
+		if (fits > 0)
 			return cpu;
+		/*
+		 * Only the min bandwidth (i.e. uclamp_min) doesn't fit. Look
+		 * for the cpu with highest bandwidth capacity.
+		 */
+		else if (fits < 0)
+			cpu_cap = capacity_of(cpu) - thermal_load_avg(cpu_rq(cpu));
 
-		if (cpu_cap > best_cap) {
+		if ((fits > best_fits) ||
+		    ((fits == best_fits) && (cpu_cap > best_cap))) {
 			best_cap = cpu_cap;
 			best_cpu = cpu;
+			best_fits = fits;
 		}
 	}
 
@@ -6890,7 +6905,7 @@ static inline bool asym_fits_cpu(unsigned long util,
 				 int cpu)
 {
 	if (sched_asym_cpucap_active())
-		return util_fits_cpu(util, util_min, util_max, cpu);
+		return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
 
 	return true;
 }
@@ -7257,6 +7272,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
+	int prev_fits = -1, best_fits = -1;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -7288,10 +7304,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long cpu_cap, cpu_thermal_cap, util;
 		unsigned long cur_delta, max_spare_cap = 0;
 		unsigned long rq_util_min, rq_util_max;
-		unsigned long util_min, util_max;
+		unsigned long util_min = 0, util_max = 1024;
 		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
+		int fits, max_fits = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -7344,7 +7361,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 					util_max = max(rq_util_max, p_util_max);
 				}
 			}
-			if (!util_fits_cpu(util, util_min, util_max, cpu))
+
+			fits = util_fits_cpu(util, util_min, util_max, cpu);
+			if (!fits)
 				continue;
 
 			lsub_positive(&cpu_cap, util);
@@ -7352,7 +7371,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (cpu == prev_cpu) {
 				/* Always use prev_cpu as a candidate. */
 				prev_spare_cap = cpu_cap;
-			} else if (cpu_cap > max_spare_cap) {
+				prev_fits = fits;
+			} else if ((fits > max_fits) ||
+				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -7360,6 +7381,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				 */
 				max_spare_cap = cpu_cap;
 				max_spare_cap_cpu = cpu;
+				max_fits = fits;
 			}
 		}
 
@@ -7389,15 +7411,18 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (cur_delta < base_energy)
 				goto unlock;
 			cur_delta -= base_energy;
-			if (cur_delta < best_delta) {
+			if ((fits > max_fits) ||
+			    ((fits == max_fits) && (cur_delta < best_delta))) {
 				best_delta = cur_delta;
 				best_energy_cpu = max_spare_cap_cpu;
+				best_fits = max_fits;
 			}
 		}
 	}
 	rcu_read_unlock();
 
-	if (best_delta < prev_delta)
+	if ((best_fits > prev_fits) ||
+	    ((best_fits == prev_fits) && (best_delta < prev_delta)))
 		target = best_energy_cpu;
 
 	return target;
@@ -10164,24 +10189,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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
@@ -10194,6 +10218,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (busiest->group_type == group_imbalanced)
 		goto force_balance;
 
+	local = &sds.local_stat;
 	/*
 	 * If the local group is busier than the selected busiest group
 	 * don't try and pull any tasks.
-- 
2.17.1



> 
> 
> Thanks!!
> 
> --
> Qais Yousef
