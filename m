Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BAC691A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjBJIsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjBJIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:48:13 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 865387B16D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 00:48:02 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxV+nBBOZjuMAQAA--.28223S3;
        Fri, 10 Feb 2023 16:48:01 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX+SpBOZjLUYwAA--.56353S7;
        Fri, 10 Feb 2023 16:48:00 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] LoongArch: Add support for kernel address space layout randomization (KASLR)
Date:   Fri, 10 Feb 2023 16:47:36 +0800
Message-Id: <1676018856-26520-6-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1676018856-26520-1-git-send-email-tangyouling@loongson.cn>
References: <1676018856-26520-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8AxX+SpBOZjLUYwAA--.56353S7
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3XFyxJr1kJryrKw1xZFy7Jrb_yoWxKw48pr
        W3C3y5tr4xGF17GrsFq3s5ury5Aws7W343WFsrKryrZ3W2qF1rXaykur97XFy8JrWkXr4a
        qF98Kaya9w4UAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for relocating the kernel to a random address.

Entropy is derived from the banner, which will change every build and
random_get_entropy() which should provide additional runtime entropy.

The kernel is relocated by up to RANDOMIZE_BASE_MAX_OFFSET bytes from
its link address. Because relocation happens so early in the kernel boot,
the amount of physical memory has not yet been determined. This means
the only way to limit relocation within the available memory is via
Kconfig. Limit the maximum value of RANDOMIZE_BASE_MAX_OFFSET to
256M(0x10000000) because our memory layout has many holes.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Xi Ruoyao <xry111@xry111.site> # Fix compiler warnings
---
 arch/loongarch/Kconfig           |  23 +++++
 arch/loongarch/kernel/head.S     |  14 ++-
 arch/loongarch/kernel/relocate.c | 143 ++++++++++++++++++++++++++++++-
 3 files changed, 176 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 089a4695b1b3..f0a070bd7254 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -489,6 +489,29 @@ config RELOCATABLE
 	  kernel binary at runtime to a different virtual address than the
 	  address it was linked at.
 
+config RANDOMIZE_BASE
+	bool "Randomize the address of the kernel image (KASLR)"
+	depends on RELOCATABLE
+	help
+	   Randomizes the physical and virtual address at which the
+	   kernel image is loaded, as a security feature that
+	   deters exploit attempts relying on knowledge of the location
+	   of kernel internals.
+
+	   The kernel will be offset by up to RANDOMIZE_BASE_MAX_OFFSET.
+
+	   If unsure, say N.
+
+config RANDOMIZE_BASE_MAX_OFFSET
+	hex "Maximum KASLR offset" if EXPERT
+	depends on RANDOMIZE_BASE
+	range 0x0 0x10000000 if 64BIT
+	default "0x01000000"
+	help
+	  When KASLR is active, this provides the maximum offset that will
+	  be applied to the kernel image.
+
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 499edc80d8ab..b12f459ad73a 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -87,10 +87,22 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	set_saved_sp	sp, t0, t1
 
 #ifdef CONFIG_RELOCATABLE
+#ifdef CONFIG_RANDOMIZE_BASE
+	bl		do_kaslr
+
+	/* Repoint the sp into the new kernel image */
+	PTR_LI		sp, (_THREAD_SIZE - PT_SIZE)
+	PTR_ADD		sp, sp, tp
+	set_saved_sp	sp, t0, t1
+
+	/* do_kaslr returns the new kernel image entry point */
+	jr		a0
+	ASM_BUG()
+#else
 	/* Apply the relocations */
 	bl		relocate_kernel
 #endif
-
+#endif
 	bl		start_kernel
 	ASM_BUG()
 
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 91ce92433bab..5266f23a3006 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -9,19 +9,21 @@
 #include <linux/kernel.h>
 #include <linux/printk.h>
 #include <linux/panic_notifier.h>
+#include <linux/start_kernel.h>
+#include <asm/bootinfo.h>
+#include <asm/early_ioremap.h>
 #include <asm/sections.h>
 
 #define RELOCATED(x) ((void *)((long)x + reloc_offset))
+#define RELOCATED_KASLR(x) ((void *)((long)x + offset))
 
 extern long __rela_dyn_start;
 extern long __rela_dyn_end;
 
 static unsigned long reloc_offset;
 
-void __init relocate_kernel(void)
+static inline __init void relocate_relative(void)
 {
-	reloc_offset = (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
-
 	if (reloc_offset) {
 		Elf64_Rela *rela, *rela_end;
 		rela = (Elf64_Rela *)&__rela_dyn_start;
@@ -43,6 +45,141 @@ void __init relocate_kernel(void)
 	}
 }
 
+#ifdef CONFIG_RANDOMIZE_BASE
+static inline __init unsigned long rotate_xor(unsigned long hash,
+					      const void *area, size_t size)
+{
+	size_t i;
+	unsigned long *ptr = (unsigned long *)area;
+
+	for (i = 0; i < size / sizeof(hash); i++) {
+		/* Rotate by odd number of bits and XOR. */
+		hash = (hash << ((sizeof(hash) * 8) - 7)) | (hash >> 7);
+		hash ^= ptr[i];
+	}
+
+	return hash;
+}
+
+static inline __init unsigned long get_random_boot(void)
+{
+	unsigned long entropy = random_get_entropy();
+	unsigned long hash = 0;
+
+	/* Attempt to create a simple but unpredictable starting entropy. */
+	hash = rotate_xor(hash, linux_banner, strlen(linux_banner));
+
+	/* Add in any runtime entropy we can get */
+	hash = rotate_xor(hash, &entropy, sizeof(entropy));
+
+	return hash;
+}
+
+static inline __init bool kaslr_disabled(void)
+{
+	char *str;
+
+	str = strstr(boot_command_line, "nokaslr");
+	if (str == boot_command_line || (str > boot_command_line && *(str - 1) == ' '))
+		return true;
+
+	return false;
+}
+
+/* Choose a new address for the kernel */
+static inline void __init *determine_relocation_address(void)
+{
+	unsigned long kernel_length;
+	void *dest = _text;
+	unsigned long offset;
+
+	if (kaslr_disabled())
+		return dest;
+
+	kernel_length = (long)_end - (long)_text;
+
+	offset = get_random_boot() << 16;
+	offset &= (CONFIG_RANDOMIZE_BASE_MAX_OFFSET - 1);
+	if (offset < kernel_length)
+		offset += ALIGN(kernel_length, 0xffff);
+
+	return RELOCATED_KASLR(dest);
+}
+
+static inline int __init relocation_addr_valid(void *loc_new)
+{
+	if ((unsigned long)loc_new & 0x00000ffff) {
+		/* Inappropriately aligned new location */
+		return 0;
+	}
+	if ((unsigned long)loc_new < (unsigned long)_end) {
+		/* New location overlaps original kernel */
+		return 0;
+	}
+	return 1;
+}
+
+static inline void __init update_reloc_offset(unsigned long *addr, long offset)
+{
+	unsigned long *new_addr = (unsigned long *)RELOCATED_KASLR(addr);
+
+	*new_addr = (unsigned long)offset;
+}
+
+void *__init do_kaslr(void)
+{
+	void *loc_new;
+	unsigned long kernel_length;
+	long offset = 0;
+	/* Default to original kernel entry point */
+	void *kernel_entry = start_kernel;
+	char *cmdline = early_ioremap(fw_arg1, COMMAND_LINE_SIZE);
+
+	/* Boot command line was passed in fw_arg1 */
+	strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
+
+	kernel_length = (long)(_end) - (long)(_text);
+
+	loc_new = determine_relocation_address();
+
+	/* Sanity check relocation address */
+	if (relocation_addr_valid(loc_new))
+		offset = (unsigned long)loc_new - (unsigned long)(_text);
+
+	if (offset) {
+		/* Copy the kernel to it's new location */
+		memcpy(loc_new, _text, kernel_length);
+
+		/* Sync the caches ready for execution of new kernel */
+		__asm__ __volatile__ (
+			"ibar 0 \t\n"
+			"dbar 0 \t\n");
+
+		reloc_offset = (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
+		reloc_offset += offset;
+
+		relocate_relative();
+
+		/* The current thread is now within the relocated image */
+		__current_thread_info = RELOCATED_KASLR(__current_thread_info);
+
+		/* Return the new kernel's entry point */
+		kernel_entry = RELOCATED_KASLR(start_kernel);
+
+		update_reloc_offset(&reloc_offset, offset);
+	}
+
+	return kernel_entry;
+}
+#endif
+
+void __init relocate_kernel(void)
+{
+	reloc_offset = (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
+
+	relocate_relative();
+}
+
 /*
  * Show relocation information on panic.
  */
-- 
2.37.3

