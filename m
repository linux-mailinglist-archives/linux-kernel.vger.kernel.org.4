Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDBE62EAC4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiKRBND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbiKRBM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:12:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF81E85ECA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qjnChz0h9yEvsDVybPnS+PQNkUKEm7fVo3IYCZg/FQ4=;
        b=VFyFjM6EHd2xKLU9lmz2ByKQaOtuSn2lBHb1duwg5cUOPCmln4kQKYPwtb+D1/FzIM7kV1
        eYbcN6XsITdSM9bGcWPRkE7IIV/TVoDY8Ia4sNJTtzdthcSlqsxDVsg1bzDJZ8Bv3pUnm5
        RD7QSKoe2/8/S9Pzq+r0tiwq2b3BCJY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-568-zb1gKab9OGG7Thy-wCDWxg-1; Thu, 17 Nov 2022 20:10:41 -0500
X-MC-Unique: zb1gKab9OGG7Thy-wCDWxg-1
Received: by mail-qt1-f200.google.com with SMTP id y8-20020ac87088000000b003a528a5b844so3398423qto.18
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjnChz0h9yEvsDVybPnS+PQNkUKEm7fVo3IYCZg/FQ4=;
        b=F6zmZ93uVUfdjGH3o4/CjvxZuFsJAvJvBuxkUk1WDkj9Oj99P8aWeSZeZOkRYTP54/
         98dz/l4Z69mQLuqENOuwCpsoQ+ewb0kppvYm+7ZCvq5O+Q6Hf20DpsqoMmOl54UDuNgs
         UiVQMlOqi8HgLrjksmPEXJJKpgHadt9GAVBx4b/eo2SYJatjD7UMsvAzMmoPdq2PWWIC
         hK48mxSGl1wbliL3oaQbGrmQWJHZ3Z5IfOQ56MSYTHTSt1jSi8nlI0S8U9Rij1i0S6vX
         z7cveexwjpjio6PkOa+ZVSjPlhcZ6v4P5psGioBfZu40vJuRAvuRryXUSCDDu4Yk7hvg
         7+kA==
X-Gm-Message-State: ANoB5pmhh2UYW/1SSgCcetq+2MLGNnYirPtJNgvmF8rKnnlun6rL0NyC
        RU1dVCjiGIkqOJ5iPoOlBnAn++uQx0Z92SQ6oH4aFgIn+4QWYnJ2M3xtLwStnnX0WlmkWNR7sI+
        pUOScxyKVE9zCDIurAfZNvea6
X-Received: by 2002:a05:620a:c04:b0:6cf:7988:75a9 with SMTP id l4-20020a05620a0c0400b006cf798875a9mr4033253qki.613.1668733841014;
        Thu, 17 Nov 2022 17:10:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf54cqseGLR98vZZaTQtgNM/mQInkImtMr4ZFy3PyyVl91SKAmCECTcH2P+eiXPqv9u2h3rDQw==
X-Received: by 2002:a05:620a:c04:b0:6cf:7988:75a9 with SMTP id l4-20020a05620a0c0400b006cf798875a9mr4033233qki.613.1668733840789;
        Thu, 17 Nov 2022 17:10:40 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm1491342qko.126.2022.11.17.17.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:10:40 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC v2 08/12] mm/hugetlb: Use hugetlb walker lock in follow_hugetlb_page()
Date:   Thu, 17 Nov 2022 20:10:21 -0500
Message-Id: <20221118011025.2178986-9-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221118011025.2178986-1-peterx@redhat.com>
References: <20221118011025.2178986-1-peterx@redhat.com>
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

Hugetlb walker lock makes sure the pte_t* won't go away from under us.
Some trick is used to release the walker lock slightly earlier when we
found present pte.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fc49e3ca8acd..e81af6a46c59 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6280,6 +6280,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			break;
 		}
 
+		hugetlb_walker_lock();
 		/*
 		 * Some archs (sparc64, sh*) have multiple pte_ts to
 		 * each hugepage.  We have to make sure we get the
@@ -6304,6 +6305,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
 			if (pte)
 				spin_unlock(ptl);
+			hugetlb_walker_unlock();
 			remainder = 0;
 			break;
 		}
@@ -6325,6 +6327,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 			if (pte)
 				spin_unlock(ptl);
+			hugetlb_walker_unlock();
+
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
 			else if (unshare)
@@ -6367,6 +6371,15 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			continue;
 		}
 
+		/*
+		 * When reach here, it means the pteval is not absent, so
+		 * anyone who wants to free and invalidate the pgtable page
+		 * (aka, pte*) should need to first unmap the entries which
+		 * relies on the pgtable lock.  Since we're holding it,
+		 * we're safe even without the walker lock anymore.
+		 */
+		hugetlb_walker_unlock();
+
 		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
 		page = pte_page(huge_ptep_get(pte));
 
-- 
2.37.3

