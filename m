Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DC06AE1D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCGOK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjCGOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CD0769C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8A8CB818F6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C6FC4339E;
        Tue,  7 Mar 2023 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198053;
        bh=v8v/TkqMB9OCCzVoe5QhdocYNnv3zbGgGyZ+eM5YmgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXT3451NNJDKpngopF9FhSnKez/+LmLSPb0f8C5FoGyHiY1+Jb69+bZvtp1qCM7fc
         6h/PPkb8iMbPpyNCPEQ28i0rF9EKsivkbqV+89rFdyIKAvqeq6io6GVm+qn/+bzhpe
         EEQR9gezKj65AX2z9Ed+6Jxnx+bRhxMNfto9BmSyfT21nRifPnh219yQmKdkrDoJC1
         87y83HBdyR8j45cLoR83hfIxIXcJpiFtTs7kRcoinzvTbHSuGUuR0+asJvTagEBwu9
         FcKCb3x2h9M4WStIdUnBsGkbWwBZKXDGnP6aC0e1zUp9gE8kOFqH0MD08iQw+aI3wr
         KcHXStRRKyYeA==
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
Subject: [PATCH v3 23/60] arm64: idreg-override: Move to early mini C runtime
Date:   Tue,  7 Mar 2023 15:04:45 +0100
Message-Id: <20230307140522.2311461-24-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6750; i=ardb@kernel.org; h=from:subject; bh=v8v/TkqMB9OCCzVoe5QhdocYNnv3zbGgGyZ+eM5YmgQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxXwxtwOb0Kwq3ab+mJWN9cyOTE29fnwzzT3XnbyqM vfK/GUdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJexxj+CjxZ6WQZ/KZuT4vD 1Js7VhyrXZEie8WsRmdjabj9Evkf3xgZdvgu++rzvuBa2kvH88debqy6Y9shLXdshcaz8Akf1kX 3cwMA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will want to parse the ID register overrides even earlier, so that we
can take them into account before creating the kernel mapping. So
migrate the code and make it work in the context of the early C runtime.
We will move the invocation to an earlier stage in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/Makefile                  |  4 +--
 arch/arm64/kernel/head.S                    |  5 ++-
 arch/arm64/kernel/image-vars.h              |  9 +++++
 arch/arm64/kernel/pi/Makefile               |  5 +--
 arch/arm64/kernel/{ => pi}/idreg-override.c | 38 ++++++++------------
 5 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index e27168d6ed2050b9..4f1fcaebafcfe077 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -33,8 +33,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
-			   syscall.o proton-pack.o idreg-override.o idle.o	\
-			   patching.o
+			   syscall.o proton-pack.o idle.o patching.o pi/
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
@@ -58,7 +57,6 @@ obj-$(CONFIG_ACPI)			+= acpi.o
 obj-$(CONFIG_ACPI_NUMA)			+= acpi_numa.o
 obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 obj-$(CONFIG_PARAVIRT)			+= paravirt.o
-obj-$(CONFIG_RELOCATABLE)		+= pi/
 obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
 obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 obj-$(CONFIG_ELF_CORE)			+= elfcore.o
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 5047a2952ec273f9..0fa44b3188c1e204 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -510,10 +510,9 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
-	mov	x0, x21				// pass FDT address in x0
-	bl	early_fdt_map			// Try mapping the FDT early
 	mov	x0, x20				// pass the full boot status
-	bl	init_feature_override		// Parse cpu feature overrides
+	mov	x1, x22				// pass the low FDT mapping
+	bl	__pi_init_feature_override	// Parse cpu feature overrides
 #ifdef CONFIG_UNWIND_PATCH_PAC_INTO_SCS
 	bl	scs_patch_vmlinux
 #endif
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index b5906f8e18d7eb8d..5aa914ea919a1149 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -35,6 +35,15 @@ PROVIDE(__pi___memmove			= __pi_memmove);
 PROVIDE(__pi___memset			= __pi_memset);
 
 PROVIDE(__pi_vabits_actual		= vabits_actual);
+PROVIDE(__pi_id_aa64isar1_override	= id_aa64isar1_override);
+PROVIDE(__pi_id_aa64isar2_override	= id_aa64isar2_override);
+PROVIDE(__pi_id_aa64mmfr1_override	= id_aa64mmfr1_override);
+PROVIDE(__pi_id_aa64pfr0_override	= id_aa64pfr0_override);
+PROVIDE(__pi_id_aa64pfr1_override	= id_aa64pfr1_override);
+PROVIDE(__pi_id_aa64smfr0_override	= id_aa64smfr0_override);
+PROVIDE(__pi_id_aa64zfr0_override	= id_aa64zfr0_override);
+PROVIDE(__pi_arm64_sw_feature_override	= arm64_sw_feature_override);
+PROVIDE(__pi__ctype			= _ctype);
 
 #ifdef CONFIG_KVM
 
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index d084c1dcf4165420..7f6dfce893c3b88f 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -38,6 +38,7 @@ $(obj)/lib-%.pi.o: OBJCOPYFLAGS += --prefix-alloc-sections=.init
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-obj-y				:= relocate.pi.o
-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr_early.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
+obj-y				:= idreg-override.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
+obj-$(CONFIG_RELOCATABLE)	+= relocate.pi.o
+obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr_early.pi.o
 extra-y				:= $(patsubst %.pi.o,%.o,$(obj-y))
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
similarity index 93%
rename from arch/arm64/kernel/idreg-override.c
rename to arch/arm64/kernel/pi/idreg-override.c
index 758f0e86e2bd2a34..4e76db6eb72c2087 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -14,6 +14,8 @@
 #include <asm/cpufeature.h>
 #include <asm/setup.h>
 
+#include "pi.h"
+
 #define FTR_DESC_NAME_LEN	20
 #define FTR_DESC_FIELD_LEN	10
 #define FTR_ALIAS_NAME_LEN	30
@@ -21,18 +23,6 @@
 
 static u64 __boot_status __initdata;
 
-// temporary __prel64 related definitions
-// to be removed when this code is moved under pi/
-
-#define __prel64_initconst	__initconst
-
-typedef void *prel64_t;
-
-static void *prel64_to_pointer(const prel64_t *p)
-{
-	return *p;
-}
-
 struct ftr_set_desc {
 	char 				name[FTR_DESC_NAME_LEN];
 	union {
@@ -309,16 +299,11 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 	} while (1);
 }
 
-static __init const u8 *get_bootargs_cmdline(void)
+static __init const u8 *get_bootargs_cmdline(const void *fdt)
 {
 	const u8 *prop;
-	void *fdt;
 	int node;
 
-	fdt = get_early_fdt_ptr();
-	if (!fdt)
-		return NULL;
-
 	node = fdt_path_offset(fdt, "/chosen");
 	if (node < 0)
 		return NULL;
@@ -330,9 +315,9 @@ static __init const u8 *get_bootargs_cmdline(void)
 	return strlen(prop) ? prop : NULL;
 }
 
-static __init void parse_cmdline(void)
+static __init void parse_cmdline(const void *fdt)
 {
-	const u8 *prop = get_bootargs_cmdline();
+	const u8 *prop = get_bootargs_cmdline(fdt);
 
 	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !prop)
 		__parse_cmdline(CONFIG_CMDLINE, true);
@@ -342,9 +327,9 @@ static __init void parse_cmdline(void)
 }
 
 /* Keep checkers quiet */
-void init_feature_override(u64 boot_status);
+void init_feature_override(u64 boot_status, const void *fdt);
 
-asmlinkage void __init init_feature_override(u64 boot_status)
+asmlinkage void __init init_feature_override(u64 boot_status, const void *fdt)
 {
 	struct arm64_ftr_override *override;
 	const struct ftr_set_desc *reg;
@@ -360,7 +345,7 @@ asmlinkage void __init init_feature_override(u64 boot_status)
 
 	__boot_status = boot_status;
 
-	parse_cmdline();
+	parse_cmdline(fdt);
 
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
 		reg = prel64_to_pointer(&regs[i].reg_prel);
@@ -369,3 +354,10 @@ asmlinkage void __init init_feature_override(u64 boot_status)
 				       (unsigned long)(override + 1));
 	}
 }
+
+char * __init skip_spaces(const char *str)
+{
+	while (isspace(*str))
+		++str;
+	return (char *)str;
+}
-- 
2.39.2

