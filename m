Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF8271126E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbjEYRcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240529AbjEYRcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:32:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 988CC19D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:32:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C48F165C;
        Thu, 25 May 2023 10:32:52 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF43C3F6C4;
        Thu, 25 May 2023 10:32:04 -0700 (PDT)
Message-ID: <db5c8ad5-6311-5833-c0e4-a3536840e4ad@arm.com>
Date:   Thu, 25 May 2023 18:32:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 08/19] x86/resctrl: Add cpumask_any_housekeeping() for
 limbo/overflow
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
 <20230320172620.18254-9-james.morse@arm.com>
 <8f10581c-63ff-fef5-4f9e-d1ded096528@linux.intel.com>
 <01e0704c-6d69-07ca-8a3b-c2cff498c972@arm.com>
 <b7af42dd-2169-5013-93d8-24eb5c37f5bf@linux.intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <b7af42dd-2169-5013-93d8-24eb5c37f5bf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On 27/04/2023 15:25, Ilpo Järvinen wrote:
> On Thu, 27 Apr 2023, James Morse wrote:
>> On 21/03/2023 15:14, Ilpo Jï¿œrvinen wrote:
>>> On Mon, 20 Mar 2023, James Morse wrote:
>>>
>>>> The limbo and overflow code picks a CPU to use from the domain's list
>>>> of online CPUs. Work is then scheduled on these CPUs to maintain
>>>> the limbo list and any counters that may overflow.
>>>>
>>>> cpumask_any() may pick a CPU that is marked nohz_full, which will
>>>> either penalise the work that CPU was dedicated to, or delay the
>>>> processing of limbo list or counters that may overflow. Perhaps
>>>> indefinitely. Delaying the overflow handling will skew the bandwidth
>>>> values calculated by mba_sc, which expects to be called once a second.
>>>>
>>>> Add cpumask_any_housekeeping() as a replacement for cpumask_any()
>>>> that prefers housekeeping CPUs. This helper will still return
>>>> a nohz_full CPU if that is the only option. The CPU to use is
>>>> re-evaluated each time the limbo/overflow work runs. This ensures
>>>> the work will move off a nohz_full CPU once a houskeeping CPU is
>>>
>>> housekeeping
>>>
>>>> available.
>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index 87545e4beb70..0b5fd5a0cda2 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>
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
>>>
>>> Why cpumask_nth_and() is not enough here? ..._andnot() seems to alter 
>>> tick_nohz_full_mask which doesn't seem desirable?
>>
>> tick_nohz_full_mask is the list of CPUs we should avoid. This wants to find the first cpu
>> set in the domain mask, and clear in tick_nohz_full_mask.
>>
>> Where does cpumask_nth_andnot() modify its arguments? Its arguments are const.
> 
> Ah, it doesn't, I'm sorry about that.
> 
> I think I was trapped by ambiguous English:
>  * cpumask_nth_andnot - get the first cpu set in 1st cpumask, and clear in 2nd.
> ...which can be understood as it clearing it in 2nd.
Great, I'm not going mad!

How could the english there be clearer?
"get the first cpu that is set in 1st cpumask, and not set in 2nd." ?


Thanks,

James
