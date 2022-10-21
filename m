Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3362607F66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJUUBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJUUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:01:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD3125E88D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666382489; x=1697918489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KaF9e0WVFrqnnol9CO30O+x7LQt9U5cOhvA5BN7/yRs=;
  b=J2IcpiDQ1b2GhBT6r13xInTu+9MtO3hQ5vZmuWCSUUCrWeUHzJ/F/tyZ
   ufmzAUUyamv9wjsytXy0K4nZeLwmyml/R6NUULsU8JfrE87+RZ369OzQf
   7cFwP3JG5n80sv+UQ9b1/Tz2DmFY/5WhAgvXCZyq2K42TCg70dYiAQboz
   u5xR3DQ15ufMMjMO8LenHTbyTViqheJmCNwpQ/QoG6N6OtjeWEPAujzSC
   5DBYr13Wh8kbtDWW01nwBZloomcaVuzQBe/hA0qXuXNZqwSax/HUozylE
   ontfT8MhV4T7pBtfPV0z0H2NlE4r3jRmmsg9UY2BxBd4YFhaMa5qwOJOS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="290401088"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="290401088"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:01:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="633069088"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="633069088"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:01:27 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 1/2] mm, hwpoison: Try to recover from copy-on write faults
Date:   Fri, 21 Oct 2022 13:01:19 -0700
Message-Id: <20221021200120.175753-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021200120.175753-1-tony.luck@intel.com>
References: <20221019170835.155381-1-tony.luck@intel.com>
 <20221021200120.175753-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel is copying a page as the result of a copy-on-write
fault and runs into an uncorrectable error, Linux will crash because
it does not have recovery code for this case where poison is consumed
by the kernel.

It is easy to set up a test case. Just inject an error into a private
page, fork(2), and have the child process write to the page.

I wrapped that neatly into a test at:

  git://git.kernel.org/pub/scm/linux/kernel/git/aegl/ras-tools.git

just enable ACPI error injection and run:

  # ./einj_mem-uc -f copy-on-write

Add a new copy_user_highpage_mc() function that uses copy_mc_to_kernel()
on architectures where that is available (currently x86 and powerpc).
When an error is detected during the page copy, return VM_FAULT_HWPOISON
to caller of wp_page_copy(). This propagates up the call stack. Both x86
and powerpc have code in their fault handler to deal with this code by
sending a SIGBUS to the application.

Note that this patch avoids a system crash and signals the process that
triggered the copy-on-write action. It does not take any action for the
memory error that is still in the shared page. To handle that a call to
memory_failure() is needed. But this cannot be done from wp_page_copy()
because it holds mmap_lock(). Perhaps the architecture fault handlers
can deal with this loose end in a subsequent patch?

On Intel/x86 this loose end will often be handled automatically because
the memory controller provides an additional notification of the h/w
poison in memory, the handler for this will call memory_failure(). This
isn't a 100% solution. If there are multiple errors, not all may be
logged in this way.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Changes in V3:
    Dan Williams
	Rename copy_user_highpage_mc() to copy_mc_user_highpage() for
	consistency with Linus' discussion on names of functions that
	check for machine check.
	Write complete functions for the have/have-not copy_mc_to_kernel
	cases (so grep shows there are two versions)
	Change __wp_page_copy_user() to return 0 for success, negative for fail
	[I picked -EAGAIN for both non-EHWPOISON cases]

Changes in V2:
   Naoya Horiguchi:
	1) Use -EHWPOISON error code instead of minus one.
	2) Poison path needs also to deal with old_page
   Tony Luck:
	Rewrote commit message
	Added some powerpc folks to Cc: list
---
 include/linux/highmem.h | 24 ++++++++++++++++++++++++
 mm/memory.c             | 30 ++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index e9912da5441b..a32c64681f03 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -319,6 +319,30 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 
 #endif
 
+#ifdef copy_mc_to_kernel
+static inline int copy_mc_user_highpage(struct page *to, struct page *from,
+					unsigned long vaddr, struct vm_area_struct *vma)
+{
+	unsigned long ret;
+	char *vfrom, *vto;
+
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
+	ret = copy_mc_to_kernel(vto, vfrom, PAGE_SIZE);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
+
+	return ret;
+}
+#else
+static inline int copy_mc_user_highpage(struct page *to, struct page *from,
+					unsigned long vaddr, struct vm_area_struct *vma)
+{
+	copy_user_highpage(to, from, vaddr, vma);
+	return 0;
+}
+#endif
+
 #ifndef __HAVE_ARCH_COPY_HIGHPAGE
 
 static inline void copy_highpage(struct page *to, struct page *from)
diff --git a/mm/memory.c b/mm/memory.c
index f88c351aecd4..b6056eef2f72 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2848,10 +2848,16 @@ static inline int pte_unmap_same(struct vm_fault *vmf)
 	return same;
 }
 
-static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
-				       struct vm_fault *vmf)
+/*
+ * Return:
+ *	0:		copied succeeded
+ *	-EHWPOISON:	copy failed due to hwpoison in source page
+ *	-EAGAIN:	copied failed (some other reason)
+ */
+static inline int __wp_page_copy_user(struct page *dst, struct page *src,
+				      struct vm_fault *vmf)
 {
-	bool ret;
+	int ret;
 	void *kaddr;
 	void __user *uaddr;
 	bool locked = false;
@@ -2860,8 +2866,9 @@ static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		copy_user_highpage(dst, src, addr, vma);
-		return true;
+		if (copy_mc_user_highpage(dst, src, addr, vma))
+			return -EHWPOISON;
+		return 0;
 	}
 
 	/*
@@ -2888,7 +2895,7 @@ static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
 			 * and update local tlb only
 			 */
 			update_mmu_tlb(vma, addr, vmf->pte);
-			ret = false;
+			ret = -EAGAIN;
 			goto pte_unlock;
 		}
 
@@ -2913,7 +2920,7 @@ static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
 		if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 			/* The PTE changed under us, update local tlb */
 			update_mmu_tlb(vma, addr, vmf->pte);
-			ret = false;
+			ret = -EAGAIN;
 			goto pte_unlock;
 		}
 
@@ -2932,7 +2939,7 @@ static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
 		}
 	}
 
-	ret = true;
+	ret = 0;
 
 pte_unlock:
 	if (locked)
@@ -3104,6 +3111,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	pte_t entry;
 	int page_copied = 0;
 	struct mmu_notifier_range range;
+	int ret;
 
 	delayacct_wpcopy_start();
 
@@ -3121,19 +3129,21 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		if (!new_page)
 			goto oom;
 
-		if (!__wp_page_copy_user(new_page, old_page, vmf)) {
+		ret = __wp_page_copy_user(new_page, old_page, vmf);
+		if (ret) {
 			/*
 			 * COW failed, if the fault was solved by other,
 			 * it's fine. If not, userspace would re-fault on
 			 * the same address and we will handle the fault
 			 * from the second attempt.
+			 * The -EHWPOISON case will not be retried.
 			 */
 			put_page(new_page);
 			if (old_page)
 				put_page(old_page);
 
 			delayacct_wpcopy_end();
-			return 0;
+			return ret == -EHWPOISON ? VM_FAULT_HWPOISON : 0;
 		}
 		kmsan_copy_page_meta(new_page, old_page);
 	}
-- 
2.37.3

