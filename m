Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BC06A77D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCAXjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjCAXiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D4F521F1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713891; x=1709249891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NR72OLVunS5t2SqSsi29lRMoOPaXNWEb1txH4+ymFL0=;
  b=SSgWhUvXh2/LLdc7xJbLU2ZIFvdGZ9SCplpjI32FDZ2SBnCzl9uEb4hD
   wrJFXTcBp5hwAyb6LTxqUeUER5O8hHUaS2z1S6FUhbU/rLDZXihDI0b2h
   oruwKR0xv6LjJb+PEvAiqPJgHm8tADnAtjMmVg05pKE5VvzPBH6t4pZkQ
   NGcTF8Ymy7SJwfqFe+n4C8I4U7Md5YY35kI3O+dH5z5PApry1/aYyroKW
   8r1l4yHRhJGoJtZUGQqigMzm4y/6cBuaN5KCSZWnxME01jO1awTuDfQl9
   XfF3FI7pw8w55x0XiNaDjwXzqF2thq49m5sYSkvkgfgnkgWaV8G3k4Jhw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818807"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818807"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826877"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826877"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:38:01 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v7 24/24] x86/tsc: Stop the HPET hardlockup detector if TSC become unstable
Date:   Wed,  1 Mar 2023 15:47:53 -0800
Message-Id: <20230301234753.28582-25-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
References: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HPET-based hardlockup detector relies on the TSC to determine if an
observed NMI interrupt was originated by HPET timer. Hence, this detector
can no longer be used with an unstable TSC. Once marked as unstable,
the TSC cannot be stable again. In such case, permanently stop the HPET-
based hardlockup detector.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v6:
 * Do not switch to the perf-based NMI watchdog. Instead, only stop
   the HPET-based NMI watchdog if the TSC counter becomes unstable.

Changes since v5:
 * Relocated the declaration of hardlockup_detector_switch_to_perf() to
   x86/nmi.h It does not depend on HPET.
 * Removed function stub. The shim hardlockup detector is always for x86.

Changes since v4:
 * Added a stub version of hardlockup_detector_switch_to_perf() for
   !CONFIG_HPET_TIMER. (lkp)
 * Reconfigure the whole lockup detector instead of unconditionally
   starting the perf-based hardlockup detector.

Changes since v3:
 * None

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 arch/x86/include/asm/nmi.h     |  6 ++++++
 arch/x86/kernel/tsc.c          |  3 +++
 arch/x86/kernel/watchdog_hld.c | 11 +++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 5c5f1e56c404..4d0687a2b4ea 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -63,4 +63,10 @@ void stop_nmi(void);
 void restart_nmi(void);
 void local_touch_nmi(void);
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
+extern void hardlockup_detector_mark_hpet_hld_unavailable(void);
+#else
+static inline void hardlockup_detector_mark_hpet_hld_unavailable(void) {}
+#endif
+
 #endif /* _ASM_X86_NMI_H */
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 344698852146..24f77efea569 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1191,6 +1191,9 @@ void mark_tsc_unstable(char *reason)
 
 	clocksource_mark_unstable(&clocksource_tsc_early);
 	clocksource_mark_unstable(&clocksource_tsc);
+
+	/* The HPET hardlockup detector depends on a stable TSC. */
+	hardlockup_detector_mark_hpet_hld_unavailable();
 }
 
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
index 33c22f6456a3..f5d79ce0e7a2 100644
--- a/arch/x86/kernel/watchdog_hld.c
+++ b/arch/x86/kernel/watchdog_hld.c
@@ -6,6 +6,8 @@
  * Copyright (C) Intel Corporation 2023
  */
 
+#define pr_fmt(fmt) "watchdog: " fmt
+
 #include <linux/nmi.h>
 #include <asm/hpet.h>
 
@@ -84,3 +86,12 @@ void watchdog_nmi_start(void)
 	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
 		hardlockup_detector_hpet_start();
 }
+
+void hardlockup_detector_mark_hpet_hld_unavailable(void)
+{
+	if (detector_type != X86_HARDLOCKUP_DETECTOR_HPET)
+		return;
+
+	pr_warn("TSC is unstable. Stopping the HPET NMI watchdog.");
+	hardlockup_detector_mark_unavailable();
+}
-- 
2.25.1

