Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA572EE53
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbjFMVym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFMVyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6631BCD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686693238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMeXibFgr6WGH9TADmv6GKzvddxtLLfsVSaxyvBxKHs=;
        b=PARZNzKLdWiCszzTYXIw3Ca3t1mpR+kTz9+VafnEKoYOjj8VHujKQgkLkguCayCeo/XmIq
        cUW1giZO106cu4CU5OUBXZmwPOCAnKVGrcpn6NGDFsYyEIYMdgliE2wTMJO41Hw5Ui4Nq5
        NQX5WpUp4kV69dmmhceRA1PI78RnDTM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-R6PFmtyvP62yj4Agsx3PVw-1; Tue, 13 Jun 2023 17:53:57 -0400
X-MC-Unique: R6PFmtyvP62yj4Agsx3PVw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f871a1e3f9so8070031cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686693232; x=1689285232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMeXibFgr6WGH9TADmv6GKzvddxtLLfsVSaxyvBxKHs=;
        b=kfUo6tZ0VEfUFxaMyYXyqlWtTI0LPup5j6JAtCqN3kwHoDXl77JLxD1K7V3Ae6fNOT
         KIOaYJNiq5eK1DujZ6A7Kzyykma8rH2GorHIiFEBDVnLX3PvATJ9wB0VC4rIT0Y7SHCH
         wJ205OvH8k2GuzhLppnczhUdSsFr0RBiKXsmQ+jn70Hh8GwvYJJgDOrlWI0RO3l8tCiU
         peh2pKuCLZumNARaZVDlC4ARyBdZCeyUWAYiQXQyd5cuhM/x9kfgXnf4R08L+SbuDfvQ
         4U4c0sm9X1+A7T6RRJmtSrI5TiHo31EuONJHCIeslFhQ2yLsMAcG2aPBgh/cXmS8BYhh
         pAcQ==
X-Gm-Message-State: AC+VfDxyK7cfLU3+5j4b7UMAK8FGouZryLwR16z6+W8W1UpfNHwK/08T
        pzhulGNiN5d96GP0QAHWbE8j/nTUfXvcX+dqszq0n4jQoYGotrbFTivNTJL2YUP0htriCo86bin
        fzJmfACxlbUx7d2e1Y8jftAnHTF3Sc0BAR4YtJ78SKCzWOTXH+oUhvoEC3xHoQ7aR8nRoV4CwY2
        1xkUbYmA==
X-Received: by 2002:a05:622a:1887:b0:3f9:ab2c:8895 with SMTP id v7-20020a05622a188700b003f9ab2c8895mr18016485qtc.3.1686693232286;
        Tue, 13 Jun 2023 14:53:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72MmVJ/KYdtXeaLxllJ/hfKOlDEtGiOvMuFZzCmuKll0yFpjBUzckwXKh9hVVGptkRtecEgQ==
X-Received: by 2002:a05:622a:1887:b0:3f9:ab2c:8895 with SMTP id v7-20020a05622a188700b003f9ab2c8895mr18016457qtc.3.1686693231907;
        Tue, 13 Jun 2023 14:53:51 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id fz24-20020a05622a5a9800b003f9bccc3182sm4522330qtb.32.2023.06.13.14.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:53:50 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 1/7] mm/hugetlb: Handle FOLL_DUMP well in follow_page_mask()
Date:   Tue, 13 Jun 2023 17:53:40 -0400
Message-Id: <20230613215346.1022773-2-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613215346.1022773-1-peterx@redhat.com>
References: <20230613215346.1022773-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c     | 9 ++-------
 mm/hugetlb.c | 9 +++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index dbe96d266670..aa0668505d61 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -781,7 +781,6 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 			      struct follow_page_context *ctx)
 {
 	pgd_t *pgd;
-	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
 	ctx->page_mask = 0;
@@ -794,12 +793,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
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
index 270ec0ecd5a1..82dfdd96db4c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6501,6 +6501,15 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
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

