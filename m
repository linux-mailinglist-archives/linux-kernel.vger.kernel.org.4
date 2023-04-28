Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A3D6F1643
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbjD1LAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjD1LAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:00:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF08E2706
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:00:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ACFEC14;
        Fri, 28 Apr 2023 04:01:00 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E05973F64C;
        Fri, 28 Apr 2023 04:00:14 -0700 (PDT)
Date:   Fri, 28 Apr 2023 12:00:09 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 05/60] arm64: mm: Move fixmap region above vmemmap
 region
Message-ID: <ZEunOUCH90QvX93Z@FVFF77S0Q05N>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-6-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307140522.2311461-6-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 03:04:27PM +0100, Ard Biesheuvel wrote:
> Move the fixmap region above the vmemmap region, so that the start of
> the vmemmap delineates the end of the region available for vmalloc and
> vmap allocations and the randomized placement of the kernel and modules.
> 
> In a subsequent patch, we will take advantage of this to reclaim most of
> the vmemmap area when running a 52-bit VA capable build with 52-bit
> virtual addressing disabled at runtime.
> 
> Note that the existing guard region of 256 MiB covers the fixmap and PCI
> I/O regions as well, so we can reduce it 8 MiB, which is what we use in
> other places too.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/memory.h  | 2 +-
>  arch/arm64/include/asm/pgtable.h | 2 +-
>  arch/arm64/mm/ptdump.c           | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)

As a heads-up, this will (trivially) conflict with some of the arm64 fixmap
cleanups that'll be in v6.4-rc1, due to the FIXADDR_TOT_* changes.

> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 6e321cc06a3c30f0..9b9e52d823beccc6 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -51,7 +51,7 @@
>  #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
>  #define PCI_IO_START		(VMEMMAP_END + SZ_8M)
>  #define PCI_IO_END		(PCI_IO_START + PCI_IO_SIZE)
> -#define FIXADDR_TOP		(VMEMMAP_START - SZ_32M)
> +#define FIXADDR_TOP		(ULONG_MAX - SZ_8M + 1)

Can we make this:

  #define FIXADDR_TOP	(-SZ_8M)

... as that would match the way we define PAGE_OFFSET (and VMEMMAP_START), and
it removes the need for the '+1' to handle ULONG_MAX being one-off what we
actually want to subtact from.

Mark.

>  
>  #if VA_BITS > 48
>  #define VA_BITS_MIN		(48)
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b6ba466e2e8a3fc7..3eff06c5d0eb73c7 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -22,7 +22,7 @@
>   *	and fixed mappings
>   */
>  #define VMALLOC_START		(MODULES_END)
> -#define VMALLOC_END		(VMEMMAP_START - SZ_256M)
> +#define VMALLOC_END		(VMEMMAP_START - SZ_8M)
>  
>  #define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
>  
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 9d1f4cdc6672ed5f..76d28056bd14920a 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -45,12 +45,12 @@ static struct addr_marker address_markers[] = {
>  	{ MODULES_END,			"Modules end" },
>  	{ VMALLOC_START,		"vmalloc() area" },
>  	{ VMALLOC_END,			"vmalloc() end" },
> -	{ FIXADDR_START,		"Fixmap start" },
> -	{ FIXADDR_TOP,			"Fixmap end" },
>  	{ VMEMMAP_START,		"vmemmap start" },
>  	{ VMEMMAP_START + VMEMMAP_SIZE,	"vmemmap end" },
>  	{ PCI_IO_START,			"PCI I/O start" },
>  	{ PCI_IO_END,			"PCI I/O end" },
> +	{ FIXADDR_START,		"Fixmap start" },
> +	{ FIXADDR_TOP,			"Fixmap end" },
>  	{ -1,				NULL },
>  };
>  
> -- 
> 2.39.2
> 
> 
