Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A181B607C85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiJUQkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiJUQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3538428B1A2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36ab1ae386bso3393707b3.16
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8LccpPhXfmW4rVnqf/7+o+Hx7HGdpTBJy+WhJxfYYjY=;
        b=VtedBtwvWHz/xR7mbbUZi/QoevZsZHK58lrDg/Og1dHq+4sTO0SzuJwbDL01OD4aRO
         ZrzqzImsUW7zaLsPz9uDyqGaQmYDBP/ewXtMT4FyGfv8JkL2w+joXY1RfIXLgBKES2Sj
         vqywDuAhyTmd/LLF7nkcY7zjNmxvC9i895d0uGYTI/cSG6WlZY+43S6OfJD/E2SXCvXm
         X2hL0i7SeDE8rCss/xStUkiKMm2focDWaDnd8WQz9Joh9DY2g8UAYbi2pu7QynxsVTmQ
         UZERGl+LChK8MQdnam9/1x/By+2QIZQaEESDONOlLX/D7ClwvnQ3+jVU/EIpCh5KiFQc
         fYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LccpPhXfmW4rVnqf/7+o+Hx7HGdpTBJy+WhJxfYYjY=;
        b=cviTifGuCilDRJ/dBDjemKOOEqnhM7FoMTpn/P0Zm5xp7GdDpYo+GXspcG2/qmH1lY
         woERaH7cn/FYNh73aTtf20CjfFGKH7Mzlaf53NRBvXLjpQOLcneF4FhesMRDaIV7VCbc
         qHCYWg0ej1cHINxbLsQOUcvrDsZQ2oCBURdoqQ8ZT733S2vE5bHvxifwEhivjjplArNR
         5v9tJrSy5MK5TGSCF/RsCKlurzx/QA+PLc400+9dgZtXWPiPoLlehcEmBoUj0Voyxx9+
         rAUzU7Briw8V5hnQprXntsjuOTYkBMkOlAyQAlqwKEG73mbDCKrPLH8oIxhy0n+Jclbs
         GXOA==
X-Gm-Message-State: ACrzQf2etIi8YFfd5YgXUhNSZB1pkZMR8+6Mq8QFeCsacNPdUcKTuaKZ
        tB9kkfRUkCxt3xaLUuv/nSReNRhFIF21uXAl
X-Google-Smtp-Source: AMsMyM7sugWuEQwWleh1RgVujXbvv8FwsEzDuh6usgcO4hdZ4bZxviKYervWwAHcVUH8gDgLsBvkym1lZSOGRGOT
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:2d63:0:b0:6ca:3fe:3f2d with SMTP id
 s35-20020a252d63000000b006ca03fe3f2dmr12173515ybe.90.1666370271836; Fri, 21
 Oct 2022 09:37:51 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:54 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-39-jthoughton@google.com>
Subject: [RFC PATCH v2 38/47] hugetlb: replace make_huge_pte with make_huge_pte_with_shift
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
index 9d4e41c41f78..b26142bec4fe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4908,9 +4908,9 @@ const struct vm_operations_struct hugetlb_vm_ops = {
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
 
@@ -4926,14 +4926,6 @@ static pte_t make_huge_pte_with_shift(struct vm_area_struct *vma,
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
@@ -4974,10 +4966,12 @@ static void
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
 	ClearHPageRestoreReserve(new_page);
 	SetHPageMigratable(new_page);
 }
@@ -5737,7 +5731,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		page_remove_rmap(old_page, vma, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
 		set_huge_pte_at(mm, haddr, ptep,
-				make_huge_pte(vma, new_page, !unshare));
+				make_huge_pte(vma, new_page, !unshare,
+					huge_page_shift(h)));
 		SetHPageMigratable(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
@@ -6033,7 +6028,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		page_dup_file_rmap(page, true);
 
 	subpage = hugetlb_find_subpage(h, page, haddr_hgm);
-	new_pte = make_huge_pte_with_shift(vma, subpage,
+	new_pte = make_huge_pte(vma, subpage,
 			((vma->vm_flags & VM_WRITE)
 			 && (vma->vm_flags & VM_SHARED)),
 			hpte->shift);
@@ -6481,8 +6476,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	subpage = hugetlb_find_subpage(h, page, dst_addr);
 	WARN_ON_ONCE(subpage != page && !hugetlb_hgm_enabled(dst_vma));
 
-	_dst_pte = make_huge_pte_with_shift(dst_vma, subpage, writable,
-			dst_hpte->shift);
+	_dst_pte = make_huge_pte(dst_vma, subpage, writable, dst_hpte->shift);
 	/*
 	 * Always mark UFFDIO_COPY page dirty; note that this may not be
 	 * extremely important for hugetlbfs for now since swapping is not
@@ -8044,8 +8038,7 @@ int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
 		page_dup_file_rmap(hpage, true);
 
 		subpage = hugetlb_find_subpage(h, hpage, curr);
-		entry = make_huge_pte_with_shift(vma, subpage,
-						 writable, hpte.shift);
+		entry = make_huge_pte(vma, subpage, writable, hpte.shift);
 		set_huge_pte_at(mm, curr, hpte.ptep, entry);
 next_hpte:
 		curr += hugetlb_pte_size(&hpte);
-- 
2.38.0.135.g90850a2211-goog

