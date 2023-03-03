Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE36A9EEB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCCSfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjCCSfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:35:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B8669EFD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:35:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A633143D;
        Fri,  3 Mar 2023 10:36:11 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E97B3F93E;
        Fri,  3 Mar 2023 10:35:24 -0800 (PST)
Message-ID: <90f5a52a-44b7-1d79-211e-a639ff6fa06d@arm.com>
Date:   Fri, 3 Mar 2023 18:35:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 06/18] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
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
 <20230113175459.14825-7-james.morse@arm.com>
 <IA1PR11MB609729461B9FF9F9BFD1DEC99BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <IA1PR11MB609729461B9FF9F9BFD1DEC99BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
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

On 17/01/2023 18:29, Yu, Fenghua wrote:
>> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
>> used for different control groups.
>>
>> This means once a CLOSID is allocated, all its monitoring ids may still be dirty,
>> and held in limbo.
>>
>> Add a helper to allow the CLOSID allocator to check if a CLOSID has dirty RMID
>> values. This behaviour is enabled by a kconfig option selected by the
>> architecture, which avoids a pointless search for x86.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 347be3767241..190ac183139e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -327,6 +327,37 @@ static struct rmid_entry *resctrl_find_free_rmid(u32
>> closid)
>>  	return ERR_PTR(-ENOSPC);
>>  }
>>
>> +/**
>> + * resctrl_closid_is_dirty - Determine if clean RMID can be allocate for this
> 
> s/allocate/allocated/
> 
>> + *                           CLOSID.
>> + * @closid: The CLOSID that is being queried.
>> + *
>> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocate
> 
> s/allocate/allocated/

(Both fixed, thanks)


>> +CLOSID
>> + * may not be able to allocate clean RMID. To avoid this the allocator
>> +will
>> + * only return clean CLOSID.
>> + */
>> +bool resctrl_closid_is_dirty(u32 closid) {
>> +	struct rmid_entry *entry;
>> +	int i;
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);
> 
> It's better to move lockdep_asser_held() after if (!IS_ENABLE()).
> Then compiler might optimize this function to empty on X86.

If you compile without lockdep it will be empty!
Is anyone worried about performance with lockdep enabled?

The reason for it being here is documentation and for the runtime check if you run with
lockdep. Having it here is so that new code that only runs on x86 (with lockdep) also
checks this, even though it doesn't have CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID.

I'd prefer to keep it so we can catch bugs early. Lockdep isn't on by default.


>> +
>> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>> +		return false;
>> +
>> +	for (i = 0; i < resctrl_arch_system_num_rmid_idx(); i++) {
>> +		entry = &rmid_ptrs[i];
>> +		if (entry->closid != closid)
>> +			continue;
>> +
>> +		if (entry->busy)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}


Thanks,

James
