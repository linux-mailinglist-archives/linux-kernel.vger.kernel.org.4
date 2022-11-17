Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1100662D7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbiKQKJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiKQKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:09:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09BDD24095;
        Thu, 17 Nov 2022 02:09:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A0C513D5;
        Thu, 17 Nov 2022 02:09:19 -0800 (PST)
Received: from [10.1.28.20] (e121896.cambridge.arm.com [10.1.28.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60AA23F73B;
        Thu, 17 Nov 2022 02:09:10 -0800 (PST)
Message-ID: <f1a3b3bc-bfa4-e54e-cd2f-a9ee70d56850@arm.com>
Date:   Thu, 17 Nov 2022 10:09:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 6/7] arm64/perf: Add BRBE driver
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
References: <20221107062514.2851047-1-anshuman.khandual@arm.com>
 <20221107062514.2851047-7-anshuman.khandual@arm.com>
 <1d06f05c-0e7f-7648-6b1b-b78e999bc65f@arm.com>
 <a065d948-3b9c-86bf-4a10-45d9c47e7ea1@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <a065d948-3b9c-86bf-4a10-45d9c47e7ea1@arm.com>
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



On 17/11/2022 05:45, Anshuman Khandual wrote:
> 
> 
> On 11/16/22 22:12, James Clark wrote:
>>
>>
>> On 07/11/2022 06:25, Anshuman Khandual wrote:
>> [...]
>>
>>> +static void perf_branch_to_brbcr(struct pmu_hw_events *cpuc, int branch_type)
>>> +{
>>> +	cpuc->brbcr = (BRBCR_EL1_CC | BRBCR_EL1_MPRED);
>>> +
>>> +	if (branch_type & PERF_SAMPLE_BRANCH_USER)
>>> +		cpuc->brbcr |= BRBCR_EL1_E0BRE;
>>> +
>>> +	if (branch_type & PERF_SAMPLE_BRANCH_NO_CYCLES)
>>> +		cpuc->brbcr &= ~BRBCR_EL1_CC;
>>> +
>>> +	if (branch_type & PERF_SAMPLE_BRANCH_NO_FLAGS)
>>> +		cpuc->brbcr &= ~BRBCR_EL1_MPRED;
>>> +
>>> +	if (branch_type & PERF_SAMPLE_BRANCH_KERNEL)
>>> +		cpuc->brbcr |= BRBCR_EL1_E1BRE;
>>> +	else
>>> +		return;
>>> +
>>> +	/*
>>> +	 * The exception and exception return branches could be
>>> +	 * captured only when the event has necessary privilege
>>> +	 * indicated via branch type PERF_SAMPLE_BRANCH_KERNEL,
>>> +	 * which has been ascertained in generic perf. Please
>>> +	 * refer perf_copy_attr() for more details.
>>> +	 */
>>> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
>>> +		cpuc->brbcr |= BRBCR_EL1_EXCEPTION;
>>> +		cpuc->brbcr |= BRBCR_EL1_ERTN;
>>
>> Because this comes after the PERF_SAMPLE_BRANCH_KERNEL check, it's
>> impossible to get syscall records from userspace. When you enable kernel
>> branch records, the buffer always fills up before it gets to userspace.
> 
> Just to summerize.
> 
> System call [user_addr -> kernel_addr] and return [kernel_addr -> user_addr]
> records are impossible to be captured, because
> 
> - Without PERF_SAMPLE_BRANCH_KERNEL, BRBCR_EL1_EXCEPTION/ERTN are not set
> - With PERF_SAMPLE_BRANCH_KERNEL, buffer fills up with in kernel branches
> 

Yep that's it

> Did you try with latest fix, that clears the paused BRBE after reading branch
> records during PMU interrupt ? That fix creates much more samples than before.
> 

Yes that's with the latest fix. It may even make the problem more
obvious with the fix rather than without.

>>
>> Can you move this to the top so that it can be set if either
>> PERF_SAMPLE_BRANCH_USER or PERF_SAMPLE_BRANCH_KERNEL is set. The
> 
> Why should they depend on privilege filters i.e PERF_SAMPLE_BRANCH_USER/KERNEL
> rather than just branch filters PERF_SAMPLE_BRANCH_ANY/ANY_CALL/ANY_RETURN ?
> 

Exactly, I don't think they should depend on the privilege level. But at
the moment we return before setting them unless
PERF_SAMPLE_BRANCH_KERNEL is set.

>> hardware already handles the security by giving partial records with the
>> kernel part zeroed out so I don't think the driver needs to add any
>> additional rules other than setting BRBCR_EL1_E1BRE or BRBCR_EL1_E0BRE.
> 
> Basically BRBCR_EL1_EXCEPTION/BRBCR_EL1_ERTN should be treated like any other
> branch filter rather than privilege filters as is the case now ?

I think so yes

> 
>>
>> For example I moved it to the top, removed the return below and then I
>> get syscall partial records:
>>
>> ....  5: 0000000000745d0c -> 0000000000000000 0 cycles  P   9fbfbfbf SYSCALL
>>
>> I also get ERETS but with only the userspace part set:
>>
>> .....  4: 0000000000000000 -> 0000000000745d10 0 cycles  P   9fbfbfbf ERET
> But with both user and kernel privilege filters being set, these should have
> been complete branch records containing both user and kernel addresses ?

Yes, but I only set PERF_SAMPLE_BRANCH_USER, I should have given the
perf command as well:

  perf record -j any,save_type,u -- syscall_loop

Where syscall_loop obviously generates lots of SYSCALLS and ERETS. But
with both user and kernel you just don't get to that point before the
buffer fills up. At least in per process mode, maybe with -a the timings
are different.

> 
>>
>>> +		return;
>>> +	}
>>> +
>>> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL)
>>> +		cpuc->brbcr |= BRBCR_EL1_EXCEPTION;
>>> +
>>> +	if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
>>> +		cpuc->brbcr |= BRBCR_EL1_ERTN;
>>> +}
>>> +
> 
> [....]
