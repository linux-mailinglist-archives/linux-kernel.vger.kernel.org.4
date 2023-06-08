Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500707279E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjFHI0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFHI0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:26:09 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D149E43
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:26:05 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51E5224000E;
        Thu,  8 Jun 2023 08:26:00 +0000 (UTC)
Message-ID: <dfd776cb-1ee4-3967-8f56-9cffa4742923@ghiti.fr>
Date:   Thu, 8 Jun 2023 10:25:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] riscv: mm: Pre-allocate PGD entries for
 vmalloc/modules area
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@rivosinc.com, Alexandre Ghiti <alexghiti@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20230531093817.665799-1-bjorn@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230531093817.665799-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Björn,

On 31/05/2023 11:38, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> The RISC-V port requires that kernel PGD entries are to be
> synchronized between MMs. This is done via the vmalloc_fault()
> function, that simply copies the PGD entries from init_mm to the
> faulting one.
>
> Historically, faulting in PGD entries have been a source for both bugs
> [1], and poor performance.
>
> One way to get rid of vmalloc faults is by pre-allocating the PGD
> entries. Pre-allocating the entries potientially wastes 64 * 4K (65 on
> SV39). The pre-allocation function is pulled from Jörg Rödel's x86
> work, with the addition of 3-level page tables (PMD allocations).
>
> The pmd_alloc() function needs the ptlock cache to be initialized
> (when split page locks is enabled), so the pre-allocation is done in a
> RISC-V specific pgtable_cache_init() implementation.
>
> Pre-allocate the kernel PGD entries for the vmalloc/modules area, but
> only for 64b platforms.
>
> Link: https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.org/ # [1]
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
> v1->v2: Fixed broken !MMU build.
> ---
> arch/riscv/mm/fault.c | 16 ++----------
>   arch/riscv/mm/init.c  | 58 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 60 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 8685f85a7474..b023fb311e28 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -238,24 +238,12 @@ void handle_page_fault(struct pt_regs *regs)
>   	 * only copy the information from the master page table,
>   	 * nothing more.
>   	 */
> -	if (unlikely((addr >= VMALLOC_START) && (addr < VMALLOC_END))) {
> +	if ((!IS_ENABLED(CONFIG_MMU) || !IS_ENABLED(CONFIG_64BIT)) &&
> +	    unlikely(addr >= VMALLOC_START && addr < VMALLOC_END)) {
>   		vmalloc_fault(regs, code, addr);
>   		return;
>   	}
>   
> -#ifdef CONFIG_64BIT
> -	/*
> -	 * Modules in 64bit kernels lie in their own virtual region which is not
> -	 * in the vmalloc region, but dealing with page faults in this region
> -	 * or the vmalloc region amounts to doing the same thing: checking that
> -	 * the mapping exists in init_mm.pgd and updating user page table, so
> -	 * just use vmalloc_fault.
> -	 */
> -	if (unlikely(addr >= MODULES_VADDR && addr < MODULES_END)) {
> -		vmalloc_fault(regs, code, addr);
> -		return;
> -	}
> -#endif
>   	/* Enable interrupts if they were enabled in the parent context. */
>   	if (!regs_irqs_disabled(regs))
>   		local_irq_enable();
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 747e5b1ef02d..45ceaff5679e 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1363,3 +1363,61 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>   	return vmemmap_populate_basepages(start, end, node, NULL);
>   }
>   #endif
> +
> +#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> +/*
> + * Pre-allocates page-table pages for a specific area in the kernel
> + * page-table. Only the level which needs to be synchronized between
> + * all page-tables is allocated because the synchronization can be
> + * expensive.
> + */
> +static void __init preallocate_pgd_pages_range(unsigned long start, unsigned long end,
> +					       const char *area)
> +{
> +	unsigned long addr;
> +	const char *lvl;
> +
> +	for (addr = start; addr < end && addr >= start; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
> +		pgd_t *pgd = pgd_offset_k(addr);
> +		p4d_t *p4d;
> +		pud_t *pud;
> +		pmd_t *pmd;
> +
> +		lvl = "p4d";
> +		p4d = p4d_alloc(&init_mm, pgd, addr);
> +		if (!p4d)
> +			goto failed;
> +
> +		if (pgtable_l5_enabled)
> +			continue;
> +
> +		lvl = "pud";
> +		pud = pud_alloc(&init_mm, p4d, addr);
> +		if (!pud)
> +			goto failed;
> +
> +		if (pgtable_l4_enabled)
> +			continue;
> +
> +		lvl = "pmd";
> +		pmd = pmd_alloc(&init_mm, pud, addr);
> +		if (!pmd)
> +			goto failed;
> +	}
> +	return;
> +
> +failed:
> +	/*
> +	 * The pages have to be there now or they will be missing in
> +	 * process page-tables later.
> +	 */
> +	panic("Failed to pre-allocate %s pages for %s area\n", lvl, area);
> +}
> +
> +void __init pgtable_cache_init(void)
> +{
> +	preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc");
> +	if (IS_ENABLED(CONFIG_MODULES))
> +		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
> +}
> +#endif
>
> base-commit: ac9a78681b921877518763ba0e89202254349d1b


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Alex

