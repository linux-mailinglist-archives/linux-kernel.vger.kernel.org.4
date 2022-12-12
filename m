Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59E6498DA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 07:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiLLGIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 01:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiLLGI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:08:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 205A1DECE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:08:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C6031FB;
        Sun, 11 Dec 2022 22:09:04 -0800 (PST)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A4A3F71E;
        Sun, 11 Dec 2022 22:08:19 -0800 (PST)
Message-ID: <b6737780-1fec-4419-05e0-2f74d859b147@arm.com>
Date:   Mon, 12 Dec 2022 11:38:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/1] KVM: arm64: PMU: Fix PMCR_EL0 reset value
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>,
        James Clark <james.clark@arm.com>
Cc:     kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <20221209164446.1972014-1-james.clark@arm.com>
 <20221209164446.1972014-2-james.clark@arm.com> <Y5N3R+w3GF94hxHa@google.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y5N3R+w3GF94hxHa@google.com>
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



On 12/9/22 23:28, Oliver Upton wrote:
> On Fri, Dec 09, 2022 at 04:44:46PM +0000, James Clark wrote:
>> ARMV8_PMU_PMCR_N_MASK is an unshifted value which results in the wrong
>> reset value for PMCR_EL0, so shift it to fix it.
> 
> That's just mean. *_MASK tends to be a shifted mask, although it would
> appear that asm/perf_event.h does not follow this convention. Fixing
> that would be nice (as I'm sure somebody else will get burned by this),
> but for the sake of an immediate fix:

New arch/arm64/tools/sysreg generates shifted i.e in place masks for register
fields. Once all these PMU registers move into arch/arm64/tools/sysreg, this
problem will be solved.

> 
>> This fixes the following error when running qemu:
>>
>>   $ qemu-system-aarch64 -cpu host -machine type=virt,accel=kvm -kernel ...
>>
>>   target/arm/helper.c:1813: pmevcntr_rawwrite: Assertion `counter < pmu_num_counters(env)' failed.
>>
>> Fixes: 292e8f149476 ("KVM: arm64: PMU: Simplify PMCR_EL0 reset handling")
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
> 
> --
> Thanks,
> Oliver
> 
>> ---
>>  arch/arm64/kvm/sys_regs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index d5ee52d6bf73..c6cbfe6b854b 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -646,7 +646,7 @@ static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>>  		return;
>>  
>>  	/* Only preserve PMCR_EL0.N, and reset the rest to 0 */
>> -	pmcr = read_sysreg(pmcr_el0) & ARMV8_PMU_PMCR_N_MASK;
>> +	pmcr = read_sysreg(pmcr_el0) & (ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
>>  	if (!kvm_supports_32bit_el0())
>>  		pmcr |= ARMV8_PMU_PMCR_LC;
>>  
>> -- 
>> 2.25.1
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
