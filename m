Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4285372E7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbjFMQMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbjFMQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:12:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAE0A1;
        Tue, 13 Jun 2023 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686672761; x=1718208761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TmLYSmJr3kuyIrE1YnGbwOsu8dcWq+znY7V5gJ2mPRc=;
  b=Yb0I8R82YnbRgErsNiBFp1TRUaU2FOal1bzUglN2rdHePAXTuiZTX9ch
   LM4yzUAhJKJDZ7CwkPxtaeZ4m0XNPb8msZk7mk5b2ZPQKEAIDwBsAer4v
   kVndn+e+aJG1nLXEXvSJdFroFFBuFa8Px1N2ydy5jPjIxyDCcGFkxJPem
   tTdDPzwljcqQiv/K7XJEZZmQ4DArEzpt52A1C8O+JGylHWHS8p4b0uxAt
   JqNm2bUI6crm5L6VGMrFS8rYLW5HJc9Gg/ryjR5BnhQRLdpQ+u9Fwglv6
   S2r6vQ+bru+Zpd4kNpWsVEpEMnPVs17W7sNV2MlvIwZKC9aenM3I06Ori
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348038787"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="348038787"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="714863474"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="714863474"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2023 09:10:52 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 1/5] acpi: Move logic responsible for conveying processor OSPM capabilities
Date:   Tue, 13 Jun 2023 19:10:30 +0300
Message-Id: <20230613161034.3496047-2-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613161034.3496047-1-michal.wilczynski@intel.com>
References: <20230613161034.3496047-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since _PDC method is deprecated and a preferred method of communicating
OSPM processor power management capabilities is _OSC, there is a need to
move functions checking whether processor is present and workarounds for
specific hardware to acpi_processor.c as this logic is not _PDC specific.
It also applies to the _OSC objects.

Move processor_dmi_check(), processor_idle_dmi_table, set_no_mwait() and
processor_physically_present() to acpi_processor.c.
Introduce IDLE_NOMWAIT workaround and processor_dmi_table workarounds to
work with _OSC objects.
Mark acpi_early_processor_set_pdc() and acpi_processor_set_pdc() as
deprecated.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_processor.c | 84 ++++++++++++++++++++++++++++++++++-
 drivers/acpi/internal.h       |  3 ++
 drivers/acpi/processor_pdc.c  | 80 +--------------------------------
 include/acpi/processor.h      |  2 +-
 4 files changed, 89 insertions(+), 80 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index f9aa02cac6d1..8c5d0295a042 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -12,6 +12,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -21,6 +22,8 @@
 
 #include <asm/cpu.h>
 
+#include <xen/xen.h>
+
 #include "internal.h"
 
 DEFINE_PER_CPU(struct acpi_processor *, processors);
@@ -508,7 +511,86 @@ static void acpi_processor_remove(struct acpi_device *device)
 }
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
-#ifdef CONFIG_X86
+#ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
+bool __init processor_physically_present(acpi_handle handle)
+{
+	int cpuid, type;
+	u32 acpi_id;
+	acpi_status status;
+	acpi_object_type acpi_type;
+	unsigned long long tmp;
+	union acpi_object object = {};
+	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
+
+	status = acpi_get_type(handle, &acpi_type);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	switch (acpi_type) {
+	case ACPI_TYPE_PROCESSOR:
+		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			return false;
+		acpi_id = object.processor.proc_id;
+		break;
+	case ACPI_TYPE_DEVICE:
+		status = acpi_evaluate_integer(handle, METHOD_NAME__UID,
+					       NULL, &tmp);
+		if (ACPI_FAILURE(status))
+			return false;
+		acpi_id = tmp;
+		break;
+	default:
+		return false;
+	}
+
+	if (xen_initial_domain())
+		/*
+		 * When running as a Xen dom0 the number of processors Linux
+		 * sees can be different from the real number of processors on
+		 * the system, and we still need to execute _PDC or _OSC for
+		 * all of them.
+		 */
+		return xen_processor_present(acpi_id);
+
+	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
+	cpuid = acpi_get_cpuid(handle, type, acpi_id);
+
+	return !invalid_logical_cpuid(cpuid);
+}
+
+static int __init set_no_mwait(const struct dmi_system_id *id)
+{
+	pr_notice("%s detected - disabling mwait for CPU C-states\n",
+		  id->ident);
+	boot_option_idle_override = IDLE_NOMWAIT;
+	return 0;
+}
+
+static const struct dmi_system_id processor_idle_dmi_table[] __initconst = {
+	{
+		.callback = set_no_mwait,
+		.ident = "Extensa 5220",
+		.matches =  {
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
+			DMI_MATCH(DMI_BOARD_NAME, "Columbia"),
+		},
+		.driver_data = NULL,
+	},
+	{}
+};
+
+void __init processor_dmi_check(void)
+{
+	/*
+	 * Check whether the system is DMI table. If yes, OSPM
+	 * should not use mwait for CPU-states.
+	 */
+	dmi_check_system(processor_idle_dmi_table);
+}
+
 static bool acpi_hwp_native_thermal_lvt_set;
 static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
 							  u32 lvl,
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 06ad497067ac..f979a2f7077c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -151,6 +151,9 @@ int acpi_wakeup_device_init(void);
    -------------------------------------------------------------------------- */
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
 void acpi_early_processor_set_pdc(void);
+
+void processor_dmi_check(void);
+bool processor_physically_present(acpi_handle handle);
 #else
 static inline void acpi_early_processor_set_pdc(void) {}
 #endif
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 18fb04523f93..5596862e6fea 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -9,61 +9,12 @@
 
 #define pr_fmt(fmt) "ACPI: " fmt
 
-#include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
-#include <xen/xen.h>
-
 #include "internal.h"
 
-static bool __init processor_physically_present(acpi_handle handle)
-{
-	int cpuid, type;
-	u32 acpi_id;
-	acpi_status status;
-	acpi_object_type acpi_type;
-	unsigned long long tmp;
-	union acpi_object object = { 0 };
-	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
-
-	status = acpi_get_type(handle, &acpi_type);
-	if (ACPI_FAILURE(status))
-		return false;
-
-	switch (acpi_type) {
-	case ACPI_TYPE_PROCESSOR:
-		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
-		if (ACPI_FAILURE(status))
-			return false;
-		acpi_id = object.processor.proc_id;
-		break;
-	case ACPI_TYPE_DEVICE:
-		status = acpi_evaluate_integer(handle, "_UID", NULL, &tmp);
-		if (ACPI_FAILURE(status))
-			return false;
-		acpi_id = tmp;
-		break;
-	default:
-		return false;
-	}
-
-	if (xen_initial_domain())
-		/*
-		 * When running as a Xen dom0 the number of processors Linux
-		 * sees can be different from the real number of processors on
-		 * the system, and we still need to execute _PDC for all of
-		 * them.
-		 */
-		return xen_processor_present(acpi_id);
-
-	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
-	cpuid = acpi_get_cpuid(handle, type, acpi_id);
-
-	return !invalid_logical_cpuid(cpuid);
-}
-
 static void acpi_set_pdc_bits(u32 *buf)
 {
 	buf[0] = ACPI_PDC_REVISION_ID;
@@ -146,7 +97,7 @@ acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 	return status;
 }
 
-void acpi_processor_set_pdc(acpi_handle handle)
+void __deprecated acpi_processor_set_pdc(acpi_handle handle)
 {
 	struct acpi_object_list *obj_list;
 
@@ -174,34 +125,7 @@ early_init_pdc(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK;
 }
 
-static int __init set_no_mwait(const struct dmi_system_id *id)
-{
-	pr_notice("%s detected - disabling mwait for CPU C-states\n",
-		  id->ident);
-	boot_option_idle_override = IDLE_NOMWAIT;
-	return 0;
-}
-
-static const struct dmi_system_id processor_idle_dmi_table[] __initconst = {
-	{
-	set_no_mwait, "Extensa 5220", {
-	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-	DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-	DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
-	DMI_MATCH(DMI_BOARD_NAME, "Columbia") }, NULL},
-	{},
-};
-
-static void __init processor_dmi_check(void)
-{
-	/*
-	 * Check whether the system is DMI table. If yes, OSPM
-	 * should not use mwait for CPU-states.
-	 */
-	dmi_check_system(processor_idle_dmi_table);
-}
-
-void __init acpi_early_processor_set_pdc(void)
+void __init __deprecated acpi_early_processor_set_pdc(void)
 {
 	processor_dmi_check();
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 94181fe9780a..83ed42254567 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -372,7 +372,7 @@ static inline void acpi_cppc_processor_exit(struct acpi_processor *pr)
 #endif	/* CONFIG_ACPI_CPPC_LIB */
 
 /* in processor_pdc.c */
-void acpi_processor_set_pdc(acpi_handle handle);
+void __deprecated acpi_processor_set_pdc(acpi_handle handle);
 
 /* in processor_throttling.c */
 #ifdef CONFIG_ACPI_CPU_FREQ_PSS
-- 
2.41.0

