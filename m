Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0B061F691
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiKGOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiKGOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:51:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7554C1BEB9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:51:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2415AB81217
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D361EC433D7;
        Mon,  7 Nov 2022 14:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667832663;
        bh=RQF6DcpueeAn/U7ivkg2nCuDs++5yALpTWm0b1zzxGc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YgzYQ13JxuI90RZ1M7xc3VnCQqQN/crcFmQjiJeYd1Fw8obFllxKSq7FZh8RqXZ52
         ygxmgve4PxQGecUVubnOQGZAhe/ei6FiT6j0ibRtvFy5DjxVF8gbv3cVjj0b9y9Rvd
         LLCpuGlDY8LIs74sHC44ywd9vzfdmdIB4dQz7t86Cnbq7rI7HvewqeTzFYiNb2mKAj
         JLelAQYvs29pe3Bi75zxDZqR5DDcDoFYX8gWYs2M8258mVgVkRvhQ4gpGR6vAIDpN9
         l1UwFUgYeS60XMuVO5gFHpcROcKYUV8fVWKCB7T5Xmk8zcfCSkGVpUSYn45cJqJF0f
         1D4+t202ieTvw==
Message-ID: <dd9e8b36-2421-6142-764a-f44b891b9774@kernel.org>
Date:   Mon, 7 Nov 2022 06:50:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCHv11 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
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
 <20221025001722.17466-6-kirill.shutemov@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20221025001722.17466-6-kirill.shutemov@linux.intel.com>
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
> untagged_addr() is a helper used by the core-mm to strip tag bits and
> get the address to the canonical shape. In only handles userspace
> addresses. The untagging mask is stored in mmu_context and will be set
> on enabling LAM for the process.
> 
> The tags must not be included into check whether it's okay to access the
> userspace address.
> 
> Strip tags in access_ok().
> 
> get_user() and put_user() don't use access_ok(), but check access
> against TASK_SIZE directly in assembly. Strip tags, before calling into
> the assembly helper.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Tested-by: Alexander Potapenko <glider@google.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/include/asm/mmu.h         |  3 +++
>   arch/x86/include/asm/mmu_context.h | 11 ++++++++
>   arch/x86/include/asm/uaccess.h     | 42 +++++++++++++++++++++++++++---
>   arch/x86/kernel/process.c          |  3 +++
>   4 files changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 002889ca8978..2fdb390040b5 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -43,6 +43,9 @@ typedef struct {
>   
>   	/* Active LAM mode:  X86_CR3_LAM_U48 or X86_CR3_LAM_U57 or 0 (disabled) */
>   	unsigned long lam_cr3_mask;
> +
> +	/* Significant bits of the virtual address. Excludes tag bits. */
> +	u64 untag_mask;
>   #endif
>   
>   	struct mutex lock;
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 69c943b2ae90..5bd3d46685dc 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -100,6 +100,12 @@ static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
>   static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
>   {
>   	mm->context.lam_cr3_mask = oldmm->context.lam_cr3_mask;
> +	mm->context.untag_mask = oldmm->context.untag_mask;
> +}
> +
> +static inline void mm_reset_untag_mask(struct mm_struct *mm)
> +{
> +	mm->context.untag_mask = -1UL;
>   }
>   
>   #else
> @@ -112,6 +118,10 @@ static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
>   static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
>   {
>   }
> +
> +static inline void mm_reset_untag_mask(struct mm_struct *mm)
> +{
> +}
>   #endif
>   
>   #define enter_lazy_tlb enter_lazy_tlb
> @@ -138,6 +148,7 @@ static inline int init_new_context(struct task_struct *tsk,
>   		mm->context.execute_only_pkey = -1;
>   	}
>   #endif
> +	mm_reset_untag_mask(mm);
>   	init_new_context_ldt(mm);
>   	return 0;
>   }
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 8bc614cfe21b..c6062c07ccd2 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -7,6 +7,7 @@
>   #include <linux/compiler.h>
>   #include <linux/instrumented.h>
>   #include <linux/kasan-checks.h>
> +#include <linux/mm_types.h>
>   #include <linux/string.h>
>   #include <asm/asm.h>
>   #include <asm/page.h>
> @@ -21,6 +22,30 @@ static inline bool pagefault_disabled(void);
>   # define WARN_ON_IN_IRQ()
>   #endif
>   
> +#ifdef CONFIG_X86_64
> +/*
> + * Mask out tag bits from the address.
> + *
> + * Magic with the 'sign' allows to untag userspace pointer without any branches
> + * while leaving kernel addresses intact.
> + */
> +#define untagged_addr(mm, addr)	({					\
> +	u64 __addr = (__force u64)(addr);				\
> +	s64 sign = (s64)__addr >> 63;					\
> +	__addr &= (mm)->context.untag_mask | sign;			\
> +	(__force __typeof__(addr))__addr;				\
> +})
> +

I think this implementation is correct, but I'm wondering if there are 
any callers of untagged_addr that actually need to preserve kernel 
addresses.  Are there?  (There certainly *were* back when we had set_fs().)

I'm also mildly uneasy about a potential edge case.  Naively, one would 
expect:

untagged_addr(current->mm, addr) + size ==
untagged_addr(current->mm, addr + size)

at least for an address that is valid enough to be potentially 
dereferenced.  This isn't true any more for size that overflows into the 
tag bit range.

I *think* we're okay though -- __access_ok requires that addr <= limit - 
size, so any range that overflows into tag bits will be rejected even if 
the entire range consists of valid (tagged) user addresses.

So:

Acked-by: Andy Lutomirski <luto@kernel.org>

