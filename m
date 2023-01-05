Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE9C65E8DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjAEKVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjAEKT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:57 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64687559CD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4b34cf67fb6so64981647b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YiV8/mi4PL7n0t7wUxWEcBb+colJN0WHKmqKjso6aI=;
        b=LLH1FHQmSuPREM9no8Xr1mrJ+WX7c7pQin9EAc1TvbLcGl/RkRXVwm8E1KdBkYBfGV
         YIbOE4N1o74dyaPeOKZcf4lLMNNXkB6ntMAbzLwmbHJOP6v9E5qeX1N0aPIuGJxFBbMc
         DAYDRj/A2/l8+0SDjtsFQpbfETrwBoJUzB2rpy+l5tAr/dFGII17vpR5Red3X2ZytOJ7
         oWSpFA1Ze6s9PZS3/XShmJem6/Ne0GdcNEZibyC+1G61SR9BHwKMzCLxkcexZKOZqBmj
         o+/TsTl7bfdyibV9AZKmqM5CVurcLoGPu4otDexr+01trkvt9Pgocw+EzAHZiG5i0KHf
         sA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YiV8/mi4PL7n0t7wUxWEcBb+colJN0WHKmqKjso6aI=;
        b=Kk8s3VtO8SJCYObezdiIa4NF4+tIosP4TcPNkGR/VguwI/IQt4OzzhOVUvVl93uG8J
         uLwWh9h7vtvXGchXteRiMJZOkcSgGKBEdnQ8pezImzlExYS0M65NJ6I2B/V4Hz8jg+lA
         FQCqEcUpu9RBfgEyRL+AFTJ6wM1EkTnj/w0RXOv0miRz4oFZjkvfBF2VvrGOJ7h9L9z6
         ovNp5qupq38Szq3mkuTwP3nIU9m9LJr89GNPOAkF1ml+tOeFIoeeWhmAH3/sS9ABeWLO
         Y9iE5c7pP7V+HiyGGPFJuTPqJm6FwrHo850ZwNzzjjCttzDSvo58VO9PsOQwVWdzRual
         wi3w==
X-Gm-Message-State: AFqh2kphvfHqGNIDoqyCiSiZxDR+xcM2sjnddGLHv+pPoW2b6kCbob7r
        L9SRAH7TT0Lb7U/uSHznQL5l2BOO/ocNkZ1Y
X-Google-Smtp-Source: AMrXdXsGYdoE5wl2sivs6OdjI5ZSUUexE/Vrq4eXctrFdqUeY9jM31ir5DBKkL0+y1etkakDWP7pB3SgIRai/epT
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:d06:0:b0:731:7af4:cc3e with SMTP id
 6-20020a250d06000000b007317af4cc3emr3400989ybn.368.1672913964504; Thu, 05 Jan
 2023 02:19:24 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:18 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-21-jthoughton@google.com>
Subject: [PATCH 20/46] hugetlb: add HGM support for hugetlb_follow_page_mask
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

The change here is very simple: do a high-granularity walk.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 30fea414d9ee..718572444a73 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6553,11 +6553,10 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 				unsigned long address, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long haddr = address & huge_page_mask(h);
 	struct page *page = NULL;
 	spinlock_t *ptl;
-	pte_t *pte, entry;
+	pte_t entry;
+	struct hugetlb_pte hpte;
 
 	/*
 	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
@@ -6567,13 +6566,24 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		return NULL;
 
 	hugetlb_vma_lock_read(vma);
-	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
-	if (!pte)
+
+	if (hugetlb_full_walk(&hpte, vma, address))
 		goto out_unlock;
 
-	ptl = huge_pte_lock(h, mm, pte);
-	entry = huge_ptep_get(pte);
+retry:
+	ptl = hugetlb_pte_lock(&hpte);
+	entry = huge_ptep_get(hpte.ptep);
 	if (pte_present(entry)) {
+		if (unlikely(!hugetlb_pte_present_leaf(&hpte, entry))) {
+			/*
+			 * We raced with someone splitting from under us.
+			 * Keep walking to get to the real leaf.
+			 */
+			spin_unlock(ptl);
+			hugetlb_full_walk_continue(&hpte, vma, address);
+			goto retry;
+		}
+
 		page = pte_page(entry) +
 				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
 		/*
-- 
2.39.0.314.g84b9a713c41-goog

