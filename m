Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E0764E1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiLOTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:44:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA6E511CB;
        Thu, 15 Dec 2022 11:44:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E86EB81B9E;
        Thu, 15 Dec 2022 19:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94038C433D2;
        Thu, 15 Dec 2022 19:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671133459;
        bh=DN7Ky2ByqlL7lH1aNikrWtAHE0Y0hbmJhJ4JoipwVeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQZG5r+wv+dyf0U9C9ex8PfNrturX/5mj2Jomp3qebm3sVEqhXfnuz0usqieo9HxW
         3mb1TvROeRiBdkS+K2j47ah46Ax54/TIqDLWWQ7xkDMNNL0YsZeu7Iq0CY9pXYgXR0
         shDI/TpSoYNaSf8iYlRsNfvJR6pfo4OHxtsVp7WAeylSRWSzBNuAuO/NylUxPPj9iU
         jjWz9AD6TPKuGJckyLieRSs03RKsHQQr7NTwRDu1qthJsG5wfWC3sIdMz8r3Gy+bS4
         1xf8rM9eYz2uG9Z3upaxhzLeIT1zoQoSoS/dNKjzlltwabteTj4M+y+PSgQXt9Crvh
         WLFRYrGscF1Xw==
Date:   Thu, 15 Dec 2022 19:44:14 +0000
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: errata: refer to config ARM64_ERRATUM_2645198 to
 make workaround work
Message-ID: <20221215194413.GA8094@willie-the-truck>
References: <20221215094811.23188-1-lukas.bulwahn@gmail.com>
 <20221215105745.GA7711@willie-the-truck>
 <b6f61241-e436-5db1-1053-3b441080b8d6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f61241-e436-5db1-1053-3b441080b8d6@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 04:59:20PM +0530, Anshuman Khandual wrote:
> On 12/15/22 16:27, Will Deacon wrote:
> > On Thu, Dec 15, 2022 at 10:48:11AM +0100, Lukas Bulwahn wrote:
> >> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> >> index cd8d96e1fa1a..95364e8bdc19 100644
> >> --- a/arch/arm64/mm/hugetlbpage.c
> >> +++ b/arch/arm64/mm/hugetlbpage.c
> >> @@ -562,7 +562,7 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
> >>  
> >>  pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
> >>  {
> >> -	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
> >> +	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
> >>  	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
> >>  		/*
> >>  		 * Break-before-make (BBM) is required for all user space mappings
> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >> index 12915f379c22..d77c9f56b7b4 100644
> >> --- a/arch/arm64/mm/mmu.c
> >> +++ b/arch/arm64/mm/mmu.c
> >> @@ -1633,7 +1633,7 @@ early_initcall(prevent_bootmem_remove_init);
> >>  
> >>  pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
> >>  {
> >> -	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
> >> +	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
> >>  	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
> >>  		/*
> >>  		 * Break-before-make (BBM) is required for all user space mappings
> > 
> > Grr, this bug seems to exist in all three versions of the patch reviewed on
> > the list, so I can only draw the conclusion that this code has never been
> 
> Ohh, my bad, apologies. I did not have a real system with this erratum, although
> had emulated and tested this workaround path via some other debug changes (which
> might have just forced the first condition to always evaluate true).

"might have"?

> > tested. Consequently, I'm more inclined to _revert_ the change for now and
> > we can bring it back as a fix once somebody has checked that it actually
> > works properly.
> Please do not revert this change if possible.

I've gone ahead with the revert anyway, just because it's the easy thing to
do and we can bring back a fixed version of the patch as a fix in the new
year. So please send a new version with this fix folded in after you've
tested that it doesn't cause regressions for systems without the erratum.

Cheers,

Will
