Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C426832D5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjAaQgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjAaQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:36:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AF1819A;
        Tue, 31 Jan 2023 08:36:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C43712F4;
        Tue, 31 Jan 2023 08:36:47 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9008D3F64C;
        Tue, 31 Jan 2023 08:36:03 -0800 (PST)
Message-ID: <122cb5dd-de31-2b41-1899-0dd9ec03a2c4@arm.com>
Date:   Tue, 31 Jan 2023 17:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, peterz@infradead.org, qyousef@layalina.io,
        rafael@kernel.org, viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
References: <20230119174244.2059628-1-vincent.guittot@linaro.org>
 <d5012cdf-ad5b-adf8-11f6-8ac2c3a89f0b@arm.com>
 <CAKfTPtDH-0FrmYfH-61c+_TSM3DPtz9na47DuLYBxkwr8MmCkQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtDH-0FrmYfH-61c+_TSM3DPtz9na47DuLYBxkwr8MmCkQ@mail.gmail.com>
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

On 27/01/2023 17:20, Vincent Guittot wrote:
> On Thu, 26 Jan 2023 at 12:42, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 19/01/2023 17:42, Vincent Guittot wrote:
>>> By taking into account uclamp_min, the 1:1 relation between task misfit
>>> and cpu overutilized is no more true as a task with a small util_avg may
>>> not fit a high capacity cpu because of uclamp_min constraint.
>>>
>>> Add a new state in util_fits_cpu() to reflect the case that task would fit
>>> a CPU except for the uclamp_min hint which is a performance requirement.
>>>
>>> Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
>>> can use this new value to take additional action to select the best CPU
>>> that doesn't match uclamp_min hint.
>>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>
>>> Change since v3:
>>> - Keep current condition for uclamp_max_fits in util_fits_cpu()
>>> - Update some comments
>>
>> We had already this discussion whether this patch can also remove
>> Capacity Inversion (CapInv).
>>
>> After studying the code again, I'm not so sure anymore.
>>
>> This patch:
>>
>> (1) adds a dedicated return value (-1) to util_fits_cpu() when:
>>
>> `util fits 80% capacity_of() && util < uclamp_min && uclamp_min >
>> capacity_orig_thermal (region c)`
>>
>> (2) Enhancements to the CPU selection in sic() and feec() to cater for
>> this new return value.
>>
>> IMHO this doesn't make the intention of CapInv in util_fits_cpu()
>> obsolete, which is using:
>>
>> in CapInv:
>>
>>   capacity_orig         = capacity_orig_of() - thermal_load_avg
>>   capacity_orig_thermal = capacity_orig_of() - thermal_load_avg
>>
>> not in CapInv:
>>
>>   capacity_orig         = capacity_orig_of()
>>   capacity_orig_thermal = capacity_orig_of() - th_pressure
>>
>> Maybe I still miss a bit of the story?
>>
>> v3 hints to removing the bits in the next version:
>>
>> https://lkml.kernel.org/r/20230115001906.v7uq4ddodrbvye7d@airbuntu
>>
>>>  kernel/sched/fair.c | 105 ++++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 82 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index d4db72f8f84e..54e14da53274 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -4561,8 +4561,8 @@ static inline int util_fits_cpu(unsigned long util,
>>>        * handle the case uclamp_min > uclamp_max.
>>>        */
>>>       uclamp_min = min(uclamp_min, uclamp_max);
>>> -     if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
>>> -             fits = fits && (uclamp_min <= capacity_orig_thermal);
>>> +     if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
>>> +             return -1;
>>
>> Or does the definition 'return -1 if util fits but uclamp doesn't' make
>> the distinction between capacity_orig and capacity_orig_thermal obsolete
>> and so CapInv?
> 
> Yes, that's the key point. When it returns -1, we will continue to
> look for a possible cpu with better performance which replaces CapInv
> with capacity_orig_of() - thermal_load_avg to detect a capacity
> inversion.

I see.

Could you add this paragraph to the patch header so that we understand
this part of the intention of this change right away? I know you
mentioned this either in a conversation or in an email-thread somewhere
but I forgot about it in the meantime.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]
