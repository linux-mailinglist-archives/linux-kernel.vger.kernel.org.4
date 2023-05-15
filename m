Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95126702560
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjEOGwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbjEOGvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:51:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7115171C
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133489; x=1715669489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wsFbcSJtx/AlSmGIw0DdUSJEopY6I39DINuaH9UuTy0=;
  b=S+NrvFbR0iDHJ5XGAcV6zcKUC6rqeVW1EuFQ5OBbsxGdvV3APGPQ+x/1
   6h61y+zXBu6FZF536cbf5q9HBckn6uEXsubRnmaF6IDRtyjlXE1BpD1h1
   hzOdysSETzY7UWw014WBKYtZRZ7/7JToO3EQ7NEBdYETZzef1JaXXH4iN
   w1V4pdsTQERQNGdf0nfq3mWul7lC3bIUigsbQk8KpSaxkUL0gWLzepxRb
   IMNpd3Ibw4nSswvB20i9fO4w+E8vLrF+kKZXbW1Qs6MHOV3jcj4xapuNU
   9uApUMCyxHyiMn1MS8S3xtjZSi3s1j0G5CJQQOq2A0Hjv80sivUiSnOpM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966445"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966445"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908736"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908736"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:54 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 15/26] soundwire: intel_ace2x: add sync_arm/sync_go helpers
Date:   Mon, 15 May 2023 15:10:31 +0800
Message-Id: <20230515071042.2038-16-yung-chuan.liao@linux.intel.com>
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

