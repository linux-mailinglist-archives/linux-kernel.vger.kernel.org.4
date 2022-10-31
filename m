Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A56139D5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiJaPQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJaPQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:16:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCBB11456
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667229399; x=1698765399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ij2hEDRZG6EMb0z+MYknc0l1TIq/FCdvq5UymJFqZws=;
  b=J0oKhm7WSP4v0rmrn1h9MkfD3e9V98o2lEcImV8v9p5RGIRc/dTgc/CU
   td8mlL0EEx76eB4nXn0qEKX7X7BnY3poHKqL5bBDhvb6kf/HHZQaceVQj
   UIvDcc4DaUnBVby1TQFjqgyJgAGhJ88XRxefAopNdAYMidrHKbmnjjdBV
   rSa6cXqgw9Hj4ekEBEoB450kFT4TBscO/z1E2hiqrvkoo7FLwqUrne7RF
   Brch808ZFAsCtRR+ELLA3lgBMH7bwgApKioJg620SqaKBNqdD5aza6df5
   1DmNNZBSSIk5DBMJABUz6tHIBe09YDMbt7T2TxDIvRw4YT7S5ENs7BDNR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="373134131"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="373134131"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 08:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="697045598"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="697045598"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga008.fm.intel.com with ESMTP; 31 Oct 2022 08:16:35 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 29VFGXGE008839;
        Mon, 31 Oct 2022 15:16:34 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/boot: robustify calling startup_{32,64}() from the decompressor code
Date:   Mon, 31 Oct 2022 16:10:46 +0100
Message-Id: <20221031151047.167288-2-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031151047.167288-1-alexandr.lobakin@intel.com>
References: <20221031151047.167288-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit ce697ccee1a8 ("kbuild: remove head-y syntax"), I
started digging whether x86 is ready from removing this old cruft.
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
---
 arch/x86/boot/compressed/head_32.S |  2 +-
 arch/x86/boot/compressed/head_64.S |  2 +-
 arch/x86/boot/compressed/misc.c    | 16 +++++++++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

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
index cf690d8712f4..96ae5af29f49 100644
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
@@ -287,6 +287,7 @@ static void parse_elf(void *output)
 	Elf32_Phdr *phdrs, *phdr;
 #endif
 	void *dest;
+	size_t off;
 	int i;
 
 	memcpy(&ehdr, output, sizeof(ehdr));
@@ -295,16 +296,19 @@ static void parse_elf(void *output)
 	   ehdr.e_ident[EI_MAG2] != ELFMAG2 ||
 	   ehdr.e_ident[EI_MAG3] != ELFMAG3) {
 		error("Kernel is not a valid ELF file");
-		return;
+		return 0;
 	}
 
 	debug_putstr("Parsing ELF... ");
 
 	phdrs = malloc(sizeof(*phdrs) * ehdr.e_phnum);
-	if (!phdrs)
+	if (!phdrs) {
 		error("Failed to allocate space for phdrs");
+		return 0;
+	}
 
 	memcpy(phdrs, output + ehdr.e_phoff, sizeof(*phdrs) * ehdr.e_phnum);
+	off = ehdr.e_entry - phdrs->p_paddr;
 
 	for (i = 0; i < ehdr.e_phnum; i++) {
 		phdr = &phdrs[i];
@@ -328,6 +332,7 @@ static void parse_elf(void *output)
 	}
 
 	free(phdrs);
+	return off;
 }
 
 /*
@@ -356,6 +361,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	unsigned long needed_size;
+	size_t off;
 
 	/* Retain x86 boot parameters pointer passed from startup_32/64. */
 	boot_params = rmode;
@@ -456,14 +462,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	debug_putstr("\nDecompressing Linux... ");
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
-	parse_elf(output);
+	off = parse_elf(output);
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

