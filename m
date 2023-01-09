Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CDC6629B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbjAIPSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbjAIPRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:17:39 -0500
Received: from outbound-smtp03.blacknight.com (outbound-smtp03.blacknight.com [81.17.249.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8269E1EEEE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:16:45 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id EA77EC0D20
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:16:43 +0000 (GMT)
Received: (qmail 15870 invoked from network); 9 Jan 2023 15:16:43 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 9 Jan 2023 15:16:43 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/6 v2] Discard __GFP_ATOMIC
Date:   Mon,  9 Jan 2023 15:16:24 +0000
Message-Id: <20230109151631.24923-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since v1
o Split one patch						(vbabka)
o Improve OOM reserve handling					(vbabka)
o Fix __GFP_RECLAIM vs __GFP_DIRECT_RECLAIM			(vbabka)

Neil's patch has been residing in mm-unstable as commit 2fafb4fe8f7a
("mm: discard __GFP_ATOMIC") for a long time and recently brought up
again. Most recently, I was worried that __GFP_HIGH allocations could
use high-order atomic reserves which is unintentional but there was no
response so lets revisit -- this series reworks how min reserves are used,
protects highorder reserves and then finishes with Neil's patch with very
minor modifications so it fits on top.

There was a review discussion on renaming __GFP_DIRECT_RECLAIM to
__GFP_ALLOW_BLOCKING but I didn't think it was that big an issue and is
ortogonal to the removal of __GFP_ATOMIC.

There were some concerns about how the gfp flags affect the min reserves
but it never reached a solid conclusion so I made my own attempt.

The series tries to iron out some of the details on how reserves are
used. ALLOC_HIGH becomes ALLOC_MIN_RESERVE and ALLOC_HARDER becomes
ALLOC_NON_BLOCK and documents how the reserves are affected. For example,
ALLOC_NON_BLOCK (no direct reclaim) on its own allows 25% of the min reserve.
ALLOC_MIN_RESERVE (__GFP_HIGH) allows 50% and both combined allows deeper
access again. ALLOC_OOM allows access to 75%.

High-order atomic allocations are explicitly handled with the caveat that
no __GFP_ATOMIC flag means that any high-order allocation that specifies
GFP_HIGH and cannot enter direct reclaim will be treated as if it was
GFP_ATOMIC.

 Documentation/mm/balance.rst   |   2 +-
 drivers/iommu/tegra-smmu.c     |   4 +-
 include/linux/gfp_types.h      |  12 ++--
 include/trace/events/mmflags.h |   1 -
 lib/test_printf.c              |   8 +--
 mm/internal.h                  |  15 ++++-
 mm/page_alloc.c                | 103 ++++++++++++++++++++-------------
 tools/perf/builtin-kmem.c      |   1 -
 8 files changed, 86 insertions(+), 60 deletions(-)

-- 
2.35.3

