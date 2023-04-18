Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE556E665D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjDRNu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjDRNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:50:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B09A710DE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:50:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1EB31063;
        Tue, 18 Apr 2023 06:51:05 -0700 (PDT)
Received: from [10.1.27.157] (C02CF1NRLVDN.cambridge.arm.com [10.1.27.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F8BC3F587;
        Tue, 18 Apr 2023 06:50:20 -0700 (PDT)
Message-ID: <334f041e-575f-4efe-bfd8-53b7d19f8371@arm.com>
Date:   Tue, 18 Apr 2023 14:50:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 49/60] arm64: Enable LPA2 at boot if supported by the
 system
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-50-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-50-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 14:05, Ard Biesheuvel wrote:
> Update the early kernel mapping code to take 52-bit virtual addressing
> into account based on the LPA2 feature. This is a bit more involved than
> LVA (which is supported with 64k pages only), given that some page table
> descriptor bits change meaning in this case.
> 
> To keep the handling in asm to a minimum, the initial ID map is still
> created with 48-bit virtual addressing, which implies that the kernel
> image must be loaded into 48-bit addressable physical memory. This is
> currently required by the boot protocol, even though we happen to
> support placement outside of that for LVA/64k based configurations.
> 
> Enabling LPA2 involves more than setting TCR.T1SZ to a lower value,
> there is also a DS bit in TCR that needs to be set, and which changes
> the meaning of bits [9:8] in all page table descriptors. Since we cannot
> enable DS and every live page table descriptor at the same time, let's
> pivot through another temporary mapping. This avoids the need to
> reintroduce manipulations of the page tables with the MMU and caches
> disabled.
> 
> To permit the LPA2 feature to be overridden on the kernel command line,
> which may be necessary to work around silicon errata, or to deal with
> mismatched features on heterogeneous SoC designs, test for CPU feature
> overrides first, and only then enable LPA2.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/assembler.h  |  8 ++-
>  arch/arm64/include/asm/cpufeature.h | 18 +++++
>  arch/arm64/include/asm/memory.h     |  4 ++
>  arch/arm64/kernel/head.S            |  8 +++
>  arch/arm64/kernel/image-vars.h      |  1 +
>  arch/arm64/kernel/pi/map_kernel.c   | 70 +++++++++++++++++++-
>  arch/arm64/kernel/pi/map_range.c    | 11 ++-
>  arch/arm64/kernel/pi/pi.h           |  4 +-
>  arch/arm64/mm/init.c                |  2 +-
>  arch/arm64/mm/mmu.c                 |  6 +-
>  arch/arm64/mm/proc.S                |  3 +
>  11 files changed, 124 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 55e8731844cf7eb7..d5e139ce0820479b 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -581,11 +581,17 @@ alternative_endif
>   * but we have to add an offset so that the TTBR1 address corresponds with the
>   * pgdir entry that covers the lowest 48-bit addressable VA.
>   *
> + * Note that this trick is only used for LVA/64k pages - LPA2/4k pages uses an
> + * additional paging level, and on LPA2/16k pages, we would end up with a root
> + * level table with only 2 entries, which is suboptimal in terms of TLB
> + * utilization, so there we fall back to 47 bits of translation if LPA2 is not
> + * supported.
> + *
>   * orr is used as it can cover the immediate value (and is idempotent).
>   * 	ttbr: Value of ttbr to set, modified.
>   */
>  	.macro	offset_ttbr1, ttbr, tmp
> -#ifdef CONFIG_ARM64_VA_BITS_52
> +#if defined(CONFIG_ARM64_VA_BITS_52) && !defined(CONFIG_ARM64_LPA2)
>  	mrs	\tmp, tcr_el1
>  	and	\tmp, \tmp, #TCR_T1SZ_MASK
>  	cmp	\tmp, #TCR_T1SZ(VA_BITS_MIN)
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 7faf9a48339e7c8c..170e18cb2b4faf11 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -1002,6 +1002,24 @@ static inline bool cpu_has_lva(void)
>  						    ID_AA64MMFR2_EL1_VARange_SHIFT);
>  }
>  
> +static inline bool cpu_has_lpa2(void)
> +{
> +#ifdef CONFIG_ARM64_LPA2
> +	u64 mmfr0;
> +	int feat;
> +
> +	mmfr0 = read_sysreg(id_aa64mmfr0_el1);
> +	mmfr0 &= ~id_aa64mmfr0_override.mask;
> +	mmfr0 |= id_aa64mmfr0_override.val;
> +	feat = cpuid_feature_extract_signed_field(mmfr0,
> +						  ID_AA64MMFR0_EL1_TGRAN_SHIFT);
> +
> +	return feat >= ID_AA64MMFR0_EL1_TGRAN_LPA2;
> +#else
> +	return false;
> +#endif
> +}

I wonder if we should rename this to cpu_has_lpa2_stage1()? I currently have a
system_supports_lpa2() function, which wraps a system cap, and reports true if
BOTH stage1 and stage2 are supported. I suspect this should be renamed to
something like system_has_lpa2_stage12() to match?

Regardless, in my series, KVM currently decides whether or not to use LPA2 page
tables based on system_supports_lpa2(). But I will need to add a new condition
whereby if the kernel is using LPA2 (lpa2_is_enabled()) but stage2 reports that
LPA2 is not supported then KVM fails to initialize. Otherwise we could end up in
a situation where KVM can't map memory passed to it by the kernel.

