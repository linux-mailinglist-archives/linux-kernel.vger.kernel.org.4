Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DF7720C85
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 02:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjFCAIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 20:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbjFCAIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:08:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF75E4C;
        Fri,  2 Jun 2023 17:08:47 -0700 (PDT)
Date:   Sat, 03 Jun 2023 00:08:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685750924;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6P1G25QWsEZ5DbnZw/dB6wiQ7RZxGRUDn/NXqnEWiIg=;
        b=bexkjkrPdtqy77aXvJ8DNa9vErXG+3VT3rgRkHm4DYcEmq5aVvEelTSX01+UfHNsHirs6t
        RqTva25Gwsfdv9+e0Nq4c6tGKWNBqqIxlxauBDVxPykAz3wZ8L97Ef8H80BePbaXfM9gWr
        FuZfTgD/8Vg6MSyBczFuekIkCT6FKAA2ZXS9PZLqnDlWrXQrDw+62mTgfqm6XiYfF4wX7R
        KEjtbeNjOYyfD+nTSLA0YQuKCtPRAU7gnXsbkTJ9WHxJn063GsA1N2P3Dml6jbvQusZ/y+
        nBFQGR9b9k667PW5WTVFcqMHMVszPOt1KK11IXFteZbIAlCemW7DuyxXw4YfJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685750924;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6P1G25QWsEZ5DbnZw/dB6wiQ7RZxGRUDn/NXqnEWiIg=;
        b=ehVSXyLsLs5KV4Rh4fIGujJ33DzQSOrrU7z/CJ8hufBHPtkzQFLWLW1ZsEvIQ+uWHeEn4L
        ScCzvW+gIMZvmlCw==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/head/64: Switch to KERNEL_CS as soon as new GDT
 is installed
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168575092411.404.3470065936057251897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a37f2699c36a7f6606ba3300f243227856c5ad6b
Gitweb:        https://git.kernel.org/tip/a37f2699c36a7f6606ba3300f243227856c5ad6b
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 17 May 2023 11:26:41 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 02 Jun 2023 16:59:57 -07:00

x86/head/64: Switch to KERNEL_CS as soon as new GDT is installed

The call to startup_64_setup_env() will install a new GDT but does not
actually switch to using the KERNEL_CS entry until returning from the
function call.

Commit bcce82908333 ("x86/sev: Detect/setup SEV/SME features earlier in
boot") moved the call to sme_enable() earlier in the boot process and in
between the call to startup_64_setup_env() and the switch to KERNEL_CS.
An SEV-ES or an SEV-SNP guest will trigger #VC exceptions during the call
to sme_enable() and if the CS pushed on the stack as part of the exception
and used by IRETQ is not mapped by the new GDT, then problems occur.
Today, the current CS when entering startup_64 is the kernel CS value
because it was set up by the decompressor code, so no issue is seen.

However, a recent patchset that looked to avoid using the legacy
decompressor during an EFI boot exposed this bug. At entry to startup_64,
the CS value is that of EFI and is not mapped in the new kernel GDT. So
when a #VC exception occurs, the CS value used by IRETQ is not valid and
the guest boot crashes.

Fix this issue by moving the block that switches to the KERNEL_CS value to
be done immediately after returning from startup_64_setup_env().

Fixes: bcce82908333 ("x86/sev: Detect/setup SEV/SME features earlier in boot")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/all/6ff1f28af2829cc9aea357ebee285825f90a431f.1684340801.git.thomas.lendacky%40amd.com
---
 arch/x86/kernel/head_64.S | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a5df3e9..113c133 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -77,6 +77,15 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	startup_64_setup_env
 	popq	%rsi
 
+	/* Now switch to __KERNEL_CS so IRET works reliably */
+	pushq	$__KERNEL_CS
+	leaq	.Lon_kernel_cs(%rip), %rax
+	pushq	%rax
+	lretq
+
+.Lon_kernel_cs:
+	UNWIND_HINT_END_OF_STACK
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
 	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
@@ -90,15 +99,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	popq	%rsi
 #endif
 
-	/* Now switch to __KERNEL_CS so IRET works reliably */
-	pushq	$__KERNEL_CS
-	leaq	.Lon_kernel_cs(%rip), %rax
-	pushq	%rax
-	lretq
-
-.Lon_kernel_cs:
-	UNWIND_HINT_END_OF_STACK
-
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
