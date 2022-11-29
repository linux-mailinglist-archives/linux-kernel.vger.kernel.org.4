Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F9063C41C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiK2Pru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbiK2Prs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:47:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9CB6357
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:47:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v1so22734607wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcNi41xvTMS4NGTUpyHD2vhE6PXJ5qCDMr6KFHcPQag=;
        b=Ymj/TX58LmBHMlJm2tvaAwNPklk0OGDZu/h2bpwb8PEHBxKhk4ajUV93di2Grz8TVV
         9lMyxfkKDAp24o03K5+1FRcgoCKVXZjlBGbIytbuviIem7nF4rYyG6KooxotGqK+hP1E
         oOi+BBXCoaw4iA3xFq6+2BtTm31okvGXqpDLHXAVrSQF4e3INEQh3xc0r9WI6qWJs9vr
         cn8nSzY+otKe+LsoUuNa8GtXB+bJo3a/2ezw2yBL/OKQ89GnW5aHwVJlGaUwwQWVVlUi
         OfYz0qsbjPaz3Sq039jK3ZktX72U89/hNuW+ZLmHuz+gzgfB998b5wYXplTrOYLmT1UV
         HOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcNi41xvTMS4NGTUpyHD2vhE6PXJ5qCDMr6KFHcPQag=;
        b=agypwEglpyK4xut2vNW72TMMNiRJNKNKEpttnV5CHd+R1Q3ChM6PaPxCL9gcGOY0RM
         jqGOF9fJNRYKhKxT6sY/qseQ174qmRqvkH53Aw5KE2M9ztgLVNMuKSGL7App88h2Vl7J
         K5s2SqG7Hb7NJcAYhTOID4VvpLu+m5B0MNmwQ4/GboUgJkXLIn/QZZGy/YoJqeTsFcRv
         tsCbYFhhX4Na/MKJYoGMhSxMWYjQHQer6InbxRK0OLnt6bfnMuTJf3V2xEUmsBOxYRQw
         DRvMz0l0JeLTSqPiDO7Yqfk2qKljZjC1YE8MU7PGdnX9RwzXsIWzFJ1LIfV4dNqu0kgR
         BP8Q==
X-Gm-Message-State: ANoB5pnIRwbpjAfDBvansrb20AX8LM03b2KlWbDmknz6Onua4vtxvt82
        k9rjVcFPd5KRPCICTB6G8+mEpw==
X-Google-Smtp-Source: AA0mqf4VS2OE+nEDrDPjpzaYNf+mLsm5WKH9zV+k+70WKT3wLEzTcfYv6YO/CIf/HCa4ZWlt9jGz0w==
X-Received: by 2002:a05:6000:70f:b0:22e:41c5:7ef7 with SMTP id bs15-20020a056000070f00b0022e41c57ef7mr35635050wrb.332.1669736860806;
        Tue, 29 Nov 2022 07:47:40 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:5011:adcc:fddd:accf])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d6b49000000b002366e3f1497sm14090293wrw.6.2022.11.29.07.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:47:40 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v5 1/3] mm/khugepaged: Take the right locks for page table retraction
Date:   Tue, 29 Nov 2022 16:47:28 +0100
Message-Id: <20221129154730.2274278-1-jannh@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pagetable walks on address ranges mapped by VMAs can be done under the mmap
lock, the lock of an anon_vma attached to the VMA, or the lock of the VMA's
address_space. Only one of these needs to be held, and it does not need to
be held in exclusive mode.

Under those circumstances, the rules for concurrent access to page table
entries are:

 - Terminal page table entries (entries that don't point to another page
   table) can be arbitrarily changed under the page table lock, with the
   exception that they always need to be consistent for
   hardware page table walks and lockless_pages_from_mm().
   This includes that they can be changed into non-terminal entries.
 - Non-terminal page table entries (which point to another page table)
   can not be modified; readers are allowed to READ_ONCE() an entry, verify
   that it is non-terminal, and then assume that its value will stay as-is.

Retracting a page table involves modifying a non-terminal entry, so
page-table-level locks are insufficient to protect against concurrent
page table traversal; it requires taking all the higher-level locks under
which it is possible to start a page walk in the relevant range in
exclusive mode.

The collapse_huge_page() path for anonymous THP already follows this rule,
but the shmem/file THP path was getting it wrong, making it possible for
concurrent rmap-based operations to cause corruption.

Cc: stable@kernel.org
Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v4: added ack by David Hildenbrand
    v5: added reviewed-by by Yang Shi

 mm/khugepaged.c | 55 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4734315f79407..674b111a24fa7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1384,16 +1384,37 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
 	return SCAN_SUCCEED;
 }
 
+/*
+ * A note about locking:
+ * Trying to take the page table spinlocks would be useless here because those
+ * are only used to synchronize:
+ *
+ *  - modifying terminal entries (ones that point to a data page, not to another
+ *    page table)
+ *  - installing *new* non-terminal entries
+ *
+ * Instead, we need roughly the same kind of protection as free_pgtables() or
+ * mm_take_all_locks() (but only for a single VMA):
+ * The mmap lock together with this VMA's rmap locks covers all paths towards
+ * the page table entries we're messing with here, except for hardware page
+ * table walks and lockless_pages_from_mm().
+ */
 static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
 				  unsigned long addr, pmd_t *pmdp)
 {
-	spinlock_t *ptl;
 	pmd_t pmd;
 
 	mmap_assert_write_locked(mm);
-	ptl = pmd_lock(vma->vm_mm, pmdp);
+	if (vma->vm_file)
+		lockdep_assert_held_write(&vma->vm_file->f_mapping->i_mmap_rwsem);
+	/*
+	 * All anon_vmas attached to the VMA have the same root and are
+	 * therefore locked by the same lock.
+	 */
+	if (vma->anon_vma)
+		lockdep_assert_held_write(&vma->anon_vma->root->rwsem);
+
 	pmd = pmdp_collapse_flush(vma, addr, pmdp);
-	spin_unlock(ptl);
 	mm_dec_nr_ptes(mm);
 	page_table_check_pte_clear_range(mm, addr, pmd);
 	pte_free(mm, pmd_pgtable(pmd));
@@ -1444,6 +1465,14 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
 		return SCAN_VMA_CHECK;
 
+	/*
+	 * Symmetry with retract_page_tables(): Exclude MAP_PRIVATE mappings
+	 * that got written to. Without this, we'd have to also lock the
+	 * anon_vma if one exists.
+	 */
+	if (vma->anon_vma)
+		return SCAN_VMA_CHECK;
+
 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
 	if (userfaultfd_wp(vma))
 		return SCAN_PTE_UFFD_WP;
@@ -1477,6 +1506,20 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto drop_hpage;
 	}
 
+	/*
+	 * We need to lock the mapping so that from here on, only GUP-fast and
+	 * hardware page walks can access the parts of the page tables that
+	 * we're operating on.
+	 * See collapse_and_free_pmd().
+	 */
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	/*
+	 * This spinlock should be unnecessary: Nobody else should be accessing
+	 * the page tables under spinlock protection here, only
+	 * lockless_pages_from_mm() and the hardware page walker can access page
+	 * tables while all the high-level locks are held in write mode.
+	 */
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
 	result = SCAN_FAIL;
 
@@ -1531,6 +1574,8 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	/* step 4: remove pte entries */
 	collapse_and_free_pmd(mm, vma, haddr, pmd);
 
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
+
 maybe_install_pmd:
 	/* step 5: install pmd entry */
 	result = install_pmd
@@ -1544,6 +1589,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 
 abort:
 	pte_unmap_unlock(start_pte, ptl);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
 	goto drop_hpage;
 }
 
@@ -1600,7 +1646,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
 		 * An alternative would be drop the check, but check that page
 		 * table is clear before calling pmdp_collapse_flush() under
 		 * ptl. It has higher chance to recover THP for the VMA, but
-		 * has higher cost too.
+		 * has higher cost too. It would also probably require locking
+		 * the anon_vma.
 		 */
 		if (vma->anon_vma) {
 			result = SCAN_PAGE_ANON;

base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
-- 
2.38.1.584.g0f3c55d4c2-goog

