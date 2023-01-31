Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E92168310C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjAaPOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjAaPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:14:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1CC18AB5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:12:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg26so4732029wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu003L2kYCMfRjVpqY1q4S0aUw9CnS5RY+6XuRyP8fU=;
        b=jePm+zDiOc45NIttaSz8i+CwNrO+B/KGUinE7RZDTx5lcXmvfz7ysSnBZMQpiJSbWI
         wZK4QcPbIb2uDXyUI3HhAz3Qcpd5pW8uVP7Uf5kdf86A0gtPW6OpHsQwWdCk3OQXpu3b
         vFmtVx7kivXa5UnjatUNGsI0z3OL5lWZBgCQqdEO/IhaGN5PWcxr3geTHWUpiylLXlpM
         V7cnXcYukeKZ0wji44YciEiE7Ddxvu8oBJVyfR7LGy6FjtQI568E/ckeMH2Q/w2SDi92
         KfqtpLw85x901gQTstIz8bfXTi/n9rTReGmbsQrbIWlyDjAoBycv2Bb5PfvIQ+1ZwdZl
         +VmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vu003L2kYCMfRjVpqY1q4S0aUw9CnS5RY+6XuRyP8fU=;
        b=hVCUu9Fy4bNx7mNmtU1M1acWSHfi8tZS+RMF54ocwY0D/W+MmWV8GUiZk4tAHrxDnO
         hXBD7f6Dnuc85374hgwJF34IbbKQ0vLYzGZaKkiFeloRvZ1S5xwHak1JMnry6vwvwE8S
         DHSlOQ3++2gz4DwjCR6HkIzXNgoxLfqhotv+OY7jtArYhMp2maEHvFBsR6xj0uKdyb/+
         RCs8dDgateOjij7+W9YQcl7OLrM48zK34C/LyVsND8nMgCxL2EUjd5KPVUf1+KBq/GH7
         3INjRcBR7/G1rPum3slG/W08uUXb7jyB5cggqhB0xHAByh/4UCZ3531PEl8Yf9WGnZe+
         TBiA==
X-Gm-Message-State: AO0yUKWrczAaOsGcfjewlAfVt0K06ykCN/TypF7e+7936BpEqUyPS/He
        GbZ5ZQh2N8l4L9afmYQSJrVdsw==
X-Google-Smtp-Source: AK7set/iEMxt9GiuHBCi5Q4TEKgTzblgEjJUuHT1ymMoceD6R7UHJvfNUziCenIli6P9LMgQXaNQCg==
X-Received: by 2002:a7b:cbd0:0:b0:3dc:5ab8:7d74 with SMTP id n16-20020a7bcbd0000000b003dc5ab87d74mr7485270wmi.3.1675177945066;
        Tue, 31 Jan 2023 07:12:25 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c028200b003dc4baaedd3sm10798132wmk.37.2023.01.31.07.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:12:24 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 1/1] riscv: Allow to downgrade paging mode from the command line
Date:   Tue, 31 Jan 2023 16:11:15 +0100
Message-Id: <20230131151115.1972740-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230131151115.1972740-1-alexghiti@rivosinc.com>
References: <20230131151115.1972740-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
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
---
 .../admin-guide/kernel-parameters.txt         |  5 +-
 arch/riscv/kernel/Makefile                    |  2 +
 arch/riscv/kernel/pi/Makefile                 | 34 ++++++++++++
 arch/riscv/kernel/pi/cmdline_early.c          | 52 +++++++++++++++++++
 arch/riscv/lib/memcpy.S                       |  2 +
 arch/riscv/lib/memmove.S                      |  2 +
 arch/riscv/mm/init.c                          | 36 ++++++++++---
 7 files changed, 126 insertions(+), 7 deletions(-)
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
index 000000000000..5ae7b853fa66
--- /dev/null
+++ b/arch/riscv/kernel/pi/cmdline_early.c
@@ -0,0 +1,52 @@
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
+			fdt_cmdline_size = strlen(fdt_cmdline);
+			strscpy(early_cmdline, fdt_cmdline, COMMAND_LINE_SIZE);
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
index 4e482159f35d..fb19c80ac0c4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -742,6 +742,8 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
+u64 __pi_set_satp_mode_from_cmdline(uintptr_t dtb_pa);
+
 static void __init disable_pgtable_l5(void)
 {
 	pgtable_l5_enabled = false;
@@ -756,17 +758,39 @@ static void __init disable_pgtable_l4(void)
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
@@ -785,7 +809,8 @@ static __init void set_satp_mode(void)
 retry:
 	create_pgd_mapping(early_pg_dir,
 			   set_satp_mode_pmd,
-			   check_l4 ? (uintptr_t)early_pud : (uintptr_t)early_p4d,
+			   pgtable_l5_enabled ?
+				(uintptr_t)early_p4d : (uintptr_t)early_pud,
 			   PGDIR_SIZE, PAGE_TABLE);
 
 	identity_satp = PFN_DOWN((uintptr_t)&early_pg_dir) | satp_mode;
@@ -796,9 +821,8 @@ static __init void set_satp_mode(void)
 	local_flush_tlb_all();
 
 	if (hw_satp != identity_satp) {
-		if (!check_l4) {
+		if (pgtable_l5_enabled) {
 			disable_pgtable_l5();
-			check_l4 = true;
 			memset(early_pg_dir, 0, PAGE_SIZE);
 			goto retry;
 		}
@@ -989,7 +1013,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
-	set_satp_mode();
+	set_satp_mode(dtb_pa);
 #endif
 
 	kernel_map.va_pa_offset = 0UL;
-- 
2.37.2

