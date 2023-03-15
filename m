Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE176BB545
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjCONzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjCONzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:55:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5DA3BD9A;
        Wed, 15 Mar 2023 06:55:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9478E1FD6C;
        Wed, 15 Mar 2023 13:55:11 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7A42F2C141;
        Wed, 15 Mar 2023 13:55:11 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: sibyte: Remove unused config option SIBYTE_BCM1x55
Date:   Wed, 15 Mar 2023 14:55:09 +0100
Message-Id: <20230315135509.102542-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_FAIL,SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIBYTE_BCM1x55 is not selected anywhere, so let's get rid of it.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/Kbuild.platforms            |  1 -
 arch/mips/sibyte/Kconfig              | 13 +------------
 arch/mips/sibyte/Makefile             |  2 --
 arch/mips/sibyte/Platform             |  4 ----
 arch/mips/sibyte/common/bus_watcher.c |  4 ++--
 arch/mips/sibyte/common/cfe.c         |  2 +-
 arch/mips/sibyte/common/sb_tbprof.c   | 10 +++++-----
 arch/mips/sibyte/swarm/setup.c        |  6 +++---
 8 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 5d04438ee12e..caad195ba5c1 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -29,7 +29,6 @@ platform-$(CONFIG_SGI_IP30)		+= sgi-ip30/
 platform-$(CONFIG_SGI_IP32)		+= sgi-ip32/
 platform-$(CONFIG_SIBYTE_BCM112X)	+= sibyte/
 platform-$(CONFIG_SIBYTE_SB1250)	+= sibyte/
-platform-$(CONFIG_SIBYTE_BCM1x55)	+= sibyte/
 platform-$(CONFIG_SIBYTE_BCM1x80)	+= sibyte/
 platform-$(CONFIG_SNI_RM)		+= sni/
 platform-$(CONFIG_MACH_TX49XX)		+= txx9/
diff --git a/arch/mips/sibyte/Kconfig b/arch/mips/sibyte/Kconfig
index 470d46183677..c437bc02dd08 100644
--- a/arch/mips/sibyte/Kconfig
+++ b/arch/mips/sibyte/Kconfig
@@ -58,16 +58,6 @@ config SIBYTE_BCM1x80
 	select SIBYTE_SB1xxx_SOC
 	select SYS_SUPPORTS_SMP
 
-config SIBYTE_BCM1x55
-	bool
-	select CEVT_BCM1480
-	select CSRC_BCM1480
-	select HAVE_PCI
-	select IRQ_MIPS_CPU
-	select SIBYTE_SB1xxx_SOC
-	select SIBYTE_HAS_ZBUS_PROFILING
-	select SYS_SUPPORTS_SMP
-
 config SIBYTE_SB1xxx_SOC
 	bool
 	select IRQ_MIPS_CPU
@@ -143,8 +133,7 @@ config SIBYTE_CFE_CONSOLE
 config SIBYTE_BUS_WATCHER
 	bool "Support for Bus Watcher statistics"
 	depends on SIBYTE_SB1xxx_SOC && \
-		(SIBYTE_BCM112X || SIBYTE_SB1250 || \
-		 SIBYTE_BCM1x55 || SIBYTE_BCM1x80)
+		(SIBYTE_BCM112X || SIBYTE_SB1250 || SIBYTE_BCM1x80)
 	help
 	  Handle and keep statistics on the bus error interrupts (COR_ECC,
 	  BAD_ECC, IO_BUS).
diff --git a/arch/mips/sibyte/Makefile b/arch/mips/sibyte/Makefile
index d015c4d79c3e..ca0d57824d56 100644
--- a/arch/mips/sibyte/Makefile
+++ b/arch/mips/sibyte/Makefile
@@ -6,8 +6,6 @@ obj-$(CONFIG_SIBYTE_BCM112X)	+= sb1250/
 obj-$(CONFIG_SIBYTE_BCM112X)	+= common/
 obj-$(CONFIG_SIBYTE_SB1250)	+= sb1250/
 obj-$(CONFIG_SIBYTE_SB1250)	+= common/
-obj-$(CONFIG_SIBYTE_BCM1x55)	+= bcm1480/
-obj-$(CONFIG_SIBYTE_BCM1x55)	+= common/
 obj-$(CONFIG_SIBYTE_BCM1x80)	+= bcm1480/
 obj-$(CONFIG_SIBYTE_BCM1x80)	+= common/
 
diff --git a/arch/mips/sibyte/Platform b/arch/mips/sibyte/Platform
index 65b2225b76b2..304b4d16dfbf 100644
--- a/arch/mips/sibyte/Platform
+++ b/arch/mips/sibyte/Platform
@@ -13,10 +13,6 @@ cflags-$(CONFIG_SIBYTE_SB1250)	+=					\
 		-I$(srctree)/arch/mips/include/asm/mach-sibyte		\
 		-DSIBYTE_HDR_FEATURES=SIBYTE_HDR_FMASK_1250_112x_ALL
 
-cflags-$(CONFIG_SIBYTE_BCM1x55) +=					\
-		-I$(srctree)/arch/mips/include/asm/mach-sibyte		\
-		-DSIBYTE_HDR_FEATURES=SIBYTE_HDR_FMASK_1480_ALL
-
 cflags-$(CONFIG_SIBYTE_BCM1x80) +=					\
 		-I$(srctree)/arch/mips/include/asm/mach-sibyte		\
 		-DSIBYTE_HDR_FEATURES=SIBYTE_HDR_FMASK_1480_ALL
diff --git a/arch/mips/sibyte/common/bus_watcher.c b/arch/mips/sibyte/common/bus_watcher.c
index d43291473f76..a296d2c51841 100644
--- a/arch/mips/sibyte/common/bus_watcher.c
+++ b/arch/mips/sibyte/common/bus_watcher.c
@@ -24,7 +24,7 @@
 #include <asm/sibyte/sb1250_regs.h>
 #include <asm/sibyte/sb1250_int.h>
 #include <asm/sibyte/sb1250_scd.h>
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#ifdef CONFIG_SIBYTE_BCM1x80
 #include <asm/sibyte/bcm1480_regs.h>
 #endif
 
@@ -71,7 +71,7 @@ void check_bus_watcher(void)
 #if defined(CONFIG_SIBYTE_BCM112X) || defined(CONFIG_SIBYTE_SB1250)
 	/* Use non-destructive register */
 	status = csr_in32(IOADDR(A_SCD_BUS_ERR_STATUS_DEBUG));
-#elif defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#elif defined(CONFIG_SIBYTE_BCM1x80)
 	/* Use non-destructive register */
 	/* Same as 1250 except BUS_ERR_STATUS_DEBUG is in a different place. */
 	status = csr_in32(IOADDR(A_BCM1480_BUS_ERR_STATUS_DEBUG));
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index 2503f60271e8..2cb90dbbe843 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -295,7 +295,7 @@ void __init prom_init(void)
 #if defined(CONFIG_SIBYTE_BCM112X) || defined(CONFIG_SIBYTE_SB1250)
 	register_smp_ops(&sb_smp_ops);
 #endif
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#ifdef CONFIG_SIBYTE_BCM1x80
 	register_smp_ops(&bcm1480_smp_ops);
 #endif
 }
diff --git a/arch/mips/sibyte/common/sb_tbprof.c b/arch/mips/sibyte/common/sb_tbprof.c
index bc47681e825a..004a08469a39 100644
--- a/arch/mips/sibyte/common/sb_tbprof.c
+++ b/arch/mips/sibyte/common/sb_tbprof.c
@@ -23,7 +23,7 @@
 #include <asm/io.h>
 #include <asm/sibyte/sb1250.h>
 
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#ifdef CONFIG_SIBYTE_BCM1x80
 #include <asm/sibyte/bcm1480_regs.h>
 #include <asm/sibyte/bcm1480_scd.h>
 #include <asm/sibyte/bcm1480_int.h>
@@ -35,7 +35,7 @@
 #error invalid SiByte UART configuration
 #endif
 
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#ifdef CONFIG_SIBYTE_BCM1x80
 #undef K_INT_TRACE_FREEZE
 #define K_INT_TRACE_FREEZE K_BCM1480_INT_TRACE_FREEZE
 #undef K_INT_PERF_CNT
@@ -157,7 +157,7 @@ static void arm_tb(void)
 	 * a previous interrupt request.  This means that bus profiling
 	 * requires ALL of the SCD perf counters.
 	 */
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#ifdef CONFIG_SIBYTE_BCM1x80
 	__raw_writeq((scdperfcnt & ~M_SPC_CFG_SRC1) |
 						/* keep counters 0,2,3,4,5,6,7 as is */
 		     V_SPC_CFG_SRC1(1),		/* counter 1 counts cycles */
@@ -290,7 +290,7 @@ static int sbprof_zbprof_start(struct file *filp)
 	 *  pass them through.	I am exploiting my knowledge that
 	 *  cp0_status masks out IP[5]. krw
 	 */
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#ifdef CONFIG_SIBYTE_BCM1x80
 	__raw_writeq(K_BCM1480_INT_MAP_I3,
 		     IOADDR(A_BCM1480_IMR_REGISTER(0, R_BCM1480_IMR_INTERRUPT_MAP_BASE_L) +
 			    ((K_BCM1480_INT_PERF_CNT & 0x3f) << 3)));
@@ -343,7 +343,7 @@ static int sbprof_zbprof_start(struct file *filp)
 	__raw_writeq(0, IOADDR(A_SCD_TRACE_SEQUENCE_7));
 
 	/* Now indicate the PERF_CNT interrupt as a trace-relevant interrupt */
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#ifdef CONFIG_SIBYTE_BCM1x80
 	__raw_writeq(1ULL << (K_BCM1480_INT_PERF_CNT & 0x3f),
 		     IOADDR(A_BCM1480_IMR_REGISTER(0, R_BCM1480_IMR_INTERRUPT_TRACE_L)));
 #else
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 72a31eeeebba..9e7a1e305f61 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -24,7 +24,7 @@
 #include <asm/time.h>
 #include <asm/traps.h>
 #include <asm/sibyte/sb1250.h>
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#ifdef CONFIG_SIBYTE_BCM1x80
 #include <asm/sibyte/bcm1480_regs.h>
 #elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 #include <asm/sibyte/sb1250_regs.h>
@@ -34,7 +34,7 @@
 #include <asm/sibyte/sb1250_genbus.h>
 #include <asm/sibyte/board.h>
 
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#ifdef CONFIG_SIBYTE_BCM1x80
 extern void bcm1480_setup(void);
 #elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 extern void sb1250_setup(void);
@@ -114,7 +114,7 @@ int update_persistent_clock64(struct timespec64 now)
 
 void __init plat_mem_setup(void)
 {
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#ifdef CONFIG_SIBYTE_BCM1x80
 	bcm1480_setup();
 #elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 	sb1250_setup();
-- 
2.35.3

