Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3800A62B28F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKPFEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiKPFEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:04:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 803381CFD3;
        Tue, 15 Nov 2022 21:04:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92D5C13D5;
        Tue, 15 Nov 2022 21:04:16 -0800 (PST)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AA553F73B;
        Tue, 15 Nov 2022 21:04:07 -0800 (PST)
Message-ID: <9ef95ff6-ea97-847f-55d2-ffb3bdf895f0@arm.com>
Date:   Wed, 16 Nov 2022 10:34:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 2/2] arm64: errata: Workaround possible Cortex-A715
 [ESR|FAR]_ELx corruption
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
References: <20221113012645.190301-1-anshuman.khandual@arm.com>
 <20221113012645.190301-3-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20221113012645.190301-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/22 06:56, Anshuman Khandual wrote:
> +pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
> +{
> +	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
> +		pte_t pte = READ_ONCE(*ptep);
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
> +	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +}
> +
> +void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
> +			     pte_t old_pte, pte_t pte)
> +{
> +	__set_pte_at(vma->vm_mm, addr, ptep, pte);
> +}

Will change this __set_pte_at() to set_pte_at() instead like the generic version, which also
makes sure that page_table_check_pte_set() gets called on the way, also making it similar to
the HugeTLB implementation huge_ptep_modify_prot_commit().
