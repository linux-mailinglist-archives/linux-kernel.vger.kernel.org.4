Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB139624F92
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKKBaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiKKBaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:30:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E2663147
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668130196; x=1699666196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0p3boPfp645wf/wMw+Y2tkE1nhsOJBG7jEtTIrVuN+w=;
  b=YhpRxmwERADBNXBIImZJQSxbOEKe+pynK+83dhl9rKUWBhhQeBSP6R+g
   dNsZtm1Hqg8GjabGMa7B3rGueBPdLQBFSq9X4DKzi2JZ9BLmSIfvqbYDi
   QPTdeIKlYkyjIooSir00DLwMFZF3LiRTWUwNEkq4FuIr+LmXM5cLix34l
   AMjCTtYtOtiUptL7gsrRKXDFDGWvYppJTMZg2tuurP9wXXCM290G1zeyZ
   hnFX9Ha+9IJXXDzMmbAcmqELLXJ4fhjfK1Dzbi2cmVTvDYb1Jl0cL/84n
   iiP3KxanURPWMOBDkyJW6oNh6j0HeTbAmHl2hajqHzM43n4oy12k8e8hL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294847826"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="294847826"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780003256"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="780003256"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:54 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 5/7] soundwire: intel: add link power management callbacks in hw_ops
Date:   Fri, 11 Nov 2022 09:31:32 +0800
Message-Id: <20221111013135.38289-6-yung-chuan.liao@linux.intel.com>
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

No functionality change, only add indirection for link power
management helpers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 23 +++++++++++++----------
 drivers/soundwire/intel.h           | 14 ++++++++++++++
 include/linux/soundwire/sdw_intel.h |  5 +++++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 6d2fdf3a01fd..2320f1b8a2d1 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1434,6 +1434,9 @@ const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops = {
 	.start_bus_after_clock_stop = intel_start_bus_after_clock_stop,
 	.stop_bus = intel_stop_bus,
 
+	.link_power_up = intel_link_power_up,
+	.link_power_down = intel_link_power_down,
+
 	.pre_bank_switch = intel_pre_bank_switch,
 	.post_bank_switch = intel_post_bank_switch,
 };
@@ -1614,7 +1617,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	bus->multi_link = multi_link;
 
 	/* Initialize shim, controller */
-	ret = intel_link_power_up(sdw);
+	ret = sdw_intel_link_power_up(sdw);
 	if (ret)
 		goto err_init;
 
@@ -1679,7 +1682,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	return 0;
 
 err_power_up:
-	intel_link_power_down(sdw);
+	sdw_intel_link_power_down(sdw);
 err_init:
 	return ret;
 }
@@ -1935,7 +1938,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 			pm_runtime_idle(dev);
 	}
 
-	ret = intel_link_power_up(sdw);
+	ret = sdw_intel_link_power_up(sdw);
 	if (ret) {
 		dev_err(dev, "%s failed: %d\n", __func__, ret);
 		return ret;
@@ -1950,7 +1953,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 	ret = sdw_intel_start_bus(sdw);
 	if (ret < 0) {
 		dev_err(dev, "cannot start bus during resume\n");
-		intel_link_power_down(sdw);
+		sdw_intel_link_power_down(sdw);
 		return ret;
 	}
 
@@ -1989,7 +1992,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 
 	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
-		ret = intel_link_power_up(sdw);
+		ret = sdw_intel_link_power_up(sdw);
 		if (ret) {
 			dev_err(dev, "%s: power_up failed after teardown: %d\n", __func__, ret);
 			return ret;
@@ -2004,13 +2007,13 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 		ret = sdw_intel_start_bus(sdw);
 		if (ret < 0) {
 			dev_err(dev, "%s: cannot start bus after teardown: %d\n", __func__, ret);
-			intel_link_power_down(sdw);
+			sdw_intel_link_power_down(sdw);
 			return ret;
 		}
 
 
 	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
-		ret = intel_link_power_up(sdw);
+		ret = sdw_intel_link_power_up(sdw);
 		if (ret) {
 			dev_err(dev, "%s: power_up failed after bus reset: %d\n", __func__, ret);
 			return ret;
@@ -2019,14 +2022,14 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 		ret = sdw_intel_start_bus_after_reset(sdw);
 		if (ret < 0) {
 			dev_err(dev, "%s: cannot start bus after reset: %d\n", __func__, ret);
-			intel_link_power_down(sdw);
+			sdw_intel_link_power_down(sdw);
 			return ret;
 		}
 	} else if (!clock_stop_quirks) {
 
 		sdw_intel_check_clock_stop(sdw);
 
-		ret = intel_link_power_up(sdw);
+		ret = sdw_intel_link_power_up(sdw);
 		if (ret) {
 			dev_err(dev, "%s: power_up failed: %d\n", __func__, ret);
 			return ret;
@@ -2035,7 +2038,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 		ret = sdw_intel_start_bus_after_clock_stop(sdw);
 		if (ret < 0) {
 			dev_err(dev, "%s: cannot start bus after clock stop: %d\n", __func__, ret);
-			intel_link_power_down(sdw);
+			sdw_intel_link_power_down(sdw);
 			return ret;
 		}
 	} else {
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 99a2d875a331..0f63e7584132 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -118,4 +118,18 @@ static inline int sdw_intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
 	return -ENOTSUPP;
 }
 
+static inline int sdw_intel_link_power_up(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, link_power_up))
+		return SDW_INTEL_OPS(sdw, link_power_up)(sdw);
+	return -ENOTSUPP;
+}
+
+static inline int sdw_intel_link_power_down(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, link_power_down))
+		return SDW_INTEL_OPS(sdw, link_power_down)(sdw);
+	return -ENOTSUPP;
+}
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index cee61bc9af8a..81430201b8b9 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -305,6 +305,8 @@ struct sdw_intel;
  * @start_bus_after_reset: start after reset
  * @start_bus_after_clock_stop: start after mode0 clock stop
  * @stop_bus: stop all bus
+ * @link_power_up: power-up using chip-specific helpers
+ * @link_power_down: power-down with chip-specific helpers
  * @pre_bank_switch: helper for bus management
  * @post_bank_switch: helper for bus management
  */
@@ -320,6 +322,9 @@ struct sdw_intel_hw_ops {
 	int (*start_bus_after_clock_stop)(struct sdw_intel *sdw);
 	int (*stop_bus)(struct sdw_intel *sdw, bool clock_stop);
 
+	int (*link_power_up)(struct sdw_intel *sdw);
+	int (*link_power_down)(struct sdw_intel *sdw);
+
 	int (*pre_bank_switch)(struct sdw_intel *sdw);
 	int (*post_bank_switch)(struct sdw_intel *sdw);
 };
-- 
2.25.1

