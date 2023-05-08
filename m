Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A306FA080
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjEHHFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjEHHEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889051D94E;
        Mon,  8 May 2023 00:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C655461F8E;
        Mon,  8 May 2023 07:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7498EC4339E;
        Mon,  8 May 2023 07:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529458;
        bh=VPdQcfiofp2M7ooAjtAnUJeEgqKJFWTMviAMCuGGVF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhaxFeLau1dvafm0jJWXvK9QInCA5eHAWaLkKGbSAm0nGGNSJfN6L3Aoh99QiU3/8
         5xv9E+OsWiQZBb1kZ4i+6MM97pixg/MWY+9QXaiMy39OrDYM/+zdLUA+xMIURXIPC/
         8/8haFD82HWJZWBgezrr8SlNS8dzS5uzfWc9piswHlWmBpavC8w58fXq06Pl9XmthC
         /m6DVD7M7rJPWjHY3WT4o0BrawddXUQeIdW1WGZv8FhntZXoXWQ3J0g7llilDlESkv
         cpkfkw01zyU4Ulcyiw360eCewja2F9/tgwG3SvrrRd+aOARjuqOsBw0p1TvyGAPiTl
         ktBibFkXR8K3A==
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
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 09/20] x86: efistub: Perform 4/5 level paging switch from the stub
Date:   Mon,  8 May 2023 09:03:19 +0200
Message-Id: <20230508070330.582131-10-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6966; i=ardb@kernel.org; h=from:subject; bh=VPdQcfiofp2M7ooAjtAnUJeEgqKJFWTMviAMCuGGVF8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3paEC0fE3/dpyz7xe7/L/OB1Pr1zit/PP95RNvWsV m39DM7tHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiX4IZGR68vmW9yvPXEqeo k7OqX1VN0772ZJccu/ChiqndXz7d7TjO8JNxCmcA8/dT899pWySpTt9zPnLPtztKxx7d2vplrd7 Lik4+AA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
number of paging levels is already set correctly, we no longer need to
remove NX restrictions from the memory range where this trampoline may
end up.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c |   4 +
 drivers/firmware/efi/libstub/x86-stub.c        | 119 ++++++++++++++++----
 2 files changed, 102 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1e0203d74691ffcc..fc5f3b4c45e91401 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -16,6 +16,8 @@
 
 #include "efistub.h"
 
+extern bool efi_no5lvl;
+
 bool efi_nochunk;
 bool efi_nokaslr = !IS_ENABLED(CONFIG_RANDOMIZE_BASE);
 bool efi_novamap;
@@ -73,6 +75,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_loglevel = CONSOLE_LOGLEVEL_QUIET;
 		} else if (!strcmp(param, "noinitrd")) {
 			efi_noinitrd = true;
+		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
+			efi_no5lvl = true;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap |= parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index a0bfd31358ba97b1..fb83a72ad905ad6e 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -267,32 +267,11 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
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
 		adjust_memory_range_protection(image_base, image_size);
@@ -760,6 +739,96 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	return EFI_SUCCESS;
 }
 
+bool efi_no5lvl;
+
+static void (*la57_toggle)(void *trampoline, bool enable_5lvl);
+
+extern void trampoline_32bit_src(void *, bool);
+extern const u16 trampoline_ljmp_imm_offset;
+
+/*
+ * Enabling (or disabling) 5 level paging is tricky, because it can only be
+ * done from 32-bit mode with paging disabled. This means not only that the
+ * code itself must be running from 32-bit addressable physical memory, but
+ * also that the root page table must be 32-bit addressable, as we cannot
+ * program a 64-bit value into CR3 when running in 32-bit mode.
+ */
+static efi_status_t efi_setup_5level_paging(void)
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
+	adjust_memory_range_protection((unsigned long)la57_toggle, PAGE_SIZE);
+
+	return EFI_SUCCESS;
+}
+
+static void efi_5level_switch(void)
+{
+#ifdef CONFIG_X86_64
+	static const struct desc_struct gdt[] = {
+		[GDT_ENTRY_KERNEL32_CS] = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
+		[GDT_ENTRY_KERNEL_CS]   = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
+	};
+
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
+#endif
+}
+
 /*
  * On success, we return the address of startup_32, which has potentially been
  * relocated by efi_relocate_kernel.
@@ -787,6 +856,12 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
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
@@ -905,6 +980,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 		goto fail;
 	}
 
+	efi_5level_switch();
+
 	return bzimage_addr;
 fail:
 	efi_err("efi_main() failed!\n");
-- 
2.39.2

