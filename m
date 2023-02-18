Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E969B6D3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjBRAaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjBRA3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:42 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2DC6CA0B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:08 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53659bb998bso19841337b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LnPCXYu0bp3jbi4b+RX4dTJj+ODlc15FNHREFY5xs1M=;
        b=eyB1wewXCAx1HDERPMCO0zwZAas4YhYFgV+T58Xo/niWsDRG5UC3Rs6XOZmH1VN6an
         BDeTgeZmAtV2U/RJBmPsaw2Pzs+502TrDV5JW7uSQjIUphjyqQ6JBLVLZiSywnbCwmN7
         glxseLDjZd3DHe25r9gB54clLLLOql2zDYooJkeUUmIQE39+XJaDt5UKqvRy0vPMNP/Y
         dlrZCv9EsYeOE222dzKUD7vcvUi3Z842TugU3j8cUBo6f42mvUEeN6sqIIjBwYUd3WND
         0vcWoKQXj/p0vdSibSMZSUoLzsYHkjTdgECKTuMGuOdbRhA9Y6lS7gs45B0ytQxsj3iT
         jZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnPCXYu0bp3jbi4b+RX4dTJj+ODlc15FNHREFY5xs1M=;
        b=OLyhVAiIqtK+yl2Irpuzxp2eYUip01qlGu5vPCmxhn7NQg9GV/vsg63ElMTvbiYNkR
         ZwgHTxNRBvrHj9CRhrVC7RodZ5i6mCjagpNixUv5UhHPteN5THoCM+xGr0cgtPMAaHiE
         04A3mtDU44qCsU+NUwU8hsLjJjRCMT823oVljq0TghxOBtE4Z6CnGCHzVb43iYsQdVDI
         pPPjTv5QnyOEONh2j3iR7Q5KEYy9lr550xZfUJjAKbJHXCqkIh6gaK47NtZrF8+zRYe/
         rtQPir8F6JXYVDQn2FyJjSPE1fL8NM+r40PKNDU32G6GxsRYM3fp8y3aXRHveUHAAqfL
         QRuA==
X-Gm-Message-State: AO0yUKXlACgaFw7dzuLliG3E6cMeqyqLyryWYx3OcZJ9otOD9J17vH72
        2zKOHYZdl73bH6ygctbbR8OFvjBIdGzULVQo
X-Google-Smtp-Source: AK7set8Hmr9k0Rf2FDN/phGApjkx1AsdUQUwGd2TSqsgrixKWblzVEB77ByAXj7RTzk+3xBvLZoYclWlE/0WLKho
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:ec7:0:b0:965:bac9:d458 with SMTP id
 a7-20020a5b0ec7000000b00965bac9d458mr8139ybs.11.1676680146246; Fri, 17 Feb
 2023 16:29:06 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:56 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-24-jthoughton@google.com>
Subject: [PATCH v2 23/46] hugetlb: add HGM support to move_hugetlb_page_tables
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

This is very similar to the support that was added to
copy_hugetlb_page_range. We simply do a high-granularity walk now, and
most of the rest of the code stays the same.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 210c6f2b16a5..6c4678b7a07d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5461,16 +5461,16 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	return ret;
 }
 
-static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
-			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte)
+static void move_hugetlb_pte(struct vm_area_struct *vma, unsigned long old_addr,
+			     unsigned long new_addr, struct hugetlb_pte *src_hpte,
+			     struct hugetlb_pte *dst_hpte)
 {
-	struct hstate *h = hstate_vma(vma);
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *src_ptl, *dst_ptl;
 	pte_t pte;
 
-	dst_ptl = huge_pte_lock(h, mm, dst_pte);
-	src_ptl = huge_pte_lockptr(huge_page_shift(h), mm, src_pte);
+	dst_ptl = hugetlb_pte_lock(dst_hpte);
+	src_ptl = hugetlb_pte_lockptr(src_hpte);
 
 	/*
 	 * We don't have to worry about the ordering of src and dst ptlocks
@@ -5479,8 +5479,8 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	if (src_ptl != dst_ptl)
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
-	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
-	set_huge_pte_at(mm, new_addr, dst_pte, pte);
+	pte = huge_ptep_get_and_clear(mm, old_addr, src_hpte->ptep);
+	set_huge_pte_at(mm, new_addr, dst_hpte->ptep, pte);
 
 	if (src_ptl != dst_ptl)
 		spin_unlock(src_ptl);
@@ -5498,9 +5498,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long old_end = old_addr + len;
 	unsigned long last_addr_mask;
-	pte_t *src_pte, *dst_pte;
 	struct mmu_notifier_range range;
 	bool shared_pmd = false;
+	struct hugetlb_pte src_hpte, dst_hpte;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, old_addr,
 				old_end);
@@ -5516,28 +5516,35 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	/* Prevent race with file truncation */
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
-	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
-		src_pte = hugetlb_walk(vma, old_addr, sz);
-		if (!src_pte) {
-			old_addr |= last_addr_mask;
-			new_addr |= last_addr_mask;
+	while (old_addr < old_end) {
+		if (hugetlb_full_walk(&src_hpte, vma, old_addr)) {
+			/* The hstate-level PTE wasn't allocated. */
+			old_addr = (old_addr | last_addr_mask) + sz;
+			new_addr = (new_addr | last_addr_mask) + sz;
 			continue;
 		}
-		if (huge_pte_none(huge_ptep_get(src_pte)))
+
+		if (huge_pte_none(huge_ptep_get(src_hpte.ptep))) {
+			old_addr += hugetlb_pte_size(&src_hpte);
+			new_addr += hugetlb_pte_size(&src_hpte);
 			continue;
+		}
 
-		if (huge_pmd_unshare(mm, vma, old_addr, src_pte)) {
+		if (hugetlb_pte_size(&src_hpte) == sz &&
+		    huge_pmd_unshare(mm, vma, old_addr, src_hpte.ptep)) {
 			shared_pmd = true;
-			old_addr |= last_addr_mask;
-			new_addr |= last_addr_mask;
+			old_addr = (old_addr | last_addr_mask) + sz;
+			new_addr = (new_addr | last_addr_mask) + sz;
 			continue;
 		}
 
-		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
-		if (!dst_pte)
+		if (hugetlb_full_walk_alloc(&dst_hpte, new_vma, new_addr,
+					hugetlb_pte_size(&src_hpte)))
 			break;
 
-		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte);
+		move_hugetlb_pte(vma, old_addr, new_addr, &src_hpte, &dst_hpte);
+		old_addr += hugetlb_pte_size(&src_hpte);
+		new_addr += hugetlb_pte_size(&src_hpte);
 	}
 
 	if (shared_pmd)
-- 
2.39.2.637.g21b0678d19-goog

