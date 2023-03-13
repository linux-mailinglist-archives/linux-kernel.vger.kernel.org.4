Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4539C6B7099
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCMH5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCMH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:56:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6C61516B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:55:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so15454264edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678694093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYNVVvk5MYQJLcGCKlZ/3nxpCpW/KOAolH/I1VmRq1M=;
        b=cm6jvEBYoy8FtI9jVa4wcNUNcS0EPBarIeNL4EtUigouIMM/5ZX6a0HCtLQzmdjsi1
         GXHeXCdAWpy4ru2ygJchKm04DfdGPDOyPbo5cL7HRRp4VFvGod2wUzCWPjUBrM9nwdtc
         g15ylGyBV4EKeJ08kXKZOl0cmVsyS7B2OtXqbnVTBtgw0KKU6E4A/GpKsS5JwMHx0Dj8
         Tj3U/JbCfpCiWjDQ1CuwUSgDxMBI+OSIJNSTAA9eTDiNxjHn7ARrhZDLmasMjPjGqsSc
         19e+vdxj8Gdegq6zR9owK4F6o4WDYJ69+utN1B+fjPWJY5qNwQxAh+5oijkkRt6vVjt2
         FHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678694093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYNVVvk5MYQJLcGCKlZ/3nxpCpW/KOAolH/I1VmRq1M=;
        b=pMPXYyghh884hnF8XTek0iGsN96kcLfPL2sUCPwuKd78CjdG1rQOvo10mBUb2yAiL9
         JPe8MPfp4gs7C3f5ZXSj3RfCLQLbRPF8bNwhIyk+IVNkjZUn0WlqJ4cWjxJvNPAh3N8b
         SgqHMUD0PqpHRhsPiOhCs0ZkNXePEQYWzHb1bf1FHY7fmetwCB2TryGiKEeuIvVC3hX7
         F41PdZTGJN1T4g8vr+1gdJ08/6tVZkSkFjofUIjRDcT+/suJgX2zX8jx1sOhDPbzLxaI
         a9uhxTWpPxcpHqXd4PiMm9oz8BCooS5UoZKigiS8B8ez09+grj7Nn3heZfYla219v/24
         MwyQ==
X-Gm-Message-State: AO0yUKWqHI9hFYDtuFmXXXJv3wQFJ0cMKk+fxEMcNi086iMraHpVmhhE
        1C56HC0SbveCfMNsonwxOFBX1g==
X-Google-Smtp-Source: AK7set8WfbTprk60wBZoVW3YeYQ44X9CgRpqwgCIhPOgrcEMDxgqoFr+J4qy06w1tmvgru1NzTkkgA==
X-Received: by 2002:a17:907:1c07:b0:920:307a:21d9 with SMTP id nc7-20020a1709071c0700b00920307a21d9mr8348837ejc.15.1678694093310;
        Mon, 13 Mar 2023 00:54:53 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709061c8700b008b980c3e013sm3146943ejh.179.2023.03.13.00.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 00:54:53 -0700 (PDT)
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
Subject: [PATCH v2 3/9] ASoC: codecs: lpass-rx-macro: add support for SM8550
Date:   Mon, 13 Mar 2023 08:54:39 +0100
Message-Id: <20230313075445.17160-3-krzysztof.kozlowski@linaro.org>
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

Add support for the RX macro codec on Qualcomm SM8550.  SM8550 does not
use NPL clock, thus add flags allowing to skip it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

---

Changes since v1:
1. Move the flag define to common header
---
 sound/soc/codecs/lpass-macro-common.h |  3 +++
 sound/soc/codecs/lpass-rx-macro.c     | 36 +++++++++++++++++++++------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index f2cbf9fe2c6e..4eb886565ea3 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -6,6 +6,9 @@
 #ifndef __LPASS_MACRO_COMMON_H__
 #define __LPASS_MACRO_COMMON_H__
 
+/* NPL clock is expected */
+#define LPASS_MACRO_FLAG_HAS_NPL_CLOCK		BIT(0)
+
 struct lpass_macro {
 	struct device *macro_pd;
 	struct device *dcodec_pd;
diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index a73a7d7a1c0a..8519794e36fb 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3491,7 +3491,10 @@ static int rx_macro_register_mclk_output(struct rx_macro *rx)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(rx->npl);
+	if (rx->npl)
+		parent_clk_name = __clk_get_name(rx->npl);
+	else
+		parent_clk_name = __clk_get_name(rx->mclk);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
@@ -3521,10 +3524,13 @@ static const struct snd_soc_component_driver rx_macro_component_drv = {
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
@@ -3541,9 +3547,11 @@ static int rx_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(rx->mclk))
 		return PTR_ERR(rx->mclk);
 
-	rx->npl = devm_clk_get(dev, "npl");
-	if (IS_ERR(rx->npl))
-		return PTR_ERR(rx->npl);
+	if (flags & LPASS_MACRO_FLAG_HAS_NPL_CLOCK) {
+		rx->npl = devm_clk_get(dev, "npl");
+		if (IS_ERR(rx->npl))
+			return PTR_ERR(rx->npl);
+	}
 
 	rx->fsgen = devm_clk_get(dev, "fsgen");
 	if (IS_ERR(rx->fsgen))
@@ -3655,10 +3663,22 @@ static int rx_macro_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id rx_macro_dt_match[] = {
-	{ .compatible = "qcom,sc7280-lpass-rx-macro" },
-	{ .compatible = "qcom,sm8250-lpass-rx-macro" },
-	{ .compatible = "qcom,sm8450-lpass-rx-macro" },
-	{ .compatible = "qcom,sc8280xp-lpass-rx-macro" },
+	{
+		.compatible = "qcom,sc7280-lpass-rx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+
+	}, {
+		.compatible = "qcom,sm8250-lpass-rx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+	}, {
+		.compatible = "qcom,sm8450-lpass-rx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+	}, {
+		.compatible = "qcom,sm8550-lpass-rx-macro",
+	}, {
+		.compatible = "qcom,sc8280xp-lpass-rx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rx_macro_dt_match);
-- 
2.34.1

