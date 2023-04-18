Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2022B6E673C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjDROd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDROd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:33:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D80F286BC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:33:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5390A1684;
        Tue, 18 Apr 2023 07:34:28 -0700 (PDT)
Received: from [10.1.27.157] (C02CF1NRLVDN.cambridge.arm.com [10.1.27.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74B2A3F587;
        Tue, 18 Apr 2023 07:33:43 -0700 (PDT)
Message-ID: <2555fdfe-8979-3aac-6bf1-a9bab11a79e2@arm.com>
Date:   Tue, 18 Apr 2023 15:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 56/60] arm64: kvm: Limit HYP VA and host S2 range to 48
 bits when LPA2 is in effect
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-57-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-57-ardb@kernel.org>
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
> The KVM code needs more work to support 5 level paging with LPA2, so for
> the time being, limit KVM to 48 bit addressing on 4k and 16k pagesize
> configurations. This can be reverted once the LPA2 support for KVM is
> merged.

Don't you still have a problem that a user's memory could map to physical memory
above 48 bits that it tries to map into a KVM VM? How do you protect against
that? I think KVM needs to be disabled entirely when the kernel is using LPA2,
until KVM explicitly supports LPA2 too?

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 2 ++
>  arch/arm64/kvm/mmu.c                  | 5 ++++-
>  arch/arm64/kvm/va_layout.c            | 9 +++++----
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 552653fa18be34b2..e00b87ed4a8400f6 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -128,6 +128,8 @@ static void prepare_host_vtcr(void)
>  	/* The host stage 2 is id-mapped, so use parange for T0SZ */
>  	parange = kvm_get_parange(id_aa64mmfr0_el1_sys_val);
>  	phys_shift = id_aa64mmfr0_parange_to_phys_shift(parange);
> +	if (IS_ENABLED(CONFIG_ARM64_LPA2) && phys_shift > 48)
> +		phys_shift = 48; // not implemented yet
>  
>  	host_mmu.arch.vtcr = kvm_get_vtcr(id_aa64mmfr0_el1_sys_val,
>  					  id_aa64mmfr1_el1_sys_val, phys_shift);
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 4e7c0f9a9c286c09..2ad9e6f1e101e52d 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -661,7 +661,8 @@ static int get_user_mapping_size(struct kvm *kvm, u64 addr)
>  {
>  	struct kvm_pgtable pgt = {
>  		.pgd		= (kvm_pteref_t)kvm->mm->pgd,
> -		.ia_bits	= vabits_actual,
> +		.ia_bits	= IS_ENABLED(CONFIG_ARM64_LPA2) ? 48
> +								: vabits_actual,
>  		.start_level	= (KVM_PGTABLE_MAX_LEVELS -
>  				   ARM64_HW_PGTABLE_LEVELS(pgt.ia_bits)),
>  		.mm_ops		= &kvm_user_mm_ops,
> @@ -1703,6 +1704,8 @@ int __init kvm_mmu_init(u32 *hyp_va_bits)
>  	idmap_bits = 48;
>  	kernel_bits = vabits_actual;
>  	*hyp_va_bits = max(idmap_bits, kernel_bits);
> +	if (IS_ENABLED(CONFIG_ARM64_LPA2))
> +		*hyp_va_bits = 48; // LPA2 is not yet supported in KVM
>  
>  	kvm_debug("Using %u-bit virtual addresses at EL2\n", *hyp_va_bits);
>  	kvm_debug("IDMAP page: %lx\n", hyp_idmap_start);
> diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
> index 341b67e2f2514e55..ac87d0c39c38f7d9 100644
> --- a/arch/arm64/kvm/va_layout.c
> +++ b/arch/arm64/kvm/va_layout.c
> @@ -59,12 +59,13 @@ static void init_hyp_physvirt_offset(void)
>   */
>  __init void kvm_compute_layout(void)
>  {
> +	u64 vabits = IS_ENABLED(CONFIG_ARM64_LPA2) ? 48 : vabits_actual; // not yet
>  	phys_addr_t idmap_addr = __pa_symbol(__hyp_idmap_text_start);
>  	u64 hyp_va_msb;
>  
>  	/* Where is my RAM region? */
> -	hyp_va_msb  = idmap_addr & BIT(vabits_actual - 1);
> -	hyp_va_msb ^= BIT(vabits_actual - 1);
> +	hyp_va_msb  = idmap_addr & BIT(vabits - 1);
> +	hyp_va_msb ^= BIT(vabits - 1);
>  
>  	tag_lsb = fls64((u64)phys_to_virt(memblock_start_of_DRAM()) ^
>  			(u64)(high_memory - 1));
> @@ -72,10 +73,10 @@ __init void kvm_compute_layout(void)
>  	va_mask = GENMASK_ULL(tag_lsb - 1, 0);
>  	tag_val = hyp_va_msb;
>  
> -	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && tag_lsb != (vabits_actual - 1) &&
> +	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && tag_lsb != (vabits - 1) &&
>  	    !kaslr_disabled_cmdline()) {
>  		/* We have some free bits to insert a random tag. */
> -		tag_val |= get_random_long() & GENMASK_ULL(vabits_actual - 2, tag_lsb);
> +		tag_val |= get_random_long() & GENMASK_ULL(vabits - 2, tag_lsb);
>  	}
>  	tag_val >>= tag_lsb;
>  

