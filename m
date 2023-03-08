Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93F06AFF73
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCHHHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCHHGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:06:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99315A2F2C;
        Tue,  7 Mar 2023 23:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678259206; x=1709795206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wjZGX2lZghsukQ6+ZHa9NfZBUoqLg/C435YpkbFPhYg=;
  b=DsVMHCn2CkcCwWUPTpPNEBLoaRHZNSOXMGdLL2V0aVLxich7mXOTM6EX
   9mxdX4GVvZHLidb50gukfDUYixlV4GJQRN9vNa2USlfhny2EX8mbtmBMQ
   BNMKHRj60l8/Vvygxgzjy8YU16Kk9D1AeW9PumqLoPHe+zLC1JuJhT2wR
   dUlT5mXU5Fn47dGyzMAXGnxA3HM4XcyPO3p/gt63qtleFTIqP65DzQoz2
   1dK+0TUMUif7MEp243MyQKfYDfucTze85nTEnjNFt53b0gx5NBqTinBoO
   B8bDmxr0hHa7bpTS4Gcm0wzo4o/Pno0USW2f+dXPr/r69ieQPHIT+jXzr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333553975"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="333553975"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:06:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="850986383"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="850986383"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2023 23:06:44 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Pragya Tanwar <pragya.tanwar@intel.com>
Subject: [PATCH v2 3/8] platform/x86: ISST: Parse SST MMIO and update instance
Date:   Tue,  7 Mar 2023 23:06:37 -0800
Message-Id: <20230308070642.1727167-4-srinivas.pandruvada@linux.intel.com>
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

SST registers are presented to OS in multi-layer structures starting
with a SST header showing version information freezing current
definition.

For details on SST terminology refer to
Documentation/admin-guide/pm/intel-speed-select.rst
under the kernel documentation

SST TPMI details are published in the following document:
https://github.com/intel/tpmi_power_management/blob/main/SST_TPMI_public_disclosure_FINAL.docx

SST MMIO structure layout follows:
SST-HEADER
	SST-CP Header
		SST-CP CONTROL
		SST-CP STATUS
		SST-CP CONFIG0
		SST-CP CONFIG1
		...
		...
	SST-PP Header
		SST-PP OFFSET_0
		SST-PP OFFSET_1
					SST_PP_0_INFO
					SST_PP_1_INFO
					SST_PP_2_INFO
					SST_PP_3_INFO
		SST-PP CONTROL
		SST-PP STATUS

Each register bank contains information to get to next lower level
information. This information is parsed and stored in the struct
tpmi_per_power_domain_info for each domain. This information is
used to process each SST requests.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Pragya Tanwar <pragya.tanwar@intel.com>
---
v2:
No change

 .../intel/speed_select_if/isst_tpmi_core.c    | 291 +++++++++++++++++-
 1 file changed, 287 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 6b37016c0417..3453708c2dd0 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -20,6 +20,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/intel_tpmi.h>
 #include <linux/fs.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <uapi/linux/isst_if.h>
@@ -27,10 +28,192 @@
 #include "isst_tpmi_core.h"
 #include "isst_if_common.h"
 
+/* Supported SST hardware version by this driver */
+#define ISST_HEADER_VERSION		1
+
+/**
+ * struct sst_header -	SST main header
+ * @interface_version:	Version number for this interface
+ * @cap_mask:		Bitmask of the supported sub features. 1=the sub feature is enabled.
+ *			0=disabled.
+ *			Bit[8]= SST_CP enable (1), disable (0)
+ *			bit[9]= SST_PP enable (1), disable (0)
+ *			other bits are reserved for future use
+ * @cp_offset:		Qword (8 bytes) offset to the SST_CP register bank
+ * @pp_offset:		Qword (8 bytes) offset to the SST_PP register bank
+ * @reserved:		Reserved for future use
+ *
+ * This register allows SW to discover SST capability and the offsets to SST-CP
+ * and SST-PP register banks.
+ */
+struct sst_header {
+	u8 interface_version;
+	u8 cap_mask;
+	u8 cp_offset;
+	u8 pp_offset;
+	u32 reserved;
+} __packed;
+
+/**
+ * struct cp_header -	SST-CP (core-power) header
+ * @feature_id:		0=SST-CP, 1=SST-PP, 2=SST-BF, 3=SST-TF
+ * @feature_rev:	Interface Version number for this SST feature
+ * @ratio_unit:		Frequency ratio unit. 00: 100MHz. All others are reserved
+ * @reserved:		Reserved for future use
+ *
+ * This structure is used store SST-CP header. This is packed to the same
+ * format as defined in the specifications.
+ */
+struct cp_header {
+	u64 feature_id :4;
+	u64 feature_rev :8;
+	u64 ratio_unit :2;
+	u64 reserved :50;
+} __packed;
+
+/**
+ * struct pp_header -	SST-PP (Perf profile) header
+ * @feature_id:		0=SST-CP, 1=SST-PP, 2=SST-BF, 3=SST-TF
+ * @feature_rev:	Interface Version number for this SST feature
+ * @level_en_mask:	SST-PP level enable/disable fuse mask
+ * @allowed_level_mask:	Allowed level mask used for dynamic config level switching
+ * @reserved0:		Reserved for future use
+ * @ratio_unit:		Frequency ratio unit. 00: 100MHz. All others are reserved
+ * @block_size:		Size of PP block in Qword unit (8 bytes)
+ * @dynamic_switch:	If set (1), dynamic switching of SST PP is supported
+ * @memory_ratio_unit:	Memory Controller frequency ratio unit. 00: 100MHz, others reserved
+ * @reserved1:		Reserved for future use
+ *
+ * This structure is used store SST-PP header. This is packed to the same
+ * format as defined in the specifications.
+ */
+struct pp_header {
+	u64 feature_id :4;
+	u64 feature_rev :8;
+	u64 level_en_mask :8;
+	u64 allowed_level_mask :8;
+	u64 reserved0 :4;
+	u64 ratio_unit :2;
+	u64 block_size :8;
+	u64 dynamic_switch :1;
+	u64 memory_ratio_unit :2;
+	u64 reserved1 :19;
+} __packed;
+
+/**
+ * struct feature_offset -	Offsets to SST-PP features
+ * @pp_offset:		Qword offset within PP level for the SST_PP register bank
+ * @bf_offset:		Qword offset within PP level for the SST_BF register bank
+ * @tf_offset:		Qword offset within PP level for the SST_TF register bank
+ * @reserved:		Reserved for future use
+ *
+ * This structure is used store offsets for SST features in the register bank.
+ * This is packed to the same format as defined in the specifications.
+ */
+struct feature_offset {
+	u64 pp_offset :8;
+	u64 bf_offset :8;
+	u64 tf_offset :8;
+	u64 reserved :40;
+} __packed;
+
+/**
+ * struct levels_offset -	Offsets to each SST PP level
+ * @sst_pp_level0_offset:	Qword offset to the register block of PP level 0
+ * @sst_pp_level1_offset:	Qword offset to the register block of PP level 1
+ * @sst_pp_level2_offset:	Qword offset to the register block of PP level 2
+ * @sst_pp_level3_offset:	Qword offset to the register block of PP level 3
+ * @sst_pp_level4_offset:	Qword offset to the register block of PP level 4
+ * @reserved:			Reserved for future use
+ *
+ * This structure is used store offsets of SST PP levels in the register bank.
+ * This is packed to the same format as defined in the specifications.
+ */
+struct levels_offset {
+	u64 sst_pp_level0_offset :8;
+	u64 sst_pp_level1_offset :8;
+	u64 sst_pp_level2_offset :8;
+	u64 sst_pp_level3_offset :8;
+	u64 sst_pp_level4_offset :8;
+	u64 reserved :24;
+} __packed;
+
+/**
+ * struct pp_control_offset -	Offsets for SST PP controls
+ * @perf_level:		A SST-PP level that SW intends to switch to
+ * @perf_level_lock:	SST-PP level select lock. 0 - unlocked. 1 - locked till next reset
+ * @resvd0:		Reserved for future use
+ * @current_state:	Bit mask to control the enable(1)/disable(0) state of each feature
+ *			of the current PP level, bit 0 = BF, bit 1 = TF, bit 2-7 = reserved
+ * @reserved:		Reserved for future use
+ *
+ * This structure is used store offsets of SST PP controls in the register bank.
+ * This is packed to the same format as defined in the specifications.
+ */
+struct pp_control_offset {
+	u64 perf_level :3;
+	u64 perf_level_lock :1;
+	u64 resvd0 :4;
+	u64 current_state :8;
+	u64 reserved :48;
+} __packed;
+
+/**
+ * struct pp_status_offset -	Offsets for SST PP status fields
+ * @sst_pp_level:	Returns the current SST-PP level
+ * @sst_pp_lock:	Returns the lock bit setting of perf_level_lock in pp_control_offset
+ * @error_type:		Returns last error of SST-PP level change request. 0: no error,
+ *			1: level change not allowed, others: reserved
+ * @feature_state:	Bit mask to indicate the enable(1)/disable(0) state of each feature of the
+ *			current PP level. bit 0 = BF, bit 1 = TF, bit 2-7 reserved
+ * @reserved0:		Reserved for future use
+ * @feature_error_type: Returns last error of the specific feature. Three error_type bits per
+ *			feature. i.e. ERROR_TYPE[2:0] for BF, ERROR_TYPE[5:3] for TF, etc.
+ *			0x0: no error, 0x1: The specific feature is not supported by the hardware.
+ *			0x2-0x6: Reserved. 0x7: feature state change is not allowed.
+ * @reserved1:		Reserved for future use
+ *
+ * This structure is used store offsets of SST PP status in the register bank.
+ * This is packed to the same format as defined in the specifications.
+ */
+struct pp_status_offset {
+	u64 sst_pp_level :3;
+	u64 sst_pp_lock :1;
+	u64 error_type :4;
+	u64 feature_state :8;
+	u64 reserved0 :16;
+	u64 feature_error_type : 24;
+	u64 reserved1 :8;
+} __packed;
+
+/**
+ * struct perf_level -	Used to store perf level and mmio offset
+ * @mmio_offset:	mmio offset for a perf level
+ * @level:		perf level for this offset
+ *
+ * This structure is used store final mmio offset of each perf level from the
+ * SST base mmio offset.
+ */
+struct perf_level {
+	int mmio_offset;
+	int level;
+};
+
 /**
  * struct tpmi_per_power_domain_info -	Store per power_domain SST info
  * @package_id:		Package id for this power_domain
  * @power_domain_id:	Power domain id, Each entry from the SST-TPMI instance is a power_domain.
+ * @max_level:		Max possible PP level possible for this power_domain
+ * @ratio_unit:		Ratio unit for converting to MHz
+ * @avx_levels:		Number of AVX levels
+ * @pp_block_size:	Block size from PP header
+ * @sst_header:		Store SST header for this power_domain
+ * @cp_header:		Store SST-CP header for this power_domain
+ * @pp_header:		Store SST-PP header for this power_domain
+ * @perf_levels:	Pointer to each perf level to map level to mmio offset
+ * @feature_offsets:	Store feature offsets for each PP-level
+ * @control_offset:	Store the control offset for each PP-level
+ * @status_offset:	Store the status offset for each PP-level
  * @sst_base:		Mapped SST base IO memory
  * @auxdev:		Auxiliary device instance enumerated this instance
  *
@@ -41,6 +224,17 @@
 struct tpmi_per_power_domain_info {
 	int package_id;
 	int power_domain_id;
+	int max_level;
+	int ratio_unit;
+	int avx_levels;
+	int pp_block_size;
+	struct sst_header sst_header;
+	struct cp_header cp_header;
+	struct pp_header pp_header;
+	struct perf_level *perf_levels;
+	struct feature_offset feature_offsets;
+	struct pp_control_offset control_offset;
+	struct pp_status_offset status_offset;
 	void __iomem *sst_base;
 	struct auxiliary_device *auxdev;
 };
@@ -85,6 +279,86 @@ static int isst_core_usage_count;
 /* Stores complete SST information for every package and power_domain */
 static struct tpmi_sst_common_struct isst_common;
 
+#define SST_MAX_AVX_LEVELS	3
+
+#define SST_PP_OFFSET_0		8
+#define SST_PP_OFFSET_1		16
+#define SST_PP_OFFSET_SIZE	8
+
+static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
+				 struct tpmi_per_power_domain_info *pd_info,
+				 int levels)
+{
+	u64 perf_level_offsets;
+	int i;
+
+	pd_info->perf_levels = devm_kcalloc(&auxdev->dev, levels,
+					    sizeof(struct perf_level),
+					    GFP_KERNEL);
+	if (!pd_info->perf_levels)
+		return 0;
+
+	pd_info->ratio_unit = pd_info->pp_header.ratio_unit;
+	pd_info->avx_levels = SST_MAX_AVX_LEVELS;
+	pd_info->pp_block_size = pd_info->pp_header.block_size;
+
+	/* Read PP Offset 0: Get feature offset with PP level */
+	*((u64 *)&pd_info->feature_offsets) = readq(pd_info->sst_base +
+						    pd_info->sst_header.pp_offset +
+						    SST_PP_OFFSET_0);
+
+	perf_level_offsets = readq(pd_info->sst_base + pd_info->sst_header.pp_offset +
+				   SST_PP_OFFSET_1);
+
+	for (i = 0; i < levels; ++i) {
+		u64 offset;
+
+		offset = perf_level_offsets & (0xff << (i * SST_PP_OFFSET_SIZE));
+		offset >>= (i * 8);
+		offset &= 0xff;
+		offset *= 8; /* Convert to byte from QWORD offset */
+		pd_info->perf_levels[i].mmio_offset = pd_info->sst_header.pp_offset + offset;
+	}
+
+	return 0;
+}
+
+static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domain_info *pd_info)
+{
+	int i, mask, levels;
+
+	*((u64 *)&pd_info->sst_header) = readq(pd_info->sst_base);
+	pd_info->sst_header.cp_offset *= 8;
+	pd_info->sst_header.pp_offset *= 8;
+
+	if (pd_info->sst_header.interface_version != ISST_HEADER_VERSION) {
+		dev_err(&auxdev->dev, "SST: Unsupported version:%x\n",
+			pd_info->sst_header.interface_version);
+		return -ENODEV;
+	}
+
+	/* Read SST CP Header */
+	*((u64 *)&pd_info->cp_header) = readq(pd_info->sst_base + pd_info->sst_header.cp_offset);
+
+	/* Read PP header */
+	*((u64 *)&pd_info->pp_header) = readq(pd_info->sst_base + pd_info->sst_header.pp_offset);
+
+	/* Force level_en_mask level 0 */
+	pd_info->pp_header.level_en_mask |= 0x01;
+
+	mask = 0x01;
+	levels = 0;
+	for (i = 0; i < 8; ++i) {
+		if (pd_info->pp_header.level_en_mask & mask)
+			levels = i;
+		mask <<= 1;
+	}
+	pd_info->max_level = levels;
+	sst_add_perf_profiles(auxdev, pd_info, levels + 1);
+
+	return 0;
+}
+
 static int isst_if_get_tpmi_instance_count(void __user *argp)
 {
 	struct isst_tpmi_instance_count tpmi_inst;
@@ -102,10 +376,10 @@ static int isst_if_get_tpmi_instance_count(void __user *argp)
 	sst_inst = isst_common.sst_inst[tpmi_inst.socket_id];
 	tpmi_inst.valid_mask = 0;
 	for (i = 0; i < sst_inst->number_of_power_domains; ++i) {
-		struct tpmi_per_power_domain_info *power_domain_info;
+		struct tpmi_per_power_domain_info *pd_info;
 
-		power_domain_info = &sst_inst->power_domain_info[i];
-		if (power_domain_info->sst_base)
+		pd_info = &sst_inst->power_domain_info[i];
+		if (pd_info->sst_base)
 			tpmi_inst.valid_mask |= BIT(i);
 	}
 
@@ -134,11 +408,13 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
+#define TPMI_SST_AUTO_SUSPEND_DELAY_MS	2000
+
 int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 {
 	struct intel_tpmi_plat_info *plat_info;
 	struct tpmi_sst_struct *tpmi_sst;
-	int i, pkg = 0, inst = 0;
+	int i, ret, pkg = 0, inst = 0;
 	int num_resources;
 
 	plat_info = tpmi_get_platform_data(auxdev);
@@ -189,6 +465,13 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 		if (IS_ERR(tpmi_sst->power_domain_info[i].sst_base))
 			return PTR_ERR(tpmi_sst->power_domain_info[i].sst_base);
 
+		ret = sst_main(auxdev, &tpmi_sst->power_domain_info[i]);
+		if (ret) {
+			devm_iounmap(&auxdev->dev, tpmi_sst->power_domain_info[i].sst_base);
+			tpmi_sst->power_domain_info[i].sst_base =  NULL;
+			continue;
+		}
+
 		++inst;
 	}
 
-- 
2.34.1

