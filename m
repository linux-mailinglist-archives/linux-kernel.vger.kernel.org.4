Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9942C67C10A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbjAYXl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjAYXlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:41:50 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FC515C8A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso241884pjf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz4HU32GWbuxfmIkQjW0u4ISqBHZ5RIiVnsfOJ2Lp54=;
        b=dmcxWY8U8wAh2AlCeZFmiUjni88jRf+FuhGzSc73OspKeJg/jDgHIv8asRJVZPLE7M
         GeKI9hjadJUH2P0ponOvP3pbBraa8S/sk+8nTl4/oqYo8JIFSVUDaHw97FrPx7bfNMeo
         IJM+6DNiaCAdp7b5r7OTFO2h/cIicEasMLMQulW80HW0FxGMwht/P0Z1SgDxEeIXj8ay
         2XqexkXBfBMFdPiiPa5MRPZOB4u9lcaP/PQFrDUw4y91ocEY92PcwC3UgXttppZ+VloB
         bHpeYO3CnwoDG+CP4gqrrpWVu95EqQynL873hIUCRONzU4/DRWp2/OjNZ5OfpzIHluv5
         h5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz4HU32GWbuxfmIkQjW0u4ISqBHZ5RIiVnsfOJ2Lp54=;
        b=Us+zlwAzv8xA7AYGLHLg9hXkDIbGswTbtBjHiJieCEw8HYYcQ8flIjYlUq6odp0Wtu
         JunraBMxuhLhk236MFfk7c5FvE0B+HES5KpLB8oc6kSM4GP9NOoJ0zYZuhibtZjlAll0
         mqIzw8yPdeJu9WUA7t+IUbFx3j3CzShZWXqJj7Jk8azIxX5nYik7gS1z6AJ7RUD12sEn
         AIxhDgaJLD+m9+P9L8hES59bbI1GjGbaNhpXy3Jyppvkk81f41zrQIvAJ/rF2MRaaD1d
         X5195XtGxc4aynblrdNeQ8hT/fPAlOj7fjzrB0nRvDFIKoeR/zoWUOiuQs7AO7xF2vp0
         H3ow==
X-Gm-Message-State: AFqh2ko6/Zg+vK1VgzUXtBMxz3iB6dYGqLqjd+awUy46Zl95iwzDQWao
        Dcvk7aamQ0vEqLv+i8ASkWM=
X-Google-Smtp-Source: AMrXdXsXHo3GclXuQ2bpTqlIoBZsCQOEjXZP3AX7aqO/uZ63Y2s2D6JyQLIgnnmthEvorHx4y3b9Fg==
X-Received: by 2002:a17:90b:4fc2:b0:229:680:1729 with SMTP id qa2-20020a17090b4fc200b0022906801729mr34762484pjb.10.1674690108968;
        Wed, 25 Jan 2023 15:41:48 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id e8-20020a17090a630800b00219752c8ea5sm2226806pjj.37.2023.01.25.15.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 15:41:48 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v3 4/6] mm/mempolicy: Convert queue_pages_hugetlb() to queue_folios_hugetlb()
Date:   Wed, 25 Jan 2023 15:41:32 -0800
Message-Id: <20230125234134.227244-5-vishal.moola@gmail.com>
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

This change is in preparation for the conversion of
queue_pages_required() to queue_folio_required() and migrate_page_add()
to migrate_folio_add().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ae9d16124f45..ea8cac447e04 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -558,7 +558,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 	return addr != end ? -EIO : 0;
 }
 
-static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
+static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 			       unsigned long addr, unsigned long end,
 			       struct mm_walk *walk)
 {
@@ -566,7 +566,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 #ifdef CONFIG_HUGETLB_PAGE
 	struct queue_pages *qp = walk->private;
 	unsigned long flags = (qp->flags & MPOL_MF_VALID);
-	struct page *page;
+	struct folio *folio;
 	spinlock_t *ptl;
 	pte_t entry;
 
@@ -574,13 +574,13 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	entry = huge_ptep_get(pte);
 	if (!pte_present(entry))
 		goto unlock;
-	page = pte_page(entry);
-	if (!queue_pages_required(page, qp))
+	folio = pfn_folio(pte_pfn(entry));
+	if (!queue_pages_required(&folio->page, qp))
 		goto unlock;
 
 	if (flags == MPOL_MF_STRICT) {
 		/*
-		 * STRICT alone means only detecting misplaced page and no
+		 * STRICT alone means only detecting misplaced folio and no
 		 * need to further check other vma.
 		 */
 		ret = -EIO;
@@ -591,20 +591,27 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 		/*
 		 * Must be STRICT with MOVE*, otherwise .test_walk() have
 		 * stopped walking current vma.
-		 * Detecting misplaced page but allow migrating pages which
+		 * Detecting misplaced folio but allow migrating folios which
 		 * have been queued.
 		 */
 		ret = 1;
 		goto unlock;
 	}
 
-	/* With MPOL_MF_MOVE, we migrate only unshared hugepage. */
+	/*
+	 * With MPOL_MF_MOVE, we try to migrate only unshared folios. If it
+	 * is shared it is likely not worth migrating.
+	 *
+	 * To check if the folio is shared, ideally we want to make sure
+	 * every page is mapped to the same process. Doing that is very
+	 * expensive, so check the estimated mapcount of the folio instead.
+	 */
 	if (flags & (MPOL_MF_MOVE_ALL) ||
-	    (flags & MPOL_MF_MOVE && page_mapcount(page) == 1)) {
-		if (isolate_hugetlb(page_folio(page), qp->pagelist) &&
+	    (flags & MPOL_MF_MOVE && folio_estimated_mapcount(folio) == 1)) {
+		if (isolate_hugetlb(folio, qp->pagelist) &&
 			(flags & MPOL_MF_STRICT))
 			/*
-			 * Failed to isolate page but allow migrating pages
+			 * Failed to isolate folio but allow migrating folios
 			 * which have been queued.
 			 */
 			ret = 1;
@@ -702,7 +709,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 }
 
 static const struct mm_walk_ops queue_pages_walk_ops = {
-	.hugetlb_entry		= queue_pages_hugetlb,
+	.hugetlb_entry		= queue_folios_hugetlb,
 	.pmd_entry		= queue_folios_pte_range,
 	.test_walk		= queue_pages_test_walk,
 };
-- 
2.38.1

