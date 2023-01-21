Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD99676299
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjAUA4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjAUA4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:56:34 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97925E501
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:56:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id lp10so3692967pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkXNorFtaPaGzwVFxzbZYEJpEcyIIYNIa70AwU0RnhU=;
        b=OU6CzD7S2SXTi5dHeizCrqqyUa1E/S+1Xv9bL5KSlTsI2aFqfbefk+2ycerfdqRxhd
         8YL3QZPjVDil05FoKXdnkZJjlW1wZfZPKVWdilIvw6LAdMo78a/ZgtD8F38roE33chrj
         EDi3VXK72Xts3yjaN/uxM+sQX+sQbp/Di+qqF+y7yobNFU0OdyB/pAGlAEsC/w++utef
         7X8rd3cChqG32EgfywmG6uXNbzbZR5ID0ImPlRoXIyh9MtEZiPhonzrYEKh39xMdXuxq
         8DghFm+3fyJVrZaAqCFZaTrMx4Uv8bjEvvF1/GOqE0IfHkDQG2KN3Mn6aaJQ9nNH65zm
         kHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkXNorFtaPaGzwVFxzbZYEJpEcyIIYNIa70AwU0RnhU=;
        b=L5Wua0ze37PCP6jncMHhmK5AqYUyyfXbvAy4YADjthN7XreR+S2LbGoKInsD3UZZBI
         Fm3D5QryGe5QW1QSnJWWhhRpfpjB/bkoabUy3k5KoTgVJRog59tQ0LFHMyRG49Pm5iFy
         9CWw+acjtG0PU8ovr0XVZy4XNeWE0eNWIAEeCUXlZjepaJTbo5D8nqUz3HfXicbWptVv
         MuGFEx02/e6Irk/tC1HgTX69aIoqLQP7xkemAzRUAzM21LmBzhq8p0YFLKS08pXgQhnC
         Kf55tQCd6zSOq4VkBAJalr80fmBJa51T+d7gif7j6PzXC7bjS5Af2gOnAOB61AGjLHjj
         rd0Q==
X-Gm-Message-State: AFqh2krC27to+VQlnXmZKoNk+xcOghLbPFtbIn5E+p13jFMC3rG+5pbX
        5cOZ11rtwpsVuz09vJLCEXk=
X-Google-Smtp-Source: AMrXdXuUy5kpul7xMIhJ28FxxHuxY8j1XCLUYpPVopPQ/CRV4dBrI4mTZspSM8R1fhwNdcrZ2jZwyg==
X-Received: by 2002:a17:90a:7309:b0:228:e521:3430 with SMTP id m9-20020a17090a730900b00228e5213430mr17656529pjk.21.1674262589164;
        Fri, 20 Jan 2023 16:56:29 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id pc3-20020a17090b3b8300b001fde655225fsm11314371pjb.2.2023.01.20.16.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:56:28 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        sidhartha.kumar@oracle.com, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/3] mm/migrate: Convert putback_movable_pages() to use folios
Date:   Fri, 20 Jan 2023 16:56:22 -0800
Message-Id: <20230121005622.57808-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121005622.57808-1-vishal.moola@gmail.com>
References: <20230121005622.57808-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes 6 calls to compound_head(), and replaces putback_movable_page()
with putback_movable_folio() as well.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/migrate.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index bcde3cbbc8c9..de65f7146ee6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -129,12 +129,12 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	return -EBUSY;
 }
 
-static void putback_movable_page(struct page *page)
+static void putback_movable_folio(struct folio *folio)
 {
-	const struct movable_operations *mops = page_movable_ops(page);
+	const struct movable_operations *mops = folio_movable_ops(folio);
 
-	mops->putback_page(page);
-	ClearPageIsolated(page);
+	mops->putback_page(&folio->page);
+	folio_clear_isolated(folio);
 }
 
 /*
@@ -147,33 +147,33 @@ static void putback_movable_page(struct page *page)
  */
 void putback_movable_pages(struct list_head *l)
 {
-	struct page *page;
-	struct page *page2;
+	struct folio *folio;
+	struct folio *folio2;
 
-	list_for_each_entry_safe(page, page2, l, lru) {
-		if (unlikely(PageHuge(page))) {
-			putback_active_hugepage(page);
+	list_for_each_entry_safe(folio, folio2, l, lru) {
+		if (unlikely(folio_test_hugetlb(folio))) {
+			putback_active_hugepage(&folio->page);
 			continue;
 		}
-		list_del(&page->lru);
+		list_del(&folio->lru);
 		/*
-		 * We isolated non-lru movable page so here we can use
-		 * __PageMovable because LRU page's mapping cannot have
+		 * We isolated non-lru movable folio so here we can use
+		 * __PageMovable because LRU folio's mapping cannot have
 		 * PAGE_MAPPING_MOVABLE.
 		 */
-		if (unlikely(__PageMovable(page))) {
-			VM_BUG_ON_PAGE(!PageIsolated(page), page);
-			lock_page(page);
-			if (PageMovable(page))
-				putback_movable_page(page);
+		if (unlikely(__folio_test_movable(folio))) {
+			VM_BUG_ON_FOLIO(!folio_test_isolated(folio), folio);
+			folio_lock(folio);
+			if (folio_test_movable(folio))
+				putback_movable_folio(folio);
 			else
-				ClearPageIsolated(page);
-			unlock_page(page);
-			put_page(page);
+				folio_clear_isolated(folio);
+			folio_unlock(folio);
+			folio_put(folio);
 		} else {
-			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -thp_nr_pages(page));
-			putback_lru_page(page);
+			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
+					folio_is_file_lru(folio), -folio_nr_pages(folio));
+			folio_putback_lru(folio);
 		}
 	}
 }
-- 
2.38.1

