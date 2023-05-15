Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12584702716
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjEOIYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjEOIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:22:15 -0400
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E005A10E7
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:20:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047192;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.T2DpdaM_1684138832;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.T2DpdaM_1684138832)
          by smtp.aliyun-inc.com;
          Mon, 15 May 2023 16:20:33 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juergen Gross" <jgross@suse.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>
Subject: [PATCH RFC 4/4] x86/fixmap: Unify FIXADDR_TOP
Date:   Mon, 15 May 2023 16:19:35 +0800
Message-Id: <681844dc69a3b746e92a685b706595bff7613481.1684137557.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
References: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since FIXADDR_TOP is unrelated to the vsyscall page now, it can be
declared as a variable for x86_64, thereby unifying it for x86.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/include/asm/fixmap.h | 13 -------------
 arch/x86/kernel/head64.c      |  1 -
 arch/x86/mm/dump_pagetables.c |  3 ++-
 arch/x86/mm/ioremap.c         |  5 ++---
 arch/x86/mm/pgtable.c         | 13 +++++++++++++
 arch/x86/mm/pgtable_32.c      |  3 ---
 6 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index eeb152ad9682..9433109e4853 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -40,21 +40,8 @@
 #include <linux/threads.h>
 #endif
 
-/*
- * We can't declare FIXADDR_TOP as variable for x86_64 because vsyscall
- * uses fixmaps that relies on FIXADDR_TOP for proper address calculation.
- * Because of this, FIXADDR_TOP x86 integration was left as later work.
- */
-#ifdef CONFIG_X86_32
-/*
- * Leave one empty page between vmalloc'ed areas and
- * the start of the fixmap.
- */
 extern unsigned long __FIXADDR_TOP;
 #define FIXADDR_TOP	((unsigned long)__FIXADDR_TOP)
-#else
-#define FIXADDR_TOP	(0xffffffffff600000UL - PAGE_SIZE)
-#endif
 
 /*
  * Here we define all the compile-time 'special' virtual
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 49f7629b17f7..34fc86e81872 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -485,7 +485,6 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
 	BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL));
 	MAYBE_BUILD_BUG_ON(!(((MODULES_END - 1) & PGDIR_MASK) ==
 				(__START_KERNEL & PGDIR_MASK)));
-	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
 
 	cr4_init_shadow();
 
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e1b599ecbbc2..df1a708a038a 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -104,7 +104,7 @@ static struct addr_marker address_markers[] = {
 	[HIGH_KERNEL_NR]	= { __START_KERNEL_map,	"High Kernel Mapping" },
 	[MODULES_VADDR_NR]	= { MODULES_VADDR,	"Modules" },
 	[MODULES_END_NR]	= { MODULES_END,	"End Modules" },
-	[FIXADDR_START_NR]	= { FIXADDR_START,	"Fixmap Area" },
+	[FIXADDR_START_NR]	= { 0UL,		"Fixmap Area" },
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
 
@@ -453,6 +453,7 @@ static int __init pt_dump_init(void)
 	address_markers[KASAN_SHADOW_START_NR].start_address = KASAN_SHADOW_START;
 	address_markers[KASAN_SHADOW_END_NR].start_address = KASAN_SHADOW_END;
 #endif
+	address_markers[FIXADDR_START_NR].start_address = FIXADDR_START;
 #endif
 #ifdef CONFIG_X86_32
 	address_markers[VMALLOC_START_NR].start_address = VMALLOC_START;
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index aa7d279321ea..44f9c6781c15 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -879,10 +879,9 @@ void __init early_ioremap_init(void)
 	pmd_t *pmd;
 
 #ifdef CONFIG_X86_64
-	BUILD_BUG_ON((fix_to_virt(0) + PAGE_SIZE) & ((1 << PMD_SHIFT) - 1));
-#else
-	WARN_ON((fix_to_virt(0) + PAGE_SIZE) & ((1 << PMD_SHIFT) - 1));
+	BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
 #endif
+	WARN_ON((fix_to_virt(0) + PAGE_SIZE) & ((1 << PMD_SHIFT) - 1));
 
 	early_ioremap_setup();
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e4f499eb0f29..2d73db9c7cbc 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -627,6 +627,19 @@ pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
 }
 #endif
 
+#ifdef CONFIG_X86_32
+/*
+ * Leave one empty page between vmalloc'ed areas and
+ * the start of the fixmap.
+ */
+#define __FIXADDR_TOP_BASE	0xfffff000
+#else
+#define __FIXADDR_TOP_BASE	(0xffffffffff600000UL - PAGE_SIZE)
+#endif
+
+unsigned long __FIXADDR_TOP = __FIXADDR_TOP_BASE;
+EXPORT_SYMBOL(__FIXADDR_TOP);
+
 /**
  * reserve_top_address - reserves a hole in the top of kernel address space
  * @reserve - size of hole to reserve
diff --git a/arch/x86/mm/pgtable_32.c b/arch/x86/mm/pgtable_32.c
index c234634e26ba..2b9a00976fee 100644
--- a/arch/x86/mm/pgtable_32.c
+++ b/arch/x86/mm/pgtable_32.c
@@ -65,9 +65,6 @@ void set_pte_vaddr(unsigned long vaddr, pte_t pteval)
 	flush_tlb_one_kernel(vaddr);
 }
 
-unsigned long __FIXADDR_TOP = 0xfffff000;
-EXPORT_SYMBOL(__FIXADDR_TOP);
-
 /*
  * vmalloc=size forces the vmalloc area to be exactly 'size'
  * bytes. This can be used to increase (or decrease) the
-- 
2.31.1

