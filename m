Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC3678D46
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjAXBW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjAXBWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:22:19 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75BC36FFF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:18 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z3so10223247pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz4HU32GWbuxfmIkQjW0u4ISqBHZ5RIiVnsfOJ2Lp54=;
        b=lC28+7ohH3L7RY2bT2i8tSpTM0xlFz3lF6bAgzWUGWWmFuxCK9elPf2m6zudfvrEGg
         C0P+RSe+ZqsLvrnAo/JiYETRIQ66yDmYy1Y+7m15EK3VYcvv3JnlHD7zTuXxrywpBwQd
         9vHqfvl85thXMoCB+qYDT5sRsYpyOmjbSf5RadBW37gCwnBEzxoAHepyNfuXCw3YMT1d
         P6nO/DzbweEpICN9rva8V8Muh+vEGKcmGeavnWMFEJSIl5BcYihei18T9xvc3bRKoguG
         cdMZ1rBREAS4SrcIYWfHIGtpcBBJoUpS1fYsZShm49witX7KWcPvTkXRYtg1UZjBWUSm
         109w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz4HU32GWbuxfmIkQjW0u4ISqBHZ5RIiVnsfOJ2Lp54=;
        b=cpwgaYla1MxnwPM89uri6S306y4OTntEBJbZ/IzCH/Iw1hgSf70koz9eqvCtXC0Vbm
         4jRThe4jjllQyH5z+R81LZg4OYsWnMzVkA/9bdOOIDzuYigzuOttIhC0TO3x8R9c/Fb1
         fpZGWWz7fwYSzULakN6TCbTIwKvIypD7dquW89wo1lr/5baBau67mqlZ2HVBY880h3I3
         a/cBKlkOy0jPM6BlrFXnHex9m5N4W27JbVCNjOrG5YiHnfazql0lHIRDlXgmjIgID6p1
         XwpDzoQnN9uqCiAnXZ3xsdUUUdxGwLNSuefZVcJyI1nBT3UXGB8mlu8uDazul+6J4LQ4
         aDDw==
X-Gm-Message-State: AFqh2kqlXOsSAVUBLric/Lqzoy82vHtte//fumb6oNinqXkl+uBMgGWu
        hDEyh9jv4IdRRdKzGnW4iKA=
X-Google-Smtp-Source: AMrXdXtw7DPU0fDVIuSIik2FPwLQBTsSwI80gyL0ccUmEB45ha4+fG/kppN5E/z9R4rdHRg23IBUug==
X-Received: by 2002:a05:6a00:3006:b0:58b:5f9d:c2fe with SMTP id ay6-20020a056a00300600b0058b5f9dc2femr27661373pfb.29.1674523338114;
        Mon, 23 Jan 2023 17:22:18 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id 68-20020a620547000000b005825b8e0540sm213335pff.204.2023.01.23.17.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:22:17 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v2 4/6] mm/mempolicy: Convert queue_pages_hugetlb() to queue_folios_hugetlb()
Date:   Mon, 23 Jan 2023 17:22:08 -0800
Message-Id: <20230124012210.13963-5-vishal.moola@gmail.com>
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

