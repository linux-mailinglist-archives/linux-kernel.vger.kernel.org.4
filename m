Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D676BD2FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCPPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjCPPK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:10:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31BF34038;
        Thu, 16 Mar 2023 08:10:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 945B61FE00;
        Thu, 16 Mar 2023 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678979453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lnSumxr3Y/D/dHHIbkluDIYdmFB5/urbTFFEqt2Aax0=;
        b=vUhs+8TZkkYa2DWt7XgLKF34vRG0g9yrlY7ClrwW9ek+PgbkA/JGN6KDPc7/+RtN/pdgye
        X2GAtISKcjuBNNCvmwIACA/xDCmMTSUeiwUQy/Ce4DqrSecGVccte4WN6yWNl2qqHwAZtP
        mkfZdne/hVWmzkovZ12opS3KcJNZXG4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E84513A2F;
        Thu, 16 Mar 2023 15:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FhCoEX0xE2RJAQAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Thu, 16 Mar 2023 15:10:53 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     pmladek@suse.com, mcgrof@kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v4] ACPI: cpufreq: use a platform device to load ACPI PPC and PCC drivers
Date:   Thu, 16 Mar 2023 16:10:36 +0100
Message-Id: <20230316151036.10181-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi-cpufreq and pcc-cpufreq drivers are loaded through per-CPU
module aliases. This can result in many unnecessary load requests during
boot if another frequency module, such as intel_pstate, is already
active. For instance, on a typical Intel system, one can observe that
udev makes 2x#CPUs attempts to insert acpi_cpufreq and 1x#CPUs attempts
for pcc_cpufreq. All these tries then fail if another frequency module
is already registered.

In the worst case, without the recent fix in commit 0254127ab977e
("module: Don't wait for GOING modules"), these module loads occupied
all udev workers and had their initialization attempts ran sequentially.
Resolving all these loads then on some larger machines took too long,
prevented other hardware from getting its drivers initialized and
resulted in a failed boot. Discussion over these duplicate module
requests ended up with a conclusion that only one load attempt should be
ideally made.

Both acpi-cpufreq and pcc-cpufreq drivers use platform firmware controls
which are defined by ACPI. It is possible to treat these interfaces as
platform devices.

The patch extends the ACPI parsing logic to check the ACPI namespace if
the PPC or PCC interface is present and creates a virtual platform
device for each if it is available. The acpi-cpufreq and pcc-cpufreq
drivers are then updated to map to these devices.

This allows to try loading acpi-cpufreq and pcc-cpufreq only once during
boot and only if a given interface is available in the firmware.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---

Changes since v3 [1]:
- Mark acpi_pcc_cpufreq_init() as static.

Changes since v2 [2]:
- Remove mention about all CPUs needing same clocking parameters from the commit
  message.
- Integrate the new logic to detect presence of PPC and PCC with the current
  ACPI processor code which avoids an additional scan of the ACPI namespace.

Changes since v1 [3]:
- Describe the worst case scenario without the recent fix 0254127ab977e
  ("module: Don't wait for GOING modules") and refer to its discussion
  in the commit message.
- Consider ACPI processor device objects when looking for _PCT, in
  addition to processor objects.
- Add a few more comments explaining the code.

[1] https://lore.kernel.org/lkml/20230301085717.10411-1-petr.pavlu@suse.com/
[2] https://lore.kernel.org/lkml/20230220143143.3492-1-petr.pavlu@suse.com/
[3] https://lore.kernel.org/lkml/20230131130041.629-1-petr.pavlu@suse.com/

 drivers/acpi/acpi_processor.c  | 42 ++++++++++++++++++++++++++++++++--
 drivers/cpufreq/acpi-cpufreq.c | 39 +++++++++++++++++--------------
 drivers/cpufreq/pcc-cpufreq.c  | 34 +++++++++++++++++++--------
 3 files changed, 86 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 6737b1cbf6d6..9dbd8d855009 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 
 #include <acpi/processor.h>
 
@@ -148,6 +149,34 @@ static int acpi_processor_errata(void)
 	return result;
 }
 
+/* Create a platform device to represent a CPU frequency control mechanism. */
+static void cpufreq_add_device(const char *name)
+{
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_simple(name, PLATFORM_DEVID_NONE, NULL,
+					       0);
+	if (IS_ERR(pdev))
+		pr_err("%s device creation failed: %ld\n", name, PTR_ERR(pdev));
+}
+
+#ifdef CONFIG_X86
+/* Check presence of Processor Clocking Control by searching for \_SB.PCCH. */
+static void __init acpi_pcc_cpufreq_init(void)
+{
+	acpi_status status;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, "\\_SB", &handle);
+	if (ACPI_FAILURE(status))
+		return;
+	if (acpi_has_method(handle, "PCCH"))
+		cpufreq_add_device("pcc-cpufreq");
+}
+#else
+static void __init acpi_pcc_cpufreq_init(void) {}
+#endif /* CONFIG_X86 */
+
 /* Initialization */
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 int __weak acpi_map_cpu(acpi_handle handle,
@@ -280,14 +309,22 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		dev_dbg(&device->dev, "Failed to get CPU physical ID.\n");
 
 	pr->id = acpi_map_cpuid(pr->phys_id, pr->acpi_id);
-	if (!cpu0_initialized && !acpi_has_cpu_in_madt()) {
+	if (!cpu0_initialized) {
 		cpu0_initialized = 1;
 		/*
 		 * Handle UP system running SMP kernel, with no CPU
 		 * entry in MADT
 		 */
-		if (invalid_logical_cpuid(pr->id) && (num_online_cpus() == 1))
+		if (!acpi_has_cpu_in_madt() && invalid_logical_cpuid(pr->id) &&
+		    (num_online_cpus() == 1))
 			pr->id = 0;
+		/*
+		 * Check availability of Processor Performance Control by
+		 * looking at the presence of the _PCT object under the first
+		 * processor definition.
+		 */
+		if (acpi_has_method(pr->handle, "_PCT"))
+			cpufreq_add_device("acpi-cpufreq");
 	}
 
 	/*
@@ -686,6 +723,7 @@ void __init acpi_processor_init(void)
 	acpi_processor_check_duplicates();
 	acpi_scan_add_handler_with_hotplug(&processor_handler, "processor");
 	acpi_scan_add_handler(&processor_container_handler);
+	acpi_pcc_cpufreq_init();
 }
 
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 78adfb2ffff6..e1a5384cf21c 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -965,7 +965,7 @@ static void __init acpi_cpufreq_boost_init(void)
 	acpi_cpufreq_driver.boost_enabled = boost_state(0);
 }
 
-static int __init acpi_cpufreq_init(void)
+static int __init acpi_cpufreq_probe(struct platform_device *pdev)
 {
 	int ret;
 
@@ -1010,13 +1010,32 @@ static int __init acpi_cpufreq_init(void)
 	return ret;
 }
 
-static void __exit acpi_cpufreq_exit(void)
+static int acpi_cpufreq_remove(struct platform_device *pdev)
 {
 	pr_debug("%s\n", __func__);
 
 	cpufreq_unregister_driver(&acpi_cpufreq_driver);
 
 	free_acpi_perf_data();
+
+	return 0;
+}
+
+static struct platform_driver acpi_cpufreq_platdrv = {
+	.driver = {
+		.name	= "acpi-cpufreq",
+	},
+	.remove		= acpi_cpufreq_remove,
+};
+
+static int __init acpi_cpufreq_init(void)
+{
+	return platform_driver_probe(&acpi_cpufreq_platdrv, acpi_cpufreq_probe);
+}
+
+static void __exit acpi_cpufreq_exit(void)
+{
+	platform_driver_unregister(&acpi_cpufreq_platdrv);
 }
 
 module_param(acpi_pstate_strict, uint, 0644);
@@ -1027,18 +1046,4 @@ MODULE_PARM_DESC(acpi_pstate_strict,
 late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
 
-static const struct x86_cpu_id __maybe_unused acpi_cpufreq_ids[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
-	X86_MATCH_FEATURE(X86_FEATURE_HW_PSTATE, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
-
-static const struct acpi_device_id __maybe_unused processor_device_ids[] = {
-	{ACPI_PROCESSOR_OBJECT_HID, },
-	{ACPI_PROCESSOR_DEVICE_HID, },
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, processor_device_ids);
-
-MODULE_ALIAS("acpi");
+MODULE_ALIAS("platform:acpi-cpufreq");
diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 9f3fc7a073d0..0c362932ca60 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -384,7 +384,7 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
 	return ret;
 }
 
-static int __init pcc_cpufreq_probe(void)
+static int __init pcc_cpufreq_evaluate(void)
 {
 	acpi_status status;
 	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -576,7 +576,7 @@ static struct cpufreq_driver pcc_cpufreq_driver = {
 	.name = "pcc-cpufreq",
 };
 
-static int __init pcc_cpufreq_init(void)
+static int __init pcc_cpufreq_probe(struct platform_device *pdev)
 {
 	int ret;
 
@@ -587,9 +587,9 @@ static int __init pcc_cpufreq_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	ret = pcc_cpufreq_probe();
+	ret = pcc_cpufreq_evaluate();
 	if (ret) {
-		pr_debug("pcc_cpufreq_init: PCCH evaluation failed\n");
+		pr_debug("pcc_cpufreq_probe: PCCH evaluation failed\n");
 		return ret;
 	}
 
@@ -607,21 +607,35 @@ static int __init pcc_cpufreq_init(void)
 	return ret;
 }
 
-static void __exit pcc_cpufreq_exit(void)
+static int pcc_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&pcc_cpufreq_driver);
 
 	pcc_clear_mapping();
 
 	free_percpu(pcc_cpu_info);
+
+	return 0;
 }
 
-static const struct acpi_device_id __maybe_unused processor_device_ids[] = {
-	{ACPI_PROCESSOR_OBJECT_HID, },
-	{ACPI_PROCESSOR_DEVICE_HID, },
-	{},
+static struct platform_driver pcc_cpufreq_platdrv = {
+	.driver = {
+		.name	= "pcc-cpufreq",
+	},
+	.remove		= pcc_cpufreq_remove,
 };
-MODULE_DEVICE_TABLE(acpi, processor_device_ids);
+
+static int __init pcc_cpufreq_init(void)
+{
+	return platform_driver_probe(&pcc_cpufreq_platdrv, pcc_cpufreq_probe);
+}
+
+static void __exit pcc_cpufreq_exit(void)
+{
+	platform_driver_unregister(&pcc_cpufreq_platdrv);
+}
+
+MODULE_ALIAS("platform:pcc-cpufreq");
 
 MODULE_AUTHOR("Matthew Garrett, Naga Chumbalkar");
 MODULE_VERSION(PCC_VERSION);
-- 
2.35.3

