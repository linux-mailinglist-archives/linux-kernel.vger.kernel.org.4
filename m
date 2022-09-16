Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2B5BAE17
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiIPNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiIPNYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:24:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CF027FC2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:24:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so19879818wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QFHrDBmOgjQNltcQ0NOpoAX3KMBSQJ+P+IQdQCe6YjM=;
        b=XWL8wPxIUHiYoj/0qB3Cow1E5n3CxnPfeJ8Z52NlN2YMTA5GTBRZgOyWIGuP8dDZyo
         Owp4kPFfT2HkMokWvz1J8hmKoB50gq/QZF00wCXdN51cG4R6zbPeqA2FfeG2/ewFZM64
         Jsz2BuhRtSQMM5Yfw0t+Sz5TU9kGyYZ0FDVjua5dEbT3TbmrO1IBs6QSFm0T1OV4ltjw
         G5yHVjoPhhsb3nnA6fR4P8WB5QnySfwzezODnw4eUnST/BS+luNS3RrkgO/OKl3GQG7G
         3/YiQYSb4r1ADg2r+OwT72+eEZ4TPRvpOQf9/ll6ERHjZ0HonRPpq7uZUMIqisgtgUF3
         gNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QFHrDBmOgjQNltcQ0NOpoAX3KMBSQJ+P+IQdQCe6YjM=;
        b=T36ItKYu6Wlqsi/naWVln893wVO/fM2lwHQPbCXyDiHKfGJ9xW9iipRC5I0ysvVlwK
         BLaHvAd2Ii06FeVi80dGQ5gnAfwhG6kFzw0SL2vuc7ipr9Qh7wa8znRan/2pkjUnCTW1
         BfUjG+qx0UL9UL4wY+Abl8qi/hzFg2P0hIaMARnueVljEyTFeF4fAZdxANdXFwZ35MHg
         8Z8uS56u8orQ0TG+chMsln3rOAcDXK3CojXRWqsCi38z/aaUN+CDhbpEydAgZgoAAs7p
         6ILvWDMIlR+QUVxjeqnBtc4vJjMSgdTM6gFa0FsBiC28m/HtuhFPMv9K4Z/udFk4QTae
         k35w==
X-Gm-Message-State: ACrzQf3HNRPzgVjQV8Bjj7MfXoGtjW0VZz+w4zWQ/pa7MMBfEDEQjLJj
        /gCX2vueCuwfd5C6HYxYy06x7A==
X-Google-Smtp-Source: AMsMyM5h3bbfh/0miAnLLu6tTrn07B0ha3jjwBwpQiZB4oPT3wUVa1n6Hv7duVCXKdjuqfuBn1BNlQ==
X-Received: by 2002:a05:600c:418a:b0:3b4:6708:1e3b with SMTP id p10-20020a05600c418a00b003b467081e3bmr3369426wmh.67.1663334684104;
        Fri, 16 Sep 2022 06:24:44 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003a608d69a64sm2387061wmq.21.2022.09.16.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:24:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 5/5] ASoC: qcom: add machine driver for sc8280xp
Date:   Fri, 16 Sep 2022 14:24:27 +0100
Message-Id: <20220916132427.1845-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220916132427.1845-1-srinivas.kandagatla@linaro.org>
References: <20220916132427.1845-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add machine driver for sc8280xp SoC.

This intial supports only includes WSA883x Speakers and WCD938x based headset.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig    |  12 +++
 sound/soc/qcom/Makefile   |   2 +
 sound/soc/qcom/sc8280xp.c | 157 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 sound/soc/qcom/sc8280xp.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 750653404ba3..1b0252ec4665 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -173,6 +173,18 @@ config SND_SOC_SM8250
 	  SM8250 SoC-based systems.
 	  Say Y if you want to use audio device on this SoCs.
 
+config SND_SOC_SC8280XP
+	tristate "SoC Machine driver for SC8280XP boards"
+	depends on QCOM_APR || COMPILE_TEST
+	depends on SOUNDWIRE
+	depends on COMMON_CLK
+	select SND_SOC_QDSP6
+	select SND_SOC_QCOM_COMMON
+	help
+	  To add support for audio on Qualcomm Technologies Inc.
+	  SC8280XP SoC-based systems.
+	  Say Y if you want to use audio device on this SoCs.
+
 config SND_SOC_SC7180
 	tristate "SoC Machine driver for SC7180 boards"
 	depends on I2C && GPIOLIB
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 8b7b876899a8..8b97172cf990 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -26,6 +26,7 @@ snd-soc-sc7180-objs := sc7180.o
 snd-soc-sc7280-objs := sc7280.o
 snd-soc-sdm845-objs := sdm845.o
 snd-soc-sm8250-objs := sm8250.o
+snd-soc-sc8280xp-objs := sc8280xp.o
 snd-soc-qcom-common-objs := common.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
@@ -33,6 +34,7 @@ obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
 obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
 obj-$(CONFIG_SND_SOC_SC7180) += snd-soc-sc7180.o
 obj-$(CONFIG_SND_SOC_SC7280) += snd-soc-sc7280.o
+obj-$(CONFIG_SND_SOC_SC8280XP) += snd-soc-sc8280xp.o
 obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o
 obj-$(CONFIG_SND_SOC_SM8250) += snd-soc-sm8250.o
 obj-$(CONFIG_SND_SOC_QCOM_COMMON) += snd-soc-qcom-common.o
diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
new file mode 100644
index 000000000000..ade44ad7c585
--- /dev/null
+++ b/sound/soc/qcom/sc8280xp.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2022, Linaro Limited
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <linux/soundwire/sdw.h>
+#include <sound/jack.h>
+#include <linux/input-event-codes.h>
+#include "qdsp6/q6afe.h"
+#include "common.h"
+
+#define DRIVER_NAME		"sc8280xp"
+
+struct sc8280xp_snd_data {
+	bool stream_prepared[AFE_PORT_MAX];
+	struct snd_soc_card *card;
+	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
+	struct snd_soc_jack jack;
+	bool jack_setup;
+};
+
+static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+
+	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
+}
+
+static int sc8280xp_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = rate->max = 48000;
+	channels->min = 2;
+	channels->max = 2;
+	switch (cpu_dai->id) {
+	case TX_CODEC_DMA_TX_0:
+	case TX_CODEC_DMA_TX_1:
+	case TX_CODEC_DMA_TX_2:
+	case TX_CODEC_DMA_TX_3:
+		channels->min = 1;
+		break;
+	default:
+		break;
+	}
+
+
+	return 0;
+}
+
+static int sc8280xp_snd_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct sc8280xp_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
+
+	return qcom_snd_sdw_hw_params(substream, params, &pdata->sruntime[cpu_dai->id]);
+}
+
+static int sc8280xp_snd_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+
+	return qcom_snd_sdw_prepare(substream, sruntime,
+				    &data->stream_prepared[cpu_dai->id]);
+}
+
+static int sc8280xp_snd_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+
+	return qcom_snd_sdw_hw_free(substream, sruntime,
+				    &data->stream_prepared[cpu_dai->id]);
+}
+
+static const struct snd_soc_ops sc8280xp_be_ops = {
+	.hw_params = sc8280xp_snd_hw_params,
+	.hw_free = sc8280xp_snd_hw_free,
+	.prepare = sc8280xp_snd_prepare,
+};
+
+static void sc8280xp_add_be_ops(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *link;
+	int i;
+
+	for_each_card_prelinks(card, i, link) {
+		if (link->no_pcm == 1) {
+			link->init = sc8280xp_snd_init;
+			link->be_hw_params_fixup = sc8280xp_be_hw_params_fixup;
+			link->ops = &sc8280xp_be_ops;
+		}
+	}
+}
+
+static int sc8280xp_platform_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card;
+	struct sc8280xp_snd_data *data;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+	card->owner = THIS_MODULE;
+	/* Allocate the private data */
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	card->dev = dev;
+	dev_set_drvdata(dev, card);
+	snd_soc_card_set_drvdata(card, data);
+	ret = qcom_snd_parse_of(card);
+	if (ret)
+		return ret;
+
+	card->driver_name = DRIVER_NAME;
+	sc8280xp_add_be_ops(card);
+	return devm_snd_soc_register_card(dev, card);
+}
+
+static const struct of_device_id snd_sc8280xp_dt_match[] = {
+	{.compatible = "qcom,sc8280xp-sndcard",},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, snd_sc8280xp_dt_match);
+
+static struct platform_driver snd_sc8280xp_driver = {
+	.probe  = sc8280xp_platform_probe,
+	.driver = {
+		.name = "snd-sc8280xp",
+		.of_match_table = snd_sc8280xp_dt_match,
+	},
+};
+module_platform_driver(snd_sc8280xp_driver);
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_DESCRIPTION("SC8280XP ASoC Machine Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

