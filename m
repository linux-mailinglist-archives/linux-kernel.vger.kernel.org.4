Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0387E6961AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjBNLBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjBNLBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:01:40 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F8244B5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:01:36 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jg8so39077237ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFzfHrOtIZCqMj4zPJVlDbK817D86+LN2MDM7zmPIms=;
        b=z7Y+KEKJCkG36g6nHpsRZt2V/JBZpah+ipSiZDJVgvbDsSx4Tv64H6Y3bVpYdX7o+r
         wOTURRQpXui2zhy+Bcnovh3VtWMqv948xVpvsGUec3Av9OHqUGlyHn4bU1v/JhFPks48
         dqtDabMnErd5bzpW4+e2HG6j6tR8/DkWW+zInedQT1C7pmfnfDcvQvzSnTsC/ycT+4k8
         MUfH+DvJeIspqCep3zPagWMJwcUYYuzRdFQOFOBsH+GkxflSQDkdEdkWoQyaB6Aq4Gnd
         DGRUrKlKcXKQctfYcZ3DTqC0HzK5qghRaYYWPxXdY7ehIWTdVVL0Q4yWkAfvAJCvT+/5
         jduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFzfHrOtIZCqMj4zPJVlDbK817D86+LN2MDM7zmPIms=;
        b=eNpWe6q8G2V97gU+NXUP+6Pa9Dh/hSY6TQAMWRC7D3rj+PDyIyYoQ3AOIHlCJfUISY
         /KNHVaFJptxi6ltSQO6qKP8nPtjccXMl/fyyQ7xjJfkxA8qXZugLg+bqcVj57rXMA1gP
         0UrZYVOQbiBeJzddnTHdYAUwivoQNZvmAQ6weX+KWc4bTedzfmJY5K7pOarLmGdXrKGl
         Qj/siIhQI8BrkZy6X+fKMncq7rc9uc90V8ZY9EYGiAjU+pvrKXtgDh0UPnZ+CNxLVe77
         UzrThrIc97g9xURM2dZWW9R29Lf0ceiBEdyGNFWoMXW9BPjXHayz5wi4keVdW6Gk1MD9
         mQ8w==
X-Gm-Message-State: AO0yUKVhQxXZOJpw1aXVxple5yIFBxWgZTm2g5+OMCvUusC+HXfY3K/F
        2rqg5cwfzJB9Z5SDAjDQ0j7rgQ==
X-Google-Smtp-Source: AK7set8MNrao1ntWwi8JnefpATCpH+M6d7iyhDNkq1v2nvlIZi4jwzWz8P2KHMCicfQgmF8KsOQ2CQ==
X-Received: by 2002:a17:906:6ad4:b0:877:573d:e919 with SMTP id q20-20020a1709066ad400b00877573de919mr2597986ejs.20.1676372495311;
        Tue, 14 Feb 2023 03:01:35 -0800 (PST)
Received: from [172.16.220.87] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906115500b008711cab8875sm7959596eja.216.2023.02.14.03.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 03:01:35 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Tue, 14 Feb 2023 12:01:32 +0100
Subject: [PATCH v3 1/2] clk: qcom: camcc-sm6350: add pm_runtime support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230213-sm6350-camcc-runtime_pm-v3-1-d35e0d833cc4@fairphone.com>
References: <20230213-sm6350-camcc-runtime_pm-v3-0-d35e0d833cc4@fairphone.com>
In-Reply-To: <20230213-sm6350-camcc-runtime_pm-v3-0-d35e0d833cc4@fairphone.com>
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
        Luca Weiss <luca.weiss@fairphone.com>
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

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/camcc-sm6350.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/camcc-sm6350.c b/drivers/clk/qcom/camcc-sm6350.c
index acba9f99d960..fc5532e2ee5b 100644
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
@@ -1879,14 +1894,22 @@ static int camcc_sm6350_probe(struct platform_device *pdev)
 	clk_agera_pll_configure(&camcc_pll2, regmap, &camcc_pll2_config);
 	clk_fabia_pll_configure(&camcc_pll3, regmap, &camcc_pll3_config);
 
-	return qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &camcc_sm6350_desc, regmap);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
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

