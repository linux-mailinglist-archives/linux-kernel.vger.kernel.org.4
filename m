Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE040629B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiKOOCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiKOOCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:02:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5455F2AC71;
        Tue, 15 Nov 2022 06:02:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 089D4B818BA;
        Tue, 15 Nov 2022 14:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CB0C433C1;
        Tue, 15 Nov 2022 14:02:04 +0000 (UTC)
Date:   Tue, 15 Nov 2022 14:02:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V2 2/2] arm64: errata: Workaround possible Cortex-A715
 [ESR|FAR]_ELx corruption
Message-ID: <Y3Ob2MmmuoXOs2In@arm.com>
References: <20221113012645.190301-1-anshuman.khandual@arm.com>
 <20221113012645.190301-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113012645.190301-3-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 06:56:45AM +0530, Anshuman Khandual wrote:
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 35e9a468d13e..6552947ca7fa 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -559,3 +559,24 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
>  {
>  	return __hugetlb_valid_size(size);
>  }
> +
> +pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
> +{
> +	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
> +		pte_t pte = READ_ONCE(*ptep);

Not sure whether the generated code would be any different but we should
probably add the check for the CPU capability in the 'if' condition
above, before the READ_ONCE (which expands to some asm volatile):

	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
		pte_t pte = ...
		...
	}

> +		/*
> +		 * Break-before-make (BBM) is required for all user space mappings
> +		 * when the permission changes from executable to non-executable
> +		 * in cases where cpu is affected with errata #2645198.
> +		 */
> +		if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
> +			return huge_ptep_clear_flush(vma, addr, ptep);
> +	}
> +	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +}
> +
> +void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
> +				  pte_t old_pte, pte_t pte)
> +{
> +	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
> +}
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9a7c38965154..c1fb0ce1473c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1702,3 +1702,24 @@ static int __init prevent_bootmem_remove_init(void)
>  }
>  early_initcall(prevent_bootmem_remove_init);
>  #endif
> +
> +pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
> +{
> +	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
> +		pte_t pte = READ_ONCE(*ptep);
> +		/*
> +		 * Break-before-make (BBM) is required for all user space mappings
> +		 * when the permission changes from executable to non-executable
> +		 * in cases where cpu is affected with errata #2645198.
> +		 */
> +		if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
> +			return ptep_clear_flush(vma, addr, ptep);
> +	}

Same here.

> +	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +}
> +
> +void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
> +			     pte_t old_pte, pte_t pte)
> +{
> +	__set_pte_at(vma->vm_mm, addr, ptep, pte);
> +}

-- 
Catalin
