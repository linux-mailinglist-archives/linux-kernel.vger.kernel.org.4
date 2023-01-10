Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF350664805
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjAJSC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbjAJR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:58:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B9196540
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:57:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05BBD4B3;
        Tue, 10 Jan 2023 09:58:39 -0800 (PST)
Received: from [10.1.196.46] (eglon.cambridge.arm.com [10.1.196.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C01A03F67D;
        Tue, 10 Jan 2023 09:57:50 -0800 (PST)
Message-ID: <fac47e24-d3f0-853b-70d9-a6b25f719d24@arm.com>
Date:   Tue, 10 Jan 2023 17:57:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 02/18] x86/resctrl: Access per-rmid structures by index
Content-Language: en-GB
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-3-james.morse@arm.com>
 <IA1PR11MB609782777889811A1BB773549BFB9@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <IA1PR11MB609782777889811A1BB773549BFB9@IA1PR11MB6097.namprd11.prod.outlook.com>
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

Hi Fenghua,

On 06/01/2023 03:12, Yu, Fenghua wrote:
>> James Morse <james.morse@arm.com> writes:
>> Because of the differences between Intel RDT/AMD QoS and Arm's MPAM
>> monitors, RMID values on arm64 are not unique unless the CLOSID is also
>> included. Bitmaps like rmid_busy_llc need to be sized by the number of unique
>> entries for this resource.
>>
>> Add helpers to encode/decode the CLOSID and RMID to an index. The domain's
>> busy_rmid_llc and the rmid_ptrs[] array are then sized by index. On x86, this is
>> always just the RMID. This gives resctrl a unique value it can use to store
>> monitor values, and allows MPAM to decode the closid when reading the
>> hardware counters.

>> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
>> index d24b04ebf950..523eabfa3193 100644
>> --- a/arch/x86/include/asm/resctrl.h
>> +++ b/arch/x86/include/asm/resctrl.h
>> @@ -96,6 +96,23 @@ static inline void resctrl_sched_in(void)
>>  		__resctrl_sched_in();
>>  }
>>
>> +static inline u32 resctrl_arch_system_num_rmid_idx(void)
>> +{
>> +	/* RMID are independent numbers for x86. num_rmid_idx==num_rmid
>> */
>> +	return boot_cpu_data.x86_cache_max_rmid + 1; }
>> +
>> +static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid,
>> +u32 *rmid) {
>> +	*rmid = idx;
>> +	*closid = ~0;

> Should closid be 0 or ~0 on X86? Any special reason for closid to be ~0?

I picked ~0 as its not a valid CLOSID, so anything that consumes it should choke quickly.


> Seems 0 is a natural value so that it's ignored on X86. And the value should
> be consistent on x86 and documented.

Well 0 is a valid CLOSID value, you can't ignore it based on the value - that's done at
compile time as the helpers don't use the value. Doing nothing here would leave an
uninitialized value on the stack, which would then get passed to the next function (which
should ignore it). I assume this is the sort of thing future compilers will complain about
if they can't see that the next function doesn't use the value.

I'll give it a #define value to make it clear its a deliberate choice to initialise it
with an out of range value.


> 
>> +}
>> +
>> +static inline u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid) {
>> +	return rmid;
>> +}
>> +
>>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>>
>>  #else

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index f1f66c9942a5..c95d259476d4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -137,11 +137,24 @@ static inline u64 get_corrected_mbm_count(u32 rmid,
>> unsigned long val)
>>  	return val;
>>  }
>>
>> -static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
>> +/*
>> + * x86 and arm64 differ in their handling of monitoring.
>> + * x86's RMID are an independent number, there is one RMID '1'.
>> + * arm64's PMG extend the PARTID/CLOSID space, there is one RMID '1'
>> +for each
>> + * CLOSID. The RMID is no longer unique.
>> + * To account for this, resctrl uses an index. On x86 this is just the
>> +RMID,
>> + * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
>> + *
>> + * The domain's rmid_busy_llc and rmid_ptrs are sized by index. The
>> +arch code
>> + * must accept an attempt to read every index.
>> + */
>> +static inline struct rmid_entry *__rmid_entry(u32 idx)
>>  {
>>  	struct rmid_entry *entry;
>> +	u32 closid, rmid;
>>
>> -	entry = &rmid_ptrs[rmid];
>> +	entry = &rmid_ptrs[idx];
>> +	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
>>  	WARN_ON(entry->rmid != rmid);

> Will __rmid_entry() be moved to fs/?

It does as its not related to accessing the hardware. I hope to move as much as possible
to avoid duplication.


> Should add WARN_ON(entry->closid!=rmid) here?

Presumably WARN_ON(entry->closid != closid)?
That would force everything to be initalised to the official 'unitialised value', which is
probably not a bad thing.

If I'm touching these, I 'll change it to WARN_ON_ONCE(), as if it breaks, chances are its
going to trigger a few hundred times a second, which wouldn't help anyone trying to debug it.


>>  	return entry;


>> @@ -714,7 +737,7 @@ static int dom_data_init(struct rdt_resource *r)
>>  	 * default_rdtgroup control group, which will be setup later. See
>>  	 * rdtgroup_setup_root().
>>  	 */
>> -	entry = __rmid_entry(0, 0);
>> +	entry = __rmid_entry(resctrl_arch_rmid_idx_encode(0, 0));

> Closid is 0 here on x86.

It's supposed to be zero. This code is ensuring the monitors for the default control group
will always be available, by removing it from rmid_free_lru, effectively allocating it.

It needs to be 0 for architectures where the CLOSID matters to
resctrl_arch_rmid_idx_encode(), to ensure it allocates/reserves/leaks the correct hardware
monitor.

Changing __rmid_entry() to take a struct rdtgroup might make the whole thing clearer, I
didn't go that far as I thought it would be more churn.


> We need to have a consistent closid value on x86.
> Maybe even define a macro for x86 closid value e.g. #define RMID_FIELD_CLOSID_IGNORED 0.
> So the macro value is used on X86 always.

The value is ignored on encode by x86. You only need to provide a magic value for decode,
and only because deterministic bugs and values you can grep for a good things!


Thanks,

James
