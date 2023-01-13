Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8A766955D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbjAMLTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241326AbjAMLR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:17:57 -0500
Received: from outbound-smtp26.blacknight.com (outbound-smtp26.blacknight.com [81.17.249.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063CC7D9D5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:12:49 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 8A53ECAE82
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:12:48 +0000 (GMT)
Received: (qmail 9303 invoked from network); 13 Jan 2023 11:12:48 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 13 Jan 2023 11:12:48 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/6] mm/page_alloc: Treat RT tasks similar to __GFP_HIGH
Date:   Fri, 13 Jan 2023 11:12:13 +0000
Message-Id: <20230113111217.14134-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230113111217.14134-1-mgorman@techsingularity.net>
References: <20230113111217.14134-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RT tasks are allowed to dip below the min reserve but ALLOC_HARDER is
typically combined with ALLOC_MIN_RESERVE so RT tasks are a little
unusual. While there is some justification for allowing RT tasks
access to memory reserves, there is a strong chance that a RT task
that is also under memory pressure is at risk of missing deadlines
anyway. Relax how much reserves an RT task can access by treating
it the same as __GFP_HIGH allocations.

Note that in a future kernel release that the RT special casing will be
removed. Hard realtime tasks should be locking down resources in advance
and ensuring enough memory is available. Even a soft-realtime task like
audio or video live decoding which cannot jitter should be allocating both
memory and any disk space required up-front before the recording starts
instead of relying on reserves. At best, reserve access will only delay
the problem by a very short interval.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 244c1e675dc8..0040b4e00913 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4847,7 +4847,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
 		 */
 		alloc_flags &= ~ALLOC_CPUSET;
 	} else if (unlikely(rt_task(current)) && in_task())
-		alloc_flags |= ALLOC_HARDER;
+		alloc_flags |= ALLOC_MIN_RESERVE;
 
 	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
 
-- 
2.35.3

