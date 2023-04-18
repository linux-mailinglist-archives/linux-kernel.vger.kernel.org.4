Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CCD6E6CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjDRTOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjDRTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:13:49 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BCAAD2F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id op30so18258741qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845207; x=1684437207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13UUYwnQDW8sv6Z5U/gfNQWUn2NaHbpFqCKtGCMsvrI=;
        b=KYPCQZ61APdNYs9D70nl3yomvGcC38mIMM4ac/0Jxqh0MQrsikJDyqz8kNAKqw9iC1
         1bmnq4F1MqaGWpFLA8ADTd1KOLEiSxDVYMfswSH15y4crGrkoG6QG/Dr8TRu4HNJqULs
         3ondml+qKSu04IkF3zQ8fUI8BpomkXLoFtEZTlNb5W8qR5dw6PS9O8KDT/9Kxlz6inFB
         Zoapu1IejZKECDPcQcl9q/KpgYWJmZLUxb2uAQzBruh9kz4IWlq+6bWZCm5vzL8tOPu8
         21csNAuzKAdA/rLnXVEEXuAuDwsTm2WP87lOxN6ifFsa6PFpUcCMCZg4Et1TQULauXd7
         sXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845207; x=1684437207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13UUYwnQDW8sv6Z5U/gfNQWUn2NaHbpFqCKtGCMsvrI=;
        b=bgVPfgiBLM40POG/QOadjZxIFJ7Hfm9xKwTemnmgYawprJcBm7ElfD2N4Xc15Pjg6C
         jjKro0OW/V+Cwk5VqIze65MUIbnLEcVs6XuJYEka5ODSr5j7rIelDsxvODbTFsusxuHd
         +++W60DiugVNuU0iJvYmTW5nHA2GoyZFJ+LD6nwFpm9OqEp4LJ4+veWXwNiaEIu9JJwz
         V6r/CChZn1nyyBF3LdMbt8tiYZFf09jNOHbs3ynLepiAKUMkT3C8k4COZRG6MQXU5jTT
         ef4FrGUtSK4N5f8apIKioV5xnAsS0RHLO6fZglrvantc8MkWNRc1YgbqkuO3NzNeXHVG
         Ymzg==
X-Gm-Message-State: AAQBX9fHBp11ESJl+YenteUM3eRZRgDhpsLNRTgOxhdcyR/cPGbELmiV
        MVvvUAq3X35eQ1ujt0rzSFxqPQ==
X-Google-Smtp-Source: AKy350bRhkIUr8N7okrlgh3Hwo07F/vQhkNz4v1tFl3I8eV2V83V9lNwfkKYujFHpq4QwdXTdItkPw==
X-Received: by 2002:ad4:5946:0:b0:5ef:9b22:dc88 with SMTP id eo6-20020ad45946000000b005ef9b22dc88mr5188244qvb.0.1681845207300;
        Tue, 18 Apr 2023 12:13:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id db3-20020a056214170300b005e5b30eef24sm3907199qvb.56.2023.04.18.12.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:26 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 07/26] mm: page_alloc: move capture_control to the page allocator
Date:   Tue, 18 Apr 2023 15:12:54 -0400
Message-Id: <20230418191313.268131-8-hannes@cmpxchg.org>
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

Compaction capturing is really a component of the page allocator.
Later patches will also disconnect allocation request size from the
compaction size, so move the setup of the capturing parameters to the
"request domain", i.e. the page allocator. No functional change.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/compaction.h |  3 ++-
 mm/compaction.c            | 33 ++++++++++-----------------------
 mm/page_alloc.c            | 25 ++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 52a9ff65faee..06eeb2e25833 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -56,6 +56,7 @@ enum compact_result {
 };
 
 struct alloc_context; /* in mm/internal.h */
+struct capture_control; /* in mm/internal.h */
 
 /*
  * Number of free order-0 pages that should be available above given watermark
@@ -94,7 +95,7 @@ extern int fragmentation_index(struct zone *zone, unsigned int order);
 extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		unsigned int order, unsigned int alloc_flags,
 		const struct alloc_context *ac, enum compact_priority prio,
-		struct page **page);
+		struct capture_control *capc);
 extern void reset_isolation_suitable(pg_data_t *pgdat);
 extern enum compact_result compaction_suitable(struct zone *zone, int order,
 		unsigned int alloc_flags, int highest_zoneidx);
diff --git a/mm/compaction.c b/mm/compaction.c
index 84db84e8fd3a..a2280001eea3 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2510,7 +2510,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 static enum compact_result compact_zone_order(struct zone *zone, int order,
 		gfp_t gfp_mask, enum compact_priority prio,
 		unsigned int alloc_flags, int highest_zoneidx,
-		struct page **capture)
+		struct capture_control *capc)
 {
 	enum compact_result ret;
 	struct compact_control cc = {
@@ -2527,38 +2527,25 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
 		.ignore_skip_hint = (prio == MIN_COMPACT_PRIORITY),
 		.ignore_block_suitable = (prio == MIN_COMPACT_PRIORITY)
 	};
-	struct capture_control capc = {
-		.cc = &cc,
-		.page = NULL,
-	};
 
-	/*
-	 * Make sure the structs are really initialized before we expose the
-	 * capture control, in case we are interrupted and the interrupt handler
-	 * frees a page.
-	 */
+	/* See the comment in __alloc_pages_direct_compact() */
 	barrier();
-	WRITE_ONCE(current->capture_control, &capc);
+	WRITE_ONCE(capc->cc, &cc);
 
-	ret = compact_zone(&cc, &capc);
+	ret = compact_zone(&cc, capc);
+
+	WRITE_ONCE(capc->cc, NULL);
 
 	VM_BUG_ON(!list_empty(&cc.freepages));
 	VM_BUG_ON(!list_empty(&cc.migratepages));
 
-	/*
-	 * Make sure we hide capture control first before we read the captured
-	 * page pointer, otherwise an interrupt could free and capture a page
-	 * and we would leak it.
-	 */
-	WRITE_ONCE(current->capture_control, NULL);
-	*capture = READ_ONCE(capc.page);
 	/*
 	 * Technically, it is also possible that compaction is skipped but
 	 * the page is still captured out of luck(IRQ came and freed the page).
 	 * Returning COMPACT_SUCCESS in such cases helps in properly accounting
 	 * the COMPACT[STALL|FAIL] when compaction is skipped.
 	 */
-	if (*capture)
+	if (capc->page)
 		ret = COMPACT_SUCCESS;
 
 	return ret;
@@ -2573,13 +2560,13 @@ int sysctl_extfrag_threshold = 500;
  * @alloc_flags: The allocation flags of the current allocation
  * @ac: The context of current allocation
  * @prio: Determines how hard direct compaction should try to succeed
- * @capture: Pointer to free page created by compaction will be stored here
+ * @capc: The context for capturing pages during freeing
  *
  * This is the main entry point for direct page compaction.
  */
 enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		unsigned int alloc_flags, const struct alloc_context *ac,
-		enum compact_priority prio, struct page **capture)
+		enum compact_priority prio, struct capture_control *capc)
 {
 	int may_perform_io = (__force int)(gfp_mask & __GFP_IO);
 	struct zoneref *z;
@@ -2607,7 +2594,7 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		}
 
 		status = compact_zone_order(zone, order, gfp_mask, prio,
-				alloc_flags, ac->highest_zoneidx, capture);
+				alloc_flags, ac->highest_zoneidx, capc);
 		rc = max(status, rc);
 
 		/* The allocation should succeed, stop compacting */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b9366c002334..4d20513c83be 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -944,7 +944,7 @@ static inline struct capture_control *task_capc(struct zone *zone)
 {
 	struct capture_control *capc = current->capture_control;
 
-	return unlikely(capc) &&
+	return unlikely(capc && capc->cc) &&
 		!(current->flags & PF_KTHREAD) &&
 		!capc->page &&
 		capc->cc->zone == zone ? capc : NULL;
@@ -4480,22 +4480,41 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	struct page *page = NULL;
 	unsigned long pflags;
 	unsigned int noreclaim_flag;
+	struct capture_control capc = {
+		.page = NULL,
+	};
 
 	if (!order)
 		return NULL;
 
+	/*
+	 * Make sure the structs are really initialized before we expose the
+	 * capture control, in case we are interrupted and the interrupt handler
+	 * frees a page.
+	 */
+	barrier();
+	WRITE_ONCE(current->capture_control, &capc);
+
 	psi_memstall_enter(&pflags);
 	delayacct_compact_start();
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	*compact_result = try_to_compact_pages(gfp_mask, order, alloc_flags, ac,
-								prio, &page);
+					       prio, &capc);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 	psi_memstall_leave(&pflags);
 	delayacct_compact_end();
 
-	if (*compact_result == COMPACT_SKIPPED)
+	/*
+	 * Make sure we hide capture control first before we read the captured
+	 * page pointer, otherwise an interrupt could free and capture a page
+	 * and we would leak it.
+	 */
+	WRITE_ONCE(current->capture_control, NULL);
+	page = READ_ONCE(capc.page);
+
+	if (!page && *compact_result == COMPACT_SKIPPED)
 		return NULL;
 	/*
 	 * At least in one zone compaction wasn't deferred or skipped, so let's
-- 
2.39.2

