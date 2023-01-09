Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37497662EE0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjAISYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbjAISXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:23:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9721742F;
        Mon,  9 Jan 2023 10:22:09 -0800 (PST)
Date:   Mon, 09 Jan 2023 18:22:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673288527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxUE5+XksKmk8epgtBLjOnSZAYwxSlXPBiNLgSC8nOs=;
        b=WO+ScrwNm1G3dwVVRZWH82b5wbui1x4IOb9kfUff5hGxu8wGIFH4dJb5MHLPnGdE+1E3rw
        iUbQUI6uD7axCpPo8WBrvhdAdT3Dhk3N+PvGDAijZMa40M1Rd7md/NZgxeIuNoL66ym3PD
        wo9WJQM722TyjIjLzALPRFP1A0YfttN5O9Q3ZL45vZ+0mNyQuumAKnFJ/V0TwMyabFaHYU
        bkjo5vFVFAeVyEQtHYLFxs7H1CWY7C4+IaOVqCGuMAIG4DUxQ6VVICkXIKcM23iPgRtYsw
        RBbqA7wgxEtlH+y0ZUSMVdbkSvRN6PxqGJSax7yiXbm0vzvNF0XW/CY3Q7C2cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673288527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxUE5+XksKmk8epgtBLjOnSZAYwxSlXPBiNLgSC8nOs=;
        b=X4graGIgESoX3PmtaJ/lgDbCjMw0PHATnbSRnKfnbsb0ZbxLuS8ihZb0CG1d3PWb6MxKii
        DXU7RM5SxyrgEvDg==
From:   "tip-bot2 for Alexander Lobakin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Robustify calling startup_{32,64}() from
 the decompressor code
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230109170403.4117105-2-alexandr.lobakin@intel.com>
References: <20230109170403.4117105-2-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Message-ID: <167328852741.4906.2981279054381045296.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     7734a0f31e99c433df3063bbb7e8ee5a16a2cb82
Gitweb:        https://git.kernel.org/tip/7734a0f31e99c433df3063bbb7e8ee5a16a2cb82
Author:        Alexander Lobakin <alexandr.lobakin@intel.com>
AuthorDate:    Mon, 09 Jan 2023 18:04:02 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 18:22:21 +01:00

x86/boot: Robustify calling startup_{32,64}() from the decompressor code

After commit ce697ccee1a8 ("kbuild: remove head-y syntax"), I
started digging whether x86 is ready for removing this old cruft.
Removing its objects from the list makes the kernel unbootable.
This applies only to bzImage, vmlinux still works correctly.
The reason is that with no strict object order determined by the
linker arguments, not the linker script, startup_64 can be placed
not right at the beginning of the kernel.
Here's vmlinux.map's beginning before removing:

  ffffffff81000000         vmlinux.o:(.head.text)
  ffffffff81000000                 startup_64
  ffffffff81000070                 secondary_startup_64
  ffffffff81000075                 secondary_startup_64_no_verify
  ffffffff81000160                 verify_cpu

and after:

  ffffffff81000000         vmlinux.o:(.head.text)
  ffffffff81000000                 pvh_start_xen
  ffffffff81000080                 startup_64
  ffffffff810000f0                 secondary_startup_64
  ffffffff810000f5                 secondary_startup_64_no_verify

Not a problem itself, but the self-extractor code has the address of
that function hardcoded the beginning, not looking onto the ELF
header, which always contains the address of startup_{32,64}().

So, instead of doing an "act of blind faith", just take the address
from the ELF header and extract a relative offset to the entry
point. The decompressor function already returns a pointer to the
beginning of the kernel to the Asm code, which then jumps to it,
so add that offset to the return value.
This doesn't change anything for now, but allows to resign from the
"head object list" for x86 and makes sure valid Kbuild or any other
improvements won't break anything here in general.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20230109170403.4117105-2-alexandr.lobakin@intel.com
---
 arch/x86/boot/compressed/head_32.S |  2 +-
 arch/x86/boot/compressed/head_64.S |  2 +-
 arch/x86/boot/compressed/misc.c    | 18 +++++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 6589ddd..987ae72 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -187,7 +187,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	leal	boot_heap@GOTOFF(%ebx), %eax
 	pushl	%eax			/* heap area */
 	pushl	%esi			/* real mode pointer */
-	call	extract_kernel		/* returns kernel location in %eax */
+	call	extract_kernel		/* returns kernel entry point in %eax */
 	addl	$24, %esp
 
 /*
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a757129..03c4328 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -569,7 +569,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	movl	input_len(%rip), %ecx	/* input_len */
 	movq	%rbp, %r8		/* output target address */
 	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
-	call	extract_kernel		/* returns kernel location in %rax */
+	call	extract_kernel		/* returns kernel entry point in %rax */
 	popq	%rsi
 
 /*
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index cf690d8..014ff22 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -277,7 +277,7 @@ static inline void handle_relocations(void *output, unsigned long output_len,
 { }
 #endif
 
-static void parse_elf(void *output)
+static size_t parse_elf(void *output)
 {
 #ifdef CONFIG_X86_64
 	Elf64_Ehdr ehdr;
@@ -293,10 +293,8 @@ static void parse_elf(void *output)
 	if (ehdr.e_ident[EI_MAG0] != ELFMAG0 ||
 	   ehdr.e_ident[EI_MAG1] != ELFMAG1 ||
 	   ehdr.e_ident[EI_MAG2] != ELFMAG2 ||
-	   ehdr.e_ident[EI_MAG3] != ELFMAG3) {
+	   ehdr.e_ident[EI_MAG3] != ELFMAG3)
 		error("Kernel is not a valid ELF file");
-		return;
-	}
 
 	debug_putstr("Parsing ELF... ");
 
@@ -328,6 +326,8 @@ static void parse_elf(void *output)
 	}
 
 	free(phdrs);
+
+	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
 /*
@@ -356,6 +356,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	unsigned long needed_size;
+	size_t entry_offset;
 
 	/* Retain x86 boot parameters pointer passed from startup_32/64. */
 	boot_params = rmode;
@@ -456,14 +457,17 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	debug_putstr("\nDecompressing Linux... ");
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
-	parse_elf(output);
+	entry_offset = parse_elf(output);
 	handle_relocations(output, output_len, virt_addr);
-	debug_putstr("done.\nBooting the kernel.\n");
+
+	debug_putstr("done.\nBooting the kernel (entry_offset: 0x");
+	debug_puthex(entry_offset);
+	debug_putstr(").\n");
 
 	/* Disable exception handling before booting the kernel */
 	cleanup_exception_handling();
 
-	return output;
+	return output + entry_offset;
 }
 
 void fortify_panic(const char *name)
