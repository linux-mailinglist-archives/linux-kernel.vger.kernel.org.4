Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED7A678D48
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjAXBWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjAXBWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:22:24 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5517CE3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:20 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 7so10356820pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN57XfC0N2Z9PnMQ9nUjXYfVmJE2FGzydu2ZVvrzX3Q=;
        b=C/U/++SQ2raDEJiXZtLwp/aQPJIL2snP32r34/JamWV0YT5a5TsRoxvkNwbqlG+WDL
         Ps9wGzMk2fiKNQXMr2OEKdhMvvQfUMMtwtVHTbBPYYhV8nQcLx8qaQELNcPzo8v7Ttmf
         VmKiBt4Qr55YGjL0lwWS3LlD/Buk97PMiEpFshtmKPPbhX+1xEZd87JnVl7KpInH2k5c
         R2I/J6j7A0NCijafjBjis/f0LP6dYdH2w6/hgAka5LvRlZ5Tg5e//B6nTlGW6Z+W2fGt
         UmVFycoXRWSqB05rk6sYjNnEASAC57l7Sc6+Gmba8spUW3oIL05EE51CkXLabKhrLqo4
         V3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN57XfC0N2Z9PnMQ9nUjXYfVmJE2FGzydu2ZVvrzX3Q=;
        b=oHD90n+tRp8YiN2As7J/EKp+kl9UPp3qszgnR6/bCLCfX7ORAY5o8KyWZ8CKxGAqi1
         w8KyGghjIaPdtTDbGaLdVaKWm/CnYCYNGg8tnnn9O2fwOIZozSZdTFb6RfY17Ou0Rml6
         2M3MY/7AZch6fITZ2X4LDxpMG00DXIq1t5y9dAyf/+uAJGGOJNXG/Z6Sz1KZpiXj4i5z
         L7sP15ac0dUihBbxWHGQO5kAhfHa9KBIHtE64KT9gqBq3jb1UEjeO783XLmhk5Mu+WjJ
         7BYCGKr55pG6Fs7ReQaYHEg1L15zcp9Yh+QQsmQhiO5hPJiSviYjlgVtSyKRDg4EMxsT
         x+Lg==
X-Gm-Message-State: AFqh2kqJi4i/jvWa6yX83wmrUrmM/uXWqYfgxjVITbH1N39CLI1nV1/3
        eJOn5m3QSoKdBnBQOqGz034=
X-Google-Smtp-Source: AMrXdXsUcKBht35TPhoeIdubPl8bcQOBoTQINC0wEB8tAeEYBIKQ/4JjGSme0DY/zIDwqcq5kn6xZw==
X-Received: by 2002:a05:6a00:2986:b0:58c:8bdd:2e3c with SMTP id cj6-20020a056a00298600b0058c8bdd2e3cmr28301423pfb.20.1674523339887;
        Mon, 23 Jan 2023 17:22:19 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id 68-20020a620547000000b005825b8e0540sm213335pff.204.2023.01.23.17.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:22:19 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 6/6] mm/mempolicy: Convert migrate_page_add() to migrate_folio_add()
Date:   Mon, 23 Jan 2023 17:22:10 -0800
Message-Id: <20230124012210.13963-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230124012210.13963-1-vishal.moola@gmail.com>
References: <20230124012210.13963-1-vishal.moola@gmail.com>
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

Replace migrate_page_add() with migrate_folio_add().
migrate_folio_add() does the same a migrate_page_add() but takes in a
folio instead of a page. This removes a couple of calls to
compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index da87644430e3..9bb4600c4294 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -414,7 +414,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 	},
 };
 
-static int migrate_page_add(struct page *page, struct list_head *pagelist,
+static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 				unsigned long flags);
 
 struct queue_pages {
@@ -476,7 +476,7 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 	/* go to folio migration */
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 		if (!vma_migratable(walk->vma) ||
-		    migrate_page_add(&folio->page, qp->pagelist, flags)) {
+		    migrate_folio_add(folio, qp->pagelist, flags)) {
 			ret = 1;
 			goto unlock;
 		}
@@ -544,7 +544,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 			 * temporary off LRU pages in the range.  Still
 			 * need migrate other LRU pages.
 			 */
-			if (migrate_page_add(&folio->page, qp->pagelist, flags))
+			if (migrate_folio_add(folio, qp->pagelist, flags))
 				has_unmovable = true;
 		} else
 			break;
@@ -1029,27 +1029,28 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 }
 
 #ifdef CONFIG_MIGRATION
-/*
- * page migration, thp tail pages can be passed.
- */
-static int migrate_page_add(struct page *page, struct list_head *pagelist,
+static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 				unsigned long flags)
 {
-	struct page *head = compound_head(page);
 	/*
-	 * Avoid migrating a page that is shared with others.
+	 * We try to migrate only unshared folios. If it is shared it
+	 * is likely not worth migrating.
+	 *
+	 * To check if the folio is shared, ideally we want to make sure
+	 * every page is mapped to the same process. Doing that is very
+	 * expensive, so check the estimated mapcount of the folio instead.
 	 */
-	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(head) == 1) {
-		if (!isolate_lru_page(head)) {
-			list_add_tail(&head->lru, pagelist);
-			mod_node_page_state(page_pgdat(head),
-				NR_ISOLATED_ANON + page_is_file_lru(head),
-				thp_nr_pages(head));
+	if ((flags & MPOL_MF_MOVE_ALL) || folio_estimated_mapcount(folio) == 1) {
+		if (!folio_isolate_lru(folio)) {
+			list_add_tail(&folio->lru, foliolist);
+			node_stat_mod_folio(folio,
+				NR_ISOLATED_ANON + folio_is_file_lru(folio),
+				folio_nr_pages(folio));
 		} else if (flags & MPOL_MF_STRICT) {
 			/*
-			 * Non-movable page may reach here.  And, there may be
-			 * temporary off LRU pages or non-LRU movable pages.
-			 * Treat them as unmovable pages since they can't be
+			 * Non-movable folio may reach here.  And, there may be
+			 * temporary off LRU folios or non-LRU movable folios.
+			 * Treat them as unmovable folios since they can't be
 			 * isolated, so they can't be moved at the moment.  It
 			 * should return -EIO for this case too.
 			 */
@@ -1241,7 +1242,7 @@ static struct page *new_page(struct page *page, unsigned long start)
 }
 #else
 
-static int migrate_page_add(struct page *page, struct list_head *pagelist,
+static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 				unsigned long flags)
 {
 	return -EIO;
-- 
2.38.1

