Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139D46BA70D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCOF1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjCOF1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:27:02 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D67657D09
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 22:26:02 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id p20so18838938plw.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 22:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678857824;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjKy7C3/cQxzvvNhh8JYH9DRhvpc3Xb8Ck3BTbP4FIw=;
        b=NjtkBsAXpQlDU4BGX/gYRlZbgHpWpvX3bkRRTtqVjyc8H8Z5BdxENl4cGILMwU9+l7
         6eh5ijqlaXpCMC1g0SgufHGBr9ypr1GR8LET17oDgHNNThI/Sa5eHSJN3Ak3P5x/MSxF
         LKfQewvHVw2h8T74FL0iIOQqgpfVsw+vPMI2LpYPjJHhUd1kqA1fO/wYlxD442bZuy77
         CIyUcwiP00DwhBwe3fYHarJbpJwNVQjtF5SqlgyfpYiyOh9sK/LTyWFaEjPvC8VdC0RZ
         TJ/QZPkfKFKG/BGoXCCul1VsknFsIw/iQ7lvOYXrcjcqezvHS47WEz3Exy1EJ//nQxXS
         U4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678857824;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjKy7C3/cQxzvvNhh8JYH9DRhvpc3Xb8Ck3BTbP4FIw=;
        b=GoIrSOSHoBvHL67tG3l5kWW44lB4tTYxue2WxfApRM2zk+yqFkj0hCRmXeSnU77hR2
         fwJuPkqN5ZH8BrEHqRRVIQnryOf+uV9c8OP9PgMdbRhHVlyrRQnHekZthb74Vl+F43qQ
         45nH3UWabkZh785Gimd3Taj0EBL8vztEIbcbKgDyQMJT+46FGK8HkjhsoMeU5u82gtzk
         pUEg2KeZhT0IbiOjgvCRw4Y8jdiZvSfm6/FNYt1hSdDpqEt/gE7IgH3k4oJajNhvJAqx
         e83woxiAEG47bGPAkrFA16pc7MjGty/sViAfQSFjQwBuBltM34QiRVYb0hOBG1/Z1MDy
         hojQ==
X-Gm-Message-State: AO0yUKV+NSkp8Wdm8Vy0dILm15HxTrM+HL7h9RxskilU2iQUiCBDrvAO
        QIRIi45JJ7dnsBbaMp6QV5LkCT+1GoIQTfH4npQ=
X-Google-Smtp-Source: AK7set/bva9pNCCVEG6ntKH5jwV71fM4HOjl4X0hHTrQaY1lziKShXYFg9iT0LR1BwYfjme5MnxaWg==
X-Received: by 2002:a17:90b:1e42:b0:235:b712:4179 with SMTP id pi2-20020a17090b1e4200b00235b7124179mr39010890pjb.5.1678857823683;
        Tue, 14 Mar 2023 22:23:43 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090a015600b00234899c65e7sm392170pje.28.2023.03.14.22.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 22:23:43 -0700 (PDT)
Date:   Tue, 14 Mar 2023 22:23:43 -0700 (PDT)
X-Google-Original-Date: Tue, 14 Mar 2023 22:22:49 PDT (-0700)
Subject:     Re: [PATCH v3 20/34] riscv: Implement the new page table range API
In-Reply-To: <20230228213738.272178-21-willy@infradead.org>
CC:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     willy@infradead.org
Message-ID: <mhng-21d3fe96-715e-49c4-aec0-2ee4e91b462d@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 13:37:23 PST (-0800), willy@infradead.org wrote:
> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> Change the PG_dcache_clean flag from being per-page to per-folio.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/include/asm/cacheflush.h | 19 +++++++++----------
>  arch/riscv/include/asm/pgtable.h    | 26 +++++++++++++++++++-------
>  arch/riscv/mm/cacheflush.c          | 11 ++---------
>  3 files changed, 30 insertions(+), 26 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 03e3b95ae6da..10e5e96f09b5 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -15,20 +15,19 @@ static inline void local_flush_icache_all(void)
>
>  #define PG_dcache_clean PG_arch_1
>
> -static inline void flush_dcache_page(struct page *page)
> +static inline void flush_dcache_folio(struct folio *folio)
>  {
> -	/*
> -	 * HugeTLB pages are always fully mapped and only head page will be
> -	 * set PG_dcache_clean (see comments in flush_icache_pte()).
> -	 */
> -	if (PageHuge(page))
> -		page = compound_head(page);
> -
> -	if (test_bit(PG_dcache_clean, &page->flags))
> -		clear_bit(PG_dcache_clean, &page->flags);
> +	if (test_bit(PG_dcache_clean, &folio->flags))
> +		clear_bit(PG_dcache_clean, &folio->flags);
>  }
> +#define flush_dcache_folio flush_dcache_folio
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>
> +static inline void flush_dcache_page(struct page *page)
> +{
> +	flush_dcache_folio(page_folio(page));
> +}
> +
>  /*
>   * RISC-V doesn't have an instruction to flush parts of the instruction cache,
>   * so instead we just flush the whole thing.
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index b516f3b59616..3a3a776fc047 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -405,8 +405,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>
>
>  /* Commit new configuration to MMU hardware */
> -static inline void update_mmu_cache(struct vm_area_struct *vma,
> -	unsigned long address, pte_t *ptep)
> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
> +		unsigned long address, pte_t *ptep, unsigned int nr)
>  {
>  	/*
>  	 * The kernel assumes that TLBs don't cache invalid entries, but
> @@ -415,8 +415,11 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  	 * Relying on flush_tlb_fix_spurious_fault would suffice, but
>  	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
>  	 */
> -	local_flush_tlb_page(address);
> +	while (nr--)
> +		local_flush_tlb_page(address + nr * PAGE_SIZE);
>  }
> +#define update_mmu_cache(vma, addr, ptep) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
>
>  #define __HAVE_ARCH_UPDATE_MMU_TLB
>  #define update_mmu_tlb update_mmu_cache
> @@ -456,12 +459,21 @@ static inline void __set_pte_at(struct mm_struct *mm,
>  	set_pte(ptep, pteval);
>  }
>
> -static inline void set_pte_at(struct mm_struct *mm,
> -	unsigned long addr, pte_t *ptep, pte_t pteval)
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pteval, unsigned int nr)
>  {
> -	page_table_check_ptes_set(mm, addr, ptep, pteval, 1);
> -	__set_pte_at(mm, addr, ptep, pteval);
> +	page_table_check_ptes_set(mm, addr, ptep, pteval, nr);
> +
> +	for (;;) {
> +		__set_pte_at(mm, addr, ptep, pteval);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		addr += PAGE_SIZE;
> +		pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
> +	}
>  }
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
>
>  static inline void pte_clear(struct mm_struct *mm,
>  	unsigned long addr, pte_t *ptep)
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index fcd6145fbead..e36a851e5788 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -81,16 +81,9 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>  #ifdef CONFIG_MMU
>  void flush_icache_pte(pte_t pte)
>  {
> -	struct page *page = pte_page(pte);
> +	struct folio *folio = page_folio(pte_page(pte));
>
> -	/*
> -	 * HugeTLB pages are always fully mapped, so only setting head page's
> -	 * PG_dcache_clean flag is enough.
> -	 */
> -	if (PageHuge(page))
> -		page = compound_head(page);
> -
> -	if (!test_bit(PG_dcache_clean, &page->flags)) {
> +	if (!test_bit(PG_dcache_clean, &folio->flags)) {
>  		flush_icache_all();
>  		set_bit(PG_dcache_clean, &page->flags);
>  	}

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
