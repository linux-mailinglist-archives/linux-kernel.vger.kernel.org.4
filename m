Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6C672B5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjFLDQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbjFLDPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:15:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B61E6F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686539695; x=1718075695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xwsgpdxaqinXUt42/9XufyLi9iO/nioCRY94pZmKTgQ=;
  b=kt0UCZ8Q6F5ewScDRe0DNbEle0E+u4AqNzFAUGGDp2pIMaIibXyplPNI
   J9elWTx2tP8QQZjvcsiV9/V9lIgmxscKK+R2UtvKUs5TNIgpbasf3M+XS
   idoHOrtlJi2aBm1fIQEYO1RY2Kv2QWT6YRK3ubgWPzKbchdNqMFWLTVFr
   tXnQAhIiSLGwag/AYQNfxzJA4nB5hmJM1FnfLYJS+Yq7lS3HmAmrQQdq1
   si3/2dsiRWZc0eQek0IUttfBoEtmFLkHLG0QaVLuTvHHG9Rlq6bS/C7AE
   /4tC1Gx7yul6nyQqM7rTlW8GPJ/fweu5+M/6u4yfy9nDGASwEUjUyLzzV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="347578933"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="347578933"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 20:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="776191918"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="776191918"
Received: from brentlu-desktop.itwn.intel.com ([10.5.252.92])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2023 20:14:52 -0700
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
Subject: [PATCH 04/12] ASoC: Intel: avs-max98357a: remove redundant dapm routes
Date:   Mon, 12 Jun 2023 19:09:50 +0800
Message-Id: <20230612110958.592674-5-brent.lu@intel.com>
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

The route "HiFi Playback<-sspX Tx" is created by
snd_soc_dapm_connect_dai_link_widgets() automatically. Remove the
duplicate routes.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/avs/boards/max98357a.c | 39 ++------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/sound/soc/intel/avs/boards/max98357a.c b/sound/soc/intel/avs/boards/max98357a.c
index 183123d08c5a..b9b20562c691 100644
--- a/sound/soc/intel/avs/boards/max98357a.c
+++ b/sound/soc/intel/avs/boards/max98357a.c
@@ -86,41 +86,14 @@ static int avs_create_dai_link(struct device *dev, const char *platform_name, in
 	return 0;
 }
 
-static int avs_create_dapm_routes(struct device *dev, int ssp_port,
-				  struct snd_soc_dapm_route **routes, int *num_routes)
-{
-	struct snd_soc_dapm_route *dr;
-	const int num_base = ARRAY_SIZE(card_base_routes);
-	const int num_dr = num_base + 1;
-	int idx;
-
-	dr = devm_kcalloc(dev, num_dr, sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return -ENOMEM;
-
-	memcpy(dr, card_base_routes, num_base * sizeof(*dr));
-
-	idx = num_base;
-	dr[idx].sink = devm_kasprintf(dev, GFP_KERNEL, "HiFi Playback");
-	dr[idx].source = devm_kasprintf(dev, GFP_KERNEL, "ssp%d Tx", ssp_port);
-	if (!dr[idx].sink || !dr[idx].source)
-		return -ENOMEM;
-
-	*routes = dr;
-	*num_routes = num_dr;
-
-	return 0;
-}
-
 static int avs_max98357a_probe(struct platform_device *pdev)
 {
-	struct snd_soc_dapm_route *routes;
 	struct snd_soc_dai_link *dai_link;
 	struct snd_soc_acpi_mach *mach;
 	struct snd_soc_card *card;
 	struct device *dev = &pdev->dev;
 	const char *pname;
-	int num_routes, ssp_port, ret;
+	int ssp_port, ret;
 
 	mach = dev_get_platdata(dev);
 	pname = mach->mach_params.platform;
@@ -132,12 +105,6 @@ static int avs_max98357a_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = avs_create_dapm_routes(dev, ssp_port, &routes, &num_routes);
-	if (ret) {
-		dev_err(dev, "Failed to create dapm routes: %d", ret);
-		return ret;
-	}
-
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
 	if (!card)
 		return -ENOMEM;
@@ -151,8 +118,8 @@ static int avs_max98357a_probe(struct platform_device *pdev)
 	card->num_controls = ARRAY_SIZE(card_controls);
 	card->dapm_widgets = card_widgets;
 	card->num_dapm_widgets = ARRAY_SIZE(card_widgets);
-	card->dapm_routes = routes;
-	card->num_dapm_routes = num_routes;
+	card->dapm_routes = card_base_routes;
+	card->num_dapm_routes = ARRAY_SIZE(card_base_routes);
 	card->fully_routed = true;
 
 	ret = snd_soc_fixup_dai_links_platform_name(card, pname);
-- 
2.34.1

