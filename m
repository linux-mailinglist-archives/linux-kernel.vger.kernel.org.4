Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DEB6C1D94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjCTRR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjCTRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:17:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 841EB132CE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:13:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74CA4106F;
        Mon, 20 Mar 2023 10:13:17 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24A943F67D;
        Mon, 20 Mar 2023 10:12:29 -0700 (PDT)
Message-ID: <b6951268-e9c8-bf7e-add8-bf8009d7b9ad@arm.com>
Date:   Mon, 20 Mar 2023 17:12:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 08/18] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-9-james.morse@arm.com>
 <b85cc905-3ea2-9f73-a592-0ebdc4240c37@intel.com>
 <4a9e4fed-c969-490c-d602-d00bcdcb5096@arm.com>
 <8d05bce5-b145-3df3-7445-02aa31ca877c@arm.com>
 <0814c380-b5f1-be8b-f03f-e6fcb8fa0821@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <0814c380-b5f1-be8b-f03f-e6fcb8fa0821@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/03/2023 20:06, Reinette Chatre wrote:
> On 3/8/2023 8:09 AM, James Morse wrote:
>> On 06/03/2023 11:33, James Morse wrote:
>>> On 02/02/2023 23:47, Reinette Chatre wrote:
>>>> On 1/13/2023 9:54 AM, James Morse wrote:
>>>>> x86 is blessed with an abundance of monitors, one per RMID, that can be
>>>>> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
>>>>> the number implemented is up to the manufacturer. This means when there are
>>>>> fewer monitors than needed, they need to be allocated and freed.
>>>>>
>>>>> Worse, the domain may be broken up into slices, and the MMIO accesses
>>>>> for each slice may need performing from different CPUs.
>>>>>
>>>>> These two details mean MPAMs monitor code needs to be able to sleep, and
>>>>> IPI another CPU in the domain to read from a resource that has been sliced.
>>>>>
>>>>> mon_event_read() already invokes mon_event_count() via IPI, which means
>>>>> this isn't possible.
>>>>>
>>>>> Change mon_event_read() to schedule mon_event_count() on a remote CPU and
>>>>> wait, instead of sending an IPI. This function is only used in response to
>>>>> a user-space filesystem request (not the timing sensitive overflow code).
>>>>>
>>>>> This allows MPAM to hide the slice behaviour from resctrl, and to keep
>>>>> the monitor-allocation in monitor.c.
>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> index 1df0e3262bca..4ee3da6dced7 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> @@ -542,7 +545,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>>>>  	rr->val = 0;
>>>>>  	rr->first = first;
>>>>>  
>>>>> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
>>>>> +	smp_call_on_cpu(cpumask_any(&d->cpu_mask), mon_event_count, rr, false);
>>>
>>>> This would be problematic for the use cases where single tasks are run on
>>>> adaptive-tick CPUs. If an adaptive-tick CPU is chosen to run the function then
>>>> it may never run. Real-time environments are target usage of resctrl (with examples
>>>> in the documentation).
>>>
>>> Interesting. I can't find an IPI wakeup under smp_call_on_cpu() ... I wonder what else
>>> this breaks!
>>>
>>> Resctrl doesn't consider the nohz-cpus when doing any of this work, or when setting up the
>>> limbo or overflow timer work.
>>>
>>> I think the right thing to do here is add some cpumask_any_housekeeping() helper to avoid
>>> nohz-full CPUs where possible, and fall back to an IPI if all the CPUs in a domain are
>>> nohz-full.
>>>
>>> Ideally cpumask_any() would do this but it isn't possible without allocating memory.
>>> If I can reproduce this problem,  ...
>>
>> ... I haven't been able to reproduce this.
>>
>> With "nohz_full=1 isolcpus=nohz,domain,1" on the command-line I can still
>> smp_call_on_cpu() on cpu-1 even when its running a SCHED_FIFO task that spins in
>> user-space as much as possible.
>>
>> This looks to be down to "sched: RT throttling activated", which seems to be to prevent RT
>> CPU hogs from blocking kernel work. From Peter's comments at [0], it looks like running
>> tasks 100% in user-space isn't a realistic use-case.
>>
>> Given that, I think resctrl should use smp_call_on_cpu() to avoid interrupting a nohz_full
>> CPUs, and the limbo/overflow code should equally avoid these CPUs. If work does get
>> scheduled on those CPUs, it is expected to run eventually.

> From what I understand the email you point to, and I assume your testing,
> used the system defaults (SCHED_FIFO gets 0.95s out of 1s).
> 
> Users are not constrained by these defaults. Please see
> Documentation/scheduler/sched-rt-group.rst

Aha, I didn't find thiese to change. But I note most things down here say:
| Fiddling with these settings can result in an unstable system, the knobs are
| root only and assumes root knows what he is doing.

on them.


> It is thus possible for tightly controlled task to have a CPU dedicated to
> it for great lengths or even forever. Ideally written in a way to manage power
> and thermal constraints.
> 
> In the current behavior, users can use resctrl to read the data at any time
> and expect to understand consequences of such action. 

Those consequences are that resctrl might pick that CPU as the victim of an IPI, so the
time taken to read the counters goes missing from user-space.


> It seems to me that there may be scenarios under which this change could
> result in a read of data to never return? As you indicated it is expected
> to run eventually, but that would be dictated by the RT scheduling period
> that can be up to about 35 minutes (or "no limit" prompting me to make the
> "never return" statement).

Surely not interrupting an RT task is a better state of affairs. User-space can't know
which CPU resctrl is going to IPI.
If this means resctrl doesn't work properly, I'd file that under 'can result in an
unstable system' as quoted above.

I think the best solution here is for resctrl to assume there is one housekeeping CPU per
domain, (e.g. for processing offloaded RCU callbacks), and that it should prefer that CPU
for all cross-call work. This avoids ever interrupting RT tasks.

If you feel strongly that all CPUs in a domain could be dedicated 100% to user-space work,
can always use an IPI when nohz_full is in use, (and hope for the best on the CPU choice).
This will prevent a class of MPAM platforms from using their monitors with nohz_full,
which I'm fine with as the conditions are detectable.


> I do not see at this time that limbo/overflow should avoid these CPUs. Limbo
> could be avoided from user space. I have not hear about overflow impacting
> such workloads negatively.

Its got all the same properties. The limbo/overflow work picks a CPU to run on, it may
pick a nohz_full CPU. I suspect no-one has complained is because this 100%-in-userspace is
a niche sport.

Again, I think the best solution here is for the limbo/overflow code to prefer
housekeeping CPUs for all their work. This is what I've done for v3.


Thanks,

James
