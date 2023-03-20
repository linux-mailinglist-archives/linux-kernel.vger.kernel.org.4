Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD86C1CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjCTQud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjCTQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:49:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10A13C02;
        Mon, 20 Mar 2023 09:42:10 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dWLOboJjVT+zu6r3LUJL74Gm+8gvVrqiwejt/I7HHCM=;
        b=J4Yw/Z7+uwxmZT43ObHVhnTe+kanHflqKTBSvlFMGfmkWgMqVh8HHhWIheKXUAD1FEFFOc
        zoiOnbwgJdbWESNLV3UF9DZ5xf6LuYG2AB10fYVwyHJpOSRPCNzs+KiyOo31uj3nexxxn9
        aBzrO1O9WTdg3Rd9ltSvTZLDOL+5/2f7lRLuxFFz7fXQi7e4uKujgg76+Wg7PHL464d4MR
        i3pIYvY+J6t6ka9PWp8Kc+XOK0nGRqwhTBams/K/5YYFfrw0vmTs38nNeTNHKq5PDHwxTX
        7arcuaI7kbxM2n4pl/Qv5tAizv+AGUe4W7H2Kian8gxhgnaCTbRCLIk/o90R2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dWLOboJjVT+zu6r3LUJL74Gm+8gvVrqiwejt/I7HHCM=;
        b=4TXbid8pZLGgSIAHo3bObcQm3Qlk/DN9SQf3Cu6xcRYHWWt8gsUPJ7ZtdyNd3Sq1EYa2G3
        hOgTVJGSD/mb77DA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/mm: Introduce _PAGE_SAVED_DIRTY
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036752.5837.1179851651037838977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     dee76004d54e8afc920b916f932136229fe4f259
Gitweb:        https://git.kernel.org/tip/dee76004d54e8afc920b916f932136229fe4f259
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:09 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:09 -07:00

x86/mm: Introduce _PAGE_SAVED_DIRTY

Some OSes have a greater dependence on software available bits in PTEs than
Linux. That left the hardware architects looking for a way to represent a
new memory type (shadow stack) within the existing bits. They chose to
repurpose a lightly-used state: Write=0,Dirty=1. So in order to support
shadow stack memory, Linux should avoid creating memory with this PTE bit
combination unless it intends for it to be shadow stack.

The reason it's lightly used is that Dirty=1 is normally set by HW
_before_ a write. A write with a Write=0 PTE would typically only generate
a fault, not set Dirty=1. Hardware can (rarely) both set Dirty=1 *and*
generate the fault, resulting in a Write=0,Dirty=1 PTE. Hardware which
supports shadow stacks will no longer exhibit this oddity.

So that leaves Write=0,Dirty=1 PTEs created in software. To avoid
inadvertently created shadow stack memory, in places where Linux normally
creates Write=0,Dirty=1, it can use the software-defined _PAGE_SAVED_DIRTY
in place of the hardware _PAGE_DIRTY. In other words, whenever Linux needs
to create Write=0,Dirty=1, it instead creates Write=0,SavedDirty=1 except
for shadow stack, which is Write=0,Dirty=1.

There are six bits left available to software in the 64-bit PTE after
consuming a bit for _PAGE_SAVED_DIRTY. No space is consumed in 32-bit
kernels because shadow stacks are not enabled there.

Implement only the infrastructure for _PAGE_SAVED_DIRTY. Changes to
actually begin creating _PAGE_SAVED_DIRTY PTEs will follow once other
pieces are in place.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-15-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable.h       | 79 +++++++++++++++++++++++++++-
 arch/x86/include/asm/pgtable_types.h | 50 ++++++++++++++---
 arch/x86/include/asm/tlbflush.h      |  3 +-
 3 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 66c5148..7360783 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -301,6 +301,45 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 	return native_make_pte(v & ~clear);
 }
 
+/*
+ * Write protection operations can result in Dirty=1,Write=0 PTEs. But in the
+ * case of X86_FEATURE_USER_SHSTK, the software SavedDirty bit is used, since
+ * the Dirty=1,Write=0 will result in the memory being treated as shadow stack
+ * by the HW. So when creating dirty, write-protected memory, a software bit is
+ * used _PAGE_BIT_SAVED_DIRTY. The following functions pte_mksaveddirty() and
+ * pte_clear_saveddirty() take a conventional dirty, write-protected PTE
+ * (Write=0,Dirty=1) and transition it to the shadow stack compatible
+ * version. (Write=0,SavedDirty=1).
+ */
+static inline pte_t pte_mksaveddirty(pte_t pte)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pte;
+
+	pte = pte_clear_flags(pte, _PAGE_DIRTY);
+	return pte_set_flags(pte, _PAGE_SAVED_DIRTY);
+}
+
+static inline pte_t pte_clear_saveddirty(pte_t pte)
+{
+	/*
+	 * _PAGE_SAVED_DIRTY is unnecessary on !X86_FEATURE_USER_SHSTK kernels,
+	 * since the HW dirty bit can be used without creating shadow stack
+	 * memory. See the _PAGE_SAVED_DIRTY definition for more details.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pte;
+
+	/*
+	 * PTE is getting copied-on-write, so it will be dirtied
+	 * if writable, or made shadow stack if shadow stack and
+	 * being copied on access. Set the dirty bit for both
+	 * cases.
+	 */
+	pte = pte_set_flags(pte, _PAGE_DIRTY);
+	return pte_clear_flags(pte, _PAGE_SAVED_DIRTY);
+}
+
 static inline pte_t pte_wrprotect(pte_t pte)
 {
 	return pte_clear_flags(pte, _PAGE_RW);
@@ -420,6 +459,26 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 	return native_make_pmd(v & ~clear);
 }
 
+/* See comments above pte_mksaveddirty() */
+static inline pmd_t pmd_mksaveddirty(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pmd;
+
+	pmd = pmd_clear_flags(pmd, _PAGE_DIRTY);
+	return pmd_set_flags(pmd, _PAGE_SAVED_DIRTY);
+}
+
+/* See comments above pte_mksaveddirty() */
+static inline pmd_t pmd_clear_saveddirty(pmd_t pmd)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pmd;
+
+	pmd = pmd_set_flags(pmd, _PAGE_DIRTY);
+	return pmd_clear_flags(pmd, _PAGE_SAVED_DIRTY);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pmd_clear_flags(pmd, _PAGE_RW);
@@ -491,6 +550,26 @@ static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 	return native_make_pud(v & ~clear);
 }
 
+/* See comments above pte_mksaveddirty() */
+static inline pud_t pud_mksaveddirty(pud_t pud)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pud;
+
+	pud = pud_clear_flags(pud, _PAGE_DIRTY);
+	return pud_set_flags(pud, _PAGE_SAVED_DIRTY);
+}
+
+/* See comments above pte_mksaveddirty() */
+static inline pud_t pud_clear_saveddirty(pud_t pud)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return pud;
+
+	pud = pud_set_flags(pud, _PAGE_DIRTY);
+	return pud_clear_flags(pud, _PAGE_SAVED_DIRTY);
+}
+
 static inline pud_t pud_mkold(pud_t pud)
 {
 	return pud_clear_flags(pud, _PAGE_ACCESSED);
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 0646ad0..8f26678 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -21,7 +21,8 @@
 #define _PAGE_BIT_SOFTW2	10	/* " */
 #define _PAGE_BIT_SOFTW3	11	/* " */
 #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
-#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
+#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
+#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
 #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
 #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
 #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
@@ -34,6 +35,15 @@
 #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
+/*
+ * Indicates a Saved Dirty bit page.
+ */
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+#define _PAGE_BIT_SAVED_DIRTY		_PAGE_BIT_SOFTW5 /* Saved Dirty bit */
+#else
+#define _PAGE_BIT_SAVED_DIRTY		0
+#endif
+
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
 /* - if the user mapped it with PROT_NONE; pte_present gives true */
 #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
@@ -117,6 +127,25 @@
 #define _PAGE_SOFTW4	(_AT(pteval_t, 0))
 #endif
 
+/*
+ * The hardware requires shadow stack to be Write=0,Dirty=1. However,
+ * there are valid cases where the kernel might create read-only PTEs that
+ * are dirty (e.g., fork(), mprotect(), uffd-wp(), soft-dirty  tracking). In
+ * this case, the _PAGE_SAVED_DIRTY bit is used instead of the HW-dirty bit,
+ * to avoid creating a wrong "shadow stack" PTEs. Such PTEs have
+ * (Write=0,SavedDirty=1,Dirty=0) set.
+ *
+ * Note that on processors without shadow stack support, the
+ * _PAGE_SAVED_DIRTY remains unused.
+ */
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+#define _PAGE_SAVED_DIRTY	(_AT(pteval_t, 1) << _PAGE_BIT_SAVED_DIRTY)
+#else
+#define _PAGE_SAVED_DIRTY	(_AT(pteval_t, 0))
+#endif
+
+#define _PAGE_DIRTY_BITS (_PAGE_DIRTY | _PAGE_SAVED_DIRTY)
+
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
 /*
@@ -125,9 +154,9 @@
  * instance, and is *not* included in this mask since
  * pte_modify() does modify it.
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
-			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |  \
+#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		     \
+			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY_BITS | \
+			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |	     \
 			 _PAGE_UFFD_WP)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
 
@@ -186,12 +215,17 @@ enum page_cache_mode {
 #define PAGE_READONLY	     __pg(__PP|   0|_USR|___A|__NX|   0|   0|   0)
 #define PAGE_READONLY_EXEC   __pg(__PP|   0|_USR|___A|   0|   0|   0|   0)
 
-#define __PAGE_KERNEL		 (__PP|__RW|   0|___A|__NX|___D|   0|___G)
-#define __PAGE_KERNEL_EXEC	 (__PP|__RW|   0|___A|   0|___D|   0|___G)
-#define _KERNPG_TABLE_NOENC	 (__PP|__RW|   0|___A|   0|___D|   0|   0)
-#define _KERNPG_TABLE		 (__PP|__RW|   0|___A|   0|___D|   0|   0| _ENC)
+/*
+ * Page tables needs to have Write=1 in order for any lower PTEs to be
+ * writable. This includes shadow stack memory (Write=0, Dirty=1)
+ */
 #define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
 #define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
+#define _KERNPG_TABLE_NOENC	 (__PP|__RW|   0|___A|   0|___D|   0|   0)
+#define _KERNPG_TABLE		 (__PP|__RW|   0|___A|   0|___D|   0|   0| _ENC)
+
+#define __PAGE_KERNEL		 (__PP|__RW|   0|___A|__NX|___D|   0|___G)
+#define __PAGE_KERNEL_EXEC	 (__PP|__RW|   0|___A|   0|___D|   0|___G)
 #define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|   0|   0|___G)
 #define __PAGE_KERNEL_ROX	 (__PP|   0|   0|___A|   0|   0|   0|___G)
 #define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index cda3118..6c5ef14 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -273,7 +273,8 @@ static inline bool pte_flags_need_flush(unsigned long oldflags,
 	const pteval_t flush_on_clear = _PAGE_DIRTY | _PAGE_PRESENT |
 					_PAGE_ACCESSED;
 	const pteval_t software_flags = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
-					_PAGE_SOFTW3 | _PAGE_SOFTW4;
+					_PAGE_SOFTW3 | _PAGE_SOFTW4 |
+					_PAGE_SAVED_DIRTY;
 	const pteval_t flush_on_change = _PAGE_RW | _PAGE_USER | _PAGE_PWT |
 			  _PAGE_PCD | _PAGE_PSE | _PAGE_GLOBAL | _PAGE_PAT |
 			  _PAGE_PAT_LARGE | _PAGE_PKEY_BIT0 | _PAGE_PKEY_BIT1 |
