Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2336A63A2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiK1IZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiK1IY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:24:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4F102DCF;
        Mon, 28 Nov 2022 00:24:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 245DFD6E;
        Mon, 28 Nov 2022 00:25:00 -0800 (PST)
Received: from [10.162.40.16] (unknown [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CF773F73B;
        Mon, 28 Nov 2022 00:24:48 -0800 (PST)
Message-ID: <90f4abd0-2314-19e4-176c-00f15100ada0@arm.com>
Date:   Mon, 28 Nov 2022 13:54:46 +0530
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
 <fa55fccc-455c-828a-b5fb-de5cb269e35b@arm.com>
 <Y3tjfg/aPIixPTbs@FVFF77S0Q05N.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y3tjfg/aPIixPTbs@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/22 17:09, Mark Rutland wrote:
> On Mon, Nov 21, 2022 at 12:06:31PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 11/18/22 23:31, Mark Rutland wrote:
>>> On Mon, Nov 07, 2022 at 11:55:11AM +0530, Anshuman Khandual wrote:
>>>> This adds arm pmu infrastrure to probe BRBE implementation's attributes via
>>>> driver exported callbacks later. The actual BRBE feature detection will be
>>>> added by the driver itself.
>>>>
>>>> CPU specific BRBE entries, cycle count, format support gets detected during
>>>> PMU init. This information gets saved in per-cpu struct pmu_hw_events which
>>>> later helps in operating BRBE during a perf event context.
>>>
>>> Do we expect this to vary between CPUs handled by the same struct arm_pmu ?
>>
>> BRBE registers are per CPU, and the spec does not assert about BRBE properties
>> being the same across the system, served via same the struct arm_pmu.
> 
> The same is true of the PMU, and struct arm_pmu does not cover the whole
> system, it covers each *micro-architecture* within the system.
> 
> I think BRBE should be treated the same, i.e. uniform *within* a struct
> arm_pmu.

Understood, detected on one and verified on all ?

> 
>> Hence it would be inaccurate to make that assumption, which might have just
>> avoided all these IPI based probes during boot.
> 
> FWIW, I would be happy to IPI all CPUs during boot to verify uniformity of CPUs
> within an arm_pmu; I just don't think that BRBE should be treated differently
> from the rest of the PMU features.

Hence BRBE probing should be done inside an updated __armv8pmu_probe_pmu().

static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
{
        struct armv8pmu_probe_info probe = {
                .pmu = cpu_pmu,
                .present = false,
        };
        int ret;

        ret = smp_call_function_any(&cpu_pmu->supported_cpus,
                                    __armv8pmu_probe_pmu,
                                    &probe, 1);
        if (ret)
                return ret;

        return probe.present ? 0 : -ENODEV;
}

But if BRBE is assumed (and verified) to be same across the micro-architecture,
then following BRBE attributes when captured should be part of 'struct arm_pmu'
instead of 'struct pmu_hw_events' as is the case currently.

        /* Detected BRBE attributes */
        bool                            brbe_v1p1;
        int                             brbe_cc;
        int                             brbe_nr;
        int                             brbe_format;

> 
> [...]
> 
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
>>>
>>> Why does this need to be called on each CPU in the supported_cpus mask?
>>
>> Is not supported_cpus derived after partitioning the IRQ in pmu_parse_percpu_irq().
>> The idea is to fill up BRBE buffer attributes, on all such supported cpus which could
>> trigger PMU interrupt. Is the concern, that not all cpus in supported_cpus mask might
>> not be online during boot, hence IPIs could not be served, hence BRBE attributed for
>> them could not be fetched ?
> 
> As above, I think this is solvable if we mandate that BRBE must be uniform
> *within* an arm_pmu's supported CPUs; then we only need one CPU in the
> supported_cpus mask to be present at boot time, as with the rest of the PMU
> code.
> 
> We could *verify* that when onlining a CPU.

Understood.

> 
>>> I don't see anything here to handle late hotplug, so this looks suspicious.
>>
>> Right, I should add cpu hotplug handling, otherwise risk loosing BRBE support on cpus
>> which might have been offline during boot i.e when above IPI based probe happened ?
>>
>>> Either we're missing something, or it's redundant at boot time.
>>
>> Should we add cpu hotplug online-offline handlers like some other PMU drivers ? Let
>> me know if there are some other concerns.
>>
>> cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRVNAME,
>> 			arm_brbe_cpu_startup,
>> 		        arm_brbe_cpu_teardown)
> 
> We *could* add that, but that's going to require ordering against the existing
> hooks for probing arm_pmu.

Right.

> 
> Why can't this hang off the exising hooks for arm_pmu? We're treating this as
> part of the PMU anyway, so I don't understand why we should probe it
> separately.
Okay, will try and see what all changes are required to move the probing into generic
arm_pmu probe, and capture the BRBE attributes inside struct arm_pmu.
