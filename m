Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A84270255D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbjEOGvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbjEOGv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:51:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AA72D7F
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133465; x=1715669465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aNL2KliVK/W0PGGaQa+13McnVurhskx2OOU+yOO7uSY=;
  b=Jyb9vydAHkPvidL3mW6nWVqQt+eC6/rkl3l/LwJ24StHAjz9q6s1l2kX
   2VXSoXSXXDJz5yAAkJtVAz3SWx0iqtVKxeq79hptwzTUWfwJUB9tdTeg6
   aC2Pc35LhLU1eO5fgv0q+4LOzoyCH5PnRyT0G4YGPgBnS58wQ+egVo1Xt
   NXxPHp8sG0CjpGmLeLXpMukulznFsX5dA3Jc33IZV1QJRwH/aVJU8GTV2
   fD16utJpen7huF4KwByKHZmEiE7Mador/9Aqwmd+LnOtY5PoVdgcm3h/E
   EC5Mn0c6CWWr5n/zke/Mxxa13a7+Cdh0hHCn3BC/N7D5ij1oJPkuHUsTn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966393"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966393"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908711"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908711"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:47 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 12/26] soundwire: intel_ace2x: set SYNCPRD before powering-up
Date:   Mon, 15 May 2023 15:10:28 +0800
Message-Id: <20230515071042.2038-13-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

