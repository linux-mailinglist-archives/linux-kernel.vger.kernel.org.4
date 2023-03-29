Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3506CD33D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjC2HbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjC2Hao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:30:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09BE40E6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56234B81E5F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367EAC4339B;
        Wed, 29 Mar 2023 07:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680074897;
        bh=SO5dN440drWwAjGv15LISSI+yn8jWWkwe558B4XHZYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PXL4jPrZR67MWVOz+XzAQuq9nF/9cmFIEOskGlY43KQ1mPY1BzNVcfGAOhfoaVdx+
         HQOFIoflLOT0Emh0ZfaaMtbKi8S7vJILBTtGSRz4nWWBJJZgVHGkunxEatzNiuXGpE
         69Lr7uxLy74fnxFqLdrPIa0kxo/W4K/AyG1ukfhGM1MPpy562gbzqL2NgJ3aJ/2p6c
         CuvV0z/UVqixm76J8j1sTcHLfZVlLw/3T+ndarfbJi2LIyVgpf7P1NYYauMu+qLOjl
         7kjGFli1GTq8Ak7fOhSfkCguCg19VTjB67X/cgmseWSR2h6qb/uDFFzutXvhSyYKj2
         6W6t37FbD6mbA==
Date:   Wed, 29 Mar 2023 10:28:02 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZCPoglyi7fDkXKmB@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
 <ZB6W1C88TU6CcjJH@kernel.org>
 <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
 <ZCKIX3de5AZfGggK@kernel.org>
 <ZCKZuXxq38obmYpn@dhcp22.suse.cz>
 <ZCMDmHSqOeCj1EIo@kernel.org>
 <ZCMGwWmF9MGObSlt@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCMGwWmF9MGObSlt@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 05:24:49PM +0200, Michal Hocko wrote:
> On Tue 28-03-23 18:11:20, Mike Rapoport wrote:
> > On Tue, Mar 28, 2023 at 09:39:37AM +0200, Michal Hocko wrote:
> [...]
> > > OK, so you want to reduce that direct map fragmentation?
> > 
> > Yes.
> > 
> > > Is that a real problem?
> > 
> > A while ago Intel folks published report [1] that showed better performance
> > with large pages in the direct map for majority of benchmarks.
> > 
> > > My impression is that modules are mostly static thing. BPF
> > > might be a different thing though. I have a recollection that BPF guys
> > > were dealing with direct map fragmention as well.
> > 
> > Modules are indeed static, but module_alloc() used by anything that
> > allocates code pages, e.g. kprobes, ftrace and BPF. Besides, Thomas
> > mentioned that having code in 2M pages reduces iTLB pressure [2], but
> > that's not only about avoiding the splits in the direct map but also about
> > using large mappings in the modules address space.
> > 
> > BPF guys suggested an allocator for executable memory [3] mainly because
> > they've seen performance improvement of 0.6% - 0.9% in their setups [4].
> 
> These are fair arguments and it would have been better to have them in
> the RFC. Also it is not really clear to me what is the actual benefit of
> the unmapping for those usecases. I do get they want to benefit from
> caching on the same permission setup but do they need unmapping as well?

The pages allocated with module_alloc() get different permissions depending
on whether they belong to text, rodata, data etc. The permissions are
updated in both vmalloc address space and in the direct map. The updates to
the direct map cause splits of the large pages. If we cache large pages as
unmapped we take out the entire 2M page from the direct map and then
if/when it becomes free it can be returned to the direct map as a 2M page.

Generally, the unmapped allocations are intended for use-cases that anyway
map the memory elsewhere than direct map and need to modify direct mappings
of the memory, be it modules_alloc(), secretmem, PKS page tables or maybe
even some of the encrypted VM memory.
 
> > > > If we were to use unmapped_pages_alloc() in modules_alloc(), we would have
> > > > to implement the part of vmalloc() that reserves the virtual addresses and
> > > > maps the allocated memory there in module_alloc().
> > > 
> > > Another option would be to provide an allocator for the backing pages to
> > > vmalloc. But I do agree that a gfp flag is a less laborous way to
> > > achieve the same. So the primary question really is whether we really
> > > need vmalloc support for unmapped memory.
> > 
> > I'm not sure I follow here. module_alloc() is essentially an alias to
> > vmalloc(), so to reduce direct map fragmentation caused by code allocations
> > the most sensible way IMO is to support unmapped memory in vmalloc().
> 
> What I meant to say is that vmalloc is currently using the page
> allocator (resp bulk allocator) for the backing storage. I can imagine
> an extension to replace this default allocator by something else (e.g. a
> given allocation function). This would be more generic and it would
> allow different usecases (e.g. benefit from caching withtout doing the
> actual unmapping).

The whole point of unmapped cache is to allow non-default permissions in
the direct map without splitting large pages there. So the cache that
unmaps large pages in the direct map and then handles out subpages of that
page seems like the most logical thing to do. With the current use cases
the callers anyway map these pages at different virtual addresses, i.e. 
page cache or vmalloc.

> > I also think vmalloc with unmmapped pages can provide backing pages for
> > execmem_alloc() Song proposed.
> 
> Why would you need to have execmem_alloc have its memory virtually
> mapped into vmalloc space?

Currently all the memory allocated for code is managed in a subset of
vmalloc() space. The intention of execmem_alloc() was to replace
module_alloc() for the code pages, so it's natural that it will use the
same virtual ranges.

But anyway, execmem_alloc() is a long shot as it also requires quite a
refactoring of modules loading.
 
> > [1] https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/
> > [2] https://lore.kernel.org/all/87mt86rbvy.ffs@tglx/
> > [3] https://lore.kernel.org/all/20221107223921.3451913-1-song@kernel.org/
> > [4] https://lore.kernel.org/bpf/20220707223546.4124919-1-song@kernel.org/
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
