Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0A74843A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjGEMdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjGEMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:33:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8B711B;
        Wed,  5 Jul 2023 05:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3840961557;
        Wed,  5 Jul 2023 12:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95922C433CC;
        Wed,  5 Jul 2023 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688560389;
        bh=fkeH/trnUCotq/eMq+tRenmiWPEZTSYWlpllerwpCEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kTdvDCFYKw21sRmjWal+eILYeelHqmrpRknWGNYfzgQmV1yZQmrokWC0wEtJcDESs
         wFg66S6c0Atvwd7L8gFtxdlPIczCGJvZLlLsAjtkMkAFcBdB5FLr8PF+2REXKMsTjk
         M0xAdHFFCSJHoKlz1WqcnAcC74Q48yUA6+ZuzKHwj/doFP0RfgPOfcJHfYlRIbYfG3
         hBA/8lFQxUs0RNTbR/kxPGm7bMq9bwCIcONGLh14Tnp87VlAXk4/+cfkeijgJvnVB9
         yndfN2YnB3wN/xJ6yGtdmx7keRwlGNGDz4EMKP+BeHs3ezGKoXAbaIdt/wfNIEn1Js
         ITeLbLk5pf57g==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qH1hK-00084E-1F;
        Wed, 05 Jul 2023 14:33:30 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 4/8] ASoC: codecs: wcd938x: fix resource leaks on component remove
Date:   Wed,  5 Jul 2023 14:30:14 +0200
Message-Id: <20230705123018.30903-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230705123018.30903-1-johan+linaro@kernel.org>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to release allocated resources on component probe failure and
on remove.

This is specifically needed to allow probe deferrals of the sound card
which otherwise fails when reprobing the codec component:

    snd-sc8280xp sound: ASoC: failed to instantiate card -517
    genirq: Flags mismatch irq 289. 00002001 (HPHR PDM WD INT) vs. 00002001 (HPHR PDM WD INT)
    wcd938x_codec audio-codec: Failed to request HPHR WD interrupt (-16)
    genirq: Flags mismatch irq 290. 00002001 (HPHL PDM WD INT) vs. 00002001 (HPHL PDM WD INT)
    wcd938x_codec audio-codec: Failed to request HPHL WD interrupt (-16)
    genirq: Flags mismatch irq 291. 00002001 (AUX PDM WD INT) vs. 00002001 (AUX PDM WD INT)
    wcd938x_codec audio-codec: Failed to request Aux WD interrupt (-16)
    genirq: Flags mismatch irq 292. 00002001 (mbhc sw intr) vs. 00002001 (mbhc sw intr)
    wcd938x_codec audio-codec: Failed to request mbhc interrupts -16

Fixes: 8d78602aa87a ("ASoC: codecs: wcd938x: add basic driver")
Cc: stable@vger.kernel.org	# 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 55 +++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 2e342398d027..be38cad5f354 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2636,6 +2636,14 @@ static int wcd938x_mbhc_init(struct snd_soc_component *component)
 
 	return 0;
 }
+
+static void wcd938x_mbhc_deinit(struct snd_soc_component *component)
+{
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	wcd_mbhc_deinit(wcd938x->wcd_mbhc);
+}
+
 /* END MBHC */
 
 static const struct snd_kcontrol_new wcd938x_snd_controls[] = {
@@ -3131,20 +3139,26 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 	ret = request_threaded_irq(wcd938x->hphr_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "HPHR PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request HPHR WD interrupt (%d)\n", ret);
+		goto err_free_clsh_ctrl;
+	}
 
 	ret = request_threaded_irq(wcd938x->hphl_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "HPHL PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request HPHL WD interrupt (%d)\n", ret);
+		goto err_free_hphr_pdm_wd_int;
+	}
 
 	ret = request_threaded_irq(wcd938x->aux_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "AUX PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request Aux WD interrupt (%d)\n", ret);
+		goto err_free_hphl_pdm_wd_int;
+	}
 
 	/* Disable watchdog interrupt for HPH and AUX */
 	disable_irq_nosync(wcd938x->hphr_pdm_wd_int);
@@ -3159,7 +3173,7 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 			dev_err(component->dev,
 				"%s: Failed to add snd ctrls for variant: %d\n",
 				__func__, wcd938x->variant);
-			goto err;
+			goto err_free_aux_pdm_wd_int;
 		}
 		break;
 	case WCD9385:
@@ -3169,7 +3183,7 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 			dev_err(component->dev,
 				"%s: Failed to add snd ctrls for variant: %d\n",
 				__func__, wcd938x->variant);
-			goto err;
+			goto err_free_aux_pdm_wd_int;
 		}
 		break;
 	default:
@@ -3177,12 +3191,38 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 	}
 
 	ret = wcd938x_mbhc_init(component);
-	if (ret)
+	if (ret) {
 		dev_err(component->dev,  "mbhc initialization failed\n");
-err:
+		goto err_free_aux_pdm_wd_int;
+	}
+
+	return 0;
+
+err_free_aux_pdm_wd_int:
+	free_irq(wcd938x->aux_pdm_wd_int, wcd938x);
+err_free_hphl_pdm_wd_int:
+	free_irq(wcd938x->hphl_pdm_wd_int, wcd938x);
+err_free_hphr_pdm_wd_int:
+	free_irq(wcd938x->hphr_pdm_wd_int, wcd938x);
+err_free_clsh_ctrl:
+	wcd_clsh_ctrl_free(wcd938x->clsh_info);
+
 	return ret;
 }
 
+static void wcd938x_soc_codec_remove(struct snd_soc_component *component)
+{
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	wcd938x_mbhc_deinit(component);
+
+	free_irq(wcd938x->aux_pdm_wd_int, wcd938x);
+	free_irq(wcd938x->hphl_pdm_wd_int, wcd938x);
+	free_irq(wcd938x->hphr_pdm_wd_int, wcd938x);
+
+	wcd_clsh_ctrl_free(wcd938x->clsh_info);
+}
+
 static int wcd938x_codec_set_jack(struct snd_soc_component *comp,
 				  struct snd_soc_jack *jack, void *data)
 {
@@ -3199,6 +3239,7 @@ static int wcd938x_codec_set_jack(struct snd_soc_component *comp,
 static const struct snd_soc_component_driver soc_codec_dev_wcd938x = {
 	.name = "wcd938x_codec",
 	.probe = wcd938x_soc_codec_probe,
+	.remove = wcd938x_soc_codec_remove,
 	.controls = wcd938x_snd_controls,
 	.num_controls = ARRAY_SIZE(wcd938x_snd_controls),
 	.dapm_widgets = wcd938x_dapm_widgets,
-- 
2.39.3

