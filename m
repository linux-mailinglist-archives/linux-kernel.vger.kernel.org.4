Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609D172647E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbjFGP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbjFGP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:26:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BD52729;
        Wed,  7 Jun 2023 08:25:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1201821A0F;
        Wed,  7 Jun 2023 15:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686151544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rVxOeo4RLBDL5GE2Lf9QZE9fzvk64IDwLTus852i6o=;
        b=bMFhXmKFPG/jj84oi9qQQtQ4h5fHR3MVqZfcRZwxLBGRLcQ6l6RT8Ryrjoii+w69lQLhMB
        Hd21yM/yX538nlKd/anmDhThlhU/jaBUC56LHhqbpvEn+ooHtP2QJHrMoPZu18+fE4cPRx
        Qljz7ZuIpPtLtzEgTLcqdOnd2X2d/Sk=
Received: from alley.suse.cz (unknown [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id 7E49B2C141;
        Wed,  7 Jun 2023 15:25:43 +0000 (UTC)
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
Subject: [PATCH 4/7] watchdog/hardlockup: Enable HAVE_NMI_WATCHDOG only on sparc64
Date:   Wed,  7 Jun 2023 17:24:29 +0200
Message-Id: <20230607152432.5435-5-pmladek@suse.com>
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

HAVE_NMI_WATCHDOG is always enabled when SPARC64 is enabled. The sparc64
implementation is special. It does not support the generic hardlockup
related Kconfig values, command line parameters, and sysctl interface.
Instead it is enabled/disabled by the top-level watchdog interface
that is common for both softlockup and hardlockup detectors.

As a result, sparc64 needs special treating in Kconfig and source
files. The checks are a bit complicated because HAVE_NMI_WATCHDOG is
automatically set when HAVE_HARDLOCKUP_DETECTOR_ARCH is set.
But HAVE_HARDLOCKUP_DETECTOR_ARCH is set when the arch specific
implementation uses the generic hardlockup detector related
Kconfig variables, command line parameters, and sysctl interface.

The motivation probably was to avoid changes in the code when
the powerpc64-specific watchdog introduced HAVE_HARDLOCKUP_DETECTOR_ARCH.
It probably allowed to re-use some existing checks for HAVE_NMI_WATCHDOG.

But it actually made things pretty complicated. For example,
the following check was needed in HARDLOCKUP_DETECTOR config variable:

   depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH

The inverted logic makes things easier:

  + HAVE_NMI_WATCHDOG is used only on sparc64. It is clear when
    the sparc64 specific watchdog is used.

  + HAVE_HARDLOCKUP_DETECTOR_ARCH is basically compatible with
    the generic watchdogs. As a result, the common code
    is marked by ifdef CONFIG_HARDLOCKUP_DETECTOR.

As a result:

  + Some conditions are easier.

  + Some conditions use HAVE_HARDLOCKUP_DETECTOR_ARCH instead of
    HAVE_NMI_WATCHDOG.

Note that HARDLOCKUP_DETECTOR_PREFER_BUDDY, HARDLOCKUP_DETECTOR_PERF,
and HARDLOCKUP_DETECTOR_BUDDY might depend only on
HAVE_HARDLOCKUP_DETECTOR_ARCH. They depend on HARDLOCKUP_DETECTOR
and it is not longer enabled when HAVE_NMI_WATCHDOG is set.

Note that asm/nmi.h still has to be included for all arch-specific
watchdogs. It declares more functions that are used in another
arch specific code which includes only linux/nmi.h.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/Kconfig        |  7 +------
 include/linux/nmi.h |  5 ++---
 lib/Kconfig.debug   | 16 +++++++---------
 3 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 13c6e596cf9e..57f15babe188 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -404,10 +404,9 @@ config HAVE_NMI_WATCHDOG
 	depends on HAVE_NMI
 	bool
 	help
-	  The arch provides its own hardlockup detector implementation instead
+	  Sparc64 provides its own hardlockup detector implementation instead
 	  of the generic perf one.
 
-	  Sparc64 defines this variable without HAVE_HARDLOCKUP_DETECTOR_ARCH.
 	  It does _not_ use the command line parameters and sysctl interface
 	  used by generic hardlockup detectors. Instead it is enabled/disabled
 	  by the top-level watchdog interface that is common for both softlockup
@@ -415,7 +414,6 @@ config HAVE_NMI_WATCHDOG
 
 config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	bool
-	select HAVE_NMI_WATCHDOG
 	help
 	  The arch provides its own hardlockup detector implementation instead
 	  of the generic ones.
@@ -423,9 +421,6 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
-	  HAVE_NMI_WATCHDOG is selected to build the code shared with
-	  the sparc64 specific implementation.
-
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index b9e816bde14a..800196c78f65 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -9,7 +9,7 @@
 #include <asm/irq.h>
 
 /* Arch specific watchdogs might need to share extra watchdog-related APIs. */
-#if defined(CONFIG_HAVE_NMI_WATCHDOG)
+#if defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH) || defined(CONFIG_HAVE_NMI_WATCHDOG)
 #include <asm/nmi.h>
 #endif
 
@@ -92,8 +92,7 @@ static inline void hardlockup_detector_disable(void) {}
 #endif
 
 /* Sparc64 has special implemetantion that is always enabled. */
-#if defined(CONFIG_HARDLOCKUP_DETECTOR) || \
-    (defined(CONFIG_HAVE_NMI_WATCHDOG) && !defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH))
+#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
 void arch_touch_nmi_watchdog(void);
 #else
 static inline void arch_touch_nmi_watchdog(void) { }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d201f5d3876b..4b4aa0f941f9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1050,15 +1050,13 @@ config HAVE_HARDLOCKUP_DETECTOR_BUDDY
 #	sparc64: has a custom implementation which is not using the common
 #		hardlockup command line options and sysctl interface.
 #
-# Note that HAVE_NMI_WATCHDOG is used to distinguish the sparc64 specific
-# implementaion. It is automatically enabled also for other arch-specific
-# variants which set HAVE_HARDLOCKUP_DETECTOR_ARCH. It makes the check
-# of avaialable and supported variants quite tricky.
+# Note that HAVE_NMI_WATCHDOG is set when the sparc64 specific implementation
+# is used.
 #
 config HARDLOCKUP_DETECTOR
 	bool "Detect Hard Lockups"
-	depends on DEBUG_KERNEL && !S390
-	depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
+	depends on DEBUG_KERNEL && !S390 && !HAVE_NMI_WATCHDOG
+	depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
 	imply HARDLOCKUP_DETECTOR_PERF
 	imply HARDLOCKUP_DETECTOR_BUDDY
 	select LOCKUP_DETECTOR
@@ -1079,7 +1077,7 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
 	bool "Prefer the buddy CPU hardlockup detector"
 	depends on HARDLOCKUP_DETECTOR
 	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETECTOR_BUDDY
-	depends on !HAVE_NMI_WATCHDOG
+	depends on !HAVE_HARLOCKUP_DETECTOR_ARCH
 	default n
 	help
 	  Say Y here to prefer the buddy hardlockup detector over the perf one.
@@ -1096,7 +1094,7 @@ config HARDLOCKUP_DETECTOR_PERF
 	bool
 	depends on HARDLOCKUP_DETECTOR
 	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
-	depends on !HAVE_NMI_WATCHDOG
+	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 
 config HARDLOCKUP_DETECTOR_BUDDY
@@ -1104,7 +1102,7 @@ config HARDLOCKUP_DETECTOR_BUDDY
 	depends on HARDLOCKUP_DETECTOR
 	depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
 	depends on !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_PREFER_BUDDY
-	depends on !HAVE_NMI_WATCHDOG
+	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 
 #
-- 
2.35.3

