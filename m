Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FD1681B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjA3UTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3USt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:18:49 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C4474E4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:47 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 7so8510795pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj/qU+zS2SpVSC06qhYsv6OtjuVRmpJHRc9Sl9s1IRQ=;
        b=Tj3i6e31rScg++PudsTthpoxV+1jPlpPlY3/2b5Bf0/UDddmvfwoSeZ+wYXRcuVc2s
         wRlQRVqhaPdfYKY1/JcUFWGAyeH43ttEzDrtWbqT+7iJn/MB4dHk+JXlS32nb7igoFty
         J9/9643gbLQ/ImSRTqG97EHjD5VvPpCXcog14K0EjqXA51AkRgjmIbWqnOfPPXFe65Ri
         MDyBz/g7XdxdVnoMxbYe2N6WuWw1NeC62o4FfTo4S/s3M+4uRlhzGZ/c6TYRKZXNODpk
         TDOT5lG0BDlRIhjVRNv7IIUn6wH7Sx+sBaVWNVUw/fpiys5R733Q1SifNCc1biGkBk2W
         r0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rj/qU+zS2SpVSC06qhYsv6OtjuVRmpJHRc9Sl9s1IRQ=;
        b=7PRZECPs5QGjkDULkhV9S2JkxhpSvts0x6oKN36V0v9033Qr3Dq26g+cKQRQ+Oo8x1
         mBcUi2VF1/I8RPpXMKYZNK+qgH49Mnlb97IG8dX+0/c+SGp8uWVdxheCkDgXuueAlMDU
         QIdoCxMaYuTKY7w8aFO9WVDXRX2f0QuqMdoA4EUScGl1AQItKaD7SWHk/7P1uDP64EEu
         syVuimwb4+Z7iMIZ50TWV6WbWqFaRAACReV4zJ/PdHrRzkcYEZ4UCNYh1gCUZT4FMh/d
         V2a5voSMOddMGxWmC4V6drehm0nyiubJBKKmpRue2YVXMcmMuh7Wfq8ZDJhdDA0dUiBG
         NH9w==
X-Gm-Message-State: AO0yUKUGV5jfnYOeYG/HhFYz2vGwps7+kUpN5VGvzl6m02w1kGFE37iE
        NJ3t7vQ5mxOdai+CjlaNlmc=
X-Google-Smtp-Source: AK7set8JYge76j6ldf/cIJq9uWBWkQOUiCPeaBC+LTVdk7HzGHP97Ti5ETwPgNXR/shIaFwgkw06Cw==
X-Received: by 2002:a62:3044:0:b0:590:64f1:8873 with SMTP id w65-20020a623044000000b0059064f18873mr7945965pfw.5.1675109927113;
        Mon, 30 Jan 2023 12:18:47 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id g9-20020a056a000b8900b0058d9730ede0sm113262pfj.210.2023.01.30.12.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:18:46 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v4 6/6] mm/mempolicy: convert migrate_page_add() to migrate_folio_add()
Date:   Mon, 30 Jan 2023 12:18:33 -0800
Message-Id: <20230130201833.27042-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230130201833.27042-1-vishal.moola@gmail.com>
References: <20230130201833.27042-1-vishal.moola@gmail.com>
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

Replace migrate_page_add() with migrate_folio_add().  migrate_folio_add()
does the same a migrate_page_add() but takes in a folio instead of a page.
This removes a couple of calls to compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6a68dbce3b70..0919c7a719d4 100644
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
@@ -1021,27 +1021,28 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
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
+	if ((flags & MPOL_MF_MOVE_ALL) || folio_estimated_sharers(folio) == 1) {
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
@@ -1235,7 +1236,7 @@ static struct page *new_page(struct page *page, unsigned long start)
 }
 #else
 
-static int migrate_page_add(struct page *page, struct list_head *pagelist,
+static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 				unsigned long flags)
 {
 	return -EIO;
-- 
2.38.1

