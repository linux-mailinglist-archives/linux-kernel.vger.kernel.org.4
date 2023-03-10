Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB96B47AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjCJOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjCJOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:52:32 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A610D32F;
        Fri, 10 Mar 2023 06:48:58 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1767a208b30so6092115fac.2;
        Fri, 10 Mar 2023 06:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MeMfBv4qQBDw/gdQ6DRV1lIN5tc704+WbXsfATt4Sf8=;
        b=fYs4vkOtdWtHG5D9rzfzKG8USk1kL4rEYvuo0opv8vJGT6EQuCv+CmSvuqroEHKEXr
         4KC4X0mFjMiZs+PF9grMVSODtAb463cTJ28tDYVHN6Eu7uaUSuX98kFGYAdQeVNvHRuC
         WMahpTr7z4H0akRCxptQKmGA79uC6H9f4879W+1dg/MAwZwsyPTobO+8xU4VLV2UjxdO
         At3EBmKhyHlNpy2OXD1vUU0rJeTsusc/j9ZmXOS6aj2V3CSWg1/DMsQaBNZp4mNRfUid
         HjLyB2GufjpeH3QV6Y6cAjf2wb5B8JLjAYuc/fsRf2hlPK8tgBg4RMq0v8RRtPTtvWvi
         5V6Q==
X-Gm-Message-State: AO0yUKVcz8K34zAis9NghA36kBb+WjkRu+IGru17VZ/ThYXOsI24g2Pt
        TYClWREsyPJNNT9SknVRlA==
X-Google-Smtp-Source: AK7set8szTbZ+YaspgWW0DP50UUQDJz+VFULa71hkxc+OI/0UNVu/Ygd6JIK1cuNuWckROeaP/6v4w==
X-Received: by 2002:a05:6870:d113:b0:176:5b6f:12ff with SMTP id e19-20020a056870d11300b001765b6f12ffmr15944517oac.4.1678459682358;
        Fri, 10 Mar 2023 06:48:02 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n22-20020a4ae1d6000000b005253a5cc3cfsm866059oot.29.2023.03.10.06.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:01 -0800 (PST)
Received: (nullmailer pid 1546457 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:32 -0600
Message-Id: <20230310144733.1546413-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/soc/codecs/sta32x.c  | 39 +++++++++++------------
 sound/soc/codecs/sta350.c  | 63 +++++++++++++++++---------------------
 sound/soc/codecs/tas5086.c |  2 +-
 sound/soc/fsl/fsl_sai.c    | 12 ++++----
 sound/soc/fsl/fsl_ssi.c    |  2 +-
 sound/soc/fsl/imx-card.c   |  2 +-
 sound/soc/sh/rcar/ssi.c    |  4 +--
 7 files changed, 57 insertions(+), 67 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 8c86b578eba8..29af9595dac1 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -1054,35 +1054,32 @@ static int sta32x_probe_dt(struct device *dev, struct sta32x_priv *sta32x)
 	of_property_read_u8(np, "st,ch3-output-mapping",
 			    &pdata->ch3_output_mapping);
 
-	if (of_get_property(np, "st,fault-detect-recovery", NULL))
-		pdata->fault_detect_recovery = 1;
-	if (of_get_property(np, "st,thermal-warning-recovery", NULL))
-		pdata->thermal_warning_recovery = 1;
-	if (of_get_property(np, "st,thermal-warning-adjustment", NULL))
-		pdata->thermal_warning_adjustment = 1;
-	if (of_get_property(np, "st,needs_esd_watchdog", NULL))
-		pdata->needs_esd_watchdog = 1;
+	pdata->fault_detect_recovery =
+		of_property_read_bool(np, "st,fault-detect-recovery");
+	pdata->thermal_warning_recovery =
+		of_property_read_bool(np, "st,thermal-warning-recovery");
+	pdata->thermal_warning_adjustment =
+		of_property_read_bool(np, "st,thermal-warning-adjustment");
+	pdata->needs_esd_watchdog =
+		of_property_read_bool(np, "st,needs_esd_watchdog");
 
 	tmp = 140;
 	of_property_read_u16(np, "st,drop-compensation-ns", &tmp);
 	pdata->drop_compensation_ns = clamp_t(u16, tmp, 0, 300) / 20;
 
 	/* CONFE */
-	if (of_get_property(np, "st,max-power-use-mpcc", NULL))
-		pdata->max_power_use_mpcc = 1;
-
-	if (of_get_property(np, "st,max-power-correction", NULL))
-		pdata->max_power_correction = 1;
-
-	if (of_get_property(np, "st,am-reduction-mode", NULL))
-		pdata->am_reduction_mode = 1;
-
-	if (of_get_property(np, "st,odd-pwm-speed-mode", NULL))
-		pdata->odd_pwm_speed_mode = 1;
+	pdata->max_power_use_mpcc =
+		of_property_read_bool(np, "st,max-power-use-mpcc");
+	pdata->max_power_correction =
+		of_property_read_bool(np, "st,max-power-correction");
+	pdata->am_reduction_mode =
+		of_property_read_bool(np, "st,am-reduction-mode");
+	pdata->odd_pwm_speed_mode =
+		of_property_read_bool(np, "st,odd-pwm-speed-mode");
 
 	/* CONFF */
-	if (of_get_property(np, "st,invalid-input-detect-mute", NULL))
-		pdata->invalid_input_detect_mute = 1;
+	pdata->invalid_input_detect_mute =
+		of_property_read_bool(np, "st,invalid-input-detect-mute");
 
 	sta32x->pdata = pdata;
 
diff --git a/sound/soc/codecs/sta350.c b/sound/soc/codecs/sta350.c
index 9ed13aeb3cbd..b033a5fcd6c0 100644
--- a/sound/soc/codecs/sta350.c
+++ b/sound/soc/codecs/sta350.c
@@ -1106,12 +1106,12 @@ static int sta350_probe_dt(struct device *dev, struct sta350_priv *sta350)
 	of_property_read_u8(np, "st,ch3-output-mapping",
 			    &pdata->ch3_output_mapping);
 
-	if (of_get_property(np, "st,thermal-warning-recovery", NULL))
-		pdata->thermal_warning_recovery = 1;
-	if (of_get_property(np, "st,thermal-warning-adjustment", NULL))
-		pdata->thermal_warning_adjustment = 1;
-	if (of_get_property(np, "st,fault-detect-recovery", NULL))
-		pdata->fault_detect_recovery = 1;
+	pdata->thermal_warning_recovery =
+		of_property_read_bool(np, "st,thermal-warning-recovery");
+	pdata->thermal_warning_adjustment =
+		of_property_read_bool(np, "st,thermal-warning-adjustment");
+	pdata->fault_detect_recovery =
+		of_property_read_bool(np, "st,fault-detect-recovery");
 
 	pdata->ffx_power_output_mode = STA350_FFX_PM_VARIABLE_DROP_COMP;
 	if (!of_property_read_string(np, "st,ffx-power-output-mode",
@@ -1133,41 +1133,34 @@ static int sta350_probe_dt(struct device *dev, struct sta350_priv *sta350)
 	of_property_read_u16(np, "st,drop-compensation-ns", &tmp);
 	pdata->drop_compensation_ns = clamp_t(u16, tmp, 0, 300) / 20;
 
-	if (of_get_property(np, "st,overcurrent-warning-adjustment", NULL))
-		pdata->oc_warning_adjustment = 1;
+	pdata->oc_warning_adjustment =
+		of_property_read_bool(np, "st,overcurrent-warning-adjustment");
 
 	/* CONFE */
-	if (of_get_property(np, "st,max-power-use-mpcc", NULL))
-		pdata->max_power_use_mpcc = 1;
-
-	if (of_get_property(np, "st,max-power-correction", NULL))
-		pdata->max_power_correction = 1;
-
-	if (of_get_property(np, "st,am-reduction-mode", NULL))
-		pdata->am_reduction_mode = 1;
-
-	if (of_get_property(np, "st,odd-pwm-speed-mode", NULL))
-		pdata->odd_pwm_speed_mode = 1;
-
-	if (of_get_property(np, "st,distortion-compensation", NULL))
-		pdata->distortion_compensation = 1;
+	pdata->max_power_use_mpcc =
+		of_property_read_bool(np, "st,max-power-use-mpcc");
+	pdata->max_power_correction =
+		of_property_read_bool(np, "st,max-power-correction");
+	pdata->am_reduction_mode =
+		of_property_read_bool(np, "st,am-reduction-mode");
+	pdata->odd_pwm_speed_mode =
+		of_property_read_bool(np, "st,odd-pwm-speed-mode");
+	pdata->distortion_compensation =
+		of_property_read_bool(np, "st,distortion-compensation");
 
 	/* CONFF */
-	if (of_get_property(np, "st,invalid-input-detect-mute", NULL))
-		pdata->invalid_input_detect_mute = 1;
+	pdata->invalid_input_detect_mute =
+		of_property_read_bool(np, "st,invalid-input-detect-mute");
 
 	/* MISC */
-	if (of_get_property(np, "st,activate-mute-output", NULL))
-		pdata->activate_mute_output = 1;
-
-	if (of_get_property(np, "st,bridge-immediate-off", NULL))
-		pdata->bridge_immediate_off = 1;
-
-	if (of_get_property(np, "st,noise-shape-dc-cut", NULL))
-		pdata->noise_shape_dc_cut = 1;
-
-	if (of_get_property(np, "st,powerdown-master-volume", NULL))
-		pdata->powerdown_master_vol = 1;
+	pdata->activate_mute_output =
+		of_property_read_bool(np, "st,activate-mute-output");
+	pdata->bridge_immediate_off =
+		of_property_read_bool(np, "st,bridge-immediate-off");
+	pdata->noise_shape_dc_cut =
+		of_property_read_bool(np, "st,noise-shape-dc-cut");
+	pdata->powerdown_master_vol =
+		of_property_read_bool(np, "st,powerdown-master-volume");
 
 	if (!of_property_read_u8(np, "st,powerdown-delay-divider", &tmp8)) {
 		if (is_power_of_2(tmp8) && tmp8 >= 1 && tmp8 <= 128)
diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 22143cc5afa7..f9e7122894bd 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -840,7 +840,7 @@ static int tas5086_probe(struct snd_soc_component *component)
 			snprintf(name, sizeof(name),
 				 "ti,mid-z-channel-%d", i + 1);
 
-			if (of_get_property(of_node, name, NULL) != NULL)
+			if (of_property_read_bool(of_node, name))
 				priv->pwm_start_mid_z |= 1 << i;
 		}
 	}
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 1b197478b3d9..4e6b75f1ddd0 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1380,18 +1380,18 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	sai->cpu_dai_drv.symmetric_channels = 1;
 	sai->cpu_dai_drv.symmetric_sample_bits = 1;
 
-	if (of_find_property(np, "fsl,sai-synchronous-rx", NULL) &&
-	    of_find_property(np, "fsl,sai-asynchronous", NULL)) {
+	if (of_property_read_bool(np, "fsl,sai-synchronous-rx") &&
+	    of_property_read_bool(np, "fsl,sai-asynchronous")) {
 		/* error out if both synchronous and asynchronous are present */
 		dev_err(dev, "invalid binding for synchronous mode\n");
 		return -EINVAL;
 	}
 
-	if (of_find_property(np, "fsl,sai-synchronous-rx", NULL)) {
+	if (of_property_read_bool(np, "fsl,sai-synchronous-rx")) {
 		/* Sync Rx with Tx */
 		sai->synchronous[RX] = false;
 		sai->synchronous[TX] = true;
-	} else if (of_find_property(np, "fsl,sai-asynchronous", NULL)) {
+	} else if (of_property_read_bool(np, "fsl,sai-asynchronous")) {
 		/* Discard all settings for asynchronous mode */
 		sai->synchronous[RX] = false;
 		sai->synchronous[TX] = false;
@@ -1400,7 +1400,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		sai->cpu_dai_drv.symmetric_sample_bits = 0;
 	}
 
-	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
+	if (of_property_read_bool(np, "fsl,sai-mclk-direction-output") &&
 	    of_device_is_compatible(np, "fsl,imx6ul-sai")) {
 		gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
 		if (IS_ERR(gpr)) {
@@ -1443,7 +1443,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		dev_warn(dev, "Error reading SAI version: %d\n", ret);
 
 	/* Select MCLK direction */
-	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
+	if (of_property_read_bool(np, "fsl,sai-mclk-direction-output") &&
 	    sai->soc_data->max_register >= FSL_SAI_MCTL) {
 		regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
 				   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 46a53551b955..6af00b62a60f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1447,7 +1447,7 @@ static int fsl_ssi_probe_from_dt(struct fsl_ssi *ssi)
 			return -EINVAL;
 		}
 		strcpy(ssi->card_name, "ac97-codec");
-	} else if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
+	} else if (!of_property_read_bool(np, "fsl,ssi-asynchronous")) {
 		/*
 		 * In synchronous mode, STCK and STFS ports are used by RX
 		 * as well. So the software should limit the sample rates,
diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index 3f128ced4180..64a4d7e9db60 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -563,7 +563,7 @@ static int imx_card_parse_of(struct imx_card_data *data)
 			link_data->cpu_sysclk_id = FSL_SAI_CLK_MAST1;
 
 			/* sai may support mclk/bclk = 1 */
-			if (of_find_property(np, "fsl,mclk-equal-bclk", NULL)) {
+			if (of_property_read_bool(np, "fsl,mclk-equal-bclk")) {
 				link_data->one2one_ratio = true;
 			} else {
 				int i;
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 8ddee5b03ece..690ac0d6ef41 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1211,10 +1211,10 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 			goto rsnd_ssi_probe_done;
 		}
 
-		if (of_get_property(np, "shared-pin", NULL))
+		if (of_property_read_bool(np, "shared-pin"))
 			rsnd_flags_set(ssi, RSND_SSI_CLK_PIN_SHARE);
 
-		if (of_get_property(np, "no-busif", NULL))
+		if (of_property_read_bool(np, "no-busif"))
 			rsnd_flags_set(ssi, RSND_SSI_NO_BUSIF);
 
 		ssi->irq = irq_of_parse_and_map(np, 0);
-- 
2.39.2

