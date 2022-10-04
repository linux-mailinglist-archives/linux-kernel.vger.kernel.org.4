Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2AB5F479A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiJDQaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJDQae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:30:34 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E575755D;
        Tue,  4 Oct 2022 09:30:29 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 294GT79l026312;
        Wed, 5 Oct 2022 01:29:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 294GT79l026312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664900948;
        bh=UE+Gbs+Qop9VMM78JAxq6T2pZ+SbUfdmbZgd+KnURfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3g8MfOi0pw/xiwTKMxfKT3ylvWKoeXYIRRS2TJEjIej3vaWQQRei8EZSkhvKezvh
         SeeCyAWj4Jsaa9qvgnCknGCGHsuuvkyNstu2CvpDanrhCR0/7XWK3PC4AvbIOzy9Gv
         tGabo+Um88toCXmlSdy8F1XyfL27RmnmkawStpSd2cxbVFLp6BHx1QFwjwVaTHYUxg
         TphKkgavQXjDLyBWu+ZfrgCjMCKKk+Xv6M5Cwe6LtWPtzGa/Zjr3umqcLSEWC3XAkX
         pfkHEJfyY7p2lHGENKuCQxwFP1qj8VXNPsttBfC2YLho+D408RrMb/uPuVhIe9Q3Wo
         CHDteTcBWT2QA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH v2 3/3] Kconfig.debug: split debug-level and DWARF-version into separate choices
Date:   Wed,  5 Oct 2022 01:29:05 +0900
Message-Id: <20221004162905.24997-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004162905.24997-1-masahiroy@kernel.org>
References: <20221004162905.24997-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable from
a choice") added CONFIG_DEBUG_INFO_NONE into the DWARF version choice,
but it should rather belong to the debug level choice.

This commit consolidates CONFIG options into two choices:

 - Debug info level (NONE / REDUCED / DEFAULT)

 - DWARF format (DWARF_TOOLCHAIN_DEFAULT / DWARF4 / DWARF5)

This is more consistent with compilers' policy because the -g0 compiler
flag means "no debug info".

  GCC manual:

    -g<level>

      Request debugging information and also use level to specify how
      much information. The default level is 2.

      Level 0 produces no debug information at all. Thus, -g0 negates -g.

      Level 1 produces minimal information, enough for making backtraces
      in parts of the program that you don’t plan to debug. ...

      Level 3 includes extra information, such as all the macro
      definitions present in the program. ...

  Rustc Codegen manual:

    debuginfo

      This flag controls the generation of debug information. It takes
      one of the following values:

      0: no debug info at all (the default).
      1: line tables only.
      2: full debug info.

I moved CONFIG_DEBUG_INFO_REDUCED into the debug level choice.

This change will make it easier to add another debug info level if
necessary.

Update defconfig files accordingly. This includes the fixes for commit
f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable from a choice").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---

Changes in v2:
  - Fix up defconfig files

 arch/alpha/configs/defconfig                  |  2 +-
 arch/arc/configs/tb10x_defconfig              |  2 +-
 arch/arm/configs/axm55xx_defconfig            |  2 +-
 arch/arm/configs/badge4_defconfig             |  2 +-
 arch/arm/configs/bcm2835_defconfig            |  2 +-
 arch/arm/configs/colibri_pxa270_defconfig     |  2 +-
 arch/arm/configs/colibri_pxa300_defconfig     |  2 +-
 arch/arm/configs/dove_defconfig               |  2 +-
 arch/arm/configs/exynos_defconfig             |  2 +-
 arch/arm/configs/keystone_defconfig           |  2 +-
 arch/arm/configs/lpc18xx_defconfig            |  2 +-
 arch/arm/configs/lpc32xx_defconfig            |  2 +-
 arch/arm/configs/lpd270_defconfig             |  2 +-
 arch/arm/configs/lubbock_defconfig            |  2 +-
 arch/arm/configs/mainstone_defconfig          |  2 +-
 arch/arm/configs/mini2440_defconfig           |  2 +-
 arch/arm/configs/mmp2_defconfig               |  2 +-
 arch/arm/configs/moxart_defconfig             |  2 +-
 arch/arm/configs/mps2_defconfig               |  2 +-
 arch/arm/configs/multi_v5_defconfig           |  2 +-
 arch/arm/configs/mv78xx0_defconfig            |  2 +-
 arch/arm/configs/mvebu_v5_defconfig           |  2 +-
 arch/arm/configs/mvebu_v7_defconfig           |  2 +-
 arch/arm/configs/mxs_defconfig                |  2 +-
 arch/arm/configs/nhk8815_defconfig            |  2 +-
 arch/arm/configs/omap1_defconfig              |  2 +-
 arch/arm/configs/omap2plus_defconfig          |  1 +
 arch/arm/configs/orion5x_defconfig            |  2 +-
 arch/arm/configs/pxa168_defconfig             |  2 +-
 arch/arm/configs/pxa255-idp_defconfig         |  2 +-
 arch/arm/configs/pxa910_defconfig             |  2 +-
 arch/arm/configs/pxa_defconfig                |  2 +-
 arch/arm/configs/qcom_defconfig               |  2 +-
 arch/arm/configs/s3c2410_defconfig            |  2 +-
 arch/arm/configs/s3c6400_defconfig            |  2 +-
 arch/arm/configs/s5pv210_defconfig            |  2 +-
 arch/arm/configs/socfpga_defconfig            |  2 +-
 arch/arm/configs/spear13xx_defconfig          |  2 +-
 arch/arm/configs/spear3xx_defconfig           |  2 +-
 arch/arm/configs/spear6xx_defconfig           |  2 +-
 arch/arm/configs/stm32_defconfig              |  2 +-
 arch/arm/configs/tegra_defconfig              |  2 +-
 arch/arm/configs/vexpress_defconfig           |  2 +-
 arch/arm64/configs/defconfig                  |  1 -
 arch/microblaze/configs/mmu_defconfig         |  2 +-
 arch/mips/configs/bcm47xx_defconfig           |  1 -
 arch/mips/configs/cavium_octeon_defconfig     |  2 +-
 arch/mips/configs/ci20_defconfig              |  2 +-
 arch/mips/configs/cu1000-neo_defconfig        |  2 +-
 arch/mips/configs/cu1830-neo_defconfig        |  2 +-
 arch/mips/configs/generic_defconfig           |  1 -
 arch/mips/configs/omega2p_defconfig           |  2 +-
 arch/mips/configs/qi_lb60_defconfig           |  2 +-
 arch/mips/configs/vocore2_defconfig           |  2 +-
 arch/nios2/configs/10m50_defconfig            |  2 +-
 arch/nios2/configs/3c120_defconfig            |  2 +-
 arch/powerpc/configs/44x/akebono_defconfig    |  2 +-
 arch/powerpc/configs/44x/currituck_defconfig  |  2 +-
 arch/powerpc/configs/44x/fsp2_defconfig       |  2 +-
 arch/powerpc/configs/44x/iss476-smp_defconfig |  2 +-
 arch/powerpc/configs/44x/warp_defconfig       |  2 +-
 arch/powerpc/configs/52xx/lite5200b_defconfig |  2 +-
 arch/powerpc/configs/52xx/motionpro_defconfig |  2 +-
 arch/powerpc/configs/52xx/tqm5200_defconfig   |  2 +-
 arch/powerpc/configs/adder875_defconfig       |  2 +-
 arch/powerpc/configs/ep8248e_defconfig        |  2 +-
 arch/powerpc/configs/ep88xc_defconfig         |  2 +-
 arch/powerpc/configs/mgcoge_defconfig         |  2 +-
 arch/powerpc/configs/mpc5200_defconfig        |  2 +-
 arch/powerpc/configs/mpc8272_ads_defconfig    |  2 +-
 arch/powerpc/configs/mpc885_ads_defconfig     |  2 +-
 arch/powerpc/configs/ppc6xx_defconfig         |  2 +-
 arch/powerpc/configs/pq2fads_defconfig        |  2 +-
 arch/powerpc/configs/ps3_defconfig            |  2 +-
 arch/powerpc/configs/tqm8xx_defconfig         |  2 +-
 arch/s390/configs/debug_defconfig             |  1 +
 arch/s390/configs/defconfig                   |  1 +
 arch/s390/configs/zfcpdump_defconfig          |  1 +
 arch/sh/configs/apsh4a3a_defconfig            |  2 +-
 arch/sh/configs/apsh4ad0a_defconfig           |  2 +-
 arch/sh/configs/edosk7760_defconfig           |  2 +-
 arch/sh/configs/magicpanelr2_defconfig        |  2 +-
 arch/sh/configs/polaris_defconfig             |  2 +-
 arch/sh/configs/r7780mp_defconfig             |  2 +-
 arch/sh/configs/r7785rp_defconfig             |  2 +-
 arch/sh/configs/rsk7203_defconfig             |  2 +-
 arch/sh/configs/sdk7780_defconfig             |  2 +-
 arch/sh/configs/se7712_defconfig              |  2 +-
 arch/sh/configs/se7721_defconfig              |  2 +-
 arch/sh/configs/sh2007_defconfig              |  2 +-
 arch/sh/configs/sh7757lcr_defconfig           |  2 +-
 arch/sh/configs/sh7785lcr_32bit_defconfig     |  2 +-
 arch/sh/configs/urquell_defconfig             |  2 +-
 arch/um/configs/i386_defconfig                |  2 +-
 arch/um/configs/x86_64_defconfig              |  2 +-
 arch/xtensa/configs/audio_kc705_defconfig     |  2 +-
 arch/xtensa/configs/cadence_csp_defconfig     |  2 +-
 arch/xtensa/configs/generic_kc705_defconfig   |  2 +-
 arch/xtensa/configs/nommu_kc705_defconfig     |  2 +-
 arch/xtensa/configs/smp_lx200_defconfig       |  2 +-
 arch/xtensa/configs/virt_defconfig            |  2 +-
 arch/xtensa/configs/xip_kc705_defconfig       |  2 +-
 lib/Kconfig.debug                             | 59 +++++++++++--------
 103 files changed, 135 insertions(+), 121 deletions(-)

diff --git a/arch/alpha/configs/defconfig b/arch/alpha/configs/defconfig
index 7e9336930880..dfa0a1d251ab 100644
--- a/arch/alpha/configs/defconfig
+++ b/arch/alpha/configs/defconfig
@@ -65,7 +65,7 @@ CONFIG_NFSD=m
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_ALPHA_LEGACY_START_ADDRESS=y
 CONFIG_MATHEMU=y
 CONFIG_CRYPTO_HMAC=y
diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index d93b65008d4a..264c29c2e0d0 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -90,7 +90,7 @@ CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_HEADERS_INSTALL=y
diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index bfbaa2df3be5..70f5b1fdefe2 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -224,7 +224,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_CRYPTO_XCBC=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index 506f3378da07..7c486dd488e4 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -98,7 +98,7 @@ CONFIG_NFS_V3=y
 CONFIG_SMB_FS=m
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index c4d2e2334b6e..52a1211d8e3e 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -176,7 +176,7 @@ CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
 CONFIG_BOOT_PRINTK_DELAY=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
index 8357d721c69c..fb1280e59eee 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -135,7 +135,7 @@ CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_KEYS=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/arm/configs/colibri_pxa300_defconfig b/arch/arm/configs/colibri_pxa300_defconfig
index 42adfefdb6dc..47a76816b596 100644
--- a/arch/arm/configs/colibri_pxa300_defconfig
+++ b/arch/arm/configs/colibri_pxa300_defconfig
@@ -53,7 +53,7 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_AES=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 CONFIG_CRYPTO_ARC4=y
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 16ed5c110e8d..e174ec6d95fe 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -116,7 +116,7 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
 CONFIG_TIMER_STATS=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 1ce74f46e114..6508afa65f02 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -374,7 +374,7 @@ CONFIG_FONTS=y
 CONFIG_FONT_7x14=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 68b89b90ca29..90a929102c07 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -224,7 +224,7 @@ CONFIG_NFSD=y
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_CRYPTO_USER=y
 CONFIG_CRYPTO_AUTHENC=y
 CONFIG_CRYPTO_CBC=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 142c1700f450..d49cd2466b18 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -150,7 +150,7 @@ CONFIG_JFFS2_FS=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 8a41fe4e62f1..785fdc872662 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -185,7 +185,7 @@ CONFIG_CRYPTO_ANSI_CPRNG=y
 CONFIG_CRC_CCITT=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/lpd270_defconfig b/arch/arm/configs/lpd270_defconfig
index b0c21a99a0a8..8132b78bab62 100644
--- a/arch/arm/configs/lpd270_defconfig
+++ b/arch/arm/configs/lpd270_defconfig
@@ -52,7 +52,7 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/lubbock_defconfig b/arch/arm/configs/lubbock_defconfig
index 4fc744c96196..a307b10a8c11 100644
--- a/arch/arm/configs/lubbock_defconfig
+++ b/arch/arm/configs/lubbock_defconfig
@@ -47,7 +47,7 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/mainstone_defconfig
index 096cd7bc667a..4fa4376dbfa5 100644
--- a/arch/arm/configs/mainstone_defconfig
+++ b/arch/arm/configs/mainstone_defconfig
@@ -45,7 +45,7 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index 86e00f684e16..56fd10a5f8d9 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -329,7 +329,7 @@ CONFIG_LIBCRC32C=m
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_MINI_4x6=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_STRIP_ASM_SYMS=y
diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 4d39c615117b..9b5291b347c3 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -76,7 +76,7 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_PREEMPT is not set
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 # CONFIG_DYNAMIC_DEBUG is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index 082a38a14c12..7758e21719ce 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -121,7 +121,7 @@ CONFIG_KEYS=y
 CONFIG_CRC32_BIT=y
 CONFIG_DMA_API_DEBUG=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_KGDB=y
 CONFIG_DEBUG_PAGEALLOC=y
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index 700568474549..546885f6820c 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -94,7 +94,7 @@ CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index e0be0e0023f3..724ef12071cf 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -290,7 +290,7 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_DEV_MARVELL_CESA=y
 CONFIG_CRC_CCITT=y
 CONFIG_LIBCRC32C=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index a53ccd49f8ff..6de33b14dd27 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -123,7 +123,7 @@ CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SLUB_DEBUG is not set
 CONFIG_SCHEDSTATS=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index ef3a33ebc29a..4704629b90ee 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -184,7 +184,7 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_DEV_MARVELL_CESA=y
diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 68a18264f31b..079573e5018a 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -147,7 +147,7 @@ CONFIG_NLS_UTF8=y
 CONFIG_CRYPTO_DEV_MARVELL_CESA=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 155553ee06f4..1a7c676c825d 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -163,7 +163,7 @@ CONFIG_CRC_ITU_T=m
 CONFIG_CRC7=m
 CONFIG_FONTS=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_WARN=2048
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index d5881de42018..3185c43b3b3f 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -135,7 +135,7 @@ CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_DES=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 54a9f50122af..e21adde6997a 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -218,7 +218,7 @@ CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_UTF8=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 99d015cf8919..3e6030e5ca62 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -726,6 +726,7 @@ CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DEBUG_INFO_SPLIT=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 1311d9583fcc..981c3ffe6ba1 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -140,7 +140,7 @@ CONFIG_CRC_T10DIF=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 # CONFIG_SLUB_DEBUG is not set
 CONFIG_LATENCYTOP=y
 # CONFIG_FTRACE is not set
diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/pxa168_defconfig
index 70d327895ccf..53625450c089 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -52,7 +52,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
index ae0444949a87..00e13b8b37d9 100644
--- a/arch/arm/configs/pxa255-idp_defconfig
+++ b/arch/arm/configs/pxa255-idp_defconfig
@@ -49,7 +49,7 @@ CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index 5072bde71508..bf9128a9149f 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -60,7 +60,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
 CONFIG_DEBUG_MMP_UART2=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 104a45722799..6068293da07b 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -646,7 +646,7 @@ CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=m
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_TIMER_STATS=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MANAGER=y
diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 8a59441701a8..b39c22ce39ca 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -310,7 +310,7 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SLUB_DEBUG is not set
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index 41b40863a78e..09611ee3509a 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -429,7 +429,7 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=m
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MUTEXES=y
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index 4f04f583c738..5a13a973b26c 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -62,7 +62,7 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_RT_MUTEXES=y
diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 789e900a8a08..7f233336226d 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -115,7 +115,7 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_CRC_CCITT=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index d91ae3f0d698..a772c8a64e6d 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -152,7 +152,7 @@ CONFIG_NFSD_V4=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 0227dd566c28..6014b73548fc 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -101,4 +101,4 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 254d970a4011..38fed2f44b50 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -81,4 +81,4 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index 2809c4eb77e7..2f0813700816 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -70,4 +70,4 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 1f5446cda8b6..fa8ea56c9f66 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -74,7 +74,7 @@ CONFIG_NLS=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 71400af6cef4..5a1f8ccbbfcc 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -343,7 +343,7 @@ CONFIG_CRYPTO_TWOFISH=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SLAB=y
 CONFIG_DEBUG_VM=y
diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index 4e3a0133e4d3..f6964765a5b4 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -133,7 +133,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_CRYPTO_HW is not set
 CONFIG_DMA_CMA=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5b167649097e..33f4f71576e5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1319,7 +1319,6 @@ CONFIG_CRYPTO_DEV_HISI_TRNG=m
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index 51337fffb947..a0e62b444a35 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -83,7 +83,7 @@ CONFIG_CIFS=y
 CONFIG_CIFS_STATS2=y
 CONFIG_ENCRYPTED_KEYS=y
 CONFIG_DMA_CMA=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_KGDB=y
 CONFIG_KGDB_TESTS=y
 CONFIG_KGDB_KDB=y
diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index 91ce75edbfb4..b6eb14a6a5b3 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -72,7 +72,6 @@ CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_CRC32_SARWATE=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index 97ceaf080c0c..20d3b228304f 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -162,7 +162,7 @@ CONFIG_CRYPTO_SHA1_OCTEON=m
 CONFIG_CRYPTO_SHA256_OCTEON=m
 CONFIG_CRYPTO_SHA512_OCTEON=m
 CONFIG_CRYPTO_DES=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index cc69b215854e..513e39b755b5 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -199,7 +199,7 @@ CONFIG_NLS_UTF8=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/mips/configs/cu1000-neo_defconfig b/arch/mips/configs/cu1000-neo_defconfig
index 5bd55eb32fe5..9828eaa0dcdb 100644
--- a/arch/mips/configs/cu1000-neo_defconfig
+++ b/arch/mips/configs/cu1000-neo_defconfig
@@ -113,7 +113,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_CONSOLE_LOGLEVEL_DEFAULT=15
 CONFIG_CONSOLE_LOGLEVEL_QUIET=15
 CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/mips/configs/cu1830-neo_defconfig b/arch/mips/configs/cu1830-neo_defconfig
index cc69688962e8..88c1a2f21fce 100644
--- a/arch/mips/configs/cu1830-neo_defconfig
+++ b/arch/mips/configs/cu1830-neo_defconfig
@@ -116,7 +116,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_CONSOLE_LOGLEVEL_DEFAULT=15
 CONFIG_CONSOLE_LOGLEVEL_QUIET=15
 CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
index 714169e411cf..e6f5144ff028 100644
--- a/arch/mips/configs/generic_defconfig
+++ b/arch/mips/configs/generic_defconfig
@@ -83,7 +83,6 @@ CONFIG_ROOT_NFS=y
 # CONFIG_XZ_DEC_ARMTHUMB is not set
 # CONFIG_XZ_DEC_SPARC is not set
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/mips/configs/omega2p_defconfig b/arch/mips/configs/omega2p_defconfig
index fc39ddf610a9..a13c20c57a3f 100644
--- a/arch/mips/configs/omega2p_defconfig
+++ b/arch/mips/configs/omega2p_defconfig
@@ -116,7 +116,7 @@ CONFIG_CRYPTO_LZO=y
 CONFIG_CRC16=y
 CONFIG_XZ_DEC=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
index b4448d0876d5..e14d7533271e 100644
--- a/arch/mips/configs/qi_lb60_defconfig
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -166,7 +166,7 @@ CONFIG_NLS_UTF8=y
 CONFIG_FONTS=y
 CONFIG_FONT_SUN8x16=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_READABLE_ASM=y
 CONFIG_KGDB=y
diff --git a/arch/mips/configs/vocore2_defconfig b/arch/mips/configs/vocore2_defconfig
index a14f8ea5c386..80efb90ad5c7 100644
--- a/arch/mips/configs/vocore2_defconfig
+++ b/arch/mips/configs/vocore2_defconfig
@@ -116,7 +116,7 @@ CONFIG_CRYPTO_LZO=y
 CONFIG_CRC16=y
 CONFIG_XZ_DEC=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/nios2/configs/10m50_defconfig b/arch/nios2/configs/10m50_defconfig
index a7967b4cfb6e..e88c62505aa0 100644
--- a/arch/nios2/configs/10m50_defconfig
+++ b/arch/nios2/configs/10m50_defconfig
@@ -74,4 +74,4 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
 CONFIG_SUNRPC_DEBUG=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
diff --git a/arch/nios2/configs/3c120_defconfig b/arch/nios2/configs/3c120_defconfig
index 423a0c40a162..66f05c414ef3 100644
--- a/arch/nios2/configs/3c120_defconfig
+++ b/arch/nios2/configs/3c120_defconfig
@@ -71,4 +71,4 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_ROOT_NFS=y
 CONFIG_SUNRPC_DEBUG=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
diff --git a/arch/powerpc/configs/44x/akebono_defconfig b/arch/powerpc/configs/44x/akebono_defconfig
index fde4824f235e..e4b90ac530f3 100644
--- a/arch/powerpc/configs/44x/akebono_defconfig
+++ b/arch/powerpc/configs/44x/akebono_defconfig
@@ -118,7 +118,7 @@ CONFIG_CRAMFS=y
 CONFIG_NLS_DEFAULT="n"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_XMON=y
diff --git a/arch/powerpc/configs/44x/currituck_defconfig b/arch/powerpc/configs/44x/currituck_defconfig
index 7283b7d4a1a5..f2d88e6bbbe1 100644
--- a/arch/powerpc/configs/44x/currituck_defconfig
+++ b/arch/powerpc/configs/44x/currituck_defconfig
@@ -73,7 +73,7 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_NLS_DEFAULT="n"
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_XMON=y
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index 3fdfbb29b854..d6c34a9c0156 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -110,7 +110,7 @@ CONFIG_XZ_DEC=y
 CONFIG_PRINTK_TIME=y
 CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_CBC=y
diff --git a/arch/powerpc/configs/44x/iss476-smp_defconfig b/arch/powerpc/configs/44x/iss476-smp_defconfig
index 0f6380e1e612..0c8899426399 100644
--- a/arch/powerpc/configs/44x/iss476-smp_defconfig
+++ b/arch/powerpc/configs/44x/iss476-smp_defconfig
@@ -56,7 +56,7 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_PPC_EARLY_DEBUG=y
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 20891c413149..aca01bd8ae54 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -88,7 +88,7 @@ CONFIG_NLS_UTF8=y
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/powerpc/configs/52xx/lite5200b_defconfig b/arch/powerpc/configs/52xx/lite5200b_defconfig
index 7db479dcbc0c..d8e3afb508fa 100644
--- a/arch/powerpc/configs/52xx/lite5200b_defconfig
+++ b/arch/powerpc/configs/52xx/lite5200b_defconfig
@@ -58,6 +58,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/configs/52xx/motionpro_defconfig
index 6186ead1e105..777ddc1a9cd1 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -84,7 +84,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_ECB=y
diff --git a/arch/powerpc/configs/52xx/tqm5200_defconfig b/arch/powerpc/configs/52xx/tqm5200_defconfig
index e6735b945327..976e94d4c95f 100644
--- a/arch/powerpc/configs/52xx/tqm5200_defconfig
+++ b/arch/powerpc/configs/52xx/tqm5200_defconfig
@@ -85,7 +85,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_ECB=y
diff --git a/arch/powerpc/configs/adder875_defconfig b/arch/powerpc/configs/adder875_defconfig
index 7f35d5bc1229..13ea9bfc1642 100644
--- a/arch/powerpc/configs/adder875_defconfig
+++ b/arch/powerpc/configs/adder875_defconfig
@@ -45,7 +45,7 @@ CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC32_SLICEBY4=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/powerpc/configs/ep8248e_defconfig b/arch/powerpc/configs/ep8248e_defconfig
index 8df6d3a293e3..17fbbb56aa30 100644
--- a/arch/powerpc/configs/ep8248e_defconfig
+++ b/arch/powerpc/configs/ep8248e_defconfig
@@ -59,7 +59,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_BDI_SWITCH=y
diff --git a/arch/powerpc/configs/ep88xc_defconfig b/arch/powerpc/configs/ep88xc_defconfig
index a98ef6a4abef..b1766808941a 100644
--- a/arch/powerpc/configs/ep88xc_defconfig
+++ b/arch/powerpc/configs/ep88xc_defconfig
@@ -48,6 +48,6 @@ CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC32_SLICEBY4=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
index 498d35db7833..0d45d47009e5 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -73,7 +73,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index c0fe5e76604a..9d51665b9e1a 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -122,6 +122,6 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/powerpc/configs/mpc8272_ads_defconfig b/arch/powerpc/configs/mpc8272_ads_defconfig
index 4145ef5689ca..5860de900aca 100644
--- a/arch/powerpc/configs/mpc8272_ads_defconfig
+++ b/arch/powerpc/configs/mpc8272_ads_defconfig
@@ -67,7 +67,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_BDI_SWITCH=y
diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index 700115d85d6f..e70f417c8407 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -71,7 +71,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_DEV_TALITOS=y
 CONFIG_CRC32_SLICEBY4=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_VM_PGTABLE=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 91967824272e..df070217e197 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -1065,7 +1065,7 @@ CONFIG_NLS_ISO8859_14=m
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_HEADERS_INSTALL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
diff --git a/arch/powerpc/configs/pq2fads_defconfig b/arch/powerpc/configs/pq2fads_defconfig
index 9d63e2e65211..260d98ea317e 100644
--- a/arch/powerpc/configs/pq2fads_defconfig
+++ b/arch/powerpc/configs/pq2fads_defconfig
@@ -68,7 +68,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index 2d9ac233da68..4c1d69d3b346 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -153,7 +153,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_CRC_CCITT=m
 CONFIG_CRC_T10DIF=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_STACKOVERFLOW=y
diff --git a/arch/powerpc/configs/tqm8xx_defconfig b/arch/powerpc/configs/tqm8xx_defconfig
index 083c2e57520a..5a9868c12ed1 100644
--- a/arch/powerpc/configs/tqm8xx_defconfig
+++ b/arch/powerpc/configs/tqm8xx_defconfig
@@ -55,6 +55,6 @@ CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRC32_SLICEBY4=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 2a827002934b..ef4ea34bc378 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -796,6 +796,7 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=0
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_GDB_SCRIPTS=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index fb780e80e4c8..ea5555f92288 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -780,6 +780,7 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=0
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_GDB_SCRIPTS=y
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index a5576b8d4081..5e5fe7297bbf 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -73,6 +73,7 @@ CONFIG_XZ_DEC_MICROLZMA=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_SYMBOLIC_ERRNAME is not set
 CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/sh/configs/apsh4a3a_defconfig b/arch/sh/configs/apsh4a3a_defconfig
index 530498f18990..694eb2bcf3dd 100644
--- a/arch/sh/configs/apsh4a3a_defconfig
+++ b/arch/sh/configs/apsh4a3a_defconfig
@@ -85,7 +85,7 @@ CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 # CONFIG_FTRACE is not set
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/sh/configs/apsh4ad0a_defconfig b/arch/sh/configs/apsh4ad0a_defconfig
index 6abd9bd70106..f462ede40b30 100644
--- a/arch/sh/configs/apsh4ad0a_defconfig
+++ b/arch/sh/configs/apsh4ad0a_defconfig
@@ -116,7 +116,7 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_VM=y
 CONFIG_DWARF_UNWINDER=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/sh/configs/edosk7760_defconfig b/arch/sh/configs/edosk7760_defconfig
index d77f54e906fd..7ad05675adc8 100644
--- a/arch/sh/configs/edosk7760_defconfig
+++ b/arch/sh/configs/edosk7760_defconfig
@@ -107,7 +107,7 @@ CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_TIMER_STATS=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
diff --git a/arch/sh/configs/magicpanelr2_defconfig b/arch/sh/configs/magicpanelr2_defconfig
index 0989ed929540..78e484d3f80b 100644
--- a/arch/sh/configs/magicpanelr2_defconfig
+++ b/arch/sh/configs/magicpanelr2_defconfig
@@ -84,7 +84,7 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_KOBJECT=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_FRAME_POINTER=y
 CONFIG_CRC_CCITT=m
 CONFIG_CRC16=m
diff --git a/arch/sh/configs/polaris_defconfig b/arch/sh/configs/polaris_defconfig
index 246408ec7462..8d33040c6763 100644
--- a/arch/sh/configs/polaris_defconfig
+++ b/arch/sh/configs/polaris_defconfig
@@ -79,5 +79,5 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_SG=y
diff --git a/arch/sh/configs/r7780mp_defconfig b/arch/sh/configs/r7780mp_defconfig
index f823cc6b18f9..153ebc7890b4 100644
--- a/arch/sh/configs/r7780mp_defconfig
+++ b/arch/sh/configs/r7780mp_defconfig
@@ -101,7 +101,7 @@ CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_PREEMPT is not set
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
diff --git a/arch/sh/configs/r7785rp_defconfig b/arch/sh/configs/r7785rp_defconfig
index f96bc20d4b1a..c74324b51d92 100644
--- a/arch/sh/configs/r7785rp_defconfig
+++ b/arch/sh/configs/r7785rp_defconfig
@@ -96,7 +96,7 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_SH_STANDARD_BIOS=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_4KSTACKS=y
diff --git a/arch/sh/configs/rsk7203_defconfig b/arch/sh/configs/rsk7203_defconfig
index 5a54e2b883f0..8eba35621a51 100644
--- a/arch/sh/configs/rsk7203_defconfig
+++ b/arch/sh/configs/rsk7203_defconfig
@@ -112,7 +112,7 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_OBJECTS=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_LIST=y
 CONFIG_DEBUG_SG=y
diff --git a/arch/sh/configs/sdk7780_defconfig b/arch/sh/configs/sdk7780_defconfig
index 7d6d32359848..90cd14f32df2 100644
--- a/arch/sh/configs/sdk7780_defconfig
+++ b/arch/sh/configs/sdk7780_defconfig
@@ -131,7 +131,7 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_TIMER_STATS=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_SH_STANDARD_BIOS=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
diff --git a/arch/sh/configs/se7712_defconfig b/arch/sh/configs/se7712_defconfig
index ee6d28ae08de..70cbac89271b 100644
--- a/arch/sh/configs/se7712_defconfig
+++ b/arch/sh/configs/se7712_defconfig
@@ -93,7 +93,7 @@ CONFIG_CRAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_FRAME_POINTER=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/sh/configs/se7721_defconfig b/arch/sh/configs/se7721_defconfig
index bad921bc10f8..be33fa12c9d0 100644
--- a/arch/sh/configs/se7721_defconfig
+++ b/arch/sh/configs/se7721_defconfig
@@ -121,7 +121,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_FRAME_POINTER=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRC_CCITT=y
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index 79f02f1c0dc8..3aafc1866fff 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -159,7 +159,7 @@ CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHED_DEBUG is not set
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_FRAME_POINTER=y
 CONFIG_SH_STANDARD_BIOS=y
 CONFIG_CRYPTO_NULL=y
diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index a2700ab165af..27fe8741d829 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -80,6 +80,6 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 # CONFIG_FTRACE is not set
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 7eb3c10f28ad..ec610727a42a 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -141,7 +141,7 @@ CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_LATENCYTOP=y
 # CONFIG_FTRACE is not set
 CONFIG_CRYPTO_HMAC=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index cb2f56468fe0..a5a4798baccb 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -139,7 +139,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_FRAME_POINTER=y
 # CONFIG_FTRACE is not set
 # CONFIG_DUMP_CODE is not set
diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index fb51bd206dbe..1109ab005597 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -69,5 +69,5 @@ CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NLS=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_DEBUG_KERNEL=y
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 477b87317424..33f0c8e96184 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -67,6 +67,6 @@ CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NLS=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_FRAME_WARN=1024
 CONFIG_DEBUG_KERNEL=y
diff --git a/arch/xtensa/configs/audio_kc705_defconfig b/arch/xtensa/configs/audio_kc705_defconfig
index 3be62da8089b..a8a6c224ea3d 100644
--- a/arch/xtensa/configs/audio_kc705_defconfig
+++ b/arch/xtensa/configs/audio_kc705_defconfig
@@ -120,7 +120,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index fc240737b14d..fa4439f382ff 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -100,7 +100,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/xtensa/configs/generic_kc705_defconfig b/arch/xtensa/configs/generic_kc705_defconfig
index e9d6b6f6eca1..82bbd127e054 100644
--- a/arch/xtensa/configs/generic_kc705_defconfig
+++ b/arch/xtensa/configs/generic_kc705_defconfig
@@ -107,7 +107,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index fcb620ef3799..b9afbecacfd9 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -105,7 +105,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 # CONFIG_FRAME_POINTER is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_VM=y
diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index a47c85638ec1..b557789aa8e7 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -111,7 +111,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_VM=y
 CONFIG_LOCKUP_DETECTOR=y
diff --git a/arch/xtensa/configs/virt_defconfig b/arch/xtensa/configs/virt_defconfig
index 6d1387dfa96f..4b6e009d48d0 100644
--- a/arch/xtensa/configs/virt_defconfig
+++ b/arch/xtensa/configs/virt_defconfig
@@ -97,7 +97,7 @@ CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_FONTS=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
diff --git a/arch/xtensa/configs/xip_kc705_defconfig b/arch/xtensa/configs/xip_kc705_defconfig
index 062148e17135..bb5ce53b1c8f 100644
--- a/arch/xtensa/configs/xip_kc705_defconfig
+++ b/arch/xtensa/configs/xip_kc705_defconfig
@@ -102,7 +102,7 @@ CONFIG_CRYPTO_LZO=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc90414d492e..ce1faae1a979 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -234,15 +234,10 @@ config DEBUG_INFO
 choice
 	prompt "Debug information"
 	depends on DEBUG_KERNEL
+	depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
 	help
 	  Selecting something other than "None" results in a kernel image
 	  that will include debugging info resulting in a larger kernel image.
-	  This adds debug symbols to the kernel and modules (gcc -g), and
-	  is needed if you intend to use kernel crashdump or binary object
-	  tools like crash, kgdb, LKCD, gdb, etc on the kernel.
-
-	  Choose which version of DWARF debug info to emit. If unsure,
-	  select "Toolchain default".
 
 config DEBUG_INFO_NONE
 	bool "Disable debug information"
@@ -250,10 +245,40 @@ config DEBUG_INFO_NONE
 	  Do not build the kernel with debugging information, which will
 	  result in a faster and smaller build.
 
+config DEBUG_INFO_REDUCED
+	bool "Reduced debugging information"
+	select DEBUG_INFO
+	help
+	  If you say Y here compiler is instructed to generate less debugging
+	  information for structure types. This means that tools that
+	  need full debugging information (like kgdb or systemtap) won't
+	  be happy. But if you merely need debugging information to
+	  resolve line numbers there is no loss. Advantage is that
+	  build directory object sizes shrink dramatically over a full
+	  DEBUG_INFO build and compile times are reduced too.
+	  Only works with newer gcc versions.
+
+config DEBUG_INFO_DEFAULT
+	bool "Default-level debugging information"
+	select DEBUG_INFO
+	help
+	  If you say Y here compiler is instructed to generate the default
+	  level of debugging information.
+
+	  This adds debug symbols to the kernel and modules (gcc -g), and
+	  is needed if you intend to use kernel crashdump or binary object
+	  tools like crash, kgdb, LKCD, gdb, etc on the kernel.
+
+endchoice # "Debug information"
+
+choice
+	prompt "DWARF version"
+	depends on DEBUG_INFO
+	help
+	  Which version of DWARF debug info to emit.
+
 config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 	bool "Rely on the toolchain's implicit default DWARF version"
-	select DEBUG_INFO
-	depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
 	help
 	  The implicit default version of DWARF debug info produced by a
 	  toolchain changes over time.
@@ -262,9 +287,10 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 	  support newer revisions, and prevent testing newer versions, but
 	  those should be less common scenarios.
 
+	  If unsure, say Y.
+
 config DEBUG_INFO_DWARF4
 	bool "Generate DWARF Version 4 debuginfo"
-	select DEBUG_INFO
 	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
 	help
 	  Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
@@ -276,7 +302,6 @@ config DEBUG_INFO_DWARF4
 
 config DEBUG_INFO_DWARF5
 	bool "Generate DWARF Version 5 debuginfo"
-	select DEBUG_INFO
 	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
 	help
 	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
@@ -291,22 +316,10 @@ config DEBUG_INFO_DWARF5
 	  config if they rely on tooling that has not yet been updated to
 	  support DWARF Version 5.
 
-endchoice # "Debug information"
+endchoice # "DWARF version"
 
 if DEBUG_INFO
 
-config DEBUG_INFO_REDUCED
-	bool "Reduce debugging information"
-	help
-	  If you say Y here gcc is instructed to generate less debugging
-	  information for structure types. This means that tools that
-	  need full debugging information (like kgdb or systemtap) won't
-	  be happy. But if you merely need debugging information to
-	  resolve line numbers there is no loss. Advantage is that
-	  build directory object sizes shrink dramatically over a full
-	  DEBUG_INFO build and compile times are reduced too.
-	  Only works with newer gcc versions.
-
 config DEBUG_INFO_COMPRESSED
 	bool "Compressed debugging information"
 	depends on $(cc-option,-gz=zlib)
-- 
2.34.1

