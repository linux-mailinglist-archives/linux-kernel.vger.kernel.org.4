Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73E26CC545
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjC1PND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjC1PMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:12:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1C11027C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36602B81D92
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A49C4339B;
        Tue, 28 Mar 2023 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680016293;
        bh=kEtXdgCEBV5p0GqSsNHxDFPAO4gt8lDkvKFBSENj3yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qmi4b60jdCXHiubROfANwWXwBPf/XpnrzqrX94qr468D5KhnYOpEyIcXYc9Enains
         BN3pDUwsgTHq8z5Ar+M8UuwU05OJbflhrIHJafv3SpdCNq3F84eZioEbdvrA8oR5tU
         pLI9lj2C8nYsFfz0SgTHE0d+uCuH3hzLVNqxO1s0AQWWLzMbu/E90zIzEJt0vsle25
         +8rdrtGX873DLMg2heMztHWRmul3QK11yyYzOQ+pyExEGjemPfYwi38WsPKxRJQ7/T
         NBKg2Lz3eV9txZkD8TelrzTdIyp5Vptjk9xKxv19LdbdAL+mwm3o+l3OXRPou0q7xQ
         jPD3A1wr/CFJw==
Date:   Tue, 28 Mar 2023 18:11:20 +0300
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
Message-ID: <ZCMDmHSqOeCj1EIo@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
 <ZB6W1C88TU6CcjJH@kernel.org>
 <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
 <ZCKIX3de5AZfGggK@kernel.org>
 <ZCKZuXxq38obmYpn@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCKZuXxq38obmYpn@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:39:37AM +0200, Michal Hocko wrote:
> On Tue 28-03-23 09:25:35, Mike Rapoport wrote:
> > On Mon, Mar 27, 2023 at 03:43:27PM +0200, Michal Hocko wrote:
> > > On Sat 25-03-23 09:38:12, Mike Rapoport wrote:
> > > > On Fri, Mar 24, 2023 at 09:37:31AM +0100, Michal Hocko wrote:
> > > > > On Wed 08-03-23 11:41:02, Mike Rapoport wrote:
> > > > > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > > > > 
> > > > > > When set_memory or set_direct_map APIs used to change attribute or
> > > > > > permissions for chunks of several pages, the large PMD that maps these
> > > > > > pages in the direct map must be split. Fragmenting the direct map in such
> > > > > > manner causes TLB pressure and, eventually, performance degradation.
> > > > > > 
> > > > > > To avoid excessive direct map fragmentation, add ability to allocate
> > > > > > "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
> > > > > > allocated pages from the direct map and use a cache of the unmapped pages.
> > > > > > 
> > > > > > This cache is replenished with higher order pages with preference for
> > > > > > PMD_SIZE pages when possible so that there will be fewer splits of large
> > > > > > pages in the direct map.
> > > > > > 
> > > > > > The cache is implemented as a buddy allocator, so it can serve high order
> > > > > > allocations of unmapped pages.
> > > > > 
> > > > > Why do we need a dedicated gfp flag for all this when a dedicated
> > > > > allocator is used anyway. What prevents users to call unmapped_pages_{alloc,free}?
> > > > 
> > > > Using unmapped_pages_{alloc,free} adds complexity to the users which IMO
> > > > outweighs the cost of a dedicated gfp flag.
> > > 
> > > Aren't those users rare and very special anyway?
> > > 
> > > > For modules we'd have to make x86::module_{alloc,free}() take care of
> > > > mapping and unmapping the allocated pages in the modules virtual address
> > > > range. This also might become relevant for another architectures in future
> > > > and than we'll have several complex module_alloc()s. 
> > > 
> > > The module_alloc use is lacking any justification. More context would be
> > > more than useful. Also vmalloc support for the proposed __GFP_UNMAPPED
> > > likely needs more explanation as well.
> >  
> > Right now module_alloc() boils down to vmalloc() with the virtual range
> > limited to the modules area. The allocated chunk contains both code and
> > data. When CONFIG_STRICT_MODULE_RWX is set, parts of the memory allocated
> > with module_alloc() remapped with different permissions both in vmalloc
> > address space and in the direct map. The change of permissions for small
> > ranges causes splits of large pages in the direct map.
> 
> OK, so you want to reduce that direct map fragmentation?

Yes.

> Is that a real problem?

A while ago Intel folks published report [1] that showed better performance
with large pages in the direct map for majority of benchmarks.

> My impression is that modules are mostly static thing. BPF
> might be a different thing though. I have a recollection that BPF guys
> were dealing with direct map fragmention as well.

Modules are indeed static, but module_alloc() used by anything that
allocates code pages, e.g. kprobes, ftrace and BPF. Besides, Thomas
mentioned that having code in 2M pages reduces iTLB pressure [2], but
that's not only about avoiding the splits in the direct map but also about
using large mappings in the modules address space.

BPF guys suggested an allocator for executable memory [3] mainly because
they've seen performance improvement of 0.6% - 0.9% in their setups [4].
 
> > If we were to use unmapped_pages_alloc() in modules_alloc(), we would have
> > to implement the part of vmalloc() that reserves the virtual addresses and
> > maps the allocated memory there in module_alloc().
> 
> Another option would be to provide an allocator for the backing pages to
> vmalloc. But I do agree that a gfp flag is a less laborous way to
> achieve the same. So the primary question really is whether we really
> need vmalloc support for unmapped memory.

I'm not sure I follow here. module_alloc() is essentially an alias to
vmalloc(), so to reduce direct map fragmentation caused by code allocations
the most sensible way IMO is to support unmapped memory in vmalloc().

I also think vmalloc with unmmapped pages can provide backing pages for
execmem_alloc() Song proposed.

> -- 
> Michal Hocko
> SUSE Labs

[1] https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/
[2] https://lore.kernel.org/all/87mt86rbvy.ffs@tglx/
[3] https://lore.kernel.org/all/20221107223921.3451913-1-song@kernel.org/
[4] https://lore.kernel.org/bpf/20220707223546.4124919-1-song@kernel.org/

-- 
Sincerely yours,
Mike.
