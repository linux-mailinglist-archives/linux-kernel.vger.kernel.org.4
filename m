Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C0C6246BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiKJQUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiKJQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:20:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 037841B1D6;
        Thu, 10 Nov 2022 08:20:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8EFD1FB;
        Thu, 10 Nov 2022 08:20:37 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82FD63F703;
        Thu, 10 Nov 2022 08:20:30 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, janusz.krzysztofik@linux.intel.com,
        lucas.demarchi@intel.com
Subject: [PATCH] hwmon/coretemp: Simplify platform device antics
Date:   Thu, 10 Nov 2022 16:20:25 +0000
Message-Id: <898dbb76a54aae6ca58ceefcab9ab18beeee2fff.1668096928.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coretemp's vestigial platform driver is odd. All the real work is done
globally by the initcall and CPU hotplug notifiers, while the "driver"
effectively just wraps an allocation and the registration of the hwmon
interface in a long-winded round-trip through the driver core. The whole
logic of dynamically creating and destroying platform devices to bring
the interfaces up and down is fatally flawed right away, since it
assumes platform_device_add() will synchronously bind the driver and set
drvdata before it returns, thus results in a NULL dereference if
drivers_autoprobe is turned off for the platform bus. Furthermore, the
unusual approach of doing that from within a CPU hotplug notifier is
also problematic. It's already commented in the code that it deadlocks
suspend, but it also causes lockdep issues for other drivers or
subsystems which may want to legitimately register a CPU hotplug
notifier from a platform bus notifier.

All of these issues can be solved by ripping this questionable behaviour
out completely, simply tying the platform devices to the lifetime of the
module itself, and directly managing the hwmon interfaces from the
hotplug notifiers. There is a slight user-visible change in that
/sys/bus/platform/drivers/coretemp will no longer appear, and
/sys/devices/platform/coretemp.n will remain present if package n is
hotplugged off, but hwmon users should really only be looking for the
presence of the hwmon interfaces, whose behaviour remains unchanged.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

I haven't been able to fully test hotplug since I only have a
single-socket Intel system to hand.

 drivers/hwmon/coretemp.c | 134 ++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 73 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 8bf32c6c85d9..9fa68a81625e 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -543,66 +543,49 @@ static void coretemp_remove_core(struct platform_data *pdata, int indx)
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
-
-	pdata->hwmon_dev = devm_hwmon_device_register_with_groups(dev, DRVNAME,
-								  pdata, NULL);
-	return PTR_ERR_OR_ZERO(pdata->hwmon_dev);
-}
-
-static int coretemp_remove(struct platform_device *pdev)
-{
-	struct platform_data *pdata = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = MAX_CORE_DATA - 1; i >= 0; --i)
-		if (pdata->core_data[i])
-			coretemp_remove_core(pdata, i);
-
-	ida_destroy(&pdata->ida);
-	return 0;
-}
-
-static struct platform_driver coretemp_driver = {
-	.driver = {
-		.name = DRVNAME,
-	},
-	.probe = coretemp_probe,
-	.remove = coretemp_remove,
-};
-
-static struct platform_device *coretemp_device_add(unsigned int cpu)
-{
-	int err, zoneid = topology_logical_die_id(cpu);
-	struct platform_device *pdev;
-
-	if (zoneid < 0)
-		return ERR_PTR(-ENOMEM);
 
 	pdev = platform_device_alloc(DRVNAME, zoneid);
-	if (!pdev)
-		return ERR_PTR(-ENOMEM);
-
-	err = platform_device_add(pdev);
-	if (err) {
-		platform_device_put(pdev);
-		return ERR_PTR(err);
+	if (!pdev) {
+		err = -ENOMEM;
+		goto err_free_pdata;
 	}
 
+	err = platform_device_add(pdev);
+	if (err)
+		goto err_put_dev;
+
+	platform_set_drvdata(pdev, pdata);
 	zone_devices[zoneid] = pdev;
-	return pdev;
+	return 0;
+
+err_put_dev:
+	platform_device_put(pdev);
+err_free_pdata:
+	kfree(pdata);
+	return err;
+}
+
+static void coretemp_device_remove(int zoneid)
+{
+	struct platform_device *pdev = zone_devices[zoneid];
+	struct platform_data *pdata = platform_get_drvdata(pdev);
+
+	ida_destroy(&pdata->ida);
+	kfree(pdata);
+	platform_device_unregister(pdev);
 }
 
 static int coretemp_cpu_online(unsigned int cpu)
@@ -626,7 +609,10 @@ static int coretemp_cpu_online(unsigned int cpu)
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
@@ -637,9 +623,11 @@ static int coretemp_cpu_online(unsigned int cpu)
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
@@ -649,7 +637,6 @@ static int coretemp_cpu_online(unsigned int cpu)
 			coretemp_add_core(pdev, cpu, 1);
 	}
 
-	pdata = platform_get_drvdata(pdev);
 	/*
 	 * Check whether a thread sibling is already online. If not add the
 	 * interface for this CPU core.
@@ -668,18 +655,14 @@ static int coretemp_cpu_offline(unsigned int cpu)
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
@@ -711,13 +694,14 @@ static int coretemp_cpu_offline(unsigned int cpu)
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
 
@@ -725,7 +709,6 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 * Check whether this core is the target for the package
 	 * interface. We need to assign it to some other cpu.
 	 */
-	tdata = pd->core_data[PKG_SYSFS_ATTR_NO];
 	if (tdata && tdata->cpu == cpu) {
 		target = cpumask_first(&pd->cpumask);
 		mutex_lock(&tdata->update_lock);
@@ -744,7 +727,7 @@ static enum cpuhp_state coretemp_hp_online;
 
 static int __init coretemp_init(void)
 {
-	int err;
+	int i, err;
 
 	/*
 	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
@@ -760,20 +743,22 @@ static int __init coretemp_init(void)
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
@@ -781,8 +766,11 @@ module_init(coretemp_init)
 
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
2.36.1.dirty

