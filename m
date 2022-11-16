Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA562B5D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiKPJAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiKPJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:00:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141581142;
        Wed, 16 Nov 2022 01:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8F9B61AE9;
        Wed, 16 Nov 2022 09:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDDDC433D6;
        Wed, 16 Nov 2022 09:00:15 +0000 (UTC)
Date:   Wed, 16 Nov 2022 09:00:12 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V2 2/2] arm64: errata: Workaround possible Cortex-A715
 [ESR|FAR]_ELx corruption
Message-ID: <Y3SmnJLO92zc20lD@arm.com>
References: <20221113012645.190301-1-anshuman.khandual@arm.com>
 <20221113012645.190301-3-anshuman.khandual@arm.com>
 <Y3Ob2MmmuoXOs2In@arm.com>
 <438ddc78-ded6-d464-f917-6b8749626f16@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438ddc78-ded6-d464-f917-6b8749626f16@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:12:34AM +0530, Anshuman Khandual wrote:
> Planning to apply the following change after this patch.
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 6552947ca7fa..cd8d96e1fa1a 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -562,14 +562,14 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
>  
>  pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>  {
> -       if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
> -               pte_t pte = READ_ONCE(*ptep);
> +       if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
> +           cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
>                 /*
>                  * Break-before-make (BBM) is required for all user space mappings
>                  * when the permission changes from executable to non-executable
>                  * in cases where cpu is affected with errata #2645198.
>                  */
> -               if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
> +               if (pte_user_exec(READ_ONCE(*ptep)))
>                         return huge_ptep_clear_flush(vma, addr, ptep);
>         }
>         return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c1fb0ce1473c..ec305ea3942c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1705,14 +1705,14 @@ early_initcall(prevent_bootmem_remove_init);
>  
>  pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>  {
> -       if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
> -               pte_t pte = READ_ONCE(*ptep);
> +       if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
> +           cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
>                 /*
>                  * Break-before-make (BBM) is required for all user space mappings
>                  * when the permission changes from executable to non-executable
>                  * in cases where cpu is affected with errata #2645198.
>                  */
> -               if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
> +               if (pte_user_exec(READ_ONCE(*ptep)))
>                         return ptep_clear_flush(vma, addr, ptep);
>         }
>         return ptep_get_and_clear(vma->vm_mm, addr, ptep);

It looks fine to me. Thanks.

-- 
Catalin
