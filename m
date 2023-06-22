Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A0C73A561
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjFVPvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjFVPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F531713
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8947661883
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 15:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB95C433C0;
        Thu, 22 Jun 2023 15:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687449067;
        bh=ftFYZCWnNe/1OVuJN9ptS3sPWxiUyv3i1Sf1E+OY2zs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YTpZF9vanAWQwjMOQzJU/WjMuLpiRASXqFeUWGWfX2aC5Ppdqd3ZnBy+E05kJsfnR
         dJQRcEJGhBWfML+x09PEte1AUlygeXqL2qH99Hu0KUspFZLqkfcWN+kBznaFcdhRi3
         kuAMsSnv3eKMt/TRDhKrab/uKJnXQyXqYUcU/+tBU3XL0Y95UPUiHOSavyocIXJq8Y
         CTeCbHSDnOX5tPn5xU10CXSxfRuiJ1CSuaCWaORES9kItIUaQcxNMITuX4Oc6pPVk5
         pj8z7dacp018df0imB8ZTJF1wot9dTb0eTUHFkAyaNBmtfeanzxtGP+lFwXeYzPPao
         mPvM6c0BirCNA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, Bjorn Topel <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@rivosinc.com, alexghiti@rivosinc.com, joro@8bytes.org
Subject: Re: [PATCH] riscv: mm: Pre-allocate PGD entries vmalloc/modules area
In-Reply-To: <mhng-fc6025e7-ff1b-46e2-86a5-f74a3db74bd2@palmer-ri-x1c9a>
References: <mhng-fc6025e7-ff1b-46e2-86a5-f74a3db74bd2@palmer-ri-x1c9a>
Date:   Thu, 22 Jun 2023 17:51:03 +0200
Message-ID: <87ilbfjy1k.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> writes:

> On Mon, 29 May 2023 11:00:23 PDT (-0700), bjorn@kernel.org wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> The RISC-V port requires that kernel PGD entries are to be
>> synchronized between MMs. This is done via the vmalloc_fault()
>> function, that simply copies the PGD entries from init_mm to the
>> faulting one.
>>
>> Historically, faulting in PGD entries have been a source for both bugs
>> [1], and poor performance.
>>
>> One way to get rid of vmalloc faults is by pre-allocating the PGD
>> entries. Pre-allocating the entries potientially wastes 64 * 4K (65 on
>> SV39). The pre-allocation function is pulled from J=C3=B6rg R=C3=B6del's=
 x86
>> work, with the addition of 3-level page tables (PMD allocations).
>>
>> The pmd_alloc() function needs the ptlock cache to be initialized
>> (when split page locks is enabled), so the pre-allocation is done in a
>> RISC-V specific pgtable_cache_init() implementation.
>>
>> Pre-allocate the kernel PGD entries for the vmalloc/modules area, but
>> only for 64b platforms.
>>
>> Link: https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.or=
g/ # [1]
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/mm/fault.c | 20 +++------------
>>  arch/riscv/mm/init.c  | 58 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 62 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
>> index 8685f85a7474..6b0b5e517e12 100644
>> --- a/arch/riscv/mm/fault.c
>> +++ b/arch/riscv/mm/fault.c
>> @@ -230,32 +230,20 @@ void handle_page_fault(struct pt_regs *regs)
>>  		return;
>>
>>  	/*
>> -	 * Fault-in kernel-space virtual memory on-demand.
>> -	 * The 'reference' page table is init_mm.pgd.
>> +	 * Fault-in kernel-space virtual memory on-demand, for 32-bit
>> +	 * architectures.  The 'reference' page table is init_mm.pgd.
>
> That wording seems a little odd to me: I think English allows for these=20
> "add something after the comma to change the meaning of a sentence"=20
> things, but they're kind of complicated.  Maybe it's easier to just flip=
=20
> the order?
>
> That said, it's very early so maybe it's fine...
>
>>  	 *
>>  	 * NOTE! We MUST NOT take any locks for this case. We may
>>  	 * be in an interrupt or a critical region, and should
>>  	 * only copy the information from the master page table,
>>  	 * nothing more.
>>  	 */
>> -	if (unlikely((addr >=3D VMALLOC_START) && (addr < VMALLOC_END))) {
>> +	if (!IS_ENABLED(CONFIG_64BIT) &&
>> +	    unlikely(addr >=3D VMALLOC_START && addr < VMALLOC_END)) {
>>  		vmalloc_fault(regs, code, addr);
>>  		return;
>>  	}
>>
>> -#ifdef CONFIG_64BIT
>> -	/*
>> -	 * Modules in 64bit kernels lie in their own virtual region which is n=
ot
>> -	 * in the vmalloc region, but dealing with page faults in this region
>> -	 * or the vmalloc region amounts to doing the same thing: checking that
>> -	 * the mapping exists in init_mm.pgd and updating user page table, so
>> -	 * just use vmalloc_fault.
>> -	 */
>> -	if (unlikely(addr >=3D MODULES_VADDR && addr < MODULES_END)) {
>> -		vmalloc_fault(regs, code, addr);
>> -		return;
>> -	}
>> -#endif
>>  	/* Enable interrupts if they were enabled in the parent context. */
>>  	if (!regs_irqs_disabled(regs))
>>  		local_irq_enable();
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 747e5b1ef02d..38bd4dd95276 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1363,3 +1363,61 @@ int __meminit vmemmap_populate(unsigned long star=
t, unsigned long end, int node,
>>  	return vmemmap_populate_basepages(start, end, node, NULL);
>>  }
>>  #endif
>> +
>> +#ifdef CONFIG_64BIT
>> +/*
>> + * Pre-allocates page-table pages for a specific area in the kernel
>> + * page-table. Only the level which needs to be synchronized between
>> + * all page-tables is allocated because the synchronization can be
>> + * expensive.
>> + */
>> +static void __init preallocate_pgd_pages_range(unsigned long start, uns=
igned long end,
>> +					       const char *area)
>> +{
>> +	unsigned long addr;
>> +	const char *lvl;
>> +
>> +	for (addr =3D start; addr < end && addr >=3D start; addr =3D ALIGN(add=
r + 1, PGDIR_SIZE)) {
>> +		pgd_t *pgd =3D pgd_offset_k(addr);
>> +		p4d_t *p4d;
>> +		pud_t *pud;
>> +		pmd_t *pmd;
>> +
>> +		lvl =3D "p4d";
>> +		p4d =3D p4d_alloc(&init_mm, pgd, addr);
>> +		if (!p4d)
>> +			goto failed;
>> +
>> +		if (pgtable_l5_enabled)
>> +			continue;
>> +
>> +		lvl =3D "pud";
>> +		pud =3D pud_alloc(&init_mm, p4d, addr);
>> +		if (!pud)
>> +			goto failed;
>> +
>> +		if (pgtable_l4_enabled)
>> +			continue;
>> +
>> +		lvl =3D "pmd";
>> +		pmd =3D pmd_alloc(&init_mm, pud, addr);
>> +		if (!pmd)
>> +			goto failed;
>> +	}
>> +	return;
>> +
>> +failed:
>> +	/*
>> +	 * The pages have to be there now or they will be missing in
>> +	 * process page-tables later.
>> +	 */
>> +	panic("Failed to pre-allocate %s pages for %s area\n", lvl, area);
>> +}
>> +
>> +void __init pgtable_cache_init(void)
>> +{
>> +	preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc");
>> +	if (IS_ENABLED(CONFIG_MODULES))
>> +		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules"=
);
>> +}
>> +#endif
>>
>> base-commit: ac9a78681b921877518763ba0e89202254349d1b
>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> aside from the build issue, which seems pretty straight-forward.  I'm=20
> going to drop this from patchwork.

Hmm, you applied the V2 a couple of days ago [1], which fixes the build
issue. Did you drop the V2 from the queue?

[1]
https://lore.kernel.org/linux-riscv/168727442024.569.16572247474971535604.g=
it-patchwork-notify@kernel.org/


Bj=C3=B6rn
