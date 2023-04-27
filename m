Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB306F0705
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbjD0OKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243827AbjD0OKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:10:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 121E54C39
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:10:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6B96C14;
        Thu, 27 Apr 2023 07:11:06 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DC8D3F7D8;
        Thu, 27 Apr 2023 07:09:55 -0700 (PDT)
Message-ID: <22efdde1-9b63-f11c-65ba-22cdca44600b@arm.com>
Date:   Thu, 27 Apr 2023 15:09:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 08/19] x86/resctrl: Add cpumask_any_housekeeping() for
 limbo/overflow
Content-Language: en-GB
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
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
 <816992e-a153-db6e-d3d7-84de1c1e1d59@linux.intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <816992e-a153-db6e-d3d7-84de1c1e1d59@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On 21/03/2023 13:21, Ilpo Järvinen wrote:
> On Mon, 20 Mar 2023, James Morse wrote:
> 
>> The limbo and overflow code picks a CPU to use from the domain's list
>> of online CPUs. Work is then scheduled on these CPUs to maintain
>> the limbo list and any counters that may overflow.
>>
>> cpumask_any() may pick a CPU that is marked nohz_full, which will
>> either penalise the work that CPU was dedicated to, or delay the
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
>> +	return cpu;
>> +}
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
> 
> Its definition seems to also be inside #ifdef:
> 
> kernel/time/tick-sched.c-#ifdef CONFIG_NO_HZ_FULL
> kernel/time/tick-sched.c:cpumask_var_t tick_nohz_full_mask;
> kernel/time/tick-sched.c:EXPORT_SYMBOL_GPL(tick_nohz_full_mask);

Indeed, but all the uses are guarded by tick_nohz_full_cpu(), which the compiler knows is
false if CONFIG_NO_HZ_FULL is not selected.

Moving the prototype is enough to let the compiler parse the code to check its correct,
before dead-code-eliminating it. There is no need to carry around the cpumask if its never
going to be used. This would only cause a problem if someone adds a user of
tick_nohz_full_mask which isn't guarded by IS_ENABLED(). I argue that would be a bug.

All this is being done to avoid more #ifdeffery!)


Thanks,

James
