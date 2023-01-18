Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F7672818
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjARTX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjARTX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:23:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B847953B2C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:23:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69FC8B81C66
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCB3C433D2;
        Wed, 18 Jan 2023 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674069802;
        bh=0ya5K5vjVFPW7YzbbDzDGC2Lwm5m4bGSEj8L7qF73aE=;
        h=From:Date:Subject:To:Cc:From;
        b=EwpuW/gobuiyeXJs2dQ4kbN14sQEOWf/f8Lxa8Kkrf9gX2uBQW8IikL84yL5nqOUU
         jLtjRLiYds2rRqxwDqod9XyJS36xOD68fxAIl4pWMI8O7FxAlQYfIxSyVA/H4Z5uBl
         nHQCRDmzy/GghPNk+Vc1RIg3PfgqLu7Vj0vX0DbcLc8WTDOdCTo6i3w7G/FSqQm1Zn
         vxJXpPlstBhJBnp5VnqmL+IyeFDBkcxfm7c9vKNt9zV5X3N0bLLmodEbSCUUS1uL4I
         +ItgfsgroRhpr3DYHGcEX4MP01SoVAX5FK19SaXLMPyH20SsfPhMviowjvA9ioT+eE
         39vvDeYR6IwqA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Wed, 18 Jan 2023 12:22:59 -0700
Subject: [PATCH] ARM: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230118-v4-v4t-lld-16-v1-1-e3d9a00ae47c@kernel.org>
X-B4-Tracking: v=1; b=H4sIABRHyGMC/x2N0QqDMAxFf0XyvICts0x/ZfhQ02wGXJVEZCD++
 +rgvhwuh3OAsQob9NUByruYLLmAu1VAU8xvRkmFwde+qZ174H4v23CeE7qAXUhtaomaQB6KM0Zj
 HDVmmi7rE21jvY5V+SXff+g5nOcPBT2DQXgAAAA=
To:     linux@armlinux.org.uk, arnd@arndb.de
Cc:     ndesaulniers@google.com, trix@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188; i=nathan@kernel.org;
 h=from:subject:message-id; bh=0ya5K5vjVFPW7YzbbDzDGC2Lwm5m4bGSEj8L7qF73aE=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDMkn3DX7ptX3yk/buub+p7cHnHw+Ho74v3H/xcuZm7Zo5B3c
 pBZY1VHKwiDGwSArpshS/Vj1uKHhnLOMN05NgpnDygQyhIGLUwAmsqSBkaGFr9akoUciZIb4grYGp3
 WX7luftRZ7qJvY+N5CZFb0lFBGhht8B/S9lZgZ9KXKRMTr/WMOCO06m3vGdnf+icBtr+1VmAE=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6a7ee50f8f56 ("ARM: disallow pre-ARMv5 builds with ld.lld")
prevented v4 or v4t kernels when ld.lld will link the kernel due to
inserting unsupported blx instructions.

ld.lld has been fixed in current main (16.0.0) to avoid inserting these
instructions by inserting position independent thunks instead. Allow
these configurations to be enabled when ld.lld 16.0.0 is used to link
the kernel.

Additionally, add a link to the upstream LLVM issue so that the reason
for this dependency is clearly documented.

Link: https://github.com/ClangBuiltLinux/linux/issues/964
Link: https://github.com/llvm/llvm-project/commit/6f9ff1beee9d12aca0c9caa9ae0051dc6d0a718c
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I just build tested:

- multi_v4t_defconfig without 6a7ee50f8f56 with LLVM 15: warning
- multi_v4t_defconfig with this patch with LLVM 16: no warning

and the configuration cannot be selected under the old and new conditions
still.
---
 arch/arm/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43c7773b89ae..874c5b56cf9a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -345,14 +345,16 @@ comment "CPU Core family selection"
 config ARCH_MULTI_V4
 	bool "ARMv4 based platforms (FA526, StrongARM)"
 	depends on !ARCH_MULTI_V6_V7
-	depends on !LD_IS_LLD
+	# https://github.com/llvm/llvm-project/issues/50764
+	depends on !LD_IS_LLD || LLD_VERSION >= 160000
 	select ARCH_MULTI_V4_V5
 	select CPU_FA526 if !(CPU_SA110 || CPU_SA1100)
 
 config ARCH_MULTI_V4T
 	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
 	depends on !ARCH_MULTI_V6_V7
-	depends on !LD_IS_LLD
+	# https://github.com/llvm/llvm-project/issues/50764
+	depends on !LD_IS_LLD || LLD_VERSION >= 160000
 	select ARCH_MULTI_V4_V5
 	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
 		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \

---
base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
change-id: 20230118-v4-v4t-lld-16-96d5d5cc36c2

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>
