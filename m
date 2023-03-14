Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43816B87C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCNBlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCNBl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41CD7431C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758085; x=1710294085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vepzt9Zc2Bh5rbiChvEscf+RR1gwoyN+wIZaDpk0cM4=;
  b=Q/yhQcy8jZK49IWmUjBE6XzuVENgLZMHfkGRRmkItu/3rQ5stH8tglwM
   YAPSyffPduxQIkcpVSXp03rUC8S8vaCst50qnZyMSVQIJMs4Dbdydvyhj
   MzsluVOw6H7dh+RauoWLt0sV+QLacrxNcUA1MzYA9rWOZo/o1CtfAqtCs
   03Rc4yOtolcR17e7GyFdZZ3LKJVr/aPx0TTcIio3YjfU9YEGpV2V1NHJK
   qETm1Q/1m5gwoEHiyHU81PXrdT+P9BoxGFohoVNyQz52kU95GPA7rGXal
   wqLTtilLVwoJxGV9v4TPI1QuTgjs+z1hvFvBI2WyREr/cO50PphpL19cE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949265"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949265"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327459"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327459"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:20 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 08/16] soundwire: intel: move bus common sequences to different file
Date:   Tue, 14 Mar 2023 09:54:02 +0800
Message-Id: <20230314015410.487311-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
References: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Now that the bus start/stop/clock_stop sequences use the ops, we can
move them to a different file to reuse them.

Note that we could in theory remove the abstraction for all those
sequences and directly call the functions in intel_auxdevice.c. To
allow for more flexibility and have means to special-case new
platforms, we decided to keep the abstraction. If in time it becomes
clear there is no benefit the abstraction will be simplified.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/Makefile           |   3 +-
 drivers/soundwire/intel.c            | 199 -------------------------
 drivers/soundwire/intel.h            |   7 +
 drivers/soundwire/intel_bus_common.c | 210 +++++++++++++++++++++++++++
 4 files changed, 219 insertions(+), 200 deletions(-)
 create mode 100644 drivers/soundwire/intel_bus_common.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index ca97414ada70..8038e840ac5b 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -20,7 +20,8 @@ soundwire-cadence-y := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
 
 #Intel driver
-soundwire-intel-y :=	intel.o intel_auxdevice.o intel_init.o dmi-quirks.o
+soundwire-intel-y :=	intel.o intel_auxdevice.o intel_init.o dmi-quirks.o \
+			intel_bus_common.o
 obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
 
 #Qualcomm driver
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 8395a20e5739..77d698908595 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1122,205 +1122,6 @@ static int intel_register_dai(struct sdw_intel *sdw)
 					       dais, num_dai);
 }
 
-static int intel_start_bus(struct sdw_intel *sdw)
-{
-	struct device *dev = sdw->cdns.dev;
-	struct sdw_cdns *cdns = &sdw->cdns;
-	struct sdw_bus *bus = &cdns->bus;
-	int ret;
-
-	ret = sdw_cdns_enable_interrupt(cdns, true);
-	if (ret < 0) {
-		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
-		return ret;
-	}
-
-	/*
-	 * follow recommended programming flows to avoid timeouts when
-	 * gsync is enabled
-	 */
-	if (bus->multi_link)
-		sdw_intel_sync_arm(sdw);
-
-	ret = sdw_cdns_init(cdns);
-	if (ret < 0) {
-		dev_err(dev, "%s: unable to initialize Cadence IP: %d\n", __func__, ret);
-		goto err_interrupt;
-	}
-
-	ret = sdw_cdns_exit_reset(cdns);
-	if (ret < 0) {
-		dev_err(dev, "%s: unable to exit bus reset sequence: %d\n", __func__, ret);
-		goto err_interrupt;
-	}
-
-	if (bus->multi_link) {
-		ret = sdw_intel_sync_go(sdw);
-		if (ret < 0) {
-			dev_err(dev, "%s: sync go failed: %d\n", __func__, ret);
-			goto err_interrupt;
-		}
-	}
-	sdw_cdns_check_self_clearing_bits(cdns, __func__,
-					  true, INTEL_MASTER_RESET_ITERATIONS);
-
-	return 0;
-
-err_interrupt:
-	sdw_cdns_enable_interrupt(cdns, false);
-	return ret;
-}
-
-static int intel_start_bus_after_reset(struct sdw_intel *sdw)
-{
-	struct device *dev = sdw->cdns.dev;
-	struct sdw_cdns *cdns = &sdw->cdns;
-	struct sdw_bus *bus = &cdns->bus;
-	bool clock_stop0;
-	int status;
-	int ret;
-
-	/*
-	 * An exception condition occurs for the CLK_STOP_BUS_RESET
-	 * case if one or more masters remain active. In this condition,
-	 * all the masters are powered on for they are in the same power
-	 * domain. Master can preserve its context for clock stop0, so
-	 * there is no need to clear slave status and reset bus.
-	 */
-	clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
-
-	if (!clock_stop0) {
-
-		/*
-		 * make sure all Slaves are tagged as UNATTACHED and
-		 * provide reason for reinitialization
-		 */
-
-		status = SDW_UNATTACH_REQUEST_MASTER_RESET;
-		sdw_clear_slave_status(bus, status);
-
-		ret = sdw_cdns_enable_interrupt(cdns, true);
-		if (ret < 0) {
-			dev_err(dev, "cannot enable interrupts during resume\n");
-			return ret;
-		}
-
-		/*
-		 * follow recommended programming flows to avoid
-		 * timeouts when gsync is enabled
-		 */
-		if (bus->multi_link)
-			sdw_intel_sync_arm(sdw);
-
-		/*
-		 * Re-initialize the IP since it was powered-off
-		 */
-		sdw_cdns_init(&sdw->cdns);
-
-	} else {
-		ret = sdw_cdns_enable_interrupt(cdns, true);
-		if (ret < 0) {
-			dev_err(dev, "cannot enable interrupts during resume\n");
-			return ret;
-		}
-	}
-
-	ret = sdw_cdns_clock_restart(cdns, !clock_stop0);
-	if (ret < 0) {
-		dev_err(dev, "unable to restart clock during resume\n");
-		goto err_interrupt;
-	}
-
-	if (!clock_stop0) {
-		ret = sdw_cdns_exit_reset(cdns);
-		if (ret < 0) {
-			dev_err(dev, "unable to exit bus reset sequence during resume\n");
-			goto err_interrupt;
-		}
-
-		if (bus->multi_link) {
-			ret = sdw_intel_sync_go(sdw);
-			if (ret < 0) {
-				dev_err(sdw->cdns.dev, "sync go failed during resume\n");
-				goto err_interrupt;
-			}
-		}
-	}
-	sdw_cdns_check_self_clearing_bits(cdns, __func__, true, INTEL_MASTER_RESET_ITERATIONS);
-
-	return 0;
-
-err_interrupt:
-	sdw_cdns_enable_interrupt(cdns, false);
-	return ret;
-}
-
-static void intel_check_clock_stop(struct sdw_intel *sdw)
-{
-	struct device *dev = sdw->cdns.dev;
-	bool clock_stop0;
-
-	clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
-	if (!clock_stop0)
-		dev_err(dev, "%s: invalid configuration, clock was not stopped\n", __func__);
-}
-
-static int intel_start_bus_after_clock_stop(struct sdw_intel *sdw)
-{
-	struct device *dev = sdw->cdns.dev;
-	struct sdw_cdns *cdns = &sdw->cdns;
-	int ret;
-
-	ret = sdw_cdns_enable_interrupt(cdns, true);
-	if (ret < 0) {
-		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
-		return ret;
-	}
-
-	ret = sdw_cdns_clock_restart(cdns, false);
-	if (ret < 0) {
-		dev_err(dev, "%s: unable to restart clock: %d\n", __func__, ret);
-		sdw_cdns_enable_interrupt(cdns, false);
-		return ret;
-	}
-
-	sdw_cdns_check_self_clearing_bits(cdns, "intel_resume_runtime no_quirks",
-					  true, INTEL_MASTER_RESET_ITERATIONS);
-
-	return 0;
-}
-
-static int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
-{
-	struct device *dev = sdw->cdns.dev;
-	struct sdw_cdns *cdns = &sdw->cdns;
-	bool wake_enable = false;
-	int ret;
-
-	if (clock_stop) {
-		ret = sdw_cdns_clock_stop(cdns, true);
-		if (ret < 0)
-			dev_err(dev, "%s: cannot stop clock: %d\n", __func__, ret);
-		else
-			wake_enable = true;
-	}
-
-	ret = sdw_cdns_enable_interrupt(cdns, false);
-	if (ret < 0) {
-		dev_err(dev, "%s: cannot disable interrupts: %d\n", __func__, ret);
-		return ret;
-	}
-
-	ret = sdw_intel_link_power_down(sdw);
-	if (ret) {
-		dev_err(dev, "%s: Link power down failed: %d\n", __func__, ret);
-		return ret;
-	}
-
-	sdw_intel_shim_wake(sdw, wake_enable);
-
-	return 0;
-}
 
 const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops = {
 	.debugfs_init = intel_debugfs_init,
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 28b21a92e28b..abd1a500defa 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -187,4 +187,11 @@ static inline int sdw_intel_sync_go(struct sdw_intel *sdw)
 	return -ENOTSUPP;
 }
 
+/* common bus management */
+int intel_start_bus(struct sdw_intel *sdw);
+int intel_start_bus_after_reset(struct sdw_intel *sdw);
+void intel_check_clock_stop(struct sdw_intel *sdw);
+int intel_start_bus_after_clock_stop(struct sdw_intel *sdw);
+int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop);
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
new file mode 100644
index 000000000000..9a06ab58018b
--- /dev/null
+++ b/drivers/soundwire/intel_bus_common.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+// Copyright(c) 2015-2023 Intel Corporation. All rights reserved.
+
+#include <linux/acpi.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_intel.h>
+#include "cadence_master.h"
+#include "bus.h"
+#include "intel.h"
+
+int intel_start_bus(struct sdw_intel *sdw)
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
+		sdw_intel_sync_arm(sdw);
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
+		ret = sdw_intel_sync_go(sdw);
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
+int intel_start_bus_after_reset(struct sdw_intel *sdw)
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
+			sdw_intel_sync_arm(sdw);
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
+			ret = sdw_intel_sync_go(sdw);
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
+void intel_check_clock_stop(struct sdw_intel *sdw)
+{
+	struct device *dev = sdw->cdns.dev;
+	bool clock_stop0;
+
+	clock_stop0 = sdw_cdns_is_clock_stop(&sdw->cdns);
+	if (!clock_stop0)
+		dev_err(dev, "%s: invalid configuration, clock was not stopped\n", __func__);
+}
+
+int intel_start_bus_after_clock_stop(struct sdw_intel *sdw)
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
+int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
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
+	ret = sdw_intel_link_power_down(sdw);
+	if (ret) {
+		dev_err(dev, "%s: Link power down failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	sdw_intel_shim_wake(sdw, wake_enable);
+
+	return 0;
+}
-- 
2.25.1

