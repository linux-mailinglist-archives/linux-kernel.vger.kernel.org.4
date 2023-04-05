Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC1D6D7A59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbjDEKus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjDEKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:50:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05DB84C19;
        Wed,  5 Apr 2023 03:50:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 470D31684;
        Wed,  5 Apr 2023 03:51:29 -0700 (PDT)
Received: from [10.57.20.121] (unknown [10.57.20.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BCB13F73F;
        Wed,  5 Apr 2023 03:50:42 -0700 (PDT)
Message-ID: <96a920d4-8614-65ce-1c81-2b72a3ff9036@arm.com>
Date:   Wed, 5 Apr 2023 11:50:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] sched/tp: Add new tracepoint to track uclamp set from
 user-space
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com
References: <20230322151843.14390-1-lukasz.luba@arm.com>
 <20230322151843.14390-2-lukasz.luba@arm.com>
 <20230403134606.amdxfmr5fb544xnv@airbuntu>
 <bdaebc90-ca39-1301-c7ba-e367f8406d09@arm.com>
 <20230404171720.ntktoqixkj5f77ag@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230404171720.ntktoqixkj5f77ag@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/23 18:17, Qais Yousef wrote:
> On 04/03/23 17:47, Lukasz Luba wrote:
>> Hi Qais,
>>
>> On 4/3/23 14:46, Qais Yousef wrote:
>>> Hi Lukasz!
>>>
>>> On 03/22/23 15:18, Lukasz Luba wrote:
>>>> The user-space can set uclamp value for a given task. It impacts task
>>>> placement decisions made by the scheduler. This is very useful information
>>>> and helps to understand the system behavior or track improvements in
>>>> middleware and applications which start using uclamp mechanisms and report
>>>> better performance in tests.
>>>
>>> We do have uclamp trace events in sched_tp, why are they not sufficient?
>>>
>>> 	https://github.com/qais-yousef/sched_tp/blob/main/sched_events.h#L233
>>>
>>> Do you really want to know the exact time the value has changed?
>>
>> Yes, that's why these new are triggered instantly after userspace wanted
>> to set the new uclamp values. We are going to have a few different
>> uclamp implementations: one in mainline and X in Android vendor kernels.
> 
> This is not true. As you can see everyone tries to push fixes for issues they

Could you clarify which part is not true?
1. We have X vendor hook implementations how uclamp is interpreted + one
    upstream
2. we are going to have such situation for a while (till we don't meet
    requirements in mainline uclamp, so the hooks can be removed and
    we would have the same mechanism under the hood that we understand)
3. the user-space sets uclamp value via syscall


> find, but this not happening fast enough and they get forced to carry out of
> tree stuff at the end. Out of tree stuff for the broken bits that is.
> 
>> The goal is to have only one... We will have to experiment to find
> 
> This statement gives a very strong message to everyone out here. And I'd like
> to stress strongly that this is NOT true. Broken bits, yes. But essential bits
> that works are used the same.

Could you elaborate this?

This is how I view the solution with uclamp, but I'm afraid we have
different views:
Uclamp is part of the control algorithms in a closed feedback loop. The
apps want to use (as stated in the latest kernel doc) uclamp in order
get desired performance (e.g. no frame drops) in an environment, which:
1. can change with a CPUs configuration that the app was installed
    (single app from a repo want to run efficient on various devices;
     those devices create different environment, from the beginning)
2. the thermal conditions can change in run-time, so the capacity of
    the platform might change (even to a point that some CPUs is out)
3. has access to a dedicated accelerators, which can handle some of
    heavy computations from the CPUs (e.g. those with neural networks)
4. drivers and devices have different capabilities e.g. in terms of
    fast DVFS change, which can be and issue in this case

When the uclamp algorithm, which interprets the individual tasks' values
and runqueue value, can be different, then this is a different solution.
In such situation every platform might have different solution.

We are going to focus on mainline uclamp development. We want to know
if the frequency cannot be changed due to some slow HW or a huge traffic
in the system of various tasks/runqueues wanted to change the freq, or
just wrong setting in the schedutil filter. We are also interested in
measuring the 'delay' from the uclamp new request till the HW getting
it actually. All of this would shape the solutions 'quality'.

I don't know if vendors justify their vendor hook uclamp implementation
as a fix for 'broken bits' or a 'value-added'.

> 
> We can do a better job and fix things faster upstream. I am committed to
> sorting all these stuff out anyway.
> 
>> the behavior of those algorithms and understand the differences. Since
>> uclamp is part of this 'control-chain' of CPU frequency and also
>> task placement - it would be really tricky to figure our everything.
>> The analysis on traces are crucial for this.
> 
> I think the existing uclamp trace event is enough to be honest. But up to the
> maintainer if they want to add this new specific one. The two tps seem a bit of
> a clutter to me. With kprobes and bpf a lot can be done on the fly if you want
> to reverse engineer some stuff.
> 
>>
>>>
>>> Would it make sense to introduce a generic sched_setscheduler tracepoint
>>> instead? Although this might not be necessary as I think we can use
>>> register_kprobe() to register a callback and create a new event without any
>>> additional tracepoint. sched_setscheduler() is not inlined so should be easy to
>>> hook into and create events, no?
>>
>> This looks very complex and we already have our LISA tool with the
> 
> It's not. Here's a PoC that only does a trace_printk(), it's simple. You don't
> need to do it in a module even, see below.
> 
> 	https://github.com/qais-yousef/sched_tp/compare/main...kprobe-poc
> 
> It did highlight that sugov_should_update_freq() ends up actually being inlined
> though :(. It should work for sched_setscheduler(). You'd want to use
> register_kprobe() instead for that.

Issues with that approach:
- as you said, it won't work with inline functions, so in this patch set
   example it would work 'partially' ;)
- uses trace_printk() which is not aligned method to our tool and AFAIK
   Perfetto
- would create mix of mechanisms that would push the complexity for
   our analysis tool, which we don't want. This is the complexity
   that I had in mind from SW engineering perspective.
   Maintainability and understanding of the mechanics across teams
   or even companies is not for free. Then explaining someone in
   different company that this approach won't work if the compiler
   inlined a function, so they have to rewrite the code and use
   the other approach (with tracepoint in the code) doesn't sound
   good.

> 
>> module to change the tracepoints into trace events and build them.
>> I wanted to be aligned with that design, which might look a bit
>> old-fashion but is simple IMO.
> 
> trace-cmd, bpf and I believe perf, all can do the same; and they support
> kprobes not just tracepoints.
> 
> And they all boil down to the same underlying mechanism
> 
> 	https://www.kernel.org/doc/html/v6.1/trace/kprobetrace.html
> 
> No need to re-invent a new wheel ;-)

I don't understand why you are calling this 're-invent a new wheel',
when I said this is aligned with our SW design for trace analysis.
BTW, the LISA tool is open source and anyone can use it for free [1].
I'm not developing another framework for tracepoints here, I just use
this approach.

I agree, there is a few ways of doing this. The worse thing would
be for a us to use a mix (and mess) a few of them. As you know,
our tool takes the path with one of them: tracepoints explicitly
visible to everyone in the kernel code, so you can point engineers
into it. I know, you can basically trace almost any function dynamically
which creates huge potential space. The big space of opportunity isn't
good when you want to solve the problem and share the knowledge
to others how to follow. Look at the example of tracepoints which
are used for deriving the task wake-up latency. It's easier for
engineers to see that in the code with the tracepoints, what parts
are important. Where and why the flow is going, which is a nice
example how the vast code space can been reduced.

> 
>> The 'sched_setscheduler tracepoint' might be a too big for this
>> purpose.
> 
> Sorry I am usually supportive for more tracepoints, but I feel skeptical this
> time. That said, I really don't mind if the maintainers are okay with it. So
> while I'm not convinced, but I don't have any objection either.

I hope I would convince you with those examples, so you would be less
skeptical.

Cheers,
Lukasz

[1] 
https://lisa-linux-integrated-system-analysis.readthedocs.io/en/latest/setup.html
