Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A004652066
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiLTMdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiLTMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:32:59 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A061E95B6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:32:57 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg10so8611246wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkByTijuFYw5EW1OdEQwCXPeXPmMw31zujfA5Jx25io=;
        b=K5CHuloxwAz3F1qxZCERJCfhzA9H/ypO2rms7U38A49UqgDt4EZgaGz97zIenGkU/g
         84VCClVq+DaTMCFM+bjqo9lmysvxtOEfF3OqMCf7AhEY+9crQUqLUaq5zBi/Naf7Ekq8
         baBiBRTBMYZJHDTLjLV7p1boG1geSrn3eD1OK/BRTbcrdAHMW/Ce9sMOgrfblTBiOTli
         4ztfcrIrm3B0QTOoWxafdUiY4m/CSI0CIKlxbMUC7jfELsZWN6VqGt90tQ1JXuyyzWNU
         hnXSa64GU5+wZ4jA4uPFRRbVYvQCDVZbU3emeWBOFePt6mHC5XpFS1bi2leZXHL8xh/u
         /a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkByTijuFYw5EW1OdEQwCXPeXPmMw31zujfA5Jx25io=;
        b=SpOrvDVuDl5ktdWt580j7UVKetZyUZnv6nXPV9QbgZ9Q31ZhTj1vwatikUMBctbfnn
         k4Pt1dZHd3ATKIGop8hnd/9LQaCEUkLgBV9u4Sgo7gLxcFQl/zArlsB8/piUtvlvHWQs
         r9ZvgfUMAUK54QttLAcHoXJ7Dh0N9czMu6poub6Utq2S4nXk2qnel6BlhF5YzUn37DzK
         M6jF7Nyw8EeRJOygg0IGrDUr2Zogk10EZ8yND+8F32UWQIjmMtGyb3ALl8qFnCt33cL3
         6LiCbgZ+bVe5Xf3yz9iTx1K4ZvQkPCIrec9Tn3wrPWar+EjUK0TWS0uFtdAG78tvFMZ2
         1dGQ==
X-Gm-Message-State: ANoB5plPKVhAmD0Z2hHmywXQ3+UeWk1UrzgiMd6wxj6T24ybNU2IB6Cv
        r8Npm001F/PsId3/5EyhrlRu8w==
X-Google-Smtp-Source: AA0mqf6ry6hFGZhc1j6al7vVkfy2yc2GRQIQtFa2rINXU2vUkTfobQdjNzXWMpzBQ1It5LUgNz57AQ==
X-Received: by 2002:a05:600c:511d:b0:3d1:4145:b3b with SMTP id o29-20020a05600c511d00b003d141450b3bmr34403135wms.9.1671539575974;
        Tue, 20 Dec 2022 04:32:55 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003c71358a42dsm31400791wmq.18.2022.12.20.04.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:32:55 -0800 (PST)
Date:   Tue, 20 Dec 2022 12:32:54 +0000
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
Message-ID: <20221220123254.to6tzznxloxq725q@airbuntu>
References: <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu>
 <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu>
 <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
 <20221208140526.vvmjxlz6akgqyoma@airbuntu>
 <20221209164739.GA24368@vingu-book>
 <20221212184317.sntxy3h6k44oz4mo@airbuntu>
 <CAKfTPtBX0ugM87CEjAXUbVhnTZTwAAnjXu2fRfc6ezHE8=aC6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBX0ugM87CEjAXUbVhnTZTwAAnjXu2fRfc6ezHE8=aC6w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 18:39, Vincent Guittot wrote:
> On Mon, 12 Dec 2022 at 19:43, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 12/09/22 17:47, Vincent Guittot wrote:
> >
> > [...]
> >
> > > > > > > This patch loops on all cpufreq policy in sched softirq, how can this
> > > > > > > be sane ? and not only in eas mode but also in the default asymmetric
> > > > > >
> > > > > > Hmm I'm still puzzled. Why it's not sane to do it here but it's okay to do it
> > > > > > in the wake up path in feec()?
> > > > >
> > > > > feec() should be considered as an exception not as the default rule.
> > > > > Thing like above which loops for_each on external subsystem should be
> > > > > prevented and the fact that feec loops all PDs doesn't means that we
> > > > > can put that everywhere else
> > > >
> > > > Fair enough. But really understanding the root cause behind this limitation
> > > > will be very helpful. I don't have the same appreciation of why this is
> > > > a problem, and shedding more light will help me to think more about it in the
> > > > future.
> > > >
> > >
> > > Take the example of 1k cores with per cpu policy. Do you really think a
> > > for_each_cpufreq_policy would be reasonable ?
> >
> > Hmm I don't think such an HMP system makes sense to ever exist.
> >
> > That system has to be a multi-socket system and I doubt inversion detection is
> > something of value.
> >
> > Point taken anyway. Let's find another way to do this.
> >
> > [...]
> >
> > > > This only makes sense to me if you refer to death by thousand cuts kind of
> > > > problem. I can't see how this on its own being a problem.. I'll run some tests
> > > > to convince myself.
> > >
> > > That's exactly the point, the scheduler tries hard to not add any system size
> > > related limitation like: it's fine because it's only for 8 cores system.
> > > I don't want to lock up the uclamp/util_fits_cpu in such limitations so you
> > > can't use for_each_cpufreq or anything similar at runtime in sched softirq
> >
> > I'm happy to make things more generic so more users can benefit :-)
> >
> > >
> > > >
> > > > >
> > > > > uclamp_min should not be used to set an over utilized cpu  because it
> > > >
> > > > uclamp_min must set overutilized. If a long running task has its uclamp_min
> > > > changed, we want to upmigrate it if that's necessary to meet the new demand.
> > >
> > > I think that you are too much focused on your 8 cores android system.
> >
> > I am not; you're making an assumption here :-)
> >
> > HMP systems for 1k servers just don't make any sense. A desktop with 128 or
> > even 256 HMP cores is a big stretch; and if that exist I don't think there's an
> > overhead to worry about here; and I *did* consider this. I measured the impact
> > if we have 128 and it was mere 1 or 2 us extra.  And that's on under powered
> > pine book pro. If such a system exist it'd probably be more performant.
> >
> > > uclamp_min must not set a CPU overutilized because the CPU is not overutilized
> > > in this case. It's only the task that is misfit. You mostly try to bias some
> > > behavior to fit your use case.
> >
> > Maybe we are talking about different things over here. As long as we agree it's
> > a misfit task then we are aligned.
> >
> > As far as I know misfit required overutilized to re-enable load balance. But
> > maybe there's a detail that's creating this confusion.
> 
> The current implementation uses overutilized to fix misfit task
> placement because it was assumed that misfit task also means that the
> cpu is overutilized as only the utilization was used but It's not
> mandatory as proposed below and there is no direct relation anymore
> with uclamp_min

Okay. As we discussed offline - this is independent improvement to decouple
misfit load balance from overutilized. And I agree it's a good thing to have
and will mean that uclamp_min will no longer have to raise overutilized too,
which is the right thing to do indeed.

> 
> >
> > >
> > > >
> > > > Keep in mind in android tasks could move between top-app, foreground and
> > > > background groups.
> > > >
> > > > And keep in mind Android now implement a framework to dynamically change
> > > > uclamp. It's available from Android 12 as part of Android Dynamic Performance
> > > > Framework (ADPF). It's under CPU Hints.
> > > >
> > > >     https://developer.android.com/games/optimize/adpf
> > > >
> > >
> > > I have never put any kind of limitation of the task or system behavior
> >
> > Nope you didn't. I was just trying to highlight some additional problems we're
> > seeing that we'd need to consider :-)
> 
> I don't see any additional problem TBH.

Okay. I'll raise these issues in another venue/time.

> 
> >
> > >
> > > > > doesn means that the cpu is overutilized and uclamp_max should be used
> > > >
> > > > It is a misfit task; which requires overutilized to be set to re-enable load
> > > > balance for uclamp_min to upgrate it. For uclamp max we should not set
> > > > overutilized, agreed and that's what we should be doing.
> > >
> > > That's probably the root of your problem here. The load balance is still
> > > periodically called even when EAS is enabled but the latter prevents task
> > > migration unless overutilized in order to not break the energy aware task
> >
> > Okay. For me this means load_balance is disabled since it's effectively doing
> > nothing. So maybe it's a terminology problem of what I meant with load balance
> > is disabled.
> 
> This is not doing nothing and your patch is using load_balance to
> detect inversion as an example
> 
> >
> > > placement. But if a task is misplaced and a cpu finds it can help,
> > > we should let it pull the task without disabling EAS. This will not enable the
> > > performance spread behavior and we can expect the other small tasks to be
> > > packed by EAS on the best cpu at next wakeup.
> > >
> > > So intead of trying to detect a very specific capacity inversion use case
> > > during this periodic this load balance, it's better to let a CPU that can
> > > fix the misfit situation to pull the task.
> >
> > I can't see the relation here.
> >
> > Capacity inversion is required NOT in load balance. In every place will look
> 
> You are using periodic load_balance to detect capacity inversion:
> update_cpu_capacity() is called during periodic load_balance. Instead
> of detecting capacity inversion, use load_balance to pull a misfit
> task.
> Either there is a cpu on which the task can fit better and it will
> pull it or there is no better place and it will not
> 
> > for a fitting CPU; we need to ensure hints to place the task on big cpu works
> > even under thermal pressure.
> >
> > If uclamp_min = 1024, but big core has 5% thermal pressure, it should still fit
> > there. And feec() a long with all other callers should respect that too.
> 
> That's probably where I disagree, task should probably stay on this
> cpu because there is no better option (ie cpu with higher compute
> capacity) but the task doesn't fit on the cpu because its capacity is
> below uclamp_min. You might think that I niptick there but that makes
> a difference in the way to handle the situation.

Hmm. When we spoke offline I thought we agree on this point..

> 
> >
> > How better overutilized detection helps here? EAS needs to consider this as
> > a candidate CPU and place it there at wake up.
> 
> If uclamp_min = 1024, but big core has 5% thermal pressure, big cpu
> doesn't fit, otherwise uclamp_min is meaningless. But it can still
> remain the best choice and feec should select it.

.. okay so we agree that we should still select it.

As we agreed offline I'll refactor the code so that util_fits_cpu() returns
multiple reasons to help feec() and select_idle_capacity() and other call sites
make better decision. ie: make feec() have a fallback CPU for the next best fit
under thermal pressure cases so if there's no CPU truly fits we can fallback to
the next best thing - which should mimic what we do in capacity inversion but
should be more generic.

I have to say, I still prefer the current approach as it keeps the logic
encapsulated in util_fits_cpu() and leads to the similar results. I am worried
about spilling the details out to users now - something I tried hard to avoid.
I'll trust your judgement call here though. I'll post patches as soon as
they're ready :-).

> > I need time to digest this. But so far I see this is still irrelevant as the
> > problem with the definition of what *fits* a CPU and what doesn't.
> >
> > On a system where:
> >
> >         LITTLE=160, MEDIUM=480, BIG=1024
> >
> > A task
> >
> >         p->util_avg = 200
> >         p->util_min = 1024
> >
> > Should always be placed on a big core unless the big core is capacity inverted.
> > That means most importantly in feec().
> >
> > How does the above fix that?
> 
> Not differently than if BIG is under thermal pressure and its capacity
> goes below 480. In this case, MEDIUM is the best CPU and should be
> selected. Note that the task still doesn't fit on any cpu but neither
> BIG nor MEDIUM are over utilized and there is no need to disable EAS
> and spread the tasks everywhere. feec() and select_idle_capacity()
> should take care of this case and as a result of yours. I don't see
> any difference in the way both cases should be handled whereas
> capacity inversion makes a difference.

I was relying here that select_idle_capacity() will actually do the right thing
and pick the highest spare capacity CPU. And maybe I have the wrong threshold
here for 'this is a disaster anyway' - I just thought if big gets that badly
throttled; there are bigger issues to worry about. I need to raise my bar! :-P


> >
> > Because it's the highest level. You have no option to do better. uclamp_min is
> > a hint; if the util_avg is small (ie: it still fits_capacity()); best effort is
> > to keep giving the task the performance it needs. While on a big core; you
> > can't upmigrate to any other level; so thermal pressure on big core is
> > meaningless until it is in capacity inversion.
> 
> >
> > If the user asks for something and finds that their task is placed randomly
> > that's not good, no?
> 
> nobody says to place the task randomly.

With the new proposal to make util_fits_cpu() return multiple reason, yes.
Previously I understood to just subtract thermal pressure blindly all the time
- which will lead to non desirable behavior that will confuse userspace that
uses uclamp. I think the task placement part of uclamp is important even if we
sometimes fail to get the right frequency due to thermal pressure - which is
invisible to userspace and I don't want them to worry about these details when
setting uclamp values.

> 
> >
> > What you say makes sense against util_avg; the rule of which is still the same
> > as before.
> >
> > >
> > > >>
> > > >
> > > > >
> > > > > Also we have more and more thermal capping happening ahead of
> > > > > overheating like the power cap interface where we want to cap some
> > > > > CPUs and others even before they reach their thermal limit in order to
> > > > > get more power/thermal room for others. This implies that some CPUs
> > > > > could be under thermal pressure whereas others not. This implies also
> > > > > that a UC with big core capacity being below little and medium cores
> > > > > is not impossible or medium being under little but big staying at high
> > > > > capacity.
> > > >
> > > > I *think* I am catering for this already. The big is special because it's the
> > > > highest level, so thermal pressure; from uclamp perspective, is not meaningful
> > > > as it's the best you can ever get on this system; untill it becomes capacity
> > > > inverted that is.
> > > >
> > >
> > > That's another point that concerns me, you put some special condition on big
> > > cores to be able to detect an possible inversion.
> > > If a task deosn't fit a cpu because of thermal pressure, it should be tagged misfit
> > > and let other cpu looks if they can do better. That's doesnt mean that we
> > > will find one.
> >
> > This breaks the usefulness of the hint. What you say means a small task that
> > wants to run as fast as possible will find itself placed randomly instead
> 
> Why randomly ? feec() and others should continue to select the best
> cpu even if it may not fit util_min constraint, whatever the cpu BIG,
> MEDIUM or LITTLE

Without capacity inversion or your new proposal of making util_fits_cpu()
return multiple reasons; feec() will not find any fitting cpu and we'll end up
falling back to prev_cpu or an idle cpu in select_task_rq_fair(). Given how
temporary these thermal pressure on big cores can be; the task will be moving
between cpus in what appears as random from userspace point of view when
looking at perfetto traces at least.

So we can't consider thermal pressure blindly is what I am trying to say.
I think we see the same thing now. We do have the same problem for RT - which
I had a patch to do what you're suggesting to do  with util_fits_cpu(). So
maybe in a sense this will unify the two approaches.


Thanks!!

--
Qais Yousef
