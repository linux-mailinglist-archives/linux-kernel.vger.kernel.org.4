Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD536C5EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjCWFcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCWFbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:31:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED7F22031
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549465; x=1711085465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wsFbcSJtx/AlSmGIw0DdUSJEopY6I39DINuaH9UuTy0=;
  b=K8QJDfehQh970xxe9MsJjbb/TOWmkqFr6R0S2+OtPUKfPovkuslMdJCG
   +WiJOOpCuLaOfrrG2B0nT7nbYqs4/5CnfH+Sl+2GvnvAO9KUX/SEPEGnw
   HHIYsDjMj9Om6SanktA2qMlTrEAsgd+ceoZ1+yR8hX6122k/qJI4YpHsd
   v4xDFTKOnbbaoKhsSo4S91jS5iPMup8ui5qavnGEazF9DWJmR/fCx09Dp
   IohZHYP8UaO1ndwAxmZIxOiBrY46OjW7cLHM46WCmSBq00bsJqkXoqkYu
   /Q8HaEadSfbDCW2g93FWBYyI2ii8qrDP4hjBQevMGz5XyAQ/4vIQUqPEk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779460"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779460"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567197"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567197"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:26 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 15/20] soundwire: intel_ace2x: add sync_arm/sync_go helpers
Date:   Thu, 23 Mar 2023 13:44:47 +0800
Message-Id: <20230323054452.1543233-16-yung-chuan.liao@linux.intel.com>
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

Same functionality as before, but with the registers moved to the
HDaudio multi-link area.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index d6d5e6e070f4..20b8806f7de6 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -116,6 +116,41 @@ static int intel_link_power_down(struct sdw_intel *sdw)
 	return ret;
 }
 
+static void intel_sync_arm(struct sdw_intel *sdw)
+{
+	unsigned int link_id = sdw->instance;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	hdac_bus_eml_sdw_sync_arm_unlocked(sdw->link_res->hbus, link_id);
+
+	mutex_unlock(sdw->link_res->shim_lock);
+}
+
+static int intel_sync_go_unlocked(struct sdw_intel *sdw)
+{
+	int ret;
+
+	ret = hdac_bus_eml_sdw_sync_go_unlocked(sdw->link_res->hbus);
+	if (ret < 0)
+		dev_err(sdw->cdns.dev, "%s: SyncGO clear failed: %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int intel_sync_go(struct sdw_intel *sdw)
+{
+	int ret;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	ret = intel_sync_go_unlocked(sdw);
+
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	return ret;
+}
+
 /*
  * DAI operations
  */
@@ -283,6 +318,10 @@ const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 
 	.link_power_up = intel_link_power_up,
 	.link_power_down = intel_link_power_down,
+
+	.sync_arm = intel_sync_arm,
+	.sync_go_unlocked = intel_sync_go_unlocked,
+	.sync_go = intel_sync_go,
 };
 EXPORT_SYMBOL_NS(sdw_intel_lnl_hw_ops, SOUNDWIRE_INTEL);
 
-- 
2.25.1

