Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A610B6420BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiLEA2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLEA22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:28:28 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4436911144;
        Sun,  4 Dec 2022 16:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670200107; x=1701736107;
  h=from:to:cc:subject:date:message-id;
  bh=ZimJ2YT8aZQnfEYHIFHtH8PzMXMZ8Iim/gsgYv7dtTE=;
  b=cAISHqtFY124yCpy7VvoCQfUV7oH0T64w4CRQ2HJoHyHM/Bb0j+x/wtV
   T0XxXSBN5DogQGY83QzxNiLj1ouAGEYjpTP58Snt1mIw+hqvnYW9z67gi
   nv7h6r8hI7oyd9T3N/4E4xYdxjwmjcZCh6njUfgZl0L3f0KHjxkTXSNI3
   wiKHqQ5fxBre/HwUVp1HJ8F+iv0S9OS3AlpTKZbK33YUZjc293m3jY7Ny
   KF6dKoylRNIIts/gdcKKOe6w6/N8ojEvCLcQwzaMmNS0TlnocrulwBlyj
   2oM1fMm8wppiGCFKKQLTx/bl21qs2HjP+wI2KoEQWb1SZSAXSb2ntYeOV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="313880497"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="313880497"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 16:28:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="639304976"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="639304976"
Received: from kartikka-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.241.109])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 16:28:25 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        rppt@kernel.org, peterz@infradead.org, luto@kernel.org
Cc:     rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] x86/hibernate: Use fixmap for saving unmapped pages
Date:   Sun,  4 Dec 2022 16:28:04 -0800
Message-Id: <20221205002804.21225-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Hi,

Since none of the module space allocation overhauls ever seem to go smoothly
and it may be awhile before VM_FLUSH_RESET_PERMS in not needed, I thought I
would try and fix up some of its deficiencies in the meantime. This is
pre-work for that, but I thought it was useful enough on it's own.

The testing was hacking up hibernate to load some data to a huge NP mapping
and making sure the data was there when it came back.

Thanks,

Rick

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
index 2a406753af90..ccf123b5019c 100644
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

