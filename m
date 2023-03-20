Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE06C1CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjCTQvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjCTQty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:49:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5264C06;
        Mon, 20 Mar 2023 09:42:20 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SoWgfdBCQFXYRXc2gw3EFfiFz85wh0sWzg6rAlffUUo=;
        b=tFcX9xz/+SUIhaY8xGfjC8ZXOruu/9/PIVwjffQ4xZkNXxmAE/Ve9Q0kRK4uT6cpt/nz5K
        KUjzGStuiaFqGb78R7OwpSEpPwBW3rvuomeisTUEXpBEYnO3mlglvfcxoJL5mqzWOnAjnm
        obyutVBFJIkVtv0mgFaauEPaTa1dbzqbEgmjNNUb09GbvoHOODNAycKibgz6ozQ9NK+ELz
        ByFCR7qNjA94hU2dILijUfC5j+AbtDU1jA4GUXtNODSHV6hcEBu0uPbV2Vt94eP2qPaU4o
        Xbk6Ow2SdwvyDVCfVNfCk95Bwsmp8p2BMNTbghInhnt5Fv1AL6qo1bBrNuLYEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SoWgfdBCQFXYRXc2gw3EFfiFz85wh0sWzg6rAlffUUo=;
        b=G+ITuhvMgbxxTfADnY6kDHw0ohsuHsifkWDz0K/8GCNdXUipw7qnKmJKZIjvkBx3iL4AhZ
        cRYZ9OjCnaZbb5CA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Add Kconfig option for shadow stack
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933037103.5837.11623929936150441742.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     f7dabb27de62e121afc32c44748328841249e68f
Gitweb:        https://git.kernel.org/tip/f7dabb27de62e121afc32c44748328841249e68f
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:14:57 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:07 -07:00

x86/shstk: Add Kconfig option for shadow stack

Shadow stack provides protection for applications against function return
address corruption. It is active when the processor supports it, the
kernel has CONFIG_X86_SHADOW_STACK enabled, and the application is built
for the feature. This is only implemented for the 64-bit kernel. When it
is enabled, legacy non-shadow stack applications continue to work, but
without protection.

Since there is another feature that utilizes CET (Kernel IBT) that will
share implementation with shadow stacks, create CONFIG_CET to signify
that at least one CET feature is configured.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-3-rick.p.edgecombe%40intel.com
---
 arch/x86/Kconfig           | 24 ++++++++++++++++++++++++
 arch/x86/Kconfig.assembler |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf0..f03791b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1851,6 +1851,11 @@ config CC_HAS_IBT
 		  (CC_IS_CLANG && CLANG_VERSION >= 140000)) && \
 		  $(as-instr,endbr64)
 
+config X86_CET
+	def_bool n
+	help
+	  CET features configured (Shadow stack or IBT)
+
 config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
 	def_bool y
@@ -1858,6 +1863,7 @@ config X86_KERNEL_IBT
 	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
 	depends on !LD_IS_LLD || LLD_VERSION >= 140000
 	select OBJTOOL
+	select X86_CET
 	help
 	  Build the kernel with support for Indirect Branch Tracking, a
 	  hardware support course-grain forward-edge Control Flow Integrity
@@ -1952,6 +1958,24 @@ config X86_SGX
 
 	  If unsure, say N.
 
+config X86_USER_SHADOW_STACK
+	bool "X86 userspace shadow stack"
+	depends on AS_WRUSS
+	depends on X86_64
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select X86_CET
+	help
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption.  This helps mitigate ROP attacks.
+	  Applications must be enabled to use it, and old userspace does not
+	  get protection "for free".
+
+	  CPUs supporting shadow stacks were first released in 2020.
+
+	  See Documentation/x86/shstk.rst for more information.
+
+	  If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index b88f784..8ad41da 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -24,3 +24,8 @@ config AS_GFNI
 	def_bool $(as-instr,vgf2p8mulb %xmm0$(comma)%xmm1$(comma)%xmm2)
 	help
 	  Supported by binutils >= 2.30 and LLVM integrated assembler
+
+config AS_WRUSS
+	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
+	help
+	  Supported by binutils >= 2.31 and LLVM integrated assembler
