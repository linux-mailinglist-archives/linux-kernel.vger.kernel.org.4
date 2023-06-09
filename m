Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA4729BAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbjFINfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbjFINev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:34:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 999892D48;
        Fri,  9 Jun 2023 06:34:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4797AB6;
        Fri,  9 Jun 2023 06:35:34 -0700 (PDT)
Received: from [10.57.24.231] (unknown [10.57.24.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E0363F71E;
        Fri,  9 Jun 2023 06:34:47 -0700 (PDT)
Message-ID: <510f88f2-574c-097f-7299-2842b1cf432d@arm.com>
Date:   Fri, 9 Jun 2023 14:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V11 06/10] arm64/perf: Enable branch stack events via
 FEAT_BRBE
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-7-anshuman.khandual@arm.com>
 <ZH3mhorKNo77hsv5@FVFF77S0Q05N>
 <e960d5d5-07a8-2049-7d0a-07268ecfe36a@arm.com>
 <ZIMfVsF50cODuOYx@FVFF77S0Q05N.cambridge.arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <ZIMfVsF50cODuOYx@FVFF77S0Q05N.cambridge.arm.com>
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



On 09/06/2023 13:47, Mark Rutland wrote:
> On Fri, Jun 09, 2023 at 10:52:37AM +0530, Anshuman Khandual wrote:
>> [...]
>>
>> On 6/5/23 19:13, Mark Rutland wrote:
>>>> +void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
>>>> +{
>>>> +	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;
>>>> +	u64 brbfcr, brbcr;
>>>> +	int idx, loop1_idx1, loop1_idx2, loop2_idx1, loop2_idx2, count;
>>>> +
>>>> +	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>>>> +	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>>>> +
>>>> +	/* Ensure pause on PMU interrupt is enabled */
>>>> +	WARN_ON_ONCE(!(brbcr & BRBCR_EL1_FZP));
>>>> +
>>>> +	/* Pause the buffer */
>>>> +	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>>>> +	isb();
>>>> +
>>>> +	/* Determine the indices for each loop */
>>>> +	loop1_idx1 = BRBE_BANK0_IDX_MIN;
>>>> +	if (brbe_attr->brbe_nr <= BRBE_BANK_MAX_ENTRIES) {
>>>> +		loop1_idx2 = brbe_attr->brbe_nr - 1;
>>>> +		loop2_idx1 = BRBE_BANK1_IDX_MIN;
>>>> +		loop2_idx2 = BRBE_BANK0_IDX_MAX;
>>>> +	} else {
>>>> +		loop1_idx2 = BRBE_BANK0_IDX_MAX;
>>>> +		loop2_idx1 = BRBE_BANK1_IDX_MIN;
>>>> +		loop2_idx2 = brbe_attr->brbe_nr - 1;
>>>> +	}
>>>> +
>>>> +	/* Loop through bank 0 */
>>>> +	select_brbe_bank(BRBE_BANK_IDX_0);
>>>> +	for (idx = 0, count = loop1_idx1; count <= loop1_idx2; idx++, count++) {
>>>> +		if (!capture_branch_entry(cpuc, event, idx))
>>>> +			goto skip_bank_1;
>>>> +	}
>>>> +
>>>> +	/* Loop through bank 1 */
>>>> +	select_brbe_bank(BRBE_BANK_IDX_1);
>>>> +	for (count = loop2_idx1; count <= loop2_idx2; idx++, count++) {
>>>> +		if (!capture_branch_entry(cpuc, event, idx))
>>>> +			break;
>>>> +	}
>>>> +
>>>> +skip_bank_1:
>>>> +	cpuc->branches->branch_stack.nr = idx;
>>>> +	cpuc->branches->branch_stack.hw_idx = -1ULL;
>>>> +	process_branch_aborts(cpuc);
>>>> +
>>>> +	/* Unpause the buffer */
>>>> +	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>>>> +	isb();
>>>> +	armv8pmu_branch_reset();
>>>> +}
>>> The loop indicies are rather difficult to follow, and I think those can be made
>>> quite a lot simpler if split out, e.g.
>>>
>>> | int __armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
>>> | {
>>> | 	struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;
>>> | 	int nr_hw_entries = brbe_attr->brbe_nr;
>>> | 	int idx;
>>
>> I guess idx needs an init to 0.
> 
> Yes, sorry, that should have been:
> 
> 	int idx = 0;
> 
>>> | 
>>> | 	select_brbe_bank(BRBE_BANK_IDX_0);
>>> | 	while (idx < nr_hw_entries && idx < BRBE_BANK0_IDX_MAX) {
>>> | 		if (!capture_branch_entry(cpuc, event, idx))
>>> | 			return idx;
>>> | 		idx++;
>>> | 	}
>>> | 
>>> | 	select_brbe_bank(BRBE_BANK_IDX_1);
>>> | 	while (idx < nr_hw_entries && idx < BRBE_BANK1_IDX_MAX) {
>>> | 		if (!capture_branch_entry(cpuc, event, idx))
>>> | 			return idx;
>>> | 		idx++;
>>> | 	}
>>> | 
>>> | 	return idx;
>>> | }
>>
>> These loops are better than the proposed one with indices, will update.
> 
> Great!
> 
>>> | 
>>> | void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
>>> | {
>>> | 	u64 brbfcr, brbcr;
>>> | 	int nr;
>>> | 
>>> | 	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>>> | 	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>>> | 
>>> | 	/* Ensure pause on PMU interrupt is enabled */
>>> | 	WARN_ON_ONCE(!(brbcr & BRBCR_EL1_FZP));
>>> | 
>>> | 	/* Pause the buffer */
>>> | 	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>>> | 	isb();
>>> | 
>>> | 	nr = __armv8pmu_branch_read(cpus, event);
>>> | 
>>> | 	cpuc->branches->branch_stack.nr = nr;
>>> | 	cpuc->branches->branch_stack.hw_idx = -1ULL;
>>> | 	process_branch_aborts(cpuc);
>>> | 
>>> | 	/* Unpause the buffer */
>>> | 	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>>> | 	isb();
>>> | 	armv8pmu_branch_reset();
>>> | }
>>>
>>> Looking at <linux/perf_event.h> I see:
>>>
>>> | /*
>>> |  * branch stack layout:
>>> |  *  nr: number of taken branches stored in entries[]
>>> |  *  hw_idx: The low level index of raw branch records
>>> |  *          for the most recent branch.
>>> |  *          -1ULL means invalid/unknown.
>>> |  *
>>> |  * Note that nr can vary from sample to sample
>>> |  * branches (to, from) are stored from most recent
>>> |  * to least recent, i.e., entries[0] contains the most
>>> |  * recent branch.
>>> |  * The entries[] is an abstraction of raw branch records,
>>> |  * which may not be stored in age order in HW, e.g. Intel LBR.
>>> |  * The hw_idx is to expose the low level index of raw
>>> |  * branch record for the most recent branch aka entries[0].
>>> |  * The hw_idx index is between -1 (unknown) and max depth,
>>> |  * which can be retrieved in /sys/devices/cpu/caps/branches.
>>> |  * For the architectures whose raw branch records are
>>> |  * already stored in age order, the hw_idx should be 0.
>>> |  */
>>> | struct perf_branch_stack {
>>> |         __u64                           nr;  
>>> |         __u64                           hw_idx;
>>> |         struct perf_branch_entry        entries[];
>>> | };
>>>
>>> ... which seems to indicate we should be setting hw_idx to 0, since IIUC our
>>> records are in age order.
>> Branch records are indeed in age order, sure will change hw_idx as 0. Earlier
>> figured that there was no need for hw_idx and hence marked it as -1UL similar
>> to other platforms like powerpc.
> 
> That's fair enough; looking at power_pmu_bhrb_read() in
> arch/powerpc/perf/core-book3s.c, I see a comment:
> 
> 	Branches are read most recent first (ie. mfbhrb 0 is
> 	the most recent branch).
> 
> ... which suggests that should be 0 also, or that the documentation is wrong.
> 
> Do you know how the perf tool consumes this?
> 
> Thanks,
> Mark.

It looks like it's a unique ID/last position updated in the LBR FIFO and
it's used to stitch callchains together when the stack depth exceeds the
buffer size. Perf takes the previous one that got filled to the limit
and and the new one and stitches them together if the hw_idx matches.

There are some options in perf you need to provide to make it happen, so
I think for BRBE it doesn't matter what value is assigned to it. -1
seems to be a 'not used' value which we should probably set in case the
event is opened with PERF_SAMPLE_BRANCH_HW_INDEX

You could also fail to open the event if PERF_SAMPLE_BRANCH_HW_INDEX is
set, and that would save writing out -1 every time for every branch
stack. Although it's not enabled by default, so maybe that's not necessary.

James
