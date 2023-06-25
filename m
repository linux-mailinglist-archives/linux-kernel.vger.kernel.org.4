Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DC273CFF4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjFYJ6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjFYJ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:58:08 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D3710D3;
        Sun, 25 Jun 2023 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687687058; bh=YtsXJvNsH4YXyvvEvCiNoOEuYFmBZqVboByxYB2/yFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vC7QKvMcWWP/npTqVBCyEAAKdJx6W4J1EEp2eWfzw58Swuc5KkXh6ww0TsihpaDaX
         +EnSH7VhqZtR00IzzrmbnLd9f/oU/nVkMCglwcf9ZouAqXjy5Gh5Y+OpgrzCp/KTA9
         vCOOeNnysuT6tRycEtk3yp5oqCee8hC+d7tTxsYY=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id B22036015C;
        Sun, 25 Jun 2023 17:57:38 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH v3 6/8] LoongArch: Tweak CFLAGS for Clang compatibility
Date:   Sun, 25 Jun 2023 17:56:42 +0800
Message-Id: <20230625095644.3156349-7-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230625095644.3156349-1-kernel@xen0n.name>
References: <20230625095644.3156349-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Now the arch code is mostly ready for LLVM/Clang consumption, it is time
to re-organize the CFLAGS a little to actually enable the LLVM build.
Namely, all -G0 switches from CFLAGS are removed, and -mexplicit-relocs
and -mdirect-extern-access are now wrapped with cc-option (with the
related asm/percpu.h definition guarded against toolchain combos that
are known to not work).

A build with !RELOCATABLE && !MODULE is confirmed working within a QEMU
environment; support for the two features are currently blocked on
LLVM/Clang, and will come later.

Why -G0 can be removed:

In GCC, -G stands for "small data threshold", that instructs the
compiler to put data smaller than the specified threshold in a dedicated
"small data" section (called .sdata on LoongArch and several other
arches).

However, benefiting from this would require ABI cooperation, which is
not the case for LoongArch; and current GCC behave the same whether -G0
(equal to disabling this optimization) is given or not. So, remove -G0
from CFLAGS altogether for one less thing to care about. This also
benefits LLVM/Clang compatibility where the -G switch is not supported.

Why -mexplicit-relocs can now be conditionally applied without
regressions:

Originally -mexplicit-relocs is unconditionally added to CFLAGS in case
of CONFIG_AS_HAS_EXPLICIT_RELOCS, because not having it (i.e. old GCC +
new binutils) would not work: modules will have R_LARCH_ABS_* relocs
inside, but given the rarity of such toolchain combo in the wild, it may
not be worthwhile to support it, so support for such relocs in modules
were not added back when explicit relocs support was upstreamed, and
-mexplicit-relocs is unconditionally added to fail the build early.

Now that Clang compatibility is desired, given Clang is behaving like
-mexplicit-relocs from day one but without support for the CLI flag, we
must ensure the flag is not passed in case of Clang. However, explicit
compiler flavor checks can be more brittle than feature detection: in
this case what actually matters is support for __attribute__((model))
when building modules. Given neither older GCC nor current Clang support
this attribute, probing for the attribute support and #error'ing out
would allow proper UX without checking for Clang, and also automatically
work when Clang support for the attribute is to be added in the future.

Why -mdirect-extern-access is now conditionally applied:

This is actually a nice-to-have optimization that can reduce GOT
accesses, but not having it is harmless either. Because Clang does not
support the option currently, but might do so in the future, conditional
application via cc-option ensures compatibility with both current and
future Clang versions.

Suggested-by: Xi Ruoyao <xry111@xry111.site> # cc-option changes
Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/Makefile             | 21 +++++++++++++--------
 arch/loongarch/include/asm/percpu.h |  6 +++++-
 arch/loongarch/vdso/Makefile        |  2 +-
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index a27e264bdaa5..a63683da3bcf 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -46,8 +46,8 @@ ld-emul			= $(64bit-emul)
 cflags-y		+= -mabi=lp64s
 endif
 
-cflags-y			+= -G0 -pipe -msoft-float
-LDFLAGS_vmlinux			+= -G0 -static -n -nostdlib
+cflags-y			+= -pipe -msoft-float
+LDFLAGS_vmlinux			+= -static -n -nostdlib
 
 # When the assembler supports explicit relocation hint, we must use it.
 # GCC may have -mexplicit-relocs off by default if it was built with an old
@@ -56,13 +56,18 @@ LDFLAGS_vmlinux			+= -G0 -static -n -nostdlib
 # When the assembler does not supports explicit relocation hint, we can't use
 # it.  Disable it if the compiler supports it.
 #
-# If you've seen "unknown reloc hint" message building the kernel and you are
-# now wondering why "-mexplicit-relocs" is not wrapped with cc-option: the
-# combination of a "new" assembler and "old" compiler is not supported.  Either
-# upgrade the compiler or downgrade the assembler.
+# The combination of a "new" assembler and "old" GCC is not supported, given
+# the rarity of this combo and the extra complexity needed to make it work.
+# Either upgrade the compiler or downgrade the assembler; the build will error
+# out if it is the case (by probing for the model attribute; all supported
+# compilers in this case would have support).
+#
+# Also, -mdirect-extern-access is useful in case of building with explicit
+# relocs, for avoiding unnecessary GOT accesses. It is harmless to not have
+# support though.
 ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
-cflags-y			+= -mexplicit-relocs
-KBUILD_CFLAGS_KERNEL		+= -mdirect-extern-access
+cflags-y			+= $(call cc-option,-mexplicit-relocs)
+KBUILD_CFLAGS_KERNEL		+= $(call cc-option,-mdirect-extern-access)
 else
 cflags-y			+= $(call cc-option,-mno-explicit-relocs)
 KBUILD_AFLAGS_KERNEL		+= -Wa,-mla-global-with-pcrel
diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index ad8d88494554..b9f567e66016 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -14,7 +14,11 @@
  * loaded. Tell the compiler this fact when using explicit relocs.
  */
 #if defined(MODULE) && defined(CONFIG_AS_HAS_EXPLICIT_RELOCS)
-#define PER_CPU_ATTRIBUTES    __attribute__((model("extreme")))
+# if __has_attribute(model)
+#  define PER_CPU_ATTRIBUTES __attribute__((model("extreme")))
+# else
+#  error compiler support for the model attribute is necessary when a recent assembler is used
+# endif
 #endif
 
 /* Use r21 for fast access */
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 4c859a0e4754..ee4abcf5642e 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -25,7 +25,7 @@ endif
 cflags-vdso := $(ccflags-vdso) \
 	-isystem $(shell $(CC) -print-file-name=include) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
-	-O2 -g -fno-strict-aliasing -fno-common -fno-builtin -G0 \
+	-O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-asynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
-- 
2.40.0

