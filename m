Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A473CC73
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjFXSm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 14:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjFXSmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 14:42:49 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7042699;
        Sat, 24 Jun 2023 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687632140; bh=0Tq7EFJUUQOAtspH6l1egJDQ+7z8Kts6U1eCmQuulT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJtLR5X9id4V7kryXwZrL369m5ZrY688s67Lk5G4iVzV+IqTKZbXuEWqWIXac+jYi
         lkDPwriZygD8MFQetGr4JJPxIlyw0AvOCyAFl3xHVDLRG8kJO3Q8r1htcf9cRxcODd
         URv4KRbKKhhsgdfmAkRmO6y53nzP0Mac1lNjgiKA=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 1AF6960164;
        Sun, 25 Jun 2023 02:42:20 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH v2 7/9] LoongArch: Tweak CFLAGS for Clang compatibility
Date:   Sun, 25 Jun 2023 02:40:53 +0800
Message-Id: <20230624184055.3000636-8-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230624184055.3000636-1-kernel@xen0n.name>
References: <20230624184055.3000636-1-kernel@xen0n.name>
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

In particular, -mexplicit-relocs and -mdirect-extern-access are not
necessary nor supported on Clang; feature detection via cc-option would
not work, because that way the broken combo of "new GNU as + old GCC"
would seem to get "fixed", but actually produce broken kernels.
Explicitly depending on CONFIG_CC_IS_CLANG is thus necessary to not
regress UX for those building their own kernels.

A build with !RELOCATABLE && !MODULE is confirmed working within a QEMU
environment; support for the two features are currently blocked on
LLVM/Clang, and will come later.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 366771016b99..82c619791a63 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -51,7 +51,9 @@ LDFLAGS_vmlinux			+= -static -n -nostdlib
 
 # When the assembler supports explicit relocation hint, we must use it.
 # GCC may have -mexplicit-relocs off by default if it was built with an old
-# assembler, so we force it via an option.
+# assembler, so we force it via an option. For LLVM/Clang the desired behavior
+# is the default, and the flag is not supported, so don't pass it if Clang is
+# being used.
 #
 # When the assembler does not supports explicit relocation hint, we can't use
 # it.  Disable it if the compiler supports it.
@@ -61,8 +63,10 @@ LDFLAGS_vmlinux			+= -static -n -nostdlib
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
-- 
2.40.0

