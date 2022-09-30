Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1551B5F0575
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiI3HEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiI3HEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EB81C6A57
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664521470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcWFHjgbuO0r6ZBZj8hgSgJiAfkT3Zf4371ZaHnekNw=;
        b=NZCcl47giN2t/tNLFphoOl9SmrwCgjxyOn4IGosHFfgE9ZvnAOU1TB35ao2nvfrMlmKaua
        GMi1xSRFwiKOfV/rQXFly8+F1k8P1mT9ikwREqjuU4U+a6wvMKrHz5x8M3oxmb1rB6zvzo
        QpfbbhdvykTEDwEKYoI2Co0aiTE9A4o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-9nEgwoG1NZaonIsHlLBNmA-1; Fri, 30 Sep 2022 03:04:29 -0400
X-MC-Unique: 9nEgwoG1NZaonIsHlLBNmA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5E8438012D3;
        Fri, 30 Sep 2022 07:04:28 +0000 (UTC)
Received: from localhost (ovpn-12-133.pek2.redhat.com [10.72.12.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAFDF49BB60;
        Fri, 30 Sep 2022 07:04:27 +0000 (UTC)
Date:   Fri, 30 Sep 2022 15:04:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
        will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <YzaU99WgKFzpSN4P@MiWiFi-R3L-srv>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
 <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org>
 <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
 <YxXPannyTqBZInAt@kernel.org>
 <YxXmsKYGTd1+/U12@MiWiFi-R3L-srv>
 <CAMj1kXFDhbMPNcFnogyi7RXATqyHpqJLK9wiz=djRM3g65J8Zg@mail.gmail.com>
 <YyrBFvD2ID8sqhEK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyrBFvD2ID8sqhEK@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 09/21/22 at 10:45am, Mike Rapoport wrote:
> On Tue, Sep 06, 2022 at 03:05:57PM +0200, Ard Biesheuvel wrote:
> > 
> > While I appreciate the effort that has gone into solving this problem,
> > I don't think there is any consensus that an elaborate fix is required
> > to ensure that the crash kernel can be unmapped from the linear map at
> > all cost. In fact, I personally think we shouldn't bother, and IIRC,
> > Will made a remark along the same lines back when the Huawei engineers
> > were still driving this effort.
> > 
> > So perhaps we could align on that before doing yet another version of this?
> 
> I suggest to start with disabling crash kernel protection when its memory
> reservation is deferred and then Baoquan and kdump folks can take it from
> here.

Thanks for the attempt, really appreciated. We all tried and all see
everybody's effort on this issue.

If disabling protection is chosen, I would suggest disable it at all.
The system w/o having CONFIG_ZONE_DMA|32 is rarely seen, I don't think
we need do the protection for it specifically to make code inconsistent
and could confuse people. We can revert below commit and its later
change do to that.

commit 98d2e1539b84 ("arm64: kdump: protect crash dump kernel memory")

For RPi4, I tried to find one to test and figure out if it can do crash
dumping with buffer above 1G. However, nobody care about kdump when I
asked people around who have one at hand for testing, hobby, or
developping. Since they are not familiar with kdump setting and not so
eager to get to know, and I don't want to take up too much time, finally
I just give up.

So, if solution in this patchset is not accepted, I would like to see
the protection code is reverted. Other opinion, please?

> 
> From 6430407f784f3571da9b4d79340487f2647a44ab Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Wed, 21 Sep 2022 10:14:46 +0300
> Subject: [PATCH] arm64/mm: don't protect crash kernel memory with
>  CONFIG_ZONE_DMA/DMA32
> 
> Currently, in order to allow protection of crash kernel memory when
> CONFIG_ZONE_DMA/DMA32 is enabled, the block mappings in the linear map are
> disabled and the entire linear map uses base size pages.
> 
> This results in performance degradation because of higher TLB pressure for
> kernel memory accesses, so there is a trade off between performance and
> ability to protect the crash kernel memory.
> 
> Baoquan He said [1]:
> 
> 	In fact, panic is a small probability event, and accidental
> 	corruption on kdump kernel data is a much smaller probability
> 	event.
> 
> With this, it makes sense to only protect crash kernel memory only when it
> can be reserved before creation of the linear map.
> 
> Simplify the logic around crash kernel protection in map_mem() so that it
> will use base pages only if crash kernel memory is already reserved and
> introduce crashkres_protection_possible variable to ensure that
> arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres() won't
> try to modify page table if crash kernel is not mapped with base pages.
> 
> [1] https://lore.kernel.org/all/Yw2C9ahluhX4Mg3G@MiWiFi-R3L-srv
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/include/asm/mmu.h      |  1 +
>  arch/arm64/kernel/machine_kexec.c |  6 ++++
>  arch/arm64/mm/init.c              | 30 +++++++++-----------
>  arch/arm64/mm/mmu.c               | 46 ++++++++-----------------------
>  4 files changed, 32 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 48f8466a4be9..975607843548 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -71,6 +71,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>  extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
>  extern void mark_linear_text_alias_ro(void);
>  extern bool kaslr_requires_kpti(void);
> +extern bool crashkres_protection_possible;
>  
>  #define INIT_MM_CONTEXT(name)	\
>  	.pgd = init_pg_dir,
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 19c2d487cb08..68295403aa40 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -272,6 +272,9 @@ void arch_kexec_protect_crashkres(void)
>  {
>  	int i;
>  
> +	if (!crashkres_protection_possible)
> +		return;
> +
>  	for (i = 0; i < kexec_crash_image->nr_segments; i++)
>  		set_memory_valid(
>  			__phys_to_virt(kexec_crash_image->segment[i].mem),
> @@ -282,6 +285,9 @@ void arch_kexec_unprotect_crashkres(void)
>  {
>  	int i;
>  
> +	if (!crashkres_protection_possible)
> +		return;
> +
>  	for (i = 0; i < kexec_crash_image->nr_segments; i++)
>  		set_memory_valid(
>  			__phys_to_virt(kexec_crash_image->segment[i].mem),
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index b9af30be813e..220d45655918 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -62,27 +62,21 @@ EXPORT_SYMBOL(memstart_addr);
>   * In such case, ZONE_DMA32 covers the rest of the 32-bit addressable memory,
>   * otherwise it is empty.
>   *
> - * Memory reservation for crash kernel either done early or deferred
> - * depending on DMA memory zones configs (ZONE_DMA) --
> + * Memory reservation for crash kernel must know the upper limit of low
> + * memory in order to allow DMA access for devices with kdump kernel. When
> + * ZONE_DMA/DMA32 is enabled, this limit is determined after DT/ACPI is
> + * parsed, and crash kernel reservation happens afterwards. In this case,
> + * the crash kernel memory is reserved after linear map is created, there
> + * is no guarantee that crash kernel memory will be mapped with the base
> + * pages in the linear map, and thus the protection if the crash kernel
> + * memory is disabled.
>   *
>   * In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
>   * here instead of max_zone_phys().  This lets early reservation of
>   * crash kernel memory which has a dependency on arm64_dma_phys_limit.
> - * Reserving memory early for crash kernel allows linear creation of block
> - * mappings (greater than page-granularity) for all the memory bank rangs.
> - * In this scheme a comparatively quicker boot is observed.
> - *
> - * If ZONE_DMA configs are defined, crash kernel memory reservation
> - * is delayed until DMA zone memory range size initialization performed in
> - * zone_sizes_init().  The defer is necessary to steer clear of DMA zone
> - * memory range to avoid overlap allocation.  So crash kernel memory boundaries
> - * are not known when mapping all bank memory ranges, which otherwise means
> - * not possible to exclude crash kernel range from creating block mappings
> - * so page-granularity mappings are created for the entire memory range.
> - * Hence a slightly slower boot is observed.
> - *
> - * Note: Page-granularity mappings are necessary for crash kernel memory
> - * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
> + * Reserving crash kernel memory early allows mapping it with base pages in
> + * the linear map so that it can be protected, without preventing usage of
> + * block mappings for creation of the linear map.
>   */
>  #if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
>  phys_addr_t __ro_after_init arm64_dma_phys_limit;
> @@ -90,6 +84,8 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
>  phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>  #endif
>  
> +bool __ro_after_init crashkres_protection_possible;
> +
>  /* Current arm64 boot protocol requires 2MB alignment */
>  #define CRASH_ALIGN			SZ_2M
>  
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c5065abec55a..7b40f38dd3ee 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -502,21 +502,6 @@ void __init mark_linear_text_alias_ro(void)
>  			    PAGE_KERNEL_RO);
>  }
>  
> -static bool crash_mem_map __initdata;
> -
> -static int __init enable_crash_mem_map(char *arg)
> -{
> -	/*
> -	 * Proper parameter parsing is done by reserve_crashkernel(). We only
> -	 * need to know if the linear map has to avoid block mappings so that
> -	 * the crashkernel reservations can be unmapped later.
> -	 */
> -	crash_mem_map = true;
> -
> -	return 0;
> -}
> -early_param("crashkernel", enable_crash_mem_map);
> -
>  static void __init map_mem(pgd_t *pgdp)
>  {
>  	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
> @@ -547,13 +532,9 @@ static void __init map_mem(pgd_t *pgdp)
>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>  
>  #ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map) {
> -		if (defer_reserve_crashkernel())
> -			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> -		else if (crashk_res.end)
> -			memblock_mark_nomap(crashk_res.start,
> -			    resource_size(&crashk_res));
> -	}
> +	if (crashk_res.end)
> +		memblock_mark_nomap(crashk_res.start,
> +				    resource_size(&crashk_res));
>  #endif
>  
>  	/* map all the memory banks */
> @@ -584,20 +565,17 @@ static void __init map_mem(pgd_t *pgdp)
>  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>  
>  	/*
> -	 * Use page-level mappings here so that we can shrink the region
> -	 * in page granularity and put back unused memory to buddy system
> -	 * through /sys/kernel/kexec_crash_size interface.
> +	 * Use page-level mappings here so that we can protect crash kernel
> +	 * memory to allow post-mortem analysis despite memory errors in
> +	 * the main kernel.
>  	 */
>  #ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map && !defer_reserve_crashkernel()) {
> -		if (crashk_res.end) {
> -			__map_memblock(pgdp, crashk_res.start,
> -				       crashk_res.end + 1,
> -				       PAGE_KERNEL,
> -				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> -			memblock_clear_nomap(crashk_res.start,
> -					     resource_size(&crashk_res));
> -		}
> +	if (crashk_res.end) {
> +		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
> +			       PAGE_KERNEL, NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> +		memblock_clear_nomap(crashk_res.start,
> +				     resource_size(&crashk_res));
> +		crashkres_protection_possible = true;
>  	}
>  #endif
>  }
> -- 
> 2.35.3
> 
> 
> -- 
> Sincerely yours,
> Mike.
> 

