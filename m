Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26030723676
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjFFErf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFFErd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:47:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43F10109;
        Mon,  5 Jun 2023 21:47:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 899ABAB6;
        Mon,  5 Jun 2023 21:48:17 -0700 (PDT)
Received: from [10.163.44.58] (unknown [10.163.44.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD7093F587;
        Mon,  5 Jun 2023 21:47:24 -0700 (PDT)
Message-ID: <1a8965ed-1210-2350-1c97-aebc27d005b7@arm.com>
Date:   Tue, 6 Jun 2023 10:17:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V11 03/10] arm64/perf: Add branch stack support in struct
 arm_pmu
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-4-anshuman.khandual@arm.com>
 <ZH2VmOUuZobZMcc/@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZH2VmOUuZobZMcc/@FVFF77S0Q05N>
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



On 6/5/23 13:28, Mark Rutland wrote:
> On Wed, May 31, 2023 at 09:34:21AM +0530, Anshuman Khandual wrote:
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
>> Tested-by: James Clark <james.clark@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/perf/arm_pmu.c       |  3 +--
>>  include/linux/perf/arm_pmu.h | 12 +++++++++++-
>>  2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index aada47e3b126..d4a4f2bd89a5 100644
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
>> index f7fbd162ca4c..0da745eaf426 100644
>> --- a/include/linux/perf/arm_pmu.h
>> +++ b/include/linux/perf/arm_pmu.h
>> @@ -102,7 +102,9 @@ struct arm_pmu {
>>  	int		(*map_event)(struct perf_event *event);
>>  	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
>>  	int		num_events;
>> -	bool		secure_access; /* 32-bit ARM only */
>> +	unsigned int	secure_access	: 1, /* 32-bit ARM only */
>> +			has_branch_stack: 1, /* 64-bit ARM only */
>> +			reserved	: 30;
>>  #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
>>  	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
>>  #define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
>> @@ -118,8 +120,16 @@ struct arm_pmu {
>>  
>>  	/* Only to be used by ACPI probing code */
>>  	unsigned long acpi_cpuid;
>> +
>> +	/* Implementation specific attributes */
>> +	void		*private;
>>  };
>>  
>> +static inline bool arm_pmu_branch_stack_supported(struct arm_pmu *armpmu)
>> +{
>> +	return armpmu->has_branch_stack;
>> +}
> 
> Since this is a trivial test, and we already access the 'secure_access' field
> directly, I'd prefer we removed this helper and directly accessesed
> arm_pmu::has_branch_stack, e.g. with the logic in armpmu_event_init() being:
> 
> 	if (has_branch_stack(event) && !armpmu->has_branch_stack)
> 		return -EOPNOTSUPP;

Sure, will drop the helper and change as suggested in all the call sites.

> 
> With that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
