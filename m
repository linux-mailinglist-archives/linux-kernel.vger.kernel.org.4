Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A65A729D6A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbjFIOy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbjFIOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:54:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2B73A84
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:54:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso14621065e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322456; x=1688914456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ViS6qF8cS4iDl2a+diQ/4R9Vhl6rQuGyv9+232yC8g=;
        b=pYx6AAYX31qs1F2OdJbIgSLF5yMv3UfFa3oRnRll8KhhrmjwB3eEme0y1/+w3+P5bg
         idMNOEjcnlLemtdf/DSiN/3bybugS+OpaCxhTS/w7CXjZ9OwnE6bm/G89LRJQFiV4yzD
         hEJYKN0j72BaoMJuD/kUZbWg+yXlp1pUO+mmU40Y3H3kugF/792D1SskLtB9BFtflClQ
         fesCobyMVy3iaixO7aJFfh7MzgsF2nVbuPn9CHQ+ZIRGcj8+fGjAvTvCZJypMro1e9sS
         6Umvo4fTd8nEamBKl8wWca8/pKDVdU3YlnN5Vo80gFlB5Av89qsqtjwaQGSVX1FhoYit
         mokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322456; x=1688914456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ViS6qF8cS4iDl2a+diQ/4R9Vhl6rQuGyv9+232yC8g=;
        b=fD5gPrw+cza/e+zSOTGaRQva0KjSbOILzaIEDkp+ECEl9PvyLXOUhKbi6Hvu/2wKVh
         c4fg2zzSAGgl5xUkUkp94bXbSV5GDUOet+6BxuMZWVn3Gl+pVpbBIn9XfKuAUiyWHXm0
         5Lm9Ndk97jqtPd82gRP2EHkLCVVWtKzSvEwFthe5NqJ6KcwutxoW3QKrMQRVJQkRAxMv
         tN0AzmQh8J0Ube2Gl2540RfOPe4WDZ/gDXoqJIn/idHBxWH4Sh8l2OlMJZLji5dBrnaA
         3SU3cIuhKqA/ZyPogqgkMsmwWHNcXP3Sj5l/oWNYR1WB2X7VV6EtifaLNJL5oVlMwJ3P
         ks6A==
X-Gm-Message-State: AC+VfDyPxNZoR89Lx/yC+sMm/85hn6vTro7qEd1ytqP1KIvkzzC1WVpF
        0dq4169jHFsOfzvtSCwIv+bUAA==
X-Google-Smtp-Source: ACHHUZ6XJv+CElBwzddgkPF/3BDt6V+kN3w98q7v8ajDl+3UTsnaK0Y5g9kA2jnZsi6MOEamkqZNvQ==
X-Received: by 2002:a05:600c:3b29:b0:3f7:ec1d:21b3 with SMTP id m41-20020a05600c3b2900b003f7ec1d21b3mr4169683wms.5.1686322455438;
        Fri, 09 Jun 2023 07:54:15 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm2946632wmr.2.2023.06.09.07.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:54:14 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 01/11] ASoC: qcom: SC7280: audioreach: Add sc7280 hardware param fixup callback
Date:   Fri,  9 Jun 2023 15:53:57 +0100
Message-Id: <20230609145407.18774-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
References: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

