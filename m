Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CF7730053
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245073AbjFNNpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbjFNNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C031FFA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DEA641ED
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7223C433C8;
        Wed, 14 Jun 2023 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686750336;
        bh=o3exFAy/I8i9TTORrbT2rsCyqzoejgEKi9bVo660uSY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gK84fm8wVd/ePYHcLYYkrK9xbgHptYdMIkIIFAgeQ4XpYk4TQTNVAg+PeYXo4Scd1
         bCFtuf5PaDlcLn7jnRucDnbyamgUuYf7M2LlNNhcc9PrWgLa+3G333CpQym+e9uPBF
         ohyiiWuSr034Zi6+YgPhb+ZJrqLNbdfVYyyOEbeq0JhXp1+FnSYYnistffF5NB9LKY
         tojgKbG47TRFWRLHyng14xF0xWe+mZDvEav6NZW4u/yqfY3eIYvaq9lx/mFjIMTMhP
         NiX+VioigWOzpHCTGlqLbr2yVKQo/MArPdoGXavINY/2BQgbCKApfqjPGbyLR9DSC4
         5zuPBKy9DTXHQ==
Message-ID: <4849295d-9aef-836f-0e5f-063e2075380a@kernel.org>
Date:   Wed, 14 Jun 2023 15:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
To:     Joel Fernandes <joel@joelfernandes.org>
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
 <841849b5-1f9c-4f0e-2de8-1da278256888@kernel.org>
 <CAEXW_YQ7vEakRcJgva_PYEnsj4ZLafH-pXQiJ5STCkM7dQAttg@mail.gmail.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAEXW_YQ7vEakRcJgva_PYEnsj4ZLafH-pXQiJ5STCkM7dQAttg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 17:32, Joel Fernandes wrote:
> On Tue, Jun 13, 2023 at 9:43 AM Daniel Bristot de Oliveira
> <bristot@kernel.org> wrote:
> [...]
>>> On Mon, Jun 12, 2023 at 1:21 PM Daniel Bristot de Oliveira
>>> <bristot@kernel.org> wrote:
>>> [...]
>>>>> On Thu, Jun 8, 2023 at 11:58 AM Daniel Bristot de Oliveira
>>>>> <bristot@kernel.org> wrote:
>>>>>>
>>>>>> From: Juri Lelli <juri.lelli@redhat.com>
>>>>>>
>>>>>> Starting deadline server for lower priority classes right away when
>>>>>> first task is enqueued might break guarantees, as tasks belonging to
>>>>>> intermediate priority classes could be uselessly preempted. E.g., a well
>>>>>> behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
>>>>>> there are still CPU cycles available for NORMAL tasks to run, as they'll
>>>>>> be running inside the fair deadline server for some period of time.
>>>>>>
>>>>>> To prevent this issue, implement a starvation monitor mechanism that
>>>>>> starts the deadline server only if a (fair in this case) task hasn't
>>>>>> been scheduled for some interval of time after it has been enqueued.
>>>>>> Use pick/put functions to manage starvation monitor status.
>>>>>
>>>>> Me and Vineeth were discussing that another way of resolving this
>>>>> issue is to use a DL-server for RT as well, and then using a smaller
>>>>> deadline  for RT. That way the RT is more likely to be selected due to
>>>>> its earlier deadline/period.
>>>>
>>>> It would not be that different from what we have now.
>>>>
>>>> One of the problems of throttling nowadays is that it accounts for a large window
>>>> of time, and any "imprecision" can cause the mechanism not to work as expected.
>>>>
>>>> For example, we work on a fully-isolated CPU scenario, where some very sporadic
>>>> workload can be placed on the isolated CPU because of per-cpu kernel activities,
>>>> e.g., kworkers... We need to let them run, but for a minimal amount of time, for
>>>> instance, 20 us, to bound the interference.
>>>>
>>>> The current mechanism does not give this precision because the IRQ accounting
>>>> does not account for runtime for the rt throttling (which makes sense).
>>>
>>> I lost you here, "Runtime for the rt throttling" does not make much
>>> sense to me as a statement.
>>
>> Both update_curr_rt() and update_curr_dl() use rq_clock_task() as clock. update_rq_clock_task()
>> reduces the irq_delta from task's clock (inside #ifdef CONFIG_IRQ_TIME_ACCOUNTING), and this
>> clock is used to throttling.
> 
> That was a much better description. You're basically saying that since
> the running time of the RT class is not accounted for in the clock, it
> affects the throttling and unthrottling times. I actually ran into a
> similar issue on Android I recall, where the RT time was showing up as
> CFS load if I recall.
> 
> For RT throttling though, in our testing the time scales are large
> enough (for our usecase) that such time stealing wasn't an issue. I am
> going for something that is practical and that works, does not have to
> be perfect since it has been several years now with these problems and
> leaving RT throttling broken is probably not a good thing.

By postponing the enqueue/replanishment of the DL server here, we are fixing the
problem in a practical way, that works without breaking existing useful properties &
use-cases.

[...]
>>> not seeing how that is related to creation of a DL-server for the RT
>>> class. Maybe describe your point a bit more clearly?
>>
>> This patch is targeting a better way to avoid SCHED_OTHER starvation.
>> Having a DL server for RT class does not help on that. We need to boost
>> SCHED_OTHER.
> 
> Oh, actually the problem of boosting SCHED_OTHER is a bit orthogonal
> to what I said. I was not saying not to boost SCHED_OTHER, I was
> talking more about this particular patch and using an DL-based RT
> server to mitigate that issue. The boosting is already handled in
> previous patches with the DL-server.

The boosting of the previous patch is breaking FIFO priority. This patch fixes that
single point without touching and or breaking SCHED_DEADLINE/EDF properties. With
these things in place we do not mitigate, we fix the problem.

[...]
>>>>> Another approach could be to implement the 0-laxity scheduling as a
>>>>> general SCHED_DEADLINE feature, perhaps through a flag. And allow DL
>>>>> tasks to opt-in to 0-laxity scheduling unless there are idle cycles.
>>>>> And then opt-in the feature for the CFS deadline server task.
>>>>
>>>> A 0-laxity scheduler is not as simple as it sounds, as the priority also depends
>>>> on the "C" (runtime, generally WCET), which is hard to find and embeds
>>>> pessimism. Also, having such a feature would make other mechanisms harder, as
>>>> well as debugging things. For example, proxy-execution or a more precise
>>>> schedulability test...
>>>
>>> I think you did not read my email properly, I was saying make the
>>> 0-laxity default-off and the opt-in for certain DL tasks. That may
>>> work perfectly well for a system like ChromeOS where likely we will
>>> use the DL server as the sole deadline task and opt-in for the
>>> 0-laxity. Then we don't need watchdog hacks at all and it all cleanly
>>> works within the DL class itself. There are the drawbacks of the
>>> pessimism/locking  etc (I already knew that by the way as the obvious
>>> drawbacks of 0-laxity) but I am not immediately seeing how this
>>> CFS-watchdog with 0-laxity is any different from the DL-server itself
>>> having such a property. If you really have a concrete point on why
>>> that won't work, and if you could clarify that more clearly why a
>>> watchdog is better than it, that would be great.
>>
>>
>> I think you are overloading a term and a goal, and this makes your
>> thoughts ambiguous.
> 
> Well the term was mentioned in this series cover letter as well. ;-)

This term was mentioned also on my slides, and also on the other threads, but
not alone...

> 
>> 0-laxity is a point in time. What do you want to do at 0-laxity? Do you
>> want to run or start/replenish?
> 
> You could do either.

No, these are two different things depending on the current ready queue status.

It could be run a bit earlier than 0-laxity. Or
> could you just push it out to run in the next period if it has the
> flag.

The improvements on top of this patch is to postpone the enqueue/replenish to the 0-laxity
time. By doing so, the task receives a new period (and so deadline) a period ahead.

> 
> Here is the definition of 0-laxity as I understand it. Please correct
> me as I have not done a phD in these things like you ;-)
> 
> Laxity, also known as slack time,

laxity = absolute deadline - activation time - runtime.

is the amount of time that a task
> can be delayed without causing a missed deadline.

If you look at the task alone! e.g, if it does not face preemption!

A 0-laxity task is
> one that has no more time to spare and must be executed immediately

and not be preempted!

to
> avoid missing its deadline.

Again, you are looking at the task alone.

> And here's where I need your input: If we take all admitted DL tasks
> and run it at their respective 0-laxity times or slightly earlier,
> then in-theory, they should all meet their deadlines correctly?
For all tasksets, no!

There might be a taskset here o there that creates such timeline under EDF,
but it is not always true that a task under EDF will wait until the 0-laxity
time for them to run. EDF is working conserving.

For a working conserving scheduler to build such a timeline, it needs to
have no idle time. Then, lets get the classical single core assumptions
(these servers are per-cpu).

- Assuming single-core/partitioned scheduler.
- Assuming periodic tasks with deadline = period
- Assuming a task set with the sum of each task utilization = 1
- Assuming all tasks are dispatched at the same time (critical instant)
- Assuming all tasks will run for their entire runtime, without blocking

(so... the thing that EDF is optimum... fully loaded...)

Even so you will not have EDF always creating such timeline because the
task with the earliest deadline will run first, still deadlines will be met.

For example:

t1 = 5/10
t2 = 5/10

Each task you pick first will run 5 unities of time before the "0-laxity time".

If there is a scheduler that always build a timeline like you want, it will not
schedule the taskset I mentioned... thus.. it will schedule less than EDF.

> 
> Now, I don't really mean to run it exactly at 0-laxity. It could be
> run a bit earlier to factor in sleep times, locking time, preemptions
> etc.

For you to force the delay... you would need to do things like... injecting idle?

Measuring these values is worst than measuring the runtime... you are pilling
up complexity.

I mean with SCHED_DEADLINE, you really can't control those things
> anyway -- so even if  you run the DL task as soon as possible, you
> might still miss your deadline.

If the taskset is schedulable... EDF will. The overheads are part of the problem
for any real implementation, and moving to more complex scheduling design will
only make those things worse.

Or at 0-laxity, push its deadline out
> to the next period and consider it "activated". I am just thinking out
> loud.
> 
> That could break EDF the way it is now. However, it could be an
> interesting idea that could be developed into a better idea.  A DL
> task does not have to run immediately to meet its deadline (it could
> be run later as well)and that I know for a fact -- so why not add
> this flexibility within SCHED_DEADLINE itself rather than inventing a
> hack (and by hack I mean only this patch, not the other patches from
> Peter or the idea of CFS boosting).
This "hack" is not inside the deadline.c because it is a PoC... in the next version
it will not in fair.c anymore, and it will part of deadline. A deferred server start.

I think you are focusing here in the code, not in the idea. We said we will improve
the code.

> 
> My impression is the other (DL tasks without flag) should still have
> their promised bandwidth so it is not mixing 2 schedulers.If this
> series gets stalled for some reason, I would probably explore such an
> idea in my own time later.
> 
>> In the previous discussions, we mentioned using a scheduler that uses
>> it as a way to prioritize the task (to run). That is an overkill, as
>> it would be another scheduler. That is the first interpretation for
>> 0-laxity in this thread, mainly associated with the word "scheduling"
>> (not only I read that way).
>>
>> In this patch, Juri's PoC shows that if we defer the DL server start
>> (replenish) for a point in the future, we can keep the fixed-priority
>> order of the schedulers, boosting SCHED_OTHER if it starves,
>> without breaking EDF.
>>
>> If you see the cover, I mentioned using the 0-laxity point in time to
>> activate the DL server under EDF. In that way, at the 0-laxity point,
>> the DL server is replenished with runtime and deadline as
>> "now" + period. With that implemented...
>>
>> In the base case:
>>   it is never activated.
>>
>> In the Busy-loop FIFO case:
>>  Busy-loop FIFO task run starving OTHER for (period - runtime):
>>    SCHED_OTHER server will be started at 0-laxity and get the
>>    processor for its runtime immediately because there are no DL
>>    tasks.
>>
>> In the presence of DL & RT tasks:
>>  DL and RT Starving OTHER for (period - runtime):
>>    SCHED_OTHER server will be started & scheduled under EDF, before or
>>    after the other DL tasks, following EDF. Anyways, before
>>    returning to the SCHED_RT.
>>
>> So, in this way, the OTHER will be boosted over SCHED_RT without breaking
>> SCHED_DEADLINE tasks.
>>
>> In an 0-laxity scheduler, the server would run at 0-laxity, jumping in
>> front of DL tasks... that would break EDF. It would be mixing two
>> schedulers in one. It is not required and likely not a good idea either.
> 
> I am still missing why some tasks cannot be run at close to 0-laxity
> time, and as opt-in.And if the DL-server is the sole task running,
> then there's nothing else to break.

If it is the sole (DL!) task running, this patch is equivalent to place the task
to run at 0-laxity. I explained this the previous email.

> In fact, I am not immediately seeing how this can break SCHED_DEADLINE
> if you allow at most 1-task to run at close to 0-laxity. The others
> should still have their promised bandwidth so it is not mixing 2
> schedulers, you just delay the DL-server till it's close to the
> 0-laxity. What am I missing?
if you want to do a 0-laxity scheduler like decision, that is, the task will
start running at 0-laxity, and once the task starts to run it will not be
preempted so it can finish before its deadline, you will break other EDF
tasks deadline in a schedulable task set.

It is not hard to create a timeline that breaks it...

server 50/1000 postponed by 950.
task 1/10.

At time 950 the server starts not to be preempted for 50.
at 951 the 1/10 starts... BOOM.

Expanding the idea in this patch, the task will be enqueued at 950,
with a deadline at 1950... so it will not break the EDF scheduler,
while still getting the time on top of SCHED_RT.

The SCHED_RT is the problem we are addressing here, because of lack of
fairness w.r.t SCHED_OTHER.

Moreover, DL tasks run when RT rq is throttled. So, that 1/10 preemption
on top of the deferred server happens in the current behavior. Thinking twice,
with this patch in place, SCHED_OTHER will also recover that time, which makes
even more sense.

(noticing that here we are only scratching the consequences, as anything that
is utilization based on our design will be broken as the system starts because
this is always enabled).

> Perhaps you mean the algorithm needs to push the new period/deadline
> to a later time at the 0-laxity. 

This is the idea behind this patch ^^^^ This is the different between running
and replenishing I mention on previous emails.

That's also fine with me. But some
> variation of the idea is possible AFAICS (again could be missing
> something that mathematically makes this impossible).

you are looking for a fragment of the information... "0-laxity time," with
a single task in mind - not in the context of a scheduler.

> 
>> In the cover, I mentioned improving this patch, so maybe watchdog is not
>> the appropriate name. 0-laxity server is not a good name either because
>> it might induce people to think that the server will RUN at 0-laxity
>> while it will actually be replenished at 0-laxity. Maybe a deferred server
>> might be a better name.
> 
> Yeah maybe a deferred server could be a better name.
> 
>>>> In a paper, the scheduler alone is the solution. In real life, the solution
>>>> for problems like locking is as fundamental as the scheduler. We need to keep
>>>> things simple to expand on these other topics as well.
>>>>
>>>> So, I do not think we need all the drawbacks of a mixed solution to just fix
>>>> the throttling problem, and EDF is more capable and explored for the
>>>> general case.
>>>
>>> Again, I was saying making it opt-in seems like a reasonable approach
>>> and just enabling such property for the DL server.
>>
>> Can we have a "deferred DL server?" is that your question?
>>
>> If so, I think so. But we have other points to look first. DL servers are per-cpu,
>> so they break global. We need to think about an interface... and there are
>> other points that we need to understand before trying some other more
>> optimized cases.
> 
> You mean an interface for the DL server params? Those can be similar
> to other sched knobs. And then boot with a CONFIG option and boost CFS
> things by default if RT is active. Would that work or did you mean
> something else by interface?
> 
>>>>> Lastly, if the goal is to remove RT throttling code eventually, are
>>>>> you also planning to remove RT group scheduling as well? Are there
>>>>> users of RT group scheduling that might be impacted? On the other
>>>>> hand, RT throttling / group scheduling code can be left as it is
>>>>> (perhaps documenting it as deprecated) and the server stuff can be
>>>>> implemented via a CONFIG option.
>>>>
>>>> I think that the idea is to have the DL servers eventually replace the group
>>>> schedule. But I also believe that it is better to start by solving the
>>>> throttling and then moving to other constructions on top of the mechanism.
>>>
>>> Hmm. For throttling at the root level yes, but  I am not seeing how
>>> you can replace the group scheduling code for existing users of RT
>>> Cgroups with this. The throttling in the RT group scheduling code is
>>> not exactly only about "not starving CFS", it is more related to
>>> letting RT groups run with certain bandwidth. So you cannot really
>>> delete it if there are real users of that code -- you'll have to
>>> migrate those users away first (to an alternate implementation like
>>> DL).  If there are no users of RT group scheduling, that's lovely
>>> though. We don't use it in ChromeOS fwiw.
>>
>> The idea behind the base patchset from Peter is solid and is the best way we
>> can start, and starting with avoiding OTHER starvation is an easy starting point.
>> Many people will benefit from it - like all the people that ping me
>> because of the RT_RUNTIME_GREED (including Google in the past)... which is
>> the starting point of all this work.
> 
> Right, you know I am on the same page about that. I presented exactly
> the same stuff at 2 conferences in 2 countries this year.
> 
>>
>> Generalizing it requires time, but it will happen... and you know that Juri and I
>> care about Chromeos' use case, as I have been discussing this with you all and
>> even participating in Google/chrome focused meetings about sched...
>> at 6 pm our time ;-).
> 
> I totally appreciate that, please don't get offended, we go a long way
> back as friends ;-)

I did not get offended, and nothing changes on our friendship :-). I am just
clarifying you things we know - even before this rebase... We are aware of
Chrome needs, as well as general RT Linux needs.

The basic idea behind this patch works for all cases and is unlocking this
situation. The code will be improved in the next version.

Thanks
-- Daniel

And I really want to help, I am not trying to
> prove I am an expert compared to you. I just want to get it *done* and
> not have to wait for more years. You can see my 2 presentations this
> year on this topic alone -- I travelled to 2 countries leaving my
> family behind to discuss these.
> 
> Many thanks,
> 
>  - Joel

