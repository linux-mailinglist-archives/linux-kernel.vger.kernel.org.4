Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FBF5BD40F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiISRu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiISRus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:50:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C004440BFB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609847; x=1695145847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=grC3JO/QhhKE8hi6QZ/jj64Nuz3BhMdMj/nvoJJ91hs=;
  b=cRIB5KToQWybokugm+xBquyReA5OuNQo+Sn2w4mleYe8XYZgP/Ywdxn3
   SrNJYwMUvrr4lGZ9pagoBkQG0uaVZgA1aSuzxhxlFpnKpU1DOPyOGI32G
   qF0D228zFEp/R0BpjBRWgIsXPHwz9JUYdjDJvIdfrtmwP+OqdVyW5CrXZ
   qxT+Tu0upUMmzV1iu4WWe//BScSxIxZJHxixhBwSXyRg6MC4WMxgf73d3
   x49UzSPT5l1rKQWRAbvicMNGVVhI09pU9Xufrz80bA6RTyGwRu2+r9/w+
   jtOYK/ZBZyTSN0OgMOML0FnJSnjoiO2oN+QAnZQyLUScIVHYi+3L0mVtT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363429185"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363429185"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863658388"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:44 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 03/11] soundwire: intel: move DAI registration and debugfs init earlier
Date:   Tue, 20 Sep 2022 01:57:13 +0800
Message-Id: <20220919175721.354679-4-yung-chuan.liao@linux.intel.com>
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

These two steps can and should be done before starting up the clock
and the bus operation. This is a first step before re-grouping
functionality in well-defined callbacks.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index a6fe91f2d964..d7852cc7dd96 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1393,6 +1393,15 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 
 	intel_pdi_ch_update(sdw);
 
+	/* Register DAIs */
+	ret = intel_register_dai(sdw);
+	if (ret) {
+		dev_err(dev, "DAI registration failed: %d\n", ret);
+		goto err_init;
+	}
+
+	intel_debugfs_init(sdw);
+
 	ret = sdw_cdns_enable_interrupt(cdns, true);
 	if (ret < 0) {
 		dev_err(dev, "cannot enable interrupts\n");
@@ -1428,15 +1437,6 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	sdw_cdns_check_self_clearing_bits(cdns, __func__,
 					  true, INTEL_MASTER_RESET_ITERATIONS);
 
-	/* Register DAIs */
-	ret = intel_register_dai(sdw);
-	if (ret) {
-		dev_err(dev, "DAI registration failed: %d\n", ret);
-		goto err_interrupt;
-	}
-
-	intel_debugfs_init(sdw);
-
 	/* Enable runtime PM */
 	if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME)) {
 		pm_runtime_set_autosuspend_delay(dev,
-- 
2.25.1

