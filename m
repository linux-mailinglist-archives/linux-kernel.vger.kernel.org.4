Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1CB610219
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiJ0T4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbiJ0T4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:56:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 755B987084;
        Thu, 27 Oct 2022 12:56:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E278023A;
        Thu, 27 Oct 2022 12:56:22 -0700 (PDT)
Received: from [10.57.7.15] (unknown [10.57.7.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FF053F445;
        Thu, 27 Oct 2022 12:56:14 -0700 (PDT)
Message-ID: <c6e6d338-60e5-4401-1cf4-faaee3cc447f@arm.com>
Date:   Thu, 27 Oct 2022 20:56:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional
 util-awareness
Content-Language: en-US
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y0fymW5LOoIHstE2@e126311.manchester.arm.com>
 <CAAYoRsW+5xbW_Zd7Mtbo4VMi4RZFXRr7mf4NAU=Le7GhQzNJvg@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAAYoRsW+5xbW_Zd7Mtbo4VMi4RZFXRr7mf4NAU=Le7GhQzNJvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thank you for your effort in testing these patches and different
governors. We really appreciate that, since this helped us to
better understand the platform that you are using. It is different
to what we have and our workloads. That's why I have some comments.

It would be hard to combine these two worlds and requirements.
I have some concerns to the tests, the setup and the platform.
I can see a reason why this patch has to prove the
strengths on this platform and environment.
Please see my comments below.

On 10/13/22 23:12, Doug Smythies wrote:
> Hi All,
> 
> On Thu, Oct 13, 2022 at 4:12 AM Kajetan Puchalski
> <kajetan.puchalski@arm.com> wrote:
>> On Wed, Oct 12, 2022 at 08:50:39PM +0200, Rafael J. Wysocki wrote:
>>> On Mon, Oct 3, 2022 at 4:50 PM Kajetan Puchalski
>>> <kajetan.puchalski@arm.com> wrote:
> ...
> 
>> On the Intel & power usage angle you might have seen in the discussion,
>> Doug sent me some interesting data privately. As far as I can tell the
>> main issue there is that C0 on Intel doesn't actually do power saving so
>> moving the state selection down to it is a pretty bad idea because C1
>> could be very close in terms of latency and save much more power.
>>
>> A potential solution could be altering the v2 to only decrease the state
>> selection by 1 if it's above 1, ie 2->1 but not 1->0. It's fine for us
>> because arm systems with 2 states use the early exit path anyway. It'd
>> just amount to changing this hunk:
>>
>> +       if (cpu_data->utilized && idx > 0 && !dev->states_usage[idx-1].disable)
>> +               idx--;
>>
>> to:
>>
>> +       if (cpu_data->utilized && idx > 1 && !dev->states_usage[idx-1].disable)
>> +               idx--;
>>
>> What would you think about that? Should make it much less intense for
>> Intel systems.
> 
> I tested the above, which you sent me as patch version v2-2.
> 
> By default, my Intel i5-10600K has 4 idle states:
> 
> $ grep . /sys/devices/system/cpu/cpu7/cpuidle/state*/name
> /sys/devices/system/cpu/cpu7/cpuidle/state0/name:POLL

This active polling state type worries me a bit. We don't have
such on our platforms. Our shallowest idle state is really different.
We don't have active polling and there is no need for such.

> /sys/devices/system/cpu/cpu7/cpuidle/state1/name:C1_ACPI
> /sys/devices/system/cpu/cpu7/cpuidle/state2/name:C2_ACPI
> /sys/devices/system/cpu/cpu7/cpuidle/state3/name:C3_ACPI
> 
> Idle driver governor legend:
> teo: the normal teo idle governor
> menu: the normal menu idle governor
> util or v1: the original patch
> util-v2 or v2: V2 of the patch
> util-v2-2 or v2-2: the suggestion further up in this thread.
> 
> Test 1: Timer based periodic:
> 
> A load sweep from 0 to 100%, then 100% to 0, first 73 hertz, then 113,
> 211,347 and finally 401 hertz work/sleep frequency. Single thread.

This 'Single thread' worries me a bit as well. Probably the
task don't migrate at all over CPUs, or very unlikely.

> 
> http://smythies.com/~doug/linux/idle/teo-util/consume/idle-1/
> 
> Summary, average processor package powers (watts):
> 
> teo              menu          v1               v2             v2-2
> 10.19399    10.74804    22.12791    21.0431    11.27865
>                       5.44%      117.07%     106.43%     10.64%
> 
> There is no performance measurement for this test, it just has to
> finish the work packet before the next period starts. Note that
> overruns do occur as the workload approaches 100%, but I do not record
> that data, as typically the lower workload percentages are the area of
> interest.
> 
> Test 2: Ping-pong test rotating through 6 different cores, with a
> variable packet of work to do at each stop. This test goes gradually
> through different idle states and is not timer based. A different 2
> core test (which I have not done) is used to better explore the idle
> state 0 to idle state 1 transition. This test has a performance
> measurement. The CPU scaling governor was set to performance. HWP was

The 'performance' governor also worries me here. When we fix the
frequency of the CPU then some basic statistics mechanisms would be good
enough for reasoning.

In our world, a few conditions are different:
1. The CPU frequency changes. We work with SchedUtil and adjust the
frequency quite often. Therefore, simple statistics which are not
aware of the frequency change and the impact to the CPU computation
capacity might be misleading. The utilization signal of the CPU runqueue
brings that information to our idle decisions.
2. Single threaded workloads aren't typical apps. When we deal
with many tasks and the task scheduler migrates them across many
CPUs we would like to 'see' this. The 'old-school' statistics
observing only the local CPU usage are not able to figure out
fast enough that some bigger task just migrated to that CPU.
With utilization of the runqueue, we know that upfront, because the task
utilization was subtracted from the old CPU's runqueue and
added to the new CPU's runqueue. Our approach with this util
signal would allow us to make a better decision in these two use cases:
a) task is leaving the CPU and rq util drops dramatically - so we can
go into deeper sleep immediately
b) task just arrived on this CPU and rq util got higher value - so we
shouldn't go into deep idle state, since there is 'not small' task.
3. Power saving on our platform in shallowest idle state was improved
recently and creates a scope for saving power and increase performance.

It would be fair to let TEO continue it's evolution (on the platforms
that it was designed for) and create a new governor which would address
better other platforms and workloads needs.

I will ask Rafael if that can happen. Kajetan has a tiny patch with
basic mechanisms, which performs really good. I will ask him to send it
so Rafael could have a look and decide. We could then develop/improve
that new governor with ideas from other experienced engineers in
mobile platforms.

Regards,
Lukasz
