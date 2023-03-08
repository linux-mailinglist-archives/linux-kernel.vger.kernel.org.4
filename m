Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37056AFF77
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCHHHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCHHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:06:54 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB42A335F;
        Tue,  7 Mar 2023 23:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678259208; x=1709795208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qwn8Bd8rwa4fZVbxslD5uKPXHgCW84xGABQ3xPxzrOo=;
  b=O1rhYazCHDBk5Qe15ZifHAwxgzFpzZ1meinFcf+8LR7jyytAnVOIxlDY
   iVav+XU9ctruPJHRBZr9EmnAcoE+9jVchbT2AjfDMR2TmoK33xFJcFI1m
   3+S5dSZK6lyWm55NzCQ4aMPYacF51EUHr/KLSlWrwonCoh58ZFJd3d4s8
   ohrhVdLUFdL+GMw0FdJa3rG/ACbg0aZXfs8nmn67fn55C29G/zckxcN4R
   rrhTsxN1siabZpTGZY6DBDlXVOKF29/6PBxu4buyOl/9LzixUnG5WujEl
   kvFMJS+5uJ8odYDjnu5X3WsdL0sGScwtM0o+BfLR2Pyjmj63unZeYnFjz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333553988"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="333553988"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="850986399"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="850986399"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2023 23:06:44 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Pragya Tanwar <pragya.tanwar@intel.com>
Subject: [PATCH v2 8/8] platform/x86: ISST: Add suspend/resume callbacks
Date:   Tue,  7 Mar 2023 23:06:42 -0800
Message-Id: <20230308070642.1727167-9-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230308070642.1727167-1-srinivas.pandruvada@linux.intel.com>
References: <20230308070642.1727167-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support S3/S4 with TPMI interface add suspend/resume callbacks.
Here HW state is stored in suspend callback and restored during
resume callback.

The hardware state which needs to be stored/restored:
- CLOS configuration
- CLOS Association
- SST-CP enable/disable status
- SST-PP perf level setting

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Pragya Tanwar <pragya.tanwar@intel.com>
---
v2:
- As suggested by Hans, modified suspend/resume callbacks

 .../x86/intel/speed_select_if/isst_tpmi.c     | 19 +++++++
 .../intel/speed_select_if/isst_tpmi_core.c    | 49 +++++++++++++++++++
 .../intel/speed_select_if/isst_tpmi_core.h    |  2 +
 3 files changed, 70 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
index 7b4bdeefb8bc..17972191538a 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
@@ -34,6 +34,22 @@ static void intel_sst_remove(struct auxiliary_device *auxdev)
 	tpmi_sst_exit();
 }
 
+static int intel_sst_suspend(struct device *dev)
+{
+	tpmi_sst_dev_suspend(to_auxiliary_dev(dev));
+
+	return 0;
+}
+
+static int intel_sst_resume(struct device *dev)
+{
+	tpmi_sst_dev_resume(to_auxiliary_dev(dev));
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(intel_sst_pm, intel_sst_suspend, intel_sst_resume);
+
 static const struct auxiliary_device_id intel_sst_id_table[] = {
 	{ .name = "intel_vsec.tpmi-sst" },
 	{}
@@ -44,6 +60,9 @@ static struct auxiliary_driver intel_sst_aux_driver = {
 	.id_table       = intel_sst_id_table,
 	.remove         = intel_sst_remove,
 	.probe          = intel_sst_probe,
+	.driver = {
+		.pm = pm_sleep_ptr(&intel_sst_pm),
+	},
 };
 
 module_auxiliary_driver(intel_sst_aux_driver);
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 5104717afe0e..cdb56a18ea17 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -229,6 +229,10 @@ struct perf_level {
  * @status_offset:	Store the status offset for each PP-level
  * @sst_base:		Mapped SST base IO memory
  * @auxdev:		Auxiliary device instance enumerated this instance
+ * @saved_sst_cp_control: Save SST-CP control configuration to store restore for suspend/resume
+ * @saved_clos_configs:	Save SST-CP CLOS configuration to store restore for suspend/resume
+ * @saved_clos_assocs:	Save SST-CP CLOS association to store restore for suspend/resume
+ * @saved_pp_control:	Save SST-PP control information to store restore for suspend/resume
  *
  * This structure is used store complete SST information for a power_domain. This information
  * is used to read/write request for any SST IOCTL. Each physical CPU package can have multiple
@@ -250,6 +254,10 @@ struct tpmi_per_power_domain_info {
 	struct pp_status_offset status_offset;
 	void __iomem *sst_base;
 	struct auxiliary_device *auxdev;
+	u64 saved_sst_cp_control;
+	u64 saved_clos_configs[4];
+	u64 saved_clos_assocs[4];
+	u64 saved_pp_control;
 };
 
 /**
@@ -1333,6 +1341,47 @@ void tpmi_sst_dev_remove(struct auxiliary_device *auxdev)
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_remove, INTEL_TPMI_SST);
 
+void tpmi_sst_dev_suspend(struct auxiliary_device *auxdev)
+{
+	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
+	struct tpmi_per_power_domain_info *power_domain_info = tpmi_sst->power_domain_info;
+	void __iomem *cp_base;
+
+	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
+	power_domain_info->saved_sst_cp_control = readq(cp_base + SST_CP_CONTROL_OFFSET);
+
+	memcpy_fromio(power_domain_info->saved_clos_configs, cp_base + SST_CLOS_CONFIG_0_OFFSET,
+		      sizeof(power_domain_info->saved_clos_configs));
+
+	memcpy_fromio(power_domain_info->saved_clos_assocs, cp_base + SST_CLOS_ASSOC_0_OFFSET,
+		      sizeof(power_domain_info->saved_clos_assocs));
+
+	power_domain_info->saved_pp_control = readq(power_domain_info->sst_base +
+						    power_domain_info->sst_header.pp_offset +
+						    SST_PP_CONTROL_OFFSET);
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_suspend, INTEL_TPMI_SST);
+
+void tpmi_sst_dev_resume(struct auxiliary_device *auxdev)
+{
+	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
+	struct tpmi_per_power_domain_info *power_domain_info = tpmi_sst->power_domain_info;
+	void __iomem *cp_base;
+
+	cp_base = power_domain_info->sst_base + power_domain_info->sst_header.cp_offset;
+	writeq(power_domain_info->saved_sst_cp_control, cp_base + SST_CP_CONTROL_OFFSET);
+
+	memcpy_toio(cp_base + SST_CLOS_CONFIG_0_OFFSET, power_domain_info->saved_clos_configs,
+		    sizeof(power_domain_info->saved_clos_configs));
+
+	memcpy_toio(cp_base + SST_CLOS_ASSOC_0_OFFSET, power_domain_info->saved_clos_assocs,
+		    sizeof(power_domain_info->saved_clos_assocs));
+
+	writeq(power_domain_info->saved_pp_control, power_domain_info->sst_base +
+				power_domain_info->sst_header.pp_offset + SST_PP_CONTROL_OFFSET);
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_resume, INTEL_TPMI_SST);
+
 #define ISST_TPMI_API_VERSION	0x02
 
 int tpmi_sst_init(void)
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
index 356cb02273b1..900b483703f9 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
@@ -13,4 +13,6 @@ int tpmi_sst_init(void);
 void tpmi_sst_exit(void);
 int tpmi_sst_dev_add(struct auxiliary_device *auxdev);
 void tpmi_sst_dev_remove(struct auxiliary_device *auxdev);
+void tpmi_sst_dev_suspend(struct auxiliary_device *auxdev);
+void tpmi_sst_dev_resume(struct auxiliary_device *auxdev);
 #endif
-- 
2.34.1

