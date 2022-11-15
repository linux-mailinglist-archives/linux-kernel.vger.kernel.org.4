Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B259A629207
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiKOGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiKOGyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:54:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60F3CE4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:54:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l14so22581600wrw.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pFaM0hloG+JfDFCgGPA/nosgcP0KUi3J9bN6sLMDKRw=;
        b=J2vPBmLOoJw7NIe5hwqyxQAiV2H3Iss+gEdWg8gMITlrjWh8tMllsd/5TmVLC6AiMy
         I8Akf7BgUzMM/xfsE/iG/QuRgJErZMO8oGnvbWOZ7+ATUoS8KH+yVzig6a+mBhztxMT2
         GhhbRTE/d58+z1Bc7x+Alme08EtLSBqu7EBNuwNtyCV3If8mx6Vu0UNAr9yn5tZ/F3wK
         OgemPn8A/huUa0wnxvlDNfdf6XyiPGPF3JDKek/QaVDU7Zh3k8MkMTgq4+slXNp0Wdt6
         Vu+DmAZF9f/1YExChfLHLzbf7DQwIScK0sIWwPOlsx5blqkzxvh+9P//3uXs1I1NpwhV
         Zt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFaM0hloG+JfDFCgGPA/nosgcP0KUi3J9bN6sLMDKRw=;
        b=0OawhGqiUgqHpMaxG9WYJr99oFPlMQeejTr/oWF6BdgQXRT0G32cfPZVFQlhNcEjC/
         hnezLTZGmLpdSbvQHOLAE79GTrkY7PoxfSVkJ1jMDQ+REA0DMsPUIB6Lj4/s1u+Cc4Hd
         to5FRwkvaICi+R3lH/iV/9F4hA5oOvDDUHI/F3BtDKSOOUDjJUWuhBV9RvBPRueExIAB
         thaiuIkFpq5Yb66PO44APmerlOlagUaJ5Y1VpFjiCtKqoaKWi7/DfE+u4qNnWiNzVXW+
         /6S2qiJiJfINpzdMgHZKcljnMoBVlhllCLUElWIRI9iemzq4Z02p/eOB/3iaps+bMKgu
         Lu5Q==
X-Gm-Message-State: ANoB5pnZF83f0vSEtL8raeCoK/qJSrtDOdvD87+OKFxQd8ztPFHaS2mx
        HvKeDfpjcUpTqR87tPN+kOYEhw==
X-Google-Smtp-Source: AA0mqf4D5kpCBvMwW6NTLWocITfU8RvfyH/og1nY5cSJDvqVKqRxs1CS0kmeiKRa3u7rcnQA6byPZg==
X-Received: by 2002:a5d:420e:0:b0:236:7034:cd48 with SMTP id n14-20020a5d420e000000b002367034cd48mr9451209wrq.418.1668495274186;
        Mon, 14 Nov 2022 22:54:34 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id az11-20020a05600c600b00b003b4cba4ef71sm21194175wmb.41.2022.11.14.22.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:54:33 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: codecs: tx-macro: add dmic support via tx macro
Date:   Tue, 15 Nov 2022 06:54:30 +0000
Message-Id: <20221115065430.4126-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMIC Paths into LPASS digital codec can go via tx-macro or va-macro codec, add
support to tx-macro path as va-macro path is already supported.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 149 +++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index ee15cf6b98bb..2ef62d6edc30 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -46,6 +46,7 @@
 #define CDC_TX_TOP_CSR_SWR_AMIC1_CTL	(0x00D4)
 #define CDC_TX_INP_MUX_ADC_MUXn_CFG0(n)	(0x0100 + 0x8 * n)
 #define CDC_TX_MACRO_SWR_MIC_MUX_SEL_MASK GENMASK(3, 0)
+#define CDC_TX_MACRO_DMIC_MUX_SEL_MASK GENMASK(7, 4)
 #define CDC_TX_INP_MUX_ADC_MUX0_CFG0	(0x0100)
 #define CDC_TX_INP_MUX_ADC_MUXn_CFG1(n)	(0x0104 + 0x8 * n)
 #define CDC_TX_INP_MUX_ADC_MUX0_CFG1	(0x0104)
@@ -774,7 +775,10 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
 	}
 
 	if (val != 0) {
-		if (val < 5) {
+		if (widget->shift) { /* MSM DMIC */
+			snd_soc_component_write_field(component, mic_sel_reg,
+						      CDC_TXn_ADC_DMIC_SEL_MASK, 1);
+		} else if (val < 5) {
 			snd_soc_component_write_field(component, mic_sel_reg,
 						      CDC_TXn_ADC_DMIC_SEL_MASK, 0);
 		} else {
@@ -1272,6 +1276,52 @@ static const struct snd_kcontrol_new tx_smic6_mux = SOC_DAPM_ENUM_EXT("tx_smic6"
 static const struct snd_kcontrol_new tx_smic7_mux = SOC_DAPM_ENUM_EXT("tx_smic7", tx_smic7_enum,
 			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
 
+static const char * const dmic_mux_text[] = {
+	"ZERO", "DMIC0", "DMIC1", "DMIC2", "DMIC3",
+	"DMIC4", "DMIC5", "DMIC6", "DMIC7"
+};
+
+static SOC_ENUM_SINGLE_DECL(tx_dmic0_enum, CDC_TX_INP_MUX_ADC_MUX0_CFG0,
+			4, dmic_mux_text);
+
+static SOC_ENUM_SINGLE_DECL(tx_dmic1_enum, CDC_TX_INP_MUX_ADC_MUX1_CFG0,
+			4, dmic_mux_text);
+
+static SOC_ENUM_SINGLE_DECL(tx_dmic2_enum, CDC_TX_INP_MUX_ADC_MUX2_CFG0,
+			4, dmic_mux_text);
+
+static SOC_ENUM_SINGLE_DECL(tx_dmic3_enum, CDC_TX_INP_MUX_ADC_MUX3_CFG0,
+			4, dmic_mux_text);
+
+static SOC_ENUM_SINGLE_DECL(tx_dmic4_enum, CDC_TX_INP_MUX_ADC_MUX4_CFG0,
+			4, dmic_mux_text);
+
+static SOC_ENUM_SINGLE_DECL(tx_dmic5_enum, CDC_TX_INP_MUX_ADC_MUX5_CFG0,
+			4, dmic_mux_text);
+
+static SOC_ENUM_SINGLE_DECL(tx_dmic6_enum, CDC_TX_INP_MUX_ADC_MUX6_CFG0,
+			4, dmic_mux_text);
+
+static SOC_ENUM_SINGLE_DECL(tx_dmic7_enum, CDC_TX_INP_MUX_ADC_MUX7_CFG0,
+			4, dmic_mux_text);
+
+static const struct snd_kcontrol_new tx_dmic0_mux = SOC_DAPM_ENUM_EXT("tx_dmic0", tx_dmic0_enum,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_dmic1_mux = SOC_DAPM_ENUM_EXT("tx_dmic1", tx_dmic1_enum,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_dmic2_mux = SOC_DAPM_ENUM_EXT("tx_dmic2", tx_dmic2_enum,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_dmic3_mux = SOC_DAPM_ENUM_EXT("tx_dmic3", tx_dmic3_enum,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_dmic4_mux = SOC_DAPM_ENUM_EXT("tx_dmic4", tx_dmic4_enum,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_dmic5_mux = SOC_DAPM_ENUM_EXT("tx_dmic5", tx_dmic5_enum,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_dmic6_mux = SOC_DAPM_ENUM_EXT("tx_dmic6", tx_dmic6_enum,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+static const struct snd_kcontrol_new tx_dmic7_mux = SOC_DAPM_ENUM_EXT("tx_dmic7", tx_dmic7_enum,
+			snd_soc_dapm_get_enum_double, tx_macro_put_dec_enum);
+
 static const char * const dec_mode_mux_text[] = {
 	"ADC_DEFAULT", "ADC_LOW_PWR", "ADC_HIGH_PERF",
 };
@@ -1380,6 +1430,15 @@ static const struct snd_soc_dapm_widget tx_macro_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("TX SMIC MUX6", SND_SOC_NOPM, 0, 0, &tx_smic6_mux),
 	SND_SOC_DAPM_MUX("TX SMIC MUX7", SND_SOC_NOPM, 0, 0, &tx_smic7_mux),
 
+	SND_SOC_DAPM_MUX("TX DMIC MUX0", SND_SOC_NOPM, 4, 0, &tx_dmic0_mux),
+	SND_SOC_DAPM_MUX("TX DMIC MUX1", SND_SOC_NOPM, 4, 0, &tx_dmic1_mux),
+	SND_SOC_DAPM_MUX("TX DMIC MUX2", SND_SOC_NOPM, 4, 0, &tx_dmic2_mux),
+	SND_SOC_DAPM_MUX("TX DMIC MUX3", SND_SOC_NOPM, 4, 0, &tx_dmic3_mux),
+	SND_SOC_DAPM_MUX("TX DMIC MUX4", SND_SOC_NOPM, 4, 0, &tx_dmic4_mux),
+	SND_SOC_DAPM_MUX("TX DMIC MUX5", SND_SOC_NOPM, 4, 0, &tx_dmic5_mux),
+	SND_SOC_DAPM_MUX("TX DMIC MUX6", SND_SOC_NOPM, 4, 0, &tx_dmic6_mux),
+	SND_SOC_DAPM_MUX("TX DMIC MUX7", SND_SOC_NOPM, 4, 0, &tx_dmic7_mux),
+
 	SND_SOC_DAPM_INPUT("TX SWR_ADC0"),
 	SND_SOC_DAPM_INPUT("TX SWR_ADC1"),
 	SND_SOC_DAPM_INPUT("TX SWR_ADC2"),
@@ -1392,6 +1451,14 @@ static const struct snd_soc_dapm_widget tx_macro_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("TX SWR_DMIC5"),
 	SND_SOC_DAPM_INPUT("TX SWR_DMIC6"),
 	SND_SOC_DAPM_INPUT("TX SWR_DMIC7"),
+	SND_SOC_DAPM_INPUT("TX DMIC0"),
+	SND_SOC_DAPM_INPUT("TX DMIC1"),
+	SND_SOC_DAPM_INPUT("TX DMIC2"),
+	SND_SOC_DAPM_INPUT("TX DMIC3"),
+	SND_SOC_DAPM_INPUT("TX DMIC4"),
+	SND_SOC_DAPM_INPUT("TX DMIC5"),
+	SND_SOC_DAPM_INPUT("TX DMIC6"),
+	SND_SOC_DAPM_INPUT("TX DMIC7"),
 
 	SND_SOC_DAPM_MUX_E("TX DEC0 MUX", SND_SOC_NOPM,
 			   TX_MACRO_DEC0, 0,
@@ -1495,6 +1562,16 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX DEC6 MUX", NULL, "TX_MCLK"},
 	{"TX DEC7 MUX", NULL, "TX_MCLK"},
 
+	{"TX DEC0 MUX", "MSM_DMIC", "TX DMIC MUX0"},
+	{"TX DMIC MUX0", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX0", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX0", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX0", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX0", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX0", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX0", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX0", "DMIC7", "TX DMIC7"},
+
 	{"TX DEC0 MUX", "SWR_MIC", "TX SMIC MUX0"},
 	{"TX SMIC MUX0", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX0", "ADC0", "TX SWR_ADC0"},
@@ -1510,6 +1587,16 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX0", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX0", "SWR_DMIC7", "TX SWR_DMIC7"},
 
+	{"TX DEC1 MUX", "MSM_DMIC", "TX DMIC MUX1"},
+	{"TX DMIC MUX1", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX1", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX1", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX1", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX1", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX1", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX1", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX1", "DMIC7", "TX DMIC7"},
+
 	{"TX DEC1 MUX", "SWR_MIC", "TX SMIC MUX1"},
 	{"TX SMIC MUX1", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX1", "ADC0", "TX SWR_ADC0"},
@@ -1525,6 +1612,16 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX1", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX1", "SWR_DMIC7", "TX SWR_DMIC7"},
 
+	{"TX DEC2 MUX", "MSM_DMIC", "TX DMIC MUX2"},
+	{"TX DMIC MUX2", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX2", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX2", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX2", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX2", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX2", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX2", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX2", "DMIC7", "TX DMIC7"},
+
 	{"TX DEC2 MUX", "SWR_MIC", "TX SMIC MUX2"},
 	{"TX SMIC MUX2", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX2", "ADC0", "TX SWR_ADC0"},
@@ -1540,6 +1637,16 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX2", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX2", "SWR_DMIC7", "TX SWR_DMIC7"},
 
+	{"TX DEC3 MUX", "MSM_DMIC", "TX DMIC MUX3"},
+	{"TX DMIC MUX3", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX3", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX3", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX3", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX3", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX3", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX3", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX3", "DMIC7", "TX DMIC7"},
+
 	{"TX DEC3 MUX", "SWR_MIC", "TX SMIC MUX3"},
 	{"TX SMIC MUX3", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX3", "ADC0", "TX SWR_ADC0"},
@@ -1555,6 +1662,16 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX3", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX3", "SWR_DMIC7", "TX SWR_DMIC7"},
 
+	{"TX DEC4 MUX", "MSM_DMIC", "TX DMIC MUX4"},
+	{"TX DMIC MUX4", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX4", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX4", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX4", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX4", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX4", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX4", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX4", "DMIC7", "TX DMIC7"},
+
 	{"TX DEC4 MUX", "SWR_MIC", "TX SMIC MUX4"},
 	{"TX SMIC MUX4", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX4", "ADC0", "TX SWR_ADC0"},
@@ -1570,6 +1687,16 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX4", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX4", "SWR_DMIC7", "TX SWR_DMIC7"},
 
+	{"TX DEC5 MUX", "MSM_DMIC", "TX DMIC MUX5"},
+	{"TX DMIC MUX5", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX5", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX5", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX5", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX5", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX5", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX5", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX5", "DMIC7", "TX DMIC7"},
+
 	{"TX DEC5 MUX", "SWR_MIC", "TX SMIC MUX5"},
 	{"TX SMIC MUX5", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX5", "ADC0", "TX SWR_ADC0"},
@@ -1585,6 +1712,16 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX5", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX5", "SWR_DMIC7", "TX SWR_DMIC7"},
 
+	{"TX DEC6 MUX", "MSM_DMIC", "TX DMIC MUX6"},
+	{"TX DMIC MUX6", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX6", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX6", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX6", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX6", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX6", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX6", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX6", "DMIC7", "TX DMIC7"},
+
 	{"TX DEC6 MUX", "SWR_MIC", "TX SMIC MUX6"},
 	{"TX SMIC MUX6", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX6", "ADC0", "TX SWR_ADC0"},
@@ -1600,6 +1737,16 @@ static const struct snd_soc_dapm_route tx_audio_map[] = {
 	{"TX SMIC MUX6", "SWR_DMIC6", "TX SWR_DMIC6"},
 	{"TX SMIC MUX6", "SWR_DMIC7", "TX SWR_DMIC7"},
 
+	{"TX DEC7 MUX", "MSM_DMIC", "TX DMIC MUX7"},
+	{"TX DMIC MUX7", "DMIC0", "TX DMIC0"},
+	{"TX DMIC MUX7", "DMIC1", "TX DMIC1"},
+	{"TX DMIC MUX7", "DMIC2", "TX DMIC2"},
+	{"TX DMIC MUX7", "DMIC3", "TX DMIC3"},
+	{"TX DMIC MUX7", "DMIC4", "TX DMIC4"},
+	{"TX DMIC MUX7", "DMIC5", "TX DMIC5"},
+	{"TX DMIC MUX7", "DMIC6", "TX DMIC6"},
+	{"TX DMIC MUX7", "DMIC7", "TX DMIC7"},
+
 	{"TX DEC7 MUX", "SWR_MIC", "TX SMIC MUX7"},
 	{"TX SMIC MUX7", NULL, "TX_SWR_CLK"},
 	{"TX SMIC MUX7", "ADC0", "TX SWR_ADC0"},
-- 
2.25.1

