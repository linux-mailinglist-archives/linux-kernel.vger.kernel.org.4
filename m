Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6C66BB5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjCOONJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjCOOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:12:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C10AA2264;
        Wed, 15 Mar 2023 07:12:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9910D219B5;
        Wed, 15 Mar 2023 14:12:05 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7EE322C141;
        Wed, 15 Mar 2023 14:12:05 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: sibyte: Remove Sibyte CARMEL and CRHINE board support
Date:   Wed, 15 Mar 2023 15:12:02 +0100
Message-Id: <20230315141202.107168-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like these boards were nether in active use, so let's remove them.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/Kconfig                     | 18 -----------
 arch/mips/include/asm/sibyte/board.h  |  6 +---
 arch/mips/include/asm/sibyte/carmel.h | 45 ---------------------------
 arch/mips/include/asm/sibyte/swarm.h  |  5 ---
 arch/mips/sibyte/Kconfig              |  9 ------
 arch/mips/sibyte/Makefile             |  4 ---
 arch/mips/sibyte/Platform             |  4 ---
 arch/mips/sibyte/swarm/setup.c        |  6 ----
 8 files changed, 1 insertion(+), 96 deletions(-)
 delete mode 100644 arch/mips/include/asm/sibyte/carmel.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e2f3ca73f40d..277daaab1b0d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -795,24 +795,6 @@ config SGI_IP32
 	help
 	  If you want this kernel to run on SGI O2 workstation, say Y here.
 
-config SIBYTE_CRHINE
-	bool "Sibyte BCM91120C-CRhine"
-	select BOOT_ELF32
-	select SIBYTE_BCM1120
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_SB1
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config SIBYTE_CARMEL
-	bool "Sibyte BCM91120x-Carmel"
-	select BOOT_ELF32
-	select SIBYTE_BCM1120
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_SB1
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
 config SIBYTE_CRHONE
 	bool "Sibyte BCM91125C-CRhone"
 	select BOOT_ELF32
diff --git a/arch/mips/include/asm/sibyte/board.h b/arch/mips/include/asm/sibyte/board.h
index 20fe2f16c97e..03463faa4244 100644
--- a/arch/mips/include/asm/sibyte/board.h
+++ b/arch/mips/include/asm/sibyte/board.h
@@ -7,7 +7,7 @@
 #define _SIBYTE_BOARD_H
 
 #if defined(CONFIG_SIBYTE_SWARM) || defined(CONFIG_SIBYTE_CRHONE) || \
-    defined(CONFIG_SIBYTE_CRHINE) || defined(CONFIG_SIBYTE_LITTLESUR)
+    defined(CONFIG_SIBYTE_LITTLESUR)
 #include <asm/sibyte/swarm.h>
 #endif
 
@@ -15,10 +15,6 @@
 #include <asm/sibyte/sentosa.h>
 #endif
 
-#ifdef CONFIG_SIBYTE_CARMEL
-#include <asm/sibyte/carmel.h>
-#endif
-
 #ifdef CONFIG_SIBYTE_BIGSUR
 #include <asm/sibyte/bigsur.h>
 #endif
diff --git a/arch/mips/include/asm/sibyte/carmel.h b/arch/mips/include/asm/sibyte/carmel.h
deleted file mode 100644
index c6730d7a6392..000000000000
--- a/arch/mips/include/asm/sibyte/carmel.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2002 Broadcom Corporation
- */
-#ifndef __ASM_SIBYTE_CARMEL_H
-#define __ASM_SIBYTE_CARMEL_H
-
-#include <asm/sibyte/sb1250.h>
-#include <asm/sibyte/sb1250_int.h>
-
-#define SIBYTE_BOARD_NAME "Carmel"
-
-#define GPIO_PHY_INTERRUPT	2
-#define GPIO_NONMASKABLE_INT	3
-#define GPIO_CF_INSERTED	6
-#define GPIO_MONTEREY_RESET	7
-#define GPIO_QUADUART_INT	8
-#define GPIO_CF_INT		9
-#define GPIO_FPGA_CCLK		10
-#define GPIO_FPGA_DOUT		11
-#define GPIO_FPGA_DIN		12
-#define GPIO_FPGA_PGM		13
-#define GPIO_FPGA_DONE		14
-#define GPIO_FPGA_INIT		15
-
-#define LEDS_CS			2
-#define LEDS_PHYS		0x100C0000
-#define MLEDS_CS		3
-#define MLEDS_PHYS		0x100A0000
-#define UART_CS			4
-#define UART_PHYS		0x100D0000
-#define ARAVALI_CS		5
-#define ARAVALI_PHYS		0x11000000
-#define IDE_CS			6
-#define IDE_PHYS		0x100B0000
-#define ARAVALI2_CS		7
-#define ARAVALI2_PHYS		0x100E0000
-
-#if defined(CONFIG_SIBYTE_CARMEL)
-#define K_GPIO_GB_IDE	9
-#define K_INT_GB_IDE	(K_INT_GPIO_0 + K_GPIO_GB_IDE)
-#endif
-
-
-#endif /* __ASM_SIBYTE_CARMEL_H */
diff --git a/arch/mips/include/asm/sibyte/swarm.h b/arch/mips/include/asm/sibyte/swarm.h
index 947122f487ed..49ea7a645c15 100644
--- a/arch/mips/include/asm/sibyte/swarm.h
+++ b/arch/mips/include/asm/sibyte/swarm.h
@@ -24,11 +24,6 @@
 #define SIBYTE_HAVE_PCMCIA 0
 #define SIBYTE_HAVE_IDE	   0
 #endif
-#ifdef CONFIG_SIBYTE_CRHINE
-#define SIBYTE_BOARD_NAME "BCM91120C (CRhine)"
-#define SIBYTE_HAVE_PCMCIA 0
-#define SIBYTE_HAVE_IDE	   0
-#endif
 
 /* Generic bus chip selects */
 #define LEDS_CS		3
diff --git a/arch/mips/sibyte/Kconfig b/arch/mips/sibyte/Kconfig
index c437bc02dd08..c4596d49edf1 100644
--- a/arch/mips/sibyte/Kconfig
+++ b/arch/mips/sibyte/Kconfig
@@ -10,15 +10,6 @@ config SIBYTE_SB1250
 	select SIBYTE_SB1xxx_SOC
 	select SYS_SUPPORTS_SMP
 
-config SIBYTE_BCM1120
-	bool
-	select CEVT_SB1250
-	select CSRC_SB1250
-	select IRQ_MIPS_CPU
-	select SIBYTE_BCM112X
-	select SIBYTE_HAS_ZBUS_PROFILING
-	select SIBYTE_SB1xxx_SOC
-
 config SIBYTE_BCM1125
 	bool
 	select CEVT_SB1250
diff --git a/arch/mips/sibyte/Makefile b/arch/mips/sibyte/Makefile
index ca0d57824d56..47078353fe8a 100644
--- a/arch/mips/sibyte/Makefile
+++ b/arch/mips/sibyte/Makefile
@@ -10,15 +10,11 @@ obj-$(CONFIG_SIBYTE_BCM1x80)	+= bcm1480/
 obj-$(CONFIG_SIBYTE_BCM1x80)	+= common/
 
 #
-# Sibyte BCM91120x (Carmel) board
-# Sibyte BCM91120C (CRhine) board
 # Sibyte BCM91125C (CRhone) board
 # Sibyte BCM91125E (Rhone) board
 # Sibyte SWARM board
 # Sibyte BCM91x80 (BigSur) board
 #
-obj-$(CONFIG_SIBYTE_CARMEL)	+= swarm/
-obj-$(CONFIG_SIBYTE_CRHINE)	+= swarm/
 obj-$(CONFIG_SIBYTE_CRHONE)	+= swarm/
 obj-$(CONFIG_SIBYTE_RHONE)	+= swarm/
 obj-$(CONFIG_SIBYTE_SENTOSA)	+= swarm/
diff --git a/arch/mips/sibyte/Platform b/arch/mips/sibyte/Platform
index 304b4d16dfbf..937108e41f13 100644
--- a/arch/mips/sibyte/Platform
+++ b/arch/mips/sibyte/Platform
@@ -18,16 +18,12 @@ cflags-$(CONFIG_SIBYTE_BCM1x80) +=					\
 		-DSIBYTE_HDR_FEATURES=SIBYTE_HDR_FMASK_1480_ALL
 
 #
-# Sibyte BCM91120x (Carmel) board
-# Sibyte BCM91120C (CRhine) board
 # Sibyte BCM91125C (CRhone) board
 # Sibyte BCM91125E (Rhone) board
 # Sibyte BCM91250A (SWARM) board
 # Sibyte BCM91250C2 (LittleSur) board
 # Sibyte BCM91x80 (BigSur) board
 #
-load-$(CONFIG_SIBYTE_CARMEL)	:= 0xffffffff80100000
-load-$(CONFIG_SIBYTE_CRHINE)	:= 0xffffffff80100000
 load-$(CONFIG_SIBYTE_CRHONE)	:= 0xffffffff80100000
 load-$(CONFIG_SIBYTE_RHONE)	:= 0xffffffff80100000
 load-$(CONFIG_SIBYTE_SENTOSA)	:= 0xffffffff80100000
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 9e7a1e305f61..76683993cdd3 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -146,12 +146,6 @@ void __init plat_mem_setup(void)
 
 #ifdef LEDS_PHYS
 
-#ifdef CONFIG_SIBYTE_CARMEL
-/* XXXKW need to detect Monterey/LittleSur/etc */
-#undef LEDS_PHYS
-#define LEDS_PHYS MLEDS_PHYS
-#endif
-
 void setleds(char *str)
 {
 	void *reg;
-- 
2.35.3

