Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0ED61A1E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKDUHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKDUHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:07:09 -0400
Received: from smtpcmd12132.aruba.it (smtpcmd12132.aruba.it [62.149.156.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A32381BC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:07:06 -0700 (PDT)
Received: from [192.168.50.173] ([146.241.83.94])
        by Aruba Outgoing Smtp  with ESMTPSA
        id r2xxoksyrae4mr2xxos151; Fri, 04 Nov 2022 21:07:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1667592424; bh=4rNWA6LxK3Nk/aSIAW3zF5mgoZH6h/znbwRrsrOEaHQ=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=Hpi2sObTpY3uxA1QBl4NLTN7KUy8bgpaKQR32xj8Cxe17A06vTsKFgIXnNk/wE5XH
         MF1vmLQXHOAM9c4HVMN/8tQywvD85yE6tZ1WzA2fzvWa3uAGuJmpWHJheEuMJqv/Zv
         lBUtvSVgcsVja1bDi5N5FoJNH/UEs3/WMJbrlOvwyrERzO/t3RP0i/hpFnIPwo6mZN
         6W86K3OiePsxB3hZaysjah9l2Ha8Jj6nTl0gh8IfIgECzyhWKCze3PiKtitgpd5Jdb
         tz+TSCkZNF9XqluR21QMTK3E961omKHTkO37jJLrOiSwcAwdkOi8ZC85OvZyOPawn+
         8B7ruD5QKJzNQ==
Message-ID: <64e16669-8bcc-a05e-0eb1-9ae644431d95@benettiengineering.com>
Date:   Fri, 4 Nov 2022 21:07:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] ARM: mm: fix no-MMU ZERO_PAGE() implementation
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>
References: <20221018222503.90118-1-giulio.benetti@benettiengineering.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20221018222503.90118-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKhXI8JkQI++zVRgIJ21Nv3/QfDiS03sM1LqTkjDc5XF1BYJOfCrkATWnQKe7w3TAN3G8qlAp1CMB22g72AW4WbM11rwn3Q8m+UcRLOZS5wqJ26oqjpp
 A20qHynssmbBADayF6PLwEaJKWjt0aCm9ruy6EoT8zUQ94s59jzWXD90BBw4VLP190aMzc11EqjiU7SvkyRPuqJpOsdd+udaFsTZ1vPxvRkkJ7d+qe/fbOOp
 w2KvnuQVqGNDzEEESuthFTW1FqbHiRzEctu6jq/j0w7IJSuzuxlFNS+fhK0Fu74v63yc9G5CvO3tG+g09isqeCv+uuzabNtGVHctQmYC1DF3J6+hmLKvOA1n
 gYwBxaoJKEElAgyCCmNlbj9nFgxLZUbUotstAeikWK/p9vau5qvMw904Nu6HR4fiGQkHokUbIQ49oU/vjp2oi/2YcXkwaHEraNSDq7WXqiYmNmwdRdi9v6Ty
 8QLQNxYE5dKQEHA+Up6vvpOKs15DaxMnN8YtM71lGpntjveuWPESKfkJnGg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd, Russell, All,

is this patch ok or has it some changes to do?

While instead [PATCH 2/2] has a NAK and can be dropped.

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

On 19/10/22 00:25, Giulio Benetti wrote:
> Actually in no-MMU SoCs(i.e. i.MXRT) ZERO_PAGE(vaddr) expands to
> ```
> virt_to_page(0)
> ```
> that in order expands to:
> ```
> pfn_to_page(virt_to_pfn(0))
> ```
> and then virt_to_pfn(0) to:
> ```
> #define virt_to_pfn(0) \
> 	((((unsigned long)(0) - PAGE_OFFSET) >> PAGE_SHIFT) + \
> 	 PHYS_PFN_OFFSET)
> ```
> where PAGE_OFFSET and PHYS_PFN_OFFSET are the DRAM offset(0x80000000) and
> PAGE_SHIFT is 12. This way we obtain 16MB(0x01000000) summed to the base of
> DRAM(0x80000000).
> When ZERO_PAGE(0) is then used, for example in bio_add_page(), the page
> gets an address that is out of DRAM bounds.
> So instead of using fake virtual page 0 let's allocate a dedicated
> zero_page during paging_init() and assign it to a global 'struct page *
> empty_zero_page' the same way mmu.c does and it's the same approach used
> in m68k with commit dc068f462179 as discussed here[0]. Then let's move
> ZERO_PAGE() definition to the top of pgtable.h to be in common between
> mmu.c and nommu.c.
> 
> [0]: https://lore.kernel.org/linux-m68k/2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com/T/#m1266ceb63ad140743174d6b3070364d3c9a5179b
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
> V1->V2:
> * improve commit log as suggested by Arnd Bergmann
> ---
>   arch/arm/include/asm/pgtable-nommu.h |  6 ------
>   arch/arm/include/asm/pgtable.h       | 16 +++++++++-------
>   arch/arm/mm/nommu.c                  | 19 +++++++++++++++++++
>   3 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
> index d16aba48fa0a..090011394477 100644
> --- a/arch/arm/include/asm/pgtable-nommu.h
> +++ b/arch/arm/include/asm/pgtable-nommu.h
> @@ -44,12 +44,6 @@
>   
>   typedef pte_t *pte_addr_t;
>   
> -/*
> - * ZERO_PAGE is a global shared page that is always zero: used
> - * for zero-mapped memory areas etc..
> - */
> -#define ZERO_PAGE(vaddr)	(virt_to_page(0))
> -
>   /*
>    * Mark the prot value as uncacheable and unbufferable.
>    */
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 78a532068fec..ef48a55e9af8 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -10,6 +10,15 @@
>   #include <linux/const.h>
>   #include <asm/proc-fns.h>
>   
> +#ifndef __ASSEMBLY__
> +/*
> + * ZERO_PAGE is a global shared page that is always zero: used
> + * for zero-mapped memory areas etc..
> + */
> +extern struct page *empty_zero_page;
> +#define ZERO_PAGE(vaddr)	(empty_zero_page)
> +#endif
> +
>   #ifndef CONFIG_MMU
>   
>   #include <asm-generic/pgtable-nopud.h>
> @@ -139,13 +148,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>    */
>   
>   #ifndef __ASSEMBLY__
> -/*
> - * ZERO_PAGE is a global shared page that is always zero: used
> - * for zero-mapped memory areas etc..
> - */
> -extern struct page *empty_zero_page;
> -#define ZERO_PAGE(vaddr)	(empty_zero_page)
> -
>   
>   extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>   
> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> index c42debaded95..c1494a4dee25 100644
> --- a/arch/arm/mm/nommu.c
> +++ b/arch/arm/mm/nommu.c
> @@ -26,6 +26,13 @@
>   
>   unsigned long vectors_base;
>   
> +/*
> + * empty_zero_page is a special page that is used for
> + * zero-initialized data and COW.
> + */
> +struct page *empty_zero_page;
> +EXPORT_SYMBOL(empty_zero_page);
> +
>   #ifdef CONFIG_ARM_MPU
>   struct mpu_rgn_info mpu_rgn_info;
>   #endif
> @@ -148,9 +155,21 @@ void __init adjust_lowmem_bounds(void)
>    */
>   void __init paging_init(const struct machine_desc *mdesc)
>   {
> +	void *zero_page;
> +
>   	early_trap_init((void *)vectors_base);
>   	mpu_setup();
> +
> +	/* allocate the zero page. */
> +	zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +	if (!zero_page)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> +		      __func__, PAGE_SIZE, PAGE_SIZE);
> +
>   	bootmem_init();
> +
> +	empty_zero_page = virt_to_page(zero_page);
> +	flush_dcache_page(empty_zero_page);
>   }
>   
>   /*

