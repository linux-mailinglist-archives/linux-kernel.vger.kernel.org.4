Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ECD627C96
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiKNLoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiKNLoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA317079
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9867D61029
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CD5C4314F;
        Mon, 14 Nov 2022 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426240;
        bh=fqd76LHS4zm9yigkSD8GcXuhYRdtL6d9jVg6IEleNpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+HiDymiRneMmutFCHHvvrzFAnxG9Dq0+mCVxsufGjfUTGM/YEFWmQkgjxDWf1mL6
         ShTjzuG7e9ij94oNB8sexozmUuT8PeNan6720Nwi3Zrf9bY/g3p+aITf2OEv0IBwBR
         ninnop3pWqIQ1ZcNpA+PrmSMAY4lx9rE3hIPHzl4zfWhsQ2Rnt9EL3OJXqef9aut72
         V/YMZP1R0ltq3rg9sJABcAgRfxwQA+UhVteLabRAlscyHksSeRVfxVNa/Xu6zy+6vr
         jKv25Vh7nS+lZp8KqvAbUdVw/M3iorTIGV0Ch4ydgD6tULMsb1fh7DXvMF9gmuNvhF
         UwqHB7wWMMNWg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 01/46] x86/boot: robustify calling startup_{32,64}() from the decompressor code
Date:   Mon, 14 Nov 2022 12:42:59 +0100
Message-Id: <20221114114344.18650-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alexandr.lobakin@intel.com>

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
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
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

