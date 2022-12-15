Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AEC64D9E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiLOK6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiLOK5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:57:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD882E696;
        Thu, 15 Dec 2022 02:57:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7756DB81ADB;
        Thu, 15 Dec 2022 10:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3192C433EF;
        Thu, 15 Dec 2022 10:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671101871;
        bh=fMmjzGIH0CRhTtjJw03yzuzhzkLRPQKpcOH9nmWFjx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZuwanRa7QECHG/OZEtvLfBneGVE/BzhYGdE8JDorggkxdYspHrSUooR1f637h2sMg
         +cK/nMV9ubDQNsLGcs977dt78mvaZ9lcMG/nsAyFYay8yXsITx1DQYSwFkXTakOWGS
         H+NMbJQQI8+DcPH7G9URddZE7hG1zo48B/0PXPIM2ClImq7jfma0+pZgmBXrtgJXvH
         tpqUFOVBtOdUtBn0M2YQwrEMCXe1+/lZGLaCCl39e2WyTzbN0yO0CBdf0Ac1T/5S++
         snfT3+MMoecoOxwEcpLvNTJdf4PeuGUOygByqiZkc45rRUHbtUEjIjPcifBn44+J6T
         eGkRqbnY4Y8VA==
Date:   Thu, 15 Dec 2022 10:57:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: errata: refer to config ARM64_ERRATUM_2645198 to
 make workaround work
Message-ID: <20221215105745.GA7711@willie-the-truck>
References: <20221215094811.23188-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215094811.23188-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 10:48:11AM +0100, Lukas Bulwahn wrote:
> Commit 44ecda71fd8a ("arm64: errata: Workaround possible Cortex-A715
> [ESR|FAR]_ELx corruption") implements a workaround for arm64 erratum
> 2645198. The arm64 cpucaps is called WORKAROUND_2645198; the kernel build
> configuration is called ARM64_ERRATUM_2645198.
> 
> In the functions huge_ptep_modify_prot_start() and
> ptep_modify_prot_start(), the code accidently refers to the non-existing
> config CONFIG_ARM64_WORKAROUND_2645198. Note that the config name uses
> ERRATUM, not WORKAROUND. By this accidental misreference, this condition is
> always false, the branch of the workaround is not reachable and the
> workaround is effectively not implemented at all.
> 
> Refer to the intended config ARM64_ERRATUM_2645198 and make the intended
> workaround effectively work.
> 
> Fixes: 44ecda71fd8a ("arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 2 +-
>  arch/arm64/mm/mmu.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks for the report!

> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index cd8d96e1fa1a..95364e8bdc19 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -562,7 +562,7 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
>  
>  pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>  {
> -	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
> +	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
>  	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
>  		/*
>  		 * Break-before-make (BBM) is required for all user space mappings
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 12915f379c22..d77c9f56b7b4 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1633,7 +1633,7 @@ early_initcall(prevent_bootmem_remove_init);
>  
>  pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>  {
> -	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
> +	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
>  	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
>  		/*
>  		 * Break-before-make (BBM) is required for all user space mappings

Grr, this bug seems to exist in all three versions of the patch reviewed on
the list, so I can only draw the conclusion that this code has never been
tested. Consequently, I'm more inclined to _revert_ the change for now and
we can bring it back as a fix once somebody has checked that it actually
works properly.

Will
