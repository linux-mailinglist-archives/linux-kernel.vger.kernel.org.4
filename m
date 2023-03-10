Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA416B403D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjCJNWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCJNWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:22:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3AFAD7A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id k10so20235970edk.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678454527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rto2D5OftYK1ID57dBSGS4QnEMib23DRCG76xg1zNII=;
        b=EckjYIrE4DJhMp6xe6dqYs9joBiyI1ngPyS/0OY9GgOP2nTQbi+9ZebR+rNljPuG36
         F/SyIj/rGDkrmCfzmx3Wg9DE/aVxU/s9cDsnSlyRpYEGL+KbGPIpmitQLhPyZNnryIyU
         6zwGgeGjcbTfKLAiqbdnwJzQvJN82nFfO6MY+2NjScneBbpLX1sRNJBvP1OIkffYoVxa
         XAVB8JDDrtlaz8FpxsLLA/2mjiJOJ2uHc62ToAcxhEIOQuT4VTRx55ZRE5DFxEqCQt1h
         ripnr9yzUtuZMAWmvBV/6gNz9XDXf/k01ARRcA+So1FaTcFAVzNrxd6FNTXiJQlbKTBo
         3aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678454527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rto2D5OftYK1ID57dBSGS4QnEMib23DRCG76xg1zNII=;
        b=FQXkGnCeXnPpEgU5TyzyeiYWP4S24nGdkoN2Hfzt6jpyRj8ye9vqiQYIDQmF1jQS4n
         JN83s51IRpZytHsiui/98tSGIl3e0ZlsuUIuNmwnCehqD6Bg9/1NkMAh/BevLXeALfvp
         prQrD+iPN09IOIQj/wmch71CA8ca04Aibfm7i3oXzXCIm3QCqjDq+k2eyYLYCDQgsPrW
         HeXj5KtryuV40ReMDtxiL3tABncFUW4XC1CgsvUARQIw7wc43viW2gKKe/p5YZzRgL6C
         tx47UJZfR8q6N3SjPjErTgsQG9kTsvLjyoHmPX7yL7iJ6B278iX28r7JmlLc2KdL1yTl
         We7g==
X-Gm-Message-State: AO0yUKU5lhkJ7bK1PoZVOYO/yi0DB3s+BdiR4ljw36MAJ32gMg1Addz1
        I8Z4T0RkH3nUzqoNwSLDwTt2Mw==
X-Google-Smtp-Source: AK7set+O3ImPHzDIFLhFK5/g1q7pHfzB69yohRjQEKyKjOzXBvIq6vsr/mv67mV4NXtNeqiTtWIRJw==
X-Received: by 2002:a17:906:2bc2:b0:8b1:7de3:cfb4 with SMTP id n2-20020a1709062bc200b008b17de3cfb4mr24517931ejg.4.1678454527437;
        Fri, 10 Mar 2023 05:22:07 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:45c4:46be:ec71:4a51])
        by smtp.gmail.com with ESMTPSA id zc4-20020a170906988400b008b17879ec95sm959124ejb.22.2023.03.10.05.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 05:22:07 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/9] ASoC: codecs: lpass-rx-macro: add support for SM8550
Date:   Fri, 10 Mar 2023 14:21:55 +0100
Message-Id: <20230310132201.322148-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310132201.322148-1-krzysztof.kozlowski@linaro.org>
References: <20230310132201.322148-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RX macro codec on Qualcomm SM8550.  SM8550 does not
use NPL clock, thus add flags allowing to skip it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 39 ++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index a73a7d7a1c0a..e322d918db36 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -395,6 +395,9 @@
 #define COMP_MAX_COEFF 25
 #define RX_NUM_CLKS_MAX	5
 
+/* NPL clock is expected */
+#define RX_MACRO_FLAG_HAS_NPL_CLOCK		BIT(0)
+
 struct comp_coeff_val {
 	u8 lsb;
 	u8 msb;
@@ -3491,7 +3494,10 @@ static int rx_macro_register_mclk_output(struct rx_macro *rx)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(rx->npl);
+	if (rx->npl)
+		parent_clk_name = __clk_get_name(rx->npl);
+	else
+		parent_clk_name = __clk_get_name(rx->mclk);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
@@ -3521,10 +3527,13 @@ static const struct snd_soc_component_driver rx_macro_component_drv = {
 static int rx_macro_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	kernel_ulong_t flags;
 	struct rx_macro *rx;
 	void __iomem *base;
 	int ret;
 
+	flags = (kernel_ulong_t)device_get_match_data(dev);
+
 	rx = devm_kzalloc(dev, sizeof(*rx), GFP_KERNEL);
 	if (!rx)
 		return -ENOMEM;
@@ -3541,9 +3550,11 @@ static int rx_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(rx->mclk))
 		return PTR_ERR(rx->mclk);
 
-	rx->npl = devm_clk_get(dev, "npl");
-	if (IS_ERR(rx->npl))
-		return PTR_ERR(rx->npl);
+	if (flags & RX_MACRO_FLAG_HAS_NPL_CLOCK) {
+		rx->npl = devm_clk_get(dev, "npl");
+		if (IS_ERR(rx->npl))
+			return PTR_ERR(rx->npl);
+	}
 
 	rx->fsgen = devm_clk_get(dev, "fsgen");
 	if (IS_ERR(rx->fsgen))
@@ -3655,10 +3666,22 @@ static int rx_macro_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id rx_macro_dt_match[] = {
-	{ .compatible = "qcom,sc7280-lpass-rx-macro" },
-	{ .compatible = "qcom,sm8250-lpass-rx-macro" },
-	{ .compatible = "qcom,sm8450-lpass-rx-macro" },
-	{ .compatible = "qcom,sc8280xp-lpass-rx-macro" },
+	{
+		.compatible = "qcom,sc7280-lpass-rx-macro",
+		.data = (void *)RX_MACRO_FLAG_HAS_NPL_CLOCK,
+
+	}, {
+		.compatible = "qcom,sm8250-lpass-rx-macro",
+		.data = (void *)RX_MACRO_FLAG_HAS_NPL_CLOCK,
+	}, {
+		.compatible = "qcom,sm8450-lpass-rx-macro",
+		.data = (void *)RX_MACRO_FLAG_HAS_NPL_CLOCK,
+	}, {
+		.compatible = "qcom,sm8550-lpass-rx-macro",
+	}, {
+		.compatible = "qcom,sc8280xp-lpass-rx-macro",
+		.data = (void *)RX_MACRO_FLAG_HAS_NPL_CLOCK,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rx_macro_dt_match);
-- 
2.34.1

