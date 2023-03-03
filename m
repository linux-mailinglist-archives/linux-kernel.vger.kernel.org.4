Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471CE6A9EE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjCCSdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjCCSdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:33:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC1F1212C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:33:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB1CB143D;
        Fri,  3 Mar 2023 10:34:30 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38B7C3F93E;
        Fri,  3 Mar 2023 10:33:42 -0800 (PST)
Message-ID: <f9b5dc0e-c5f1-b2ad-db7e-ce4046600724@arm.com>
Date:   Fri, 3 Mar 2023 18:33:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 02/18] x86/resctrl: Access per-rmid structures by index
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
 <20230113175459.14825-3-james.morse@arm.com>
 <8d56cbf0-7522-6718-a38e-164dee9464bd@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <8d56cbf0-7522-6718-a38e-164dee9464bd@intel.com>
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

Hi Reinette,

On 02/02/2023 23:44, Reinette Chatre wrote:
> On 1/13/2023 9:54 AM, James Morse wrote:
>> Because of the differences between Intel RDT/AMD QoS and Arm's MPAM
>> monitors, RMID values on arm64 are not unique unless the CLOSID is
>> also included. Bitmaps like rmid_busy_llc need to be sized by the
>> number of unique entries for this resource.
>>
>> Add helpers to encode/decode the CLOSID and RMID to an index. The
>> domain's busy_rmid_llc and the rmid_ptrs[] array are then sized by
> 
> busy_rmid_llc -> rmid_busy_llc ?
> 
> Could you please also mention the MBM state impacted?

Yup, this paragraph reworded as:
| Add helpers to encode/decode the CLOSID and RMID to an index. The
| domain's rmid_busy__llc and the rmid_ptrs[] array are then sized by
| index, as are the domain mbm_local and mbm_total arrays.
| On x86, the index is always just the RMID, so all these structures
| remain the same size.
|
| The index gives resctrl a unique value it can use to store monitor
| values, and allows MPAM to decode the closid when reading the hardware
| counters.

>> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
>> index 52788f79786f..44d568f3577c 100644
>> --- a/arch/x86/include/asm/resctrl.h
>> +++ b/arch/x86/include/asm/resctrl.h
>> @@ -7,6 +7,13 @@
>>  #include <linux/sched.h>
>>  #include <linux/jump_label.h>
>>  
>> +/*
>> + * This value can never be a valid CLOSID, and is used when mapping a
>> + * (closid, rmid) pair to an index and back. On x86 only the RMID is
>> + * needed.
>> + */
>> +#define X86_RESCTRL_BAD_CLOSID		~0

> Should this be moved to previous patch where first usage of ~0 appears?

Makes sense,


> Also, not having a size creates opportunity for inconsistencies. How
> about ((u32)~0) ?

Yes, the compilers secret expectations on sizes always catch me out!


>> +
>>  /**
>>   * struct resctrl_pqr_state - State cache for the PQR MSR
>>   * @cur_rmid:		The cached Resource Monitoring ID
>> @@ -94,6 +101,23 @@ static inline void resctrl_sched_in(void)
>>  		__resctrl_sched_in();
>>  }
>>  
>> +static inline u32 resctrl_arch_system_num_rmid_idx(void)
>> +{
>> +	/* RMID are independent numbers for x86. num_rmid_idx==num_rmid */
>> +	return boot_cpu_data.x86_cache_max_rmid + 1;
>> +}

> It seems that this helper and its subsequent usage eliminates the
> need for struct rdt_resource::num_rmid? Are any users left?

The only user in the filesystem parts of resctrl is rdt_num_rmids_show(), which exposes
the value to user-space. The value is unfortunately meaningless on MPAM systems, but as
its user-space ABI, it has to stay.

The remaining users in the x86 specific code:
domain_add_cpu() continues to use r->num_rmid as the arch code can know its the same
number as num_idx, and rdt_get_mon_l3_config() calculates the value.


Thanks,

James
