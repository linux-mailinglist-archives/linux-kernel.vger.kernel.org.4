Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A8B7077FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjERCUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjERCUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:20:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C192137
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684376435; x=1715912435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sNFf0anZ290+Br3dbHkevwq9kWheG2VgMEYEnF9HzNg=;
  b=j8RwnUUZkGFbcmwaec1KCL+3WVDFCHCE/HF0L9FyFLbaGbfa8h8jKPkt
   2ls4VFo6KjIDASR+6AKmDAxv9DiXpBz/ubljbIIafnNRLP1shDMw2uDpw
   HOH0ZcU1hIgP2Fe4acdZhvXPeUw+4OLT5XvAtCWqejKB16j3Q8CQ+TPPH
   BzPs071H2H0iyUtCKbnP8dQsMMQpA8wxVQqtPIniWY2xCP+zUuxtmseEw
   mmOQSRp5WbBWit0bP5JA2odpvjt0nLUN5Hrv6kEWxDstfxlyIRDcaET/k
   /3rjogPuFVYBsrZwHUu2UrqAzklOb4HWdJbG2rTQBO7SxhI1TCFzENxHT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="336504765"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="336504765"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="826195213"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="826195213"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:20:33 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 1/3] soundwire: intel_bus_common: enable interrupts last
Date:   Thu, 18 May 2023 10:41:17 +0800
Message-Id: <20230518024119.164160-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518024119.164160-1-yung-chuan.liao@linux.intel.com>
References: <20230518024119.164160-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

It's not clear why we enabled interrupts in the Cadence IP first. The
logical programming sequence should be to first start the bus, and
only second to enable the interrupts.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_bus_common.c | 61 +++++++++++++---------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
index f180e3bea989..901d4f5736c1 100644
--- a/drivers/soundwire/intel_bus_common.c
+++ b/drivers/soundwire/intel_bus_common.c
@@ -16,12 +16,6 @@ int intel_start_bus(struct sdw_intel *sdw)
 	struct sdw_bus *bus = &cdns->bus;
 	int ret;
 
-	ret = sdw_cdns_enable_interrupt(cdns, true);
-	if (ret < 0) {
-		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
-		return ret;
-	}
-
 	/*
 	 * follow recommended programming flows to avoid timeouts when
 	 * gsync is enabled
@@ -32,30 +26,33 @@ int intel_start_bus(struct sdw_intel *sdw)
 	ret = sdw_cdns_init(cdns);
 	if (ret < 0) {
 		dev_err(dev, "%s: unable to initialize Cadence IP: %d\n", __func__, ret);
-		goto err_interrupt;
+		return ret;
 	}
 
 	ret = sdw_cdns_exit_reset(cdns);
 	if (ret < 0) {
 		dev_err(dev, "%s: unable to exit bus reset sequence: %d\n", __func__, ret);
-		goto err_interrupt;
+		return ret;
 	}
 
 	if (bus->multi_link) {
 		ret = sdw_intel_sync_go(sdw);
 		if (ret < 0) {
 			dev_err(dev, "%s: sync go failed: %d\n", __func__, ret);
-			goto err_interrupt;
+			return ret;
 		}
 	}
+
+	ret = sdw_cdns_enable_interrupt(cdns, true);
+	if (ret < 0) {
+		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
+		return ret;
+	}
+
 	sdw_cdns_check_self_clearing_bits(cdns, __func__,
 					  true, INTEL_MASTER_RESET_ITERATIONS);
 
 	return 0;
-
-err_interrupt:
-	sdw_cdns_enable_interrupt(cdns, false);
-	return ret;
 }
 
 int intel_start_bus_after_reset(struct sdw_intel *sdw)
@@ -86,12 +83,6 @@ int intel_start_bus_after_reset(struct sdw_intel *sdw)
 		status = SDW_UNATTACH_REQUEST_MASTER_RESET;
 		sdw_clear_slave_status(bus, status);
 
-		ret = sdw_cdns_enable_interrupt(cdns, true);
-		if (ret < 0) {
-			dev_err(dev, "cannot enable interrupts during resume\n");
-			return ret;
-		}
-
 		/*
 		 * follow recommended programming flows to avoid
 		 * timeouts when gsync is enabled
@@ -115,31 +106,36 @@ int intel_start_bus_after_reset(struct sdw_intel *sdw)
 	ret = sdw_cdns_clock_restart(cdns, !clock_stop0);
 	if (ret < 0) {
 		dev_err(dev, "unable to restart clock during resume\n");
-		goto err_interrupt;
+		if (!clock_stop0)
+			sdw_cdns_enable_interrupt(cdns, false);
+		return ret;
 	}
 
 	if (!clock_stop0) {
 		ret = sdw_cdns_exit_reset(cdns);
 		if (ret < 0) {
 			dev_err(dev, "unable to exit bus reset sequence during resume\n");
-			goto err_interrupt;
+			return ret;
 		}
 
 		if (bus->multi_link) {
 			ret = sdw_intel_sync_go(sdw);
 			if (ret < 0) {
 				dev_err(sdw->cdns.dev, "sync go failed during resume\n");
-				goto err_interrupt;
+				return ret;
 			}
 		}
+
+		ret = sdw_cdns_enable_interrupt(cdns, true);
+		if (ret < 0) {
+			dev_err(dev, "cannot enable interrupts during resume\n");
+			return ret;
+		}
+
 	}
 	sdw_cdns_check_self_clearing_bits(cdns, __func__, true, INTEL_MASTER_RESET_ITERATIONS);
 
 	return 0;
-
-err_interrupt:
-	sdw_cdns_enable_interrupt(cdns, false);
-	return ret;
 }
 
 void intel_check_clock_stop(struct sdw_intel *sdw)
@@ -158,16 +154,15 @@ int intel_start_bus_after_clock_stop(struct sdw_intel *sdw)
 	struct sdw_cdns *cdns = &sdw->cdns;
 	int ret;
 
-	ret = sdw_cdns_enable_interrupt(cdns, true);
-	if (ret < 0) {
-		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
-		return ret;
-	}
-
 	ret = sdw_cdns_clock_restart(cdns, false);
 	if (ret < 0) {
 		dev_err(dev, "%s: unable to restart clock: %d\n", __func__, ret);
-		sdw_cdns_enable_interrupt(cdns, false);
+		return ret;
+	}
+
+	ret = sdw_cdns_enable_interrupt(cdns, true);
+	if (ret < 0) {
+		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
 		return ret;
 	}
 
-- 
2.25.1

