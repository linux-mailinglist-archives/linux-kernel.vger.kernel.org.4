Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC8A6443B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiLFM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiLFM5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:57:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E3D9FC5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 04:56:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i15so11946559edf.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 04:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGLwUiqnWNNCSh7SfaJVMgmwcN3tXBqQdd3/EujPmbQ=;
        b=BLvjAc5qaWMqqX0LcNFZyaPScS8Auq+3la+ia6AMIs5X41daPyVN7wWTB2K6uBVJNg
         eQ5nU2q+rxJ/soT09N7oSzhTLMOu8Kh8TL0BXSBzZ3ERRcqvyqekAeyjnPbFsJcH9b1w
         bEj4b2GjZocjwIk5jbgIjaxUyAKEFj7d9K27jW3pPQ9xUgDwXyLjOX7rJZ1K6BaLn6Fo
         2zgsy2KnfHOco82Q1tx7xonCspRrejUD3mA9xa2Ek88xJwDfE59ePdH9GogZBz5vma5W
         Vrl2yN1LFxZ1hM7L1lJf60Pe+U9clI2sr7jP+BFBkPjtAnA4fP3zapyoex1Os/Jj/6i/
         xqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGLwUiqnWNNCSh7SfaJVMgmwcN3tXBqQdd3/EujPmbQ=;
        b=XqbZOxt1Jg1qKzu5UeRjzq2dZlI/UIwuMWeksiiuPTK8J5woIqGUnovDBNytElBgz2
         g7+TCHdnEZLrPTYiqoOqW/yLb9DU/CQcgRgIdNrcVyhTfmeQRs7nID7+oI/dBNDh8wkO
         GedgG/4lWNlEY9E5hgk7u39EQxk8eUepQq/UkFeFv8FbwtP8lEYjOlvKxK8X7G+8n6lJ
         YD6F2mht7F9Pu3BuuaZLKRSREomqjOeLInlKnKKmSzqRdKw25Ukec2x3yXW4oHmxOFK4
         AzaluEs9Uc9Ld3JdSx23b1x9BOjFFEQmG2vGnJ82VpZM6LqctfDYc59o264nVuvd20Be
         cldQ==
X-Gm-Message-State: ANoB5pk5f4I0dDwKzayv2xbYhuXk1lX2TkelcjMB/6YM+9Kt3bU4iQU9
        fwy8mRKWtYMGqP8eaDuXrp1+gw==
X-Google-Smtp-Source: AA0mqf7/OHiK8cWKxQjLJ0SL7h+aSGvGW7e1tYw7TFeyR6QAAaQMDsaQ0v27h441WmswYjKWqOYrog==
X-Received: by 2002:a05:6402:4d6:b0:458:789b:c1b0 with SMTP id n22-20020a05640204d600b00458789bc1b0mr65538122edw.89.1670331405860;
        Tue, 06 Dec 2022 04:56:45 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7cd4f000000b0046150ee13besm932991edw.65.2022.12.06.04.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 04:56:45 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v5 4/5] clk: qcom: rpmh: Add support for SM8550 rpmh clocks
Date:   Tue,  6 Dec 2022 14:56:34 +0200
Message-Id: <20221206125635.952114-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206125635.952114-1-abel.vesa@linaro.org>
References: <20221206125635.952114-1-abel.vesa@linaro.org>
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
 drivers/clk/qcom/clk-rpmh.c | 110 +++++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 2c2ef4b6d130..ce81c76ed0fd 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -130,6 +130,34 @@ static DEFINE_MUTEX(rpmh_clk_lock);
 		},							\
 	}
 
+#define DEFINE_CLK_FIXED_FACTOR(_name, _parent_name, _div)		\
+	static struct clk_fixed_factor clk_fixed_factor##_##_name = {	\
+		.mult = 1,						\
+		.div = _div,						\
+		.hw.init = &(struct clk_init_data){			\
+			.ops = &clk_fixed_factor_ops,			\
+			.name = #_name,					\
+			.parent_data =  &(const struct clk_parent_data){ \
+				.fw_name = #_parent_name,		\
+				.name = #_parent_name,			\
+			},						\
+			.num_parents = 1,				\
+		},							\
+	};								\
+	static struct clk_fixed_factor clk_fixed_factor##_##_name##_ao = { \
+		.mult = 1,						\
+		.div = _div,						\
+		.hw.init = &(struct clk_init_data){			\
+			.ops = &clk_fixed_factor_ops,			\
+			.name = #_name "_ao",				\
+			.parent_data =  &(const struct clk_parent_data){ \
+				.fw_name = #_parent_name "_ao",		\
+				.name = #_parent_name "_ao",		\
+			},						\
+			.num_parents = 1,				\
+		},							\
+	}
+
 static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
 {
 	return container_of(_hw, struct clk_rpmh, hw);
@@ -345,6 +373,8 @@ DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 2);
 DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 4);
 DEFINE_CLK_RPMH_ARC(qlink, "qphy.lvl", 0x1, 4);
 
+DEFINE_CLK_FIXED_FACTOR(bi_tcxo_div2, bi_tcxo, 2);
+
 DEFINE_CLK_RPMH_VRM(ln_bb_clk1, _a2, "lnbclka1", 2);
 DEFINE_CLK_RPMH_VRM(ln_bb_clk2, _a2, "lnbclka2", 2);
 DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _a2, "lnbclka3", 2);
@@ -366,6 +396,16 @@ DEFINE_CLK_RPMH_VRM(rf_clk2, _d, "rfclkd2", 1);
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
@@ -576,6 +616,33 @@ static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
 	.num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
 };
 
+static struct clk_hw *sm8550_rpmh_clocks[] = {
+	[RPMH_CXO_PAD_CLK]      = &clk_rpmh_bi_tcxo_div2.hw,
+	[RPMH_CXO_PAD_CLK_A]    = &clk_rpmh_bi_tcxo_div2_ao.hw,
+	[RPMH_CXO_CLK]		= &clk_fixed_factor_bi_tcxo_div2.hw,
+	[RPMH_CXO_CLK_A]	= &clk_fixed_factor_bi_tcxo_div2_ao.hw,
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
@@ -683,29 +750,31 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 
 		name = hw_clks[i]->init->name;
 
-		rpmh_clk = to_clk_rpmh(hw_clks[i]);
-		res_addr = cmd_db_read_addr(rpmh_clk->res_name);
-		if (!res_addr) {
-			dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
-				rpmh_clk->res_name);
-			return -ENODEV;
-		}
+		if (hw_clks[i]->init->ops != &clk_fixed_factor_ops) {
+			rpmh_clk = to_clk_rpmh(hw_clks[i]);
+			res_addr = cmd_db_read_addr(rpmh_clk->res_name);
+			if (!res_addr) {
+				dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
+					rpmh_clk->res_name);
+				return -ENODEV;
+			}
 
-		data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
-		if (IS_ERR(data)) {
-			ret = PTR_ERR(data);
-			dev_err(&pdev->dev,
-				"error reading RPMh aux data for %s (%d)\n",
-				rpmh_clk->res_name, ret);
-			return ret;
-		}
+			data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
+			if (IS_ERR(data)) {
+				ret = PTR_ERR(data);
+				dev_err(&pdev->dev,
+					"error reading RPMh aux data for %s (%d)\n",
+					rpmh_clk->res_name, ret);
+				return ret;
+			}
 
-		/* Convert unit from Khz to Hz */
-		if (aux_data_len == sizeof(*data))
-			rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
+			/* Convert unit from Khz to Hz */
+			if (aux_data_len == sizeof(*data))
+				rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
 
-		rpmh_clk->res_addr += res_addr;
-		rpmh_clk->dev = &pdev->dev;
+			rpmh_clk->res_addr += res_addr;
+			rpmh_clk->dev = &pdev->dev;
+		}
 
 		ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
 		if (ret) {
@@ -741,6 +810,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
 	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
 	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
+	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
 	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
 	{ }
 };
-- 
2.34.1

