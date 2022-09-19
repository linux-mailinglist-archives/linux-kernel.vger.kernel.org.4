Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7015BD41B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiISRvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiISRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:51:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA35C45064
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609862; x=1695145862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c6tZxuELr4NSU9kuMAkq1H8+mPlH4jFBJzfU4tnhLOg=;
  b=cfdVeli3rU3J+kuoqP1EyQqtKF+H0cl8Q8twK4nYfMzDjdnVz0VbZaCK
   SJYL0IFoxOM/NM04neyu8t+ao8mBlq2i31HhvJQl3CjoL7NxoFKuYqeT7
   rBJ9EZs//kY1r32oSSOecXmkn+MsFe8uFNa1bfqwezHkBX7yMJ8MMPV+9
   DihohPlNrqzuTsqoepbqQzJyKxky6qsgLfWj31t10KkBlaBHKWXi9AaLa
   MpjyZEFBUvovy772TiQoss0LqY5D35f/AJsjg78OIfhP8s5HCnphoLfMF
   tjZS0C/P2Rs+hebHq8PVj/Yv0WXFogL7IFxvXdkNQhsP4S5OZgopMk2rO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363429385"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363429385"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:51:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863658636"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:59 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 11/11] soundwire: intel: add helper to stop bus
Date:   Tue, 20 Sep 2022 01:57:21 +0800
Message-Id: <20220919175721.354679-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919175721.354679-1-yung-chuan.liao@linux.intel.com>
References: <20220919175721.354679-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We have three nearly identical sequences to stop the clock, let's
introduce a helper to reuse the same code.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 83 +++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 42 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index abe14436d874..15fe083e0402 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1391,6 +1391,38 @@ static int intel_start_bus_after_clock_stop(struct sdw_intel *sdw)
 	return 0;
 }
 
+static int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
+{
+	struct device *dev = sdw->cdns.dev;
+	struct sdw_cdns *cdns = &sdw->cdns;
+	bool wake_enable = false;
+	int ret;
+
+	if (clock_stop) {
+		ret = sdw_cdns_clock_stop(cdns, true);
+		if (ret < 0)
+			dev_err(dev, "%s: cannot stop clock: %d\n", __func__, ret);
+		else
+			wake_enable = true;
+	}
+
+	ret = sdw_cdns_enable_interrupt(cdns, false);
+	if (ret < 0) {
+		dev_err(dev, "%s: cannot disable interrupts: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = intel_link_power_down(sdw);
+	if (ret) {
+		dev_err(dev, "%s: Link power down failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	intel_shim_wake(sdw, wake_enable);
+
+	return 0;
+}
+
 static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 {
 	struct sdw_master_prop *prop = &bus->prop;
@@ -1790,20 +1822,12 @@ static int __maybe_unused intel_suspend(struct device *dev)
 		return 0;
 	}
 
-	ret = sdw_cdns_enable_interrupt(cdns, false);
+	ret = intel_stop_bus(sdw, false);
 	if (ret < 0) {
-		dev_err(dev, "cannot disable interrupts on suspend\n");
+		dev_err(dev, "%s: cannot stop bus: %d\n", __func__, ret);
 		return ret;
 	}
 
-	ret = intel_link_power_down(sdw);
-	if (ret) {
-		dev_err(dev, "Link power down failed: %d\n", ret);
-		return ret;
-	}
-
-	intel_shim_wake(sdw, false);
-
 	return 0;
 }
 
@@ -1824,44 +1848,19 @@ static int __maybe_unused intel_suspend_runtime(struct device *dev)
 	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 
 	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
-
-		ret = sdw_cdns_enable_interrupt(cdns, false);
+		ret = intel_stop_bus(sdw, false);
 		if (ret < 0) {
-			dev_err(dev, "cannot disable interrupts on suspend\n");
+			dev_err(dev, "%s: cannot stop bus during teardown: %d\n",
+				__func__, ret);
 			return ret;
 		}
-
-		ret = intel_link_power_down(sdw);
-		if (ret) {
-			dev_err(dev, "Link power down failed: %d\n", ret);
-			return ret;
-		}
-
-		intel_shim_wake(sdw, false);
-
-	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET ||
-		   !clock_stop_quirks) {
-		bool wake_enable = true;
-
-		ret = sdw_cdns_clock_stop(cdns, true);
-		if (ret < 0) {
-			dev_err(dev, "cannot enable clock stop on suspend\n");
-			wake_enable = false;
-		}
-
-		ret = sdw_cdns_enable_interrupt(cdns, false);
+	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET || !clock_stop_quirks) {
+		ret = intel_stop_bus(sdw, true);
 		if (ret < 0) {
-			dev_err(dev, "cannot disable interrupts on suspend\n");
-			return ret;
-		}
-
-		ret = intel_link_power_down(sdw);
-		if (ret) {
-			dev_err(dev, "Link power down failed: %d\n", ret);
+			dev_err(dev, "%s: cannot stop bus during clock_stop: %d\n",
+				__func__, ret);
 			return ret;
 		}
-
-		intel_shim_wake(sdw, wake_enable);
 	} else {
 		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
 			__func__, clock_stop_quirks);
-- 
2.25.1

