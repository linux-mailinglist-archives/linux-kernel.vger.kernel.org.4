Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D795A6C5EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCWFbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjCWFbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:31:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2492D151
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549454; x=1711085454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zfPDFAUHD0yEFTAl6FmNYsvKI40bPenFTeUs36GSzIY=;
  b=ahm0ncEEFKg/f2Cm3I46zkUeVUyq7gh0yzGrkJgELws71us6SAGazhJx
   b51L36b55YKh+Et3syTGAKs/sVQfdzxNopDXGM66FpJnVzjMCZs9NE4H6
   2Z5DvufYxa2NzC8OTsFoU+tGHZcduLMf54XAdsz51JFIKEvYtoYWlYhHG
   vX0lRRheqqbXZ7M2KeTs7oEehyLhntdqPpM3leRj/xlTIC/jWrAZFaTUc
   kIWb4TOxIECnAAQwaeauO5QPqGYeNPMlYx46hqzM62m8PKvg/hAUYijiT
   mzlLobryrRn5j2WW8It8h8emihh1wOroqgyUtvxQgA8XHGvJ1oRiCLY56
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779408"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779408"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567117"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567117"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:16 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 11/20] soundwire: intel_ace2x: add link power-up/down helpers
Date:   Thu, 23 Mar 2023 13:44:43 +0800
Message-Id: <20230323054452.1543233-12-yung-chuan.liao@linux.intel.com>
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

only power-up/down for now, the frequency is not set.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 1c47bb2adb93..5b6a608e63ba 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -10,12 +10,62 @@
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_intel.h>
+#include <sound/hda-mlink.h>
 #include "cadence_master.h"
 #include "bus.h"
 #include "intel.h"
 
+static int intel_link_power_up(struct sdw_intel *sdw)
+{
+	int ret;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	ret = hdac_bus_eml_sdw_power_up_unlocked(sdw->link_res->hbus, sdw->instance);
+	if (ret < 0) {
+		dev_err(sdw->cdns.dev, "%s: hdac_bus_eml_sdw_power_up failed: %d\n",
+			__func__, ret);
+		goto out;
+	}
+
+	sdw->cdns.link_up = true;
+out:
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	return ret;
+}
+
+static int intel_link_power_down(struct sdw_intel *sdw)
+{
+	int ret;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	sdw->cdns.link_up = false;
+
+	ret = hdac_bus_eml_sdw_power_down_unlocked(sdw->link_res->hbus, sdw->instance);
+	if (ret < 0) {
+		dev_err(sdw->cdns.dev, "%s: hdac_bus_eml_sdw_power_down failed: %d\n",
+			__func__, ret);
+
+		/*
+		 * we leave the sdw->cdns.link_up flag as false since we've disabled
+		 * the link at this point and cannot handle interrupts any longer.
+		 */
+	}
+
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	return ret;
+}
+
 const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 	.debugfs_init = intel_ace2x_debugfs_init,
 	.debugfs_exit = intel_ace2x_debugfs_exit,
+
+	.link_power_up = intel_link_power_up,
+	.link_power_down = intel_link_power_down,
 };
 EXPORT_SYMBOL_NS(sdw_intel_lnl_hw_ops, SOUNDWIRE_INTEL);
+
+MODULE_IMPORT_NS(SND_SOC_SOF_HDA_MLINK);
-- 
2.25.1

