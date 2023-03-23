Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6498C6C5EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjCWFbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjCWFbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:31:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC022797
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549456; x=1711085456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aNL2KliVK/W0PGGaQa+13McnVurhskx2OOU+yOO7uSY=;
  b=ALhUWyojgqzHzE6KZpUEEJgv2r6amjn/APoDkMzpbwHmI2Ev+5f0wGkL
   GrQ1EeYTsQGiaArk4Se0fDL4P7Xwjp/rABdqYaK6BXjU1Wbgrdlyykfkp
   BWTijKAFWhhrYc2t8gRwFsp2l3fZDVW4skpvsWXy3bqJ2EnB7YFhRHtA7
   XGuGkkRdKRZfXeXpi4ig3/KeLpEr6D1oD8ySB+b8SGQSc3LSZR/y+MisP
   N+ZC8dkWQB2HegBJfn0Z8cKqLCY+hgwE5r/Wi1kY8pKx67rlYxUhZX5zi
   St3A+hK6xOt5xJSdroWfcHVUU9UN60TM6J0WWh8WpM441bU3OfwRVwosE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779422"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779422"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567132"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567132"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:18 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 12/20] soundwire: intel_ace2x: set SYNCPRD before powering-up
Date:   Thu, 23 Mar 2023 13:44:44 +0800
Message-Id: <20230323054452.1543233-13-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The registers used for multi-link synchronization are no longer in the
SHIM but in the HDaudio multi-link capability space. Use helpers to
configure the SYNCPRD value, and wait for SYNCPU to change after
powering-up.

Note that the SYNCPRD value is shared between all sublinks, for
obvious reasons if those links are supposed to be synchronized. The
value of SYNCPRD is programmed only once for all sublinks.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 42 +++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 5b6a608e63ba..01668246b7ba 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -17,17 +17,51 @@
 
 static int intel_link_power_up(struct sdw_intel *sdw)
 {
+	struct sdw_bus *bus = &sdw->cdns.bus;
+	struct sdw_master_prop *prop = &bus->prop;
+	u32 *shim_mask = sdw->link_res->shim_mask;
+	unsigned int link_id = sdw->instance;
+	u32 syncprd;
 	int ret;
 
 	mutex_lock(sdw->link_res->shim_lock);
 
-	ret = hdac_bus_eml_sdw_power_up_unlocked(sdw->link_res->hbus, sdw->instance);
+	if (!*shim_mask) {
+		/* we first need to program the SyncPRD/CPU registers */
+		dev_dbg(sdw->cdns.dev, "first link up, programming SYNCPRD\n");
+
+		if (prop->mclk_freq % 6000000)
+			syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_38_4;
+		else
+			syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_24;
+
+		ret =  hdac_bus_eml_sdw_set_syncprd_unlocked(sdw->link_res->hbus, syncprd);
+		if (ret < 0) {
+			dev_err(sdw->cdns.dev, "%s: hdac_bus_eml_sdw_set_syncprd failed: %d\n",
+				__func__, ret);
+			goto out;
+		}
+	}
+
+	ret = hdac_bus_eml_sdw_power_up_unlocked(sdw->link_res->hbus, link_id);
 	if (ret < 0) {
 		dev_err(sdw->cdns.dev, "%s: hdac_bus_eml_sdw_power_up failed: %d\n",
 			__func__, ret);
 		goto out;
 	}
 
+	if (!*shim_mask) {
+		/* SYNCPU will change once link is active */
+		ret =  hdac_bus_eml_sdw_wait_syncpu_unlocked(sdw->link_res->hbus);
+		if (ret < 0) {
+			dev_err(sdw->cdns.dev, "%s: hdac_bus_eml_sdw_wait_syncpu failed: %d\n",
+				__func__, ret);
+			goto out;
+		}
+	}
+
+	*shim_mask |= BIT(link_id);
+
 	sdw->cdns.link_up = true;
 out:
 	mutex_unlock(sdw->link_res->shim_lock);
@@ -37,13 +71,17 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 
 static int intel_link_power_down(struct sdw_intel *sdw)
 {
+	u32 *shim_mask = sdw->link_res->shim_mask;
+	unsigned int link_id = sdw->instance;
 	int ret;
 
 	mutex_lock(sdw->link_res->shim_lock);
 
 	sdw->cdns.link_up = false;
 
-	ret = hdac_bus_eml_sdw_power_down_unlocked(sdw->link_res->hbus, sdw->instance);
+	*shim_mask &= ~BIT(link_id);
+
+	ret = hdac_bus_eml_sdw_power_down_unlocked(sdw->link_res->hbus, link_id);
 	if (ret < 0) {
 		dev_err(sdw->cdns.dev, "%s: hdac_bus_eml_sdw_power_down failed: %d\n",
 			__func__, ret);
-- 
2.25.1

