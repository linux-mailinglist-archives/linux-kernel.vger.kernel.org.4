Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01135F27EE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 06:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJCEEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 00:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJCEEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 00:04:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768581DF07
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 21:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664769870; x=1696305870;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UB5cjKVsB4H26nWv1fTPcqnJR9cV/qO68D0Qc0DBJ0Y=;
  b=iiID7QFvSk+WRPJmLjBcjOij+hOOxQJ3ZGBFeS8TFJih8+cZlFy2HtrR
   EIVqHSpqldfRtAsuAccQNlgDXYXwfmY37/lIx1ySSPMKjTu7OGGrTLflK
   w/PdH8JlS1v1r6rOSWpkKhtd/sFw8bWjMxPAKM8Um1dsbOrvUjsCSj/PD
   f6hCHak1MnASaIknV3j8vdziEcspPZVZv2OnhKtw2cwkHZ4V6265VVNLM
   5jMyGVS6Ot3Q+vsZTbVYxjHHrCDMEzwLEppPgVjLrEj5Q9k7O46GTrYnb
   OVq2qC65CuLKJ/FGet1rUKCqbGC4IXB1h2fUsTeK973aMOB82yFEVV6/y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="289704178"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; 
   d="scan'208";a="289704178"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 21:04:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="625622175"
X-IronPort-AV: E=Sophos;i="5.93,364,1654585200"; 
   d="scan'208";a="625622175"
Received: from bkbuerkl-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.51.15])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 21:04:28 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] highmem: Fix kmap_to_page() for kmap_local_page() addresses
Date:   Sun,  2 Oct 2022 21:04:27 -0700
Message-Id: <20221003040427.1082050-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
I'm still working toward getting rid of kmap_to_page.[1]  But until then
this fix should be applied.

[1] https://lore.kernel.org/linux-mm/20221002002326.946620-1-ira.weiny@intel.com/
---
 mm/highmem.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index c707d7202d5f..29423c1afb3e 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -140,16 +140,45 @@ pte_t *pkmap_page_table;
 		do { spin_unlock(&kmap_lock); (void)(flags); } while (0)
 #endif
 
+static inline int kmap_local_calc_idx(int idx)
+{
+	return idx + KM_MAX_IDX * smp_processor_id();
+}
+
+#ifndef arch_kmap_local_map_idx
+#define arch_kmap_local_map_idx(idx, pfn)	kmap_local_calc_idx(idx)
+#endif
+
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
@@ -462,10 +491,6 @@ static inline void kmap_local_idx_pop(void)
 # define arch_kmap_local_post_unmap(vaddr)		do { } while (0)
 #endif
 
-#ifndef arch_kmap_local_map_idx
-#define arch_kmap_local_map_idx(idx, pfn)	kmap_local_calc_idx(idx)
-#endif
-
 #ifndef arch_kmap_local_unmap_idx
 #define arch_kmap_local_unmap_idx(idx, vaddr)	kmap_local_calc_idx(idx)
 #endif
@@ -494,11 +519,6 @@ static inline bool kmap_high_unmap_local(unsigned long vaddr)
 	return false;
 }
 
-static inline int kmap_local_calc_idx(int idx)
-{
-	return idx + KM_MAX_IDX * smp_processor_id();
-}
-
 static pte_t *__kmap_pte;
 
 static pte_t *kmap_get_pte(unsigned long vaddr, int idx)

base-commit: 274d7803837da78dfc911bcda0d593412676fc20
-- 
2.37.2

