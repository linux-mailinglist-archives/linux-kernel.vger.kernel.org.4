Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFE274D880
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjGJOG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjGJOGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:06:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1AFFA;
        Mon, 10 Jul 2023 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688997963; x=1720533963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0cQUe9pkwTFEo2qElR85DPOsKIH6ISqvOwLIiL5AbLE=;
  b=arvXzGIbj+I592EQjuMUeDyaPU6MWEWlGMnvLc29xF41RGhsFBp8T1Qi
   N3GqpMbg0A59/OpLdWXKNaI7jc89FQcHYM4o3LwYPrNTp1bXS6Z8iXlIn
   LB+LH8xZUhaVC97VNj/BgFEg6B3m5wryv5WIf/Ch1YDNfP2wtEk2Sr6r4
   POkk30ehGx33lora7LCsELwu0tEN0tTYuJwVPjAMbgyvqmAfkR3mjtSvV
   YOM8aWqt7heaVrK/yM97kcRwV70CSdQICkrxWd7MtxNsh5AZSonJDpx7e
   zWzl7wbRiflENwZJ2ti10w8WiO1ftoYvLKI8wYqH7IpxN8kUAieTEDkqE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361814888"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361814888"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714822707"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="714822707"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:13 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 2/9] acpi: Move processor_physically_present() to acpi_processor.c
Date:   Mon, 10 Jul 2023 17:03:30 +0300
Message-ID: <20230710140337.1434060-3-michal.wilczynski@intel.com>
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

Since _PDC method is deprecated and a preferred method of communicating
OSPM processor power management capabilities is _OSC, there is a need to
move function checking whether processor is present as this logic is not
_PDC specific.

Move processor_physically_present() to acpi_processor.c.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_processor.c | 52 ++++++++++++++++++++++++++++++++++-
 drivers/acpi/internal.h       |  1 +
 drivers/acpi/processor_pdc.c  | 49 ---------------------------------
 3 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index f9aa02cac6d1..ebb4efd3d0aa 100644
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
@@ -508,7 +511,54 @@ static void acpi_processor_remove(struct acpi_device *device)
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
 static bool acpi_hwp_native_thermal_lvt_set;
 static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
 							  u32 lvl,
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 90d199ab271c..87c343f79900 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -155,6 +155,7 @@ int acpi_wakeup_device_init(void);
 void acpi_early_processor_set_pdc(void);
 
 void acpi_proc_quirk_dmi_check(void);
+bool processor_physically_present(acpi_handle handle);
 #else
 static inline void acpi_early_processor_set_pdc(void) {}
 #endif
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 34bb06de2afb..6d2d521a068d 100644
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
-- 
2.41.0

