Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3B1637DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKXQmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKXQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:42:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AB5171C9E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:41:58 -0800 (PST)
Received: from zn.tnic (p200300ea9733e75b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e75b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 928A91EC0380;
        Thu, 24 Nov 2022 17:41:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669308116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=3Qr0t5rgpiAGQm2Qn0yOKvOZkKfphcvYfhkGMrOwin4=;
        b=UzdKfWl6Jnu4rIgQCnLpA8H6YNnucdgKMIjNyplWx47hXFG0KdBjJGqvC/FlMi6zMCJ6yc
        sg2EOeilYFDq4LPMajs8P1kUx5RlD53FTDkCoi6yKhZnbxlFwjMYHDUfOxfOcVRAcd3q+c
        aUVWloY/5Rx6C95L4rdqTauhC+K+qno=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/cpuid: Carve out all CPUID functionality
Date:   Thu, 24 Nov 2022 17:41:50 +0100
Message-Id: <20221124164150.3040-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Carve it out into a special header, where it belongs.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cpuid.h     | 141 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/processor.h | 133 +----------------------------
 2 files changed, 140 insertions(+), 134 deletions(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 70b2db18165e..9bee3e7bf973 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -1,13 +1,132 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * CPUID-related helpers/definitions
- *
- * Derived from arch/x86/kvm/cpuid.c
  */
 
 #ifndef _ASM_X86_CPUID_H
 #define _ASM_X86_CPUID_H
 
+#include <asm/string.h>
+
+struct cpuid_regs {
+	u32 eax, ebx, ecx, edx;
+};
+
+enum cpuid_regs_idx {
+	CPUID_EAX = 0,
+	CPUID_EBX,
+	CPUID_ECX,
+	CPUID_EDX,
+};
+
+#ifdef CONFIG_X86_32
+extern int have_cpuid_p(void);
+#else
+static inline int have_cpuid_p(void)
+{
+	return 1;
+}
+#endif
+static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
+				unsigned int *ecx, unsigned int *edx)
+{
+	/* ecx is often an input as well as an output. */
+	asm volatile("cpuid"
+	    : "=a" (*eax),
+	      "=b" (*ebx),
+	      "=c" (*ecx),
+	      "=d" (*edx)
+	    : "0" (*eax), "2" (*ecx)
+	    : "memory");
+}
+
+#define native_cpuid_reg(reg)					\
+static inline unsigned int native_cpuid_##reg(unsigned int op)	\
+{								\
+	unsigned int eax = op, ebx, ecx = 0, edx;		\
+								\
+	native_cpuid(&eax, &ebx, &ecx, &edx);			\
+								\
+	return reg;						\
+}
+
+/*
+ * Native CPUID functions returning a single datum.
+ */
+native_cpuid_reg(eax)
+native_cpuid_reg(ebx)
+native_cpuid_reg(ecx)
+native_cpuid_reg(edx)
+
+#ifdef CONFIG_PARAVIRT_XXL
+#include <asm/paravirt.h>
+#else
+#define __cpuid			native_cpuid
+#endif
+
+/*
+ * Generic CPUID function
+ * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ * resulting in stale register contents being returned.
+ */
+static inline void cpuid(unsigned int op,
+			 unsigned int *eax, unsigned int *ebx,
+			 unsigned int *ecx, unsigned int *edx)
+{
+	*eax = op;
+	*ecx = 0;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/* Some CPUID calls want 'count' to be placed in ecx */
+static inline void cpuid_count(unsigned int op, int count,
+			       unsigned int *eax, unsigned int *ebx,
+			       unsigned int *ecx, unsigned int *edx)
+{
+	*eax = op;
+	*ecx = count;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/*
+ * CPUID functions returning a single datum
+ */
+static inline unsigned int cpuid_eax(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return eax;
+}
+
+static inline unsigned int cpuid_ebx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return ebx;
+}
+
+static inline unsigned int cpuid_ecx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return ecx;
+}
+
+static inline unsigned int cpuid_edx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+
+	return edx;
+}
+
 static __always_inline bool cpuid_function_is_indexed(u32 function)
 {
 	switch (function) {
@@ -31,4 +150,22 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 	return false;
 }
 
+#define for_each_possible_hypervisor_cpuid_base(function) \
+	for (function = 0x40000000; function < 0x40010000; function += 0x100)
+
+static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
+{
+	uint32_t base, eax, signature[3];
+
+	for_each_possible_hypervisor_cpuid_base(base) {
+		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
+
+		if (!memcmp(sig, signature, 12) &&
+		    (leaves == 0 || ((eax - base) >= leaves)))
+			return base;
+	}
+
+	return 0;
+}
+
 #endif /* _ASM_X86_CPUID_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67c9d73b31fa..6836c64b9819 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -16,6 +16,7 @@ struct vm86;
 #include <uapi/asm/sigcontext.h>
 #include <asm/current.h>
 #include <asm/cpufeatures.h>
+#include <asm/cpuid.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
 #include <asm/percpu.h>
@@ -146,17 +147,6 @@ struct cpuinfo_x86 {
 	unsigned		initialized : 1;
 } __randomize_layout;
 
-struct cpuid_regs {
-	u32 eax, ebx, ecx, edx;
-};
-
-enum cpuid_regs_idx {
-	CPUID_EAX = 0,
-	CPUID_EBX,
-	CPUID_ECX,
-	CPUID_EDX,
-};
-
 #define X86_VENDOR_INTEL	0
 #define X86_VENDOR_CYRIX	1
 #define X86_VENDOR_AMD		2
@@ -205,45 +195,6 @@ extern void identify_secondary_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 void print_cpu_msr(struct cpuinfo_x86 *);
 
-#ifdef CONFIG_X86_32
-extern int have_cpuid_p(void);
-#else
-static inline int have_cpuid_p(void)
-{
-	return 1;
-}
-#endif
-static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
-				unsigned int *ecx, unsigned int *edx)
-{
-	/* ecx is often an input as well as an output. */
-	asm volatile("cpuid"
-	    : "=a" (*eax),
-	      "=b" (*ebx),
-	      "=c" (*ecx),
-	      "=d" (*edx)
-	    : "0" (*eax), "2" (*ecx)
-	    : "memory");
-}
-
-#define native_cpuid_reg(reg)					\
-static inline unsigned int native_cpuid_##reg(unsigned int op)	\
-{								\
-	unsigned int eax = op, ebx, ecx = 0, edx;		\
-								\
-	native_cpuid(&eax, &ebx, &ecx, &edx);			\
-								\
-	return reg;						\
-}
-
-/*
- * Native CPUID functions returning a single datum.
- */
-native_cpuid_reg(eax)
-native_cpuid_reg(ebx)
-native_cpuid_reg(ecx)
-native_cpuid_reg(edx)
-
 /*
  * Friendlier CR3 helpers.
  */
@@ -578,7 +529,6 @@ static __always_inline bool on_thread_stack(void)
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
-#define __cpuid			native_cpuid
 
 static inline void load_sp0(unsigned long sp0)
 {
@@ -589,69 +539,6 @@ static inline void load_sp0(unsigned long sp0)
 
 unsigned long __get_wchan(struct task_struct *p);
 
-/*
- * Generic CPUID function
- * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
- * resulting in stale register contents being returned.
- */
-static inline void cpuid(unsigned int op,
-			 unsigned int *eax, unsigned int *ebx,
-			 unsigned int *ecx, unsigned int *edx)
-{
-	*eax = op;
-	*ecx = 0;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/* Some CPUID calls want 'count' to be placed in ecx */
-static inline void cpuid_count(unsigned int op, int count,
-			       unsigned int *eax, unsigned int *ebx,
-			       unsigned int *ecx, unsigned int *edx)
-{
-	*eax = op;
-	*ecx = count;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/*
- * CPUID functions returning a single datum
- */
-static inline unsigned int cpuid_eax(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return eax;
-}
-
-static inline unsigned int cpuid_ebx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return ebx;
-}
-
-static inline unsigned int cpuid_ecx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return ecx;
-}
-
-static inline unsigned int cpuid_edx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	return edx;
-}
-
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 extern void amd_e400_c1e_apic_setup(void);
 
@@ -805,24 +692,6 @@ static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
 #endif
 
-#define for_each_possible_hypervisor_cpuid_base(function) \
-	for (function = 0x40000000; function < 0x40010000; function += 0x100)
-
-static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
-{
-	uint32_t base, eax, signature[3];
-
-	for_each_possible_hypervisor_cpuid_base(base) {
-		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
-
-		if (!memcmp(sig, signature, 12) &&
-		    (leaves == 0 || ((eax - base) >= leaves)))
-			return base;
-	}
-
-	return 0;
-}
-
 extern unsigned long arch_align_stack(unsigned long sp);
 void free_init_pages(const char *what, unsigned long begin, unsigned long end);
 extern void free_kernel_image_pages(const char *what, void *begin, void *end);
-- 
2.35.1

