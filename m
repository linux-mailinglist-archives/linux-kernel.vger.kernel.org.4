Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566076B87C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCNBlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCNBlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAEB75840
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758087; x=1710294087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pL6YG6BMqzUVh4Kle1zgXWisMHBEcSc8c1jkWgAQStg=;
  b=T1WYL4loQLCeJfAZpDjI+MqegirUC2zt5YHyTaxzFlL3kuWpRUVU+KK9
   2JTfTkZSUj+2QTULXtuqeju/ddYkZN64njUgTRF6GCt4b2OAaGI1Z31DX
   tryJSIMZpoLGDefsGiyLp6rYaYf/9hJSwVAftFozKroG2o1CxuRdu5wDx
   U3zRdkIjOq2nGPBD/Nndw84vukKd8vU6mIYVXbGZa0x3MS4+xT9Y+tMIq
   W140jck7tmH9Vfesm2s60AQN80FhZLU13bXr3IAsAa1nieSZIJEnOVlUE
   mF9cNZBMw7DaT6vAO45ynhl5qo7GWkCw9/VTbcIvHAopwCEpD395BVMIN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949276"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949276"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327475"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327475"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:22 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 09/16] soundwire: intel: add abstraction for cmdsync check
Date:   Tue, 14 Mar 2023 09:54:03 +0800
Message-Id: <20230314015410.487311-10-yung-chuan.liao@linux.intel.com>
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

If we add one more callback, we can have common bank switch sequences
between old and new hardware: the only difference is where the CMDSYNC
register is located.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 24 +++++++++++++-----------
 drivers/soundwire/intel.h           |  7 +++++++
 include/linux/soundwire/sdw_intel.h |  3 +++
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 77d698908595..1131ecb4b5e7 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -325,6 +325,15 @@ static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 	mutex_unlock(sdw->link_res->shim_lock);
 }
 
+static bool intel_check_cmdsync_unlocked(struct sdw_intel *sdw)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	int sync_reg;
+
+	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
+	return !!(sync_reg & SDW_SHIM_SYNC_CMDSYNC_MASK);
+}
+
 static int intel_link_power_up(struct sdw_intel *sdw)
 {
 	unsigned int link_id = sdw->instance;
@@ -695,8 +704,7 @@ static int intel_post_bank_switch(struct sdw_intel *sdw)
 {
 	struct sdw_cdns *cdns = &sdw->cdns;
 	struct sdw_bus *bus = &cdns->bus;
-	void __iomem *shim = sdw->link_res->shim;
-	int sync_reg, ret;
+	int ret = 0;
 
 	/* Write to register only for multi-link */
 	if (!bus->multi_link)
@@ -704,9 +712,6 @@ static int intel_post_bank_switch(struct sdw_intel *sdw)
 
 	mutex_lock(sdw->link_res->shim_lock);
 
-	/* Read SYNC register */
-	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
-
 	/*
 	 * post_bank_switch() ops is called from the bus in loop for
 	 * all the Masters in the steam with the expectation that
@@ -715,13 +720,9 @@ static int intel_post_bank_switch(struct sdw_intel *sdw)
 	 *
 	 * So, set the SYNCGO bit only if CMDSYNC bit is set for any Master.
 	 */
-	if (!(sync_reg & SDW_SHIM_SYNC_CMDSYNC_MASK)) {
-		ret = 0;
-		goto unlock;
-	}
+	if (sdw_intel_sync_check_cmdsync_unlocked(sdw))
+		ret = sdw_intel_sync_go_unlocked(sdw);
 
-	ret = sdw_intel_sync_go_unlocked(sdw);
-unlock:
 	mutex_unlock(sdw->link_res->shim_lock);
 
 	if (ret < 0)
@@ -1147,6 +1148,7 @@ const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops = {
 	.sync_arm = intel_shim_sync_arm,
 	.sync_go_unlocked = intel_shim_sync_go_unlocked,
 	.sync_go = intel_shim_sync_go,
+	.sync_check_cmdsync_unlocked = intel_check_cmdsync_unlocked,
 };
 EXPORT_SYMBOL_NS(sdw_intel_cnl_hw_ops, SOUNDWIRE_INTEL);
 
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index abd1a500defa..7a69cf755954 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -187,6 +187,13 @@ static inline int sdw_intel_sync_go(struct sdw_intel *sdw)
 	return -ENOTSUPP;
 }
 
+static inline bool sdw_intel_sync_check_cmdsync_unlocked(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, sync_check_cmdsync_unlocked))
+		return SDW_INTEL_OPS(sdw, sync_check_cmdsync_unlocked)(sdw);
+	return false;
+}
+
 /* common bus management */
 int intel_start_bus(struct sdw_intel *sdw);
 int intel_start_bus_after_reset(struct sdw_intel *sdw);
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 06fa30929ebd..207701aeeb47 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -313,6 +313,8 @@ struct sdw_intel;
  * @sync_go_unlocked: helper for multi-link synchronization -
  * shim_lock is assumed to be locked at higher level
  * @sync_go: helper for multi-link synchronization
+ * @sync_check_cmdsync_unlocked: helper for multi-link synchronization
+ * and bank switch - shim_lock is assumed to be locked at higher level
  */
 struct sdw_intel_hw_ops {
 	void (*debugfs_init)(struct sdw_intel *sdw);
@@ -338,6 +340,7 @@ struct sdw_intel_hw_ops {
 	void (*sync_arm)(struct sdw_intel *sdw);
 	int (*sync_go_unlocked)(struct sdw_intel *sdw);
 	int (*sync_go)(struct sdw_intel *sdw);
+	bool (*sync_check_cmdsync_unlocked)(struct sdw_intel *sdw);
 };
 
 extern const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops;
-- 
2.25.1

