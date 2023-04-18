Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751716E6CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjDRTOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjDRTOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:03 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C291027A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:33 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a23so25544231qtj.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845213; x=1684437213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKzxWkw9Wp7aX3AQonPLuV4v1F6kfO1MbtWYkZecR34=;
        b=fnKaIHJG7NChil0OqR30RHO2yD9ilNfbfzz+l5UrDoOhQMcIjn9Z7u0gwD85iPVAp0
         tffEBcyMY2FouSlHJNy6srGCvt5E9IDj4dJBVKRE6XA/ar/BC0EWMcwavJ9D8HNRuvlG
         Qdrqep2d7P+SpC95Rfj9aYd53ubAphhsP8E2gw2I9iDczVYbpjshQr8hBgBoVIb0a4N3
         k6mQGeB1gv6RgDAMcI2tUgO6k3f+/MPwwLRAHp5lTK9eH/oa31Gg7tq6UC02MZCEJxJ0
         CZVghku4DrrkzUssr6FthK28bwb1ynE8SrIKpU9sP12KWUg87rBmxhFx+GjHDJFIysNI
         WwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845213; x=1684437213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKzxWkw9Wp7aX3AQonPLuV4v1F6kfO1MbtWYkZecR34=;
        b=VvieWOPiBSKHuSrqB0h+IoVE09JZVQ4+tEOhFQ4L4beIchTpQRb3eWzni78limmrvk
         Cn6lDbjzFFgTOoKupv22kXB9sOn7HOz6RkLduSs0oLF2T5bLT/d3EIxX0wP4f2qEs0JG
         4fR+3wQKx8uvoZTu+hkXWsVfttjg2hBpBrZbMr+HpdTLFsLaY28koNAvxiJ8T8DQy0Zk
         76OkTT6TWjORbTrFpuUpTN50wy1s8Wa2BpxpCb0BMsIQNxzJwwB5mxjjSfe9PqVoULHy
         do9xpKZ9I2uuK4ditaXOy6LNML3RvYfnWg9/88LXJhjqx9mysEjwJRDJEr/WrC7isBgt
         og8g==
X-Gm-Message-State: AAQBX9cq8xtWc6+bohukx+Xwt2rLTYhmNIgJiIdakbwt7/aQGTF594yA
        D4xgWeVmf1nKwxc7J9bd4u59kA==
X-Google-Smtp-Source: AKy350YRTIp6emLy7bR9ZUZa/RhO/Obyaw6AxSNUEm8mzOLj17NAjGHuS3AbcjQstxdD3Htg+F7UQg==
X-Received: by 2002:a05:622a:4d1:b0:3ef:3d3f:17a2 with SMTP id q17-20020a05622a04d100b003ef3d3f17a2mr1327574qtx.68.1681845213072;
        Tue, 18 Apr 2023 12:13:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id y30-20020a05620a09de00b0074683c45f6csm4141283qky.1.2023.04.18.12.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:32 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 12/26] mm: page_alloc: per-migratetype free counts
Date:   Tue, 18 Apr 2023 15:12:59 -0400
Message-Id: <20230418191313.268131-13-hannes@cmpxchg.org>
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

Increase visibility into the defragmentation behavior by tracking and
reporting per-migratetype free counters.

Subsequent patches will also use those counters to make more targeted
reclaim/compaction decisions.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mmzone.h |  5 +++++
 mm/page_alloc.c        | 29 +++++++++++++++++++++++++----
 mm/vmstat.c            |  5 +++++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 20542e5a0a43..d1083ab81998 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -139,6 +139,11 @@ enum numa_stat_item {
 enum zone_stat_item {
 	/* First 128 byte cacheline (assuming 64 bit words) */
 	NR_FREE_PAGES,
+	NR_FREE_UNMOVABLE,
+	NR_FREE_MOVABLE,
+	NR_FREE_RECLAIMABLE,
+	NR_FREE_HIGHATOMIC,
+	NR_FREE_FREE,
 	NR_ZONE_LRU_BASE, /* Used only for compaction and reclaim retry */
 	NR_ZONE_INACTIVE_ANON = NR_ZONE_LRU_BASE,
 	NR_ZONE_ACTIVE_ANON,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 44da23625f51..5f2a0037bed1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -959,8 +959,12 @@ static inline void account_freepages(struct page *page, struct zone *zone,
 
 	__mod_zone_page_state(zone, NR_FREE_PAGES, nr_pages);
 
-	if (is_migrate_cma(migratetype))
+	if (migratetype <= MIGRATE_FREE)
+		__mod_zone_page_state(zone, NR_FREE_UNMOVABLE + migratetype, nr_pages);
+	else if (is_migrate_cma(migratetype))
 		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
+	else
+		VM_WARN_ONCE(1, "unexpected migratetype %d\n", migratetype);
 }
 
 /* Used for pages not on another list */
@@ -6175,7 +6179,9 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 		" mapped:%lu shmem:%lu pagetables:%lu\n"
 		" sec_pagetables:%lu bounce:%lu\n"
 		" kernel_misc_reclaimable:%lu\n"
-		" free:%lu free_pcp:%lu free_cma:%lu\n",
+		" free:%lu free_unmovable:%lu free_movable:%lu\n"
+		" free_reclaimable:%lu free_highatomic:%lu free_free:%lu\n"
+		" free_cma:%lu free_pcp:%lu\n",
 		global_node_page_state(NR_ACTIVE_ANON),
 		global_node_page_state(NR_INACTIVE_ANON),
 		global_node_page_state(NR_ISOLATED_ANON),
@@ -6194,8 +6200,13 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 		global_zone_page_state(NR_BOUNCE),
 		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE),
 		global_zone_page_state(NR_FREE_PAGES),
-		free_pcp,
-		global_zone_page_state(NR_FREE_CMA_PAGES));
+		global_zone_page_state(NR_FREE_UNMOVABLE),
+		global_zone_page_state(NR_FREE_MOVABLE),
+		global_zone_page_state(NR_FREE_RECLAIMABLE),
+		global_zone_page_state(NR_FREE_HIGHATOMIC),
+		global_zone_page_state(NR_FREE_FREE),
+		global_zone_page_state(NR_FREE_CMA_PAGES),
+		free_pcp);
 
 	for_each_online_pgdat(pgdat) {
 		if (show_mem_node_skip(filter, pgdat->node_id, nodemask))
@@ -6273,6 +6284,11 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 		printk(KERN_CONT
 			"%s"
 			" free:%lukB"
+			" free_unmovable:%lukB"
+			" free_movable:%lukB"
+			" free_reclaimable:%lukB"
+			" free_highatomic:%lukB"
+			" free_free:%lukB"
 			" boost:%lukB"
 			" min:%lukB"
 			" low:%lukB"
@@ -6294,6 +6310,11 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 			"\n",
 			zone->name,
 			K(zone_page_state(zone, NR_FREE_PAGES)),
+			K(zone_page_state(zone, NR_FREE_UNMOVABLE)),
+			K(zone_page_state(zone, NR_FREE_MOVABLE)),
+			K(zone_page_state(zone, NR_FREE_RECLAIMABLE)),
+			K(zone_page_state(zone, NR_FREE_HIGHATOMIC)),
+			K(zone_page_state(zone, NR_FREE_FREE)),
 			K(zone->watermark_boost),
 			K(min_wmark_pages(zone)),
 			K(low_wmark_pages(zone)),
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 1ea6a5ce1c41..c8b8e6e259da 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1168,6 +1168,11 @@ int fragmentation_index(struct zone *zone, unsigned int order)
 const char * const vmstat_text[] = {
 	/* enum zone_stat_item counters */
 	"nr_free_pages",
+	"nr_free_unmovable",
+	"nr_free_movable",
+	"nr_free_reclaimable",
+	"nr_free_highatomic",
+	"nr_free_free",
 	"nr_zone_inactive_anon",
 	"nr_zone_active_anon",
 	"nr_zone_inactive_file",
-- 
2.39.2

