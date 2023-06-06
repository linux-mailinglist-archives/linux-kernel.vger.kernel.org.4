Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF8C724D66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbjFFTnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbjFFTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:42:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A61D10F2;
        Tue,  6 Jun 2023 12:42:42 -0700 (PDT)
Date:   Tue, 06 Jun 2023 19:42:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686080560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnbf/2C3jtsTSH1eb5/MccVGHmx+gKAuxQm1RISRdAg=;
        b=D5cAybN95k6u5llHb7Wr9NMPYU1ALUE8/mzajOyqx6kAmHYNfZprd5fVGQX/TuMDsVyPIn
        qdExP+PpdgYSTcGd63RMFawKAe4n7oZ81+VbryzXRUkBBGYEeWep2l0k/ZS2m7ZswEiALg
        0ylILMbHrI6BcwNAudFZK9Z+uuhpzRgqWjiaVL2bJDJIpv7iSf24P47aLoZymf/0MnbhUf
        S6WB6T9nTKl+cTMju/sag5AqN9QEonoaLVzD+seaapUQ6jHC/5VXwtqcfx2Qu+z3xk5A7E
        4PmOguBxx356oLQDaHDBxZftgou6t2PPBFvrzh2hx+rWX8Koq1x6tU/MIQUTfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686080560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnbf/2C3jtsTSH1eb5/MccVGHmx+gKAuxQm1RISRdAg=;
        b=nPRgrGO36pJkd6VPB1XLFyXQNV7/RGcolr22YKyxO0vc/LmK3sbmbe3betKurdOstwoSer
        0qU78xMgbe3DMhCw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] efi: Add unaccepted memory support
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
References: <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168608055951.404.8430387110343209587.tip-bot2@tip-bot2>
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

Commit-ID:     2053bc57f36763febced0b5cd91821698bcf6b3d
Gitweb:        https://git.kernel.org/tip/2053bc57f36763febced0b5cd91821698bcf6b3d
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 06 Jun 2023 17:26:33 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Jun 2023 17:22:20 +02:00

efi: Add unaccepted memory support

efi_config_parse_tables() reserves memory that holds unaccepted memory
configuration table so it won't be reused by page allocator.

Core-mm requires few helpers to support unaccepted memory:

 - accept_memory() checks the range of addresses against the bitmap and
   accept memory if needed.

 - range_contains_unaccepted_memory() checks if anything within the
   range requires acceptance.

Architectural code has to provide efi_get_unaccepted_table() that
returns pointer to the unaccepted memory configuration table.

arch_accept_memory() handles arch-specific part of memory acceptance.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230606142637.5171-6-kirill.shutemov@linux.intel.com
---
 arch/x86/platform/efi/efi.c              |   3 +-
 drivers/firmware/efi/Makefile            |   1 +-
 drivers/firmware/efi/efi.c               |  25 +++++-
 drivers/firmware/efi/unaccepted_memory.c | 112 ++++++++++++++++++++++-
 include/linux/efi.h                      |   1 +-
 5 files changed, 142 insertions(+)
 create mode 100644 drivers/firmware/efi/unaccepted_memory.c

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index f3f2d87..e9f99c5 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -96,6 +96,9 @@ static const unsigned long * const efi_tables[] = {
 #ifdef CONFIG_EFI_COCO_SECRET
 	&efi.coco_secret,
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	&efi.unaccepted,
+#endif
 };
 
 u64 efi_setup;		/* efi setup_data physical address */
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index b51f2a4..e489fef 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
+obj-$(CONFIG_UNACCEPTED_MEMORY)		+= unaccepted_memory.o
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7dce06e..d817e7a 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -50,6 +50,9 @@ struct efi __read_mostly efi = {
 #ifdef CONFIG_EFI_COCO_SECRET
 	.coco_secret		= EFI_INVALID_TABLE_ADDR,
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	.unaccepted		= EFI_INVALID_TABLE_ADDR,
+#endif
 };
 EXPORT_SYMBOL(efi);
 
@@ -605,6 +608,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 #ifdef CONFIG_EFI_COCO_SECRET
 	{LINUX_EFI_COCO_SECRET_AREA_GUID,	&efi.coco_secret,	"CocoSecret"	},
 #endif
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	{LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID,	&efi.unaccepted,	"Unaccepted"	},
+#endif
 #ifdef CONFIG_EFI_GENERIC_STUB
 	{LINUX_EFI_SCREEN_INFO_TABLE_GUID,	&screen_info_table			},
 #endif
@@ -759,6 +765,25 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
+	    efi.unaccepted != EFI_INVALID_TABLE_ADDR) {
+		struct efi_unaccepted_memory *unaccepted;
+
+		unaccepted = early_memremap(efi.unaccepted, sizeof(*unaccepted));
+		if (unaccepted) {
+			unsigned long size;
+
+			if (unaccepted->version == 1) {
+				size = sizeof(*unaccepted) + unaccepted->size;
+				memblock_reserve(efi.unaccepted, size);
+			} else {
+				efi.unaccepted = EFI_INVALID_TABLE_ADDR;
+			}
+
+			early_memunmap(unaccepted, sizeof(*unaccepted));
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
new file mode 100644
index 0000000..08a9a84
--- /dev/null
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/efi.h>
+#include <linux/memblock.h>
+#include <linux/spinlock.h>
+#include <asm/unaccepted_memory.h>
+
+/* Protects unaccepted memory bitmap */
+static DEFINE_SPINLOCK(unaccepted_memory_lock);
+
+/*
+ * accept_memory() -- Consult bitmap and accept the memory if needed.
+ *
+ * Only memory that is explicitly marked as unaccepted in the bitmap requires
+ * an action. All the remaining memory is implicitly accepted and doesn't need
+ * acceptance.
+ *
+ * No need to accept:
+ *  - anything if the system has no unaccepted table;
+ *  - memory that is below phys_base;
+ *  - memory that is above the memory that addressable by the bitmap;
+ */
+void accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct efi_unaccepted_memory *unaccepted;
+	unsigned long range_start, range_end;
+	unsigned long flags;
+	u64 unit_size;
+
+	unaccepted = efi_get_unaccepted_table();
+	if (!unaccepted)
+		return;
+
+	unit_size = unaccepted->unit_size;
+
+	/*
+	 * Only care for the part of the range that is represented
+	 * in the bitmap.
+	 */
+	if (start < unaccepted->phys_base)
+		start = unaccepted->phys_base;
+	if (end < unaccepted->phys_base)
+		return;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted->phys_base;
+	end -= unaccepted->phys_base;
+
+	/* Make sure not to overrun the bitmap */
+	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
+		end = unaccepted->size * unit_size * BITS_PER_BYTE;
+
+	range_start = start / unit_size;
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
+				   DIV_ROUND_UP(end, unit_size)) {
+		unsigned long phys_start, phys_end;
+		unsigned long len = range_end - range_start;
+
+		phys_start = range_start * unit_size + unaccepted->phys_base;
+		phys_end = range_end * unit_size + unaccepted->phys_base;
+
+		arch_accept_memory(phys_start, phys_end);
+		bitmap_clear(unaccepted->bitmap, range_start, len);
+	}
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+}
+
+bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct efi_unaccepted_memory *unaccepted;
+	unsigned long flags;
+	bool ret = false;
+	u64 unit_size;
+
+	unaccepted = efi_get_unaccepted_table();
+	if (!unaccepted)
+		return false;
+
+	unit_size = unaccepted->unit_size;
+
+	/*
+	 * Only care for the part of the range that is represented
+	 * in the bitmap.
+	 */
+	if (start < unaccepted->phys_base)
+		start = unaccepted->phys_base;
+	if (end < unaccepted->phys_base)
+		return false;
+
+	/* Translate to offsets from the beginning of the bitmap */
+	start -= unaccepted->phys_base;
+	end -= unaccepted->phys_base;
+
+	/* Make sure not to overrun the bitmap */
+	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
+		end = unaccepted->size * unit_size * BITS_PER_BYTE;
+
+	spin_lock_irqsave(&unaccepted_memory_lock, flags);
+	while (start < end) {
+		if (test_bit(start / unit_size, unaccepted->bitmap)) {
+			ret = true;
+			break;
+		}
+
+		start += unit_size;
+	}
+	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
+
+	return ret;
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 8ffe451..67cb72d 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -646,6 +646,7 @@ extern struct efi {
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
 	unsigned long			mokvar_table;		/* MOK variable config table */
 	unsigned long			coco_secret;		/* Confidential computing secret table */
+	unsigned long			unaccepted;		/* Unaccepted memory table */
 
 	efi_get_time_t			*get_time;
 	efi_set_time_t			*set_time;
