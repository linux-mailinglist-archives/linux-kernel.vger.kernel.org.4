Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE665EFE1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjAEPWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjAEPVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:21:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A68D813CF1;
        Thu,  5 Jan 2023 07:20:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C9E61063;
        Thu,  5 Jan 2023 07:21:32 -0800 (PST)
Received: from [10.57.13.209] (unknown [10.57.13.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95C1E3F71A;
        Thu,  5 Jan 2023 07:20:48 -0800 (PST)
Message-ID: <f2148ed2-bf6d-e218-e4a4-fe4904812b5d@arm.com>
Date:   Thu, 5 Jan 2023 15:20:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com,
        dsmythies@telus.net, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <CAJZ5v0i1MrgkRPiMEPeZBuFmx24D-JaWTwmdCTeBVPmretL7VA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0i1MrgkRPiMEPeZBuFmx24D-JaWTwmdCTeBVPmretL7VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/23 15:07, Rafael J. Wysocki wrote:
> On Thu, Jan 5, 2023 at 3:52 PM Kajetan Puchalski
> <kajetan.puchalski@arm.com> wrote:
>>
>> Modern interactive systems, such as recent Android phones, tend to have power
>> efficient shallow idle states. Selecting deeper idle states on a device while a
>> latency-sensitive workload is running can adversely impact performance due to
>> increased latency. Additionally, if the CPU wakes up from a deeper sleep before
>> its target residency as is often the case, it results in a waste of energy on
>> top of that.
>>
>> At the moment, none of the available idle governors take any scheduling
>> information into account. They also tend to overestimate the idle
>> duration quite often, which causes them to select excessively deep idle
>> states, thus leading to increased wakeup latency and lower performance with no
>> power saving. For 'menu' while web browsing on Android for instance, those
>> types of wakeups ('too deep') account for over 24% of all wakeups.
>>
>> At the same time, on some platforms idle state 0 can be power efficient
>> enough to warrant wanting to prefer it over idle state 1. This is because
>> the power usage of the two states can be so close that sufficient amounts
>> of too deep state 1 sleeps can completely offset the state 1 power saving to the
>> point where it would've been more power efficient to just use state 0 instead.
>> This is of course for systems where state 0 is not a polling state, such as
>> arm-based devices.
>>
>> Sleeps that happened in state 0 while they could have used state 1 ('too shallow') only
>> save less power than they otherwise could have. Too deep sleeps, on the other
>> hand, harm performance and nullify the potential power saving from using state 1 in
>> the first place. While taking this into account, it is clear that on balance it
>> is preferable for an idle governor to have more too shallow sleeps instead of
>> more too deep sleeps on those kinds of platforms.
>>
>> This patch specifically tunes TEO to prefer shallower idle states in
>> order to reduce wakeup latency and achieve better performance.
>> To this end, before selecting the next idle state it uses the avg_util signal
>> of a CPU's runqueue in order to determine to what extent the CPU is being utilized.
>> This util value is then compared to a threshold defined as a percentage of the
>> cpu's capacity (capacity >> 6 ie. ~1.5% in the current implementation). If the
>> util is above the threshold, the idle state selected by TEO metrics will be
>> reduced by 1, thus selecting a shallower state. If the util is below the threshold,
>> the governor defaults to the TEO metrics mechanism to try to select the deepest
>> available idle state based on the closest timer event and its own correctness.
>>
>> The main goal of this is to reduce latency and increase performance for some
>> workloads. Under some workloads it will result in an increase in power usage
>> (Geekbench 5) while for other workloads it will also result in a decrease in
>> power usage compared to TEO (PCMark Web, Jankbench, Speedometer).
>>
>> It can provide drastically decreased latency and performance benefits in certain
>> types of workloads that are sensitive to latency.
>>
>> Example test results:
>>
>> 1. GB5 (better score, latency & more power usage)
>>
>> | metric                                | menu           | teo               | teo-util-aware    |
>> | ------------------------------------- | -------------- | ----------------- | ----------------- |
>> | gmean score                           | 2826.5 (0.0%)  | 2764.8 (-2.18%)   | 2865 (1.36%)      |
>> | gmean power usage [mW]                | 2551.4 (0.0%)  | 2606.8 (2.17%)    | 2722.3 (6.7%)     |
>> | gmean too deep %                      | 14.99%         | 9.65%             | 4.02%             |
>> | gmean too shallow %                   | 2.5%           | 5.96%             | 14.59%            |
>> | gmean task wakeup latency (asynctask) | 78.16μs (0.0%) | 61.60μs (-21.19%) | 54.45μs (-30.34%) |
>>
>> 2. Jankbench (better score, latency & less power usage)
>>
>> | metric                                | menu           | teo               | teo-util-aware    |
>> | ------------------------------------- | -------------- | ----------------- | ----------------- |
>> | gmean frame duration                  | 13.9 (0.0%)    | 14.7 (6.0%)       | 12.6 (-9.0%)      |
>> | gmean jank percentage                 | 1.5 (0.0%)     | 2.1 (36.99%)      | 1.3 (-17.37%)     |
>> | gmean power usage [mW]                | 144.6 (0.0%)   | 136.9 (-5.27%)    | 121.3 (-16.08%)   |
>> | gmean too deep %                      | 26.00%         | 11.00%            | 2.54%             |
>> | gmean too shallow %                   | 4.74%          | 11.89%            | 21.93%            |
>> | gmean wakeup latency (RenderThread)   | 139.5μs (0.0%) | 116.5μs (-16.49%) | 91.11μs (-34.7%)  |
>> | gmean wakeup latency (surfaceflinger) | 124.0μs (0.0%) | 151.9μs (22.47%)  | 87.65μs (-29.33%) |
>>
>> Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> 
> This looks good enough for me.
> 
> There are still a couple of things I would change in it, but I may as
> well do that when applying it, so never mind.
> 
> The most important question for now is what the scheduler people think
> about calling sched_cpu_util() from a CPU idle governor.  Peter,
> Vincent?
> 

We have a precedence in thermal framework for purpose of thermal
governor - IPA. It's been there for a while to estimate the power
of CPUs in the frequency domain for cpufreq_cooling device [1].
That's how this API sched_cpu_util() got created. Then it was also
adopted to PowerCap DTPM [2] (for the same power estimation purpose).

It's a function available with form include/linux/sched.h so I don't
see reasons why to not use it.

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/thermal/cpufreq_cooling.c#L151
[2] 
https://elixir.bootlin.com/linux/latest/source/drivers/powercap/dtpm_cpu.c#L83
