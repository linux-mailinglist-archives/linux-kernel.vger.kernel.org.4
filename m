Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A1C741B36
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjF1Vy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjF1VyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2022111
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687989199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IlLdQZDWL4abQusa0fWM05NgtC5yViIwxz1MKIy8bPA=;
        b=ZgkP7MNeWTBFLqPLJ1hIGcTOfs+K3Ubo7sNdgL/x80kV3dU1HNoTsPwBEq4a96EaqY8tCR
        dSH0Q+PDkk7ZC2VgZCPR26esbSbwrjRjegUEEBPSXKLuuO2j86/RRZmYT9ZzclvGpFd5oj
        GD+DnvXwRDWbSVbiwt6+SsnzjIEsrzk=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-lg8yFQ42PUCqedzxscCwcA-1; Wed, 28 Jun 2023 17:53:17 -0400
X-MC-Unique: lg8yFQ42PUCqedzxscCwcA-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4716b1f55b9so2889e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989197; x=1690581197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlLdQZDWL4abQusa0fWM05NgtC5yViIwxz1MKIy8bPA=;
        b=d078f08flziWSVLAsr/H1JDvkV+WYJ46hM6vzWIwJloj+G7lSGzKI1J2HTSZK4fHia
         V/M8ZAP6b+682BLj/C1lRA1qeEWIpfvPGqLm0NVIgRfXBrv+LXjb4QLkNY4Nh0q/Ao2L
         a5ulKt0adNY5f/oiXNOPGPFaNpue8HhmxjTNoCAqPdBV9dBRLcB69jDT/A/CR4GOOjxk
         RP9aTSGqHA9wOBp/kUd4iNVPrAis3jzo8B84UTdJcLf0EUDwFy+K1qDm8UaXquqQmmXo
         zohUF01NgX/Wl4i5jQOYWLrPN9e5jcl/oqcoommB6KXn0VgvSZA3vyuWo7QcAmr1oM7H
         5fkg==
X-Gm-Message-State: AC+VfDwb/zm9HJ5L/ZQRPccNPt9ezGEQv3PVXGdswDbL8qQ2b5pNgXbn
        Hfsb6+/zvwQV1vH7RY7jCzM4UYbQw6DTSZSFQ/28u5NgyQzKKh//b3VdcTPv61/iZh4VsAq58SB
        GgZeBsGHx/1+H3umIHSZeLM51
X-Received: by 2002:a05:6102:358d:b0:440:b763:a69d with SMTP id h13-20020a056102358d00b00440b763a69dmr12045541vsu.2.1687989196707;
        Wed, 28 Jun 2023 14:53:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xAhw0w/TD6i35B4jAPAsfvCfbDcR0SS33V5o7YLBIW4QDiUOfL0qQyToMemXcWuE4mGgWTQ==
X-Received: by 2002:a05:6102:358d:b0:440:b763:a69d with SMTP id h13-20020a056102358d00b00440b763a69dmr12045528vsu.2.1687989196447;
        Wed, 28 Jun 2023 14:53:16 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p3-20020a0cfac3000000b00631fea4d5bcsm6277797qvo.95.2023.06.28.14.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:53:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        James Houghton <jthoughton@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com
Subject: [PATCH v4 3/8] mm/hugetlb: Add page_mask for hugetlb_follow_page_mask()
Date:   Wed, 28 Jun 2023 17:53:05 -0400
Message-ID: <20230628215310.73782-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215310.73782-1-peterx@redhat.com>
References: <20230628215310.73782-1-peterx@redhat.com>
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

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 8 +++++---
 mm/gup.c                | 3 ++-
 mm/hugetlb.c            | 5 ++++-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ca3c8e10f24a..9f282f370d96 100644
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
index 06bc2e31f209..1e2e23084f3c 100644
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
index 4410139cf890..15e82a8a2b76 100644
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
@@ -6504,6 +6505,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 			page = ERR_PTR(ret);
 			goto out;
 		}
+
+		*page_mask = (1U << huge_page_order(h)) - 1;
 	}
 out:
 	spin_unlock(ptl);
-- 
2.41.0

