Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B071F1D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjFAS0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjFAS0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:26:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFE619F;
        Thu,  1 Jun 2023 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685643967; x=1717179967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cB7JT7aDjJoQ9y+kzrW0Z2YsT+bewIUS18f1VtIr+yc=;
  b=fWFZqax0ENicFi3exZX0qISEXsRlAy+i1ZgPWGqS8jGtb1SK+kXS2lXu
   mqlMj1ANsFPTJBtdpIXsBJqksL6tUWxFfX4Txc2JbXRKxAubeVoUvcVCw
   hhHRhvFhNdFSEOKHQUDgSSibBkVP1zVzh/axSLJpcxPIkpt4vULV80j3W
   VhiaPzKhSe5reBUdyBxrB41bz9CHnYPfmb9DJ4FJDIwPZ4Idu+3bgkVVL
   aZxjttoqFQ4s2PDhgsEPfpM3Gs8Rn06VS22buaWnxfVZoRI09Q1meHXBv
   SHGp73CLcqPZSe8O783ab0bKyz3s/G0XWvHFjP+Lzdmv9abMjVfnzdEeW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="383920509"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="383920509"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="772539905"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="772539905"
Received: from fmaislin-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.47.213])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 11:25:54 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 74B0710B6AB; Thu,  1 Jun 2023 21:25:52 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Liam Merwick <liam.merwick@oracle.com>
Subject: [PATCHv13 4/9] x86/boot/compressed: Handle unaccepted memory
Date:   Thu,  1 Jun 2023 21:25:38 +0300
Message-Id: <20230601182543.19036-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/efi.h   | 10 +++++++++
 arch/x86/boot/compressed/kaslr.c | 35 +++++++++++++++++++++-----------
 arch/x86/boot/compressed/mem.c   | 31 ++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.c  |  7 +++++++
 arch/x86/boot/compressed/misc.h  |  6 ++++++
 5 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
index 7db2f41b54cd..866c0af8b5b9 100644
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
index 454757fbdfe5..749f0fe7e446 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -672,6 +672,28 @@ static bool process_mem_region(struct mem_vector *region,
 }
 
 #ifdef CONFIG_EFI
+
+/*
+ * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if supported) are
+ * guaranteed to be free.
+ *
+ * It is more conservative in picking free memory than the EFI spec allows:
+ *
+ * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also free memory
+ * and thus available to place the kernel image into, but in practice there's
+ * firmware where using that memory leads to crashes.
+ */
+static inline bool memory_type_is_free(efi_memory_desc_t *md)
+{
+	if (md->type == EFI_CONVENTIONAL_MEMORY)
+		return true;
+
+	if (md->type == EFI_UNACCEPTED_MEMORY)
+		return IS_ENABLED(CONFIG_UNACCEPTED_MEMORY);
+
+	return false;
+}
+
 /*
  * Returns true if we processed the EFI memmap, which we prefer over the E820
  * table if it is available.
@@ -716,18 +738,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
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
index 67594fcb11d9..4ecf26576a77 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -1,9 +1,40 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "error.h"
+#include "misc.h"
 
 void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
 	error("Cannot accept memory");
 }
+
+void init_unaccepted_memory(void)
+{
+	guid_t guid =  LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
+	struct efi_unaccepted_memory *unaccepted_table;
+	unsigned long cfg_table_pa;
+	unsigned int cfg_table_len;
+	enum efi_type et;
+	int ret;
+
+	et = efi_get_type(boot_params);
+	if (et == EFI_TYPE_NONE)
+		return;
+
+	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
+	if (ret)
+		error("EFI config table not found.");
+
+	unaccepted_table = (void *)efi_find_vendor_table(boot_params,
+							 cfg_table_pa,
+							 cfg_table_len,
+							 guid);
+	if (!unaccepted_table)
+		return;
+
+	if (unaccepted_table->version != 1)
+		error("Unknown version of unaccepted memory table\n");
+
+	set_unaccepted_table(unaccepted_table);
+}
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 014ff222bf4b..36535a3753f5 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -455,6 +455,13 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
+
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
+		debug_putstr("Accepting memory... ");
+		init_unaccepted_memory();
+		accept_memory(__pa(output), __pa(output) + needed_size);
+	}
+
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
 	entry_offset = parse_elf(output);
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 2f155a0e3041..e1a0b49e0ed2 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -247,4 +247,10 @@ static inline unsigned long efi_find_vendor_table(struct boot_params *bp,
 }
 #endif /* CONFIG_EFI */
 
+void init_unaccepted_memory(void);
+
+/* Implemented in EFI stub */
+void set_unaccepted_table(struct efi_unaccepted_memory *table);
+void accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif /* BOOT_COMPRESSED_MISC_H */
-- 
2.39.3

