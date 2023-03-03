Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168F56A9EDF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjCCSdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjCCSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:33:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9313893CA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:33:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930A3143D;
        Fri,  3 Mar 2023 10:34:14 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1F013F93E;
        Fri,  3 Mar 2023 10:33:26 -0800 (PST)
Message-ID: <1e9b904f-c0ef-a21b-d92c-d52b14cc820f@arm.com>
Date:   Fri, 3 Mar 2023 18:33:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 02/18] x86/resctrl: Access per-rmid structures by index
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
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-3-james.morse@arm.com>
 <IA1PR11MB60979C2E98EA36A279BF9C119BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <IA1PR11MB60979C2E98EA36A279BF9C119BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
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

Hi Fenghua,

On 17/01/2023 18:28, Yu, Fenghua wrote:
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
>> index 52788f79786f..44d568f3577c 100644
>> --- a/arch/x86/include/asm/resctrl.h
>> +++ b/arch/x86/include/asm/resctrl.h
>> @@ -94,6 +101,23 @@ static inline void resctrl_sched_in(void)
>>  		__resctrl_sched_in();
>>  }
>>
>> +static inline u32 resctrl_arch_system_num_rmid_idx(void)
>> +{
>> +	/* RMID are independent numbers for x86. num_rmid_idx==num_rmid
>> */

> Is it better to change the comment to something like:
> +       /* RMIDs are independent of CLOSIDs and number of RMIDs is fixed. */

I agree the reference to x86 looks a bit funny, but its to explain why this 'idx'
concept exists before the MPAM code is merged that needs it.

I don't think it helps to say the number of RMID is fixed on x86, for MPAM there is no
direct equivalent, but everything there is fixed too. Its not the fixed property that this
is needed for, but the 'no equivalent'.


>> +	return boot_cpu_data.x86_cache_max_rmid + 1; }
>> +

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 13673cab175a..dbae380e3d1c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -142,12 +142,27 @@ static inline u64 get_corrected_mbm_count(u32 rmid,
>> unsigned long val)
>>  	return val;
>>  }
>>
>> -static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
>> +/*
>> + * x86 and arm64 differ in their handling of monitoring.
>> + * x86's RMID are an independent number, there is one RMID '1'.

> What do you mean by "one RMID '1'"?

If I could snoop the traffic on the interconnect, there would only be one source of
traffic with RMID value 1.

In contrast, if you did this on an arm machine, there would be numerous sources of traffic
with PMG value 1. This is because PMG isn't an independent number, it isn't equivalent to
RMID.


> Should this sentence be "x86's RMID is an independent number."?

Does it help to rephrase it as:
| * x86's RMID are an independent number, there is only one source of traffic
| * an RMID value of '1'.
| * arm64's PMG extend the PARTID/CLOSID space, there are multiple sources of
| * traffic with a PMG value of '1', one for each CLOSID, meaining the RMID
| * value is no longer unique.

?

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
>> -	WARN_ON(entry->rmid != rmid);
>> +	entry = &rmid_ptrs[idx];
>> +	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
>> +
>> +	WARN_ON_ONCE(entry->closid != closid);
>> +	WARN_ON_ONCE(entry->rmid != rmid);
>>
>>  	return entry;
>>  }

>> @@ -719,7 +744,7 @@ static int dom_data_init(struct rdt_resource *r)
>>  	 * default_rdtgroup control group, which will be setup later. See
>>  	 * rdtgroup_setup_root().
>>  	 */
>> -	entry = __rmid_entry(0, 0);
>> +	entry = __rmid_entry(resctrl_arch_rmid_idx_encode(0, 0));

> Better change to:
> +	entry = __rmid_entry(resctrl_arch_rmid_idx_encode(RESCTRL_BAD_CLOSID, 0));
> because this explicitly tells CLOSID is invalid here on X86.

Its not invalid, its the reserved value that MSR_IA32_PQR_ASSOC is set to when a task is
in the default control group, and when a CPU first comes online.

Reserving CLOSID ~0 would be ignored on x86, but hit a WARN_ON_ONCE() on arm64 because ~0
isn't a valid closid. The X86 in 'X86_RESCTRL_BAD_CLOSID' is the hint it should only
appear in x86 specific code!

How about:
|        idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID, 0);
|        entry = __rmid_entry(idx);

?

> 
>>  	list_del(&entry->list);
>>
>>  	return 0;


Thanks,

James
