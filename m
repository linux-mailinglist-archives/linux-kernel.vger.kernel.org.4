Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3716E6CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjDRTOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjDRTNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:13:55 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869EAC65A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:30 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id dd8so17376152qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845209; x=1684437209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ziCYFLP0gIvrTMKVGAOENHj/570OA5tLu/LhfprcHs=;
        b=tASioUHSg0O8JLU9lmpT2o9qieQ5UPbSCjZ2FFf4DPmc+sm1lG5E2sefokRjX82PWv
         /naa0xXtkW6heFV0tkRw9s2v57ltr8jqTBis+P8WeOGGhuTUTbP/NaZa2KY0naFlxm+B
         W0CWp0uB41dkHuQ1/kpuzy+c28wZgenF79DWz7OZV3qE+8W75G/CgO9SPnK2fL9a320t
         yXKyc58RVcAaAikakCIJxYNwp+SzurktP4fqmo2U9wFIB3ZelkMdhT468zPi5iN0Uonq
         qlshkMrXESVN82SilYYT0M1b22r6Yho1HwmEKjRb0CLDZMxgSBPEuAYI8Xtu54okMtlA
         dd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845209; x=1684437209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ziCYFLP0gIvrTMKVGAOENHj/570OA5tLu/LhfprcHs=;
        b=cBMt7pYOKWpCq5hkZndrgGT5rsQcIj7aiHTxElqk08Gn3VfEfe5mglVMMBcmBS36vS
         ikusUusewfwZyhkytx/trnBKCm71+DiEEb4xamilOgFVb5F55yXTxwm2fj/tWviZGUbw
         1pRLy7AJ487bha5RWru6lMf1XvhIOaawlCdbD0yE2ZP5Rm22cyhePvoZaYsOrR32C1/o
         Uxy7PQUSGCooSQ6bLLH1z3ZSFkYrJCxqbSfezr2tCa7FKZ6xOtyq9Fek1DOxMTbXvS1+
         Sq2ih8z6qkEQQK0DBnaARSxf3HYLAT/YpyMZOQRgwPS/25fUZc9hBUfzUne0K0XvkPhy
         SKaA==
X-Gm-Message-State: AAQBX9eIimlX1NO0BZiUtI0YcFHXhSQ0TN4sfQzjUS3EshIu7uDzS+dq
        yKR0TkodogOZT8UagBOSph8/aw==
X-Google-Smtp-Source: AKy350ZOi+88hEvm9GEFxPHg078nMJgdO2hJcrbQjNkq+nM1p74G7tq0XzGJcBNJQ1SbVH8WMthykg==
X-Received: by 2002:a05:6214:f23:b0:5ef:77c4:4540 with SMTP id iw3-20020a0562140f2300b005ef77c44540mr16271521qvb.27.1681845209552;
        Tue, 18 Apr 2023 12:13:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id dr3-20020a05621408e300b005dd8b9345dbsm3884921qvb.115.2023.04.18.12.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:29 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 09/26] mm: page_alloc: move expand() above compaction_capture()
Date:   Tue, 18 Apr 2023 15:12:56 -0400
Message-Id: <20230418191313.268131-10-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch will allow compaction to capture from
larger-than-requested page blocks and free the remainder.

Rearrange the code in advance to make the diff more readable. No
functional change.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 186 ++++++++++++++++++++++++------------------------
 1 file changed, 93 insertions(+), 93 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8e5996f8b4b4..cd86f80d7bbe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -950,61 +950,6 @@ static inline void set_buddy_order(struct page *page, unsigned int order)
 	__SetPageBuddy(page);
 }
 
-#ifdef CONFIG_COMPACTION
-static inline struct capture_control *task_capc(struct zone *zone)
-{
-	struct capture_control *capc = current->capture_control;
-
-	return unlikely(capc && capc->cc) &&
-		!(current->flags & PF_KTHREAD) &&
-		!capc->page &&
-		capc->cc->zone == zone ? capc : NULL;
-}
-
-static inline bool
-compaction_capture(struct capture_control *capc, struct page *page,
-		   int order, int migratetype)
-{
-	if (!capc || order != capc->cc->order)
-		return false;
-
-	/* Do not accidentally pollute CMA or isolated regions*/
-	if (is_migrate_cma(migratetype) ||
-	    is_migrate_isolate(migratetype))
-		return false;
-
-	if (order >= pageblock_order) {
-		migratetype = capc->migratetype;
-		change_pageblock_range(page, order, migratetype);
-	} else if (migratetype == MIGRATE_MOVABLE) {
-		/*
-		 * Do not let lower order allocations pollute a
-		 * movable pageblock.  This might let an unmovable
-		 * request use a reclaimable pageblock and vice-versa
-		 * but no more than normal fallback logic which can
-		 * have trouble finding a high-order free page.
-		 */
-		return false;
-	}
-
-	capc->page = page;
-	return true;
-}
-
-#else
-static inline struct capture_control *task_capc(struct zone *zone)
-{
-	return NULL;
-}
-
-static inline bool
-compaction_capture(struct capture_control *capc, struct page *page,
-		   int order, int migratetype)
-{
-	return false;
-}
-#endif /* CONFIG_COMPACTION */
-
 static inline void account_freepages(struct page *page, struct zone *zone,
 				     int nr_pages, int migratetype)
 {
@@ -1072,6 +1017,99 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
 	account_freepages(page, zone, -(1 << order), migratetype);
 }
 
+/*
+ * The order of subdivision here is critical for the IO subsystem.
+ * Please do not alter this order without good reasons and regression
+ * testing. Specifically, as large blocks of memory are subdivided,
+ * the order in which smaller blocks are delivered depends on the order
+ * they're subdivided in this function. This is the primary factor
+ * influencing the order in which pages are delivered to the IO
+ * subsystem according to empirical testing, and this is also justified
+ * by considering the behavior of a buddy system containing a single
+ * large block of memory acted on by a series of small allocations.
+ * This behavior is a critical factor in sglist merging's success.
+ *
+ * -- nyc
+ */
+static inline void expand(struct zone *zone, struct page *page,
+	int low, int high, int migratetype)
+{
+	unsigned long size = 1 << high;
+
+	while (high > low) {
+		high--;
+		size >>= 1;
+		VM_BUG_ON_PAGE(bad_range(zone, &page[size]), &page[size]);
+
+		/*
+		 * Mark as guard pages (or page), that will allow to
+		 * merge back to allocator when buddy will be freed.
+		 * Corresponding page table entries will not be touched,
+		 * pages will stay not present in virtual address space
+		 */
+		if (set_page_guard(zone, &page[size], high))
+			continue;
+
+		add_to_free_list(&page[size], zone, high, migratetype, false);
+		set_buddy_order(&page[size], high);
+	}
+}
+
+#ifdef CONFIG_COMPACTION
+static inline struct capture_control *task_capc(struct zone *zone)
+{
+	struct capture_control *capc = current->capture_control;
+
+	return unlikely(capc && capc->cc) &&
+		!(current->flags & PF_KTHREAD) &&
+		!capc->page &&
+		capc->cc->zone == zone ? capc : NULL;
+}
+
+static inline bool
+compaction_capture(struct capture_control *capc, struct page *page,
+		   int order, int migratetype)
+{
+	if (!capc || order != capc->cc->order)
+		return false;
+
+	/* Do not accidentally pollute CMA or isolated regions*/
+	if (is_migrate_cma(migratetype) ||
+	    is_migrate_isolate(migratetype))
+		return false;
+
+	if (order >= pageblock_order) {
+		migratetype = capc->migratetype;
+		change_pageblock_range(page, order, migratetype);
+	} else if (migratetype == MIGRATE_MOVABLE) {
+		/*
+		 * Do not let lower order allocations pollute a
+		 * movable pageblock.  This might let an unmovable
+		 * request use a reclaimable pageblock and vice-versa
+		 * but no more than normal fallback logic which can
+		 * have trouble finding a high-order free page.
+		 */
+		return false;
+	}
+
+	capc->page = page;
+	return true;
+}
+
+#else
+static inline struct capture_control *task_capc(struct zone *zone)
+{
+	return NULL;
+}
+
+static inline bool
+compaction_capture(struct capture_control *capc, struct page *page,
+		   int order, int migratetype)
+{
+	return false;
+}
+#endif /* CONFIG_COMPACTION */
+
 /*
  * If this is not the largest possible page, check if the buddy
  * of the next-highest order is free. If it is, it's possible
@@ -2345,44 +2383,6 @@ void __init init_cma_reserved_pageblock(struct page *page)
 }
 #endif
 
-/*
- * The order of subdivision here is critical for the IO subsystem.
- * Please do not alter this order without good reasons and regression
- * testing. Specifically, as large blocks of memory are subdivided,
- * the order in which smaller blocks are delivered depends on the order
- * they're subdivided in this function. This is the primary factor
- * influencing the order in which pages are delivered to the IO
- * subsystem according to empirical testing, and this is also justified
- * by considering the behavior of a buddy system containing a single
- * large block of memory acted on by a series of small allocations.
- * This behavior is a critical factor in sglist merging's success.
- *
- * -- nyc
- */
-static inline void expand(struct zone *zone, struct page *page,
-	int low, int high, int migratetype)
-{
-	unsigned long size = 1 << high;
-
-	while (high > low) {
-		high--;
-		size >>= 1;
-		VM_BUG_ON_PAGE(bad_range(zone, &page[size]), &page[size]);
-
-		/*
-		 * Mark as guard pages (or page), that will allow to
-		 * merge back to allocator when buddy will be freed.
-		 * Corresponding page table entries will not be touched,
-		 * pages will stay not present in virtual address space
-		 */
-		if (set_page_guard(zone, &page[size], high))
-			continue;
-
-		add_to_free_list(&page[size], zone, high, migratetype, false);
-		set_buddy_order(&page[size], high);
-	}
-}
-
 static void check_new_page_bad(struct page *page)
 {
 	if (unlikely(page->flags & __PG_HWPOISON)) {
-- 
2.39.2

