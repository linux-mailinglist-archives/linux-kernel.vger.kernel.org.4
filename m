Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377B85BD41D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiISRvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiISRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:51:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C7243E62
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609860; x=1695145860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g9GpV0D8iiL8DS1/b9l/HN2tHUJ93url3w8XnhgEB1k=;
  b=DbNbq64RbycltJ0mi2Rb3iYhUdrmpkcC9YCcKcxZwq+Kd9oX5Zwo6nEw
   CLu/3Fv5cSSft4nMxaoxTH+V3uCAGmZ5by/rikTR2RcI1Ym4Y1L4PGBUb
   WNDhLBGorCK//MjzqnSkQF4v198w+R/s+vTvClxAN85Jly27OK7rZpN0d
   /KvpTxvDDp9ybl474mdeEPsP1+TnjpyJh6qOVLq6arfZ+KhG+7rv4McRU
   uHjNlQKnYjiDv7FhiWvNW68JLAzulEx+zNY1RC6KzyHgcivSEtsQS50ne
   a1SAi9LH2UtRijXjhl+kepbryxS4esVoV893l9CE1RViNORy/OiNmmjMY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363429355"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363429355"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863658612"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:57 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 10/11] soundwire: intel: introduce helpers to start bus
Date:   Tue, 20 Sep 2022 01:57:20 +0800
Message-Id: <20220919175721.354679-11-yung-chuan.liao@linux.intel.com>
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

There are 3 different sequences to start the bus, let's move the
functionality to helpers.

There should be no functionality change, except in error cases where
the flow is improved with more consistent disabling of interrupts and
powering down.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 388 +++++++++++++++++++-------------------
 1 file changed, 195 insertions(+), 193 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 2ca924622153..abe14436d874 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1223,6 +1223,174 @@ static int intel_register_dai(struct sdw_intel *sdw)
 					       dais, num_dai);
 }
 
+static int intel_start_bus(struct sdw_intel *sdw)
+{
+	struct device *dev = sdw->cdns.dev;
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_bus *bus = &cdns->bus;
+	int ret;
+
+	ret = sdw_cdns_enable_interrupt(cdns, true);
+	if (ret < 0) {
+		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
+		return ret;
+	}
+
+	/*
+	 * follow recommended programming flows to avoid timeouts when
+	 * gsync is enabled
+	 */
+	if (bus->multi_link)
+		intel_shim_sync_arm(sdw);
+
+	ret = sdw_cdns_init(cdns);
+	if (ret < 0) {
+		dev_err(dev, "%s: unable to initialize Cadence IP: %d\n", __func__, ret);
+		goto err_interrupt;
+	}
+
+	ret = sdw_cdns_exit_reset(cdns);
+	if (ret < 0) {
+		dev_err(dev, "%s: unable to exit bus reset sequence: %d\n", __func__, ret);
+		goto err_interrupt;
+	}
+
+	if (bus->multi_link) {
+		ret = intel_shim_sync_go(sdw);
+		if (ret < 0) {
+			dev_err(dev, "%s: sync go failed: %d\n", __func__, ret);
+			goto err_interrupt;
+		}
+	}
+	sdw_cdns_check_self_clearing_bits(cdns, __func__,
+					  true, INTEL_MASTER_RESET_ITERATIONS);
+
+	return 0;
+
+err_interrupt:
+	sdw_cdns_enable_interrupt(cdns, false);
+	return ret;
+}
+
+static int intel_start_bus_after_reset(struct sdw_intel *sdw)
+{
+	struct device *dev = sdw->cdns.dev;
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_bus *bus = &cdns->bus;
+	bool clock_stop0;
+	int status;
+	int ret;
+
+	/*
+	 * An exception condition occurs for the CLK_STOP_BUS_RESET
+	 * case if one or more masters remain active. In this condition,
+	 * all the masters are powered on for they are in the same power
+	 * domain. Master can preserve its context for clock stop0, so
+	 * there is no need to clear slave status and reset bus.
+	 */
+	clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
+
+	if (!clock_stop0) {
+
+		/*
+		 * make sure all Slaves are tagged as UNATTACHED and
+		 * provide reason for reinitialization
+		 */
+
+		status = SDW_UNATTACH_REQUEST_MASTER_RESET;
+		sdw_clear_slave_status(bus, status);
+
+		ret = sdw_cdns_enable_interrupt(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "cannot enable interrupts during resume\n");
+			return ret;
+		}
+
+		/*
+		 * follow recommended programming flows to avoid
+		 * timeouts when gsync is enabled
+		 */
+		if (bus->multi_link)
+			intel_shim_sync_arm(sdw);
+
+		/*
+		 * Re-initialize the IP since it was powered-off
+		 */
+		sdw_cdns_init(&sdw->cdns);
+
+	} else {
+		ret = sdw_cdns_enable_interrupt(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "cannot enable interrupts during resume\n");
+			return ret;
+		}
+	}
+
+	ret = sdw_cdns_clock_restart(cdns, !clock_stop0);
+	if (ret < 0) {
+		dev_err(dev, "unable to restart clock during resume\n");
+		goto err_interrupt;
+	}
+
+	if (!clock_stop0) {
+		ret = sdw_cdns_exit_reset(cdns);
+		if (ret < 0) {
+			dev_err(dev, "unable to exit bus reset sequence during resume\n");
+			goto err_interrupt;
+		}
+
+		if (bus->multi_link) {
+			ret = intel_shim_sync_go(sdw);
+			if (ret < 0) {
+				dev_err(sdw->cdns.dev, "sync go failed during resume\n");
+				goto err_interrupt;
+			}
+		}
+	}
+	sdw_cdns_check_self_clearing_bits(cdns, __func__, true, INTEL_MASTER_RESET_ITERATIONS);
+
+	return 0;
+
+err_interrupt:
+	sdw_cdns_enable_interrupt(cdns, false);
+	return ret;
+}
+
+static void intel_check_clock_stop(struct sdw_intel *sdw)
+{
+	struct device *dev = sdw->cdns.dev;
+	bool clock_stop0;
+
+	clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
+	if (!clock_stop0)
+		dev_err(dev, "%s: invalid configuration, clock was not stopped\n", __func__);
+}
+
+static int intel_start_bus_after_clock_stop(struct sdw_intel *sdw)
+{
+	struct device *dev = sdw->cdns.dev;
+	struct sdw_cdns *cdns = &sdw->cdns;
+	int ret;
+
+	ret = sdw_cdns_enable_interrupt(cdns, true);
+	if (ret < 0) {
+		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = sdw_cdns_clock_restart(cdns, false);
+	if (ret < 0) {
+		dev_err(dev, "%s: unable to restart clock: %d\n", __func__, ret);
+		sdw_cdns_enable_interrupt(cdns, false);
+		return ret;
+	}
+
+	sdw_cdns_check_self_clearing_bits(cdns, "intel_resume_runtime no_quirks",
+					  true, INTEL_MASTER_RESET_ITERATIONS);
+
+	return 0;
+}
+
 static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 {
 	struct sdw_master_prop *prop = &bus->prop;
@@ -1368,7 +1536,6 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
 	if (!multi_link) {
 		dev_dbg(dev, "Multi-link is disabled\n");
-		bus->multi_link = false;
 	} else {
 		/*
 		 * hardware-based synchronization is required regardless
@@ -1376,9 +1543,9 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 		 * synchronization is gated by gsync when the multi-master
 		 * mode is set.
 		 */
-		bus->multi_link = true;
 		bus->hw_sync_min_links = 1;
 	}
+	bus->multi_link = multi_link;
 
 	/* Initialize shim, controller */
 	ret = intel_link_power_up(sdw);
@@ -1389,46 +1556,18 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	ret = intel_register_dai(sdw);
 	if (ret) {
 		dev_err(dev, "DAI registration failed: %d\n", ret);
-		goto err_init;
+		goto err_power_up;
 	}
 
 	intel_debugfs_init(sdw);
 
-	ret = sdw_cdns_enable_interrupt(cdns, true);
-	if (ret < 0) {
-		dev_err(dev, "cannot enable interrupts\n");
-		goto err_init;
+	/* start bus */
+	ret = intel_start_bus(sdw);
+	if (ret) {
+		dev_err(dev, "bus start failed: %d\n", ret);
+		goto err_power_up;
 	}
 
-	/*
-	 * follow recommended programming flows to avoid timeouts when
-	 * gsync is enabled
-	 */
-	if (multi_link)
-		intel_shim_sync_arm(sdw);
-
-	ret = sdw_cdns_init(cdns);
-	if (ret < 0) {
-		dev_err(dev, "unable to initialize Cadence IP\n");
-		goto err_interrupt;
-	}
-
-	ret = sdw_cdns_exit_reset(cdns);
-	if (ret < 0) {
-		dev_err(dev, "unable to exit bus reset sequence\n");
-		goto err_interrupt;
-	}
-
-	if (multi_link) {
-		ret = intel_shim_sync_go(sdw);
-		if (ret < 0) {
-			dev_err(dev, "sync go failed: %d\n", ret);
-			goto err_interrupt;
-		}
-	}
-	sdw_cdns_check_self_clearing_bits(cdns, __func__,
-					  true, INTEL_MASTER_RESET_ITERATIONS);
-
 	/* Enable runtime PM */
 	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME)) {
 		pm_runtime_set_autosuspend_delay(dev,
@@ -1473,8 +1612,8 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	sdw->startup_done = true;
 	return 0;
 
-err_interrupt:
-	sdw_cdns_enable_interrupt(cdns, false);
+err_power_up:
+	intel_link_power_down(sdw);
 err_init:
 	return ret;
 }
@@ -1738,7 +1877,6 @@ static int __maybe_unused intel_resume(struct device *dev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 	int link_flags;
-	bool multi_link;
 	int ret;
 
 	if (bus->prop.hw_disabled || !sdw->startup_done) {
@@ -1748,7 +1886,6 @@ static int __maybe_unused intel_resume(struct device *dev)
 	}
 
 	link_flags = md_flags >> (bus->link_id * 8);
-	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
 
 	if (pm_runtime_suspended(dev)) {
 		dev_dbg(dev, "pm_runtime status was suspended, forcing active\n");
@@ -1777,41 +1914,13 @@ static int __maybe_unused intel_resume(struct device *dev)
 	 */
 	sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
 
-	ret = sdw_cdns_enable_interrupt(cdns, true);
+	ret = intel_start_bus(sdw);
 	if (ret < 0) {
-		dev_err(dev, "cannot enable interrupts during resume\n");
+		dev_err(dev, "cannot start bus during resume\n");
+		intel_link_power_down(sdw);
 		return ret;
 	}
 
-	/*
-	 * follow recommended programming flows to avoid timeouts when
-	 * gsync is enabled
-	 */
-	if (multi_link)
-		intel_shim_sync_arm(sdw);
-
-	ret = sdw_cdns_init(&sdw->cdns);
-	if (ret < 0) {
-		dev_err(dev, "unable to initialize Cadence IP during resume\n");
-		return ret;
-	}
-
-	ret = sdw_cdns_exit_reset(cdns);
-	if (ret < 0) {
-		dev_err(dev, "unable to exit bus reset sequence during resume\n");
-		return ret;
-	}
-
-	if (multi_link) {
-		ret = intel_shim_sync_go(sdw);
-		if (ret < 0) {
-			dev_err(dev, "sync go failed during resume\n");
-			return ret;
-		}
-	}
-	sdw_cdns_check_self_clearing_bits(cdns, __func__,
-					  true, INTEL_MASTER_RESET_ITERATIONS);
-
 	/*
 	 * after system resume, the pm_runtime suspend() may kick in
 	 * during the enumeration, before any children device force the
@@ -1824,7 +1933,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 	 */
 	pm_runtime_mark_last_busy(dev);
 
-	return ret;
+	return 0;
 }
 
 static int __maybe_unused intel_resume_runtime(struct device *dev)
@@ -1833,10 +1942,6 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
 	u32 clock_stop_quirks;
-	bool clock_stop0;
-	int link_flags;
-	bool multi_link;
-	int status;
 	int ret;
 
 	if (bus->prop.hw_disabled || !sdw->startup_done) {
@@ -1848,15 +1953,12 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 	/* unconditionally disable WAKEEN interrupt */
 	intel_shim_wake(sdw, false);
 
-	link_flags = md_flags >> (bus->link_id * 8);
-	multi_link = !(link_flags & SDW_INTEL_MASTER_DISABLE_MULTI_LINK);
-
 	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 
 	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
 		ret = intel_link_power_up(sdw);
 		if (ret) {
-			dev_err(dev, "%s failed: %d\n", __func__, ret);
+			dev_err(dev, "%s: power_up failed after teardown: %d\n", __func__, ret);
 			return ret;
 		}
 
@@ -1866,145 +1968,45 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 		 */
 		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
 
-		ret = sdw_cdns_enable_interrupt(cdns, true);
+		ret = intel_start_bus(sdw);
 		if (ret < 0) {
-			dev_err(dev, "cannot enable interrupts during resume\n");
+			dev_err(dev, "%s: cannot start bus after teardown: %d\n", __func__, ret);
+			intel_link_power_down(sdw);
 			return ret;
 		}
 
-		/*
-		 * follow recommended programming flows to avoid
-		 * timeouts when gsync is enabled
-		 */
-		if (multi_link)
-			intel_shim_sync_arm(sdw);
-
-		ret = sdw_cdns_init(&sdw->cdns);
-		if (ret < 0) {
-			dev_err(dev, "unable to initialize Cadence IP during resume\n");
-			return ret;
-		}
-
-		ret = sdw_cdns_exit_reset(cdns);
-		if (ret < 0) {
-			dev_err(dev, "unable to exit bus reset sequence during resume\n");
-			return ret;
-		}
-
-		if (multi_link) {
-			ret = intel_shim_sync_go(sdw);
-			if (ret < 0) {
-				dev_err(dev, "sync go failed during resume\n");
-				return ret;
-			}
-		}
-		sdw_cdns_check_self_clearing_bits(cdns, "intel_resume_runtime TEARDOWN",
-						  true, INTEL_MASTER_RESET_ITERATIONS);
 
 	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
 		ret = intel_link_power_up(sdw);
 		if (ret) {
-			dev_err(dev, "%s failed: %d\n", __func__, ret);
+			dev_err(dev, "%s: power_up failed after bus reset: %d\n", __func__, ret);
 			return ret;
 		}
 
-		/*
-		 * An exception condition occurs for the CLK_STOP_BUS_RESET
-		 * case if one or more masters remain active. In this condition,
-		 * all the masters are powered on for they are in the same power
-		 * domain. Master can preserve its context for clock stop0, so
-		 * there is no need to clear slave status and reset bus.
-		 */
-		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
-
-		if (!clock_stop0) {
-
-			/*
-			 * make sure all Slaves are tagged as UNATTACHED and
-			 * provide reason for reinitialization
-			 */
-
-			status = SDW_UNATTACH_REQUEST_MASTER_RESET;
-			sdw_clear_slave_status(bus, status);
-
-			ret = sdw_cdns_enable_interrupt(cdns, true);
-			if (ret < 0) {
-				dev_err(dev, "cannot enable interrupts during resume\n");
-				return ret;
-			}
-
-			/*
-			 * follow recommended programming flows to avoid
-			 * timeouts when gsync is enabled
-			 */
-			if (multi_link)
-				intel_shim_sync_arm(sdw);
-
-			/*
-			 * Re-initialize the IP since it was powered-off
-			 */
-			sdw_cdns_init(&sdw->cdns);
-
-		} else {
-			ret = sdw_cdns_enable_interrupt(cdns, true);
-			if (ret < 0) {
-				dev_err(dev, "cannot enable interrupts during resume\n");
-				return ret;
-			}
-		}
-
-		ret = sdw_cdns_clock_restart(cdns, !clock_stop0);
+		ret = intel_start_bus_after_reset(sdw);
 		if (ret < 0) {
-			dev_err(dev, "unable to restart clock during resume\n");
+			dev_err(dev, "%s: cannot start bus after reset: %d\n", __func__, ret);
+			intel_link_power_down(sdw);
 			return ret;
 		}
-
-		if (!clock_stop0) {
-			ret = sdw_cdns_exit_reset(cdns);
-			if (ret < 0) {
-				dev_err(dev, "unable to exit bus reset sequence during resume\n");
-				return ret;
-			}
-
-			if (multi_link) {
-				ret = intel_shim_sync_go(sdw);
-				if (ret < 0) {
-					dev_err(sdw->cdns.dev, "sync go failed during resume\n");
-					return ret;
-				}
-			}
-		}
-		sdw_cdns_check_self_clearing_bits(cdns, "intel_resume_runtime BUS_RESET",
-						  true, INTEL_MASTER_RESET_ITERATIONS);
-
 	} else if (!clock_stop_quirks) {
 
-		clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
-		if (!clock_stop0)
-			dev_err(dev, "%s invalid configuration, clock was not stopped", __func__);
+		intel_check_clock_stop(sdw);
 
 		ret = intel_link_power_up(sdw);
 		if (ret) {
-			dev_err(dev, "%s failed: %d\n", __func__, ret);
+			dev_err(dev, "%s: power_up failed: %d\n", __func__, ret);
 			return ret;
 		}
 
-		ret = sdw_cdns_enable_interrupt(cdns, true);
+		ret = intel_start_bus_after_clock_stop(sdw);
 		if (ret < 0) {
-			dev_err(dev, "cannot enable interrupts during resume\n");
+			dev_err(dev, "%s: cannot start bus after clock stop: %d\n", __func__, ret);
+			intel_link_power_down(sdw);
 			return ret;
 		}
-
-		ret = sdw_cdns_clock_restart(cdns, false);
-		if (ret < 0) {
-			dev_err(dev, "unable to resume master during resume\n");
-			return ret;
-		}
-
-		sdw_cdns_check_self_clearing_bits(cdns, "intel_resume_runtime no_quirks",
-						  true, INTEL_MASTER_RESET_ITERATIONS);
 	} else {
-		dev_err(dev, "%s clock_stop_quirks %x unsupported\n",
+		dev_err(dev, "%s: clock_stop_quirks %x unsupported\n",
 			__func__, clock_stop_quirks);
 		ret = -EINVAL;
 	}
-- 
2.25.1

