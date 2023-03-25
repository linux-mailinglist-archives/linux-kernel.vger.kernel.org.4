Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847FF6C8BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCYGie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjCYGib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:38:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E5F49C1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 661BBB826F0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98850C433EF;
        Sat, 25 Mar 2023 06:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679726307;
        bh=09X3GwvaX9EPrUeSWfoBHO3NT20VKgRC9q168x8HVao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKFHkzqyyxtLu3o9NPWBgip+PXHpiM8d+nMz/dKNC4zOyJrzg+tIovoeIrsJd8vIV
         Rh9GTHvBrgxJ6HaGKZ4nsyRLv1Xm9I36lai0Hp47sxibC4juLYIKEtZW4qFoogvKod
         IKS/UxNUjS/a6oLpL9FPf0h3rcbMxBKi0+zP63GWVCBWUS5+2RYnlofMRYRuM5Nz56
         L6YYH4giJklgskzrLg3t5m0RAwv5Blzjc4qxh+w+sEyHuoa0h4B0sx2WqtV0vscVBf
         1lQrHfCYU9GSa+Qh1NhDcdglo9JEyjAyCOvs0rdLM61SWMEdUlC0egL7IRyU+QTfIM
         dDTKS40iyIC8w==
Date:   Sat, 25 Mar 2023 09:38:12 +0300
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
Message-ID: <ZB6W1C88TU6CcjJH@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:37:31AM +0100, Michal Hocko wrote:
> On Wed 08-03-23 11:41:02, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > When set_memory or set_direct_map APIs used to change attribute or
> > permissions for chunks of several pages, the large PMD that maps these
> > pages in the direct map must be split. Fragmenting the direct map in such
> > manner causes TLB pressure and, eventually, performance degradation.
> > 
> > To avoid excessive direct map fragmentation, add ability to allocate
> > "unmapped" pages with __GFP_UNMAPPED flag that will cause removal of the
> > allocated pages from the direct map and use a cache of the unmapped pages.
> > 
> > This cache is replenished with higher order pages with preference for
> > PMD_SIZE pages when possible so that there will be fewer splits of large
> > pages in the direct map.
> > 
> > The cache is implemented as a buddy allocator, so it can serve high order
> > allocations of unmapped pages.
> 
> Why do we need a dedicated gfp flag for all this when a dedicated
> allocator is used anyway. What prevents users to call unmapped_pages_{alloc,free}?

Using unmapped_pages_{alloc,free} adds complexity to the users which IMO
outweighs the cost of a dedicated gfp flag.

For modules we'd have to make x86::module_{alloc,free}() take care of
mapping and unmapping the allocated pages in the modules virtual address
range. This also might become relevant for another architectures in future
and than we'll have several complex module_alloc()s. 

And for secretmem while using unmapped_pages_alloc() is easy, the free path
becomes really complex because actual page freeing for fd-based memory is
deeply buried in the page cache code.

My gut feeling is that for PKS using a gfp flag would save a lot of hassle
as well.

I also think that some of the core buddy allocator code might be reused and
unmapped_pages_{alloc,free} could be statics in mm/page_alloc.c and won't be
exposed at all. For now I've just copied free list helpers to a separate
file out of laziness.

> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
