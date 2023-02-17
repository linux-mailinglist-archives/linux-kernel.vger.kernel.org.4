Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C9F69A410
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 03:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjBQC4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 21:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBQC4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 21:56:23 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6EA5382B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:56:21 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PHxJn4D1LzrRsv;
        Fri, 17 Feb 2023 10:55:53 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Feb 2023 10:56:19 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <mawupeng1@huawei.com>, <bp@suse.de>, <toshi.kani@hp.com>,
        <suresh.b.siddha@intel.com>,
        <syzbot+5f488e922d047d8f00cc@syzkaller.appspotmail.com>
Subject: [RFC PATCH 1/1] x86/mm/pat: Clear VM_PAT if copy_p4d_range failed
Date:   Fri, 17 Feb 2023 10:56:15 +0800
Message-ID: <20230217025615.1595558-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

x86/mm/pat: Clear VM_PAT if copy_p4d_range failed.

Syzbot reports a warning in untrack_pfn(). Digging into the root we found
that this is due to memory allocation failure in pmd_alloc_one. And this
failure is produced due to failslab.

In copy_page_range(), memory alloaction for pmd failed. During the error
handling process in copy_page_range(), mmput() is called to remove all
vmas. While untrack_pfn this empty pfn, warning happens.

Here's a simplified flow:

dup_mm
  dup_mmap
    copy_page_range
      copy_p4d_range
        copy_pud_range
          copy_pmd_range
            pmd_alloc
              __pmd_alloc
                pmd_alloc_one
                  page = alloc_pages(gfp, 0);
                    if (!page)
                      return NULL;
    mmput
        exit_mmap
          unmap_vmas
            unmap_single_vma
              untrack_pfn
                follow_phys
                  WARN_ON_ONCE(1);

Since this vma is not generate successfully, we can clear flag VM_PAT.
In this case, untrack_pfn() will not be called while cleaning this vma.

Function untrack_pfn_moved() has also been renamed to fit the new logic.

Reported-by: syzbot+5f488e922d047d8f00cc@syzkaller.appspotmail.com
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/x86/mm/pat/memtype.c | 12 ++++++++----
 include/linux/pgtable.h   |  7 ++++---
 mm/memory.c               |  1 +
 mm/mremap.c               |  2 +-
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index fb4b1b5e0dea..558bb71ff350 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1070,11 +1070,15 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 }
 
 /*
- * untrack_pfn_moved is called, while mremapping a pfnmap for a new region,
- * with the old vma after its pfnmap page table has been removed.  The new
- * vma has a new pfnmap to the same pfn & cache type with VM_PAT set.
+ * untrack_pfn_clear is called if the following situation fits:
+ *
+ * 1) while mremapping a pfnmap for a new region,  with the old vma after
+ * its pfnmap page table has been removed.  The new vma has a new pfnmap
+ * to the same pfn & cache type with VM_PAT set.
+ * 2) while duplicating vm area, the new vma fails to copy the pgtable from
+ * old vma.
  */
-void untrack_pfn_moved(struct vm_area_struct *vma)
+void untrack_pfn_clear(struct vm_area_struct *vma)
 {
 	vma->vm_flags &= ~VM_PAT;
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1159b25b0542..e211124f4330 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1219,9 +1219,10 @@ static inline void untrack_pfn(struct vm_area_struct *vma,
 }
 
 /*
- * untrack_pfn_moved is called while mremapping a pfnmap for a new region.
+ * untrack_pfn_clear is called while mremapping a pfnmap for a new region
+ * or fails to copy pgtable during duplicate vm area.
  */
-static inline void untrack_pfn_moved(struct vm_area_struct *vma)
+static inline void untrack_pfn_clear(struct vm_area_struct *vma)
 {
 }
 #else
@@ -1233,7 +1234,7 @@ extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
 extern int track_pfn_copy(struct vm_area_struct *vma);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size);
-extern void untrack_pfn_moved(struct vm_area_struct *vma);
+extern void untrack_pfn_clear(struct vm_area_struct *vma);
 #endif
 
 #ifdef CONFIG_MMU
diff --git a/mm/memory.c b/mm/memory.c
index f526b9152bef..846d4136d1de 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1278,6 +1278,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 			continue;
 		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
 					    addr, next))) {
+			untrack_pfn_clear(dst_vma);
 			ret = -ENOMEM;
 			break;
 		}
diff --git a/mm/mremap.c b/mm/mremap.c
index 930f65c315c0..6ed28eeae5a8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -682,7 +682,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	/* Tell pfnmap has moved from this vma */
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
-		untrack_pfn_moved(vma);
+		untrack_pfn_clear(vma);
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
-- 
2.25.1

