Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09020726490
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbjFGP1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbjFGP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:26:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5B52101;
        Wed,  7 Jun 2023 08:26:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B533C1FDAF;
        Wed,  7 Jun 2023 15:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686151522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZMgrqHtMrAeY5j22xjkDrC2zHqYEKve2qBXN/mlSCao=;
        b=GVdgT+jq8CYmHR3ddjDWe4Z+IuF669E1fJpSbvQKwtVI6CNBcVVp2eLM0fIq/vaGolWUSH
        uI4KJOe08m6IdZIpbCD/2r/Vft8j3RTn7S9BIWOVLtbPVL2cFEBwfDRyo+eaG2tVjpVDZO
        QW11sykPlIjVx0WJ7QSlH8wI92Lp5wg=
Received: from alley.suse.cz (unknown [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id 2C92A2C141;
        Wed,  7 Jun 2023 15:25:22 +0000 (UTC)
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
Subject: [PATCH 2/7] watchdog/hardlockup: Make the config checks more straightforward
Date:   Wed,  7 Jun 2023 17:24:27 +0200
Message-Id: <20230607152432.5435-3-pmladek@suse.com>
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

There are four possible variants of hardlockup detectors:

  + buddy: available when SMP is set.

  + perf: available when HAVE_HARDLOCKUP_DETECTOR_PERF is set.

  + arch-specific: available when HAVE_HARDLOCKUP_DETECTOR_ARCH is set.

  + sparc64 special variant: available when HAVE_NMI_WATCHDOG is set
	and HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.

The check for the sparc64 variant is more complicated because
HAVE_NMI_WATCHDOG is used to #ifdef code used by both arch-specific
and sparc64 specific variant. Therefore it is automatically
selected with HAVE_HARDLOCKUP_DETECTOR_ARCH.

This complexity is partly hidden in HAVE_HARDLOCKUP_DETECTOR_NON_ARCH.
It reduces the size of some checks but it makes them harder to follow.

Finally, the other temporary variable HARDLOCKUP_DETECTOR_NON_ARCH
is used to re-compute HARDLOCKUP_DETECTOR_PERF/BUDDY when the global
HARDLOCKUP_DETECTOR switch is enabled/disabled.

Make the logic more straightforward by the following changes:

  + Better explain the role of HAVE_HARDLOCKUP_DETECTOR_ARCH and
    HAVE_NMI_WATCHDOG in comments.

  + Add HAVE_HARDLOCKUP_DETECTOR_BUDDY so that there is separate
    HAVE_* for all four hardlockup detector variants.

    Use it in the other conditions instead of SMP. It makes it
    clear that it is about the buddy detector.

  + Open code HAVE_HARDLOCKUP_DETECTOR_NON_ARCH in HARDLOCKUP_DETECTOR
    and HARDLOCKUP_DETECTOR_PREFER_BUDDY. It helps to understand
    the conditions between the four hardlockup detector variants.

  + Define the exact conditions when HARDLOCKUP_DETECTOR_PERF/BUDDY
    can be enabled. It explains the dependency on the other
    hardlockup detector variants.

    Also it allows to remove HARDLOCKUP_DETECTOR_NON_ARCH by using "imply".
    It triggers re-evaluating HARDLOCKUP_DETECTOR_PERF/BUDDY when
    the global HARDLOCKUP_DETECTOR switch is changed.

  + Add dependency on HARDLOCKUP_DETECTOR so that the affected variables
    disappear when the hardlockup detectors are disabled.

    Another nice side effect is that HARDLOCKUP_DETECTOR_PREFER_BUDDY
    value is not preserved when the global switch is disabled.
    The user has to make the decision when it is enabled again.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/Kconfig      | 22 ++++++++++++-----
 lib/Kconfig.debug | 63 ++++++++++++++++++++++++++++-------------------
 2 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 422f0ffa269e..13c6e596cf9e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -404,17 +404,27 @@ config HAVE_NMI_WATCHDOG
 	depends on HAVE_NMI
 	bool
 	help
-	  The arch provides a low level NMI watchdog. It provides
-	  asm/nmi.h, and defines its own watchdog_hardlockup_probe() and
-	  arch_touch_nmi_watchdog().
+	  The arch provides its own hardlockup detector implementation instead
+	  of the generic perf one.
+
+	  Sparc64 defines this variable without HAVE_HARDLOCKUP_DETECTOR_ARCH.
+	  It does _not_ use the command line parameters and sysctl interface
+	  used by generic hardlockup detectors. Instead it is enabled/disabled
+	  by the top-level watchdog interface that is common for both softlockup
+	  and hardlockup detectors.
 
 config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	bool
 	select HAVE_NMI_WATCHDOG
 	help
-	  The arch chooses to provide its own hardlockup detector, which is
-	  a superset of the HAVE_NMI_WATCHDOG. It also conforms to config
-	  interfaces and parameters provided by hardlockup detector subsystem.
+	  The arch provides its own hardlockup detector implementation instead
+	  of the generic ones.
+
+	  It uses the same command line parameters, and sysctl interface,
+	  as the generic hardlockup detectors.
+
+	  HAVE_NMI_WATCHDOG is selected to build the code shared with
+	  the sparc64 specific implementation.
 
 config HAVE_PERF_REGS
 	bool
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3e91fa33c7a0..d201f5d3876b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1035,16 +1035,33 @@ config BOOTPARAM_SOFTLOCKUP_PANIC
 
 	  Say N if unsure.
 
+config HAVE_HARDLOCKUP_DETECTOR_BUDDY
+	bool
+	depends on SMP
+	default y
+
 #
-# arch/ can define HAVE_HARDLOCKUP_DETECTOR_ARCH to provide their own hard
-# lockup detector rather than the perf based detector.
+# Global switch whether to build a hardlockup detector at all. It is available
+# only when the architecture supports at least one implementation. There are
+# two exceptions. The hardlockup detector is newer enabled on:
+#
+#	s390: it reported many false positives there
+#
+#	sparc64: has a custom implementation which is not using the common
+#		hardlockup command line options and sysctl interface.
+#
+# Note that HAVE_NMI_WATCHDOG is used to distinguish the sparc64 specific
+# implementaion. It is automatically enabled also for other arch-specific
+# variants which set HAVE_HARDLOCKUP_DETECTOR_ARCH. It makes the check
+# of avaialable and supported variants quite tricky.
 #
 config HARDLOCKUP_DETECTOR
 	bool "Detect Hard Lockups"
 	depends on DEBUG_KERNEL && !S390
-	depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH || HAVE_HARDLOCKUP_DETECTOR_ARCH
+	depends on ((HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY) && !HAVE_NMI_WATCHDOG) || HAVE_HARDLOCKUP_DETECTOR_ARCH
+	imply HARDLOCKUP_DETECTOR_PERF
+	imply HARDLOCKUP_DETECTOR_BUDDY
 	select LOCKUP_DETECTOR
-	select HARDLOCKUP_DETECTOR_NON_ARCH if HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
 
 	help
 	  Say Y here to enable the kernel to act as a watchdog to detect
@@ -1055,9 +1072,15 @@ config HARDLOCKUP_DETECTOR
 	  chance to run.  The current stack trace is displayed upon detection
 	  and the system will stay locked up.
 
+#
+# Note that arch-specific variants are always preferred.
+#
 config HARDLOCKUP_DETECTOR_PREFER_BUDDY
 	bool "Prefer the buddy CPU hardlockup detector"
-	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && SMP
+	depends on HARDLOCKUP_DETECTOR
+	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETECTOR_BUDDY
+	depends on !HAVE_NMI_WATCHDOG
+	default n
 	help
 	  Say Y here to prefer the buddy hardlockup detector over the perf one.
 
@@ -1071,39 +1094,27 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
 
 config HARDLOCKUP_DETECTOR_PERF
 	bool
-	depends on HAVE_HARDLOCKUP_DETECTOR_PERF
+	depends on HARDLOCKUP_DETECTOR
+	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
+	depends on !HAVE_NMI_WATCHDOG
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 
 config HARDLOCKUP_DETECTOR_BUDDY
 	bool
-	depends on SMP
+	depends on HARDLOCKUP_DETECTOR
+	depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
+	depends on !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_PREFER_BUDDY
+	depends on !HAVE_NMI_WATCHDOG
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 
+#
 # Both the "perf" and "buddy" hardlockup detectors count hrtimer
 # interrupts. This config enables functions managing this common code.
+#
 config HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 	bool
 	select SOFTLOCKUP_DETECTOR
 
-# For hardlockup detectors you can have one directly provided by the arch
-# or use a "non-arch" one. If you're using a "non-arch" one that is
-# further divided the perf hardlockup detector (which, confusingly, needs
-# arch-provided perf support) and the buddy hardlockup detector (which just
-# needs SMP). In either case, using the "non-arch" code conflicts with
-# the NMI watchdog code (which is sometimes used directly and sometimes used
-# by the arch-provided hardlockup detector).
-config HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
-	bool
-	depends on (HAVE_HARDLOCKUP_DETECTOR_PERF || SMP) && !HAVE_NMI_WATCHDOG
-	default y
-
-# This will select the appropriate non-arch hardlockdup detector
-config HARDLOCKUP_DETECTOR_NON_ARCH
-	bool
-	depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
-	select HARDLOCKUP_DETECTOR_BUDDY if !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_PREFER_BUDDY
-	select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
-
 #
 # Enables a timestamp based low pass filter to compensate for perf based
 # hard lockup detection which runs too fast due to turbo modes.
-- 
2.35.3

