Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0978F6035D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJRWZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJRWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:25:12 -0400
Received: from smtpcmd0987.aruba.it (smtpcmd0987.aruba.it [62.149.156.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7E7D42E72
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:25:07 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kv1EovliYaWj1kv1EoELA7; Wed, 19 Oct 2022 00:25:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666131907; bh=ecGKETr6tHYjYHpQVgivf0BPNu10d7Tim6n0Zf2+ae8=;
        h=From:To:Subject:Date:MIME-Version;
        b=KWN5bUrbvitA1vzV0g/ooksAWbSRhEteGWEaaNfZEEHepIiJTOltLHJd2aLmSWFf/
         XoFgJDEGfA9mGzs7tZ0gReRjcV9sxYGwkMbHix1Lc3h9QuheSfAn/ZSJAlvu9RS1IV
         jzsg5qyKUg/fThoYyWIgmnC8b1+3oAH/RZR8DFL40jxcXASD9TF7NBWdBY2teOgVb2
         8nkIEUuIsumtjGcypPxOCtZz+vHUhG8m6THC0pD+Q40OpXVdzRLdidW2Bq5IV8gsoj
         TUVsOb8BbMHlOpA2fcCNDWHdxXmQD+gTi2VTeqYprohSGDacFkW5+gxXDwIntqxiDa
         SlNl2pKycC0Bg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 1/2] ARM: mm: fix no-MMU ZERO_PAGE() implementation
Date:   Wed, 19 Oct 2022 00:25:02 +0200
Message-Id: <20221018222503.90118-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPZlKIhA9QmVEJg8TyQBw3iOkBHZPOM6fAPP7UVSbA59v5ex4MI480bxgNdmo8uHnNiksDWqvpGUvjzux5YgGrteQPR5O48noLtBaTn1TidfdU+mLXi/
 FFtW/XkJQDDRzYNqBcP6279UyKprwgLo3h5hGUB2sfHoYxuhC8MpaLZy9WTMmtwSsSBHv/Wa19QXWDMy9MWX7lGH862VbgubxMzq55a3PtL4HadLBBpjxxPf
 MzfXXUphB7jB5T7JVxZf9Nl6/ch6X3KpE3T00QtMyr1EJm9ATRYwfOYkkmMhx3Dha4DBBMJlVD7ClieCQKKu5XfjYGeLYjfl0mFtha9uUEM6KtvVaP4d/JZ+
 LxiNlwaXaEeQ017keBant8uTh5J4txIvAB/z4TrTLyC18pEZfkAu3ubfDF6iL24AIdyF/LrA8FatnhlM+m6MpMezt0V9n1U0lOAcCBep2+a7US/j/iQZFlBu
 G1V7fNAJTLTe2e8Cb87lLxqv+3TCOnUYs5NaKR9GsYQ1T7a1ZgR5r7FGMAIA9TyC8LNCvSvzohoUY3KTmTbA5Vvmz7gJYU9dnnhVKhfUrRihsYgNRMgSg6D0
 38s=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually in no-MMU SoCs(i.e. i.MXRT) ZERO_PAGE(vaddr) expands to
```
virt_to_page(0)
```
that in order expands to:
```
pfn_to_page(virt_to_pfn(0))
```
and then virt_to_pfn(0) to:
```
#define virt_to_pfn(0) \
	((((unsigned long)(0) - PAGE_OFFSET) >> PAGE_SHIFT) + \
	 PHYS_PFN_OFFSET)
```
where PAGE_OFFSET and PHYS_PFN_OFFSET are the DRAM offset(0x80000000) and
PAGE_SHIFT is 12. This way we obtain 16MB(0x01000000) summed to the base of
DRAM(0x80000000).
When ZERO_PAGE(0) is then used, for example in bio_add_page(), the page
gets an address that is out of DRAM bounds.
So instead of using fake virtual page 0 let's allocate a dedicated
zero_page during paging_init() and assign it to a global 'struct page *
empty_zero_page' the same way mmu.c does and it's the same approach used
in m68k with commit dc068f462179 as discussed here[0]. Then let's move
ZERO_PAGE() definition to the top of pgtable.h to be in common between
mmu.c and nommu.c.

[0]: https://lore.kernel.org/linux-m68k/2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com/T/#m1266ceb63ad140743174d6b3070364d3c9a5179b

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* improve commit log as suggested by Arnd Bergmann
---
 arch/arm/include/asm/pgtable-nommu.h |  6 ------
 arch/arm/include/asm/pgtable.h       | 16 +++++++++-------
 arch/arm/mm/nommu.c                  | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
index d16aba48fa0a..090011394477 100644
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -44,12 +44,6 @@
 
 typedef pte_t *pte_addr_t;
 
-/*
- * ZERO_PAGE is a global shared page that is always zero: used
- * for zero-mapped memory areas etc..
- */
-#define ZERO_PAGE(vaddr)	(virt_to_page(0))
-
 /*
  * Mark the prot value as uncacheable and unbufferable.
  */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 78a532068fec..ef48a55e9af8 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -10,6 +10,15 @@
 #include <linux/const.h>
 #include <asm/proc-fns.h>
 
+#ifndef __ASSEMBLY__
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+extern struct page *empty_zero_page;
+#define ZERO_PAGE(vaddr)	(empty_zero_page)
+#endif
+
 #ifndef CONFIG_MMU
 
 #include <asm-generic/pgtable-nopud.h>
@@ -139,13 +148,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
  */
 
 #ifndef __ASSEMBLY__
-/*
- * ZERO_PAGE is a global shared page that is always zero: used
- * for zero-mapped memory areas etc..
- */
-extern struct page *empty_zero_page;
-#define ZERO_PAGE(vaddr)	(empty_zero_page)
-
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index c42debaded95..c1494a4dee25 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -26,6 +26,13 @@
 
 unsigned long vectors_base;
 
+/*
+ * empty_zero_page is a special page that is used for
+ * zero-initialized data and COW.
+ */
+struct page *empty_zero_page;
+EXPORT_SYMBOL(empty_zero_page);
+
 #ifdef CONFIG_ARM_MPU
 struct mpu_rgn_info mpu_rgn_info;
 #endif
@@ -148,9 +155,21 @@ void __init adjust_lowmem_bounds(void)
  */
 void __init paging_init(const struct machine_desc *mdesc)
 {
+	void *zero_page;
+
 	early_trap_init((void *)vectors_base);
 	mpu_setup();
+
+	/* allocate the zero page. */
+	zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+	if (!zero_page)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
+		      __func__, PAGE_SIZE, PAGE_SIZE);
+
 	bootmem_init();
+
+	empty_zero_page = virt_to_page(zero_page);
+	flush_dcache_page(empty_zero_page);
 }
 
 /*
-- 
2.34.1

