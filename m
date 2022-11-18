Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E0B62F253
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbiKRKRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241435AbiKRKRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:17:38 -0500
Received: from outbound-smtp29.blacknight.com (outbound-smtp29.blacknight.com [81.17.249.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A846153F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:17:36 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 2883ABEC19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:17:35 +0000 (GMT)
Received: (qmail 3723 invoked from network); 18 Nov 2022 10:17:35 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 18 Nov 2022 10:17:34 -0000
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
Subject: [PATCH 1/2] mm/page_alloc: Always remove pages from temporary list
Date:   Fri, 18 Nov 2022 10:17:13 +0000
Message-Id: <20221118101714.19590-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221118101714.19590-1-mgorman@techsingularity.net>
References: <20221118101714.19590-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_unref_page_list() has neglected to remove pages properly from the list
of pages to free since forever. It works by coincidence because list_add
happened to do the right thing adding the pages to just the PCP lists.
However, a later patch added pages to either the PCP list or the zone list
but only properly deleted the page from the list in one path leading to
list corruption and a subsequent failure. As a preparation patch, always
delete the pages from one list properly before adding to another.  On its
own, this fixes nothing although it adds a fractional amount of overhead
but is critical to the next patch.

Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 218b28ee49ed..1ec54173b8d4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3546,6 +3546,8 @@ void free_unref_page_list(struct list_head *list)
 	list_for_each_entry_safe(page, next, list, lru) {
 		struct zone *zone = page_zone(page);
 
+		list_del(&page->lru);
+
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
 			if (pcp)
-- 
2.35.3

