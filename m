Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ABD6CA8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjC0PKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC0PKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:10:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44B3C19
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:10:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E108B1FDE4;
        Mon, 27 Mar 2023 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679929810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wumnRnZ3mJK+95JSA6PLaHw4mVwxf/aNZqTtEDsqwmM=;
        b=ao7iOgtgltan86e3vJELzQW8Z9M+QQ3IyzYxQtzhBXmTU5dJUQ7/BZw40GFk0hmH17YHyO
        ULCwjK41X0JZRzM4EBH2eBYq0ZcKxL4y4yql6iwP6BjF4mSHXRBv5A93lRqm27RiUbwWIR
        ZczhHUnlnZgzD4xrdlX0hBmFNoBMOcM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFCD413329;
        Mon, 27 Mar 2023 15:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q//OKtKxIWS/LAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 27 Mar 2023 15:10:10 +0000
Date:   Mon, 27 Mar 2023 17:10:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZCGx0unt2aofy8BW@dhcp22.suse.cz>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
 <ZB6W1C88TU6CcjJH@kernel.org>
 <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
 <f2702360-d560-95da-a93d-16fae1dbf766@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2702360-d560-95da-a93d-16fae1dbf766@suse.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-03-23 16:31:45, Vlastimil Babka wrote:
> On 3/27/23 15:43, Michal Hocko wrote:
> > On Sat 25-03-23 09:38:12, Mike Rapoport wrote:
> >> On Fri, Mar 24, 2023 at 09:37:31AM +0100, Michal Hocko wrote:
> >> > On Wed 08-03-23 11:41:02, Mike Rapoport wrote:
> >> > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >> > > 
> >> > > When set_memory or set_direct_map APIs used to change attribute or
> >> > > permissions for chunks of several pages, the large PMD that maps these
> >> > > pages in the direct map must be split. Fragmenting the direct map in such
> >> > > manner causes TLB pressure and, eventually, performance degradation.
> >> > > 
> >> > > To avoid excessive direct map fragmentation, add ability to allocate
> >> > > "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
> >> > > allocated pages from the direct map and use a cache of the unmapped pages.
> >> > > 
> >> > > This cache is replenished with higher order pages with preference for
> >> > > PMD_SIZE pages when possible so that there will be fewer splits of large
> >> > > pages in the direct map.
> >> > > 
> >> > > The cache is implemented as a buddy allocator, so it can serve high order
> >> > > allocations of unmapped pages.
> >> > 
> >> > Why do we need a dedicated gfp flag for all this when a dedicated
> >> > allocator is used anyway. What prevents users to call unmapped_pages_{alloc,free}?
> >> 
> >> Using unmapped_pages_{alloc,free} adds complexity to the users which IMO
> >> outweighs the cost of a dedicated gfp flag.
> > 
> > Aren't those users rare and very special anyway?
> 
> I think it's mostly about the freeing that can happen from a generic context
> not aware of the special allocation, so it's not about how rare it is, but
> how complex would be to determine exhaustively those contexts and do
> something in them.

Yes, I can see a challenge with put_page users but that is not really
related to the gfp flag as those are only relevant for the allocation
context.
 
> >> For modules we'd have to make x86::module_{alloc,free}() take care of
> >> mapping and unmapping the allocated pages in the modules virtual address
> >> range. This also might become relevant for another architectures in future
> >> and than we'll have several complex module_alloc()s. 
> > 
> > The module_alloc use is lacking any justification. More context would be
> > more than useful. Also vmalloc support for the proposed __GFP_UNMAPPED
> > likely needs more explanation as well.
> > 
> >> And for secretmem while using unmapped_pages_alloc() is easy, the free path
> >> becomes really complex because actual page freeing for fd-based memory is
> >> deeply buried in the page cache code.
> > 
> > Why is that a problem? You already hook into the page freeing path and
> > special case unmapped memory.
> 
> But the proposal of unmapped_pages_free() would suggest this would no longer
> be the case?

I can see a check in the freeing path.

> But maybe we could, as a compromise, provide unmapped_pages_alloc() to get
> rid of the new __GFP flag, provide unmapped_pages_free() to annotate places
> that are known to free unmapped memory explicitly, but the generic page
> freeing would also keep the hook?

Honestly I do not see a different option if those pages are to be
reference counted. Unless they can use a destructor concept like hugetlb
pages. At least secret mem usecase cannot AFAICS.

-- 
Michal Hocko
SUSE Labs
