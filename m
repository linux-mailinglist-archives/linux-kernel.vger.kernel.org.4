Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B536F14AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbjD1Jzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345882AbjD1JzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:55:18 -0400
Received: from out0-212.mail.aliyun.com (out0-212.mail.aliyun.com [140.205.0.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F86559A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:54:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---.STFoGiO_1682675636;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STFoGiO_1682675636)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:57 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "=?UTF-8?B?TWlrZSBSYXBvcG9ydCAoSUJNKQ==?=" <rppt@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>
Subject: [PATCH RFC 38/43] x86/fixmap: Move vsyscall page out of fixmap area
Date:   Fri, 28 Apr 2023 17:51:18 +0800
Message-Id: <f859494fba337ffc76a4fe74251ba5f8bff33f18.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
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

After mapping vsyscall page individually, vsyscall page could
be moved out of fixmap area.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/vsyscall/vsyscall_64.c |  4 ----
 arch/x86/include/asm/fixmap.h         | 17 +++++------------
 arch/x86/kernel/head_64.S             |  6 +++---
 arch/x86/mm/fault.c                   |  1 -
 arch/x86/mm/init_64.c                 |  2 +-
 5 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 4373460ebbde..f469f8dc36d4 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -35,7 +35,6 @@
 
 #include <asm/vsyscall.h>
 #include <asm/unistd.h>
-#include <asm/fixmap.h>
 #include <asm/traps.h>
 #include <asm/paravirt.h>
 
@@ -391,7 +390,4 @@ void __init map_vsyscall(void)
 
 	if (vsyscall_mode == XONLY)
 		vm_flags_init(&gate_vma, VM_EXEC);
-
-	BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=
-		     (unsigned long)VSYSCALL_ADDR);
 }
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index d0dcefb5cc59..eeb152ad9682 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -23,13 +23,13 @@
  * covered fully.
  */
 #ifndef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
-# define FIXMAP_PMD_NUM	2
+# define FIXMAP_PMD_NUM	1
 #else
 # define KM_PMDS	(KM_MAX_IDX * ((CONFIG_NR_CPUS + 511) / 512))
-# define FIXMAP_PMD_NUM (KM_PMDS + 2)
+# define FIXMAP_PMD_NUM (KM_PMDS + 1)
 #endif
-/* fixmap starts downwards from the 507th entry in level2_fixmap_pgt */
-#define FIXMAP_PMD_TOP	507
+/* fixmap starts downwards from the 506th entry in level2_fixmap_pgt */
+#define FIXMAP_PMD_TOP	506
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
@@ -38,8 +38,6 @@
 #include <asm/pgtable_types.h>
 #ifdef CONFIG_X86_32
 #include <linux/threads.h>
-#else
-#include <uapi/asm/vsyscall.h>
 #endif
 
 /*
@@ -55,8 +53,7 @@
 extern unsigned long __FIXADDR_TOP;
 #define FIXADDR_TOP	((unsigned long)__FIXADDR_TOP)
 #else
-#define FIXADDR_TOP	(round_up(VSYSCALL_ADDR + PAGE_SIZE, 1<<PMD_SHIFT) - \
-			 PAGE_SIZE)
+#define FIXADDR_TOP	(0xffffffffff600000UL - PAGE_SIZE)
 #endif
 
 /*
@@ -81,10 +78,6 @@ extern unsigned long __FIXADDR_TOP;
 enum fixed_addresses {
 #ifdef CONFIG_X86_32
 	FIX_HOLE,
-#else
-#ifdef CONFIG_X86_VSYSCALL_EMULATION
-	VSYSCALL_PAGE = (FIXADDR_TOP - VSYSCALL_ADDR) >> PAGE_SHIFT,
-#endif
 #endif
 	FIX_DBGP_BASE,
 	FIX_EARLYCON_MEM_BASE,
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 94c5defec8cc..19cb2852238b 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -659,15 +659,15 @@ SYM_DATA_START_PAGE_ALIGNED(level2_kernel_pgt)
 SYM_DATA_END(level2_kernel_pgt)
 
 SYM_DATA_START_PAGE_ALIGNED(level2_fixmap_pgt)
-	.fill	(512 - 4 - FIXMAP_PMD_NUM),8,0
+	.fill	(512 - 5 - FIXMAP_PMD_NUM),8,0
 	pgtno = 0
 	.rept (FIXMAP_PMD_NUM)
 	.quad level1_fixmap_pgt + (pgtno << PAGE_SHIFT) - __START_KERNEL_map \
 		+ _PAGE_TABLE_NOENC;
 	pgtno = pgtno + 1
 	.endr
-	/* 6 MB reserved space + a 2MB hole */
-	.fill	4,8,0
+	/* 2MB (with 4KB vsyscall page inside) + 6 MB reserved space + a 2MB hole */
+	.fill	5,8,0
 SYM_DATA_END(level2_fixmap_pgt)
 
 SYM_DATA_START_PAGE_ALIGNED(level1_fixmap_pgt)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7beb0ba6b2ec..548c0803d9f4 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -22,7 +22,6 @@
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
-#include <asm/fixmap.h>			/* VSYSCALL_ADDR		*/
 #include <asm/vsyscall.h>		/* emulate_vsyscall		*/
 #include <asm/vm86.h>			/* struct vm86			*/
 #include <asm/mmu_context.h>		/* vma_pkey()			*/
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a190aae8ceaf..b7fd05a1ba1d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -40,7 +40,7 @@
 #include <linux/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/dma.h>
-#include <asm/fixmap.h>
+#include <asm/vsyscall.h>
 #include <asm/e820/api.h>
 #include <asm/apic.h>
 #include <asm/tlb.h>
-- 
2.31.1

