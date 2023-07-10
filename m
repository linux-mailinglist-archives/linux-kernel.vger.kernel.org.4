Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6957274D87E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjGJOGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjGJOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:06:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E664E100;
        Mon, 10 Jul 2023 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688997959; x=1720533959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oKFvqYMRF7Pt7Xhjz32NaDYPooCMV5ps+J3TslYX8qg=;
  b=dPmX8gSl8b39ozHg6QjfvY+K9c1ynMyET5VwrGzghuGGuNv59BdhGpDV
   tVcxeMnoSXiJLl6gwY+3IRWbDykQWitNHVai95WweE2VhqMGTYbFz7Y7S
   D4jvhfjFHoOsskfm4R0rCVofcRq++dOpvHbEjHjWjJSYSNDu7tAIjVmLx
   8MooQKtnFFd5a2mS/Rf1WNFCecPQzmct4TKWUiFzBIiJteTJ7Cg8waXYh
   y2eyM3uR/7S6x7kVJpulH3OOKVsFBMZ9FBZWlp/rKs3TxoQyvUaXygc1C
   mtzDIaffl3qkCANGXxsa2647cJ31qYe+O9kgzAkp2S2alZZHQJKNsbnrA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361814852"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361814852"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714822612"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="714822612"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:05:09 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 1/9] acpi: Move mwait quirk out of acpi_processor.c
Date:   Mon, 10 Jul 2023 17:03:29 +0300
Message-ID: <20230710140337.1434060-2-michal.wilczynski@intel.com>
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

Commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal board")
introduced a workaround for mwait for a specific x86 system. Move the
code outside of acpi_processor.c to acpi/x86 directory for better
coherency. Rename functions to start with acpi_proc_quirk to make the
goal obvious.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/internal.h      |  2 ++
 drivers/acpi/processor_pdc.c | 29 +----------------------------
 drivers/acpi/x86/utils.c     | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index f4148dc50b9c..90d199ab271c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -153,6 +153,8 @@ int acpi_wakeup_device_init(void);
    -------------------------------------------------------------------------- */
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
 void acpi_early_processor_set_pdc(void);
+
+void acpi_proc_quirk_dmi_check(void);
 #else
 static inline void acpi_early_processor_set_pdc(void) {}
 #endif
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 18fb04523f93..34bb06de2afb 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -174,36 +174,9 @@ early_init_pdc(acpi_handle handle, u32 lvl, void *context, void **rv)
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
 void __init acpi_early_processor_set_pdc(void)
 {
-	processor_dmi_check();
+	acpi_proc_quirk_dmi_check();
 
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index c2b925f8cd4e..5903cd7c8404 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -518,3 +518,38 @@ bool acpi_quirk_skip_acpi_ac_and_battery(void)
 	return false;
 }
 EXPORT_SYMBOL_GPL(acpi_quirk_skip_acpi_ac_and_battery);
+
+/* This section provides a workaround for a specific x86 system
+ * which requires disabling of mwait to work correctly.
+ */
+static int __init acpi_proc_quirk_set_no_mwait(const struct dmi_system_id *id)
+{
+	pr_notice("%s detected - disabling mwait for CPU C-states\n",
+		  id->ident);
+	boot_option_idle_override = IDLE_NOMWAIT;
+	return 0;
+}
+
+static const struct dmi_system_id acpi_proc_quirk_idle_dmi_table[] __initconst = {
+	{
+		.callback = acpi_proc_quirk_set_no_mwait,
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
+void __init acpi_proc_quirk_dmi_check(void)
+{
+	/*
+	 * Check whether the system is DMI table. If yes, OSPM
+	 * should not use mwait for CPU-states.
+	 */
+	dmi_check_system(acpi_proc_quirk_idle_dmi_table);
+}
-- 
2.41.0

