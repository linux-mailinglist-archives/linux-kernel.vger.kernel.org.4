Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967DE681B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjA3UTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjA3USq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:18:46 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADD41727
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:45 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id ay1so8599296pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSeBOBmV5irVttghOKU/WEyUh0YnA4r3UGGroMyochk=;
        b=Uoo5nyF2OvMxPs0CxInigN1mJkJMwm5kATVUZBZlY8FvxSKwsrCYPNOpgk9ixI1C13
         jjmHWadhrt9csTXfa3+84oLpPKGjkm5nWzcKsmF3eCUMdqoCWKJzjSItxDE1yFsLl266
         9YgCoQXUE60Y10w/pTt7qjpCo4MjYCMpgGlnTRfQpj0XPFYYYBG2zNd2r66nMD/Pmh/n
         0Ujs1OUPo1skoLWFTbngUeBk9H47O+nou8ws2yllTFrC6eEE4HEPj4iGeUJUviOPlI4g
         /gvHSiUfmZYXMkFrMNKUMKPQvcCtnMffPqy38v0jcPg2BOydF1h0qE4YIIqwlenrzOl6
         RCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSeBOBmV5irVttghOKU/WEyUh0YnA4r3UGGroMyochk=;
        b=sRouzQMBzNBYBh7C0CBIOVKqYe1NydBbtim2m7/afEnWPSCxNn5dNyguC2Xq6cyBF7
         hlEQvpAXGpLjm5WHj8X5ixgLQfbfKQBb4qPtcE1cprKuziFSIwFfZMK6ujW6lZgWmbWu
         IT0am2ZBZ80C/u5qcsFSfd01ymxSYJ/xZmZNJWHPKif9ollVlQ2YWRFaPlYIg8twVdbK
         yYF0/NkDohjTUK/enVINM3DWCUmZ2ALxWpydt7wyZhBuLXJqmfq5zEaEYri7VTczXwvp
         h9CQ/hmZk3w8a0A7D9N8s/j5Q7ZtWMdzioxXUjU/k+eOOyKnKxI+cr6KKaSWy8asl1kI
         o4Kg==
X-Gm-Message-State: AO0yUKUfuF6G+MUlx37Ux9ewttrJcNvFKkYMFV6vXSPV1BG8JlTllKPH
        hfTQng745mwxR8HrOegAIpE=
X-Google-Smtp-Source: AK7set+DszPwpSPBVBkWWwuActthXmx+XqB/olsEL1Pq6RwXLA89syW3jS5kw/6r1MPLSHmjUCv5yg==
X-Received: by 2002:aa7:8883:0:b0:58d:ca02:3fd6 with SMTP id z3-20020aa78883000000b0058dca023fd6mr12047476pfe.25.1675109925162;
        Mon, 30 Jan 2023 12:18:45 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::a8cd])
        by smtp.googlemail.com with ESMTPSA id g9-20020a056a000b8900b0058d9730ede0sm113262pfj.210.2023.01.30.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:18:44 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v4 4/6] mm/mempolicy: convert queue_pages_hugetlb() to queue_folios_hugetlb()
Date:   Mon, 30 Jan 2023 12:18:31 -0800
Message-Id: <20230130201833.27042-5-vishal.moola@gmail.com>
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

This change is in preparation for the conversion of queue_pages_required()
to queue_folio_required() and migrate_page_add() to migrate_folio_add().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b0805bb87655..668392493500 100644
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
@@ -591,21 +591,28 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
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
-	    (flags & MPOL_MF_MOVE && page_mapcount(page) == 1 &&
+	    (flags & MPOL_MF_MOVE && folio_estimated_sharers(folio) == 1 &&
 	     !hugetlb_pmd_shared(pte))) {
-		if (isolate_hugetlb(page_folio(page), qp->pagelist) &&
+		if (isolate_hugetlb(folio, qp->pagelist) &&
 			(flags & MPOL_MF_STRICT))
 			/*
-			 * Failed to isolate page but allow migrating pages
+			 * Failed to isolate folio but allow migrating pages
 			 * which have been queued.
 			 */
 			ret = 1;
@@ -703,7 +710,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 }
 
 static const struct mm_walk_ops queue_pages_walk_ops = {
-	.hugetlb_entry		= queue_pages_hugetlb,
+	.hugetlb_entry		= queue_folios_hugetlb,
 	.pmd_entry		= queue_folios_pte_range,
 	.test_walk		= queue_pages_test_walk,
 };
-- 
2.38.1

