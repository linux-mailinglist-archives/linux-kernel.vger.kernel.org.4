Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C416672C85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjARXWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjARXW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:22:26 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE2666EF7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:22:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y1so664224plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR1JcCUA9O2Vny3R+G4SUtwxLVo8Eke3dTYifmkKbTA=;
        b=VLVGj2MeNhV4dG8tqMCOaUdWWZUjRbL/wzXS2nrU9rMdcdiWoHupAjfnkS2LZ1UIzY
         EIrqU/eNtw167F98QPa+DlF0ttEz6P6jzss97ZHeMD+Mnp+0o17cR9id+VKeOvQQTo3U
         yCYIeFH96KTFdJyLdWHN+Y55hcNZwYOVh0olOR9/ydyvrvK3SrD7Ds/NSW1Z0mk/pf2m
         RhJSpm+Ca0ZYRz9opt+TrOTf+OIbRsYV0dxpzVQLYDESUfHLZoFpRJy20nXvMeS7rqRO
         tTccJ45EBAGYT0CVJTr0FvUCBeU7cNfdMTbnxr39qIXoSZB1IxqhH3nzHofdm80Ce5K8
         EJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR1JcCUA9O2Vny3R+G4SUtwxLVo8Eke3dTYifmkKbTA=;
        b=4fGmfZs/CpCoWtEkc4D1jzPOblbckwDIOVabvTgDdm27Yck97Gx/en+SUfGZ5rOVDj
         bFfSaYnCV7nogRUw/MICWSj0HOHENJ71uAziAOzANZZEWsAuWW1NOJFjYvoaaVYWEV7u
         Z2VYnPmmkDXyoYykPhwIGkNBlBpHPGg3eBtBqmRG/Tv7ZPFfzGvo0E9x3cpC+OGbHkkx
         TzMzKvHe91ILsGK4zG3Z7jjN1/FGKi/gx0q1pQ3ZZKBzlDlPw0bbYuvkX3ryn6W34noT
         nl/DWpKdsmDoFlhevBTtSY9A2pEpvsCzXYFOD4xkyrNhQDii3LkaXEGw+/o+twurh8Mh
         vR2A==
X-Gm-Message-State: AFqh2kqRDmVgZPWPbGv8fiLTWeEOwn0kZFQdo1DMoaJgphIwV33u3cH2
        wqVY6V1XaQJhLfrDAAjrGqw=
X-Google-Smtp-Source: AMrXdXt0ENl5WIQO0+QtroAVNydcvggXodDzKiNp1GCI+BCD3n+pIqAhLtX5Ca38kf6D0ROrCrVurA==
X-Received: by 2002:a17:90a:2dce:b0:229:4a04:65eb with SMTP id q14-20020a17090a2dce00b002294a0465ebmr9156656pjm.31.1674084145299;
        Wed, 18 Jan 2023 15:22:25 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::4e4b])
        by smtp.googlemail.com with ESMTPSA id k1-20020a17090a7f0100b00223f495dc28sm1862265pjl.14.2023.01.18.15.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:22:25 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable 3/5] mm/mempolicy: Convert queue_pages_hugetlb() to queue_folios_hugetlb()
Date:   Wed, 18 Jan 2023 15:22:17 -0800
Message-Id: <20230118232219.27038-4-vishal.moola@gmail.com>
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

This change is in preparation for the conversion of
queue_pages_required() to queue_folio_required() and migrate_page_add()
to migrate_folio_add().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/mempolicy.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ae9d16124f45..0b82f8159541 100644
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
@@ -591,7 +591,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 		/*
 		 * Must be STRICT with MOVE*, otherwise .test_walk() have
 		 * stopped walking current vma.
-		 * Detecting misplaced page but allow migrating pages which
+		 * Detecting misplaced folio but allow migrating folios which
 		 * have been queued.
 		 */
 		ret = 1;
@@ -600,11 +600,11 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 
 	/* With MPOL_MF_MOVE, we migrate only unshared hugepage. */
 	if (flags & (MPOL_MF_MOVE_ALL) ||
-	    (flags & MPOL_MF_MOVE && page_mapcount(page) == 1)) {
-		if (isolate_hugetlb(page_folio(page), qp->pagelist) &&
+	    (flags & MPOL_MF_MOVE && folio_mapcount(folio) == 1)) {
+		if (isolate_hugetlb(folio, qp->pagelist) &&
 			(flags & MPOL_MF_STRICT))
 			/*
-			 * Failed to isolate page but allow migrating pages
+			 * Failed to isolate folio but allow migrating folios
 			 * which have been queued.
 			 */
 			ret = 1;
@@ -702,7 +702,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 }
 
 static const struct mm_walk_ops queue_pages_walk_ops = {
-	.hugetlb_entry		= queue_pages_hugetlb,
+	.hugetlb_entry		= queue_folios_hugetlb,
 	.pmd_entry		= queue_folios_pte_range,
 	.test_walk		= queue_pages_test_walk,
 };
-- 
2.38.1

