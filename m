Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C393614340
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiKACak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiKACai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:30:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA44D13E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667269837; x=1698805837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nha+cAjfFYdN1e072igYPcVQvV7I74uH4Vu/8Q6fFzs=;
  b=cVbR38duo71+LGFeYXHSir8+aGau4gJ/8nGrlgtYUujdNswgsEDB0ilE
   WcDyBhVFNJ+Wu/wPqHpPK5IRzLyTXH9r0VezuryXf9+cmP+3P5cBczvW2
   lsWB8HVRVtY2f71kp+hOxHk6t6foHnMfhv8MjYKLOFO1SRNeZyV/0UhTy
   fnNJG9AqOhW6qp7nVZxrUvY1gw51ufpaOFL0jqTlp3RfzWxifEYoy1JgP
   a5AkxRqfWLUS3dphgnjfI1WEE3APw3rm7qONjHESFbHa/LlBAyIxZvEmO
   tMmzmD1SgD03Hpxiz6SPM1lIUSMlrahHj/nrX/yaB8OTt4xumzwEgNf3V
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="288763723"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="288763723"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 19:30:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="611709369"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="611709369"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 19:30:34 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: cadence: rename sdw_cdns_dai_dma_data as sdw_cdns_dai_runtime
Date:   Tue,  1 Nov 2022 10:35:20 +0800
Message-Id: <20221101023521.2384586-2-yung-chuan.liao@linux.intel.com>
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

The existing 'struct sdw_cdns_dma_data' has really nothing to do with
DMAs. The information is stored in the dai->dma_data, but this is
really private data that should be stored in a different context.

Beyond the academic elegance discussion, using dma_data is a problem
for new Intel hardware where the dma_data structure is already used
for true DMA handling performed by other parts of the code.

This patch prepares a transition away from the use of dma_data, for
now with a rename-only change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 30 +++++-----
 drivers/soundwire/cadence_master.h |  4 +-
 drivers/soundwire/intel.c          | 96 +++++++++++++++---------------
 3 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 93929f19d083..235617b0542f 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1707,40 +1707,40 @@ int cdns_set_sdw_stream(struct snd_soc_dai *dai,
 			void *stream, int direction)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 
 	if (stream) {
 		/* first paranoia check */
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-			dma = dai->playback_dma_data;
+			dai_runtime = dai->playback_dma_data;
 		else
-			dma = dai->capture_dma_data;
+			dai_runtime = dai->capture_dma_data;
 
-		if (dma) {
+		if (dai_runtime) {
 			dev_err(dai->dev,
-				"dma_data already allocated for dai %s\n",
+				"dai_runtime already allocated for dai %s\n",
 				dai->name);
 			return -EINVAL;
 		}
 
-		/* allocate and set dma info */
-		dma = kzalloc(sizeof(*dma), GFP_KERNEL);
-		if (!dma)
+		/* allocate and set dai_runtime info */
+		dai_runtime = kzalloc(sizeof(*dai_runtime), GFP_KERNEL);
+		if (!dai_runtime)
 			return -ENOMEM;
 
-		dma->stream_type = SDW_STREAM_PCM;
+		dai_runtime->stream_type = SDW_STREAM_PCM;
 
-		dma->bus = &cdns->bus;
-		dma->link_id = cdns->instance;
+		dai_runtime->bus = &cdns->bus;
+		dai_runtime->link_id = cdns->instance;
 
-		dma->stream = stream;
+		dai_runtime->stream = stream;
 
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-			dai->playback_dma_data = dma;
+			dai->playback_dma_data = dai_runtime;
 		else
-			dai->capture_dma_data = dma;
+			dai->capture_dma_data = dai_runtime;
 	} else {
-		/* for NULL stream we release allocated dma_data */
+		/* for NULL stream we release allocated dai_runtime */
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 			kfree(dai->playback_dma_data);
 			dai->playback_dma_data = NULL;
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index ca9e805bab88..93f23bd46e2c 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -70,7 +70,7 @@ struct sdw_cdns_stream_config {
 };
 
 /**
- * struct sdw_cdns_dma_data: Cadence DMA data
+ * struct sdw_cdns_dai_runtime: Cadence DAI runtime data
  *
  * @name: SoundWire stream name
  * @stream: stream runtime
@@ -82,7 +82,7 @@ struct sdw_cdns_stream_config {
  * @suspended: status set when suspended, to be used in .prepare
  * @paused: status set in .trigger, to be used in suspend
  */
-struct sdw_cdns_dma_data {
+struct sdw_cdns_dai_runtime {
 	char *name;
 	struct sdw_stream_runtime *stream;
 	struct sdw_cdns_pdi *pdi;
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 244209358784..1e9c6df4b62c 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -824,15 +824,15 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 	struct sdw_cdns_pdi *pdi;
 	struct sdw_stream_config sconfig;
 	struct sdw_port_config *pconfig;
 	int ch, dir;
 	int ret;
 
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma)
+	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dai_runtime)
 		return -EIO;
 
 	ch = params_channels(params);
@@ -854,10 +854,10 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	sdw_cdns_config_stream(cdns, ch, dir, pdi);
 
 	/* store pdi and hw_params, may be needed in prepare step */
-	dma->paused = false;
-	dma->suspended = false;
-	dma->pdi = pdi;
-	dma->hw_params = params;
+	dai_runtime->paused = false;
+	dai_runtime->suspended = false;
+	dai_runtime->pdi = pdi;
+	dai_runtime->hw_params = params;
 
 	/* Inform DSP about PDI stream number */
 	ret = intel_params_stream(sdw, substream->stream, dai, params,
@@ -869,7 +869,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	sconfig.direction = dir;
 	sconfig.ch_count = ch;
 	sconfig.frame_rate = params_rate(params);
-	sconfig.type = dma->stream_type;
+	sconfig.type = dai_runtime->stream_type;
 
 	sconfig.bps = snd_pcm_format_width(params_format(params));
 
@@ -884,7 +884,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	pconfig->ch_mask = (1 << ch) - 1;
 
 	ret = sdw_stream_add_master(&cdns->bus, &sconfig,
-				    pconfig, 1, dma->stream);
+				    pconfig, 1, dai_runtime->stream);
 	if (ret)
 		dev_err(cdns->dev, "add master to stream failed:%d\n", ret);
 
@@ -898,19 +898,19 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ch, dir;
 	int ret = 0;
 
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma) {
-		dev_err(dai->dev, "failed to get dma data in %s\n",
+	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dai_runtime) {
+		dev_err(dai->dev, "failed to get dai runtime in %s\n",
 			__func__);
 		return -EIO;
 	}
 
-	if (dma->suspended) {
-		dma->suspended = false;
+	if (dai_runtime->suspended) {
+		dai_runtime->suspended = false;
 
 		/*
 		 * .prepare() is called after system resume, where we
@@ -921,21 +921,21 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 		 */
 
 		/* configure stream */
-		ch = params_channels(dma->hw_params);
+		ch = params_channels(dai_runtime->hw_params);
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 			dir = SDW_DATA_DIR_RX;
 		else
 			dir = SDW_DATA_DIR_TX;
 
-		intel_pdi_shim_configure(sdw, dma->pdi);
-		intel_pdi_alh_configure(sdw, dma->pdi);
-		sdw_cdns_config_stream(cdns, ch, dir, dma->pdi);
+		intel_pdi_shim_configure(sdw, dai_runtime->pdi);
+		intel_pdi_alh_configure(sdw, dai_runtime->pdi);
+		sdw_cdns_config_stream(cdns, ch, dir, dai_runtime->pdi);
 
 		/* Inform DSP about PDI stream number */
 		ret = intel_params_stream(sdw, substream->stream, dai,
-					  dma->hw_params,
+					  dai_runtime->hw_params,
 					  sdw->instance,
-					  dma->pdi->intel_alh_id);
+					  dai_runtime->pdi->intel_alh_id);
 	}
 
 	return ret;
@@ -946,11 +946,11 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ret;
 
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma)
+	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dai_runtime)
 		return -EIO;
 
 	/*
@@ -959,10 +959,10 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	 * DEPREPARED for the first cpu-dai and to RELEASED for the last
 	 * cpu-dai.
 	 */
-	ret = sdw_stream_remove_master(&cdns->bus, dma->stream);
+	ret = sdw_stream_remove_master(&cdns->bus, dai_runtime->stream);
 	if (ret < 0) {
 		dev_err(dai->dev, "remove master from stream %s failed: %d\n",
-			dma->stream->name, ret);
+			dai_runtime->stream->name, ret);
 		return ret;
 	}
 
@@ -972,8 +972,8 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 		return ret;
 	}
 
-	dma->hw_params = NULL;
-	dma->pdi = NULL;
+	dai_runtime->hw_params = NULL;
+	dai_runtime->pdi = NULL;
 
 	return 0;
 }
@@ -996,17 +996,17 @@ static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
 static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
 				  int direction)
 {
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 
 	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma = dai->playback_dma_data;
+		dai_runtime = dai->playback_dma_data;
 	else
-		dma = dai->capture_dma_data;
+		dai_runtime = dai->capture_dma_data;
 
-	if (!dma)
+	if (!dai_runtime)
 		return ERR_PTR(-EINVAL);
 
-	return dma->stream;
+	return dai_runtime->stream;
 }
 
 static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct snd_soc_dai *dai)
@@ -1014,7 +1014,7 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_intel_link_res *res = sdw->link_res;
-	struct sdw_cdns_dma_data *dma;
+	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ret = 0;
 
 	/*
@@ -1025,9 +1025,9 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 	if (res->ops && res->ops->trigger)
 		res->ops->trigger(dai, cmd, substream->stream);
 
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma) {
-		dev_err(dai->dev, "failed to get dma data in %s\n",
+	dai_runtime = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dai_runtime) {
+		dev_err(dai->dev, "failed to get dai runtime in %s\n",
 			__func__);
 		return -EIO;
 	}
@@ -1042,17 +1042,17 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 		 * the .trigger callback is used to track the suspend case only.
 		 */
 
-		dma->suspended = true;
+		dai_runtime->suspended = true;
 
 		ret = intel_free_stream(sdw, substream->stream, dai, sdw->instance);
 		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		dma->paused = true;
+		dai_runtime->paused = true;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		dma->paused = false;
+		dai_runtime->paused = false;
 		break;
 	default:
 		break;
@@ -1091,25 +1091,25 @@ static int intel_component_dais_suspend(struct snd_soc_component *component)
 	for_each_component_dais(component, dai) {
 		struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 		struct sdw_intel *sdw = cdns_to_intel(cdns);
-		struct sdw_cdns_dma_data *dma;
+		struct sdw_cdns_dai_runtime *dai_runtime;
 		int stream;
 		int ret;
 
-		dma = dai->playback_dma_data;
+		dai_runtime = dai->playback_dma_data;
 		stream = SNDRV_PCM_STREAM_PLAYBACK;
-		if (!dma) {
-			dma = dai->capture_dma_data;
+		if (!dai_runtime) {
+			dai_runtime = dai->capture_dma_data;
 			stream = SNDRV_PCM_STREAM_CAPTURE;
 		}
 
-		if (!dma)
+		if (!dai_runtime)
 			continue;
 
-		if (dma->suspended)
+		if (dai_runtime->suspended)
 			continue;
 
-		if (dma->paused) {
-			dma->suspended = true;
+		if (dai_runtime->paused) {
+			dai_runtime->suspended = true;
 
 			ret = intel_free_stream(sdw, stream, dai, sdw->instance);
 			if (ret < 0)
-- 
2.25.1

