Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD4B664DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjAJVTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjAJVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:19:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3AA5F91B;
        Tue, 10 Jan 2023 13:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673385540; x=1704921540;
  h=from:to:cc:subject:date:message-id;
  bh=ulZlgG79EnzhO/at10rqu6ZjlmtW0C087vTovJIq3do=;
  b=Mtn1QaLMM2daTEsU/U/CM8E0g7liOIXjRR2qej48x8bp7bk2RoZHJUIw
   gnJ/K+/2k5wuCVRmiYFhD2Ai2+EgreyXVmFP0nmPB2ZiJPc8sY15Lv33b
   z2xe3EV2O56RsmjMagsVgGBNeKNItK3z35NOlpm6sQOqMItIn87DMjdUD
   xrf0qoA5RGJkM/Gbknf+LgYM6fDEycW6cwKWKQ3p2m9erAlwrInm26ggZ
   LoK+Ao5d1gFG5v55pKGeHvt45zd7GNXUS4iQBHuMB8/yTyiX/ElghOG7Z
   wEKh68HeOhPsXgH/mHAfOKcqt6TLpYuBoUk4rgJ2Dv0gowXDpkFU7IXlb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321963123"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="321963123"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 13:18:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720485160"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="720485160"
Received: from anupumpa-mobl3.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.91.157])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 13:18:58 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        rppt@kernel.org, peterz@infradead.org, luto@kernel.org
Cc:     rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2] x86/hibernate: Use fixmap for saving unmapped pages
Date:   Tue, 10 Jan 2023 13:18:39 -0800
Message-Id: <20230110211839.19572-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hibernate uses the direct map to read memory it saves to disk. Since
sometimes pages are not accessible on the direct map ("not present" on
x86), it has special case logic to temporarily make a page present. On x86
these direct map addresses can be mapped at various page sizes, but the
logic works ok as long as the not present pages are always mapped as
PAGE_SIZE such that they don't require a split to map the region as
present. If the address was mapped not present by a larger page size, the
split may fail and hibernate would then try to read an address mapped not
present.

Today on x86 there are no known cases of this (huge not present pages on
the direct map), but it has come up from time to time when developing
things that operate on the direct map. It blocked making
VM_FLUSH_RESET_PERMS support huge vmalloc when that came up, and also
has been a complication for various direct map protection efforts.

This dependency is also pretty hidden and easily missed by people poking at
the direct map. For this reason, there are warnings in place to complain
but not handle this scenario.

One way to make this more robust would be to create some new CPA
functionality that can know to map and reset the whole huge page in the
case of trying to map a subpage. But for simplicity and smaller code, just
make x86 hibernate have its own fixmap PTE that it can use to point
to 4k pages when it encounters an unmapped direct map page.

Move do_copy_page() to a header such that it can be used in an arch
breakout. Rename it hib_copy_page() to be more hibernate specific since
it could appear in other files.

Use __weak for the arch breakout because there is not a suitable arch
specific header to use the #define method.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

Rebase to v6.2-rc3 (original still applied) and resending per:
https://lore.kernel.org/lkml/CAJZ5v0i6cxGD+V6G+q-Y_Lp-ov51_zmkZr8ZGpCtqWV-e=BsLg@mail.gmail.com/

 arch/x86/include/asm/fixmap.h |  3 +++
 arch/x86/power/hibernate.c    | 10 ++++++++++
 include/linux/suspend.h       | 13 +++++++++++++
 kernel/power/snapshot.c       | 21 +++++++--------------
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index d0dcefb5cc59..0fceed9a4152 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -108,6 +108,9 @@ enum fixed_addresses {
 #ifdef CONFIG_PARAVIRT_XXL
 	FIX_PARAVIRT_BOOTMAP,
 #endif
+#ifdef CONFIG_HIBERNATION
+	FIX_HIBERNATE,
+#endif
 
 #ifdef CONFIG_ACPI_APEI_GHES
 	/* Used for GHES mapping from assorted contexts */
diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 6f955eb1e163..473b6b5f6b7e 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -147,6 +147,16 @@ int arch_hibernation_header_restore(void *addr)
 	return 0;
 }
 
+void copy_unmapped_page(void *dst, struct page *page)
+{
+	WARN_ON(!preempt_count());
+
+	set_fixmap(FIX_HIBERNATE, page_to_phys(page));
+	__flush_tlb_all();
+	hib_copy_page(dst, (void *)fix_to_virt(FIX_HIBERNATE));
+	clear_fixmap(FIX_HIBERNATE);
+}
+
 int relocate_restore_code(void)
 {
 	pgd_t *pgd;
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cfe19a028918..0b19b910526e 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -447,6 +447,19 @@ extern bool hibernation_available(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
 int pfn_is_nosave(unsigned long pfn);
+void copy_unmapped_page(void *dst, struct page *page);
+
+/*
+ * This is needed, because copy_page and memcpy are not usable for copying
+ * task structs.
+ */
+static inline void hib_copy_page(long *dst, long *src)
+{
+	int n;
+
+	for (n = PAGE_SIZE / sizeof(long); n; n--)
+		*dst++ = *src++;
+}
 
 int hibernate_quiet_exec(int (*func)(void *data), void *data);
 #else /* CONFIG_HIBERNATION */
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index cd8b7b35f1e8..344c071f29d3 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1369,16 +1369,11 @@ static unsigned int count_data_pages(void)
 	return n;
 }
 
-/*
- * This is needed, because copy_page and memcpy are not usable for copying
- * task structs.
- */
-static inline void do_copy_page(long *dst, long *src)
+void __weak copy_unmapped_page(void *dst, struct page *page)
 {
-	int n;
-
-	for (n = PAGE_SIZE / sizeof(long); n; n--)
-		*dst++ = *src++;
+	hibernate_map_page(page);
+	hib_copy_page(dst, page_address(page));
+	hibernate_unmap_page(page);
 }
 
 /**
@@ -1392,11 +1387,9 @@ static inline void do_copy_page(long *dst, long *src)
 static void safe_copy_page(void *dst, struct page *s_page)
 {
 	if (kernel_page_present(s_page)) {
-		do_copy_page(dst, page_address(s_page));
+		hib_copy_page(dst, page_address(s_page));
 	} else {
-		hibernate_map_page(s_page);
-		do_copy_page(dst, page_address(s_page));
-		hibernate_unmap_page(s_page);
+		copy_unmapped_page(dst, s_page);
 	}
 }
 
@@ -1417,7 +1410,7 @@ static void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 	if (PageHighMem(s_page)) {
 		src = kmap_atomic(s_page);
 		dst = kmap_atomic(d_page);
-		do_copy_page(dst, src);
+		hib_copy_page(dst, src);
 		kunmap_atomic(dst);
 		kunmap_atomic(src);
 	} else {
-- 
2.17.1

