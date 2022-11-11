Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBECD624F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKKBaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiKKB3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:29:52 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220F760E8E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668130191; x=1699666191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y7Jo51AjZuYZn7HB9q/LeKKCw5Dcg+G+BQMTISHpqM0=;
  b=gWsz1Mhqo99NT0qaiacunmdKGT2ez+EswT+sgAsGyucTebRdh+4Puae2
   OpDx6woD/A9qAGQtUG4IDj68oENmZUSlKbsZNXlCFFY82zIwiWasVuATs
   rYE/CkZb9SWgCFh2FSv176jIizUQM8WoQ3AbTH955R2pVXLuEibqKwRku
   yACjLBREJX4YmkttEBZMJ+ptlqNUSvr1gzrNHkT64uNx8sax6QXzn1hnw
   GozCoEmlv8QoUiJWdxpsLVpvD01PLJBgot7k5VyzOzcxKTuH+HV8tMQ13
   XZfdTqOxDgUZw2yil/jcy9dmOA82CIeW+TnQjfOLz4gObqFRR6b04NdFl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294847805"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="294847805"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780003228"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="780003228"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:49 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 2/7] soundwire: intel: add debugfs callbacks in hw_ops
Date:   Fri, 11 Nov 2022 09:31:29 +0800
Message-Id: <20221111013135.38289-3-yung-chuan.liao@linux.intel.com>
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

No functionality change, only add indirection for debugfs helpers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           |  7 +++++--
 drivers/soundwire/intel.h           | 16 ++++++++++++++++
 include/linux/soundwire/sdw_intel.h |  5 +++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index f88319f8ded4..914f2fb43721 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1423,6 +1423,9 @@ static int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
 }
 
 const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops = {
+	.debugfs_init = intel_debugfs_init,
+	.debugfs_exit = intel_debugfs_exit,
+
 	.pre_bank_switch = intel_pre_bank_switch,
 	.post_bank_switch = intel_post_bank_switch,
 };
@@ -1614,7 +1617,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 		goto err_power_up;
 	}
 
-	intel_debugfs_init(sdw);
+	sdw_intel_debugfs_init(sdw);
 
 	/* start bus */
 	ret = intel_start_bus(sdw);
@@ -1685,7 +1688,7 @@ static void intel_link_remove(struct auxiliary_device *auxdev)
 	 * SDW_INTEL_CLK_STOP_NOT_ALLOWED
 	 */
 	if (!bus->prop.hw_disabled) {
-		intel_debugfs_exit(sdw);
+		sdw_intel_debugfs_exit(sdw);
 		sdw_cdns_enable_interrupt(cdns, false);
 	}
 	sdw_bus_master_delete(bus);
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 3170df76b411..5548b8451d01 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -61,4 +61,20 @@ struct sdw_intel_link_dev {
 #define auxiliary_dev_to_sdw_intel_link_dev(auxiliary_dev) \
 	container_of(auxiliary_dev, struct sdw_intel_link_dev, auxdev)
 
+#define SDW_INTEL_CHECK_OPS(sdw, cb)	((sdw) && (sdw)->link_res && (sdw)->link_res->hw_ops && \
+					 (sdw)->link_res->hw_ops->cb)
+#define SDW_INTEL_OPS(sdw, cb)		((sdw)->link_res->hw_ops->cb)
+
+static inline void sdw_intel_debugfs_init(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, debugfs_init))
+		SDW_INTEL_OPS(sdw, debugfs_init)(sdw);
+}
+
+static inline void sdw_intel_debugfs_exit(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, debugfs_exit))
+		SDW_INTEL_OPS(sdw, debugfs_exit)(sdw);
+}
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 2dbe34b41ef1..211924e4ebf2 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -297,10 +297,15 @@ irqreturn_t sdw_intel_thread(int irq, void *dev_id);
 struct sdw_intel;
 
 /* struct intel_sdw_hw_ops - SoundWire ops for Intel platforms.
+ * @debugfs_init: initialize all debugfs capabilities
+ * @debugfs_exit: close and cleanup debugfs capabilities
  * @pre_bank_switch: helper for bus management
  * @post_bank_switch: helper for bus management
  */
 struct sdw_intel_hw_ops {
+	void (*debugfs_init)(struct sdw_intel *sdw);
+	void (*debugfs_exit)(struct sdw_intel *sdw);
+
 	int (*pre_bank_switch)(struct sdw_intel *sdw);
 	int (*post_bank_switch)(struct sdw_intel *sdw);
 };
-- 
2.25.1

