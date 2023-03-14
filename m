Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548356B87C0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCNBlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCNBlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C8972B10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758075; x=1710294075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E1vpSUnv0GpopyC7lDUkDQqhHE9rQzhik8od9N+jq4w=;
  b=PE3jgalQU8e0GMhkr9L3f4Dq94oqJ9+73GQmk0LYzODp+nUN/4PD2f2M
   u9SuT+7xdbGaa3N/NVuh2i2W9DqjKplHjA+KSAiO7bF5AvVoJypSTtsWO
   MbKkQHx98aaQkAJ0qyuGkaTJ94C/XEIYOGMK6ZFs+/vrZSrSJt8zemVkx
   iL5aUaUQXlwgalTzt0O1VlggXYJqrza+L9yHYH3jx0c1KFjZOjwuVHjqY
   W+eUQFwiqPBULwi0Dq4DcehMjZ/oVwF11VMBqGeVOG1jogHdO6LCFutpa
   d+MYJLIS/7l0I9wLHq7NXq4OjdU+hHDb5icbA3dza17ZhfGvXJ6Yu+9uV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949233"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949233"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327386"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327386"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:12 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 04/16] soundwire: intel: remove useless abstraction
Date:   Tue, 14 Mar 2023 09:53:58 +0800
Message-Id: <20230314015410.487311-5-yung-chuan.liao@linux.intel.com>
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

PDM is supported in the hardware but never enabled: there are no known
PDM-based devices. We can directly call the PCM helper.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 6c17baab7923..2c1c905f8889 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -586,13 +586,6 @@ static int intel_pdi_stream_ch_update(struct sdw_intel *sdw,
 	return 0;
 }
 
-static int intel_pdi_ch_update(struct sdw_intel *sdw)
-{
-	intel_pdi_stream_ch_update(sdw, &sdw->cdns.pcm);
-
-	return 0;
-}
-
 static void
 intel_pdi_shim_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 {
@@ -1094,7 +1087,7 @@ static int intel_register_dai(struct sdw_intel *sdw)
 	if (ret)
 		return ret;
 
-	intel_pdi_ch_update(sdw);
+	intel_pdi_stream_ch_update(sdw, &sdw->cdns.pcm);
 
 	/* DAIs are created based on total number of PDIs supported */
 	num_dai = cdns->pcm.num_pdi;
-- 
2.25.1

