Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AA95FA160
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJJPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJJPsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:48:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D6B11A81B;
        Mon, 10 Oct 2022 08:48:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E2BE12FC;
        Mon, 10 Oct 2022 08:48:42 -0700 (PDT)
Received: from [10.57.66.71] (unknown [10.57.66.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F0E53F67D;
        Mon, 10 Oct 2022 08:48:34 -0700 (PDT)
Message-ID: <6805165c-8aaf-086f-f5a6-181876cd7975@arm.com>
Date:   Mon, 10 Oct 2022 16:48:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH V3 7/7] arm64/perf: Enable branch stack sampling
To:     James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
References: <20220929075857.158358-1-anshuman.khandual@arm.com>
 <20220929075857.158358-8-anshuman.khandual@arm.com>
 <0adcc3f7-bf60-516f-c8d7-4250d1f901cb@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <0adcc3f7-bf60-516f-c8d7-4250d1f901cb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 14:55, James Clark wrote:
> 
> 
> On 29/09/2022 08:58, Anshuman Khandual wrote:
>> Now that all the required pieces are already in place, just enable the perf
>> branch stack sampling support on arm64 platform, by removing the gate which
>> blocks it in armpmu_event_init().
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/perf/arm_pmu.c | 32 +++++++++++++++++++++++++++++---
>>   1 file changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index 93b36933124f..2a9b988b53c2 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -537,9 +537,35 @@ static int armpmu_event_init(struct perf_event *event)
>>   		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
>>   		return -ENOENT;
>>   
>> -	/* does not support taken branch sampling */
>> -	if (has_branch_stack(event))
>> -		return -EOPNOTSUPP;
>> +	if (has_branch_stack(event)) {
>> +		/*
>> +		 * BRBE support is absent. Select CONFIG_ARM_BRBE_PMU
>> +		 * in the config, before branch stack sampling events
>> +		 * can be requested.
>> +		 */
>> +		if (!IS_ENABLED(CONFIG_ARM_BRBE_PMU)) {
>> +			pr_warn_once("BRBE is disabled, select CONFIG_ARM_BRBE_PMU\n");
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>> +		if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_KERNEL) {
>> +			if (!perfmon_capable()) {
> 
> I'm still getting different behaviour compared to x86 when using
> perf_event_paranoid because of this perfmon_capable() call here.

Given the generic events framework already checks this for any
privileged branch samples (i.e., for both KERNEL and HV), the
individual drivers must not add additional restrictions.

> 
>> +				pr_warn_once("does not have permission for kernel branch filter\n");
> 
> Also I was under the impression that this should be more like a
> KERN_INFO loglevel rather than a KERN_WARNING. It's more like expected
> behavior rather than unexpected behavior and as far as I know anyone who
> sees something in dmesg might think something has gone wrong and try to
> follow it up. It is quite a useful message but I remember getting a
> review like this before and it made sense to me.

+1

Suzuki

