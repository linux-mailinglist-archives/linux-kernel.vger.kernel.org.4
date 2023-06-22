Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E71373A482
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFVPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjFVPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:13:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFA51FC6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:13:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3595043b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687446781; x=1690038781;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWoBwn7kjOnWJ8cQ9OaXHQdl/aiQSmn14uD4PvCcxzE=;
        b=axk7hiernNQEvMLwxW/t+q32Dq3MztflbNUfqGg7S6uuw1pdYSv8doPGQ64t/whnp3
         uMr5j+8BIjchom/j29y9Sg2eiX8wGvZdnVgLCzDR4Y+OXsgP3id6WKhbVxma5hcEzB5c
         Mj9EuCPKAOpOr7losO/cP1Xbuz3lhqFSL22rr5jj2Iyl8XV4pzYzeR93fV9tQHh9nmOg
         vB7p6+Cbxc8WdFOVYePavlSSPfr9HUHsuRItTJvNJZnZf4HhBlPd38ZfAHbNfHnpvleY
         4jaO8Bm2Px9NCVkgGdb4C5PyuBeoPGW5a2n/zWajMiDxFjqFLmnxVfmoYUEWdSlmkNbE
         50Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446781; x=1690038781;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWoBwn7kjOnWJ8cQ9OaXHQdl/aiQSmn14uD4PvCcxzE=;
        b=BjuSr6AMzFLpWfyWuRoXi3aNaCVp5M5S5v3XgG7inhpYtUHBBE5Wve6Ha4EtLxwPni
         QMg3+6t+BPsqqJ64bpLxDyorQ7HDkGKeAQoDmcSqpifH6hbvrjcTQyIibKuNFGdd8tN0
         5G48xy+VFmSkB69OWkFDQCGIjWJ6yrqlMQfPbitcD4Lre4tfbiOkp6+sVcfMCUqmnlFi
         F7/XKM7xsKQD6A9mXsGfevqzJKqV9cAIPR4AsUtQfe7mCy17OjQwuvLaQgFZBIS8hdy8
         5BgAIpYQm0hvSoBOv3ZwRr/+78kvi4EMDp9ZE1Dz+oMHzfQYtiY6+CRtC1kSccoyHguA
         ckPQ==
X-Gm-Message-State: AC+VfDzy6l0EtKIzX+XVl2J77nimfohqYkAYrAGnpCnkRRm8JkFV3zlV
        ztDGBWS/QwvEKa/NJxMcyScs4g==
X-Google-Smtp-Source: ACHHUZ5Euxbr2zsl3BHypE18SGhVZ6f/GRnCEfjFokRyYC8Tkc1YmWl2e6vmy6euSiXkRS8u6rgLcg==
X-Received: by 2002:a05:6a20:8f0f:b0:ff:f3d9:1ada with SMTP id b15-20020a056a208f0f00b000fff3d91adamr15056171pzk.60.1687446781174;
        Thu, 22 Jun 2023 08:13:01 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a3-20020a62bd03000000b00669c99d05fasm4044964pff.150.2023.06.22.08.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:13:00 -0700 (PDT)
Date:   Thu, 22 Jun 2023 08:13:00 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Jun 2023 08:12:01 PDT (-0700)
Subject:     Re: [PATCH] riscv: mm: Pre-allocate PGD entries vmalloc/modules area
In-Reply-To: <20230529180023.289904-1-bjorn@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, Bjorn Topel <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@rivosinc.com, alexghiti@rivosinc.com, joro@8bytes.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bjorn@kernel.org
Message-ID: <mhng-fc6025e7-ff1b-46e2-86a5-f74a3db74bd2@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 11:00:23 PDT (-0700), bjorn@kernel.org wrote:
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
>  arch/riscv/mm/fault.c | 20 +++------------
>  arch/riscv/mm/init.c  | 58 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 16 deletions(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 8685f85a7474..6b0b5e517e12 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -230,32 +230,20 @@ void handle_page_fault(struct pt_regs *regs)
>  		return;
>
>  	/*
> -	 * Fault-in kernel-space virtual memory on-demand.
> -	 * The 'reference' page table is init_mm.pgd.
> +	 * Fault-in kernel-space virtual memory on-demand, for 32-bit
> +	 * architectures.  The 'reference' page table is init_mm.pgd.

That wording seems a little odd to me: I think English allows for these 
"add something after the comma to change the meaning of a sentence" 
things, but they're kind of complicated.  Maybe it's easier to just flip 
the order?

That said, it's very early so maybe it's fine...

>  	 *
>  	 * NOTE! We MUST NOT take any locks for this case. We may
>  	 * be in an interrupt or a critical region, and should
>  	 * only copy the information from the master page table,
>  	 * nothing more.
>  	 */
> -	if (unlikely((addr >= VMALLOC_START) && (addr < VMALLOC_END))) {
> +	if (!IS_ENABLED(CONFIG_64BIT) &&
> +	    unlikely(addr >= VMALLOC_START && addr < VMALLOC_END)) {
>  		vmalloc_fault(regs, code, addr);
>  		return;
>  	}
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
>  	/* Enable interrupts if they were enabled in the parent context. */
>  	if (!regs_irqs_disabled(regs))
>  		local_irq_enable();
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 747e5b1ef02d..38bd4dd95276 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1363,3 +1363,61 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  	return vmemmap_populate_basepages(start, end, node, NULL);
>  }
>  #endif
> +
> +#ifdef CONFIG_64BIT
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

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

aside from the build issue, which seems pretty straight-forward.  I'm 
going to drop this from patchwork.
