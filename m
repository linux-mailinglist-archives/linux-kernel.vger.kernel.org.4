Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E75F6ABE40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCFLe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjCFLeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:34:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3C5723DB8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:34:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4CF912FC;
        Mon,  6 Mar 2023 03:35:19 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 635123F5A1;
        Mon,  6 Mar 2023 03:34:33 -0800 (PST)
Message-ID: <cc4eed18-1966-ebcf-8ae1-81b7e0833299@arm.com>
Date:   Mon, 6 Mar 2023 11:34:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 18/18] x86/resctrl: Separate arch and fs resctrl locks
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
 <20230113175459.14825-19-james.morse@arm.com>
 <d7d43c53-a482-100f-8a25-4dae6500d184@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <d7d43c53-a482-100f-8a25-4dae6500d184@intel.com>
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

On 02/02/2023 23:50, Reinette Chatre wrote:
> On 1/13/2023 9:54 AM, James Morse wrote:
>> resctrl has one mutex that is taken by the architecture specific code,
>> and the filesystem parts. The two interact via cpuhp, where the
>> architecture code updates the domain list. Filesystem handlers that
>> walk the domains list should not run concurrently with the cpuhp
>> callback modifying the list.
>>
>> Exposing a lock from the filesystem code means the interface is not
>> cleanly defined, and creates the possibility of cross-architecture
>> lock ordering headaches. The interaction only exists so that certain
>> filesystem paths are serialised against cpu hotplug. The cpu hotplug
>> code already has a mechanism to do this using cpus_read_lock().
>>
>> MPAM's monitors have an overflow interrupt, so it needs to be possible
>> to walk the domains list in irq context. RCU is ideal for this,
>> but some paths need to be able to sleep to allocate memory.
>>
>> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
>> of a cpuhp callback, cpus_read_lock() must always be taken first.
>> rdtgroup_schemata_write() already does this.
>>
>> All but one of the filesystem code's domain list walkers are
>> currently protected by the rdtgroup_mutex taken in
>> rdtgroup_kn_lock_live(). The exception is rdt_bit_usage_show()
>> which takes the lock directly.
> 
> The new BMEC code also. You can find it on tip's x86/cache branch,
> see mbm_total_bytes_config_write() and mbm_local_bytes_config_write().
> 
>>
>> Make the domain list protected by RCU. An architecture-specific
>> lock prevents concurrent writers. rdt_bit_usage_show() can
>> walk the domain list under rcu_read_lock().
>> The other filesystem list walkers need to be able to sleep.
>> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
>> cpuhp callbacks can't be invoked when file system operations are
>> occurring.
>>
>> Add lockdep_assert_cpus_held() in the cases where the
>> rdtgroup_kn_lock_live() call isn't obvious.
>>
>> Resctrl's domain online/offline calls now need to take the
>> rdtgroup_mutex themselves.


>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 7896fcf11df6..dc1ba580c4db 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -25,8 +25,14 @@
>>  #include <asm/resctrl.h>
>>  #include "internal.h"
>>  
>> -/* Mutex to protect rdtgroup access. */
>> -DEFINE_MUTEX(rdtgroup_mutex);
>> +/*
>> + * rdt_domain structures are kfree()d when their last cpu goes offline,
>> + * and allocated when the first cpu in a new domain comes online.
>> + * The rdt_resource's domain list is updated when this happens. The domain
>> + * list is protected by RCU, but callers can also take the cpus_read_lock()
>> + * to prevent modification if they need to sleep. All writers take this mutex:
> 
> Using "callers can" is not specific (compare to "callers should"). Please provide
> clear guidance on how the locks should be used. Reader may wonder "why take cpus_read_lock()
> to prevent modification, why not just take the mutex to prevent modification?"

'if they need to sleep' is the answer to this. I think a certain amount of background
knowledge can be assumed. My aim here wasn't to write an essay, but indicate not all
readers do the same thing. This is already the case in resctrl, and the MPAM pmu stuff
makes that worse.

Is this more robust:
| * rdt_domain structures are kfree()d when their last cpu goes offline,
| * and allocated when the first cpu in a new domain comes online.
| * The rdt_resource's domain list is updated when this happens. Readers of
| * the domain list must either take cpus_read_lock(), or rely on an RCU
| * read-side critical section, to avoid observing concurrent modification.
| * For information about RCU, see Docuemtation/RCU/rcu.rst.
| * All writers take this mutex:

?


>> @@ -541,7 +550,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>>  	cpumask_clear_cpu(cpu, &d->cpu_mask);
>>  	if (cpumask_empty(&d->cpu_mask)) {
>>  		resctrl_offline_domain(r, d);
>> -		list_del(&d->list);
>> +		list_del_rcu(&d->list);
>> +		synchronize_rcu();
>>  
>>  		/*
>>  		 * rdt_domain "d" is going to be freed below, so clear

> Should domain_remove_cpu() also get a "lockdep_assert_held(&domain_list_lock)"?

Yes, not sure why I didn't do that!


>> @@ -569,30 +579,27 @@ static void clear_closid_rmid(int cpu)
>>  static int resctrl_arch_online_cpu(unsigned int cpu)
>>  {
>>  	struct rdt_resource *r;
>> -	int err;
>>  
>> -	mutex_lock(&rdtgroup_mutex);
>> +	mutex_lock(&domain_list_lock);
>>  	for_each_capable_rdt_resource(r)
>>  		domain_add_cpu(cpu, r);
>>  	clear_closid_rmid(cpu);
>> +	mutex_unlock(&domain_list_lock);

> Why is clear_closid_rmid(cpu) protected by mutex?

It doesn't need to be, its just an artefact of changing the lock, then moving the
filesystem calls out. (its doesn't need to be protected by rdtgroup_mutex today).

If you don't think its churn, I'll move it to make it clearer.


Thanks,

James
