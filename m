Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8332F6E6AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjDRROL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjDRRNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:13:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E08C5FC0;
        Tue, 18 Apr 2023 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681838026; x=1713374026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EW/NzUatcqccaAZf4t6HInPFSpn4oc5stb1VqBGNgJw=;
  b=WhsdgoRDJ0FASDUeShDCiufYE3XTiTuKgA8fdhX12/5soYcZqsXc9wwn
   I1Kf7boUb3weMdk4uramnxwv9QPGtunTFz7563O5TZQ7gvPoSNrZlZcG4
   qgXg4dI+Q/lzCYj/CNxemNkQd9sCAc5j9sAbLvLHmNgoAcjIt2s5tIXF7
   s8fqghj7IbRdaK4AsbAXC3OIyAEYHugiPp0Bux1nMgAqQ4tcA1Ip8qU8f
   JCn2IP0criUJrr3QsDaWAhwTmNDJ3+s1n73pIbh6HhKTUy0GuKsRpTqHA
   0/I4ZVoZNFhPXo33tPTK7+m6N6H2VJnmBGzmbYITr9neL3bRRMTk/ABsm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="347084269"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="347084269"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="755762667"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="755762667"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 18 Apr 2023 10:13:44 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: [PATCH v2 3/3] platform/x86/intel-uncore-freq: tpmi: Provide cluster level control
Date:   Tue, 18 Apr 2023 10:13:40 -0700
Message-Id: <20230418171340.681662-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230418171340.681662-1-srinivas.pandruvada@linux.intel.com>
References: <20230418171340.681662-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new generation of CPUs have granular control at a cluster level.
Each package/die can have multiple power domains, which further can
have multiple fabric clusters. The TPMI interface allows control at
fabric cluster level.

Use the updated uncore sysfs feature to expose controls at cluster
level. At each cluster level there is a control for maximum and minimum
uncore frequency. Also present current uncore frequency at a cluster
level.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wendy Wang <wendy.wang@intel.com>
---
New patch with this series.

 .../uncore-frequency/uncore-frequency-tpmi.c  | 136 ++++++++++++++----
 1 file changed, 108 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 5e454e9dd4a7..b7f7d2a7f42c 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -44,6 +44,7 @@ struct tpmi_uncore_struct;
 
 /* Information for each cluster */
 struct tpmi_uncore_cluster_info {
+	bool root_domain;
 	u8 __iomem *cluster_base;
 	struct uncore_data uncore_data;
 	struct tpmi_uncore_struct *uncore_root;
@@ -60,12 +61,15 @@ struct tpmi_uncore_power_domain_info {
 /* Information for all power domains in a package */
 struct tpmi_uncore_struct {
 	int power_domain_count;
+	int max_ratio;
+	int min_ratio;
 	struct tpmi_uncore_power_domain_info *pd_info;
 	struct tpmi_uncore_cluster_info root_cluster;
 };
 
 #define UNCORE_GENMASK_MIN_RATIO	GENMASK_ULL(21, 15)
 #define UNCORE_GENMASK_MAX_RATIO	GENMASK_ULL(14, 8)
+#define UNCORE_GENMASK_CURRENT_RATIO	GENMASK_ULL(6, 0)
 
 /* Helper function to read MMIO offset for max/min control frequency */
 static void read_control_freq(struct tpmi_uncore_cluster_info *cluster_info,
@@ -85,32 +89,37 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *min,
 				    unsigned int *max)
 {
 	struct tpmi_uncore_cluster_info *cluster_info;
-	struct tpmi_uncore_struct *uncore_root;
-	int i, _min = 0, _max = 0;
 
 	cluster_info = container_of(data, struct tpmi_uncore_cluster_info, uncore_data);
-	uncore_root = cluster_info->uncore_root;
 
-	*min = UNCORE_MAX_RATIO * UNCORE_FREQ_KHZ_MULTIPLIER;
-	*max = 0;
+	if (cluster_info->root_domain) {
+		struct tpmi_uncore_struct *uncore_root = cluster_info->uncore_root;
+		int i, _min = 0, _max = 0;
 
-	/*
-	 * Get the max/min by looking at each cluster. Get the lowest
-	 * min and highest max.
-	 */
-	for (i = 0; i < uncore_root->power_domain_count; ++i) {
-		int j;
+		*min = UNCORE_MAX_RATIO * UNCORE_FREQ_KHZ_MULTIPLIER;
+		*max = 0;
 
-		for (j = 0; j < uncore_root->pd_info[i].cluster_count; ++j) {
-			read_control_freq(&uncore_root->pd_info[i].cluster_infos[j],
-					  &_min, &_max);
-			if (*min > _min)
-				*min = _min;
-			if (*max < _max)
-				*max = _max;
+		/*
+		 * Get the max/min by looking at each cluster. Get the lowest
+		 * min and highest max.
+		 */
+		for (i = 0; i < uncore_root->power_domain_count; ++i) {
+			int j;
+
+			for (j = 0; j < uncore_root->pd_info[i].cluster_count; ++j) {
+				read_control_freq(&uncore_root->pd_info[i].cluster_infos[j],
+						  &_min, &_max);
+				if (*min > _min)
+					*min = _min;
+				if (*max < _max)
+					*max = _max;
+			}
 		}
+		return 0;
 	}
 
+	read_control_freq(cluster_info, min, max);
+
 	return 0;
 }
 
@@ -139,7 +148,6 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 {
 	struct tpmi_uncore_cluster_info *cluster_info;
 	struct tpmi_uncore_struct *uncore_root;
-	int i;
 
 	input /= UNCORE_FREQ_KHZ_MULTIPLIER;
 	if (!input || input > UNCORE_MAX_RATIO)
@@ -149,21 +157,72 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 	uncore_root = cluster_info->uncore_root;
 
 	/* Update each cluster in a package */
-	for (i = 0; i < uncore_root->power_domain_count; ++i) {
-		int j;
+	if (cluster_info->root_domain) {
+		struct tpmi_uncore_struct *uncore_root = cluster_info->uncore_root;
+		int i;
+
+		for (i = 0; i < uncore_root->power_domain_count; ++i) {
+			int j;
+
+			for (j = 0; j < uncore_root->pd_info[i].cluster_count; ++j)
+				write_control_freq(&uncore_root->pd_info[i].cluster_infos[j],
+						  input, min_max);
+		}
 
-		for (j = 0; j < uncore_root->pd_info[i].cluster_count; ++j)
-			write_control_freq(&uncore_root->pd_info[i].cluster_infos[j],
-					   input, min_max);
+		if (min_max)
+			uncore_root->max_ratio = input;
+		else
+			uncore_root->min_ratio = input;
+
+		return 0;
 	}
 
+	if (min_max && uncore_root->max_ratio && uncore_root->max_ratio < input)
+		return -EINVAL;
+
+	if (!min_max && uncore_root->min_ratio && uncore_root->min_ratio > input)
+		return -EINVAL;
+
+	write_control_freq(cluster_info, input, min_max);
+
 	return 0;
 }
 
 /* Callback for sysfs read for the current uncore frequency. Called under mutex locks */
 static int uncore_read_freq(struct uncore_data *data, unsigned int *freq)
 {
-	return -ENODATA;
+	struct tpmi_uncore_cluster_info *cluster_info;
+	u64 status;
+
+	cluster_info = container_of(data, struct tpmi_uncore_cluster_info, uncore_data);
+	if (cluster_info->root_domain)
+		return -ENODATA;
+
+	status = readq((u8 __iomem *)cluster_info->cluster_base + UNCORE_STATUS_INDEX);
+	*freq = FIELD_GET(UNCORE_GENMASK_CURRENT_RATIO, status) * UNCORE_FREQ_KHZ_MULTIPLIER;
+
+	return 0;
+}
+
+static void remove_cluster_entries(struct tpmi_uncore_struct *tpmi_uncore)
+{
+	int i;
+
+	for (i = 0; i < tpmi_uncore->power_domain_count; ++i) {
+		struct tpmi_uncore_power_domain_info *pd_info;
+		int j;
+
+		pd_info = &tpmi_uncore->pd_info[i];
+		if (!pd_info->uncore_base)
+			continue;
+
+		for (j = 0; j < pd_info->cluster_count; ++j) {
+			struct tpmi_uncore_cluster_info *cluster_info;
+
+			cluster_info = &pd_info->cluster_infos[j];
+			uncore_freq_remove_die_entry(&cluster_info->uncore_data);
+		}
+	}
 }
 
 #define UNCORE_GENMASK_VERSION			GENMASK_ULL(7, 0)
@@ -231,7 +290,13 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 		pd_info->uncore_base = devm_ioremap_resource(&auxdev->dev, res);
 		if (IS_ERR(pd_info->uncore_base)) {
 			ret = PTR_ERR(pd_info->uncore_base);
-			goto err_rem_common;
+			/*
+			 * Set to NULL so that clean up can still remove other
+			 * entries already created if any by
+			 * remove_cluster_entries()
+			 */
+			pd_info->uncore_base = NULL;
+			goto remove_clusters;
 		}
 
 		/* Check for version and skip this resource if there is mismatch */
@@ -263,7 +328,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 						      GFP_KERNEL);
 		if (!pd_info->cluster_infos) {
 			ret = -ENOMEM;
-			goto err_rem_common;
+			goto remove_clusters;
 		}
 		/*
 		 * Each byte in the register point to status and control
@@ -287,7 +352,16 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 			cluster_info->uncore_data.package_id = pkg;
 			/* There are no dies like Cascade Lake */
 			cluster_info->uncore_data.die_id = 0;
+			cluster_info->uncore_data.domain_id = i;
+			cluster_info->uncore_data.cluster_id = j;
+
+			cluster_info->uncore_root = tpmi_uncore;
 
+			ret = uncore_freq_add_entry(&cluster_info->uncore_data, 0);
+			if (ret) {
+				cluster_info->cluster_base = NULL;
+				goto remove_clusters;
+			}
 			/* Point to next cluster offset */
 			cluster_offset >>= UNCORE_MAX_CLUSTER_PER_DOMAIN;
 		}
@@ -295,14 +369,19 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 
 	auxiliary_set_drvdata(auxdev, tpmi_uncore);
 
+	tpmi_uncore->root_cluster.root_domain = true;
 	tpmi_uncore->root_cluster.uncore_root = tpmi_uncore;
+
 	tpmi_uncore->root_cluster.uncore_data.package_id = pkg;
+	tpmi_uncore->root_cluster.uncore_data.domain_id = UNCORE_DOMAIN_ID_INVALID;
 	ret = uncore_freq_add_entry(&tpmi_uncore->root_cluster.uncore_data, 0);
 	if (ret)
-		goto err_rem_common;
+		goto remove_clusters;
 
 	return 0;
 
+remove_clusters:
+	remove_cluster_entries(tpmi_uncore);
 err_rem_common:
 	uncore_freq_common_exit();
 
@@ -314,6 +393,7 @@ static void uncore_remove(struct auxiliary_device *auxdev)
 	struct tpmi_uncore_struct *tpmi_uncore = auxiliary_get_drvdata(auxdev);
 
 	uncore_freq_remove_die_entry(&tpmi_uncore->root_cluster.uncore_data);
+	remove_cluster_entries(tpmi_uncore);
 
 	uncore_freq_common_exit();
 }
-- 
2.38.1

