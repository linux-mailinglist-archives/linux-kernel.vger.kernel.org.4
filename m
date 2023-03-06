Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1026AB801
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCFILa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFIL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:11:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F0E5AD18
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:11:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3023412FC;
        Mon,  6 Mar 2023 00:00:23 -0800 (PST)
Received: from [10.162.42.7] (a077893.blr.arm.com [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 047FF3F885;
        Sun,  5 Mar 2023 23:59:37 -0800 (PST)
Message-ID: <2f16732b-12d4-fc8c-040d-2ef081a7bb15@arm.com>
Date:   Mon, 6 Mar 2023 13:29:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V7 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-6-anshuman.khandual@arm.com>
 <Y8AZXQJUO6h5mlgq@FVFF77S0Q05N>
 <bdcc2d71-b216-ade6-203d-0a527d0503ff@arm.com>
 <Y+P5oGRfdaCYRkbL@FVFF77S0Q05N.cambridge.arm.com>
 <f952612b-db37-c21e-4dde-12202768cb44@arm.com>
 <Y/dudjSnIFtHzNRI@FVFF77S0Q05N.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y/dudjSnIFtHzNRI@FVFF77S0Q05N.cambridge.arm.com>
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



On 2/23/23 19:17, Mark Rutland wrote:
> On Mon, Feb 13, 2023 at 01:53:56PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 2/9/23 01:06, Mark Rutland wrote:
>>> On Fri, Jan 13, 2023 at 10:41:51AM +0530, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 1/12/23 19:59, Mark Rutland wrote:
>>>>> On Thu, Jan 05, 2023 at 08:40:38AM +0530, Anshuman Khandual wrote:
>>>>>> @@ -878,6 +890,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>>>>>  		if (!armpmu_event_set_period(event))
>>>>>>  			continue;
>>>>>>  
>>>>>> +		if (has_branch_stack(event)) {
>>>>>> +			WARN_ON(!cpuc->branches);
>>>>>> +			armv8pmu_branch_read(cpuc, event);
>>>>>> +			data.br_stack = &cpuc->branches->branch_stack;
>>>>>> +			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
>>>>>> +		}
>>>>>
>>>>> How do we ensure the data we're getting isn't changed under our feet? Is BRBE
>>>>> disabled at this point?
>>>>
>>>> Right, BRBE is paused after a PMU IRQ. We also ensure the buffer is disabled for
>>>> all exception levels, i.e removing BRBCR_EL1_E0BRE/E1BRE from the configuration,
>>>> before initiating the actual read, which eventually populates the data.br_stack.
>>>
>>> Ok; just to confirm, what exactly is the condition that enforces that BRBE is
>>> disabled? Is that *while* there's an overflow asserted, or does something else
>>> get set at the instant the overflow occurs?
>>
>> - BRBE can be disabled completely via BRBCR_EL1_E0BRE/E1BRE irrespective of PMU interrupt
>> - But with PMU interrupt, it just pauses if BRBCR_EL1_FZP is enabled
> 
> IIUC the distinction between "disabled completely" and "just pauses" doesn't
> really matter to us, and a pause is sufficient for use to be able to read and
> manipulate the records.
As I learned from the HW folks earlier, but seems like we might have to revisit
this understanding once again.

'Pause' state ensures that no new branch records could not get into the buffer
which is necessary, but not sufficient enough condition before all the branch
records could be processed in software. BRBE "disabled completely" via putting
in prohibited region (implicitly during PMU interrupt while tracing user only
sessions, explicitly while tracing user/kernel/hv sessions) is still necessary.

> 
> I also note that we always set BRBCR_EL1.FZP.
> 
> Am I missing something?

We always set BRBCR_EL1.FZP, but during PMU interrupt while processing branch
records, there are certain distinctions. 

user only traces:

	- Ensuring BRBFCR_EL1_PAUSED being set is not necessary
	- BRBE is already in prohibited region (IRQ handler in EL1)
	- Exception transition serve as a context synchronization event
	- Branch records can be read and processed right away
	- Return after clearing BRBFCR_EL1_PAUSED followed by BRB_IALL
	- isb() is not even necessary before returning 
	- ERET from EL1 will ensure a context a synchronization event

privilege traces:
	
	- Ensuring BRBFCR_EL1_PAUSED is necessary
	- Ensuring BRBE is in prohibited state - SW clears BRBCR_EL1_E1BR
	- isb() is required to ensure BRBE is prohibited state before reading
	- Return after clearing BRBFCR_EL1_PAUSED followed by BRB_IALL
	- isb() is required while returning from IRQ handler

I had suggested differentiating user only sessions, because it can save multiple
isb() instances and register write accesses which is not possible for privilege
trace sessions.

- Anshuman
