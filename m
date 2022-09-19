Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567FB5BD412
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiISRvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiISRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:50:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CD343620
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609853; x=1695145853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5FyW8xBbXeJkum8aRiIIbDtkh2gfMubt0it9/PXMLG8=;
  b=JK5jexsSo27EZ3OXGaC7S+Eq7tRdIk63PBJw21NcCGRYm9sP3ZY9Aqsn
   w8iwfrE0OdZ0NdeicTkhHSndfHXlqvYtK/3zRMMLSN654zGF2Uvzkbst0
   EzvgAcfL0+pD/7XUHLKmYNwo9e3d1DOuURzpXaVnHk7iRsjjMNylp5KbF
   iBxQA+CiEvTHO8Qksf33mQWkeXF7edlzhF4iJTKzg1mQ098vTHoVs0ajU
   Au63qfjaXcjkXKPfgr43/mv7ChiKBnoWvqRN9RLKboy3q9Gha7sD1v7a7
   O6hUVTDSnv6hITPa2ZqJSiayrgAsCbVPg7TfrUMWf/fh1sH8p9Cm9BLcK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363429261"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363429261"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863658448"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:50 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 06/11] soundwire: intel: move shim initialization before power up/down
Date:   Tue, 20 Sep 2022 01:57:16 +0800
Message-Id: <20220919175721.354679-7-yung-chuan.liao@linux.intel.com>
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

Move code around before additional simplification. No functionality
change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 231 +++++++++++++++++++-------------------
 1 file changed, 115 insertions(+), 116 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 2d828d98e153..140cf36eb407 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -260,6 +260,121 @@ static void intel_debugfs_exit(struct sdw_intel *sdw) {}
 /*
  * shim ops
  */
+/* this needs to be called with shim_lock */
+static void intel_shim_glue_to_master_ip(struct sdw_intel *sdw)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	unsigned int link_id = sdw->instance;
+	u16 ioctl;
+
+	/* Switch to MIP from Glue logic */
+	ioctl = intel_readw(shim,  SDW_SHIM_IOCTL(link_id));
+
+	ioctl &= ~(SDW_SHIM_IOCTL_DOE);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl &= ~(SDW_SHIM_IOCTL_DO);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl |= (SDW_SHIM_IOCTL_MIF);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl &= ~(SDW_SHIM_IOCTL_BKE);
+	ioctl &= ~(SDW_SHIM_IOCTL_COE);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	/* at this point Master IP has full control of the I/Os */
+}
+
+/* this needs to be called with shim_lock */
+static void intel_shim_master_ip_to_glue(struct sdw_intel *sdw)
+{
+	unsigned int link_id = sdw->instance;
+	void __iomem *shim = sdw->link_res->shim;
+	u16 ioctl;
+
+	/* Glue logic */
+	ioctl = intel_readw(shim, SDW_SHIM_IOCTL(link_id));
+	ioctl |= SDW_SHIM_IOCTL_BKE;
+	ioctl |= SDW_SHIM_IOCTL_COE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl &= ~(SDW_SHIM_IOCTL_MIF);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	/* at this point Integration Glue has full control of the I/Os */
+}
+
+static int intel_shim_init(struct sdw_intel *sdw)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	unsigned int link_id = sdw->instance;
+	int ret = 0;
+	u16 ioctl = 0, act = 0;
+
+	mutex_lock(sdw->link_res->shim_lock);
+
+	/* Initialize Shim */
+	ioctl |= SDW_SHIM_IOCTL_BKE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl |= SDW_SHIM_IOCTL_WPDD;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl |= SDW_SHIM_IOCTL_DO;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	ioctl |= SDW_SHIM_IOCTL_DOE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+	usleep_range(10, 15);
+
+	intel_shim_glue_to_master_ip(sdw);
+
+	u16p_replace_bits(&act, 0x1, SDW_SHIM_CTMCTL_DOAIS);
+	act |= SDW_SHIM_CTMCTL_DACTQE;
+	act |= SDW_SHIM_CTMCTL_DODS;
+	intel_writew(shim, SDW_SHIM_CTMCTL(link_id), act);
+	usleep_range(10, 15);
+
+	mutex_unlock(sdw->link_res->shim_lock);
+
+	return ret;
+}
+
+static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	unsigned int link_id = sdw->instance;
+	u16 wake_en, wake_sts;
+
+	mutex_lock(sdw->link_res->shim_lock);
+	wake_en = intel_readw(shim, SDW_SHIM_WAKEEN);
+
+	if (wake_enable) {
+		/* Enable the wakeup */
+		wake_en |= (SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKEEN, wake_en);
+	} else {
+		/* Disable the wake up interrupt */
+		wake_en &= ~(SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKEEN, wake_en);
+
+		/* Clear wake status */
+		wake_sts = intel_readw(shim, SDW_SHIM_WAKESTS);
+		wake_sts |= (SDW_SHIM_WAKESTS_STATUS << link_id);
+		intel_writew(shim, SDW_SHIM_WAKESTS, wake_sts);
+	}
+	mutex_unlock(sdw->link_res->shim_lock);
+}
 
 static int intel_link_power_up(struct sdw_intel *sdw)
 {
@@ -340,122 +455,6 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	return ret;
 }
 
-/* this needs to be called with shim_lock */
-static void intel_shim_glue_to_master_ip(struct sdw_intel *sdw)
-{
-	void __iomem *shim = sdw->link_res->shim;
-	unsigned int link_id = sdw->instance;
-	u16 ioctl;
-
-	/* Switch to MIP from Glue logic */
-	ioctl = intel_readw(shim,  SDW_SHIM_IOCTL(link_id));
-
-	ioctl &= ~(SDW_SHIM_IOCTL_DOE);
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	ioctl &= ~(SDW_SHIM_IOCTL_DO);
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	ioctl |= (SDW_SHIM_IOCTL_MIF);
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	ioctl &= ~(SDW_SHIM_IOCTL_BKE);
-	ioctl &= ~(SDW_SHIM_IOCTL_COE);
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	/* at this point Master IP has full control of the I/Os */
-}
-
-/* this needs to be called with shim_lock */
-static void intel_shim_master_ip_to_glue(struct sdw_intel *sdw)
-{
-	unsigned int link_id = sdw->instance;
-	void __iomem *shim = sdw->link_res->shim;
-	u16 ioctl;
-
-	/* Glue logic */
-	ioctl = intel_readw(shim, SDW_SHIM_IOCTL(link_id));
-	ioctl |= SDW_SHIM_IOCTL_BKE;
-	ioctl |= SDW_SHIM_IOCTL_COE;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	ioctl &= ~(SDW_SHIM_IOCTL_MIF);
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	/* at this point Integration Glue has full control of the I/Os */
-}
-
-static int intel_shim_init(struct sdw_intel *sdw)
-{
-	void __iomem *shim = sdw->link_res->shim;
-	unsigned int link_id = sdw->instance;
-	int ret = 0;
-	u16 ioctl = 0, act = 0;
-
-	mutex_lock(sdw->link_res->shim_lock);
-
-	/* Initialize Shim */
-	ioctl |= SDW_SHIM_IOCTL_BKE;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	ioctl |= SDW_SHIM_IOCTL_WPDD;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	ioctl |= SDW_SHIM_IOCTL_DO;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	ioctl |= SDW_SHIM_IOCTL_DOE;
-	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
-	usleep_range(10, 15);
-
-	intel_shim_glue_to_master_ip(sdw);
-
-	u16p_replace_bits(&act, 0x1, SDW_SHIM_CTMCTL_DOAIS);
-	act |= SDW_SHIM_CTMCTL_DACTQE;
-	act |= SDW_SHIM_CTMCTL_DODS;
-	intel_writew(shim, SDW_SHIM_CTMCTL(link_id), act);
-	usleep_range(10, 15);
-
-	mutex_unlock(sdw->link_res->shim_lock);
-
-	return ret;
-}
-
-static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
-{
-	void __iomem *shim = sdw->link_res->shim;
-	unsigned int link_id = sdw->instance;
-	u16 wake_en, wake_sts;
-
-	mutex_lock(sdw->link_res->shim_lock);
-	wake_en = intel_readw(shim, SDW_SHIM_WAKEEN);
-
-	if (wake_enable) {
-		/* Enable the wakeup */
-		wake_en |= (SDW_SHIM_WAKEEN_ENABLE << link_id);
-		intel_writew(shim, SDW_SHIM_WAKEEN, wake_en);
-	} else {
-		/* Disable the wake up interrupt */
-		wake_en &= ~(SDW_SHIM_WAKEEN_ENABLE << link_id);
-		intel_writew(shim, SDW_SHIM_WAKEEN, wake_en);
-
-		/* Clear wake status */
-		wake_sts = intel_readw(shim, SDW_SHIM_WAKESTS);
-		wake_sts |= (SDW_SHIM_WAKESTS_STATUS << link_id);
-		intel_writew(shim, SDW_SHIM_WAKESTS, wake_sts);
-	}
-	mutex_unlock(sdw->link_res->shim_lock);
-}
-
 static int intel_link_power_down(struct sdw_intel *sdw)
 {
 	u32 link_control, spa_mask, cpa_mask;
-- 
2.25.1

