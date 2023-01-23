Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E775678175
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjAWQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAWQa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:30:58 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733CD29E0F;
        Mon, 23 Jan 2023 08:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674491457; x=1706027457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3XjT1Rd6YFhugKX8f0xdY/kqfnqSuJ54Immi5pga/EU=;
  b=CXDqZSQrWfafafBjBEZYKNyq5/PkleDgeY9Ew4MbxezOT0wrGrXxEiou
   dSmVx1NehIO24f6VM28+QgQ2g/NKQFnMRbGWU4kMPhp+GEz08lBvOfLjO
   bTrWqX6LF1mYRkIIpqDIL3HQy5edPq5DQ6/8IPWW4KRKn6oL4a0T3o35S
   H9/X/G0aohje3AspGfxqKGNxGPSdnG73wZoxq8kAtW6CDOY9TpJXSiYpm
   hl2BbF7bbE0fqyfc4nozXZnAUDBUHgUPG7DsX7ojQeZFgOaj2LYlFgJKF
   jz5hd2IhmtNAc4MiGmYZbnk9ozlCTrKqohSXSwSKfK6F25lFNQsArjNdu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="388433210"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="388433210"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 08:30:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="639236200"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="639236200"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006.jf.intel.com with ESMTP; 23 Jan 2023 08:30:56 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] thermal: int340x_thermal: Add production mode attribute
Date:   Mon, 23 Jan 2023 08:30:46 -0800
Message-Id: <20230123163046.358879-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
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

It is possible that the system manufacturer locks down thermal tuning
beyond what is usually done on the given platform. In that case user
space calibration tools should not try to adjust the thermal
configuration of the system.

To allow user space to check if that is the case, add a new sysfs
attribute "production_mode" that will be present when the ACPI DCFG
method is present under the INT3400 device object in the ACPI Namespace.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3:
Build warning reported by for missing static
Reported-by: kernel test robot <lkp@intel.com>

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
index db8a6f63657d..23ea21238bbd 100644
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
+static void production_mode_exit(struct int3400_thermal_priv *priv)
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

