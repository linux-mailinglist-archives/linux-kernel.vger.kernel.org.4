Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FDF6B87B8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCNBl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCNBlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89C67431C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758078; x=1710294078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gHC1L9M9Gcn75VIlZPVSTJ0/8DWLLL6154TEcRehIwE=;
  b=BYFw/6t3UT9sOboM+k3iaZ0H4sBiYSwdja/9/hQbdhhwIFPhfAR77BBf
   oP0Osisldmi+cu/miJ89h0t2wSN311xBD9+lJWvGWaxSxdX9ws34psUBq
   tRruiwz4c2dWQpA/BbKzUOA9nc1nxzo+fnzFQpVoG88gVBLPqeQIahHge
   SY/NpxfaCR7IYXAvy8KCyr+GN/KtZnhoscujEhFKA1XXJ2DrS43ewjYcg
   XSJy87wQPowl9oBThwhQsYz8SJUVSyLaa3800iHTRsaqCho6FlIF3KLYw
   j7pv3e+ylZihQrdTFScKiYDmNOrZ+bz9UwxqRON9X8C1q/EMRx1la5NKa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949250"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949250"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327422"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327422"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:16 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 06/16] soundwire: intel: add sync_arm/sync_go to ops
Date:   Tue, 14 Mar 2023 09:54:00 +0800
Message-Id: <20230314015410.487311-7-yung-chuan.liao@linux.intel.com>
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

The bus start/stop sequences can be reused between platforms if we add
a couple of new callbacks. In following patches the code will be moved to
a shared file.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 16 ++++++++++------
 drivers/soundwire/intel.h           | 20 ++++++++++++++++++++
 include/linux/soundwire/sdw_intel.h |  8 ++++++++
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 6fdb10117e59..902934cbb27b 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -686,7 +686,7 @@ static int intel_pre_bank_switch(struct sdw_intel *sdw)
 	if (!bus->multi_link)
 		return 0;
 
-	intel_shim_sync_arm(sdw);
+	sdw_intel_sync_arm(sdw);
 
 	return 0;
 }
@@ -720,7 +720,7 @@ static int intel_post_bank_switch(struct sdw_intel *sdw)
 		goto unlock;
 	}
 
-	ret = intel_shim_sync_go_unlocked(sdw);
+	ret = sdw_intel_sync_go_unlocked(sdw);
 unlock:
 	mutex_unlock(sdw->link_res->shim_lock);
 
@@ -1140,7 +1140,7 @@ static int intel_start_bus(struct sdw_intel *sdw)
 	 * gsync is enabled
 	 */
 	if (bus->multi_link)
-		intel_shim_sync_arm(sdw);
+		sdw_intel_sync_arm(sdw);
 
 	ret = sdw_cdns_init(cdns);
 	if (ret < 0) {
@@ -1155,7 +1155,7 @@ static int intel_start_bus(struct sdw_intel *sdw)
 	}
 
 	if (bus->multi_link) {
-		ret = intel_shim_sync_go(sdw);
+		ret = sdw_intel_sync_go(sdw);
 		if (ret < 0) {
 			dev_err(dev, "%s: sync go failed: %d\n", __func__, ret);
 			goto err_interrupt;
@@ -1210,7 +1210,7 @@ static int intel_start_bus_after_reset(struct sdw_intel *sdw)
 		 * timeouts when gsync is enabled
 		 */
 		if (bus->multi_link)
-			intel_shim_sync_arm(sdw);
+			sdw_intel_sync_arm(sdw);
 
 		/*
 		 * Re-initialize the IP since it was powered-off
@@ -1239,7 +1239,7 @@ static int intel_start_bus_after_reset(struct sdw_intel *sdw)
 		}
 
 		if (bus->multi_link) {
-			ret = intel_shim_sync_go(sdw);
+			ret = sdw_intel_sync_go(sdw);
 			if (ret < 0) {
 				dev_err(sdw->cdns.dev, "sync go failed during resume\n");
 				goto err_interrupt;
@@ -1342,6 +1342,10 @@ const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops = {
 
 	.pre_bank_switch = intel_pre_bank_switch,
 	.post_bank_switch = intel_post_bank_switch,
+
+	.sync_arm = intel_shim_sync_arm,
+	.sync_go_unlocked = intel_shim_sync_go_unlocked,
+	.sync_go = intel_shim_sync_go,
 };
 EXPORT_SYMBOL_NS(sdw_intel_cnl_hw_ops, SOUNDWIRE_INTEL);
 
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 089c41babfc1..28b21a92e28b 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -167,4 +167,24 @@ static inline void sdw_intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 		SDW_INTEL_OPS(sdw, shim_wake)(sdw, wake_enable);
 }
 
+static inline void sdw_intel_sync_arm(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, sync_arm))
+		SDW_INTEL_OPS(sdw, sync_arm)(sdw);
+}
+
+static inline int sdw_intel_sync_go_unlocked(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, sync_go_unlocked))
+		return SDW_INTEL_OPS(sdw, sync_go_unlocked)(sdw);
+	return -ENOTSUPP;
+}
+
+static inline int sdw_intel_sync_go(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, sync_go))
+		return SDW_INTEL_OPS(sdw, sync_go)(sdw);
+	return -ENOTSUPP;
+}
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 91f0dc564fe5..06fa30929ebd 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -309,6 +309,10 @@ struct sdw_intel;
  * @shim_wake: enable/disable in-band wake management
  * @pre_bank_switch: helper for bus management
  * @post_bank_switch: helper for bus management
+ * @sync_arm: helper for multi-link synchronization
+ * @sync_go_unlocked: helper for multi-link synchronization -
+ * shim_lock is assumed to be locked at higher level
+ * @sync_go: helper for multi-link synchronization
  */
 struct sdw_intel_hw_ops {
 	void (*debugfs_init)(struct sdw_intel *sdw);
@@ -330,6 +334,10 @@ struct sdw_intel_hw_ops {
 
 	int (*pre_bank_switch)(struct sdw_intel *sdw);
 	int (*post_bank_switch)(struct sdw_intel *sdw);
+
+	void (*sync_arm)(struct sdw_intel *sdw);
+	int (*sync_go_unlocked)(struct sdw_intel *sdw);
+	int (*sync_go)(struct sdw_intel *sdw);
 };
 
 extern const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops;
-- 
2.25.1

