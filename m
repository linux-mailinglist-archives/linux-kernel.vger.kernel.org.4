Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23B6E6CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjDRTOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjDRTNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:13:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D9AA26F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l11so30661643qtj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845204; x=1684437204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaODw93P+SR5wwuqKRfmGnBXSp8Lv6zFL4m1Q/yirc8=;
        b=kkfQYtWHK0cjsqR3Tr2Evmha89C/CGQuIEEPuLJT4pN5xWQi7d8Vq8uFMbzxn0pTuC
         vDsdfEFFx8thdvtcSffx5yY2knbkiKEIrb36FC9V3aQefF2s2mRjSVPD8070oJiQg8ZU
         r5RGXeP3tLr0RU10A3wP/Cz9FMVpBN6V/JJLvDmUodacBd0JSArMMCR8nLaXExEBOlpe
         yNw3G0y7GS5KEOFNn1FFACN24lKo6bTWTBgwy+WWKudhSd5CtHRcuY63yhaEwdjZrzkl
         7WYaotdrp8RPDc3Q3kZ6QS6x9WTWeqdC+Y/EyJLjEHZmM+bvNm4BrANxjwU1IMwgDCiF
         l0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845204; x=1684437204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaODw93P+SR5wwuqKRfmGnBXSp8Lv6zFL4m1Q/yirc8=;
        b=jQ0OxWtvcJqOtoLwQfW7ABMAAm9rvGev9zzPE78N6gFKgwp5hkF5S4ac6u/RbiX9rl
         bL/JKOu4P8PcA9eZTOwFLTHq9U9qFRz39yfvCLpPWfqlxItH0XaxuB/hCblq3z7RNcds
         4NHMFJaiO0xfTkw0JZWfpdbyjs5RXjeg53i/kc1zZnl30QiobhmOuw2w1JHLgYRm2zH1
         7ikXWv/ju0O3kIRcFhHVhVU0x7KEWgKZ3A7hhTGe0T4kKPPusRjJc6QsBNJNNB38fr8g
         0r/Uxulf3XWXGHvZQ5c//5LhEm+T/MEyGQkenSbxsrx+RuxRyeqQZ5OD0P7ml+2UnBEN
         IqWg==
X-Gm-Message-State: AAQBX9fuYgxUNQqYAzm8QizsIzUwZfHC+3knMS1w6BeJhWtvi/qlv8zV
        Ht4DifelIGG/crakBifMy1F5aA==
X-Google-Smtp-Source: AKy350aw5jRncIivAr25Em9/snSJvkqiUm+fvvm6Oxsi6j5yZZnDL1qzCh3Cxx7kfD1wTwtewWkLkA==
X-Received: by 2002:a05:622a:1042:b0:3ef:2db1:6e75 with SMTP id f2-20020a05622a104200b003ef2db16e75mr1455616qte.24.1681845203869;
        Tue, 18 Apr 2023 12:13:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id p23-20020a05620a22f700b0074ad04609f8sm1217413qki.117.2023.04.18.12.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:23 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 04/26] mm: page_isolation: write proper kerneldoc
Date:   Tue, 18 Apr 2023 15:12:51 -0400
Message-Id: <20230418191313.268131-5-hannes@cmpxchg.org>
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
index 47fbc1696466..b67800f7f6b1 100644
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
2.39.2

