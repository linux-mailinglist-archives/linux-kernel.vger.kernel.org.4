Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE0F6FC4E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjEILWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjEILWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:22:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C844EE0
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:22:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-306f2b42a86so3622870f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683631329; x=1686223329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfCcSveqMLGp6QUetB3KVscfku26PhF2QBUjnUp0yPg=;
        b=hf+jL8rKFKU/v9sPw7R1ubkn+2T4ZkSGkcWBbVdVE07z1Ve56+FJ3kVtfsRMcN6ypg
         Xhny7KBwyBSPiiW0RcXqvma4g5OvYsZPpLB04M36yBRzFnPM3JVFzUZZx09gopbsxJRT
         4GlLwiPrhNA746L4BgTnKRIpaGgo8Vv+q82XC2V42+e9swXlgSEz21dy3pvJ59LXcN+9
         TfcJRpXd8n91X3Vv8yEoiXnYAZRV0H204DgSChKjT+4cWLs5lsHExmCqx1Ld0HybPgkp
         /BPSjXcE2GGNWGXaRhwwH+31oplxz4pMIV9zwIZJfEqzzWoCLidjXxLoOjqQcUnmZCHE
         4rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683631329; x=1686223329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfCcSveqMLGp6QUetB3KVscfku26PhF2QBUjnUp0yPg=;
        b=bZ61X22EjcpKGfGuqjJXl7c3elnqKF1K5WTFm3Ce/FAOKhOH8SXPXKzswvpf9pTQ1H
         bE6elAa6wm1pgEf99d1q1i/LM7A6d9fXfxxmrWJjmbiRtqVAfUYTHRLOF2aenR7wgbnh
         yeVh+TOgB2oz7WJPV5z2bOfmQjI1CE4C2JRQ4dgplqxRkAf3ombdA2HZBG7otv8u3yKn
         JeTxTKhZlcpoPFVbxP9BS2a3lR6qbnuukC97c5ZGWO6JWp+qJW7S1vJOzToQjP1ZwboD
         FZU8yNPT5YOcAKGyZ10IWGwcK1avDB3z83Znm32vmvRZgenTNVJCoMhqcFUAb/6fjm1Z
         CnDA==
X-Gm-Message-State: AC+VfDz+RcmhcLKMYjZ/DZVSXx5VbVewXAvR98RT1cq5pvrmfTrkxZVb
        MadZCRuOfHKVS0GTKAi96U9wbw==
X-Google-Smtp-Source: ACHHUZ4NfB6pOeQ+HCgyqUG13YvNskOphBJkvvnDI9c2105UhklBZPaUEJCG+Wya5o9tKFl3aeNXYw==
X-Received: by 2002:a5d:5746:0:b0:306:4239:4cd with SMTP id q6-20020a5d5746000000b00306423904cdmr9658659wrw.31.1683631329129;
        Tue, 09 May 2023 04:22:09 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003f17eded97bsm19531072wmd.19.2023.05.09.04.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:22:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] ASoC: qcom: q6dsp: add support to more display ports
Date:   Tue,  9 May 2023 12:22:01 +0100
Message-Id: <20230509112202.21471-4-srinivas.kandagatla@linaro.org>
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

Existing code base only supports one display port, this patch adds
support upto 8 display ports. This support is required to allow platforms
like X13s which have 3 display ports, and some of the Qualcomm SoCs
there are upto 7 Display ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../sound/qcom,q6dsp-lpass-ports.h            |  8 ++++
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c      | 43 ++++++++++++-------
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
index 9f7c5103bc82..39f203256c4f 100644
--- a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
+++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
@@ -131,6 +131,14 @@
 #define RX_CODEC_DMA_RX_7	126
 #define QUINARY_MI2S_RX		127
 #define QUINARY_MI2S_TX		128
+#define DISPLAY_PORT_RX_0	DISPLAY_PORT_RX
+#define DISPLAY_PORT_RX_1	129
+#define DISPLAY_PORT_RX_2	130
+#define DISPLAY_PORT_RX_3	131
+#define DISPLAY_PORT_RX_4	132
+#define DISPLAY_PORT_RX_5	133
+#define DISPLAY_PORT_RX_6	134
+#define DISPLAY_PORT_RX_7	135
 
 #define LPASS_CLK_ID_PRI_MI2S_IBIT	1
 #define LPASS_CLK_ID_PRI_MI2S_EBIT	2
diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
index f67c16fd90b9..ac937a6bf909 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
+++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
@@ -79,6 +79,22 @@
 		.id = did,						\
 	}
 
+#define Q6AFE_DP_RX_DAI(did) {						\
+		.playback = {						\
+			.stream_name = #did" Playback",			\
+			.rates = SNDRV_PCM_RATE_48000 |			\
+				SNDRV_PCM_RATE_96000 |			\
+				SNDRV_PCM_RATE_192000,			\
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
+				   SNDRV_PCM_FMTBIT_S24_LE,		\
+			.channels_min = 2,				\
+			.channels_max = 8,				\
+			.rate_min = 48000,				\
+			.rate_max = 192000,				\
+		},							\
+		.name = #did,						\
+		.id = did,						\
+	}
 
 static struct snd_soc_dai_driver q6dsp_audio_fe_dais[] = {
 	{
@@ -528,22 +544,14 @@ static struct snd_soc_dai_driver q6dsp_audio_fe_dais[] = {
 	Q6AFE_TDM_CAP_DAI("Quinary", 5, QUINARY_TDM_TX_5),
 	Q6AFE_TDM_CAP_DAI("Quinary", 6, QUINARY_TDM_TX_6),
 	Q6AFE_TDM_CAP_DAI("Quinary", 7, QUINARY_TDM_TX_7),
-	{
-		.playback = {
-			.stream_name = "Display Port Playback",
-			.rates = SNDRV_PCM_RATE_48000 |
-				 SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE |
-				   SNDRV_PCM_FMTBIT_S24_LE,
-			.channels_min = 2,
-			.channels_max = 8,
-			.rate_max =     192000,
-			.rate_min =	48000,
-		},
-		.id = DISPLAY_PORT_RX,
-		.name = "DISPLAY_PORT",
-	},
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_0),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_1),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_2),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_3),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_4),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_5),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_6),
+	Q6AFE_DP_RX_DAI(DISPLAY_PORT_RX_7),
 	Q6AFE_CDC_DMA_RX_DAI(WSA_CODEC_DMA_RX_0),
 	Q6AFE_CDC_DMA_TX_DAI(WSA_CODEC_DMA_TX_0),
 	Q6AFE_CDC_DMA_RX_DAI(WSA_CODEC_DMA_RX_1),
@@ -603,6 +611,9 @@ struct snd_soc_dai_driver *q6dsp_audio_ports_set_config(struct device *dev,
 		case DISPLAY_PORT_RX:
 			q6dsp_audio_fe_dais[i].ops = cfg->q6hdmi_ops;
 			break;
+		case DISPLAY_PORT_RX_1 ... DISPLAY_PORT_RX_7:
+			q6dsp_audio_fe_dais[i].ops = cfg->q6hdmi_ops;
+			break;
 		case SLIMBUS_0_RX ... SLIMBUS_6_TX:
 			q6dsp_audio_fe_dais[i].ops = cfg->q6slim_ops;
 			break;
-- 
2.21.0

