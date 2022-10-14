Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518415FEB42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiJNI7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJNI7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:59:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9218114EC6A;
        Fri, 14 Oct 2022 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665737954; x=1697273954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tT6GsCkKtFxZFwU3AnqBEMCkEq36qH77xhPKht8kymI=;
  b=VSyHKXHKHsWSC6w3OMMGUCCz03zvc8G5mSa3gpZlx3XTvZ2qr2eLsGab
   s7+depnHuiFLxVysbSsCrZ/Cuz21Hcwf2SMK6fQCa2qtq0+fy7hAVx6g4
   VtRutGNl0D2nLaI5vCPDqIJR7rZnoGLwAnCLsTNj9C0w4tTS3ir82Vjip
   3AMOFTZ7NhZRMNu05SQkxeXT5iBNB/CgoKTHsk+7dxMbJpkbV3n9E2Bfo
   +RJ5RUgGknFeLk31x/h65cdmybfNy7oc9AG97kmv226oC3hlbX1q8D0Z6
   SVkH6pM/N301sFzUrrJiXho81zGqgBSVl5Wwtfmm6Il1ltNLzKWGtzTzI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="391635374"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="391635374"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 01:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="696234521"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="696234521"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2022 01:59:11 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        jdelvare@suse.com, linux@roeck-us.net, len.brown@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V4 2/4] hwmon/coretemp: Handle large core ID value
Date:   Fri, 14 Oct 2022 17:01:45 +0800
Message-Id: <20221014090147.1836-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221014090147.1836-1-rui.zhang@intel.com>
References: <20221014090147.1836-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coretemp driver supports up to a hard-coded limit of 128 cores.

Today, the driver can not support a core with an ID above that limit.
Yet, the encoding of core ID's is arbitrary (BIOS APIC-ID) and so they
may be sparse and they may be large.

Update the driver to map arbitrary core ID numbers into appropriate
array indexes so that 128 cores can be supported, no matter the encoding
of core ID's.

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Len Brown <len.brown@intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c | 56 +++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index bfdcfe8ccb34..291566aeb703 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -46,9 +46,6 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
 
-#define TO_CORE_ID(cpu)		(cpu_data(cpu).cpu_core_id)
-#define TO_ATTR_NO(cpu)		(TO_CORE_ID(cpu) + BASE_SYSFS_ATTR_NO)
-
 #ifdef CONFIG_SMP
 #define for_each_sibling(i, cpu) \
 	for_each_cpu(i, topology_sibling_cpumask(cpu))
@@ -91,6 +88,8 @@ struct temp_data {
 struct platform_data {
 	struct device		*hwmon_dev;
 	u16			pkg_id;
+	u16			cpu_map[NUM_REAL_CORES];
+	struct ida		ida;
 	struct cpumask		cpumask;
 	struct temp_data	*core_data[MAX_CORE_DATA];
 	struct device_attribute name_attr;
@@ -441,7 +440,7 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
 							MSR_IA32_THERM_STATUS;
 	tdata->is_pkg_data = pkg_flag;
 	tdata->cpu = cpu;
-	tdata->cpu_core_id = TO_CORE_ID(cpu);
+	tdata->cpu_core_id = topology_core_id(cpu);
 	tdata->attr_size = MAX_CORE_ATTRS;
 	mutex_init(&tdata->update_lock);
 	return tdata;
@@ -454,7 +453,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	u32 eax, edx;
-	int err, attr_no;
+	int err, index, attr_no;
 
 	/*
 	 * Find attr number for sysfs:
@@ -462,14 +461,26 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	 * The attr number is always core id + 2
 	 * The Pkgtemp will always show up as temp1_*, if available
 	 */
-	attr_no = pkg_flag ? PKG_SYSFS_ATTR_NO : TO_ATTR_NO(cpu);
+	if (pkg_flag) {
+		attr_no = PKG_SYSFS_ATTR_NO;
+	} else {
+		index = ida_alloc(&pdata->ida, GFP_KERNEL);
+		if (index < 0)
+			return index;
+		pdata->cpu_map[index] = topology_core_id(cpu);
+		attr_no = index + BASE_SYSFS_ATTR_NO;
+	}
 
-	if (attr_no > MAX_CORE_DATA - 1)
-		return -ERANGE;
+	if (attr_no > MAX_CORE_DATA - 1) {
+		err = -ERANGE;
+		goto ida_free;
+	}
 
 	tdata = init_temp_data(cpu, pkg_flag);
-	if (!tdata)
-		return -ENOMEM;
+	if (!tdata) {
+		err = -ENOMEM;
+		goto ida_free;
+	}
 
 	/* Test if we can access the status register */
 	err = rdmsr_safe_on_cpu(cpu, tdata->status_reg, &eax, &edx);
@@ -505,6 +516,9 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 exit_free:
 	pdata->core_data[attr_no] = NULL;
 	kfree(tdata);
+ida_free:
+	if (!pkg_flag)
+		ida_free(&pdata->ida, index);
 	return err;
 }
 
@@ -524,6 +538,9 @@ static void coretemp_remove_core(struct platform_data *pdata, int index)
 
 	kfree(pdata->core_data[index]);
 	pdata->core_data[index] = NULL;
+
+	if (index >= BASE_SYSFS_ATTR_NO)
+		ida_free(&pdata->ida, index - BASE_SYSFS_ATTR_NO);
 }
 
 static int coretemp_probe(struct platform_device *pdev)
@@ -537,6 +554,7 @@ static int coretemp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pdata->pkg_id = pdev->id;
+	ida_init(&pdata->ida);
 	platform_set_drvdata(pdev, pdata);
 
 	pdata->hwmon_dev = devm_hwmon_device_register_with_groups(dev, DRVNAME,
@@ -553,6 +571,7 @@ static int coretemp_remove(struct platform_device *pdev)
 		if (pdata->core_data[i])
 			coretemp_remove_core(pdata, i);
 
+	ida_destroy(&pdata->ida);
 	return 0;
 }
 
@@ -647,7 +666,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	struct platform_device *pdev = coretemp_get_pdev(cpu);
 	struct platform_data *pd;
 	struct temp_data *tdata;
-	int index, target;
+	int i, index = -1, target;
 
 	/*
 	 * Don't execute this on suspend as the device remove locks
@@ -660,12 +679,19 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	if (!pdev)
 		return 0;
 
-	/* The core id is too big, just return */
-	index = TO_ATTR_NO(cpu);
-	if (index > MAX_CORE_DATA - 1)
+	pd = platform_get_drvdata(pdev);
+
+	for (i = 0; i < NUM_REAL_CORES; i++) {
+		if (pd->cpu_map[i] == topology_core_id(cpu)) {
+			index = i + BASE_SYSFS_ATTR_NO;
+			break;
+		}
+	}
+
+	/* Too many cores and this core is not populated, just return */
+	if (index < 0)
 		return 0;
 
-	pd = platform_get_drvdata(pdev);
 	tdata = pd->core_data[index];
 
 	cpumask_clear_cpu(cpu, &pd->cpumask);
-- 
2.25.1

