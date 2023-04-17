Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473076E4A91
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjDQOB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDQOBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:01:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCC4E4C39
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:00:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0D011691;
        Mon, 17 Apr 2023 07:01:29 -0700 (PDT)
Received: from [10.57.68.227] (unknown [10.57.68.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C23473F5A1;
        Mon, 17 Apr 2023 07:00:44 -0700 (PDT)
Message-ID: <37412bd5-9e73-024f-26ab-a351853bc846@arm.com>
Date:   Mon, 17 Apr 2023 15:00:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 25/60] arm64: head: Clear BSS and the kernel page
 tables in one go
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-26-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-26-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 14:04, Ard Biesheuvel wrote:
> We will move the CPU feature overrides into BSS in a subsequent patch,
> and this requires that BSS is zeroed before the feature override
> detection code runs. So let's map BSS read-write in the ID map, and zero
> it via this mapping.
> 
> Since the kernel page tables are right next to it, and also zeroed via
> the ID map, let's drop the separate clear_page_tables() function, and
> just zero everything in one go.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/head.S | 33 +++++++-------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 0fa44b3188c1e204..ade0cb99c8a83a3d 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -177,17 +177,6 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
>  	ret
>  SYM_CODE_END(preserve_boot_args)
>  
> -SYM_FUNC_START_LOCAL(clear_page_tables)
> -	/*
> -	 * Clear the init page tables.
> -	 */
> -	adrp	x0, init_pg_dir
> -	adrp	x1, init_pg_end
> -	sub	x2, x1, x0
> -	mov	x1, xzr
> -	b	__pi_memset			// tail call
> -SYM_FUNC_END(clear_page_tables)
> -
>  /*
>   * Macro to populate page table entries, these entries can be pointers to the next level
>   * or last level entries pointing to physical memory.
> @@ -386,9 +375,9 @@ SYM_FUNC_START_LOCAL(create_idmap)
>  
>  	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
>  
> -	/* Remap the kernel page tables r/w in the ID map */
> +	/* Remap BSS and the kernel page tables r/w in the ID map */
>  	adrp	x1, _text
> -	adrp	x2, init_pg_dir
> +	adrp	x2, __bss_start
>  	adrp	x3, _end
>  	bic	x4, x2, #SWAPPER_BLOCK_SIZE - 1
>  	mov	x5, SWAPPER_RW_MMUFLAGS
> @@ -489,14 +478,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>  	mov	x0, x20
>  	bl	set_cpu_boot_mode_flag
>  
> -	// Clear BSS
> -	adr_l	x0, __bss_start
> -	mov	x1, xzr
> -	adr_l	x2, __bss_stop
> -	sub	x2, x2, x0
> -	bl	__pi_memset
> -	dsb	ishst				// Make zero page visible to PTW
> -
>  #if VA_BITS > 48
>  	adr_l	x8, vabits_actual		// Set this early so KASAN early init
>  	str	x25, [x8]			// ... observes the correct value
> @@ -780,6 +761,15 @@ SYM_FUNC_START_LOCAL(__primary_switch)
>  	adrp	x1, reserved_pg_dir
>  	adrp	x2, init_idmap_pg_dir
>  	bl	__enable_mmu
> +
> +	// Clear BSS
> +	adrp	x0, __bss_start
> +	mov	x1, xzr
> +	adrp	x2, init_pg_end
> +	sub	x2, x2, x0
> +	bl	__pi_memset
> +	dsb	ishst				// Make zero page visible to PTW

Is it possible to add an assert somewhere (or at the very least a comment in
vmlinux.lds.S) to ensure that nothing gets inserted between the BSS and the page
tables? It feels a bit fragile otherwise.

I also wonder what's the point in calling __pi_memset() from here? Why not just
do it all in C?


> +
>  #ifdef CONFIG_RELOCATABLE
>  	adrp	x23, KERNEL_START
>  	and	x23, x23, MIN_KIMG_ALIGN - 1
> @@ -794,7 +784,6 @@ SYM_FUNC_START_LOCAL(__primary_switch)
>  	orr	x23, x23, x0			// record kernel offset
>  #endif
>  #endif
> -	bl	clear_page_tables
>  	bl	create_kernel_mapping
>  
>  	adrp	x1, init_pg_dir

