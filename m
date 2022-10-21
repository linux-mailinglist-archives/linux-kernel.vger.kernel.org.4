Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA691607C63
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiJUQho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiJUQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:27 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3541327B54B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:22 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id p184-20020a6742c1000000b003a9dc8a5ec2so1052458vsa.22
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=34cx5eEOWWMEza3+3K1vLVCCrFvx1bz9vEUMrzq2ytU=;
        b=Sp9ejFIjwkTD2k7b5O35d/eTr3qFaL4Cu0+Y3Jqen1+jW42rNvItxKaNURZz5TSKk7
         x35Bvv5PH68z6pCQYFbhWyoyGgG4rzUpeOPbjmYrzgvXuzuUNcyvX4/Otvfkuiq5+cZv
         HHQynZVto3uDixtcVQsCf3qWQvklcY23DsStSgC2qGnXAGQ/l0stiqvSXSvt9oZVTDkE
         Caber1o4FewbpJvcwU1yEnRVdmKdy2XZSnVqN1DFbOLIkZI+hKbcR55fyjn4Og0CJ7M/
         x13b8bjYpqhnO2fokhLpSAWC6h6Udyc8I00LhZRGAFNopGb6wpiImE12TuoAvXq6t9Ke
         1k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34cx5eEOWWMEza3+3K1vLVCCrFvx1bz9vEUMrzq2ytU=;
        b=FruMi4n4XpGw2FLrALD6TCR0HJQg8ncpUUEszG9NgMVXpXIJeFBc/s/BeH0GaLQf7f
         YYNWRqTxfO3HItPVw2JzMCGT+OLD7xxzwqwIxZNsVeCabjF1st0w2/Euk6x44B1+7mAF
         go9VPj1d84krzrP0uKOZQAwFSV7gvKmz59JN/GyUwgflUWPXSdLBICX7rA3aUEPE1d+G
         eqejsUlkBbtsLN/yhGKTh6DQ9IUZv6qDSqp+vef+Q6okCQEuBCmldqBZQ5+lZsjz7YCn
         Gvsw+/XzIQlkgH19QVzU8BPQiUefBNEpzVaRj4KaD7OHQ1suDldTdOd3Dj98bTiVPwiD
         8oJw==
X-Gm-Message-State: ACrzQf30tQQflkDYlIJUKgjW880j3HTx+Nbscp8s1W6OSsJ5TcvhTntu
        GjxG3Z03DjZ7FvmuHBe7eRrV/zbncmGXjNva
X-Google-Smtp-Source: AMsMyM6Mvo2qQVK8sdSIbcMVnfOhwFg4FhU4eWPB/UUGtomewuseawpOfNBtO35uLxun2jYxXKf3dRRjIA99NUXN
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a67:fa59:0:b0:3a7:7516:b43b with SMTP
 id j25-20020a67fa59000000b003a77516b43bmr14278433vsq.83.1666370241512; Fri,
 21 Oct 2022 09:37:21 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:21 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-6-jthoughton@google.com>
Subject: [RFC PATCH v2 05/47] hugetlb: make hugetlb_vma_lock_alloc return its
 failure reason
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

Currently hugetlb_vma_lock_alloc doesn't return anything, as there is no
need: if it fails, PMD sharing won't be enabled. However, HGM requires
that the VMA lock exists, so we need to verify that
hugetlb_vma_lock_alloc actually succeeded. If hugetlb_vma_lock_alloc
fails, then we can pass that up to the caller that is attempting to
enable HGM.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 52cec5b0789e..dc82256b89dd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -92,7 +92,7 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
+static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
@@ -7001,17 +7001,17 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 	}
 }
 
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 {
 	struct hugetlb_vma_lock *vma_lock;
 
 	/* Only establish in (flags) sharable vmas */
 	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
-		return;
+		return -EINVAL;
 
-	/* Should never get here with non-NULL vm_private_data */
+	/* We've already allocated the lock. */
 	if (vma->vm_private_data)
-		return;
+		return 0;
 
 	vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
 	if (!vma_lock) {
@@ -7026,13 +7026,14 @@ static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 		 * allocation failure.
 		 */
 		pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
-		return;
+		return -ENOMEM;
 	}
 
 	kref_init(&vma_lock->refs);
 	init_rwsem(&vma_lock->rw_sema);
 	vma_lock->vma = vma;
 	vma->vm_private_data = vma_lock;
+	return 0;
 }
 
 /*
@@ -7160,8 +7161,9 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 {
 }
 
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 {
+	return 0;
 }
 
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
-- 
2.38.0.135.g90850a2211-goog

