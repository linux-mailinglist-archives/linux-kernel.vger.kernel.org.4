Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DAD6629B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbjAIPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbjAIPRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:17:55 -0500
Received: from outbound-smtp46.blacknight.com (outbound-smtp46.blacknight.com [46.22.136.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE642BC7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:17:36 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id B3A48FA8C8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:17:35 +0000 (GMT)
Received: (qmail 18620 invoked from network); 9 Jan 2023 15:17:35 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 9 Jan 2023 15:17:35 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5/7] mm/page_alloc.c: Allow __GFP_NOFAIL requests deeper access to reserves
Date:   Mon,  9 Jan 2023 15:16:29 +0000
Message-Id: <20230109151631.24923-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230109151631.24923-1-mgorman@techsingularity.net>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently __GFP_NOFAIL allocations without any other flags can access 25%
of the reserves but these requests imply that the system cannot make forward
progress until the allocation succeeds. Allow __GFP_NOFAIL access to 75%
of the min reserve.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6f41b84a97ac..d2df78f5baa2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5308,7 +5308,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * could deplete whole memory reserves which would just make
 		 * the situation worse
 		 */
-		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
+		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE|ALLOC_HARDER, ac);
 		if (page)
 			goto got_pg;
 
-- 
2.35.3

