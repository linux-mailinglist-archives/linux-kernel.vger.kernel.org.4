Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28236735C00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjFSQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjFSQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:13:26 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113861AC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:13:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b45e6e1b73so42850541fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687191203; x=1689783203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zb5V9XwfVFSIHpQhT+fVgcE2qaopeXD6dDII5Ksk8SI=;
        b=bB+j6bXK9bzttVUO3aefwzMtLgjoTbl5bcAV4jZtwnCEe2+zNabdgA508a+8J/V5iN
         6WwrXRM6DNCHdS8upXURZenKQvT4G2G7GkrGs1LvPaNEra+8q+aTF532jXrfbIHkyFio
         nCuwS3Xcd+iTVWw8JQ6bnMxjsfQqJqsUn2JyfbD3aBidw/FeMKVLFl8CLSqjKfMGgGdy
         I7uapsi2rn1XMLJPut+m8TD3jAFDRMsIofCXBQMveozk5eEe+YOnR+H2uy+13ZGJ+Nxc
         zc/ZXmlHVtKkOBfIYEC5f540LKyvhx8Tb2UIzs4xex7fTpVD8oRZl5OkEaHZYLZWWvMm
         10XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191203; x=1689783203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zb5V9XwfVFSIHpQhT+fVgcE2qaopeXD6dDII5Ksk8SI=;
        b=lCQRCAkS3vFGnnUW2o/5/79AQZkq1WQP1844cp0/449SYDZFLcwxBlvqFUXgFTuBSA
         VoSU+hXxdM9XT76ZnetXyHZ7KiYgC2mKCwKPuvMxfeWOufT8V5mSCLKWqlWpxbpXm7Ct
         EMdUitY+hoVfaPcYSViUQGdUonPcLDC1Ci9+Rq1teVOCt5APgQrPhr/x3GuMRmCT1NeT
         /mfPXkcZ7pUcQxZnZ15/7batw/8PGgsLDxKOyfhIwM0BPgAbhPpx24wcLCo72r9u20Ur
         hD+Dofm9wLoPqaAGu8AgPILY3a6i0BTY1CvBOStAsjKnPuwbRsCBWaL8RTKqORsY6ddI
         fwVg==
X-Gm-Message-State: AC+VfDwN5g4CCG9xo1pjpQdx9uv4WH2IL50FHifuybUnzDqkKf9cqu13
        ej8v9RJ/2G/yiwaVFTEK6XurzqzCsGdgarwc6G0=
X-Google-Smtp-Source: ACHHUZ7P7sjednE2bGKLN2y9DXYmXl1NUfMgakQ31M8U+TKMrIDoMuESw8gMix1UVjbnSDPaMddkQw==
X-Received: by 2002:a2e:8842:0:b0:2b4:6b64:6855 with SMTP id z2-20020a2e8842000000b002b46b646855mr3283513ljj.24.1687191203246;
        Mon, 19 Jun 2023 09:13:23 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id x20-20020a2e7c14000000b002b471efb253sm1011714ljc.46.2023.06.19.09.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:13:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 18:13:17 +0200
Subject: [PATCH 1/2] clk: qcom: gpucc-sc8280xp: Add runtime PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-sc8280xp-clk-rpm-v1-1-1e5e1064cdb2@linaro.org>
References: <20230619-topic-sc8280xp-clk-rpm-v1-0-1e5e1064cdb2@linaro.org>
In-Reply-To: <20230619-topic-sc8280xp-clk-rpm-v1-0-1e5e1064cdb2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687191201; l=1937;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5Q+uIon8TwEZ6cJYHo5zacahpsGk7QSU+uGdUpH/moA=;
 b=f3JFlxvNLVIGIfQGPanhZfCO1xDNeRNXyVkclN0YBwa4r94CwWeP7+9B5deZSpgSsP0FlNyUo
 T7Oirv/CVT/Cfb8Ff/akhzHaU2Dn6Ab3fgZJNA/CP8AsDl0nURfl9Ty
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU_CC block on SC8280XP is powered by the GFX rail. We need to
ensure that it's enabled to prevent unwanted power collapse.

Enable runtime PM to keep the power flowing only when necessary.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gpucc-sc8280xp.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index ea1e9505c335..8e147ee294ee 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,gpucc-sc8280xp.h>
@@ -424,10 +425,21 @@ static struct qcom_cc_desc gpu_cc_sc8280xp_desc = {
 static int gpu_cc_sc8280xp_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
+	int ret;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
 
 	regmap = qcom_cc_map(pdev, &gpu_cc_sc8280xp_desc);
-	if (IS_ERR(regmap))
+	if (IS_ERR(regmap)) {
+		pm_runtime_put(&pdev->dev);
 		return PTR_ERR(regmap);
+	}
 
 	clk_lucid_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
 	clk_lucid_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
@@ -439,7 +451,10 @@ static int gpu_cc_sc8280xp_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x1170, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x109c, BIT(0), BIT(0));
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sc8280xp_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &gpu_cc_sc8280xp_desc, regmap);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
 }
 
 static const struct of_device_id gpu_cc_sc8280xp_match_table[] = {

-- 
2.41.0

