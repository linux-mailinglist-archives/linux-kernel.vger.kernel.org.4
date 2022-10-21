Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23C2607C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiJUQid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiJUQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE37527B560
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a2510d5000000b006be7970889cso3745369ybq.21
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fsyIlVnnMiNXvkl1HsXqgX1TLgLGQ8zT/P/5weg/1gI=;
        b=XqorezT/2FphyiQnAX1Bd8wgsl7lfI/pP/ncB+cOJZKqD23STzv16ftCYUCPWHqtg5
         bpBlu8K4trcZPPP7ksTIPwi+OmxSmuA+bx2JDQ4xMN1Sza2xhzZIri2t3uZC3siOgf1N
         6PkInLp3do3ZY7Mr0m9JvaUW9Fio86INZMzBpW/c8ze+LCXgeqrdcTQFLLGy0UJLJ7rx
         r5nPuIKCiA9//Lvg3JPH/D3IUupmV0+whrn4/c2BWlYGrhrlNQ3nh+aOXJrWK/llyVpr
         73/3Br83UOiGnA3b2tybFdHzcf9rRgS7SFsJnN0uyja6ZNBNeDdPNMYCpV/KSWK8w9CV
         O7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsyIlVnnMiNXvkl1HsXqgX1TLgLGQ8zT/P/5weg/1gI=;
        b=K+e3UX+pTvf9ANRUGoMl/psOaT/Bqsp+sLggtvK2mS6JGtzj9zzAUhl1nHKQd5c7Hy
         HYwe7HM2mbfZxzx2XRMEHwXxjYXaaVgPR+F7vRdqnFu2X1hv+FHJonXzbiKox1rG/yYr
         yy3F+0QeYIKEvBlGtnsBvnQi/kHiXgFq1EApsbYxN0ecP50b2O9nJdMxYcGhfOsFeTXZ
         RflacmL1dd+ttzcFYhXfWRKkkdR9ORsxAykHAzJqx4iG6zCS6akLBF3aP/Q6F3ItDpCz
         fi9o0uRy+iIOnYlhKvJks12s/WR3ftWfzetx9yTvUo6xW0FfE9D6g+HsECuNukIyofWT
         eHiw==
X-Gm-Message-State: ACrzQf1vHAckTIBW/n6KvpKivc6gjn9/ugp/4r1WJ8nzaLw0+m8BLJhN
        rV7pRb84V9MraDRTI+ogSH+/zhgUHc5IEHqi
X-Google-Smtp-Source: AMsMyM4BD94+VbGPR4g7N7cSR0mTVCvwlFZLyZIhchhPIXP/hu+fs3VOPw61nlbFmAsQysXWmSvESfUZFYZzAMKD
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:70f:b0:6ca:7254:c2ea with SMTP
 id k15-20020a056902070f00b006ca7254c2eamr3096670ybt.476.1666370250766; Fri,
 21 Oct 2022 09:37:30 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:31 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-16-jthoughton@google.com>
Subject: [RFC PATCH v2 15/47] hugetlbfs: for unmapping, treat HGM-mapped pages
 as potentially mapped
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb_vma_maps_page was mostly used as an optimization: if the VMA
isn't mapping a page, then we don't have to attempt to unmap it again.
We are still able to call the unmap routine if we need to.

For high-granularity mapped pages, we can't easily do a full walk to see
if the page is actually mapped or not, so simply return that it might
be.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/hugetlbfs/inode.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7f836f8f9db1..a7ab62e39b8c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -383,21 +383,34 @@ static void hugetlb_delete_from_page_cache(struct folio *folio)
  * mutex for the page in the mapping.  So, we can not race with page being
  * faulted into the vma.
  */
-static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
-				unsigned long addr, struct page *page)
+static bool hugetlb_vma_maybe_maps_page(struct vm_area_struct *vma,
+					unsigned long addr, struct page *page)
 {
 	pte_t *ptep, pte;
+	struct hugetlb_pte hpte;
+	struct hstate *h = hstate_vma(vma);
 
-	ptep = huge_pte_offset(vma->vm_mm, addr,
-			huge_page_size(hstate_vma(vma)));
+	ptep = huge_pte_offset(vma->vm_mm, addr, huge_page_size(h));
 
 	if (!ptep)
 		return false;
 
+	hugetlb_pte_populate(&hpte, ptep, huge_page_shift(h),
+			hpage_size_to_level(huge_page_size(h)));
+
 	pte = huge_ptep_get(ptep);
 	if (huge_pte_none(pte) || !pte_present(pte))
 		return false;
 
+	if (!hugetlb_pte_present_leaf(&hpte, pte))
+		/*
+		 * The top-level PTE is not a leaf, so it's possible that a PTE
+		 * under us is mapping the page. We aren't holding the VMA
+		 * lock, so it is unsafe to continue the walk further. Instead,
+		 * return true to indicate that we might be mapping the page.
+		 */
+		return true;
+
 	if (pte_page(pte) == page)
 		return true;
 
@@ -457,7 +470,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
-		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
+		if (!hugetlb_vma_maybe_maps_page(vma, vma->vm_start + v_start,
+					page))
 			continue;
 
 		if (!hugetlb_vma_trylock_write(vma)) {
@@ -507,7 +521,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		 */
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
-		if (hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
+		if (hugetlb_vma_maybe_maps_page(vma, vma->vm_start + v_start,
+					page))
 			unmap_hugepage_range(vma, vma->vm_start + v_start,
 						v_end, NULL,
 						ZAP_FLAG_DROP_MARKER);
-- 
2.38.0.135.g90850a2211-goog

