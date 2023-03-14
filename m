Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F406E6B87B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCNBll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjCNBlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6817A90B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758087; x=1710294087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNGs5CqhpeSutHJ3ZnJS8u0595Z/RX0QA49udnu9oCc=;
  b=bBNXTRfqg1+9CMaZsz0sspgQeh3rPL2pnDY5JfuLMMzFwp9YoO+fj3gZ
   QtAc07u01KENX9F578gbau6G89ag7limvGueILkdaEGOTG7lidM5kITfd
   no/wy6ZpZ666jGW5gtt1YXRU43NsM/4oXp1EdO+9lvzLHesPiFtBBsBpu
   g1jy6qWeGwshKerttXDkTMSNUXL5PXGoHjWu62UpmOCX6Fd5JuIwksxfO
   pPlc8QCikZu9lno4RMMEuIGh/ibly5tmKqxbfMpf9Dew8LZO8gGFdBSTz
   QoBt9Cs/QZVGPSOINjdLbbZ5JOOIgduwzz+urgvippA9eVB9YqbOWfucy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949281"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949281"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327485"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327485"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:24 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 10/16] soundwire: intel: move bank switch routine to common intel_bus_common.c
Date:   Tue, 14 Mar 2023 09:54:04 +0800
Message-Id: <20230314015410.487311-11-yung-chuan.liao@linux.intel.com>
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

No functionality change, just moving the routines to a common file so
that they can be used for new hardware.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c            | 49 ----------------------------
 drivers/soundwire/intel.h            |  4 +++
 drivers/soundwire/intel_bus_common.c | 49 ++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 1131ecb4b5e7..046c67a2a39b 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -682,55 +682,6 @@ static int intel_free_stream(struct sdw_intel *sdw,
 	return 0;
 }
 
-/*
- * bank switch routines
- */
-
-static int intel_pre_bank_switch(struct sdw_intel *sdw)
-{
-	struct sdw_cdns *cdns = &sdw->cdns;
-	struct sdw_bus *bus = &cdns->bus;
-
-	/* Write to register only for multi-link */
-	if (!bus->multi_link)
-		return 0;
-
-	sdw_intel_sync_arm(sdw);
-
-	return 0;
-}
-
-static int intel_post_bank_switch(struct sdw_intel *sdw)
-{
-	struct sdw_cdns *cdns = &sdw->cdns;
-	struct sdw_bus *bus = &cdns->bus;
-	int ret = 0;
-
-	/* Write to register only for multi-link */
-	if (!bus->multi_link)
-		return 0;
-
-	mutex_lock(sdw->link_res->shim_lock);
-
-	/*
-	 * post_bank_switch() ops is called from the bus in loop for
-	 * all the Masters in the steam with the expectation that
-	 * we trigger the bankswitch for the only first Master in the list
-	 * and do nothing for the other Masters
-	 *
-	 * So, set the SYNCGO bit only if CMDSYNC bit is set for any Master.
-	 */
-	if (sdw_intel_sync_check_cmdsync_unlocked(sdw))
-		ret = sdw_intel_sync_go_unlocked(sdw);
-
-	mutex_unlock(sdw->link_res->shim_lock);
-
-	if (ret < 0)
-		dev_err(sdw->cdns.dev, "Post bank switch failed: %d\n", ret);
-
-	return ret;
-}
-
 /*
  * DAI routines
  */
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 7a69cf755954..09d479f2c77b 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -201,4 +201,8 @@ void intel_check_clock_stop(struct sdw_intel *sdw);
 int intel_start_bus_after_clock_stop(struct sdw_intel *sdw);
 int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop);
 
+/* common bank switch routines */
+int intel_pre_bank_switch(struct sdw_intel *sdw);
+int intel_post_bank_switch(struct sdw_intel *sdw);
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
index 9a06ab58018b..f180e3bea989 100644
--- a/drivers/soundwire/intel_bus_common.c
+++ b/drivers/soundwire/intel_bus_common.c
@@ -208,3 +208,52 @@ int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
 
 	return 0;
 }
+
+/*
+ * bank switch routines
+ */
+
+int intel_pre_bank_switch(struct sdw_intel *sdw)
+{
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_bus *bus = &cdns->bus;
+
+	/* Write to register only for multi-link */
+	if (!bus->multi_link)
+		return 0;
+
+	sdw_intel_sync_arm(sdw);
+
+	return 0;
+}
+
+int intel_post_bank_switch(struct sdw_intel *sdw)
+{
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_bus *bus = &cdns->bus;
+	int ret = 0;
+
+	/* Write to register only for multi-link */
+	if (!bus->multi_link)
+		return 0;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	/*
+	 * post_bank_switch() ops is called from the bus in loop for
+	 * all the Masters in the steam with the expectation that
+	 * we trigger the bankswitch for the only first Master in the list
+	 * and do nothing for the other Masters
+	 *
+	 * So, set the SYNCGO bit only if CMDSYNC bit is set for any Master.
+	 */
+	if (sdw_intel_sync_check_cmdsync_unlocked(sdw))
+		ret = sdw_intel_sync_go_unlocked(sdw);
+
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	if (ret < 0)
+		dev_err(sdw->cdns.dev, "Post bank switch failed: %d\n", ret);
+
+	return ret;
+}
-- 
2.25.1

