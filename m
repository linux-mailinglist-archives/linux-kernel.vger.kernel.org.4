Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47760614341
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKACap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiKACaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:30:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B4D1789C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667269838; x=1698805838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=za/Z9PfLJMMXCFFtbbmJABNMg+7cNftbJHk93bK/Hts=;
  b=D4wFLvaUTbagrjCWGeIx5Y0dUrV4z1Nw8IIswcS7p8+Bbs92tOkXzzSD
   cTKlGaIhxKy4C5fzVdb2Sjf1FBERM+jixgQwj5aLf/l9FSVXXXVvRqjXK
   Z6bMfIzbMfwVlc+0w28dFoivxmi9R/N6EC5VB6oQ8JD6gjQxS09odJkAj
   mjSYhDKOdCPCFWDTIHLIvs8kcdRaZPB7cTnrRN/ZNxCzoA2VsGXTsRLKm
   c6mGPedGRzFfGHI606yzBkz7xrXCDwykR/z52lQ9/25AtiqydMvgyhiNs
   pf++EWuL9+PlblhRtfTdNA2tChsB6EY72UX0cj7scGfsdTwG3/ou2wlzl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="288763726"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="288763726"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 19:30:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="611709385"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="611709385"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 19:30:36 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 2/2] soundwire: cadence: use dai_runtime_array instead of dma_data
Date:   Tue,  1 Nov 2022 10:35:21 +0800
Message-Id: <20221101023521.2384586-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101023521.2384586-1-yung-chuan.liao@linux.intel.com>
References: <20221101023521.2384586-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Simplify the code with a Cadence-specific dai_runtime_array, indexed
with dai->id, instead of abusing dma_data.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 30 +++++++++++++--------------
 drivers/soundwire/cadence_master.h |  5 +++++
 drivers/soundwire/intel.c          | 33 +++++++++++++++---------------
 3 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 235617b0542f..a1de363eba3f 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1709,13 +1709,10 @@ int cdns_set_sdw_stream(struct snd_soc_dai *dai,
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_cdns_dai_runtime *dai_runtime;
 
+	dai_runtime = cdns->dai_runtime_array[dai->id];
+
 	if (stream) {
 		/* first paranoia check */
-		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-			dai_runtime = dai->playback_dma_data;
-		else
-			dai_runtime = dai->capture_dma_data;
-
 		if (dai_runtime) {
 			dev_err(dai->dev,
 				"dai_runtime already allocated for dai %s\n",
@@ -1734,20 +1731,21 @@ int cdns_set_sdw_stream(struct snd_soc_dai *dai,
 		dai_runtime->link_id = cdns->instance;
 
 		dai_runtime->stream = stream;
+		dai_runtime->direction = direction;
 
-		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-			dai->playback_dma_data = dai_runtime;
-		else
-			dai->capture_dma_data = dai_runtime;
+		cdns->dai_runtime_array[dai->id] = dai_runtime;
 	} else {
+		/* second paranoia check */
+		if (!dai_runtime) {
+			dev_err(dai->dev,
+				"dai_runtime not allocated for dai %s\n",
+				dai->name);
+			return -EINVAL;
+		}
+
 		/* for NULL stream we release allocated dai_runtime */
-		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
-			kfree(dai->playback_dma_data);
-			dai->playback_dma_data = NULL;
-		} else {
-			kfree(dai->capture_dma_data);
-			dai->capture_dma_data = NULL;
-		}
+		kfree(dai_runtime);
+		cdns->dai_runtime_array[dai->id] = NULL;
 	}
 	return 0;
 }
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 93f23bd46e2c..0434d70d4b1f 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -81,6 +81,7 @@ struct sdw_cdns_stream_config {
  * @hw_params: hw_params to be applied in .prepare step
  * @suspended: status set when suspended, to be used in .prepare
  * @paused: status set in .trigger, to be used in suspend
+ * @direction: stream direction
  */
 struct sdw_cdns_dai_runtime {
 	char *name;
@@ -92,6 +93,7 @@ struct sdw_cdns_dai_runtime {
 	struct snd_pcm_hw_params *hw_params;
 	bool suspended;
 	bool paused;
+	int direction;
 };
 
 /**
@@ -108,6 +110,7 @@ struct sdw_cdns_dai_runtime {
  * @registers: Cadence registers
  * @link_up: Link status
  * @msg_count: Messages sent on bus
+ * @dai_runtime_array: runtime context for each allocated DAI.
  */
 struct sdw_cdns {
 	struct device *dev;
@@ -135,6 +138,8 @@ struct sdw_cdns {
 	struct work_struct work;
 
 	struct list_head list;
+
+	struct sdw_cdns_dai_runtime **dai_runtime_array;
 };
 
 #define bus_to_cdns(_bus) container_of(_bus, struct sdw_cdns, bus)
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 1e9c6df4b62c..e8855a2115f6 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -831,7 +831,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	int ch, dir;
 	int ret;
 
-	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	dai_runtime = cdns->dai_runtime_array[dai->id];
 	if (!dai_runtime)
 		return -EIO;
 
@@ -902,7 +902,7 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 	int ch, dir;
 	int ret = 0;
 
-	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	dai_runtime = cdns->dai_runtime_array[dai->id];
 	if (!dai_runtime) {
 		dev_err(dai->dev, "failed to get dai runtime in %s\n",
 			__func__);
@@ -949,7 +949,7 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ret;
 
-	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	dai_runtime = cdns->dai_runtime_array[dai->id];
 	if (!dai_runtime)
 		return -EIO;
 
@@ -996,13 +996,10 @@ static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
 static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
 				  int direction)
 {
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_cdns_dai_runtime *dai_runtime;
 
-	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dai_runtime = dai->playback_dma_data;
-	else
-		dai_runtime = dai->capture_dma_data;
-
+	dai_runtime = cdns->dai_runtime_array[dai->id];
 	if (!dai_runtime)
 		return ERR_PTR(-EINVAL);
 
@@ -1025,7 +1022,7 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 	if (res->ops && res->ops->trigger)
 		res->ops->trigger(dai, cmd, substream->stream);
 
-	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	dai_runtime = cdns->dai_runtime_array[dai->id];
 	if (!dai_runtime) {
 		dev_err(dai->dev, "failed to get dai runtime in %s\n",
 			__func__);
@@ -1092,15 +1089,9 @@ static int intel_component_dais_suspend(struct snd_soc_component *component)
 		struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 		struct sdw_intel *sdw = cdns_to_intel(cdns);
 		struct sdw_cdns_dai_runtime *dai_runtime;
-		int stream;
 		int ret;
 
-		dai_runtime = dai->playback_dma_data;
-		stream = SNDRV_PCM_STREAM_PLAYBACK;
-		if (!dai_runtime) {
-			dai_runtime = dai->capture_dma_data;
-			stream = SNDRV_PCM_STREAM_CAPTURE;
-		}
+		dai_runtime = cdns->dai_runtime_array[dai->id];
 
 		if (!dai_runtime)
 			continue;
@@ -1111,7 +1102,7 @@ static int intel_component_dais_suspend(struct snd_soc_component *component)
 		if (dai_runtime->paused) {
 			dai_runtime->suspended = true;
 
-			ret = intel_free_stream(sdw, stream, dai, sdw->instance);
+			ret = intel_free_stream(sdw, dai_runtime->direction, dai, sdw->instance);
 			if (ret < 0)
 				return ret;
 		}
@@ -1178,6 +1169,7 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 
 static int intel_register_dai(struct sdw_intel *sdw)
 {
+	struct sdw_cdns_dai_runtime **dai_runtime_array;
 	struct sdw_cdns_stream_config config;
 	struct sdw_cdns *cdns = &sdw->cdns;
 	struct sdw_cdns_streams *stream;
@@ -1195,6 +1187,13 @@ static int intel_register_dai(struct sdw_intel *sdw)
 	/* DAIs are created based on total number of PDIs supported */
 	num_dai = cdns->pcm.num_pdi;
 
+	dai_runtime_array = devm_kcalloc(cdns->dev, num_dai,
+					 sizeof(struct sdw_cdns_dai_runtime *),
+					 GFP_KERNEL);
+	if (!dai_runtime_array)
+		return -ENOMEM;
+	cdns->dai_runtime_array = dai_runtime_array;
+
 	dais = devm_kcalloc(cdns->dev, num_dai, sizeof(*dais), GFP_KERNEL);
 	if (!dais)
 		return -ENOMEM;
-- 
2.25.1

