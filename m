Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38AE6AFF74
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCHHHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCHHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:06:54 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C38A2F37;
        Tue,  7 Mar 2023 23:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678259207; x=1709795207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DB5Y6DApORxnvwCMX80Ms32ZTNNF+wlOEuhY2BLU+Jg=;
  b=mu1jVC2wLv7pkt797li8hszBdlvF/VE2txntZ4gnzf54Pe9H5xtc/Bzd
   qh6PapM5GBPkDNtnL6NGpXc+1jfKvGs7AgYGOXuVsSa51sk3wp66/bW/B
   27IOLIWBUvrlZtVvfjPh/68bHcDFjiF8AjTpzcviB6pb45qU8xWAkwY9L
   HdIEvj5t0fOCXHjL3QS8y0Z0QJuq2yCPgUeB703zQ3KtaiDgTA4EMXvGX
   0StTOCsvdOXnBD4sMNK3vo6hPGnlO1nwsas7KyMl4T7mLNoXQDP+ZzC7i
   HSZyjG3FODlqfLmmqApThkbcRk0wCQtBLfed1htK5vvzTO/i624iNOy3k
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333553985"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="333553985"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="850986392"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="850986392"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2023 23:06:44 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Pragya Tanwar <pragya.tanwar@intel.com>
Subject: [PATCH v2 6/8] platform/x86: ISST: Add SST-BF support via TPMI
Date:   Tue,  7 Mar 2023 23:06:40 -0800
Message-Id: <20230308070642.1727167-7-srinivas.pandruvada@linux.intel.com>
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

The Intel Speed Select Technology - Base Frequency (SST-BF) feature lets
the user control base frequency. If some critical workload threads demand
constant high guaranteed performance, then this feature can be used to
execute the thread at higher base frequency on specific sets of CPUs
(high priority CPUs) at the cost of lower base frequency (low priority
CPUs) on other CPUs.

Two new IOCTLs are added:
ISST_IF_GET_BASE_FREQ_INFO : Get frequency information for high and
				low priority CPUs
ISST_IF_GET_BASE_FREQ_CPU_MASK : CPUs capable of higher frequency

Once an instance is identified, read or write from correct MMIO
offset for a given field as defined in the specification.

For details on SST-BF operations using intel-speed-selet utility,
refer to:
Documentation/admin-guide/pm/intel-speed-select.rst
under the kernel documentation

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Pragya Tanwar <pragya.tanwar@intel.com>
---
v2:
No change

 .../intel/speed_select_if/isst_tpmi_core.c    | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index c9b1321dfd1b..0566c8d30181 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1014,6 +1014,87 @@ static int isst_if_get_perf_level_mask(void __user *argp)
 	return 0;
 }
 
+#define SST_BF_INFO_0_OFFSET	0
+#define SST_BF_INFO_1_OFFSET	8
+
+#define SST_BF_P1_HIGH_START	13
+#define SST_BF_P1_HIGH_WIDTH	8
+
+#define SST_BF_P1_LOW_START	21
+#define SST_BF_P1_LOW_WIDTH	8
+
+#define SST_BF_T_PROHOT_START	38
+#define SST_BF_T_PROHOT_WIDTH	8
+
+#define SST_BF_TDP_START	46
+#define SST_BF_TDP_WIDTH	15
+
+static int isst_if_get_base_freq_info(void __user *argp)
+{
+	static struct isst_base_freq_info base_freq;
+	struct tpmi_per_power_domain_info *power_domain_info;
+
+	if (copy_from_user(&base_freq, argp, sizeof(base_freq)))
+		return -EFAULT;
+
+	power_domain_info = get_instance(base_freq.socket_id, base_freq.power_domain_id);
+	if (!power_domain_info)
+		return -EINVAL;
+
+	if (base_freq.level > power_domain_info->max_level)
+		return -EINVAL;
+
+	_read_bf_level_info("p1_high", base_freq.high_base_freq_mhz, base_freq.level,
+			    SST_BF_INFO_0_OFFSET, SST_BF_P1_HIGH_START, SST_BF_P1_HIGH_WIDTH,
+			    SST_MUL_FACTOR_FREQ)
+	_read_bf_level_info("p1_low", base_freq.low_base_freq_mhz, base_freq.level,
+			    SST_BF_INFO_0_OFFSET, SST_BF_P1_LOW_START, SST_BF_P1_LOW_WIDTH,
+			    SST_MUL_FACTOR_FREQ)
+	_read_bf_level_info("BF-TJ", base_freq.tjunction_max_c, base_freq.level,
+			    SST_BF_INFO_0_OFFSET, SST_BF_T_PROHOT_START, SST_BF_T_PROHOT_WIDTH,
+			    SST_MUL_FACTOR_NONE)
+	_read_bf_level_info("BF-tdp", base_freq.thermal_design_power_w, base_freq.level,
+			    SST_BF_INFO_0_OFFSET, SST_BF_TDP_START, SST_BF_TDP_WIDTH,
+			    SST_MUL_FACTOR_NONE)
+	base_freq.thermal_design_power_w /= 8; /*unit = 1/8th watt*/
+
+	if (copy_to_user(argp, &base_freq, sizeof(base_freq)))
+		return -EFAULT;
+
+	return 0;
+}
+
+#define P1_HI_CORE_MASK_START	0
+#define P1_HI_CORE_MASK_WIDTH	64
+
+static int isst_if_get_base_freq_mask(void __user *argp)
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
+	_read_bf_level_info("BF-cpumask", mask, cpumask.level, SST_BF_INFO_1_OFFSET,
+			    P1_HI_CORE_MASK_START, P1_HI_CORE_MASK_WIDTH,
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
@@ -1079,6 +1160,12 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 	case ISST_IF_GET_PERF_LEVEL_CPU_MASK:
 		ret = isst_if_get_perf_level_mask(argp);
 		break;
+	case ISST_IF_GET_BASE_FREQ_INFO:
+		ret = isst_if_get_base_freq_info(argp);
+		break;
+	case ISST_IF_GET_BASE_FREQ_CPU_MASK:
+		ret = isst_if_get_base_freq_mask(argp);
+		break;
 	default:
 		break;
 	}
-- 
2.34.1

