Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C881B6E4D94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjDQPsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjDQPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:48:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B278A24F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:48:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62B701691;
        Mon, 17 Apr 2023 08:48:48 -0700 (PDT)
Received: from [10.57.68.227] (unknown [10.57.68.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 742CB3F5A1;
        Mon, 17 Apr 2023 08:48:03 -0700 (PDT)
Message-ID: <e932c4c4-c0a5-76f0-20ee-1d0155d5b79e@arm.com>
Date:   Mon, 17 Apr 2023 16:48:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 32/60] arm64: head: allocate more pages for the kernel
 mapping
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-33-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-33-ardb@kernel.org>
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
> In preparation for switching to an early kernel mapping routine that
> maps each segment according to its precise boundaries, and with the
> correct attributes, let's allocate some extra pages for page tables for
> the 4k page size configuration. This is necessary because the start and
> end of each segment may not be aligned to the block size, and so we'll
> need an extra page table at each segment boundary.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/kernel-pgtable.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index 4d13c73171e1e360..50b5c145358a5d8e 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -80,7 +80,7 @@
>  			+ EARLY_PGDS((vstart), (vend), add) 	/* each PGDIR needs a next level page table */	\
>  			+ EARLY_PUDS((vstart), (vend), add)	/* each PUD needs a next level page table */	\
>  			+ EARLY_PMDS((vstart), (vend), add))	/* each PMD needs a next level page table */
> -#define INIT_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR, _end, EARLY_KASLR))
> +#define INIT_DIR_SIZE (PAGE_SIZE * (EARLY_PAGES(KIMAGE_VADDR, _end, EARLY_KASLR) + EARLY_SEGMENT_EXTRA_PAGES))
>  
>  /* the initial ID map may need two extra pages if it needs to be extended */
>  #if VA_BITS < 48
> @@ -101,6 +101,15 @@
>  #define SWAPPER_TABLE_SHIFT	PMD_SHIFT
>  #endif
>  
> +/* The number of segments in the kernel image (text, rodata, inittext, initdata, data+bss) */
> +#define KERNEL_SEGMENT_COUNT	5
> +
> +#if SWAPPER_BLOCK_SIZE > SEGMENT_ALIGN
> +#define EARLY_SEGMENT_EXTRA_PAGES (KERNEL_SEGMENT_COUNT + 1)

I'm guessing the block size for 4K pages is PMD, so you need these extra pages
to define PTEs for the case where the section start/end addresses are not on
exact 2MB boundaries? But in that case, isn't it possible that you would need 2
extra PTE tables per segment - one for the start and one for the end?

> +#else
> +#define EARLY_SEGMENT_EXTRA_PAGES 0
> +#endif
> +
>  /*
>   * Initial memory map attributes.
>   */

