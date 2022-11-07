Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E819461F6FC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiKGPA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiKGPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:00:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAF41DDD6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:59:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D4426114E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FCBC433C1;
        Mon,  7 Nov 2022 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667833151;
        bh=bf9N/JHE7L0ipa1U2A7zFmNDXYV8KVfW0tcb8iRb2Ac=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JoSL9iuaPd1zJ/yQQXCwhkCLAYx9K9wwWH5M9+pNx2Imo0ydG3V2lXn9N7BCNN64N
         1Jnd/M30XVgI3/0mwAnkmKEzmRynGYWHI7WM7W/YVNPBBMsiExBY74dNapax+R+WQ7
         gJx/3ZWNuyCuC17g6oA8HDEngqx4NQANOndx0n+FnTX4p3lNMVKaDnOfhO//5Y93Ga
         LKd/C/q7/wAlXk+5fY9l3jBCaQL4OBytKlRXy0Ix2IW7TyooJt4yuLozoDfKQXdLve
         Enojj6FtgNLjz36YtD2XcNLUzgNIv5W7tKwF+2RXd0Gbu2Ejz0EW4Vb5Ce9+cCXacL
         Z3D+6ziScm95A==
Message-ID: <b38f15de-436e-489c-b8db-9beff4466748@kernel.org>
Date:   Mon, 7 Nov 2022 06:58:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCHv11 04/16] x86/mm: Handle LAM on context switch
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
 <20221025001722.17466-5-kirill.shutemov@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20221025001722.17466-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 17:17, Kirill A. Shutemov wrote:
> Linear Address Masking mode for userspace pointers encoded in CR3 bits.
> The mode is selected per-process and stored in mm_context_t.
> 
> switch_mm_irqs_off() now respects selected LAM mode and constructs CR3
> accordingly.
> 
> The active LAM mode gets recorded in the tlb_state.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Tested-by: Alexander Potapenko <glider@google.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/include/asm/mmu.h         |  3 ++
>   arch/x86/include/asm/mmu_context.h | 24 +++++++++++++++
>   arch/x86/include/asm/tlbflush.h    | 34 +++++++++++++++++++++
>   arch/x86/mm/tlb.c                  | 48 ++++++++++++++++++++----------
>   4 files changed, 93 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 5d7494631ea9..002889ca8978 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -40,6 +40,9 @@ typedef struct {
>   
>   #ifdef CONFIG_X86_64
>   	unsigned short flags;
> +
> +	/* Active LAM mode:  X86_CR3_LAM_U48 or X86_CR3_LAM_U57 or 0 (disabled) */
> +	unsigned long lam_cr3_mask;
>   #endif
>   
>   	struct mutex lock;
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index b8d40ddeab00..69c943b2ae90 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -91,6 +91,29 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
>   }
>   #endif
>   
> +#ifdef CONFIG_X86_64
> +static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
> +{
> +	return mm->context.lam_cr3_mask;
> +}
> +
> +static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
> +{
> +	mm->context.lam_cr3_mask = oldmm->context.lam_cr3_mask;
> +}
> +
> +#else
> +
> +static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
> +{
> +	return 0;
> +}
> +
> +static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
> +{
> +}
> +#endif
> +
>   #define enter_lazy_tlb enter_lazy_tlb
>   extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
>   
> @@ -168,6 +191,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
>   {
>   	arch_dup_pkeys(oldmm, mm);
>   	paravirt_arch_dup_mmap(oldmm, mm);
> +	dup_lam(oldmm, mm);
>   	return ldt_dup_context(oldmm, mm);
>   }
>   
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index cda3118f3b27..662598dea937 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -101,6 +101,16 @@ struct tlb_state {
>   	 */
>   	bool invalidate_other;
>   
> +#ifdef CONFIG_X86_64
> +	/*
> +	 * Active LAM mode.
> +	 *
> +	 * X86_CR3_LAM_U57/U48 shifted right by X86_CR3_LAM_U57_BIT or 0 if LAM
> +	 * disabled.
> +	 */
> +	u8 lam;
> +#endif
> +
>   	/*
>   	 * Mask that contains TLB_NR_DYN_ASIDS+1 bits to indicate
>   	 * the corresponding user PCID needs a flush next time we
> @@ -357,6 +367,30 @@ static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
>   }
>   #define huge_pmd_needs_flush huge_pmd_needs_flush
>   
> +#ifdef CONFIG_X86_64
> +static inline unsigned long tlbstate_lam_cr3_mask(void)
> +{
> +	unsigned long lam = this_cpu_read(cpu_tlbstate.lam);
> +
> +	return lam << X86_CR3_LAM_U57_BIT;
> +}
> +
> +static inline void set_tlbstate_cr3_lam_mask(unsigned long mask)
> +{
> +	this_cpu_write(cpu_tlbstate.lam, mask >> X86_CR3_LAM_U57_BIT);
> +}
> +
> +#else
> +
> +static inline unsigned long tlbstate_lam_cr3_mask(void)
> +{
> +	return 0;
> +}
> +
> +static inline void set_tlbstate_cr3_lam_mask(u64 mask)
> +{
> +}
> +#endif
>   #endif /* !MODULE */
>   
>   static inline void __native_tlb_flush_global(unsigned long cr4)
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index c1e31e9a85d7..d6c9c15d2ad2 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -154,26 +154,30 @@ static inline u16 user_pcid(u16 asid)
>   	return ret;
>   }
>   
> -static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
> +static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
>   {
> +	unsigned long cr3 = __sme_pa(pgd) | lam;
> +
>   	if (static_cpu_has(X86_FEATURE_PCID)) {
> -		return __sme_pa(pgd) | kern_pcid(asid);
> +		VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
> +		cr3 |= kern_pcid(asid);
>   	} else {
>   		VM_WARN_ON_ONCE(asid != 0);
> -		return __sme_pa(pgd);
>   	}
> +
> +	return cr3;
>   }
>   
> -static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
> +static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid,
> +					      unsigned long lam)
>   {
> -	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
>   	/*
>   	 * Use boot_cpu_has() instead of this_cpu_has() as this function
>   	 * might be called during early boot. This should work even after
>   	 * boot because all CPU's the have same capabilities:
>   	 */
>   	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
> -	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
> +	return build_cr3(pgd, asid, lam) | CR3_NOFLUSH;
>   }
>   
>   /*
> @@ -274,15 +278,16 @@ static inline void invalidate_user_asid(u16 asid)
>   		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
>   }
>   
> -static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
> +static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, unsigned long lam,
> +			    bool need_flush)
>   {
>   	unsigned long new_mm_cr3;
>   
>   	if (need_flush) {
>   		invalidate_user_asid(new_asid);
> -		new_mm_cr3 = build_cr3(pgdir, new_asid);
> +		new_mm_cr3 = build_cr3(pgdir, new_asid, lam);
>   	} else {
> -		new_mm_cr3 = build_cr3_noflush(pgdir, new_asid);
> +		new_mm_cr3 = build_cr3_noflush(pgdir, new_asid, lam);
>   	}
>   
>   	/*
> @@ -491,6 +496,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>   {
>   	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
>   	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> +	unsigned long prev_lam = tlbstate_lam_cr3_mask();
> +	unsigned long new_lam = mm_lam_cr3_mask(next);
>   	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
>   	unsigned cpu = smp_processor_id();
>   	u64 next_tlb_gen;
> @@ -520,7 +527,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>   	 * isn't free.
>   	 */
>   #ifdef CONFIG_DEBUG_VM
> -	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid))) {
> +	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid, prev_lam))) {
>   		/*
>   		 * If we were to BUG here, we'd be very likely to kill
>   		 * the system so hard that we don't see the call trace.
> @@ -554,6 +561,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>   	if (real_prev == next) {
>   		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
>   			   next->context.ctx_id);
> +		VM_WARN_ON(prev_lam != new_lam);

What prevents this warning from firing if a remote cpu does 
prctl_enable_tagged_addr() and this cpu hits this code path before 
getting the LAM-enabling IPI?  Conceptually this would be like if we 
asserted that LDTR matched the mm_context's ldt setting in this code path.

I think (haven't really verified) that you can fix this by removing the 
warning and adding a comment explaining that CR3 can be out of sync due 
to a race against changes to LAM settings.  I don't think there's any 
way to eliminate the race -- there is no lock you can take while 
changing lam that prevents a remote CPU from switching mm or scheduling.

--Andy
