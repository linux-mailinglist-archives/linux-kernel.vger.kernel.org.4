Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B7C6F9CDE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 01:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjEGXrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjEGXqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:46:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CF313C10;
        Sun,  7 May 2023 16:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683503204; x=1715039204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y619tJKuPjwZ/y2uw6gP6ILX0dPH5S7/IjFdg41hRrw=;
  b=R0vma4SvF7QPs190C0zqrPqVnmL4Iq49gHm7RCh3Zwi6C0tyqxtafsAj
   8oU7owT3kBXjbnjsoWD/HAAXPFJQpy9sEwyYqGMAZMm2tfqcYCdZo2Y/Y
   DmqkA9sJL9BxKW4D/EWTE5O1rOiU66jnBgmgDmX8kxk5S7P9a/td/grKP
   S/I//O+AawJc5eYSfcqqWjfu++X0aKyFcQ3KzkqasWnHB+5JujR9KAt50
   iHEb25mglaLDIftbSZkuz+BTLym36ZKnaMK+SwsJlobb1FS6G4fKG4C6V
   7/yim+YW0G2P+axv+8m8n2dFYzc6MfeHWkzlyOTGSRA5Y/R/yMUv5Imc8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="349550273"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="349550273"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 16:46:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="701222808"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="701222808"
Received: from dancaspi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 16:46:31 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3C28910D1EB; Mon,  8 May 2023 02:46:20 +0300 (+03)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv10 05/11] x86/boot/compressed: Handle unaccepted memory
Date:   Mon,  8 May 2023 02:46:12 +0300
Message-Id: <20230507234618.18067-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
References: <20230507234618.18067-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
this physical address. Since the unaccepted memory region is relatively
small, KASLR would be quite ineffective if it only used the pre-accepted
area (EFI_CONVENTIONAL_MEMORY). Ensure that KASLR randomizes among the
entire physical address space by also including EFI_UNACCEPTED_MEMORY.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/Makefile        |  2 +-
 arch/x86/boot/compressed/efi.h           |  1 +
 arch/x86/boot/compressed/kaslr.c         | 35 ++++++++++++++++--------
 arch/x86/boot/compressed/mem.c           | 18 ++++++++++++
 arch/x86/boot/compressed/misc.c          |  6 ++++
 arch/x86/boot/compressed/misc.h          |  6 ++++
 arch/x86/include/asm/unaccepted_memory.h |  2 ++
 7 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f62c02348f9a..74f7adee46ad 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,7 +107,7 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
-vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/mem.o
+vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/find.o $(obj)/mem.o
 
 vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
index 7db2f41b54cd..cf475243b6d5 100644
--- a/arch/x86/boot/compressed/efi.h
+++ b/arch/x86/boot/compressed/efi.h
@@ -32,6 +32,7 @@ typedef	struct {
 } efi_table_hdr_t;
 
 #define EFI_CONVENTIONAL_MEMORY		 7
+#define EFI_UNACCEPTED_MEMORY		15
 
 #define EFI_MEMORY_MORE_RELIABLE \
 				((u64)0x0000000000010000ULL)	/* higher reliability */
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
index 6b15a0ed8b54..de858a5180b6 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -3,12 +3,15 @@
 #include "../cpuflags.h"
 #include "bitmap.h"
 #include "error.h"
+#include "find.h"
 #include "math.h"
 
 #define PMD_SHIFT	21
 #define PMD_SIZE	(_AC(1, UL) << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE - 1))
 
+extern struct boot_params *boot_params;
+
 static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
@@ -71,3 +74,18 @@ void process_unaccepted_memory(struct boot_params *params, u64 start, u64 end)
 	bitmap_set((unsigned long *)params->unaccepted_memory,
 		   start / PMD_SIZE, (end - start) / PMD_SIZE);
 }
+
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long range_start, range_end;
+	unsigned long *bitmap, bitmap_size;
+
+	bitmap = (unsigned long *)boot_params->unaccepted_memory;
+	range_start = start / PMD_SIZE;
+	bitmap_size = DIV_ROUND_UP(end, PMD_SIZE);
+
+	for_each_set_bitrange_from(range_start, range_end, bitmap, bitmap_size) {
+		__accept_memory(range_start * PMD_SIZE, range_end * PMD_SIZE);
+		bitmap_clear(bitmap, range_start, range_end - range_start);
+	}
+}
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 014ff222bf4b..186bfd53e042 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -455,6 +455,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
+
+	if (boot_params->unaccepted_memory) {
+		debug_putstr("Accepting memory... ");
+		accept_memory(__pa(output), __pa(output) + needed_size);
+	}
+
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
 	entry_offset = parse_elf(output);
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 2f155a0e3041..9663d1839f54 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -247,4 +247,10 @@ static inline unsigned long efi_find_vendor_table(struct boot_params *bp,
 }
 #endif /* CONFIG_EFI */
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+void accept_memory(phys_addr_t start, phys_addr_t end);
+#else
+static inline void accept_memory(phys_addr_t start, phys_addr_t end) {}
+#endif
+
 #endif /* BOOT_COMPRESSED_MISC_H */
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index df0736d32858..41fbfc798100 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -7,4 +7,6 @@ struct boot_params;
 
 void process_unaccepted_memory(struct boot_params *params, u64 start, u64 num);
 
+void accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif
-- 
2.39.3

