Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB0736000
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFSXLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjFSXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A35E65
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687216253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6bDfMbeRbNTGIwHWXqT4W/WFCKBAZr5szTZ9WWVoPyY=;
        b=VBTHFw9rqImxlVYOTjywvRhb+WR+8TuAosfwmepDv5/KoUh5wgUK5Kw4aEeL84kRWJh+4B
        2qnWAhCZPmq3MPB8hFCzUuihZTsvovTM5pHhkevUl4v44h5azSE5aYLniAz7BHe06c1gV1
        tCu8HPj0nosq9mpru/9YMqxaeAIpOqE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-8LLJQvs8PQ2IOvpAGgBglQ-1; Mon, 19 Jun 2023 19:10:51 -0400
X-MC-Unique: 8LLJQvs8PQ2IOvpAGgBglQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7623c0f2856so48475885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216251; x=1689808251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bDfMbeRbNTGIwHWXqT4W/WFCKBAZr5szTZ9WWVoPyY=;
        b=MrqYRMpoJK/zqUu1ub1WPbrKsoc9D2cwRgIxBHUuJ5ErbclU+5DwrfvrzcVS1Cjtrf
         1n8KCaKh0fUXh3+1AZVrj3/GZ0Ov1J/G5mAsQ9wkPfggTAlFjPVkZ6H9JAUmL87HVxAt
         SLKAQeOK/NTY6d6COU+c4y2xfZHi2TflXAKeW4/2d5ldmKEr06B7Vbo8ea8ziZHG3R9D
         h2zni0178QxMHlMMDBhjDNO823x4schvnYAqWRx55gY2aFuqlvll9yiCtEe3Vuqo1B7V
         cZP4n6KSZ2di2tzd71CulfYUiAlVmoDJ/BAb5Xk4yG/H59YevKvO1xdkEO6dP4bwI+TV
         drlQ==
X-Gm-Message-State: AC+VfDxBweceyxHxpnJksCIxaGwmoXrVs/YTxnGWk4KTM0D9Cvr72x0l
        Li5VZRj5SRhVFPqIZ+JRFUrVlH/6MHJ3LR7PBof3GjPokjR/l7DI/GDFOfV8+t7SWveioyldq1+
        AgIs/wLKpOsFRdEqK+n7GW4IV
X-Received: by 2002:a05:620a:171f:b0:75d:e31a:a015 with SMTP id az31-20020a05620a171f00b0075de31aa015mr12743197qkb.2.1687216251119;
        Mon, 19 Jun 2023 16:10:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6l3RVvQSr/D1LXHPe5NTuMnLt2zR7kaZEIqF+D9ThQr41twmjAeA1Pct5PrS5DNmUPlNg8Gg==
X-Received: by 2002:a05:620a:171f:b0:75d:e31a:a015 with SMTP id az31-20020a05620a171f00b0075de31aa015mr12743182qkb.2.1687216250831;
        Mon, 19 Jun 2023 16:10:50 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a034f00b007592f2016f4sm405864qkm.110.2023.06.19.16.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:10:50 -0700 (PDT)
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
Subject: [PATCH v2 3/8] mm/hugetlb: Add page_mask for hugetlb_follow_page_mask()
Date:   Mon, 19 Jun 2023 19:10:39 -0400
Message-Id: <20230619231044.112894-4-peterx@redhat.com>
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

follow_page() doesn't need it, but we'll start to need it when unifying gup
for hugetlb.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 8 +++++---
 mm/gup.c                | 3 ++-
 mm/hugetlb.c            | 5 ++++-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index beb7c63d2871..2e2d89e79d6c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -131,7 +131,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
 			    struct vm_area_struct *, struct vm_area_struct *);
 struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
-				unsigned long address, unsigned int flags);
+				      unsigned long address, unsigned int flags,
+				      unsigned int *page_mask);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 struct page **, unsigned long *, unsigned long *,
 			 long, unsigned int, int *);
@@ -297,8 +298,9 @@ static inline void adjust_range_if_pmd_sharing_possible(
 {
 }
 
-static inline struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
-				unsigned long address, unsigned int flags)
+static inline struct page *hugetlb_follow_page_mask(
+    struct vm_area_struct *vma, unsigned long address, unsigned int flags,
+    unsigned int *page_mask)
 {
 	BUILD_BUG(); /* should never be compiled in if !CONFIG_HUGETLB_PAGE*/
 }
diff --git a/mm/gup.c b/mm/gup.c
index abcd841d94b7..9fc9271cba8d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -780,7 +780,8 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	 * Ordinary GUP uses follow_hugetlb_page for hugetlb processing.
 	 */
 	if (is_vm_hugetlb_page(vma))
-		return hugetlb_follow_page_mask(vma, address, flags);
+		return hugetlb_follow_page_mask(vma, address, flags,
+						&ctx->page_mask);
 
 	pgd = pgd_offset(mm, address);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9a6918c4250a..fbf6a09c0ec4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6454,7 +6454,8 @@ static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
 }
 
 struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
-				unsigned long address, unsigned int flags)
+				      unsigned long address, unsigned int flags,
+				      unsigned int *page_mask)
 {
 	struct hstate *h = hstate_vma(vma);
 	struct mm_struct *mm = vma->vm_mm;
@@ -6499,6 +6500,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 			page = NULL;
 			goto out;
 		}
+
+		*page_mask = ~huge_page_mask(h) >> PAGE_SHIFT;
 	}
 out:
 	spin_unlock(ptl);
-- 
2.40.1

