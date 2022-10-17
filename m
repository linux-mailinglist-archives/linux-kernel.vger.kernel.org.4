Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D797601DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJQXmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJQXmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:42:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD5B82D0B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666050131; x=1697586131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QlcB0A8sTz9XVjgWdXeFTBjKtTBN2eNlnDD0YUJo+2c=;
  b=MXGNi+KDgUy+gQwpOSKYC9qv10bTo8+bG6xQqsFxrAKjZ/SQ9DKSTc5v
   WYijuFn2IjqLu+h384++Zd1Eu0mEMoYcmvViGN4FME8rZdcDkBEA7mOg0
   KdBs5Z9U0pp87KVIzwoYrQYdPTLD3Ppx4kyiSWn1NUff16yhOw/ZBhZtj
   MWU3jt7YNA9YzxMHmryzRL91crqDpkvxbAVLJxxKYHSO45D2hp2ATTUCh
   fxnpjUOCo/vvnZofmiZo7W0mO1iHypBADNPsIkItHFabzgwtR6l2Srytt
   wlxldcuhOchcKHVNQUaH7va+Eczg5r5MNYb1Cs+DsJuiYWlP7qfIjPuwp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="392249229"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="392249229"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 16:42:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="606304946"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="606304946"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 16:42:10 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH] mm, hwpoison: Recover from copy-on-write machine checks
Date:   Mon, 17 Oct 2022 16:42:03 -0700
Message-Id: <20221017234203.103666-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

[Note this test needs some better reporting for the case where this
patch has been applied and the system does NOT crash]

Patch below works ... but there are probably many places where it could
fit better into the general "mm" way of doing things. E.g. using the
copy_mc_to_kernel() function does what I need here, but the name doesn't
seem like it is quite right.

Basic idea is very simple ... if the kernel gets a machine check copying
the page, just free up the new page that was going to be the target of
the copy and return VM_FAULT_HWPOISON to the calling stack.

Slightly-signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/highmem.h | 19 +++++++++++++++++++
 mm/memory.c             | 28 ++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index e9912da5441b..5967541fbf0e 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -319,6 +319,25 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 
 #endif
 
+static inline int copy_user_highpage_mc(struct page *to, struct page *from,
+					unsigned long vaddr, struct vm_area_struct *vma)
+{
+	unsigned long ret = 0;
+#ifdef copy_mc_to_kernel
+	char *vfrom, *vto;
+
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
+	ret = copy_mc_to_kernel(vto, vfrom, PAGE_SIZE);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
+#else
+	copy_user_highpage(to, from, vaddr, vma);
+#endif
+
+	return ret;
+}
+
 #ifndef __HAVE_ARCH_COPY_HIGHPAGE
 
 static inline void copy_highpage(struct page *to, struct page *from)
diff --git a/mm/memory.c b/mm/memory.c
index f88c351aecd4..b5e22bf4c10a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2848,8 +2848,14 @@ static inline int pte_unmap_same(struct vm_fault *vmf)
 	return same;
 }
 
-static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
-				       struct vm_fault *vmf)
+/*
+ * Return:
+ *	-1 = copy failed due to poison in source page
+ *	0 = copied failed (some other reason)
+ *	1 = copied succeeded
+ */
+static inline int __wp_page_copy_user(struct page *dst, struct page *src,
+				      struct vm_fault *vmf)
 {
 	bool ret;
 	void *kaddr;
@@ -2860,8 +2866,9 @@ static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		copy_user_highpage(dst, src, addr, vma);
-		return true;
+		if (copy_user_highpage_mc(dst, src, addr, vma))
+			return -1;
+		return 1;
 	}
 
 	/*
@@ -2888,7 +2895,7 @@ static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
 			 * and update local tlb only
 			 */
 			update_mmu_tlb(vma, addr, vmf->pte);
-			ret = false;
+			ret = 0;
 			goto pte_unlock;
 		}
 
@@ -2913,7 +2920,7 @@ static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
 		if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 			/* The PTE changed under us, update local tlb */
 			update_mmu_tlb(vma, addr, vmf->pte);
-			ret = false;
+			ret = 0;
 			goto pte_unlock;
 		}
 
@@ -2932,7 +2939,7 @@ static inline bool __wp_page_copy_user(struct page *dst, struct page *src,
 		}
 	}
 
-	ret = true;
+	ret = 1;
 
 pte_unlock:
 	if (locked)
@@ -3104,6 +3111,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	pte_t entry;
 	int page_copied = 0;
 	struct mmu_notifier_range range;
+	int ret;
 
 	delayacct_wpcopy_start();
 
@@ -3121,7 +3129,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		if (!new_page)
 			goto oom;
 
-		if (!__wp_page_copy_user(new_page, old_page, vmf)) {
+		ret = __wp_page_copy_user(new_page, old_page, vmf);
+		if (ret == -1) {
+			put_page(new_page);
+			return VM_FAULT_HWPOISON;
+		} else if (ret == 0) {
 			/*
 			 * COW failed, if the fault was solved by other,
 			 * it's fine. If not, userspace would re-fault on
-- 
2.37.3

