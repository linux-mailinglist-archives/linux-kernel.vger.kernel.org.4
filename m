Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9623565469A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiLVTau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLVTas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:30:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD5A219E;
        Thu, 22 Dec 2022 11:30:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF629B81F4E;
        Thu, 22 Dec 2022 19:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA87C433D2;
        Thu, 22 Dec 2022 19:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671737444;
        bh=6kkxlHhCYsuVQi0lgCe1ViIca0Zbfm7PLnQZC4uoLKM=;
        h=From:To:Cc:Subject:Date:From;
        b=rHAeS1B3V1a+eH1wM6+CBbGLM8XmTNn59y3KUtwEi7SagiW+JMvJ1HUIYitqZMnmO
         VDY3sm66G+2Hf+XzuK6SYP6WWlLL8R7GwNAcFQO93HiDTQwGEDprL8pINQnU5PgEAa
         I2iY840Hospv4amQtmo+L8w2Jk21n8euVqT7NDg1vb9bnHKpcKeJTeQN2wq9ods5vO
         CGPI42v7aL6choZhJOiYAKWlqP5VBi7C+xbw/g6p428WbjGxxLLQPseOMFp0lq0BGr
         qMpNxfQYyDX3NDP/PCoj2PaOcHmqzzjt9enhGIBPdymilHKDB476pyRVlgtt99KBMw
         j0O6mmksqQfdA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH] ARM: Reduce __thumb2__ definition to crypto files that require it
Date:   Thu, 22 Dec 2022 12:30:39 -0700
Message-Id: <20221222193039.2267074-1-nathan@kernel.org>
X-Mailer: git-send-email 2.39.0
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

Commit 1d2e9b67b001 ("ARM: 9265/1: pass -march= only to compiler") added
a __thumb2__ define to ASFLAGS to avoid build errors in the crypto code,
which relies on __thumb2__ for preprocessing. Commit 59e2cf8d21e0 ("ARM:
9275/1: Drop '-mthumb' from AFLAGS_ISA") followed up on this by removing
-mthumb from AFLAGS so that __thumb2__ would not be defined when the
default target was ARMv7 or newer.

Unfortunately, the second commit's fix assumes that the toolchain
defaults to -mno-thumb / -marm, which is not the case for Debian's
arm-linux-gnueabihf target, which defaults to -mthumb:

  $ echo | arm-linux-gnueabihf-gcc -dM -E - | grep __thumb
  #define __thumb2__ 1
  #define __thumb__ 1

This target is used by several CI systems, which will still see
redefined macro warnings, despite '-mthumb' not being present in the
flags:

  <command-line>: warning: "__thumb2__" redefined
  <built-in>: note: this is the location of the previous definition

Remove the global AFLAGS __thumb2__ define and move it to the crypto
folder where it is required by the imported OpenSSL algorithms; the rest
of the kernel should use the internal CONFIG_THUMB2_KERNEL symbol to
know whether or not Thumb2 is being used or not. Be sure that __thumb2__
is undefined first so that there are no macro redefinition warnings.

Link: https://github.com/ClangBuiltLinux/linux/issues/1772
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm/Makefile        | 2 +-
 arch/arm/crypto/Makefile | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4067f5169144..955b0362cdfb 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -132,7 +132,7 @@ AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
 
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
 CFLAGS_ISA	:=-Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
-AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb -D__thumb2__=2
+AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
 CFLAGS_ISA	+=-mthumb
 else
 CFLAGS_ISA	:=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index 971e74546fb1..13e62c7c25dc 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -53,7 +53,12 @@ $(obj)/%-core.S: $(src)/%-armv4.pl
 
 clean-files += poly1305-core.S sha256-core.S sha512-core.S
 
+aflags-thumb2-$(CONFIG_THUMB2_KERNEL)  := -U__thumb2__ -D__thumb2__=1
+
+AFLAGS_sha256-core.o += $(aflags-thumb2-y)
+AFLAGS_sha512-core.o += $(aflags-thumb2-y)
+
 # massage the perlasm code a bit so we only get the NEON routine if we need it
 poly1305-aflags-$(CONFIG_CPU_V7) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=5
 poly1305-aflags-$(CONFIG_KERNEL_MODE_NEON) := -U__LINUX_ARM_ARCH__ -D__LINUX_ARM_ARCH__=7
-AFLAGS_poly1305-core.o += $(poly1305-aflags-y)
+AFLAGS_poly1305-core.o += $(poly1305-aflags-y) $(aflags-thumb2-y)

base-commit: 71a7507afbc3f27c346898f13ab9bfd918613c34
-- 
2.39.0

