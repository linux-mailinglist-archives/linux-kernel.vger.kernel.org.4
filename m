Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE869B6C6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjBRAaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjBRA3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E148360F8D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:06 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536566339d6so26929197b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFEWCFEVqNzp10q8weB+17bzU0TWKtM8UIz/Xx7DMio=;
        b=jsCsMDMV78mjE8aA5hDj4ELvx3b3FYDfUCGtdB3AxH26EGW3FR4Wa7s8y12aCgjJAY
         xZHdXI0S9zLwyoyC2XXFQ/t878xZ76UJxTZdgaT1614gKQ8S86PPdMjKwYlq97dle3xZ
         X18JJ5MDR3KedDVpG1uX/f8VVj8pEdf241wOEt1/1ioMygZNzU7w6K5FfESBrPr6rcwL
         oyCOP/Tffhfxzt33/TtBRunbLaQrs+s+Ng2bav+9PXMaH8T+pd/4F//IKbtKNQ3pXtLn
         zm3LA/sIhVTcMgTue+SyM1JfkLU6x3PjoLgkHIa6SXkJODW1AhFZZ0jaKNWlzrRQQiMx
         uOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFEWCFEVqNzp10q8weB+17bzU0TWKtM8UIz/Xx7DMio=;
        b=HCe+oOi7FFFkPp3lIVuSIXEHLbjpBvrIAvnt9jZYus2jkriYkwRllplyGHUpSXFxiL
         GWUGb8D/3+tkjpktm2XkCHc1YEkKvYPMX/IO0xm7dftlu5zGjRwAxNB84uahGxvQZaqP
         KdMaDxYidZkpCPiw5EMJ2VJL/5wnJj29Bq2UAMgG7fJVCn40Dur5nntmSlw61aFwWIbY
         LQT8DGJAPYVdlWnzUDxmUc9qtfeewf8Ae3veTQKbat5dpGQutgqDBXHTSna2lmwX8cIE
         vQmnrDWl2k3KTkEt8x1GKdBxu+SXlvK/0tjaoNxRskeW7wmL64IzsX13omodT4mAKbzk
         fxCg==
X-Gm-Message-State: AO0yUKWSFdTOlwxBJ9HUj+z/bXjJsr4DwRatM/wYlIOhaVBRDWe0QnWn
        /o8mgUNwSh0svXpEMpmHCTu7b5Cy29dkuxtN
X-Google-Smtp-Source: AK7set+l/nyB7A0r6pHwCnr6M8cb+COlb7s5TL7EsXfsO+GgeuyPTV/etrosFrCflWYhmk4cAs1xco6548KS9NkT
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:10e:0:b0:94a:ebba:cba6 with SMTP id
 14-20020a5b010e000000b0094aebbacba6mr249759ybx.9.1676680144192; Fri, 17 Feb
 2023 16:29:04 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:54 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-22-jthoughton@google.com>
Subject: [PATCH v2 21/46] hugetlb: add HGM support to hugetlb_follow_page_mask
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change here is very simple: do a high-granularity walk.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c26b040f4fb5..693332b7e186 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6655,11 +6655,10 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 				unsigned long address, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long haddr = address & huge_page_mask(h);
 	struct page *page = NULL;
 	spinlock_t *ptl;
-	pte_t *pte, entry;
+	pte_t entry;
+	struct hugetlb_pte hpte;
 
 	/*
 	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
@@ -6669,13 +6668,24 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		return NULL;
 
 	hugetlb_vma_lock_read(vma);
-	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
-	if (!pte)
+
+	if (hugetlb_full_walk(&hpte, vma, address))
 		goto out_unlock;
 
-	ptl = huge_pte_lock(h, mm, pte);
-	entry = huge_ptep_get(pte);
+retry:
+	ptl = hugetlb_pte_lock(&hpte);
+	entry = huge_ptep_get(hpte.ptep);
 	if (pte_present(entry)) {
+		if (unlikely(!hugetlb_pte_present_leaf(&hpte, entry))) {
+			/*
+			 * We raced with someone splitting from under us.
+			 * Keep walking to get to the real leaf.
+			 */
+			spin_unlock(ptl);
+			hugetlb_full_walk_continue(&hpte, vma, address);
+			goto retry;
+		}
+
 		page = pte_page(entry) +
 				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
 		/*
-- 
2.39.2.637.g21b0678d19-goog

