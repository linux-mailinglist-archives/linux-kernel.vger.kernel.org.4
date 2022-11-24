Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B31637B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiKXOFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKXOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:04:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8647DC81
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:04:01 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g12so2589718wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UPLDM1X+4+BmpiYXGN4fQwA4bV0V/bRkxj3ZJr22X8k=;
        b=FPmS9nYjtoWgaoEzjnzqpYOb3E6RaXUxbohz6HY6hDlqg2cTb0jwsKgyfR45NAx/RS
         u6YN9AXh8zo5Z4Cu60tyc5SSpSVXw2HxVEOSkEmVMg6qPyPtY5wy/OWxjsE2Pv+T0ODY
         f1xMqg5Ty+fjT59BdtwRgwo/UtCpO+3Nj30oRh1gfkkxRh/q0eGCrDwgrATm3AZgiNvT
         /VBPw3OU2l2DcKloq7OpLbTdjgEd28EevM7x/QeMWMIKeZocB87dM6grxXiGIsFLtP4P
         A+/9yaNFyxNhRsDEPKZJAYzZsBJBTizqwV5JKskLRvDhVd2nQvuwGtD/4Nn4VqzotHRY
         qXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPLDM1X+4+BmpiYXGN4fQwA4bV0V/bRkxj3ZJr22X8k=;
        b=ihtgj3MCLtdzRBX0ZYU8YuiA2fY3R8Sidq85Id6VlJcrODIXpb0A91gx9ABSuBTNFu
         aV029p9dH/dOWNAYAsyGF28ZZjozsRJJKFoxUbC0jAcwJ1RqJ6inU/uQl6qetz58CMDZ
         Ein4s+pxHfwPi+4JlkYg5l2tPxgJvwpAmgleXGB/P8y45tYzgkQ04FCu5KixCgjJAwFe
         wi6txP+6gmTVJ/HAMaoBXa5trpFkFPc4uk7ILgv89ZxvWzmZhRKDsQooTwSoOpN0luKc
         UXZkn0jyYNC31+7HbYKvuIXTN7dv7XWkCblTUs/0s35T9DsOzKTHUZasawmXgOXir6My
         mpYw==
X-Gm-Message-State: ANoB5plGWWw3vgsP1deS/3Ofnbi6wt6fpzM2iOET2pQPJDNP6nkvazJ3
        Mx07cz6ZKvHWu5bj6fIEh+m7CA==
X-Google-Smtp-Source: AA0mqf6Ez3aJB3hwGRDNPb4zZPBCNg0+cXL7s32xoUdXbrKzgxBfhDVeW0r6N0XwN8b9v7lV2AyWRA==
X-Received: by 2002:adf:ea82:0:b0:241:e749:f75c with SMTP id s2-20020adfea82000000b00241e749f75cmr6978278wrm.609.1669298640229;
        Thu, 24 Nov 2022 06:04:00 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003c6b7f5567csm11770720wms.0.2022.11.24.06.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 06:03:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: qcom: cleanup and fix dependency of QCOM_COMMON
Date:   Thu, 24 Nov 2022 14:03:51 +0000
Message-Id: <20221124140351.407506-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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

SND_SOC_QCOM_COMMON depends on SOUNDWIRE for some symbols but this
is not explicitly specified using Kconfig depends. On the other hand
SND_SOC_QCOM_COMMON is also directly selected by the sound card
Kconfigs, this could result in various combinations and some symbols
ending up in modules and soundcard that uses those symbols as in-build
driver.

Fix these issues by explicitly specifying the dependencies of
SND_SOC_QCOM_COMMON and also use imply a to select SND_SOC_QCOM_COMMON
so that the symbol is selected based on its dependencies.

Also remove dummy stubs in common.c around CONFIG_SOUNDWIRE

Fixes: 3bd975f3ae0a ("ASoC: qcom: sm8250: move some code to common")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig  | 16 +++++++++-------
 sound/soc/qcom/common.c |  2 --
 sound/soc/qcom/common.h | 23 -----------------------
 3 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8c7398bc1ca8..96a6d4731e6f 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -2,6 +2,7 @@
 menuconfig SND_SOC_QCOM
 	tristate "ASoC support for QCOM platforms"
 	depends on ARCH_QCOM || COMPILE_TEST
+	imply SND_SOC_QCOM_COMMON
 	help
 	  Say Y or M if you want to add support to use audio devices
 	  in Qualcomm Technologies SOC-based platforms.
@@ -59,13 +60,14 @@ config SND_SOC_STORM
 config SND_SOC_APQ8016_SBC
 	tristate "SoC Audio support for APQ8016 SBC platforms"
 	select SND_SOC_LPASS_APQ8016
-	select SND_SOC_QCOM_COMMON
+	depends on SND_SOC_QCOM_COMMON
 	help
 	  Support for Qualcomm Technologies LPASS audio block in
 	  APQ8016 SOC-based systems.
 	  Say Y if you want to use audio devices on MI2S.
 
 config SND_SOC_QCOM_COMMON
+	depends on SOUNDWIRE
 	tristate
 
 config SND_SOC_QDSP6_COMMON
@@ -142,7 +144,7 @@ config SND_SOC_MSM8996
 	depends on QCOM_APR
 	depends on COMMON_CLK
 	select SND_SOC_QDSP6
-	select SND_SOC_QCOM_COMMON
+	depends on SND_SOC_QCOM_COMMON
 	help
 	  Support for Qualcomm Technologies LPASS audio block in
 	  APQ8096 SoC-based systems.
@@ -153,7 +155,7 @@ config SND_SOC_SDM845
 	depends on QCOM_APR && I2C && SOUNDWIRE
 	depends on COMMON_CLK
 	select SND_SOC_QDSP6
-	select SND_SOC_QCOM_COMMON
+	depends on SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
 	imply SND_SOC_CROS_EC_CODEC
@@ -167,7 +169,7 @@ config SND_SOC_SM8250
 	depends on QCOM_APR && SOUNDWIRE
 	depends on COMMON_CLK
 	select SND_SOC_QDSP6
-	select SND_SOC_QCOM_COMMON
+	depends on SND_SOC_QCOM_COMMON
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SM8250 SoC-based systems.
@@ -178,7 +180,7 @@ config SND_SOC_SC8280XP
 	depends on QCOM_APR && SOUNDWIRE
 	depends on COMMON_CLK
 	select SND_SOC_QDSP6
-	select SND_SOC_QCOM_COMMON
+	depends on SND_SOC_QCOM_COMMON
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SC8280XP SoC-based systems.
@@ -188,7 +190,7 @@ config SND_SOC_SC7180
 	tristate "SoC Machine driver for SC7180 boards"
 	depends on I2C && GPIOLIB
 	depends on SOUNDWIRE || SOUNDWIRE=n
-	select SND_SOC_QCOM_COMMON
+	depends on SND_SOC_QCOM_COMMON
 	select SND_SOC_LPASS_SC7180
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT5682_I2C
@@ -202,7 +204,7 @@ config SND_SOC_SC7180
 config SND_SOC_SC7280
 	tristate "SoC Machine driver for SC7280 boards"
 	depends on I2C && SOUNDWIRE
-	select SND_SOC_QCOM_COMMON
+	depends on SND_SOC_QCOM_COMMON
 	select SND_SOC_LPASS_SC7280
 	select SND_SOC_MAX98357A
 	select SND_SOC_WCD938X_SDW
diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 69dd3b504e20..49c74c1662a3 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -180,7 +180,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 }
 EXPORT_SYMBOL_GPL(qcom_snd_parse_of);
 
-#if IS_ENABLED(CONFIG_SOUNDWIRE)
 int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 			 struct sdw_stream_runtime *sruntime,
 			 bool *stream_prepared)
@@ -294,7 +293,6 @@ int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_snd_sdw_hw_free);
-#endif
 
 int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 			    struct snd_soc_jack *jack, bool *jack_setup)
diff --git a/sound/soc/qcom/common.h b/sound/soc/qcom/common.h
index c5472a642de0..3ef5bb6d12df 100644
--- a/sound/soc/qcom/common.h
+++ b/sound/soc/qcom/common.h
@@ -11,7 +11,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card);
 int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 			    struct snd_soc_jack *jack, bool *jack_setup);
 
-#if IS_ENABLED(CONFIG_SOUNDWIRE)
 int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 			 struct sdw_stream_runtime *runtime,
 			 bool *stream_prepared);
@@ -21,26 +20,4 @@ int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
 			 struct sdw_stream_runtime *sruntime,
 			 bool *stream_prepared);
-#else
-static inline int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
-				       struct sdw_stream_runtime *runtime,
-				       bool *stream_prepared)
-{
-	return -ENOTSUPP;
-}
-
-static inline int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
-					 struct snd_pcm_hw_params *params,
-					 struct sdw_stream_runtime **psruntime)
-{
-	return -ENOTSUPP;
-}
-
-static inline int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
-				       struct sdw_stream_runtime *sruntime,
-				       bool *stream_prepared)
-{
-	return -ENOTSUPP;
-}
-#endif
 #endif
-- 
2.25.1

