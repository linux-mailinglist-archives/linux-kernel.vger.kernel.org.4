Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DABB672C87
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjARXWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjARXW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:22:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C5B676C4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:22:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id a14-20020a17090a70ce00b00229a2f73c56so4075129pjm.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyaiUqa6uxGoekyzThZMenGPL9hncRzPR7deDY3LNSw=;
        b=lR6rKoh2RFGVgliV98r5mNThqsblkwbahtu0j3cOy5zj+Wzs0dviXjd2xpwYFy2b/s
         FygjQje2As8gfiTv9IpoYviItU5IfXF3C+GHMqEG1TIChBHPivgqi6vwtmYerHkKtLg7
         Wor81yJRBNys/MDCgjcgoFKMBZc6oqepM5BPCSw5FKbe5xpLw6HtkAKD/ZCxElxGwXq/
         E7IuAIb85nTgV+Zl0fknCajTg5E6lgdimAdfDfa1GyuBlO703HbOwVSZiZ1bBuRQaOo+
         40WaxHk5Ci8dNgUiqHOfu4PLfvBSxBin0LQbgice19D3oERHCz3XPGmgoPf+Xd0BQzLs
         xjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyaiUqa6uxGoekyzThZMenGPL9hncRzPR7deDY3LNSw=;
        b=hftufaGZ2C0efATgHYml/O6ezP+NlQ/s2e4bAD1IjV2Ni/jjUEw2yTdMCEhqArykK5
         biax/SzzlijwBvjTzzGqEE7RgWzu4R4Yxgnvc4qrPgBY6G1GznpQZOHntFtkQdAn9Z2t
         6A/yaFa31ELQmZ+nGEKPnjRsIkR9av2DvPdWx7cOzy//90CCHnFGM0PgidOsUTZKkcir
         +KvwrcYxmF0xWiSuL05e6OAFh2NFhfUr5WGBnJn3bd9EGdXCsmC6/yV03Wo/OCQ1eQZZ
         W0yX24acBPRJpnaDYykrA31BPA6ISP2InffGwm+ZXwZBkMb/fhS6wE8YwlY0Jn5RAyFU
         gASA==
X-Gm-Message-State: AFqh2kqmKunRGccQQTtTRJ9lxgqsisvkeO7kbryqj+brMyS3QS8QMEUg
        9aA83FrXVJzGoiALxb8st0uVY1F2KT4=
X-Google-Smtp-Source: AMrXdXuNC0wSbEBnfwY4tpq5Uzm/p/V4ipRKGX+mC0Iiyh8LXHRGagSW26Bf2QUBFcOVAY6JVMfNOA==
X-Received: by 2002:a17:90a:ea86:b0:229:9369:e13 with SMTP id h6-20020a17090aea8600b0022993690e13mr8927376pjz.36.1674084147437;
        Wed, 18 Jan 2023 15:22:27 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id k1-20020a17090a7f0100b00223f495dc28sm1862265pjl.14.2023.01.18.15.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:22:27 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable 5/5] mm/mempolicy: Convert migrate_page_add() to migrate_folio_add()
Date:   Wed, 18 Jan 2023 15:22:19 -0800
Message-Id: <20230118232219.27038-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230118232219.27038-1-vishal.moola@gmail.com>
References: <20230118232219.27038-1-vishal.moola@gmail.com>
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
 mm/mempolicy.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0a3690ecab7d..253ce368cf16 100644
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
@@ -1022,27 +1022,23 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
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
+	 * Avoid migrating a folio that is shared with others.
 	 */
-	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(head) == 1) {
-		if (!isolate_lru_page(head)) {
-			list_add_tail(&head->lru, pagelist);
-			mod_node_page_state(page_pgdat(head),
-				NR_ISOLATED_ANON + page_is_file_lru(head),
-				thp_nr_pages(head));
+	if ((flags & MPOL_MF_MOVE_ALL) || folio_mapcount(folio) == 1) {
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
@@ -1234,7 +1230,7 @@ static struct page *new_page(struct page *page, unsigned long start)
 }
 #else
 
-static int migrate_page_add(struct page *page, struct list_head *pagelist,
+static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 				unsigned long flags)
 {
 	return -EIO;
-- 
2.38.1

