Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F6F6611C6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 22:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjAGVUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 16:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGVUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 16:20:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7225B4A9;
        Sat,  7 Jan 2023 13:20:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B26B60BCB;
        Sat,  7 Jan 2023 21:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDCEC433D2;
        Sat,  7 Jan 2023 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673126427;
        bh=XpMX+uZxjGGJ3KfRz6Yz4WKx99Etyhlw516mSlREReU=;
        h=From:To:Cc:Subject:Date:From;
        b=BXjJBbvjFtfjpvVVYOzpZrsJ6kFEcWpZwAYuzpO+V6/cDveJbcDY/mo9LbO2sXNqa
         JA3VWAzP8Q0p51Y86TzSJkr54P4KNyqrlM1nbrrYZCfkQHngK5OEVmEyWPwTlnQJ2D
         2dZA9IAFLmtucDk8UcOCwBiTNI5sLFRau14EtEpS+92hvFeSGEf7ca3lzCO+kTiGFJ
         5aKLGhpToqlrDmZy2c1rTwRLa/rONuQktGeTc5f1GY9yZeKBkws8zXbpxaDDgVVQB2
         6C1+/CrpQw0JD/Dt6IJEAQLcepoHs8XSUu5UCl/SVT4Q7DBflMWBwSSreOtKt14nG1
         nQtxVZ6fV9K6Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <n.schier@avm.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Xin Li <xin3.li@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] ARM: fix nm error message when GNU Make >= 4.4 is used
Date:   Sun,  8 Jan 2023 06:20:18 +0900
Message-Id: <20230107212019.2575770-1-masahiroy@kernel.org>
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

  $ make-4.4 ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build defconfig all
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

This occurs with GNU Make commit 98da874c4303 ("[SV 10593] Export
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

The 'foo' is a resursively expanded (or lazily expanded) variable.

GNU Make 4.3 expands it just before running the recipe '@echo $(foo)',
at this point, the directory 'bar' exists.

GNU Make 4.4 expands it to evaluate $(shell mkdir bar) because 'foo' is
exported. At this point, the directory 'bar' does not exit yet. The cat
command cannot resolve the bar/../foo path, hence the error message.

Let's get back to the kernel Makefile.

'KBSS_SZ' in arch/arm/boot/compressed/Makefile is a recursive variable,
which is referenced by 'LDFLAGS_vmlinux', which is also a recursive
variable.

GNU Make 4.3 expands 'KBSS_SZ' just before running the recipes. Before
that, $(shell mkdir -p $(obj-dirs)) in scripts/Makefile.build creates
the output directory, arch/arm/boot/compressed.

GNU Make 4.4 expands 'KBSS_SZ' in the parse stage because LDFLAGS_vmlinux
was (accidentally) exported by commit 5d4aeffbf709 ("kbuild: rebuild
.vmlinux.export.o when its prerequisite is updated"). $(NM) cannot
resolve the path arch/arm/boot/compressed/../../../../vmlinux.

I admit this is a bug caused by 5d4aeffbf709 (I will fix it in the next
commit), but do not see any good reason in writing the vmlinux path in
such an indirect way. Just say 'vmlinux'.

[1]: https://git.savannah.gnu.org/cgit/make.git/commit/?id=98da874c43035a490cdca81331724f233a3d0c9a

Link: https://lore.kernel.org/all/Y7i8+EjwdnhHtlrr@dev-arch.thelio-3990X/
Fixes: 5d4aeffbf709 ("kbuild: rebuild .vmlinux.export.o when its prerequisite is updated")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 2ef651a78fa2..726ecabcef09 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -107,7 +107,7 @@ ccflags-remove-$(CONFIG_FUNCTION_TRACER) += -pg
 asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
-KBSS_SZ = $(shell echo $$(($$($(NM) $(obj)/../../../../vmlinux | \
+KBSS_SZ = $(shell echo $$(($$($(NM) vmlinux | \
 		sed -n -e 's/^\([^ ]*\) [ABD] __bss_start$$/-0x\1/p' \
 		       -e 's/^\([^ ]*\) [ABD] __bss_stop$$/+0x\1/p') )) )
 LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
-- 
2.34.1

