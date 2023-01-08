Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36C661469
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 10:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjAHJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 04:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHJx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 04:53:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A1DBF;
        Sun,  8 Jan 2023 01:53:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A96A960C57;
        Sun,  8 Jan 2023 09:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA54C433EF;
        Sun,  8 Jan 2023 09:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673171631;
        bh=AxFFW7gAD/hGkqqH/1eltNah71ELaSI+2AAH9yFwTKE=;
        h=From:To:Cc:Subject:Date:From;
        b=hRNxu+VsHh2bYMCRQHcb12PPXn6L8XEkFtOaVSNJJO1TrGK3q/4dw10uslT7eaf7a
         kmsPbDnFnfh3ptYqnLd/okYcpZX8TI3ZOqs4w/sWCWZIN4Y9XrwZ0S8T4UHYM/6u6p
         ZcAkHtdPKgF1xpR02DfjLR6RdJ/EdUQtKCYolf9Np1eckuRq3HlVORWy6OwmygYCHE
         hlEEAMVY1ioXpJa9oVQsgbbAF6yc5OKtnsaz6vaYjZmoRrxjAC4TRahu3GJKtgLYSQ
         Ng8OMn9p/JExTuHCE3k05PRRAUBhwZwLngod0zKUV9+Vgg7ZLQer3XFMax5zMedNdP
         1aIJr2chsygmw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2] kbuild: do not export LDFLAGS_vmlinux to decompressor Makefiles
Date:   Sun,  8 Jan 2023 18:53:42 +0900
Message-Id: <20230108095342.2766757-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Nathan Chancellor reports an error message from $(NM) if GNU Make 4.4
is used to build the ARM decompressor.

  $ make-4.4 ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build defconfig zImage
    [snip]
    LD      vmlinux
    NM      System.map
    SORTTAB vmlinux
    OBJCOPY arch/arm/boot/Image
    Kernel: arch/arm/boot/Image is ready
  arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux': No such file
  /bin/sh: 1: arithmetic expression: expecting primary: " "
    LDS     arch/arm/boot/compressed/vmlinux.lds
    AS      arch/arm/boot/compressed/head.o
    GZIP    arch/arm/boot/compressed/piggy_data
    AS      arch/arm/boot/compressed/piggy.o
    CC      arch/arm/boot/compressed/misc.o

This occurs since GNU Make commit 98da874c4303 ("[SV 10593] Export
variables to $(shell ...) commands"), and the O= option is needed to
reproduce it. The generated zImage is correct despite the error message.

As the commit description of 98da874c4303 [1] says, exported variables
are passed down to $(shell ) functions, which means exported recursive
variables might be expanded earlier than before, in the parse stage.

The following test code demonstrates the change for GNU Make 4.4.

[Test Makefile]

  $(shell echo hello > foo)
  export foo = $(shell cat bar/../foo)
  $(shell mkdir bar)

  all:
          @echo $(foo)

[GNU Make 4.3]

  $ rm -rf bar; make-4.3
  hello

[GNU Make 4.4]

  $ rm -rf bar; make-4.4
  cat: bar/../foo: No such file or directory
  hello

The 'foo' is a resursively expanded (i.e. lazily expanded) variable.

GNU Make 4.3 expands 'foo' just before running the recipe '@echo $(foo)',
at this point, the directory 'bar' exists.

GNU Make 4.4 expands 'foo' to evaluate $(shell mkdir bar) because it is
exported. At this point, the directory 'bar' does not exit yet. The cat
command cannot resolve the bar/../foo path, hence the error message.

Let's get back to the kernel Makefile.

In arch/arm/boot/compressed/Makefile, KBSS_SZ is referenced by
LDFLAGS_vmlinux, which is recursive and also exported by the top
Makefile.

GNU Make 4.3 expands KBSS_SZ just before running the recipes, so it
works fine.

GNU Make 4.4 expands KBSS_SZ in the parse stage, where the directory
arm/arm/boot/compressed does not exit yet. When compiled O= option,
the output directory is created by $(shell mkdir -p $(obj-dirs))
in scripts/Makefile.build.

There are two ways to fix this particular issue:

 - change "$(obj)/../../../../vmlinux" in KBSS_SZ to "vmlinux"
 - unexport LDFLAGS_vmlinux

This commit takes the latter course because it is what I originally
intended.

Commit 3ec8a5b33dea ("kbuild: do not export LDFLAGS_vmlinux")
unexported LDFLAGS_vmlinux.

Commit 5d4aeffbf709 ("kbuild: rebuild .vmlinux.export.o when its
prerequisite is updated") accidentally exported it again.

We can clean up arch/arm/boot/compressed/Makefile later.

[1]: https://git.savannah.gnu.org/cgit/make.git/commit/?id=98da874c43035a490cdca81331724f233a3d0c9a

Link: https://lore.kernel.org/all/Y7i8+EjwdnhHtlrr@dev-arch.thelio-3990X/
Fixes: 5d4aeffbf709 ("kbuild: rebuild .vmlinux.export.o when its prerequisite is updated")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Postpone the change for arch/arm/boot/compressed/Makefile
  - Update the commit description

 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dfba294ae790..658fc0e602c9 100644
--- a/Makefile
+++ b/Makefile
@@ -549,7 +549,7 @@ LDFLAGS_MODULE  =
 CFLAGS_KERNEL	=
 RUSTFLAGS_KERNEL =
 AFLAGS_KERNEL	=
-export LDFLAGS_vmlinux =
+LDFLAGS_vmlinux =
 
 # Use USERINCLUDE when you must reference the UAPI directories only.
 USERINCLUDE    := \
@@ -1248,6 +1248,11 @@ vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
 	@:
 
 PHONY += vmlinux
+# LDFLAGS_vmlinux flags from the top Makefile and arch/*/Makefile should be
+# exported for building the top vmlinux, but not for building decompressors.
+# They happen to have the same base name (arch/*/boot/compressed/vmlinux).
+# The decompressor Makefiles should not inherit LDFLAGS_vmlinux.
+vmlinux: export LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
 vmlinux: vmlinux.o $(KBUILD_LDS) modpost
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux
 
-- 
2.34.1

