Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389EC624F93
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiKKBaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiKKBaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:30:05 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11CA61B82
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668130198; x=1699666198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9PyiT4xs21Bv2WDv7eYaoCUfVE+lPLCmDaq/TH3rDRo=;
  b=a38uwTEZA5Zuz8W1My4mqPtvkfC20zEdJ7qkzinQIvhR5fZ56MQcMUGA
   L7fzL/dKK2w+0bTMgIY2n16C5K2KEN93pIFZi13d4C8qZhegEKSSQYOaM
   mfjauzOfqeipb1r/vZHESWBFWxJg1ybcx8SHohYRR1OEXnXWXpBIxP4wX
   zhqvqMW83N1CntlZ90TtqxHeNiZJ8eilOaBCijDDSkctrgAT11CZ2Y5Ng
   bmz7r9rrwCKcEtbcgEL6flHIGHycsH6ElcSamOjkswlQW4uBkzzswp+wD
   GdvSuOTcKqjEqTcxMzr+Y7+fzm042JA9IkQYjMGCeBEFgqoSKoEoaK1wC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294847836"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="294847836"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780003268"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="780003268"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:56 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 6/7] soundwire: intel: add in-band wake callbacks in hw_ops
Date:   Fri, 11 Nov 2022 09:31:33 +0800
Message-Id: <20221111013135.38289-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
References: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

No functionality change, only add indirection for in-band wake
management helpers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 11 +++++++----
 drivers/soundwire/intel.h           | 13 +++++++++++++
 include/linux/soundwire/sdw_intel.h |  5 +++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 2320f1b8a2d1..ea6479b4010d 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1437,6 +1437,9 @@ const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops = {
 	.link_power_up = intel_link_power_up,
 	.link_power_down = intel_link_power_down,
 
+	.shim_check_wake = intel_shim_check_wake,
+	.shim_wake = intel_shim_wake,
+
 	.pre_bank_switch = intel_pre_bank_switch,
 	.post_bank_switch = intel_post_bank_switch,
 };
@@ -1720,11 +1723,11 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
 		return 0;
 	}
 
-	if (!intel_shim_check_wake(sdw))
+	if (!sdw_intel_shim_check_wake(sdw))
 		return 0;
 
 	/* disable WAKEEN interrupt ASAP to prevent interrupt flood */
-	intel_shim_wake(sdw, false);
+	sdw_intel_shim_wake(sdw, false);
 
 	/*
 	 * resume the Master, which will generate a bus reset and result in
@@ -1852,7 +1855,7 @@ static int __maybe_unused intel_suspend(struct device *dev)
 				 */
 				dev_err(dev, "%s: invalid config: parent is suspended\n", __func__);
 			} else {
-				intel_shim_wake(sdw, false);
+				sdw_intel_shim_wake(sdw, false);
 			}
 		}
 
@@ -1987,7 +1990,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 	}
 
 	/* unconditionally disable WAKEEN interrupt */
-	intel_shim_wake(sdw, false);
+	sdw_intel_shim_wake(sdw, false);
 
 	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 0f63e7584132..9ac3397757a0 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -132,4 +132,17 @@ static inline int sdw_intel_link_power_down(struct sdw_intel *sdw)
 	return -ENOTSUPP;
 }
 
+static inline int sdw_intel_shim_check_wake(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, shim_check_wake))
+		return SDW_INTEL_OPS(sdw, shim_check_wake)(sdw);
+	return -ENOTSUPP;
+}
+
+static inline void sdw_intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, shim_wake))
+		SDW_INTEL_OPS(sdw, shim_wake)(sdw, wake_enable);
+}
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 81430201b8b9..0942cd464095 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -307,6 +307,8 @@ struct sdw_intel;
  * @stop_bus: stop all bus
  * @link_power_up: power-up using chip-specific helpers
  * @link_power_down: power-down with chip-specific helpers
+ * @shim_check_wake: check if a wake was received
+ * @shim_wake: enable/disable in-band wake management
  * @pre_bank_switch: helper for bus management
  * @post_bank_switch: helper for bus management
  */
@@ -325,6 +327,9 @@ struct sdw_intel_hw_ops {
 	int (*link_power_up)(struct sdw_intel *sdw);
 	int (*link_power_down)(struct sdw_intel *sdw);
 
+	int  (*shim_check_wake)(struct sdw_intel *sdw);
+	void (*shim_wake)(struct sdw_intel *sdw, bool wake_enable);
+
 	int (*pre_bank_switch)(struct sdw_intel *sdw);
 	int (*post_bank_switch)(struct sdw_intel *sdw);
 };
-- 
2.25.1

