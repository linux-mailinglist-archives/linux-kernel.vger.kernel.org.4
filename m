Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3175C00FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIUPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIUPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:19:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED60B33E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5886B8304F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275CDC433C1;
        Wed, 21 Sep 2022 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663773566;
        bh=dbFiBb96XQe4U0eDZ+uXd3wxcpqjYtrh6LsgsTTGho0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPCgfALMkZMmrCpvLjMnb44QHoCKH55Z7hBvgBWNEX8T7NtvVuFFgpxyyuqVIZfTk
         2ZF5WpTBGufJ/KRLGDuNlpZ4FtW7jWJoFnm7xHIzqSznBcYX8pJTsBAX7FVf5cGhem
         t/a4srQMQNtpXPZ6a6XEn7Gql/oz4OjT/sPt7M56GW/vAUXRNoDNXcoS4lFuEoOcFA
         8zohy5kQhU9WqapK5dtERlOjEJ1gBQWxAdoZzCQyWO8szqFLSkGAaC/znVgbcwoC5W
         J1HJwHSPUKppX3cuAgwczPwn/nEbPsJD116nq0xDSDhu83GJ8lesjhimNef+4lH7P1
         h3j4br5CKHM1w==
Date:   Wed, 21 Sep 2022 18:19:12 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: fold check for KFENCE into can_set_direct_map()
Message-ID: <YysrcNmdz5t30cQQ@kernel.org>
References: <20220921074841.382615-1-rppt@kernel.org>
 <1a87b8a4-46f0-69c9-83ec-10cce8f0aa72@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a87b8a4-46f0-69c9-83ec-10cce8f0aa72@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Wed, Sep 21, 2022 at 05:09:19PM +0530, Anshuman Khandual wrote:
> 
> 
> On 9/21/22 13:18, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > KFENCE requires linear map to be mapped at page granularity, so that it
> > is possible to protect/unprotect single pages, just like with
> > rodata_full and DEBUG_PAGEALLOC.
> > 
> > Instead of repating
> > 
> > 	can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE)
> > 
> > make can_set_direct_map() handle the KFENCE case.
> > 
> > This also prevents potential false positives in kernel_page_present()
> > that may return true for non-present page if CONFIG_KFENCE is enabled.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/arm64/mm/mmu.c      | 8 ++------
> >  arch/arm64/mm/pageattr.c | 8 +++++++-
> >  2 files changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index e7ad44585f40..c5065abec55a 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -535,7 +535,7 @@ static void __init map_mem(pgd_t *pgdp)
> >  	 */
> >  	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
> >  
> > -	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> > +	if (can_set_direct_map())
> >  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >  
> >  	/*
> > @@ -1547,11 +1547,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >  
> >  	VM_BUG_ON(!mhp_range_allowed(start, size, true));
> >  
> > -	/*
> > -	 * KFENCE requires linear map to be mapped at page granularity, so that
> > -	 * it is possible to protect/unprotect single pages in the KFENCE pool.
> > -	 */
> > -	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> > +	if (can_set_direct_map())
> >  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >  
> >  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > index 64e985eaa52d..d107c3d434e2 100644
> > --- a/arch/arm64/mm/pageattr.c
> > +++ b/arch/arm64/mm/pageattr.c
> > @@ -21,7 +21,13 @@ bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED
> >  
> >  bool can_set_direct_map(void)
> >  {
> > -	return rodata_full || debug_pagealloc_enabled();
> > +	/*
> > +	 * rodata_full, DEBUG_PAGEALLOC and KFENCE require linear map to be
> > +	 * mapped at page granularity, so that it is possible to
> > +	 * protect/unprotect single pages.
> > +	 */
> > +	return rodata_full || debug_pagealloc_enabled() ||
> > +		IS_ENABLED(CONFIG_KFENCE);
> >  }
> 
> Changing can_set_direct_map() also changes behaviour for other functions such as 
> 
> set_direct_map_default_noflush()
> set_direct_map_invalid_noflush()
> __kernel_map_pages()
> 
> Is that okay ?
 
Yes. Since KFENCE disables block mappings, these will actually change the
page tables.
Actually, before this change the test for can_set_direct_map() in these
functions was false negative when CONFIG_KFENCE=y
  
> >  static int change_page_range(pte_t *ptep, unsigned long addr, void *data)

-- 
Sincerely yours,
Mike.
