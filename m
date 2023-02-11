Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FF8692EBD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBKGe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjBKGeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:34:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3184BAF;
        Fri, 10 Feb 2023 22:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676097217; x=1707633217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GichFD27YyhQppdvaJp3UuTTE+SAB287jijQOETfxAE=;
  b=byexQ/FJqLM4+5KTJIpF76+ZGf1BCKzMw3OWC6A9HqD3u5cwuMGNjCSW
   OX0eo0YBsU3dSAvqlYhBmk4pehnkrx2VlRe/acLDr7NT9Lsq9/mi3qtBR
   bJk2OiP5FgQppAMg/+aoLwV1NLt9kYVNyau/MajEMVlsHREaT3NK1xmnd
   gjMSO68XHYVm76fFr7VnPJq51dkxt5JITwNC6fyBSQEZ59KhpyN69RJKu
   VwY+iu1PbadvElHKC1n+i+pVRpY3qDhBniOh5nJ4q8GsZJqg3cucLmGU/
   8RMG4eAJcAGuDx+XLGS5oRcObZrGFcxyyb7F/6ZwrhUuFgbdXoO/iXNmG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310223228"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="310223228"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 22:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997171782"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="997171782"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 22:33:05 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 12/12] platform/x86: ISST: Add suspend/resume callbacks
Date:   Fri, 10 Feb 2023 22:32:57 -0800
Message-Id: <20230211063257.311746-13-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
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

To support S3/S4 with TPMI interface add suspend/resume callbacks.
Here HW state is stored in suspend callback and restored during
resume callback.

The hardware state which needs to be stored/restored:
- CLOS configuration
- CLOS Association
- SST-CP enable/disable status
- SST-PP perf level setting

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel/speed_select_if/isst_tpmi.c     | 21 ++++++++
 .../intel/speed_select_if/isst_tpmi_core.c    | 49 +++++++++++++++++++
 .../intel/speed_select_if/isst_tpmi_core.h    |  2 +
 3 files changed, 72 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
index 7b4bdeefb8bc..ef39870c9829 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
@@ -34,6 +34,24 @@ static void intel_sst_remove(struct auxiliary_device *auxdev)
 	tpmi_sst_exit();
 }
 
+static int __maybe_unused intel_sst_suspend(struct device *dev)
+{
+	tpmi_sst_dev_suspend(to_auxiliary_dev(dev));
+
+	return 0;
+}
+
+static int __maybe_unused intel_sst_resume(struct device *dev)
+{
+	tpmi_sst_dev_resume(to_auxiliary_dev(dev));
+
+	return 0;
+}
+
+static const struct dev_pm_ops intel_sst_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(intel_sst_suspend, intel_sst_resume)
+};
+
 static const struct auxiliary_device_id intel_sst_id_table[] = {
 	{ .name = "intel_vsec.tpmi-sst" },
 	{}
@@ -44,6 +62,9 @@ static struct auxiliary_driver intel_sst_aux_driver = {
 	.id_table       = intel_sst_id_table,
 	.remove         = intel_sst_remove,
 	.probe          = intel_sst_probe,
+	.driver = {
+		.pm = &intel_sst_pm,
+	},
 };
 
 module_auxiliary_driver(intel_sst_aux_driver);
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 9eaff90bb649..e173167085ea 100644
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
2.39.1

