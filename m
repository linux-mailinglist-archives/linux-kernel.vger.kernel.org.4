Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC1E6FA089
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjEHHFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjEHHFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255A81A4AB;
        Mon,  8 May 2023 00:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A52F661F93;
        Mon,  8 May 2023 07:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53317C4339C;
        Mon,  8 May 2023 07:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529475;
        bh=PS6uh5wyY4cP3z3FsRLfK/TPFwIu+D7LfOjVysY9Mk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p7KBlAYirJZQt//TF3ysIWzDilAocdvTP2HTH52YAbAM5UNju9R1ZpKdeX59pj8QK
         eWnXW66BzWr4iczjl7FiLPAUTondZFOcr6/uhn2yuAQVvkimYUdE24sxy/O3zjMVB1
         KwbUK2Fx87db/UGL1kYpM/3Fyt+8xLvW7G+OraGl8CKB4YuX4LQNhVUI64nFFwCMVs
         RyE/iz5tUdozOJ62Q2M/AM8LAAQJhxvMZRsODojUipi0hTbgmsOghXvmwknqQsjuti
         Y3Ktp38OfALtBNNBIxkWK+9D14SPSH/wyYOxrNwvCjnqssVN9VenU1x78/MmZCqb0Z
         cLXwUsavUVZLg==
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
Subject: [PATCH v2 13/20] x86: decompressor: Factor out kernel decompression and relocation
Date:   Mon,  8 May 2023 09:03:23 +0200
Message-Id: <20230508070330.582131-14-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2967; i=ardb@kernel.org; h=from:subject; bh=PS6uh5wyY4cP3z3FsRLfK/TPFwIu+D7LfOjVysY9Mk0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3s4F7BdX2XS7fxG0VGxmDYx2tVrhIJHIus1JJbs2q qbARKujlIVBjINBVkyRRWD233c7T0+UqnWeJQszh5UJZAgDF6cATCTAh5HhuU5p+Ttz/pS41LbY yN5Jpz+GvY07INFnaVLUznVM80oyw/+S52qN15bUCCu8Mt3IvumxpN2mwuLpj/eIdF6e1tC0L4o NAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the decompressor sequence that invokes the decompressor,
parses the ELF and applies the relocations so that we will be able to
call it directly from the EFI stub.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.c | 28 ++++++++++++++++----
 arch/x86/include/asm/boot.h     |  8 ++++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 1cd40cb9fb4e5027..3635cbeaca1c03cf 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,11 +330,33 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+const unsigned long kernel_total_size = VO__end - VO__text;
+
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
 
 extern unsigned char input_data[];
 extern unsigned int input_len, output_len;
 
+unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
+				void (*error)(char *x))
+{
+	unsigned long entry;
+
+	if (!free_mem_ptr) {
+		free_mem_ptr     = (unsigned long)boot_heap;
+		free_mem_end_ptr = (unsigned long)boot_heap + sizeof(boot_heap);
+	}
+
+	if (__decompress(input_data, input_len, NULL, NULL, outbuf, output_len,
+			 NULL, error) < 0)
+		return ULONG_MAX;
+
+	entry = parse_elf(outbuf);
+	handle_relocations(outbuf, output_len, virt_addr);
+
+	return entry;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -354,7 +376,6 @@ extern unsigned int input_len, output_len;
  */
 asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 {
-	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	memptr heap = (memptr)boot_heap;
 	unsigned long needed_size;
@@ -457,10 +478,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
-	__decompress(input_data, input_len, NULL, NULL, output, output_len,
-			NULL, error);
-	entry_offset = parse_elf(output);
-	handle_relocations(output, output_len, virt_addr);
+	entry_offset = decompress_kernel(output, virt_addr, error);
 
 	debug_putstr("done.\nBooting the kernel (entry_offset: 0x");
 	debug_puthex(entry_offset);
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea3160d..4ae14339cb8cc72d 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -62,4 +62,12 @@
 # define BOOT_STACK_SIZE	0x1000
 #endif
 
+#ifndef __ASSEMBLY__
+extern unsigned int output_len;
+extern const unsigned long kernel_total_size;
+
+unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
+				void (*error)(char *x));
+#endif
+
 #endif /* _ASM_X86_BOOT_H */
-- 
2.39.2

