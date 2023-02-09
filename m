Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB306908C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBIM2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBIM2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:28:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112A3126D8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:28:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d14so1574439wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdgbNuhnuI8HvGFss/JHz5QrLG7sfZSeSJMIaBHo/bk=;
        b=QJVTqSRdqqHcybqhGKd2Rfv9F2xEWixeuwVkVGwpshvwk/g848tUi0Tnis3ZZPWjWV
         6Uy+gztl/cYhIirToJICkm5iwqJYu/Uk85Q15oUO6TjGoexpBWWIy1trXUCg7Ynh46Ku
         t/Qkd/tQhXlzuF43Oqd24cCfB/nMbl3CCCqJFaU/U1CWygEnXA+1F2esIadvmGjC2o1e
         MBGndlLA5y0/4A6mQ9+piQKENLzl3YM0lVIF3lZdPskfaTS8IuqVw2espMWsccbBEfc2
         oiGb/P7q7J9IzWau5/7x0jw+TWoH2Nvpo0RxUUMKnuArv9rj1EMfl2khyTzwD+VxJHLj
         R0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdgbNuhnuI8HvGFss/JHz5QrLG7sfZSeSJMIaBHo/bk=;
        b=kPenOZ1ZfOMVzC8Yy0ysLbEsmwoNXWFgxJ7FKSMmXFvSVr+fSGP1mOm06CvVvXwfuS
         8zvmrT1qBHDdD52N/Lc1uvv65vmWkJYpJulAl9t6xFtSqN9U8LwLOhcsIXDcMLkHHTpg
         q+NvLoL42s3EBlyYmnawPDcXU+n7m5rCbly94qEAw8z4umRAOVt5o6OCGCdCKnehRRQ4
         xH6QlpEaRPRMS9WMmtM7iTXhmN3yKPucAG9bvHvufGyRziNtXdvzbXYBvX2YIHMU3iuc
         3j+d21YDyUFfdELYupQWCJCoB66MVOZxh09R8eGaJIG0rm2xdnzOde6r9BXP17ugJtZ1
         3UFw==
X-Gm-Message-State: AO0yUKVNdIxdCj6GJVEYd3GLbYruCdO0gp/n0rYhQ3JihtvzNJcdC1IF
        AJ4PQ28LOjZUCumeljwcH91DaA==
X-Google-Smtp-Source: AK7set/t5oKzjlWyATb/30pIVAqCDe9grRBKvQ8EXy0hhIFD0gb2WbEgVKamQN6iPJkux3DL11JsNQ==
X-Received: by 2002:a5d:4806:0:b0:2c3:ea6b:ef83 with SMTP id l6-20020a5d4806000000b002c3ea6bef83mr11677540wrq.12.1675945701608;
        Thu, 09 Feb 2023 04:28:21 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d58c8000000b002c3f0a4ce98sm1134763wrf.98.2023.02.09.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 04:28:20 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/8] ASoC: codecs: lpass: register mclk after runtime pm
Date:   Thu,  9 Feb 2023 12:28:03 +0000
Message-Id: <20230209122806.18923-6-srinivas.kandagatla@linaro.org>
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

move mclk out registration after runtime pm is enabled so that the
clk framework can resume the codec if it requires to enable the mclk out.

Fixes: c96baa2949b2 ("ASoC: codecs: wsa-macro: add runtime pm support")
Fixes: 72ad25eabda0 ("ASoC: codecs: va-macro: add runtime pm support")
Fixes: 366ff79ed539 ("ASoC: codecs: rx-macro: add runtime pm support")
Fixes: 1fb83bc5cf64 ("ASoC: codecs: tx-macro: add runtime pm support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c  |  8 ++++----
 sound/soc/codecs/lpass-tx-macro.c  |  8 ++++----
 sound/soc/codecs/lpass-va-macro.c  | 20 ++++++++++----------
 sound/soc/codecs/lpass-wsa-macro.c |  9 ++++-----
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index a9ef9d5ffcc5..dd6970d5eb8d 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3601,10 +3601,6 @@ static int rx_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_fsgen;
 
-	ret = rx_macro_register_mclk_output(rx);
-	if (ret)
-		goto err_clkout;
-
 	ret = devm_snd_soc_register_component(dev, &rx_macro_component_drv,
 					      rx_macro_dai,
 					      ARRAY_SIZE(rx_macro_dai));
@@ -3618,6 +3614,10 @@ static int rx_macro_probe(struct platform_device *pdev)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
+	ret = rx_macro_register_mclk_output(rx);
+	if (ret)
+		goto err_clkout;
+
 	return 0;
 
 err_clkout:
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 2ef62d6edc30..b9475ba55e20 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2036,10 +2036,6 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_fsgen;
 
-	ret = tx_macro_register_mclk_output(tx);
-	if (ret)
-		goto err_clkout;
-
 	ret = devm_snd_soc_register_component(dev, &tx_macro_component_drv,
 					      tx_macro_dai,
 					      ARRAY_SIZE(tx_macro_dai));
@@ -2052,6 +2048,10 @@ static int tx_macro_probe(struct platform_device *pdev)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
+	ret = tx_macro_register_mclk_output(tx);
+	if (ret)
+		goto err_clkout;
+
 	return 0;
 
 err_clkout:
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index b0b6cf29cba3..1623ba78ddb3 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1524,16 +1524,6 @@ static int va_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_mclk;
 
-	ret = va_macro_register_fsgen_output(va);
-	if (ret)
-		goto err_clkout;
-
-	va->fsgen = clk_hw_get_clk(&va->hw, "fsgen");
-	if (IS_ERR(va->fsgen)) {
-		ret = PTR_ERR(va->fsgen);
-		goto err_clkout;
-	}
-
 	if (va->has_swr_master) {
 		/* Set default CLK div to 1 */
 		regmap_update_bits(va->regmap, CDC_VA_TOP_CSR_SWR_MIC_CTL0,
@@ -1560,6 +1550,16 @@ static int va_macro_probe(struct platform_device *pdev)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
+	ret = va_macro_register_fsgen_output(va);
+	if (ret)
+		goto err_clkout;
+
+	va->fsgen = clk_hw_get_clk(&va->hw, "fsgen");
+	if (IS_ERR(va->fsgen)) {
+		ret = PTR_ERR(va->fsgen);
+		goto err_clkout;
+	}
+
 	return 0;
 
 err_clkout:
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 5cfe96f6e430..c0b86d69c72e 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2451,11 +2451,6 @@ static int wsa_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_fsgen;
 
-	ret = wsa_macro_register_mclk_output(wsa);
-	if (ret)
-		goto err_clkout;
-
-
 	ret = devm_snd_soc_register_component(dev, &wsa_macro_component_drv,
 					      wsa_macro_dai,
 					      ARRAY_SIZE(wsa_macro_dai));
@@ -2468,6 +2463,10 @@ static int wsa_macro_probe(struct platform_device *pdev)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
+	ret = wsa_macro_register_mclk_output(wsa);
+	if (ret)
+		goto err_clkout;
+
 	return 0;
 
 err_clkout:
-- 
2.21.0

