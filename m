Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB18F6F15EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345531AbjD1KnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjD1KnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:43:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 428A8E76
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:43:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C532C14;
        Fri, 28 Apr 2023 03:43:44 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAB963F64C;
        Fri, 28 Apr 2023 03:42:58 -0700 (PDT)
Date:   Fri, 28 Apr 2023 11:42:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 03/60] arm64: mm: get rid of kimage_vaddr global
 variable
Message-ID: <ZEujMHRbqXS3gxhY@FVFF77S0Q05N>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307140522.2311461-4-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 03:04:25PM +0100, Ard Biesheuvel wrote:
> We store the address of _text in kimage_vaddr, but since commit
> 09e3c22a86f6889d ("arm64: Use a variable to store non-global mappings
> decision"), we no longer reference this variable from modules so we no
> longer need to export it.
> 
> In fact, we don't need it at all so let's just get rid of it.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/memory.h | 6 ++----
>  arch/arm64/kernel/head.S        | 2 +-
>  arch/arm64/mm/mmu.c             | 3 ---
>  3 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 78e5163836a0ab95..a4e1d832a15a2d7a 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -182,6 +182,7 @@
>  #include <linux/types.h>
>  #include <asm/boot.h>
>  #include <asm/bug.h>
> +#include <asm/sections.h>
>  
>  #if VA_BITS > 48
>  extern u64			vabits_actual;
> @@ -193,15 +194,12 @@ extern s64			memstart_addr;
>  /* PHYS_OFFSET - the physical address of the start of memory. */
>  #define PHYS_OFFSET		({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
>  
> -/* the virtual base of the kernel image */
> -extern u64			kimage_vaddr;
> -
>  /* the offset between the kernel virtual and physical mappings */
>  extern u64			kimage_voffset;
>  
>  static inline unsigned long kaslr_offset(void)
>  {
> -	return kimage_vaddr - KIMAGE_VADDR;
> +	return (u64)&_text - KIMAGE_VADDR;
>  }
>  
>  static inline bool kaslr_enabled(void)
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index b98970907226b36c..65cdaaa2c859418f 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -482,7 +482,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>  
>  	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
>  
> -	ldr_l	x4, kimage_vaddr		// Save the offset between
> +	adrp	x4, _text			// Save the offset between
>  	sub	x4, x4, x0			// the kernel virtual and
>  	str_l	x4, kimage_voffset, x5		// physical mappings
>  
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 6f9d8898a02516f6..81e1420d2cc13246 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -50,9 +50,6 @@ u64 vabits_actual __ro_after_init = VA_BITS_MIN;
>  EXPORT_SYMBOL(vabits_actual);
>  #endif
>  
> -u64 kimage_vaddr __ro_after_init = (u64)&_text;
> -EXPORT_SYMBOL(kimage_vaddr);
> -
>  u64 kimage_voffset __ro_after_init;
>  EXPORT_SYMBOL(kimage_voffset);
>  
> -- 
> 2.39.2
> 
> 
