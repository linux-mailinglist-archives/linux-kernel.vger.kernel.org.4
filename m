Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B0267C10B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjAYXmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjAYXlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:41:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991AA5FDB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:51 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso211744pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN57XfC0N2Z9PnMQ9nUjXYfVmJE2FGzydu2ZVvrzX3Q=;
        b=P6CDrkzJSgET54MDlG18KNSNOlZoW3MU7+hkgLqRJ/5Xqzgl8we5PZOg1hkICvX2CV
         qJuAyZ0zwDf79dalVbx6THwSx5WpRv7irQY4fWrO65cPK9qxlsBx0aRlT9bMDJUF1IWk
         Vdc3Flt7m1v4/SJ2NceeyIu3ROeYczykNgzpa6MKvRiWkg3DKWUnET3/mPqUh8G50olU
         TZeUw09UecGDHUoaAyfy+kXlHDrlCQD7OBWh+QrMS+SXz98gVihHyB7H5Lkz5OvooRno
         IJSQLLalXZorgQX63BTIU5Rmz6BSXpttPAnERpvzhMa9w+rhHUUo1reXjMpAwfuE0P5c
         DeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN57XfC0N2Z9PnMQ9nUjXYfVmJE2FGzydu2ZVvrzX3Q=;
        b=TeFtzNW+SQGD9ZrMLThSLubp8Al03gq7LI2U5ou7ElCiebmI6+hUEpMEQ1OyCrXcC/
         knplikuJeUV7efobtpev3MzJoWQVU0kycFH5qe2xjSOGLt0KhG1jG2H9fAkpWXwtOnGc
         qZbo2L+CsrO6vyRdSzfw+rsmTJrluJUXfIjKkij4TPPS0iUiZH4A/Tz6z/OhYk7Z2dYN
         Ve2wD6GjjtoQCaAvJUHuwiyh55WBC861ySf52N6E7DDhxOWyuFByLkEneQx98gkLnynU
         DBQiXkN7RCeFNI/F+8IddOSWOvXV/dmjG2tTzC4ijA5sBUn9F2O/l7HhBmp/tmuP5pA3
         sy4Q==
X-Gm-Message-State: AFqh2kodCdR7RqvGQ/QqhRjkQ0HQtu0RJFSDopTY97s5HSR1WjIaAxcC
        4k0Xh408sX4hGtgsJdXVgyQVwQejn+t/9w==
X-Google-Smtp-Source: AMrXdXulsPWSiWTwVZGqHBrrwSWR9r4OEwxKEGBefyPEA2GtBCq+t9NogNmvV2nutnNPlWn7MjG4Mg==
X-Received: by 2002:a17:90a:86ca:b0:225:d697:41ea with SMTP id y10-20020a17090a86ca00b00225d69741eamr36754049pjv.23.1674690111263;
        Wed, 25 Jan 2023 15:41:51 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id e8-20020a17090a630800b00219752c8ea5sm2226806pjj.37.2023.01.25.15.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 15:41:50 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v3 6/6] mm/mempolicy: Convert migrate_page_add() to migrate_folio_add()
Date:   Wed, 25 Jan 2023 15:41:34 -0800
Message-Id: <20230125234134.227244-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230125234134.227244-1-vishal.moola@gmail.com>
References: <20230125234134.227244-1-vishal.moola@gmail.com>
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

