Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA56C5EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCWFcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjCWFcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD82E31BD2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549483; x=1711085483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zulnEGWCaE/ce7on2AHJOrEISXuutjX2aua9tmM2yVE=;
  b=P8rk4T1nDolSbVLSQmIHuiMGPFWQleRgDCqyVLt0FTKIb+H9VM5VpRuf
   tbhPc81S4e04hiQiZuo1/wrtiENIfAcbfXM3buhKknpjbecnGQQKJLTug
   jGvUVBvM/Y3K4XTlHdDhZTEm70V7R4XcHm+6IeAxvdexW6TVSYfVmdLl7
   ce1ovynWcHxdcUhyaY74vprtup0nNiniE7LjkWl2P5xAJiNaEQczbtSJm
   eQf3JAfJVgPCoQTj06SBhWAC3tX4LtIYD1FG3gxG7w8Ds6/8QTt/tLSI8
   ivws77o6S8/6Jas6TB4VF4/aq5wfx+MI93wICIsQFUFmEey2t4FNykkyA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779480"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779480"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567238"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567238"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:31 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 17/20] soundwire: intel_ace2x: enable wake support
Date:   Thu, 23 Mar 2023 13:44:49 +0800
Message-Id: <20230323054452.1543233-18-yung-chuan.liao@linux.intel.com>
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

The WAKEEN and WAKESTS registers were moved to the per-link SHIM_VS
area.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 2e33e8a00b55..fe950b3ea3bc 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -31,6 +31,41 @@ static void intel_shim_vs_init(struct sdw_intel *sdw)
 	usleep_range(10, 15);
 }
 
+static int intel_shim_check_wake(struct sdw_intel *sdw)
+{
+	void __iomem *shim_vs;
+	u16 wake_sts;
+
+	shim_vs = sdw->link_res->shim_vs;
+	wake_sts = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_WAKESTS);
+
+	return wake_sts & SDW_SHIM2_INTEL_VS_WAKEEN_PWS;
+}
+
+static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
+{
+	void __iomem *shim_vs = sdw->link_res->shim_vs;
+	u16 wake_en;
+	u16 wake_sts;
+
+	wake_en = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_WAKEEN);
+
+	if (wake_enable) {
+		/* Enable the wakeup */
+		wake_en |= SDW_SHIM2_INTEL_VS_WAKEEN_PWE;
+		intel_writew(shim_vs, SDW_SHIM2_INTEL_VS_WAKEEN, wake_en);
+	} else {
+		/* Disable the wake up interrupt */
+		wake_en &= ~SDW_SHIM2_INTEL_VS_WAKEEN_PWE;
+		intel_writew(shim_vs, SDW_SHIM2_INTEL_VS_WAKEEN, wake_en);
+
+		/* Clear wake status (W1C) */
+		wake_sts = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_WAKESTS);
+		wake_sts |= SDW_SHIM2_INTEL_VS_WAKEEN_PWS;
+		intel_writew(shim_vs, SDW_SHIM2_INTEL_VS_WAKESTS, wake_sts);
+	}
+}
+
 static int intel_link_power_up(struct sdw_intel *sdw)
 {
 	struct sdw_bus *bus = &sdw->cdns.bus;
@@ -325,6 +360,9 @@ const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 	.link_power_up = intel_link_power_up,
 	.link_power_down = intel_link_power_down,
 
+	.shim_check_wake = intel_shim_check_wake,
+	.shim_wake = intel_shim_wake,
+
 	.sync_arm = intel_sync_arm,
 	.sync_go_unlocked = intel_sync_go_unlocked,
 	.sync_go = intel_sync_go,
-- 
2.25.1

