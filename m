Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BAD70B634
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjEVHQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjEVHPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75D5CA;
        Mon, 22 May 2023 00:15:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CBB061DC4;
        Mon, 22 May 2023 07:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAEFC433EF;
        Mon, 22 May 2023 07:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684739715;
        bh=hFZ/SCviIEc1YZbiLBLlEDyweQ6PGSxYwFHksamIzHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hz/XLYpwvrB7eaE67rIp6oVZcPncDEeoJ1HK+tnyQVcUCtXSHsbtsqPkd8b+q6RAT
         ZKfyjLbFV7cR2whGTuHdlUIvZT8cdvhBpe3lhbO6U9lffuWe2Tj3qFECI2hjnIyYpT
         uMkW92CnW/NWGG+IJ4qnp9ow11jZtgz7G6CdiN6OjrQ8dK9z8+LtMJQm8WuxcRJy5P
         7QpuutM9ZljLjE83bqk3d/qSZPksgzgMO7Wf/FG5bfUEgPYezQ8xwYzWbRwLeEODq5
         Xu4TCQTn8mY3nybucf17nyxw6gg3XkiWZpZElvymw03DzBd2SAmMdcjhcng0/0bvyv
         iWtsyc3P1mXfg==
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
Subject: [PATCH v3 10/21] x86/decompressor: Call trampoline directly from C code
Date:   Mon, 22 May 2023 09:14:04 +0200
Message-Id: <20230522071415.501717-11-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522071415.501717-1-ardb@kernel.org>
References: <20230522071415.501717-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4966; i=ardb@kernel.org; h=from:subject; bh=hFZ/SCviIEc1YZbiLBLlEDyweQ6PGSxYwFHksamIzHs=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVbzPL8sq2/X/qHu2RslN1qcKxny6qQhYuW/epuYZguW MS46tj8jlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRoyGMDId17vRVz82v/sNW 3LB74ubOr+6SR34XTX9+UuHX+vULoh4x/OGZ2Gx+NysqlrmRZ573db4utlXfpc6IrTXQzc8zuWX xkgsA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of returning to the asm calling code to invoke the trampoline,
call it straight from the C code that sets the scene. That way, the
struct return type is no longer needed for returning two values, and the
call can be made conditional more cleanly in a subsequent patch.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 20 +++-----------
 arch/x86/boot/compressed/pgtable_64.c | 28 ++++++++------------
 2 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 741b4e8fefc915ea..a60ec9283bd760e3 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -430,24 +430,12 @@ SYM_CODE_START(startup_64)
 #endif
 
 	/*
-	 * paging_prepare() sets up the trampoline and checks if we need to
-	 * enable 5-level paging.
-	 *
-	 * paging_prepare() returns a two-quadword structure which lands
-	 * into RDX:RAX:
-	 *   - Address of the trampoline is returned in RAX.
-	 *   - Non zero RDX means trampoline needs to enable 5-level
-	 *     paging.
-	 *
+	 * set_paging_levels() updates the number of paging levels using a
+	 * trampoline in 32-bit addressable memory if the current number does
+	 * not match the desired number.
 	 */
 	movq	%r15, %rdi		/* pass struct boot_params pointer */
-	call	paging_prepare
-
-	/* Pass the trampoline address and boolean flag as args #1 and #2 */
-	movq	%rax, %rdi
-	movq	%rdx, %rsi
-	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
-	call	*%rax
+	call	set_paging_levels
 
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 09fc18180929fab3..b62b6819dcdd01be 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -16,11 +16,6 @@ unsigned int __section(".data") pgdir_shift = 39;
 unsigned int __section(".data") ptrs_per_p4d = 1;
 #endif
 
-struct paging_config {
-	unsigned long trampoline_start;
-	unsigned long l5_required;
-};
-
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 
@@ -106,10 +101,10 @@ static unsigned long find_trampoline_placement(void)
 	return bios_start - TRAMPOLINE_32BIT_SIZE;
 }
 
-struct paging_config paging_prepare(void *rmode)
+asmlinkage void set_paging_levels(void *rmode)
 {
-	struct paging_config paging_config = {};
-	void *tramp_code;
+	void (*toggle_la57)(void *trampoline, bool enable_5lvl);
+	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
 	boot_params = rmode;
@@ -130,12 +125,10 @@ struct paging_config paging_prepare(void *rmode)
 			!cmdline_find_option_bool("no5lvl") &&
 			native_cpuid_eax(0) >= 7 &&
 			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
-		paging_config.l5_required = 1;
+		l5_required = true;
 	}
 
-	paging_config.trampoline_start = find_trampoline_placement();
-
-	trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
+	trampoline_32bit = (unsigned long *)find_trampoline_placement();
 
 	/* Preserve trampoline memory */
 	memcpy(trampoline_save, trampoline_32bit, TRAMPOLINE_32BIT_SIZE);
@@ -144,7 +137,7 @@ struct paging_config paging_prepare(void *rmode)
 	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
 
 	/* Copy trampoline code in place */
-	tramp_code = memcpy(trampoline_32bit +
+	toggle_la57 = memcpy(trampoline_32bit +
 			TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
 			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
 
@@ -154,7 +147,8 @@ struct paging_config paging_prepare(void *rmode)
 	 * immediate absolute address, so we have to adjust that based on the
 	 * placement of the trampoline.
 	 */
-	*(u32 *)(tramp_code + trampoline_ljmp_imm_offset) += (unsigned long)tramp_code;
+	*(u32 *)((u8 *)toggle_la57 + trampoline_ljmp_imm_offset) +=
+						(unsigned long)toggle_la57;
 
 	/*
 	 * The code below prepares page table in trampoline memory.
@@ -170,10 +164,10 @@ struct paging_config paging_prepare(void *rmode)
 	 * We are not going to use the page table in trampoline memory if we
 	 * are already in the desired paging mode.
 	 */
-	if (paging_config.l5_required == !!(native_read_cr4() & X86_CR4_LA57))
+	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
 		goto out;
 
-	if (paging_config.l5_required) {
+	if (l5_required) {
 		/*
 		 * For 4- to 5-level paging transition, set up current CR3 as
 		 * the first and the only entry in a new top-level page table.
@@ -196,7 +190,7 @@ struct paging_config paging_prepare(void *rmode)
 	}
 
 out:
-	return paging_config;
+	toggle_la57(trampoline_32bit, l5_required);
 }
 
 void cleanup_trampoline(void *pgtable)
-- 
2.39.2

