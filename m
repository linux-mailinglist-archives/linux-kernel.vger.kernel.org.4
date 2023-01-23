Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A262C677429
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 03:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjAWCkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 21:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWCkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 21:40:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C416AC7;
        Sun, 22 Jan 2023 18:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674441648; x=1705977648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=20YoAJBsfKQs4Tqyxmb6fWD2mvcnbkiw1ELR3Ly2kBU=;
  b=JeEiG3cZCC7dgoRXbr2heoy6N0u8QK6yI0Ac93xDCnVNuTROyvYS1sWG
   eVa8nD6PVaPgHrYWMkw9WHrO/byJcBEE0uGOufpNO85eJk3JuqMmgkCKu
   oUzugkPd93vEbMXsvpHP/BdwzH2TQ6HGbrVa9XoN0NsOFpoA7oWR4R+dt
   r4Z1I0dzgQlAU8Oo8u40KItNRD8/zNiPy0O/EUDei//d36FH7a0rKUib3
   hRdzi/Dm1g8+GkYoM9eQDzu/p+GgNgQguQPiSjFrhrFX5wDHOItOKsNfm
   OZYymmqzvJmTjEI8a/5CEocTMXJ6SqJSkKZqVXv1t2aZAWSdGncEVFCcc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="305623784"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="305623784"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 18:40:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="785437669"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="785437669"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga004.jf.intel.com with ESMTP; 22 Jan 2023 18:40:47 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] thermal: int340x_thermal: Add production mode attribute
Date:   Sun, 22 Jan 2023 18:40:40 -0800
Message-Id: <20230123024040.337866-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that the system manufacturer locks down thermal tuning
beyond what is usually done on the given platform. In that case user
space calibration tools should not try to adjust the thermal
configuration of the system.

To allow user space to check if that is the case, add a new sysfs
attribute "production_mode" that will be present when the ACPI DCFG
method is present under the INT3400 device object in the ACPI Namespace.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
Addressed comments from Rafael:
- Updated commit excatly same as Rafael wrote
- Removed production_mode_support bool
- Use sysfs_emit
- Update documentation

 .../driver-api/thermal/intel_dptf.rst         |  3 ++
 .../intel/int340x_thermal/int3400_thermal.c   | 48 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index 372bdb4d04c6..f5c193cccbda 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -84,6 +84,9 @@ DPTF ACPI Drivers interface
 	https:/github.com/intel/thermal_daemon for decoding
 	thermal table.
 
+``production_mode`` (RO)
+	When different from zero, manufacturer locked thermal configuration
+	from further changes.
 
 ACPI Thermal Relationship table interface
 ------------------------------------------
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index db8a6f63657d..326f493b9c91 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -60,6 +60,7 @@ struct int3400_thermal_priv {
 	int odvp_count;
 	int *odvp;
 	u32 os_uuid_mask;
+	int production_mode;
 	struct odvp_attr *odvp_attrs;
 };
 
@@ -315,6 +316,44 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
 	return result;
 }
 
+static ssize_t production_mode_show(struct device *dev, struct device_attribute *attr,
+				     char *buf)
+{
+	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", priv->production_mode);
+}
+
+static DEVICE_ATTR_RO(production_mode);
+
+static int production_mode_init(struct int3400_thermal_priv *priv)
+{
+	unsigned long long mode;
+	acpi_status status;
+	int ret;
+
+	priv->production_mode = -1;
+
+	status = acpi_evaluate_integer(priv->adev->handle, "DCFG", NULL, &mode);
+	/* If the method is not present, this is not an error */
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	ret = sysfs_create_file(&priv->pdev->dev.kobj, &dev_attr_production_mode.attr);
+	if (ret)
+		return ret;
+
+	priv->production_mode = mode;
+
+	return 0;
+}
+
+void production_mode_exit(struct int3400_thermal_priv *priv)
+{
+	if (priv->production_mode >= 0)
+		sysfs_remove_file(&priv->pdev->dev.kobj, &dev_attr_production_mode.attr);
+}
+
 static ssize_t odvp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -610,8 +649,15 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (result)
 		goto free_sysfs;
 
+	result = production_mode_init(priv);
+	if (result)
+		goto free_notify;
+
 	return 0;
 
+free_notify:
+	acpi_remove_notify_handler(priv->adev->handle, ACPI_DEVICE_NOTIFY,
+				   int3400_notify);
 free_sysfs:
 	cleanup_odvp(priv);
 	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
@@ -638,6 +684,8 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 {
 	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
 
+	production_mode_exit(priv);
+
 	acpi_remove_notify_handler(
 			priv->adev->handle, ACPI_DEVICE_NOTIFY,
 			int3400_notify);
-- 
2.31.1

