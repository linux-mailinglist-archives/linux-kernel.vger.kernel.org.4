Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0329A6449EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiLFRGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiLFRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:06:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90D701134;
        Tue,  6 Dec 2022 09:05:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BD0223A;
        Tue,  6 Dec 2022 09:06:06 -0800 (PST)
Received: from [10.32.36.24] (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D45D63F73B;
        Tue,  6 Dec 2022 09:05:56 -0800 (PST)
Message-ID: <c3ca3fb5-d68f-a813-daac-a84b3cce2f6f@arm.com>
Date:   Tue, 6 Dec 2022 17:05:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 6/7] arm64/perf: Add BRBE driver
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
 <25658a70-0b37-966d-e46c-f86be2a76a8e@arm.com>
 <54d532cc-089c-0c6c-6bf4-be840bc27826@arm.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <54d532cc-089c-0c6c-6bf4-be840bc27826@arm.com>
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



On 30/11/2022 04:49, Anshuman Khandual wrote:
> 
> 
> On 11/29/22 21:23, James Clark wrote:
[...]
> 
> The latest code (not posted), disables TRBE completely while reading the
> branch records during PMU interrupt. Could you please apply those changes
> as well, or rather just use the branch instead.
> 
> https://gitlab.arm.com/linux-arm/linux-anshuman/-/commit/ab17879711f0e61c280ed52400ccde172b67e04a
> 
>>
>> armv8pmu_brbe_enable+0xc/arm64_pmu_brbe_enable+0x0/P/-/-/0/CALL
>> armpmu_start+0xe0/armv8pmu_brbe_enable+0x0/P/-/-/0/IND_CALL
>> armv8pmu_brbe_reset+0x18/armpmu_start+0xd0/P/-/-/0/RET
>> arm64_pmu_brbe_reset+0x18/armv8pmu_brbe_reset+0x10/P/-/-/0/RET
> 
> I am wondering how the different privilege branch record leak is possible.
> Because arm64_pmu_brbe_enable() should start BRBE from a clean state with
> respect to privilege level filters.
> 
> void arm64_pmu_brbe_enable(struct pmu_hw_events *cpuc)
> {
>         u64 brbfcr, brbcr;
> 
>         if (brbe_disabled(cpuc))
>                 return;
> 
>         brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>         brbfcr &= ~BRBFCR_EL1_BANK_MASK;
>         brbfcr &= ~(BRBFCR_EL1_EnI | BRBFCR_EL1_PAUSED | BRBE_FCR_MASK);
>         brbfcr |= (cpuc->brbfcr & BRBE_FCR_MASK);
>         write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
>         isb();
> 
>         brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>         brbcr &= ~BRBE_CR_MASK;			--> Contains BRBCR_EL1_E1BRE and BRBCR_EL1_E0BRE
>         brbcr |= BRBCR_EL1_FZP;
>         brbcr |= (BRBCR_EL1_TS_PHYSICAL << BRBCR_EL1_TS_SHIFT);
>         brbcr |= (cpuc->brbcr & BRBE_CR_MASK);
>         write_sysreg_s(brbcr, SYS_BRBCR_EL1);
>         isb();

Yes I tracked down the problem to here as well. I added a
arm64_pmu_brbe_reset(cpuc) to the end of arm64_pmu_brbe_enable() and it
fixes the issue.

The problem is, without ensuring that BRBFCR_EL1_PAUSED is set, there is
no way to write to both BRBFCR and BRBCR in either order without new
records being produced based on a partial configuration.

BRBFCR_EL1_PAUSED isn't set from the previous session, and there is no
obvious place to add a paused at the end of the session with the current
callbacks. So the easiest fix is to flush the old kernel samples after
configuring both registers.

I'm not sure what the BRBFCR_EL1_PAUSED value is at power on either, so
the issue might also be present with the very first brbe session, but
less obvious than a userspace one following a kernel one. But the flush
solves that problem too.

> }
> 
> Could these samples are from a previous session ? But they should have been
> flushed in armpmu_start().
> 
> static void armpmu_start(struct perf_event *event, int flags)
> {
> 	.........
>         if (has_branch_stack(event)) {
>                 if (event->ctx->task && hw_events->brbe_context != event->ctx) {
>                         armpmu->brbe_reset(hw_events);
>                         hw_events->brbe_context = event->ctx;
>                 }
>                 armpmu->brbe_enable(hw_events);
>                 hw_events->brbe_users++;
>         }
> 	.........
> }
> 
>>
>>
>> [1]:
>> https://gitlab.arm.com/linux-arm/linux-jc/-/commit/7260b7bef06ac161eac88d05266e8c5c303d9881
