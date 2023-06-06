Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD14724D61
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbjFFTn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239241AbjFFTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:42:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9338910FD;
        Tue,  6 Jun 2023 12:42:42 -0700 (PDT)
Date:   Tue, 06 Jun 2023 19:42:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686080560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5J7gFwTB5pW8pWlIW839LudqvFI1Ghz76VQywrDSe+Q=;
        b=VY1JnElJeQBggu9IC+tQYgFTa9lm9HLdlVekbqLifKRJ55vxpedDca2w+MJAl1S9FKzuOl
        sw0D/h4BFkFr5jtQVwIROEiBaqPxH3qi4rcRA8EW/5Xck0YeYVycZsa2LiJzoqEu1ZWpPw
        /zp9Jxb1H4D59JDUGvUxi1hQVUa6us9Di3L50WAs+0VGy4jCM2VYkrPrVNE4dw94TrRVMt
        J2q4MKSnlj8w9TrcaTJzXDitQNh00YGWKxcLxs6Z6WzRlFY/MWuhnko5RISz6QazC/yyY7
        VS839MT21WPkryfrA59JLTJYFMoK+nuJu0D9dr6CNJTpvweZ2osJHwhN+QsvgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686080560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5J7gFwTB5pW8pWlIW839LudqvFI1Ghz76VQywrDSe+Q=;
        b=Sg10T1mT2/4ezNlekb0F6B0+ad7EXSKAM5v1jqJTCIXF+OItcAr1pBc442ViDYu88XHI2k
        9e7mV1CLxZSztmCQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/boot/compressed: Handle unaccepted memory
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Liam Merwick <liam.merwick@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230606142637.5171-5-kirill.shutemov@linux.intel.com>
References: <20230606142637.5171-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168608055987.404.17716929724598317983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     3fd1239a783522e7158a1f141fabc7b3b5dc84c6
Gitweb:        https://git.kernel.org/tip/3fd1239a783522e7158a1f141fabc7b3b5dc84c6
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 06 Jun 2023 17:26:32 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Jun 2023 17:17:24 +02:00

x86/boot/compressed: Handle unaccepted memory

The firmware will pre-accept the memory used to run the stub. But, the
stub is responsible for accepting the memory into which it decompresses
the main kernel. Accept memory just before decompression starts.

The stub is also responsible for choosing a physical address in which to
place the decompressed kernel image. The KASLR mechanism will randomize
this physical address. Since the accepted memory region is relatively
small, KASLR would be quite ineffective if it only used the pre-accepted
area (EFI_CONVENTIONAL_MEMORY). Ensure that KASLR randomizes among the
entire physical address space by also including EFI_UNACCEPTED_MEMORY.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230606142637.5171-5-kirill.shutemov@linux.intel.com
---
 arch/x86/boot/compressed/efi.h   | 10 ++++++++-
 arch/x86/boot/compressed/kaslr.c | 40 +++++++++++++++++++++---------
 arch/x86/boot/compressed/mem.c   | 41 +++++++++++++++++++++++++++++++-
 arch/x86/boot/compressed/misc.c  |  6 +++++-
 arch/x86/boot/compressed/misc.h  | 10 ++++++++-
 5 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
index 7db2f41..866c0af 100644
--- a/arch/x86/boot/compressed/efi.h
+++ b/arch/x86/boot/compressed/efi.h
@@ -16,6 +16,7 @@ typedef guid_t efi_guid_t __aligned(__alignof__(u32));
 #define ACPI_TABLE_GUID				EFI_GUID(0xeb9d2d30, 0x2d88, 0x11d3,  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
 #define ACPI_20_TABLE_GUID			EFI_GUID(0x8868e871, 0xe4f1, 0x11d3,  0xbc, 0x22, 0x00, 0x80, 0xc7, 0x3c, 0x88, 0x81)
 #define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
+#define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
 
 #define EFI32_LOADER_SIGNATURE	"EL32"
 #define EFI64_LOADER_SIGNATURE	"EL64"
@@ -32,6 +33,7 @@ typedef	struct {
 } efi_table_hdr_t;
 
 #define EFI_CONVENTIONAL_MEMORY		 7
+#define EFI_UNACCEPTED_MEMORY		15
 
 #define EFI_MEMORY_MORE_RELIABLE \
 				((u64)0x0000000000010000ULL)	/* higher reliability */
@@ -104,6 +106,14 @@ struct efi_setup_data {
 	u64 reserved[8];
 };
 
+struct efi_unaccepted_memory {
+	u32 version;
+	u32 unit_size;
+	u64 phys_base;
+	u64 size;
+	unsigned long bitmap[];
+};
+
 static inline int efi_guidcmp (efi_guid_t left, efi_guid_t right)
 {
 	return memcmp(&left, &right, sizeof (efi_guid_t));
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 454757f..9193acf 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -672,6 +672,33 @@ static bool process_mem_region(struct mem_vector *region,
 }
 
 #ifdef CONFIG_EFI
+
+/*
+ * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if supported) are
+ * guaranteed to be free.
+ *
+ * Pick free memory more conservatively than the EFI spec allows: according to
+ * the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also free memory and thus
+ * available to place the kernel image into, but in practice there's firmware
+ * where using that memory leads to crashes. Buggy vendor EFI code registers
+ * for an event that triggers on SetVirtualAddressMap(). The handler assumes
+ * that EFI_BOOT_SERVICES_DATA memory has not been touched by loader yet, which
+ * is probably true for Windows.
+ *
+ * Preserve EFI_BOOT_SERVICES_* regions until after SetVirtualAddressMap().
+ */
+static inline bool memory_type_is_free(efi_memory_desc_t *md)
+{
+	if (md->type == EFI_CONVENTIONAL_MEMORY)
+		return true;
+
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
+	    md->type == EFI_UNACCEPTED_MEMORY)
+		    return true;
+
+	return false;
+}
+
 /*
  * Returns true if we processed the EFI memmap, which we prefer over the E820
  * table if it is available.
@@ -716,18 +743,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
 	for (i = 0; i < nr_desc; i++) {
 		md = efi_early_memdesc_ptr(pmap, e->efi_memdesc_size, i);
 
-		/*
-		 * Here we are more conservative in picking free memory than
-		 * the EFI spec allows:
-		 *
-		 * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also
-		 * free memory and thus available to place the kernel image into,
-		 * but in practice there's firmware where using that memory leads
-		 * to crashes.
-		 *
-		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
-		 */
-		if (md->type != EFI_CONVENTIONAL_MEMORY)
+		if (!memory_type_is_free(md))
 			continue;
 
 		if (efi_soft_reserve_enabled() &&
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 67594fc..69038ed 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -1,9 +1,50 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "error.h"
+#include "misc.h"
 
 void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
 	error("Cannot accept memory");
 }
+
+bool init_unaccepted_memory(void)
+{
+	guid_t guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
+	struct efi_unaccepted_memory *table;
+	unsigned long cfg_table_pa;
+	unsigned int cfg_table_len;
+	enum efi_type et;
+	int ret;
+
+	et = efi_get_type(boot_params);
+	if (et == EFI_TYPE_NONE)
+		return false;
+
+	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
+	if (ret) {
+		warn("EFI config table not found.");
+		return false;
+	}
+
+	table = (void *)efi_find_vendor_table(boot_params, cfg_table_pa,
+					      cfg_table_len, guid);
+	if (!table)
+		return false;
+
+	if (table->version != 1)
+		error("Unknown version of unaccepted memory table\n");
+
+	/*
+	 * In many cases unaccepted_table is already set by EFI stub, but it
+	 * has to be initialized again to cover cases when the table is not
+	 * allocated by EFI stub or EFI stub copied the kernel image with
+	 * efi_relocate_kernel() before the variable is set.
+	 *
+	 * It must be initialized before the first usage of accept_memory().
+	 */
+	unaccepted_table = table;
+
+	return true;
+}
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 014ff22..94b7abc 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -455,6 +455,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
+
+	if (init_unaccepted_memory()) {
+		debug_putstr("Accepting memory... ");
+		accept_memory(__pa(output), __pa(output) + needed_size);
+	}
+
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
 	entry_offset = parse_elf(output);
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 2f155a0..964fe90 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -247,4 +247,14 @@ static inline unsigned long efi_find_vendor_table(struct boot_params *bp,
 }
 #endif /* CONFIG_EFI */
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+bool init_unaccepted_memory(void);
+#else
+static inline bool init_unaccepted_memory(void) { return false; }
+#endif
+
+/* Defined in EFI stub */
+extern struct efi_unaccepted_memory *unaccepted_table;
+void accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif /* BOOT_COMPRESSED_MISC_H */
