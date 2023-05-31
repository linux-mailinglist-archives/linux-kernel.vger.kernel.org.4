Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B6E7182F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjEaNqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjEaNon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D71703;
        Wed, 31 May 2023 06:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A48463B4E;
        Wed, 31 May 2023 13:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A81EC433D2;
        Wed, 31 May 2023 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540564;
        bh=Luun0qN3Hqo2+HrVtNije7hzgiJtuA0kucqBhrlDmSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YTL6tGHoJKARf8VeqOOEqVCBEtTG08JHjcCub/pfYKBS+Nc+/9vuJzfsvSWK9dpbq
         mZQ4txEnpBMjd4S8CFI8QFBUpUBts7a2TtWXNHzOG0gYHbxl7IRqFydCA81VENz7UT
         wXbvghutBA7MH77K2JVOK7y6JVyhcCek/J2OJ4x430cebGwi/N5TGK0FbF1PGElaxx
         4pUSk91YD4pZWfWbgCQGAMgSiHG8qsOEtSm9rmLv2mKP9sx2hCQlfbsOt/2Myh7GNF
         30CNTLXrYASga5+yuFDb1ViEPzL5eLb4mhTc0w2fdDNGe1tZET2DJeCT+rh2pA1Eq1
         5T709Qbvaf24A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 21/33] ASoC: Intel: avs: Add missing checks on FE startup
Date:   Wed, 31 May 2023 09:41:47 -0400
Message-Id: <20230531134159.3383703-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 25148f57a2a6d157779bae494852e172952ba980 ]

Constraint functions have return values, they should be checked for
potential errors.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230519201711.4073845-8-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/pcm.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index 8fe5917b1e263..22f21f3f612d1 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -424,21 +424,34 @@ static int avs_dai_fe_startup(struct snd_pcm_substream *substream, struct snd_so
 
 	host_stream = snd_hdac_ext_stream_assign(bus, substream, HDAC_EXT_STREAM_TYPE_HOST);
 	if (!host_stream) {
-		kfree(data);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err;
 	}
 
 	data->host_stream = host_stream;
-	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		goto err;
+
 	/* avoid wrap-around with wall-clock */
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME, 20, 178000000);
-	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_rates);
+	ret = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME, 20, 178000000);
+	if (ret < 0)
+		goto err;
+
+	ret = snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_rates);
+	if (ret < 0)
+		goto err;
+
 	snd_pcm_set_sync(substream);
 
 	dev_dbg(dai->dev, "%s fe STARTUP tag %d str %p",
 		__func__, hdac_stream(host_stream)->stream_tag, substream);
 
 	return 0;
+
+err:
+	kfree(data);
+	return ret;
 }
 
 static void avs_dai_fe_shutdown(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
-- 
2.39.2

