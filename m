Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13938637377
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKXINA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiKXIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:12:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102C7D237B;
        Thu, 24 Nov 2022 00:12:01 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:11:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669277519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkboDhnIm8nCsSCjlZpVh9iMQ8Wke4eddVhfLMFSwcc=;
        b=ZfRmp5AmvzpFPDbb2tnH5EnvqO3CRdtsAp7GsdIlvnsfDC+4uyEQfTcIRrzBTfDFRh6tqu
        x7xKnU2qcBhaAQKy89mqqGOqImmm4JRQXYo+NTcF6JMswUwhoFPYXWxxXMAIxE96hJ/wJi
        Ei/43mOToTwUo6dUbpmQMPN693qpMdns9CgVsIc34hvas/BHp5rmNwADKkTcKSruxFHfOc
        iKkVERhyRyQxVqqUfL5sicDqxrb3u3gNVBx/ORGehH/wvJgWG4kZ/Dk3Xr9emapjpBNVfc
        gl5kjZq9F7rlgxc0a1TDLNydFHatHWBU6RFxhDtikOqYo2UjpxehDGzI19mnnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669277519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkboDhnIm8nCsSCjlZpVh9iMQ8Wke4eddVhfLMFSwcc=;
        b=dHNcxjQRCy6WYgA3IUSMur7ft8H8kA0jEDQ2gFS0hX6m+UwIXpKC6ZxaXN7X6wJE+JiBY9
        skDcvpLfWfHgnqDA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/efi: Make the deprecated EFI handover protocol optional
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122161017.2426828-18-ardb@kernel.org>
References: <20221122161017.2426828-18-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <166927751790.4906.9771581383533870976.tip-bot2@tip-bot2>
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

Commit-ID:     cc3fdda2876e58a7e83e558ab51853cf106afb6a
Gitweb:        https://git.kernel.org/tip/cc3fdda2876e58a7e83e558ab51853cf106afb6a
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 22 Nov 2022 17:10:17 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 24 Nov 2022 08:57:41 +01:00

x86/efi: Make the deprecated EFI handover protocol optional

The EFI handover protocol permits a bootloader to invoke the kernel as a
EFI PE/COFF application, while passing a bootparams struct as a third
argument to the entrypoint function call.

This has no basis in the UEFI specification, and there are better ways
to pass additional data to a UEFI application (UEFI configuration
tables, UEFI variables, UEFI protocols) than going around the
StartImage() boot service and jumping to a fixed offset in the loaded
image, just to call a different function that takes a third parameter.

The reason for handling struct bootparams in the bootloader was that the
EFI stub could only load initrd images from the EFI system partition,
and so passing it via struct bootparams was needed for loaders like
GRUB, which pass the initrd in memory, and may load it from anywhere,
including from the network. Another motivation was EFI mixed mode, which
could not use the initrd loader in the EFI stub at all due to 32/64 bit
incompatibilities (which will be fixed shortly [0]), and could not
invoke the ordinary PE/COFF entry point either, for the same reasons.

Given that loaders such as GRUB already carried the bootparams handling
in order to implement non-EFI boot, retaining that code and just passing
bootparams to the EFI stub was a reasonable choice (although defining an
alternate entrypoint could have been avoided.) However, the GRUB side
changes never made it upstream, and are only shipped by some of the
distros in their downstream versions.

In the meantime, EFI support has been added to other Linux architecture
ports, as well as to U-boot and systemd, including arch-agnostic methods
for passing initrd images in memory [1], and for doing mixed mode boot
[2], none of them requiring anything like the EFI handover protocol. So
given that only out-of-tree distro GRUB relies on this, let's permit it
to be omitted from the build, in preparation for retiring it completely
at a later date. (Note that systemd-boot does have an implementation as
well, but only uses it as a fallback for booting images that do not
implement the LoadFile2 based initrd loading method, i.e., v5.8 or older)

[0] https://lore.kernel.org/all/20220927085842.2860715-1-ardb@kernel.org/
[1] ec93fc371f01 ("efi/libstub: Add support for loading the initrd from a device path")
[2] 97aa276579b2 ("efi/x86: Add true mixed mode entry point into .compat section")

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221122161017.2426828-18-ardb@kernel.org
---
 arch/x86/Kconfig                   | 17 +++++++++++++++++
 arch/x86/boot/compressed/head_64.S |  4 +++-
 arch/x86/boot/header.S             |  2 +-
 arch/x86/boot/tools/build.c        |  2 ++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ce..a0fb836 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1980,6 +1980,23 @@ config EFI_STUB
 
 	  See Documentation/admin-guide/efi-stub.rst for more information.
 
+config EFI_HANDOVER_PROTOCOL
+	bool "EFI handover protocol (DEPRECATED)"
+	depends on EFI_STUB
+	default y
+	help
+	  Select this in order to include support for the deprecated EFI
+	  handover protocol, which defines alternative entry points into the
+	  EFI stub.  This is a practice that has no basis in the UEFI
+	  specification, and requires a priori knowledge on the part of the
+	  bootloader about Linux/x86 specific ways of passing the command line
+	  and initrd, and where in memory those assets may be loaded.
+
+	  If in doubt, say Y. Even though the corresponding support is not
+	  present in upstream GRUB or other bootloaders, most distros build
+	  GRUB with numerous downstream patches applied, and may rely on the
+	  handover protocol as as result.
+
 config EFI_MIXED
 	bool "EFI mixed-mode support"
 	depends on EFI_STUB && X86_64
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 6ba2c21..d4c4281 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -286,7 +286,7 @@ SYM_FUNC_START(startup_32)
 	lret
 SYM_FUNC_END(startup_32)
 
-#ifdef CONFIG_EFI_MIXED
+#if IS_ENABLED(CONFIG_EFI_MIXED) && IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL)
 	.org 0x190
 SYM_FUNC_START(efi32_stub_entry)
 	add	$0x4, %esp		/* Discard return address */
@@ -516,7 +516,9 @@ trampoline_return:
 SYM_CODE_END(startup_64)
 
 #ifdef CONFIG_EFI_STUB
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 	.org 0x390
+#endif
 SYM_FUNC_START(efi64_stub_entry)
 	and	$~0xf, %rsp			/* realign the stack */
 	movq	%rdx, %rbx			/* save boot_params pointer */
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index f912d77..d319825 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -406,7 +406,7 @@ xloadflags:
 # define XLF1 0
 #endif
 
-#ifdef CONFIG_EFI_STUB
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 # ifdef CONFIG_EFI_MIXED
 #  define XLF23 (XLF_EFI_HANDOVER_32|XLF_EFI_HANDOVER_64)
 # else
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index a3725ad..bd24769 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -290,6 +290,7 @@ static void efi_stub_entry_update(void)
 {
 	unsigned long addr = efi32_stub_entry;
 
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 #ifdef CONFIG_X86_64
 	/* Yes, this is really how we defined it :( */
 	addr = efi64_stub_entry - 0x200;
@@ -299,6 +300,7 @@ static void efi_stub_entry_update(void)
 	if (efi32_stub_entry != addr)
 		die("32-bit and 64-bit EFI entry points do not match\n");
 #endif
+#endif
 	put_unaligned_le32(addr, &buf[0x264]);
 }
 
