Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDC37147F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjE2Kdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Kdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:33:51 -0400
Received: from outbound-smtp46.blacknight.com (outbound-smtp46.blacknight.com [46.22.136.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2E0C2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:33:48 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 34296FA996
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:33:47 +0100 (IST)
Received: (qmail 10972 invoked from network); 29 May 2023 10:33:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 May 2023 10:33:46 -0000
Date:   Mon, 29 May 2023 11:33:42 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] mm: compaction: Update pageblock skip when first
 migration candidate is not at the start
Message-ID: <20230529103342.esek6r5fvmft2nky@techsingularity.net>
References: <20230515113344.6869-1-mgorman@techsingularity.net>
 <20230515113344.6869-4-mgorman@techsingularity.net>
 <e87a9797-c8ce-1959-884a-7f791adeaafc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e87a9797-c8ce-1959-884a-7f791adeaafc@suse.cz>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 03:37:43PM +0200, Vlastimil Babka wrote:
> On 5/15/23 13:33, Mel Gorman wrote:
> > isolate_migratepages_block should mark a pageblock as skip if scanning
> > started on an aligned pageblock boundary but it only updates the skip
> > flag if the first migration candidate is also aligned. Tracing during
> > a compaction stress load (mmtests: workload-usemem-stress-numa-compact)
> > that many pageblocks are not marked skip causing excessive scanning of
> > blocks that had been recently checked. Update pageblock skip based on
> > "valid_page" which is set if scanning started on a pageblock boundary.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> I wonder if this has an unintended side-effect that if we resume
> isolate_migratepages_block() of a partially compacted pageblock to finish
> it, test_and_set_skip() will now tell us to abort, because we already set
> the skip bit in the previous call. This would include the
> cc->finish_pageblock rescan cases.
> 
> So unless I miss something that already prevents that, I agree we should not
> tie setting the skip bit to pageblock_aligned(pfn), but maybe if we are not
> pageblock aligned, we should ignore the already-set skip bit, as it was most
> likely being set by us in the previous iteration and should not prevent us
> from finishing the pageblock?
> 

Hmm, I think you're right. While it should not hit the original bug,
migration candidates are missed until the next compaction scan which
could be tricky to detect. Something like this as a separate patch?
Build tested only but the intent is for an unaligned start to set the skip
bet if already unset but otherwise complete the scan. Like earlier fixes,
this might overscan some pageblocks in a given context but we are probably
hitting the limits on how compaction can run efficiently in the current
scheme without causing other side-effects :(

diff --git a/mm/compaction.c b/mm/compaction.c
index 91af6a8b7a98..761a2dd7d78a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -792,6 +792,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	bool skip_on_failure = false;
 	unsigned long next_skip_pfn = 0;
 	bool skip_updated = false;
+	bool start_aligned;
 	int ret = 0;
 
 	cc->migrate_pfn = low_pfn;
@@ -824,6 +825,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	}
 
 	/* Time to isolate some pages for migration */
+	start_aligned = pageblock_aligned(start_pfn);
 	for (; low_pfn < end_pfn; low_pfn++) {
 
 		if (skip_on_failure && low_pfn >= next_skip_pfn) {
@@ -1069,10 +1071,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 			lruvec_memcg_debug(lruvec, page_folio(page));
 
-			/* Try get exclusive access under lock */
+			/* Try get exclusive access under lock. Isolation is
+			 * only aborted if the start was pageblock aligned
+			 * as this may be a partial resumed scan that set
+			 * the bit on a recent scan but the scan must reach
+			 * the end of the pageblock.
+			 */
 			if (!skip_updated && valid_page) {
 				skip_updated = true;
-				if (test_and_set_skip(cc, valid_page))
+				if (test_and_set_skip(cc, valid_page) && start_aligned)
 					goto isolate_abort;
 			}
 
