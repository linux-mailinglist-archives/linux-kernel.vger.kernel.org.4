Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF6D70960A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjESLQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjESLQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:16:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B281A113
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:16:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96649b412easo496389966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1684495013; x=1687087013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=10duq/iSi0SrgAic2oFa0MSpSchsNelGTHibEkYiEYo=;
        b=mKz7GTssxphaehQ0POFeVEdVoWd4z55up137j0GfnPI88ZJwsrdzxQmls/Ks6d5OEk
         kJoRUnEWqNELsjiIbUjoKKNkLz6gDg7lTM6oDqlnramFhWpP3W4TSQCfUcdsYS65wcjl
         GIYJi68ZN5+VLfGQEDg5J0xrSy2Tmy+uHHzIZvRUcL5//5JkZ6MhjFasNQLvlIyZ8OEA
         FiAkPTtmbeD66T9etAa5C238TdyHP5ow8FYjITf/q4JLz4qSY/6n+zLyG9/1/9ZdAKI6
         QHnBI2Yn3CcGECj1jCQ0SB2NDA9867HQmBtArryEYUyukzgYBNrQxcSfCtSbyRHGGEvB
         QRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684495013; x=1687087013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10duq/iSi0SrgAic2oFa0MSpSchsNelGTHibEkYiEYo=;
        b=g5Zhr1PNURFfk5gytQmQGZwvLYayYWw7T4gXDfCod7feQvA93vPyoGDzuB9ey9dFqS
         m0PD+nUjxWDNyj9FHB4k8EmQrd4/VvBJSJQxSHvsAu93JEiWKeU9sI5zGIZDcP3j9VF/
         a7JNLnl/eHx6HubmFL9nvn8oByLrZmiiF6gRgoBhlyp7/8OXZDZ0hDzY4xxi5S/CIAL7
         9MaC944Q7LFzEtHEpC3rOdioqH/DuzKcD6ECJ/90TpHcfJorRIIkJ1JWwThcmz7mgjuj
         BFasKnoCpkE9MuecfXCWNYan8o+ZjhkTeCN+cRKX1IxddzNiWlEnRWJploIInvurlAN6
         KmXQ==
X-Gm-Message-State: AC+VfDzRhu6T6NYUoE4Awa1z0k57B6lAN1RoyrAuN0/hB5n5nOHNJKNK
        qyHe54dcmR+ewlbVl1vO3iiKig==
X-Google-Smtp-Source: ACHHUZ40QJHLQgWD3+zwLtMoGb2m9aCvrWRlNSFM9kTEHw69TlY/Ivppd2NBGoA5omT4uFnyrvGIqg==
X-Received: by 2002:a17:907:9955:b0:947:ebd5:c798 with SMTP id kl21-20020a170907995500b00947ebd5c798mr1092652ejc.54.1684495013024;
        Fri, 19 May 2023 04:16:53 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:7d40:e266:3092:9afb:a7b1])
        by smtp.gmail.com with ESMTPSA id t17-20020a17090605d100b0094edfbd475csm2127441ejt.127.2023.05.19.04.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 04:16:52 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: page_isolation: write proper kerneldoc
Date:   Fri, 19 May 2023 13:16:52 +0200
Message-Id: <20230519111652.40658-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.40.0
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

And remove the incorrect header comments.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/page-isolation.h | 24 ++++++------------------
 mm/page_isolation.c            | 29 ++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 5456b7be38ae..0ab089e89db4 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -37,24 +37,12 @@ void set_pageblock_migratetype(struct page *page, int migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
 				int migratetype, int *num_movable);
 
-/*
- * Changes migrate type in [start_pfn, end_pfn) to be MIGRATE_ISOLATE.
- */
-int
-start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			 int migratetype, int flags, gfp_t gfp_flags);
-
-/*
- * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
- * target range is [start_pfn, end_pfn)
- */
-void
-undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			int migratetype);
-
-/*
- * Test all pages in [start_pfn, end_pfn) are isolated or not.
- */
+int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
+			     int migratetype, int flags, gfp_t gfp_flags);
+
+void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
+			     int migratetype);
+
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 			int isol_flags);
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c6f3605e37ab..e7d7685104de 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -481,8 +481,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 }
 
 /**
- * start_isolate_page_range() - make page-allocation-type of range of pages to
- * be MIGRATE_ISOLATE.
+ * start_isolate_page_range() - mark page range MIGRATE_ISOLATE
  * @start_pfn:		The lower PFN of the range to be isolated.
  * @end_pfn:		The upper PFN of the range to be isolated.
  * @migratetype:	Migrate type to set in error recovery.
@@ -571,8 +570,14 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	return 0;
 }
 
-/*
- * Make isolated pages available again.
+/**
+ * undo_isolate_page_range - undo effects of start_isolate_page_range()
+ * @start_pfn:		The lower PFN of the isolated range
+ * @end_pfn:		The upper PFN of the isolated range
+ * @migratetype:	New migrate type to set on the range
+ *
+ * This finds every MIGRATE_ISOLATE page block in the given range
+ * and switches it to @migratetype.
  */
 void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			    int migratetype)
@@ -631,7 +636,21 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
 	return pfn;
 }
 
-/* Caller should ensure that requested range is in a single zone */
+/**
+ * test_pages_isolated - check if pageblocks in range are isolated
+ * @start_pfn:		The first PFN of the isolated range
+ * @end_pfn:		The first PFN *after* the isolated range
+ * @isol_flags:		Testing mode flags
+ *
+ * This tests if all in the specified range are free.
+ *
+ * If %MEMORY_OFFLINE is specified in @flags, it will consider
+ * poisoned and offlined pages free as well.
+ *
+ * Caller must ensure the requested range doesn't span zones.
+ *
+ * Returns 0 if true, -EBUSY if one or more pages are in use.
+ */
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 			int isol_flags)
 {
-- 
2.40.0

