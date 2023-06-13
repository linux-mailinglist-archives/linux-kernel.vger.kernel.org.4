Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9644772E47B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbjFMNnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbjFMNnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F3AC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DA8661F26
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E112CC433F0;
        Tue, 13 Jun 2023 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686663789;
        bh=3kwtf6Pi9FprYSlFOHY6F6dGznMMwR06O05kVHy0KI8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p3tx/2E/DZzkMDL/iEKwbpWufcz3G6uJJvD9miw5DbUL1fn3zMMcPXFEbcV0ICeJa
         sN0niw8YByE7dYvQR1w7M8/97VFMdJwum01sJimXgd0HV9zMTnWdnEefjSsXs5aIgY
         qwsF5znauuuvyCub5EIR1wVh2md25lQ64e55wZ1er9jgUtdh3RsW7lF1QPuCJ9fRua
         tgnA8cf/ElcHjU6LpvP80xO9sc/Zymb08sr75QfE7bYhjq2VWcJS0ao3ft8wc8ndxF
         1jv8ttsv2rekGNvfDqq6iVLWS1+J6WWUTMx+s+3Zw6wxJCPLDhGt+QnRUkbWsHYtb8
         YSeOEjk2PAN4A==
Message-ID: <841849b5-1f9c-4f0e-2de8-1da278256888@kernel.org>
Date:   Tue, 13 Jun 2023 15:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
To:     Joel Fernandes <joel@joelfernandes.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
 <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org>
 <CAEXW_YR9Tfw5KyFU7TQtYE02k+DpaMXH=osx9Ws5w_j1YpHxhg@mail.gmail.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAEXW_YR9Tfw5KyFU7TQtYE02k+DpaMXH=osx9Ws5w_j1YpHxhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 22:35, Joel Fernandes wrote:
> Hello Daniel!
> 
> On Mon, Jun 12, 2023 at 1:21 PM Daniel Bristot de Oliveira
> <bristot@kernel.org> wrote:
> [...]
>>> On Thu, Jun 8, 2023 at 11:58 AM Daniel Bristot de Oliveira
>>> <bristot@kernel.org> wrote:
>>>>
>>>> From: Juri Lelli <juri.lelli@redhat.com>
>>>>
>>>> Starting deadline server for lower priority classes right away when
>>>> first task is enqueued might break guarantees, as tasks belonging to
>>>> intermediate priority classes could be uselessly preempted. E.g., a well
>>>> behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
>>>> there are still CPU cycles available for NORMAL tasks to run, as they'll
>>>> be running inside the fair deadline server for some period of time.
>>>>
>>>> To prevent this issue, implement a starvation monitor mechanism that
>>>> starts the deadline server only if a (fair in this case) task hasn't
>>>> been scheduled for some interval of time after it has been enqueued.
>>>> Use pick/put functions to manage starvation monitor status.
>>>
>>> Me and Vineeth were discussing that another way of resolving this
>>> issue is to use a DL-server for RT as well, and then using a smaller
>>> deadline  for RT. That way the RT is more likely to be selected due to
>>> its earlier deadline/period.
>>
>> It would not be that different from what we have now.
>>
>> One of the problems of throttling nowadays is that it accounts for a large window
>> of time, and any "imprecision" can cause the mechanism not to work as expected.
>>
>> For example, we work on a fully-isolated CPU scenario, where some very sporadic
>> workload can be placed on the isolated CPU because of per-cpu kernel activities,
>> e.g., kworkers... We need to let them run, but for a minimal amount of time, for
>> instance, 20 us, to bound the interference.
>>
>> The current mechanism does not give this precision because the IRQ accounting
>> does not account for runtime for the rt throttling (which makes sense).
> 
> I lost you here, "Runtime for the rt throttling" does not make much
> sense to me as a statement.

Both update_curr_rt() and update_curr_dl() use rq_clock_task() as clock. update_rq_clock_task()
reduces the irq_delta from task's clock (inside #ifdef CONFIG_IRQ_TIME_ACCOUNTING), and this
clock is used to throttling.

>> So the
>> RT throttling has the 20 us stolen from IRQs and keeps running. The same will
>> happen if we swap the current mechanism with a DL server for the RT.
> 
> I read this about 10 times to learn that *maybe* you mean that IRQs
> stole time from the "Well behaved running time" of the RT class.

I also read emails many times :-)

I am
> not seeing how that is related to creation of a DL-server for the RT
> class. Maybe describe your point a bit more clearly?

This patch is targeting a better way to avoid SCHED_OTHER starvation.
Having a DL server for RT class does not help on that. We need to boost
SCHED_OTHER.

>>
>> Also, thinking about short deadlines to fake a fixed priority is... not starting
>> well. A fixed-priority higher instance is not a property of a deadline-based
>> scheduler, and Linux has a fixed-priority hierarchy: STOP -> DL -> RT -> CFS...
>> It is simple, and that is good.
>>
>> That is why it is better to boost CFS instead of throttling RT. By boosting
>> CFS, you do not need a server for RT, and we account for anything on top of CFS
>> for free (IRQ/DL/FIFO...).
> 
> I did mention in my last email that it is not ideal. I just brought it
> up as an option. It might reduce the problem being seen and is better
> than not having it.

We have thought about it, but boosting SCHED_OTHER is the way to go.

> 
>>> Another approach could be to implement the 0-laxity scheduling as a
>>> general SCHED_DEADLINE feature, perhaps through a flag. And allow DL
>>> tasks to opt-in to 0-laxity scheduling unless there are idle cycles.
>>> And then opt-in the feature for the CFS deadline server task.
>>
>> A 0-laxity scheduler is not as simple as it sounds, as the priority also depends
>> on the "C" (runtime, generally WCET), which is hard to find and embeds
>> pessimism. Also, having such a feature would make other mechanisms harder, as
>> well as debugging things. For example, proxy-execution or a more precise
>> schedulability test...
> 
> I think you did not read my email properly, I was saying make the
> 0-laxity default-off and the opt-in for certain DL tasks. That may
> work perfectly well for a system like ChromeOS where likely we will
> use the DL server as the sole deadline task and opt-in for the
> 0-laxity. Then we don't need watchdog hacks at all and it all cleanly
> works within the DL class itself. There are the drawbacks of the
> pessimism/locking  etc (I already knew that by the way as the obvious
> drawbacks of 0-laxity) but I am not immediately seeing how this
> CFS-watchdog with 0-laxity is any different from the DL-server itself
> having such a property. If you really have a concrete point on why
> that won't work, and if you could clarify that more clearly why a
> watchdog is better than it, that would be great.


I think you are overloading a term and a goal, and this makes your
thoughts ambiguous.

0-laxity is a point in time. What do you want to do at 0-laxity? Do you
want to run or start/replenish?

In the previous discussions, we mentioned using a scheduler that uses
it as a way to prioritize the task (to run). That is an overkill, as
it would be another scheduler. That is the first interpretation for
0-laxity in this thread, mainly associated with the word "scheduling"
(not only I read that way).

In this patch, Juri's PoC shows that if we defer the DL server start
(replenish) for a point in the future, we can keep the fixed-priority
order of the schedulers, boosting SCHED_OTHER if it starves,
without breaking EDF.

If you see the cover, I mentioned using the 0-laxity point in time to
activate the DL server under EDF. In that way, at the 0-laxity point,
the DL server is replenished with runtime and deadline as
"now" + period. With that implemented...

In the base case:
  it is never activated.

In the Busy-loop FIFO case:
 Busy-loop FIFO task run starving OTHER for (period - runtime):
   SCHED_OTHER server will be started at 0-laxity and get the
   processor for its runtime immediately because there are no DL
   tasks.

In the presence of DL & RT tasks:
 DL and RT Starving OTHER for (period - runtime):
   SCHED_OTHER server will be started & scheduled under EDF, before or
   after the other DL tasks, following EDF. Anyways, before
   returning to the SCHED_RT.

So, in this way, the OTHER will be boosted over SCHED_RT without breaking
SCHED_DEADLINE tasks.

In an 0-laxity scheduler, the server would run at 0-laxity, jumping in
front of DL tasks... that would break EDF. It would be mixing two
schedulers in one. It is not required and likely not a good idea either.

In the cover, I mentioned improving this patch, so maybe watchdog is not
the appropriate name. 0-laxity server is not a good name either because
it might induce people to think that the server will RUN at 0-laxity
while it will actually be replenished at 0-laxity. Maybe a deferred server
might be a better name.

>> In a paper, the scheduler alone is the solution. In real life, the solution
>> for problems like locking is as fundamental as the scheduler. We need to keep
>> things simple to expand on these other topics as well.
>>
>> So, I do not think we need all the drawbacks of a mixed solution to just fix
>> the throttling problem, and EDF is more capable and explored for the
>> general case.
> 
> Again, I was saying making it opt-in seems like a reasonable approach
> and just enabling such property for the DL server.

Can we have a "deferred DL server?" is that your question?

If so, I think so. But we have other points to look first. DL servers are per-cpu,
so they break global. We need to think about an interface... and there are
other points that we need to understand before trying some other more
optimized cases.

>> With this patch's idea (and expansions), we can fix the throttling problem
>> without breaking other behaviors like scheduling order...
> 
> I don't mind the watchdog patch as such, of course. I presented its
> mechanics at OSSNA and I know how it works, but I feel the DL server
> opting-in for 0-laxity would be cleaner while keeping such behavior as
> default-off for regular DL uses, that's my opinion -- but what else am
> I missing?  Either way, no harm in discussing alternate approaches as
> well even if we are settling for the watchdog.
> 
>>> Lastly, if the goal is to remove RT throttling code eventually, are
>>> you also planning to remove RT group scheduling as well? Are there
>>> users of RT group scheduling that might be impacted? On the other
>>> hand, RT throttling / group scheduling code can be left as it is
>>> (perhaps documenting it as deprecated) and the server stuff can be
>>> implemented via a CONFIG option.
>>
>> I think that the idea is to have the DL servers eventually replace the group
>> schedule. But I also believe that it is better to start by solving the
>> throttling and then moving to other constructions on top of the mechanism.
> 
> Hmm. For throttling at the root level yes, but  I am not seeing how
> you can replace the group scheduling code for existing users of RT
> Cgroups with this. The throttling in the RT group scheduling code is
> not exactly only about "not starving CFS", it is more related to
> letting RT groups run with certain bandwidth. So you cannot really
> delete it if there are real users of that code -- you'll have to
> migrate those users away first (to an alternate implementation like
> DL).  If there are no users of RT group scheduling, that's lovely
> though. We don't use it in ChromeOS fwiw.

The idea behind the base patchset from Peter is solid and is the best way we
can start, and starting with avoiding OTHER starvation is an easy starting point.
Many people will benefit from it - like all the people that ping me
because of the RT_RUNTIME_GREED (including Google in the past)... which is
the starting point of all this work.

Generalizing it requires time, but it will happen... and you know that Juri and I
care about Chromeos' use case, as I have been discussing this with you all and
even participating in Google/chrome focused meetings about sched...
at 6 pm our time ;-).

-- Daniel

> 
> - Joel
> 

