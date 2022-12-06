Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C5A644EAC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiLFWpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiLFWp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:45:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933B61C121
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 14:45:26 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s5so22424769edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 14:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGLwUiqnWNNCSh7SfaJVMgmwcN3tXBqQdd3/EujPmbQ=;
        b=USNBxSGKBn5FbHuXELI8G7fD4ra27dG0EDBfWENVl3aOtZ1V29g1iNZttBlLKDi7yB
         k57VcrNQNxkQPSou/PO+x5oUExqj+06Ga7LoyFo/UqT2BxkV8O832Gco9Ms9K9Rm8kRn
         DMy5hc7uX44oQC22yYVKkIhI4XKLmxiJh7tXCOus4TTKlTwygrCCwyFUlXAj/zHSD/JR
         qa2rNeRyglgUeBcXFzVxZ+RFbxJzSpaXYdYCn2/e4qbXUkvk8YpfXA4JBwektxcAcYIH
         V8pdn6t2RO+gqO8ZaWn/SrJJwIhBFyL3vQCAKiqXM6pP7AgDuwmno/MFeBr8bBSUq/td
         WgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGLwUiqnWNNCSh7SfaJVMgmwcN3tXBqQdd3/EujPmbQ=;
        b=1sgg25qg/cSW0RFt0G+f4ohXbUeiJO72XNipGTk35/yQk+aD822F8QxyUSN3mklhTM
         vcG059ng30OV1L59QQ+cF5udF2PaejDp9qk9PYR4aJkuNFuvuS97y6KkDmB/0c7Oog5g
         r9RG1B1hBw+5rPk9T5dzph9rsortu3Bk4abzkqt6B4TdyrNOU2R1/52SzAxTyiOvZJzw
         ipRh4WwJmrGwnErmjaPf/I/GA7OtCWuMIhge54gPTthP74VF5nbwfbdUUVJbHu4tQVpv
         ys28W6vFhClWnYs34dwomJivuLpio0Nd8MksyUClo43KuWZbdaN+TAn/UYeehPB4TOFS
         OZKA==
X-Gm-Message-State: ANoB5pkefc5Iu55lPsl8RrFhrHF2klcu2EUAmmfCwMFT8L/H5OFggR2a
        tifQ88G5uX44gv99TK2Y9cQfvA==
X-Google-Smtp-Source: AA0mqf6C4ThccuZCos4zGz4SWn/wLPO3ZEXrf0Q1qns78ECCAqldPgIVe+m0DaeZHlkImyEU5mJkSQ==
X-Received: by 2002:a05:6402:3c1:b0:46b:2d74:d970 with SMTP id t1-20020a05640203c100b0046b2d74d970mr36829012edw.138.1670366725127;
        Tue, 06 Dec 2022 14:45:25 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709061bb100b007c0985aa6b0sm7820772ejg.191.2022.12.06.14.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 14:45:24 -0800 (PST)
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
Subject: [PATCH v6 4/5] clk: qcom: rpmh: Add support for SM8550 rpmh clocks
Date:   Wed,  7 Dec 2022 00:45:14 +0200
Message-Id: <20221206224515.1495457-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206224515.1495457-1-abel.vesa@linaro.org>
References: <20221206224515.1495457-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

