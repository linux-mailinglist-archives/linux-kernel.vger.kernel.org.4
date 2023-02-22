Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435E69F2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBVKoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjBVKoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:44:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F637F1F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:44:28 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v3so7178744wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63ddUURZK1WcSEWa6PFArCoWz1u1nszRv3/eqLgbtv8=;
        b=47wOaNT7AL3Ib2+OuLJHB2zcF0brHUnp57QOGwYC0Mz2rCkhn3di1MOK+AIL/l9OuV
         tV1wzIhG+4VfZY5vmvFPiyCLVR/aPdveJhx7MS9hvsH0nm9SdnlOrxM2BYTpKIgJnC+5
         8+uKK85b1a6fzlyaBlqtlr5+Xfvjw790brwP+VvHrrU2CZW5JsLLu0AqrUfv1o7VBvCp
         06iUWVYrBY7ckBCKFEKJIQIjIaMp2pxaz7vypnmYhcSJLk9g3X3Si8luS5OT8quSfgZa
         HoB9VO5VgrSgE1/zTR65PNr593/SbtSbm66yWopwxqWR3/6TdJ4z2HRSYLv0CSjaE2Ge
         4o+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63ddUURZK1WcSEWa6PFArCoWz1u1nszRv3/eqLgbtv8=;
        b=Ml3BdaczGrTZ/pr9nfrWYaI7XOX5sHWE83U9hEtAlbvcxMFMjFw3tTLt81GGcsFQgK
         pDL6wfog/IrLqQtq4AUA5rFjXsXZNADkaKTeC3pNR3dH9zwK8VADlLdpnLTgrtuho8ql
         ZmoYUJyucau5ZLjg6X7fc2IuWWjde2eBOQcNyd4y8OULJsNOd5Ec40pESBOttf8Hz/KC
         kstwRuhgXyy25NYsNxYCxH3wRfvU1neh4KvSqKBbEoygqu6ZMoS+57RuRPkK8P1c1GFD
         Ivcp7jQZiO5amVpF0Ss+TzaekKauASAfr58+TOblPjDdZ63n3BrMgVXpgTihfWgaeEDr
         6pFQ==
X-Gm-Message-State: AO0yUKWZvj8pKGZHJAy/bWbTJADL4eNt0v829KGvvB7zwRVc8p5+kn2K
        jrwaR0KT+mE7j47tgZ9NeIgfTw==
X-Google-Smtp-Source: AK7set8S4UcwMjHzxvPq6gSHozwq4anrUgRaw3TEN1hsobsYeyPrRFZm9oD6oEAP79YBdiK+3ZfneA==
X-Received: by 2002:a5d:4e49:0:b0:2c3:e4f5:18c with SMTP id r9-20020a5d4e49000000b002c3e4f5018cmr6946460wrt.30.1677062666963;
        Wed, 22 Feb 2023 02:44:26 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-gre-1-235-32.w90-112.abo.wanadoo.fr. [90.112.194.32])
        by smtp.gmail.com with ESMTPSA id ja13-20020a05600c556d00b003e4326a6d53sm9507050wmb.35.2023.02.22.02.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 02:44:26 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v5 1/1] riscv: Allow to downgrade paging mode from the command line
Date:   Wed, 22 Feb 2023 11:43:22 +0100
Message-Id: <20230222104322.1197763-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222104322.1197763-1-alexghiti@rivosinc.com>
References: <20230222104322.1197763-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 early command line parameters that allow to downgrade satp mode
(using the same naming as x86):
- "no5lvl": use a 4-level page table (down from sv57 to sv48)
- "no4lvl": use a 3-level page table (down from sv57/sv48 to sv39)

Note that going through the device tree to get the kernel command line
works with ACPI too since the efi stub creates a device tree anyway with
the command line.

In KASAN kernels, we can't use the libfdt that early in the boot process
since we are not ready to execute instrumented functions. So instead of
using the "generic" libfdt, we compile our own versions of those functions
that are not instrumented and that are prefixed so that they do not
conflict with the generic ones. We also need the non-instrumented versions
of the string functions and the prefixed versions of memcpy/memmove.

This is largely inspired by commit aacd149b6238 ("arm64: head: avoid
relocating the kernel twice for KASLR") from which I removed compilation
flags that were not relevant to RISC-V at the moment (LTO, SCS, pie).

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>

---
 .../admin-guide/kernel-parameters.txt         |  5 +-
 arch/riscv/kernel/Makefile                    |  2 +
 arch/riscv/kernel/pi/Makefile                 | 34 ++++++++++++
 arch/riscv/kernel/pi/cmdline_early.c          | 55 +++++++++++++++++++
 arch/riscv/lib/memcpy.S                       |  2 +
 arch/riscv/lib/memmove.S                      |  2 +
 arch/riscv/mm/init.c                          | 36 ++++++++++--
 7 files changed, 129 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/Makefile
 create mode 100644 arch/riscv/kernel/pi/cmdline_early.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..1d8fc66d2b0d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3578,7 +3578,10 @@
 			emulation library even if a 387 maths coprocessor
 			is present.
 
-	no5lvl		[X86-64] Disable 5-level paging mode. Forces
+	no4lvl		[RISCV] Disable 4-level and 5-level paging modes. Forces
+			kernel to use 3-level paging instead.
+
+	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
 	nofsgsbase	[X86] Disables FSGSBASE instructions.
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4cf303a779ab..6756209f1ac6 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -89,3 +89,5 @@ obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+= compat_signal.o
 obj-$(CONFIG_COMPAT)		+= compat_vdso/
+
+obj-y				+= pi/
diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
new file mode 100644
index 000000000000..554e936ef0b6
--- /dev/null
+++ b/arch/riscv/kernel/pi/Makefile
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+# This file was copied from arm64/kernel/pi/Makefile.
+
+KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
+		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
+		   $(call cc-option,-mbranch-protection=none) \
+		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
+		   -D__DISABLE_EXPORTS -ffreestanding \
+		   -fno-asynchronous-unwind-tables -fno-unwind-tables \
+		   $(call cc-option,-fno-addrsig)
+
+GCOV_PROFILE	:= n
+KASAN_SANITIZE	:= n
+KCSAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
+KCOV_INSTRUMENT	:= n
+
+$(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
+			       --remove-section=.note.gnu.property \
+			       --prefix-alloc-sections=.init
+$(obj)/%.pi.o: $(obj)/%.o FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/string.o: $(srctree)/lib/string.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
+obj-y		:= cmdline_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
+extra-y		:= $(patsubst %.pi.o,%.o,$(obj-y))
diff --git a/arch/riscv/kernel/pi/cmdline_early.c b/arch/riscv/kernel/pi/cmdline_early.c
new file mode 100644
index 000000000000..be491987d2bf
--- /dev/null
+++ b/arch/riscv/kernel/pi/cmdline_early.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/libfdt.h>
+#include <linux/string.h>
+#include <asm/pgtable.h>
+#include <asm/setup.h>
+
+static char early_cmdline[COMMAND_LINE_SIZE] __initdata;
+
+static char * __init get_early_cmdline(uintptr_t dtb_pa)
+{
+	const char *fdt_cmdline = NULL;
+	unsigned int fdt_cmdline_size = 0;
+	int chosen_node;
+
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
+		chosen_node = fdt_path_offset((void *)dtb_pa, "/chosen");
+		if (chosen_node >= 0) {
+			fdt_cmdline = fdt_getprop((void *)dtb_pa, chosen_node,
+						  "bootargs", NULL);
+			if (fdt_cmdline) {
+				fdt_cmdline_size = strlen(fdt_cmdline);
+				strscpy(early_cmdline, fdt_cmdline,
+					COMMAND_LINE_SIZE);
+			}
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
+	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
+	    fdt_cmdline_size == 0 /* CONFIG_CMDLINE_FALLBACK */) {
+		strncat(early_cmdline, CONFIG_CMDLINE,
+			COMMAND_LINE_SIZE - fdt_cmdline_size);
+	}
+
+	return early_cmdline;
+}
+
+static u64 __init match_noXlvl(char *cmdline)
+{
+	if (strstr(cmdline, "no4lvl"))
+		return SATP_MODE_48;
+	else if (strstr(cmdline, "no5lvl"))
+		return SATP_MODE_57;
+
+	return 0;
+}
+
+u64 __init set_satp_mode_from_cmdline(uintptr_t dtb_pa)
+{
+	char *cmdline = get_early_cmdline(dtb_pa);
+
+	return match_noXlvl(cmdline);
+}
diff --git a/arch/riscv/lib/memcpy.S b/arch/riscv/lib/memcpy.S
index 51ab716253fa..1a40d01a9543 100644
--- a/arch/riscv/lib/memcpy.S
+++ b/arch/riscv/lib/memcpy.S
@@ -106,3 +106,5 @@ WEAK(memcpy)
 6:
 	ret
 END(__memcpy)
+SYM_FUNC_ALIAS(__pi_memcpy, __memcpy)
+SYM_FUNC_ALIAS(__pi___memcpy, __memcpy)
diff --git a/arch/riscv/lib/memmove.S b/arch/riscv/lib/memmove.S
index e0609e1f0864..838ff2022fe3 100644
--- a/arch/riscv/lib/memmove.S
+++ b/arch/riscv/lib/memmove.S
@@ -314,3 +314,5 @@ return_from_memmove:
 
 SYM_FUNC_END(memmove)
 SYM_FUNC_END(__memmove)
+SYM_FUNC_ALIAS(__pi_memmove, __memmove)
+SYM_FUNC_ALIAS(__pi___memmove, __memmove)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 87f6a5d475a6..04d20e41894e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -732,6 +732,8 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
+u64 __pi_set_satp_mode_from_cmdline(uintptr_t dtb_pa);
+
 static void __init disable_pgtable_l5(void)
 {
 	pgtable_l5_enabled = false;
@@ -746,17 +748,39 @@ static void __init disable_pgtable_l4(void)
 	satp_mode = SATP_MODE_39;
 }
 
+static int __init print_no4lvl(char *p)
+{
+	pr_info("Disabled 4-level and 5-level paging");
+	return 0;
+}
+early_param("no4lvl", print_no4lvl);
+
+static int __init print_no5lvl(char *p)
+{
+	pr_info("Disabled 5-level paging");
+	return 0;
+}
+early_param("no5lvl", print_no5lvl);
+
 /*
  * There is a simple way to determine if 4-level is supported by the
  * underlying hardware: establish 1:1 mapping in 4-level page table mode
  * then read SATP to see if the configuration was taken into account
  * meaning sv48 is supported.
  */
-static __init void set_satp_mode(void)
+static __init void set_satp_mode(uintptr_t dtb_pa)
 {
 	u64 identity_satp, hw_satp;
 	uintptr_t set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
-	bool check_l4 = false;
+	u64 satp_mode_cmdline = __pi_set_satp_mode_from_cmdline(dtb_pa);
+
+	if (satp_mode_cmdline == SATP_MODE_57) {
+		disable_pgtable_l5();
+	} else if (satp_mode_cmdline == SATP_MODE_48) {
+		disable_pgtable_l5();
+		disable_pgtable_l4();
+		return;
+	}
 
 	create_p4d_mapping(early_p4d,
 			set_satp_mode_pmd, (uintptr_t)early_pud,
@@ -775,7 +799,8 @@ static __init void set_satp_mode(void)
 retry:
 	create_pgd_mapping(early_pg_dir,
 			   set_satp_mode_pmd,
-			   check_l4 ? (uintptr_t)early_pud : (uintptr_t)early_p4d,
+			   pgtable_l5_enabled ?
+				(uintptr_t)early_p4d : (uintptr_t)early_pud,
 			   PGDIR_SIZE, PAGE_TABLE);
 
 	identity_satp = PFN_DOWN((uintptr_t)&early_pg_dir) | satp_mode;
@@ -786,9 +811,8 @@ static __init void set_satp_mode(void)
 	local_flush_tlb_all();
 
 	if (hw_satp != identity_satp) {
-		if (!check_l4) {
+		if (pgtable_l5_enabled) {
 			disable_pgtable_l5();
-			check_l4 = true;
 			memset(early_pg_dir, 0, PAGE_SIZE);
 			goto retry;
 		}
@@ -979,7 +1003,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
-	set_satp_mode();
+	set_satp_mode(dtb_pa);
 #endif
 
 	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
-- 
2.37.2

