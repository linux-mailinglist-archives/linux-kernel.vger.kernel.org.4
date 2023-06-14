Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ABF71FF21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjFBKYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjFBKXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4530E10D7;
        Fri,  2 Jun 2023 03:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF40764E6C;
        Fri,  2 Jun 2023 10:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512DBC433A0;
        Fri,  2 Jun 2023 10:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685701384;
        bh=qSgmzewWVKnnUee0WJqteVdeET11EUDulO4v6yJCdIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQVut3s5U9T+3LYhk66bKvpmn6FqcxlkNLEn/8Nh6YzIjqtDebcucSUh++WaKzoDe
         /dcyEM3ksvmUCUDWdDC9hAgHhfA66pPh17miBS7H9aoNjAobsa6nOfhUCtlAcTLjsA
         vjndQRELfccd7QcI3emzayAoF8aZY7fuvV73omVWXzV0aXCZJtbEYy3kucH8ClkMCu
         +ftHmqNUhAkZtGH159xqpt7mGANfGkOqeuEqTAMs3Orkk54A18DyCSHQKi+y+vu8R4
         NgdcUgUWAoBle4h+HcqEKH7cIWQlcnjSvkcHTdhGgwp6NT/bVN1Jg9w9oZQzKodWVC
         Mdv93Ri5t8FEQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v4 13/21] x86/efistub: Perform 4/5 level paging switch from the stub
Date:   Fri,  2 Jun 2023 12:13:05 +0200
Message-Id: <20230602101313.3557775-14-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602101313.3557775-1-ardb@kernel.org>
References: <20230602101313.3557775-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10070; i=ardb@kernel.org; h=from:subject; bh=qSgmzewWVKnnUee0WJqteVdeET11EUDulO4v6yJCdIc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXywPr78zd3BNqtP3xL96b0OtaeuL++Nt1HWk7enfiPp V0qbBd/RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhI0F+G/4EZS9Lfn681lQnb tvCu2Z0bwnvfRf/gLZ/mnay58dLpk1GMDH+4ZdjqEroFVmebT8g5bNW271F38ubAJjdjbZlJy5f MYgUA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for updating the EFI stub boot flow to avoid the bare
metal decompressor code altogether, implement the support code for
switching between 4 and 5 levels of paging before jumping to the kernel
proper.

This reuses the newly refactored trampoline that the bare metal
decompressor uses, but relies on EFI APIs to allocate 32-bit addressable
memory and remap it with the appropriate permissions. Given that the
bare metal decompressor will no longer call into the trampoline if the
number of paging levels is already set correctly, it is no longer needed
to remove NX restrictions from the memory range where this trampoline
may end up.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile          |  1 +
 drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +
 drivers/firmware/efi/libstub/efistub.h         |  1 +
 drivers/firmware/efi/libstub/x86-5lvl.c        | 94 ++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c        | 40 +++------
 drivers/firmware/efi/libstub/x86-stub.h        | 17 ++++
 6 files changed, 129 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 16d64a34d1e19465..ae8874401a9f1490 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -88,6 +88,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64.o arm64-stub.o smbios.o
 lib-$(CONFIG_X86)		+= x86-stub.o
+lib-$(CONFIG_X86_64)		+= x86-5lvl.o
 lib-$(CONFIG_RISCV)		+= riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1e0203d74691ffcc..51779279fbff21b5 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -73,6 +73,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
 		} else if (!strcmp(param, "noinitrd")) {
 			efi_noinitrd = true;
+		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
+			efi_no5lvl = true;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap |= parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 8659a01664b85d95..191698e8489d82e7 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -33,6 +33,7 @@
 #define EFI_ALLOC_LIMIT		ULONG_MAX
 #endif
 
+extern bool efi_no5lvl;
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern int efi_loglevel;
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
new file mode 100644
index 0000000000000000..f7284f6270abcc18
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/efi.h>
+
+#include <asm/boot.h>
+#include <asm/desc.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+#include "x86-stub.h"
+
+bool efi_no5lvl;
+
+static void (*la57_toggle)(void *trampoline, bool enable_5lvl);
+
+static const struct desc_struct gdt[] = {
+	[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
+};
+
+/*
+ * Enabling (or disabling) 5 level paging is tricky, because it can only be
+ * done from 32-bit mode with paging disabled. This means not only that the
+ * code itself must be running from 32-bit addressable physical memory, but
+ * also that the root page table must be 32-bit addressable, as we cannot
+ * program a 64-bit value into CR3 when running in 32-bit mode.
+ */
+efi_status_t efi_setup_5level_paging(void)
+{
+	u8 tmpl_size = (u8 *)&trampoline_ljmp_imm_offset - (u8 *)&trampoline_32bit_src;
+	efi_status_t status;
+	u8 *la57_code;
+
+	if (!efi_is_64bit())
+		return EFI_SUCCESS;
+
+	/* check for 5 level paging support */
+	if (native_cpuid_eax(0) < 7 ||
+	    !(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+		return EFI_SUCCESS;
+
+	/* allocate some 32-bit addressable memory for code and a page table */
+	status = efi_allocate_pages(2 * PAGE_SIZE, (unsigned long *)&la57_code,
+				    U32_MAX);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	la57_toggle = memcpy(la57_code, trampoline_32bit_src, tmpl_size);
+	memset(la57_code + tmpl_size, 0x90, PAGE_SIZE - tmpl_size);
+
+	/*
+	 * To avoid having to allocate a 32-bit addressable stack, we use a
+	 * ljmp to switch back to long mode. However, this takes an absolute
+	 * address, so we have to poke it in at runtime.
+	 */
+	*(u32 *)&la57_code[trampoline_ljmp_imm_offset] += (unsigned long)la57_code;
+
+	efi_adjust_memory_range_protection((unsigned long)la57_toggle, PAGE_SIZE);
+
+	return EFI_SUCCESS;
+}
+
+void efi_5level_switch(void)
+{
+	bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
+	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
+	bool need_toggle = want_la57 ^ have_la57;
+	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
+	u64 *cr3 = (u64 *)__native_read_cr3();
+	u64 *new_cr3;
+
+	if (!la57_toggle || !need_toggle)
+		return;
+
+	if (!have_la57) {
+		/*
+		 * We are going to enable 5 level paging, so we need to
+		 * allocate a root level page from the 32-bit addressable
+		 * physical region, and plug the existing hierarchy into it.
+		 */
+		new_cr3 = memset(pgt, 0, PAGE_SIZE);
+		new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
+	} else {
+		// take the new root table pointer from the current entry #0
+		new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
+
+		// copy the new root level table if it is not 32-bit addressable
+		if ((u64)new_cr3 > U32_MAX)
+			new_cr3 = memcpy(pgt, new_cr3, PAGE_SIZE);
+	}
+
+	native_load_gdt(&(struct desc_ptr){ sizeof(gdt) - 1, (u64)gdt });
+
+	la57_toggle(new_cr3, want_la57);
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index d010448dffb12cb8..c55c028cf911bce0 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -17,6 +17,7 @@
 #include <asm/boot.h>
 
 #include "efistub.h"
+#include "x86-stub.h"
 
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
@@ -212,8 +213,8 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
-static void
-adjust_memory_range_protection(unsigned long start, unsigned long size)
+void efi_adjust_memory_range_protection(unsigned long start,
+					unsigned long size)
 {
 	efi_status_t status;
 	efi_gcd_memory_space_desc_t desc;
@@ -267,35 +268,14 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
 	}
 }
 
-/*
- * Trampoline takes 2 pages and can be loaded in first megabyte of memory
- * with its end placed between 128k and 640k where BIOS might start.
- * (see arch/x86/boot/compressed/pgtable_64.c)
- *
- * We cannot find exact trampoline placement since memory map
- * can be modified by UEFI, and it can alter the computed address.
- */
-
-#define TRAMPOLINE_PLACEMENT_BASE ((128 - 8)*1024)
-#define TRAMPOLINE_PLACEMENT_SIZE (640*1024 - (128 - 8)*1024)
-
 void startup_32(struct boot_params *boot_params);
 
 static void
 setup_memory_protection(unsigned long image_base, unsigned long image_size)
 {
-	/*
-	 * Allow execution of possible trampoline used
-	 * for switching between 4- and 5-level page tables
-	 * and relocated kernel image.
-	 */
-
-	adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
-				       TRAMPOLINE_PLACEMENT_SIZE);
-
 #ifdef CONFIG_64BIT
 	if (image_base != (unsigned long)startup_32)
-		adjust_memory_range_protection(image_base, image_size);
+		efi_adjust_memory_range_protection(image_base, image_size);
 #else
 	/*
 	 * Clear protection flags on a whole range of possible
@@ -305,8 +285,8 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
 	 * need to remove possible protection on relocated image
 	 * itself disregarding further relocations.
 	 */
-	adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
-				       KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
+	efi_adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
+					   KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
 #endif
 }
 
@@ -804,6 +784,12 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		efi_dxe_table = NULL;
 	}
 
+	status = efi_setup_5level_paging();
+	if (status != EFI_SUCCESS) {
+		efi_err("efi_setup_5level_paging() failed!\n");
+		goto fail;
+	}
+
 	/*
 	 * If the kernel isn't already loaded at a suitable address,
 	 * relocate it.
@@ -922,6 +908,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
+	efi_5level_switch();
+
 	if (IS_ENABLED(CONFIG_X86_64))
 		/* add offset of startup_64() */
 		bzimage_addr += 0x200;
diff --git a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h
new file mode 100644
index 0000000000000000..37c5a36b9d8cf9b2
--- /dev/null
+++ b/drivers/firmware/efi/libstub/x86-stub.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/efi.h>
+
+extern void trampoline_32bit_src(void *, bool);
+extern const u16 trampoline_ljmp_imm_offset;
+
+void efi_adjust_memory_range_protection(unsigned long start,
+					unsigned long size);
+
+#ifdef CONFIG_X86_64
+efi_status_t efi_setup_5level_paging(void);
+void efi_5level_switch(void);
+#else
+static inline efi_status_t efi_setup_5level_paging(void) { return EFI_SUCCESS; }
+static inline void efi_5level_switch(void) {}
+#endif
-- 
2.39.2

