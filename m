Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC0D68DB95
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjBGOdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjBGOcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:32:54 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3164A3E635
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1675780204;
        bh=bYU8i2vMnFWlU7t8bvGKvgBRgI3/rqYbEk0nKv8UPc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DB6T/rgR/D1PBLoQu7/6ZZbYa/q0dP02qSY3OZG9phC2MLiiZyOF0873zkMOum+z8
         lf9WSbzcAb549qBYJ3WzJujD2HV7Zqh+tGeaen2GREHF3tGNcxmutODkeunmMAGgE6
         UXXrQLjnRWYL54jd8O3nagbsw+oGbkVABQKWs6eo=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:11cc:4100:dc73:854d:832e:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id A369E65DC6;
        Tue,  7 Feb 2023 09:29:57 -0500 (EST)
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v2 5/5] LoongArch: Add support for kernel address space layout randomization (KASLR)
Date:   Tue,  7 Feb 2023 22:28:22 +0800
Message-Id: <20230207142822.52172-6-xry111@xry111.site>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207142822.52172-1-xry111@xry111.site>
References: <20230207142822.52172-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youling Tang <tangyouling@loongson.cn>

This patch adds support for relocating the kernel to a random address.

Entropy is derived from the banner, which will change every build and
random_get_entropy() which should provide additional runtime entropy.

The kernel is relocated by up to RANDOMIZE_BASE_MAX_OFFSET bytes from
its link address. Because relocation happens so early in the kernel boot,
the amount of physical memory has not yet been determined. This means
the only way to limit relocation within the available memory is via
Kconfig. Limit the maximum value of RANDOMIZE_BASE_MAX_OFFSET to
256M(0x10000000) because our memory layout has many holes.

KERNELOFFSET (kaslr_offset) is added to vmcoreinfo in the future, for
crash --kaslr support.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Xi Ruoyao <xry111@xry111.site> # Use arch_initcall
---
 arch/loongarch/Kconfig            |  22 ++++++
 arch/loongarch/include/asm/page.h |   6 ++
 arch/loongarch/kernel/relocate.c  | 115 ++++++++++++++++++++++++++++++
 arch/loongarch/kernel/setup.c     |   3 +
 4 files changed, 146 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index db83f71ba1c0..4ceb16ce080a 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -489,6 +489,28 @@ config RELOCATABLE
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
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index 53f284a96182..6dda0d6271ca 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -106,6 +106,12 @@ extern int __virt_addr_valid(volatile void *kaddr);
 	 ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
 	 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+extern unsigned long __kaslr_offset;
+static inline unsigned long kaslr_offset(void)
+{
+	return __kaslr_offset;
+}
+
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 9c61e03d3e91..351168b70b7a 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -11,6 +11,7 @@
 #include <linux/printk.h>
 #include <linux/panic_notifier.h>
 #include <asm/bootinfo.h>
+#include <asm/early_ioremap.h>
 #include <asm/inst.h>
 #include <asm/sections.h>
 
@@ -19,6 +20,70 @@
 extern long __rela_dyn_start;
 extern long __rela_dyn_end;
 
+#ifdef CONFIG_RANDOMIZE_BASE
+
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
+	return RELOCATED(dest);
+}
+
+#else
+
 /*
  * Choose a new address for the kernel, for now we'll hard
  * code the destination.
@@ -28,6 +93,8 @@ static inline void __init *determine_relocation_address(void)
 	return (void *)(CACHE_BASE + 0x02000000);
 }
 
+#endif
+
 static inline int __init relocation_addr_valid(void *loc_new)
 {
 	if ((unsigned long)loc_new & 0x0000ffff) {
@@ -41,6 +108,13 @@ static inline int __init relocation_addr_valid(void *loc_new)
 	return 1;
 }
 
+static inline void __init update_kaslr_offset(unsigned long *addr, long offset)
+{
+	unsigned long *new_addr = (unsigned long *)RELOCATED(addr);
+
+	*new_addr = (unsigned long)offset;
+}
+
 void *__init relocate_kernel(void)
 {
 	Elf64_Rela *rela, *rela_end;
@@ -49,6 +123,10 @@ void *__init relocate_kernel(void)
 	long offset = 0;
 	/* Default to original kernel entry point */
 	void *kernel_entry = start_kernel;
+	char *cmdline = early_ioremap(fw_arg1, COMMAND_LINE_SIZE);
+
+	/* Boot command line was passed in fw_arg1 */
+	strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
 
 	kernel_length = (long)(_end) - (long)(_text);
 
@@ -90,7 +168,44 @@ void *__init relocate_kernel(void)
 
 		/* Return the new kernel's entry point */
 		kernel_entry = RELOCATED(start_kernel);
+
+		/* Error may occur before, so keep it at last */
+		update_kaslr_offset(&__kaslr_offset, offset);
 	}
 
 	return kernel_entry;
 }
+
+/*
+ * Show relocation information on panic.
+ */
+static void show_kernel_relocation(const char *level)
+{
+	if (__kaslr_offset > 0) {
+		printk(level);
+		pr_cont("Kernel relocated offset @ 0x%lx\n", __kaslr_offset);
+		pr_cont(" .text @ 0x%lx\n", (unsigned long)&_text);
+		pr_cont(" .data @ 0x%lx\n", (unsigned long)&_sdata);
+		pr_cont(" .bss  @ 0x%lx\n", (unsigned long)&__bss_start);
+	}
+}
+
+static int kernel_location_notifier_fn(struct notifier_block *self,
+				       unsigned long v, void *p)
+{
+	show_kernel_relocation(KERN_EMERG);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block kernel_location_notifier = {
+	.notifier_call = kernel_location_notifier_fn
+};
+
+static int __init register_kernel_offset_dumper(void)
+{
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &kernel_location_notifier);
+	return 0;
+}
+
+arch_initcall(register_kernel_offset_dumper);
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 4344502c0b31..b2ba2741945c 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -82,6 +82,9 @@ static struct resource code_resource = { .name = "Kernel code", };
 static struct resource data_resource = { .name = "Kernel data", };
 static struct resource bss_resource  = { .name = "Kernel bss", };
 
+unsigned long __kaslr_offset __ro_after_init;
+EXPORT_SYMBOL(__kaslr_offset);
+
 const char *get_system_type(void)
 {
 	return "generic-loongson-machine";
-- 
2.37.0

