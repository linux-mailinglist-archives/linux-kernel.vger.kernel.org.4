Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686E36D9CDA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbjDFP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbjDFP7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:59:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4F4EA255
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:58:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF92B169E;
        Thu,  6 Apr 2023 08:59:38 -0700 (PDT)
Received: from [192.168.178.92] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A7673F6C4;
        Thu,  6 Apr 2023 08:58:52 -0700 (PDT)
Message-ID: <97b85280-4ce6-21f8-1a62-c997c4d90c35@arm.com>
Date:   Thu, 6 Apr 2023 17:58:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
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
References: <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <20230223153700.55zydy7jyfwidkis@airbuntu>
 <CAKfTPtDVGcvmR5BoJpyoOBE19PcWZP+6NjSD7MnJyBAc7VMnmg@mail.gmail.com>
 <20230301172458.intrgsirjauzqmo3@airbuntu>
 <60fe6b16-0fc6-6ac4-f8fe-87ae9b6592c0@arm.com>
 <20230403144539.46iwihlrzigsx5iu@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230403144539.46iwihlrzigsx5iu@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 03/04/2023 16:45, Qais Yousef wrote:
> Hi Diemtar
> 
> On 03/23/23 17:29, Dietmar Eggemann wrote:
>> On 01/03/2023 18:24, Qais Yousef wrote:
>>> On 03/01/23 11:39, Vincent Guittot wrote:
>>>> On Thu, 23 Feb 2023 at 16:37, Qais Yousef <qyousef@layalina.io> wrote:
>>>>>
>>>>> On 02/09/23 17:16, Vincent Guittot wrote:

[...]

>>>>> If we improve util response time, couldn't this mean we can remove util_est or
>>>>> am I missing something?
>>>>
>>>> not sure because you still have a ramping step whereas util_est
>>>> directly gives you the final tager
>>
>> util_est gives us instantaneous signal at enqueue for periodic tasks,
> 
> How do you define instantaneous and periodic here? How would you describe the
> behavior for non periodic tasks?

Instantaneous is when the max value is available already @wakeup. That 
is the main use case for util_est, provide this boost to periodic tasks. 
A non-periodic task doesn't benefit from this. Work assumption back then 
was that the important task involved here are the periodic (back then 
60Hz, 16.67 ms period) tasks of the Android display pipeline.

>> something PELT will never be able to do.
> 
> Why? Isn't by selecting a lower pelt halflife we achieve something similar?

You get closer but you still would need time to ramp-up. That's without 
util_est.

[...]

>>>> the 25% is not related to the ramping time but to the fact that you
>>>> always need some margin to cover unexpected events and estimation
>>>> error
>>>
>>> At the moment we have
>>>
>>> 	util_avg -> util_est -> (util_est_faster) -> util_map_freq -> schedutil filter ==> current frequency selection
>>>
>>> I think we have too many transformations before deciding the current
>>> frequencies. Which makes it hard to tweak the system response.
>>
>> To me it looks more like this:
>>
>> max(max(util_avg, util_est), runnable_avg) -> schedutil's rate limit* -> freq. selection
>>                              ^^^^^^^^^^^^ 
>>                              new proposal to factor in root cfs_rq contention
> 
> These are still 5 stages even if written differently.
> 
> What if background tasks that are causing the contention? How can you tell it
> to ignore that and NOT drive the frequency up unnecessary for those non
> important ones? If userspace is fully aware of uclamp - this whole discussion
> wouldn't be necessary. And I still have a bunch of fixes to push before
> uclamp_max is actually usable in production.

You're hinting to the other open discussion we have on uclamp in feec():

https://lkml.kernel.org/r/20230205224318.2035646-1-qyousef@layalina.io

IMHO, this is a different discussion. No classification of tasks here. 

>> Like Vincent mentioned, util_map_freq() (now: map_util_perf()) is only
>> there to create the safety margin used by schedutil & EAS.
> 
> Yes I know and that's not the point. The point is that it's a chain reaction.
> 25% percent headroom is already very aggressive and causes issues on the top
> inefficient ends of the cores. And when util is high, you might end up in
> a situation where you skip frequencies. Making everything go up faster without
> balancing it with either enabling going down faster too or tune this value can
> lead to power and thermal issues on powerful systems.

I try to follow here but I fail. You're saying that the safety margin is 
too wide and in case util is within the safety margin, the logic is 
eclipsed by going max or choosing a CPU from a higher CPU capacity 
Perf-domain?

Wouldn't `going down faster` contradict with schedutil's 20ms down rate 
limit?

> 
> I think all we need is controlling pelt halflife and this one to tune the
> system to the desired trade-off.
> 
>>
>> * The schedutil up/down filter thing has been already naked in Nov 2016.
>> IMHO, this is where util_est was initially discussed as an alternative.
> 
> Well, I don't see anyone not using a down filter. So I'm not sure util_est has
> been a true alternative.

Definitely not in down direction. util_est is 0 w/o any runnable tasks. 
And blocked utilization is decaying much faster than your 20ms down rate 
limit.

>> We have it in mainline as well, but one value (default 10ms) for both
>> directions. There was discussion to map it to the driver's
>> translation_latency instead.
> 
> Which can be filled wrong sometimes :(
> 
>>
>> In Pixel7 you use 0.5ms up and `5/20/20ms` down for `little/medium/big`.
>>
>> So on `up` your rate is as small as possible (only respecting the
>> driver's translation_latency) but on `down` you use much more than that. 
>>
>> Why exactly do you have this higher value on `down`? My hunch is
>> scenarios in which the CPU (all CPUs in the freq. domain) goes idle,
>> so util_est is 0 and the blocked utilization is decaying (too fast,
>> 4ms (250Hz) versus 20ms?). So you don't want to ramp-up frequency
>> again when the CPU wakes up in those 20ms?   
> 
> The down filter prevents changing the frequency to a lower value. So it's
> a holding function to keep the residency at a higher frequency for at least
> 20ms. It is, sort of, similar to the max() functions you used above. The max
> function will allow you to follow the fasting ramping up signal on the way up,
> and the slowest ramping down one on the way down.
> 
> I think this is more deterministic way to do it.

But a faster PELT wouldn't help here, quite the opposite.
[...]

>>>> Also IIUC Dietmar's results, the problem seems more linked to the
>>>> selection of a higher freq than increasing the utilization;
>>>> runnable_avg tests give similar perf results than shorter half life
>>>> and better power consumption.
>>>
>>> Does it ramp down faster too?
>>
>> Not sure why you are interested in this? Can't be related to the
>> `driving DVFS` functionality discussed above.
> 
> If you change the reaction time to be more aggressive in going up, then it's
> only natural to have it symmetrical so your residency on the power hungry OPPs
> don't go over the roof and end up with thermal and power issues.

But you apply this 20ms down rate limit on the big cores too?

> I am concerned about us biasing towrads perf first too much and not enabling
> sys admins to select a proper trade off for their system and use case. Which
> are not static. The workloads the system needs to accommodate to are abundant
> and operating conditions could change. And the diversity of hardware available
> out there is huge - I am not sure how can we expect we can have one response to
> accommodate for all of them.
> 
> What I'm trying to push for here is that we should look at the chain as one
> unit. And we should consider that there's important trade-off to be had here;
> having a sensible default doesn't mean the user shouldn't be allowed to select
> a different trade-off. I'm not sure the problem can be generalized and fixed
> automatically. But happy to be proven wrong of course :-)
> 
> FWIW, I'm trying to tweak all these knobs and study their impact. Do you mind
> pasting the patch for load_avg consideration so I can take it into account too
> in my experiments?

Just posted it:

https://lkml.kernel.org/r/20230406155030.1989554-1-dietmar.eggemann@arm.com

