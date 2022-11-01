Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E65614F14
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKAQU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKAQU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:20:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB6C1C903
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667319625; x=1698855625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lbpBDH90w4tbkgFgWIYQaC3aPZqBsU4jJJZ0iR+lNew=;
  b=G54KAkfe6Izr8B/5/mVeQRm80hkkTeocrIxUoUoNlwxejCiyWHFeLS8A
   KF6dfu1I8TrC7qmzsTVY+aF+53QokPgcCB4X/zglZJaQuI/sVzsPt7bZD
   2Ht+/uMbffXhTbqWVu5woY3jXpQ+fk3lvFKMgUFeSMOXLmOQf4Su2Uwmv
   dxRGjGTyFVUhz6wj3o3m2D/iuRr0DgaowbQwG2gqawMMPV6u0Z0z8gpiw
   LdVKwpF0mfZoWjr3tomDOLR97RqkQieCbO4nepBCruE/ibMym+91P04Ej
   v+Rsr6N+sEOdCynCrETuE0Je683SUWI92ys16Hp2JP9zhkIJYhCOfWgBk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="309175943"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="309175943"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 09:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="628623930"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="628623930"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga007.jf.intel.com with ESMTP; 01 Nov 2022 09:19:38 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2A1GJa8B019884;
        Tue, 1 Nov 2022 16:19:37 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/boot: robustify calling startup_{32,64}() from the decompressor code
Date:   Tue,  1 Nov 2022 17:15:28 +0100
Message-Id: <20221101161529.1634188-2-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101161529.1634188-1-alexandr.lobakin@intel.com>
References: <20221101161529.1634188-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Tested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 arch/x86/boot/compressed/head_32.S |  2 +-
 arch/x86/boot/compressed/head_64.S |  2 +-
 arch/x86/boot/compressed/misc.c    | 16 ++++++++++------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 3b354eb9516d..56f9847e208b 100644
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
index d33f060900d2..aeba5aa3d26c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -593,7 +593,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	movl	input_len(%rip), %ecx	/* input_len */
 	movq	%rbp, %r8		/* output target address */
 	movl	output_len(%rip), %r9d	/* decompressed length, end of relocs */
-	call	extract_kernel		/* returns kernel location in %rax */
+	call	extract_kernel		/* returns kernel entry point in %rax */
 	popq	%rsi
 
 /*
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index cf690d8712f4..2548d7fb243e 100644
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
@@ -287,16 +287,15 @@ static void parse_elf(void *output)
 	Elf32_Phdr *phdrs, *phdr;
 #endif
 	void *dest;
+	size_t off;
 	int i;
 
 	memcpy(&ehdr, output, sizeof(ehdr));
 	if (ehdr.e_ident[EI_MAG0] != ELFMAG0 ||
 	   ehdr.e_ident[EI_MAG1] != ELFMAG1 ||
 	   ehdr.e_ident[EI_MAG2] != ELFMAG2 ||
-	   ehdr.e_ident[EI_MAG3] != ELFMAG3) {
+	   ehdr.e_ident[EI_MAG3] != ELFMAG3)
 		error("Kernel is not a valid ELF file");
-		return;
-	}
 
 	debug_putstr("Parsing ELF... ");
 
@@ -305,6 +304,7 @@ static void parse_elf(void *output)
 		error("Failed to allocate space for phdrs");
 
 	memcpy(phdrs, output + ehdr.e_phoff, sizeof(*phdrs) * ehdr.e_phnum);
+	off = ehdr.e_entry - phdrs->p_paddr;
 
 	for (i = 0; i < ehdr.e_phnum; i++) {
 		phdr = &phdrs[i];
@@ -328,6 +328,8 @@ static void parse_elf(void *output)
 	}
 
 	free(phdrs);
+
+	return off;
 }
 
 /*
@@ -356,6 +358,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	unsigned long needed_size;
+	size_t off;
 
 	/* Retain x86 boot parameters pointer passed from startup_32/64. */
 	boot_params = rmode;
@@ -456,14 +459,15 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	debug_putstr("\nDecompressing Linux... ");
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
-	parse_elf(output);
+	off = parse_elf(output);
+	debug_putaddr(off);
 	handle_relocations(output, output_len, virt_addr);
 	debug_putstr("done.\nBooting the kernel.\n");
 
 	/* Disable exception handling before booting the kernel */
 	cleanup_exception_handling();
 
-	return output;
+	return output + off;
 }
 
 void fortify_panic(const char *name)
-- 
2.38.1

