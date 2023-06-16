Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EA673343C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345192AbjFPPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344708AbjFPPHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:07:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A730F1;
        Fri, 16 Jun 2023 08:07:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 17D711F74C;
        Fri, 16 Jun 2023 15:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686928030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8rPtQgN6vSoW8VvCYmw0+AJGTAHRLGVOe7N7gs1tSc=;
        b=WcE6bts402dB0qd+B0JwNUcM215ujMBrjbLGulyEpRpZahfabZxrV3e+htSPXqkev4clah
        IQznN1Kr0G6ZtraGh62ZmO5lpnl9+7T53PQyqvPHtCV7UFV4ejpAPMUYB14+unZNlTuUhD
        kM07aBFUhfA+5gWs2cUsAYby7QRAbUE=
Received: from alley.suse.cz (unknown [10.100.208.146])
        by relay2.suse.de (Postfix) with ESMTP id 715CE2C141;
        Fri, 16 Jun 2023 15:07:09 +0000 (UTC)
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
Subject: [PATCH v2 3/6] watchdog/hardlockup: Declare arch_touch_nmi_watchdog() only in linux/nmi.h
Date:   Fri, 16 Jun 2023 17:06:15 +0200
Message-Id: <20230616150618.6073-4-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616150618.6073-1-pmladek@suse.com>
References: <20230616150618.6073-1-pmladek@suse.com>
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

arch_touch_nmi_watchdog() needs a different implementation for various
hardlockup detector implementations. And it does nothing when
any hardlockup detector is not built at all.

arch_touch_nmi_watchdog() is declared via linux/nmi.h. And it must be
defined as an empty function when there is no hardlockup detector.
It is done directly in this header file for the perf and buddy detectors.
And it is done in the included asm/linux.h for arch specific detectors.

The reason probably is that the arch specific variants build the code
using another conditions. For example, powerpc64/sparc64 builds the code
when CONFIG_PPC_WATCHDOG is enabled.

Another reason might be that these architectures define more functions
in asm/nmi.h anyway.

However the generic code actually knows when the function will be
implemented. It happens when some full featured or the sparc64-specific
hardlockup detector is built.

In particular, CONFIG_HARDLOCKUP_DETECTOR can be enabled only when
a generic or arch-specific full featured hardlockup detector is available.
The only exception is sparc64 which can be built even when the global
HARDLOCKUP_DETECTOR switch is disabled.

The information about sparc64 is a bit complicated. The hardlockup
detector is built there when CONFIG_HAVE_NMI_WATCHDOG is set and
CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.

People might wonder whether this change really makes things easier.
The motivation is:

  + The current logic in linux/nmi.h is far from obvious.
    For example, arch_touch_nmi_watchdog() is defined as {} when
    neither CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER nor
    CONFIG_HAVE_NMI_WATCHDOG is defined.

  + The change synchronizes the checks in lib/Kconfig.debug and
    in the generic code.

  + It is a step that will help cleaning HAVE_NMI_WATCHDOG related
    checks.

The change should not change the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/powerpc/include/asm/nmi.h |  2 --
 arch/sparc/include/asm/nmi.h   |  1 -
 include/linux/nmi.h            | 13 ++++++++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index 43bfd4de868f..ce25318c3902 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -3,11 +3,9 @@
 #define _ASM_NMI_H
 
 #ifdef CONFIG_PPC_WATCHDOG
-extern void arch_touch_nmi_watchdog(void);
 long soft_nmi_interrupt(struct pt_regs *regs);
 void watchdog_hardlockup_set_timeout_pct(u64 pct);
 #else
-static inline void arch_touch_nmi_watchdog(void) {}
 static inline void watchdog_hardlockup_set_timeout_pct(u64 pct) {}
 #endif
 
diff --git a/arch/sparc/include/asm/nmi.h b/arch/sparc/include/asm/nmi.h
index 90ee7863d9fe..920dc23f443f 100644
--- a/arch/sparc/include/asm/nmi.h
+++ b/arch/sparc/include/asm/nmi.h
@@ -8,7 +8,6 @@ void nmi_adjust_hz(unsigned int new_hz);
 
 extern atomic_t nmi_active;
 
-void arch_touch_nmi_watchdog(void);
 void start_nmi_watchdog(void *unused);
 void stop_nmi_watchdog(void *unused);
 
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index b5d0b7ab52fb..b9e816bde14a 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -7,6 +7,8 @@
 
 #include <linux/sched.h>
 #include <asm/irq.h>
+
+/* Arch specific watchdogs might need to share extra watchdog-related APIs. */
 #if defined(CONFIG_HAVE_NMI_WATCHDOG)
 #include <asm/nmi.h>
 #endif
@@ -89,12 +91,17 @@ extern unsigned int hardlockup_panic;
 static inline void hardlockup_detector_disable(void) {}
 #endif
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER)
+/* Sparc64 has special implemetantion that is always enabled. */
+#if defined(CONFIG_HARDLOCKUP_DETECTOR) || \
+    (defined(CONFIG_HAVE_NMI_WATCHDOG) && !defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH))
 void arch_touch_nmi_watchdog(void);
+#else
+static inline void arch_touch_nmi_watchdog(void) { }
+#endif
+
+#if defined(CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER)
 void watchdog_hardlockup_touch_cpu(unsigned int cpu);
 void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
-#elif !defined(CONFIG_HAVE_NMI_WATCHDOG)
-static inline void arch_touch_nmi_watchdog(void) { }
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
-- 
2.35.3

