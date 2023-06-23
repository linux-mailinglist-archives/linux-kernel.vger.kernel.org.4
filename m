Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0294373B8F7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjFWNog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjFWNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:44:19 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7862696;
        Fri, 23 Jun 2023 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687527855; bh=gdMT1VPu7/T52oiYEqx+LXNHcCWHe7wIMOjlRAhlRp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbZUAwOBMJDqn53dBYM6vkJk0QzMOlZIpO4XkyKJcp3LLA9UYdeAm4QO5NmZ7Hg3B
         Vt+LbbPcmhvdXLiI0FkO/5nhUEIBUWVSEtSRRIdYOwWk112ZSFfz99lXjB22Kxq1Fl
         /y4el0HPuzUO6cB2bR4t3fQdnRceT87sRecquOAw=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id AC758605F4;
        Fri, 23 Jun 2023 21:44:15 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 7/9] LoongArch: Tweak CFLAGS for Clang compatibility
Date:   Fri, 23 Jun 2023 21:43:49 +0800
Message-Id: <20230623134351.1898379-8-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230623134351.1898379-1-kernel@xen0n.name>
References: <20230623134351.1898379-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Now the arch code is mostly ready for LLVM/Clang consumption, it is time
to re-organize the CFLAGS a little to actually enable the LLVM build.

A build with !RELOCATABLE && !MODULE is confirmed working within a QEMU
environment; support for the two features are currently blocked by
LLVM/Clang, and will come later.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/Makefile      | 14 +++++++++++---
 arch/loongarch/vdso/Makefile |  6 +++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index a27e264bdaa5..efe9b50bd829 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -46,12 +46,18 @@ ld-emul			= $(64bit-emul)
 cflags-y		+= -mabi=lp64s
 endif
 
-cflags-y			+= -G0 -pipe -msoft-float
-LDFLAGS_vmlinux			+= -G0 -static -n -nostdlib
+ifndef CONFIG_CC_IS_CLANG
+cflags-y			+= -G0
+LDFLAGS_vmlinux			+= -G0
+endif
+cflags-y			+= -pipe
+LDFLAGS_vmlinux			+= -static -n -nostdlib
 
 # When the assembler supports explicit relocation hint, we must use it.
 # GCC may have -mexplicit-relocs off by default if it was built with an old
-# assembler, so we force it via an option.
+# assembler, so we force it via an option. For LLVM/Clang the desired behavior
+# is the default, and the flag is not supported, so don't pass it if Clang is
+# being used.
 #
 # When the assembler does not supports explicit relocation hint, we can't use
 # it.  Disable it if the compiler supports it.
@@ -61,8 +67,10 @@ LDFLAGS_vmlinux			+= -G0 -static -n -nostdlib
 # combination of a "new" assembler and "old" compiler is not supported.  Either
 # upgrade the compiler or downgrade the assembler.
 ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
+ifndef CONFIG_CC_IS_CLANG
 cflags-y			+= -mexplicit-relocs
 KBUILD_CFLAGS_KERNEL		+= -mdirect-extern-access
+endif
 else
 cflags-y			+= $(call cc-option,-mno-explicit-relocs)
 KBUILD_AFLAGS_KERNEL		+= -Wa,-mla-global-with-pcrel
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 4c859a0e4754..19f6c75a1106 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -25,13 +25,17 @@ endif
 cflags-vdso := $(ccflags-vdso) \
 	-isystem $(shell $(CC) -print-file-name=include) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
-	-O2 -g -fno-strict-aliasing -fno-common -fno-builtin -G0 \
+	-O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-asynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
 aflags-vdso := $(ccflags-vdso) \
 	-D__ASSEMBLY__ -Wa,-gdwarf-2
 
+ifndef CONFIG_CC_IS_CLANG
+cflags-vdso += -G0
+endif
+
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
 endif
-- 
2.40.0

