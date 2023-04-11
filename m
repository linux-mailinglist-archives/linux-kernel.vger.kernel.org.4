Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86E6DE325
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDKRvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDKRve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:51:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB0D6A4D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:51:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j11so12063430wrd.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1681235491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f6wlHf3TxflhhHKfhguz5XUqylvsE4OEn5X1ag/cp6g=;
        b=t1jOG34MGztUa/RteubYQJ/VdSGsxFBu/swoAsZZGpRpIgFjx/EhXUAUqQafxkmBJB
         gr/18dc+feBQDXMnq2WgpY64D3qvtL8wDCFSvTUrxSR5Nw94Vx0yORiMngIDAUKLRW/6
         adI3vS1D/+4S3kCvtTxEYIiBSn3O18ma5eCucKorFidRpEkpn/e1Kg33KeRfRmXc+1MV
         PHAXh0vl7wYIZ9S0D1+x1bTqbuwHSs4zPI5FEMUatY6GV8IDe2IM+MhZiihMFlPD94DB
         r6i7Li9rSpwZYNaNo+GlOBbNLWK4/wB6oJqlELj2mtAJ8np5twxWHr5KVVnGYROil1xJ
         pdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6wlHf3TxflhhHKfhguz5XUqylvsE4OEn5X1ag/cp6g=;
        b=c283OFuTOemv0m3tt9gpE6EPThcJDAkbOcDYa6/QaDv5lYl9+OX8xUN6yrMCJeiAyw
         pH4ovVx7IcmcCdKxGq8278mCNcldd1FQElpR2nZQlTNgASQYqp5otc9QIA9bE6LgSvLc
         T5oLMsxJZO4zQn8U2ohwxShkmZ97xxQqF5b3xwXaUqnjvcS+T4l+qKiwYszbGgkHxsEr
         13RMhbJfdB5pFVBsEK1HhMSHO+zM/x90sGRqlwFzxZ5ubawkVdKljz5RX+O+q99Nqg+g
         Gm0yiB9OmbQ2xLFYlMfy4FuWFS4EnxQ2rxf5kFCxVtl/TpDCUqh3ZpxUzbxtwoqpNOdn
         avDw==
X-Gm-Message-State: AAQBX9dpLu/Ct5EdA4HRi9kxNULtySJl4JI1Z1BSRhDA36CVWYKRS7r9
        KhbooefJsd4oBlqspcEu4XkqkQ==
X-Google-Smtp-Source: AKy350avAqTTfFPK9YrtWu3xDFtG4BfVTrQOp9CLCip/iiaqEMvgaraxOmApi7p2VvYpmJBSWZYTIw==
X-Received: by 2002:adf:f2cf:0:b0:2ef:b596:3f71 with SMTP id d15-20020adff2cf000000b002efb5963f71mr9095045wrp.51.1681235490566;
        Tue, 11 Apr 2023 10:51:30 -0700 (PDT)
Received: from airbuntu (host109-154-46-114.range109-154.btcentralplus.com. [109.154.46.114])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4fc3000000b002efacde3fc7sm12850658wrw.35.2023.04.11.10.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:51:30 -0700 (PDT)
Date:   Tue, 11 Apr 2023 18:51:28 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <20230411175128.ddk4tnzymwiu47fq@airbuntu>
References: <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <20230223153700.55zydy7jyfwidkis@airbuntu>
 <CAKfTPtDVGcvmR5BoJpyoOBE19PcWZP+6NjSD7MnJyBAc7VMnmg@mail.gmail.com>
 <20230301172458.intrgsirjauzqmo3@airbuntu>
 <60fe6b16-0fc6-6ac4-f8fe-87ae9b6592c0@arm.com>
 <20230403144539.46iwihlrzigsx5iu@airbuntu>
 <97b85280-4ce6-21f8-1a62-c997c4d90c35@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97b85280-4ce6-21f8-1a62-c997c4d90c35@arm.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar!

On 04/06/23 17:58, Dietmar Eggemann wrote:
> Hi Qais,
> 
> On 03/04/2023 16:45, Qais Yousef wrote:
> > Hi Diemtar
> > 
> > On 03/23/23 17:29, Dietmar Eggemann wrote:
> >> On 01/03/2023 18:24, Qais Yousef wrote:
> >>> On 03/01/23 11:39, Vincent Guittot wrote:
> >>>> On Thu, 23 Feb 2023 at 16:37, Qais Yousef <qyousef@layalina.io> wrote:
> >>>>>
> >>>>> On 02/09/23 17:16, Vincent Guittot wrote:
> 
> [...]
> 
> >>>>> If we improve util response time, couldn't this mean we can remove util_est or
> >>>>> am I missing something?
> >>>>
> >>>> not sure because you still have a ramping step whereas util_est
> >>>> directly gives you the final tager
> >>
> >> util_est gives us instantaneous signal at enqueue for periodic tasks,
> > 
> > How do you define instantaneous and periodic here? How would you describe the
> > behavior for non periodic tasks?
> 
> Instantaneous is when the max value is available already @wakeup. That 
> is the main use case for util_est, provide this boost to periodic tasks. 
> A non-periodic task doesn't benefit from this. Work assumption back then 
> was that the important task involved here are the periodic (back then 
> 60Hz, 16.67 ms period) tasks of the Android display pipeline.

Not all tasks in the system are periodic..

Note that the main use case that was brought up here is gaming - which is not
the same as Android display pipeline.

> 
> >> something PELT will never be able to do.
> > 
> > Why? Isn't by selecting a lower pelt halflife we achieve something similar?
> 
> You get closer but you still would need time to ramp-up. That's without 
> util_est.

Yes we'll always need time to ramp up. Even for util_est, no?

> 
> [...]
> 
> >>>> the 25% is not related to the ramping time but to the fact that you
> >>>> always need some margin to cover unexpected events and estimation
> >>>> error
> >>>
> >>> At the moment we have
> >>>
> >>> 	util_avg -> util_est -> (util_est_faster) -> util_map_freq -> schedutil filter ==> current frequency selection
> >>>
> >>> I think we have too many transformations before deciding the current
> >>> frequencies. Which makes it hard to tweak the system response.
> >>
> >> To me it looks more like this:
> >>
> >> max(max(util_avg, util_est), runnable_avg) -> schedutil's rate limit* -> freq. selection
> >>                              ^^^^^^^^^^^^ 
> >>                              new proposal to factor in root cfs_rq contention
> > 
> > These are still 5 stages even if written differently.
> > 
> > What if background tasks that are causing the contention? How can you tell it
> > to ignore that and NOT drive the frequency up unnecessary for those non
> > important ones? If userspace is fully aware of uclamp - this whole discussion
> > wouldn't be necessary. And I still have a bunch of fixes to push before
> > uclamp_max is actually usable in production.
> 
> You're hinting to the other open discussion we have on uclamp in feec():

No, no I am not.

> 
> https://lkml.kernel.org/r/20230205224318.2035646-1-qyousef@layalina.io
> 
> IMHO, this is a different discussion. No classification of tasks here. 

That patch has nothing to do with what I'm trying to say here. You say looking
at load_avg helps with contention. My point was that what if the contention is
caused by background tasks? They'll cause a frequency to go up higher which is
not the desired effect.

So it'll not distinguish between cases that matters and cases that don't
matter; and with no ability to control this behavior.

As you know cpuset is used to keep background tasks on little cores; whose top
frequencies on latest ones are very expensive. This could lead to higher
residency on those expensive frequencies with your change.

We need to be selective - which is the whole point behind wanting a runtime
control. Not all workloads are equal. And not all systems handle the same
workload similarly. There are trade-offs.

> 
> >> Like Vincent mentioned, util_map_freq() (now: map_util_perf()) is only
> >> there to create the safety margin used by schedutil & EAS.
> > 
> > Yes I know and that's not the point. The point is that it's a chain reaction.
> > 25% percent headroom is already very aggressive and causes issues on the top
> > inefficient ends of the cores. And when util is high, you might end up in
> > a situation where you skip frequencies. Making everything go up faster without
> > balancing it with either enabling going down faster too or tune this value can
> > lead to power and thermal issues on powerful systems.
> 
> I try to follow here but I fail. You're saying that the safety margin is 
> too wide and in case util is within the safety margin, the logic is 
> eclipsed by going max or choosing a CPU from a higher CPU capacity 
> Perf-domain?
> 
> Wouldn't `going down faster` contradict with schedutil's 20ms down rate 
> limit?

No. 200ms is a far cry from 20ms.

> 
> > 
> > I think all we need is controlling pelt halflife and this one to tune the
> > system to the desired trade-off.
> > 
> >>
> >> * The schedutil up/down filter thing has been already naked in Nov 2016.
> >> IMHO, this is where util_est was initially discussed as an alternative.
> > 
> > Well, I don't see anyone not using a down filter. So I'm not sure util_est has
> > been a true alternative.
> 
> Definitely not in down direction. util_est is 0 w/o any runnable tasks. 
> And blocked utilization is decaying much faster than your 20ms down rate 
> limit.

Okay I'll keep this in mind when looking at this in the future. Maybe there's
something fishy in there that we could improve.

> 
> >> We have it in mainline as well, but one value (default 10ms) for both
> >> directions. There was discussion to map it to the driver's
> >> translation_latency instead.
> > 
> > Which can be filled wrong sometimes :(
> > 
> >>
> >> In Pixel7 you use 0.5ms up and `5/20/20ms` down for `little/medium/big`.
> >>
> >> So on `up` your rate is as small as possible (only respecting the
> >> driver's translation_latency) but on `down` you use much more than that. 
> >>
> >> Why exactly do you have this higher value on `down`? My hunch is
> >> scenarios in which the CPU (all CPUs in the freq. domain) goes idle,
> >> so util_est is 0 and the blocked utilization is decaying (too fast,
> >> 4ms (250Hz) versus 20ms?). So you don't want to ramp-up frequency
> >> again when the CPU wakes up in those 20ms?   
> > 
> > The down filter prevents changing the frequency to a lower value. So it's
> > a holding function to keep the residency at a higher frequency for at least
> > 20ms. It is, sort of, similar to the max() functions you used above. The max
> > function will allow you to follow the fasting ramping up signal on the way up,
> > and the slowest ramping down one on the way down.
> > 
> > I think this is more deterministic way to do it.
> 
> But a faster PELT wouldn't help here, quite the opposite.

I didn't mention PELT here. I was comparing util_est max() to the filter in
schedutil.

> [...]
> 
> >>>> Also IIUC Dietmar's results, the problem seems more linked to the
> >>>> selection of a higher freq than increasing the utilization;
> >>>> runnable_avg tests give similar perf results than shorter half life
> >>>> and better power consumption.
> >>>
> >>> Does it ramp down faster too?
> >>
> >> Not sure why you are interested in this? Can't be related to the
> >> `driving DVFS` functionality discussed above.
> > 
> > If you change the reaction time to be more aggressive in going up, then it's
> > only natural to have it symmetrical so your residency on the power hungry OPPs
> > don't go over the roof and end up with thermal and power issues.
> 
> But you apply this 20ms down rate limit on the big cores too?
> 
> > I am concerned about us biasing towrads perf first too much and not enabling
> > sys admins to select a proper trade off for their system and use case. Which
> > are not static. The workloads the system needs to accommodate to are abundant
> > and operating conditions could change. And the diversity of hardware available
> > out there is huge - I am not sure how can we expect we can have one response to
> > accommodate for all of them.
> > 
> > What I'm trying to push for here is that we should look at the chain as one
> > unit. And we should consider that there's important trade-off to be had here;
> > having a sensible default doesn't mean the user shouldn't be allowed to select
> > a different trade-off. I'm not sure the problem can be generalized and fixed
> > automatically. But happy to be proven wrong of course :-)
> > 
> > FWIW, I'm trying to tweak all these knobs and study their impact. Do you mind
> > pasting the patch for load_avg consideration so I can take it into account too
> > in my experiments?
> 
> Just posted it:
> 
> https://lkml.kernel.org/r/20230406155030.1989554-1-dietmar.eggemann@arm.com

Thanks a lot! I'll revisit the whole story taking into account the relationship
with all these other controls. I will need sometime though. But I will get back
with some data hopefully to help us pave the right way. I think we shredded
this thread to pieces enough :)


Thanks!

--
Qais Yousef
