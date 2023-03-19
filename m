Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0786C05D1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCSWAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCSWAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:00:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AC914E97;
        Sun, 19 Mar 2023 15:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E836A611CD;
        Sun, 19 Mar 2023 22:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C11FC433A0;
        Sun, 19 Mar 2023 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263229;
        bh=zekLhry5fbzdsyyFVJESg5+PbdXiqA638EXDFWo0PPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXkUKnzydDJ71mPtZtGDkbDpHakn4+vm9e5hsj9ZXIp26esqmpKA0HKya3tWcGwU9
         hHaJ6/V57EkzRpGi8lnjrEYAjO5VItMs/Md0bbdadjwge+a9/WTyHI1abD1pUrKKYQ
         h9K7yRauBXU7Tw8Mq2jgvBEw9AE21CER4YwrQv5CWjBxfQ9UHdb/tQXfSG95r6LaJQ
         vBhjliYse44G7HvTmgehhaqQXcvX1kGezbx65UwsYMW0fffJYTYM3h1pRApRzerWw0
         c/X95FgbZkXr+iJhGJ6iUvnfoAIV/WrZXrD5FY4iZUFuWW7Tdw/Lw0s9FGHu1TLONU
         lRE/6FdnqUlYQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 02/15] mm/cma: move init_cma_reserved_pages() to cma.c and make it static
Date:   Sun, 19 Mar 2023 23:59:55 +0200
Message-Id: <20230319220008.2138576-3-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319220008.2138576-1-rppt@kernel.org>
References: <20230319220008.2138576-1-rppt@kernel.org>
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

init_cma_reserved_pages() only used in cma.c, no point of having it in
page_alloc.c.

Move init_cma_reserved_pages() to cma.c and make it static.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/gfp.h |  5 -----
 mm/cma.c            | 21 +++++++++++++++++++++
 mm/page_alloc.c     | 21 ---------------------
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 65a78773dcca..7c554e4bd49f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -361,9 +361,4 @@ extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 #endif
 void free_contig_range(unsigned long pfn, unsigned long nr_pages);
 
-#ifdef CONFIG_CMA
-/* CMA stuff */
-extern void init_cma_reserved_pageblock(struct page *page);
-#endif
-
 #endif /* __LINUX_GFP_H */
diff --git a/mm/cma.c b/mm/cma.c
index a7263aa02c92..ce08fb9825b4 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -31,8 +31,10 @@
 #include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/kmemleak.h>
+#include <linux/page-isolation.h>
 #include <trace/events/cma.h>
 
+#include "internal.h"
 #include "cma.h"
 
 struct cma cma_areas[MAX_CMA_AREAS];
@@ -93,6 +95,25 @@ static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,
 	spin_unlock_irqrestore(&cma->lock, flags);
 }
 
+/* Free whole pageblock and set its migration type to MIGRATE_CMA. */
+static void init_cma_reserved_pageblock(struct page *page)
+{
+	unsigned i = pageblock_nr_pages;
+	struct page *p = page;
+
+	do {
+		__ClearPageReserved(p);
+		set_page_count(p, 0);
+	} while (++p, --i);
+
+	set_pageblock_migratetype(page, MIGRATE_CMA);
+	set_page_refcounted(page);
+	__free_pages(page, pageblock_order);
+
+	adjust_managed_page_count(page, pageblock_nr_pages);
+	page_zone(page)->cma_pages += pageblock_nr_pages;
+}
+
 static void __init cma_activate_area(struct cma *cma)
 {
 	unsigned long base_pfn = cma->base_pfn, pfn;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 87d760236dba..22e3da842e3f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2280,27 +2280,6 @@ void __init page_alloc_init_late(void)
 		set_zone_contiguous(zone);
 }
 
-#ifdef CONFIG_CMA
-/* Free whole pageblock and set its migration type to MIGRATE_CMA. */
-void __init init_cma_reserved_pageblock(struct page *page)
-{
-	unsigned i = pageblock_nr_pages;
-	struct page *p = page;
-
-	do {
-		__ClearPageReserved(p);
-		set_page_count(p, 0);
-	} while (++p, --i);
-
-	set_pageblock_migratetype(page, MIGRATE_CMA);
-	set_page_refcounted(page);
-	__free_pages(page, pageblock_order);
-
-	adjust_managed_page_count(page, pageblock_nr_pages);
-	page_zone(page)->cma_pages += pageblock_nr_pages;
-}
-#endif
-
 /*
  * The order of subdivision here is critical for the IO subsystem.
  * Please do not alter this order without good reasons and regression
-- 
2.35.1

