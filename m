Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD216702564
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbjEOGwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240454AbjEOGwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:52:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D892101
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133507; x=1715669507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zulnEGWCaE/ce7on2AHJOrEISXuutjX2aua9tmM2yVE=;
  b=WT6/sr+GjCk608Rgj65IJ2nebMUTwi178AL1Kp1f0n6v2MbpwaJEP69+
   D97nwjSW6Nlv1JgEVQmmxBxYIRL6AaXmG9w3DJY1CL29wkSezALDU+zg/
   ugze5Gt+PwEkCGMTX7A25yAw38flW3MjVsSmFgNlc1c/f4SzpiAMtvyKV
   GdVyQ5RSedoL/+7HziQ1dA9j9dntWeHwi6ntCTCoO2sBRdutciErm+XTT
   tzlo6SYj6xo4nGji2zm7u9TfJ6+oEupsU687RI48adLWrrweIq4Kk5Smw
   hC5SiIA7JOdrDLBKNDHptdJ4mG4UL3jA+aIAvEioEMdFAJFOnnHaLfyZz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966479"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966479"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:51:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908748"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908748"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:59 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 17/26] soundwire: intel_ace2x: enable wake support
Date:   Mon, 15 May 2023 15:10:33 +0800
Message-Id: <20230515071042.2038-18-yung-chuan.liao@linux.intel.com>
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

