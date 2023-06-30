Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2967A743ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjF3LbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjF3LbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:31:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCF7C0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:30:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc54caad5so8983075e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1688124654; x=1690716654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZV6dzBiQl0IH1EEhpQsQA8tKPBloNuEHt8BD8L2NkEI=;
        b=wml0BG1fzqHqy5AFo8YeNkTuA+sDYFhG8thc/i8gW71eeBfUj3Az4BTt1UT27FoIMy
         V92rSpl9hsQtMth70RMSgEOFCCMrcR/tODf5Jy7XzZrb/pLEYbulZjlN/VYToU1Lc1Xd
         aOIZAaEcuPcSoLPkeG2PLhXh4mSCftHCJa8sWZdkgFUX5GuKSNb1vY6Y/mPJLXDfE2Oe
         V8uD7ZU96af7P57fa4ugtogo9oYuu45dXzWzl/0rDAqz/gM2rZIBFwAKwTK/gTj7vLa5
         Q0zytl2g1TVUuAcq0ZoVCX7PqedHe5p2oDRk75yUHYMxWy16Bf2JGNGbpNsgVeHo5MsR
         LL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688124654; x=1690716654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV6dzBiQl0IH1EEhpQsQA8tKPBloNuEHt8BD8L2NkEI=;
        b=e3W9eauoifB7plj4SitDKmsEMzpgINfByGS//ZhJb/JElz+JncNRKEaygYR3hKdFLm
         G9/Ju+14JbM/FTN+JRKEtEqUiw8qRdX/If2pUje/0dCt23vOmDkW1d45C7xyqftPcRG0
         DzTYOo2J+3sjC1b3y+rByQncVyEPmwn+y7jjQQT7LtB+W4i9F4Kkrtam86ICj/4yO6jI
         UIUgXZDcj8g3f/xKMkYYKbSZ3FNScK8nScWzRiDqdlrSWHxYy7RtVffWoVP6C+oP1em3
         uOOlCxkEu3qZ2Tfn1M2roNBL3FPkwwgDEJSBD0IhbRvgHWOOsw4g5XArdrRC3EHn6MrO
         QTQQ==
X-Gm-Message-State: AC+VfDwfdr6mJIDMwwpX7FJPyhJmmu3FLI99ONwwk+igXwI5Tie2lgii
        /K1S1EG+cJJLgrKZcpMjcOmdzQ==
X-Google-Smtp-Source: ACHHUZ7TSxhgptiqaWhxXiY/Vl9yeIQJRkaPUVC5f6QKQjnYikMG17OcC10n55EEK5ZLKWEd9arN+Q==
X-Received: by 2002:a7b:ce87:0:b0:3f7:5d:4a06 with SMTP id q7-20020a7bce87000000b003f7005d4a06mr1841455wmj.1.1688124654424;
        Fri, 30 Jun 2023 04:30:54 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id c14-20020a7bc84e000000b003f8126bcf34sm21658390wml.48.2023.06.30.04.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 04:30:53 -0700 (PDT)
Date:   Fri, 30 Jun 2023 12:30:49 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230630113049.exhfcf3cc2shs4pm@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
 <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
 <48db3f08-a066-c078-bfc9-bf20f66e067a@arm.com>
 <20230531182243.r4d5teuijiadwp2c@airbuntu>
 <2d4ead34-3023-aac9-3e1d-97703c7200a0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d4ead34-3023-aac9-3e1d-97703c7200a0@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/23 13:29, Dietmar Eggemann wrote:
> On 31/05/2023 20:22, Qais Yousef wrote:
> > Hi Lukasz!
> > 
> > Sorry for late response..
> > 
> > On 05/22/23 09:30, Lukasz Luba wrote:
> >> Hi Qais,
> >>
> >> I have a question regarding the 'soft cpu affinity'.
> > 
> > [...]
> > 
> >>> IIUC I'm not seeing this being a problem. The goal of capping with uclamp_max
> >>> is two folds:
> >>>
> >>> 	1. Prevent tasks from consuming energy.
> >>> 	2. Keep them away from expensive CPUs.
> >>>
> >>> 2 is actually very important for 2 reasons:
> >>>
> >>> 	a. Because of max aggregation - any uncapped tasks that wakes up will
> >>> 	   cause a frequency spike on this 'expensive' cpu. We don't have
> >>> 	   a mechanism to downmigrate it - which is another thing I'm working
> >>> 	   on.
> >>> 	b. It is desired to keep these bigger cpu idle ready for more important
> >>> 	   work.
> >>>
> >>> For 2, generally we don't want these tasks to steal bandwidth from these CPUs
> >>> that we'd like to preserve for other type of work.
> >>
> >> I'm a bit afraid about such 'strong force'. That means the task would
> >> not go via EAS if we set uclamp_max e.g. 90, while the little capacity
> >> is 125. Or am I missing something?
> > 
> > We should go via EAS, actually that's the whole point.
> > 
> > Why do you think we won't go via EAS? The logic should be is we give a hint to
> > prefer the little core, but we still can pick something else if it's more
> > energy efficient.
> > 
> > What uclamp_max enables us is to still consider that little core even if it's
> > utilization says it doesn't fit there. We need to merge these patches first
> > though as it's broken at the moment. if little capacity is 125 and utilization
> > of the task is 125, then even if uclamp_max is 0, EAS will skip the whole
> > little cluster as apotential candidate because there's no spare_capacity there.
> > Even if the whole little cluster is idle.
> 
> I'm not against letting uclamp_max force fit the placement of p. I'm
> just worried that using the EM (especially in it's current state) for
> that is wrong and will only work in certain scenarios like the one you
> picked.
> 
> I did show a counter-example (Juno-r0 [446 1024 1024 446 446 446] with 6
> 8ms/16ms uclamp_max=440). The issue is that once we have no idle time
> left, the decisions of the EM are simply wrong and we shouldn't enforce
> those decisions.

But this is a different problem, no? If you consider the current level of
brokeness, the impact is worse IMO.

Given that Android force packs things on little cores using cpuset; I see this
wrong calculation bug less impactful. But I do agree we should do better. But
I don't see this as a blocker to merging this fix.

The thing we need to keep in mind is that if the big cores are busy or running
at high frequencies, then yes we want to cram these tasks on the little cores.
The impact of them running accidentally there (especially we lack support for
correction action in the load balancer yet) is worse.

> 
> There is a related issue. E.g. on Pixel6 with its 4 little CPUs with
> cpu_cap_orig = 124. If you admit a task with p->util_avg > cpu_cap_orig
> it doesn't even fit onto a CPU. But we then do an energy calculation
> taking the values of the whole little PD into consideration. This makes
> no sense. The EM is not uclamp_max aware right now.

Sorry could explain the difference between this problem and the one we already
were discussing?

> 
> What about using `sis() -> sic()` for uclamp_max constrained tasks? We
> would just have to iterate over the CPUs in cpu_cap_orig order. (1)

What's the advantage here? This is not useful because we only search idle
capacities. So on scenarios where the system is busy, they'll end up randomly
but we do want to pack them on little cores IMHO.

> Or the EM has to be made uclamp_max aware. (2)

Do you have any suggestions here?

Note we lack the evidence how problematic this is in real world scenarios. All
the systems I've seen already pack everything on little cores via cpuset. So
nothing gets worse here. But we get a chance to do better in other cases while
we look for ways to improve this.

> 
> Your example is the idle system with 1 task p waking up. This task has a
> util_avg which excludes the little CPUs from being the new task_cpu(p).
> But p's uclamp_max value would allow this. But we can't just consider
> the placement of 1 task here.

No one is saying we need to consider the placement of 1 task only. I think you
exaggerate the impact of cramming things and not noticing that whether it's
1 or 100 tasks, EAS will not even consider the little cores for those busy
tasks. uclamp_max was introduce to allow this, and it just doesn't work since
by definition these tasks will cause the little cores to have 0 spare
capacity. But we skip all cpus with 0 spare capacities.

> 
> >> This might effectively use more energy for those tasks which can run on
> >> any CPU and EAS would figure a good energy placement. I'm worried
> >> about this, since we have L3+littles in one DVFS domain and the L3
> >> would be only bigger in future.
> > 
> > It's a bias that will enable the search algorithm in EAS to still consider the
> > little core for big tasks. This bias will depend on the uclamp_max value chosen
> > by userspace (so they have some control on how hard to cap the task), and what
> > else is happening in the system at the time it wakes up.
> 
> To teach the EM about such tricky dependencies is IMHO outside the scope
> of `how to select a CPU for a uclamp_max constrained task`. (3)
> 
> >> IMO to keep the big cpus more in idle, we should give them big energy
> >> wake up cost. That's my 3rd feature to the EM presented in OSPM2023.
> > 
> > Considering the wake up cost in EAS would be a great addition to have :)
> 
> I see this one as unrelated to (3) as well.
> 
> >>> Of course userspace has control by selecting the right uclamp_max value. They
> >>> can increase it to allow a spill to next pd - or keep it low to steer them more
> >>> strongly on a specific pd.
> >>
> >> This would we be interesting to see in practice. I think we need such
> >> experiment, for such changes.
> > 
> > I'm not sure what you mean by 'such changes'. I hope you don't mean these
> > patches as they are not the key. They fix an obvious bug where task placement
> > hint won't work at all. They don't modify any behavior that shouldn't have
> > already been there. Nor introduce new limitation. I have to say I am
> > disappointed that these patches aren't considered an important fix for an
> > obvious breakage.
> 
> To me it's a dead-end to go this way. We need to see the full picture
> including something like (1) or (2) or patches you have mentioned, like
> the `down-migration in load-balance` thing.

The down migration is to address another problem. It is a necessary fix to do
corrections when we end up in bad situation. Wake up path still has to do the
right thing first.

> 
> Maybe we can at least list all the use cases for uclamp_max capping here:
> 
> It was mentioned:
> 
> (A) `soft affinity for tasks w/ util_avg > uclamp_max`.
> 
> Are there more?

We are trying to fix bugs here. Do you want to restart the discussion of why
uclamp_max was introduced?

Uclamp max is a hint to bias task placement and power consumption by help
keeping these task away from big cpus and higher frequencies based on the max
allowed performance level the task is allowed to reach.


Cheers

--
Qais Yousef
