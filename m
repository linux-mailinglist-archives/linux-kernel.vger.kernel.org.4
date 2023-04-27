Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4B26F0707
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbjD0OLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243547AbjD0OLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:11:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2825793
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:11:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED7DB11FB;
        Thu, 27 Apr 2023 07:12:18 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D76593F64C;
        Thu, 27 Apr 2023 07:10:57 -0700 (PDT)
Message-ID: <78256a0f-d6e2-9c65-610d-ff962fdfed5b@arm.com>
Date:   Thu, 27 Apr 2023 15:10:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 08/19] x86/resctrl: Add cpumask_any_housekeeping() for
 limbo/overflow
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
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-9-james.morse@arm.com>
 <3145caff-4e73-0ef2-5bc2-70cdfe7953e9@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <3145caff-4e73-0ef2-5bc2-70cdfe7953e9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 01/04/2023 00:24, Reinette Chatre wrote:
> On 3/20/2023 10:26 AM, James Morse wrote:
>> The limbo and overflow code picks a CPU to use from the domain's list
>> of online CPUs. Work is then scheduled on these CPUs to maintain
>> the limbo list and any counters that may overflow.
>>
>> cpumask_any() may pick a CPU that is marked nohz_full, which will
>> either penalise the work that CPU was dedicated to, or delay the
> 
> penalise -> penalize

(s->z is the difference between British English and American English)


>> processing of limbo list or counters that may overflow. Perhaps
>> indefinitely. Delaying the overflow handling will skew the bandwidth
>> values calculated by mba_sc, which expects to be called once a second.
>>
>> Add cpumask_any_housekeeping() as a replacement for cpumask_any()
>> that prefers housekeeping CPUs. This helper will still return
>> a nohz_full CPU if that is the only option. The CPU to use is
>> re-evaluated each time the limbo/overflow work runs. This ensures
>> the work will move off a nohz_full CPU once a houskeeping CPU is
>> available.

>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 87545e4beb70..0b5fd5a0cda2 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -55,6 +56,28 @@
>>  /* Max event bits supported */
>>  #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>>  
>> +/**
>> + * cpumask_any_housekeeping() - Chose any cpu in @mask, preferring those that
>> + *			        aren't marked nohz_full
>> + * @mask:	The mask to pick a CPU from.
>> + *
>> + * Returns a CPU in @mask. If there are houskeeping CPUs that don't use
>> + * nohz_full, these are preferred.
>> + */
>> +static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>> +{
>> +	int cpu, hk_cpu;
>> +
>> +	cpu = cpumask_any(mask);
>> +	if (tick_nohz_full_cpu(cpu)) {
>> +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
>> +		if (hk_cpu < nr_cpu_ids)
>> +			cpu = hk_cpu;
>> +	}
>> +

> I think as a start this could perhaps be a #if defined(CONFIG_NO_HZ_FULL). There
> appears to be a precedent for this in kernel/rcu/tree_nocb.h.

This harms readability, and prevents the compiler from testing that this is valid C code
for any compile of this code.

With if-def's here you'd be reliant on come CI system to build with the required
combination of Kconfig symbols to expose any warnings.

It's much better to use IS_ENABLED() in the helpers and rely on the compiler's
dead-code-elimination to remove paths that have been configured out.

(See the section on Conditional Compilation in coding-style for a much better summary!)


> Apart from the issue that Ilpo pointed out I would prefer that any changes outside
> resctrl are submitted separately to that subsystem.

Sure, I'll pull those three lines out as a separate patch.


>> @@ -801,6 +803,11 @@ void mbm_handle_overflow(struct work_struct *work)
>>  			update_mba_bw(prgrp, d);
>>  	}
>>  
>> +	/*
>> +	 * Re-check for housekeeping CPUs. This allows the overflow handler to
>> +	 * move off a nohz_full CPU quickly.
>> +	 */
>> +	cpu = cpumask_any_housekeeping(&d->cpu_mask);
>>  	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
>>  
>>  out_unlock:
> 
> From what I can tell the nohz_full CPUs are set during boot and do not change.

But the house keeping CPUs can be taken offline, and brought back.

With this change the work moves off the nohz_full CPU and back to the housekeeping CPU the
next time this runs. Without it, you're stuck on a nohz_full CPU until you take that CPU
offline too.


>> diff --git a/include/linux/tick.h b/include/linux/tick.h
>> index bfd571f18cfd..ae2e9019fc18 100644
>> --- a/include/linux/tick.h
>> +++ b/include/linux/tick.h
>> @@ -174,9 +174,10 @@ static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
>>  static inline void tick_nohz_idle_stop_tick_protected(void) { }
>>  #endif /* !CONFIG_NO_HZ_COMMON */
>>  
>> +extern cpumask_var_t tick_nohz_full_mask;
>> +
>>  #ifdef CONFIG_NO_HZ_FULL
>>  extern bool tick_nohz_full_running;
>> -extern cpumask_var_t tick_nohz_full_mask;
>>  
>>  static inline bool tick_nohz_full_enabled(void)
>>  {
> 
> In addition to what Ilpo pointed out, be careful here.
> cpumask_var_t is a pointer (or array) and needs to be
> allocated before use. Moving its declaration but not the
> allocation code seems risky.

Risky how? Any use of tick_nohz_full_mask that isn't guarded by something like
tick_nohz_full_cpu() will lead to a link error regardless of the type.


Thanks,

James
