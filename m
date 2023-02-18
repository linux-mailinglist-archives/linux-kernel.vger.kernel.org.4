Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8483069B6D5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBRAbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjBRAaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:30:16 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A257964B22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5365a8e6d8dso18114837b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GaGw9/EzNbJa/6t4pJ7yTdVKyp/NxSZHrGSlaKMUK+E=;
        b=JocgWYINYVmULfBzV4L8RQDVrC/ksz9Y8dI+J+nlAsc/Rp1x6bcRPeZoTXr9WfAAcE
         637vbboTsrEowR0AFIppjUO9sj33exLylRWnzGJRB4Ke4REBcvqZSCDhAGTVp/j5YufQ
         YgJobCIYoQmdFEhMN4GhlXFaOyyGAAfpa0yi+wp2F9k5f0rcjtQQjbs0cPJHzrVzFUhk
         50adDYi9tmH1ngFR2JYpBWBk6Q0MNk3dZbjF//o0K6YVOKO0ibfrqlf5m/HRlbVFSL22
         zZbQkatRHAWrwIFzYMCpOzJ34fpVzrSFt1DFYR7+DUtjlcSXBgnd1OMWELyjBlQGE0L4
         N6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaGw9/EzNbJa/6t4pJ7yTdVKyp/NxSZHrGSlaKMUK+E=;
        b=BFhwe3q2T8PM0Yr8wQ1Cqa/BHYcdYzAxA0xGpGwXX6DctVUR//wKKoH8z5uuOJQGTO
         3W3hqX48V9aKR4G9H9ksHPutSSh3cYJHxyz7xOiDEyLeGoYTV6qNnuar2tCoIDkmgg1X
         Xl71DxR9aFonk/tpwTX2C0ekHh5Q5pECu7G8uA3UcqJw/MCm7YA26j5IpWGvMA/6BGjZ
         MJOLgrz0eQbMUVVzSHReTSb9Ac9EtOk/OZU+qbe++7VEnppEo8HzkmbAFmiewkkffDBW
         O19lAB/bAA4MkXUaCP2m72/tbQwtrProSD3/VLf9xrnGYJT65OMtqvoVFyhMSW50tt1x
         gMqA==
X-Gm-Message-State: AO0yUKVAz+dU636JJcw48hVFNoHmrPqzGjFomNzoTz3lZWs+D6AEmf3F
        QE6vX3e5z69mUWVb2/BKh0k2gl1kGt+UTwOO
X-Google-Smtp-Source: AK7set9wC+TS+nhluAugC3NIlRB72Nwu/shM7r466HV9itDauVe/hJjpxls4Y6ZfyXihDUoWjGrwgClTAbgrS6MV
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:12c8:b0:8e3:6aea:973 with SMTP
 id j8-20020a05690212c800b008e36aea0973mr91564ybu.4.1676680161464; Fri, 17 Feb
 2023 16:29:21 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:10 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-38-jthoughton@google.com>
Subject: [PATCH v2 37/46] hugetlb: replace make_huge_pte with make_huge_pte_with_shift
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

This removes the old definition of make_huge_pte, where now we always
require the shift to be explicitly given. All callsites are cleaned up.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e0a92e7c1755..4c9b3c5379b2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5204,9 +5204,9 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.pagesize = hugetlb_vm_op_pagesize,
 };
 
-static pte_t make_huge_pte_with_shift(struct vm_area_struct *vma,
-				      struct page *page, int writable,
-				      int shift)
+static pte_t make_huge_pte(struct vm_area_struct *vma,
+			   struct page *page, int writable,
+			   int shift)
 {
 	pte_t entry;
 
@@ -5222,14 +5222,6 @@ static pte_t make_huge_pte_with_shift(struct vm_area_struct *vma,
 	return entry;
 }
 
-static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
-			   int writable)
-{
-	unsigned int shift = huge_page_shift(hstate_vma(vma));
-
-	return make_huge_pte_with_shift(vma, page, writable, shift);
-}
-
 static void set_huge_ptep_writable(struct vm_area_struct *vma,
 				   unsigned long address, pte_t *ptep)
 {
@@ -5272,7 +5264,9 @@ hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long add
 {
 	__folio_mark_uptodate(new_folio);
 	hugepage_add_new_anon_rmap(new_folio, vma, addr);
-	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, &new_folio->page, 1));
+	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(
+				vma, &new_folio->page, 1,
+				huge_page_shift(hstate_vma(vma))));
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
 	folio_set_hugetlb_migratable(new_folio);
 }
@@ -6006,7 +6000,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		hugetlb_remove_rmap(old_page, huge_page_shift(h), h, vma);
 		hugepage_add_new_anon_rmap(new_folio, vma, haddr);
 		set_huge_pte_at(mm, haddr, ptep,
-				make_huge_pte(vma, &new_folio->page, !unshare));
+				make_huge_pte(vma, &new_folio->page, !unshare,
+					      huge_page_shift(h)));
 		folio_set_hugetlb_migratable(new_folio);
 		/* Make the old page be freed below */
 		new_folio = page_folio(old_page);
@@ -6348,7 +6343,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	else
 		hugetlb_add_file_rmap(subpage, hpte->shift, h, vma);
 
-	new_pte = make_huge_pte_with_shift(vma, subpage,
+	new_pte = make_huge_pte(vma, subpage,
 			((vma->vm_flags & VM_WRITE)
 			 && (vma->vm_flags & VM_SHARED)),
 			hpte->shift);
@@ -6770,8 +6765,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
 
-	_dst_pte = make_huge_pte_with_shift(dst_vma, subpage, writable,
-			dst_hpte->shift);
+	_dst_pte = make_huge_pte(dst_vma, subpage, writable, dst_hpte->shift);
 	/*
 	 * Always mark UFFDIO_COPY page dirty; note that this may not be
 	 * extremely important for hugetlbfs for now since swapping is not
@@ -8169,8 +8163,7 @@ static int __hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
 		}
 
 		subpage = hugetlb_find_subpage(h, folio, curr);
-		entry = make_huge_pte_with_shift(vma, subpage,
-						 writable, hpte.shift);
+		entry = make_huge_pte(vma, subpage, writable, hpte.shift);
 		hugetlb_add_file_rmap(subpage, hpte.shift, h, vma);
 		set_huge_pte_at(mm, curr, hpte.ptep, entry);
 		spin_unlock(ptl);
-- 
2.39.2.637.g21b0678d19-goog

