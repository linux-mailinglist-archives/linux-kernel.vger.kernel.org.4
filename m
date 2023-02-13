Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE35694693
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjBMNIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjBMNIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:08:12 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF4517CD6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:08:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id fi26so12767586edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toszlCApAapEeFqDOAwpUXkStpvwASomRZo2T6mEG/c=;
        b=ymahPWWQURF/O1Lh4FbkzLW/klW8mPcwTS4dUtGnpIiTl0m1RG7LIo5Oj+kZS/i4rA
         MfyIFRxD+4HyrQ7A4hBXrn3XUEQG0DhWf2NY5RYakFukCccZYUUAv0qibS3Q1LxuRMIn
         J1e7C1mCjK6gY4dDLRwNEUgUxF9Voq+X7G113L0qIrUZ/jndesKHgvdU1JPO3y2aXDip
         s+zCrQVbTd4Eyugib/hlqi9QekwJg/0itEKNZ8Kj/6jULIILRtyNrN5qWnoi+Kru9j9d
         j2Im5sgON9hZa2nWDidfUmc6yF0rOQ9VSSFYel3eN93xS5s3ca9KLXaRYN5EgAhz8kkc
         XMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toszlCApAapEeFqDOAwpUXkStpvwASomRZo2T6mEG/c=;
        b=7xSB/1SHlRpjwMeCrKwA06a1gH7D01OuwS6OrItHWTKK2jKI65P/yDWxD2ekXuvLto
         v4oZCcISg0kmcud6zF3Nw606/xEJPSPuhQfABfEO6n+vTy26m2mHCANBbMtM/Z6z+vD6
         z1u0yuiIF2KSQg7EO4acqwbdYdiogNI0p8oYQdJQ0iOaUyHofaEEJryzhD9IO71nxtMA
         UgPu4gyctyJKs3PJNJWuMJyiSNcib3LovJHs+0CGanH29re8lxd6Ultb15gXUNJvanNy
         iLaiPCxZXvM6lIGbtI3qJZXeMA3gdVutu7LHQVSSV8iJze0YDlQd9uxOz65pMyZB+D2i
         iY8w==
X-Gm-Message-State: AO0yUKUDX0QnQprTrQ3n8P2oxFqOftR00h7kIkSqbgSv8DTwzwxao64V
        PCGC8dw9JbbvK+dcNAdLxNgBiA==
X-Google-Smtp-Source: AK7set/PoneDQZG6t0Zyg+WutlmMmUqL7cOJ3103UYH+QyyVg32InIC9jei4mrMKCUzwdI8sQ+5K3w==
X-Received: by 2002:a50:9b13:0:b0:4ab:44bd:80a1 with SMTP id o19-20020a509b13000000b004ab44bd80a1mr12636185edi.22.1676293688775;
        Mon, 13 Feb 2023 05:08:08 -0800 (PST)
Received: from [172.16.220.87] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id f22-20020a50a6d6000000b004acc6cbc451sm1616515edc.36.2023.02.13.05.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 05:08:08 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
X-Google-Original-From: Luca Weiss <luca@z3ntu.xyz>
Date:   Mon, 13 Feb 2023 14:08:06 +0100
Subject: [PATCH v2 1/2] clk: qcom: camcc-sm6350: add pm_runtime support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230213-sm6350-camcc-runtime_pm-v2-1-60a507bf3e68@z3ntu.xyz>
References: <20230213-sm6350-camcc-runtime_pm-v2-0-60a507bf3e68@z3ntu.xyz>
In-Reply-To: <20230213-sm6350-camcc-runtime_pm-v2-0-60a507bf3e68@z3ntu.xyz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that we can enable and disable the power domains used for
camcc when the clocks are and aren't used.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/clk/qcom/camcc-sm6350.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/camcc-sm6350.c
index acba9f99d960..dd65f3ef0857 100644
--- a/drivers/clk/qcom/camcc-sm6350.c
+++ b/drivers/clk/qcom/camcc-sm6350.c
@@ -7,6 +7,8 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm6350-camcc.h>
@@ -1869,6 +1871,19 @@ MODULE_DEVICE_TABLE(of, camcc_sm6350_match_table);
 static int camcc_sm6350_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
+	int ret;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_pm_clk_create(&pdev->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = pm_runtime_get(&pdev->dev);
+	if (ret)
+		return ret;
 
 	regmap = qcom_cc_map(pdev, &camcc_sm6350_desc);
 	if (IS_ERR(regmap))
@@ -1879,14 +1894,26 @@ static int camcc_sm6350_probe(struct platform_device *pdev)
 	clk_agera_pll_configure(&camcc_pll2, regmap, &camcc_pll2_config);
 	clk_fabia_pll_configure(&camcc_pll3, regmap, &camcc_pll3_config);
 
-	return qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
+	pm_runtime_put(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register CAM CC clocks\n");
+		return ret;
+	}
+
+	return 0;
 }
 
+static const struct dev_pm_ops camcc_pm_ops = {
+	SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
+};
+
 static struct platform_driver camcc_sm6350_driver = {
 	.probe = camcc_sm6350_probe,
 	.driver = {
 		.name = "sm6350-camcc",
 		.of_match_table = camcc_sm6350_match_table,
+		.pm = &camcc_pm_ops,
 	},
 };
 

-- 
2.39.1

