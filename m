Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86ED62EAC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbiKRBMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbiKRBMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:12:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCC685ECF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ek0v3IZFacfv4QAamvdXXDg+rLS9iFnyxQu22HNSG2w=;
        b=fgjR/stalitptovrG99D84ElHAy6hQfpsJUM92o55SLDlojEdLCwWIy201XuV8b+VeKxRV
        hmYGtsSRD0FItkIveVSJYWGqU4xbvnkXIuqIfSZm++jWR1hIp38/vKixHO6llQ92kQgdZv
        i9KvBPnhqIrDacoA0UVXLHsj3M2LCwg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-176-M4M5NPWaMZGKeo0uuL6bYQ-1; Thu, 17 Nov 2022 20:10:38 -0500
X-MC-Unique: M4M5NPWaMZGKeo0uuL6bYQ-1
Received: by mail-qk1-f199.google.com with SMTP id bp10-20020a05620a458a00b006fa29f253dcso4429550qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ek0v3IZFacfv4QAamvdXXDg+rLS9iFnyxQu22HNSG2w=;
        b=XEFfGYzEZiRTRjve+K8+E4Udt/ebC2HwkTp1fDiue7GO2D6GXuDS+hRNMrDrbWPsMP
         40ueJkoZmEzF0PTiJbpS+lSZCb1ghyZg87nDotpa7N0k+z7S7UMCn6UJl1Y0djbDV1bU
         0JkVLucrA8I1HWkA2DBCkCAeZ7KVDa8rYSCjmgr+P8qqTdYVZ0Jzk0p6BFkp3hWklA79
         zeU/p5saU9nCLGiFju/QI1FfMxRvMPGt70mC3Z0mlAQpwi62XIFqn4xpLfnlUcgmRRPx
         RVxT7ZD0a7H2nHH2430SvzGxlVsFfobCGeXgNpNt2cITgXr/2cuk1+izd0iDmvNqkmVP
         /McQ==
X-Gm-Message-State: ANoB5plwqQaIC2rlEnLeQP2W9+hdqyMFHkA8s7yGscrwSjPBvBi+TdEE
        O6N4nLl7/TqUcSKVKNuCQ37neWRSSjP40LYxJFCrzArNDpSrgqv52VF87zZ2OJ3WKERzFm+8qwL
        kOGbDqcktALv/vMCVmLX4rjIj
X-Received: by 2002:ac8:7608:0:b0:3a5:6797:c57a with SMTP id t8-20020ac87608000000b003a56797c57amr4788566qtq.34.1668733837959;
        Thu, 17 Nov 2022 17:10:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4YUHL//KLcKTO3eXesn/AhPVyYy7y3vCnFwX7NxkFnL7BxzMVqhjH97L9Gr/XOknNuKwkO9w==
X-Received: by 2002:ac8:7608:0:b0:3a5:6797:c57a with SMTP id t8-20020ac87608000000b003a56797c57amr4788551qtq.34.1668733837733;
        Thu, 17 Nov 2022 17:10:37 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm1491342qko.126.2022.11.17.17.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:10:37 -0800 (PST)
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
Subject: [PATCH RFC v2 06/12] mm/hugetlb: Protect huge_pmd_share() with walker lock
Date:   Thu, 17 Nov 2022 20:10:19 -0500
Message-Id: <20221118011025.2178986-7-peterx@redhat.com>
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

huge_pmd_share() is normally called with vma lock held already, it lets us
feel like we don't really need the walker lock.  But that's not true,
because we only took the vma lock for "current" vma, but not all the vma
pgtables we're going to walk upon.

Taking each vma lock may lead to deadlock and hard to order.  The safe
approach is just to use the walker lock which guarantees the pgtable page
being alive, then we should use get_page_unless_zero() rather than
get_page() only, to make sure the pgtable page is not being freed at the
meantime.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 61a1fa678172..5ef883184885 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7008,6 +7008,13 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	spinlock_t *ptl;
 
 	i_mmap_lock_read(mapping);
+
+	/*
+	 * NOTE: even if we've got the vma read lock, here we still need to
+	 * take the walker lock, because we're not walking the current vma,
+	 * but some other mm's!
+	 */
+	hugetlb_walker_lock();
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
@@ -7016,12 +7023,15 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		if (saddr) {
 			spte = huge_pte_offset(svma->vm_mm, saddr,
 					       vma_mmu_pagesize(svma));
-			if (spte) {
-				get_page(virt_to_page(spte));
+			/*
+			 * When page ref==0, it means it's probably being
+			 * freed; continue with the next one.
+			 */
+			if (spte && get_page_unless_zero(virt_to_page(spte)))
 				break;
-			}
 		}
 	}
+	hugetlb_walker_unlock();
 
 	if (!spte)
 		goto out;
-- 
2.37.3

