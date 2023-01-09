Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEFC662C52
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbjAIRKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbjAIRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:10:24 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C69D3E0EB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673284137; x=1704820137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oj8YO1zy1ZMlAyirTXbDMSpyy0WKKS3RhgQpZj0V60U=;
  b=EDlCe8IgmRTGUq7divlDrxxC8wNVjllJzsOwZ9OWL2WaGX/aogtpqr3h
   RnyrDzftpS8b75SmewqH8XBy4mNriT0Gj+YnlkbDXRbuVY+MWxeRDCRmH
   BVPOPQ67LV+UgqaQ+dv9XOe6QgDOOt2ovIpac3KHXqq85oMwTJo7bi5P9
   LnDnScumoYC7F0VC5WKv7CpziNEMCzeTEUPPT1ihxUn3ttY3qYNka+TiG
   R0+BhSOdd+epjWrXjAtLc2g4Bd4kOiQEKJNKliRL4fpK71w7G5dNBVhhh
   tH69gHKtJv/2i763FW6rlelktU4ZRlREtKTrQIQvPFkym8/SVgLSE7hKU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="310722820"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="310722820"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 09:05:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="725236432"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="725236432"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2023 09:05:13 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 309H5Bdx030759;
        Mon, 9 Jan 2023 17:05:12 GMT
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
Subject: [PATCH v3 1/2] x86/boot: robustify calling startup_{32,64}() from the decompressor code
Date:   Mon,  9 Jan 2023 18:04:02 +0100
Message-Id: <20230109170403.4117105-2-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109170403.4117105-1-alexandr.lobakin@intel.com>
References: <20230109170403.4117105-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/boot/compressed/misc.c    | 18 +++++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 6589ddd4cfaf..987ae727cf9f 100644
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
index a75712991df3..03c4328a88cb 100644
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
index cf690d8712f4..014ff222bf4b 100644
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
-- 
2.39.0

