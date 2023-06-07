Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92C0725F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbjFGMZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbjFGMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:24:58 -0400
Received: from outbound-smtp36.blacknight.com (outbound-smtp36.blacknight.com [46.22.139.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5191734
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:24:52 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp36.blacknight.com (Postfix) with ESMTPS id 7E2191CA3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:24:50 +0100 (IST)
Received: (qmail 5691 invoked from network); 7 Jun 2023 12:24:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Jun 2023 12:24:50 -0000
Date:   Wed, 7 Jun 2023 13:24:48 +0100
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
Message-ID: <20230607122448.nvyxtviyuawk3rfy@techsingularity.net>
References: <20230515113344.6869-1-mgorman@techsingularity.net>
 <20230515113344.6869-4-mgorman@techsingularity.net>
 <e87a9797-c8ce-1959-884a-7f791adeaafc@suse.cz>
 <20230529103342.esek6r5fvmft2nky@techsingularity.net>
 <6695b7e5-9fa5-fae8-8a66-cc5985b0baaf@suse.cz>
 <20230602111622.swtxhn6lu2qwgrwq@techsingularity.net>
 <152e0730-0ddc-a1f8-7122-275d51741a1d@suse.cz>
 <20230602124825.24a775kwwuf4rs6v@techsingularity.net>
 <2c802986-3726-f79c-6383-cc03adb9fb0c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <2c802986-3726-f79c-6383-cc03adb9fb0c@suse.cz>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 03:11:27PM +0200, Vlastimil Babka wrote:
> On 6/2/23 14:48, Mel Gorman wrote:
> > On Fri, Jun 02, 2023 at 02:19:00PM +0200, Vlastimil Babka wrote:
> >> On 6/2/23 13:16, Mel Gorman wrote:
> >> > On Mon, May 29, 2023 at 02:43:48PM +0200, Vlastimil Babka wrote:
> >> >> On 5/29/23 12:33, Mel Gorman wrote:
> >> >> > On Thu, May 25, 2023 at 03:37:43PM +0200, Vlastimil Babka wrote:
> >> >> >> On 5/15/23 13:33, Mel Gorman wrote:
> >> >> >> > isolate_migratepages_block should mark a pageblock as skip if scanning
> >> >> >> > started on an aligned pageblock boundary but it only updates the skip
> >> >> >> > flag if the first migration candidate is also aligned. Tracing during
> >> >> >> > a compaction stress load (mmtests: workload-usemem-stress-numa-compact)
> >> >> >> > that many pageblocks are not marked skip causing excessive scanning of
> >> >> >> > blocks that had been recently checked. Update pageblock skip based on
> >> >> >> > "valid_page" which is set if scanning started on a pageblock boundary.
> >> >> >> > 
> >> >> >> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> >> >> >> 
> >> >> >> I wonder if this has an unintended side-effect that if we resume
> >> >> >> isolate_migratepages_block() of a partially compacted pageblock to finish
> >> >> >> it, test_and_set_skip() will now tell us to abort, because we already set
> >> >> >> the skip bit in the previous call. This would include the
> >> >> >> cc->finish_pageblock rescan cases.
> >> >> >> 
> >> >> >> So unless I miss something that already prevents that, I agree we should not
> >> >> >> tie setting the skip bit to pageblock_aligned(pfn), but maybe if we are not
> >> >> >> pageblock aligned, we should ignore the already-set skip bit, as it was most
> >> >> >> likely being set by us in the previous iteration and should not prevent us
> >> >> >> from finishing the pageblock?
> >> >> >> 
> >> >> > 
> >> >> > Hmm, I think you're right. While it should not hit the original bug,
> >> >> > migration candidates are missed until the next compaction scan which
> >> >> > could be tricky to detect. Something like this as a separate patch?
> >> >> > Build tested only but the intent is for an unaligned start to set the skip
> >> >> > bet if already unset but otherwise complete the scan. Like earlier fixes,
> >> >> > this might overscan some pageblocks in a given context but we are probably
> >> >> > hitting the limits on how compaction can run efficiently in the current
> >> >> > scheme without causing other side-effects :(
> >> >> 
> >> >> Yeah that should work! I think it should be even folded to 3/4 but if you
> >> >> want separate, fine too.
> >> >> 
> >> > 
> >> > I was not happy with the test results so limited the scope of the patch
> >> > which performed much better both in terms of absolute performance and
> >> > compaction activity.
> >> 
> >> That's surprising. Does that mean that if we isolate COMPACT_CLUSTER_MAX
> >> pages, migrate them without failing, but it's not enough to succeed (i.e.
> >> there are more pages we need to migrate to free up a whole pageblock), it's
> >> better to give up on the rest of the pageblock rather than continue?
> > 
> > I don't have precise enough data to answer that with certainty but probably
> > yes, at least in terms of scan activity. The first version had spikes of
> > pages scanned for migration that are not always reproducible and not on
> > all machines.
> 
> Well, that kinda sucks. So for the patch (with adding the missing NOT below).
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> But in raises a question whether we should terminate compaction under the
> right conditions after a successful migration immediately, rather than
> invoke another iteration of isolate_migratepages_block() where we could skip
> over some pages uselessly only to abort at first valid page due to the skip bit.
> It would save some cycles and be much more obvious than now, where anyone
> trying to understand how it works in detail might conclude it's an oversight?
> 

It sounds like a solid idea and would be a good standalone patch with
the usual supporting data. At a quick glance, the check for a page
stored on compact_control happens surprisingly late which makes me think
we probably over-compact in direct compaction in particular. It would
need supporting data because it probably means that compaction cost gets
spread over multiple tasks requiring high-order pages instead of one
unlucky task doing compaction works that unrelated tasks indirectly
benefit from. It's probably more sensible behaviour that tasks requiring
high-order pages pay the cost if kcompactd cannot keep up but supporting
data would tell us one way or the other.

-- 
Mel Gorman
SUSE Labs
