Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2753614348
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKACc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKACc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:32:56 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E94DCD5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:32:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667269973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6TefmdO43ILS61YweujCpCvfdLxa126KkuiZEMMTg3c=;
        b=XDksCaR5tYi0qjMnF2RCdEumv8O4KTNHiCx2EzDr+cook6Vf/kFA5lFqVhAEJ0Yt+S7OhS
        GZTAuWKLRQ6a+mV8tVwuh4waKnVvf7yfnl5h54TkjbpA5LK2cJ64bDyXMIrQFfE/JW0il3
        MtnXj0qcp5h3/PeC5Bw2UDAiy+6b+bk=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm: simplify page_zone() and get_deferred_split_queue() with page_pgdat()
Date:   Tue,  1 Nov 2022 10:32:19 +0800
Message-Id: <20221101023219.752365-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_zone() is too long, we can shorten it by page_pgdat().

There is no need define pgdat variable if memcg isn't NULL, so use
page_pgdat() to simplify get_deferred_split_queue().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/mm.h | 8 ++++----
 mm/huge_memory.c   | 7 ++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 978c17df053e..25ff9a14a777 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1448,14 +1448,14 @@ static inline void page_kasan_tag_reset(struct page *page) { }
 
 #endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
 
-static inline struct zone *page_zone(const struct page *page)
+static inline pg_data_t *page_pgdat(const struct page *page)
 {
-	return &NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)];
+	return NODE_DATA(page_to_nid(page));
 }
 
-static inline pg_data_t *page_pgdat(const struct page *page)
+static inline struct zone *page_zone(const struct page *page)
 {
-	return NODE_DATA(page_to_nid(page));
+	return &page_pgdat(page)->node_zones[page_zonenum(page)];
 }
 
 static inline struct zone *folio_zone(const struct folio *folio)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1ed245f6d1a7..a524db74e9e6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -562,19 +562,16 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 static inline struct deferred_split *get_deferred_split_queue(struct page *page)
 {
 	struct mem_cgroup *memcg = page_memcg(compound_head(page));
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
 
 	if (memcg)
 		return &memcg->deferred_split_queue;
 	else
-		return &pgdat->deferred_split_queue;
+		return &page_pgdat(page)->deferred_split_queue;
 }
 #else
 static inline struct deferred_split *get_deferred_split_queue(struct page *page)
 {
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
-
-	return &pgdat->deferred_split_queue;
+	return &page_pgdat(page)->deferred_split_queue;
 }
 #endif
 
-- 
2.25.1

