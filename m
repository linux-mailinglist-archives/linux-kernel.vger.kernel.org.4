Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784036AE70C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCGQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCGQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:45:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D37150F97
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:42:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3010411FB;
        Tue,  7 Mar 2023 08:43:22 -0800 (PST)
Received: from [10.1.29.181] (C02CF1NRLVDN.cambridge.arm.com [10.1.29.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 791653F67D;
        Tue,  7 Mar 2023 08:42:37 -0800 (PST)
Message-ID: <8e931b7c-3c10-10f7-5d59-546b1a9d5735@arm.com>
Date:   Tue, 7 Mar 2023 16:42:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 09/60] arm64: mm: Reclaim unused vmemmap region for
 vmalloc use
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-10-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-10-ardb@kernel.org>
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

On 07/03/2023 14:04, Ard Biesheuvel wrote:
> The vmemmap array is statically sized based on the maximum supported
> size of the virtual address space, but it is located inside the upper VA
> region, which is statically sized based on the *minimum* supported size
> of the VA space. This doesn't matter much when using 64k pages, which is
> the only configuration that currently supports 52-bit virtual
> addressing.

As I understand it, the vmemmap section only holds struct pages, and the number
of struct pages in the system is surely a function of PA size, not VA size? So
why is the region sized based on VA size?

> 
> However, upcoming LPA2 support will change this picture somewhat, as in
> that case, the vmemmap array will take up more than 25% of the upper VA
> region when using 4k pages. Given that most of this space is never used
> when running on a system that does not support 52-bit virtual
> addressing, let's reclaim the unused vmemmap area in that case.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 3eff06c5d0eb73c7..2259898e8c3d990a 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -18,11 +18,15 @@
>   * VMALLOC range.
>   *
>   * VMALLOC_START: beginning of the kernel vmalloc space
> - * VMALLOC_END: extends to the available space below vmemmap, PCI I/O space
> - *	and fixed mappings
> + * VMALLOC_END: extends to the available space below vmemmap
>   */
>  #define VMALLOC_START		(MODULES_END)
> +#if VA_BITS == VA_BITS_MIN
>  #define VMALLOC_END		(VMEMMAP_START - SZ_8M)
> +#else
> +#define VMEMMAP_UNUSED_NPAGES	((_PAGE_OFFSET(vabits_actual) - PAGE_OFFSET) >> PAGE_SHIFT)
> +#define VMALLOC_END		(VMEMMAP_START + VMEMMAP_UNUSED_NPAGES * sizeof(struct page) - SZ_8M)
> +#endif
>  
>  #define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
>  

