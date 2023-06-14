Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75532730B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbjFNXSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjFNXSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B101FEF;
        Wed, 14 Jun 2023 16:18:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 184266286E;
        Wed, 14 Jun 2023 23:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BABC433C8;
        Wed, 14 Jun 2023 23:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686784682;
        bh=VtjXUsVFZs1O91NerGvbTs+J8wgXOZF0VffZjoZ8hNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nv+ldAK/HpfiYALxKtTzDJ3R1JvD8STlSMxVjZUG5Avyp/mD57nD76jjE3FPXT8AL
         HCGXEPCkaFUHIfSqWaNABbDD1Al1ADfRLyjDSCn2qAeMIrs+Db1tkl6FNOEpc676Ze
         l68tWfDummphVfPm7n2mcDB8CWV7pztUvHFE3q0JsE2gCl/zLRclcYygBfyViXXnem
         gK73cgwRKGUwFnFqEfuSuC2FVqbH9J3ptdq5dhRed4nxnjBXEyDeORkjPQ30CCpF70
         QaJdYw8nkViSwe2ZlqF2rBlHvWW/eaJ5JiW0kpHPUcMlEFETbnObgVCONxs2mm8WRC
         cUQeRdqv61Jyw==
Date:   Wed, 14 Jun 2023 16:17:58 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/23] mips: update_mmu_cache() can replace
 __update_tlb()
Message-ID: <20230614231758.GA1503611@dev-arch.thelio-3990X>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
 <178970b0-1539-8aac-76fd-972c6c46ec17@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178970b0-1539-8aac-76fd-972c6c46ec17@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Thu, Jun 08, 2023 at 12:17:24PM -0700, Hugh Dickins wrote:
> Don't make update_mmu_cache() a wrapper around __update_tlb(): call it
> directly, and use the ptep (or pmdp) provided by the caller, instead of
> re-calling pte_offset_map() - which would raise a question of whether a
> pte_unmap() is needed to balance it.
> 
> Check whether the "ptep" provided by the caller is actually the pmdp,
> instead of testing pmd_huge(): or test pmd_huge() too and warn if it
> disagrees?  This is "hazardous" territory: needs review and testing.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  arch/mips/include/asm/pgtable.h | 15 +++------------
>  arch/mips/mm/tlb-r3k.c          |  5 +++--
>  arch/mips/mm/tlb-r4k.c          |  9 +++------
>  3 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index 574fa14ac8b2..9175dfab08d5 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -565,15 +565,8 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  }
>  #endif
>  
> -extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
> -	pte_t pte);
> -
> -static inline void update_mmu_cache(struct vm_area_struct *vma,
> -	unsigned long address, pte_t *ptep)
> -{
> -	pte_t pte = *ptep;
> -	__update_tlb(vma, address, pte);
> -}
> +extern void update_mmu_cache(struct vm_area_struct *vma,
> +	unsigned long address, pte_t *ptep);
>  
>  #define	__HAVE_ARCH_UPDATE_MMU_TLB
>  #define update_mmu_tlb	update_mmu_cache
> @@ -581,9 +574,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>  	unsigned long address, pmd_t *pmdp)
>  {
> -	pte_t pte = *(pte_t *)pmdp;
> -
> -	__update_tlb(vma, address, pte);
> +	update_mmu_cache(vma, address, (pte_t *)pmdp);
>  }
>  
>  /*
> diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
> index 53dfa2b9316b..e5722cd8dd6d 100644
> --- a/arch/mips/mm/tlb-r3k.c
> +++ b/arch/mips/mm/tlb-r3k.c
> @@ -176,7 +176,8 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
>  	}
>  }
>  
> -void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t pte)
> +void update_mmu_cache(struct vm_area_struct *vma,
> +		      unsigned long address, pte_t *ptep)
>  {
>  	unsigned long asid_mask = cpu_asid_mask(&current_cpu_data);
>  	unsigned long flags;
> @@ -203,7 +204,7 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t pte)
>  	BARRIER;
>  	tlb_probe();
>  	idx = read_c0_index();
> -	write_c0_entrylo0(pte_val(pte));
> +	write_c0_entrylo0(pte_val(*ptep));
>  	write_c0_entryhi(address | pid);
>  	if (idx < 0) {					/* BARRIER */
>  		tlb_write_random();
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index 1b939abbe4ca..c96725d17cab 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -290,14 +290,14 @@ void local_flush_tlb_one(unsigned long page)
>   * updates the TLB with the new pte(s), and another which also checks
>   * for the R4k "end of page" hardware bug and does the needy.
>   */
> -void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
> +void update_mmu_cache(struct vm_area_struct *vma,
> +		      unsigned long address, pte_t *ptep)
>  {
>  	unsigned long flags;
>  	pgd_t *pgdp;
>  	p4d_t *p4dp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
> -	pte_t *ptep;
>  	int idx, pid;
>  
>  	/*
> @@ -326,10 +326,9 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
>  	idx = read_c0_index();
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>  	/* this could be a huge page  */
> -	if (pmd_huge(*pmdp)) {
> +	if (ptep == (pte_t *)pmdp) {
>  		unsigned long lo;
>  		write_c0_pagemask(PM_HUGE_MASK);
> -		ptep = (pte_t *)pmdp;
>  		lo = pte_to_entrylo(pte_val(*ptep));
>  		write_c0_entrylo0(lo);
>  		write_c0_entrylo1(lo + (HPAGE_SIZE >> 7));
> @@ -344,8 +343,6 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
>  	} else
>  #endif
>  	{
> -		ptep = pte_offset_map(pmdp, address);
> -
>  #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
>  #ifdef CONFIG_XPA
>  		write_c0_entrylo0(pte_to_entrylo(ptep->pte_high));
> -- 
> 2.35.3
> 

I just bisected a crash while powering down a MIPS machine in QEMU to
this change as commit 8044511d3893 ("mips: update_mmu_cache() can
replace __update_tlb()") in linux-next. Unfortunately, I can still
reproduce it with the existing fix you have for this change on the
mailing list, which is present in next-20230614.

I can reproduce it with the GCC 13.1.0 on kernel.org [1].

  $ make -skj"$(nproc)" ARCH=mips CROSS_COMPILE=mips-linux- mrproper malta_defconfig vmlinux

  $ qemu-system-mipsel \
      -display none \
      -nodefaults \
      -cpu 24Kf \
      -machine malta \
      -kernel vmlinux \
      -initrd rootfs.cpio \
      -m 512m \
      -serial mon:stdio
  ...
  Linux version 6.4.0-rc6-next-20230614 (nathan@dev-arch.thelio-3990X) (mips-linux-gcc (GCC) 13.1.0, GNU ld (GNU Binutils) 2.40) #1 SMP Wed Jun 14 16:13:02 MST 2023
  ...
  Run /init as init process
  process '/bin/busybox' started with executable stack
  do_page_fault(): sending SIGSEGV to init for invalid read access from 0000003c
  epc = 77b893dc in ld-uClibc-1.0.39.so[77b84000+8000]
  ra  = 77b8930c in ld-uClibc-1.0.39.so[77b84000+8000]
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
  ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

The rootfs is available at [2] if it is needed. I am more than happy to
provide additional information or test patches if necessary.

[1]: https://mirrors.edge.kernel.org/pub/tools/crosstool/
[2]: https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230609-194440/mipsel-rootfs.cpio.zst

Cheers,
Nathan
