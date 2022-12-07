Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAEC64626A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLGUcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLGUbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:31:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B39C7BC15
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670445054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwIY6qGYW16H7RKgjgoL5wZJoRvSXS6wmhu5l+J439g=;
        b=AhUEBWL+EhRw8UGgRw0Uh18wEacaCdSRFVWCsNpFHpE4QZMya95MYJMK9SsyelwzI8Xkru
        JV6OIk3gYL+vo/6Uja8RQdq/jPDX5N1zguYK+Js/TD5tZ1jba6KBmBl5yMYAb1Hz9RVb0N
        4gNcww6OpH7nH0IXcSqZNjUbyeScSqs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-100-nOivNHiJMc6c9UA2_eiIXg-1; Wed, 07 Dec 2022 15:30:49 -0500
X-MC-Unique: nOivNHiJMc6c9UA2_eiIXg-1
Received: by mail-qv1-f70.google.com with SMTP id a15-20020ad441cf000000b004c79ef7689aso104539qvq.14
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwIY6qGYW16H7RKgjgoL5wZJoRvSXS6wmhu5l+J439g=;
        b=xBIZIel23oq8vB6znEB6cr7UeKiFCnPMtrkFhJJqFo7tFErI2ukc3WDs2OanpRIEtS
         GGnc7nl8GolhQs5D0rrwQQWHuk+Ob0WVbQ3L6R1ndTzTsCDTI4ppYYQ6LtIj9Bum3xwL
         EhRNsv+eap5GaWpS0Tay/lZz0xc4fgPvcGs9o9VEQBcLYF+DjmI0eVnOvx/jeRuz5CqO
         owuQ7cs6/zH5WvK7aiLLEpvnpWuZqoVjL1Qvb90J88R59L7RYeUfq/pnIVG05fVSJzId
         EoQ4yQDzusoa+aPjMArwt68Tcn9RcX9c5FROW5j5zrv7SkNeFRP39fxa41ngbWNvaS49
         gbDw==
X-Gm-Message-State: ANoB5pmBTzMTYE/qxk8endFwvmdi4CTs1AnFp1YHTv1bWJ1SRvkd0xtP
        sfGUbho1Oxkiz1NLPKPJDZ69KxVFk5ipt83hMTMtrGcOZI4AaP4HAP22lxqvyAX/q+205Z7bKki
        2U9o9pN5i15G8/7jRPkCBDRBu
X-Received: by 2002:a05:6214:284:b0:4c7:4f6d:d9bd with SMTP id l4-20020a056214028400b004c74f6dd9bdmr1355994qvv.38.1670445049159;
        Wed, 07 Dec 2022 12:30:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6gwEUm1ExsgjT3GOzwaF3cPo9sE8A57vdvavUjxQytQjXm37D0mKl9btfYXk/zG1ZmitVzEg==
X-Received: by 2002:a05:6214:284:b0:4c7:4f6d:d9bd with SMTP id l4-20020a056214028400b004c74f6dd9bdmr1355984qvv.38.1670445048921;
        Wed, 07 Dec 2022 12:30:48 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id dc53-20020a05620a523500b006fefa5f7fcesm855594qkb.10.2022.12.07.12.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:30:48 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2 07/10] mm/hugetlb: Make follow_hugetlb_page() safe to pmd unshare
Date:   Wed,  7 Dec 2022 15:30:31 -0500
Message-Id: <20221207203034.650899-8-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221207203034.650899-1-peterx@redhat.com>
References: <20221207203034.650899-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3fbbd599d015..f42399522805 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6284,6 +6284,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			break;
 		}
 
+		hugetlb_vma_lock_read(vma);
 		/*
 		 * Some archs (sparc64, sh*) have multiple pte_ts to
 		 * each hugepage.  We have to make sure we get the
@@ -6308,6 +6309,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
 			if (pte)
 				spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
 			remainder = 0;
 			break;
 		}
@@ -6329,6 +6331,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 			if (pte)
 				spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
+
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
 			else if (unshare)
@@ -6388,6 +6392,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			remainder -= pages_per_huge_page(h);
 			i += pages_per_huge_page(h);
 			spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
 			continue;
 		}
 
@@ -6415,6 +6420,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
 							 flags))) {
 				spin_unlock(ptl);
+				hugetlb_vma_unlock_read(vma);
 				remainder = 0;
 				err = -ENOMEM;
 				break;
@@ -6426,6 +6432,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		i += refs;
 
 		spin_unlock(ptl);
+		hugetlb_vma_unlock_read(vma);
 	}
 	*nr_pages = remainder;
 	/*
-- 
2.37.3

