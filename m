Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3C6D79BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbjDEKbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDEKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:31:47 -0400
Received: from outbound-smtp14.blacknight.com (outbound-smtp14.blacknight.com [46.22.139.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6955435BF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:31:45 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 8AF091C429D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:31:43 +0100 (IST)
Received: (qmail 7474 invoked from network); 5 Apr 2023 10:31:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Apr 2023 10:31:43 -0000
Date:   Wed, 5 Apr 2023 11:31:41 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, vbabka@suse.cz,
        william.lam@bytedance.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: compaction: consider the number of scanning
 compound pages in isolate fail path
Message-ID: <20230405103141.yu7p53psbvstv6kg@techsingularity.net>
References: <73d6250a90707649cc010731aedc27f946d722ed.1678962352.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <73d6250a90707649cc010731aedc27f946d722ed.1678962352.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 07:06:46PM +0800, Baolin Wang wrote:
> The commit b717d6b93b54 ("mm: compaction: include compound page count
> for scanning in pageblock isolation") had added compound page statistics
> for scanning in pageblock isolation, to make sure the number of scanned
> pages are always larger than the number of isolated pages when isolating
> mirgratable or free pageblock.
> 
> However, when failed to isolate the pages when scanning the mirgratable or
> free pageblock, the isolation failure path did not consider the scanning
> statistics of the compound pages, which can show the incorrect number of
> scanned pages in tracepoints or the vmstats to make people confusing about
> the page scanning pressure in memory compaction.
> 
> Thus we should take into account the number of scanning pages when failed
> to isolate the compound pages to make the statistics accurate.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

However, the patch highlights weakeness in the tracepoints and how
useful they are.

Minimally, I think that the change might be misleading when comparing
tracepoints across kernel versions as it'll be necessary to check the exact
meaning of nr_scanned for a given kernel version. That's not a killer problem
as such, just a hazard if using an analysis tool comparing kernel versions.

As an example, consider this

                if (PageCompound(page)) {
                        const unsigned int order = compound_order(page);
                                
                        if (likely(order < MAX_ORDER)) {
                                blockpfn += (1UL << order) - 1;
                                cursor += (1UL << order) - 1;
				nr_scanned += compound_nr(page) - 1;		 <<< patch adds
                        }
                        goto isolate_fail;
                }

Only the head page is "scanned", the tail pages are not scanned so
accounting for them as "scanned" is not an accurate reflection of the
amount of work done. Isolation is different because the compound pages
isolated is a prediction of how much work is necessary to migrate that
page as it's obviously more work to copy 2M of data than 4K. The migrated
pages combined with isolation then can measure efficiency of isolation
vs migration although imperfectly as isolation is a span while migration
probably fails at the head page.

The same applies when skipping buddies, the tail pages are not scanned
so skipping them is not additional work.

Everything depends on what the tracepoint is being used for. If it's a
measure of work done, then accounting for skipped tail pages over-estimates
the amount of work. However, if the intent is to measure efficiency of
isolation vs migration then the "span" scanned is more useful.

None of this kills the patch, it only notes that the tracepoints as-is
probably cannot answer all relevant questions, most of which are only
relevant when making a modification to compaction in general. The patch
means that an unspecified pressure metric can be derived (maybe interesting
to sysadmins) but loses a metric about time spent on scanning (maybe
interesting to developers writing a patch). Of those concerns, sysadmins
are probably more common so the patch is acceptable but some care will be
need if modifying the tracepoints further if it enables one type of
analysis at the cost of another.

-- 
Mel Gorman
SUSE Labs
