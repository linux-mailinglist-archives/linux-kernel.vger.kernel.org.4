Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3F5BD416
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiISRvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiISRu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:50:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97494362B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609854; x=1695145854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JLrBqsp8Ryp2ISD8I4vo0ddVnpHvol6JNhobDsbmiJ0=;
  b=PJzWt6NCFKYd2OObsetlx0EbzcMXtHkCM+xlOx0ueW0T1r99BP6G8H7K
   cw828pewzGprm4Vay9gMD7tACEcli8JXEWMLeWcmF06wpAcWBresig3k0
   qDfU3EroEjnyESvFGfOeF3iDvVhN6fDQuUjoTrgZzg3bOwdTJhAwVX/gP
   SX+GPl9Z9YlPX2DZM897aOE9psTpLZu+GVGaw6PCHjsJXVQVufRHke9xj
   yBHOAFZ53o78z0Z3OXkYlHlIu+5VXzwoWjcA6ecpYIUs80dOr4GxhCSvy
   819Mk0Unxb8TrZdQ8OveS/DyM1+Adi1eqEfDT/gxV1XR+Zsm58c0b7c/a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363429278"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363429278"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863658468"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:52 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 07/11] soundwire: intel: remove intel_init() wrapper
Date:   Tue, 20 Sep 2022 01:57:17 +0800
Message-Id: <20220919175721.354679-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919175721.354679-1-yung-chuan.liao@linux.intel.com>
References: <20220919175721.354679-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We can directly call intel_link_power_up and do power_up+shim_init in
the same function. This simplifies the code with a better symmetry
between power_up and power_down operations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 140cf36eb407..4eeb2b5c1594 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -311,15 +311,13 @@ static void intel_shim_master_ip_to_glue(struct sdw_intel *sdw)
 	/* at this point Integration Glue has full control of the I/Os */
 }
 
-static int intel_shim_init(struct sdw_intel *sdw)
+/* this needs to be called with shim_lock */
+static void intel_shim_init(struct sdw_intel *sdw)
 {
 	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
-	int ret = 0;
 	u16 ioctl = 0, act = 0;
 
-	mutex_lock(sdw->link_res->shim_lock);
-
 	/* Initialize Shim */
 	ioctl |= SDW_SHIM_IOCTL_BKE;
 	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
@@ -344,10 +342,6 @@ static int intel_shim_init(struct sdw_intel *sdw)
 	act |= SDW_SHIM_CTMCTL_DODS;
 	intel_writew(shim, SDW_SHIM_CTMCTL(link_id), act);
 	usleep_range(10, 15);
-
-	mutex_unlock(sdw->link_res->shim_lock);
-
-	return ret;
 }
 
 static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
@@ -449,6 +443,9 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	*shim_mask |= BIT(link_id);
 
 	sdw->cdns.link_up = true;
+
+	intel_shim_init(sdw);
+
 out:
 	mutex_unlock(sdw->link_res->shim_lock);
 
@@ -1274,16 +1271,6 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.post_bank_switch = intel_post_bank_switch,
 };
 
-static int intel_init(struct sdw_intel *sdw)
-{
-	/* Initialize shim and controller */
-	intel_link_power_up(sdw);
-
-	intel_shim_init(sdw);
-
-	return 0;
-}
-
 /*
  * probe and init (aux_dev_id argument is required by function prototype but not used)
  */
@@ -1384,7 +1371,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	}
 
 	/* Initialize shim, controller */
-	ret = intel_init(sdw);
+	ret = intel_link_power_up(sdw);
 	if (ret)
 		goto err_init;
 
@@ -1773,7 +1760,7 @@ static int __maybe_unused intel_resume(struct device *dev)
 			pm_runtime_idle(dev);
 	}
 
-	ret = intel_init(sdw);
+	ret = intel_link_power_up(sdw);
 	if (ret) {
 		dev_err(dev, "%s failed: %d\n", __func__, ret);
 		return ret;
@@ -1862,7 +1849,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 	clock_stop_quirks = sdw->link_res->clock_stop_quirks;
 
 	if (clock_stop_quirks & SDW_INTEL_CLK_STOP_TEARDOWN) {
-		ret = intel_init(sdw);
+		ret = intel_link_power_up(sdw);
 		if (ret) {
 			dev_err(dev, "%s failed: %d\n", __func__, ret);
 			return ret;
@@ -1910,7 +1897,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 						  true, INTEL_MASTER_RESET_ITERATIONS);
 
 	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
-		ret = intel_init(sdw);
+		ret = intel_link_power_up(sdw);
 		if (ret) {
 			dev_err(dev, "%s failed: %d\n", __func__, ret);
 			return ret;
@@ -1991,7 +1978,7 @@ static int __maybe_unused intel_resume_runtime(struct device *dev)
 		if (!clock_stop0)
 			dev_err(dev, "%s invalid configuration, clock was not stopped", __func__);
 
-		ret = intel_init(sdw);
+		ret = intel_link_power_up(sdw);
 		if (ret) {
 			dev_err(dev, "%s failed: %d\n", __func__, ret);
 			return ret;
-- 
2.25.1

