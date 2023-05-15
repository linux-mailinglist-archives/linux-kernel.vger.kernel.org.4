Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1770256F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbjEOGxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbjEOGw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:52:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FAD213A
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133546; x=1715669546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HnNtbwiDrZNBgzzJYA3WKKwmdCK9fTg/aHcJpktUXV0=;
  b=NBo7hZ3ca/ingSBlOPS7/FsOE+suGQJNhHVnjrj14Nf6VbWsA4VbziDW
   SQH/M67C3G5RpnZFlumtZ7p09Mv+AqbwmYkG+Z0IgzT79t2IsZNaRYamS
   kXvlyi+HjFhIwySMWQK5FZeQUIJ7CiJgfG+4ENY5uZUwXD9US5Ow03ZNn
   9eoDPZeYgVi/zu/gRyFoNYOydGBaBV8Zy9ygF7+g+DxgdKobMOKIEsVjM
   Nc8B1dr/70tvobSfPRtnmDQEMSYGzDp3+bGF7otcILJffsO51k2vlOdvA
   vPRzU7wF/e4C1LfoxQ03h/Wo2oZK1WsoFvYPfMXmx0kqFIR4KkfnTubLQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966545"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966545"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:51:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908784"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908784"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:51:11 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 22/26] ASoC: SOF/soundwire: re-add substream in params_stream structure
Date:   Mon, 15 May 2023 15:10:38 +0800
Message-Id: <20230515071042.2038-23-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
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

An earlier simplification to only pass the direction is no longer
suitable, all the ACE2.x HDaudio DMA management relies on access to
the substream structure.

This patch is an iso-functionality change, the HDaudio DMA parts will
be provided separately.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 8 ++++----
 include/linux/soundwire/sdw_intel.h | 2 +-
 sound/soc/sof/intel/hda.c           | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 238acf5c97a9..c8eb1ec512c4 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -643,7 +643,7 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 }
 
 static int intel_params_stream(struct sdw_intel *sdw,
-			       int stream,
+			       struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai,
 			       struct snd_pcm_hw_params *hw_params,
 			       int link_id, int alh_stream_id)
@@ -651,7 +651,7 @@ static int intel_params_stream(struct sdw_intel *sdw,
 	struct sdw_intel_link_res *res = sdw->link_res;
 	struct sdw_intel_stream_params_data params_data;
 
-	params_data.stream = stream; /* direction */
+	params_data.substream = substream;
 	params_data.dai = dai;
 	params_data.hw_params = hw_params;
 	params_data.link_id = link_id;
@@ -727,7 +727,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	dai_runtime->pdi = pdi;
 
 	/* Inform DSP about PDI stream number */
-	ret = intel_params_stream(sdw, substream->stream, dai, params,
+	ret = intel_params_stream(sdw, substream, dai, params,
 				  sdw->instance,
 				  pdi->intel_alh_id);
 	if (ret)
@@ -804,7 +804,7 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 		sdw_cdns_config_stream(cdns, ch, dir, dai_runtime->pdi);
 
 		/* Inform DSP about PDI stream number */
-		ret = intel_params_stream(sdw, substream->stream, dai,
+		ret = intel_params_stream(sdw, substream, dai,
 					  hw_params,
 					  sdw->instance,
 					  dai_runtime->pdi->intel_alh_id);
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 1a8f32059cd8..ccb228eebc65 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -182,7 +182,7 @@
  * firmware.
  */
 struct sdw_intel_stream_params_data {
-	int stream;
+	struct snd_pcm_substream *substream;
 	struct snd_soc_dai *dai;
 	struct snd_pcm_hw_params *hw_params;
 	int link_id;
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 388e41057172..511c927b6696 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -94,7 +94,7 @@ static int sdw_params_stream(struct device *dev,
 			     struct sdw_intel_stream_params_data *params_data)
 {
 	struct snd_soc_dai *d = params_data->dai;
-	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(d, params_data->stream);
+	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(d, params_data->substream->stream);
 	struct snd_sof_dai_config_data data = { 0 };
 
 	data.dai_index = (params_data->link_id << 8) | d->id;
-- 
2.25.1

