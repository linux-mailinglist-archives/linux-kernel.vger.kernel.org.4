Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB55FB066
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJKKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJKKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:25:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C52677B7B2;
        Tue, 11 Oct 2022 03:25:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11F7B1042;
        Tue, 11 Oct 2022 03:25:51 -0700 (PDT)
Received: from [10.57.1.254] (unknown [10.57.1.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 674C13F766;
        Tue, 11 Oct 2022 03:25:43 -0700 (PDT)
Message-ID: <5001a099-4596-2d10-2f79-3e39ad507959@arm.com>
Date:   Tue, 11 Oct 2022 11:25:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] cpufreq: Update CPU capacity reduction in
 store_scaling_max_freq()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
References: <20220930094821.31665-1-lukasz.luba@arm.com>
 <20220930094821.31665-2-lukasz.luba@arm.com>
 <20221010053902.5rofnpzvyynumw3e@vireshk-i7>
 <3f9a4123-171b-5fa7-f506-341355f71483@arm.com>
 <CAKfTPtBPqcTm5_-M_Ka3y46yQ2322TmH8KS-QyDbAiKk5B6hEQ@mail.gmail.com>
 <8a7968c2-dbf7-5316-ef36-6d45143e0605@arm.com>
 <CAKfTPtB3Lk5bc9k634O+Yi8wwP=MVeKS5NPbpaqwhX1F4t5EbA@mail.gmail.com>
 <9611971c-d8dd-7877-6f50-c5afbf38b171@arm.com>
 <Y0Py/Ol9t+LMM1pI@hirez.programming.kicks-ass.net>
 <7ded9241-6c21-6631-8910-9f1150db6724@arm.com>
 <Y0UrbBioezoyeez/@hirez.programming.kicks-ass.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <Y0UrbBioezoyeez/@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/22 09:38, Peter Zijlstra wrote:
> On Mon, Oct 10, 2022 at 11:46:29AM +0100, Lukasz Luba wrote:
>>
>> +CC Daniel, since I have mentioned a few times DTPM
>>
>> On 10/10/22 11:25, Peter Zijlstra wrote:
>>> On Mon, Oct 10, 2022 at 11:12:06AM +0100, Lukasz Luba wrote:
>>>> BTW, those Android user space max freq requests are not that long,
>>>> mostly due to camera capturing (you can see a few in this file,
>>>> e.g. [1]).
>>>
>>> It does what now ?!? Why is Android using this *at*all* ?
>>
>> It tries to balance the power budget, before bad things happen
>> randomly (throttling different devices w/o a good context what's
>> going on). Please keep in mind that we have ~3 Watts total power
>> budget in a phone, while several devices might be suddenly used:
>> 1. big CPU with max power ~3-3.5 Watts (and we have 2 cores on pixel6)
>> 2. GPU with max power ~6Watts (normally ~1-2Watts when lightly used)
>> 3. ISP (Image Signal Processor) up to ~2Watts
>> 4. DSP also up to 1-2Watts
>>
>> We don't have currently a good mechanism which could be aware
>> of the total power/thermal budget and relations between those
>> devices. Vendors and OEMs run experiments on devices and profile
>> them to work more predictable in those 'important to users' scenarios.
>>
>> AFAIK Daniel Lescano is trying to help with this new interface
>> for PowerCap: DTMP. It might be use as a new interface for those known
>> scenarios like the camera snapshot. But that interface is on the list
>> that I have also mentioned - it's missing the notification mechanism
>> for the scheduler reduced capacity due to user-space new scenario.
> 
> DTMP is like IPA but including random devices? Because I thought IPA
> already did lots of this.

The DTMP is a kernel interface for power split which happen in the user
space policy. It exposes the sysfs to set those scenarios, even before
(like those Android 'powerhints') the power/thermal issue occur. I have
been reviewing it (and advocating internally). There is more work to
do there still and AFAIK is not yet used by Android.

IPA contains the policy to power budget split, but misses this 'context'
of what's going on and would happen. It has some PID mechanism to fix
itself, but it's not a silver bullet.

Furthermore, there are other IPA fundamental issues:
1. You might recall we added last year to IPA the utilization signal
    of the CPU runqueues. That model still has issues with input
    power estimation and I have described that here [1].
2. Cpu frequency sampling issue (we assume const. freq at whole period)
    (also in [1])
3. Power consumption of a CPU at the same frequency varies and depends
    on workload instruction mix, e.g. heavy SIMD floating-point code
    for some image filter in camera app drains more power vs. a code
    which is a garbage-collector background thread traversing a graph
    in memory and has big backend stall due to randomness of pointers
    (or a game thread for collision detection on octrees).
    Our Energy Model doesn't cover such thing (yet).
    The issue become more severe for us with last year available big
    cores: a new generation of uArch Cortex-X1. They are able to
    drain 3.5W instantly, while in Energy Model we have 2.2W for max
    freq. In previous big cores we haven't such power hungry CPUs.
    A fair assumption was 1.0W for EM value and 1.7W for a pick power
    in some SIMD code. That 3.5W-2.2W can heat up the SoC really
    quickly and use the free thermal budget easily. So hints from
    user space are welcome IMO.
4. User space restriction to cpufreq and devfreq, which are those
    'powerhints' about possible coming soon scenarios, are not taken into
    account, due to missing interface. I have mentioned it ~2 years ago
    and sent a RFC example patch for devfreq (didn't dare to address
    cpufreq at once) [2]
5. Thermal-pressure PELT signal converges slowly to the original
    instant signal set by thermal governor, so the capacity_of()
    has delays to 'observe' the reality of the capped CPUs. In those
    user space scenario short hints is important. I have tried to
    add a mechanism to react faster, since we might already have
    delays in our FW or IPA to the original signal. Patch didn't
    make any progress on LKML [3].
6. The leakage. Rising temperature above normal values, causing higher
    power drain by the CPU core. Presented on LPC 2022 [4]. This is an
    issue when our GPU or ISP heats up the SoC, thus CPUs.

If you like, I can give you more details how those different CPUs
(and other devices) behave under power/thermal stress in various
scenarios. I have spent a lot of time in last ~5years on researching
it.

Regards,
Lukasz

[1] 
https://lore.kernel.org/linux-pm/20220406220809.22555-1-lukasz.luba@arm.com/
[2] https://lore.kernel.org/lkml/20210126104001.20361-1-lukasz.luba@arm.com/
[3] https://lore.kernel.org/lkml/20220429091245.12423-1-lukasz.luba@arm.com/
[4] https://lpc.events/event/16/contributions/1341/
