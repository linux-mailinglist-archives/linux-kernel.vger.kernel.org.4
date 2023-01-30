Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B09681B39
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjA3UTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjA3USp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:18:45 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BE474F4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:44 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 78so8497387pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Nhbc0AgbHO5zV6t6mmHVD0PFRFqh3MKW7JYpBDIsYU=;
        b=nRv3hsG1oZEx1tRfncyxMeskGayFbaD3uykQ6nIJM9rxPmYih1WHusV9Y2O1iLGRxS
         +kfnhlN/Ocx15MTYrjdSPbVJHaKFKNxwXWvD+YgY48bzQyMiPXUvHKCZQdPqbzdCoKMg
         5ulCiSiG+QWzAZG+KStlmxZjgubTxggZSPapErWiXtKuMIN7+8pR+3kjuqKU28bFnhuK
         nTGunLTXpfPWao7Lye+vchwTPWeu8qIkkQCZ56/K0Xkv1yYFPw/XIEmsZEi8M10Epuii
         LyEJ09MbQEhwhoM+A4VuUjzoif+UoeAX4nLv7Ng62tII1BOOJ3YgAmg6am0gdFHw+RU+
         PgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Nhbc0AgbHO5zV6t6mmHVD0PFRFqh3MKW7JYpBDIsYU=;
        b=nHGPaa2ntTlr31AXjTdDUwH+yciO9OE6kS+M1MPFCKKxFesppupDzBldGNoVk09QD7
         R/E3d/aWlCYGHAZ10ntDNGqIl+F4d2tUXgEU56zbIhAFm5TY7/FuaKNoOPBZmrxXCKyM
         NI3VXVpPPF3lCTCyMQW20qr0aOP/KJwEF2ymfH4YM68U2e9++vYCFKKAImWrhNtBudta
         cId/AKp6EHfT0/ZdtrUg+xIAOQ6clCU/T3CBCGamhoP8owqq4NPwxGi2unYZ6RK+ij91
         FHy3eiOK7ACaPBiKcz+pAGHww6DKCZEnbZX2Fy/M8D/OZLCnkS/y8y38RbJ+NcAepVfq
         a0Kw==
X-Gm-Message-State: AO0yUKWpzM4xfjFDUAIGovThKJQpruhvlbCmWkLZWdwP36z6fmmBHXPY
        clmxesrWnGu1fIE3rJLWhxA=
X-Google-Smtp-Source: AK7set+YqzG592x28e6kZFTk/siUxYxEWaKBctpynci92iHX5sfOS9hsl3+DQ6yEMS9HJtV4dcMSig==
X-Received: by 2002:a05:6a00:212e:b0:592:5eab:3402 with SMTP id n14-20020a056a00212e00b005925eab3402mr10171232pfj.28.1675109924061;
        Mon, 30 Jan 2023 12:18:44 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id g9-20020a056a000b8900b0058d9730ede0sm113262pfj.210.2023.01.30.12.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:18:43 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v4 3/6] mm/mempolicy: convert queue_pages_pte_range() to queue_folios_pte_range()
Date:   Mon, 30 Jan 2023 12:18:30 -0800
Message-Id: <20230130201833.27042-4-vishal.moola@gmail.com>
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

This function now operates on folios associated with ptes instead of
pages.

This change is in preparation for the conversion of queue_pages_required()
to queue_folio_required() and migrate_page_add() to migrate_folio_add().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fc754dbcbbcd..b0805bb87655 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -491,19 +491,19 @@ static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
  * Scan through pages checking if pages follow certain conditions,
  * and move them to the pagelist if they do.
  *
- * queue_pages_pte_range() has three possible return values:
- * 0 - pages are placed on the right node or queued successfully, or
+ * queue_folios_pte_range() has three possible return values:
+ * 0 - folios are placed on the right node or queued successfully, or
  *     special page is met, i.e. zero page.
- * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
+ * 1 - there is unmovable folio, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
  *     specified.
- * -EIO - only MPOL_MF_STRICT was specified and an existing page was already
+ * -EIO - only MPOL_MF_STRICT was specified and an existing folio was already
  *        on a node that does not follow the policy.
  */
-static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
+static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 			unsigned long end, struct mm_walk *walk)
 {
 	struct vm_area_struct *vma = walk->vma;
-	struct page *page;
+	struct folio *folio;
 	struct queue_pages *qp = walk->private;
 	unsigned long flags = qp->flags;
 	bool has_unmovable = false;
@@ -521,16 +521,16 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
-		page = vm_normal_page(vma, addr, *pte);
-		if (!page || is_zone_device_page(page))
+		folio = vm_normal_folio(vma, addr, *pte);
+		if (!folio || folio_is_zone_device(folio))
 			continue;
 		/*
-		 * vm_normal_page() filters out zero pages, but there might
-		 * still be PageReserved pages to skip, perhaps in a VDSO.
+		 * vm_normal_folio() filters out zero pages, but there might
+		 * still be reserved folios to skip, perhaps in a VDSO.
 		 */
-		if (PageReserved(page))
+		if (folio_test_reserved(folio))
 			continue;
-		if (!queue_pages_required(page, qp))
+		if (!queue_pages_required(&folio->page, qp))
 			continue;
 		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 			/* MPOL_MF_STRICT must be specified if we get here */
@@ -544,7 +544,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			 * temporary off LRU pages in the range.  Still
 			 * need migrate other LRU pages.
 			 */
-			if (migrate_page_add(page, qp->pagelist, flags))
+			if (migrate_page_add(&folio->page, qp->pagelist, flags))
 				has_unmovable = true;
 		} else
 			break;
@@ -704,7 +704,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 
 static const struct mm_walk_ops queue_pages_walk_ops = {
 	.hugetlb_entry		= queue_pages_hugetlb,
-	.pmd_entry		= queue_pages_pte_range,
+	.pmd_entry		= queue_folios_pte_range,
 	.test_walk		= queue_pages_test_walk,
 };
 
-- 
2.38.1

