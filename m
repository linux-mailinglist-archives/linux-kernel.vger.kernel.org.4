Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05296E4237
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDQIJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDQIJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:09:51 -0400
Received: from outbound-smtp42.blacknight.com (outbound-smtp42.blacknight.com [46.22.139.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC87546A1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:09:47 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp42.blacknight.com (Postfix) with ESMTPS id BE0BF1EA9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:09:45 +0100 (IST)
Received: (qmail 17197 invoked from network); 17 Apr 2023 08:09:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Apr 2023 08:09:45 -0000
Date:   Mon, 17 Apr 2023 09:09:43 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: Skip regions with hugetlbfs pages when
 allocating 1G pages
Message-ID: <20230417080943.ybapzpxq4uoph6k6@techsingularity.net>
References: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
 <085983ed-b32a-3ec6-ff4a-a340776c410b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <085983ed-b32a-3ec6-ff4a-a340776c410b@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 04:20:33PM -0700, Doug Berger wrote:
> On 4/14/2023 7:14 AM, Mel Gorman wrote:
> > A bug was reported by Yuanxi Liu where allocating 1G pages at runtime is
> > taking an excessive amount of time for large amounts of memory. Further
> > testing allocating huge pages that the cost is linear i.e. if allocating
> > 1G pages in batches of 10 then the time to allocate nr_hugepages from
> > 10->20->30->etc increases linearly even though 10 pages are allocated at
> > each step. Profiles indicated that much of the time is spent checking the
> > validity within already existing huge pages and then attempting a migration
> > that fails after isolating the range, draining pages and a whole lot of
> > other useless work.
> > 
> > Commit eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from
> > pfn_range_valid_contig") removed two checks, one which ignored huge pages
> > for contiguous allocations as huge pages can sometimes migrate. While
> > there may be value on migrating a 2M page to satisfy a 1G allocation, it's
> > potentially expensive if the 1G allocation fails and it's pointless to
> > try moving a 1G page for a new 1G allocation or scan the tail pages for
> > valid PFNs.
> > 
> > Reintroduce the PageHuge check and assume any contiguous region with
> > hugetlbfs pages is unsuitable for a new 1G allocation.
> > 
> > The hpagealloc test allocates huge pages in batches and reports the
> > average latency per page over time. This test happens just after boot when
> > fragmentation is not an issue. Units are in milliseconds.
> > 
> > hpagealloc
> >                                 6.3.0-rc6              6.3.0-rc6              6.3.0-rc6
> >                                   vanilla   hugeallocrevert-v1r1   hugeallocsimple-v1r2
> > Min       Latency       26.42 (   0.00%)        5.07 (  80.82%)       18.94 (  28.30%)
> > 1st-qrtle Latency      356.61 (   0.00%)        5.34 (  98.50%)       19.85 (  94.43%)
> > 2nd-qrtle Latency      697.26 (   0.00%)        5.47 (  99.22%)       20.44 (  97.07%)
> > 3rd-qrtle Latency      972.94 (   0.00%)        5.50 (  99.43%)       20.81 (  97.86%)
> > Max-1     Latency       26.42 (   0.00%)        5.07 (  80.82%)       18.94 (  28.30%)
> > Max-5     Latency       82.14 (   0.00%)        5.11 (  93.78%)       19.31 (  76.49%)
> > Max-10    Latency      150.54 (   0.00%)        5.20 (  96.55%)       19.43 (  87.09%)
> > Max-90    Latency     1164.45 (   0.00%)        5.53 (  99.52%)       20.97 (  98.20%)
> > Max-95    Latency     1223.06 (   0.00%)        5.55 (  99.55%)       21.06 (  98.28%)
> > Max-99    Latency     1278.67 (   0.00%)        5.57 (  99.56%)       22.56 (  98.24%)
> > Max       Latency     1310.90 (   0.00%)        8.06 (  99.39%)       26.62 (  97.97%)
> > Amean     Latency      678.36 (   0.00%)        5.44 *  99.20%*       20.44 *  96.99%*
> > 
> >                     6.3.0-rc6   6.3.0-rc6   6.3.0-rc6
> >                       vanilla   revert-v1   hugeallocfix-v2
> > Duration User           0.28        0.27        0.30
> > Duration System       808.66       17.77       35.99
> > Duration Elapsed      830.87       18.08       36.33
> > 
> > The vanilla kernel is poor, taking up to 1.3 second to allocate a huge page
> > and almost 10 minutes in total to run the test. Reverting the problematic
> > commit reduces it to 8ms at worst and the patch takes 26ms. This patch
> > fixes the main issue with skipping huge pages but leaves the page_count()
> > out because a page with an elevated count potentially can migrate.
> > 
> A while ago I submitted this patch set that should significantly improve
> the chances of a 2MB Huge Page being successfully migrated:
> https://lore.kernel.org/linux-mm/20220921223639.1152392-1-opendmb@gmail.com/
> 
> Unfortunately, it is collecting dust and needs to be updated to support
> Folios, but I would be curious how it affects the performance of this test.
> 

It would not affect the specific test reported in the changelog as it's
1G allocations early in boot so no other hugetlb pages present. To be
representative there would have to an initialisation step to allocate 2M
pages first, place them awkwardly and then attempt the 1G allocations
to force the migrations to occur. That's not impossible as huge pages
could be allocated while base pages are being faulted in a mmap() region
to try interleaving 2M and base pages in the physical address space (only
realistic during boot and the same process faulting base pages should also
increment nr_hugepages so it's reproducible).  That would be sufficient
to demonstrate that migrating the 2M pages allows a 1G to succeed where
it would have failed otherwise.

> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=217022
> > Fixes: eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from pfn_range_valid_contig")
> > Reported-by: Yuanxi Liu <y.liu@naruida.com>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >   mm/page_alloc.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 7136c36c5d01..b47f520c3051 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -9450,6 +9450,9 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
> >   		if (PageReserved(page))
> >   			return false;
> > +
> > +		if (PageHuge(page))
> > +			return false;
> >   	}
> >   	return true;
> >   }
> > 
> 
> I am OK with this patch too, but I could resubmit my patch with Mike's
> suggested variant and Folio support if anyone wants to try it instead of
> this approach.
> 

I have no objection to a patch checking compound_order(page) > MAX_ORDER but
I wouldn't consider it to be a stable candidate. Ideally, there would be some
data showing it actually works (1G pages succeed that would otherwise fail)
and that it doesn't take a silly amount of time to succeed *or* fail a 1G
allocation. The test case is an ideal based on commit eb14d4eefdc4 implying
that 2M migrations were expected to improve 1G allocations but I don't
know if that's actually true or what the cost is. Maybe someone else knows.

-- 
Mel Gorman
SUSE Labs
