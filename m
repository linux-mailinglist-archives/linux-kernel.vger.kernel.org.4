Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD1F6EC8C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjDXJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDXJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:24:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F10273A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:24:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so69645395e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682328257; x=1684920257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKHDf/OuI0joUYiyFgsR6uDWAhEBCTmUNYp/uICOgcM=;
        b=k7kOLa6IR5EJwGmnBOhOxTID2K+mwgYgRL3NB8AamFmIiUlSfNm1gfl9p5OuZRbgC3
         omwDtbRZrgIY8P55Uir2PlFUHe4hdtS6IiyHEydYocqSIxTHrVzb02kUQKUUqxT8ZVob
         PEdRAeduI8Q5inx8fwCJZpKxZe3O8S1VvGr0hv+hXwQq3oQ9Hsqw4gW9MQOm9QmqIlRH
         js3Sq8arhBmLjIU4jHCH82jVRQxZQZzMPu+IFtW5/hUYpkMjGf8vZZ8SrVmkzaZDroSs
         TsmJ2QoCKbQwXNNKA3TVrhoZlhIgcuxLKLb6D+sHp0KWEB6zhJGjg6rv/Z4nWIjvrhML
         puIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682328257; x=1684920257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKHDf/OuI0joUYiyFgsR6uDWAhEBCTmUNYp/uICOgcM=;
        b=DSZIqciexuWUsEAXXS+l5VAvSkB8bkVwugwLhOtigvV4wggEIfgLaEpKsFg+7LHbVQ
         RAy2cmDMAx4Er1cbx4MaKe2nJ2hBQlJSBN3dLlDAr3hkg9OtnhypnUnJk5uZlLw7iElK
         yv7wUPQ+AIIHB/ShWyD/dV4uDgW1YuDV66fZQwmKfKoQ3b+mnNxqYWJmWoFkMJo532qo
         DNgVOHQShhvCJTHGleqBNKtsfMwVZaZoFCUg/uEqXsQNZNsha3F3+i8gstLJMSxoGb8J
         SFbV4C+Epw5RTNZ0VySXzUdHSF/u06/F/qYYbP2nfjbv+SgIM9lmA0Lx6LK3ZOAoJ0yX
         R+DA==
X-Gm-Message-State: AAQBX9fRctE9EC+CPHT6Am7jGIJR/E7MjCuxV/7u4yeuU+x2cZBCmDQq
        BBWT8gN0J4CxreV4feKIZsnD8A==
X-Google-Smtp-Source: AKy350YTPxe2yl9aXhmt0aTaxnKjxu6ut+FOguHCXTw5DwDIVqjr6GDK0T0E3IEGtebA9aqRKY98Pw==
X-Received: by 2002:a05:600c:5012:b0:3f0:a095:7b9 with SMTP id n18-20020a05600c501200b003f0a09507b9mr7347857wmr.5.1682328256950;
        Mon, 24 Apr 2023 02:24:16 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c00d300b003f17eaae2c9sm11723172wmm.1.2023.04.24.02.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 02:24:16 -0700 (PDT)
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
Subject: [PATCH v10 1/1] riscv: Allow to downgrade paging mode from the command line
Date:   Mon, 24 Apr 2023 11:23:13 +0200
Message-Id: <20230424092313.178699-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230424092313.178699-1-alexghiti@rivosinc.com>
References: <20230424092313.178699-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
flags that were not relevant to RISC-V at the moment (LTO, SCS). Also
note that we have to link with -z norelro to avoid ld.lld to throw a
warning with the new .got sections, like in commit 311bea3cb9ee ("arm64:
link with -z norelro for LLD or aarch64-elf").

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +-
 arch/riscv/Makefile                           |  3 +-
 arch/riscv/kernel/Makefile                    |  2 +
 arch/riscv/kernel/pi/Makefile                 | 39 ++++++++++++
 arch/riscv/kernel/pi/cmdline_early.c          | 62 +++++++++++++++++++
 arch/riscv/kernel/vmlinux.lds.S               | 11 +++-
 arch/riscv/lib/memcpy.S                       |  2 +
 arch/riscv/lib/memmove.S                      |  2 +
 arch/riscv/lib/strlen.S                       |  1 +
 arch/riscv/mm/init.c                          | 36 +++++++++--
 10 files changed, 154 insertions(+), 9 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/Makefile
 create mode 100644 arch/riscv/kernel/pi/cmdline_early.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..accc400b43f1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3576,7 +3576,10 @@
 			emulation library even if a 387 maths coprocessor
 			is present.
 
-	no5lvl		[X86-64] Disable 5-level paging mode. Forces
+	no4lvl		[RISCV] Disable 4-level and 5-level paging modes. Forces
+			kernel to use 3-level paging instead.
+
+	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
 	nofsgsbase	[X86] Disables FSGSBASE instructions.
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 7dc6904a6836..6eef6b33795d 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -7,8 +7,9 @@
 #
 
 OBJCOPYFLAGS    := -O binary
+LDFLAGS_vmlinux := -z norelro
 ifeq ($(CONFIG_RELOCATABLE),y)
-	LDFLAGS_vmlinux += -shared -Bsymbolic -z notext -z norelro --emit-relocs
+	LDFLAGS_vmlinux += -shared -Bsymbolic -z notext --emit-relocs
 	KBUILD_CFLAGS += -fPIE
 endif
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4cf303a779ab..aa22f87faeae 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -89,3 +89,5 @@ obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+= compat_signal.o
 obj-$(CONFIG_COMPAT)		+= compat_vdso/
+
+obj-$(CONFIG_64BIT)		+= pi/
diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
new file mode 100644
index 000000000000..5d7cb991f2b8
--- /dev/null
+++ b/arch/riscv/kernel/pi/Makefile
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+# This file was copied from arm64/kernel/pi/Makefile.
+
+KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
+		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
+		   $(call cc-option,-mbranch-protection=none) \
+		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
+		   -D__DISABLE_EXPORTS -ffreestanding \
+		   -fno-asynchronous-unwind-tables -fno-unwind-tables \
+		   $(call cc-option,-fno-addrsig)
+
+KBUILD_CFLAGS	+= -mcmodel=medany
+
+CFLAGS_cmdline_early.o += -D__NO_FORTIFY
+CFLAGS_lib-fdt_ro.o += -D__NO_FORTIFY
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
index 000000000000..05652d13c746
--- /dev/null
+++ b/arch/riscv/kernel/pi/cmdline_early.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/libfdt.h>
+#include <linux/string.h>
+#include <asm/pgtable.h>
+#include <asm/setup.h>
+
+static char early_cmdline[COMMAND_LINE_SIZE];
+
+/*
+ * Declare the functions that are exported (but prefixed) here so that LLVM
+ * does not complain it lacks the 'static' keyword (which, if added, makes
+ * LLVM complain because the function is actually unused in this file).
+ */
+u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
+
+static char *get_early_cmdline(uintptr_t dtb_pa)
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
+static u64 match_noXlvl(char *cmdline)
+{
+	if (strstr(cmdline, "no4lvl"))
+		return SATP_MODE_48;
+	else if (strstr(cmdline, "no5lvl"))
+		return SATP_MODE_57;
+
+	return 0;
+}
+
+u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa)
+{
+	char *cmdline = get_early_cmdline(dtb_pa);
+
+	return match_noXlvl(cmdline);
+}
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 615ff5842690..305877d85e96 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -83,6 +83,14 @@ SECTIONS
 	/* Start of init data section */
 	__init_data_begin = .;
 	INIT_DATA_SECTION(16)
+
+	/* Those sections result from the compilation of kernel/pi/string.c */
+	.init.pidata : {
+		*(.init.srodata.cst8*)
+		*(.init__bug_table*)
+		*(.init.sdata*)
+	}
+
 	.init.bss : {
 		*(.init.bss)	/* from the EFI stub */
 	}
@@ -128,9 +136,10 @@ SECTIONS
 		__rela_dyn_end = .;
 	}
 
+	.got : { *(.got*) }
+
 #ifdef CONFIG_RELOCATABLE
 	.data.rel : { *(.data.rel*) }
-	.got : { *(.got*) }
 	.plt : { *(.plt) }
 	.dynamic : { *(.dynamic) }
 	.dynsym : { *(.dynsym) }
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
diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
index 15bb8f3aa959..9d0055616f7b 100644
--- a/arch/riscv/lib/strlen.S
+++ b/arch/riscv/lib/strlen.S
@@ -131,3 +131,4 @@ strlen_zbb:
 .option pop
 #endif
 SYM_FUNC_END(strlen)
+SYM_FUNC_ALIAS(__pi_strlen, strlen)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index bce899b180cd..3ad771571c2d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -746,6 +746,8 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
+u64 __pi_set_satp_mode_from_cmdline(uintptr_t dtb_pa);
+
 static void __init disable_pgtable_l5(void)
 {
 	pgtable_l5_enabled = false;
@@ -760,17 +762,39 @@ static void __init disable_pgtable_l4(void)
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
@@ -789,7 +813,8 @@ static __init void set_satp_mode(void)
 retry:
 	create_pgd_mapping(early_pg_dir,
 			   set_satp_mode_pmd,
-			   check_l4 ? (uintptr_t)early_pud : (uintptr_t)early_p4d,
+			   pgtable_l5_enabled ?
+				(uintptr_t)early_p4d : (uintptr_t)early_pud,
 			   PGDIR_SIZE, PAGE_TABLE);
 
 	identity_satp = PFN_DOWN((uintptr_t)&early_pg_dir) | satp_mode;
@@ -800,9 +825,8 @@ static __init void set_satp_mode(void)
 	local_flush_tlb_all();
 
 	if (hw_satp != identity_satp) {
-		if (!check_l4) {
+		if (pgtable_l5_enabled) {
 			disable_pgtable_l5();
-			check_l4 = true;
 			memset(early_pg_dir, 0, PAGE_SIZE);
 			goto retry;
 		}
@@ -1031,7 +1055,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
-	set_satp_mode();
+	set_satp_mode(dtb_pa);
 #endif
 
 	/*
-- 
2.37.2

