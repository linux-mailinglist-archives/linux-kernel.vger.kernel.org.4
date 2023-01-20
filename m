Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE33675D20
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjATSxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjATSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:53:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B89660C80;
        Fri, 20 Jan 2023 10:53:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0894E11FB;
        Fri, 20 Jan 2023 10:53:49 -0800 (PST)
Received: from [192.168.255.158] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8790B3F445;
        Fri, 20 Jan 2023 10:53:04 -0800 (PST)
Message-ID: <eee85ad6-bc78-0693-c182-4a53410af054@arm.com>
Date:   Fri, 20 Jan 2023 18:53:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>
Cc:     mingo@kernel.org, peterz@infradead.org, rafael@kernel.org,
        viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
References: <20230113134056.257691-1-vincent.guittot@linaro.org>
 <78bf2d91-0076-f748-7c6a-530dad466787@arm.com>
 <CAKfTPtCAAOvFak2FqkKv2AwnoBZ3cwbMwfnAAGqDx+Wq4Ng+zw@mail.gmail.com>
 <7a6182dd-89f5-69c5-4331-2f102dc0418d@arm.com>
 <CAKfTPtCfbVgwPGYgw4vuO3UgEFM9GbMzyrzkgCoeL7onZXQXBg@mail.gmail.com>
 <20230118164820.r37yfigmwwdske4r@airbuntu>
 <CAKfTPtBX=tA2mDdbMP+R5fOZkH-P3AORgTk=ozXLRrP2Hz7kVg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtBX=tA2mDdbMP+R5fOZkH-P3AORgTk=ozXLRrP2Hz7kVg@mail.gmail.com>
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

On 19/01/2023 10:08, Vincent Guittot wrote:
> On Wed, 18 Jan 2023 at 17:48, Qais Yousef <qyousef@layalina.io> wrote:
>>
>> On 01/18/23 09:15, Vincent Guittot wrote:
>>> On Mon, 16 Jan 2023 at 15:56, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 16/01/2023 12:23, Vincent Guittot wrote:
>>>>> On Mon, 16 Jan 2023 at 10:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>>>
>>>>>> On 13/01/2023 14:40, Vincent Guittot wrote:

[...]

>>>>>> In task_fits_cpu() `utilization and performance (better uclamp)
>>>>>> requirements` term was used. I assume it's the same thing here?
>>>>>>
>>>>>>> +             if (fits > 0)
>>>>>>>                       return cpu;
>>>>>>> +             /*
>>>>>>> +              * Only the min performance (i.e. uclamp_min) doesn't fit. Look
>>>>>>> +              * for the CPU with highest performance capacity.
>>>>>>                                             ^^^^^^^^^^^^^^^^^^^^
>>>>>>
>>>>>> Do we use a new CPU capacity value `performance capacity (1)` here?
>>>>>>
>>>>>> Which I guess is `capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu)`.
>>>>>>
>>>>>> I'm asking since util_fits_cpu() still uses: `capacity_orig_thermal (2)
>>>>>> = capacity_orig - arch_scale_thermal_pressure()` when checking whether
>>>>>> to return -1. Shouldn't (1) and (2) be the same?
>>>>>
>>>>> I'm all in favor of both being capacity_orig_of(cpu) -
>>>>> thermal_load_avg(cpu_rq(cpu) like the capacity inversion detection
>>>>
>>>> I think we need a handy name for this new capacity value, which seems to
>>>> be `capacity_orig - capacity reduced by thermal`. And we should either
>>>> use `thermal_load_avg` or `thermal pressure` for the latter part. And
>>>> then we should use this consistently in all these places:
>>>> util_fits_cpu(), feec(), sic().
>>>
>>> Ok, let me change this everywhere
>>
>> I'm not keen on this :-/
>>
>> Changing this everywhere could have implications beyond our simple capabilities
>> of testing now :(

It's actually not everywhere. I'm aware of 2 occurrences now in which we
use 'cap_orig - th_pressure': in feec()/compute_energy() (commit
489f16459e00 "sched/fair: Take thermal pressure into account while
estimating energy") and now also in util_fits_cpu().

>> Current choice (in util_fits_cpu()) was based on a direct feedback from Xuewen.

I went through these ~40 emails in the '[PATCH] sched: Take thermal
pressure into account when determine rt fits capacity' thread (1):

https://lkml.kernel.org/r/20220407051932.4071-1-xuewen.yan@unisoc.com

and the '[PATCH 1/7] sched/uclamp: Fix relationship between uclamp and
migration margin' (2):

https://lkml.kernel.org/r/20220629194632.1117723-2-qais.yousef@arm.com

There is this email from Xuewen in (1):

https://lkml.kernel.org/r/CAB8ipk--Y8HxetcmUhBmtWq6Mmd726QmDbcbibGLERJw_PUqkQ@mail.gmail.com

in which he mentioned that he prefers th_pressure but this was a CapInv
prototype in update_cpu_capacity() (the whole discussion was about
th_pressure in rt_task_fits_capacity()) rather than util_fits_cpu().

Maybe I missed something more directly related to util_fits_cpu()?

>> I think we should discuss how we can improve the situation instead rather than
>> worry about consistency. I don't think we can be consistent without doing some
>> improvements on thermal pressure response time.

I'm fine with discussing this next Wednesday.

We just have to watch out for v4 of this patch which uses `cap_orig -
thermal_load_avg()` in sic().

>> A separate proposal patch to invoke some testing and discussion is fine by me.
>>
>> Better keep it a separate work item please?
> 
> Ok, I'm going to keep the current use of arch_scale_thermal_pressure
> and thermal_load_avg for this patch

OK.
