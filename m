Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23B26AFF75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCHHHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCHHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:06:54 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5DDA3342;
        Tue,  7 Mar 2023 23:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678259208; x=1709795208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XF9Xq78hJP6NfJnZXSiLni/YDd+aQG9M96yaekwmAnU=;
  b=JHVIsWIKRCwOOCUS/1j988fLWbZpOYnAYkaTZ9/w0CMNvcxHjPqVRvPz
   ihYwC1SPzaS0H0raj8ub0zlllcSouYNNSN8E18HXgdllzB7sF/YRcKgzh
   pOe7uYQ3EaMLwD79hBb4y8V5eMMp4UZkFGaPnjM/fotoIua95TKZiXMVT
   TWv57JUS3WpDVc0MRtxjstfZgmxGaRZ2mYwvm7aGwgvhE+nVJJ/gC7P5I
   rY47KKYQWPTgSIywt8NE8pSqNIF17RglzTttt2CpYdY55p2rqcw142tUg
   Sm2vzWCbvnFhx0g6KABPRwc+gPJTQQKH0826uVzbdbRvJdgDQdwOhgmZp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333553984"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="333553984"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="850986389"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="850986389"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2023 23:06:44 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Pragya Tanwar <pragya.tanwar@intel.com>
Subject: [PATCH v2 5/8] platform/x86: ISST: Add SST-PP support via TPMI
Date:   Tue,  7 Mar 2023 23:06:39 -0800
Message-Id: <20230308070642.1727167-6-srinivas.pandruvada@linux.intel.com>
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

This Intel Speed Select Technology - Performance Profile (SST-PP) feature
introduces a mechanism that allows multiple optimized performance profiles
per system. Each profile defines a set of CPUs that need to be online and
rest offline to sustain a guaranteed base frequency.

Five new IOCTLs are added:
ISST_IF_PERF_LEVELS : Get number of performance levels
ISST_IF_PERF_SET_LEVEL : Set to a new performance level
ISST_IF_PERF_SET_FEATURE : Activate SST-BF/SST-TF for a performance level
ISST_IF_GET_PERF_LEVEL_INFO : Get parameters for a performance level
ISST_IF_GET_PERF_LEVEL_CPU_MASK : Get CPU mask for a performance level

Once an instance is identified, read or write from correct MMIO
offset for a given field as defined in the specification.

For details on SST PP operations using intel-speed-selet utility,
refer to:
Documentation/admin-guide/pm/intel-speed-select.rst
under the kernel documentation

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Pragya Tanwar <pragya.tanwar@intel.com>
---
v2:
No change

 .../intel/speed_select_if/isst_tpmi_core.c    | 417 +++++++++++++++++-
 include/uapi/linux/isst_if.h                  | 180 ++++++++
 2 files changed, 596 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index bc1c1f26fbf9..c9b1321dfd1b 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
 #include <linux/intel_tpmi.h>
 #include <linux/fs.h>
 #include <linux/io.h>
@@ -325,7 +326,7 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 	for (i = 0; i < levels; ++i) {
 		u64 offset;
 
-		offset = perf_level_offsets & (0xff << (i * SST_PP_OFFSET_SIZE));
+		offset = perf_level_offsets & (0xffULL << (i * SST_PP_OFFSET_SIZE));
 		offset >>= (i * 8);
 		offset &= 0xff;
 		offset *= 8; /* Convert to byte from QWORD offset */
@@ -614,6 +615,405 @@ static long isst_if_clos_assoc(void __user *argp)
 	return 0;
 }
 
+#define _read_pp_info(name_str, name, offset, start, width, mult_factor)\
+{\
+	u64 val, _mask;\
+	\
+	val = readq(power_domain_info->sst_base + power_domain_info->sst_header.pp_offset +\
+		    (offset));\
+	_mask = GENMASK_ULL((start + width - 1), start);\
+	val &= _mask;\
+	val >>= start;\
+	name = (val * mult_factor);\
+}
+
+#define _write_pp_info(name_str, name, offset, start, width, div_factor)\
+{\
+	u64 val, _mask;\
+	\
+	val = readq(power_domain_info->sst_base + power_domain_info->sst_header.pp_offset +\
+		    (offset));\
+	_mask = GENMASK((start + width - 1), start);\
+	val &= ~_mask;\
+	val |= (name / div_factor) << start;\
+	writeq(val, power_domain_info->sst_base + power_domain_info->sst_header.pp_offset +\
+	      (offset));\
+}
+
+#define _read_bf_level_info(name_str, name, level, offset, start, width, mult_factor)\
+{\
+	u64 val, _mask;\
+	\
+	val = readq(power_domain_info->sst_base +\
+		    power_domain_info->perf_levels[level].mmio_offset +\
+		(power_domain_info->feature_offsets.bf_offset * 8) + (offset));\
+	_mask = GENMASK_ULL((start + width - 1), start);\
+	val &= _mask; \
+	val >>= start;\
+	name = (val * mult_factor);\
+}
+
+#define _read_tf_level_info(name_str, name, level, offset, start, width, mult_factor)\
+{\
+	u64 val, _mask;\
+	\
+	val = readq(power_domain_info->sst_base +\
+		    power_domain_info->perf_levels[level].mmio_offset +\
+		(power_domain_info->feature_offsets.tf_offset * 8) + (offset));\
+	_mask = GENMASK_ULL((start + width - 1), start);\
+	val &= _mask; \
+	val >>= start;\
+	name = (val * mult_factor);\
+}
+
+#define SST_PP_STATUS_OFFSET	32
+
+#define SST_PP_LEVEL_START	0
+#define SST_PP_LEVEL_WIDTH	3
+
+#define SST_PP_LOCK_START	3
+#define SST_PP_LOCK_WIDTH	1
+
+#define SST_PP_FEATURE_STATE_START	8
+#define SST_PP_FEATURE_STATE_WIDTH	8
+
+#define SST_BF_FEATURE_SUPPORTED_START	12
+#define SST_BF_FEATURE_SUPPORTED_WIDTH	1
+
+#define SST_TF_FEATURE_SUPPORTED_START	12
+#define SST_TF_FEATURE_SUPPORTED_WIDTH	1
+
+static int isst_if_get_perf_level(void __user *argp)
+{
+	struct isst_perf_level_info perf_level;
+	struct tpmi_per_power_domain_info *power_domain_info;
+
+	if (copy_from_user(&perf_level, argp, sizeof(perf_level)))
+		return -EFAULT;
+
+	power_domain_info = get_instance(perf_level.socket_id, perf_level.power_domain_id);
+	if (!power_domain_info)
+		return -EINVAL;
+
+	perf_level.max_level = power_domain_info->max_level;
+	perf_level.level_mask = power_domain_info->pp_header.allowed_level_mask;
+	perf_level.feature_rev = power_domain_info->pp_header.feature_rev;
+	_read_pp_info("current_level", perf_level.current_level, SST_PP_STATUS_OFFSET,
+		      SST_PP_LEVEL_START, SST_PP_LEVEL_WIDTH, SST_MUL_FACTOR_NONE)
+	_read_pp_info("locked", perf_level.locked, SST_PP_STATUS_OFFSET,
+		      SST_PP_LOCK_START, SST_PP_LEVEL_WIDTH, SST_MUL_FACTOR_NONE)
+	_read_pp_info("feature_state", perf_level.feature_state, SST_PP_STATUS_OFFSET,
+		      SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH, SST_MUL_FACTOR_NONE)
+	perf_level.enabled = !!(power_domain_info->sst_header.cap_mask & BIT(1));
+
+	_read_bf_level_info("bf_support", perf_level.sst_bf_support, 0, 0,
+			    SST_BF_FEATURE_SUPPORTED_START, SST_BF_FEATURE_SUPPORTED_WIDTH,
+			    SST_MUL_FACTOR_NONE);
+	_read_tf_level_info("tf_support", perf_level.sst_tf_support, 0, 0,
+			    SST_TF_FEATURE_SUPPORTED_START, SST_TF_FEATURE_SUPPORTED_WIDTH,
+			    SST_MUL_FACTOR_NONE);
+
+	if (copy_to_user(argp, &perf_level, sizeof(perf_level)))
+		return -EFAULT;
+
+	return 0;
+}
+
+#define SST_PP_CONTROL_OFFSET		24
+#define SST_PP_LEVEL_CHANGE_TIME_MS	5
+#define SST_PP_LEVEL_CHANGE_RETRY_COUNT	3
+
+static int isst_if_set_perf_level(void __user *argp)
+{
+	struct isst_perf_level_control perf_level;
+	struct tpmi_per_power_domain_info *power_domain_info;
+	int level, retry = 0;
+
+	if (disable_dynamic_sst_features())
+		return -EFAULT;
+
+	if (copy_from_user(&perf_level, argp, sizeof(perf_level)))
+		return -EFAULT;
+
+	power_domain_info = get_instance(perf_level.socket_id, perf_level.power_domain_id);
+	if (!power_domain_info)
+		return -EINVAL;
+
+	if (!(power_domain_info->pp_header.allowed_level_mask & BIT(perf_level.level)))
+		return -EINVAL;
+
+	_read_pp_info("current_level", level, SST_PP_STATUS_OFFSET,
+		      SST_PP_LEVEL_START, SST_PP_LEVEL_WIDTH, SST_MUL_FACTOR_NONE)
+
+	/* If the requested new level is same as the current level, reject */
+	if (perf_level.level == level)
+		return -EINVAL;
+
+	_write_pp_info("perf_level", perf_level.level, SST_PP_CONTROL_OFFSET,
+		       SST_PP_LEVEL_START, SST_PP_LEVEL_WIDTH, SST_MUL_FACTOR_NONE)
+
+	/* It is possible that firmware is busy (although unlikely), so retry */
+	do {
+		/* Give time to FW to process */
+		msleep(SST_PP_LEVEL_CHANGE_TIME_MS);
+
+		_read_pp_info("current_level", level, SST_PP_STATUS_OFFSET,
+			      SST_PP_LEVEL_START, SST_PP_LEVEL_WIDTH, SST_MUL_FACTOR_NONE)
+
+		/* Check if the new level is active */
+		if (perf_level.level == level)
+			break;
+
+	} while (retry++ < SST_PP_LEVEL_CHANGE_RETRY_COUNT);
+
+	/* If the level change didn't happen, return fault */
+	if (perf_level.level != level)
+		return -EFAULT;
+
+	/* Reset the feature state on level change */
+	_write_pp_info("perf_feature", 0, SST_PP_CONTROL_OFFSET,
+		       SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH,
+		       SST_MUL_FACTOR_NONE)
+
+	/* Give time to FW to process */
+	msleep(SST_PP_LEVEL_CHANGE_TIME_MS);
+
+	return 0;
+}
+
+static int isst_if_set_perf_feature(void __user *argp)
+{
+	struct isst_perf_feature_control perf_feature;
+	struct tpmi_per_power_domain_info *power_domain_info;
+
+	if (disable_dynamic_sst_features())
+		return -EFAULT;
+
+	if (copy_from_user(&perf_feature, argp, sizeof(perf_feature)))
+		return -EFAULT;
+
+	power_domain_info = get_instance(perf_feature.socket_id, perf_feature.power_domain_id);
+	if (!power_domain_info)
+		return -EINVAL;
+
+	_write_pp_info("perf_feature", perf_feature.feature, SST_PP_CONTROL_OFFSET,
+		       SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH,
+		       SST_MUL_FACTOR_NONE)
+
+	return 0;
+}
+
+#define _read_pp_level_info(name_str, name, level, offset, start, width, mult_factor)\
+{\
+	u64 val, _mask;\
+	\
+	val = readq(power_domain_info->sst_base +\
+		    power_domain_info->perf_levels[level].mmio_offset +\
+		(power_domain_info->feature_offsets.pp_offset * 8) + (offset));\
+	_mask = GENMASK_ULL((start + width - 1), start);\
+	val &= _mask; \
+	val >>= start;\
+	name = (val * mult_factor);\
+}
+
+#define SST_PP_INFO_0_OFFSET	0
+#define SST_PP_INFO_1_OFFSET	8
+#define SST_PP_INFO_2_OFFSET	16
+#define SST_PP_INFO_3_OFFSET	24
+
+/* SST_PP_INFO_4_OFFSET to SST_PP_INFO_9_OFFSET are trl levels */
+#define SST_PP_INFO_4_OFFSET	32
+
+#define SST_PP_INFO_10_OFFSET	80
+#define SST_PP_INFO_11_OFFSET	88
+
+#define SST_PP_P1_SSE_START	0
+#define SST_PP_P1_SSE_WIDTH	8
+
+#define SST_PP_P1_AVX2_START	8
+#define SST_PP_P1_AVX2_WIDTH	8
+
+#define SST_PP_P1_AVX512_START	16
+#define SST_PP_P1_AVX512_WIDTH	8
+
+#define SST_PP_P1_AMX_START	24
+#define SST_PP_P1_AMX_WIDTH	8
+
+#define SST_PP_TDP_START	32
+#define SST_PP_TDP_WIDTH	15
+
+#define SST_PP_T_PROCHOT_START	47
+#define SST_PP_T_PROCHOT_WIDTH	8
+
+#define SST_PP_MAX_MEMORY_FREQ_START	55
+#define SST_PP_MAX_MEMORY_FREQ_WIDTH	7
+
+#define SST_PP_COOLING_TYPE_START	62
+#define SST_PP_COOLING_TYPE_WIDTH	2
+
+#define SST_PP_TRL_0_RATIO_0_START	0
+#define SST_PP_TRL_0_RATIO_0_WIDTH	8
+
+#define SST_PP_TRL_CORES_BUCKET_0_START	0
+#define SST_PP_TRL_CORES_BUCKET_0_WIDTH	8
+
+#define SST_PP_CORE_RATIO_P0_START	0
+#define SST_PP_CORE_RATIO_P0_WIDTH	8
+
+#define SST_PP_CORE_RATIO_P1_START	8
+#define SST_PP_CORE_RATIO_P1_WIDTH	8
+
+#define SST_PP_CORE_RATIO_PN_START	16
+#define SST_PP_CORE_RATIO_PN_WIDTH	8
+
+#define SST_PP_CORE_RATIO_PM_START	24
+#define SST_PP_CORE_RATIO_PM_WIDTH	8
+
+#define SST_PP_CORE_RATIO_P0_FABRIC_START	32
+#define SST_PP_CORE_RATIO_P0_FABRIC_WIDTH	8
+
+#define SST_PP_CORE_RATIO_P1_FABRIC_START	40
+#define SST_PP_CORE_RATIO_P1_FABRIC_WIDTH	8
+
+#define SST_PP_CORE_RATIO_PM_FABRIC_START	48
+#define SST_PP_CORE_RATIO_PM_FABRIC_WIDTH	8
+
+static int isst_if_get_perf_level_info(void __user *argp)
+{
+	struct isst_perf_level_data_info perf_level;
+	struct tpmi_per_power_domain_info *power_domain_info;
+	int i, j;
+
+	if (copy_from_user(&perf_level, argp, sizeof(perf_level)))
+		return -EFAULT;
+
+	power_domain_info = get_instance(perf_level.socket_id, perf_level.power_domain_id);
+	if (!power_domain_info)
+		return -EINVAL;
+
+	if (perf_level.level > power_domain_info->max_level)
+		return -EINVAL;
+
+	if (!(power_domain_info->pp_header.level_en_mask & BIT(perf_level.level)))
+		return -EINVAL;
+
+	_read_pp_level_info("tdp_ratio", perf_level.tdp_ratio, perf_level.level,
+			    SST_PP_INFO_0_OFFSET, SST_PP_P1_SSE_START, SST_PP_P1_SSE_WIDTH,
+			    SST_MUL_FACTOR_NONE)
+	_read_pp_level_info("base_freq_mhz", perf_level.base_freq_mhz, perf_level.level,
+			    SST_PP_INFO_0_OFFSET, SST_PP_P1_SSE_START, SST_PP_P1_SSE_WIDTH,
+			    SST_MUL_FACTOR_FREQ)
+	_read_pp_level_info("base_freq_avx2_mhz", perf_level.base_freq_avx2_mhz, perf_level.level,
+			    SST_PP_INFO_0_OFFSET, SST_PP_P1_AVX2_START, SST_PP_P1_AVX2_WIDTH,
+			    SST_MUL_FACTOR_FREQ)
+	_read_pp_level_info("base_freq_avx512_mhz", perf_level.base_freq_avx512_mhz,
+			    perf_level.level, SST_PP_INFO_0_OFFSET, SST_PP_P1_AVX512_START,
+			    SST_PP_P1_AVX512_WIDTH, SST_MUL_FACTOR_FREQ)
+	_read_pp_level_info("base_freq_amx_mhz", perf_level.base_freq_amx_mhz, perf_level.level,
+			    SST_PP_INFO_0_OFFSET, SST_PP_P1_AMX_START, SST_PP_P1_AMX_WIDTH,
+			    SST_MUL_FACTOR_FREQ)
+
+	_read_pp_level_info("thermal_design_power_w", perf_level.thermal_design_power_w,
+			    perf_level.level, SST_PP_INFO_1_OFFSET, SST_PP_TDP_START,
+			    SST_PP_TDP_WIDTH, SST_MUL_FACTOR_NONE)
+	perf_level.thermal_design_power_w /= 8; /* units are in 1/8th watt */
+	_read_pp_level_info("tjunction_max_c", perf_level.tjunction_max_c, perf_level.level,
+			    SST_PP_INFO_1_OFFSET, SST_PP_T_PROCHOT_START, SST_PP_T_PROCHOT_WIDTH,
+			    SST_MUL_FACTOR_NONE)
+	_read_pp_level_info("max_memory_freq_mhz", perf_level.max_memory_freq_mhz,
+			    perf_level.level, SST_PP_INFO_1_OFFSET, SST_PP_MAX_MEMORY_FREQ_START,
+			    SST_PP_MAX_MEMORY_FREQ_WIDTH, SST_MUL_FACTOR_FREQ)
+	_read_pp_level_info("cooling_type", perf_level.cooling_type, perf_level.level,
+			    SST_PP_INFO_1_OFFSET, SST_PP_COOLING_TYPE_START,
+			    SST_PP_COOLING_TYPE_WIDTH, SST_MUL_FACTOR_NONE)
+
+	for (i = 0; i < TRL_MAX_LEVELS; ++i) {
+		for (j = 0; j < TRL_MAX_BUCKETS; ++j)
+			_read_pp_level_info("trl*_bucket*_freq_mhz",
+					    perf_level.trl_freq_mhz[i][j], perf_level.level,
+					    SST_PP_INFO_4_OFFSET + (i * SST_PP_TRL_0_RATIO_0_WIDTH),
+					    j * SST_PP_TRL_0_RATIO_0_WIDTH,
+					    SST_PP_TRL_0_RATIO_0_WIDTH,
+					    SST_MUL_FACTOR_FREQ);
+	}
+
+	for (i = 0; i < TRL_MAX_BUCKETS; ++i)
+		_read_pp_level_info("bucket*_core_count", perf_level.bucket_core_counts[i],
+				    perf_level.level, SST_PP_INFO_10_OFFSET,
+				    SST_PP_TRL_CORES_BUCKET_0_WIDTH * i,
+				    SST_PP_TRL_CORES_BUCKET_0_WIDTH, SST_MUL_FACTOR_NONE)
+
+	perf_level.max_buckets = TRL_MAX_BUCKETS;
+	perf_level.max_trl_levels = TRL_MAX_LEVELS;
+
+	_read_pp_level_info("p0_freq_mhz", perf_level.p0_freq_mhz, perf_level.level,
+			    SST_PP_INFO_11_OFFSET, SST_PP_CORE_RATIO_P0_START,
+			    SST_PP_CORE_RATIO_P0_WIDTH, SST_MUL_FACTOR_FREQ)
+	_read_pp_level_info("p1_freq_mhz", perf_level.p1_freq_mhz, perf_level.level,
+			    SST_PP_INFO_11_OFFSET, SST_PP_CORE_RATIO_P1_START,
+			    SST_PP_CORE_RATIO_P1_WIDTH, SST_MUL_FACTOR_FREQ)
+	_read_pp_level_info("pn_freq_mhz", perf_level.pn_freq_mhz, perf_level.level,
+			    SST_PP_INFO_11_OFFSET, SST_PP_CORE_RATIO_PN_START,
+			    SST_PP_CORE_RATIO_PN_WIDTH, SST_MUL_FACTOR_FREQ)
+	_read_pp_level_info("pm_freq_mhz", perf_level.pm_freq_mhz, perf_level.level,
+			    SST_PP_INFO_11_OFFSET, SST_PP_CORE_RATIO_PM_START,
+			    SST_PP_CORE_RATIO_PM_WIDTH, SST_MUL_FACTOR_FREQ)
+	_read_pp_level_info("p0_fabric_freq_mhz", perf_level.p0_fabric_freq_mhz,
+			    perf_level.level, SST_PP_INFO_11_OFFSET,
+			    SST_PP_CORE_RATIO_P0_FABRIC_START,
+			    SST_PP_CORE_RATIO_P0_FABRIC_WIDTH, SST_MUL_FACTOR_FREQ)
+	_read_pp_level_info("p1_fabric_freq_mhz", perf_level.p1_fabric_freq_mhz,
+			    perf_level.level, SST_PP_INFO_11_OFFSET,
+			    SST_PP_CORE_RATIO_P1_FABRIC_START,
+			    SST_PP_CORE_RATIO_P1_FABRIC_WIDTH, SST_MUL_FACTOR_FREQ)
+	_read_pp_level_info("pm_fabric_freq_mhz", perf_level.pm_fabric_freq_mhz,
+			    perf_level.level, SST_PP_INFO_11_OFFSET,
+			    SST_PP_CORE_RATIO_PM_FABRIC_START,
+			    SST_PP_CORE_RATIO_PM_FABRIC_WIDTH, SST_MUL_FACTOR_FREQ)
+
+	if (copy_to_user(argp, &perf_level, sizeof(perf_level)))
+		return -EFAULT;
+
+	return 0;
+}
+
+#define SST_PP_FUSED_CORE_COUNT_START	0
+#define SST_PP_FUSED_CORE_COUNT_WIDTH	8
+
+#define SST_PP_RSLVD_CORE_COUNT_START	8
+#define SST_PP_RSLVD_CORE_COUNT_WIDTH	8
+
+#define SST_PP_RSLVD_CORE_MASK_START	0
+#define SST_PP_RSLVD_CORE_MASK_WIDTH	64
+
+static int isst_if_get_perf_level_mask(void __user *argp)
+{
+	static struct isst_perf_level_cpu_mask cpumask;
+	struct tpmi_per_power_domain_info *power_domain_info;
+	u64 mask;
+
+	if (copy_from_user(&cpumask, argp, sizeof(cpumask)))
+		return -EFAULT;
+
+	power_domain_info = get_instance(cpumask.socket_id, cpumask.power_domain_id);
+	if (!power_domain_info)
+		return -EINVAL;
+
+	_read_pp_level_info("mask", mask, cpumask.level, SST_PP_INFO_2_OFFSET,
+			    SST_PP_RSLVD_CORE_MASK_START, SST_PP_RSLVD_CORE_MASK_WIDTH,
+			    SST_MUL_FACTOR_NONE)
+
+	cpumask.mask = mask;
+
+	if (!cpumask.punit_cpu_map)
+		return -EOPNOTSUPP;
+
+	if (copy_to_user(argp, &cpumask, sizeof(cpumask)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int isst_if_get_tpmi_instance_count(void __user *argp)
 {
 	struct isst_tpmi_instance_count tpmi_inst;
@@ -664,6 +1064,21 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 	case ISST_IF_CLOS_ASSOC:
 		ret = isst_if_clos_assoc(argp);
 		break;
+	case ISST_IF_PERF_LEVELS:
+		ret = isst_if_get_perf_level(argp);
+		break;
+	case ISST_IF_PERF_SET_LEVEL:
+		ret = isst_if_set_perf_level(argp);
+		break;
+	case ISST_IF_PERF_SET_FEATURE:
+		ret = isst_if_set_perf_feature(argp);
+		break;
+	case ISST_IF_GET_PERF_LEVEL_INFO:
+		ret = isst_if_get_perf_level_info(argp);
+		break;
+	case ISST_IF_GET_PERF_LEVEL_CPU_MASK:
+		ret = isst_if_get_perf_level_mask(argp);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/isst_if.h b/include/uapi/linux/isst_if.h
index 32687d8023ef..c4b350ea5cbe 100644
--- a/include/uapi/linux/isst_if.h
+++ b/include/uapi/linux/isst_if.h
@@ -254,6 +254,178 @@ struct isst_tpmi_instance_count {
 	__u16 valid_mask;
 };
 
+/**
+ * struct isst_perf_level_info - Structure to get information on SST-PP levels
+ * @socket_id:	Socket/package id
+ * @power_domain:	Power Domain id
+ * @logical_cpu: CPU number
+ * @clos:	Clos ID to assign to the logical CPU
+ * @max_level: Maximum performance level supported by the platform
+ * @feature_rev: The feature revision for SST-PP supported by the platform
+ * @level_mask: Mask of supported performance levels
+ * @current_level: Current performance level
+ * @feature_state: SST-BF and SST-TF (enabled/disabled) status at current level
+ * @locked: SST-PP performance level change is locked/unlocked
+ * @enabled: SST-PP feature is enabled or not
+ * @sst-tf_support: SST-TF support status at this level
+ * @sst-bf_support: SST-BF support status at this level
+ *
+ * Structure to get SST-PP details using IOCTL ISST_IF_PERF_LEVELS.
+ */
+struct isst_perf_level_info {
+	__u8 socket_id;
+	__u8 power_domain_id;
+	__u8 max_level;
+	__u8 feature_rev;
+	__u8 level_mask;
+	__u8 current_level;
+	__u8 feature_state;
+	__u8 locked;
+	__u8 enabled;
+	__u8 sst_tf_support;
+	__u8 sst_bf_support;
+};
+
+/**
+ * struct isst_perf_level_control - Structure to set SST-PP level
+ * @socket_id:	Socket/package id
+ * @power_domain:	Power Domain id
+ * @level:	level to set
+ *
+ * Structure used change SST-PP level using IOCTL ISST_IF_PERF_SET_LEVEL.
+ */
+struct isst_perf_level_control {
+	__u8 socket_id;
+	__u8 power_domain_id;
+	__u8 level;
+};
+
+/**
+ * struct isst_perf_feature_control - Structure to activate SST-BF/SST-TF
+ * @socket_id:	Socket/package id
+ * @power_domain:	Power Domain id
+ * @feature:	bit 0 = SST-BF state, bit 1 = SST-TF state
+ *
+ * Structure used to enable SST-BF/SST-TF using IOCTL ISST_IF_PERF_SET_FEATURE.
+ */
+struct isst_perf_feature_control {
+	__u8 socket_id;
+	__u8 power_domain_id;
+	__u8 feature;
+};
+
+#define TRL_MAX_BUCKETS	8
+#define TRL_MAX_LEVELS		6
+
+/**
+ * struct isst_perf_level_data_info - Structure to get SST-PP level details
+ * @socket_id:	Socket/package id
+ * @power_domain:	Power Domain id
+ * @level:	SST-PP level for which caller wants to get information
+ * @tdp_ratio: TDP Ratio
+ * @base_freq_mhz: Base frequency in MHz
+ * @base_freq_avx2_mhz: AVX2 Base frequency in MHz
+ * @base_freq_avx512_mhz: AVX512 base frequency in MHz
+ * @base_freq_amx_mhz: AMX base frequency in MHz
+ * @thermal_design_power_w: Thermal design (TDP) power
+ * @tjunction_max_c: Max junction temperature
+ * @max_memory_freq_mhz: Max memory frequency in MHz
+ * @cooling_type: Type of cooling is used
+ * @p0_freq_mhz: core maximum frequency
+ * @p1_freq_mhz: Core TDP frequency
+ * @pn_freq_mhz: Core maximum efficiency frequency
+ * @pm_freq_mhz: Core minimum frequency
+ * @p0_fabric_freq_mhz: Fabric (Uncore) maximum frequency
+ * @p1_fabric_freq_mhz: Fabric (Uncore) TDP frequency
+ * @pn_fabric_freq_mhz: Fabric (Uncore) minimum efficiency frequency
+ * @pm_fabric_freq_mhz: Fabric (Uncore) minimum frequency
+ * @max_buckets: Maximum trl buckets
+ * @max_trl_levels: Maximum trl levels
+ * @bucket_core_counts[TRL_MAX_BUCKETS]: Number of cores per bucket
+ * @trl_freq_mhz[TRL_MAX_LEVELS][TRL_MAX_BUCKETS]: maximum frequency
+ * for a bucket and trl level
+ *
+ * Structure used to get information on frequencies and TDP for a SST-PP
+ * level using ISST_IF_GET_PERF_LEVEL_INFO.
+ */
+struct isst_perf_level_data_info {
+	__u8 socket_id;
+	__u8 power_domain_id;
+	__u16 level;
+	__u16 tdp_ratio;
+	__u16 base_freq_mhz;
+	__u16 base_freq_avx2_mhz;
+	__u16 base_freq_avx512_mhz;
+	__u16 base_freq_amx_mhz;
+	__u16 thermal_design_power_w;
+	__u16 tjunction_max_c;
+	__u16 max_memory_freq_mhz;
+	__u16 cooling_type;
+	__u16 p0_freq_mhz;
+	__u16 p1_freq_mhz;
+	__u16 pn_freq_mhz;
+	__u16 pm_freq_mhz;
+	__u16 p0_fabric_freq_mhz;
+	__u16 p1_fabric_freq_mhz;
+	__u16 pn_fabric_freq_mhz;
+	__u16 pm_fabric_freq_mhz;
+	__u16 max_buckets;
+	__u16 max_trl_levels;
+	__u16 bucket_core_counts[TRL_MAX_BUCKETS];
+	__u16 trl_freq_mhz[TRL_MAX_LEVELS][TRL_MAX_BUCKETS];
+};
+
+/**
+ * struct isst_perf_level_cpu_mask - Structure to get SST-PP level CPU mask
+ * @socket_id:	Socket/package id
+ * @power_domain:	Power Domain id
+ * @level:	SST-PP level for which caller wants to get information
+ * @punit_cpu_map: Set to 1 if the CPU number is punit numbering not
+ *		   Linux CPU number. If 0 CPU buffer is copied to user space
+ *		   supplied cpu_buffer of size cpu_buffer_size. Punit
+ *		   cpu mask is copied to "mask" field.
+ * @mask:	cpu mask for this PP level (punit CPU numbering)
+ * @cpu_buffer_size: size of cpu_buffer also used to return the copied CPU
+ *		buffer size.
+ * @cpu_buffer:	Buffer to copy CPU mask when punit_cpu_map is 0
+ *
+ * Structure used to get cpumask for a SST-PP level using
+ * IOCTL ISST_IF_GET_PERF_LEVEL_CPU_MASK. Also used to get CPU mask for
+ * IOCTL ISST_IF_GET_BASE_FREQ_CPU_MASK for SST-BF.
+ */
+struct isst_perf_level_cpu_mask {
+	__u8 socket_id;
+	__u8 power_domain_id;
+	__u8 level;
+	__u8 punit_cpu_map;
+	__u64 mask;
+	__u16 cpu_buffer_size;
+	__s8 cpu_buffer[1];
+};
+
+/**
+ * struct isst_base_freq_info - Structure to get SST-BF frequencies
+ * @socket_id:	Socket/package id
+ * @power_domain:	Power Domain id
+ * @level:	SST-PP level for which caller wants to get information
+ * @high_base_freq_mhz: High priority CPU base frequency
+ * @low_base_freq_mhz: Low priority CPU base frequency
+ * @tjunction_max_c: Max junction temperature
+ * @thermal_design_power_w: Thermal design power in watts
+ *
+ * Structure used to get SST-BF information using
+ * IOCTL ISST_IF_GET_BASE_FREQ_INFO.
+ */
+struct isst_base_freq_info {
+	__u8 socket_id;
+	__u8 power_domain_id;
+	__u16 level;
+	__u16 high_base_freq_mhz;
+	__u16 low_base_freq_mhz;
+	__u16 tjunction_max_c;
+	__u16 thermal_design_power_w;
+};
+
 #define ISST_IF_MAGIC			0xFE
 #define ISST_IF_GET_PLATFORM_INFO	_IOR(ISST_IF_MAGIC, 0, struct isst_if_platform_info *)
 #define ISST_IF_GET_PHY_ID		_IOWR(ISST_IF_MAGIC, 1, struct isst_if_cpu_map *)
@@ -266,4 +438,12 @@ struct isst_tpmi_instance_count {
 #define ISST_IF_CLOS_PARAM	_IOWR(ISST_IF_MAGIC, 7, struct isst_clos_param *)
 #define ISST_IF_CLOS_ASSOC	_IOWR(ISST_IF_MAGIC, 8, struct isst_if_clos_assoc_cmds *)
 
+#define ISST_IF_PERF_LEVELS	_IOWR(ISST_IF_MAGIC, 9, struct isst_perf_level_info *)
+#define ISST_IF_PERF_SET_LEVEL	_IOW(ISST_IF_MAGIC, 10, struct isst_perf_level_control *)
+#define ISST_IF_PERF_SET_FEATURE _IOW(ISST_IF_MAGIC, 11, struct isst_perf_feature_control *)
+#define ISST_IF_GET_PERF_LEVEL_INFO	_IOR(ISST_IF_MAGIC, 12, struct isst_perf_level_data_info *)
+#define ISST_IF_GET_PERF_LEVEL_CPU_MASK	_IOR(ISST_IF_MAGIC, 13, struct isst_perf_level_cpu_mask *)
+#define ISST_IF_GET_BASE_FREQ_INFO	_IOR(ISST_IF_MAGIC, 14, struct isst_base_freq_info *)
+#define ISST_IF_GET_BASE_FREQ_CPU_MASK	_IOR(ISST_IF_MAGIC, 15, struct isst_perf_level_cpu_mask *)
+
 #endif
-- 
2.34.1

