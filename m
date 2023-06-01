Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0013471F3C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjFAUXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjFAUX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:23:28 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEF6134;
        Thu,  1 Jun 2023 13:22:57 -0700 (PDT)
Received: from [192.168.1.103] (178.176.72.8) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 1 Jun 2023
 23:22:18 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v6] sh: avoid using IRQ0 on SH3/4
To:     Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        <linux-sh@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        <linux-kernel@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru>
Date:   Thu, 1 Jun 2023 23:22:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.72.8]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 06/01/2023 19:59:41
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 177803 [Jun 01 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 515 515 1b17fc6ab778ab3730d780f30d802773a7d822ac
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_no_received}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: 178.176.72.8:7.4.1,7.7.3,7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.8
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/01/2023 20:06:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/1/2023 4:24:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
return -EINVAL instead.  However, the kernel code supporting SH3/4 based
SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
IRQ #s from 16 instead.

The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
indeed are using IRQ0 for the SMSC911x compatible Ethernet chip...

Fixes: ce753ad1549c ("platform: finally disallow IRQ0 in platform_get_irq() and its ilk")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

---
The patch is against Linus Torvalds' 'linux.git' repo.

Changes in version 6:
- fixed up inconsistencies and did some rewording in the patch description.

Changes in version 5:
- updated the patch description and the "Fixes:" tag as the patch disallowing
  the use of IRQ0 was merged meanwhile.

Changes in version 4:
- fixed up the off-chip base IRQ #s for the Dreamcast/Highlander/R2D/SE7724
  boards.

Changes in version 3:
- added an appropriate Fixes: tag and added a passage about it to the patch
  description;
- added actual cases of the boards using IRQ0 to the patch description;
- added Geert Uytterhoeven's and John Paul Adrian Glaubitz's tags;
- updated the link to point to the version 2 of the patch.

Changes in version 2:
- changed cmp/ge to cmp/hs in the assembly code.

 arch/sh/include/mach-common/mach/highlander.h |    2 +-
 arch/sh/include/mach-common/mach/r2d.h        |    2 +-
 arch/sh/include/mach-dreamcast/mach/sysasic.h |    2 +-
 arch/sh/include/mach-se/mach/se7724.h         |    2 +-
 arch/sh/kernel/cpu/sh3/entry.S                |    4 ++--
 include/linux/sh_intc.h                       |    6 +++---
 6 files changed, 9 insertions(+), 9 deletions(-)

Index: linux/arch/sh/include/mach-common/mach/highlander.h
===================================================================
--- linux.orig/arch/sh/include/mach-common/mach/highlander.h
+++ linux/arch/sh/include/mach-common/mach/highlander.h
@@ -176,7 +176,7 @@
 #define IVDR_CK_ON	4		/* iVDR Clock ON */
 #endif
 
-#define HL_FPGA_IRQ_BASE	200
+#define HL_FPGA_IRQ_BASE	(200 + 16)
 #define HL_NR_IRL		15
 
 #define IRQ_AX88796		(HL_FPGA_IRQ_BASE + 0)
Index: linux/arch/sh/include/mach-common/mach/r2d.h
===================================================================
--- linux.orig/arch/sh/include/mach-common/mach/r2d.h
+++ linux/arch/sh/include/mach-common/mach/r2d.h
@@ -47,7 +47,7 @@
 
 #define IRLCNTR1	(PA_BCR + 0)	/* Interrupt Control Register1 */
 
-#define R2D_FPGA_IRQ_BASE	100
+#define R2D_FPGA_IRQ_BASE	(100 + 16)
 
 #define IRQ_VOYAGER		(R2D_FPGA_IRQ_BASE + 0)
 #define IRQ_EXT			(R2D_FPGA_IRQ_BASE + 1)
Index: linux/arch/sh/include/mach-dreamcast/mach/sysasic.h
===================================================================
--- linux.orig/arch/sh/include/mach-dreamcast/mach/sysasic.h
+++ linux/arch/sh/include/mach-dreamcast/mach/sysasic.h
@@ -22,7 +22,7 @@
    takes.
 */
 
-#define HW_EVENT_IRQ_BASE  48
+#define HW_EVENT_IRQ_BASE  (48 + 16)
 
 /* IRQ 13 */
 #define HW_EVENT_VSYNC     (HW_EVENT_IRQ_BASE +  5) /* VSync */
Index: linux/arch/sh/include/mach-se/mach/se7724.h
===================================================================
--- linux.orig/arch/sh/include/mach-se/mach/se7724.h
+++ linux/arch/sh/include/mach-se/mach/se7724.h
@@ -37,7 +37,7 @@
 #define IRQ2_IRQ        evt2irq(0x640)
 
 /* Bits in IRQ012 registers */
-#define SE7724_FPGA_IRQ_BASE	220
+#define SE7724_FPGA_IRQ_BASE	(220 + 16)
 
 /* IRQ0 */
 #define IRQ0_BASE	SE7724_FPGA_IRQ_BASE
Index: linux/arch/sh/kernel/cpu/sh3/entry.S
===================================================================
--- linux.orig/arch/sh/kernel/cpu/sh3/entry.S
+++ linux/arch/sh/kernel/cpu/sh3/entry.S
@@ -470,9 +470,9 @@ ENTRY(handle_interrupt)
 	mov	r4, r0		! save vector->jmp table offset for later
 
 	shlr2	r4		! vector to IRQ# conversion
-	add	#-0x10, r4
 
-	cmp/pz	r4		! is it a valid IRQ?
+	mov	#0x10, r5
+	cmp/hs	r5, r4		! is it a valid IRQ?
 	bt	10f
 
 	/*
Index: linux/include/linux/sh_intc.h
===================================================================
--- linux.orig/include/linux/sh_intc.h
+++ linux/include/linux/sh_intc.h
@@ -13,9 +13,9 @@
 /*
  * Convert back and forth between INTEVT and IRQ values.
  */
-#ifdef CONFIG_CPU_HAS_INTEVT
-#define evt2irq(evt)		(((evt) >> 5) - 16)
-#define irq2evt(irq)		(((irq) + 16) << 5)
+#ifdef CONFIG_CPU_HAS_INTEVT	/* Avoid IRQ0 (invalid for platform devices) */
+#define evt2irq(evt)		((evt) >> 5)
+#define irq2evt(irq)		((irq) << 5)
 #else
 #define evt2irq(evt)		(evt)
 #define irq2evt(irq)		(irq)
