Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547DD674B93
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjATFCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjATFBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:01:54 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EB2CC5D7;
        Thu, 19 Jan 2023 20:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674190166; x=1705726166;
  h=from:to:cc:subject:date:message-id;
  bh=MRaoQHl13vbKfYUOZLICSPqZK23aH07qLJtCBzzV2wo=;
  b=C0C1I5xriEW++3c7rTYfu8PvTco+aE9ZIw4uRGOpK7Po0JoCUq2CygcZ
   naW3meiQVIvchc+aH4ndt8TQTnJZ2gN6eGfSuZ1gwue4uboW3m6LJy/o2
   u6V2SVUTA70slAS3yQsvniuJJHm/zzOcba9PXZTmLBo9G/ydv33JqoLTp
   Emw1x5xbECOEiFZce95DBT8BsZqZHn7iMRC4eiFepDZ5Ll0OB36pax5M2
   MdUWuQYC3TCK2JvFAlEcrSqpNZIG2nBD19QOkkRj8wqquKwuMNIowZycS
   gsQmwJ9EOY5On/j+gOe+r6ZCOVbzyJb7E4v4uc1wk7Pno3o0qmrTM6VMe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="309042726"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="309042726"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 15:52:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="662317599"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="662317599"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 15:52:12 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        rppt@kernel.org, peterz@infradead.org, luto@kernel.org
Cc:     rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3] x86/hibernate: Use fixmap for saving unmapped pages
Date:   Thu, 19 Jan 2023 15:51:45 -0800
Message-Id: <20230119235145.22740-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

So create arch breakouts for hibernate_map_page() and
hibernate_unmap_page() so that the mapping of unmapped pages can be
off the direct map. Change hibernate_map_page() to return an address,
and implement an arch breakout on x86 on that uses the fixmap.

Since now hibernate_map_page() can return a value, have it return NULL
when the page fails to map, and have safe_copy_page() skip copying the
page if it fails to map. The existing behavior should crash in this case,
so this way there is a chance the system would be recoverable.

Use __weak for the arch breakout because there is not a suitable arch
specific header to use the #define method.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v3:
 - Switch from hib_copy_page() breakout to hibernate_un/map_page()
   breakouts.
 - Since there is an error to use now, skip copying for unmappable pages

v2:
 - Rebase

 arch/x86/include/asm/fixmap.h |  3 +++
 arch/x86/power/hibernate.c    | 12 ++++++++++++
 include/linux/suspend.h       |  2 ++
 kernel/power/snapshot.c       | 22 ++++++++++++++--------
 4 files changed, 31 insertions(+), 8 deletions(-)

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
index 6f955eb1e163..e7cde7cd529d 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -147,6 +147,18 @@ int arch_hibernation_header_restore(void *addr)
 	return 0;
 }
 
+long *hibernate_map_page(struct page *page)
+{
+	set_fixmap(FIX_HIBERNATE, page_to_phys(page));
+	__flush_tlb_all();
+	return (long *)fix_to_virt(FIX_HIBERNATE);
+}
+
+void hibernate_unmap_page(struct page *page)
+{
+	clear_fixmap(FIX_HIBERNATE);
+}
+
 int relocate_restore_code(void)
 {
 	pgd_t *pgd;
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cfe19a028918..a6c3f7dac9e1 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -447,6 +447,8 @@ extern bool hibernation_available(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
 int pfn_is_nosave(unsigned long pfn);
+long *hibernate_map_page(struct page *page);
+void hibernate_unmap_page(struct page *page);
 
 int hibernate_quiet_exec(int (*func)(void *data), void *data);
 #else /* CONFIG_HIBERNATION */
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index cd8b7b35f1e8..8cc16114da75 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -83,19 +83,18 @@ static inline void hibernate_restore_unprotect_page(void *page_address) {}
  * It is still worth to have a warning here if something changes and this
  * will no longer be the case.
  */
-static inline void hibernate_map_page(struct page *page)
+long * __weak hibernate_map_page(struct page *page)
 {
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
-		int ret = set_direct_map_default_noflush(page);
-
-		if (ret)
-			pr_warn_once("Failed to remap page\n");
+		if (set_direct_map_default_noflush(page))
+			return NULL;
 	} else {
 		debug_pagealloc_map_pages(page, 1);
 	}
+	return page_address(page);
 }
 
-static inline void hibernate_unmap_page(struct page *page)
+void __weak hibernate_unmap_page(struct page *page)
 {
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
 		unsigned long addr = (unsigned long)page_address(page);
@@ -1394,8 +1393,15 @@ static void safe_copy_page(void *dst, struct page *s_page)
 	if (kernel_page_present(s_page)) {
 		do_copy_page(dst, page_address(s_page));
 	} else {
-		hibernate_map_page(s_page);
-		do_copy_page(dst, page_address(s_page));
+		long *src = hibernate_map_page(s_page);
+
+		if (!src) {
+			pr_warn_once("Failed to remap page\n");
+			return;
+		}
+
+		do_copy_page(dst, src);
+
 		hibernate_unmap_page(s_page);
 	}
 }
-- 
2.17.1

