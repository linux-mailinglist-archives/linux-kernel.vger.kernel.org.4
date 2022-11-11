Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBE7624F91
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiKKBaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiKKBaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:30:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B089663159
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668130194; x=1699666194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TfJuVFvlR2o3KJEqap1qG3gwJRndC/YxttEpCE8qBl8=;
  b=DPG41DFChjblST/0qBybXD3m5N+YEvnuKr34XAtVZ1wZxM+R1u8Aynlr
   Cjsc8vnSRnqvQY8Q4fx+xJcdcsy60dp3ikGHQSsdQUWnH+9LXq+3C2TKS
   o9h/UI0GlKIn6Q6X1dobDdMFbmI4slbghqpD6gB9LrJYsF1oTyOy4vM2t
   UASuwznsadI0GvR+o9tJdq2bhJ1A5c+LpflTBp31iuRMyRO8wJGmjGsbY
   uWJKK7JhT78el2fiVR7xy5wO3OtO5VdRaJTYa4ApH5nJuduQNZTfHUILL
   BHNp+NHttbkWwNnK4HqSkzgIcWVkRa3xICHH0nWqJDiwYx+6yyjpTC3mp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294847817"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="294847817"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780003244"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="780003244"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:52 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 4/7] soundwire: intel: add bus management callbacks in hw_ops
Date:   Fri, 11 Nov 2022 09:31:31 +0800
Message-Id: <20221111013135.38289-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
References: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

No functionality change, only add indirection for bus management
helpers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 24 ++++++++++++--------
 drivers/soundwire/intel.h           | 34 +++++++++++++++++++++++++++++
 include/linux/soundwire/sdw_intel.h | 11 ++++++++++
 3 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0496eb0d6084..6d2fdf3a01fd 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1428,6 +1428,12 @@ const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops = {
 
 	.register_dai = intel_register_dai,
 
+	.check_clock_stop = intel_check_clock_stop,
+	.start_bus = intel_start_bus,
+	.start_bus_after_reset = intel_start_bus_after_reset,
+	.start_bus_after_clock_stop = intel_start_bus_after_clock_stop,
+	.stop_bus = intel_stop_bus,
+
 	.pre_bank_switch = intel_pre_bank_switch,
 	.post_bank_switch = intel_post_bank_switch,
 };
@@ -1622,7 +1628,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	sdw_intel_debugfs_init(sdw);
 
 	/* start bus */
-	ret = intel_start_bus(sdw);
+	ret = sdw_intel_start_bus(sdw);
 	if (ret) {
 		dev_err(dev, "bus start failed: %d\n", ret);
 		goto err_power_up;
@@ -1850,7 +1856,7 @@ static int __maybe_unused intel_suspend(struct device *dev)
 		return 0;
 	}
 
-	ret = intel_stop_bus(sdw, false);
+	ret = sdw_intel_stop_bus(sdw, false);
 	if (ret < 0) {
 		dev_err(dev, "%s: cannot stop bus: %d\n", __func__, ret);
 		return ret;
@@ -1876,14 +1882,14 @@ static int __maybe_unused intel_suspend_runtime(struct device *dev)
 	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 
 	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
-		ret = intel_stop_bus(sdw, false);
+		ret = sdw_intel_stop_bus(sdw, false);
 		if (ret < 0) {
 			dev_err(dev, "%s: cannot stop bus during teardown: %d\n",
 				__func__, ret);
 			return ret;
 		}
 	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET || !clock_stop_quirks) {
-		ret = intel_stop_bus(sdw, true);
+		ret = sdw_intel_stop_bus(sdw, true);
 		if (ret < 0) {
 			dev_err(dev, "%s: cannot stop bus during clock_stop: %d\n",
 				__func__, ret);
@@ -1941,7 +1947,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 	 */
 	sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
 
-	ret = intel_start_bus(sdw);
+	ret = sdw_intel_start_bus(sdw);
 	if (ret < 0) {
 		dev_err(dev, "cannot start bus during resume\n");
 		intel_link_power_down(sdw);
@@ -1995,7 +2001,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 		 */
 		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
 
-		ret = intel_start_bus(sdw);
+		ret = sdw_intel_start_bus(sdw);
 		if (ret < 0) {
 			dev_err(dev, "%s: cannot start bus after teardown: %d\n", __func__, ret);
 			intel_link_power_down(sdw);
@@ -2010,7 +2016,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 			return ret;
 		}
 
-		ret = intel_start_bus_after_reset(sdw);
+		ret = sdw_intel_start_bus_after_reset(sdw);
 		if (ret < 0) {
 			dev_err(dev, "%s: cannot start bus after reset: %d\n", __func__, ret);
 			intel_link_power_down(sdw);
@@ -2018,7 +2024,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 		}
 	} else if (!clock_stop_quirks) {
 
-		intel_check_clock_stop(sdw);
+		sdw_intel_check_clock_stop(sdw);
 
 		ret = intel_link_power_up(sdw);
 		if (ret) {
@@ -2026,7 +2032,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 			return ret;
 		}
 
-		ret = intel_start_bus_after_clock_stop(sdw);
+		ret = sdw_intel_start_bus_after_clock_stop(sdw);
 		if (ret < 0) {
 			dev_err(dev, "%s: cannot start bus after clock stop: %d\n", __func__, ret);
 			intel_link_power_down(sdw);
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 0521cab311a3..99a2d875a331 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -84,4 +84,38 @@ static inline int sdw_intel_register_dai(struct sdw_intel *sdw)
 	return -ENOTSUPP;
 }
 
+static inline void sdw_intel_check_clock_stop(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, check_clock_stop))
+		SDW_INTEL_OPS(sdw, check_clock_stop)(sdw);
+}
+
+static inline int sdw_intel_start_bus(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, start_bus))
+		return SDW_INTEL_OPS(sdw, start_bus)(sdw);
+	return -ENOTSUPP;
+}
+
+static inline int sdw_intel_start_bus_after_reset(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, start_bus_after_reset))
+		return SDW_INTEL_OPS(sdw, start_bus_after_reset)(sdw);
+	return -ENOTSUPP;
+}
+
+static inline int sdw_intel_start_bus_after_clock_stop(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, start_bus_after_clock_stop))
+		return SDW_INTEL_OPS(sdw, start_bus_after_clock_stop)(sdw);
+	return -ENOTSUPP;
+}
+
+static inline int sdw_intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, stop_bus))
+		return SDW_INTEL_OPS(sdw, stop_bus)(sdw, clock_stop);
+	return -ENOTSUPP;
+}
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 5be63d4fe62e..cee61bc9af8a 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -300,6 +300,11 @@ struct sdw_intel;
  * @debugfs_init: initialize all debugfs capabilities
  * @debugfs_exit: close and cleanup debugfs capabilities
  * @register_dai: read all PDI information and register DAIs
+ * @check_clock_stop: throw error message if clock is not stopped.
+ * @start_bus: normal start
+ * @start_bus_after_reset: start after reset
+ * @start_bus_after_clock_stop: start after mode0 clock stop
+ * @stop_bus: stop all bus
  * @pre_bank_switch: helper for bus management
  * @post_bank_switch: helper for bus management
  */
@@ -309,6 +314,12 @@ struct sdw_intel_hw_ops {
 
 	int (*register_dai)(struct sdw_intel *sdw);
 
+	void (*check_clock_stop)(struct sdw_intel *sdw);
+	int (*start_bus)(struct sdw_intel *sdw);
+	int (*start_bus_after_reset)(struct sdw_intel *sdw);
+	int (*start_bus_after_clock_stop)(struct sdw_intel *sdw);
+	int (*stop_bus)(struct sdw_intel *sdw, bool clock_stop);
+
 	int (*pre_bank_switch)(struct sdw_intel *sdw);
 	int (*post_bank_switch)(struct sdw_intel *sdw);
 };
-- 
2.25.1

