Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4B8648730
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLIRDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLIRC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0DD7DA55
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670605289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BJ1c+DnQwwOjSKsDq4iN/7ttySyX/vWFxv5LWeLTqBE=;
        b=SJrjuxu3NMB3kEkq8Qw3lRHS2W5ZxqyMZaaTxZ/nNmF4dXHjD8l5PEskCALrr3oNaMfmqR
        hqUfiH7/KYwnRlX3/zjjSDUdR9DaUIbPw4lYYM7D7V/2iPSiwkeRhPtEf43cuBicYV9tcl
        0REDPNoemPNiL1aK5UqL8apMhQL8CB4=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-335-66wvnKmrNUyjYvEJ3uhGTA-1; Fri, 09 Dec 2022 12:01:26 -0500
X-MC-Unique: 66wvnKmrNUyjYvEJ3uhGTA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1441866fa6cso117101fac.22
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ1c+DnQwwOjSKsDq4iN/7ttySyX/vWFxv5LWeLTqBE=;
        b=QL2wApHU6vwvO6lRJuJxFlOOfOAYP6yaSGV7ywQ7rnT8gAUhOc1iJs0+PDYzT5wBgv
         SXFlTPqTtqVKe6KWZGOEdF1LbPb7pdgkbMAoYZ2MR+Kuh/1q+UdbN+JymqdvZVsvn0BY
         raU7yscUfY7hBRL1YOVmkipx9xM3nEYtOHxjrTGShgNXHmVO7X7NkPOCrAbY/ceVyKWl
         6td/E/6OrgXcPcTf3XY765lU/21ubrQsD/ZOGyzfAKHaioZfps2nSXLsxDb5gXGLm55m
         YMrnqJdGwIk7ggl7i02n+V49MWG7F3LYbnnLXIyUfrM9Km/xrFgehkQx+Pkf4FevkeJ1
         rpIg==
X-Gm-Message-State: ANoB5pkljGASLu669wKNCML9a6vatzxSS+mUlx7E+yyR3aYsUvSadGNq
        bS9KEOcKL2ChBI9CUDJbabgDBkOtiDdwZ9daCphk0BHXRi2jqNEqUyOX6u0jqGSBIajSCzdl+dz
        LcTea5ngOVZ23y7T6+o/ydyep
X-Received: by 2002:a05:6870:2f0a:b0:141:fe19:d4d0 with SMTP id qj10-20020a0568702f0a00b00141fe19d4d0mr2655998oab.50.1670605285751;
        Fri, 09 Dec 2022 09:01:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf67Y/YxUkSaXiObMUPvZ9/FDlwGcy+0g+8APbf7404nsBoydGf3R0e/VdazPQe3Ssti4e+l/Q==
X-Received: by 2002:a05:6870:2f0a:b0:141:fe19:d4d0 with SMTP id qj10-20020a0568702f0a00b00141fe19d4d0mr2655965oab.50.1670605285082;
        Fri, 09 Dec 2022 09:01:25 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006cf38fd659asm178907qkl.103.2022.12.09.09.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:01:24 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 7/9] mm/hugetlb: Make follow_hugetlb_page() safe to pmd unshare
Date:   Fri,  9 Dec 2022 12:00:58 -0500
Message-Id: <20221209170100.973970-8-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221209170100.973970-1-peterx@redhat.com>
References: <20221209170100.973970-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since follow_hugetlb_page() walks the pgtable, it needs the vma lock
to make sure the pgtable page will not be freed concurrently.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e3af347470ac..9d8bb6508288 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6285,6 +6285,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			break;
 		}
 
+		hugetlb_vma_lock_read(vma);
 		/*
 		 * Some archs (sparc64, sh*) have multiple pte_ts to
 		 * each hugepage.  We have to make sure we get the
@@ -6309,6 +6310,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
 			if (pte)
 				spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
 			remainder = 0;
 			break;
 		}
@@ -6330,6 +6332,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 			if (pte)
 				spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
+
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
 			else if (unshare)
@@ -6389,6 +6393,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			remainder -= pages_per_huge_page(h);
 			i += pages_per_huge_page(h);
 			spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
 			continue;
 		}
 
@@ -6416,6 +6421,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
 							 flags))) {
 				spin_unlock(ptl);
+				hugetlb_vma_unlock_read(vma);
 				remainder = 0;
 				err = -ENOMEM;
 				break;
@@ -6427,6 +6433,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		i += refs;
 
 		spin_unlock(ptl);
+		hugetlb_vma_unlock_read(vma);
 	}
 	*nr_pages = remainder;
 	/*
-- 
2.37.3

