Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8887133D1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjE0Jk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjE0JkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:40:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC0418D;
        Sat, 27 May 2023 02:40:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f850b32caso305550666b.3;
        Sat, 27 May 2023 02:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685180421; x=1687772421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnO2+f52DGNhkJXeV3dwSMun1/oWC09Jx7AM2r6DtMM=;
        b=bhBfYdtLAdF6L9i7h/QEU4O1n2pyT0ratFM/0CCSnFZ+1ag/9kGSXIVWY+JPRlZuU6
         8sIuzlmUqGslfpnquwD2dzgiThRbA8Ig20vFlcatq6xaS4ZX4kE329bJ55BLmNLCC4MQ
         RW8UrzI16v/4RPahN1+UKDFtJgWDhX1a+cF3JXPGtacKP3CZBFoe1z9ndNv0JUzSfQfQ
         yK/Cxt78lIf+81MyyQ92LhOZXhgcY8vn5c9ujmdvLgH2BFj9A2RCxwCIxC7oYAiDUlBc
         OjyjtSTKQW76iDlejBV6SO0ER9PbS3dP8Gnn1DMGCeNeQTmn9CqJQTgYKA0N52wYRONI
         Hxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685180421; x=1687772421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnO2+f52DGNhkJXeV3dwSMun1/oWC09Jx7AM2r6DtMM=;
        b=bMFVsNxC3txMIfjv1Dyto5ByyPWGf8HdZ1TrhXP2+SgA4p9LhxjXcTDIocWGtON5KE
         ZM/OskFDMXCFDI6ED8WzHbTUr77BAoyP5g8cjYncDy97jvFDuv4O6a5NscuEUDeH6NEm
         sQpiV0Aq8tYx53jJ5o8beo3dJgEpqVj/DJ0KRS5oCd9m6aJQJqseWS3uvNL1jI2l2hgB
         5AF06I2YltN2D1qjweKImYbJ9OZZdGjurz2FpTIn+4dLlYubFs8+rxT/oNAKA146ptYP
         U7a0CPBkrI46d39PtW7zLiZhxC5lSAxOpVyTQLhuSMfxCJGysrHW2LDTDkdrQFvO9nTb
         rP8g==
X-Gm-Message-State: AC+VfDz45CRyRy3O1oup4RddHKehOcWF+puJrT7CVKzjpWoMZP5eLBvd
        Y4tAGZ3GIyDbMOeIoEHbptE=
X-Google-Smtp-Source: ACHHUZ75m2h7jCFKbjxh54OtTIyPOiFEaOUI6ExlmRmORTaiabRV2QhaoiuLmbLCXbW9uA5/5Vfziw==
X-Received: by 2002:a17:907:9289:b0:966:63ac:3706 with SMTP id bw9-20020a170907928900b0096663ac3706mr4018706ejc.26.1685180421286;
        Sat, 27 May 2023 02:40:21 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id kq12-20020a170906abcc00b009596e7e0dbasm3163623ejb.162.2023.05.27.02.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 02:40:20 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] clk: qcom: cbf-msm8996: Add support for MSM8996 Pro
Date:   Sat, 27 May 2023 12:39:34 +0300
Message-Id: <20230527093934.101335-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527093934.101335-1-y.oudjana@protonmail.com>
References: <20230527093934.101335-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

The CBF PLL on MSM8996 Pro has a /4 post divisor instead of /2. Handle the
difference accordingly.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/qcom/clk-cbf-8996.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
index cfd567636f4e..ab988e6f1976 100644
--- a/drivers/clk/qcom/clk-cbf-8996.c
+++ b/drivers/clk/qcom/clk-cbf-8996.c
@@ -48,7 +48,7 @@ static const u8 cbf_pll_regs[PLL_OFF_MAX_REGS] = {
 	[PLL_OFF_STATUS] = 0x28,
 };
 
-static const struct alpha_pll_config cbfpll_config = {
+static struct alpha_pll_config cbfpll_config = {
 	.l = 72,
 	.config_ctl_val = 0x200d4828,
 	.config_ctl_hi_val = 0x006,
@@ -137,7 +137,7 @@ static int clk_cbf_8996_mux_determine_rate(struct clk_hw *hw,
 {
 	struct clk_hw *parent;
 
-	if (req->rate < (DIV_THRESHOLD / 2))
+	if (req->rate < (DIV_THRESHOLD / cbf_pll_postdiv.div))
 		return -EINVAL;
 
 	if (req->rate < DIV_THRESHOLD)
@@ -265,6 +265,11 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
 	/* Switch CBF to use the primary PLL */
 	regmap_update_bits(regmap, CBF_MUX_OFFSET, CBF_MUX_PARENT_MASK, 0x1);
 
+	if (of_device_is_compatible(dev->of_node, "qcom,msm8996pro-cbf")) {
+		cbfpll_config.post_div_val = 0x3 << 8;
+		cbf_pll_postdiv.div = 4;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(cbf_msm8996_hw_clks); i++) {
 		ret = devm_clk_hw_register(dev, cbf_msm8996_hw_clks[i]);
 		if (ret)
@@ -286,6 +291,7 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
 
 static const struct of_device_id qcom_msm8996_cbf_match_table[] = {
 	{ .compatible = "qcom,msm8996-cbf" },
+	{ .compatible = "qcom,msm8996pro-cbf" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, qcom_msm8996_cbf_match_table);
-- 
2.40.1

