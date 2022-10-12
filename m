Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD65FC16D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJLHu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJLHuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:50:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC3924C037;
        Wed, 12 Oct 2022 00:50:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7FBE15A1;
        Wed, 12 Oct 2022 00:50:28 -0700 (PDT)
Received: from [10.162.41.10] (unknown [10.162.41.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E86C3F67D;
        Wed, 12 Oct 2022 00:50:19 -0700 (PDT)
Message-ID: <31b72985-5c12-b421-0cec-3c6b027a7070@arm.com>
Date:   Wed, 12 Oct 2022 13:20:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/7] driver/perf/arm_pmu_platform: Add support for BRBE
 attributes detection
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
References: <20220929075857.158358-1-anshuman.khandual@arm.com>
 <20220929075857.158358-5-anshuman.khandual@arm.com>
 <02ce379c-c718-b72d-fc74-cd8c904265fb@arm.com>
 <bf70b7d6-0564-7ae3-6fe6-24483461839b@arm.com>
 <d82de618-9e97-3d5d-f4eb-7710e9094001@arm.com>
In-Reply-To: <d82de618-9e97-3d5d-f4eb-7710e9094001@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/22 14:51, Anshuman Khandual wrote:
> 
> On 10/10/22 19:47, James Clark wrote:
>>
>> On 06/10/2022 14:37, James Clark wrote:
>>>
>>> On 29/09/2022 08:58, Anshuman Khandual wrote:
>>>> This adds arm pmu infrastrure to probe BRBE implementation's attributes via
>>>> driver exported callbacks later. The actual BRBE feature detection will be
>>>> added by the driver itself.
>>>>
>>>> CPU specific BRBE entries, cycle count, format support gets detected during
>>>> PMU init. This information gets saved in per-cpu struct pmu_hw_events which
>>>> later helps in operating BRBE during a perf event context.
>>>>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>  drivers/perf/arm_pmu_platform.c | 34 +++++++++++++++++++++++++++++++++
>>>>  1 file changed, 34 insertions(+)
>>>>
>>>> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
>>>> index 933b96e243b8..acdc445081aa 100644
>>>> --- a/drivers/perf/arm_pmu_platform.c
>>>> +++ b/drivers/perf/arm_pmu_platform.c
>>>> @@ -172,6 +172,36 @@ static int armpmu_request_irqs(struct arm_pmu *armpmu)
>>>>  	return err;
>>>>  }
>>>>  
>>>> +static void arm_brbe_probe_cpu(void *info)
>>>> +{
>>>> +	struct pmu_hw_events *hw_events;
>>>> +	struct arm_pmu *armpmu = info;
>>>> +
>>>> +	/*
>>>> +	 * Return from here, if BRBE driver has not been
>>>> +	 * implemented for this PMU. This helps prevent
>>>> +	 * kernel crash later when brbe_probe() will be
>>>> +	 * called on the PMU.
>>>> +	 */
>>>> +	if (!armpmu->brbe_probe)
>>>> +		return;
>>>> +
>>>> +	hw_events = per_cpu_ptr(armpmu->hw_events, smp_processor_id());
>>>> +	armpmu->brbe_probe(hw_events);
>>>> +}
>>>> +
>>>> +static int armpmu_request_brbe(struct arm_pmu *armpmu)
>>>> +{
>>>> +	int cpu, err = 0;
>>>> +
>>>> +	for_each_cpu(cpu, &armpmu->supported_cpus) {
>>>> +		err = smp_call_function_single(cpu, arm_brbe_probe_cpu, armpmu, 1);
>>> Hi Anshuman,
>>>
>>> I have LOCKDEP on and the patchset applied to perf/core (82aad7ff7) on
>>> git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git and I get
>> Can you confirm if this is currently the correct place to apply this to?
> This series applied on v6.0-rc5 after the perf ABI changes, both in kernel
> and in user space tools.
> 
>> I'm only getting 0 length branch stacks now. Seems like it could be
>> something to do with the layout of perf samples because I know that was
>> done in separate commits:
> Right, might be.
> 
>>   sudo ./perf record -j any_call -- ls
>>   ./perf report -D | grep "branch stack"
>>   ... branch stack: nr:0
>>   ... branch stack: nr:0
>>   ... branch stack: nr:0
>>   ... branch stack: nr:0
> I am planning to respin the series on 6.1-rc1 next week which should solve
> these multiple moving parts problem

There are some recent changes which require PMU driver to set data.sample_flags
indicating what kind of records are being filled in there. Here are the commits

a9a931e2666878343 ("perf: Use sample_flags for branch stack")
3aac580d5cc3001ca ("perf: Add sample_flags to indicate the PMU-filled sample data")

Following fix solves the problem for BRBE driver.

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 98e9a615d3cb..85a3aaefc0fb 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -877,6 +877,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
                if (has_branch_stack(event)) {
                        cpu_pmu->brbe_read(cpuc, event);
                        data.br_stack = &cpuc->branches->brbe_stack;
+                       data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
                        cpu_pmu->brbe_reset(cpuc);
                }
 
