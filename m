Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A206B70AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCMH6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCMH4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:56:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B62332A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:55:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id da10so45015316edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678694096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOLvETKr12gRLc+dvhlTcgF5sZT1MDYlJ7/1TcrZo+s=;
        b=xX3qQEzKsx+66gUd9XUqSf+Hr3CrB+H3JRf2p/Bmux8hAn+1seNR30FiLO+tvVNjjT
         dYu2zDTTinQboVoKJJlwxoG7lpfTznDpl2OW10swf6CsFGfyqD9tdkAUeETVE4Khrf+T
         p8Y9OXF6UauCT946HCrYP9dTl+DO4Lg+mWzVzAUUtCcd07vWBo6NUMQ/POE1FTodUAXs
         nhSfJkJM1UtDvLRRsepvRdIBOMAblHSZNJBLnRTFwlPQEQ3gwAAF5tX5EbfyxYoVxdgi
         /w8joUS3ke3litcNtUppzn4mXShN2gSZ+rADO+15Lk+Ig0OX98ihAZphj13gwdounQGJ
         BH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678694096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOLvETKr12gRLc+dvhlTcgF5sZT1MDYlJ7/1TcrZo+s=;
        b=y494Oylf6TvNhlxXvtuNETFfeIosm2NHEepAh5ix1J68Qc+zjrQgCm7LImQAw0fjTX
         3k1xI8SvXz2X06PZPj9/U11G7ZLxN5K0TgLI/wka4do4+ws+ScD7oJKyfb0Z6UBNscW1
         0wgEGAR/7yNNCUTYZ+E5aKtmIcgQLyhzctlo7w6RfwkzylCbdNwErLh0VGnGEK/kXWie
         ShOWJvwP/QELI7JY76sgzFaCZ5cSc4M0am2y6XFpTJ5oHw5fZ/RX2+em278cv2JE67yI
         ceHV6KcDMtah6vGdPLnLC2FHBdprkfwt1BpYh6bArWCIrwapdFKH5S7X6rVLTNkY+sBD
         sW8Q==
X-Gm-Message-State: AO0yUKXKTwVv1uCxi+DGOTYfFKXU36O/3/3DtGBoieuxVjKQ42vo3sYN
        elngULsJCs9ZfMAf8ryk9TgoOg==
X-Google-Smtp-Source: AK7set+GlczbPPP4+2pS69wk1xnY0+UkBHHrd9kySDYK81vNV7l/lZEbo7WewH5iME+BbG0DmGOT6w==
X-Received: by 2002:a17:906:1604:b0:879:bff:55c with SMTP id m4-20020a170906160400b008790bff055cmr6271106ejd.1.1678694096626;
        Mon, 13 Mar 2023 00:54:56 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709061c8700b008b980c3e013sm3146943ejh.179.2023.03.13.00.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 00:54:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 6/9] ASoC: codecs: lpass-tx-macro: add support for SM8550
Date:   Mon, 13 Mar 2023 08:54:42 +0100
Message-Id: <20230313075445.17160-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the TX macro codec on Qualcomm SM8550.  SM8550 does not
use NPL clock, thus add flags allowing to skip it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

---

Changes since v1:
1. Move the flag define to common header
---
 sound/soc/codecs/lpass-tx-macro.c | 35 ++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 473d3cd39554..a01a35f2e471 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1915,7 +1915,10 @@ static int tx_macro_register_mclk_output(struct tx_macro *tx)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(tx->npl);
+	if (tx->npl)
+		parent_clk_name = __clk_get_name(tx->npl);
+	else
+		parent_clk_name = __clk_get_name(tx->mclk);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
@@ -1946,10 +1949,13 @@ static int tx_macro_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	kernel_ulong_t flags;
 	struct tx_macro *tx;
 	void __iomem *base;
 	int ret, reg;
 
+	flags = (kernel_ulong_t)device_get_match_data(dev);
+
 	tx = devm_kzalloc(dev, sizeof(*tx), GFP_KERNEL);
 	if (!tx)
 		return -ENOMEM;
@@ -1966,9 +1972,11 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(tx->mclk))
 		return PTR_ERR(tx->mclk);
 
-	tx->npl = devm_clk_get(dev, "npl");
-	if (IS_ERR(tx->npl))
-		return PTR_ERR(tx->npl);
+	if (flags & LPASS_MACRO_FLAG_HAS_NPL_CLOCK) {
+		tx->npl = devm_clk_get(dev, "npl");
+		if (IS_ERR(tx->npl))
+			return PTR_ERR(tx->npl);
+	}
 
 	tx->fsgen = devm_clk_get(dev, "fsgen");
 	if (IS_ERR(tx->fsgen))
@@ -2145,10 +2153,21 @@ static const struct dev_pm_ops tx_macro_pm_ops = {
 };
 
 static const struct of_device_id tx_macro_dt_match[] = {
-	{ .compatible = "qcom,sc7280-lpass-tx-macro" },
-	{ .compatible = "qcom,sm8250-lpass-tx-macro" },
-	{ .compatible = "qcom,sm8450-lpass-tx-macro" },
-	{ .compatible = "qcom,sc8280xp-lpass-tx-macro" },
+	{
+		.compatible = "qcom,sc7280-lpass-tx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+	}, {
+		.compatible = "qcom,sm8250-lpass-tx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+	}, {
+		.compatible = "qcom,sm8450-lpass-tx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+	}, {
+		.compatible = "qcom,sm8550-lpass-tx-macro",
+	}, {
+		.compatible = "qcom,sc8280xp-lpass-tx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tx_macro_dt_match);
-- 
2.34.1

