Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B765BD417
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiISRv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiISRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:51:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0012644556
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609858; x=1695145858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=081EPmTS3y815iiCscPub7rqoLD2JH0w0KdPzW1+ikI=;
  b=C7RPc5Svqlhk+sS2TI7iLb3HY3u/3nhO243uvBRLyya2QPKefVXS7ZHI
   gSR7AJXDtk0APlLxV2heqkh1Pg/TPtwInHDmZR9gWGQSo/YXy3nyX7QUr
   3Og2uTNZtP1CZ/dhOYVBZGNhY13r4X190I/064DyGULNXG3rpPdtMwj68
   xLlJ0p9djA46pLyMVmgIpP3Olzw2ruxCJObRCYnQFRFZ/57fWItuLsMzu
   fu+1KjjKQNTQqs9Ka2xK2eFdSiVmmh9DITSey2hhCmh2udv7ie/vvlLdO
   VLKWeIQ9ppJZud/I6JnPGWB/+wnwh6rOqA9SXh6GPGyF2Sep+SqsbNGg+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363429319"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363429319"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863658548"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:56 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 09/11] soundwire: intel: introduce intel_shim_check_wake() helper
Date:   Tue, 20 Sep 2022 01:57:19 +0800
Message-Id: <20220919175721.354679-10-yung-chuan.liao@linux.intel.com>
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

Add new helper before code partitioning in order to avoid direct read
from specific register. No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 66aab02b9323..2ca924622153 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -344,6 +344,17 @@ static void intel_shim_init(struct sdw_intel *sdw)
 	usleep_range(10, 15);
 }
 
+static int intel_shim_check_wake(struct sdw_intel *sdw)
+{
+	void __iomem *shim;
+	u16 wake_sts;
+
+	shim = sdw->link_res->shim;
+	wake_sts = intel_readw(shim, SDW_SHIM_WAKESTS);
+
+	return wake_sts & BIT(sdw->instance);
+}
+
 static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
 {
 	void __iomem *shim = sdw->link_res->shim;
@@ -1491,8 +1502,6 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
 	struct device *dev = &auxdev->dev;
 	struct sdw_intel *sdw;
 	struct sdw_bus *bus;
-	void __iomem *shim;
-	u16 wake_sts;
 
 	sdw = auxiliary_get_drvdata(auxdev);
 	bus = &sdw->cdns.bus;
@@ -1503,10 +1512,7 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
 		return 0;
 	}
 
-	shim = sdw->link_res->shim;
-	wake_sts = intel_readw(shim, SDW_SHIM_WAKESTS);
-
-	if (!(wake_sts & BIT(sdw->instance)))
+	if (!intel_shim_check_wake(sdw))
 		return 0;
 
 	/* disable WAKEEN interrupt ASAP to prevent interrupt flood */
-- 
2.25.1

