Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A895962EABB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbiKRBLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240750AbiKRBL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:11:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664287FF3D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpOw2twfKJ5Aty2Xl+QxZU1Og2jk2hUFVZDT66cF6Tk=;
        b=OpRqMXgcjAKxByazNHBqfRZklAFIZzPGVLn9dEFbiIfuv6Z2jfD/tmGJUsbUN0fs0m7FGI
        7O83RnEugObYRtS+N5zqS3sEqYOVzaZUa/gszK+js7raIjnFwExUHlZCX8B59ghzbAp0IJ
        wNX8fBnvuda0jgAbltu/+tuFrig+MpU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-XChnTWwePX69xsubRtRYYQ-1; Thu, 17 Nov 2022 20:10:35 -0500
X-MC-Unique: XChnTWwePX69xsubRtRYYQ-1
Received: by mail-qk1-f200.google.com with SMTP id w13-20020a05620a424d00b006e833c4fb0dso4393848qko.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpOw2twfKJ5Aty2Xl+QxZU1Og2jk2hUFVZDT66cF6Tk=;
        b=YIeUe/W+QRm/vtp0AlRVIZ68vXH9vnODDFhFHE4Ctegkda4La3IiADxfA1SABxKchX
         MMJj3md/1Yor3ml5CN3SCMRjMiLdCErLydYffZQs4XkgoaJ8Znp1Xh9KdsZQxNX3qYHn
         9S/kVaYGGfjP6YRSXFHJK142XfJqSFZIksqQbVzzD4Y5d+KT1Fa22g87XGnds0EyVIIC
         hEVah8TVyd07nco8EX8aORPilS9iqCKqWEJsoy/31sg6raSciFgWfD5JJd45fzKcFxDU
         zZsdUw6u9ZuY/KGvRcV4Em+HWBLT8BZMpNqPzi7fBYhTyZfgIGuPrKTynMjnEwf9Fp6L
         Am2A==
X-Gm-Message-State: ANoB5pkj9MlGcNnbvhTWX/4mtG1AAQZc3PfH14uORVqYTY+hRLAcgVeh
        7FBatW2nkWroTenkJF1/68EAh7z9UVWwQeU51RcdOy5fR3fFjWXxIKfhBbUNhjjmratoUZHQpEs
        dIQxKhLrgiWZJmiWy6ioPH49z
X-Received: by 2002:ac8:4e0c:0:b0:3a5:279d:dd34 with SMTP id c12-20020ac84e0c000000b003a5279ddd34mr4654994qtw.531.1668733835019;
        Thu, 17 Nov 2022 17:10:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7L/DTG7iZGWFpqDk5hsUhnfTTrsJsKX9hBQZCwDrkhBBpJLcBKb29jKauqxKgKWLHLgAsufg==
X-Received: by 2002:ac8:4e0c:0:b0:3a5:279d:dd34 with SMTP id c12-20020ac84e0c000000b003a5279ddd34mr4654969qtw.531.1668733834702;
        Thu, 17 Nov 2022 17:10:34 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm1491342qko.126.2022.11.17.17.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:10:34 -0800 (PST)
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
Subject: [PATCH RFC v2 04/12] mm/hugetlb: Add pgtable walker lock
Date:   Thu, 17 Nov 2022 20:10:17 -0500
Message-Id: <20221118011025.2178986-5-peterx@redhat.com>
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

huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
hugetlb address.

Normally, it's always safe to walk a generic pgtable as long as we're with
the mmap lock held for either read or write, because that guarantees the
pgtable pages will always be valid during the process.

But it's not true for hugetlbfs, especially shared: hugetlbfs can have its
pgtable freed by pmd unsharing, it means that even with mmap lock held for
current mm, the PMD pgtable page can still go away from under us if pmd
unsharing is possible during the walk.

So we have three ways to make it safe:

  (1) If the mapping is private we're not prone to pmd sharing or
      unsharing, so it's okay.

  (2) If we're with the hugetlb vma lock held for either read/write, it's
      okay too because pmd unshare cannot happen at all.

  (3) Otherwise we may need the pgtable walker lock

The pgtable walker is implemented in different ways depending on the
config:

  - if !ARCH_WANT_HUGE_PMD_SHARE:      it's no-op
  - else if MMU_GATHER_RCU_TABLE_FREE: it should be rcu_read_lock()
  - else:                              it should be local_irq_disable()

A more efficient way to take the lock is only taking them with valid vmas
that are possible to have pmd sharing (aka, want_pmd_share() returns true),
but since the lock is mostly lightweighted (only riscv will use irq
disable, x86 & arm will use rcu) just take them unconditionally for now.

Document all these explicitly for huge_pte_offset() too, because it's not
that obvious.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 99 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 551834cd5299..8f85ad0d5bdb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -12,6 +12,8 @@
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/irqflags.h>
+#include <linux/rcupdate.h>
 
 struct ctl_table;
 struct user_struct;
@@ -24,6 +26,71 @@ typedef struct { unsigned long pd; } hugepd_t;
 #define __hugepd(x) ((hugepd_t) { (x) })
 #endif
 
+/**
+ * @hugetlb_walker_[un]lock(): protects software hugetlb pgtable walkers
+ *
+ * The hugetlb walker lock needs to be taken before huge_pte_offset() and
+ * needs to be released after finishing using the pte_t* returned.  It's
+ * used to guarantee we won't access a freed pgtable page.  Normally in
+ * this case we already have the mmap lock held for read.
+ *
+ * When holding the hugetlb walker lock, the thread cannot sleep, nor can
+ * it already in irq context (just to simplify unlock with no-save for
+ * !RCU_TABLE_TREE).  Before the thread yields itself, it should release
+ * the pgtable lock.  After the lock released, pte_t* can become invalid
+ * anytime so it cannot be accessed anymore.
+ *
+ * The only reason for the lock is to protect concurrent pmd unsharing
+ * followed by e.g. munmap() to drop the pgtable page.  For no-pmd-sharing
+ * archs, it's no-op because it's always safe to access hugetlb pgtables
+ * just like generic pgtables.
+ */
+#if !defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE)
+static inline void hugetlb_walker_lock(void)
+{
+}
+static inline void hugetlb_walker_unlock(void)
+{
+}
+static inline bool __hugetlb_walker_locked(void)
+{
+	return true;
+}
+#elif defined(CONFIG_MMU_GATHER_RCU_TABLE_FREE)
+static inline void hugetlb_walker_lock(void)
+{
+	rcu_read_lock();
+}
+static inline void hugetlb_walker_unlock(void)
+{
+	rcu_read_unlock();
+}
+static inline bool __hugetlb_walker_locked(void)
+{
+	return rcu_read_lock_held();
+}
+#else
+static inline void hugetlb_walker_lock(void)
+{
+	WARN_ON_ONCE(irqs_disabled());
+	local_irq_disable();
+}
+static inline void hugetlb_walker_unlock(void)
+{
+	local_irq_enable();
+}
+static inline bool __hugetlb_walker_locked(void)
+{
+	return irqs_disabled();
+}
+#endif
+
+#ifdef CONFIG_LOCKDEP
+#define  hugetlb_walker_locked()  __hugetlb_walker_locked()
+#else
+#define  hugetlb_walker_locked()  true
+#endif
+
 #ifdef CONFIG_HUGETLB_PAGE
 
 #include <linux/mempolicy.h>
@@ -192,6 +259,38 @@ extern struct list_head huge_boot_pages;
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
+/*
+ * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
+ * Returns the pte_t* if found, or NULL if the address is not mapped.
+ *
+ * NOTE: since this function will walk all the pgtable pages (including not
+ * only high-level pgtable page, but also PUD entry that can be unshared
+ * concurrently for VM_SHARED), the caller of this function should be
+ * responsible of its thread safety.  One can follow this rule:
+ *
+ *  (1) For private mappings: pmd unsharing is not possible, so it'll
+ *      always be safe if we're with the mmap sem for either read or write.
+ *      This is normally always the case, IOW we don't need to do anything
+ *      special.
+ *
+ *  (2) For shared mappings: pmd unsharing is possible (so the PUD-ranged
+ *      pgtable page can go away from under us!  It can be done by a pmd
+ *      unshare with a follow up munmap() on the other process), then we
+ *      need either:
+ *
+ *     (2.1) hugetlb vma lock read or write held, to make sure pmd unshare
+ *           won't happen upon the range (it also makes sure the pte_t we
+ *           read is the right and stable one), or,
+ *
+ *     (2.2) pgtable walker lock, to make sure even pmd unsharing happened,
+ *           the old shared PUD page won't get freed from under us, so even
+ *           the pteval can be obsolete, at least it's still always safe to
+ *           access the pgtable page (e.g., de-referencing pte_t* would not
+ *           cause use-after-free).
+ *
+ * PS: from the regard of (2.2), it's the same logic of fast-gup being safe
+ * for generic mm when walking the pgtables even without mmap lock.
+ */
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
 unsigned long hugetlb_mask_last_page(struct hstate *h);
-- 
2.37.3

