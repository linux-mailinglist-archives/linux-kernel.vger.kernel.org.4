Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A712C6B87B5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCNBld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCNBlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224E172B10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758085; x=1710294085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2J/lbv6Wvy/4qm3q1nHlORWUYNqsoXkS5u9Wi+zdC3Q=;
  b=DyVDBKDc6i8/s3hfzeIAKaUKW2QyUV1CD5sW7tCka9ct2hVvc7lckQsW
   VFO0DuirfT64E7fhjZuqf73SBGYIrbAVT4giY+KqWY6MhTBvyG7P3yq/Y
   brYUaTV3rlZV5+DxY0AYDcOjbGgzV9cGOXPBo6WMGoqtGKk+Ctgo3Map9
   sJTgMmV8NZI46rbUReV0jOPX1LoKZ6kls5VmtbBsJUg9hq5xneBe07Liq
   ESFU59vi71h73Ao1ffGNzylTAkn6sMJQif8iAYPRCp2xNz1c6yvgTzFFT
   CuX6A2NQrTKn4apfyJc6XWafxIuPgjx1FBLY6VR76bOhR5IK9kyNnIsbi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949257"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949257"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327439"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327439"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:18 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 07/16] soundwire: intel: use indirection before moving bus start/stop sequences
Date:   Tue, 14 Mar 2023 09:54:01 +0800
Message-Id: <20230314015410.487311-8-yung-chuan.liao@linux.intel.com>
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

There was no benefit to using the existing abstraction, but since we
are going to move the code make sure we do use the ops.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 902934cbb27b..8395a20e5739 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1311,13 +1311,13 @@ static int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
 		return ret;
 	}
 
-	ret = intel_link_power_down(sdw);
+	ret = sdw_intel_link_power_down(sdw);
 	if (ret) {
 		dev_err(dev, "%s: Link power down failed: %d\n", __func__, ret);
 		return ret;
 	}
 
-	intel_shim_wake(sdw, wake_enable);
+	sdw_intel_shim_wake(sdw, wake_enable);
 
 	return 0;
 }
-- 
2.25.1

