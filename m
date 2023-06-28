Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0991740BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjF1ImL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjF1IjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:39:21 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5726D3A90
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:30:24 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d75a77b69052e-3ff2770311dso67259531cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687941023; x=1690533023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=70kkRXsfLM/8BYxAf0BjvmYkgZM27G9ch/j23+KotKk=;
        b=AEZDqgBoFVjXU3y/7TV5VuKiyMdJjz5LdugNdq6UPH4dqhts9B5ssFe+372kY6VRPY
         wRv20QLNQA9pv7bToi/NasIjiBHtbtN4Vi+lU3YiZgDCroFuZwPeMEfwEba1vRKMlzaS
         mOBLT5OFkq4f8N1ktlQxuQYjmvgDDA0dcNz460leXvFX/K1ZopTrSuKUFC9RE+NWG/BX
         K6N6DV6xR9gKCFGc0xPfGw3/rBWYpGy/oafHlOwnetz6pZxCTifM4Xc0QkVqka20AhRo
         logKLiUNUEQE2dEAkkDGBHFfu1IxpqKIwmBXAnIVC6Wh//tWhIUw80py89fFdmJKMOHd
         a0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687941023; x=1690533023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70kkRXsfLM/8BYxAf0BjvmYkgZM27G9ch/j23+KotKk=;
        b=VOvtNryBhJjWE7ZTzLPDMMbm6lu911VEiktH6NIVoPjnc7RTHAYucsknmmu86MN6ob
         K5zmunz5PuX7YZNTAb/IGBrSkU9wXSlWQeTK5xzyTy6/1k+yCnrNR93h4S7+tcsg+wNh
         Knn70RP/uAx47L0WuC+XD+YIcOmKEuwQGDfRXcy7fCM3FervvxJt1fcY0at60PVPg2P+
         erIpCSbUYDF1KKOetBmPKASeDCSqCa+NLifkMGuda6yp6BZTtEiYfhWPOViH2zNuvTWs
         itayOiaFsRLN/zzk27uSpPFM6dXVtKAg9Uj0vXkKG1jXhdR3KHluHXwN9JqJVPMBr4Ql
         R5gw==
X-Gm-Message-State: AC+VfDxeBE5RQaWPmPJjZrJLFRZVE55FkweLlbgDj56UUUYRg1QAIAJS
        78jAX1LXFS87wCIxNaZX/maXOTKuX2g=
X-Google-Smtp-Source: ACHHUZ6OQi+GrrsFt6L2aYE+Bh/8JjB2CJChJJQK4V9w8+uL61Sq3ukd625ySw4N4Q1XugZY6mxhmwtxYNQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6664:8bd3:57fd:c83a])
 (user=surenb job=sendgmr) by 2002:a25:11c4:0:b0:c2a:b486:1085 with SMTP id
 187-20020a2511c4000000b00c2ab4861085mr2504239ybr.10.1687936693767; Wed, 28
 Jun 2023 00:18:13 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:17:58 -0700
In-Reply-To: <20230628071800.544800-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628071800.544800-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628071800.544800-5-surenb@google.com>
Subject: [PATCH v4 4/6] mm: change folio_lock_or_retry to use vm_fault directly
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change folio_lock_or_retry to accept vm_fault struct and return the
vm_fault_t directly.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pagemap.h |  9 ++++-----
 mm/filemap.c            | 22 ++++++++++++----------
 mm/memory.c             | 14 ++++++--------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..59d070c55c97 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -896,8 +896,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __folio_lock(struct folio *folio);
 int __folio_lock_killable(struct folio *folio);
-bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
-				unsigned int flags);
+vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf);
 void unlock_page(struct page *page);
 void folio_unlock(struct folio *folio);
 
@@ -1001,11 +1000,11 @@ static inline int folio_lock_killable(struct folio *folio)
  * Return value and mmap_lock implications depend on flags; see
  * __folio_lock_or_retry().
  */
-static inline bool folio_lock_or_retry(struct folio *folio,
-		struct mm_struct *mm, unsigned int flags)
+static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
+					     struct vm_fault *vmf)
 {
 	might_sleep();
-	return folio_trylock(folio) || __folio_lock_or_retry(folio, mm, flags);
+	return folio_trylock(folio) ? 0 : __folio_lock_or_retry(folio, vmf);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 00f01d8ead47..52bcf12dcdbf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1701,32 +1701,34 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 
 /*
  * Return values:
- * true - folio is locked; mmap_lock is still held.
- * false - folio is not locked.
+ * 0 - folio is locked.
+ * VM_FAULT_RETRY - folio is not locked.
  *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
  *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
  *     which case mmap_lock is still held.
  *
- * If neither ALLOW_RETRY nor KILLABLE are set, will always return true
+ * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
  * with the folio locked and the mmap_lock unperturbed.
  */
-bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
-			 unsigned int flags)
+vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
 {
+	struct mm_struct *mm = vmf->vma->vm_mm;
+	unsigned int flags = vmf->flags;
+
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
-		 * even though return 0.
+		 * even though return VM_FAULT_RETRY.
 		 */
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
-			return false;
+			return VM_FAULT_RETRY;
 
 		mmap_read_unlock(mm);
 		if (flags & FAULT_FLAG_KILLABLE)
 			folio_wait_locked_killable(folio);
 		else
 			folio_wait_locked(folio);
-		return false;
+		return VM_FAULT_RETRY;
 	}
 	if (flags & FAULT_FLAG_KILLABLE) {
 		bool ret;
@@ -1734,13 +1736,13 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 		ret = __folio_lock_killable(folio);
 		if (ret) {
 			mmap_read_unlock(mm);
-			return false;
+			return VM_FAULT_RETRY;
 		}
 	} else {
 		__folio_lock(folio);
 	}
 
-	return true;
+	return 0;
 }
 
 /**
diff --git a/mm/memory.c b/mm/memory.c
index f14d45957b83..345080052003 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3568,6 +3568,7 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	struct folio *folio = page_folio(vmf->page);
 	struct vm_area_struct *vma = vmf->vma;
 	struct mmu_notifier_range range;
+	vm_fault_t ret;
 
 	/*
 	 * We need a reference to lock the folio because we don't hold
@@ -3580,9 +3581,10 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	if (!folio_try_get(folio))
 		return 0;
 
-	if (!folio_lock_or_retry(folio, vma->vm_mm, vmf->flags)) {
+	ret = folio_lock_or_retry(folio, vmf);
+	if (ret) {
 		folio_put(folio);
-		return VM_FAULT_RETRY;
+		return ret;
 	}
 	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_EXCLUSIVE, 0,
 				vma->vm_mm, vmf->address & PAGE_MASK,
@@ -3704,7 +3706,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
-	int locked;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
@@ -3826,12 +3827,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 	}
 
-	locked = folio_lock_or_retry(folio, vma->vm_mm, vmf->flags);
-
-	if (!locked) {
-		ret |= VM_FAULT_RETRY;
+	ret |= folio_lock_or_retry(folio, vmf);
+	if (ret & VM_FAULT_RETRY)
 		goto out_release;
-	}
 
 	if (swapcache) {
 		/*
-- 
2.41.0.162.gfafddb0af9-goog

