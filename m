Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62FA6F072B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244035AbjD0OVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbjD0OVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:21:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C46A35BBB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:20:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F018EC14;
        Thu, 27 Apr 2023 07:21:08 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E68B3F64C;
        Thu, 27 Apr 2023 07:20:22 -0700 (PDT)
Message-ID: <e965ab8e-5277-d2c2-5174-2159f050a19f@arm.com>
Date:   Thu, 27 Apr 2023 15:20:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 18/19] x86/resctrl: Add cpu offline callback for
 resctrl work
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
 <20230320172620.18254-19-james.morse@arm.com>
 <988232ec-988f-5d12-eacb-8095d8c01eb6@linux.intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <988232ec-988f-5d12-eacb-8095d8c01eb6@linux.intel.com>
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

On 21/03/2023 15:32, Ilpo Järvinen wrote:
> On Mon, 20 Mar 2023, James Morse wrote:
> 
>> The resctrl architecture specific code may need to free a domain when
>> a CPU goes offline, it also needs to reset the CPUs PQR_ASSOC register.
>> The resctrl filesystem code needs to move the overflow and limbo work
>> to run on a different CPU, and clear this CPU from the cpu_mask of
>> control and monitor groups.
>>
>> Currently this is all done in core.c and called from
>> resctrl_offline_cpu(), making the split between architecture and
>> filesystem code unclear.
>>
>> Move the filesystem work into a filesystem helper called
>> resctrl_offline_cpu(), and rename the one in core.c
>> resctrl_arch_offline_cpu().
>>
>> The rdtgroup_mutex is unlocked and locked again in the call in
>> preparation for changing the locking rules for the architecture
>> code.
>>
>> resctrl_offline_cpu() is called before any of the resource/domains
>> are updated, and makes use of the exclude_cpu feature that was
>> previously added.

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index aafe4b74587c..4e5fc89dab6d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -578,22 +578,6 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>>  
>>  		return;
>>  	}
>> -
>> -	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
>> -		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
>> -			cancel_delayed_work(&d->mbm_over);
>> -			/*
>> -			 * exclude_cpu=-1 as this CPU has already been removed
>> -			 * by cpumask_clear_cpu()d
>> -			 */
> 
> This was added in 17/19 and now removed (not moved) in 18/19. Please avoid 
> such back-and-forth churn.

This is the cost of making small incremental changes that should be easier to review.
The intermediate step was a little odd, so came with a comment. (I normally mark those as
'temporary', but didn't bother this time as they are adjacent patches)

If you'd prefer, I can merge these patches together... but from Reinette's feedback its
likely I'll split them up even more.


Thanks,

James
