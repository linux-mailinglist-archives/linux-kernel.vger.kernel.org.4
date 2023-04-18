Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092D96E6CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjDRTOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjDRTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:13:53 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D89C67A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:29 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id oo30so15744241qvb.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845208; x=1684437208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Fg7akH6DcyqQI9O6hhnfSSKo6TLLXotHGx/ELhTsVs=;
        b=duezlBdfFiEByRb2UhLuZ0Hbbz17B9Qr/emODLH8mZ2CGMjptqHGa11W+QzdSjQ/7F
         NrpNC/GaqkJEOfmZT8IQhhmClT+39ZedrNCcu8ABafH+q5j+YOBKEgdjdxPGtGKwAbo+
         P2TEzDioWeN451luG7HEJwPMt/rOzqsoER6GOlwhz2qDDjhKRGqWoYpeyDSp91a0bKPf
         25r1qZ+NsVNcaUBJQLFKjSOaPj15VqfhoKvKXLa7AyFqKWsmjO1Nkx11EK8FkuJho1GV
         PlZj02YYGkSrKmCNJW7AgCuXuYglqYWYf5+G3gp8PSNESKrtKbSuyF4B4khcnFe0QCvs
         SdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845208; x=1684437208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Fg7akH6DcyqQI9O6hhnfSSKo6TLLXotHGx/ELhTsVs=;
        b=egV5nnUsJlZ9RFvsWQVswQn0i+d8wpt00UMCRE15Yed4SZ3qNNP2yC7Qblz4tmnKUD
         lug33365g4PGqhta1/Dt+I2au1CxWaPnnGqTsaqWAu30BJOFckt7HiKl7HwWjG0iaRYv
         5j4C0GLxqrfiD4YlXTkVIuZ8H8CHoIjueeOhqjWv4UQCzq06+VVzV4Uzvtw6WNVFmly9
         w6/I7PZT8iEQQUwlJCX9Jp+Dwz+gaMUo0fEpuAoMgsYqPRIuRuTjg5apOiDR0sMoqHSu
         PZcDZAOW86u7NNBOv6zULIesbjpMOzUy2reg9jNnFXzIiLu/tCmA/iyWhyovT2oAuTJ2
         2KqA==
X-Gm-Message-State: AAQBX9d6LIqj59EBejqt5to21lVDnfJ5I/hXCrtQiIziwUapx5eIiX6j
        E/h8gQC5I0papJ7zfCp/pQidkg==
X-Google-Smtp-Source: AKy350aBP+4ihxJVgdmom0s8xvFh5tp4l/UPrJZnbm1VerN0bSQuYJNYtHePgve1c8xb8nyNL5IrOA==
X-Received: by 2002:a05:6214:252a:b0:5ef:8004:e0b4 with SMTP id gg10-20020a056214252a00b005ef8004e0b4mr11443725qvb.48.1681845208456;
        Tue, 18 Apr 2023 12:13:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id c2-20020a0ceb42000000b005dd8b9345e3sm3924742qvq.123.2023.04.18.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:28 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 08/26] mm: page_alloc: claim blocks during compaction capturing
Date:   Tue, 18 Apr 2023 15:12:55 -0400
Message-Id: <20230418191313.268131-9-hannes@cmpxchg.org>
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

When capturing a whole block, update the migratetype accordingly. For
example, a THP allocation might capture an unmovable block. If the THP
gets split and partially freed later, the remainder should group up
with movable allocations.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/internal.h   |  1 +
 mm/page_alloc.c | 42 ++++++++++++++++++++++++------------------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 024affd4e4b5..39f65a463631 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -432,6 +432,7 @@ struct compact_control {
  */
 struct capture_control {
 	struct compact_control *cc;
+	int migratetype;
 	struct page *page;
 };
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4d20513c83be..8e5996f8b4b4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -615,6 +615,17 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
 				page_to_pfn(page), MIGRATETYPE_MASK);
 }
 
+static void change_pageblock_range(struct page *pageblock_page,
+					int start_order, int migratetype)
+{
+	int nr_pageblocks = 1 << (start_order - pageblock_order);
+
+	while (nr_pageblocks--) {
+		set_pageblock_migratetype(pageblock_page, migratetype);
+		pageblock_page += pageblock_nr_pages;
+	}
+}
+
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
@@ -962,14 +973,19 @@ compaction_capture(struct capture_control *capc, struct page *page,
 	    is_migrate_isolate(migratetype))
 		return false;
 
-	/*
-	 * Do not let lower order allocations pollute a movable pageblock.
-	 * This might let an unmovable request use a reclaimable pageblock
-	 * and vice-versa but no more than normal fallback logic which can
-	 * have trouble finding a high-order free page.
-	 */
-	if (order < pageblock_order && migratetype == MIGRATE_MOVABLE)
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
 		return false;
+	}
 
 	capc->page = page;
 	return true;
@@ -2674,17 +2690,6 @@ int move_freepages_block(struct zone *zone, struct page *page,
 			      old_mt, new_mt, num_movable);
 }
 
-static void change_pageblock_range(struct page *pageblock_page,
-					int start_order, int migratetype)
-{
-	int nr_pageblocks = 1 << (start_order - pageblock_order);
-
-	while (nr_pageblocks--) {
-		set_pageblock_migratetype(pageblock_page, migratetype);
-		pageblock_page += pageblock_nr_pages;
-	}
-}
-
 /*
  * When we are falling back to another migratetype during allocation, try to
  * steal extra free pages from the same pageblocks to satisfy further
@@ -4481,6 +4486,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	unsigned long pflags;
 	unsigned int noreclaim_flag;
 	struct capture_control capc = {
+		.migratetype = ac->migratetype,
 		.page = NULL,
 	};
 
-- 
2.39.2

