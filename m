Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41686F072A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbjD0OUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243990AbjD0OU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:20:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0218459ED
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:20:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 634271063;
        Thu, 27 Apr 2023 07:20:55 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95DF83F64C;
        Thu, 27 Apr 2023 07:20:08 -0700 (PDT)
Message-ID: <348c5e26-0ee0-36fd-893b-4ff9fcae67c1@arm.com>
Date:   Thu, 27 Apr 2023 15:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 17/19] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
Content-Language: en-GB
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
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
 <20230320172620.18254-18-james.morse@arm.com>
 <118d53a6-e292-50a0-dc8f-32c573379ed7@linux.intel.com>
 <54165c70-795b-6e6e-aad-4089ddd6dbe5@linux.intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <54165c70-795b-6e6e-aad-4089ddd6dbe5@linux.intel.com>
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

On 21/03/2023 15:25, Ilpo Järvinen wrote:
> On Tue, 21 Mar 2023, Ilpo Jï¿œrvinen wrote:
>> On Mon, 20 Mar 2023, James Morse wrote:
>>
>>> When a CPU is taken offline resctrl may need to move the overflow or
>>> limbo handlers to run on a different CPU.
>>>
>>> Once the offline callbacks have been split, cqm_setup_limbo_handler()
>>> will be called while the CPU that is going offline is still present
>>> in the cpu_mask.
>>>
>>> Pass the CPU to exclude to cqm_setup_limbo_handler() and
>>> mbm_setup_overflow_handler(). These functions can use a variant of
>>> cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
>>> need excluding.

>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index 3eb5b307b809..47838ba6876e 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -78,6 +78,37 @@ static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>>>  	return cpu;
>>>  }
>>>  
>>> +/**
>>> + * cpumask_any_housekeeping_but() - Chose any cpu in @mask, preferring those
>>> + *			            that aren't marked nohz_full, excluding
>>> + *				    the provided CPU
>>> + * @mask:	The mask to pick a CPU from.
>>> + * @exclude_cpu:The CPU to avoid picking.
>>> + *
>>> + * Returns a CPU from @mask, but not @but. If there are houskeeping CPUs that
>>> + * don't use nohz_full, these are preferred.
>>> + * Returns >= nr_cpu_ids if no CPUs are available.
>>> + */
>>> +static inline unsigned int
>>> +cpumask_any_housekeeping_but(const struct cpumask *mask, int exclude_cpu)
>>> +{
>>> +	int cpu, hk_cpu;
>>> +
>>> +	cpu = cpumask_any_but(mask, exclude_cpu);
>>> +	if (tick_nohz_full_cpu(cpu)) {
>>> +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
>>> +		if  (hk_cpu == exclude_cpu) {
>>> +			hk_cpu = cpumask_nth_andnot(1, mask,
>>> +						    tick_nohz_full_mask);

>> I'm left to wonder if it's okay to alter tick_nohz_full_mask in resctrl 
>> code??

Why do you think cpumask_nth_andnot() modifies its arguments?

The cpumask arguments to cpumask_nth_andnot() are const.


> I suppose it should do instead:
> 		hk_cpu = cpumask_nth_and(0, mask, tick_nohz_full_mask);
> 		if (hk_cpu == exclude_cpu)
> 			hk_cpu = cpumask_next_and(hk_cpu, mask, tick_nohz_full_mask);
> 

Removing the 'not' changes the behaviour. hk_cpu is now guaranteed to be a nohz_full CPU.
This needs to prefer CPUs that are not in that mask.

Passing 'hk_cpu' the second time doesn't look right, hk_cpu is a CPU-number, not a count
of the 'nth CPU to find', which is what the argument expects.
For example: If the mask only has CPU 10-12, where CPU 10 should be excluded, its possible
the first attempt for the 0th CPU returns 10... in which case I want to pass '1' now I
know that the 0th is the excluded CPU. If I pass 10 I expect an error, as there aren't 10
bits set in the mask.


Thanks,

James
