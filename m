Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DDA69ED61
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjBVDRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjBVDQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:16:54 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92416303E9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:16:51 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxJPQhifVjX28DAA--.1468S3;
        Wed, 22 Feb 2023 11:16:49 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxUuUbifVj9l84AA--.2774S7;
        Wed, 22 Feb 2023 11:16:48 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/5] LoongArch: Add support for kernel address space layout randomization (KASLR)
Date:   Wed, 22 Feb 2023 11:16:43 +0800
Message-Id: <1677035803-7932-6-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1677035803-7932-1-git-send-email-tangyouling@loongson.cn>
References: <1677035803-7932-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8DxUuUbifVj9l84AA--.2774S7
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3XFyxJr1kJry8Wr18Wr1kAFb_yoW3ZFW5pr
        ZxAw4Utr43GF17GrsFq34kury5Aws7W343WFsxKryru3W2qF1rXFykuryDXFy8t3yvgr4S
        qFy5Kaya9w4UAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j3GYdUUUUU=
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
 arch/loongarch/Kconfig             |  23 +++++
 arch/loongarch/include/asm/setup.h |   2 +
 arch/loongarch/kernel/head.S       |  14 ++-
 arch/loongarch/kernel/relocate.c   | 145 ++++++++++++++++++++++++++++-
 4 files changed, 179 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 406a28758a52..ab4c2ab146ab 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -530,6 +530,29 @@ config RELOCATABLE
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
diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index 68b5b5a1fe8a..8d2a9d7a4356 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -33,6 +33,8 @@ extern void *__la_abs_begin;
 extern void *__la_abs_end;
 
 extern void __init relocate_kernel(void);
+extern void *__init do_kaslr(void);
+
 #endif
 
 #endif /* __SETUP_H */
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
index feeba0730875..73faf7505140 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -9,11 +9,15 @@
 #include <linux/kernel.h>
 #include <linux/printk.h>
 #include <linux/panic_notifier.h>
+#include <linux/start_kernel.h>
+#include <asm/bootinfo.h>
+#include <asm/early_ioremap.h>
 #include <asm/inst.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 
 #define RELOCATED(x) ((void *)((long)x + reloc_offset))
+#define RELOCATED_KASLR(x) ((void *)((long)x + offset))
 
 static unsigned long reloc_offset;
 
@@ -38,13 +42,13 @@ static inline __init void relocate_relative(void)
 	}
 }
 
-static inline void __init relocate_la_abs(void)
+static inline void __init relocate_la_abs(long offset)
 {
 	struct rela_la_abs *p;
 	void *start, *end;
 
-	start = &__la_abs_begin;
-	end = &__la_abs_end;
+	start = RELOCATED_KASLR((unsigned long)&__la_abs_begin);
+	end = RELOCATED_KASLR((unsigned long)&__la_abs_end);
 
 	for (p = start; (void *)p < end; p++) {
 		long v = p->symvalue;
@@ -63,6 +67,139 @@ static inline void __init relocate_la_abs(void)
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
+	reloc_offset = (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
+
+	if (offset) {
+		/* Copy the kernel to it's new location */
+		memcpy(loc_new, _text, kernel_length);
+
+		/* Sync the caches ready for execution of new kernel */
+		__asm__ __volatile__ (
+			"ibar 0 \t\n"
+			"dbar 0 \t\n"
+			::: "memory");
+
+		reloc_offset += offset;
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
+	if (reloc_offset)
+		relocate_relative();
+
+	relocate_la_abs(offset);
+
+	return kernel_entry;
+}
+#endif
+
 void __init relocate_kernel(void)
 {
 	reloc_offset = (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
@@ -70,7 +207,7 @@ void __init relocate_kernel(void)
 	if (reloc_offset)
 		relocate_relative();
 
-	relocate_la_abs();
+	relocate_la_abs(0);
 }
 
 /*
-- 
2.37.3

