Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0BD6FC4E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjEILWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjEILWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:22:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1083749FE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:22:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f415a90215so37513065e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683631330; x=1686223330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcBWMqISV9A++p9N6hrGlnxpBrh/70LXAdj4PNnNPmc=;
        b=luRFiM+lwLaYpfKqQCsA8MqB1Xo7dII/IIjf7hfda8lgOOUgvIXxM33MgaNQ/w9hXp
         jmfRRJ44qEo+8wuDrHHF3c3R5/H1Ki/0JuoT4qcuBOtGJNi6ckdtE85LonTGBHlN3g6L
         H4ybapZugifO3/DicO3cPhAZau7qIpVu2WV2jCQ2D/Yel8rJCcd18o11y6zrJTk80N/9
         hlrCrTBo6l6S7L6uTxcxm3L23hfYFBOtyKy/7FPkMfiXL+Do7vYrGyhrTo23DMzFG4aw
         bH/z/vMhd/Fyd7xPioO6lAySztugfms415eQ3liDbhOrATrqUXpQriIfGQi2lm+XvlmG
         V5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683631330; x=1686223330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcBWMqISV9A++p9N6hrGlnxpBrh/70LXAdj4PNnNPmc=;
        b=EYYY2ZH5CL0jFFKcthpITT1f5UCBEwcJwFW6NIheDGGu0XpTSxFthip4oFQ11kyFCa
         9FX5lanNJUNSc2rFzjNMQzAMBN+zMTy0fmKMiqrHIWmRKSTBav7cc31rLdlNMagp+B1V
         bplKCdc9NkQ7HwPF5YaKyh/b5AdCS6ig3L906nQZIsxlc1QhKoegf3dakfOlR5tMlz41
         heNkq8lQCnd82DTWW9HwE8xBsgUB+zZQi330VNKjK45Yy53OQU45gWosFWNgvsIdf0Ow
         kCh0CWIx0M8m3ltUIPPxFYCgv8neX91UjLD9r/BSZua+GbfNZcdUngPogozHuj5ST/SN
         IlMg==
X-Gm-Message-State: AC+VfDzhnnppI4MomLvZ5EndFrdWg8kFahUOwWwNP3zWhy2ucuDleXV9
        hJFcohoBGlY1ET6D4iEUXC6VEQ==
X-Google-Smtp-Source: ACHHUZ5L3YbTRGyJAJmeYwfPqVXKmMnuTCBjfdZ9dKyfAaB7LLt09gFRzDI2AHX1NfxyYzVXledfEQ==
X-Received: by 2002:a1c:cc11:0:b0:3f4:86:33b with SMTP id h17-20020a1ccc11000000b003f40086033bmr9020222wmb.26.1683631330578;
        Tue, 09 May 2023 04:22:10 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003f17eded97bsm19531072wmd.19.2023.05.09.04.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:22:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] ASoC: qcom: q6apm: add support to display ports in lpass dais
Date:   Tue,  9 May 2023 12:22:02 +0100
Message-Id: <20230509112202.21471-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230509112202.21471-1-srinivas.kandagatla@linaro.org>
References: <20230509112202.21471-1-srinivas.kandagatla@linaro.org>
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

This patch adds support to q6apm lpass display port dais. This support
is required to get DP audio on x13s.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 39 +++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 420e8aa11f42..7ad604b80e25 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -11,6 +11,7 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 #include "q6dsp-lpass-ports.h"
+#include "q6dsp-common.h"
 #include "audioreach.h"
 #include "q6apm.h"
 
@@ -91,6 +92,36 @@ static int q6dma_set_channel_map(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct q6apm_lpass_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct audioreach_module_config *cfg = &dai_data->module_config[dai->id];
+	int channels = params_channels(params);
+	int ret;
+
+	cfg->bit_width = params_width(params);
+	cfg->sample_rate = params_rate(params);
+	cfg->num_channels = channels;
+
+	switch (dai->id) {
+	case DISPLAY_PORT_RX_0:
+		cfg->dp_idx = 0;
+		break;
+	case DISPLAY_PORT_RX_1 ... DISPLAY_PORT_RX_7:
+		cfg->dp_idx = dai->id - DISPLAY_PORT_RX_1 + 1;
+		break;
+	}
+
+	ret = q6dsp_get_channel_allocation(channels);
+	if (ret < 0)
+		return ret;
+
+	cfg->channel_allocation = ret;
+
+	return 0;
+}
+
 static int q6dma_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -215,6 +246,13 @@ static const struct snd_soc_dai_ops q6i2s_ops = {
 	.shutdown	= q6apm_lpass_dai_shutdown,
 	.set_channel_map  = q6dma_set_channel_map,
 	.hw_params        = q6dma_hw_params,
+};
+
+static const struct snd_soc_dai_ops q6hdmi_ops = {
+	.prepare	= q6apm_lpass_dai_prepare,
+	.startup	= q6apm_lpass_dai_startup,
+	.shutdown	= q6apm_lpass_dai_shutdown,
+	.hw_params	= q6hdmi_hw_params,
 	.set_fmt	= q6i2s_set_fmt,
 };
 
@@ -242,6 +280,7 @@ static int q6apm_lpass_dai_dev_probe(struct platform_device *pdev)
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.q6i2s_ops = &q6i2s_ops;
 	cfg.q6dma_ops = &q6dma_ops;
+	cfg.q6hdmi_ops = &q6hdmi_ops;
 	dais = q6dsp_audio_ports_set_config(dev, &cfg, &num_dais);
 
 	return devm_snd_soc_register_component(dev, &q6apm_lpass_dai_component, dais, num_dais);
-- 
2.21.0

