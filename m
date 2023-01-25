Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D48667C109
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbjAYXl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjAYXlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:41:50 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884865FE1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j5so8592pjn.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vZic6jN1vVBvksvwJz1xQpCGfyGjrm+SSW90x/iIgk=;
        b=Kh4RfcbGLDn6wlmfeljol0sY1eBsJweLAeurosHOgEoNqinDlrYKhY8araOCBOa8wF
         I/o3DWf7ZyhOwYrBnjIJRzBu/1oB/NNffx5MEncS4Ysj8sudz0DvCcQtY9fGPeFgMfF3
         gKedCJxlAVgpI44tRJIRNaoo2AD/9FsRM5z2GBhyTI2MAjFKxNDv5qbOn4GX0RlVDWbT
         wOIc3zu6WO9W0NW0LMVWZ/+cPSyma7Hk0MtPYdhVAYyp8QnbYyoyev+Rcuk4Y3LqRtIm
         OtWmcd7GqPnf+HwQ2pxmx2LZVvI6PszEEAQlIgBPp3TtL0QXQaoEbcrbEc6fAkM9ag6v
         nOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vZic6jN1vVBvksvwJz1xQpCGfyGjrm+SSW90x/iIgk=;
        b=vf/G0W95z75W6ySqF4yEpZjvYRS9zbYsU22I3kHdNAzGgdCpRD5sU22isuzy2DGIYZ
         TkDfGSscapbxVBDXgikPmp+MXBETYf133qBppYcMYMVnlyRIN+ZJf9tA7pUWX2rDUiww
         y3O+nDD4zG0TA7ZNS1sAa32GkQWTxZpxPD/7m1d7XO3rX5wLXsl94d1R4l8oJmqZ/Qan
         7ygsosGiyD9nUjgFp6GwJbdySjOj7yQkOhJDMy8z6MiWqchMZhaz1HJNNUhokFN21Ptd
         PdKGE10bP3Ql4acG0R2L6aWvzsxk/FyJOcZrWWV2W7QIhoAqPuVM8zTYYv7qxZG2edbD
         4INQ==
X-Gm-Message-State: AFqh2kosJIlstvg3MoRERcrwraO27TGN1RUss+oOR+3j5LDbnTk64QVE
        Bk4hMRrIXkqXJRqjfVzqYbA=
X-Google-Smtp-Source: AMrXdXvYkeLDgOA+420enIPeVPOV1ZMOk9RJKxRmcpIlHaghsMRa14AqSMz9s53AItO9WVuQozAWfA==
X-Received: by 2002:a17:90a:7347:b0:226:b52e:f1b8 with SMTP id j7-20020a17090a734700b00226b52ef1b8mr35518920pjs.24.1674690107979;
        Wed, 25 Jan 2023 15:41:47 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id e8-20020a17090a630800b00219752c8ea5sm2226806pjj.37.2023.01.25.15.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 15:41:47 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v3 3/6] mm/mempolicy: Convert queue_pages_pte_range() to queue_folios_pte_range()
Date:   Wed, 25 Jan 2023 15:41:31 -0800
Message-Id: <20230125234134.227244-4-vishal.moola@gmail.com>
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

This function now operates on folios associated with ptes instead of
pages.

This change is in preparation for the conversion of
queue_pages_required() to queue_folio_required() and migrate_page_add()
to migrate_folio_add().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 00fffa93adae..ae9d16124f45 100644
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
@@ -703,7 +703,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 
 static const struct mm_walk_ops queue_pages_walk_ops = {
 	.hugetlb_entry		= queue_pages_hugetlb,
-	.pmd_entry		= queue_pages_pte_range,
+	.pmd_entry		= queue_folios_pte_range,
 	.test_walk		= queue_pages_test_walk,
 };
 
-- 
2.38.1

