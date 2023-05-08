Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1B26FA07F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjEHHFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjEHHEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:04:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C23E1C0F7;
        Mon,  8 May 2023 00:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9322861F96;
        Mon,  8 May 2023 07:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4069FC433D2;
        Mon,  8 May 2023 07:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529454;
        bh=Cbgin3O3w5TrAUQhn3/olaZs0A4XgRk35uCUUkZRmeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENwWEqdCtVzf0zk6FhW1aJ99HkXt7BD5OjSafuLC9oHhpagtOXKtTghetJRs30NXs
         AH4NNjgyAufSkCxPa/060OQepjjrZSpiPmY2UWaOfGj73FAiHYvN8i/MhyHnJ0hsyV
         5R+6Ocy4N1dbrLMbcPmBYAlCJ3yxdwytYS6+o5CGLbvuEQ3p943QppwiEetM6cRR2O
         yLuyDI9g+e+tsK57ufIJd1hWztDtOHC3NIVG+53/jw6ix+smS//QaX//nx5rX3TYrD
         7c7oJKdB0e1BIz6jo9xPVmoiiJ6YRreRNoaZy6yUC7eiZYw5sPT1bRtc37BPunbBNm
         rZS7DICb36CbQ==
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
Subject: [PATCH v2 08/20] x86: decompressor: Merge trampoline cleanup with switching code
Date:   Mon,  8 May 2023 09:03:18 +0200
Message-Id: <20230508070330.582131-9-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4104; i=ardb@kernel.org; h=from:subject; bh=Cbgin3O3w5TrAUQhn3/olaZs0A4XgRk35uCUUkZRmeM=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3ubiDVq+31j5S78ITuP8/KjtsUHPLWmfkgnW5QLuf Gq7TrB2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIk8fsPwP7KoU8HwhMCMeQ+C fzKFZn3n2HKkWmNxvsSrpvwdfy8vv8bIcLujhnG+p/X94lkrLuSnqF5lnn58WYJA1BKtpSdyv99 R5AcA
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

Now that the trampoline setup code and the actual invocation of it are
all done from the C routine, we can merge the trampoline cleanup into
that as well, instead of returning to asm just to call another C
function.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 13 +++------
 arch/x86/boot/compressed/pgtable_64.c | 28 ++++++++------------
 2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index ccdfe7e55c36a40f..21af9cfd0dd0afb7 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -440,19 +440,14 @@ SYM_CODE_START(startup_64)
 	 * set_paging_levels() updates the number of paging levels using a
 	 * trampoline in 32-bit addressable memory if the current number does
 	 * not match the desired number.
+	 *
+	 * RSI is the relocated address of the page table to use instead of
+	 * page table in trampoline memory (if required).
 	 */
 	movq	%r15, %rdi		/* pass struct boot_params pointer */
+	leaq	rva(top_pgtable)(%rbx), %rsi
 	call	set_paging_levels
 
-	/*
-	 * cleanup_trampoline() would restore trampoline memory.
-	 *
-	 * RDI is address of the page table to use instead of page table
-	 * in trampoline memory (if required).
-	 */
-	leaq	rva(top_pgtable)(%rbx), %rdi
-	call	cleanup_trampoline
-
 	/* Zero EFLAGS */
 	pushq	$0
 	popfq
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index b92cf1d6e156d5f6..eeddad8c8335655e 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -101,9 +101,10 @@ static unsigned long find_trampoline_placement(void)
 	return bios_start - TRAMPOLINE_32BIT_SIZE;
 }
 
-asmlinkage void set_paging_levels(void *rmode)
+asmlinkage void set_paging_levels(void *rmode, void *pgtable)
 {
 	void (*toggle_la57)(void *trampoline, bool enable_5lvl);
+	void *trampoline_pgtable;
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
@@ -133,7 +134,7 @@ asmlinkage void set_paging_levels(void *rmode)
 	 * are already in the desired paging mode.
 	 */
 	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
-		return;
+		goto out;
 
 	trampoline_32bit = (unsigned long *)find_trampoline_placement();
 
@@ -163,6 +164,8 @@ asmlinkage void set_paging_levels(void *rmode)
 	 * The new page table will be used by trampoline code for switching
 	 * from 4- to 5-level paging or vice versa.
 	 */
+	trampoline_pgtable = trampoline_32bit +
+			     TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
 
 	if (l5_required) {
 		/*
@@ -182,31 +185,21 @@ asmlinkage void set_paging_levels(void *rmode)
 		 * may be above 4G.
 		 */
 		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
-		memcpy(trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long),
-		       (void *)src, PAGE_SIZE);
+		memcpy(trampoline_pgtable, (void *)src, PAGE_SIZE);
 	}
 
 	toggle_la57(trampoline_32bit, l5_required);
-}
-
-void cleanup_trampoline(void *pgtable)
-{
-	void *trampoline_pgtable;
-
-	trampoline_pgtable = trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
 
 	/*
-	 * Move the top level page table out of trampoline memory,
-	 * if it's there.
+	 * Move the top level page table out of trampoline memory.
 	 */
-	if ((void *)__native_read_cr3() == trampoline_pgtable) {
-		memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
-		native_write_cr3((unsigned long)pgtable);
-	}
+	memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
+	native_write_cr3((unsigned long)pgtable);
 
 	/* Restore trampoline memory */
 	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
 
+out:
 	/* Initialize variables for 5-level paging */
 #ifdef CONFIG_X86_5LEVEL
 	if (__read_cr4() & X86_CR4_LA57) {
@@ -215,4 +208,5 @@ void cleanup_trampoline(void *pgtable)
 		ptrs_per_p4d = 512;
 	}
 #endif
+	return;
 }
-- 
2.39.2

