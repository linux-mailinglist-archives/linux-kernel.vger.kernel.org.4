Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC77965BF54
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbjACLsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbjACLsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:48:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD09710555;
        Tue,  3 Jan 2023 03:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672746477; x=1704282477;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8dZkxVOI6PyfoIo2vV+E9Vgk67Nph2gFq+gQLmyC8KE=;
  b=a5fmkryapHgJazzLwF1w/1IhEH5jg3G7F2x5+iW67Qp7ZjBdqvw2Q96w
   1SAGRlyNj22fMxyMNphG1l7RZky27LNEg5/Xfs33FqVWO8Ls9qiDLndcz
   /gFyOyw5AsE/IzqccyDU2DC2k/BAW8s+kvmr2KOrx2M43mzvAJHAgT9XI
   8rBZBuA5o5xeWuRVT/vnLJV/xMUztdUYhYfkGUFAyKuRZ60c+zgKdSMDy
   WyLDrW31CzlRebSWSvlPgr0PRRkTNJwuVEXr1FO/Cv9gMHGrMhUqu6eJM
   p0M94yvUmkpND9LsSS4tmCR00Wgcu0t1p3RgsKwrLhBotrL51Lyhcr7jH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="407899903"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="407899903"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 03:47:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="723239138"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="723239138"
Received: from jkrzyszt-mobl1.ger.corp.intel.com (HELO jkrzyszt-mobl1.lan) ([10.213.19.68])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 03:47:32 -0800
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Robin Murphy <robin.murphy@arm.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, regressions@lists.linux.dev
Subject: [PATCH v2] hwmon/coretemp: Simplify platform device handling
Date:   Tue,  3 Jan 2023 12:46:20 +0100
Message-Id: <20230103114620.15319-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

Coretemp's platform driver is unconventional. All the real work is done
globally by the initcall and CPU hotplug notifiers, while the "driver"
effectively just wraps an allocation and the registration of the hwmon
interface in a long-winded round-trip through the driver core.  The whole
logic of dynamically creating and destroying platform devices to bring
the interfaces up and down is error prone, since it assumes
platform_device_add() will synchronously bind the driver and set drvdata
before it returns, thus results in a NULL dereference if drivers_autoprobe
is turned off for the platform bus. Furthermore, the unusual approach of
doing that from within a CPU hotplug notifier, already commented in the
code that it deadlocks suspend, also causes lockdep issues for other
drivers or subsystems which may want to legitimately register a CPU
hotplug notifier from a platform bus notifier.

All of these issues can be solved by ripping this unusual behaviour out
completely, simply tying the platform devices to the lifetime of the
module itself, and directly managing the hwmon interfaces from the
hotplug notifiers. There is a slight user-visible change in that
/sys/bus/platform/drivers/coretemp will no longer appear, and
/sys/devices/platform/coretemp.n will remain present if package n is
hotplugged off, but hwmon users should really only be looking for the
presence of the hwmon interfaces, whose behaviour remains unchanged.

v2: describe the problem in neutral terms

Link: https://lore.kernel.org/lkml/20220922101036.87457-1-janusz.krzysztofik@linux.intel.com/
Link: https://gitlab.freedesktop.org/drm/intel/issues/6641
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/hwmon/coretemp.c | 128 ++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 70 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index ca7a9b373bbd6..3e440ebe2508c 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -588,66 +588,49 @@ static void coretemp_remove_core(struct platform_data *pdata, int indx)
 		ida_free(&pdata->ida, indx - BASE_SYSFS_ATTR_NO);
 }
 
-static int coretemp_probe(struct platform_device *pdev)
+static int coretemp_device_add(int zoneid)
 {
-	struct device *dev = &pdev->dev;
+	struct platform_device *pdev;
 	struct platform_data *pdata;
+	int err;
 
 	/* Initialize the per-zone data structures */
-	pdata = devm_kzalloc(dev, sizeof(struct platform_data), GFP_KERNEL);
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->pkg_id = pdev->id;
+	pdata->pkg_id = zoneid;
 	ida_init(&pdata->ida);
-	platform_set_drvdata(pdev, pdata);
 
-	pdata->hwmon_dev = devm_hwmon_device_register_with_groups(dev, DRVNAME,
-								  pdata, NULL);
-	return PTR_ERR_OR_ZERO(pdata->hwmon_dev);
-}
-
-static int coretemp_remove(struct platform_device *pdev)
-{
-	struct platform_data *pdata = platform_get_drvdata(pdev);
-	int i;
+	pdev = platform_device_alloc(DRVNAME, zoneid);
+	if (!pdev) {
+		err = -ENOMEM;
+		goto err_free_pdata;
+	}
 
-	for (i = MAX_CORE_DATA - 1; i >= 0; --i)
-		if (pdata->core_data[i])
-			coretemp_remove_core(pdata, i);
+	err = platform_device_add(pdev);
+	if (err)
+		goto err_put_dev;
 
-	ida_destroy(&pdata->ida);
+	platform_set_drvdata(pdev, pdata);
+	zone_devices[zoneid] = pdev;
 	return 0;
-}
 
-static struct platform_driver coretemp_driver = {
-	.driver = {
-		.name = DRVNAME,
-	},
-	.probe = coretemp_probe,
-	.remove = coretemp_remove,
-};
+err_put_dev:
+	platform_device_put(pdev);
+err_free_pdata:
+	kfree(pdata);
+	return err;
+}
 
-static struct platform_device *coretemp_device_add(unsigned int cpu)
+static void coretemp_device_remove(int zoneid)
 {
-	int err, zoneid = topology_logical_die_id(cpu);
-	struct platform_device *pdev;
-
-	if (zoneid < 0)
-		return ERR_PTR(-ENOMEM);
-
-	pdev = platform_device_alloc(DRVNAME, zoneid);
-	if (!pdev)
-		return ERR_PTR(-ENOMEM);
-
-	err = platform_device_add(pdev);
-	if (err) {
-		platform_device_put(pdev);
-		return ERR_PTR(err);
-	}
+	struct platform_device *pdev = zone_devices[zoneid];
+	struct platform_data *pdata = platform_get_drvdata(pdev);
 
-	zone_devices[zoneid] = pdev;
-	return pdev;
+	ida_destroy(&pdata->ida);
+	kfree(pdata);
+	platform_device_unregister(pdev);
 }
 
 static int coretemp_cpu_online(unsigned int cpu)
@@ -671,7 +654,10 @@ static int coretemp_cpu_online(unsigned int cpu)
 	if (!cpu_has(c, X86_FEATURE_DTHERM))
 		return -ENODEV;
 
-	if (!pdev) {
+	pdata = platform_get_drvdata(pdev);
+	if (!pdata->hwmon_dev) {
+		struct device *hwmon;
+
 		/* Check the microcode version of the CPU */
 		if (chk_ucode_version(cpu))
 			return -EINVAL;
@@ -682,9 +668,11 @@ static int coretemp_cpu_online(unsigned int cpu)
 		 * online. So, initialize per-pkg data structures and
 		 * then bring this core online.
 		 */
-		pdev = coretemp_device_add(cpu);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		hwmon = hwmon_device_register_with_groups(&pdev->dev, DRVNAME,
+							  pdata, NULL);
+		if (IS_ERR(hwmon))
+			return PTR_ERR(hwmon);
+		pdata->hwmon_dev = hwmon;
 
 		/*
 		 * Check whether pkgtemp support is available.
@@ -694,7 +682,6 @@ static int coretemp_cpu_online(unsigned int cpu)
 			coretemp_add_core(pdev, cpu, 1);
 	}
 
-	pdata = platform_get_drvdata(pdev);
 	/*
 	 * Check whether a thread sibling is already online. If not add the
 	 * interface for this CPU core.
@@ -713,18 +700,14 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	struct temp_data *tdata;
 	int i, indx = -1, target;
 
-	/*
-	 * Don't execute this on suspend as the device remove locks
-	 * up the machine.
-	 */
+	/* No need to tear down any interfaces for suspend */
 	if (cpuhp_tasks_frozen)
 		return 0;
 
 	/* If the physical CPU device does not exist, just return */
-	if (!pdev)
-		return 0;
-
 	pd = platform_get_drvdata(pdev);
+	if (!pd->hwmon_dev)
+		return 0;
 
 	for (i = 0; i < NUM_REAL_CORES; i++) {
 		if (pd->cpu_map[i] == topology_core_id(cpu)) {
@@ -756,13 +739,14 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	}
 
 	/*
-	 * If all cores in this pkg are offline, remove the device. This
-	 * will invoke the platform driver remove function, which cleans up
-	 * the rest.
+	 * If all cores in this pkg are offline, remove the interface.
 	 */
+	tdata = pd->core_data[PKG_SYSFS_ATTR_NO];
 	if (cpumask_empty(&pd->cpumask)) {
-		zone_devices[topology_logical_die_id(cpu)] = NULL;
-		platform_device_unregister(pdev);
+		if (tdata)
+			coretemp_remove_core(pd, PKG_SYSFS_ATTR_NO);
+		hwmon_device_unregister(pd->hwmon_dev);
+		pd->hwmon_dev = NULL;
 		return 0;
 	}
 
@@ -770,7 +754,6 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 * Check whether this core is the target for the package
 	 * interface. We need to assign it to some other cpu.
 	 */
-	tdata = pd->core_data[PKG_SYSFS_ATTR_NO];
 	if (tdata && tdata->cpu == cpu) {
 		target = cpumask_first(&pd->cpumask);
 		mutex_lock(&tdata->update_lock);
@@ -789,7 +772,7 @@ static enum cpuhp_state coretemp_hp_online;
 
 static int __init coretemp_init(void)
 {
-	int err;
+	int i, err;
 
 	/*
 	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
@@ -805,20 +788,22 @@ static int __init coretemp_init(void)
 	if (!zone_devices)
 		return -ENOMEM;
 
-	err = platform_driver_register(&coretemp_driver);
-	if (err)
-		goto outzone;
+	for (i = 0; i < max_zones; i++) {
+		err = coretemp_device_add(i);
+		if (err)
+			goto outzone;
+	}
 
 	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hwmon/coretemp:online",
 				coretemp_cpu_online, coretemp_cpu_offline);
 	if (err < 0)
-		goto outdrv;
+		goto outzone;
 	coretemp_hp_online = err;
 	return 0;
 
-outdrv:
-	platform_driver_unregister(&coretemp_driver);
 outzone:
+	while (i--)
+		coretemp_device_remove(i);
 	kfree(zone_devices);
 	return err;
 }
@@ -826,8 +811,11 @@ module_init(coretemp_init)
 
 static void __exit coretemp_exit(void)
 {
+	int i;
+
 	cpuhp_remove_state(coretemp_hp_online);
-	platform_driver_unregister(&coretemp_driver);
+	for (i = 0; i < max_zones; i++)
+		coretemp_device_remove(i);
 	kfree(zone_devices);
 }
 module_exit(coretemp_exit)
-- 
2.25.1

