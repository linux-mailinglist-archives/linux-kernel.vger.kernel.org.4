Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A066F0725
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbjD0OTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbjD0OTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:19:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04230212D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:19:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB9DD2F4;
        Thu, 27 Apr 2023 07:20:28 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AF2C3F64C;
        Thu, 27 Apr 2023 07:19:38 -0700 (PDT)
Message-ID: <b1b9225f-caa3-a868-6333-b7dadf17c5e7@arm.com>
Date:   Thu, 27 Apr 2023 15:19:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 12/19] x86/resctrl: Make resctrl_mounted checks
 explicit
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
 <20230320172620.18254-13-james.morse@arm.com>
 <94b54f42-a70b-498b-ca05-62528a98cea8@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <94b54f42-a70b-498b-ca05-62528a98cea8@intel.com>
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

On 01/04/2023 00:28, Reinette Chatre wrote:
> On 3/20/2023 10:26 AM, James Morse wrote:
>> The rdt_enable_key is switched when resctrl is mounted, and used to
>> prevent a second mount of the filesystem. It also enables the
>> architecture's context switch code.
>>
>> This requires another architecture to have the same set of static-keys,
>> as resctrl depends on them too.
>>
>> Make the resctrl_mounted checks explicit: resctrl can keep track of
>> whether it has been mounted once. This doesn't need to be combined with
>> whether the arch code is context switching the CLOSID.
>> Tests against the rdt_mon_enable_key become a test that resctrl is
>> mounted and that monitoring is enabled.
> 
> The last sentence above makes the code change hard to follow ...
> (see below)
> 
>>
>> This will allow the static-key changing to be moved behind resctrl_arch_
>> calls.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index f38cd2f12285..6279f5c98b39 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -834,7 +834,7 @@ void mbm_handle_overflow(struct work_struct *work)
>>  
>>  	mutex_lock(&rdtgroup_mutex);
>>  
>> -	if (!static_branch_likely(&rdt_mon_enable_key))
>> +	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
> 
> ... considering the text in the changelog the "resctrl_mounted" check seems
> unnecessary. Looking ahead I wonder if this check would not be more
> appropriate in patch 15?

How so?

This is secretly relying on rdt_mon_enable_key being cleared in rdt_kill_sb() when the
filesystem is unmounted, otherwise the overflow thread keeps running once the filesystem
is unmounted.

I thought it simpler to add all these checks explicitly in one go.
That makes it simpler to thin out the static keys as their 'and its mounted' behaviour is
no longer relied on.

I'll add comments for these cases covering why the filesystem-mounted check is needed.


>>  		goto out_unlock;
>>  
>>  	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> @@ -867,8 +867,9 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>>  	int cpu;
>>  
>> -	if (!static_branch_likely(&rdt_mon_enable_key))
>> +	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
>>  		return;
> 
> same here

If a domain comes online mbm_setup_overflow_handler() is called, if the filesystem is not
mounted, there is nothing for it to do. Today this relies on the architecture having a
static key that resctrl can toggle when it gets unmounted.


>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 2306fbc9a9bb..5176a85f281c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

>> @@ -3687,8 +3693,7 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>>  	if (is_llc_occupancy_enabled())
>>  		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
>>  
>> -	/* If resctrl is mounted, add per domain monitor data directories. */
>> -	if (static_branch_unlikely(&rdt_mon_enable_key))
>> +	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
>>  		mkdir_mondata_subdir_allrdtgrp(r, d);
>>  
>>  	return 0;
> 
> Above also, the resctrl_mounted check does not seem to be needed.

Today its implicit in the rdt_mon_enable_key.

If the filesystem isn't mounted, there is no need to create the directories as no-one can
see them. (it does look like it would be harmless as kernfs_create_root() is called once
at init time).
Instead this work gets done at mount time by rdt_get_tree() calling mkdir_mondata_all().


Thanks,

James
