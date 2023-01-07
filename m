Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32585660A8B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbjAGAAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbjAGAAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:00:16 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF89B1BC82
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:00:14 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m3so2166390wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 16:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWaEEzUdu0a2l69D/koc9fARtXrykhlMFd9nb9u+kTo=;
        b=dmtKLautw2/olGS3O9y/lbMdibf3u+VPwxPdWc64OCxiB1sCsR8NGasJE1BK/IHeni
         zcAlgpcWYc0bOE+V8vlYASwjOBdvvTqkK8pNggfl6z1WBGgTntz8Sg2mE473j8JsoJjL
         bJY95Lwk9SeCuqc6NMM65ane++HcgMCZJymi+/tOAqhUHbnxdy0G6aDP14vKuxkJKCZQ
         A2BnewoXb2IQyCjl0bGLXoO88gBxa/nBqu3PitB/sShiuDDQARLPPyzPM6C+cLeuv3xe
         ZQKnUwavzIatT3M/BzfJcYe8e6XQ2Z2hrHOv+Tv5PheC3W37mGDjbnxQJrSlKSbmXyTl
         IeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWaEEzUdu0a2l69D/koc9fARtXrykhlMFd9nb9u+kTo=;
        b=oe6Qcbg51rhcSqpBBQ+DeupH2Is82+0+Apgnj2fM1r7J1EDm8OTAEJEg8JXOPhPgv6
         twY0ShdkeKY8tTtpR5eRP3oMk9mo2A1AXoPa3cTM7BbupIVnsC9xb8xIpqt01wgN7Yui
         hKQPUtvMqOAxHo6ZHv0JdvGwuyZlKKT7ZUhOXczgbYpzh4b0CE4HTT8H+5099sD1L9Jr
         HEMmmJcI3MqmrspDvJ9++C//DkNQgxaXQ1Lb4UEkOXQqzfku3iRM8uoXJbzUHrt1IOgb
         THJzplIBSPm8AnGT3/p6Dk9SHi4+5F1iEteHsSPOWfivza5yBvLPPBtK9JIBL+bjV5oB
         5imA==
X-Gm-Message-State: AFqh2kp5Th9RBG2m7+SYsXeXG05pq5SBU6s8YuqMz974SOF+lO/hEMns
        03Dr8ZBwWo22FlT5ao65Tgy0l7Bvz40=
X-Google-Smtp-Source: AMrXdXtUgnR1AWdGbs23R+6obY22Kkx+ZxsK1plTHayCpdTvom60eUQP+rm8DFF0kGxlyo9XDkX6Vg==
X-Received: by 2002:a05:600c:4307:b0:3d3:494f:6a39 with SMTP id p7-20020a05600c430700b003d3494f6a39mr40925953wme.16.1673049613147;
        Fri, 06 Jan 2023 16:00:13 -0800 (PST)
Received: from lucifer.home (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.googlemail.com with ESMTPSA id p21-20020a7bcc95000000b003c65c9a36dfsm3102234wma.48.2023.01.06.16.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 16:00:12 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm: update mmap_sem comments to refer to mmap_lock
Date:   Sat,  7 Jan 2023 00:00:05 +0000
Message-Id: <33fba04389ab63fc4980e7ba5442f521df6dc657.1673048927.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rename from mm->mmap_sem to mm->mmap_lock was performed in commit
da1c55f1b272 ("mmap locking API: rename mmap_sem to mmap_lock") and commit
c1e8d7c6a7a6 ("map locking API: convert mmap_sem comments"), however some
incorrect comments remain.

This patch simply corrects those comments which are obviously incorrect
within mm itself.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/mm_types.h | 2 +-
 include/linux/page_ref.h | 2 +-
 mm/hugetlb.c             | 4 ++--
 mm/madvise.c             | 2 +-
 mm/mmap.c                | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7bb216b9b8d6..83f0c0c8869c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -581,7 +581,7 @@ struct vm_area_struct {
 	/*
 	 * For private and shared anonymous mappings, a pointer to a null
 	 * terminated string containing the name given to the vma, or NULL if
-	 * unnamed. Serialized by mmap_sem. Use anon_vma_name to access.
+	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
 	 */
 	struct anon_vma_name *anon_name;
 #endif
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 2e677e6ad09f..d7c2d33baa7f 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -301,7 +301,7 @@ static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
  *
  * You can also use this function if you're holding a lock that prevents
  * pages being frozen & removed; eg the i_pages lock for the page cache
- * or the mmap_sem or page table lock for page tables.  In this case,
+ * or the mmap_lock or page table lock for page tables.  In this case,
  * it will always succeed, and you could have used a plain folio_get(),
  * but it's sometimes more convenient to have a common function called
  * from both locked and RCU-protected contexts.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d54336538e8e..6fe65f14d33b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1177,7 +1177,7 @@ void hugetlb_dup_vma_private(struct vm_area_struct *vma)

 /*
  * Reset and decrement one ref on hugepage private reservation.
- * Called with mm->mmap_sem writer semaphore held.
+ * Called with mm->mmap_lock writer semaphore held.
  * This function should be only used by move_vma() and operate on
  * same sized vma. It should never come here with last ref on the
  * reservation.
@@ -5149,7 +5149,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,

 	/*
 	 * We don't have to worry about the ordering of src and dst ptlocks
-	 * because exclusive mmap_sem (or the i_mmap_lock) prevents deadlock.
+	 * because exclusive mmap_lock (or the i_mmap_lock) prevents deadlock.
 	 */
 	if (src_ptl != dst_ptl)
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
diff --git a/mm/madvise.c b/mm/madvise.c
index 4a33f69ad5ef..4561aaa0e46c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -130,7 +130,7 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
 #endif /* CONFIG_ANON_VMA_NAME */
 /*
  * Update the vm_flags on region of a vma, splitting it or merging it as
- * necessary.  Must be called with mmap_sem held for writing;
+ * necessary.  Must be called with mmap_lock held for writing;
  * Caller should ensure anon_name stability by raising its refcount even when
  * anon_name belongs to a valid vma because this function might free that vma.
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index 19e3f0deaa42..1bafd2c04b4b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2321,7 +2321,7 @@ static inline int munmap_sidetree(struct vm_area_struct *vma,
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
+ * @downgrade: Set to true to attempt a write downgrade of the mmap_lock
  *
  * If @downgrade is true, check return code for potential release of the lock.
  */
@@ -2473,7 +2473,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * @len: The length of the range to munmap
  * @uf: The userfaultfd list_head
  * @downgrade: set to true if the user wants to attempt to write_downgrade the
- * mmap_sem
+ * mmap_lock
  *
  * This function takes a @mas that is either pointing to the previous VMA or set
  * to MA_START and sets it up to remove the mapping(s).  The @len will be
--
2.39.0
