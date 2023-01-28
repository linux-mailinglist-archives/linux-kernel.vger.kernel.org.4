Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD2C67F6AF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjA1JYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjA1JYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:24:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ADB79232;
        Sat, 28 Jan 2023 01:24:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1189EB80113;
        Sat, 28 Jan 2023 09:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80A4C433EF;
        Sat, 28 Jan 2023 09:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674897869;
        bh=nGI8NjRBk355G52xy2altpSRn4gf5lig76qHJoACUMo=;
        h=From:To:Cc:Subject:Date:From;
        b=uFJJ0GOGmbnaeVLDdP7GZyqOfdPGbYTsic4MyxiT8+DgAqUHAvNnlloZ+Ja+PgDtd
         pVz6aMRg0cd2p/nubQAL29bEE4uft6aAzxL6/YclJ+cXZV/M/wuu8uo563x+uJcpIC
         4Xdm8giSwLmOh7hZExr+O19G+C6Tvx16f5Kw3TF03XXgk8n2LtGqgNih5kL8wXLM3I
         83ldRhW9+XECQBMZJTdhgaizBGzy6cx6sr8+cV9rxBeyYRgzcba0GquxMcxGaz2GZH
         cB1Kup36zeFyxH+3wiGlLbkTX/bEL/5zb1qv+sbpgerbsx1TywG3+Dc9aNww9SQRYD
         ny9foJbAEt7ZQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kbuild: remove --include-dir MAKEFLAG from top Makefile
Date:   Sat, 28 Jan 2023 18:24:23 +0900
Message-Id: <20230128092424.45105-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I added $(srctree)/ to some included Makefiles in the following commits:

 - 3204a7fb98a3 ("kbuild: prefix $(srctree)/ to some included Makefiles")
 - d82856395505 ("kbuild: do not require sub-make for separate output tree builds")

Those were a preparation for removing --include-dir flag.

I have never thought --include-dir useful, rather, it is harmful.

For example, run the following commands:

  $ make -s ARCH=x86 mrproper defconfig
  $ make ARCH=arm O=foo dtbs
  make[1]: Entering directory '/tmp/linux/foo'
    HOSTCC  scripts/basic/fixdep
  Error: kernelrelease not valid - run 'make prepare' to update it
    UPD     include/config/kernel.release
  make[1]: Leaving directory '/tmp/linux/foo'

The first command configures the source tree for x86. The next command
tries to build ARM device trees in the separate foo/ directory - this
must stop because the directory foo/ has not been configured yet.

However, due to --include-dir=$(abs_srctree), the top Makefile includes
the wrong include/config/auto.conf from the source tree and continues
building. Kbuild traverses the directory tree, but of course does not
work correctly. The Error message is also pointless - 'make prepare'
does not help at all for fixing the issue.

This commit fixes more arch Makefile, and finally removes --include-dir
from the top Makefile.

There are more breakages under drivers/, but I do not volunteer to fix
them all. I just moved --include-dir to drivers/Makefile.

With this commit, the second command will stop with a sensible message.

  $ make -s ARCH=x86 mrproper defconfig
  $ make ARCH=arm O=foo dtbs
  make[1]: Entering directory '/tmp/linux/foo'
    SYNC    include/config/auto.conf.cmd
  ***
  *** The source tree is not clean, please run 'make ARCH=arm mrproper'
  *** in /tmp/linux
  ***
  make[2]: *** [../Makefile:646: outputmakefile] Error 1
  /tmp/linux/Makefile:770: include/config/auto.conf.cmd: No such file or directory
  make[1]: *** [/tmp/linux/Makefile:793: include/config/auto.conf.cmd] Error 2
  make[1]: Leaving directory '/tmp/linux/foo'
  make: *** [Makefile:226: __sub-make] Error 2

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                          | 8 --------
 arch/arm/mach-s3c/Makefile        | 4 ++--
 arch/ia64/kernel/Makefile         | 2 +-
 arch/mips/Kbuild                  | 2 +-
 arch/mips/Makefile.postlink       | 2 +-
 arch/powerpc/Makefile.postlink    | 2 +-
 arch/um/drivers/Makefile          | 2 +-
 arch/um/kernel/Makefile           | 2 +-
 arch/um/kernel/skas/Makefile      | 2 +-
 arch/um/os-Linux/Makefile         | 2 +-
 arch/um/os-Linux/drivers/Makefile | 2 +-
 arch/um/os-Linux/skas/Makefile    | 2 +-
 arch/x86/Makefile.um              | 2 +-
 arch/x86/um/Makefile              | 2 +-
 arch/x86/um/os-Linux/Makefile     | 2 +-
 drivers/Makefile                  | 5 +++++
 fs/hostfs/Makefile                | 2 +-
 17 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index cb1e188b1a91..339121558928 100644
--- a/Makefile
+++ b/Makefile
@@ -203,14 +203,6 @@ ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
 $(error source directory cannot contain spaces or colons)
 endif
 
-ifneq ($(abs_srctree),$(abs_objtree))
-# Look for make include files relative to root of kernel src
-#
-# --included-dir is added for backward compatibility, but you should not rely on
-# it. Please add $(srctree)/ prefix to include Makefiles in the source tree.
-MAKEFLAGS += --include-dir=$(abs_srctree)
-endif
-
 ifneq ($(filter 3.%,$(MAKE_VERSION)),)
 # 'MAKEFLAGS += -rR' does not immediately become effective for GNU Make 3.x
 # We need to invoke sub-make to avoid implicit rules in the top Makefile.
diff --git a/arch/arm/mach-s3c/Makefile b/arch/arm/mach-s3c/Makefile
index 7c7d3318fd61..deb44326b828 100644
--- a/arch/arm/mach-s3c/Makefile
+++ b/arch/arm/mach-s3c/Makefile
@@ -3,11 +3,11 @@
 # Copyright 2009 Simtec Electronics
 
 ifdef CONFIG_ARCH_S3C24XX
-include $(src)/Makefile.s3c24xx
+include $(srctree)/$(src)/Makefile.s3c24xx
 endif
 
 ifdef CONFIG_ARCH_S3C64XX
-include $(src)/Makefile.s3c64xx
+include $(srctree)/$(src)/Makefile.s3c64xx
 endif
 
 # Objects we always build independent of SoC choice
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index ae9ff07de4ab..d7e1cabee2ec 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -43,4 +43,4 @@ obj-$(CONFIG_ELF_CORE)		+= elfcore.o
 CFLAGS_traps.o  += -mfixed-range=f2-f5,f16-f31
 
 # The gate DSO image is built using a special linker script.
-include $(src)/Makefile.gate
+include $(srctree)/$(src)/Makefile.gate
diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index 9e8071f0e58f..af2967bffb73 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -7,7 +7,7 @@ subdir-ccflags-y := -Werror
 endif
 
 # platform specific definitions
-include arch/mips/Kbuild.platforms
+include $(srctree)/arch/mips/Kbuild.platforms
 obj-y := $(platform-y)
 
 # make clean traverses $(obj-) without having included .config, so
diff --git a/arch/mips/Makefile.postlink b/arch/mips/Makefile.postlink
index 4b1d3ba3a8a2..34e3bd71f3b0 100644
--- a/arch/mips/Makefile.postlink
+++ b/arch/mips/Makefile.postlink
@@ -10,7 +10,7 @@ PHONY := __archpost
 __archpost:
 
 -include include/config/auto.conf
-include scripts/Kbuild.include
+include $(srctree)/scripts/Kbuild.include
 
 CMD_LS3_LLSC = arch/mips/tools/loongson3-llsc-check
 quiet_cmd_ls3_llsc = LLSCCHK $@
diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
index a6c77f4d32b2..1f860b3c9bec 100644
--- a/arch/powerpc/Makefile.postlink
+++ b/arch/powerpc/Makefile.postlink
@@ -9,7 +9,7 @@ PHONY := __archpost
 __archpost:
 
 -include include/config/auto.conf
-include scripts/Kbuild.include
+include $(srctree)/scripts/Kbuild.include
 
 quiet_cmd_head_check = CHKHEAD $@
       cmd_head_check = $(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/head_check.sh "$(NM)" "$@"
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index e1dc4292bd22..dee6f66353b3 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -72,4 +72,4 @@ CFLAGS_null.o = -DDEV_NULL=$(DEV_NULL_PATH)
 
 CFLAGS_xterm.o += '-DCONFIG_XTERM_CHAN_DEFAULT_EMULATOR="$(CONFIG_XTERM_CHAN_DEFAULT_EMULATOR)"'
 
-include arch/um/scripts/Makefile.rules
+include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 1c2d4b29a3d4..811188be954c 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
 
 USER_OBJS := config.o
 
-include arch/um/scripts/Makefile.rules
+include $(srctree)/arch/um/scripts/Makefile.rules
 
 targets := config.c config.tmp capflags.c
 
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index f3d494a4fd9b..f93972a25765 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -14,4 +14,4 @@ UNPROFILE_OBJS := clone.o
 
 KCOV_INSTRUMENT := n
 
-include arch/um/scripts/Makefile.rules
+include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 77ac50baa3f8..544e0b344c75 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -18,4 +18,4 @@ USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
 	tty.o umid.o util.o
 
-include arch/um/scripts/Makefile.rules
+include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/drivers/Makefile b/arch/um/os-Linux/drivers/Makefile
index d79e75f1b69a..cf2d75bb1884 100644
--- a/arch/um/os-Linux/drivers/Makefile
+++ b/arch/um/os-Linux/drivers/Makefile
@@ -10,4 +10,4 @@ obj-y =
 obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap.o
 obj-$(CONFIG_UML_NET_TUNTAP) += tuntap.o
 
-include arch/um/scripts/Makefile.rules
+include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/skas/Makefile b/arch/um/os-Linux/skas/Makefile
index c4566e788815..75f11989d2e9 100644
--- a/arch/um/os-Linux/skas/Makefile
+++ b/arch/um/os-Linux/skas/Makefile
@@ -7,4 +7,4 @@ obj-y := mem.o process.o
 
 USER_OBJS := $(obj-y)
 
-include arch/um/scripts/Makefile.rules
+include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index b3c1ae084180..b89e2e0024c5 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -17,7 +17,7 @@ LDS_EXTRA		:= -Ui386
 export LDS_EXTRA
 
 # First of all, tune CFLAGS for the specific CPU. This actually sets cflags-y.
-include arch/x86/Makefile_32.cpu
+include $(srctree)/arch/x86/Makefile_32.cpu
 
 # prevent gcc from keeping the stack 16 byte aligned. Taken from i386.
 cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 3d5cd2e57820..ee89f6bb9242 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -48,4 +48,4 @@ include/generated/user_constants.h: $(obj)/user-offsets.s FORCE
 UNPROFILE_OBJS := stub_segv.o
 CFLAGS_stub_segv.o := $(CFLAGS_NO_HARDENING)
 
-include arch/um/scripts/Makefile.rules
+include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
index 253bfb8cb702..ae169125d03f 100644
--- a/arch/x86/um/os-Linux/Makefile
+++ b/arch/x86/um/os-Linux/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_64BIT) += prctl.o
 
 USER_OBJS := $(obj-y)
 
-include arch/um/scripts/Makefile.rules
+include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/drivers/Makefile b/drivers/Makefile
index bdf1c66141c9..62a9cb403a1a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -6,6 +6,11 @@
 # Rewritten to use lists instead of if-statements.
 #
 
+# Some driver Makefiles miss $(srctree)/ for include directive.
+ifdef building_out_of_srctree
+MAKEFLAGS += --include-dir=$(srctree)
+endif
+
 obj-y				+= irqchip/
 obj-y				+= bus/
 
diff --git a/fs/hostfs/Makefile b/fs/hostfs/Makefile
index d5beaffad43b..587bcd6e50a3 100644
--- a/fs/hostfs/Makefile
+++ b/fs/hostfs/Makefile
@@ -8,4 +8,4 @@ hostfs-objs := hostfs_kern.o hostfs_user.o
 obj-y :=
 obj-$(CONFIG_HOSTFS) += hostfs.o
 
-include arch/um/scripts/Makefile.rules
+include $(srctree)/arch/um/scripts/Makefile.rules
-- 
2.34.1

