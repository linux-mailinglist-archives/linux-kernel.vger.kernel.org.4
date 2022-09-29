Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70725EEBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiI2Cdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbiI2CdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:33:18 -0400
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E08012519D;
        Wed, 28 Sep 2022 19:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=27371; q=dns/txt;
  s=iport; t=1664418795; x=1665628395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9dYBkHEHNbEEC29kkkDnCqzOdoFdYCahyhQHvg2ySWk=;
  b=GZ96bii8GBqdm9fcJaBRZp5+2sq2V0MYrnIl6ggBYMAJPgU+OcUB+DZk
   cpN4ZnOQs56aAL/8PTqyp4P8qFTgSNz11q6Uqho8PhKIC9dva67MUMrT/
   V5ad3VazKYxYE8UMc04/POC3UW1KjnZvVcj7sfcVtYLDuYKrBTUgAx3UR
   g=;
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1052327482"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Sep 2022 02:33:14 +0000
Received: from zorba.cisco.com ([10.25.129.98])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 28T2X1Yt007711;
        Thu, 29 Sep 2022 02:33:13 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     xe-linux-external@cisco.com,
        Ruslan Ruslichenko <rruslich@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] CMDLINE: mips: convert to generic builtin command line
Date:   Wed, 28 Sep 2022 19:32:50 -0700
Message-Id: <20220929023301.3344694-5-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929023301.3344694-1-danielwa@cisco.com>
References: <20220929023301.3344694-1-danielwa@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-8.cisco.com
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the mips code to use the CONFIG_GENERIC_CMDLINE
option.

This deletes the option for MIPS_CMDLINE_BUILTIN_EXTEND
and replaces the functionality with generic code.

Of note, the pic32 has some strange handling of the current built
in command line. It was converted to use the static variant which
can't be updated after compilation. It should eventually be updated
to use to append and prepend symbols.

This includes a scripted mass convert of the config files to use
the new generic cmdline. There is a bit of a trim effect here.
It would seems that some of the config haven't been trimmed in
a while.

The script used is as follows,

if [[ -z "$1" || -z "$2" ]]; then
        echo "Two arguments are needed."
        exit 1
fi
mkdir $1
cp $2 $1/.config
sed -i 's/CONFIG_CMDLINE=/CONFIG_CMDLINE_BOOL=y\nCONFIG_CMDLINE_PREPEND=/g' $1/.config
make ARCH=$1 O=$1 olddefconfig
make ARCH=$1 O=$1 savedefconfig
cp $1/defconfig $2
rm -Rf $1

Cc: xe-linux-external@cisco.com
Signed-off-by: Ruslan Ruslichenko <rruslich@cisco.com>
Signed-off-by: Ruslan Bilovol <rbilovol@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/mips/Kconfig                         |  4 +--
 arch/mips/Kconfig.debug                   | 44 -----------------------
 arch/mips/configs/ar7_defconfig           |  9 ++---
 arch/mips/configs/bcm47xx_defconfig       |  8 ++---
 arch/mips/configs/bcm63xx_defconfig       | 15 +++-----
 arch/mips/configs/bmips_be_defconfig      | 11 +++---
 arch/mips/configs/bmips_stb_defconfig     |  6 ++--
 arch/mips/configs/ci20_defconfig          |  9 +++--
 arch/mips/configs/cu1000-neo_defconfig    | 10 +++---
 arch/mips/configs/cu1830-neo_defconfig    | 10 +++---
 arch/mips/configs/generic_defconfig       |  6 ++--
 arch/mips/configs/gpr_defconfig           | 18 ++--------
 arch/mips/configs/loongson3_defconfig     | 12 +++----
 arch/mips/include/asm/setup.h             |  2 ++
 arch/mips/kernel/relocate.c               | 17 +++++++--
 arch/mips/kernel/setup.c                  | 36 +++----------------
 arch/mips/pic32/pic32mzda/early_console.c |  2 +-
 arch/mips/pic32/pic32mzda/init.c          |  3 +-
 18 files changed, 64 insertions(+), 158 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 25dd4c5a8ef5..732526b0d53e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -31,6 +31,7 @@ config MIPS
 	select CPU_NO_EFFICIENT_FFS if (TARGET_ISA_REV < 1)
 	select CPU_PM if CPU_IDLE
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_CMDLINE
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_GETTIMEOFDAY
@@ -3084,9 +3085,6 @@ choice
 	config MIPS_CMDLINE_FROM_BOOTLOADER
 		bool "Bootloader kernel arguments if available"
 
-	config MIPS_CMDLINE_BUILTIN_EXTEND
-		depends on CMDLINE_BOOL
-		bool "Extend builtin kernel arguments with bootloader arguments"
 endchoice
 
 endmenu
diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index f4ae7900fcd3..f9da53d4ebd2 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -26,50 +26,6 @@ config EARLY_PRINTK_8250
 config USE_GENERIC_EARLY_PRINTK_8250
 	bool
 
-config CMDLINE_BOOL
-	bool "Built-in kernel command line"
-	help
-	  For most systems, it is firmware or second stage bootloader that
-	  by default specifies the kernel command line options.  However,
-	  it might be necessary or advantageous to either override the
-	  default kernel command line or add a few extra options to it.
-	  For such cases, this option allows you to hardcode your own
-	  command line options directly into the kernel.  For that, you
-	  should choose 'Y' here, and fill in the extra boot arguments
-	  in CONFIG_CMDLINE.
-
-	  The built-in options will be concatenated to the default command
-	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
-	  command line will be ignored and replaced by the built-in string.
-
-	  Most MIPS systems will normally expect 'N' here and rely upon
-	  the command line from the firmware or the second-stage bootloader.
-
-config CMDLINE
-	string "Default kernel command string"
-	depends on CMDLINE_BOOL
-	help
-	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel.  For these platforms, and for the cases
-	  when you want to add some extra options to the command line or ignore
-	  the default command line, you can supply some command-line options at
-	  build time by entering them here.  In other cases you can specify
-	  kernel args so that you don't have to set them up in board prom
-	  initialization routines.
-
-	  For more information, see the CMDLINE_BOOL and CMDLINE_OVERRIDE
-	  options.
-
-config CMDLINE_OVERRIDE
-	bool "Built-in command line overrides firmware arguments"
-	depends on CMDLINE_BOOL
-	help
-	  By setting this option to 'Y' you will have your kernel ignore
-	  command line arguments from firmware or second stage bootloader.
-	  Instead, the built-in command line will be used exclusively.
-
-	  Normally, you will choose 'N' here.
-
 config SB1XXX_CORELIS
 	bool "Corelis Debugger"
 	depends on SIBYTE_SB1xxx_SOC
diff --git a/arch/mips/configs/ar7_defconfig b/arch/mips/configs/ar7_defconfig
index cf9c6329b807..c09470aa672f 100644
--- a/arch/mips/configs/ar7_defconfig
+++ b/arch/mips/configs/ar7_defconfig
@@ -12,6 +12,8 @@ CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="rootfstype=squashfs,jffs2"
 CONFIG_AR7=y
 CONFIG_HZ_100=y
 CONFIG_KEXEC=y
@@ -32,9 +34,6 @@ CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_MROUTE=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -43,7 +42,6 @@ CONFIG_TCP_CONG_WESTWOOD=y
 # CONFIG_TCP_CONG_HTCP is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
-# CONFIG_BRIDGE_NETFILTER is not set
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_FTP=m
@@ -117,8 +115,5 @@ CONFIG_JFFS2_SUMMARY=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_SQUASHFS=y
 # CONFIG_CRYPTO_HW is not set
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="rootfstype=squashfs,jffs2"
diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index 91ce75edbfb4..69a965bb2dd9 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -4,8 +4,9 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="console=ttyS0,115200"
 CONFIG_BCM47XX=y
-CONFIG_PCI=y
 # CONFIG_SUSPEND is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -32,6 +33,7 @@ CONFIG_NET_SCH_FQ_CODEL=y
 CONFIG_HAMRADIO=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
+CONFIG_PCI=y
 CONFIG_MTD=y
 CONFIG_MTD_BCM47XX_PARTS=y
 CONFIG_MTD_BLOCK=y
@@ -75,7 +77,5 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_STRIP_ASM_SYMS=y
-CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200"
+CONFIG_DEBUG_FS=y
diff --git a/arch/mips/configs/bcm63xx_defconfig b/arch/mips/configs/bcm63xx_defconfig
index 861f680184b9..6791e48b2d7d 100644
--- a/arch/mips/configs/bcm63xx_defconfig
+++ b/arch/mips/configs/bcm63xx_defconfig
@@ -11,27 +11,26 @@ CONFIG_EXPERT=y
 # CONFIG_AIO is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="console=ttyS0,115200"
 CONFIG_BCM63XX=y
 CONFIG_BCM63XX_CPU_6338=y
 CONFIG_BCM63XX_CPU_6345=y
 CONFIG_BCM63XX_CPU_6348=y
 CONFIG_BCM63XX_CPU_6358=y
 # CONFIG_SECCOMP is not set
-CONFIG_PCI=y
-CONFIG_PCCARD=y
-CONFIG_PCMCIA_BCM63XX=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CFG80211=y
 CONFIG_NL80211_TESTMODE=y
 CONFIG_MAC80211=y
+CONFIG_PCI=y
+CONFIG_PCCARD=y
+CONFIG_PCMCIA_BCM63XX=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_MTD=y
@@ -50,8 +49,6 @@ CONFIG_B43=y
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
 # CONFIG_UNIX98_PTYS is not set
-CONFIG_SERIAL_BCM63XX=y
-CONFIG_SERIAL_BCM63XX_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 # CONFIG_VGA_ARB is not set
@@ -65,5 +62,3 @@ CONFIG_PROC_KCORE=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 # CONFIG_CRYPTO_HW is not set
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200"
diff --git a/arch/mips/configs/bmips_be_defconfig b/arch/mips/configs/bmips_be_defconfig
index 032bb51defe8..ae1c4adf8d98 100644
--- a/arch/mips/configs/bmips_be_defconfig
+++ b/arch/mips/configs/bmips_be_defconfig
@@ -5,21 +5,20 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="earlycon"
 CONFIG_BMIPS_GENERIC=y
 CONFIG_HIGHMEM=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=4
-# CONFIG_SECCOMP is not set
 CONFIG_MIPS_O32_FP64_SUPPORT=y
+# CONFIG_SECCOMP is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_CFG80211=y
 CONFIG_NL80211_TESTMODE=y
@@ -73,7 +72,5 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_CRYPTO_HW is not set
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="earlycon"
+CONFIG_DEBUG_FS=y
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 5956fb95c19f..19d9ef899d42 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -6,6 +6,8 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="earlycon"
 CONFIG_BMIPS_GENERIC=y
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_HIGHMEM=y
@@ -38,15 +40,13 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_BMIPS_CPUFREQ=y
+# CONFIG_SECCOMP is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_CFG80211=y
 CONFIG_NL80211_TESTMODE=y
diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index cc69b215854e..20c3e4c33356 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -22,12 +22,14 @@ CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="earlycon console=ttyS4,115200 clk_ignore_unused"
 CONFIG_MACH_INGENIC_SOC=y
 CONFIG_JZ4780_CI20=y
 CONFIG_HIGHMEM=y
 CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
 # CONFIG_SUSPEND is not set
+# CONFIG_SECCOMP is not set
 CONFIG_MODULES=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_COMPACTION is not set
@@ -111,6 +113,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_SERIAL=y
 CONFIG_USB_SERIAL_CH341=y
+CONFIG_JZ4770_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_MMC=y
 CONFIG_MMC_JZ4740=y
@@ -144,7 +147,6 @@ CONFIG_JZ4780_NEMC=y
 CONFIG_PWM=y
 CONFIG_PWM_JZ4740=m
 CONFIG_JZ4780_EFUSE=y
-CONFIG_JZ4770_PHY=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_AUTOFS_FS=y
@@ -157,7 +159,6 @@ CONFIG_CONFIGFS_FS=y
 CONFIG_UBIFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
-CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_737=y
 CONFIG_NLS_CODEPAGE_775=y
@@ -209,5 +210,3 @@ CONFIG_PANIC_TIMEOUT=10
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="earlycon console=ttyS4,115200 clk_ignore_unused"
diff --git a/arch/mips/configs/cu1000-neo_defconfig b/arch/mips/configs/cu1000-neo_defconfig
index 5bd55eb32fe5..a554439529cd 100644
--- a/arch/mips/configs/cu1000-neo_defconfig
+++ b/arch/mips/configs/cu1000-neo_defconfig
@@ -19,12 +19,14 @@ CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="earlycon clk_ignore_unused"
 CONFIG_MACH_INGENIC_SOC=y
 CONFIG_X1000_CU1000_NEO=y
 CONFIG_HIGHMEM=y
 CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
 # CONFIG_SUSPEND is not set
+# CONFIG_SECCOMP is not set
 CONFIG_MODULES=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_COMPACTION is not set
@@ -67,12 +69,12 @@ CONFIG_SENSORS_ADS7828=m
 CONFIG_WATCHDOG=y
 CONFIG_JZ4740_WDT=y
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID is not set
 CONFIG_USB=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_SERIAL=y
 CONFIG_USB_SERIAL_CH341=y
+CONFIG_JZ4770_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_MMC=y
 CONFIG_MMC_JZ4740=y
@@ -87,7 +89,6 @@ CONFIG_DMA_JZ4780=y
 # CONFIG_INGENIC_TIMER is not set
 CONFIG_INGENIC_SYSOST=y
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_JZ4770_PHY=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_AUTOFS_FS=y
@@ -98,7 +99,6 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_NFS_FS=y
-CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_936=y
 CONFIG_NLS_CODEPAGE_950=y
@@ -123,5 +123,3 @@ CONFIG_PANIC_TIMEOUT=10
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="earlycon clk_ignore_unused"
diff --git a/arch/mips/configs/cu1830-neo_defconfig b/arch/mips/configs/cu1830-neo_defconfig
index cc69688962e8..6d7d03197f17 100644
--- a/arch/mips/configs/cu1830-neo_defconfig
+++ b/arch/mips/configs/cu1830-neo_defconfig
@@ -19,12 +19,14 @@ CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="earlycon clk_ignore_unused"
 CONFIG_MACH_INGENIC_SOC=y
 CONFIG_X1830_CU1830_NEO=y
 CONFIG_HIGHMEM=y
 CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
 # CONFIG_SUSPEND is not set
+# CONFIG_SECCOMP is not set
 CONFIG_MODULES=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_COMPACTION is not set
@@ -70,12 +72,12 @@ CONFIG_SENSORS_ADS7828=m
 CONFIG_WATCHDOG=y
 CONFIG_JZ4740_WDT=y
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID is not set
 CONFIG_USB=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_SERIAL=y
 CONFIG_USB_SERIAL_CH341=y
+CONFIG_JZ4770_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_MMC=y
 CONFIG_MMC_JZ4740=y
@@ -90,7 +92,6 @@ CONFIG_DMA_JZ4780=y
 # CONFIG_INGENIC_TIMER is not set
 CONFIG_INGENIC_SYSOST=y
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_JZ4770_PHY=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_AUTOFS_FS=y
@@ -101,7 +102,6 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_NFS_FS=y
-CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_936=y
 CONFIG_NLS_CODEPAGE_950=y
@@ -126,5 +126,3 @@ CONFIG_PANIC_TIMEOUT=10
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="earlycon clk_ignore_unused"
diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
index 714169e411cf..665ae8d63ef3 100644
--- a/arch/mips/configs/generic_defconfig
+++ b/arch/mips/configs/generic_defconfig
@@ -3,7 +3,6 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_MEMCG=y
-CONFIG_MEMCG_SWAP=y
 CONFIG_BLK_CGROUP=y
 CONFIG_CFS_BANDWIDTH=y
 CONFIG_RT_GROUP_SCHED=y
@@ -21,6 +20,8 @@ CONFIG_USERFAULTFD=y
 CONFIG_EMBEDDED=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="earlycon"
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_MIPS_CPS=y
 CONFIG_HIGHMEM=y
@@ -52,7 +53,6 @@ CONFIG_HID_CHICONY=y
 CONFIG_HID_CYPRESS=y
 CONFIG_HID_EZKEY=y
 CONFIG_HID_KENSINGTON=y
-CONFIG_HID_LOGITECH=y
 CONFIG_HID_MICROSOFT=y
 CONFIG_HID_MONTEREY=y
 # CONFIG_MIPS_PLATFORM_DEVICES is not set
@@ -88,5 +88,3 @@ CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="earlycon"
diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index d82f4ebf687f..21c9109c2f63 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -10,9 +10,10 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="console=ttyS0,115200 root=/dev/nfs rw ip=auto"
 CONFIG_MIPS_ALCHEMY=y
 CONFIG_MIPS_GPR=y
-CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
@@ -29,9 +30,6 @@ CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
@@ -49,7 +47,6 @@ CONFIG_NETFILTER_XT_MATCH_LIMIT=m
 CONFIG_NETFILTER_XT_MATCH_MAC=m
 CONFIG_NETFILTER_XT_MATCH_MARK=m
 CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
-CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
 CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
 CONFIG_NETFILTER_XT_MATCH_QUOTA=m
 CONFIG_NETFILTER_XT_MATCH_REALM=m
@@ -151,6 +148,7 @@ CONFIG_BAYCOM_SER_HDX=m
 CONFIG_YAM=m
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
+CONFIG_PCI=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -220,9 +218,6 @@ CONFIG_HDLC_X25=m
 CONFIG_PCI200SYN=m
 CONFIG_WANXL=m
 CONFIG_FARSYNC=m
-CONFIG_DSCC4=m
-CONFIG_DSCC4_PCISYNC=y
-CONFIG_DSCC4_PCI_RST=y
 CONFIG_LAPBETHER=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -242,7 +237,6 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_SSB=m
 CONFIG_SSB_DRIVER_PCICORE=y
 # CONFIG_VGA_ARB is not set
-# CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_USB_HID=m
@@ -290,16 +284,10 @@ CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
-# CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs rw ip=auto"
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 25ecd15bc952..4c53ed33d03f 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -5,6 +5,8 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT=y
 CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
@@ -25,9 +27,10 @@ CONFIG_SCHED_AUTOGROUP=y
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_BPF_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="ieee754=relaxed"
 CONFIG_MACH_LOONGSON64=y
 CONFIG_CPU_HAS_MSA=y
 CONFIG_NUMA=y
@@ -128,7 +131,6 @@ CONFIG_L2TP=m
 CONFIG_BRIDGE=m
 CONFIG_VSOCKETS=m
 CONFIG_VIRTIO_VSOCKETS=m
-CONFIG_BPF_JIT=y
 CONFIG_CFG80211=m
 CONFIG_CFG80211_WEXT=y
 CONFIG_MAC80211=m
@@ -143,7 +145,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_VIRTIO_BLK=y
@@ -197,7 +198,6 @@ CONFIG_VIRTIO_NET=m
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_VENDOR_ATHEROS is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_BROCADE is not set
 # CONFIG_NET_VENDOR_CHELSIO is not set
 # CONFIG_NET_VENDOR_CIRRUS is not set
 # CONFIG_NET_VENDOR_CISCO is not set
@@ -218,6 +218,7 @@ CONFIG_IXGBE=y
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
 # CONFIG_NET_VENDOR_QLOGIC is not set
+# CONFIG_NET_VENDOR_BROCADE is not set
 # CONFIG_NET_VENDOR_RDC is not set
 CONFIG_8139CP=m
 CONFIG_8139TOO=m
@@ -268,7 +269,6 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
-CONFIG_RAW_DRIVER=m
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_PIIX4=y
 CONFIG_GPIO_LOONGSON=y
@@ -404,5 +404,3 @@ CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_FUNCTION_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="ieee754=relaxed"
diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index 8c56b862fd9c..798bc3c68080 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <uapi/asm/setup.h>
 
+#ifndef __ASSEMBLY__
 extern void prom_putchar(char);
 extern void setup_early_printk(void);
 
@@ -27,5 +28,6 @@ extern unsigned long ebase;
 extern unsigned int hwrena;
 extern void per_cpu_trap_init(bool);
 extern void cpu_cache_init(void);
+#endif
 
 #endif /* __SETUP_H */
diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index 56b51de2dc51..e73bff474a08 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -23,6 +23,7 @@
 #include <linux/start_kernel.h>
 #include <linux/string.h>
 #include <linux/printk.h>
+#include <linux/cmdline.h>
 
 #define RELOCATED(x) ((void *)((long)x + offset))
 
@@ -247,16 +248,26 @@ static inline __init bool kaslr_disabled(void)
 	char *str;
 
 #if defined(CONFIG_CMDLINE_BOOL)
-	const char *builtin_cmdline = CONFIG_CMDLINE;
+	char *builtin_cmdline = CMDLINE_PREPEND;
 
 	str = strstr(builtin_cmdline, "nokaslr");
 	if (str == builtin_cmdline ||
 	    (str > builtin_cmdline && *(str - 1) == ' '))
 		return true;
 #endif
-	str = strstr(arcs_cmdline, "nokaslr");
-	if (str == arcs_cmdline || (str > arcs_cmdline && *(str - 1) == ' '))
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+		str = strstr(arcs_cmdline, "nokaslr");
+		if (str == arcs_cmdline || (str > arcs_cmdline && *(str - 1) == ' '))
+			return true;
+	}
+
+#if defined(CONFIG_CMDLINE_BOOL)
+	builtin_cmdline = CMDLINE_APPEND;
+	str = strstr(builtin_cmdline, "nokaslr");
+	if (str == builtin_cmdline ||
+	    (str > builtin_cmdline && *(str - 1) == ' '))
 		return true;
+#endif
 
 	return false;
 }
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2ca156a5b231..f43c599068be 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -23,6 +23,7 @@
 #include <linux/debugfs.h>
 #include <linux/kexec.h>
 #include <linux/sizes.h>
+#include <linux/cmdline.h>
 #include <linux/device.h>
 #include <linux/dma-map-ops.h>
 #include <linux/decompress/generic.h>
@@ -67,12 +68,6 @@ EXPORT_SYMBOL(mips_machtype);
 static char __initdata command_line[COMMAND_LINE_SIZE];
 char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
 
-#ifdef CONFIG_CMDLINE_BOOL
-static const char builtin_cmdline[] __initconst = CONFIG_CMDLINE;
-#else
-static const char builtin_cmdline[] __initconst = "";
-#endif
-
 /*
  * mips_io_port_base is the begin of the address space to which x86 style
  * I/O ports are mapped.
@@ -557,27 +552,7 @@ static void __init bootcmdline_init(void)
 {
 	bool dt_bootargs = false;
 
-	/*
-	 * If CMDLINE_OVERRIDE is enabled then initializing the command line is
-	 * trivial - we simply use the built-in command line unconditionally &
-	 * unmodified.
-	 */
-	if (IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
-		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-		return;
-	}
-
-	/*
-	 * If the user specified a built-in command line &
-	 * MIPS_CMDLINE_BUILTIN_EXTEND, then the built-in command line is
-	 * prepended to arguments from the bootloader or DT so we'll copy them
-	 * to the start of boot_command_line here. Otherwise, empty
-	 * boot_command_line to undo anything early_init_dt_scan_chosen() did.
-	 */
-	if (IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND))
-		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	else
-		boot_command_line[0] = 0;
+	boot_command_line[0] = 0;
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
 	/*
@@ -600,12 +575,9 @@ static void __init bootcmdline_init(void)
 		bootcmdline_append(arcs_cmdline, COMMAND_LINE_SIZE);
 
 	/*
-	 * If the user specified a built-in command line & we didn't already
-	 * prepend it, we append it to boot_command_line here.
+	 * Use the generic system for builtin prepend and append.
 	 */
-	if (IS_ENABLED(CONFIG_CMDLINE_BOOL) &&
-	    !IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND))
-		bootcmdline_append(builtin_cmdline, COMMAND_LINE_SIZE);
+	cmdline_add_builtin(boot_command_line);
 }
 
 /*
diff --git a/arch/mips/pic32/pic32mzda/early_console.c b/arch/mips/pic32/pic32mzda/early_console.c
index 25372e62783b..213e318d7ad4 100644
--- a/arch/mips/pic32/pic32mzda/early_console.c
+++ b/arch/mips/pic32/pic32mzda/early_console.c
@@ -76,7 +76,7 @@ static char * __init pic32_getcmdline(void)
 	 * command line setup if using CONFIG_CMDLINE_BOOL.
 	 */
 #ifdef CONFIG_CMDLINE_OVERRIDE
-	return CONFIG_CMDLINE;
+	return CMDLINE_STATIC_PREPEND " " CMDLINE_STATIC_APPEND;
 #else
 	return fw_getcmdline();
 #endif
diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
index d9c8c4e46aff..e4eac5e1f95f 100644
--- a/arch/mips/pic32/pic32mzda/init.c
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -9,6 +9,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/sdhci-pic32.h>
+#include <linux/cmdline.h>
 
 #include <asm/fw/fw.h>
 #include <asm/mips-boards/generic.h>
@@ -41,7 +42,7 @@ void __init plat_mem_setup(void)
 	pr_info(" boot_command_line: %s\n", boot_command_line);
 	pr_info(" arcs_cmdline     : %s\n", arcs_cmdline);
 #ifdef CONFIG_CMDLINE_BOOL
-	pr_info(" builtin_cmdline  : %s\n", CONFIG_CMDLINE);
+	pr_info(" builtin_cmdline  : %s\n", CMDLINE_STATIC_PREPEND " " CMDLINE_STATIC_APPEND);
 #endif
 	if (dtb != __dtb_start)
 		strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-- 
2.25.1

