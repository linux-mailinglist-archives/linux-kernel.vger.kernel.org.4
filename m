Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88CF5C00E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiIUPQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiIUPQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:16:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972058E0D3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20BAFB83049
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DB8C433D6;
        Wed, 21 Sep 2022 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663773369;
        bh=3pWsI/Gg+BxuNQKLJDW405PHnHWdIeZ8RBjI7wGvRJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCTOzaVWZC2tsN8DmEGp7Ozg4aEaWVMWMF/y2FMLWuqdasfGY8R0/HdG/nRJSO4kc
         dveK70NllMyTpNx6YLXzYr4C5Oj877dXKnptUEw6Sip/lFI/zt3AE7yMn62fqdD6A1
         spWuYndOuusQ0xvpWyCJkihsaj3GGjmbxOdPCfOYJ0rJuXXbZkkvGGvivRvKfQXoZp
         7YfCsQDt0KQvGDmujPZ6BTtGKMlfgHXB0WMnPKqtlSkm/RrQ/fHVN4iEi0Knh/Oy1/
         YFs7BWDnP+P98andA2+R6YYeAKYlKFUfJ28acJLuICU7ZkPmIsDOGg48rXW3Lqomuz
         eafguEs0jgByA==
Date:   Wed, 21 Sep 2022 18:15:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: fold check for KFENCE into can_set_direct_map()
Message-ID: <Yysqq0/bxxSY9rcP@kernel.org>
References: <20220921074841.382615-1-rppt@kernel.org>
 <CAGsJ_4yMOC5M9rnfgv9TXWAm2aMDUVOdDYvNjzqzu_oj9DBn8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yMOC5M9rnfgv9TXWAm2aMDUVOdDYvNjzqzu_oj9DBn8Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,

On Wed, Sep 21, 2022 at 09:00:28PM +1200, Barry Song wrote:
> On Wed, Sep 21, 2022 at 8:26 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > KFENCE requires linear map to be mapped at page granularity, so that it
> > is possible to protect/unprotect single pages, just like with
> > rodata_full and DEBUG_PAGEALLOC.
> >
> > Instead of repating
> >
> >         can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE)
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
> >          */
> >         BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
> >
> > -       if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> > +       if (can_set_direct_map())
> >                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >
> >         /*
> > @@ -1547,11 +1547,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >
> >         VM_BUG_ON(!mhp_range_allowed(start, size, true));
> >
> > -       /*
> > -        * KFENCE requires linear map to be mapped at page granularity, so that
> > -        * it is possible to protect/unprotect single pages in the KFENCE pool.
> > -        */
> > -       if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> > +       if (can_set_direct_map())
> >                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >
> >         __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > index 64e985eaa52d..d107c3d434e2 100644
> > --- a/arch/arm64/mm/pageattr.c
> > +++ b/arch/arm64/mm/pageattr.c
> > @@ -21,7 +21,13 @@ bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED
> >
> >  bool can_set_direct_map(void)
> >  {
> > -       return rodata_full || debug_pagealloc_enabled();
> > +       /*
> > +        * rodata_full, DEBUG_PAGEALLOC and KFENCE require linear map to be
> > +        * mapped at page granularity, so that it is possible to
> > +        * protect/unprotect single pages.
> > +        */
> > +       return rodata_full || debug_pagealloc_enabled() ||
> > +               IS_ENABLED(CONFIG_KFENCE);
> 
> might be irrelevant, i wonder if rodata_full is too strict as
> rodata_full is almost
> always true since RODATA_FULL_DEFAULT_ENABLED is default true.

Not sure I follow. If either of these conditions is true the linear map
consists of base pages and it's possible to change attributes of each base
page. Whenever linear map contains block mapping, page attributes cannot be
modified.

And rodata_full might be false because
CONFIG_RODATA_FULL_DEFAULT_ENABLED was disabled at build time.
 
> >  }
> >
> >  static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
> > --
> > 2.35.3
> >
> 
> Thanks
> Barry

-- 
Sincerely yours,
Mike.
