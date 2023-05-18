Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E429A7077FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjERCUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjERCUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:20:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DA1210C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684376436; x=1715912436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CGSJ6BYZ+N5oz7mWJkH8v8GmgIqzQ0Y1D731giuwafc=;
  b=kqXlBA4NXeXAonStl2JuDUh7/uOTI1/1oH9bvesm8jWMTNah2Y3ygaDq
   v+padkvZ6oFc98xVXcIbQUuyhzYNWkNexCmMxoTWDrqAqmFfcSv23ce43
   hT9FrvrGQcR7JbUuLYpQ4L+gGinMqNWnsbDMxCyTikNFCcaRZcLP5oIQo
   oTmtluUl+915Ou/W29DJEg9FHW9u051dLzK5+Xl/kLy0en/zJQmQ/KVPo
   BnjXZeq8XmbxX+LYz98mULisV5qbJtM8AjV7NzsHC2jxTIddOHjuOteWc
   g4VyeLySDyuYfskqqy4izmQSK4wnJWnVpQrJe4iOsaTinjpUBR2Wir1CA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="336504774"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="336504774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="826195219"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="826195219"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:20:34 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 2/3] soundwire: intel/cadence: update hardware reset sequence
Date:   Thu, 18 May 2023 10:41:18 +0800
Message-Id: <20230518024119.164160-3-yung-chuan.liao@linux.intel.com>
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

Combining hardware reset with the multi-link mode leads to a shortened
hardware reset pattern observed on the bus.

The updated hardware programming sequence is to first enable the clock
with the sync_arm/sync_go pattern, and only in a second step to issue
the hardware reset sequence. Since there is no longer a dependency
between sync_arm/sync_go and hw_reset, the behavior of
sdw_cdns_exit_reset() is changed to wait for the self-clearing
CONFIG_UPDATE to go back to zero,

Link: https://github.com/thesofproject/linux/issues/4170
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c   | 31 ++++++++++++++++++------
 drivers/soundwire/cadence_master.h   |  3 +++
 drivers/soundwire/intel_bus_common.c | 36 ++++++++++++++++++++--------
 3 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 39502bc75712..58686ae50bbf 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -283,6 +283,29 @@ static int cdns_config_update(struct sdw_cdns *cdns)
 	return ret;
 }
 
+/**
+ * sdw_cdns_config_update() - Update configurations
+ * @cdns: Cadence instance
+ */
+void sdw_cdns_config_update(struct sdw_cdns *cdns)
+{
+	/* commit changes */
+	cdns_writel(cdns, CDNS_MCP_CONFIG_UPDATE, CDNS_MCP_CONFIG_UPDATE_BIT);
+}
+EXPORT_SYMBOL(sdw_cdns_config_update);
+
+/**
+ * sdw_cdns_config_update_set_wait() - wait until configuration update bit is self-cleared
+ * @cdns: Cadence instance
+ */
+int sdw_cdns_config_update_set_wait(struct sdw_cdns *cdns)
+{
+	/* the hardware recommendation is to wait at least 300us */
+	return cdns_set_wait(cdns, CDNS_MCP_CONFIG_UPDATE,
+			     CDNS_MCP_CONFIG_UPDATE_BIT, 0);
+}
+EXPORT_SYMBOL(sdw_cdns_config_update_set_wait);
+
 /*
  * debugfs
  */
@@ -1116,13 +1139,7 @@ int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
 		     CDNS_MCP_CONTROL_HW_RST);
 
 	/* commit changes */
-	cdns_updatel(cdns, CDNS_MCP_CONFIG_UPDATE,
-		     CDNS_MCP_CONFIG_UPDATE_BIT,
-		     CDNS_MCP_CONFIG_UPDATE_BIT);
-
-	/* don't wait here */
-	return 0;
-
+	return cdns_config_update(cdns);
 }
 EXPORT_SYMBOL(sdw_cdns_exit_reset);
 
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 27c56274217f..8e328ba01c0a 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -197,4 +197,7 @@ int cdns_set_sdw_stream(struct snd_soc_dai *dai,
 void sdw_cdns_check_self_clearing_bits(struct sdw_cdns *cdns, const char *string,
 				       bool initial_delay, int reset_iterations);
 
+void sdw_cdns_config_update(struct sdw_cdns *cdns);
+int sdw_cdns_config_update_set_wait(struct sdw_cdns *cdns);
+
 #endif /* __SDW_CADENCE_H */
diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
index 901d4f5736c1..be0c93106fc8 100644
--- a/drivers/soundwire/intel_bus_common.c
+++ b/drivers/soundwire/intel_bus_common.c
@@ -29,11 +29,7 @@ int intel_start_bus(struct sdw_intel *sdw)
 		return ret;
 	}
 
-	ret = sdw_cdns_exit_reset(cdns);
-	if (ret < 0) {
-		dev_err(dev, "%s: unable to exit bus reset sequence: %d\n", __func__, ret);
-		return ret;
-	}
+	sdw_cdns_config_update(cdns);
 
 	if (bus->multi_link) {
 		ret = sdw_intel_sync_go(sdw);
@@ -43,6 +39,18 @@ int intel_start_bus(struct sdw_intel *sdw)
 		}
 	}
 
+	ret = sdw_cdns_config_update_set_wait(cdns);
+	if (ret < 0) {
+		dev_err(dev, "%s: CONFIG_UPDATE BIT still set\n", __func__);
+		return ret;
+	}
+
+	ret = sdw_cdns_exit_reset(cdns);
+	if (ret < 0) {
+		dev_err(dev, "%s: unable to exit bus reset sequence: %d\n", __func__, ret);
+		return ret;
+	}
+
 	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
 		dev_err(dev, "%s: cannot enable interrupts: %d\n", __func__, ret);
@@ -112,11 +120,7 @@ int intel_start_bus_after_reset(struct sdw_intel *sdw)
 	}
 
 	if (!clock_stop0) {
-		ret = sdw_cdns_exit_reset(cdns);
-		if (ret < 0) {
-			dev_err(dev, "unable to exit bus reset sequence during resume\n");
-			return ret;
-		}
+		sdw_cdns_config_update(cdns);
 
 		if (bus->multi_link) {
 			ret = sdw_intel_sync_go(sdw);
@@ -126,6 +130,18 @@ int intel_start_bus_after_reset(struct sdw_intel *sdw)
 			}
 		}
 
+		ret = sdw_cdns_config_update_set_wait(cdns);
+		if (ret < 0) {
+			dev_err(dev, "%s: CONFIG_UPDATE BIT still set\n", __func__);
+			return ret;
+		}
+
+		ret = sdw_cdns_exit_reset(cdns);
+		if (ret < 0) {
+			dev_err(dev, "unable to exit bus reset sequence during resume\n");
+			return ret;
+		}
+
 		ret = sdw_cdns_enable_interrupt(cdns, true);
 		if (ret < 0) {
 			dev_err(dev, "cannot enable interrupts during resume\n");
-- 
2.25.1

