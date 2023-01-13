Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7610B668ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjAMEVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjAMEUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:20:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3686B66986
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:15:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD6B2FEC;
        Thu, 12 Jan 2023 20:16:10 -0800 (PST)
Received: from [10.162.41.9] (unknown [10.162.41.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C6133F587;
        Thu, 12 Jan 2023 20:15:26 -0800 (PST)
Message-ID: <0351f0bc-d94b-957f-8e03-6525e47d63a4@arm.com>
Date:   Fri, 13 Jan 2023 09:45:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V7 3/6] arm64/perf: Add branch stack support in struct
 arm_pmu
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-4-anshuman.khandual@arm.com>
 <Y8ARAjUaE44y+Cw3@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y8ARAjUaE44y+Cw3@FVFF77S0Q05N>
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


On 1/12/23 19:24, Mark Rutland wrote:
> On Thu, Jan 05, 2023 at 08:40:36AM +0530, Anshuman Khandual wrote:
>> This updates 'struct arm_pmu' for branch stack sampling support later. This
>> adds a new 'features' element in the structure to track supported features,
>> and another 'private' element to encapsulate implementation attributes on a
>> given 'struct arm_pmu'. These updates here will help in tracking any branch
>> stack sampling support, which is being added later. This also adds a helper
>> arm_pmu_branch_stack_supported().
>>
>> This also enables perf branch stack sampling event on all 'struct arm pmu',
>> supporting the feature but after removing the current gate that blocks such
>> events unconditionally in armpmu_event_init(). Instead a quick probe can be
>> initiated via arm_pmu_branch_stack_supported() to ascertain the support.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/perf/arm_pmu.c       | 3 +--
>>  include/linux/perf/arm_pmu.h | 9 +++++++++
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index 14a3ed3bdb0b..a85b2d67022e 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -510,8 +510,7 @@ static int armpmu_event_init(struct perf_event *event)
>>  		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
>>  		return -ENOENT;
>>  
>> -	/* does not support taken branch sampling */
>> -	if (has_branch_stack(event))
>> +	if (has_branch_stack(event) && !arm_pmu_branch_stack_supported(armpmu))
>>  		return -EOPNOTSUPP;
>>  
>>  	return __hw_perf_event_init(event);
>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
>> index 2a9d07cee927..64e1b2594025 100644
>> --- a/include/linux/perf/arm_pmu.h
>> +++ b/include/linux/perf/arm_pmu.h
>> @@ -80,11 +80,14 @@ enum armpmu_attr_groups {
>>  	ARMPMU_NR_ATTR_GROUPS
>>  };
>>  
>> +#define ARM_PMU_BRANCH_STACK	BIT(0)
>> +
>>  struct arm_pmu {
>>  	struct pmu	pmu;
>>  	cpumask_t	supported_cpus;
>>  	char		*name;
>>  	int		pmuver;
>> +	int		features;
>>  	irqreturn_t	(*handle_irq)(struct arm_pmu *pmu);
>>  	void		(*enable)(struct perf_event *event);
>>  	void		(*disable)(struct perf_event *event);
> 
> Hmm, we already have the secure_access field separately. How about we fold that
> in and go with:
> 
> 	unsigned int	secure_access    : 1,
> 			has_branch_stack : 1;

Something like this would work, but should we use __u32 instead of unsigned int
to ensure 32 bit width ?

-       bool            secure_access; /* 32-bit ARM only */
+       unsigned int    secure_access   : 1, /* 32-bit ARM only */
+                       has_branch_stack: 1,
+                       reserved        : 31;

> 
> ... that way we have one way to manage flags, we don't need to allocate the
> bits, and the bulk of the existing code for secure_access can stay as-is.

Right, the changed code also builds on arm32 without any code change.

> 
>> @@ -119,8 +122,14 @@ struct arm_pmu {
>>  
>>  	/* Only to be used by ACPI probing code */
>>  	unsigned long acpi_cpuid;
>> +	void		*private;
> 
> Does this need to be on the end of struct arm_pmu, or can it be placed earlier?

This additional 'private' attribute structure sticking out from struct arm_pmu
should be at the end. But is there any benefit moving this earlier ?

> 
> The line spacing makes it look like the ACPI comment applies to 'private',
> which isn't the case.

Sure, will add the following comment, and a space in between.

diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index f60f7e01acae..c0a090ff7991 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -130,6 +130,8 @@ struct arm_pmu {
 
        /* Only to be used by ACPI probing code */
        unsigned long acpi_cpuid;
+
+       /* Implementation specific attributes */
        void            *private;
 };

> 
>>  };
>>  
>> +static inline bool arm_pmu_branch_stack_supported(struct arm_pmu *armpmu)
>> +{
>> +	return armpmu->features & ARM_PMU_BRANCH_STACK;
>> +}
> 
> With the above, this would become:
> 
> static inline bool arm_pmu_branch_stack_supported(struct arm_pmu *armpmu)
> {
> 	return armpmu->has_branch_stack;
> }

Right, will change this helper as required.
