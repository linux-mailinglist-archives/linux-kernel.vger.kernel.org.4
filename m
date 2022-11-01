Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE585614A51
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiKAMIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKAMIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:08:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F192EE084
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 05:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE5A5B81CEA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4982CC433D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:08:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S+zXTz9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667304504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ip0uE5GdwmiGmy7PrUttMd5M6Y/zAntzvGWwNcU0BbM=;
        b=S+zXTz9hQhWrs8A0Hlk/scj8TZPmq5c7Gh4TuPYK8WXqSKDKFmn0r7YXu8ICqqHkNapVT0
        NhxJZT5OCN4rmEJoxDEszMcPzHt0DEoXn2dkrL44p/62+5juOEVhR/2fA3hB4z5bXi3ci5
        zt+hDGmvgbv79v2wzwwqnipUf7WHnbk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 31191740 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Nov 2022 12:08:24 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: use random.trust_{bootloader,cpu} command line option only
Date:   Tue,  1 Nov 2022 13:08:11 +0100
Message-Id: <20221101120811.268354-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's very unusual to have both a command line option and a compile time
option, and apparently that's confusing to people. Also, basically
everybody enables the compile time option now, which means people who
want to disable this wind up having to use the command line option to
ensure that anyway. So just reduce the number of moving pieces and nix
the compile time option in favor of the more versatile command line
option.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 .../admin-guide/kernel-parameters.txt         | 20 +++++------
 arch/powerpc/configs/microwatt_defconfig      |  1 -
 arch/s390/configs/debug_defconfig             |  2 --
 arch/s390/configs/defconfig                   |  2 --
 arch/s390/configs/zfcpdump_defconfig          |  1 -
 drivers/char/Kconfig                          | 36 -------------------
 drivers/char/random.c                         | 10 +++---
 .../selftests/wireguard/qemu/kernel.config    |  2 --
 8 files changed, 14 insertions(+), 60 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a465d5242774..78493797460f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4566,17 +4566,15 @@
 
 	ramdisk_start=	[RAM] RAM disk image start address
 
-	random.trust_cpu={on,off}
-			[KNL] Enable or disable trusting the use of the
-			CPU's random number generator (if available) to
-			fully seed the kernel's CRNG. Default is controlled
-			by CONFIG_RANDOM_TRUST_CPU.
-
-	random.trust_bootloader={on,off}
-			[KNL] Enable or disable trusting the use of a
-			seed passed by the bootloader (if available) to
-			fully seed the kernel's CRNG. Default is controlled
-			by CONFIG_RANDOM_TRUST_BOOTLOADER.
+	random.trust_cpu=off
+			[KNL] Disable trusting the use of the CPU's
+			random number generator (if available) to
+			initialize the kernel's RNG.
+
+	random.trust_bootloader=off
+			[KNL] Disable trusting the use of the a seed
+			passed by the bootloader (if available) to
+			initialize the kernel's RNG.
 
 	randomize_kstack_offset=
 			[KNL] Enable or disable kernel stack offset
diff --git a/arch/powerpc/configs/microwatt_defconfig b/arch/powerpc/configs/microwatt_defconfig
index ea2dbd778aad..18d4fe4108cb 100644
--- a/arch/powerpc/configs/microwatt_defconfig
+++ b/arch/powerpc/configs/microwatt_defconfig
@@ -68,7 +68,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_NVRAM is not set
-CONFIG_RANDOM_TRUST_CPU=y
 CONFIG_SPI=y
 CONFIG_SPI_DEBUG=y
 CONFIG_SPI_BITBANG=y
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 2a827002934b..2bb3469092f0 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -573,8 +573,6 @@ CONFIG_VIRTIO_CONSOLE=m
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_HANGCHECK_TIMER=m
 CONFIG_TN3270_FS=y
-# CONFIG_RANDOM_TRUST_CPU is not set
-# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
 CONFIG_PPS=m
 # CONFIG_PTP_1588_CLOCK is not set
 # CONFIG_HWMON is not set
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index fb780e80e4c8..366bf3fd0208 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -563,8 +563,6 @@ CONFIG_VIRTIO_CONSOLE=m
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_HANGCHECK_TIMER=m
 CONFIG_TN3270_FS=y
-# CONFIG_RANDOM_TRUST_CPU is not set
-# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
 # CONFIG_PTP_1588_CLOCK is not set
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index a5576b8d4081..9a6269c2374c 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -58,7 +58,6 @@ CONFIG_ZFCP=y
 # CONFIG_VMCP is not set
 # CONFIG_MONWRITER is not set
 # CONFIG_S390_VMUR is not set
-# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
 # CONFIG_HID is not set
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_VHOST_MENU is not set
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 0f378d29dab0..30fe9848dac1 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -423,40 +423,4 @@ config ADI
 	  and SSM (Silicon Secured Memory).  Intended consumers of this
 	  driver include crash and makedumpfile.
 
-config RANDOM_TRUST_CPU
-	bool "Initialize RNG using CPU RNG instructions"
-	default y
-	help
-	  Initialize the RNG using random numbers supplied by the CPU's
-	  RNG instructions (e.g. RDRAND), if supported and available. These
-	  random numbers are never used directly, but are rather hashed into
-	  the main input pool, and this happens regardless of whether or not
-	  this option is enabled. Instead, this option controls whether the
-	  they are credited and hence can initialize the RNG. Additionally,
-	  other sources of randomness are always used, regardless of this
-	  setting.  Enabling this implies trusting that the CPU can supply high
-	  quality and non-backdoored random numbers.
-
-	  Say Y here unless you have reason to mistrust your CPU or believe
-	  its RNG facilities may be faulty. This may also be configured at
-	  boot time with "random.trust_cpu=on/off".
-
-config RANDOM_TRUST_BOOTLOADER
-	bool "Initialize RNG using bootloader-supplied seed"
-	default y
-	help
-	  Initialize the RNG using a seed supplied by the bootloader or boot
-	  environment (e.g. EFI or a bootloader-generated device tree). This
-	  seed is not used directly, but is rather hashed into the main input
-	  pool, and this happens regardless of whether or not this option is
-	  enabled. Instead, this option controls whether the seed is credited
-	  and hence can initialize the RNG. Additionally, other sources of
-	  randomness are always used, regardless of this setting. Enabling
-	  this implies trusting that the bootloader can supply high quality and
-	  non-backdoored seeds.
-
-	  Say Y here unless you have reason to mistrust your bootloader or
-	  believe its RNG facilities may be faulty. This may also be configured
-	  at boot time with "random.trust_bootloader=on/off".
-
 endmenu
diff --git a/drivers/char/random.c b/drivers/char/random.c
index e3cf4f51ed58..5da120f10a67 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -732,7 +732,7 @@ static void __cold _credit_init_bits(size_t bits)
  *
  * add_bootloader_randomness() is called by bootloader drivers, such as EFI
  * and device tree, and credits its input depending on whether or not the
- * configuration option CONFIG_RANDOM_TRUST_BOOTLOADER is set.
+ * command line option 'random.trust_bootloader'.
  *
  * add_vmfork_randomness() adds a unique (but not necessarily secret) ID
  * representing the current instance of a VM to the pool, without crediting,
@@ -758,8 +758,8 @@ static void __cold _credit_init_bits(size_t bits)
  *
  **********************************************************************/
 
-static bool trust_cpu __initdata = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
-static bool trust_bootloader __initdata = IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER);
+static bool trust_cpu __initdata = true;
+static bool trust_bootloader __initdata = true;
 static int __init parse_trust_cpu(char *arg)
 {
 	return kstrtobool(arg, &trust_cpu);
@@ -910,8 +910,8 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 
 /*
- * Handle random seed passed by bootloader, and credit it if
- * CONFIG_RANDOM_TRUST_BOOTLOADER is set.
+ * Handle random seed passed by bootloader, and credit it depending
+ * on the command line option 'random.trust_bootloader'.
  */
 void __init add_bootloader_randomness(const void *buf, size_t len)
 {
diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index ce2a04717300..6327c9c400e0 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -64,8 +64,6 @@ CONFIG_PROC_FS=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
-CONFIG_RANDOM_TRUST_CPU=y
-CONFIG_RANDOM_TRUST_BOOTLOADER=y
 CONFIG_CONSOLE_LOGLEVEL_DEFAULT=15
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_PRINTK_TIME=y
-- 
2.38.1

