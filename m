Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF0765E8CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjAEKUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjAEKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20064C731
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l194-20020a2525cb000000b007b411fbdc13so2631560ybl.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8tZn9tkRZbaiVi1nuTHJ8rnAzFnEyMSAOvoIDK0LiA=;
        b=Wlu7XQk16tqMmg+gNIiIDB1JA/O/qtq05ltp8iTMsYdjH00SBVdUFxa+cBdSZqAQcb
         d1Wubwm9cgGb/JWbc53zSO6qZR6u0tqT/uhjkvshXe4Nbc29/Mx0FTWQepbVo5VkK/f4
         iZzimrA+jYG5bRVUIknjFLaPXJryFDe1l0StPyym3HfhV9kGhFLJmjpADMJIHuvbrMU2
         TBM7F+ry7k4c0I//IisI9senk9jQmTO6g/9v4uatar6m1pi5ieYC8Z12sX5T0E2ZspUi
         kbNXjBMVADs1kunBuGHYbySRRHfw6oNiaeB7XCT6DI2AIDizBxl6F3hmyK+58dSXDshb
         CYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8tZn9tkRZbaiVi1nuTHJ8rnAzFnEyMSAOvoIDK0LiA=;
        b=Sm0dsE3fNkCopBCfSLmpvSmZ8sNYZETyFwI5//6Tu3tBTZJrRYMfFY0gWSTfog8e3e
         m3XGOwBgn0A7whztrbVxJ8melnKLkanmdC8R5Td6EE49osdNtqLhAdmINOneWeafpC5g
         nEwM+UiA8SnS1IdY4wtwdaFbOuAZKrE1G81hi/MI8owecQonf6vzqqhzr9OemOR67rPV
         efSZP9W2kGclv6WOiA3r1a0TjYHjsUnb4inmBBqgIXkD6rOVidW+AQuxTUi4BTqDHt5k
         JJM8P4oWV+K8vec140ghrZRjTMRC8ZcVs3R2HtHkQTkEpT8+yARh5EcqcxVQNWiF8WbI
         zNJg==
X-Gm-Message-State: AFqh2kpYR/cWF+ER+ZNtyScAud1OlbFf/DgguJird04Vgq5QQMSTp/Dt
        Jy9MRzOvnwv7Izu5WboD4amdGLRTE6ZE8vjf
X-Google-Smtp-Source: AMrXdXvzTfWe8MomGisuHc0GNsvUXDDVMXnXUti7atm5wfvLHi6RqA6sGIYMNCo6vky1zzYRo3Z5sRweZqrg8aL0
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:afce:0:b0:6ca:ecb9:9fc0 with SMTP
 id d14-20020a25afce000000b006caecb99fc0mr6101337ybj.199.1672913943280; Thu,
 05 Jan 2023 02:19:03 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:05 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-8-jthoughton@google.com>
Subject: [PATCH 07/46] hugetlb: rename __vma_shareable_flags_pmd to __vma_has_hugetlb_vma_lock
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

Previously, if the hugetlb VMA lock was present, that meant that the VMA
was PMD-shareable. Now it is possible that the VMA lock is allocated but
the VMA is not PMD-shareable: if the VMA is a high-granularity VMA.

It is possible for a high-granularity VMA not to have a VMA lock; in
this case, MADV_COLLAPSE will not be able to collapse the mappings.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h | 15 ++++++++++-----
 mm/hugetlb.c            | 16 ++++++++--------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b6b10101bea7..aa49fd8cb47c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1235,7 +1235,8 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
 #define flush_hugetlb_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
 #endif
 
-static inline bool __vma_shareable_lock(struct vm_area_struct *vma)
+static inline bool
+__vma_has_hugetlb_vma_lock(struct vm_area_struct *vma)
 {
 	return (vma->vm_flags & VM_MAYSHARE) && vma->vm_private_data;
 }
@@ -1252,13 +1253,17 @@ hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
 	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 	/*
-	 * If pmd sharing possible, locking needed to safely walk the
-	 * hugetlb pgtables.  More information can be found at the comment
-	 * above huge_pte_offset() in the same file.
+	 * If the VMA has the hugetlb vma lock (PMD sharable or HGM
+	 * collapsible), locking needed to safely walk the hugetlb pgtables.
+	 * More information can be found at the comment above huge_pte_offset()
+	 * in the same file.
+	 *
+	 * This doesn't do a full high-granularity walk, so we are concerned
+	 * only with PMD unsharing.
 	 *
 	 * NOTE: lockdep_is_held() is only defined with CONFIG_LOCKDEP.
 	 */
-	if (__vma_shareable_lock(vma))
+	if (__vma_has_hugetlb_vma_lock(vma))
 		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
 			     !lockdep_is_held(
 				 &vma->vm_file->f_mapping->i_mmap_rwsem));
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 99fadd7680ec..2f86fedef283 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -260,7 +260,7 @@ static inline struct hugepage_subpool *subpool_vma(struct vm_area_struct *vma)
  */
 void hugetlb_vma_lock_read(struct vm_area_struct *vma)
 {
-	if (__vma_shareable_lock(vma)) {
+	if (__vma_has_hugetlb_vma_lock(vma)) {
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		down_read(&vma_lock->rw_sema);
@@ -269,7 +269,7 @@ void hugetlb_vma_lock_read(struct vm_area_struct *vma)
 
 void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
 {
-	if (__vma_shareable_lock(vma)) {
+	if (__vma_has_hugetlb_vma_lock(vma)) {
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		up_read(&vma_lock->rw_sema);
@@ -278,7 +278,7 @@ void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
 
 void hugetlb_vma_lock_write(struct vm_area_struct *vma)
 {
-	if (__vma_shareable_lock(vma)) {
+	if (__vma_has_hugetlb_vma_lock(vma)) {
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		down_write(&vma_lock->rw_sema);
@@ -287,7 +287,7 @@ void hugetlb_vma_lock_write(struct vm_area_struct *vma)
 
 void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
 {
-	if (__vma_shareable_lock(vma)) {
+	if (__vma_has_hugetlb_vma_lock(vma)) {
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		up_write(&vma_lock->rw_sema);
@@ -298,7 +298,7 @@ int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
 {
 	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
-	if (!__vma_shareable_lock(vma))
+	if (!__vma_has_hugetlb_vma_lock(vma))
 		return 1;
 
 	return down_write_trylock(&vma_lock->rw_sema);
@@ -306,7 +306,7 @@ int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
 
 void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
 {
-	if (__vma_shareable_lock(vma)) {
+	if (__vma_has_hugetlb_vma_lock(vma)) {
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		lockdep_assert_held(&vma_lock->rw_sema);
@@ -338,7 +338,7 @@ static void __hugetlb_vma_unlock_write_put(struct hugetlb_vma_lock *vma_lock)
 
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
 {
-	if (__vma_shareable_lock(vma)) {
+	if (__vma_has_hugetlb_vma_lock(vma)) {
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		__hugetlb_vma_unlock_write_put(vma_lock);
@@ -350,7 +350,7 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 	/*
 	 * Only present in sharable vmas.
 	 */
-	if (!vma || !__vma_shareable_lock(vma))
+	if (!vma || !__vma_has_hugetlb_vma_lock(vma))
 		return;
 
 	if (vma->vm_private_data) {
-- 
2.39.0.314.g84b9a713c41-goog

