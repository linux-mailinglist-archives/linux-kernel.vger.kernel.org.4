Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140F06FC4E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjEILWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjEILWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:22:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C98149DF
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:22:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso574605e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683631326; x=1686223326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxG+ycENWJH3AlwoPjs8awS/KwMKrnL6bZtNa57b8KY=;
        b=RnLe0zbIGps1V1jqaoiYWNSEutPblCXI6xt+JevNLqKdg46N/cSBKyRY81niOtLVwQ
         dMZLTW/FanJ4fgm1OtsJ/RBLwt7iAzt4TZ2OnarSk2ubz3x0Ap9jQXvRVXyhR5X7ffuF
         EQKAbJ8ysIDmBCWYx/gOFDY3MplVFPi7gyBTZI59f47ciGcPdFtPmp1iRqkNfReUI8DR
         qpHSlXQRZVVvP8wbzyIFn4HTv3afpeupYViEoVx3LlDdunIIRgSlKHq7uSMBmh/RxbNr
         8Z7DGkJu1rCB6nMUM9DDRLQ29k/nW4kaFXtI7UcakjlHqw5SCL4nV8yxCjjTXYw+naqm
         KpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683631326; x=1686223326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxG+ycENWJH3AlwoPjs8awS/KwMKrnL6bZtNa57b8KY=;
        b=LVRFoaHiyXntqJEflS97ScXa+qtElU1ZNdj6RO0TD8ffEObCXR8Tka5DZmaHQDoZQI
         gXUB2+BlOdP9FzSGfCZkUU1Sb2zUci4tY3/Rdb+GNG+hOM3HD8W46XmqXirdhcg0dLRW
         tW5wwC3mN4wRafg7d80JWqYAWcRyp3al9VztgCjzqvKLBBmkexZ6xYN1LREtQ/MFbmd8
         RcA9v436TSip2FBsxxRa1MD43vSLEL9aoAitfIuXtgCcuYJ5mHpjFEpxcDCPI8fcw/nG
         HFDhhwFahuHD5cJD39+DgQyGrRYLAi805y755mUEJQJQNy1zfGi5kQWtveDAT+Pecnbb
         1Z0g==
X-Gm-Message-State: AC+VfDxQSTbq9QSCgZWs2hgIhd9mM2dnNQ3T7EIRaxYPlkMe3jgj90mo
        ihpIFiCCYFFh/j0tjHK8hN1Kjg==
X-Google-Smtp-Source: ACHHUZ6nE3QoxybXlRdqHxeEbWupLkFlBrYyQt4L/qnNVyUdhTSbl+MZB6GRpkvjC0hZpadUh1kRHg==
X-Received: by 2002:a7b:cc15:0:b0:3f4:16bc:bd1d with SMTP id f21-20020a7bcc15000000b003f416bcbd1dmr7335018wmh.6.1683631326709;
        Tue, 09 May 2023 04:22:06 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003f17eded97bsm19531072wmd.19.2023.05.09.04.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:22:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] ASoC: qcom: q6dsp-common: move channel allocation to common
Date:   Tue,  9 May 2023 12:21:59 +0100
Message-Id: <20230509112202.21471-2-srinivas.kandagatla@linaro.org>
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

move hdmi/dp channel allocation to a common function
q6dsp_get_channel_allocation() so that we can reuse this across
q6afe and q6apm drivers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c    | 34 ++++++----------------------
 sound/soc/qcom/qdsp6/q6dsp-common.c | 35 +++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6dsp-common.h |  1 +
 3 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 8bb7452b8f18..31e0bad71e95 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -12,6 +12,7 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 #include "q6dsp-lpass-ports.h"
+#include "q6dsp-common.h"
 #include "q6afe.h"
 
 
@@ -69,6 +70,7 @@ static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	int channels = params_channels(params);
 	struct q6afe_hdmi_cfg *hdmi = &dai_data->port_config[dai->id].hdmi;
+	int ret;
 
 	hdmi->sample_rate = params_rate(params);
 	switch (params_format(params)) {
@@ -80,33 +82,11 @@ static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	/* HDMI spec CEA-861-E: Table 28 Audio InfoFrame Data Byte 4 */
-	switch (channels) {
-	case 2:
-		hdmi->channel_allocation = 0;
-		break;
-	case 3:
-		hdmi->channel_allocation = 0x02;
-		break;
-	case 4:
-		hdmi->channel_allocation = 0x06;
-		break;
-	case 5:
-		hdmi->channel_allocation = 0x0A;
-		break;
-	case 6:
-		hdmi->channel_allocation = 0x0B;
-		break;
-	case 7:
-		hdmi->channel_allocation = 0x12;
-		break;
-	case 8:
-		hdmi->channel_allocation = 0x13;
-		break;
-	default:
-		dev_err(dai->dev, "invalid Channels = %u\n", channels);
-		return -EINVAL;
-	}
+	ret = q6dsp_get_channel_allocation(channels);
+	if (ret < 0)
+		return ret;
+
+	hdmi->channel_allocation = (u16) ret;
 
 	return 0;
 }
diff --git a/sound/soc/qcom/qdsp6/q6dsp-common.c b/sound/soc/qcom/qdsp6/q6dsp-common.c
index d393003492c7..95585dea2b36 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-common.c
+++ b/sound/soc/qcom/qdsp6/q6dsp-common.c
@@ -63,4 +63,39 @@ int q6dsp_map_channels(u8 ch_map[PCM_MAX_NUM_CHANNEL], int ch)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(q6dsp_map_channels);
+
+int q6dsp_get_channel_allocation(int channels)
+{
+	int channel_allocation;
+
+	/* HDMI spec CEA-861-E: Table 28 Audio InfoFrame Data Byte 4 */
+	switch (channels) {
+	case 2:
+		channel_allocation = 0;
+		break;
+	case 3:
+		channel_allocation = 0x02;
+		break;
+	case 4:
+		channel_allocation = 0x06;
+		break;
+	case 5:
+		channel_allocation = 0x0A;
+		break;
+	case 6:
+		channel_allocation = 0x0B;
+		break;
+	case 7:
+		channel_allocation = 0x12;
+		break;
+	case 8:
+		channel_allocation = 0x13;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return channel_allocation;
+}
+EXPORT_SYMBOL_GPL(q6dsp_get_channel_allocation);
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6dsp-common.h b/sound/soc/qcom/qdsp6/q6dsp-common.h
index 01094d108b8a..9e704db5f604 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-common.h
+++ b/sound/soc/qcom/qdsp6/q6dsp-common.h
@@ -20,5 +20,6 @@
 #define PCM_CHANNELS   10	/* Top surround channel. */
 
 int q6dsp_map_channels(u8 ch_map[PCM_MAX_NUM_CHANNEL], int ch);
+int q6dsp_get_channel_allocation(int channels);
 
 #endif /* __Q6DSP_COMMON_H__ */
-- 
2.21.0

