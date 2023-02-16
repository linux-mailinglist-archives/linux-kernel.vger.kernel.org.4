Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34FD699AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjBPRHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPRHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:07:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5570C165
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63BEDB826BA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 17:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F00C433D2;
        Thu, 16 Feb 2023 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676567235;
        bh=GtSTUkCXK1My+Jx8HkQB4IxgNaeWPvF4xmOLmoRW+tc=;
        h=From:To:Cc:Subject:Date:From;
        b=hDtS9I6sBwZ7jiOd2SRV98PtYO6lel6tRvet9AiiTVSp56uhyqy4PIr+I/pGKCvEj
         E0ghd10Lp0Qw70DYSVKtes6yVdWKEluq6gu18Ya8pysIb87ePVXn2y8Gtm6cVvnZx4
         Wd41bUwAtyWT0VkQB7qkq+cIkJrkLUkyIxzwHcns7RIW75Aq9esaQO135tuLbOQFcY
         hUjQeUmJeOaiCSi0ABLpCsVLajtV4Dqm9o6XFxgLkonixdH7Mw5p4xW8l7SOSOCjsq
         LTPoSxNvaQP9s/EjfeDnYX9hjdepE5O3OVvLqWmAmR5JIJBx6zt5As+hGE5kDqZFWc
         E9McxnLL7muLQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v3 mm-unstable] mm/memory_hotplug: cleanup return value handing in do_migrate_range()
Date:   Thu, 16 Feb 2023 17:07:03 +0000
Message-Id: <20230216170703.64574-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return value mechanism of do_migrate_range() is not very simple, while
no caller of the function checks the return value.  Make the function
return nothing to be more simple, and cleanup related unnecessary code.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v2
(https://lore.kernel.org/linux-mm/20230215230300.61125-1-sj@kernel.org/)
- Squash patches into one
- Add Acked-by from David and Reviewed-by from Baolin

Andrew, I saw you already added v2 of this patch into mm-unstable[1], but David
asked me to squash the two patches into this one.  Could you please replace
already merged patches with this one?

[1] https://lore.kernel.org/mm-commits/20230215233032.0CECAC433EF@smtp.kernel.org/

 mm/memory_hotplug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bcb0dc41c2f2..6df3072d11df 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1620,12 +1620,10 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-static int
-do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
+static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
 	struct page *page, *head;
-	int ret = 0;
 	LIST_HEAD(source);
 	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
@@ -1679,7 +1677,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 						    page_is_file_lru(page));
 
 		} else {
-			ret = -EBUSY;
 			if (__ratelimit(&migrate_rs)) {
 				pr_warn("failed to isolate pfn %lx\n", pfn);
 				dump_page(page, "isolation failed");
@@ -1693,6 +1690,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			.nmask = &nmask,
 			.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 		};
+		int ret;
 
 		/*
 		 * We have checked that migration range is on a single zone so
@@ -1721,8 +1719,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			putback_movable_pages(&source);
 		}
 	}
-
-	return ret;
 }
 
 static int __init cmdline_parse_movable_node(char *p)
-- 
2.25.1

