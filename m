Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C775BD410
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiISRvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiISRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:50:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE5B402F8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609849; x=1695145849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QdddNi3xNXTqW9R7OXfPq7qq+hZkkcHfGOJFzY4TwbA=;
  b=FHKPe7YXGMQ3pNihe9Wtr6m0CF288rwfMN9jxR19bLvysuv9QLun4tnb
   oKf2pJIEKxYgIb1J1eBBiPzjPceK6Zt7iAgwMv3U/VaKGifmUVda4uF7x
   R+g5qUkvRELZ16VNCs+5TVzdxRVJVQMuHNC4IqEGZPDGZOHl51r+uewlN
   vlbQm5c7NdNWGMIRnvDSuNgYpyZIU+QicQOaFaSuvNqkBzyhqtYEDbqOR
   Yk6yKlE24X8BxVS+XlEWV/Lp6J2L/hDq76XpoyGFTdKvZ/NcX3DJcUqST
   rjTue6tsOvGitZjTvaWdkzdE0ExsbDJQJgrahi/xnVNt7104LFed14M/H
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363429205"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363429205"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863658402"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:46 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 04/11] soundwire: intel: move all PDI initialization under intel_register_dai()
Date:   Tue, 20 Sep 2022 01:57:14 +0800
Message-Id: <20220919175721.354679-5-yung-chuan.liao@linux.intel.com>
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

Start regrouping functionality in high-level functions.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index d7852cc7dd96..676de04c5070 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1171,11 +1171,20 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 
 static int intel_register_dai(struct sdw_intel *sdw)
 {
+	struct sdw_cdns_stream_config config;
 	struct sdw_cdns *cdns = &sdw->cdns;
 	struct sdw_cdns_streams *stream;
 	struct snd_soc_dai_driver *dais;
 	int num_dai, ret, off = 0;
 
+	/* Read the PDI config and initialize cadence PDI */
+	intel_pdi_init(sdw, &config);
+	ret = sdw_cdns_pdi_init(cdns, config);
+	if (ret)
+		return ret;
+
+	intel_pdi_ch_update(sdw);
+
 	/* DAIs are created based on total number of PDIs supported */
 	num_dai = cdns->pcm.num_pdi;
 
@@ -1347,7 +1356,6 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 
 int intel_link_startup(struct auxiliary_device *auxdev)
 {
-	struct sdw_cdns_stream_config config;
 	struct device *dev = &auxdev->dev;
 	struct sdw_cdns *cdns = auxiliary_get_drvdata(auxdev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
@@ -1385,14 +1393,6 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 	if (ret)
 		goto err_init;
 
-	/* Read the PDI config and initialize cadence PDI */
-	intel_pdi_init(sdw, &config);
-	ret = sdw_cdns_pdi_init(cdns, config);
-	if (ret)
-		goto err_init;
-
-	intel_pdi_ch_update(sdw);
-
 	/* Register DAIs */
 	ret = intel_register_dai(sdw);
 	if (ret) {
-- 
2.25.1

