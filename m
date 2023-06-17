Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B26733F80
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346302AbjFQINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjFQIN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:13:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520971FFE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD73611AD
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 08:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31758C433C8;
        Sat, 17 Jun 2023 08:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686989606;
        bh=eqvHCNCeMkLO+EgkoH/FKPeGp52JksulsjVREFCIStM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PziBb3RGhjIbGfqlYcJJJtFxRE498w/GDvXEFBfRRKD1Ws4mXivHZm0W7KFzfV+04
         4zKOUC2dmzkHXRmOr/m3D74vXXn1DhEnqh6cqfSDOiq9c2XIxGWmSBG65iz9lmtQp+
         a/Z5fScLRoVEc8SJ+hc254tXJ7WqxOm6OcFHYBFrxu0Sx3AjzU13tGVQFzjlStqDCX
         b4G53ZibgVUFCLEs7JI3Y5JP9+rTrGjS+6h9xoh074b9aAAJ8oIopZiYm7vWQPqFJN
         AqgU1Y4FIm+Z02CsR6UyfKvcuTNENkafvXN9IGk/1mixtq545XjuMZx2O3aMPhx/kt
         NqGGLykwJLOZw==
Date:   Sat, 17 Jun 2023 11:12:49 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] mm: pass nid to reserve_bootmem_region()
Message-ID: <20230617081249.GW52412@kernel.org>
References: <20230616072247.GL52412@kernel.org>
 <20230616023011.2952211-1-yajun.deng@linux.dev>
 <5ba9ad9bedb2fd3fb96571a778fc35b5@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba9ad9bedb2fd3fb96571a778fc35b5@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 07:51:21AM +0000, Yajun Deng wrote:
> June 16, 2023 3:22 PM, "Mike Rapoport" <rppt@kernel.org> wrote:
> > On Fri, Jun 16, 2023 at 10:30:11AM +0800, Yajun Deng wrote:
> > 
> >> diff --git a/mm/mm_init.c b/mm/mm_init.c
> >> index d393631599a7..1499efbebc6f 100644
> >> --- a/mm/mm_init.c
> >> +++ b/mm/mm_init.c
> >> @@ -738,16 +735,20 @@ static inline void init_reserved_page(unsigned long pfn)
> >> * marks the pages PageReserved. The remaining valid pages are later
> >> * sent to the buddy page allocator.
> >> */
> >> -void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
> >> +void __meminit reserve_bootmem_region(phys_addr_t start,
> >> + phys_addr_t end, int nid)
> >> {
> >> unsigned long start_pfn = PFN_DOWN(start);
> >> unsigned long end_pfn = PFN_UP(end);
> >> 
> >> + if (nid == MAX_NUMNODES)
> >> + nid = first_online_node;
> > 
> > How can this happen?
> > 
> 
> Some reserved memory regions may not set nid. I found it when I debug.
> We can see that by memblock_debug_show().
 
Hmm, indeed. But then it means that some struct pages for the reserved pages
will get wrong nid and if they are freed we'd actually get pages with wrong
nid. 

Maybe it's this time to set nid on all reserved pages with something like

diff --git a/mm/memblock.c b/mm/memblock.c
index 3feafea06ab2..fcd0987e2496 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2084,6 +2084,14 @@ static void __init memmap_init_reserved_pages(void)
 	phys_addr_t start, end;
 	u64 i;
 
+	for_each_mem_region(region) {
+		int nid = memblock_get_region_node(region);
+
+		start = region->base;
+		end = start + region->size;
+		memblock_set_node(start, end, &memblock.reserved, nid);
+	}
+
 	/* initialize struct pages for the reserved regions */
 	for_each_reserved_mem_range(i, &start, &end)
 		reserve_bootmem_region(start, end);

> >> @@ -2579,7 +2580,13 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
> >> void __init memblock_free_pages(struct page *page, unsigned long pfn,
> >> unsigned int order)
> >> {
> >> - if (!early_page_initialised(pfn))
> >> + int nid = 0;
> >> +
> >> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> >> + nid = early_pfn_to_nid(pfn);
> >> +#endif

Please replace #ifdef with 

	if (IS_DEFINED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
 
> > Wen can pass nid to memblock_free_pages, no?
> >
> 
> memblock_free_pages() was called by __free_pages_memory() and memblock_free_late().
> For the latter, I'm not sure if we can pass nid.
> 
> I think we can pass nid to reserve_bootmem_region() in this patch, and pass nid to
> memblock_free_pages() in another patch if we can confirm this.

Fair enough.

-- 
Sincerely yours,
Mike.
