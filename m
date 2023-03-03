Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A2B6A9EEC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjCCSg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCCSgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:36:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA87D5FE90
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:36:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3D19143D;
        Fri,  3 Mar 2023 10:37:36 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE5953F93E;
        Fri,  3 Mar 2023 10:36:48 -0800 (PST)
Message-ID: <39a3aad1-b340-2a6a-925f-b3a7614eb92a@arm.com>
Date:   Fri, 3 Mar 2023 18:36:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 06/18] x86/resctrl: Allow the allocator to check if a
 CLOSID can allocate clean RMID
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
 <20230113175459.14825-7-james.morse@arm.com>
 <50324934-20ee-51e5-67a9-f1cd823230d1@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <50324934-20ee-51e5-67a9-f1cd823230d1@intel.com>
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

On 02/02/2023 23:46, Reinette Chatre wrote:
> On 1/13/2023 9:54 AM, James Morse wrote:
>> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
>> used for different control groups.
>>
>> This means once a CLOSID is allocated, all its monitoring ids may still be
>> dirty, and held in limbo.
>>
>> Add a helper to allow the CLOSID allocator to check if a CLOSID has dirty
>> RMID values. This behaviour is enabled by a kconfig option selected by
>> the architecture, which avoids a pointless search for x86.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 347be3767241..190ac183139e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -327,6 +327,37 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>>  	return ERR_PTR(-ENOSPC);
>>  }
>>  
>> +/**
>> + * resctrl_closid_is_dirty - Determine if clean RMID can be allocate for this
>> + *                           CLOSID.
>> + * @closid: The CLOSID that is being queried.
>> + *
>> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocate CLOSID
>> + * may not be able to allocate clean RMID. To avoid this the allocator will
>> + * only return clean CLOSID.
>> + */
>> +bool resctrl_closid_is_dirty(u32 closid)
>> +{
>> +	struct rmid_entry *entry;
>> +	int i;
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>> +		return false;

> Why is a config option chosen? Is this not something that can be set in the
> architecture specific code using a global in the form matching existing related
> items like "arch_has..." or "arch_needs..."?

It doesn't vary by platform, so making it a runtime variable would mean x86 has to carry
this extra code around, even though it will never use it. Done like this, the compiler can
dead-code eliminate the below checks and embed the constant return value in all the callers.


> 
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
> 
> If I understand this correctly resctrl_closid_is_dirty() will return true if
> _any_ RMID/PMG associated with a CLOSID is in use. That is, a CLOSID may be
> able to support 100s of PMG but if only one of them is busy then the CLOSID
> will be considered unusable ("dirty"). It sounds to me that there could be scenarios
> when CLOSID could be considered unavailable while there are indeed sufficient
> resources?

You are right this could happen. I guess the better approach would be to prefer the
cleanest CLOSID that has a clean PMG=0. User-space may not be able to allocate all the
monitor groups immediately, but that would be preferable to failing the control group
creation.

But as this code doesn't get built until the MPAM driver is merged, I'd like to keep it to
an absolute minimum. This would be more than is needed for MPAM to have close to resctrl
feature-parity, so I'd prefer to do this as an improvement once the MPAM driver is upstream.

(also in this category is better use of MPAM's monitors and labelling traffic from the iommu)


> The function comment states "Determine if clean RMID can be allocate for this
> CLOSID." - if I understand correctly it behaves more like "Determine if all
> RMID associated with CLOSID are available".

Yes, I'll fix that.


Thanks!

James
