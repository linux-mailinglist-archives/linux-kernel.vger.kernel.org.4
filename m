Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15FA74843F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjGEMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjGEMdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:33:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F7D116;
        Wed,  5 Jul 2023 05:33:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB2D261572;
        Wed,  5 Jul 2023 12:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD18FC433BA;
        Wed,  5 Jul 2023 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688560389;
        bh=wn7CUVVxrOWOl0kh/DRq8DJmjTUPwwGVXxwtuxE9kBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQteiVQr2zXXSIJZcGhyLp5bdPktNo1wKcXW3iBcr+scNrD/ATzB0mxiv3vtz+BP9
         yje/CvC2ZTg7hw4yGVsFgYiDAo359/q8VtCtNmChWwB40JlIsdfKapL0ad+VCRTRQR
         t7FAvlZw7kQwXBhHJ2KmJTYsvjCLsE+nUXwRAsVxAws4EJ5UsB4Hy6kgf6K1Hj3fji
         +amjTqFZpYjvb1JwZoTGDEqi1cBJilYsGkf78KdOR5kSnYli+gJTvolNm7nMA+sWbo
         h6tD2W/u+n2VZeUC+zj5kNSp7qDd0T9kR6P0jmpq9CsS4sbyDF8kKmsFORlaakEIe+
         Cy29u0las/GsQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qH1hK-00084J-1l;
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
Subject: [PATCH 6/8] ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove
Date:   Wed,  5 Jul 2023 14:30:16 +0200
Message-Id: <20230705123018.30903-7-johan+linaro@kernel.org>
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

The MBHC resources must be released on component probe failure and
removal so can not be tied to the lifetime of the component device.

This is specifically needed to allow probe deferrals of the sound card
which otherwise fails when reprobing the codec component:

    snd-sc8280xp sound: ASoC: failed to instantiate card -517
    genirq: Flags mismatch irq 299. 00002001 (mbhc sw intr) vs. 00002001 (mbhc sw intr)
    wcd938x_codec audio-codec: Failed to request mbhc interrupts -16
    wcd938x_codec audio-codec: mbhc initialization failed
    wcd938x_codec audio-codec: ASoC: error at snd_soc_component_probe on audio-codec: -16
    snd-sc8280xp sound: ASoC: failed to instantiate card -16

Fixes: 0e5c9e7ff899 ("ASoC: codecs: wcd: add multi button Headset detection support")
Cc: stable@vger.kernel.org      # 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 57 ++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 1911750f7445..5da1934527f3 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -1454,7 +1454,7 @@ struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 		return ERR_PTR(-EINVAL);
 	}
 
-	mbhc = devm_kzalloc(dev, sizeof(*mbhc), GFP_KERNEL);
+	mbhc = kzalloc(sizeof(*mbhc), GFP_KERNEL);
 	if (!mbhc)
 		return ERR_PTR(-ENOMEM);
 
@@ -1474,61 +1474,76 @@ struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 
 	INIT_WORK(&mbhc->correct_plug_swch, wcd_correct_swch_plug);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_sw_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_sw_intr, NULL,
 					wcd_mbhc_mech_plug_detect_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"mbhc sw intr", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_mbhc;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_btn_press_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_btn_press_intr, NULL,
 					wcd_mbhc_btn_press_handler,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Button Press detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_sw_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_btn_release_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_btn_release_intr, NULL,
 					wcd_mbhc_btn_release_handler,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Button Release detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_btn_press_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_hs_ins_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_hs_ins_intr, NULL,
 					wcd_mbhc_adc_hs_ins_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Elect Insert", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_btn_release_intr;
 
 	disable_irq_nosync(mbhc->intr_ids->mbhc_hs_ins_intr);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_hs_rem_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_hs_rem_intr, NULL,
 					wcd_mbhc_adc_hs_rem_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Elect Remove", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hs_ins_intr;
 
 	disable_irq_nosync(mbhc->intr_ids->mbhc_hs_rem_intr);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->hph_left_ocp, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->hph_left_ocp, NULL,
 					wcd_mbhc_hphl_ocp_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"HPH_L OCP detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hs_rem_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->hph_right_ocp, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->hph_right_ocp, NULL,
 					wcd_mbhc_hphr_ocp_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"HPH_R OCP detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hph_left_ocp;
 
 	return mbhc;
-err:
+
+err_free_hph_left_ocp:
+	free_irq(mbhc->intr_ids->hph_left_ocp, mbhc);
+err_free_hs_rem_intr:
+	free_irq(mbhc->intr_ids->mbhc_hs_rem_intr, mbhc);
+err_free_hs_ins_intr:
+	free_irq(mbhc->intr_ids->mbhc_hs_ins_intr, mbhc);
+err_free_btn_release_intr:
+	free_irq(mbhc->intr_ids->mbhc_btn_release_intr, mbhc);
+err_free_btn_press_intr:
+	free_irq(mbhc->intr_ids->mbhc_btn_press_intr, mbhc);
+err_free_sw_intr:
+	free_irq(mbhc->intr_ids->mbhc_sw_intr, mbhc);
+err_free_mbhc:
+	kfree(mbhc);
+
 	dev_err(dev, "Failed to request mbhc interrupts %d\n", ret);
 
 	return ERR_PTR(ret);
@@ -1537,9 +1552,19 @@ EXPORT_SYMBOL(wcd_mbhc_init);
 
 void wcd_mbhc_deinit(struct wcd_mbhc *mbhc)
 {
+	free_irq(mbhc->intr_ids->hph_right_ocp, mbhc);
+	free_irq(mbhc->intr_ids->hph_left_ocp, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_hs_rem_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_hs_ins_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_btn_release_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_btn_press_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_sw_intr, mbhc);
+
 	mutex_lock(&mbhc->lock);
 	wcd_cancel_hs_detect_plug(mbhc,	&mbhc->correct_plug_swch);
 	mutex_unlock(&mbhc->lock);
+
+	kfree(mbhc);
 }
 EXPORT_SYMBOL(wcd_mbhc_deinit);
 
-- 
2.39.3

