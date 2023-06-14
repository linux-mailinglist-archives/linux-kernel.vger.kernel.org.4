Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225C723478
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjFFB23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFFB21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:28:27 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3809B98;
        Mon,  5 Jun 2023 18:28:24 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8AxyvG2i35kM0kAAA--.1189S3;
        Tue, 06 Jun 2023 09:28:22 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx+OS0i35kSYgBAA--.7012S3;
        Tue, 06 Jun 2023 09:28:21 +0800 (CST)
Message-ID: <122e2a2c-8bdd-a71b-973f-954cd47d48e7@loongson.cn>
Date:   Tue, 6 Jun 2023 09:28:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v12 19/31] LoongArch: KVM: Implement kvm mmu operations
Content-Language: en-US
To:     Tianrui Zhao <zhaotianrui@loongson.cn>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Xi Ruoyao <xry111@xry111.site>
References: <20230530015223.147755-1-zhaotianrui@loongson.cn>
 <20230530015223.147755-20-zhaotianrui@loongson.cn>
From:   "bibo, mao" <maobibo@loongson.cn>
In-Reply-To: <20230530015223.147755-20-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx+OS0i35kSYgBAA--.7012S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfWFW7trWfGr17Kr15Xry3KFX_yoW8uryDGo
        WfGr4a9r4rAw1UAFyFkryUtFWjv3ykK397ArZIyrsxXFWIy345Ar97Kws5AFy8Kr1rKF93
        Z3s7Ww4SqFZ3t3Zxl-sFpf9Il3svdjkaLaAFLSUrUUUUeb8apTn2vfkv8UJUUUU8wcxFpf
        9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
        UjIYCTnIWjp_UUUO17kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
        8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
        WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUU
        U==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/30 09:52, Tianrui Zhao 写道:
> Implement LoongArch kvm mmu, it is used to switch gpa to hpa when
> guest exit because of address translation exception. This patch
> implement allocate gpa page table, search gpa from it and flush guest
> gpa in the table.
> 
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> ---
>  arch/loongarch/kvm/mmu.c | 729 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 729 insertions(+)
>  create mode 100644 arch/loongarch/kvm/mmu.c
> 
> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> new file mode 100644
> index 000000000000..d2e31be65e30
> --- /dev/null
> +++ b/arch/loongarch/kvm/mmu.c
> @@ -0,0 +1,729 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/highmem.h>
> +#include <linux/page-flags.h>
> +#include <linux/kvm_host.h>
> +#include <linux/uaccess.h>
> +#include <asm/mmu_context.h>
> +#include <asm/pgalloc.h>
> +#include <asm/tlb.h>
> +
> +/*
> + * KVM_MMU_CACHE_MIN_PAGES is the number of GPA page table translation levels
> + * for which pages need to be cached.
> + */
> +#if defined(__PAGETABLE_PMD_FOLDED)
> +#define KVM_MMU_CACHE_MIN_PAGES 1
> +#else
> +#define KVM_MMU_CACHE_MIN_PAGES 2
> +#endif
since pgd page is allocated when vm is created, pud/pmd/pte is not allocted.
How about use this? It is ok for both 4K and 16K page size.
#define  KVM_MMU_CACHE_MIN_PAGES (CONFIG_PGTABLE_LEVELS - 1)

Otherwise look good to me.

Reviewed-by: Bibo, Mao <maobibo@loongson.cn>

> +
> +/**
> + * kvm_pgd_alloc() - Allocate and initialise a KVM GPA page directory.
> + *
> + * Allocate a blank KVM GPA page directory (PGD) for representing guest physical
> + * to host physical page mappings.
> + *
> + * Returns:	Pointer to new KVM GPA page directory.
> + *		NULL on allocation failure.
> + */
> +pgd_t *kvm_pgd_alloc(void)
> +{
> +	pgd_t *pgd;
> +
> +	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, 0);
> +	if (pgd)
> +		pgd_init((void *)pgd);
> +
> +	return pgd;
> +}
> +
> +/**
> + * kvm_walk_pgd() - Walk page table with optional allocation.
> + * @pgd:	Page directory pointer.
> + * @addr:	Address to index page table using.
> + * @cache:	MMU page cache to allocate new page tables from, or NULL.
> + *
> + * Walk the page tables pointed to by @pgd to find the PTE corresponding to the
> + * address @addr. If page tables don't exist for @addr, they will be created
> + * from the MMU cache if @cache is not NULL.
> + *
> + * Returns:	Pointer to pte_t corresponding to @addr.
> + *		NULL if a page table doesn't exist for @addr and !@cache.
> + *		NULL if a page table allocation failed.
> + */
> +static pte_t *kvm_walk_pgd(pgd_t *pgd, struct kvm_mmu_memory_cache *cache,
> +				unsigned long addr)
> +{
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	pgd += pgd_index(addr);
> +	if (pgd_none(*pgd)) {
> +		/* Not used yet */
> +		BUG();
> +		return NULL;
> +	}
> +	p4d = p4d_offset(pgd, addr);
> +	pud = pud_offset(p4d, addr);
> +	if (pud_none(*pud)) {
> +		pmd_t *new_pmd;
> +
> +		if (!cache)
> +			return NULL;
> +		new_pmd = kvm_mmu_memory_cache_alloc(cache);
> +		pmd_init((void *)new_pmd);
> +		pud_populate(NULL, pud, new_pmd);
> +	}
> +	pmd = pmd_offset(pud, addr);
> +	if (pmd_none(*pmd)) {
> +		pte_t *new_pte;
> +
> +		if (!cache)
> +			return NULL;
> +		new_pte = kvm_mmu_memory_cache_alloc(cache);
> +		clear_page(new_pte);
> +		pmd_populate_kernel(NULL, pmd, new_pte);
> +	}
> +	return pte_offset_kernel(pmd, addr);
> +}
> +
> +/* Caller must hold kvm->mm_lock */
> +static pte_t *kvm_pte_for_gpa(struct kvm *kvm,
> +				struct kvm_mmu_memory_cache *cache,
> +				unsigned long addr)
> +{
> +	return kvm_walk_pgd(kvm->arch.gpa_mm.pgd, cache, addr);
> +}
> +
> +/*
> + * level2_flush_{pte,pmd,pud,pgd,pt}.
> + * Flush a range of guest physical address space from the VM's GPA page tables.
> + */
> +static int level2_flush_pte(pmd_t *pmd, unsigned long addr, unsigned long end)
> +{
> +	pte_t *pte;
> +	unsigned long next, start;
> +	int ret;
> +
> +	ret = 0;
> +	start = addr;
> +	pte = pte_offset_kernel(pmd, addr);
> +	do {
> +		next = addr + PAGE_SIZE;
> +		if (!pte_present(*pte))
> +			continue;
> +
> +		set_pte(pte, __pte(0));
> +		ret = 1;
> +	} while (pte++, addr = next, addr != end);
> +
> +	if (start + PMD_SIZE == end) {
> +		pte = pte_offset_kernel(pmd, 0);
> +		pmd_clear(pmd);
> +		pte_free_kernel(NULL, pte);
> +	}
> +	return ret;
> +}
> +
> +static int level2_flush_pmd(pud_t *pud, unsigned long addr, unsigned long end)
> +{
> +	pmd_t *pmd;
> +	unsigned long next, start;
> +	int ret;
> +
> +	ret = 0;
> +	start = addr;
> +	pmd = pmd_offset(pud, addr);
> +	do {
> +		next = pmd_addr_end(addr, end);
> +		if (!pmd_present(*pmd))
> +			continue;
> +
> +		ret |= level2_flush_pte(pmd, addr, next);
> +	} while (pmd++, addr = next, addr != end);
> +
> +	if (start + PUD_SIZE == end) {
> +		pmd = pmd_offset(pud, 0);
> +		pud_clear(pud);
> +		pmd_free(NULL, pmd);
> +	}
> +	return ret;
> +}
> +
> +static int level2_flush_pud(pgd_t *pgd, unsigned long addr, unsigned long end)
> +{
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	unsigned long next, start;
> +	int ret;
> +
> +	ret = 0;
> +	start = addr;
> +	p4d = p4d_offset(pgd, addr);
> +	pud = pud_offset(p4d, addr);
> +	do {
> +		next = pud_addr_end(addr, end);
> +		if (!pud_present(*pud))
> +			continue;
> +
> +		ret |= level2_flush_pmd(pud, addr, next);
> +	} while (pud++, addr = next, addr != end);
> +
> +	if (start + PGDIR_SIZE == end) {
> +		pud = pud_offset(p4d, 0);
> +		pgd_clear(pgd);
> +		pud_free(NULL, pud);
> +	}
> +	return ret;
> +}
> +
> +static int level2_flush_pgd(pgd_t *pgd, unsigned long addr, unsigned long end)
> +{
> +	unsigned long next;
> +	int ret;
> +
> +	ret = 0;
> +	if (addr > end - 1)
> +		return ret;
> +	pgd = pgd + pgd_index(addr);
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (!pgd_present(*pgd))
> +			continue;
> +
> +		ret |= level2_flush_pud(pgd, addr, next);
> +	}  while (pgd++, addr = next, addr != end);
> +
> +	return ret;
> +}
> +
> +/**
> + * level2_flush_range() - Flush a range of guest physical addresses.
> + * @kvm:	KVM pointer.
> + * @start_gfn:	Guest frame number of first page in GPA range to flush.
> + * @end_gfn:	Guest frame number of last page in GPA range to flush.
> + *
> + * Flushes a range of GPA mappings from the GPA page tables.
> + *
> + * The caller must hold the @kvm->mmu_lock spinlock.
> + *
> + * Returns:	Whether its safe to remove the top level page directory because
> + *		all lower levels have been removed.
> + */
> +static bool level2_flush_range(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
> +{
> +	return level2_flush_pgd(kvm->arch.gpa_mm.pgd, start_gfn << PAGE_SHIFT,
> +				end_gfn << PAGE_SHIFT);
> +}
> +
> +typedef int (*level2_pte_ops)(void *pte);
> +/*
> + * level2_mkclean_pte
> + * Mark a range of guest physical address space clean (writes fault) in the VM's
> + * GPA page table to allow dirty page tracking.
> + */
> +static int level2_mkclean_pte(void *pte)
> +{
> +	pte_t val;
> +
> +	val = *(pte_t *)pte;
> +	if (pte_dirty(val)) {
> +		*(pte_t *)pte = pte_mkclean(val);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static int level2_ptw_pte(pmd_t *pmd, unsigned long addr, unsigned long end,
> +			level2_pte_ops func)
> +{
> +	pte_t *pte;
> +	unsigned long next;
> +	int ret;
> +
> +	ret = 0;
> +	pte = pte_offset_kernel(pmd, addr);
> +	do {
> +		next = addr + PAGE_SIZE;
> +		if (!pte_present(*pte))
> +			continue;
> +
> +		ret |= func(pte);
> +	} while (pte++, addr = next, addr != end);
> +
> +	return ret;
> +}
> +
> +static int level2_ptw_pmd(pud_t *pud, unsigned long addr, unsigned long end,
> +			level2_pte_ops func)
> +{
> +	pmd_t *pmd;
> +	unsigned long next;
> +	int ret;
> +
> +	ret = 0;
> +	pmd = pmd_offset(pud, addr);
> +	do {
> +		next = pmd_addr_end(addr, end);
> +		if (!pmd_present(*pmd))
> +			continue;
> +
> +		ret |= level2_ptw_pte(pmd, addr, next, func);
> +	} while (pmd++, addr = next, addr != end);
> +
> +	return ret;
> +}
> +
> +static int level2_ptw_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
> +			level2_pte_ops func)
> +{
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	unsigned long next;
> +	int ret;
> +
> +	ret = 0;
> +	p4d = p4d_offset(pgd, addr);
> +	pud = pud_offset(p4d, addr);
> +	do {
> +		next = pud_addr_end(addr, end);
> +		if (!pud_present(*pud))
> +			continue;
> +
> +		ret |= level2_ptw_pmd(pud, addr, next, func);
> +	} while (pud++, addr = next, addr != end);
> +
> +	return ret;
> +}
> +
> +static int level2_ptw_pgd(pgd_t *pgd, unsigned long addr, unsigned long end,
> +			level2_pte_ops func)
> +{
> +	unsigned long next;
> +	int ret;
> +
> +	ret = 0;
> +	if (addr > end - 1)
> +		return ret;
> +	pgd = pgd + pgd_index(addr);
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (!pgd_present(*pgd))
> +			continue;
> +
> +		ret |= level2_ptw_pud(pgd, addr, next, func);
> +	}  while (pgd++, addr = next, addr != end);
> +
> +	return ret;
> +}
> +
> +/*
> + * kvm_mkclean_gpa_pt() - Make a range of guest physical addresses clean.
> + * @kvm:	KVM pointer.
> + * @start_gfn:	Guest frame number of first page in GPA range to flush.
> + * @end_gfn:	Guest frame number of last page in GPA range to flush.
> + *
> + * Make a range of GPA mappings clean so that guest writes will fault and
> + * trigger dirty page logging.
> + *
> + * The caller must hold the @kvm->mmu_lock spinlock.
> + *
> + * Returns:	Whether any GPA mappings were modified, which would require
> + *		derived mappings (GVA page tables & TLB enties) to be
> + *		invalidated.
> + */
> +static int kvm_mkclean_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
> +{
> +	return level2_ptw_pgd(kvm->arch.gpa_mm.pgd, start_gfn << PAGE_SHIFT,
> +				end_gfn << PAGE_SHIFT, level2_mkclean_pte);
> +}
> +
> +/*
> + * kvm_arch_mmu_enable_log_dirty_pt_masked() - write protect dirty pages
> + * @kvm:	The KVM pointer
> + * @slot:	The memory slot associated with mask
> + * @gfn_offset:	The gfn offset in memory slot
> + * @mask:	The mask of dirty pages at offset 'gfn_offset' in this memory
> + *		slot to be write protected
> + *
> + * Walks bits set in mask write protects the associated pte's. Caller must
> + * acquire @kvm->mmu_lock.
> + */
> +void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
> +		struct kvm_memory_slot *slot,
> +		gfn_t gfn_offset, unsigned long mask)
> +{
> +	gfn_t base_gfn = slot->base_gfn + gfn_offset;
> +	gfn_t start = base_gfn +  __ffs(mask);
> +	gfn_t end = base_gfn + __fls(mask) + 1;
> +
> +	kvm_mkclean_gpa_pt(kvm, start, end);
> +}
> +
> +void kvm_arch_commit_memory_region(struct kvm *kvm,
> +				   struct kvm_memory_slot *old,
> +				   const struct kvm_memory_slot *new,
> +				   enum kvm_mr_change change)
> +{
> +	int needs_flush;
> +
> +	/*
> +	 * If dirty page logging is enabled, write protect all pages in the slot
> +	 * ready for dirty logging.
> +	 *
> +	 * There is no need to do this in any of the following cases:
> +	 * CREATE:	No dirty mappings will already exist.
> +	 * MOVE/DELETE:	The old mappings will already have been cleaned up by
> +	 *		kvm_arch_flush_shadow_memslot()
> +	 */
> +	if (change == KVM_MR_FLAGS_ONLY &&
> +	    (!(old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
> +	     new->flags & KVM_MEM_LOG_DIRTY_PAGES)) {
> +		spin_lock(&kvm->mmu_lock);
> +		/* Write protect GPA page table entries */
> +		needs_flush = kvm_mkclean_gpa_pt(kvm, new->base_gfn,
> +					new->base_gfn + new->npages);
> +		if (needs_flush)
> +			kvm_flush_remote_tlbs(kvm);
> +		spin_unlock(&kvm->mmu_lock);
> +	}
> +}
> +
> +void kvm_arch_flush_shadow_all(struct kvm *kvm)
> +{
> +	/* Flush whole GPA */
> +	level2_flush_range(kvm, 0, kvm->arch.gpa_size >> PAGE_SHIFT);
> +	/* Flush vpid for each vCPU individually */
> +	kvm_flush_remote_tlbs(kvm);
> +}
> +
> +void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
> +		struct kvm_memory_slot *slot)
> +{
> +	int ret;
> +
> +	/*
> +	 * The slot has been made invalid (ready for moving or deletion), so we
> +	 * need to ensure that it can no longer be accessed by any guest vCPUs.
> +	 */
> +	spin_lock(&kvm->mmu_lock);
> +	/* Flush slot from GPA */
> +	ret = level2_flush_range(kvm, slot->base_gfn,
> +			slot->base_gfn + slot->npages);
> +	/* Let implementation do the rest */
> +	if (ret)
> +		kvm_flush_remote_tlbs(kvm);
> +	spin_unlock(&kvm->mmu_lock);
> +}
> +
> +void _kvm_destroy_mm(struct kvm *kvm)
> +{
> +	/* It should always be safe to remove after flushing the whole range */
> +	level2_flush_range(kvm, 0, kvm->arch.gpa_size >> PAGE_SHIFT);
> +	pgd_free(NULL, kvm->arch.gpa_mm.pgd);
> +	kvm->arch.gpa_mm.pgd = NULL;
> +}
> +
> +/*
> + * Mark a range of guest physical address space old (all accesses fault) in the
> + * VM's GPA page table to allow detection of commonly used pages.
> + */
> +static int level2_mkold_pte(void *pte)
> +{
> +	pte_t val;
> +
> +	val = *(pte_t *)pte;
> +	if (pte_young(val)) {
> +		*(pte_t *)pte = pte_mkold(val);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	return level2_flush_range(kvm, range->start, range->end);
> +}
> +
> +bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	gpa_t gpa = range->start << PAGE_SHIFT;
> +	pte_t hva_pte = range->pte;
> +	pte_t *ptep = kvm_pte_for_gpa(kvm, NULL, gpa);
> +	pte_t old_pte;
> +
> +	if (!ptep)
> +		return false;
> +
> +	/* Mapping may need adjusting depending on memslot flags */
> +	old_pte = *ptep;
> +	if (range->slot->flags & KVM_MEM_LOG_DIRTY_PAGES && !pte_dirty(old_pte))
> +		hva_pte = pte_mkclean(hva_pte);
> +	else if (range->slot->flags & KVM_MEM_READONLY)
> +		hva_pte = pte_wrprotect(hva_pte);
> +
> +	set_pte(ptep, hva_pte);
> +
> +	/* Replacing an absent or old page doesn't need flushes */
> +	if (!pte_present(old_pte) || !pte_young(old_pte))
> +		return false;
> +
> +	/* Pages swapped, aged, moved, or cleaned require flushes */
> +	return !pte_present(hva_pte) ||
> +	       !pte_young(hva_pte) ||
> +	       pte_pfn(old_pte) != pte_pfn(hva_pte) ||
> +	       (pte_dirty(old_pte) && !pte_dirty(hva_pte));
> +}
> +
> +bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	return level2_ptw_pgd(kvm->arch.gpa_mm.pgd, range->start << PAGE_SHIFT,
> +				range->end << PAGE_SHIFT, level2_mkold_pte);
> +}
> +
> +bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	gpa_t gpa = range->start << PAGE_SHIFT;
> +	pte_t *ptep = kvm_pte_for_gpa(kvm, NULL, gpa);
> +
> +	if (ptep && pte_present(*ptep) && pte_young(*ptep))
> +		return true;
> +
> +	return false;
> +}
> +
> +/**
> + * kvm_map_page_fast() - Fast path GPA fault handler.
> + * @vcpu:		vCPU pointer.
> + * @gpa:		Guest physical address of fault.
> + * @write:	Whether the fault was due to a write.
> + *
> + * Perform fast path GPA fault handling, doing all that can be done without
> + * calling into KVM. This handles marking old pages young (for idle page
> + * tracking), and dirtying of clean pages (for dirty page logging).
> + *
> + * Returns:	0 on success, in which case we can update derived mappings and
> + *		resume guest execution.
> + *		-EFAULT on failure due to absent GPA mapping or write to
> + *		read-only page, in which case KVM must be consulted.
> + */
> +static int kvm_map_page_fast(struct kvm_vcpu *vcpu, unsigned long gpa,
> +				   bool write)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	gfn_t gfn = gpa >> PAGE_SHIFT;
> +	pte_t *ptep;
> +	kvm_pfn_t pfn = 0;
> +	bool pfn_valid = false;
> +	int ret = 0;
> +
> +	spin_lock(&kvm->mmu_lock);
> +
> +	/* Fast path - just check GPA page table for an existing entry */
> +	ptep = kvm_pte_for_gpa(kvm, NULL, gpa);
> +	if (!ptep || !pte_present(*ptep)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	/* Track access to pages marked old */
> +	if (!pte_young(*ptep)) {
> +		set_pte(ptep, pte_mkyoung(*ptep));
> +		pfn = pte_pfn(*ptep);
> +		pfn_valid = true;
> +		/* call kvm_set_pfn_accessed() after unlock */
> +	}
> +	if (write && !pte_dirty(*ptep)) {
> +		if (!pte_write(*ptep)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		/* Track dirtying of writeable pages */
> +		set_pte(ptep, pte_mkdirty(*ptep));
> +		pfn = pte_pfn(*ptep);
> +		mark_page_dirty(kvm, gfn);
> +		kvm_set_pfn_dirty(pfn);
> +	}
> +
> +out:
> +	spin_unlock(&kvm->mmu_lock);
> +	if (pfn_valid)
> +		kvm_set_pfn_accessed(pfn);
> +	return ret;
> +}
> +
> +/**
> + * kvm_map_page() - Map a guest physical page.
> + * @vcpu:		vCPU pointer.
> + * @gpa:		Guest physical address of fault.
> + * @write:	Whether the fault was due to a write.
> + *
> + * Handle GPA faults by creating a new GPA mapping (or updating an existing
> + * one).
> + *
> + * This takes care of marking pages young or dirty (idle/dirty page tracking),
> + * asking KVM for the corresponding PFN, and creating a mapping in the GPA page
> + * tables. Derived mappings (GVA page tables and TLBs) must be handled by the
> + * caller.
> + *
> + * Returns:	0 on success
> + *		-EFAULT if there is no memory region at @gpa or a write was
> + *		attempted to a read-only memory region. This is usually handled
> + *		as an MMIO access.
> + */
> +static int kvm_map_page(struct kvm_vcpu *vcpu, unsigned long gpa, bool write)
> +{
> +	bool writeable;
> +	int srcu_idx, err = 0, retry_no = 0;
> +	unsigned long hva;
> +	unsigned long mmu_seq;
> +	unsigned long prot_bits;
> +	pte_t *ptep, new_pte;
> +	kvm_pfn_t pfn;
> +	gfn_t gfn = gpa >> PAGE_SHIFT;
> +	struct vm_area_struct *vma;
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_memory_slot *memslot;
> +	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
> +
> +	/* Try the fast path to handle old / clean pages */
> +	srcu_idx = srcu_read_lock(&kvm->srcu);
> +	err = kvm_map_page_fast(vcpu, gpa, write);
> +	if (!err)
> +		goto out;
> +
> +	memslot = gfn_to_memslot(kvm, gfn);
> +	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writeable);
> +	if (kvm_is_error_hva(hva) || (write && !writeable))
> +		goto out;
> +
> +	mmap_read_lock(current->mm);
> +	vma = find_vma_intersection(current->mm, hva, hva + 1);
> +	if (unlikely(!vma)) {
> +		kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
> +		mmap_read_unlock(current->mm);
> +		err = -EFAULT;
> +		goto out;
> +	}
> +	mmap_read_unlock(current->mm);
> +
> +	/* We need a minimum of cached pages ready for page table creation */
> +	err = kvm_mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES);
> +	if (err)
> +		goto out;
> +
> +retry:
> +	/*
> +	 * Used to check for invalidations in progress, of the pfn that is
> +	 * returned by pfn_to_pfn_prot below.
> +	 */
> +	mmu_seq = kvm->mmu_invalidate_seq;
> +	/*
> +	 * Ensure the read of mmu_invalidate_seq isn't reordered with PTE reads in
> +	 * gfn_to_pfn_prot() (which calls get_user_pages()), so that we don't
> +	 * risk the page we get a reference to getting unmapped before we have a
> +	 * chance to grab the mmu_lock without mmu_invalidate_retry() noticing.
> +	 *
> +	 * This smp_rmb() pairs with the effective smp_wmb() of the combination
> +	 * of the pte_unmap_unlock() after the PTE is zapped, and the
> +	 * spin_lock() in kvm_mmu_invalidate_invalidate_<page|range_end>() before
> +	 * mmu_invalidate_seq is incremented.
> +	 */
> +	smp_rmb();
> +
> +	/* Slow path - ask KVM core whether we can access this GPA */
> +	pfn = gfn_to_pfn_prot(kvm, gfn, write, &writeable);
> +	if (is_error_noslot_pfn(pfn)) {
> +		err = -EFAULT;
> +		goto out;
> +	}
> +
> +	spin_lock(&kvm->mmu_lock);
> +	/* Check if an invalidation has taken place since we got pfn */
> +	if (mmu_invalidate_retry(kvm, mmu_seq)) {
> +		/*
> +		 * This can happen when mappings are changed asynchronously, but
> +		 * also synchronously if a COW is triggered by
> +		 * gfn_to_pfn_prot().
> +		 */
> +		spin_unlock(&kvm->mmu_lock);
> +		kvm_set_pfn_accessed(pfn);
> +		kvm_release_pfn_clean(pfn);
> +		if (retry_no > 100) {
> +			retry_no = 0;
> +			schedule();
> +		}
> +		retry_no++;
> +		goto retry;
> +	}
> +
> +	/*
> +	 * For emulated devices such virtio device, actual cache attribute is
> +	 * determined by physical machine.
> +	 * For pass through physical device, it should be uncachable
> +	 */
> +	prot_bits = _PAGE_PRESENT | __READABLE;
> +	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
> +		prot_bits |= _CACHE_SUC;
> +	else
> +		prot_bits |= _CACHE_CC;
> +
> +	if (writeable) {
> +		prot_bits |= _PAGE_WRITE;
> +		if (write) {
> +			prot_bits |= __WRITEABLE;
> +			mark_page_dirty(kvm, gfn);
> +			kvm_set_pfn_dirty(pfn);
> +		}
> +	}
> +
> +	/* Ensure page tables are allocated */
> +	ptep = kvm_pte_for_gpa(kvm, memcache, gpa);
> +	new_pte = pfn_pte(pfn, __pgprot(prot_bits));
> +	set_pte(ptep, new_pte);
> +
> +	err = 0;
> +	spin_unlock(&kvm->mmu_lock);
> +	kvm_release_pfn_clean(pfn);
> +	kvm_set_pfn_accessed(pfn);
> +out:
> +	srcu_read_unlock(&kvm->srcu, srcu_idx);
> +	return err;
> +}
> +
> +int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsigned long gpa, bool write)
> +{
> +	int ret;
> +
> +	ret = kvm_map_page(vcpu, gpa, write);
> +	if (ret)
> +		return ret;
> +
> +	/* Invalidate this entry in the TLB */
> +	return kvm_flush_tlb_gpa(vcpu, gpa);
> +}
> +
> +void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
> +{
> +
> +}
> +
> +int kvm_arch_prepare_memory_region(struct kvm *kvm,
> +				   const struct kvm_memory_slot *old,
> +				   struct kvm_memory_slot *new,
> +				   enum kvm_mr_change change)
> +{
> +	return 0;
> +}
> +
> +void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm,
> +					const struct kvm_memory_slot *memslot)
> +{
> +	kvm_flush_remote_tlbs(kvm);
> +}

