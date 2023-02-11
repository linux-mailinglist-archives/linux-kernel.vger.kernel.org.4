Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE315692EBA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBKGeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjBKGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:33:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABAF7D3CA;
        Fri, 10 Feb 2023 22:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676097203; x=1707633203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E9k/S+GsvFNH57VgRlynoHcY3mQtoATcyhnWxmlVNH0=;
  b=HshmWWcAsnVAEOJUok4T0TteD2UzywQSN2obFsNlitP0fySnDE4wMeld
   oDP65+Lm7XV87rvszPej9gqZWCUoV4TTvMBnwrnjvj0Q+fsqN0ZLR/zf7
   O2fMIWFm/sahMdqpaAKe3eEgYVIZVjlAWnROCSC86dZEXxgMs/pv9gr8e
   AznYFJYEFV8wzq10NHDuSWLmMkPaIw6B0rkNpUwnYIC+GpLhya71Kcym7
   hwT8mwIsuZjiHXCH8CL1YkacSckAER/V/3QPr9vAK3oD+CJV6XVN9xPgS
   6ighw7uUcF9cZRwVbYxYZ8Ea6fQDuCRRmUJE72tnlyrELgIZ9uprRXAMi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310223225"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="310223225"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 22:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997171780"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="997171780"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 22:33:04 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 11/12] platform/x86: ISST: Add SST-TF support via TPMI
Date:   Fri, 10 Feb 2023 22:32:56 -0800
Message-Id: <20230211063257.311746-12-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support of Intel Speed Select Technology - Turbo Frequency (SST-TF)
feature enables the ability to set different “All core turbo ratio
limits” to cores based on the priority. By using this feature, some cores
can be configured to get higher turbo frequency by designating them as
high priority at the cost of lower or no turbo frequency on the low
priority cores.

One new IOCTLs are added:
ISST_IF_GET_TURBO_FREQ_INFO : Get information about turbo frequency
				buckets

Once an instance is identified, read or write from correct MMIO
offset for a given field as defined in the specification.

For details on SST-TF operations using intel-speed-selet utility,
refer to:
Documentation/admin-guide/pm/intel-speed-select.rst
under the kernel documentation

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 66 +++++++++++++++++++
 include/uapi/linux/isst_if.h                  | 26 ++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index fe7c364a8d0b..9eaff90bb649 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1125,6 +1125,69 @@ static int isst_if_get_tpmi_instance_count(void __user *argp)
 	return 0;
 }
 
+#define SST_TF_INFO_0_OFFSET	0
+#define SST_TF_INFO_1_OFFSET	8
+#define SST_TF_INFO_2_OFFSET	16
+
+#define SST_TF_MAX_LP_CLIP_RATIOS	TRL_MAX_LEVELS
+
+#define SST_TF_LP_CLIP_RATIO_0_START	16
+#define SST_TF_LP_CLIP_RATIO_0_WIDTH	8
+
+#define SST_TF_RATIO_0_START	0
+#define SST_TF_RATIO_0_WIDTH	8
+
+#define SST_TF_NUM_CORE_0_START 0
+#define SST_TF_NUM_CORE_0_WIDTH 8
+
+static int isst_if_get_turbo_freq_info(void __user *argp)
+{
+	static struct isst_turbo_freq_info turbo_freq;
+	struct tpmi_per_power_domain_info *power_domain_info;
+	int i, j;
+
+	if (copy_from_user(&turbo_freq, argp, sizeof(turbo_freq)))
+		return -EFAULT;
+
+	power_domain_info = get_instance(turbo_freq.socket_id, turbo_freq.power_domain_id);
+	if (!power_domain_info)
+		return -EINVAL;
+
+	if (turbo_freq.level > power_domain_info->max_level)
+		return -EINVAL;
+
+	turbo_freq.max_buckets = TRL_MAX_BUCKETS;
+	turbo_freq.max_trl_levels = TRL_MAX_LEVELS;
+	turbo_freq.max_clip_freqs = SST_TF_MAX_LP_CLIP_RATIOS;
+
+	for (i = 0; i < turbo_freq.max_clip_freqs; ++i)
+		_read_tf_level_info("lp_clip*", turbo_freq.lp_clip_freq_mhz[i],
+				    turbo_freq.level, SST_TF_INFO_0_OFFSET,
+				    SST_TF_LP_CLIP_RATIO_0_START +
+				    (i * SST_TF_LP_CLIP_RATIO_0_WIDTH),
+				    SST_TF_LP_CLIP_RATIO_0_WIDTH, SST_MUL_FACTOR_FREQ)
+
+	for (i = 0; i < TRL_MAX_LEVELS; ++i) {
+		for (j = 0; j < TRL_MAX_BUCKETS; ++j)
+			_read_tf_level_info("cydn*_bucket_*_trl",
+					    turbo_freq.trl_freq_mhz[i][j], turbo_freq.level,
+					    SST_TF_INFO_2_OFFSET + (i * SST_TF_RATIO_0_WIDTH),
+					    j * SST_TF_RATIO_0_WIDTH, SST_TF_RATIO_0_WIDTH,
+					    SST_MUL_FACTOR_FREQ)
+	}
+
+	for (i = 0; i < TRL_MAX_BUCKETS; ++i)
+		_read_tf_level_info("bucket_*_core_count", turbo_freq.bucket_core_counts[i],
+				    turbo_freq.level, SST_TF_INFO_1_OFFSET,
+				    SST_TF_NUM_CORE_0_WIDTH * i, SST_TF_NUM_CORE_0_WIDTH,
+				    SST_MUL_FACTOR_NONE)
+
+	if (copy_to_user(argp, &turbo_freq, sizeof(turbo_freq)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
@@ -1166,6 +1229,9 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 	case ISST_IF_GET_BASE_FREQ_CPU_MASK:
 		ret = isst_if_get_base_freq_mask(argp);
 		break;
+	case ISST_IF_GET_TURBO_FREQ_INFO:
+		ret = isst_if_get_turbo_freq_info(argp);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/isst_if.h b/include/uapi/linux/isst_if.h
index c4b350ea5cbe..0df1a1c3caf4 100644
--- a/include/uapi/linux/isst_if.h
+++ b/include/uapi/linux/isst_if.h
@@ -426,6 +426,31 @@ struct isst_base_freq_info {
 	__u16 thermal_design_power_w;
 };
 
+/**
+ * struct isst_turbo_freq_info - Structure to get SST-TF frequencies
+ * @socket_id:	Socket/package id
+ * @power_domain:	Power Domain id
+ * @level:	SST-PP level for which caller wants to get information
+ * @max_clip_freqs: Maximum number of low priority core clipping frequencies
+ * @lp_clip_freq_mhz: Clip frequencies per trl level
+ * @bucket_core_counts: Maximum number of cores for a bucket
+ * @trl_freq_mhz: Frequencies per trl level for each bucket
+ *
+ * Structure used to get SST-TF information using
+ * IOCTL ISST_IF_GET_TURBO_FREQ_INFO.
+ */
+struct isst_turbo_freq_info {
+	__u8 socket_id;
+	__u8 power_domain_id;
+	__u16 level;
+	__u16 max_clip_freqs;
+	__u16 max_buckets;
+	__u16 max_trl_levels;
+	__u16 lp_clip_freq_mhz[TRL_MAX_LEVELS];
+	__u16 bucket_core_counts[TRL_MAX_BUCKETS];
+	__u16 trl_freq_mhz[TRL_MAX_LEVELS][TRL_MAX_BUCKETS];
+};
+
 #define ISST_IF_MAGIC			0xFE
 #define ISST_IF_GET_PLATFORM_INFO	_IOR(ISST_IF_MAGIC, 0, struct isst_if_platform_info *)
 #define ISST_IF_GET_PHY_ID		_IOWR(ISST_IF_MAGIC, 1, struct isst_if_cpu_map *)
@@ -445,5 +470,6 @@ struct isst_base_freq_info {
 #define ISST_IF_GET_PERF_LEVEL_CPU_MASK	_IOR(ISST_IF_MAGIC, 13, struct isst_perf_level_cpu_mask *)
 #define ISST_IF_GET_BASE_FREQ_INFO	_IOR(ISST_IF_MAGIC, 14, struct isst_base_freq_info *)
 #define ISST_IF_GET_BASE_FREQ_CPU_MASK	_IOR(ISST_IF_MAGIC, 15, struct isst_perf_level_cpu_mask *)
+#define ISST_IF_GET_TURBO_FREQ_INFO	_IOR(ISST_IF_MAGIC, 16, struct isst_turbo_freq_info *)
 
 #endif
-- 
2.39.1

