Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF854615EBB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiKBJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiKBJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:02:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64683286D5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:01:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5so10231149wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGxrVhiJog6cCrvFJyjRDALKwnKqI8styrZPsF0tpuc=;
        b=kjwpxsOgQwE9alprOtJ0BTkuMscZHfa0/qF8YpaFy718J9rnASNG8RqGiBb7tVuR+J
         +ntSZhm7Ehz6yCJm8Gog01fOFoCnqNr3LCYSpCPRkfubOlFMaOC5jqJRj6yKLbViAbDg
         gjoGQT1x1Ch4FSdz0aeC1X/TBV0wPW9wwMSBSIIdL365DhTWGe1oXxfy1sNjy4URkc9A
         r8o2L007YVyaLb6JoFrWL+AfRjjhY1bmlkmud26QsHSiJDKmhnc0HLQDeXn5oZDthqrN
         NoG7vg69uNQHfYoLUeiEYSZ7zOb2gF39qVUvv7xi5yq3pmbADF61zMDfG3EoNTQOYtBc
         tdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGxrVhiJog6cCrvFJyjRDALKwnKqI8styrZPsF0tpuc=;
        b=eri76K6eU0L6noH7QpT4F8UDqt4cY8DfYet+EQpy8mulfmFwUwAfDlYK+P9bnLPY4H
         nGb7whELaXwaH8FfSJ3y7qTV5tGnsqVZPO5K7p0SbLlolUiuxuY+gl4ttq83GW6BGnj5
         c2MP/DMXYtq8i/oealHorqKsajf9TSHzx4EqrwNCufJ0CY3ZBSTiFHortU8004eNismD
         VKROgSlxa9xLt2GPYiyEac4awLtPvcMrF6Gtc3/V9R86FM6TlAMc/GT31b5mtyL5IUk9
         Vx4DPP+nOJEvreY60dMdXrEWAuO0g5jMMJEXZcOom+Gi7XDy4UXa5oNu2lC8A9dhP1kv
         TXLw==
X-Gm-Message-State: ACrzQf26hUjms86/pAVYUcYeOsGZoce2k8bzL4jQ4/0OetlA+GfFSZo7
        fYyO1qlW7EnBOvb1/TGj/1bIWA==
X-Google-Smtp-Source: AMsMyM4MC0JGcTklkwECadkBDppF5ZEhGBwjMvkfsMCRbvsYjvboD+bjpdL5KkOk74CFY7+IwmmORA==
X-Received: by 2002:a05:600c:4618:b0:3cf:54ad:7bb3 with SMTP id m24-20020a05600c461800b003cf54ad7bb3mr20940293wmo.4.1667379711970;
        Wed, 02 Nov 2022 02:01:51 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id bd26-20020a05600c1f1a00b003cf6c2f9513sm1425322wmb.2.2022.11.02.02.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:01:51 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        dmitry.baryshkov@linaro.org, Jonathan Marek <jonathan@marek.ca>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v2 4/5] clk: qcom: dispcc-sm8250: Add missing EDP clocks for sm8350
Date:   Wed,  2 Nov 2022 10:01:39 +0100
Message-Id: <20221102090140.965450-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102090140.965450-1-robert.foss@linaro.org>
References: <20221102090140.965450-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8350 supports embedded displayport, but the clocks for this
were previously not accounted for.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8250.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index a7606580cf22..d2aaa44ed3d4 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -462,6 +462,20 @@ static struct clk_branch disp_cc_mdss_edp_link_clk = {
 	},
 };
 
+static struct clk_regmap_div disp_cc_mdss_edp_link_div_clk_src = {
+	.reg = 0x2288,
+	.shift = 0,
+	.width = 2,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "disp_cc_mdss_edp_link_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&disp_cc_mdss_edp_link_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
 static struct clk_branch disp_cc_mdss_edp_link_intf_clk = {
 	.halt_reg = 0x2074,
 	.halt_check = BRANCH_HALT,
@@ -471,7 +485,7 @@ static struct clk_branch disp_cc_mdss_edp_link_intf_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "disp_cc_mdss_edp_link_intf_clk",
 			.parent_hws = (const struct clk_hw*[]){
-				&disp_cc_mdss_edp_link_clk_src.clkr.hw,
+				&disp_cc_mdss_edp_link_div_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_GET_RATE_NOCACHE,
@@ -1175,6 +1189,7 @@ static struct clk_regmap *disp_cc_sm8250_clocks[] = {
 	[DISP_CC_MDSS_EDP_GTC_CLK_SRC] = &disp_cc_mdss_edp_gtc_clk_src.clkr,
 	[DISP_CC_MDSS_EDP_LINK_CLK] = &disp_cc_mdss_edp_link_clk.clkr,
 	[DISP_CC_MDSS_EDP_LINK_CLK_SRC] = &disp_cc_mdss_edp_link_clk_src.clkr,
+	[DISP_CC_MDSS_EDP_LINK_DIV_CLK_SRC] = &disp_cc_mdss_edp_link_div_clk_src.clkr,
 	[DISP_CC_MDSS_EDP_LINK_INTF_CLK] = &disp_cc_mdss_edp_link_intf_clk.clkr,
 	[DISP_CC_MDSS_EDP_PIXEL_CLK] = &disp_cc_mdss_edp_pixel_clk.clkr,
 	[DISP_CC_MDSS_EDP_PIXEL_CLK_SRC] = &disp_cc_mdss_edp_pixel_clk_src.clkr,
@@ -1285,7 +1300,11 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 			&disp_cc_mdss_dp_pixel1_clk_src,
 			&disp_cc_mdss_dp_pixel2_clk_src,
 			&disp_cc_mdss_dp_pixel_clk_src,
+			&disp_cc_mdss_edp_aux_clk_src,
+			&disp_cc_mdss_edp_link_clk_src,
+			&disp_cc_mdss_edp_pixel_clk_src,
 			&disp_cc_mdss_esc0_clk_src,
+			&disp_cc_mdss_esc1_clk_src,
 			&disp_cc_mdss_mdp_clk_src,
 			&disp_cc_mdss_pclk0_clk_src,
 			&disp_cc_mdss_pclk1_clk_src,
@@ -1297,6 +1316,7 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 			&disp_cc_mdss_byte1_div_clk_src,
 			&disp_cc_mdss_dp_link1_div_clk_src,
 			&disp_cc_mdss_dp_link_div_clk_src,
+			&disp_cc_mdss_edp_link_div_clk_src,
 		};
 		unsigned int i;
 		static bool offset_applied;
-- 
2.34.1

