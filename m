Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EDD63738B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiKXINk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiKXIMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C4EE6765;
        Thu, 24 Nov 2022 00:12:11 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277530;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qajjax1eWC2REHTJna7moQ3d6iO4svH4XKI/B4cd6qg=;
        b=bY9B3pZe0gcWm8FmivB9O+m+D+5SgfN5HzhIkg5vIx743E7XKus4bDln/WsAW8g6iHDE9R
        jDZ9cuC41RPgNa8y5xuaDlhU1brQbdZISyxOS4RWeTpi88nLoHmWQNv4eCj1N362dET9Mh
        VSqxdZCSeVhIL8M0DapoRXFWaqY3kjLBi6D5cbOS85zJA3ZnGyEG2ffg+ikofy7bVZEqGL
        N2FTlr/iNoCAxQbWvcEe9SGE2Gg39ukS8RD6mX2A7HzWPDEs5RjwWmpM0iccqyrBfV288q
        vGNTY8xiNPJ9Y7r+g7ljf5+WwZtmcA0G+kcieZgEKXkGXsxO7keHeW2poPLwGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277530;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qajjax1eWC2REHTJna7moQ3d6iO4svH4XKI/B4cd6qg=;
        b=O6Q1ZUA8tqKcb1xFeaVF+/uOtt1LCXji7OVdflAS68u+uJy05pW293ebAf+Wylr54Ec0BA
        47a42b4A2p/1iwCw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed, efi: Merge multiple definitions
 of image_offset into one
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-8-ardb@kernel.org>
References: <20221122161017.2426828-8-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927752922.4906.5158541220917207422.tip-bot2@tip-bot2>
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

Commit-ID:     4b52016247aeaa55ca3e3bc2e03cd91114c145c2
Gitweb:        https://git.kernel.org/tip/4b52016247aeaa55ca3e3bc2e03cd91114c145c2
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:07 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Nov 2022 08:55:55 +01:00

x86/boot/compressed, efi: Merge multiple definitions of image_offset into one

There is no need for head_32.S and head_64.S both declaring a copy of
the global 'image_offset' variable, so drop those and make the extern C
declaration the definition.

When image_offset is moved to the .c file, it needs to be placed
particularly in the .data section because it lands by default in the
.bss section which is cleared too late, in .Lrelocated, before the first
access to it and thus garbage gets read, leading to SEV guests exploding
in early boot.

This happens only when the SEV guest kernel is loaded through grub. If
supplied with qemu's -kernel command line option, that memory is always
cleared upfront by qemu and all is fine there.

  [ bp: Expand commit message with SEV aspect. ]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-8-ardb@kernel.org
---
 arch/x86/boot/compressed/head_32.S      | 4 ----
 arch/x86/boot/compressed/head_64.S      | 4 ----
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 3b354eb..6589ddd 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -208,10 +208,6 @@ SYM_DATA_START_LOCAL(gdt)
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
-#ifdef CONFIG_EFI_STUB
-SYM_DATA(image_offset, .long 0)
-#endif
-
 /*
  * Stack and heap for uncompression
  */
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 36f37f9..34d0395 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -718,10 +718,6 @@ SYM_DATA_START(boot32_idt)
 SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 #endif
 
-#ifdef CONFIG_EFI_STUB
-SYM_DATA(image_offset, .long 0)
-#endif
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	__HEAD
 	.code32
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 33a7811..a0bfd31 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -23,7 +23,7 @@
 
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
-extern u32 image_offset;
+u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
 
 static efi_status_t
