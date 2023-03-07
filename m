Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654406AE1E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjCGOLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjCGOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:10:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E107E8AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9009CCE1BDB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EE7C433D2;
        Tue,  7 Mar 2023 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198085;
        bh=Rev1o3EJYNY+Qk3vzsOG2Q4FRpOLgCRqmirTRXa/+Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esk9bra8qrRMgQfAH9gkmvsQ739xbRtgA+ATtz54Q2d5RnnMqFplF4M9iKFuiSjYF
         Wj4z12gV0HB7nOlVDZ+HvfHDq0ZIOFakR8i4gM/FWfxaYFVYQX0Hgp72w7YdzVobk5
         FOvGjMpSfMzS9nHG8sE91OtkZ4LXMmwaerad2pxf5nOgynlI2qf5u8cMRNtBzb0L4u
         /kOB5uT39MXR9v+ScMHKxR6nh39ZEXsA474HfDsfURy7qHWdxjt8GDQ+MCcHuMdnbI
         9uq3bYAB46yH/l1m71fYhM9FRhIbLRwd64lH7+GJuOo4qdtOFrayI36PsUo9Do43i9
         ZoBy26z6/Scaw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 36/60] arm64: pgtable: Decouple PGDIR size macros from PGD/PUD/PMD levels
Date:   Tue,  7 Mar 2023 15:04:58 +0100
Message-Id: <20230307140522.2311461-37-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5172; i=ardb@kernel.org; h=from:subject; bh=Rev1o3EJYNY+Qk3vzsOG2Q4FRpOLgCRqmirTRXa/+Fw=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdJSZe+mDU4Z2Oa4594em6Oktg6ydpyfgVmmfXix+7V +os9VSjo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEykPZbhf+xVW4G/Spel1zXb N7wQ6HifPqvotvYcR5HzRpsbZm1ZfpSR4VfhyonXRe76pWQoBrgeXVT6aH6Hxt7tVgmunNnlW8u YmQE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mapping from PGD/PUD/PMD to levels and shifts is very confusing,
given that, due to folding, the shifts may be equal for different
levels, if the macros are even #define'd to begin with.

In a subsequent patch, we will modify the ID mapping code to decouple
the number of levels from the kernel's view of how these types are
folded, so prepare for this by reformulating the macros without the use
of these types.

Instead, use SWAPPER_BLOCK_SHIFT as the base quantity, and derive it
from either PAGE_SHIFT or PMD_SHIFT, which -if defined at all- are
defined unambiguously for a given page size, regardless of the number of
configured levels.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/kernel-pgtable.h | 65 ++++++--------------
 1 file changed, 19 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 2a2c80ffe59e5307..bfc35944a5304e8e 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -13,27 +13,22 @@
 #include <asm/sparsemem.h>
 
 /*
- * The linear mapping and the start of memory are both 2M aligned (per
- * the arm64 booting.txt requirements). Hence we can use section mapping
- * with 4K (section size = 2M) but not with 16K (section size = 32M) or
- * 64K (section size = 512M).
+ * The physical and virtual addresses of the start of the kernel image are
+ * equal modulo 2 MiB (per the arm64 booting.txt requirements). Hence we can
+ * use section mapping with 4K (section size = 2M) but not with 16K (section
+ * size = 32M) or 64K (section size = 512M).
  */
-
-/*
- * The idmap and swapper page tables need some space reserved in the kernel
- * image. Both require pgd, pud (4 levels only) and pmd tables to (section)
- * map the kernel. With the 64K page configuration, swapper and idmap need to
- * map to pte level. The swapper also maps the FDT (see __create_page_tables
- * for more information). Note that the number of ID map translation levels
- * could be increased on the fly if system RAM is out of reach for the default
- * VA range, so pages required to map highest possible PA are reserved in all
- * cases.
- */
-#ifdef CONFIG_ARM64_4K_PAGES
-#define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS - 1)
+#if defined(PMD_SIZE) && PMD_SIZE <= MIN_KIMG_ALIGN
+#define SWAPPER_BLOCK_SHIFT	PMD_SHIFT
+#define SWAPPER_SKIP_LEVEL	1
 #else
-#define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS)
+#define SWAPPER_BLOCK_SHIFT	PAGE_SHIFT
+#define SWAPPER_SKIP_LEVEL	0
 #endif
+#define SWAPPER_BLOCK_SIZE	(UL(1) << SWAPPER_BLOCK_SHIFT)
+#define SWAPPER_TABLE_SHIFT	(SWAPPER_BLOCK_SHIFT + PAGE_SHIFT - 3)
+
+#define SWAPPER_PGTABLE_LEVELS		(CONFIG_PGTABLE_LEVELS - SWAPPER_SKIP_LEVEL)
 
 #define IDMAP_LEVELS		ARM64_HW_PGTABLE_LEVELS(48)
 #define IDMAP_ROOT_LEVEL	(4 - IDMAP_LEVELS)
@@ -64,24 +59,13 @@
 #define EARLY_ENTRIES(vstart, vend, shift, add) \
 	((((vend) - 1) >> (shift)) - ((vstart) >> (shift)) + 1 + add)
 
-#define EARLY_PGDS(vstart, vend, add) (EARLY_ENTRIES(vstart, vend, PGDIR_SHIFT, add))
-
-#if SWAPPER_PGTABLE_LEVELS > 3
-#define EARLY_PUDS(vstart, vend, add) (EARLY_ENTRIES(vstart, vend, PUD_SHIFT, add))
-#else
-#define EARLY_PUDS(vstart, vend, add) (0)
-#endif
+#define EARLY_LEVEL(l, vstart, vend, add)	\
+	(SWAPPER_PGTABLE_LEVELS > l ? EARLY_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + l * (PAGE_SHIFT - 3), add) : 0)
 
-#if SWAPPER_PGTABLE_LEVELS > 2
-#define EARLY_PMDS(vstart, vend, add) (EARLY_ENTRIES(vstart, vend, SWAPPER_TABLE_SHIFT, add))
-#else
-#define EARLY_PMDS(vstart, vend, add) (0)
-#endif
-
-#define EARLY_PAGES(vstart, vend, add) ( 1 			/* PGDIR page */				\
-			+ EARLY_PGDS((vstart), (vend), add) 	/* each PGDIR needs a next level page table */	\
-			+ EARLY_PUDS((vstart), (vend), add)	/* each PUD needs a next level page table */	\
-			+ EARLY_PMDS((vstart), (vend), add))	/* each PMD needs a next level page table */
+#define EARLY_PAGES(vstart, vend, add) (1 	/* PGDIR page */				\
+	+ EARLY_LEVEL(3, (vstart), (vend), add) /* each entry needs a next level page table */	\
+	+ EARLY_LEVEL(2, (vstart), (vend), add)	/* each entry needs a next level page table */	\
+	+ EARLY_LEVEL(1, (vstart), (vend), add))/* each entry needs a next level page table */
 #define INIT_DIR_SIZE (PAGE_SIZE * (EARLY_PAGES(KIMAGE_VADDR, _end, EARLY_KASLR) + EARLY_SEGMENT_EXTRA_PAGES))
 
 /* the initial ID map may need two extra pages if it needs to be extended */
@@ -92,17 +76,6 @@
 #endif
 #define INIT_IDMAP_DIR_PAGES	EARLY_PAGES(KIMAGE_VADDR, _end + MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE, 1)
 
-/* Initial memory map size */
-#ifdef CONFIG_ARM64_4K_PAGES
-#define SWAPPER_BLOCK_SHIFT	PMD_SHIFT
-#define SWAPPER_BLOCK_SIZE	PMD_SIZE
-#define SWAPPER_TABLE_SHIFT	PUD_SHIFT
-#else
-#define SWAPPER_BLOCK_SHIFT	PAGE_SHIFT
-#define SWAPPER_BLOCK_SIZE	PAGE_SIZE
-#define SWAPPER_TABLE_SHIFT	PMD_SHIFT
-#endif
-
 /* The number of segments in the kernel image (text, rodata, inittext, initdata, data+bss) */
 #define KERNEL_SEGMENT_COUNT	5
 
-- 
2.39.2

