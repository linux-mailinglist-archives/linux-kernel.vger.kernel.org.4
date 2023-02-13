Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFC96954F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjBMXtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjBMXsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:48:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5DF16AC3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676332130; x=1707868130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0VB2hV8K9+oaRfBh3poIm3QeNRaII+t6ZBfZ5Dl8yyE=;
  b=IQd+0EVFYfo2a92OBFS/8dvOw28EEfuhirJPGo7Q/0pjm2WThJoXiTBM
   rynEnsHa+3aWp0g7subBRlp1qWc3wxeqoxTfcQEUj1LBHDDCxFuzCwmO7
   Rl2HmDqmLiyb3Udz5PoktUDhZFopCo4MsxwuLVgnUTMBzgYPFs48M3JBw
   pwq0iFbRLp42nRmlFURo13h/RtJ2F0Q9aGLykjOlD/XqOhhLar/8AB3Uk
   1X9wtjjpIpyIltF91lCZ+V+Cod71X3qrUJkqENlQe0dvKq8PX49LmVZEo
   uNuXc0zVBt6/aGKQcyyFh2vE0HISdWvNfaaoBMz94T+BMaNLqX5wjHwB7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="329658425"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="329658425"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:48:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668965313"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668965313"
Received: from iannetti-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.49.216])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:48:46 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6CEF710CA35; Tue, 14 Feb 2023 02:48:43 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/2] x86/tdx: Convert shared memory back to private on kexec
Date:   Tue, 14 Feb 2023 02:48:36 +0300
Message-Id: <20230213234836.3683-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX guests allocate shared buffers to perform I/O. It is done by
allocating pages normally from the buddy allocator and converting them
to shared with set_memory_decrypted().

The target kernel has no idea what memory is converted this way. It only
sees E820_TYPE_RAM.

Accessing shared memory via private mapping is fatal. It leads to
unrecoverable TD exit.

Walk direct mapping and convert all shared memory back to private.
It makes all RAM private again and target kernel may use it normally.

Skip the conversion on kexec of crashkernel. It uses own pool of memory
and will not accidentally allocate from the memory the first kernel made
shared.

For crash investigation, it might be useful to access data in the shared
buffers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/Makefile         |  1 +
 arch/x86/coco/tdx/kexec.c          | 82 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h         |  4 ++
 arch/x86/kernel/machine_kexec_64.c |  2 +
 4 files changed, 89 insertions(+)
 create mode 100644 arch/x86/coco/tdx/kexec.c

diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
index 46c55998557d..a5daa2a33531 100644
--- a/arch/x86/coco/tdx/Makefile
+++ b/arch/x86/coco/tdx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y += tdx.o tdcall.o
+obj-$(CONFIG_KEXEC_CORE) += kexec.o
diff --git a/arch/x86/coco/tdx/kexec.c b/arch/x86/coco/tdx/kexec.c
new file mode 100644
index 000000000000..f1f31515f372
--- /dev/null
+++ b/arch/x86/coco/tdx/kexec.c
@@ -0,0 +1,82 @@
+#define pr_fmt(fmt)  "tdx: " fmt
+
+#include <linux/pagewalk.h>
+#include <asm/tdx.h>
+#include <asm/x86_init.h>
+
+static inline bool pud_decrypted(pud_t pud)
+{
+	return cc_mkdec(pud_val(pud)) == pud_val(pud);
+}
+
+static inline bool pmd_decrypted(pmd_t pmd)
+{
+	return cc_mkdec(pmd_val(pmd)) == pmd_val(pmd);
+}
+
+static inline bool pte_decrypted(pte_t pte)
+{
+	return cc_mkdec(pte_val(pte)) == pte_val(pte);
+}
+
+static inline void unshare_range(unsigned long start, unsigned long end)
+{
+	int pages = (end - start) / PAGE_SIZE;
+
+	if (!x86_platform.guest.enc_status_change_finish(start, pages, true))
+		pr_err("Failed to unshare range %#lx-%#lx\n", start, end);
+}
+
+static int unshare_pud(pud_t *pud, unsigned long addr, unsigned long next,
+		       struct mm_walk *walk)
+{
+	if (pud_decrypted(*pud))
+		unshare_range(addr, next);
+
+	return 0;
+}
+
+static int unshare_pmd(pmd_t *pmd, unsigned long addr, unsigned long next,
+		       struct mm_walk *walk)
+{
+	if (pmd_decrypted(*pmd))
+		unshare_range(addr, next);
+
+	return 0;
+}
+
+static int unshare_pte(pte_t *pte, unsigned long addr, unsigned long next,
+		       struct mm_walk *walk)
+{
+	if (pte_decrypted(*pte))
+		unshare_range(addr, next);
+
+	return 0;
+}
+
+static const struct mm_walk_ops unshare_ops = {
+	.pud_entry = unshare_pud,
+	.pmd_entry = unshare_pmd,
+	.pte_entry = unshare_pte,
+};
+
+void tdx_kexec_prepare(bool crash)
+{
+	/*
+	 * Crash kernel may want to see data in the shared buffers.
+	 * Do not revert them to private on kexec of crash kernel.
+	 */
+	if (crash)
+		return;
+
+	/*
+	 * Walk direct mapping and convert all shared memory back to private,
+	 * so the target kernel will be able use it normally.
+	 */
+	mmap_write_lock(&init_mm);
+	walk_page_range_novma(&init_mm,
+			      PAGE_OFFSET,
+			      PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT),
+			      &unshare_ops, init_mm.pgd, NULL);
+	mmap_write_unlock(&init_mm);
+}
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 28d889c9aa16..7cdbf10e9f7d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -69,6 +69,8 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
 
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
+void tdx_kexec_prepare(bool crash);
+
 #else
 
 static inline void tdx_early_init(void) { };
@@ -76,6 +78,8 @@ static inline void tdx_safe_halt(void) { };
 
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
+static inline void tdx_kexec_prepare(bool crash) {}
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 0611fd83858e..adbb3e5347da 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/tdx.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -312,6 +313,7 @@ void machine_kexec(struct kimage *image)
 	local_irq_disable();
 	hw_breakpoint_disable();
 	cet_disable();
+	tdx_kexec_prepare(image->type == KEXEC_TYPE_CRASH);
 
 	if (image->preserve_context) {
 #ifdef CONFIG_X86_IO_APIC
-- 
2.39.1

