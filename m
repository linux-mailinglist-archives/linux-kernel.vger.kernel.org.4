Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D096E7351C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjFSKRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjFSKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:17:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E867598
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:16:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30e412a852dso2683406f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687169817; x=1689761817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzGepGC6ZYnmZGsocL2P2Z4ZNGc2QuSBI4PBc8L8Xeo=;
        b=TeE5sjg5OrE2aYeX3pBftMim05QPJa+/1qvmbEQ7QqIESt06ME2tY/5wUULlHtheGN
         MlyFiC94sTyk3kzCrpXyrJeEPiecH0uvEUX5s0isGIOCV+u1979I/ihcn3ylReRR1dD2
         gF8ikSN6IaM+dloiqmY4eR5e7UBWVsgPUTwehGhqFx91Fzu1A/JL6lt5THWWLibYFg7Y
         TayBkWuQsVZh8xE0mBIcsxiyfjphS+E7Low2ppJDRJthHifZiq8YMXfi77xCnhElMUgn
         7IUJ6UdWQRcRAJeUi/T2GdS30Lz1GvFwvTYSBfQc6i5z/GzoH6v6200DB1dwk2lH8VkE
         i0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169817; x=1689761817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzGepGC6ZYnmZGsocL2P2Z4ZNGc2QuSBI4PBc8L8Xeo=;
        b=QMr5K0LZHVPj+SemenL+JYzPw7foqNTxB2W7Mw8WbQ1fvz7CQWbUZeJ/M0+zbaF+ej
         w6ngyJqZ2z0CYeIC+aSud85JSp2nBqeF1LMXpMQa7OOoLY6Alz7Ivnv8oxhoTN4plu5e
         Y9zLIRjM0iIteu0sAFbencarAn3dDIJiQ3IIXU4GwaFgci226v8tqcKcRE/q6i1xxPlG
         G3KZDtVfL8B5wxl0OR9HtuYK9f6xK/Lygh7qaHfBbjpbSknTDoYuxxtXO6BXV49oRgnf
         M0sicScurdj7gLioF65yjxqV5rFJ8UCiyZBs/RHHtnxBDrinYg8sonk2DlZDHeIz3I82
         PSQg==
X-Gm-Message-State: AC+VfDyqq8sqgXwDHL42Kd60ixD2kgCPwpPdpfMMTLTbPef/miNoPs1q
        2SYlzDd0pFr0QQRfrWJqTSb+eA==
X-Google-Smtp-Source: ACHHUZ6pAkcRKDuJ4mER66rw0TC0DL/95Zxf3iH5VEfKJr4ev+OM49ZLGU0BYRxcsKVlBBnIwgvMkA==
X-Received: by 2002:a5d:4952:0:b0:30d:43ca:55ab with SMTP id r18-20020a5d4952000000b0030d43ca55abmr5394016wrs.38.1687169817457;
        Mon, 19 Jun 2023 03:16:57 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm31146922wrv.108.2023.06.19.03.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:16:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 01/11] ASoC: qcom: SC7280: audioreach: Add sc7280 hardware param fixup callback
Date:   Mon, 19 Jun 2023 11:16:43 +0100
Message-Id: <20230619101653.9750-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
References: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>

Add support to set backend params such as sampling rate and
number of channels using backend params fixup callback.
Also add no pcm check for hardware params constraints setting.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sc7280.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index da7469a6a267..787dd49e03f6 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -14,6 +14,7 @@
 #include <sound/soc.h>
 #include <sound/rt5682s.h>
 #include <linux/soundwire/sdw.h>
+#include <sound/pcm_params.h>
 
 #include "../codecs/rt5682.h"
 #include "../codecs/rt5682s.h"
@@ -196,8 +197,10 @@ static int sc7280_snd_hw_params(struct snd_pcm_substream *substream,
 	struct sdw_stream_runtime *sruntime;
 	int i;
 
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE, 48000, 48000);
+	if (!rtd->dai_link->no_pcm) {
+		snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
+		snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE, 48000, 48000);
+	}
 
 	switch (cpu_dai->id) {
 	case LPASS_CDC_DMA_TX3:
@@ -358,6 +361,20 @@ static const struct snd_soc_dapm_widget sc7280_snd_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 };
 
+static int sc7280_snd_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+					 struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
+
+	return 0;
+}
+
 static int sc7280_snd_platform_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
@@ -387,6 +404,8 @@ static int sc7280_snd_platform_probe(struct platform_device *pdev)
 	for_each_card_prelinks(card, i, link) {
 		link->init = sc7280_init;
 		link->ops = &sc7280_ops;
+		if (link->no_pcm == 1)
+			link->be_hw_params_fixup = sc7280_snd_be_hw_params_fixup;
 	}
 
 	return devm_snd_soc_register_card(dev, card);
-- 
2.21.0

