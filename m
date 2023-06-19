Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45955735FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFSXLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFSXLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F5E61
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687216249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBG5VmVtD6hD7uqVIm/KwEJm6kTIhRuBKiuOHix9n+4=;
        b=IdfLtYzJg5nfM1cC0zhMd+QEAcvwSsbOq9GVW32hRyKNHyRVWWeXo7gTeMmL0yYzyDAmIx
        zpoOpGWcn78s4jZ089kOJ2xH2Y81zwUa6IK3IruiFQBVM7/H3kt60H01mZ0eS1mHHbJySM
        9FTEJSSH8jg6ELOxAVviLYUMdc6Gl5c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-RyIDWfBNOV6-QYY3OBaziA-1; Mon, 19 Jun 2023 19:10:48 -0400
X-MC-Unique: RyIDWfBNOV6-QYY3OBaziA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76248f3057bso37225485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216248; x=1689808248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBG5VmVtD6hD7uqVIm/KwEJm6kTIhRuBKiuOHix9n+4=;
        b=CMSkPpjOr49VE3Nj7tp+pAfkCr2BZ39XrkDAfVChKeKnhHgdX+LsOVNnZPwGV//Apr
         ZRJF6zQ7LlVyAXnCoUy5v2XYYvuNWINemKkyuUe2hBNLFyaXhju/Qsjmug6EI744i3RD
         O26phSRSWHWL3yWJh3dV/29uQi+g9UJbTEj86PbIhDAAcQ4Wb4EyO1KCKyoJyABY5k8x
         q0f92eqR7iKptpGH0kSBuLm4rVUFNHc45cuC9x0W944u63U5AdDnyDUgunE1T0E7yRKn
         Y8grQTUw9tDDG4nD9sZ8Uj7O4SG0bypbP2lAGD0b0yKoWRXS7kUyrClnJq4pFTczjy+/
         wcdQ==
X-Gm-Message-State: AC+VfDwinMi6jPy5eak3IncX8NDgw6tufW95S9OKngpNy74hGMw9EbOw
        BYZypXVsZYnHGlxB/k0mpfglrF/sahimvxpTZJW8ku9lAdl2JyQdAHMeKcu+2TmdJIv/EeLYysJ
        cVxHugbXIOdHfalwi/IF4JTTe
X-Received: by 2002:a05:620a:2889:b0:75b:23a1:82a4 with SMTP id j9-20020a05620a288900b0075b23a182a4mr13246170qkp.5.1687216248029;
        Mon, 19 Jun 2023 16:10:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uYNYA6ud1mXk5kCO8SQ709g56KLRkH0S51iN3gvNVcm96teEhHrAWMqahC/SXJPrCrLeZqA==
X-Received: by 2002:a05:620a:2889:b0:75b:23a1:82a4 with SMTP id j9-20020a05620a288900b0075b23a182a4mr13246155qkp.5.1687216247779;
        Mon, 19 Jun 2023 16:10:47 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a034f00b007592f2016f4sm405864qkm.110.2023.06.19.16.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:10:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 1/8] mm/hugetlb: Handle FOLL_DUMP well in follow_page_mask()
Date:   Mon, 19 Jun 2023 19:10:37 -0400
Message-Id: <20230619231044.112894-2-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619231044.112894-1-peterx@redhat.com>
References: <20230619231044.112894-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, the no_page_table() is meaningless for hugetlb which is a no-op
there, because a hugetlb page always satisfies:

  - vma_is_anonymous() == false
  - vma->vm_ops->fault != NULL

So we can already safely remove it in hugetlb_follow_page_mask(), alongside
with the page* variable.

Meanwhile, what we do in follow_hugetlb_page() actually makes sense for a
dump: we try to fault in the page only if the page cache is already
allocated.  Let's do the same here for follow_page_mask() on hugetlb.

It should so far has zero effect on real dumps, because that still goes
into follow_hugetlb_page().  But this may start to influence a bit on
follow_page() users who mimics a "dump page" scenario, but hopefully in a
good way.  This also paves way for unifying the hugetlb gup-slow.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c     | 9 ++-------
 mm/hugetlb.c | 9 +++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ce14d4d28503..abcd841d94b7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -767,7 +767,6 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 			      struct follow_page_context *ctx)
 {
 	pgd_t *pgd;
-	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
 	ctx->page_mask = 0;
@@ -780,12 +779,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	 * hugetlb_follow_page_mask is only for follow_page() handling here.
 	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
 	 */
-	if (is_vm_hugetlb_page(vma)) {
-		page = hugetlb_follow_page_mask(vma, address, flags);
-		if (!page)
-			page = no_page_table(vma, flags);
-		return page;
-	}
+	if (is_vm_hugetlb_page(vma))
+		return hugetlb_follow_page_mask(vma, address, flags);
 
 	pgd = pgd_offset(mm, address);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d76574425da3..f75f5e78ff0b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6498,6 +6498,15 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	spin_unlock(ptl);
 out_unlock:
 	hugetlb_vma_unlock_read(vma);
+
+	/*
+	 * Fixup retval for dump requests: if pagecache doesn't exist,
+	 * don't try to allocate a new page but just skip it.
+	 */
+	if (!page && (flags & FOLL_DUMP) &&
+	    !hugetlbfs_pagecache_present(h, vma, address))
+		page = ERR_PTR(-EFAULT);
+
 	return page;
 }
 
-- 
2.40.1

