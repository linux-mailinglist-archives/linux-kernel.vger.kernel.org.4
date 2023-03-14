Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047076B87C2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjCNBlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCNBlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:14 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB8C72B10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758074; x=1710294074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r4jXVCJhzsOs1ZDy2WVg/GiSmTDBrRuP65jWFiuOPLM=;
  b=chgk4FBqhOLKxBgJLvaXPc+Bu3qLybq5H50srnKAirS4IHo5pZXD1QNA
   AoqJhOLUX1xTf2+KNO9l32pRpPE2DvhVzxpvENGklL6SJNnv8TUYoHgrP
   BX2+Mq9sgvyCwUFwI5r2io03CGkqofrSI90R3Tp/UKX2uxB0Vnf9CdUdZ
   VP/gBO/BkRfu7jODA6JclsEOuQuSsS3Jud5j89YKK3C/PVIJIHKVWY3s2
   yhExEEUfahxb1wj3hB2k9cXwfHpRbg/O9sdw7mr78a6YqP/r21X0nOp3K
   hnGMQ7I1RMY9/0A+0LXDH6L+DjNZ2olq6UhsVQniciuLw8cFSeQRB5K38
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949226"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949226"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327372"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327372"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:10 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 03/16] soundwire: intel: remove PDI-level restrictions on rates and formats
Date:   Tue, 14 Mar 2023 09:53:57 +0800
Message-Id: <20230314015410.487311-4-yung-chuan.liao@linux.intel.com>
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

This is not relevant and not aligned with hardware definitions. In
addition, we've tested higher resolution formats so this is ignored at
a higher level.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 924dff670170..6c17baab7923 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1066,15 +1066,11 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_OUT) {
 			dais[i].playback.channels_min = 1;
 			dais[i].playback.channels_max = max_ch;
-			dais[i].playback.rates = SNDRV_PCM_RATE_48000;
-			dais[i].playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
 		}
 
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_IN) {
 			dais[i].capture.channels_min = 1;
 			dais[i].capture.channels_max = max_ch;
-			dais[i].capture.rates = SNDRV_PCM_RATE_48000;
-			dais[i].capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
 		}
 
 		dais[i].ops = &intel_pcm_dai_ops;
-- 
2.25.1

