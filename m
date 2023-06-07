Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363D726497
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbjFGP1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbjFGP1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:27:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4183213B;
        Wed,  7 Jun 2023 08:26:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 69C1621A0A;
        Wed,  7 Jun 2023 15:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686151565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3CgSzwsEXLc90cJanqFihmE6LXoKCUHuh/h90XQnTE=;
        b=kzML994ZgBG3ossOC8+9yjHO8RHOyz8hbZzpcg9ma+UdcHUczrr/x1OIQ42iAngt9IVRJ1
        kxpe7IwJ6HQ8T0pxLF4X36w0nvN7fkliq0gu+Fs3gxp7s7VvfXSPLdZylbnotNBQqm2O5b
        ejAwedrW9fGl0BJw30aItF91kMzis20=
Received: from alley.suse.cz (unknown [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id D68332C141;
        Wed,  7 Jun 2023 15:26:04 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 6/7] watchdog/sparc64: Define HARDLOCKUP_DETECTOR_SPARC64
Date:   Wed,  7 Jun 2023 17:24:31 +0200
Message-Id: <20230607152432.5435-7-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230607152432.5435-1-pmladek@suse.com>
References: <20230607152432.5435-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HAVE_ prefix means that the code could be enabled. Add another
variable for HAVE_HARDLOCKUP_DETECTOR_SPARC64 without this prefix.
It will be set when it should be built. It will make it compatible
with the other hardlockup detectors.

Before, it is far from obvious that the SPARC64 variant is actually used:

$> make ARCH=sparc64 defconfig
$> grep HARDLOCKUP_DETECTOR .config
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_SPARC64=y

After, it is more clear:

$> make ARCH=sparc64 defconfig
$> grep HARDLOCKUP_DETECTOR .config
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_SPARC64=y
CONFIG_HARDLOCKUP_DETECTOR_SPARC64=y

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/sparc/Kconfig.debug | 10 +++++++++-
 include/linux/nmi.h      |  4 ++--
 kernel/watchdog.c        |  2 +-
 lib/Kconfig.debug        |  2 +-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/Kconfig.debug b/arch/sparc/Kconfig.debug
index b6695303b8d4..0bb95b0aacf4 100644
--- a/arch/sparc/Kconfig.debug
+++ b/arch/sparc/Kconfig.debug
@@ -16,8 +16,9 @@ config FRAME_POINTER
 	default y
 
 config HAVE_HARDLOCKUP_DETECTOR_SPARC64
-	depends on HAVE_NMI
 	bool
+	depends on HAVE_NMI
+	select HARDLOCKUP_DETECTOR_SPARC64
 	help
 	  Sparc64 provides its own hardlockup detector implementation instead
 	  of the generic perf one.
@@ -26,3 +27,10 @@ config HAVE_HARDLOCKUP_DETECTOR_SPARC64
 	  used by generic hardlockup detectors. Instead it is enabled/disabled
 	  by the top-level watchdog interface that is common for both softlockup
 	  and hardlockup detectors.
+
+config HARDLOCKUP_DETECTOR_SPARC64
+	bool
+	depends on HAVE_HARDLOCKUP_DETECTOR_SPARC64
+
+	help
+	  The custom hardlockup detector is always built when possible.
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 7ee6c35d1f05..515d6724f469 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -9,7 +9,7 @@
 #include <asm/irq.h>
 
 /* Arch specific watchdogs might need to share extra watchdog-related APIs. */
-#if defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_SPARC64)
+#if defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
 #include <asm/nmi.h>
 #endif
 
@@ -92,7 +92,7 @@ static inline void hardlockup_detector_disable(void) {}
 #endif
 
 /* Sparc64 has special implemetantion that is always enabled. */
-#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_SPARC64)
+#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
 void arch_touch_nmi_watchdog(void);
 #else
 static inline void arch_touch_nmi_watchdog(void) { }
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index babd2f3c8b72..a2154e753cb4 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -29,7 +29,7 @@
 
 static DEFINE_MUTEX(watchdog_mutex);
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_SPARC64)
+#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HARDLOCKUP_DETECTOR_SPARC64)
 # define WATCHDOG_HARDLOCKUP_DEFAULT	1
 #else
 # define WATCHDOG_HARDLOCKUP_DEFAULT	0
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d8d8ce7c2d7..116904e65d9f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1052,7 +1052,7 @@ config HAVE_HARDLOCKUP_DETECTOR_BUDDY
 #
 config HARDLOCKUP_DETECTOR
 	bool "Detect Hard Lockups"
-	depends on DEBUG_KERNEL && !S390 && !HAVE_HARDLOCKUP_DETECTOR_SPARC64
+	depends on DEBUG_KERNEL && !S390 && !HARDLOCKUP_DETECTOR_SPARC64
 	depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
 	imply HARDLOCKUP_DETECTOR_PERF
 	imply HARDLOCKUP_DETECTOR_BUDDY
-- 
2.35.3

