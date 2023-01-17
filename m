Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E366E412
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjAQQuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjAQQud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:50:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE1212F2F;
        Tue, 17 Jan 2023 08:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673974232; x=1705510232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D/hQ52k01Iqixqps9WlZErrx2s7zv8CoaISCEZlZo9g=;
  b=AdFjiF+BLeA3DH+LFYoSTaNWCBpU1aQX/cohRQYyes/jW9ka7CUO/DnZ
   NszKXQ9IyxQjUIlxhUNPc0ycDDnfAXpy7Hzulep56sgKudw6hmli8thrj
   Ou30K8j7Iic8Z60Tt5uiPsAN+9LKWLo6q/DXnzJ5Fl4kufKxT2tcAATPJ
   ijP3w4fZ2H34X7Nwml9aJXIayAIkpz+5sMRvaNMIfcD7dSzwuU1LWZLbC
   tqKHIOqFRxgIOGNhd2BJkPRGQeB647MZmKoUINuMblhsZ3Q31k/fIiYRc
   kNFyEDrQpuLmY7v8wSA+d7BukF7yECfT3O9i89EShHCAtT/gbniRpkpeW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="389246831"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="389246831"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:50:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="748097485"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="748097485"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jan 2023 08:50:31 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x_thermal: Add production mode attribute
Date:   Tue, 17 Jan 2023 08:50:29 -0800
Message-Id: <20230117165029.2782484-1-srinivas.pandruvada@linux.intel.com>
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

It is possible that system manufacturer locks further thermal tuning. In
this case user space calibration tools should not try to adjust thermal
configuration.

Add an attribute "production_mode". This attribute is only present when
the ACPI DCFG method is present under INT3400 device scope.

When DCFG evaluates to non 0, user space configuration tools should exit.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../driver-api/thermal/intel_dptf.rst         |  4 ++
 .../intel/int340x_thermal/int3400_thermal.c   | 48 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index 372bdb4d04c6..9a7b651ba764 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -84,6 +84,10 @@ DPTF ACPI Drivers interface
 	https:/github.com/intel/thermal_daemon for decoding
 	thermal table.
 
+``production_mode`` (RO)
+	When non zero, manufacturer locked thermal configuration from
+	further changes.
+
 
 ACPI Thermal Relationship table interface
 ------------------------------------------
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index db8a6f63657d..ec5ec07ccf41 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -60,6 +60,8 @@ struct int3400_thermal_priv {
 	int odvp_count;
 	int *odvp;
 	u32 os_uuid_mask;
+	int production_mode;
+	bool production_mode_support;
 	struct odvp_attr *odvp_attrs;
 };
 
@@ -315,6 +317,43 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
 	return result;
 }
 
+static ssize_t production_mode_show(struct device *dev, struct device_attribute *attr,
+				     char *buf)
+{
+	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", priv->production_mode);
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
+	status = acpi_evaluate_integer(priv->adev->handle, "DCFG", NULL, &mode);
+	/* If the method is not present, this is not an error */
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	ret = sysfs_create_file(&priv->pdev->dev.kobj, &dev_attr_production_mode.attr);
+	if (ret)
+		return ret;
+
+	priv->production_mode_support = true;
+	priv->production_mode = mode;
+
+	return 0;
+}
+
+void production_mode_exit(struct int3400_thermal_priv *priv)
+{
+	if (priv->production_mode_support)
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

