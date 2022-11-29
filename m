Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55463B9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiK2GGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiK2GGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:06:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64FAD4FF89;
        Mon, 28 Nov 2022 22:06:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F6D6D6E;
        Mon, 28 Nov 2022 22:06:21 -0800 (PST)
Received: from [10.162.41.67] (unknown [10.162.41.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82F323F67D;
        Mon, 28 Nov 2022 22:06:10 -0800 (PST)
Message-ID: <06666fe7-d17c-24c9-98b7-65f5642dfb2b@arm.com>
Date:   Tue, 29 Nov 2022 11:36:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 2/7] arm64/perf: Update struct arm_pmu for BRBE
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20221107062514.2851047-1-anshuman.khandual@arm.com>
 <20221107062514.2851047-3-anshuman.khandual@arm.com>
 <8f6d3424-2650-8e8b-61f7-1431aec4633b@arm.com>
 <4efc0ae1-564e-dd05-842a-46fb1aeb4ad8@arm.com>
 <Y3fFGQN55+LM5s5u@FVFF77S0Q05N.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y3fFGQN55+LM5s5u@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/22 23:17, Mark Rutland wrote:
> 
> Hi Anshuman,
> 
> Apologies for the delayi n reviewing this.
> 
> On Fri, Nov 18, 2022 at 12:09:07PM +0530, Anshuman Khandual wrote:
>> On 11/9/22 17:00, Suzuki K Poulose wrote:
>>> On 07/11/2022 06:25, Anshuman Khandual wrote:
>>>> Although BRBE is an armv8 speciifc HW feature, abstracting out its various
>>>> function callbacks at the struct arm_pmu level is preferred, as it cleaner
>>>> , easier to follow and maintain.
>>>>
>>>> Besides some helpers i.e brbe_supported(), brbe_probe() and brbe_reset()
>>>> might not fit seamlessly, when tried to be embedded via existing arm_pmu
>>>> helpers in the armv8 implementation.
>>>>
>>>> Updates the struct arm_pmu to include all required helpers that will drive
>>>> BRBE functionality for a given PMU implementation. These are the following.
>>>>
>>>> - brbe_filter    : Convert perf event filters into BRBE HW filters
>>>> - brbe_probe    : Probe BRBE HW and capture its attributes
>>>> - brbe_enable    : Enable BRBE HW with a given config
>>>> - brbe_disable    : Disable BRBE HW
>>>> - brbe_read    : Read BRBE buffer for captured branch records
>>>> - brbe_reset    : Reset BRBE buffer
>>>> - brbe_supported: Whether BRBE is supported or not
>>>>
>>>> A BRBE driver implementation needs to provide these functionalities.
>>>
>>> Could these not be hidden from the generic arm_pmu and kept in the
>>> arm64 pmu backend  ? It looks like they are quite easy to simply
>>> move these to the corresponding hooks in arm64 pmu.
>>
>> We have had this discussion multiple times in the past [1], but I still
>> believe, keeping BRBE implementation hooks at the PMU level rather than
>> embedding them with other PMU events handling, is a much better logical
>> abstraction.
>>
>> [1] https://lore.kernel.org/all/c3804290-bdb1-d1eb-3526-9b0ce4c8e8b1@arm.com/
>>
>> --------------------------------------------------------------------------
>>>
>>> One thing to answer in the commit msg is why we need the hooks here.  
>>> Have we concluded that adding BRBE hooks to struct arm_pmu for what is 
>>> an armv8 specific feature is the right approach? I don't recall 
>>> reaching that conclusion.
>>
>> Although it might be possible to have this implementation embedded in
>> the existing armv8 PMU implementation, I still believe that the BRBE
>> functionalities abstracted out at the arm_pmu level with a separate
>> config option is cleaner, easier to follow and to maintain as well.
>>
>> Besides some helpers i.e brbe_supported(), brbe_probe() and brbe_reset()
>> might not fit seamlessly, when tried to be embedded via existing arm_pmu
>> helpers in the armv8 implementation.
>>
>> Nonetheless if arm_pmu based additional BRBE helpers is absolutely a no
>> go for folks here in general, will explore arm64 based implementation.
>> ----------------------------------------------------------------------------
>>
>> I am still waiting for maintainer's take on this issue. I will be happy to
>> rework this series to move all these implementation inside arm64 callbacks
>> instead, if that is required or preferred by the maintainers. But according
>> to me, this current abstraction layout is much better.
> 
> To be honest, I'm not sure what's best right now; but at the moment it's not
> clear to me why this couldn't fit within the existing hooks.
> 
> Above you say brbe_supported() / brbe_probe() / brbe_reset() didn't fit
> seamlessly; can you give an example of problem? I think I'm missing something
> obvious.

I tried to move them inside armv8 implementation callbacks.

arm64_pmu_brbe_supported() can be moved inside __armv8_pmuv3_map_event(), so that
event viability can be validated during armpmu_event_init(). arm64_pmu_brbe_probe()
can be moved inside __armv8pmu_probe_pmu() as you have suggested earlier on another
thread. arm64_pmu_brbe_reset() can also be moved inside armv8pmu_enable_event(),
and also armv8pmu_reset().

The only problem being armpmu_sched_task() where earlier we had BRBE reset, but I
guess it can be replaced with entire PMU reset which does the BRBE reset as well ?

static void armpmu_sched_task(struct perf_event_context *ctx, bool sched_in)
{
        struct arm_pmu *armpmu = to_arm_pmu(ctx->pmu);

        if (sched_in)
                armpmu->reset(armpmu);
}
