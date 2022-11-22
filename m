Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8837E633D40
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiKVNNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiKVNM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:12:56 -0500
Received: from outbound-smtp12.blacknight.com (outbound-smtp12.blacknight.com [46.22.139.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FB72715B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:12:53 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id A1E6E1C37FA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 13:12:52 +0000 (GMT)
Received: (qmail 21501 invoked from network); 22 Nov 2022 13:12:52 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 22 Nov 2022 13:12:52 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] mm/page_alloc: Leave IRQs enabled for per-cpu page allocations -fix
Date:   Tue, 22 Nov 2022 13:12:28 +0000
Message-Id: <20221122131229.5263-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221122131229.5263-1-mgorman@techsingularity.net>
References: <20221122131229.5263-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by Vlastimil Babka, the migratetype might be wrong if a PCP was
not locked so check the migrate type early. Similarly the !pcp check is
generally unlikely so explicitly tagging it makes sense.

This is a fix for the mm-unstable patch
mm-page_alloc-leave-irqs-enabled-for-per-cpu-page-allocations.patch

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 323fec05c4c6..445066617204 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3516,6 +3516,7 @@ void free_unref_page_list(struct list_head *list)
 		struct zone *zone = page_zone(page);
 
 		list_del(&page->lru);
+		migratetype = get_pcppage_migratetype(page);
 
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
@@ -3530,7 +3531,7 @@ void free_unref_page_list(struct list_head *list)
 			 */
 			pcp_trylock_prepare(UP_flags);
 			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
-			if (!pcp) {
+			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, page, page_to_pfn(page),
 					      0, migratetype, FPI_NONE);
@@ -3545,7 +3546,6 @@ void free_unref_page_list(struct list_head *list)
 		 * Non-isolated types over MIGRATE_PCPTYPES get added
 		 * to the MIGRATE_MOVABLE pcp list.
 		 */
-		migratetype = get_pcppage_migratetype(page);
 		if (unlikely(migratetype >= MIGRATE_PCPTYPES))
 			migratetype = MIGRATE_MOVABLE;
 
-- 
2.35.3

