Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA9E699164
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBPKeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjBPKd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:33:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7370853554
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:33:48 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9200A66021AF;
        Thu, 16 Feb 2023 10:33:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676543597;
        bh=6uIzQS1xNpwxFvvbM87RxfIH+mS9cj2FTgkkgyvBiJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jfy5Zjg42QUQbjlpPFqsj32bfBR1nwlLfP3OxihOfpeNgUSyx186woidwN9TRk1Jt
         1z0TrhI8jnhmtlYuJ913exsgOjC2c1ik11WB1uRI4PLO22eVk+OHTJ30oRoTh4IXF2
         /5Z71cebK9+VVfQI7iAWzabFk75/LTGIL597kc0Us9cDHKXdW94aA1dr133CbV97nS
         SsJGD01zI5W0ToYZuJh3bXZJAVW2dliw7bpbQnMtSGIOL9VDRQ7X62Ocqref+BSird
         REzeuEla/j87JHBgPtiFoLsuFkr1HaVs385Yh2QOK7/qXZ12sC6XZhCDE+XcJhhE2l
         ItLfeK6ghdq0g==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 6/9] ASoC: amd: vangogh: Check Bit Clock rate before snd_soc_dai_set_pll
Date:   Thu, 16 Feb 2023 10:32:57 +0000
Message-Id: <20230216103300.360016-7-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230216103300.360016-1-lucas.tanure@collabora.com>
References: <20230216103300.360016-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check bit clock is valid before setting it with snd_soc_dai_set_pll

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index e7a7558f70ae..7072352389ab 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -115,13 +115,19 @@ static int acp5x_nau8821_hw_params(struct snd_pcm_substream *sub, struct snd_pcm
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(sub);
 	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_dai *dai = snd_soc_card_get_codec_dai(card, ACP5X_NUVOTON_CODEC_DAI);
-	int ret;
+	int ret, bclk;
 
 	ret = snd_soc_dai_set_sysclk(dai, NAU8821_CLK_FLL_BLK, 0, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		dev_err(card->dev, "can't set FS clock %d\n", ret);
-	ret = snd_soc_dai_set_pll(dai, 0, 0, snd_soc_params_to_bclk(params),
-				  params_rate(params) * 256);
+
+	bclk = snd_soc_params_to_bclk(params);
+	if (bclk < 0) {
+		dev_err(dai->dev, "Fail to get BCLK rate: %d\n", bclk);
+		return bclk;
+	}
+
+	ret = snd_soc_dai_set_pll(dai, 0, 0, bclk, params_rate(params) * 256);
 	if (ret < 0)
 		dev_err(card->dev, "can't set FLL: %d\n", ret);
 
-- 
2.39.2

