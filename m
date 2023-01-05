Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE55D65E8EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjAEKXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjAEKVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D30559F7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k18-20020a25e812000000b0077cc9ab9dd9so27183271ybd.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEbQ+jBtLxtopyfN7uZpWk6gsndFSvLkXCtItdMk4sk=;
        b=rzwvJ5O+RQ04BJH+OwNVawRQc+ih25bUT/fZ/ETXftYRdFLi35+tT7QSZVPpjxQS1b
         ABqV/Hscpt1tyn1fI606OsdBiPRbxM/DjtciO23jBbkIiSjZtGIU3B25/psNHjy2QqL+
         n+3yYQBuUK1pJUfmrrK81ggN3y49WxAlQreHX/XO36/3irdaWFvE8DSXKP/d0WyODufr
         NKEQ4IDvemsHhse43nm2blfRwsmlA0BhLtmZ35A63iDIfnnlMTETvBoFXN6Dtdoz/wqg
         ut170EwANC3ESebWxhfhtn0H73/Xo/GUK5HnUthjZUYekYmuVYd1stlWrAvlonj7Th8O
         f90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEbQ+jBtLxtopyfN7uZpWk6gsndFSvLkXCtItdMk4sk=;
        b=XmBaB2an3fK9ETf6kpr6LQOexUKAw5hR2IzGgMiX1BlceUWYzkCWEc0GJ8x2X+uB7/
         rnGviCaED+twARZgDNyFiX5b2CPKJfAWKoEhOvjAAdnhKISlNto/rlX+Sn0zyfxbH/VV
         qdGAznwpoD8wYIecNeW3xMKqULOq51cc+bcQtfBXe42jV4fxur3l4VXAm4qVNehZ/IgG
         G3pricc9rqP7ZbYmcM1NDSYBKyjoAdtpKeR5WH/gNt13b1QqN9scvKXFpx5rkQsfXZi/
         5c7UrDuoFaHRQvidrifmDT3Rj50dJn5oMLOBs8ndnDENDKYCocgHWc5CJFHC+/lBkp5E
         XWdw==
X-Gm-Message-State: AFqh2kraE2+idAbSqm0GVP0gT/GtK6hxnyfrGBDCm2kdc9UwsKdR2IC9
        CoGGAyTWpuFSaeibgoBfmPLIUWKRzLHNRXK4
X-Google-Smtp-Source: AMrXdXsemwUzDJMwgzQg89O7O9QxdUcYFBlrWYezrLK7LXzb/jgbmzFmnWrbyc26/hsZEaa1LCvqsSIGoI/G4zn2
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:c30e:0:b0:4b2:72:d8ee with SMTP id
 r14-20020a81c30e000000b004b20072d8eemr1083439ywk.272.1672913987306; Thu, 05
 Jan 2023 02:19:47 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:35 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-38-jthoughton@google.com>
Subject: [PATCH 37/46] hugetlb: replace make_huge_pte with make_huge_pte_with_shift
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
---
 mm/hugetlb.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d71adc03138d..10a323e6bd9c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5069,9 +5069,9 @@ const struct vm_operations_struct hugetlb_vm_ops = {
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
 
@@ -5087,14 +5087,6 @@ static pte_t make_huge_pte_with_shift(struct vm_area_struct *vma,
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
@@ -5135,10 +5127,12 @@ static void
 hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
 		     struct page *new_page)
 {
+	struct hstate *h = hstate_vma(vma);
 	__SetPageUptodate(new_page);
 	hugepage_add_new_anon_rmap(new_page, vma, addr);
-	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
-	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
+	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1,
+				huge_page_shift(h)));
+	hugetlb_count_add(pages_per_huge_page(h), vma->vm_mm);
 	SetHPageMigratable(new_page);
 }
 
@@ -5854,7 +5848,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		page_remove_rmap(old_page, vma, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
 		set_huge_pte_at(mm, haddr, ptep,
-				make_huge_pte(vma, new_page, !unshare));
+				make_huge_pte(vma, new_page, !unshare,
+					huge_page_shift(h)));
 		SetHPageMigratable(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
@@ -6163,7 +6158,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		page_dup_file_rmap(page, true);
 
 	subpage = hugetlb_find_subpage(h, page, haddr_hgm);
-	new_pte = make_huge_pte_with_shift(vma, subpage,
+	new_pte = make_huge_pte(vma, subpage,
 			((vma->vm_flags & VM_WRITE)
 			 && (vma->vm_flags & VM_SHARED)),
 			hpte->shift);
@@ -6585,8 +6580,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	subpage = hugetlb_find_subpage(h, page, dst_addr);
 
-	_dst_pte = make_huge_pte_with_shift(dst_vma, subpage, writable,
-			dst_hpte->shift);
+	_dst_pte = make_huge_pte(dst_vma, subpage, writable, dst_hpte->shift);
 	/*
 	 * Always mark UFFDIO_COPY page dirty; note that this may not be
 	 * extremely important for hugetlbfs for now since swapping is not
@@ -7999,8 +7993,7 @@ int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
 		page_dup_file_rmap(hpage, true);
 
 		subpage = hugetlb_find_subpage(h, hpage, curr);
-		entry = make_huge_pte_with_shift(vma, subpage,
-						 writable, hpte.shift);
+		entry = make_huge_pte(vma, subpage, writable, hpte.shift);
 		set_huge_pte_at(mm, curr, hpte.ptep, entry);
 next_hpte:
 		curr += hugetlb_pte_size(&hpte);
-- 
2.39.0.314.g84b9a713c41-goog

