Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C96AE1ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjCGONO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjCGOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:12:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C348736F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C30BB81900
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45E5C433EF;
        Tue,  7 Mar 2023 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198142;
        bh=vKxI+oe9fpy8fzPj2uKjjtIoIWIZL1hoi7ZQRmkNSz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxErkHaE8GoD+KVEsftvLI1sxxyJJUqZLJQkHZ6G2hiDP7UewjhE6CsXhPXRq9xJF
         nEfef0dpS6h9QtrM4Oltr0hnxbzjYo5yirmThX4R6Y3bVTgf7eeQDIL2NKqsq/NB+5
         ySyhpAWd2sl+Ni7byLtC6WhXimL9Xxxsl8RU+FQ8MMDjPkMJje0yC4C6t9Bw5OF4Hb
         6cGb3RvP4XHpXMTsv/hcgJyFoqxaeZ+zOwa692Xp76D7i6sV1SYZqCnL0+5g2i2/Hl
         ban3r82Z4g0g6jgW0C6pLU9xSfRr8xkfwoIPxZV8coEcDAmT4fIsBNH976zEqs42gp
         s6Q3fr007BMkA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 60/60] arm64: mm: add support for WXN memory translation attribute
Date:   Tue,  7 Mar 2023 15:05:22 +0100
Message-Id: <20230307140522.2311461-61-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10060; i=ardb@kernel.org; h=from:subject; bh=vKxI+oe9fpy8fzPj2uKjjtIoIWIZL1hoi7ZQRmkNSz4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdZdEjGUPpD4euRzm8rKmpLLG0u7KbXX966EEfozucs srO5nwdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJf7jIydCuKPhbquqopdvd8 r/X0pCtWvhXVbSkvdzcwX+n9sd/jBCNDp4pb9KKYd4FrtSY9KVfS2BFaLNb66IL95q6c4gkRIe7 MAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AArch64 virtual memory system supports a global WXN control, which
can be enabled to make all writable mappings implicitly no-exec. This is
a useful hardening feature, as it prevents mistakes in managing page
table permissions from being exploited to attack the system.

When enabled at EL1, the restrictions apply to both EL1 and EL0. EL1 is
completely under our control, and has been cleaned up to allow WXN to be
enabled from boot onwards. EL0 is not under our control, but given that
widely deployed security features such as selinux or PaX already limit
the ability of user space to create mappings that are writable and
executable at the same time, the impact of enabling this for EL0 is
expected to be limited. (For this reason, common user space libraries
that have a legitimate need for manipulating executable code already
carry fallbacks such as [0].)

If enabled at compile time, the feature can still be disabled at boot if
needed, by passing arm64.nowxn on the kernel command line.

[0] https://github.com/libffi/libffi/blob/master/src/closures.c#L440

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig                    | 11 ++++++
 arch/arm64/include/asm/cpufeature.h   | 10 ++++++
 arch/arm64/include/asm/mman.h         | 36 ++++++++++++++++++++
 arch/arm64/include/asm/mmu_context.h  | 30 +++++++++++++++-
 arch/arm64/kernel/pi/idreg-override.c |  4 ++-
 arch/arm64/kernel/pi/map_kernel.c     | 24 +++++++++++++
 arch/arm64/mm/proc.S                  |  6 ++++
 7 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 938fe1d090a5bb4e..4262f3f784696d94 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1552,6 +1552,17 @@ config RODATA_FULL_DEFAULT_ENABLED
 	  This requires the linear region to be mapped down to pages,
 	  which may adversely affect performance in some cases.
 
+config ARM64_WXN
+	bool "Enable WXN attribute so all writable mappings are non-exec"
+	help
+	  Set the WXN bit in the SCTLR system register so that all writable
+	  mappings are treated as if the PXN/UXN bit is set as well.
+	  If this is set to Y, it can still be disabled at runtime by
+	  passing 'arm64.nowxn' on the kernel command line.
+
+	  This should only be set if no software needs to be supported that
+	  relies on being able to execute from writable mappings.
+
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
 	help
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 170e18cb2b4faf11..9a5a373a3fda7f58 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -17,6 +17,7 @@
 
 #define ARM64_SW_FEATURE_OVERRIDE_NOKASLR	0
 #define ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF	4
+#define ARM64_SW_FEATURE_OVERRIDE_NOWXN		8
 
 #ifndef __ASSEMBLY__
 
@@ -932,6 +933,15 @@ extern struct arm64_ftr_override id_aa64isar2_override;
 
 extern struct arm64_ftr_override arm64_sw_feature_override;
 
+static inline bool arm64_wxn_enabled(void)
+{
+	if (!IS_ENABLED(CONFIG_ARM64_WXN) ||
+	    cpuid_feature_extract_unsigned_field(arm64_sw_feature_override.val,
+						 ARM64_SW_FEATURE_OVERRIDE_NOWXN))
+		return false;
+	return true;
+}
+
 u32 get_kvm_ipa_limit(void);
 void dump_cpu_features(void);
 
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a61542edf..6d4940342ba73060 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -35,11 +35,40 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
 }
 #define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
 
+static inline bool arm64_check_wx_prot(unsigned long prot,
+				       struct task_struct *tsk)
+{
+	/*
+	 * When we are running with SCTLR_ELx.WXN==1, writable mappings are
+	 * implicitly non-executable. This means we should reject such mappings
+	 * when user space attempts to create them using mmap() or mprotect().
+	 */
+	if (arm64_wxn_enabled() &&
+	    ((prot & (PROT_WRITE | PROT_EXEC)) == (PROT_WRITE | PROT_EXEC))) {
+		/*
+		 * User space libraries such as libffi carry elaborate
+		 * heuristics to decide whether it is worth it to even attempt
+		 * to create writable executable mappings, as PaX or selinux
+		 * enabled systems will outright reject it. They will usually
+		 * fall back to something else (e.g., two separate shared
+		 * mmap()s of a temporary file) on failure.
+		 */
+		pr_info_ratelimited(
+			"process %s (%d) attempted to create PROT_WRITE+PROT_EXEC mapping\n",
+			tsk->comm, tsk->pid);
+		return false;
+	}
+	return true;
+}
+
 static inline bool arch_validate_prot(unsigned long prot,
 	unsigned long addr __always_unused)
 {
 	unsigned long supported = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
 
+	if (!arm64_check_wx_prot(prot, current))
+		return false;
+
 	if (system_supports_bti())
 		supported |= PROT_BTI;
 
@@ -50,6 +79,13 @@ static inline bool arch_validate_prot(unsigned long prot,
 }
 #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
 
+static inline bool arch_validate_mmap_prot(unsigned long prot,
+					   unsigned long addr)
+{
+	return arm64_check_wx_prot(prot, current);
+}
+#define arch_validate_mmap_prot arch_validate_mmap_prot
+
 static inline bool arch_validate_flags(unsigned long vm_flags)
 {
 	if (!system_supports_mte())
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index bc1cef5002d60e02..910c6e009515745d 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -20,13 +20,41 @@
 #include <asm/cpufeature.h>
 #include <asm/daifflags.h>
 #include <asm/proc-fns.h>
-#include <asm-generic/mm_hooks.h>
 #include <asm/cputype.h>
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
 
 extern bool rodata_full;
 
+static inline int arch_dup_mmap(struct mm_struct *oldmm,
+				struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline void arch_exit_mmap(struct mm_struct *mm)
+{
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+			unsigned long start, unsigned long end)
+{
+}
+
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool execute, bool foreign)
+{
+	if (IS_ENABLED(CONFIG_ARM64_WXN) && execute &&
+	    (vma->vm_flags & (VM_WRITE | VM_EXEC)) == (VM_WRITE | VM_EXEC)) {
+		pr_warn_ratelimited(
+			"process %s (%d) attempted to execute from writable memory\n",
+			current->comm, current->pid);
+		/* disallow unless the nowxn override is set */
+		return !arm64_wxn_enabled();
+	}
+	return true;
+}
+
 static inline void contextidr_thread_switch(struct task_struct *next)
 {
 	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index c4ae5ffe5cb0c999..0ceec20669e50913 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -181,6 +181,7 @@ static const struct ftr_set_desc sw_features __prel64_initconst = {
 	.fields		= {
 		FIELD("nokaslr", ARM64_SW_FEATURE_OVERRIDE_NOKASLR, NULL),
 		FIELD("rodataoff", ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF, NULL),
+		FIELD("nowxn", ARM64_SW_FEATURE_OVERRIDE_NOWXN, NULL),
 		{}
 	},
 };
@@ -214,8 +215,9 @@ static const struct {
 	  "id_aa64isar2.gpa3=0 id_aa64isar2.apa3=0"	   },
 	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
 	{ "nokaslr",			"arm64_sw.nokaslr=1" },
-	{ "rodata=off",			"arm64_sw.rodataoff=1" },
+	{ "rodata=off",			"arm64_sw.rodataoff=1 arm64_sw.nowxn=1" },
 	{ "arm64.nolva",		"id_aa64mmfr2.varange=0" },
+	{ "arm64.nowxn",		"arm64_sw.nowxn=1" },
 };
 
 static int __init parse_hexdigit(const char *p, u64 *v)
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index a14b7c1236b5707c..2d02fa94e48c92e1 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -133,6 +133,25 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 	idmap_cpu_replace_ttbr1(swapper_pg_dir);
 }
 
+static void noinline __section(".idmap.text") disable_wxn(void)
+{
+	u64 sctlr = read_sysreg(sctlr_el1) & ~SCTLR_ELx_WXN;
+
+	/*
+	 * We cannot safely clear the WXN bit while the MMU and caches are on,
+	 * so turn the MMU off, flush the TLBs and turn it on again but with
+	 * the WXN bit cleared this time.
+	 */
+	asm("	msr	sctlr_el1, %0		;"
+	    "	isb				;"
+	    "	tlbi    vmalle1			;"
+	    "	dsb     nsh			;"
+	    "	isb				;"
+	    "	msr     sctlr_el1, %1		;"
+	    "	isb				;"
+	    ::	"r"(sctlr & ~SCTLR_ELx_M), "r"(sctlr));
+}
+
 static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttbr)
 {
 	u64 sctlr = read_sysreg(sctlr_el1);
@@ -230,6 +249,11 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 	if (va_bits > VA_BITS_MIN)
 		sysreg_clear_set(tcr_el1, TCR_T1SZ_MASK, TCR_T1SZ(va_bits));
 
+	if (IS_ENABLED(CONFIG_ARM64_WXN) &&
+	    cpuid_feature_extract_unsigned_field(arm64_sw_feature_override.val,
+						 ARM64_SW_FEATURE_OVERRIDE_NOWXN))
+		disable_wxn();
+
 	/*
 	 * The virtual KASLR displacement modulo 2MiB is decided by the
 	 * physical placement of the image, as otherwise, we might not be able
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 68f8337cd8bf6ab9..1df7a031bcb40341 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -516,6 +516,12 @@ alternative_else_nop_endif
 	 * Prepare SCTLR
 	 */
 	mov_q	x0, INIT_SCTLR_EL1_MMU_ON
+#ifdef CONFIG_ARM64_WXN
+	ldr_l	x1, arm64_sw_feature_override + FTR_OVR_VAL_OFFSET
+	tst	x1, #0xf << ARM64_SW_FEATURE_OVERRIDE_NOWXN
+	orr	x1, x0, #SCTLR_ELx_WXN
+	csel	x0, x0, x1, ne
+#endif
 	ret					// return to head.S
 
 	.unreq	mair
-- 
2.39.2

