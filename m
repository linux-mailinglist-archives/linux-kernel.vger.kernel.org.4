Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269F663C892
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiK2Tiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbiK2Th1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:37:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54F84B999
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669750543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wQQtMmya3oIPlns9VTTG82x3u2HOgOUNM9IGJVSq3FI=;
        b=BobxrCsnxiTXACK5mU7SM9z9bp+hW+KdF+RtjvhQu6v5oKLys1Bo3QfI5cAgHI+VQwDS6P
        qGDDYEr9fnxNod8GXbDd1EL4V2U6jDatGfMNXStrdI905QFo1fU+ZhZVCk2J1Q/YBOei0G
        mD5cvCqgiXqGjOfB0trffnCzbI3fgjo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-217-6HTHZ3SjP92ta5qqvLe3cw-1; Tue, 29 Nov 2022 14:35:41 -0500
X-MC-Unique: 6HTHZ3SjP92ta5qqvLe3cw-1
Received: by mail-qv1-f72.google.com with SMTP id ng1-20020a0562143bc100b004bb706b3a27so21657804qvb.20
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQQtMmya3oIPlns9VTTG82x3u2HOgOUNM9IGJVSq3FI=;
        b=0YeHLzClE0i0oo2WjGYyRr0gPapLOb91nob9GZ1L6Xk+ommYDuDWOaWCmjNAMZG0tP
         RhGlSTvELgKfYn7TxgBaDX6ZMw0Be0z2MBGcs77NZdMpYxITiPN4UryS6S2Q+J+N/vDi
         Q8GJGoALb+PrPmnzpjQJAg7ns28ZSShQNpst8RE3qXLRicOvRcmRtOR1gZDjUtCH1dYk
         lLS+AgVzq68CLCfH8cIDRH+nBf0m+l8ioqOVT8T8X6+hnijQL2rxwG1CI6OB8ORnTqNA
         n9ZxQlxouYuQZw+z4UouDpvF/MJkltRALNAcD6gQ7Tu12GIcca9LUm6DX9iJP0d+rrNy
         yn3g==
X-Gm-Message-State: ANoB5pk3oGtAaHV1DBpYXPfdZITRIeB9p/zV8t2xye9XwqnY4Kndnqq5
        pCLKZ/cuPZCqavkWrDYyH3VmHfSKAQOIX/XV3XTf7NIeHGjP6nZs86snnLk7aDNH2C7nwNOdP1b
        dB0vLt9gzkDEkeE5SwoLKCDfL
X-Received: by 2002:a05:622a:4891:b0:3a5:280a:3c9c with SMTP id fc17-20020a05622a489100b003a5280a3c9cmr37951512qtb.282.1669750540822;
        Tue, 29 Nov 2022 11:35:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7D66AT3COOJUVWGxZ68VmKCBmOjMI4vwPiGugqyqG7QsmIEqLv5iYXBuBUQGMJ4PIx2eAMkQ==
X-Received: by 2002:a05:622a:4891:b0:3a5:280a:3c9c with SMTP id fc17-20020a05622a489100b003a5280a3c9cmr37951490qtb.282.1669750540508;
        Tue, 29 Nov 2022 11:35:40 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa16fe93bbsm11313013qkp.15.2022.11.29.11.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:35:40 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 07/10] mm/hugetlb: Make follow_hugetlb_page() safe to pmd unshare
Date:   Tue, 29 Nov 2022 14:35:23 -0500
Message-Id: <20221129193526.3588187-8-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d6bb1d22f1c4..df645a5824e3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6290,6 +6290,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			break;
 		}
 
+		hugetlb_vma_lock_read(vma);
 		/*
 		 * Some archs (sparc64, sh*) have multiple pte_ts to
 		 * each hugepage.  We have to make sure we get the
@@ -6314,6 +6315,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
 			if (pte)
 				spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
 			remainder = 0;
 			break;
 		}
@@ -6335,6 +6337,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 			if (pte)
 				spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
+
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
 			else if (unshare)
@@ -6394,6 +6398,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			remainder -= pages_per_huge_page(h);
 			i += pages_per_huge_page(h);
 			spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
 			continue;
 		}
 
@@ -6421,6 +6426,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
 							 flags))) {
 				spin_unlock(ptl);
+				hugetlb_vma_unlock_read(vma);
 				remainder = 0;
 				err = -ENOMEM;
 				break;
@@ -6432,6 +6438,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		i += refs;
 
 		spin_unlock(ptl);
+		hugetlb_vma_unlock_read(vma);
 	}
 	*nr_pages = remainder;
 	/*
-- 
2.37.3

