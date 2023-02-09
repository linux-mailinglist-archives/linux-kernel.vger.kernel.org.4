Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029AC6908C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBIM25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjBIM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:28:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B2D126D8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:28:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bu23so1580402wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J51vgEiaGDFuktVhqlKRRMFvlVjeM/+eUZ5W699kLE=;
        b=PCfXqvb3MXz9ybFoUWSj+AwWp6shrqNt6lrisz1CJ06Pu1nc06PNM6j7c1p3el6waP
         DRep5qrA1ntjZjOdNZQnprm6kQxDwh0y94km9LhmJM1RO0ZogRWTiV804fSD2xG0RClk
         KzrORVI0GK1tr4aT0hCXze+8h+VB8TDSB7XPJNXHw5GYU2NCFB4yhznTupkujEafaMfU
         f8GzjGIdgr1aidZBrvgEUA+5dlFtRTcEodCRa9H7KBGTQFESbeyCoyWdNsDxqqUu0zDr
         s740OJiPuhnvOgv/ezTuYpdKiq3vlgfjhEdoTf8j5h3IGUF1S/Je0XqnHmM9opsTmq1c
         llag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J51vgEiaGDFuktVhqlKRRMFvlVjeM/+eUZ5W699kLE=;
        b=Q4o5G3LVXzuAkcIddaWE1UdgPBBQKHEdNaqyHpMNHHBRzFGPfq94/5D0OP4LpbB1dl
         en831egVMfuRqPHfwc/7MI1SJQPziLyB6j2LLEVHjUD4NRgFvJ2n15ae5Z3icxrI7XEv
         7/ZMrGsAOp2jHLhmXbT5duXXr0IFo9hp//5zyzzSajmKl9iQu0GdjM+84XHQL4BgGsET
         vMb7BZQgUwtTR6NjqUCIz/0bfZIkGE5Km9ETVsliGbXcrGnt+ApLzJO9w00kUHz+4Ml5
         XDrs2lpp+PVYVdxnxGayNytbxpsIzGZYvq/mGqTPkkCEZu/vguQPhX0WTXBJDHC+fpp9
         vEhw==
X-Gm-Message-State: AO0yUKVSqCVn51nsev4Z+yLpD4kC7seeehzWOTgr6XY9a10XfdBERHd4
        AdKAJmL+P3ZV9W+lpAliYQSZCg==
X-Google-Smtp-Source: AK7set9QM8rbKi5vOkMNBtMwGWLwHFGtB8wtqa0h5tKacfZJtbjGLCCwmC2fxY1Wk+DKhMpVLsp5ZQ==
X-Received: by 2002:adf:f18a:0:b0:2c3:24f3:8b47 with SMTP id h10-20020adff18a000000b002c324f38b47mr11669836wro.31.1675945704133;
        Thu, 09 Feb 2023 04:28:24 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d58c8000000b002c3f0a4ce98sm1134763wrf.98.2023.02.09.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 04:28:23 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/8] ASoC: codecs: lpass: do not reset soundwire block on clk enable
Date:   Thu,  9 Feb 2023 12:28:05 +0000
Message-Id: <20230209122806.18923-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
References: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
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

resetting soundwire block will put the slaves out of sync and result
in re-enumeration during fsgen disable/enable path this is totally
unnecessary and resulting fifo overflows.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c  | 17 +++++++++++------
 sound/soc/codecs/lpass-tx-macro.c  | 15 ++++++++++-----
 sound/soc/codecs/lpass-va-macro.c  | 23 ++++++++++++-----------
 sound/soc/codecs/lpass-wsa-macro.c | 18 +++++++++++-------
 4 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 8621cfabcf5b..e0d891a67a12 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3441,16 +3441,10 @@ static int swclk_gate_enable(struct clk_hw *hw)
 	}
 
 	rx_macro_mclk_enable(rx, true);
-	regmap_update_bits(rx->regmap, CDC_RX_CLK_RST_CTRL_SWR_CONTROL,
-			   CDC_RX_SWR_RESET_MASK,
-			   CDC_RX_SWR_RESET);
 
 	regmap_update_bits(rx->regmap, CDC_RX_CLK_RST_CTRL_SWR_CONTROL,
 			   CDC_RX_SWR_CLK_EN_MASK, 1);
 
-	regmap_update_bits(rx->regmap, CDC_RX_CLK_RST_CTRL_SWR_CONTROL,
-			   CDC_RX_SWR_RESET_MASK, 0);
-
 	return 0;
 }
 
@@ -3601,6 +3595,17 @@ static int rx_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_fsgen;
 
+	/* reset swr block  */
+	regmap_update_bits(rx->regmap, CDC_RX_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_RX_SWR_RESET_MASK,
+			   CDC_RX_SWR_RESET);
+
+	regmap_update_bits(rx->regmap, CDC_RX_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_RX_SWR_CLK_EN_MASK, 1);
+
+	regmap_update_bits(rx->regmap, CDC_RX_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_RX_SWR_RESET_MASK, 0);
+
 	ret = devm_snd_soc_register_component(dev, &rx_macro_component_drv,
 					      rx_macro_dai,
 					      ARRAY_SIZE(rx_macro_dai));
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 2449a2df66df..bf27bdd5be20 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1861,15 +1861,10 @@ static int swclk_gate_enable(struct clk_hw *hw)
 	}
 
 	tx_macro_mclk_enable(tx, true);
-	regmap_update_bits(regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
-			   CDC_TX_SWR_RESET_MASK, CDC_TX_SWR_RESET_ENABLE);
 
 	regmap_update_bits(regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
 			   CDC_TX_SWR_CLK_EN_MASK,
 			   CDC_TX_SWR_CLK_ENABLE);
-	regmap_update_bits(regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
-			   CDC_TX_SWR_RESET_MASK, 0x0);
-
 	return 0;
 }
 
@@ -2036,6 +2031,16 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_fsgen;
 
+	/* reset soundwire block */
+	regmap_update_bits(tx->regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_TX_SWR_RESET_MASK, CDC_TX_SWR_RESET_ENABLE);
+
+	regmap_update_bits(tx->regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_TX_SWR_CLK_EN_MASK,
+			   CDC_TX_SWR_CLK_ENABLE);
+	regmap_update_bits(tx->regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_TX_SWR_RESET_MASK, 0x0);
+
 	ret = devm_snd_soc_register_component(dev, &tx_macro_component_drv,
 					      tx_macro_dai,
 					      ARRAY_SIZE(tx_macro_dai));
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 1623ba78ddb3..fd62817d29a0 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1333,17 +1333,9 @@ static int fsgen_gate_enable(struct clk_hw *hw)
 	int ret;
 
 	ret = va_macro_mclk_enable(va, true);
-	if (!va->has_swr_master)
-		return ret;
-
-	regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
-			   CDC_VA_SWR_RESET_MASK,  CDC_VA_SWR_RESET_ENABLE);
-
-	regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
-			   CDC_VA_SWR_CLK_EN_MASK,
-			   CDC_VA_SWR_CLK_ENABLE);
-	regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
-			   CDC_VA_SWR_RESET_MASK, 0x0);
+	if (va->has_swr_master)
+		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
+				   CDC_VA_SWR_CLK_EN_MASK, CDC_VA_SWR_CLK_ENABLE);
 
 	return ret;
 }
@@ -1538,6 +1530,15 @@ static int va_macro_probe(struct platform_device *pdev)
 
 	}
 
+	if (va->has_swr_master) {
+		regmap_update_bits(va->regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
+				   CDC_VA_SWR_RESET_MASK,  CDC_VA_SWR_RESET_ENABLE);
+		regmap_update_bits(va->regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
+				   CDC_VA_SWR_CLK_EN_MASK, CDC_VA_SWR_CLK_ENABLE);
+		regmap_update_bits(va->regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
+				   CDC_VA_SWR_RESET_MASK, 0x0);
+	}
+
 	ret = devm_snd_soc_register_component(dev, &va_macro_component_drv,
 					      va_macro_dais,
 					      ARRAY_SIZE(va_macro_dais));
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index c0b86d69c72e..e6b85f3692ac 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2270,17 +2270,10 @@ static int wsa_swrm_clock(struct wsa_macro *wsa, bool enable)
 		}
 		wsa_macro_mclk_enable(wsa, true);
 
-		/* reset swr ip */
-		regmap_update_bits(regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
-				   CDC_WSA_SWR_RST_EN_MASK, CDC_WSA_SWR_RST_ENABLE);
-
 		regmap_update_bits(regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
 				   CDC_WSA_SWR_CLK_EN_MASK,
 				   CDC_WSA_SWR_CLK_ENABLE);
 
-		/* Bring out of reset */
-		regmap_update_bits(regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
-				   CDC_WSA_SWR_RST_EN_MASK, CDC_WSA_SWR_RST_DISABLE);
 	} else {
 		regmap_update_bits(regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
 				   CDC_WSA_SWR_CLK_EN_MASK, 0);
@@ -2451,6 +2444,17 @@ static int wsa_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_fsgen;
 
+	/* reset swr ip */
+	regmap_update_bits(wsa->regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_WSA_SWR_RST_EN_MASK, CDC_WSA_SWR_RST_ENABLE);
+
+	regmap_update_bits(wsa->regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_WSA_SWR_CLK_EN_MASK, CDC_WSA_SWR_CLK_ENABLE);
+
+	/* Bring out of reset */
+	regmap_update_bits(wsa->regmap, CDC_WSA_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_WSA_SWR_RST_EN_MASK, CDC_WSA_SWR_RST_DISABLE);
+
 	ret = devm_snd_soc_register_component(dev, &wsa_macro_component_drv,
 					      wsa_macro_dai,
 					      ARRAY_SIZE(wsa_macro_dai));
-- 
2.21.0

