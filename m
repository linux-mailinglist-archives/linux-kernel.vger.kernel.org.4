Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77DB724D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbjFFTnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbjFFTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:42:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E400710F1;
        Tue,  6 Jun 2023 12:42:38 -0700 (PDT)
Date:   Tue, 06 Jun 2023 19:42:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686080556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fM52UQkcDpk92Baf/OwlgNGecg59KFjNH5GQuduwu2w=;
        b=2FzTvQf/sCddyj+7+9N+DWe5M0Pptm0gz2HFqcrnz1jUarLoj7aj50uAEFJvgDhWS5lFgl
        1sF1LhbH6EBc6mtNaXtwpIAfUTPtvX3h1l5oHL8lvYUPq8X2Xo48Ghb1Z6NgwjRJ509G3R
        lcBtG2Ue2LidhbmdEVIeAp+wwGKM1eyeCm3Psxx2inyRhl2AF1Chamb/egt4iW47eLNZAN
        gf4JkiIIHNDUI9GzAwbCxWQdWc+CBn5TsYONKdt8B8zDwPcfOS5gY4O418acZHWPZUB3Ed
        Nd9gHrlA/+VTClLrFV1vp8+uKhm6fhqBeOh1d0PxAQg4dw7jdxyqq4HFbRw9NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686080556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fM52UQkcDpk92Baf/OwlgNGecg59KFjNH5GQuduwu2w=;
        b=1Tjvd4Ibm22zs42AV74zWZgJ0v+bBTWaDb0kSKk7vGAejRAGNQNmxmet6a0YCrrt2wA3So
        0wkPQ2fGa9hw/XCw==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/sev: Add SNP-specific unaccepted memory support
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca52fa69f460fd1876d70074b20ad68210dfc31dd=2E16860?=
 =?utf-8?q?63086=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Ca52fa69f460fd1876d70074b20ad68210dfc31dd=2E168606?=
 =?utf-8?q?3086=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <168608055616.404.2072660129740973125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     6c3211796326a9d35618b866826ca556c8f008a8
Gitweb:        https://git.kernel.org/tip/6c3211796326a9d35618b866826ca556c8f008a8
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Tue, 06 Jun 2023 09:51:26 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Jun 2023 18:31:37 +02:00

x86/sev: Add SNP-specific unaccepted memory support

Add SNP-specific hooks to the unaccepted memory support in the boot
path (__accept_memory()) and the core kernel (accept_memory()) in order
to support booting SNP guests when unaccepted memory is present. Without
this support, SNP guests will fail to boot and/or panic() when unaccepted
memory is present in the EFI memory map.

The process of accepting memory under SNP involves invoking the hypervisor
to perform a page state change for the page to private memory and then
issuing a PVALIDATE instruction to accept the page.

Since the boot path and the core kernel paths perform similar operations,
move the pvalidate_pages() and vmgexit_psc() functions into sev-shared.c
to avoid code duplication.

Create the new header file arch/x86/boot/compressed/sev.h because adding
the function declaration to any of the existing SEV related header files
pulls in too many other header files, causing the build to fail.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/a52fa69f460fd1876d70074b20ad68210dfc31dd.1686063086.git.thomas.lendacky@amd.com
---
 arch/x86/Kconfig                         |   2 +-
 arch/x86/boot/compressed/mem.c           |   3 +-
 arch/x86/boot/compressed/sev.c           |  54 ++++++++++-
 arch/x86/boot/compressed/sev.h           |  23 +++++-
 arch/x86/include/asm/sev.h               |   3 +-
 arch/x86/include/asm/unaccepted_memory.h |   3 +-
 arch/x86/kernel/sev-shared.c             | 103 ++++++++++++++++++++-
 arch/x86/kernel/sev.c                    | 112 ++--------------------
 8 files changed, 204 insertions(+), 99 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5c72067..b9c451f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1543,11 +1543,13 @@ config X86_MEM_ENCRYPT
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
+	depends on EFI_STUB
 	select DMA_COHERENT_POOL
 	select ARCH_USE_MEMREMAP_PROT
 	select INSTRUCTION_DECODER
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
+	select UNACCEPTED_MEMORY
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index f04b29f..3c16092 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -3,6 +3,7 @@
 #include "error.h"
 #include "misc.h"
 #include "tdx.h"
+#include "sev.h"
 #include <asm/shared/tdx.h>
 
 /*
@@ -37,6 +38,8 @@ void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 	if (early_is_tdx_guest()) {
 		if (!tdx_accept_memory(start, end))
 			panic("TDX: Failed to accept memory\n");
+	} else if (sev_snp_enabled()) {
+		snp_accept_memory(start, end);
 	} else {
 		error("Cannot accept memory: unknown platform\n");
 	}
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 014b89c..09dc8c1 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -115,7 +115,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
-static inline bool sev_snp_enabled(void)
+bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
@@ -181,6 +181,58 @@ static bool early_setup_ghcb(void)
 	return true;
 }
 
+static phys_addr_t __snp_accept_memory(struct snp_psc_desc *desc,
+				       phys_addr_t pa, phys_addr_t pa_end)
+{
+	struct psc_hdr *hdr;
+	struct psc_entry *e;
+	unsigned int i;
+
+	hdr = &desc->hdr;
+	memset(hdr, 0, sizeof(*hdr));
+
+	e = desc->entries;
+
+	i = 0;
+	while (pa < pa_end && i < VMGEXIT_PSC_MAX_ENTRY) {
+		hdr->end_entry = i;
+
+		e->gfn = pa >> PAGE_SHIFT;
+		e->operation = SNP_PAGE_STATE_PRIVATE;
+		if (IS_ALIGNED(pa, PMD_SIZE) && (pa_end - pa) >= PMD_SIZE) {
+			e->pagesize = RMP_PG_SIZE_2M;
+			pa += PMD_SIZE;
+		} else {
+			e->pagesize = RMP_PG_SIZE_4K;
+			pa += PAGE_SIZE;
+		}
+
+		e++;
+		i++;
+	}
+
+	if (vmgexit_psc(boot_ghcb, desc))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	pvalidate_pages(desc);
+
+	return pa;
+}
+
+void snp_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct snp_psc_desc desc = {};
+	unsigned int i;
+	phys_addr_t pa;
+
+	if (!boot_ghcb && !early_setup_ghcb())
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	pa = start;
+	while (pa < end)
+		pa = __snp_accept_memory(&desc, pa, end);
+}
+
 void sev_es_shutdown_ghcb(void)
 {
 	if (!boot_ghcb)
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
new file mode 100644
index 0000000..fc725a9
--- /dev/null
+++ b/arch/x86/boot/compressed/sev.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD SEV header for early boot related functions.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef BOOT_COMPRESSED_SEV_H
+#define BOOT_COMPRESSED_SEV_H
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+
+bool sev_snp_enabled(void);
+void snp_accept_memory(phys_addr_t start, phys_addr_t end);
+
+#else
+
+static inline bool sev_snp_enabled(void) { return false; }
+static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
+
+#endif
+
+#endif
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e21e1c5..86e1296 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -206,6 +206,7 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
+void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -229,6 +230,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
+
+static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index 572514e..f5937e9 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -3,6 +3,7 @@
 
 #include <linux/efi.h>
 #include <asm/tdx.h>
+#include <asm/sev.h>
 
 static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
@@ -10,6 +11,8 @@ static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		if (!tdx_accept_memory(start, end))
 			panic("TDX: Failed to accept memory\n");
+	} else if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		snp_accept_memory(start, end);
 	} else {
 		panic("Cannot accept memory: unknown platform\n");
 	}
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 3a5b0c9..2eabccd 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -12,6 +12,9 @@
 #ifndef __BOOT_COMPRESSED
 #define error(v)	pr_err(v)
 #define has_cpuflag(f)	boot_cpu_has(f)
+#else
+#undef WARN
+#define WARN(condition, format...) (!!(condition))
 #endif
 
 /* I/O parameters for CPUID-related helpers */
@@ -991,3 +994,103 @@ static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 			cpuid_ext_range_max = fn->eax;
 	}
 }
+
+static void pvalidate_pages(struct snp_psc_desc *desc)
+{
+	struct psc_entry *e;
+	unsigned long vaddr;
+	unsigned int size;
+	unsigned int i;
+	bool validate;
+	int rc;
+
+	for (i = 0; i <= desc->hdr.end_entry; i++) {
+		e = &desc->entries[i];
+
+		vaddr = (unsigned long)pfn_to_kaddr(e->gfn);
+		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
+		validate = e->operation == SNP_PAGE_STATE_PRIVATE;
+
+		rc = pvalidate(vaddr, size, validate);
+		if (rc == PVALIDATE_FAIL_SIZEMISMATCH && size == RMP_PG_SIZE_2M) {
+			unsigned long vaddr_end = vaddr + PMD_SIZE;
+
+			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
+				rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
+				if (rc)
+					break;
+			}
+		}
+
+		if (rc) {
+			WARN(1, "Failed to validate address 0x%lx ret %d", vaddr, rc);
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+		}
+	}
+}
+
+static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
+{
+	int cur_entry, end_entry, ret = 0;
+	struct snp_psc_desc *data;
+	struct es_em_ctxt ctxt;
+
+	vc_ghcb_invalidate(ghcb);
+
+	/* Copy the input desc into GHCB shared buffer */
+	data = (struct snp_psc_desc *)ghcb->shared_buffer;
+	memcpy(ghcb->shared_buffer, desc, min_t(int, GHCB_SHARED_BUF_SIZE, sizeof(*desc)));
+
+	/*
+	 * As per the GHCB specification, the hypervisor can resume the guest
+	 * before processing all the entries. Check whether all the entries
+	 * are processed. If not, then keep retrying. Note, the hypervisor
+	 * will update the data memory directly to indicate the status, so
+	 * reference the data->hdr everywhere.
+	 *
+	 * The strategy here is to wait for the hypervisor to change the page
+	 * state in the RMP table before guest accesses the memory pages. If the
+	 * page state change was not successful, then later memory access will
+	 * result in a crash.
+	 */
+	cur_entry = data->hdr.cur_entry;
+	end_entry = data->hdr.end_entry;
+
+	while (data->hdr.cur_entry <= data->hdr.end_entry) {
+		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
+
+		/* This will advance the shared buffer data points to. */
+		ret = sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
+
+		/*
+		 * Page State Change VMGEXIT can pass error code through
+		 * exit_info_2.
+		 */
+		if (WARN(ret || ghcb->save.sw_exit_info_2,
+			 "SNP: PSC failed ret=%d exit_info_2=%llx\n",
+			 ret, ghcb->save.sw_exit_info_2)) {
+			ret = 1;
+			goto out;
+		}
+
+		/* Verify that reserved bit is not set */
+		if (WARN(data->hdr.reserved, "Reserved bit is set in the PSC header\n")) {
+			ret = 1;
+			goto out;
+		}
+
+		/*
+		 * Sanity check that entry processing is not going backwards.
+		 * This will happen only if hypervisor is tricking us.
+		 */
+		if (WARN(data->hdr.end_entry > end_entry || cur_entry > data->hdr.cur_entry,
+"SNP: PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
+			 end_entry, data->hdr.end_entry, cur_entry, data->hdr.cur_entry)) {
+			ret = 1;
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 17b3d00..ea2546e 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -657,38 +657,6 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void pvalidate_pages(struct snp_psc_desc *desc)
-{
-	struct psc_entry *e;
-	unsigned long vaddr;
-	unsigned int size;
-	unsigned int i;
-	bool validate;
-	int rc;
-
-	for (i = 0; i <= desc->hdr.end_entry; i++) {
-		e = &desc->entries[i];
-
-		vaddr = (unsigned long)pfn_to_kaddr(e->gfn);
-		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
-		validate = e->operation == SNP_PAGE_STATE_PRIVATE;
-
-		rc = pvalidate(vaddr, size, validate);
-		if (rc == PVALIDATE_FAIL_SIZEMISMATCH && size == RMP_PG_SIZE_2M) {
-			unsigned long vaddr_end = vaddr + PMD_SIZE;
-
-			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
-				rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
-				if (rc)
-					break;
-			}
-		}
-
-		if (WARN(rc, "Failed to validate address 0x%lx ret %d", vaddr, rc))
-			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
-	}
-}
-
 static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 				  unsigned long npages, enum psc_op op)
 {
@@ -796,72 +764,6 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 		WARN(1, "invalid memory op %d\n", op);
 }
 
-static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
-{
-	int cur_entry, end_entry, ret = 0;
-	struct snp_psc_desc *data;
-	struct es_em_ctxt ctxt;
-
-	vc_ghcb_invalidate(ghcb);
-
-	/* Copy the input desc into GHCB shared buffer */
-	data = (struct snp_psc_desc *)ghcb->shared_buffer;
-	memcpy(ghcb->shared_buffer, desc, min_t(int, GHCB_SHARED_BUF_SIZE, sizeof(*desc)));
-
-	/*
-	 * As per the GHCB specification, the hypervisor can resume the guest
-	 * before processing all the entries. Check whether all the entries
-	 * are processed. If not, then keep retrying. Note, the hypervisor
-	 * will update the data memory directly to indicate the status, so
-	 * reference the data->hdr everywhere.
-	 *
-	 * The strategy here is to wait for the hypervisor to change the page
-	 * state in the RMP table before guest accesses the memory pages. If the
-	 * page state change was not successful, then later memory access will
-	 * result in a crash.
-	 */
-	cur_entry = data->hdr.cur_entry;
-	end_entry = data->hdr.end_entry;
-
-	while (data->hdr.cur_entry <= data->hdr.end_entry) {
-		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
-
-		/* This will advance the shared buffer data points to. */
-		ret = sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
-
-		/*
-		 * Page State Change VMGEXIT can pass error code through
-		 * exit_info_2.
-		 */
-		if (WARN(ret || ghcb->save.sw_exit_info_2,
-			 "SNP: PSC failed ret=%d exit_info_2=%llx\n",
-			 ret, ghcb->save.sw_exit_info_2)) {
-			ret = 1;
-			goto out;
-		}
-
-		/* Verify that reserved bit is not set */
-		if (WARN(data->hdr.reserved, "Reserved bit is set in the PSC header\n")) {
-			ret = 1;
-			goto out;
-		}
-
-		/*
-		 * Sanity check that entry processing is not going backwards.
-		 * This will happen only if hypervisor is tricking us.
-		 */
-		if (WARN(data->hdr.end_entry > end_entry || cur_entry > data->hdr.cur_entry,
-"SNP: PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
-			 end_entry, data->hdr.end_entry, cur_entry, data->hdr.cur_entry)) {
-			ret = 1;
-			goto out;
-		}
-	}
-
-out:
-	return ret;
-}
-
 static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 				       unsigned long vaddr_end, int op)
 {
@@ -966,6 +868,20 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+void snp_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long vaddr;
+	unsigned int npages;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	vaddr = (unsigned long)__va(start);
+	npages = (end - start) >> PAGE_SHIFT;
+
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
+}
+
 static int snp_set_vmsa(void *va, bool vmsa)
 {
 	u64 attrs;
