Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A366743D77
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjF3O1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjF3O1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:27:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1114935AF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D61B061771
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36E4C433CD;
        Fri, 30 Jun 2023 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688135238;
        bh=P6YVdCFm2ZOkpCnCJ7xlyVk9dprYs6KAI7jlHUrVE5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D424TjQiXcZcj4i/3v89N3a4BuqKXQtLcEZgEl+wCzeh7iNUv9wFPGkfd+0jwWfcF
         p4pMrS4+tXjRGn/TwKglozLY4ew3h/f+zgCLPdyKpxacvKwkQA1ab0X9/DTvw15rGy
         2SzNG29ZYSKYlrOtNDqgn3Y0WMNdqhEPRR3xPTg4Y9ZUzgjl1j7bPYSboYsYysFPHY
         +rMGkUb3Kg96Cul1BwADFXFtywQbLLUwaJUL0T0bS+qPNzIgEJz0lDRm/Sd5uu1olg
         04l1NbsWscLKr++r95aPcKmkuLf90puLbVydfB0tcAUzmSQeKxeFhputmq4UrPxsrk
         qBS6Ed5P+q0tA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qFF5p-0001OS-Ds; Fri, 30 Jun 2023 16:27:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/5] ASoC: codecs: wcd938x: use dev_printk() for impedance logging
Date:   Fri, 30 Jun 2023 16:27:15 +0200
Message-Id: <20230630142717.5314-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230630142717.5314-1-johan+linaro@kernel.org>
References: <20230630142717.5314-1-johan+linaro@kernel.org>
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

Pass the component structure also to the
wcd938x_mbhc_get_result_params() helper so that the component device can
be used for logging consistently.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 5ce15b622a91..ddefe4af0b1e 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2124,10 +2124,11 @@ static int wcd938x_mbhc_micb_ctrl_threshold_mic(struct snd_soc_component *compon
 	return wcd938x_mbhc_micb_adjust_voltage(component, micb_mv, MIC_BIAS_2);
 }
 
-static void wcd938x_mbhc_get_result_params(struct wcd938x_priv *wcd938x,
+static void wcd938x_mbhc_get_result_params(struct snd_soc_component *component,
 						s16 *d1_a, u16 noff,
 						int32_t *zdet)
 {
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
 	int i;
 	int val, val1;
 	s16 c1;
@@ -2154,8 +2155,8 @@ static void wcd938x_mbhc_get_result_params(struct wcd938x_priv *wcd938x,
 		usleep_range(5000, 5050);
 
 	if (!c1 || !x1) {
-		pr_err("%s: Impedance detect ramp error, c1=%d, x1=0x%x\n",
-			__func__, c1, x1);
+		dev_err(component->dev, "Impedance detect ramp error, c1=%d, x1=0x%x\n",
+			c1, x1);
 		goto ramp_down;
 	}
 	d1 = d1_a[c1];
@@ -2165,8 +2166,8 @@ static void wcd938x_mbhc_get_result_params(struct wcd938x_priv *wcd938x,
 	else if (x1 < minCode_param[noff])
 		*zdet = WCD938X_ZDET_FLOATING_IMPEDANCE;
 
-	pr_debug("%s: d1=%d, c1=%d, x1=0x%x, z_val=%d (milliohm)\n",
-		 __func__, d1, c1, x1, *zdet);
+	dev_dbg(component->dev, "%s: d1=%d, c1=%d, x1=0x%x, z_val=%d (milliohm)\n",
+		__func__, d1, c1, x1, *zdet);
 ramp_down:
 	i = 0;
 	while (x1) {
@@ -2210,7 +2211,7 @@ static void wcd938x_mbhc_zdet_ramp(struct snd_soc_component *component,
 			   WCD938X_ANA_MBHC_ZDET, 0x80, 0x80);
 	dev_dbg(component->dev, "%s: ramp for HPH_L, noff = %d\n",
 		__func__, zdet_param->noff);
-	wcd938x_mbhc_get_result_params(wcd938x, d1_a, zdet_param->noff, &zdet);
+	wcd938x_mbhc_get_result_params(component, d1_a, zdet_param->noff, &zdet);
 	regmap_update_bits(wcd938x->regmap,
 			   WCD938X_ANA_MBHC_ZDET, 0x80, 0x00);
 
@@ -2224,7 +2225,7 @@ static void wcd938x_mbhc_zdet_ramp(struct snd_soc_component *component,
 			   WCD938X_ANA_MBHC_ZDET, 0x40, 0x40);
 	dev_dbg(component->dev, "%s: ramp for HPH_R, noff = %d\n",
 		__func__, zdet_param->noff);
-	wcd938x_mbhc_get_result_params(wcd938x, d1_a, zdet_param->noff, &zdet);
+	wcd938x_mbhc_get_result_params(component, d1_a, zdet_param->noff, &zdet);
 	regmap_update_bits(wcd938x->regmap,
 			   WCD938X_ANA_MBHC_ZDET, 0x40, 0x00);
 
-- 
2.39.3

