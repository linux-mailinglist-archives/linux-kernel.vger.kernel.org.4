Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA596CB720
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjC1G1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjC1G0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:26:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D15272
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEF48B81AEF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91733C433EF;
        Tue, 28 Mar 2023 06:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679984748;
        bh=/gjN378BHPpXOBuY5ZBtQCxFRa5v+wfjv5N1z6Y/jBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dH1R2Ibm3W3MCBkV5lrXi0+FotfnDyK0xLxyuG3hKSq5fCI8grjlIaaKmYxJK+dWs
         aMMnrIdeJtPewg6zlyNPF9QcQBkST3UtXwLmcKDibpyPC2vGUi4sRAVAwzNE6nS+t2
         jpf9ABSjs4ye5UdDznEr/ksf0yNJLM645OrSNq3dAGfaRLPtwLfPdqBoWpoXTmDwfC
         mQmlQHKK6P7oqtIZ7tpzyAjJ8NlFUq+gqMTHjeDqNs6v0O8/MpvlhHL5gjLFUqLMnK
         OoZi2YzyP5Of0faOwoydDJbQCWj5EHLbBDDw6bku7lXu8LzB8ot4shGIfWpkZ8FxCz
         +R1eT5KqGDvxA==
Date:   Tue, 28 Mar 2023 09:25:35 +0300
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
Message-ID: <ZCKIX3de5AZfGggK@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
 <ZB6W1C88TU6CcjJH@kernel.org>
 <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 03:43:27PM +0200, Michal Hocko wrote:
> On Sat 25-03-23 09:38:12, Mike Rapoport wrote:
> > On Fri, Mar 24, 2023 at 09:37:31AM +0100, Michal Hocko wrote:
> > > On Wed 08-03-23 11:41:02, Mike Rapoport wrote:
> > > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > > 
> > > > When set_memory or set_direct_map APIs used to change attribute or
> > > > permissions for chunks of several pages, the large PMD that maps these
> > > > pages in the direct map must be split. Fragmenting the direct map in such
> > > > manner causes TLB pressure and, eventually, performance degradation.
> > > > 
> > > > To avoid excessive direct map fragmentation, add ability to allocate
> > > > "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
> > > > allocated pages from the direct map and use a cache of the unmapped pages.
> > > > 
> > > > This cache is replenished with higher order pages with preference for
> > > > PMD_SIZE pages when possible so that there will be fewer splits of large
> > > > pages in the direct map.
> > > > 
> > > > The cache is implemented as a buddy allocator, so it can serve high order
> > > > allocations of unmapped pages.
> > > 
> > > Why do we need a dedicated gfp flag for all this when a dedicated
> > > allocator is used anyway. What prevents users to call unmapped_pages_{alloc,free}?
> > 
> > Using unmapped_pages_{alloc,free} adds complexity to the users which IMO
> > outweighs the cost of a dedicated gfp flag.
> 
> Aren't those users rare and very special anyway?
> 
> > For modules we'd have to make x86::module_{alloc,free}() take care of
> > mapping and unmapping the allocated pages in the modules virtual address
> > range. This also might become relevant for another architectures in future
> > and than we'll have several complex module_alloc()s. 
> 
> The module_alloc use is lacking any justification. More context would be
> more than useful. Also vmalloc support for the proposed __GFP_UNMAPPED
> likely needs more explanation as well.
 
Right now module_alloc() boils down to vmalloc() with the virtual range
limited to the modules area. The allocated chunk contains both code and
data. When CONFIG_STRICT_MODULE_RWX is set, parts of the memory allocated
with module_alloc() remapped with different permissions both in vmalloc
address space and in the direct map. The change of permissions for small
ranges causes splits of large pages in the direct map.

If we were to use unmapped_pages_alloc() in modules_alloc(), we would have
to implement the part of vmalloc() that reserves the virtual addresses and
maps the allocated memory there in module_alloc().

> > And for secretmem while using unmapped_pages_alloc() is easy, the free path
> > becomes really complex because actual page freeing for fd-based memory is
> > deeply buried in the page cache code.
> 
> Why is that a problem? You already hook into the page freeing path and
> special case unmapped memory.

I didn't say there is a problem with unmapped_pages_alloc() in secretmem, I
said there is a problem with unmapped_pages_free() and hence are the
special case for unmapped memory in the freeing path.
 
> > My gut feeling is that for PKS using a gfp flag would save a lot of hassle
> > as well.
> 
> Well, my take on this is that this is not a generic page allocator
> functionality. It is clearly an allocator on top of the page allocator.
> In general gfp flags are scarce and convenience argument usually fires
> back later on in hard to predict ways. So I've learned to be careful
> here. I am not saying this is a no-go but right now I do not see any
> acutal advantage. The vmalloc usecase could be interesting in that
> regards but it is not really clear to me whether this is a good idea in
> the first place.

I don't see the usage of a gfp flag as a convenience argument, but rather
it feels for me that a gfp flag will cause less maintenance burden. Of
course this is subjective.

And although this is an allocator on top of the page allocator, it is still
very tightly coupled with the core page allocator. I'm still think that
using a migrate type for this would have been more elegant, but I realize
that a migrate type would have more impact on the allocation path.
 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
