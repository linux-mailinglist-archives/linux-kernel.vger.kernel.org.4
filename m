Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0915C74D882
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjGJOGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjGJOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:06:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F07F9;
        Mon, 10 Jul 2023 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688997973; x=1720533973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJoKY2tVwh74wigO+g3CR/NVY34uujEe7BnUctfWF6k=;
  b=IFzBaDGJ5qZm2dBK4QYaBH93a760A0sztYtAZnrk3G47f/msmlj89V01
   BBKhamQBADv5on16JYLyjWBRW+3X9f88xDbYPaKvyHygggoD9pjLBagDL
   6YGJ6YdYRzRz8W+at8m7WItjKe6Sc6Pz/wDmZYKCgvrJPr46V8LJJ3/pt
   NCMwn4KH54USEWAyBcn/s0OgFAZnqJSMcWXlS9SYnS6ibqsiHa+L/xMwM
   V0Xnk7RMe+Jicob6nzVLMk9YweYhhQe72DW9aJl+ZB2/6+qofprEMGYRF
   Fc8/P5zZFLT/0JybRf2VK1JG6JBScf0wHn2zXCslthAy4rNJ/RYFlspy/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361814952"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361814952"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714822841"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="714822841"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:22 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 4/9] acpi: Rename ACPI_PDC constants
Date:   Mon, 10 Jul 2023 17:03:32 +0300
Message-ID: <20230710140337.1434060-5-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710140337.1434060-1-michal.wilczynski@intel.com>
References: <20230710140337.1434060-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI_PDC constants prefix suggest that those constants are only relevant
in the context of the _PDC method. This is not true, as they can also be
used in _OSC context. Change prefix to more generic ACPI_PROC_CAP, that
better describe the purpose of those constants as they describe bits in
processor capabilities buffer. Rename pdc_intel.h to proc_cap_intel.h to
reflect the change in the prefix.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 arch/ia64/include/asm/acpi.h  |  4 ++--
 arch/x86/include/asm/acpi.h   | 11 +++++-----
 arch/x86/xen/enlighten_pv.c   |  8 +++----
 drivers/acpi/processor_pdc.c  |  2 +-
 include/acpi/pdc_intel.h      | 36 --------------------------------
 include/acpi/proc_cap_intel.h | 39 +++++++++++++++++++++++++++++++++++
 6 files changed, 52 insertions(+), 48 deletions(-)
 delete mode 100644 include/acpi/pdc_intel.h
 create mode 100644 include/acpi/proc_cap_intel.h

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 43797cb44383..58500a964238 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -11,7 +11,7 @@
 
 #ifdef __KERNEL__
 
-#include <acpi/pdc_intel.h>
+#include <acpi/proc_cap_intel.h>
 
 #include <linux/init.h>
 #include <linux/numa.h>
@@ -71,7 +71,7 @@ extern int __initdata nid_to_pxm_map[MAX_NUMNODES];
 static inline bool arch_has_acpi_pdc(void) { return true; }
 static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 {
-	*cap |= ACPI_PDC_EST_CAPABILITY_SMP;
+	*cap |= ACPI_PROC_CAP_EST_CAPABILITY_SMP;
 }
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 6a498d1781e7..ce5ad6a496e6 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -6,7 +6,7 @@
  *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *  Copyright (C) 2001 Patrick Mochel <mochel@osdl.org>
  */
-#include <acpi/pdc_intel.h>
+#include <acpi/proc_cap_intel.h>
 
 #include <asm/numa.h>
 #include <asm/fixmap.h>
@@ -104,19 +104,20 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
-	*cap |= ACPI_PDC_C_CAPABILITY_SMP;
+	*cap |= ACPI_PROC_CAP_C_CAPABILITY_SMP;
 
 	if (cpu_has(c, X86_FEATURE_EST))
-		*cap |= ACPI_PDC_EST_CAPABILITY_SWSMP;
+		*cap |= ACPI_PROC_CAP_EST_CAPABILITY_SWSMP;
 
 	if (cpu_has(c, X86_FEATURE_ACPI))
-		*cap |= ACPI_PDC_T_FFH;
+		*cap |= ACPI_PROC_CAP_T_FFH;
 
 	/*
 	 * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
 	 */
 	if (!cpu_has(c, X86_FEATURE_MWAIT))
-		*cap &= ~(ACPI_PDC_C_C2C3_FFH);
+		*cap &= ~(ACPI_PROC_CAP_C_C2C3_FFH);
+
 }
 
 static inline bool acpi_has_cpu_in_madt(void)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 93b658248d01..a3864e2167a8 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -79,7 +79,7 @@
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 #include <asm/acpi.h>
-#include <acpi/pdc_intel.h>
+#include <acpi/proc_cap_intel.h>
 #include <acpi/processor.h>
 #include <xen/interface/platform.h>
 #endif
@@ -288,17 +288,17 @@ static bool __init xen_check_mwait(void)
 
 	native_cpuid(&ax, &bx, &cx, &dx);
 
-	/* Ask the Hypervisor whether to clear ACPI_PDC_C_C2C3_FFH. If so,
+	/* Ask the Hypervisor whether to clear ACPI_PROC_CAP_C_C2C3_FFH. If so,
 	 * don't expose MWAIT_LEAF and let ACPI pick the IOPORT version of C3.
 	 */
 	buf[0] = ACPI_PDC_REVISION_ID;
 	buf[1] = 1;
-	buf[2] = (ACPI_PDC_C_CAPABILITY_SMP | ACPI_PDC_EST_CAPABILITY_SWSMP);
+	buf[2] = (ACPI_PROC_CAP_C_CAPABILITY_SMP | ACPI_PROC_CAP_EST_CAPABILITY_SWSMP);
 
 	set_xen_guest_handle(op.u.set_pminfo.pdc, buf);
 
 	if ((HYPERVISOR_platform_op(&op) == 0) &&
-	    (buf[2] & (ACPI_PDC_C_C1_FFH | ACPI_PDC_C_C2C3_FFH))) {
+	    (buf[2] & (ACPI_PROC_CAP_C_C1_FFH | ACPI_PROC_CAP_C_C2C3_FFH))) {
 		cpuid_leaf5_ecx_val = cx;
 		cpuid_leaf5_edx_val = dx;
 	}
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index b2c6f17fc87c..77d3fe73047c 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -21,7 +21,7 @@ static void acpi_set_pdc_bits(u32 *buf)
 	buf[1] = 1;
 
 	/* Enable coordination with firmware's _TSD info */
-	buf[2] = ACPI_PDC_SMP_T_SWCOORD;
+	buf[2] = ACPI_PROC_CAP_SMP_T_SWCOORD;
 
 	/* Twiddle arch-specific bits needed for _PDC */
 	arch_acpi_set_proc_cap_bits(&buf[2]);
diff --git a/include/acpi/pdc_intel.h b/include/acpi/pdc_intel.h
deleted file mode 100644
index 967c552d1cd3..000000000000
--- a/include/acpi/pdc_intel.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-/* _PDC bit definition for Intel processors */
-
-#ifndef __PDC_INTEL_H__
-#define __PDC_INTEL_H__
-
-#define ACPI_PDC_P_FFH			(0x0001)
-#define ACPI_PDC_C_C1_HALT		(0x0002)
-#define ACPI_PDC_T_FFH			(0x0004)
-#define ACPI_PDC_SMP_C1PT		(0x0008)
-#define ACPI_PDC_SMP_C2C3		(0x0010)
-#define ACPI_PDC_SMP_P_SWCOORD		(0x0020)
-#define ACPI_PDC_SMP_C_SWCOORD		(0x0040)
-#define ACPI_PDC_SMP_T_SWCOORD		(0x0080)
-#define ACPI_PDC_C_C1_FFH		(0x0100)
-#define ACPI_PDC_C_C2C3_FFH		(0x0200)
-#define ACPI_PDC_SMP_P_HWCOORD		(0x0800)
-
-#define ACPI_PDC_EST_CAPABILITY_SMP	(ACPI_PDC_SMP_C1PT | \
-					 ACPI_PDC_C_C1_HALT | \
-					 ACPI_PDC_P_FFH)
-
-#define ACPI_PDC_EST_CAPABILITY_SWSMP	(ACPI_PDC_SMP_C1PT | \
-					 ACPI_PDC_C_C1_HALT | \
-					 ACPI_PDC_SMP_P_SWCOORD | \
-					 ACPI_PDC_SMP_P_HWCOORD | \
-					 ACPI_PDC_P_FFH)
-
-#define ACPI_PDC_C_CAPABILITY_SMP	(ACPI_PDC_SMP_C2C3  | \
-					 ACPI_PDC_SMP_C1PT  | \
-					 ACPI_PDC_C_C1_HALT | \
-					 ACPI_PDC_C_C1_FFH  | \
-					 ACPI_PDC_C_C2C3_FFH)
-
-#endif				/* __PDC_INTEL_H__ */
diff --git a/include/acpi/proc_cap_intel.h b/include/acpi/proc_cap_intel.h
new file mode 100644
index 000000000000..57e5e2628abb
--- /dev/null
+++ b/include/acpi/proc_cap_intel.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Vendor specific processor capabilities bit definition
+ * for Intel processors. Those bits are used to convey OSPM
+ * power management capabilities to the platform.
+ */
+
+#ifndef __PROC_CAP_INTEL_H__
+#define __PROC_CAP_INTEL_H__
+
+#define ACPI_PROC_CAP_P_FFH			(0x0001)
+#define ACPI_PROC_CAP_C_C1_HALT			(0x0002)
+#define ACPI_PROC_CAP_T_FFH			(0x0004)
+#define ACPI_PROC_CAP_SMP_C1PT			(0x0008)
+#define ACPI_PROC_CAP_SMP_C2C3			(0x0010)
+#define ACPI_PROC_CAP_SMP_P_SWCOORD		(0x0020)
+#define ACPI_PROC_CAP_SMP_C_SWCOORD		(0x0040)
+#define ACPI_PROC_CAP_SMP_T_SWCOORD		(0x0080)
+#define ACPI_PROC_CAP_C_C1_FFH			(0x0100)
+#define ACPI_PROC_CAP_C_C2C3_FFH		(0x0200)
+#define ACPI_PROC_CAP_SMP_P_HWCOORD		(0x0800)
+
+#define ACPI_PROC_CAP_EST_CAPABILITY_SMP	(ACPI_PROC_CAP_SMP_C1PT | \
+						 ACPI_PROC_CAP_C_C1_HALT | \
+						 ACPI_PROC_CAP_P_FFH)
+
+#define ACPI_PROC_CAP_EST_CAPABILITY_SWSMP	(ACPI_PROC_CAP_SMP_C1PT | \
+						 ACPI_PROC_CAP_C_C1_HALT | \
+						 ACPI_PROC_CAP_SMP_P_SWCOORD | \
+						 ACPI_PROC_CAP_SMP_P_HWCOORD | \
+						 ACPI_PROC_CAP_P_FFH)
+
+#define ACPI_PROC_CAP_C_CAPABILITY_SMP		(ACPI_PROC_CAP_SMP_C2C3  | \
+						 ACPI_PROC_CAP_SMP_C1PT  | \
+						 ACPI_PROC_CAP_C_C1_HALT | \
+						 ACPI_PROC_CAP_C_C1_FFH  | \
+						 ACPI_PROC_CAP_C_C2C3_FFH)
+
+#endif /* __PROC_CAP_INTEL_H__ */
-- 
2.41.0

