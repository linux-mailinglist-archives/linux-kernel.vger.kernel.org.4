Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB196AB8AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCFInw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCFIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:43:26 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315822000
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:43:24 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PVX9W1WkvzKq7g;
        Mon,  6 Mar 2023 16:41:19 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 16:43:22 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <mawupeng1@huawei.com>
Subject: [PATCH -next 1/2] x86/mm/pat: Move follow_phys to pat-related file
Date:   Mon, 6 Mar 2023 16:43:15 +0800
Message-ID: <20230306084316.2275757-2-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306084316.2275757-1-mawupeng1@huawei.com>
References: <20230306084316.2275757-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Since only PAT in x86 use follow_phys(), move this to from memory.c to
memtype.c and make it static. Argument flags is always zero in caller
untrack_pfn() and track_pfn_copy(). let's drop it.

Since config HAVE_IOREMAP_PROT is selected by x86, drop this config macro.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/x86/mm/pat/memtype.c | 27 +++++++++++++++++++++++++--
 include/linux/mm.h        |  2 --
 mm/memory.c               | 28 ----------------------------
 3 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index de10800cd4dd..c138ea0b0e6e 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -950,6 +950,29 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		memtype_free(paddr, paddr + size);
 }
 
+static int follow_phys(struct vm_area_struct *vma, unsigned long address,
+		       unsigned long *prot, resource_size_t *phys)
+{
+	int ret = -EINVAL;
+	pte_t *ptep, pte;
+	spinlock_t *ptl;
+
+	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
+		goto out;
+
+	if (follow_pte(vma->vm_mm, address, &ptep, &ptl))
+		goto out;
+	pte = *ptep;
+
+	*prot = pgprot_val(pte_pgprot(pte));
+	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
+
+	ret = 0;
+	pte_unmap_unlock(ptep, ptl);
+out:
+	return ret;
+}
+
 /*
  * track_pfn_copy is called when vma that is covering the pfnmap gets
  * copied through copy_page_range().
@@ -969,7 +992,7 @@ int track_pfn_copy(struct vm_area_struct *vma)
 		 * reserve the whole chunk covered by vma. We need the
 		 * starting address and protection from pte.
 		 */
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
@@ -1056,7 +1079,7 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
 			WARN_ON_ONCE(1);
 			return;
 		}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5f16263d176d..226f2f7cefd7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2311,8 +2311,6 @@ int follow_pte(struct mm_struct *mm, unsigned long address,
 	       pte_t **ptepp, spinlock_t **ptlp);
 int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	unsigned long *pfn);
-int follow_phys(struct vm_area_struct *vma, unsigned long address,
-		unsigned int flags, unsigned long *prot, resource_size_t *phys);
 int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 			void *buf, int len, int write);
 
diff --git a/mm/memory.c b/mm/memory.c
index 0adf23ea5416..93ad6b45f426 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5454,34 +5454,6 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 EXPORT_SYMBOL(follow_pfn);
 
 #ifdef CONFIG_HAVE_IOREMAP_PROT
-int follow_phys(struct vm_area_struct *vma,
-		unsigned long address, unsigned int flags,
-		unsigned long *prot, resource_size_t *phys)
-{
-	int ret = -EINVAL;
-	pte_t *ptep, pte;
-	spinlock_t *ptl;
-
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
-		goto out;
-
-	if (follow_pte(vma->vm_mm, address, &ptep, &ptl))
-		goto out;
-	pte = *ptep;
-
-	if ((flags & FOLL_WRITE) && !pte_write(pte))
-		goto unlock;
-
-	*prot = pgprot_val(pte_pgprot(pte));
-	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
-
-	ret = 0;
-unlock:
-	pte_unmap_unlock(ptep, ptl);
-out:
-	return ret;
-}
-
 /**
  * generic_access_phys - generic implementation for iomem mmap access
  * @vma: the vma to access
-- 
2.25.1

