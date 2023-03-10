Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED55B6B4045
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCJNXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjCJNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:22:32 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C27A101109
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x3so20274665edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678454530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wB+ZDQLED1lfGjvfm20Sk8PslUquOiz9jmctspNl1k=;
        b=JgavJRWVjXavsT+LNLiKq8j4sHA3egVc/3wVlar/9dWGpeoo98SDPex1hMfV7pY5yf
         1ApuU822yhrebDtqVjYVKjz47l5hI0TdWfGiwEZapkXovmwUIYYl68blWk6e4mt71rcu
         gsdPePIHs1SGdDvQ7FH47ttAJ7julhHo1vkjhLXQbuB5DxVqX9s2palK3XkyV1Y14U/G
         9of8H0ZcpX3/4gnnZeWp5U+L9dLQeCUUUg6tf1JW4TCcjedsfUgNiduvAGRq36N25YwB
         foicPk1df44T0zPT4m2SYXjH/VF2uumUZRbCFNAUV/qLB6NhWGe55n4ADar+apYuxcrW
         Ayhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678454530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wB+ZDQLED1lfGjvfm20Sk8PslUquOiz9jmctspNl1k=;
        b=vdc6QbFLMqc8+JFCvJSsQGpE0xIdkkYxt2X4j6kU+7+ro6/2QwtYlFjYKzsFBDyjEQ
         AbqoLaB56E2/Bumxaf0zZnEvaL9SfI5KJAX9C1kJradUGIlAzPaYSMMep1SBoIg9hie8
         dwFlAX9DIk3igr9tknQM2dcGEZV+a4T7WIcZaMV3UtbtGCaQL+yrcUmIoTHBDFFIpxZ9
         xpLMloetreAkj46iVsXAzyVrnZ7u4SqmbAn6QaGmnb+SeIrYq/q3vTtMVMgBob7E3Yaj
         NikZrWZthQ5TZxBH0hbpfSAQQTe/29N3PJnsAqdPO7VEGzEC+Iqt+9QKYZTncDf96SdX
         yMuw==
X-Gm-Message-State: AO0yUKXfU6LB9NviMAvq0+Bs5iqsF0XbD2HGb5wtuHROBHEMSSLe+oIK
        ZcQzSkKJqWoCYG+2ci41eh+o3A==
X-Google-Smtp-Source: AK7set+PxUyg5gMa34e3JPIVei4cJk2opNLH6ajC/YSQ9yp4xl5ntn+cwfyczNMHa6C+1F4RH8fehg==
X-Received: by 2002:a17:906:28d3:b0:8b2:3eb6:8661 with SMTP id p19-20020a17090628d300b008b23eb68661mr23663069ejd.8.1678454530577;
        Fri, 10 Mar 2023 05:22:10 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:45c4:46be:ec71:4a51])
        by smtp.gmail.com with ESMTPSA id zc4-20020a170906988400b008b17879ec95sm959124ejb.22.2023.03.10.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 05:22:10 -0800 (PST)
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
Subject: [PATCH 6/9] ASoC: codecs: lpass-tx-macro: add support for SM8550
Date:   Fri, 10 Mar 2023 14:21:58 +0100
Message-Id: <20230310132201.322148-7-krzysztof.kozlowski@linaro.org>
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

Add support for the TX macro codec on Qualcomm SM8550.  SM8550 does not
use NPL clock, thus add flags allowing to skip it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 38 ++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 473d3cd39554..23371b21505e 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -205,6 +205,9 @@
 #define TX_MACRO_AMIC_HPF_DELAY_MS	300
 #define MCLK_FREQ		19200000
 
+/* NPL clock is expected */
+#define TX_MACRO_FLAG_HAS_NPL_CLOCK		BIT(0)
+
 enum {
 	TX_MACRO_AIF_INVALID = 0,
 	TX_MACRO_AIF1_CAP,
@@ -1915,7 +1918,10 @@ static int tx_macro_register_mclk_output(struct tx_macro *tx)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(tx->npl);
+	if (tx->npl)
+		parent_clk_name = __clk_get_name(tx->npl);
+	else
+		parent_clk_name = __clk_get_name(tx->mclk);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
@@ -1946,10 +1952,13 @@ static int tx_macro_probe(struct platform_device *pdev)
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
@@ -1966,9 +1975,11 @@ static int tx_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(tx->mclk))
 		return PTR_ERR(tx->mclk);
 
-	tx->npl = devm_clk_get(dev, "npl");
-	if (IS_ERR(tx->npl))
-		return PTR_ERR(tx->npl);
+	if (flags & TX_MACRO_FLAG_HAS_NPL_CLOCK) {
+		tx->npl = devm_clk_get(dev, "npl");
+		if (IS_ERR(tx->npl))
+			return PTR_ERR(tx->npl);
+	}
 
 	tx->fsgen = devm_clk_get(dev, "fsgen");
 	if (IS_ERR(tx->fsgen))
@@ -2145,10 +2156,21 @@ static const struct dev_pm_ops tx_macro_pm_ops = {
 };
 
 static const struct of_device_id tx_macro_dt_match[] = {
-	{ .compatible = "qcom,sc7280-lpass-tx-macro" },
-	{ .compatible = "qcom,sm8250-lpass-tx-macro" },
-	{ .compatible = "qcom,sm8450-lpass-tx-macro" },
-	{ .compatible = "qcom,sc8280xp-lpass-tx-macro" },
+	{
+		.compatible = "qcom,sc7280-lpass-tx-macro",
+		.data = (void *)TX_MACRO_FLAG_HAS_NPL_CLOCK,
+	}, {
+		.compatible = "qcom,sm8250-lpass-tx-macro",
+		.data = (void *)TX_MACRO_FLAG_HAS_NPL_CLOCK,
+	}, {
+		.compatible = "qcom,sm8450-lpass-tx-macro",
+		.data = (void *)TX_MACRO_FLAG_HAS_NPL_CLOCK,
+	}, {
+		.compatible = "qcom,sm8550-lpass-tx-macro",
+	}, {
+		.compatible = "qcom,sc8280xp-lpass-tx-macro",
+		.data = (void *)TX_MACRO_FLAG_HAS_NPL_CLOCK,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tx_macro_dt_match);
-- 
2.34.1

