Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0718B6B87BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCNBlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjCNBlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D412474336
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758076; x=1710294076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hZc2EGLHxJx9i0Pailyxx3z91nn/GaDqbMywZWeyhkI=;
  b=YLUnoCe8xt5wcRgld27H58jEcQOyK3Ck3OK8afCg2a7WDDJp56Jlx0uH
   zy+P4siAoUA7rwMXtPKmJOcI3S3Zbkhc9NwLNI9GhNHbCm9Asy9tiyCys
   MbUdGADjePEi2ZxqtFSIZ6ZRHCIPvGLf/yp/9oWqHtQV4Nh5XLaYkTKM0
   2GBEPFGJvhfxFTGke+5ELuoP4G5VConNR1TXeX6RHn67MHNBKJAGOeuj6
   GyLtdYZsBKKtyzAZEoG2A+6/f/5S+CwN6QhZTnkqnr3oLbZz36P6QZLIG
   eBVPFmXeyaXM5H4855oPDlUBRNp+T3JWS6ic2SEnWYrpeWTFjZ270SNxZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949239"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949239"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327399"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327399"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:14 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 05/16] soundwire: intel: simplify sync_go sequence
Date:   Tue, 14 Mar 2023 09:53:59 +0800
Message-Id: <20230314015410.487311-6-yung-chuan.liao@linux.intel.com>
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

In the existing code, the SHIM_SYNC::SYNC_GO bit is set, and the code
waits for it to return to zero.

That second wait part is just wrong: the SYNC_GO bit is *write-only* so
there's no way to know if it's cleared by hardware. The code works
because the value for a read-only bit is zero, but that's really just
luck.

Simplify the sequence to a plain read-modify-write.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 2c1c905f8889..6fdb10117e59 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -475,7 +475,6 @@ static int intel_shim_sync_go_unlocked(struct sdw_intel *sdw)
 {
 	void __iomem *shim = sdw->link_res->shim;
 	u32 sync_reg;
-	int ret;
 
 	/* Read SYNC register */
 	sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
@@ -487,13 +486,9 @@ static int intel_shim_sync_go_unlocked(struct sdw_intel *sdw)
 	 */
 	sync_reg |= SDW_SHIM_SYNC_SYNCGO;
 
-	ret = intel_clear_bit(shim, SDW_SHIM_SYNC, sync_reg,
-			      SDW_SHIM_SYNC_SYNCGO);
+	intel_writel(shim, SDW_SHIM_SYNC, sync_reg);
 
-	if (ret < 0)
-		dev_err(sdw->cdns.dev, "SyncGO clear failed: %d\n", ret);
-
-	return ret;
+	return 0;
 }
 
 static int intel_shim_sync_go(struct sdw_intel *sdw)
-- 
2.25.1

