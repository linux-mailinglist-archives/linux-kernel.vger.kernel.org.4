Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872D26ABE34
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCFLdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCFLdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:33:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BA431CAF6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:33:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD12312FC;
        Mon,  6 Mar 2023 03:33:53 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E2D23F5A1;
        Mon,  6 Mar 2023 03:33:07 -0800 (PST)
Message-ID: <4a9e4fed-c969-490c-d602-d00bcdcb5096@arm.com>
Date:   Mon, 6 Mar 2023 11:33:07 +0000
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
From:   James Morse <james.morse@arm.com>
In-Reply-To: <b85cc905-3ea2-9f73-a592-0ebdc4240c37@intel.com>
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

On 02/02/2023 23:47, Reinette Chatre wrote:
> Hi James,
> 
> On 1/13/2023 9:54 AM, James Morse wrote:
>> x86 is blessed with an abundance of monitors, one per RMID, that can be
>> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
>> the number implemented is up to the manufacturer. This means when there are
>> fewer monitors than needed, they need to be allocated and freed.
>>
>> Worse, the domain may be broken up into slices, and the MMIO accesses
>> for each slice may need performing from different CPUs.
>>
>> These two details mean MPAMs monitor code needs to be able to sleep, and
>> IPI another CPU in the domain to read from a resource that has been sliced.
>>
>> mon_event_read() already invokes mon_event_count() via IPI, which means
>> this isn't possible.
>>
>> Change mon_event_read() to schedule mon_event_count() on a remote CPU and
>> wait, instead of sending an IPI. This function is only used in response to
>> a user-space filesystem request (not the timing sensitive overflow code).
>>
>> This allows MPAM to hide the slice behaviour from resctrl, and to keep
>> the monitor-allocation in monitor.c.

>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 1df0e3262bca..4ee3da6dced7 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -532,8 +532,11 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>>  		    int evtid, int first)
>>  {
>> +	/* When picking a cpu from cpu_mask, ensure it can't race with cpuhp */
> 
> Please consistently use CPU instead of cpu.

(done)


>> +	lockdep_assert_held(&rdtgroup_mutex);
>> +
>>  	/*
>> -	 * setup the parameters to send to the IPI to read the data.
>> +	 * setup the parameters to pass to mon_event_count() to read the data.
>>  	 */
>>  	rr->rgrp = rdtgrp;
>>  	rr->evtid = evtid;
>> @@ -542,7 +545,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>  	rr->val = 0;
>>  	rr->first = first;
>>  
>> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
>> +	smp_call_on_cpu(cpumask_any(&d->cpu_mask), mon_event_count, rr, false);

> This would be problematic for the use cases where single tasks are run on
> adaptive-tick CPUs. If an adaptive-tick CPU is chosen to run the function then
> it may never run. Real-time environments are target usage of resctrl (with examples
> in the documentation).

Interesting. I can't find an IPI wakeup under smp_call_on_cpu() ... I wonder what else
this breaks!

Resctrl doesn't consider the nohz-cpus when doing any of this work, or when setting up the
limbo or overflow timer work.

I think the right thing to do here is add some cpumask_any_housekeeping() helper to avoid
nohz-full CPUs where possible, and fall back to an IPI if all the CPUs in a domain are
nohz-full.

Ideally cpumask_any() would do this but it isn't possible without allocating memory.
If I can reproduce this problem, I'll propose adding the behaviour to
smp_call_function_any(), probably overloading 'wait' to return an error if all the target
CPUs are nohz-full.


This means those MPAM systems that need this can't use nohz_full, or at least need a
housekeeping CPU that can access each MSC. The driver already considers whether interrupts
are masked for this stuff because of the prototype perf support, which those machines
wouldn't be able to support either.

(I'll look at hooking this up to the limbo/overflow code too)


Thanks,

James

untested and incomplete hunk of code:
------------%<------------
	cpu = get_cpu();
	if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
		smp_call_function_single(cpu, smp_mon_event_count, rr, true);
		put_cpu();
	} else {
		put_cpu();

		/*
		 * If all the CPUs available use nohz_full, fall back to an IPI.
		 * Some MPAM systems will be unable to use their counters in this case.
		 */
		cpu = cpumask_any_housekeeping(&d->cpu_mask);
		if (tick_nohz_full_cpu(cpu))
			smp_call_function_single(cpu, smp_mon_event_count, rr, true);
		else
			smp_call_on_cpu(cpu, mon_event_count, rr, false);
	}
------------%<------------
