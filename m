Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810E06E6CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjDRTO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjDRTOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:01 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959679018
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:31 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id oj8so1343059qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845210; x=1684437210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W40OmA9FJpZ9KM8b83NoKn4oLbbGXwdSocdEiJSdSOk=;
        b=wn0fopvGsbR3i6PvjhCvPLQ1N5JWQrSjYBsgbrLuF6738z7mGxzLK6h6jbm6MmLsmJ
         pF8n/O/stCPiQEof58dQGBFCvd4zD48BHZayas7tdYm+iNpqPr5K40ekJd/L+fqSbnWx
         dF76tgKVdT587CaFRK8QZjlJ0JQitDXtdsiSxO7LH78byqCngXvJYUfGQXVnbLa3i4e/
         Kwi9t5fN+cwPv3JGfkRVdEAeRey7ve3x28vGryxxL8HGqMYxVgzfDZIdBf6OLivjGG2u
         1lZUigMFLGf6JwZyC57zeYywVprLLuC3qi6qYNpVO4TuaZDQqSJWnTgv3OsLRhreN2Jg
         PPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845210; x=1684437210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W40OmA9FJpZ9KM8b83NoKn4oLbbGXwdSocdEiJSdSOk=;
        b=XdLX64PmwEyHaW4xdnrksQtUAIkUFjb94ZYXuos9Au341K5prLWSYQWyFO44J58llf
         Al/uBIo+y/WfhmjO6Tux4vNk2w0Nlz1KTDjPvBTDHmhWobti+V+8EUS+xw68QDJZlVvF
         TmmQsbWnKiwNvydldf2O1SY43VtMcK8El6a82ct9S7h6Fkh1TxmlKeq4TTlFoqVgn9wV
         KIdyIsb6a4bI6qxPlhPgKha5MoUSEO7qmdXVWj1w6kzIFHK+yLNdZ3hIcwscfK/BUHI5
         fr3gmJM50oxm1BlEc4+Vwscm0IHeWnSz8k+vYde7NaF8nrTYrrAd0ht9jVfalUQAAyS+
         hMow==
X-Gm-Message-State: AAQBX9dcgaP8GDkmJ6vJ5/TO6Y3SG1OVC3TdY6B7DNMS8en/ZWlt2Vs4
        I/MVlbKiiXMK7oTlp1C7jKsqUA==
X-Google-Smtp-Source: AKy350ZdXxpY1FsQYWCci5zoHDWqXfr/R4sK4OR7K8k8+oSMxZVw0C1MOwCqOi9gSXpDKZHblUbJiQ==
X-Received: by 2002:ad4:4ea4:0:b0:5ea:6a2a:140a with SMTP id ed4-20020ad44ea4000000b005ea6a2a140amr26931362qvb.16.1681845210696;
        Tue, 18 Apr 2023 12:13:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id r1-20020ac87941000000b003df7d7bbc8csm4249673qtt.75.2023.04.18.12.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:30 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 10/26] mm: page_alloc: allow compaction capturing from larger blocks
Date:   Tue, 18 Apr 2023 15:12:57 -0400
Message-Id: <20230418191313.268131-11-hannes@cmpxchg.org>
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

Currently, capturing only works on matching orders and matching
migratetypes. However, if capturing is initially skipped on the
migratetype, it's possible that merging continues up to a full
pageblock, in which case the migratetype is up for grabs again.

Allow capturing to grab smaller chunks from claimed pageblocks, and
expand the remainder of the block back onto the freelists.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cd86f80d7bbe..5ebfcf18537b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1067,10 +1067,10 @@ static inline struct capture_control *task_capc(struct zone *zone)
 }
 
 static inline bool
-compaction_capture(struct capture_control *capc, struct page *page,
-		   int order, int migratetype)
+compaction_capture(struct zone *zone, struct page *page, int order,
+		   int migratetype, struct capture_control *capc)
 {
-	if (!capc || order != capc->cc->order)
+	if (!capc || order < capc->cc->order)
 		return false;
 
 	/* Do not accidentally pollute CMA or isolated regions*/
@@ -1092,6 +1092,9 @@ compaction_capture(struct capture_control *capc, struct page *page,
 		return false;
 	}
 
+	if (order > capc->cc->order)
+		expand(zone, page, capc->cc->order, order, migratetype);
+
 	capc->page = page;
 	return true;
 }
@@ -1103,8 +1106,8 @@ static inline struct capture_control *task_capc(struct zone *zone)
 }
 
 static inline bool
-compaction_capture(struct capture_control *capc, struct page *page,
-		   int order, int migratetype)
+compaction_capture(struct zone *zone, struct page *page, int order,
+		   int migratetype, struct capture_control *capc)
 {
 	return false;
 }
@@ -1180,7 +1183,7 @@ static inline void __free_one_page(struct page *page,
 	while (order < MAX_ORDER - 1) {
 		int buddy_mt;
 
-		if (compaction_capture(capc, page, order, migratetype))
+		if (compaction_capture(zone, page, order, migratetype, capc))
 			return;
 
 		buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
-- 
2.39.2

