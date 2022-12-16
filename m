Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB3C64EE44
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiLPPyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiLPPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:53:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC936A742
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671205952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUHaufgIZGXg7uWbITubevKDDOKyb4JchyF1bpwW4KQ=;
        b=F6ZrN9Ea59ydeOaDqamuI0mZto7frQNq7V3oMvINPhSNOcn4THcOzjpuQpCXtl8o1uUXvt
        fhLbDinsBToFxyQo6exq1pA81e2nZwS6bR5FPHmEhknHzvYR+Ab2B0CyHxgV4VNfc84V+d
        XMQEue8xmU23pPQdUTQRmgBtzA6Qj9w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-29-bAInidp2OnWKmmLUcle8DA-1; Fri, 16 Dec 2022 10:52:31 -0500
X-MC-Unique: bAInidp2OnWKmmLUcle8DA-1
Received: by mail-qv1-f71.google.com with SMTP id c10-20020a05621401ea00b004c72d0e92bcso1661841qvu.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUHaufgIZGXg7uWbITubevKDDOKyb4JchyF1bpwW4KQ=;
        b=VJ+1b90fqMNFI7JZpMIAfKaAix/mMNw+ScYuk6vtFMVdmrVE9mVujmpoOTSn9wXcPZ
         DFZ6Swgan/ubN5sdzad3+K4IC0oHJLb+3j8TZhNylRNrDs+UsvDTUcQCAlDuFj+rDQdO
         bC4PzHpT7i4BWpwazSI+pRgDp8dqrPZDzRRlRfjrPyioenOIR/iJM7MO80S7zpGnJe9m
         /4s6zCTleQbBzfRz7/rcwRhSkj0/nOMcWwBkSyAXmyR93uJRhm7Nim+7Ho/jap1DuhFO
         PLRlxf5dJg8gsG4P+GTgKr4EDRiAPv8+3bks81FSGav3LeflmsM6FSpdILR3uMd7xxYe
         /+1A==
X-Gm-Message-State: ANoB5pm4BcLohGW8IVNuT+UeTImFAvIvcMXQPTPDtEoFWv5haYiXcJPt
        3vJkAONnVqJ1PmjIoQqJIVYpMcniYk6E6PQw6auUpgya8s1vQB6S5/j9GF18l9KCiOzTwKV3YC7
        /l0O3SJ89+yfUnzWkmFKTM4ksdUQgzCs/kKX1PrjxzYxPIpgveg5b9J+SJga6EoD6E93gaGFOHA
        ==
X-Received: by 2002:a05:622a:1652:b0:3a8:1600:e60f with SMTP id y18-20020a05622a165200b003a81600e60fmr42089086qtj.14.1671205949581;
        Fri, 16 Dec 2022 07:52:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6EvF97ux4AdUPswvdTGfH5GWS4ADEWRFVyxzLx9ScIIRjScwUEcGsBcdGYmcjjmGBVg0epbg==
X-Received: by 2002:a05:622a:1652:b0:3a8:1600:e60f with SMTP id y18-20020a05622a165200b003a81600e60fmr42089044qtj.14.1671205949310;
        Fri, 16 Dec 2022 07:52:29 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id h9-20020ac81389000000b003a530a32f67sm1472717qtj.65.2022.12.16.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:52:28 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>, peterx@redhat.com,
        Miaohe Lin <linmiaohe@huawei.com>,
        Jann Horn <jannh@google.com>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 8/9] mm/hugetlb: Make walk_hugetlb_range() safe to pmd unshare
Date:   Fri, 16 Dec 2022 10:52:26 -0500
Message-Id: <20221216155226.2043738-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221216155100.2043537-1-peterx@redhat.com>
References: <20221216155100.2043537-1-peterx@redhat.com>
MIME-Version: 1.0
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

Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
to make sure the pgtable page will not be freed concurrently.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/pagewalk.h | 11 ++++++++++-
 mm/hmm.c                 | 15 ++++++++++++++-
 mm/pagewalk.c            |  2 ++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 959f52e5867d..27a6df448ee5 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -21,7 +21,16 @@ struct mm_walk;
  *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
  *			Any folded depths (where PTRS_PER_P?D is equal to 1)
  *			are skipped.
- * @hugetlb_entry:	if set, called for each hugetlb entry
+ * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
+ *			function is called with the vma lock held, in order to
+ *			protect against a concurrent freeing of the pte_t* or
+ *			the ptl. In some cases, the hook function needs to drop
+ *			and retake the vma lock in order to avoid deadlocks
+ *			while calling other functions. In such cases the hook
+ *			function must either refrain from accessing the pte or
+ *			ptl after dropping the vma lock, or else revalidate
+ *			those items after re-acquiring the vma lock and before
+ *			accessing them.
  * @test_walk:		caller specific callback function to determine whether
  *			we walk over the current vma or not. Returning 0 means
  *			"do page table walk over the current vma", returning
diff --git a/mm/hmm.c b/mm/hmm.c
index 3850fb625dda..796de6866089 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -493,8 +493,21 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	required_fault =
 		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
 	if (required_fault) {
+		int ret;
+
 		spin_unlock(ptl);
-		return hmm_vma_fault(addr, end, required_fault, walk);
+		hugetlb_vma_unlock_read(vma);
+		/*
+		 * Avoid deadlock: drop the vma lock before calling
+		 * hmm_vma_fault(), which will itself potentially take and
+		 * drop the vma lock. This is also correct from a
+		 * protection point of view, because there is no further
+		 * use here of either pte or ptl after dropping the vma
+		 * lock.
+		 */
+		ret = hmm_vma_fault(addr, end, required_fault, walk);
+		hugetlb_vma_lock_read(vma);
+		return ret;
 	}
 
 	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 7f1c9b274906..d98564a7be57 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -302,6 +302,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
 
+	hugetlb_vma_lock_read(vma);
 	do {
 		next = hugetlb_entry_end(h, addr, end);
 		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
@@ -314,6 +315,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 		if (err)
 			break;
 	} while (addr = next, addr != end);
+	hugetlb_vma_unlock_read(vma);
 
 	return err;
 }
-- 
2.37.3

