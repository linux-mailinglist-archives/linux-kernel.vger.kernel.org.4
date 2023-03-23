Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB4F6C6D92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjCWQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjCWQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:30:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4C4B2BF0A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:30:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F6382F4;
        Thu, 23 Mar 2023 09:30:48 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04D123F766;
        Thu, 23 Mar 2023 09:30:01 -0700 (PDT)
Message-ID: <60fe6b16-0fc6-6ac4-f8fe-87ae9b6592c0@arm.com>
Date:   Thu, 23 Mar 2023 17:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
References: <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <20230223153700.55zydy7jyfwidkis@airbuntu>
 <CAKfTPtDVGcvmR5BoJpyoOBE19PcWZP+6NjSD7MnJyBAc7VMnmg@mail.gmail.com>
 <20230301172458.intrgsirjauzqmo3@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230301172458.intrgsirjauzqmo3@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 18:24, Qais Yousef wrote:
> On 03/01/23 11:39, Vincent Guittot wrote:
>> On Thu, 23 Feb 2023 at 16:37, Qais Yousef <qyousef@layalina.io> wrote:
>>>
>>> On 02/09/23 17:16, Vincent Guittot wrote:
>>>
>>>> I don't see how util_est_faster can help this 1ms task here ? It's
>>>> most probably never be preempted during this 1ms. For such an Android
>>>> Graphics Pipeline short task, hasn't uclamp_min been designed for and
>>>> a better solution ?
>>>
>>> uclamp_min is being used in UI and helping there. But your mileage might vary
>>> with adoption still.
>>>
>>> The major motivation behind this is to help things like gaming as the original
>>> thread started. It can help UI and other use cases too. Android framework has
>>> a lot of context on the type of workload that can help it make a decision when
>>> this helps. And OEMs can have the chance to tune and apply based on the
>>> characteristics of their device.
>>>
>>>> IIUC how util_est_faster works, it removes the waiting time when
>>>> sharing cpu time with other tasks. So as long as there is no (runnable
>>>> but not running time), the result is the same as current util_est.
>>>> util_est_faster makes a difference only when the task alternates
>>>> between runnable and running slices.
>>>> Have you considered using runnable_avg metrics in the increase of cpu
>>>> freq ? This takes into the runnable slice and not only the running
>>>> time and increase faster than util_avg when tasks compete for the same
>>>> CPU
>>>
>>> Just to understand why we're heading into this direction now.
>>>
>>> AFAIU the desired outcome to have faster rampup time (and on HMP faster up
>>> migration) which both are tied to utilization signal.
>>>
>>> Wouldn't make the util response time faster help not just for rampup, but
>>> rampdown too?
>>>
>>> If we improve util response time, couldn't this mean we can remove util_est or
>>> am I missing something?
>>
>> not sure because you still have a ramping step whereas util_est
>> directly gives you the final tager

util_est gives us instantaneous signal at enqueue for periodic tasks,
something PELT will never be able to do.
 
> I didn't get you. tager?
> 
>>
>>>
>>> Currently we have util response which is tweaked by util_est and then that is
>>> tweaked further by schedutil with that 25% margin when maping util to
>>> frequency.
>>
>> the 25% is not related to the ramping time but to the fact that you
>> always need some margin to cover unexpected events and estimation
>> error
> 
> At the moment we have
> 
> 	util_avg -> util_est -> (util_est_faster) -> util_map_freq -> schedutil filter ==> current frequency selection
> 
> I think we have too many transformations before deciding the current
> frequencies. Which makes it hard to tweak the system response.

To me it looks more like this:

max(max(util_avg, util_est), runnable_avg) -> schedutil's rate limit* -> freq. selection
                             ^^^^^^^^^^^^ 
                             new proposal to factor in root cfs_rq contention


Like Vincent mentioned, util_map_freq() (now: map_util_perf()) is only
there to create the safety margin used by schedutil & EAS.

* The schedutil up/down filter thing has been already naked in Nov 2016.
IMHO, this is where util_est was initially discussed as an alternative.
We have it in mainline as well, but one value (default 10ms) for both
directions. There was discussion to map it to the driver's
translation_latency instead.

In Pixel7 you use 0.5ms up and `5/20/20ms` down for `little/medium/big`.

So on `up` your rate is as small as possible (only respecting the
driver's translation_latency) but on `down` you use much more than that. 

Why exactly do you have this higher value on `down`? My hunch is
scenarios in which the CPU (all CPUs in the freq. domain) goes idle,
so util_est is 0 and the blocked utilization is decaying (too fast,
4ms (250Hz) versus 20ms?). So you don't want to ramp-up frequency
again when the CPU wakes up in those 20ms?   

>>> I think if we can allow improving general util response time by tweaking PELT
>>> HALFLIFE we can potentially remove util_est and potentially that magic 25%
>>> margin too.
>>>
>>> Why the approach of further tweaking util_est is better?
>>
>> note that in this case it doesn't really tweak util_est but Dietmar
>> has taken into account runnable_avg to increase the freq in case of
>> contention
>>
>> Also IIUC Dietmar's results, the problem seems more linked to the
>> selection of a higher freq than increasing the utilization;
>> runnable_avg tests give similar perf results than shorter half life
>> and better power consumption.
> 
> Does it ramp down faster too?

Not sure why you are interested in this? Can't be related to the
`driving DVFS` functionality discussed above.
