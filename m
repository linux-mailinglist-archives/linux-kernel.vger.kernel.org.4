Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD336D2646
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjCaQy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjCaQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:54:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251F72688;
        Fri, 31 Mar 2023 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680281619; x=1711817619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=maGKeUkvCQI8zY1Lp+jGdEdPFdmHPUreRuRmB/aQUGQ=;
  b=Axwt7v1bacNC4I4eEzT9kVjdWHmVjX53bORqKdEfK0l3qLb5cHPBNNXz
   ILOV86PJZvpx0X8y3XZQUKPVg951eLHtscb3SEK5rqOO3pTAyx9JLOGb3
   Swl22MSC09zOrqzo6oslcnbbJo4mZBFencpa6NTjgXc2rkcgM8mAJZYKe
   NHpfNa+Fqsj8yXN68/8qS4uywsWDEwMaTmWFkPXZldmHKUpAHrxxIVNYP
   guBE7udoD4bcZ1ISMzJwi/1L0NO6xdSlQu8hjbMi6Z8Uks0KJLo5VUVTd
   20nrOMYyXhRu+xz4CmXC7tErfCwrgIjPdjSiHZp2c0aqLSXM/TgcTrOuR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="404236613"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="404236613"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 09:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="774423360"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="774423360"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Mar 2023 09:53:38 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal/drivers/intel/int340x: Add DLVR support
Date:   Fri, 31 Mar 2023 09:53:36 -0700
Message-Id: <20230331165336.1047102-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DLVR (Digital Linear Voltage Regulator) attributes,
which can be used to control RFIM.
Here instead of "fivr" another directory "dlvr" is created with DLVR
attributes:

/sys/bus/pci/devices/0000:00:04.0/dlvr
├── dlvr_freq_mhz
├── dlvr_freq_select
├── dlvr_hardware_rev
├── dlvr_pll_busy
├── dlvr_rfim_enable
└── dlvr_spread_spectrum_pct

Attributes
dlvr_freq_mhz (RO):
Current DLVR PLL frequency in MHz.

dlvr_freq_select (RW):
Sets DLVR PLL clock frequency.

dlvr_hardware_rev (RO):
DLVR hardware revision.

dlvr_pll_busy (RO):
PLL can't accept frequency change when set.

dlvr_rfim_enable (RW):
0: Disable RF frequency hopping, 1: Enable RF frequency hopping.

dlvr_spread_spectrum_pct (RW)
A write to this register updates the DLVR spread spectrum percent value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../driver-api/thermal/intel_dptf.rst         | 25 ++++++
 .../processor_thermal_device.c                |  3 +-
 .../processor_thermal_device.h                |  1 +
 .../processor_thermal_device_pci.c            |  2 +-
 .../int340x_thermal/processor_thermal_rfim.c  | 80 +++++++++++++++++--
 5 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
index f5c193cccbda..da906deb6a7d 100644
--- a/Documentation/driver-api/thermal/intel_dptf.rst
+++ b/Documentation/driver-api/thermal/intel_dptf.rst
@@ -264,6 +264,31 @@ DVFS attributes
 ``rfi_disable (RW)``
 	Disable DDR rate change feature
 
+DLVR attributes
+
+:file:`/sys/bus/pci/devices/0000\:00\:04.0/dlvr/`
+
+``dlvr_hardware_rev`` (RO)
+	DLVR hardware revision.
+
+``dlvr_freq_mhz`` (RO)
+	Current DLVR PLL frequency in MHz.
+
+``dlvr_freq_select`` (RW)
+	Sets DLVR PLL clock frequency. Once set, and enabled via
+	dlvr_rfim_enable, the dlvr_freq_mhz will show the current
+	DLVR PLL frequency.
+
+``dlvr_pll_busy`` (RO)
+	PLL can't accept frequency change when set.
+
+``dlvr_rfim_enable`` (RW)
+	0: Disable RF frequency hopping, 1: Enable RF frequency hopping.
+
+``dlvr_spread_spectrum_pct`` (RW)
+	Sets DLVR spread spectrum percent value.
+
+
 DPTF Power supply and Battery Interface
 ----------------------------------------
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index a1dc18be7609..3ca0a2f5937f 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -337,7 +337,8 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
 	}
 
 	if (feature_mask & PROC_THERMAL_FEATURE_FIVR ||
-	    feature_mask & PROC_THERMAL_FEATURE_DVFS) {
+	    feature_mask & PROC_THERMAL_FEATURE_DVFS ||
+	    feature_mask & PROC_THERMAL_FEATURE_DLVR) {
 		ret = proc_thermal_rfim_add(pdev, proc_priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to add RFIM interface\n");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 7d52fcff4937..7acaa8f1b896 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -60,6 +60,7 @@ struct rapl_mmio_regs {
 #define PROC_THERMAL_FEATURE_FIVR	0x02
 #define PROC_THERMAL_FEATURE_DVFS	0x04
 #define PROC_THERMAL_FEATURE_MBOX	0x08
+#define PROC_THERMAL_FEATURE_DLVR	0x10
 
 #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 90526f46c9b1..aaff67377250 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -352,7 +352,7 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_thermal_pci_suspend,
 
 static const struct pci_device_id proc_thermal_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
-	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
+	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX | PROC_THERMAL_FEATURE_DLVR) },
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
 	{ },
 };
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 92ed1213fe37..951a0869982a 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -39,6 +39,25 @@ static const struct mmio_reg tgl_fivr_mmio_regs[] = {
 	{ 1, 0x5A14, 2, 0x3, 1}, /* fivr_fffc_rev */
 };
 
+static const char * const dlvr_strings[] = {
+	"dlvr_spread_spectrum_pct",
+	"dlvr_rfim_enable",
+	"dlvr_freq_select",
+	"dlvr_hardware_rev",
+	"dlvr_freq_mhz",
+	"dlvr_pll_busy",
+	NULL
+};
+
+static const struct mmio_reg dlvr_mmio_regs[] = {
+	{ 0, 0x15A08, 5, 0x1F, 0}, /* dlvr_spread_spectrum_pct */
+	{ 0, 0x15A08, 1, 0x1, 7}, /* dlvr_rfim_enable */
+	{ 0, 0x15A08, 12, 0xFFF, 8}, /* dlvr_freq_select */
+	{ 1, 0x15A10, 2, 0x3, 30}, /* dlvr_hardware_rev */
+	{ 1, 0x15A10, 16, 0xFFFF, 0}, /* dlvr_freq_mhz */
+	{ 1, 0x15A10, 1, 0x1, 16}, /* dlvr_pll_busy */
+};
+
 /* These will represent sysfs attribute names */
 static const char * const dvfs_strings[] = {
 	"rfi_restriction_run_busy",
@@ -78,14 +97,16 @@ static ssize_t suffix##_show(struct device *dev,\
 	int ret;\
 \
 	proc_priv = pci_get_drvdata(pdev);\
-	if (table) {\
+	if (table == 1) {\
 		match_strs = (const char **)dvfs_strings;\
 		mmio_regs = adl_dvfs_mmio_regs;\
-	} else { \
+	} else if (table == 2) { \
+		match_strs = (const char **)dlvr_strings;\
+		mmio_regs = dlvr_mmio_regs;\
+	} else {\
 		match_strs = (const char **)fivr_strings;\
 		mmio_regs = tgl_fivr_mmio_regs;\
 	} \
-	\
 	ret = match_string(match_strs, -1, attr->attr.name);\
 	if (ret < 0)\
 		return ret;\
@@ -109,10 +130,13 @@ static ssize_t suffix##_store(struct device *dev,\
 	u32 mask;\
 \
 	proc_priv = pci_get_drvdata(pdev);\
-	if (table) {\
+	if (table == 1) {\
 		match_strs = (const char **)dvfs_strings;\
 		mmio_regs = adl_dvfs_mmio_regs;\
-	} else { \
+	} else if (table == 2) { \
+		match_strs = (const char **)dlvr_strings;\
+		mmio_regs = dlvr_mmio_regs;\
+	} else {\
 		match_strs = (const char **)fivr_strings;\
 		mmio_regs = tgl_fivr_mmio_regs;\
 	} \
@@ -147,6 +171,39 @@ RFIM_STORE(spread_spectrum_clk_enable, 0)
 RFIM_STORE(rfi_vco_ref_code, 0)
 RFIM_STORE(fivr_fffc_rev, 0)
 
+RFIM_SHOW(dlvr_spread_spectrum_pct, 2)
+RFIM_SHOW(dlvr_hardware_rev, 2)
+RFIM_SHOW(dlvr_freq_mhz, 2)
+RFIM_SHOW(dlvr_pll_busy, 2)
+RFIM_SHOW(dlvr_freq_select, 2)
+RFIM_SHOW(dlvr_rfim_enable, 2)
+
+RFIM_STORE(dlvr_spread_spectrum_pct, 2)
+RFIM_STORE(dlvr_rfim_enable, 2)
+RFIM_STORE(dlvr_freq_select, 2)
+
+static DEVICE_ATTR_RW(dlvr_spread_spectrum_pct);
+static DEVICE_ATTR_RW(dlvr_freq_select);
+static DEVICE_ATTR_RO(dlvr_hardware_rev);
+static DEVICE_ATTR_RO(dlvr_freq_mhz);
+static DEVICE_ATTR_RO(dlvr_pll_busy);
+static DEVICE_ATTR_RW(dlvr_rfim_enable);
+
+static struct attribute *dlvr_attrs[] = {
+	&dev_attr_dlvr_spread_spectrum_pct.attr,
+	&dev_attr_dlvr_freq_select.attr,
+	&dev_attr_dlvr_hardware_rev.attr,
+	&dev_attr_dlvr_freq_mhz.attr,
+	&dev_attr_dlvr_pll_busy.attr,
+	&dev_attr_dlvr_rfim_enable.attr,
+	NULL
+};
+
+static const struct attribute_group dlvr_attribute_group = {
+	.attrs = dlvr_attrs,
+	.name = "dlvr"
+};
+
 static DEVICE_ATTR_RW(vco_ref_code_lo);
 static DEVICE_ATTR_RW(vco_ref_code_hi);
 static DEVICE_ATTR_RW(spread_spectrum_pct);
@@ -277,12 +334,22 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 			return ret;
 	}
 
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR) {
+		ret = sysfs_create_group(&pdev->dev.kobj, &dlvr_attribute_group);
+		if (ret)
+			return ret;
+	}
+
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS) {
 		ret = sysfs_create_group(&pdev->dev.kobj, &dvfs_attribute_group);
 		if (ret && proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR) {
 			sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
 			return ret;
 		}
+		if (ret && proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR) {
+			sysfs_remove_group(&pdev->dev.kobj, &dlvr_attribute_group);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -296,6 +363,9 @@ void proc_thermal_rfim_remove(struct pci_dev *pdev)
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR)
 		sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
 
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR)
+		sysfs_remove_group(&pdev->dev.kobj, &dlvr_attribute_group);
+
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS)
 		sysfs_remove_group(&pdev->dev.kobj, &dvfs_attribute_group);
 }
-- 
2.34.1

