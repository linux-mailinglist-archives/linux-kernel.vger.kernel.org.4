Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA84F6C1D93
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjCTRRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjCTRR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:17:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F3E321963
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:13:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89A0FFEC;
        Mon, 20 Mar 2023 10:13:07 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D14C3F67D;
        Mon, 20 Mar 2023 10:12:20 -0700 (PDT)
Message-ID: <7a07defc-356b-6dc2-e3af-c52b1730fc9b@arm.com>
Date:   Mon, 20 Mar 2023 17:12:19 +0000
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
 <39a3aad1-b340-2a6a-925f-b3a7614eb92a@arm.com>
 <a578d211-ab94-d449-3ba9-7e8788ace484@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <a578d211-ab94-d449-3ba9-7e8788ace484@intel.com>
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

On 10/03/2023 19:59, Reinette Chatre wrote:
> On 3/3/2023 10:36 AM, James Morse wrote:
>> On 02/02/2023 23:46, Reinette Chatre wrote:
>>> On 1/13/2023 9:54 AM, James Morse wrote:
> 
> ...
> 
>>>> +bool resctrl_closid_is_dirty(u32 closid)
>>>> +{
>>>> +	struct rmid_entry *entry;
>>>> +	int i;
>>>> +
>>>> +	lockdep_assert_held(&rdtgroup_mutex);
>>>> +
>>>> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
>>>> +		return false;
>>
>>> Why is a config option chosen? Is this not something that can be set in the
>>> architecture specific code using a global in the form matching existing related
>>> items like "arch_has..." or "arch_needs..."?
>>
>> It doesn't vary by platform, so making it a runtime variable would mean x86 has to carry
>> this extra code around, even though it will never use it. Done like this, the compiler can
>> dead-code eliminate the below checks and embed the constant return value in all the callers.

> This is fair. I missed any other mention of this option in this series so I
> assume this will be a config that will be "select"ed automatically without
> users needing to think about whether it is needed?

Yes, MPAM platforms would unconditionally enable it, as it reflects how MPAM works. [0]
Users would never need to know it exists.


>>>> +	for (i = 0; i < resctrl_arch_system_num_rmid_idx(); i++) {
>>>> +		entry = &rmid_ptrs[i];
>>>> +		if (entry->closid != closid)
>>>> +			continue;
>>>> +
>>>> +		if (entry->busy)
>>>> +			return true;
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>
>>> If I understand this correctly resctrl_closid_is_dirty() will return true if
>>> _any_ RMID/PMG associated with a CLOSID is in use. That is, a CLOSID may be
>>> able to support 100s of PMG but if only one of them is busy then the CLOSID
>>> will be considered unusable ("dirty"). It sounds to me that there could be scenarios
>>> when CLOSID could be considered unavailable while there are indeed sufficient
>>> resources?
>>
>> You are right this could happen. I guess the better approach would be to prefer the
>> cleanest CLOSID that has a clean PMG=0. User-space may not be able to allocate all the
>> monitor groups immediately, but that would be preferable to failing the control group
>> creation.
>>
>> But as this code doesn't get built until the MPAM driver is merged, I'd like to keep it to
>> an absolute minimum. This would be more than is needed for MPAM to have close to resctrl
>> feature-parity, so I'd prefer to do this as an improvement once the MPAM driver is upstream.
>>
>> (also in this category is better use of MPAM's monitors and labelling traffic from the iommu)
>>
>>
>>> The function comment states "Determine if clean RMID can be allocate for this
>>> CLOSID." - if I understand correctly it behaves more like "Determine if all
>>> RMID associated with CLOSID are available".
>>
>> Yes, I'll fix that.
> 
> I understand your reasoning for the solution chosen. Would you be ok to expand on
> the function comment more to document the intentions that you summarize above (eg. "This
> is the absolute minimum solution that will be/should be/could be improved ...")?

Sure thing,


Thanks,

James

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/Kconfig?h=mpam/snapshot/v6.2&id=ef6b11256ba2cceaff846c96183e8eb6019642d7
