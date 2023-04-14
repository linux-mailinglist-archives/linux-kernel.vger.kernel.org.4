Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4736E1E00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDNIWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDNIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:22:28 -0400
Received: from outbound-smtp02.blacknight.com (outbound-smtp02.blacknight.com [81.17.249.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD8530EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:22:26 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 00DC9BAC5D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:22:25 +0100 (IST)
Received: (qmail 32439 invoked from network); 14 Apr 2023 08:22:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Apr 2023 08:22:24 -0000
Date:   Fri, 14 Apr 2023 09:22:22 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH] mm: page_alloc: Assume huge tail pages are valid when
 allocating contiguous pages
Message-ID: <20230414082222.idgw745cgcduzy37@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bug was reported by Yuanxi Liu where allocating 1G pages at runtime is
taking an excessive amount of time for large amounts of memory. Further
testing allocating huge pages that the cost is linear i.e. if allocating
1G pages in batches of 10 then the time to allocate nr_hugepages from
10->20->30->etc increases linearly even though 10 pages are allocated at
each step. Profiles indicated that much of the time is spent checking the
validity within already existing huge pages and then attempting a migration
that fails after isolating the range, draining pages and a whole lot of
other useless work.

Commit eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from
pfn_range_valid_contig") removed two checks, one which ignored huge pages
for contiguous allocations as huge pages can migrate. While there may be
value on migrating a 2M page to satisfy a 1G allocation, it's pointless
to move a 1G page for a new 1G allocation or scan for validity within an
existing huge page.

Reintroduce the PageHuge check with some limitations. The new check
will allow an attempt to migrate a 2M page for a 1G allocation but
contiguous requests within CMA regions will always attempt the migration.
The function is renamed as pfn_range_valid_contig can be easily confused
with a pfn_valid() check which is not what the function does.

The hpagealloc test allocates huge pages in batches and reports the
average latency per page over time. This test happens just after boot when
fragmentation is not an issue. Units are in milliseconds.

hpagealloc
                               6.3.0-rc6              6.3.0-rc6              6.3.0-rc6
                                 vanilla   hugeallocrevert-v1r1      hugeallocfix-v1r1
Min       Latency       26.42 (   0.00%)        5.07 (  80.82%)       20.30 (  23.19%)
1st-qrtle Latency      356.61 (   0.00%)        5.34 (  98.50%)       20.57 (  94.23%)
2nd-qrtle Latency      697.26 (   0.00%)        5.47 (  99.22%)       20.84 (  97.01%)
3rd-qrtle Latency      972.94 (   0.00%)        5.50 (  99.43%)       21.16 (  97.83%)
Max-1     Latency       26.42 (   0.00%)        5.07 (  80.82%)       20.30 (  23.19%)
Max-5     Latency       82.14 (   0.00%)        5.11 (  93.78%)       20.49 (  75.05%)
Max-10    Latency      150.54 (   0.00%)        5.20 (  96.55%)       20.52 (  86.37%)
Max-90    Latency     1164.45 (   0.00%)        5.53 (  99.52%)       21.20 (  98.18%)
Max-95    Latency     1223.06 (   0.00%)        5.55 (  99.55%)       21.22 (  98.26%)
Max-99    Latency     1278.67 (   0.00%)        5.57 (  99.56%)       22.81 (  98.22%)
Max       Latency     1310.90 (   0.00%)        8.06 (  99.39%)       24.87 (  98.10%)
Amean     Latency      678.36 (   0.00%)        5.44 *  99.20%*       20.93 *  96.91%*

                   6.3.0-rc6   6.3.0-rc6   6.3.0-rc6
                     vanilla   revert-v1   hugeallocfix-v1
Duration User           0.28        0.27        0.27
Duration System       808.66       17.77       36.63
Duration Elapsed      830.87       18.08       36.95

The vanilla kernel is poor, taking up to 1.3 second to allocate a huge page
and almost 10 minutes in total to run the test. Reverting the problematic
commit reduces it to 8ms at worst and the patch takes 24ms. This patch
fixes the main issue with skipping huge pages but leaves the page_count()
alone because a page with an elevated count potentially can migrate. Note
that a simplier fix that simply checks PageHuge also performs similarly
with the caveat that 1G allocations may fail due to to smaller huge pages
that could have been migrated.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=217022
Fixes: eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from pfn_range_valid_contig")
Reported-by: Yuanxi Liu <y.liu@naruida.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7136c36c5d01..9036306b3d53 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9434,22 +9434,45 @@ static int __alloc_contig_pages(unsigned long start_pfn,
 				  gfp_mask);
 }
 
-static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
+/*
+ * Returns true if it's worth trying to migrate pages within a range for
+ * a contiguous allocation.
+ */
+static bool pfn_range_suitable_contig(struct zone *z, unsigned long start_pfn,
 				   unsigned long nr_pages)
 {
 	unsigned long i, end_pfn = start_pfn + nr_pages;
 	struct page *page;
 
 	for (i = start_pfn; i < end_pfn; i++) {
+		/* Must be valid. */
 		page = pfn_to_online_page(i);
 		if (!page)
 			return false;
 
+		/* Must be within one zone. */
 		if (page_zone(page) != z)
 			return false;
 
+		/* Reserved pages cannot migrate. */
 		if (PageReserved(page))
 			return false;
+
+		/*
+		 * Do not migrate huge pages that span the size of the region
+		 * being allocated contiguous. e.g. Do not migrate a 1G page
+		 * for a 1G allocation request. CMA is an exception as the
+		 * region may be reserved for hardware that requires physical
+		 * memory without a MMU or scatter/gather capability.
+		 *
+		 * Note that the compound check is race-prone versus
+		 * free/split/collapse but it should be safe and result in
+		 * a premature skip or a useless migration attempt.
+		 */
+		if (PageHuge(page) && compound_nr(page) >= nr_pages &&
+		    !is_migrate_cma_page(page)) {
+			return false;
+		}
 	}
 	return true;
 }
@@ -9498,7 +9521,7 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 
 		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
 		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
-			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
+			if (pfn_range_suitable_contig(zone, pfn, nr_pages)) {
 				/*
 				 * We release the zone lock here because
 				 * alloc_contig_range() will also lock the zone
