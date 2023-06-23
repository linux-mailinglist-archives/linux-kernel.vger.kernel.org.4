Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778F373BA2D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjFWOaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjFWOaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617D2136
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687530583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBG5VmVtD6hD7uqVIm/KwEJm6kTIhRuBKiuOHix9n+4=;
        b=fygFZNrililEdWBDJA6sF2jN8hxy06g13wVD3fzPu5mvqZZYGRBteo87dLSKOyKiBLwZOa
        9EvUAcsGErERplrpqQRwwEO2G+N0MvF2s8FxWan4AEGdR+U/kHFosmJ5qpJ1EzPc2JxeMi
        56BMkQAdJpfT28JJVwZCurp2EEKkILo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-MM_UJJgaNiqU1U509BK5PA-1; Fri, 23 Jun 2023 10:29:42 -0400
X-MC-Unique: MM_UJJgaNiqU1U509BK5PA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f8283a3a7aso1821981cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530581; x=1690122581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBG5VmVtD6hD7uqVIm/KwEJm6kTIhRuBKiuOHix9n+4=;
        b=YD/LtA+luB60LcgwXUAvFTbjZywJqyxipKPxvVda7r8zp7DWJZm2K328t413Wr76Na
         Uksg3N6RrJRwsH6azIcXDXKRX9MhHjVz8Q0BwQYLKHCgFwQOTyCtLMOhLdM49c+EDq9Z
         37MHVK0sTwrCPE8viPBTxKXDPYMmcR4KX8O+syxirXR16vGxVwuaSlr0EgNMf3CnrCLj
         N2N7unKK7nDwcsBGC1E1VlS8h6mwrScnkOCHDmVp+uPk6OupT4i+CmhPgMrMeTApsgsB
         zEGaGaQCYa9uD8kCjDfE7Mlh6Uhzwr5OYsPNj68D5dQbV/jhTpo53J3zCkIBpjvyYuC0
         rxWw==
X-Gm-Message-State: AC+VfDyym+xTSvBCdirU3UY4sh8/MlzbdzyKDA1b1BodEBQnzB1RujGF
        tuint276deTt6+jn3a+3heo+GNp7qTLeUo6Tnartwqt65W7BccWDhJtOdcQAqQHs+ibsYqgM/ve
        OhO4D6uNfSdJErf788igNKySppOVvC2Cz
X-Received: by 2002:ad4:5b8a:0:b0:62f:e4de:5bed with SMTP id 10-20020ad45b8a000000b0062fe4de5bedmr25208868qvp.5.1687530581206;
        Fri, 23 Jun 2023 07:29:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ77EhCcf/GM+yw2Xot5giAOKEx2zhLBubqKJqeheIkq+W5o91Ui2eWJpfYc4H7mEvuNOB2yeQ==
X-Received: by 2002:ad4:5b8a:0:b0:62f:e4de:5bed with SMTP id 10-20020ad45b8a000000b0062fe4de5bedmr25208839qvp.5.1687530580951;
        Fri, 23 Jun 2023 07:29:40 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b0062821057ac7sm5104827qvk.39.2023.06.23.07.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:29:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 1/8] mm/hugetlb: Handle FOLL_DUMP well in follow_page_mask()
Date:   Fri, 23 Jun 2023 10:29:29 -0400
Message-Id: <20230623142936.268456-2-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623142936.268456-1-peterx@redhat.com>
References: <20230623142936.268456-1-peterx@redhat.com>
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

