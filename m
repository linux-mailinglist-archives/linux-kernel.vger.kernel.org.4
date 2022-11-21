Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E593B6319C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKUGgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKUGgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:36:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC07931233;
        Sun, 20 Nov 2022 22:36:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 908231FB;
        Sun, 20 Nov 2022 22:36:45 -0800 (PST)
Received: from [10.162.41.8] (unknown [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9653B3F73D;
        Sun, 20 Nov 2022 22:36:34 -0800 (PST)
Message-ID: <fa55fccc-455c-828a-b5fb-de5cb269e35b@arm.com>
Date:   Mon, 21 Nov 2022 12:06:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 4/7] driver/perf/arm_pmu_platform: Add support for BRBE
 attributes detection
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20221107062514.2851047-1-anshuman.khandual@arm.com>
 <20221107062514.2851047-5-anshuman.khandual@arm.com>
 <Y3fIYjGtoXPSX9JQ@FVFF77S0Q05N.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y3fIYjGtoXPSX9JQ@FVFF77S0Q05N.cambridge.arm.com>
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



On 11/18/22 23:31, Mark Rutland wrote:
> On Mon, Nov 07, 2022 at 11:55:11AM +0530, Anshuman Khandual wrote:
>> This adds arm pmu infrastrure to probe BRBE implementation's attributes via
>> driver exported callbacks later. The actual BRBE feature detection will be
>> added by the driver itself.
>>
>> CPU specific BRBE entries, cycle count, format support gets detected during
>> PMU init. This information gets saved in per-cpu struct pmu_hw_events which
>> later helps in operating BRBE during a perf event context.
> 
> Do we expect this to vary between CPUs handled by the same struct arm_pmu ?

BRBE registers are per CPU, and the spec does not assert about BRBE properties
being the same across the system, served via same the struct arm_pmu. Hence it
would be inaccurate to make that assumption, which might have just avoided all
these IPI based probes during boot.

> 
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/perf/arm_pmu_platform.c | 34 +++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
>> index 933b96e243b8..acdc445081aa 100644
>> --- a/drivers/perf/arm_pmu_platform.c
>> +++ b/drivers/perf/arm_pmu_platform.c
>> @@ -172,6 +172,36 @@ static int armpmu_request_irqs(struct arm_pmu *armpmu)
>>  	return err;
>>  }
>>  
>> +static void arm_brbe_probe_cpu(void *info)
>> +{
>> +	struct pmu_hw_events *hw_events;
>> +	struct arm_pmu *armpmu = info;
>> +
>> +	/*
>> +	 * Return from here, if BRBE driver has not been
>> +	 * implemented for this PMU. This helps prevent
>> +	 * kernel crash later when brbe_probe() will be
>> +	 * called on the PMU.
>> +	 */
>> +	if (!armpmu->brbe_probe)
>> +		return;
> 
> Since this is a field on struct arm_pmu, why doesn't armpmu_request_brbe()
> check this before calling smp_call_function_single(), to avoid the redundant
> IPI?

Makes sense, I will move the check inside armpmu_request_brbe() with return
code -ENODEV when not available.

> 
>> +
>> +	hw_events = per_cpu_ptr(armpmu->hw_events, smp_processor_id());
>> +	armpmu->brbe_probe(hw_events);
>> +}
>> +
>> +static int armpmu_request_brbe(struct arm_pmu *armpmu)
>> +{
>> +	int cpu, err = 0;
>> +
>> +	for_each_cpu(cpu, &armpmu->supported_cpus) {
>> +		err = smp_call_function_single(cpu, arm_brbe_probe_cpu, armpmu, 1);
> 
> Why does this need to be called on each CPU in the supported_cpus mask?

Is not supported_cpus derived after partitioning the IRQ in pmu_parse_percpu_irq().
The idea is to fill up BRBE buffer attributes, on all such supported cpus which could
trigger PMU interrupt. Is the concern, that not all cpus in supported_cpus mask might
not be online during boot, hence IPIs could not be served, hence BRBE attributed for
them could not be fetched ?

> 
> I don't see anything here to handle late hotplug, so this looks suspicious.

Right, I should add cpu hotplug handling, otherwise risk loosing BRBE support on cpus
which might have been offline during boot i.e when above IPI based probe happened ?

> Either we're missing something, or it's redundant at boot time.

Should we add cpu hotplug online-offline handlers like some other PMU drivers ? Let
me know if there are some other concerns.

cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRVNAME,
			arm_brbe_cpu_startup,
		        arm_brbe_cpu_teardown)
