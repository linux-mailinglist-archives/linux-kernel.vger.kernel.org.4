Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1DC72B5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjFLDQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjFLDPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:15:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65BE7D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686539692; x=1718075692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ZigPkJDIXift16/nF0BqzBHx5umgdG3eHZSsE529p8=;
  b=U4pHsz0e7FT1qttT7uHcH+HFGMUKv64iBKXij54K6S/jFlRNPALMRSHx
   yJJdlK7rxOqqh63FZPVQrS5vkz+U76xTXcDZvf5eskBFbfL/XEm/KVcXL
   hJElEEYSBuHMKE/WTxc3u/7m1FPtaBcwUDlf9osd5fW3wj/MGqGdudWNN
   GjS4P2uK+MxGezAzvhvW2+6nD3xKIysNYoslhHbjv08lLPG7uK7VKwjLa
   VesbD80wikT2QDPG5V0cbLDYJ661RTZIciGlYbAqEiWJ6QCKcIMiIO8p4
   mOVU4o3ZfFIoklLMaUczNUp+j3IY/4cFqkv8f1syepnSg0Yh1sS7wi0M7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="347578920"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="347578920"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 20:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="776191901"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="776191901"
Received: from brentlu-desktop.itwn.intel.com ([10.5.252.92])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2023 20:14:49 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 03/12] ASoC: Intel: avs-hdaudio: remove redundant dapm routes
Date:   Mon, 12 Jun 2023 19:09:49 +0800
Message-Id: <20230612110958.592674-4-brent.lu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612110958.592674-1-brent.lu@intel.com>
References: <20230612110958.592674-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three routes "HDMI 0 Playback<-hdaudioB0D2-cpu0 Tx",
"HDMI 1 Playback<-hdaudioB0D2-cpu1 Tx" and
"HDMI 2 Playback<-hdaudioB0D2-cpu2 Tx" are created by
snd_soc_dapm_connect_dai_link_widgets() automatically. Remove the
duplicate routes.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/avs/boards/hdaudio.c | 65 +---------------------------
 1 file changed, 1 insertion(+), 64 deletions(-)

diff --git a/sound/soc/intel/avs/boards/hdaudio.c b/sound/soc/intel/avs/boards/hdaudio.c
index a542a67e21d0..cb00bc86ac94 100644
--- a/sound/soc/intel/avs/boards/hdaudio.c
+++ b/sound/soc/intel/avs/boards/hdaudio.c
@@ -64,56 +64,6 @@ static int avs_create_dai_links(struct device *dev, struct hda_codec *codec, int
 	return 0;
 }
 
-static int avs_create_dapm_routes(struct device *dev, struct hda_codec *codec, int pcm_count,
-				  struct snd_soc_dapm_route **routes, int *num_routes)
-{
-	struct snd_soc_dapm_route *dr;
-	struct hda_pcm *pcm;
-	const char *cname = dev_name(&codec->core.dev);
-	int i, n = 0;
-
-	/* at max twice the number of pcms */
-	dr = devm_kcalloc(dev, pcm_count * 2, sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return -ENOMEM;
-
-	pcm = list_first_entry(&codec->pcm_list_head, struct hda_pcm, list);
-
-	for (i = 0; i < pcm_count; i++, pcm = list_next_entry(pcm, list)) {
-		struct hda_pcm_stream *stream;
-		int dir;
-
-		dir = SNDRV_PCM_STREAM_PLAYBACK;
-		stream = &pcm->stream[dir];
-		if (!stream->substreams)
-			goto capture_routes;
-
-		dr[n].sink = devm_kasprintf(dev, GFP_KERNEL, "%s %s", pcm->name,
-					    snd_pcm_direction_name(dir));
-		dr[n].source = devm_kasprintf(dev, GFP_KERNEL, "%s-cpu%d Tx", cname, i);
-		if (!dr[n].sink || !dr[n].source)
-			return -ENOMEM;
-		n++;
-
-capture_routes:
-		dir = SNDRV_PCM_STREAM_CAPTURE;
-		stream = &pcm->stream[dir];
-		if (!stream->substreams)
-			continue;
-
-		dr[n].sink = devm_kasprintf(dev, GFP_KERNEL, "%s-cpu%d Rx", cname, i);
-		dr[n].source = devm_kasprintf(dev, GFP_KERNEL, "%s %s", pcm->name,
-					      snd_pcm_direction_name(dir));
-		if (!dr[n].sink || !dr[n].source)
-			return -ENOMEM;
-		n++;
-	}
-
-	*routes = dr;
-	*num_routes = n;
-	return 0;
-}
-
 /* Should be aligned with SectionPCM's name from topology */
 #define FEDAI_NAME_PREFIX "HDMI"
 
@@ -172,13 +122,12 @@ static int avs_card_late_probe(struct snd_soc_card *card)
 
 static int avs_probing_link_init(struct snd_soc_pcm_runtime *rtm)
 {
-	struct snd_soc_dapm_route *routes;
 	struct snd_soc_acpi_mach *mach;
 	struct snd_soc_dai_link *links = NULL;
 	struct snd_soc_card *card = rtm->card;
 	struct hda_codec *codec;
 	struct hda_pcm *pcm;
-	int ret, n, pcm_count = 0;
+	int ret, pcm_count = 0;
 
 	mach = dev_get_platdata(card->dev);
 	codec = mach->pdata;
@@ -200,18 +149,6 @@ static int avs_probing_link_init(struct snd_soc_pcm_runtime *rtm)
 		return ret;
 	}
 
-	ret = avs_create_dapm_routes(card->dev, codec, pcm_count, &routes, &n);
-	if (ret < 0) {
-		dev_err(card->dev, "create routes failed: %d\n", ret);
-		return ret;
-	}
-
-	ret = snd_soc_dapm_add_routes(&card->dapm, routes, n);
-	if (ret < 0) {
-		dev_err(card->dev, "add routes failed: %d\n", ret);
-		return ret;
-	}
-
 	return 0;
 }
 
-- 
2.34.1

