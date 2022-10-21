Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE3607C64
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiJUQht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiJUQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:28 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD627B54F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:23 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id d184-20020a671dc1000000b0039b46979cb9so1036700vsd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EmV7/WIsSX/8L/pw2a2OJCYUYMgWWbmlq26RmUc7uno=;
        b=EjsRjGW9BIOWJ38zTf5oxqMXDmlQSTQ3fYn3u9zu3boTToWZbcGqMU9ujmx640GFRE
         9DUkw2yIPQ77Nn5MUKOb5kXytgsWQCvBSzYZM5ncj6hObT+maHj7QLFp+FH44fcEAm6s
         E54uAsE9CsLgxWffXC8Kk3/4Jzx+VZfruoAAQwnnwD+/xbUG4mg5X6y9LbZPB2Zen+1y
         1D72cLftsFvHU+NJIIKl4sRZGZcynq0InczbAJ1ff1mayWhCSq0HjcxZ85zVQqshHO7I
         JBMe4cxSTiZbZ0HfhHlpTs6kGaZKFF03HNKa1/XrU2XZyxzQiAxSFXRPbPzeToVyxPWz
         xW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmV7/WIsSX/8L/pw2a2OJCYUYMgWWbmlq26RmUc7uno=;
        b=Ps4S1IbRgaTaBKbNotwgCPAEgHK4pf4typ2uqztXI+3bBjAypR+lhwpS86PMWxxMkX
         0UviNV+qlnozfwJsOdgvW2ycI6lAdZzVUnk9pxs4jpnhwPw9GPoFGqUoOOysbn75FsLF
         9un5mKqDx+N4xeceS3qE/V/TGuBj2F/uEXq0agkjeeUEHAtQ3CHGEBfzTFCvNgfOiMby
         ZQTFmjkrCxaWx22Do64I1QH7kZACvti5i8t0m9UfNaekCOxIh7OOjJRqKark4LYxhkPd
         wYu98/zqsvOjo1pRBvLXZmgqofFudsAvztu83KdVAdXsIItj4fia7VkyixTqOGDIeF+p
         83PA==
X-Gm-Message-State: ACrzQf1N6VD/0cWjlwkzMV0F4lDamXLmhN/85514T7mYdxAYPy8e/xzI
        Y0m4Wy1ebt2q6tje21MFUErpu4BbS07SJ8JN
X-Google-Smtp-Source: AMsMyM78OfFVLJ/HGE0WMCwWX8vn7VKvg/OslMBhw8pk/6tm+bsmEHDM6BDnshVWSAveaCuilj26QFmSeysallRX
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:ab0:3742:0:b0:403:e8e2:865a with SMTP
 id i2-20020ab03742000000b00403e8e2865amr1305908uat.37.1666370242435; Fri, 21
 Oct 2022 09:37:22 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:22 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-7-jthoughton@google.com>
Subject: [RFC PATCH v2 06/47] hugetlb: extend vma lock for shared vmas
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

This allows us to add more data into the shared structure, which we will
use to store whether or not HGM is enabled for this VMA or not, as HGM
is only available for shared mappings.

It may be better to include HGM as a VMA flag instead of extending the
VMA lock structure.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h |  4 +++
 mm/hugetlb.c            | 65 +++++++++++++++++++++--------------------
 2 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a899bc76d677..534958499ac4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -121,6 +121,10 @@ struct hugetlb_vma_lock {
 	struct vm_area_struct *vma;
 };
 
+struct hugetlb_shared_vma_data {
+	struct hugetlb_vma_lock vma_lock;
+};
+
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dc82256b89dd..5ae8bc8c928e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -91,8 +91,8 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
-static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
-static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
+static void hugetlb_vma_data_free(struct vm_area_struct *vma);
+static int hugetlb_vma_data_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
@@ -4643,11 +4643,11 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 		if (vma_lock) {
 			if (vma_lock->vma != vma) {
 				vma->vm_private_data = NULL;
-				hugetlb_vma_lock_alloc(vma);
+				hugetlb_vma_data_alloc(vma);
 			} else
 				pr_warn("HugeTLB: vma_lock already exists in %s.\n", __func__);
 		} else
-			hugetlb_vma_lock_alloc(vma);
+			hugetlb_vma_data_alloc(vma);
 	}
 }
 
@@ -4659,7 +4659,7 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 	unsigned long reserve, start, end;
 	long gbl_reserve;
 
-	hugetlb_vma_lock_free(vma);
+	hugetlb_vma_data_free(vma);
 
 	resv = vma_resv_map(vma);
 	if (!resv || !is_vma_resv_set(vma, HPAGE_RESV_OWNER))
@@ -6629,7 +6629,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	/*
 	 * vma specific semaphore used for pmd sharing synchronization
 	 */
-	hugetlb_vma_lock_alloc(vma);
+	hugetlb_vma_data_alloc(vma);
 
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
@@ -6753,7 +6753,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
-	hugetlb_vma_lock_free(vma);
+	hugetlb_vma_data_free(vma);
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
@@ -6901,55 +6901,55 @@ static bool __vma_shareable_flags_pmd(struct vm_area_struct *vma)
 void hugetlb_vma_lock_read(struct vm_area_struct *vma)
 {
 	if (__vma_shareable_flags_pmd(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+		struct hugetlb_shared_vma_data *data = vma->vm_private_data;
 
-		down_read(&vma_lock->rw_sema);
+		down_read(&data->vma_lock.rw_sema);
 	}
 }
 
 void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
 {
 	if (__vma_shareable_flags_pmd(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+		struct hugetlb_shared_vma_data *data = vma->vm_private_data;
 
-		up_read(&vma_lock->rw_sema);
+		up_read(&data->vma_lock.rw_sema);
 	}
 }
 
 void hugetlb_vma_lock_write(struct vm_area_struct *vma)
 {
 	if (__vma_shareable_flags_pmd(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+		struct hugetlb_shared_vma_data *data = vma->vm_private_data;
 
-		down_write(&vma_lock->rw_sema);
+		down_write(&data->vma_lock.rw_sema);
 	}
 }
 
 void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
 {
 	if (__vma_shareable_flags_pmd(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+		struct hugetlb_shared_vma_data *data = vma->vm_private_data;
 
-		up_write(&vma_lock->rw_sema);
+		up_write(&data->vma_lock.rw_sema);
 	}
 }
 
 int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
 {
-	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+	struct hugetlb_shared_vma_data *data = vma->vm_private_data;
 
 	if (!__vma_shareable_flags_pmd(vma))
 		return 1;
 
-	return down_write_trylock(&vma_lock->rw_sema);
+	return down_write_trylock(&data->vma_lock.rw_sema);
 }
 
 void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
 {
 	if (__vma_shareable_flags_pmd(vma)) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+		struct hugetlb_shared_vma_data *data = vma->vm_private_data;
 
-		lockdep_assert_held(&vma_lock->rw_sema);
+		lockdep_assert_held(&data->vma_lock.rw_sema);
 	}
 }
 
@@ -6985,7 +6985,7 @@ static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
 	}
 }
 
-static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
+static void hugetlb_vma_data_free(struct vm_area_struct *vma)
 {
 	/*
 	 * Only present in sharable vmas.
@@ -6994,16 +6994,17 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 		return;
 
 	if (vma->vm_private_data) {
-		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+		struct hugetlb_shared_vma_data *data = vma->vm_private_data;
+		struct hugetlb_vma_lock *vma_lock = &data->vma_lock;
 
 		down_write(&vma_lock->rw_sema);
 		__hugetlb_vma_unlock_write_put(vma_lock);
 	}
 }
 
-static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+static int hugetlb_vma_data_alloc(struct vm_area_struct *vma)
 {
-	struct hugetlb_vma_lock *vma_lock;
+	struct hugetlb_shared_vma_data *data;
 
 	/* Only establish in (flags) sharable vmas */
 	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
@@ -7013,8 +7014,8 @@ static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 	if (vma->vm_private_data)
 		return 0;
 
-	vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
-	if (!vma_lock) {
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
 		/*
 		 * If we can not allocate structure, then vma can not
 		 * participate in pmd sharing.  This is only a possible
@@ -7025,14 +7026,14 @@ static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 		 * until the file is removed.  Warn in the unlikely case of
 		 * allocation failure.
 		 */
-		pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
+		pr_warn_once("HugeTLB: unable to allocate vma shared data\n");
 		return -ENOMEM;
 	}
 
-	kref_init(&vma_lock->refs);
-	init_rwsem(&vma_lock->rw_sema);
-	vma_lock->vma = vma;
-	vma->vm_private_data = vma_lock;
+	kref_init(&data->vma_lock.refs);
+	init_rwsem(&data->vma_lock.rw_sema);
+	data->vma_lock.vma = vma;
+	vma->vm_private_data = data;
 	return 0;
 }
 
@@ -7157,11 +7158,11 @@ static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
 {
 }
 
-static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
+static void hugetlb_vma_data_free(struct vm_area_struct *vma)
 {
 }
 
-static int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+static int hugetlb_vma_data_alloc(struct vm_area_struct *vma)
 {
 	return 0;
 }
-- 
2.38.0.135.g90850a2211-goog

