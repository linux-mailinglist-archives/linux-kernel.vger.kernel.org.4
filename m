Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9B7746BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjGDIXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDIXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:23:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 615E61AC;
        Tue,  4 Jul 2023 01:23:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C9ED2F4;
        Tue,  4 Jul 2023 01:24:18 -0700 (PDT)
Received: from [10.57.28.39] (unknown [10.57.28.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCD683F73F;
        Tue,  4 Jul 2023 01:23:32 -0700 (PDT)
Message-ID: <be79b206-01f8-f3e1-4107-ae6c662cbf47@arm.com>
Date:   Tue, 4 Jul 2023 09:23:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND][PATCH v2 3/3] schedutil: trace: Add tracing to capture
 filter out requests
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, delyank@fb.com,
        qyousef@google.com, kernel test robot <lkp@intel.com>
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
 <20230522145702.2419654-4-lukasz.luba@arm.com>
 <20230531183105.r5tqpdx5axoogkzp@airbuntu>
 <a0101269-1d8b-d4e1-52b4-250a99b395fa@arm.com>
 <20230630120122.oqy4q42bl5gy6bfd@airbuntu>
 <20230630132507.hggzz5g2odrabii6@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230630132507.hggzz5g2odrabii6@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 6/30/23 14:25, Qais Yousef wrote:
> On 06/30/23 13:01, Qais Yousef wrote:
>> On 06/20/23 18:52, Lukasz Luba wrote:
>>> Hi Qais,
>>>
>>> I have somehow missed your feedback on this series.
>>>
>>> On 5/31/23 19:31, Qais Yousef wrote:
>>>> On 05/22/23 15:57, Lukasz Luba wrote:
>>>>> Some of the frequency update requests coming form the task scheduler
>>>>> might be filter out. It can happen when the previous request was served
>>>>> not that long ago (in a period smaller than provided by the cpufreq driver
>>>>> as minimum for frequency update). In such case, we want to know if some of
>>>>> the frequency updates cannot make through.
>>>>> Export the new tracepoint as well. That would allow to handle it by a
>>>>> toolkit for trace analyzes.
>>>>>
>>>>> Reported-by: kernel test robot <lkp@intel.com> # solved tricky build
>>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>> ---
>>>>>    include/trace/events/sched.h     |  4 ++++
>>>>>    kernel/sched/cpufreq_schedutil.c | 10 ++++++++--
>>>>>    2 files changed, 12 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
>>>>> index dbfb30809f15..e34b7cd5de73 100644
>>>>> --- a/include/trace/events/sched.h
>>>>> +++ b/include/trace/events/sched.h
>>>>> @@ -739,6 +739,10 @@ DECLARE_TRACE(uclamp_update_tsk_tp,
>>>>>    	TP_PROTO(struct task_struct *tsk, int uclamp_id,  unsigned int value),
>>>>>    	TP_ARGS(tsk, uclamp_id, value));
>>>>> +DECLARE_TRACE(schedutil_update_filtered_tp,
>>>>> +	TP_PROTO(int cpu),
>>>>> +	TP_ARGS(cpu));
>>>>> +
>>>>>    #endif /* _TRACE_SCHED_H */
>>>>>    /* This part must be outside protection */
>>>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>>>> index f462496e5c07..4f9daf258a65 100644
>>>>> --- a/kernel/sched/cpufreq_schedutil.c
>>>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>>>> @@ -6,6 +6,8 @@
>>>>>     * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>     */
>>>>> +EXPORT_TRACEPOINT_SYMBOL_GPL(schedutil_update_filtered_tp);
>>>>> +
>>>>>    #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
>>>>>    struct sugov_tunables {
>>>>> @@ -318,8 +320,10 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>>>>>    	ignore_dl_rate_limit(sg_cpu);
>>>>> -	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
>>>>> +	if (!sugov_should_update_freq(sg_cpu->sg_policy, time)) {
>>>>> +		trace_schedutil_update_filtered_tp(sg_cpu->cpu);
>>>>>    		return false;
>>>>> +	}
>>>>
>>>> Can't we have something more generic here too? Are you interested to count
>>>> these events? How do you plan to use it?
>>>
>>> The plan is to record those events, count them and maybe adjust the FW
>>> if the frequency switching capabilities are too low, e.g. 4ms...
>>
>> You mean as part of tuning step for the system or at runtime? The latter seems
>> to indicate for a proper interface instead.

Not at runtime, the FW change or maybe even the uC would be needed for
this. Therefore, our client which experiments with the new platform
can run the analysis and spot this. Then it can change the FW
if there was an issue, or maybe even upgrade the HW if there are severe
issues with delivering needed performance on time (e.g. in high display
refresh rates and first-frame drops).

>>
>> IMHO I think the current filtering mechanism needs a bit of a massage.
>>
>> One thing I think we must do is to ignore the filter if there's a big sudden
>> change in requested frequency. Like for instance if a big task migrates. Then
>> prev_cpu should go to lower freq sooner, and new_cpu should change to higher
>> frequency sooner too. The filtering makes sense only in steady state situation
>> where we are ramping up or down gradually.

This is kind of a heuristic, which is biased for mobiles IMO.

>>
>> If no one beats me to it, I'll propose something in that regard.
>>
>>>
>>> We need those numbers to point out that there is a need for faster
>>> FW micro-controller to serve those incoming requests.
>>
>> I think there's a big assumption here that the filter is always set correctly
>> ;-)

In our case, it is set correctly, the value is coming directly from FW
[1]. It is the FW+HW limit, so not much to do with this in the kernel.

>>
>>>
>>>>
>>>> I think this will be a very noisy event by the way.
>>>
>>> Could be, but on the other hand for those statistical analysis
>>> 'the more the better'. It will also depend on number of
>>> CPUs in the cluster, e.g. 4 CPUs vs 1 CPU.
>>>
>>> I don't know when we will switch to this per-cpu cpufreq mode
>>> when all CPUs behave like independent DVFS. Juno mainline kernel and FW
>>> supports that mode. We would have to compare those two modes and
>>> measure how much we gain/loose when using one and not the other.
>>>
>>> Furthermore, we already suspect some of our integration testing for
>>> EAS-mainline (on Juno) failing due to filtered out requests. How much
>>> that would impact other boards - it would be nice to see in traces.
>>
>> Another problem I think we have is that the DVFS headroom value should be
>> a function of this filter. At the moment it is hardcoded to a random value
>> which causes power issue.

It's not a random value, as you can see in [1]. This is the main goal
for this $subject - provide information with proper test that the FW
or HW change is needed. If you like to have a decent performance in
your Linux based solution, the faster FW/HW would be needed. I don't
want to put more hacks or heuristics which try to workaround performance
issues with the HW. E.g. if someone instead of a 200MHz uC running fast
FW would put 100MHz uC than should get quality data from integration
tests, that such a design might not work well with recent OSes and apps.
Currently those kind of 'design' checks are very hard, because require
sophisticated knowledge and we are trying to lower that bar for more
engineers.

>>
>> So to summarize I think there are two improvements required (and if anyone has
>> the time to try them out go ahead otherwise I'll get to it):
>>
>>   1. The filter should only be applied if the history hasn't changed. ie: we are
>>      gradually increasing or decreasing PELT. Otherwise we should honour sudden
>>      changes ASAP.
>>   2. DVFS headroom should be a function of the filter. 25% is too high for
>>      500us. It could be too low for 10ms (I don't know).
> 
> To expand a bit more since it's related. Our  migration margins should depend
> on the tick value instead of random magic numbers they are today. More
> precisely the balance_interval. If there's a misfit task, then we should
> upmigrate it at wake up only if we think it'll become misfit before the load
> balancer kicks in. Otherwise the load balancer should do the correction if it
> becomes long running/misfit. If the sys admin wants to speed up/slow down
> migration it should be throw controlling PELT IMO and not these magic margin
> values - which are hardcoded to random values at the moment anyway that are not
> suitable for every system.
> 
> And since we decoupled overutilized from misfit lb; I think our definition
> should improve to better detect when the system needs to disable packing and
> starts spreading. Current check for overutilized based on misfit is no longer
> adequate IMO. Especially when there's a single misfit task in the system.
> 
> Again, just sharing thoughts in case someone interested to work on this before
> I get a chance to share any patches ;-)

Those are all heuristics and some of your ideas are going very beyond
the $subject. As I said the main goal for the $subject is to
deliver information that the FW/HW might need a re-design (maybe even
a more silicon for the uC).

I cannot stop you from creating a dedicated thread with your patches,
though ;)

Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/v6.4/source/drivers/cpufreq/scmi-cpufreq.c#L224
