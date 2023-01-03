Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E778D65C77B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbjACT02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbjACT0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:26:02 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40FE15F35
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:24:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso21076237wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaSJH6qwzBFLaleOV9/RDtj1DHcWd7lA30T3AWhdsIk=;
        b=FQhvuOHBlauFAqrbw32tVa3t4AjkSwzq9fnMkCTbgzd5mMQmlMUVfydcVqTBuaETxv
         69bIXwH03MOOwddsGlbKCkjZfIA+V5K7OXscxkDtnPyrHVWzXivnOsKBPcOqARe4JPF3
         ysIH2rSIFhSStel3zLoMAo60KdOURs/D2IhL0g/uhkuttYRHOADPXlis0XD/AZc2Y6yn
         liqxr3FY2Ht80Iodd9Re1TqI7z0q1tfECmfi2IaWxPZ698XorJU2UydFtUhEgjsxFGrd
         Urc9sChOrTf3+b4UeTsj5Oz0s4n8m2afDDpmu4E2o66qr5Xoy0wAFh4TrTtBBZOJYagA
         uGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaSJH6qwzBFLaleOV9/RDtj1DHcWd7lA30T3AWhdsIk=;
        b=Zo2Lp443JgGOt3WV+pVJdp8klCEYME7GWzx2xQDnCIjRZLQbVxaNKeiU2zgpvfpJZU
         O5VU3vKtFVTXyN95QWNuJikiZheP1vdiWA7wibVcQi1iZSg0aPv7dQ5iTT2A+G1GOLAz
         j88VF8n8ZeqWk/CQysd+fwRa9zIz7TlsojHjxFNeZBOJV1KDEAqE21WYMfTC0mCUbPh6
         0Y6snWmW3Du4w+ls5JDvtB+Y14bnZYNwvlr+4/urvAsOdAzkxBWVFZDWM5qgef/HXgFo
         U/nNleFKv2ODc57+EHNSnrPlXU47Tke2A+WNHJK+I2QkJU7mm1+pTQVbv+ufjISxxNvw
         BQPQ==
X-Gm-Message-State: AFqh2kr0iJs9dpFX/xwCejh9zHxQa0zMIDt2w8syLjIyrMis6Z0+jSmh
        FyRhZKsqyRqC0Kh6wyt7ztn2Xg==
X-Google-Smtp-Source: AMrXdXsHtJIvXP8sGI8IG18GWiNokmeyBijOoocrUpPlsePdq6TvsYyqkjVVcgCZQAll5jbdmVTcXQ==
X-Received: by 2002:a05:600c:600a:b0:3d1:ed41:57c0 with SMTP id az10-20020a05600c600a00b003d1ed4157c0mr35322859wmb.30.1672773851282;
        Tue, 03 Jan 2023 11:24:11 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cfbbd54178sm70803660wms.2.2023.01.03.11.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 11:24:10 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 3/4] clk: qcom: rpmh: Add support for SM8550 rpmh clocks
Date:   Tue,  3 Jan 2023 21:21:57 +0200
Message-Id: <20230103192158.1155197-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103192158.1155197-1-abel.vesa@linaro.org>
References: <20230103192158.1155197-1-abel.vesa@linaro.org>
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

Adds the RPMH clocks present in SM8550 SoC.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 586a810c682c..7db5a53d73f0 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -366,6 +366,16 @@ DEFINE_CLK_RPMH_VRM(rf_clk2, _d, "rfclkd2", 1);
 DEFINE_CLK_RPMH_VRM(rf_clk3, _d, "rfclkd3", 1);
 DEFINE_CLK_RPMH_VRM(rf_clk4, _d, "rfclkd4", 1);
 
+DEFINE_CLK_RPMH_VRM(clk1, _a1, "clka1", 1);
+DEFINE_CLK_RPMH_VRM(clk2, _a1, "clka2", 1);
+DEFINE_CLK_RPMH_VRM(clk3, _a1, "clka3", 1);
+DEFINE_CLK_RPMH_VRM(clk4, _a1, "clka4", 1);
+DEFINE_CLK_RPMH_VRM(clk5, _a1, "clka5", 1);
+
+DEFINE_CLK_RPMH_VRM(clk6, _a2, "clka6", 2);
+DEFINE_CLK_RPMH_VRM(clk7, _a2, "clka7", 2);
+DEFINE_CLK_RPMH_VRM(clk8, _a2, "clka8", 2);
+
 DEFINE_CLK_RPMH_VRM(div_clk1, _div2, "divclka1", 2);
 
 DEFINE_CLK_RPMH_BCM(ce, "CE0");
@@ -576,6 +586,31 @@ static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
 	.num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
 };
 
+static struct clk_hw *sm8550_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
+	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
+	[RPMH_LN_BB_CLK1]	= &clk_rpmh_clk6_a2.hw,
+	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_clk6_a2_ao.hw,
+	[RPMH_LN_BB_CLK2]	= &clk_rpmh_clk7_a2.hw,
+	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_clk7_a2_ao.hw,
+	[RPMH_LN_BB_CLK3]	= &clk_rpmh_clk8_a2.hw,
+	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_clk8_a2_ao.hw,
+	[RPMH_RF_CLK1]		= &clk_rpmh_clk1_a1.hw,
+	[RPMH_RF_CLK1_A]	= &clk_rpmh_clk1_a1_ao.hw,
+	[RPMH_RF_CLK2]		= &clk_rpmh_clk2_a1.hw,
+	[RPMH_RF_CLK2_A]	= &clk_rpmh_clk2_a1_ao.hw,
+	[RPMH_RF_CLK3]		= &clk_rpmh_clk3_a1.hw,
+	[RPMH_RF_CLK3_A]	= &clk_rpmh_clk3_a1_ao.hw,
+	[RPMH_RF_CLK4]		= &clk_rpmh_clk4_a1.hw,
+	[RPMH_RF_CLK4_A]	= &clk_rpmh_clk4_a1_ao.hw,
+	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sm8550 = {
+	.clks = sm8550_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sm8550_rpmh_clocks),
+};
+
 static struct clk_hw *sc7280_rpmh_clocks[] = {
 	[RPMH_CXO_CLK]      = &clk_rpmh_bi_tcxo_div4.hw,
 	[RPMH_CXO_CLK_A]    = &clk_rpmh_bi_tcxo_div4_ao.hw,
@@ -742,6 +777,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
 	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
 	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
+	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
 	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
 	{ }
 };
-- 
2.34.1

