Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435E871126D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbjEYRcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEYRcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:32:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE6BD189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:32:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9957D1655;
        Thu, 25 May 2023 10:32:50 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B79013F840;
        Thu, 25 May 2023 10:32:02 -0700 (PDT)
Message-ID: <c6038e0e-68c2-f637-5b1f-7fba8cad6222@arm.com>
Date:   Thu, 25 May 2023 18:32:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 08/19] x86/resctrl: Add cpumask_any_housekeeping() for
 limbo/overflow
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
 <20230320172620.18254-9-james.morse@arm.com>
 <3145caff-4e73-0ef2-5bc2-70cdfe7953e9@intel.com>
 <78256a0f-d6e2-9c65-610d-ff962fdfed5b@arm.com>
 <c099e82e-540a-c4e4-2efb-3db24481a64c@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <c099e82e-540a-c4e4-2efb-3db24481a64c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 28/04/2023 00:36, Reinette Chatre wrote:
> On 4/27/2023 7:10 AM, James Morse wrote:
>> On 01/04/2023 00:24, Reinette Chatre wrote:
>>> On 3/20/2023 10:26 AM, James Morse wrote:

>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index 87545e4beb70..0b5fd5a0cda2 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -55,6 +56,28 @@
>>>>  /* Max event bits supported */
>>>>  #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>>>>  
>>>> +/**
>>>> + * cpumask_any_housekeeping() - Chose any cpu in @mask, preferring those that
>>>> + *			        aren't marked nohz_full
>>>> + * @mask:	The mask to pick a CPU from.
>>>> + *
>>>> + * Returns a CPU in @mask. If there are houskeeping CPUs that don't use
>>>> + * nohz_full, these are preferred.
>>>> + */
>>>> +static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
>>>> +{
>>>> +	int cpu, hk_cpu;
>>>> +
>>>> +	cpu = cpumask_any(mask);
>>>> +	if (tick_nohz_full_cpu(cpu)) {
>>>> +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
>>>> +		if (hk_cpu < nr_cpu_ids)
>>>> +			cpu = hk_cpu;
>>>> +	}
>>>> +
>>
>>> I think as a start this could perhaps be a #if defined(CONFIG_NO_HZ_FULL). There
>>> appears to be a precedent for this in kernel/rcu/tree_nocb.h.
>>
>> This harms readability, and prevents the compiler from testing that this is valid C code
>> for any compile of this code.
>>
>> With if-def's here you'd be reliant on come CI system to build with the required
>> combination of Kconfig symbols to expose any warnings.
>>
>> It's much better to use IS_ENABLED() in the helpers and rely on the compiler's
>> dead-code-elimination to remove paths that have been configured out.
>>
>> (See the section on Conditional Compilation in coding-style for a much better summary!)
> 
> My assumption was that you intended to implement what is described first in
> the document you point to. That is, providing no-stub versions for all
> and then calling everything unconditionally. Since I did not see universal stubs
> for the code you are using I was looking at how other areas in the kernel handled
> the same. 
> 
> Reading your response to Ilpo and what you write later I now see that you are using
> a combination of no-op stubs and conditional compilation. That is, you use a no-op stub,
> instead of "IS_ENABLED()" or "#if" to conditionally compile some code. I am not familiar
> with how compilers handle these scenarios.
> 

>>>> diff --git a/include/linux/tick.h b/include/linux/tick.h
>>>> index bfd571f18cfd..ae2e9019fc18 100644
>>>> --- a/include/linux/tick.h
>>>> +++ b/include/linux/tick.h
>>>> @@ -174,9 +174,10 @@ static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
>>>>  static inline void tick_nohz_idle_stop_tick_protected(void) { }
>>>>  #endif /* !CONFIG_NO_HZ_COMMON */
>>>>  
>>>> +extern cpumask_var_t tick_nohz_full_mask;
>>>> +
>>>>  #ifdef CONFIG_NO_HZ_FULL
>>>>  extern bool tick_nohz_full_running;
>>>> -extern cpumask_var_t tick_nohz_full_mask;
>>>>  
>>>>  static inline bool tick_nohz_full_enabled(void)
>>>>  {
>>>
>>> In addition to what Ilpo pointed out, be careful here.
>>> cpumask_var_t is a pointer (or array) and needs to be
>>> allocated before use. Moving its declaration but not the
>>> allocation code seems risky.
>>
>> Risky how? Any use of tick_nohz_full_mask that isn't guarded by something like
>> tick_nohz_full_cpu() will lead to a link error regardless of the type.
> 
> I assumed that the intention was to create an actual "no-op" stub for this
> mask, enabling it to be used unconditionally. That the intention is for it
> to be guarded and how the compiler deals with this was not obvious to me. I think
> it would be good to call out this usage when submitting this to the appropriate
> maintainers. A comment near the declaration may help users to know how it is
> intended to be used.

Right, I'll add a comment:
/*
 * Mask of CPUs that are nohz_full.
 *
 * Users should be guarded by CONFIG_NO_HZ_FULL or a tick_nohz_full_cpu()
 * check.
 */




Thanks,

James
