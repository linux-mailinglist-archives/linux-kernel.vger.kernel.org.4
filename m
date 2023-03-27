Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513AD6CA5A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjC0NYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjC0NXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:23:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315835586
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ek18so36170212edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679923396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh0J+B26RJOLHDFZM1WKkkY18Exu6FcvY99vnXLALOk=;
        b=dNazTIE2tX83l9EtWuNck7yOwEMvmIl8UG0pToGQ1g14BSFnpHDRo7ocTNrqcVD1sA
         ULH4O39hXlC0PdLfyt4VSdoSski5GdubXKKKwOp+qVEKnECYtnObsA8mUKbx1GAf4QqC
         PKs0K8qDjJHfWcGyPbwSy0ELMACalcKyb9qcrbhU+N5sQGdu2gcjNCWlVQIia/iIEANv
         lf/p4U5V7mbgijAD8FJm/D/RA/5MQnWxnP53AWAbzXZrnpbNaTVBlEHbH7tA7Hw4YMo/
         En28cjRoq1SHD/c3ILzmHAePJ5hE09TQCvrC+GLoZ/CLImBd7BXDN88vuF4lrHT7U1SH
         JG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679923396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sh0J+B26RJOLHDFZM1WKkkY18Exu6FcvY99vnXLALOk=;
        b=jTBJHxwwe5ftOrSFachwRjDWKvsJZUIJ1SwZFybEQFzN/dnNI+xiX4eUqwCEbn4zOA
         PUaEdNTPKe29u8kVGeJz3ifQjbCyfoPt1F0oFHjeGUJQzltTWHqHSJVqAlzHdpP+9SIx
         FNGR3tc/T0LrfFboy5kdoiSpaoX/5YUXQSYY0RiwVzMshdWdxpvyRWHYVvM6ZmazEUrv
         LYyJUHoWRFmA3oPngD29dhXiuiPDmnMob2pi4zOETsxL82S76RjlxyKPZgIh7IIZbEih
         ccHeeLAme7kYG7on+smj/rD9vIwJU/BU7uYNFY/vyKhkv9Ni8x8/wTTvzCgFXh33HGpG
         gtLw==
X-Gm-Message-State: AAQBX9f5xpElCVnbGv4dasRz3zn/+xWrOkAU6IHXeX4er7oOJLvOB6Dp
        hiK8kNRjxB52JL6SXqBFzI4OTA==
X-Google-Smtp-Source: AKy350bCzgGnJ1uAkdKsEm1DHtodkMx+B8sthzcrvQwwUyHaCtt0b7OZInIY8iN/Dw5lguBYB/p/lQ==
X-Received: by 2002:a17:906:b4e:b0:92f:2c64:9d43 with SMTP id v14-20020a1709060b4e00b0092f2c649d43mr12372092ejg.68.1679923396503;
        Mon, 27 Mar 2023 06:23:16 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id gy24-20020a170906f25800b00930445428acsm14286814ejb.14.2023.03.27.06.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:23:16 -0700 (PDT)
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
Cc:     Patrick Lai <quic_plai@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 06/10] ASoC: codecs: lpass-tx-macro: add support for SM8550
Date:   Mon, 27 Mar 2023 15:22:50 +0200
Message-Id: <20230327132254.147975-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327132254.147975-1-krzysztof.kozlowski@linaro.org>
References: <20230327132254.147975-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index d9318799f6b7..da6fcf7f0991 100644
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
@@ -2143,10 +2151,21 @@ static const struct dev_pm_ops tx_macro_pm_ops = {
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

