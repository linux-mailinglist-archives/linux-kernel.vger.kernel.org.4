Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155C8720267
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjFBMsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjFBMse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:48:34 -0400
Received: from outbound-smtp02.blacknight.com (outbound-smtp02.blacknight.com [81.17.249.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C0F1AD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:48:29 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 35BC9BABE0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:48:28 +0100 (IST)
Received: (qmail 9395 invoked from network); 2 Jun 2023 12:48:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Jun 2023 12:48:27 -0000
Date:   Fri, 2 Jun 2023 13:48:25 +0100
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
Message-ID: <20230602124825.24a775kwwuf4rs6v@techsingularity.net>
References: <20230515113344.6869-1-mgorman@techsingularity.net>
 <20230515113344.6869-4-mgorman@techsingularity.net>
 <e87a9797-c8ce-1959-884a-7f791adeaafc@suse.cz>
 <20230529103342.esek6r5fvmft2nky@techsingularity.net>
 <6695b7e5-9fa5-fae8-8a66-cc5985b0baaf@suse.cz>
 <20230602111622.swtxhn6lu2qwgrwq@techsingularity.net>
 <152e0730-0ddc-a1f8-7122-275d51741a1d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <152e0730-0ddc-a1f8-7122-275d51741a1d@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 02:19:00PM +0200, Vlastimil Babka wrote:
> On 6/2/23 13:16, Mel Gorman wrote:
> > On Mon, May 29, 2023 at 02:43:48PM +0200, Vlastimil Babka wrote:
> >> On 5/29/23 12:33, Mel Gorman wrote:
> >> > On Thu, May 25, 2023 at 03:37:43PM +0200, Vlastimil Babka wrote:
> >> >> On 5/15/23 13:33, Mel Gorman wrote:
> >> >> > isolate_migratepages_block should mark a pageblock as skip if scanning
> >> >> > started on an aligned pageblock boundary but it only updates the skip
> >> >> > flag if the first migration candidate is also aligned. Tracing during
> >> >> > a compaction stress load (mmtests: workload-usemem-stress-numa-compact)
> >> >> > that many pageblocks are not marked skip causing excessive scanning of
> >> >> > blocks that had been recently checked. Update pageblock skip based on
> >> >> > "valid_page" which is set if scanning started on a pageblock boundary.
> >> >> > 
> >> >> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> >> >> 
> >> >> I wonder if this has an unintended side-effect that if we resume
> >> >> isolate_migratepages_block() of a partially compacted pageblock to finish
> >> >> it, test_and_set_skip() will now tell us to abort, because we already set
> >> >> the skip bit in the previous call. This would include the
> >> >> cc->finish_pageblock rescan cases.
> >> >> 
> >> >> So unless I miss something that already prevents that, I agree we should not
> >> >> tie setting the skip bit to pageblock_aligned(pfn), but maybe if we are not
> >> >> pageblock aligned, we should ignore the already-set skip bit, as it was most
> >> >> likely being set by us in the previous iteration and should not prevent us
> >> >> from finishing the pageblock?
> >> >> 
> >> > 
> >> > Hmm, I think you're right. While it should not hit the original bug,
> >> > migration candidates are missed until the next compaction scan which
> >> > could be tricky to detect. Something like this as a separate patch?
> >> > Build tested only but the intent is for an unaligned start to set the skip
> >> > bet if already unset but otherwise complete the scan. Like earlier fixes,
> >> > this might overscan some pageblocks in a given context but we are probably
> >> > hitting the limits on how compaction can run efficiently in the current
> >> > scheme without causing other side-effects :(
> >> 
> >> Yeah that should work! I think it should be even folded to 3/4 but if you
> >> want separate, fine too.
> >> 
> > 
> > I was not happy with the test results so limited the scope of the patch
> > which performed much better both in terms of absolute performance and
> > compaction activity.
> 
> That's surprising. Does that mean that if we isolate COMPACT_CLUSTER_MAX
> pages, migrate them without failing, but it's not enough to succeed (i.e.
> there are more pages we need to migrate to free up a whole pageblock), it's
> better to give up on the rest of the pageblock rather than continue?

I don't have precise enough data to answer that with certainty but probably
yes, at least in terms of scan activity. The first version had spikes of
pages scanned for migration that are not always reproducible and not on
all machines.

> As
> that's AFAIU the scenario where cc->finish_pageblock is false when we
> revisit an unfinished pageblock.
> 
> > Are you still ok with this version?
> 
> It's better than previously in that cc->finish_pageblock == true case is not
> sabotaged anymore. But the result as described above seems to be a weird
> non-intuitive and non-obvious heuristic. How did the test differences look like?
> 

5 machines were tested in all (different Intel and AMD generations),
2 showed unexpected spikes in scan activity. 1 showed high migration
scan counts for workloads workload-thpchallenge-kernel-build-xfs
and workload-usemem-stress-numa-compact. They are both basically
compaction stressors with the first one using a kernel build
in the background to generate noise. For the second machine, only
workload-usemem-stress-numa-compact was affected. In all other test cases
and machines, the patches were equivalent in terms of behaviour but the
extreme counter-examples led be to conclude the fix should be as constrained
as possible unless there is a good reason to do otherwise.

> > Vlastimil Babka pointed out the following problem with
> > mm-compaction-update-pageblock-skip-when-first-migration-candidate-is-not-at-the-start.patch
> > 
> > 	I wonder if this has an unintended side-effect that if we resume
> > 	isolate_migratepages_block() of a partially compacted pageblock
> > 	to finish it, test_and_set_skip() will now tell us to abort,
> > 	because we already set the skip bit in the previous call. This
> > 	would include the cc->finish_pageblock rescan cases.
> > 
> > He is correct and a partial rescan as implemented in "mm, compaction:
> > finish pageblocks on complete migration failure" would abort
> > prematurely.
> > 
> > Test and set the skip bit when acquiring "exclusive access" to a pageblock
> > for migration but only abort if the calling context is rescanning to
> > finish a pageblock.
> 
> Should it say NOT rescanning to finish a pageblock?
> 

Yep, it should. The sentence was a last minute update before pushing
send :(

-- 
Mel Gorman
SUSE Labs
