Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00D866C352
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjAPPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjAPPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:08:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA42F265BA;
        Mon, 16 Jan 2023 06:56:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9727AC14;
        Mon, 16 Jan 2023 06:57:10 -0800 (PST)
Received: from [10.1.196.21] (e125579.cambridge.arm.com [10.1.196.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C86D93F67D;
        Mon, 16 Jan 2023 06:56:26 -0800 (PST)
Message-ID: <7a6182dd-89f5-69c5-4331-2f102dc0418d@arm.com>
Date:   Mon, 16 Jan 2023 14:56:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, peterz@infradead.org, qyousef@layalina.io,
        rafael@kernel.org, viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
References: <20230113134056.257691-1-vincent.guittot@linaro.org>
 <78bf2d91-0076-f748-7c6a-530dad466787@arm.com>
 <CAKfTPtCAAOvFak2FqkKv2AwnoBZ3cwbMwfnAAGqDx+Wq4Ng+zw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtCAAOvFak2FqkKv2AwnoBZ3cwbMwfnAAGqDx+Wq4Ng+zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 12:23, Vincent Guittot wrote:
> On Mon, 16 Jan 2023 at 10:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 13/01/2023 14:40, Vincent Guittot wrote:

[...]

>>> @@ -6132,6 +6135,7 @@ static inline bool cpu_overutilized(int cpu)
>>>       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
>>>       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
>>>
>>> +     /* Return true only if the utlization doesn't fit its capacity */
>>
>> s/utlization/utilization
>> s/its/CPU ?
>>
>>>       return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>>>  }
>>
>> cpu_overutilized() is the only place where we now only test for
>> !util_fits_cpu(). The new comment says we only care about utilization
>> not fitting CPU capacity.
>>
>> Does this mean the rq uclamp values are not important here and we could
>> go back to use fits_capacity()?
>>
>> Not sure since util_fits_cpu() is still coded differently:
> 
> uclamp_min is not important but uclamp_max still cap the utilization

OK, makes sense.

I.e. we could pass in `rq_util_min = 0` to avoid fetching it
unnecessary? In case `fits == 1` before the uclamp_min condition in
util_fits_cpu() it doesn't matter if we switch to return `-1` when
called from cpu_overutilized(). Detail though ...

[...]

>>> @@ -6940,12 +6945,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>>>
>>>               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
>>>                       continue;
>>> -             if (util_fits_cpu(task_util, util_min, util_max, cpu))
>>> +
>>> +             fits = util_fits_cpu(task_util, util_min, util_max, cpu);
>>> +
>>> +             /* This CPU fits with all capacity and performance requirements */
>>
>> In task_fits_cpu() `utilization and performance (better uclamp)
>> requirements` term was used. I assume it's the same thing here?
>>
>>> +             if (fits > 0)
>>>                       return cpu;
>>> +             /*
>>> +              * Only the min performance (i.e. uclamp_min) doesn't fit. Look
>>> +              * for the CPU with highest performance capacity.
>>                                             ^^^^^^^^^^^^^^^^^^^^
>>
>> Do we use a new CPU capacity value `performance capacity (1)` here?
>>
>> Which I guess is `capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu)`.
>>
>> I'm asking since util_fits_cpu() still uses: `capacity_orig_thermal (2)
>> = capacity_orig - arch_scale_thermal_pressure()` when checking whether
>> to return -1. Shouldn't (1) and (2) be the same?
> 
> I'm all in favor of both being capacity_orig_of(cpu) -
> thermal_load_avg(cpu_rq(cpu) like the capacity inversion detection

I think we need a handy name for this new capacity value, which seems to
be `capacity_orig - capacity reduced by thermal`. And we should either
use `thermal_load_avg` or `thermal pressure` for the latter part. And
then we should use this consistently in all these places:
util_fits_cpu(), feec(), sic().

[...]
