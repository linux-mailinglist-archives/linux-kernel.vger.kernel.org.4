Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30025F5FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJFEGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFEGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:06:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D32988A1A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 21:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665029166; x=1696565166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=odAs4dSBq7mP4T+DKtVrZI0lz9QUelG3wbSlf8i5IJ0=;
  b=WGwm5skEQHqL6BOIGUgIjdf2K4Hu/nLLXlRtnUBK877kDT4H+vzvOKus
   MmbEWk5BlB9+0MaKx7WLpdDTFNgGiyv/mjosNq6rYPn10G+8Tg2O9/hjQ
   +4PVlMizQyFS/h0K9HO6ZMO6rxKMw9/Jk0W+KLaQWFeCRdwhIOvbbpw6S
   r1MD1sagJufyOn7kJYA8S9BnE3LNhpbiTFquNFXzUgiZRzYnTSx/6xfUf
   rrlX/BTBekL7GudWUhj+z6FtHxi7fHYpCyFor3IeyycQEqxqVKe8AUgyn
   N4dW0b2hOwhVr3yVYfUbdQ+LObbRgq7JYnGlCzEdQaGXenczm+J8AedFP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="367465368"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="367465368"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 21:06:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="713685040"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="713685040"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.182.164])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 21:06:05 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] highmem: Fix kmap_to_page() for kmap_local_page() addresses
Date:   Wed,  5 Oct 2022 21:05:55 -0700
Message-Id: <20221006040555.1502679-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap_to_page() is used to get the page for a virtual address which may
be kmap'ed.  Unfortunately, kmap_local_page() stores mappings in a
thread local array separate from kmap().  These mappings were not
checked by the call.

Check the kmap_local_page() mappings and return the page if found.

Because it is intended to remove kmap_to_page() add a warn on once to
the kmap checks to flag potential issues early.

NOTE Due to 32bit x86 use of kmap local in iomap atmoic, KMAP_LOCAL does
not require HIGHMEM to be set.  Therefore the support calls required a
new KMAP_LOCAL section to fix 0day build errors.

Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	Fix 0day build errors.

I'm still working toward getting rid of kmap_to_page.[1]  But until then
this fix should be applied.

[1] https://lore.kernel.org/linux-mm/20221002002326.946620-1-ira.weiny@intel.com/
---
 mm/highmem.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index c707d7202d5f..529987b28205 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -30,6 +30,17 @@
 #include <asm/tlbflush.h>
 #include <linux/vmalloc.h>
 
+#ifdef CONFIG_KMAP_LOCAL
+static inline int kmap_local_calc_idx(int idx)
+{
+	return idx + KM_MAX_IDX * smp_processor_id();
+}
+
+#ifndef arch_kmap_local_map_idx
+#define arch_kmap_local_map_idx(idx, pfn)	kmap_local_calc_idx(idx)
+#endif
+#endif /* CONFIG_KMAP_LOCAL */
+
 /*
  * Virtual_count is not a pure "count".
  *  0 means that it is not mapped, and has not been mapped
@@ -142,14 +153,34 @@ pte_t *pkmap_page_table;
 
 struct page *__kmap_to_page(void *vaddr)
 {
+	unsigned long base = (unsigned long) vaddr & PAGE_MASK;
+	struct kmap_ctrl *kctrl = &current->kmap_ctrl;
 	unsigned long addr = (unsigned long)vaddr;
+	int i;
 
-	if (addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP)) {
+	/* kmap() mappings */
+	if (WARN_ON_ONCE(addr >= PKMAP_ADDR(0) &&
+			 addr < PKMAP_ADDR(LAST_PKMAP))) {
 		int i = PKMAP_NR(addr);
 
 		return pte_page(pkmap_page_table[i]);
 	}
 
+	/* kmap_local_page() mappings */
+	if (WARN_ON_ONCE(base >= __fix_to_virt(FIX_KMAP_END) &&
+			 base < __fix_to_virt(FIX_KMAP_BEGIN))) {
+		for (i = 0; i < kctrl->idx; i++) {
+			unsigned long base_addr;
+			int idx;
+
+			idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
+			base_addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+
+			if (base_addr == base)
+				return pte_page(kctrl->pteval[i]);
+		}
+	}
+
 	return virt_to_page(vaddr);
 }
 EXPORT_SYMBOL(__kmap_to_page);
@@ -462,10 +493,6 @@ static inline void kmap_local_idx_pop(void)
 # define arch_kmap_local_post_unmap(vaddr)		do { } while (0)
 #endif
 
-#ifndef arch_kmap_local_map_idx
-#define arch_kmap_local_map_idx(idx, pfn)	kmap_local_calc_idx(idx)
-#endif
-
 #ifndef arch_kmap_local_unmap_idx
 #define arch_kmap_local_unmap_idx(idx, vaddr)	kmap_local_calc_idx(idx)
 #endif
@@ -494,11 +521,6 @@ static inline bool kmap_high_unmap_local(unsigned long vaddr)
 	return false;
 }
 
-static inline int kmap_local_calc_idx(int idx)
-{
-	return idx + KM_MAX_IDX * smp_processor_id();
-}
-
 static pte_t *__kmap_pte;
 
 static pte_t *kmap_get_pte(unsigned long vaddr, int idx)
-- 
2.37.2

