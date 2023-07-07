Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C8674A96A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 05:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjGGDmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 23:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGGDmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 23:42:47 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D371FD8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 20:42:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-557790487feso1060813a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688701341; x=1691293341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4dGEjrKfb91ScuG2fHCuxeZvT3NdSjT3lpyNvE2ruts=;
        b=H/q39WmXRkCBvEDAvejs6WAFVt8g0mtum2v9xkdNxHcXvgXuXkcj/Kb0eClS6NWUPl
         LskgSNmTLZdZIDiJvTj0wYEONNaOXTNxc8cl9ql4ANzcoqLQB1LZ+aNW3Msf6S/gl205
         lJfSCkLLHCEVcQCVotujdDswgZ+5h4Dppbt+mc0mREHR1L9v2WVPw6HGEElbds5VgODt
         KuqCZq06OFBt0jn8fuYNnYXPi99SjlF3LIv0ieItmgNeucvYas/tCqhUndTDmjCW8Hac
         BC3zx7Sj1rIUsX9is8/XkDwyyWws9d9jiCLhubDV95cQvyy/61arM57+5VSXeQEZKBz3
         MYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688701341; x=1691293341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dGEjrKfb91ScuG2fHCuxeZvT3NdSjT3lpyNvE2ruts=;
        b=WA42xNpQ8D0Epl3nUR/1KGHQMyLoJnHAAp2ZUDdqLi88Xy4gAFawU++1/pGW0Z5KKt
         W/fmTQNoycbZyzDCUs1CjDnRQhAVTyVpt62wa/e+F9b0Yd/dhXNvmGYPhq/J0H5tUwVx
         5Dsu04HrUGwVPav7CCR9imqNUrRz6QfdIGMSc3P6hh62ef64Zl4eX9bv6SMyMrF67X75
         VElP1O3ao1gfaVDREL9wfiUIBzg48gRyH5YdqQYdTN/THgFlDTDdU+aq7kdJU4aKPRGt
         dA1TigTk56/0nSo+ELg3HJEjbb70YtY9EEAJiZIIVwtzlNzrpyl38VeERaUBkWSlKatG
         l0VA==
X-Gm-Message-State: ABy/qLYCHZJhNtFYBiQvWY+SJRsVFEp1zXXavzs7Oi6natWTxCxo7zGe
        gXueYlC+5yXA5UatgEEk80DjsA==
X-Google-Smtp-Source: APBJJlENymPkMLpnB+sJaPNWjjjbgqSsvHOuNXuxOmz2QUFvvx/qpFDPbecDxjTodrte//Jb1NXK2Q==
X-Received: by 2002:a05:6a20:8408:b0:12d:39c6:9f94 with SMTP id c8-20020a056a20840800b0012d39c69f94mr4285144pzd.47.1688701341570;
        Thu, 06 Jul 2023 20:42:21 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id x1-20020a62fb01000000b00663b712bfbdsm1927743pfm.57.2023.07.06.20.42.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Jul 2023 20:42:20 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: hugetlb_vmemmap: fix a race between vmemmap pmd split
Date:   Fri,  7 Jul 2023 11:38:59 +0800
Message-Id: <20230707033859.16148-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable @page in __split_vmemmap_huge_pmd() to obtain a pmd
page without holding page_table_lock may possiblely get the page table
page instead of a huge pmd page.  The effect may be in set_pte_at()
since we may pass an invalid page struct, if set_pte_at() wants to
access the page struct (e.g. CONFIG_PAGE_TABLE_CHECK is enabled), it
may crash the kernel.  So fix it. And inline __split_vmemmap_huge_pmd()
since it only has one user.

Fixes: d8d55f5616cf ("mm: sparsemem: use page table lock to protect kernel pmd operations")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c2007ef5e9b0..4b9734777f69 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -36,14 +36,22 @@ struct vmemmap_remap_walk {
 	struct list_head	*vmemmap_pages;
 };
 
-static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 {
 	pmd_t __pmd;
 	int i;
 	unsigned long addr = start;
-	struct page *page = pmd_page(*pmd);
-	pte_t *pgtable = pte_alloc_one_kernel(&init_mm);
+	struct page *head;
+	pte_t *pgtable;
+
+	spin_lock(&init_mm.page_table_lock);
+	head = pmd_leaf(*pmd) ? pmd_page(*pmd) : NULL;
+	spin_unlock(&init_mm.page_table_lock);
 
+	if (!head)
+		return 0;
+
+	pgtable = pte_alloc_one_kernel(&init_mm);
 	if (!pgtable)
 		return -ENOMEM;
 
@@ -53,7 +61,7 @@ static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 		pte_t entry, *pte;
 		pgprot_t pgprot = PAGE_KERNEL;
 
-		entry = mk_pte(page + i, pgprot);
+		entry = mk_pte(head + i, pgprot);
 		pte = pte_offset_kernel(&__pmd, addr);
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
@@ -65,8 +73,8 @@ static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 		 * be treated as indepdenent small pages (as they can be freed
 		 * individually).
 		 */
-		if (!PageReserved(page))
-			split_page(page, get_order(PMD_SIZE));
+		if (!PageReserved(head))
+			split_page(head, get_order(PMD_SIZE));
 
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
@@ -80,20 +88,6 @@ static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 	return 0;
 }
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
-{
-	int leaf;
-
-	spin_lock(&init_mm.page_table_lock);
-	leaf = pmd_leaf(*pmd);
-	spin_unlock(&init_mm.page_table_lock);
-
-	if (!leaf)
-		return 0;
-
-	return __split_vmemmap_huge_pmd(pmd, start);
-}
-
 static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
 			      unsigned long end,
 			      struct vmemmap_remap_walk *walk)
-- 
2.11.0

