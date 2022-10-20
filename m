Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A642606905
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJTTiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTTit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32821CCCD0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666294727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=85S5u2Kj0kLXjbV1eC6tH45ETLd1PtrOIvBagjXXKHg=;
        b=S5HLCpSBNiaaaxrQJTygDSkRq86ZdlTGSULHsqZJOzHhwWlwyJBxTcGbT8PrSJlFlY6C+M
        dsA+RCXHSmthCTCIG4CfyJ4tNsYtDJsgDiS3iHq7ljutUBSBO5CBJ0eBzHRBeSxPCtihbU
        Zd4yvoxnKmCVHFivQSNkTbjGOnuyjeI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-81-gtH7siwZOdqJrykh_T2NGw-1; Thu, 20 Oct 2022 15:38:46 -0400
X-MC-Unique: gtH7siwZOdqJrykh_T2NGw-1
Received: by mail-qt1-f198.google.com with SMTP id u11-20020a05622a198b00b0039cca1826c8so354020qtc.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 12:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85S5u2Kj0kLXjbV1eC6tH45ETLd1PtrOIvBagjXXKHg=;
        b=itYGGt1sbLsGGDQb7pPfBLtDC7YyYbGkOmZJkGC5KfdAX0JIYDDw9nntWOHsQgs2Eq
         4WfQWFaMjN1dHzGizsNqthlhASi8J9US+eQUTHcZYUrPpv2WEJ8t5oAst5FP7cVwcMBW
         F1H4A3KL5ITz4g5uEgaC0Qsq5zKyZ0eFHaulIQNhE+GwjkZNuqbWNV7Xf2FIx6ajDP+y
         Vl9igrdbgcNRPK62q4ZJnk8DZ+E+pUWD5tQrxoBr88/UzJXCoKyszr451Zjs0G8/BMF0
         Zi8adYF/4bNrggwZYsOjsxlCV3V0Op7o5r6vNo/AbMANqsv4MdRyTW+eaeso2X5mLnMi
         AEyQ==
X-Gm-Message-State: ACrzQf09XPbwcBN4plVQNb2NqZiVaeGm/6aO7d5qj2y5DNCOcWtTLoFI
        Bd1nvYP2Bhh9goAAmzuoB6WQj4XQ++ywgRC6N1c+yK8elTdJg8ScolEfPmmNeSroKD0nzHyOnqO
        9Hr6QFyOwhy+RZk6AzjAnPEnW6NoxDynFVg6Xc9rmr/9ZYBftZPsws3ri6YGl2rmZOYTNPL1jbQ
        ==
X-Received: by 2002:ac8:5b15:0:b0:39c:d63a:d82 with SMTP id m21-20020ac85b15000000b0039cd63a0d82mr12737545qtw.8.1666294725627;
        Thu, 20 Oct 2022 12:38:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5+lZIN+opAk1J1sWYCJQufRZwqLE9h0Kf49Du8fY7l1ltie0di6XohikrUIV3lzIMrn1ey0A==
X-Received: by 2002:a05:622a:1312:b0:39c:fbd3:6dbf with SMTP id v18-20020a05622a131200b0039cfbd36dbfmr9453063qtk.335.1666294714733;
        Thu, 20 Oct 2022 12:38:34 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a25cd00b006bbf85cad0fsm8074982qko.20.2022.10.20.12.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 12:38:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] mm/hugetlb: Unify clearing of RestoreReserve for private pages
Date:   Thu, 20 Oct 2022 15:38:32 -0400
Message-Id: <20221020193832.776173-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial cleanup to move clearing of RestoreReserve into adding anon rmap
of private hugetlb mappings.  It matches with the shared mappings where we
only clear the bit when adding into page cache, rather than spreading it
around the code paths.

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 14 ++++----------
 mm/rmap.c    |  2 +-
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1a7dc7b2e16c..931789a8f734 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4784,7 +4784,6 @@ hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr
 	hugepage_add_new_anon_rmap(new_page, vma, addr);
 	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
-	ClearHPageRestoreReserve(new_page);
 	SetHPageMigratable(new_page);
 }
 
@@ -5447,8 +5446,6 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_lock(ptl);
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
-		ClearHPageRestoreReserve(new_page);
-
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
@@ -5743,10 +5740,9 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	if (!pte_same(huge_ptep_get(ptep), old_pte))
 		goto backout;
 
-	if (anon_rmap) {
-		ClearHPageRestoreReserve(page);
+	if (anon_rmap)
 		hugepage_add_new_anon_rmap(page, vma, haddr);
-	} else
+	else
 		page_dup_file_rmap(page, true);
 	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
@@ -6133,12 +6129,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
 		goto out_release_unlock;
 
-	if (page_in_pagecache) {
+	if (page_in_pagecache)
 		page_dup_file_rmap(page, true);
-	} else {
-		ClearHPageRestoreReserve(page);
+	else
 		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
-	}
 
 	/*
 	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
diff --git a/mm/rmap.c b/mm/rmap.c
index 9bba65b30e4d..3b2d18bbdc44 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2571,7 +2571,7 @@ void hugepage_add_new_anon_rmap(struct page *page,
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	atomic_set(compound_mapcount_ptr(page), 0);
 	atomic_set(compound_pincount_ptr(page), 0);
-
+	ClearHPageRestoreReserve(page);
 	__page_set_anon_rmap(page, vma, address, 1);
 }
 #endif /* CONFIG_HUGETLB_PAGE */
-- 
2.37.3

