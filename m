Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D06720035
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjFBLQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjFBLQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:16:29 -0400
Received: from outbound-smtp35.blacknight.com (outbound-smtp35.blacknight.com [46.22.139.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A55133
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:16:26 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 744E91D0B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:16:25 +0100 (IST)
Received: (qmail 11021 invoked from network); 2 Jun 2023 11:16:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Jun 2023 11:16:25 -0000
Date:   Fri, 2 Jun 2023 12:16:22 +0100
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
Message-ID: <20230602111622.swtxhn6lu2qwgrwq@techsingularity.net>
References: <20230515113344.6869-1-mgorman@techsingularity.net>
 <20230515113344.6869-4-mgorman@techsingularity.net>
 <e87a9797-c8ce-1959-884a-7f791adeaafc@suse.cz>
 <20230529103342.esek6r5fvmft2nky@techsingularity.net>
 <6695b7e5-9fa5-fae8-8a66-cc5985b0baaf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <6695b7e5-9fa5-fae8-8a66-cc5985b0baaf@suse.cz>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:43:48PM +0200, Vlastimil Babka wrote:
> On 5/29/23 12:33, Mel Gorman wrote:
> > On Thu, May 25, 2023 at 03:37:43PM +0200, Vlastimil Babka wrote:
> >> On 5/15/23 13:33, Mel Gorman wrote:
> >> > isolate_migratepages_block should mark a pageblock as skip if scanning
> >> > started on an aligned pageblock boundary but it only updates the skip
> >> > flag if the first migration candidate is also aligned. Tracing during
> >> > a compaction stress load (mmtests: workload-usemem-stress-numa-compact)
> >> > that many pageblocks are not marked skip causing excessive scanning of
> >> > blocks that had been recently checked. Update pageblock skip based on
> >> > "valid_page" which is set if scanning started on a pageblock boundary.
> >> > 
> >> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> >> 
> >> I wonder if this has an unintended side-effect that if we resume
> >> isolate_migratepages_block() of a partially compacted pageblock to finish
> >> it, test_and_set_skip() will now tell us to abort, because we already set
> >> the skip bit in the previous call. This would include the
> >> cc->finish_pageblock rescan cases.
> >> 
> >> So unless I miss something that already prevents that, I agree we should not
> >> tie setting the skip bit to pageblock_aligned(pfn), but maybe if we are not
> >> pageblock aligned, we should ignore the already-set skip bit, as it was most
> >> likely being set by us in the previous iteration and should not prevent us
> >> from finishing the pageblock?
> >> 
> > 
> > Hmm, I think you're right. While it should not hit the original bug,
> > migration candidates are missed until the next compaction scan which
> > could be tricky to detect. Something like this as a separate patch?
> > Build tested only but the intent is for an unaligned start to set the skip
> > bet if already unset but otherwise complete the scan. Like earlier fixes,
> > this might overscan some pageblocks in a given context but we are probably
> > hitting the limits on how compaction can run efficiently in the current
> > scheme without causing other side-effects :(
> 
> Yeah that should work! I think it should be even folded to 3/4 but if you
> want separate, fine too.
> 

I was not happy with the test results so limited the scope of the patch
which performed much better both in terms of absolute performance and
compaction activity. Are you still ok with this version?

Thanks

--8<--
mm: compaction: Update pageblock skip when first migration candidate is not at the start -fix

Vlastimil Babka pointed out the following problem with
mm-compaction-update-pageblock-skip-when-first-migration-candidate-is-not-at-the-start.patch

	I wonder if this has an unintended side-effect that if we resume
	isolate_migratepages_block() of a partially compacted pageblock
	to finish it, test_and_set_skip() will now tell us to abort,
	because we already set the skip bit in the previous call. This
	would include the cc->finish_pageblock rescan cases.

He is correct and a partial rescan as implemented in "mm, compaction:
finish pageblocks on complete migration failure" would abort
prematurely.

Test and set the skip bit when acquiring "exclusive access" to a pageblock
for migration but only abort if the calling context is rescanning to
finish a pageblock.

This is a fix for the mmotm patch
mm-compaction-update-pageblock-skip-when-first-migration-candidate-is-not-at-the-start.patch

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 91af6a8b7a98..300aa968a0cf 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1069,11 +1069,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 			lruvec_memcg_debug(lruvec, page_folio(page));
 
-			/* Try get exclusive access under lock */
+			/*
+			 * Try get exclusive access under lock. If marked for
+			 * skip, the scan is aborted unless the current context
+			 * is a rescan to reach the end of the pageblock.
+			 */
 			if (!skip_updated && valid_page) {
 				skip_updated = true;
-				if (test_and_set_skip(cc, valid_page))
+				if (test_and_set_skip(cc, valid_page) &&
+				    !cc->finish_pageblock) {
 					goto isolate_abort;
+				}
 			}
 
 			/*
