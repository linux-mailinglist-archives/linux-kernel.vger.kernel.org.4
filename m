Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A6E7461D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGCSJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGCSJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:09:14 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71164E7B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:09:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b69a48368fso73266801fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688407748; x=1690999748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqW9M2dFn1ZjAqPjCzlM+kpDwzNfPSt+HCWXrNSekXU=;
        b=f8+qdZv0RtZ+fDx65C1Deda3yavnCaD9cBWp/8GLIU1CiuD5969J2pG0Nd3lU+OrBp
         NPpZ19Eahtb+Uek8MmRJ5F0VsMeWn/k06DsfHhrCO/C2nltweMGIaEbCgBaefipSDrB4
         FhJ7l69oKwnoSANlw48PPXzde+Hpvw2XAlhepZr7nyFS/vMNrsjIRk9kpxGC7oHp6WEy
         t3PHzXkECnMzECGk0tTUgNo2y1v4OEzEK413cLj+8Ze4aApb4mVo1N5Nw9mstsAg39bF
         L0jPHujFXzp215wclWaHt6v7wIwh1PgqK8eeAC/66+ov/Wgekj/BWJanBQb9HqUkQb2A
         8cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407748; x=1690999748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqW9M2dFn1ZjAqPjCzlM+kpDwzNfPSt+HCWXrNSekXU=;
        b=fihfG/PlpdF7lJZCRXAG4DtK6k/d6unvcRK66B2YYRRD7YEuCnTmqS7LWQ87wOP4Ge
         3luYMHjbTXmUKSP7bzQuIce8Ej/qwMIJt5Inbs7QyIXlp9RJu3Qa/lKbCVt0h6YNxNyI
         Hf1/45t7SaP0qF6uGudDvbWUVTfP+QzE2/vVrmmcA3uOSbvTu15y1mdsz3E5XqyKofwR
         e1oDVVtLa2z8iy+Txmo2AsKxjh8Ec2iIZWn3GQpSZnbLABO17UqCHBM1S8dq94nLtnXn
         XHGFXwGLTElu1DDz6XjtM+UIfa8miwmTE64/diE2rZMiIcMUaA71xce2zun/sfoitjXm
         P5tQ==
X-Gm-Message-State: ABy/qLanLv9+4ywF5MBlPfBhZGOu6aUsIRLRXBcsE30NMPwM4YOPgtTG
        1lGrHzkF6J89MTEouz1f4FzlXw==
X-Google-Smtp-Source: APBJJlGu7JnhD5pgBRBgwJ8KhvEWkjVOGYWIScNa1OUFPNnLltk5NIocRFmliWckiDTbSZSYq386mQ==
X-Received: by 2002:a2e:9610:0:b0:2b6:d8ea:6650 with SMTP id v16-20020a2e9610000000b002b6d8ea6650mr5018708ljh.27.1688407747826;
        Mon, 03 Jul 2023 11:09:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id l17-20020a2ea311000000b002b690038aecsm5241157lje.112.2023.07.03.11.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:09:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Jul 2023 20:09:02 +0200
Subject: [PATCH 2/2] clk: qcom: videocc-sm8350: Add SC8280XP support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230703-topic-8280_videocc-v1-2-8959d4d0a93e@linaro.org>
References: <20230703-topic-8280_videocc-v1-0-8959d4d0a93e@linaro.org>
In-Reply-To: <20230703-topic-8280_videocc-v1-0-8959d4d0a93e@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688407743; l=3909;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TLaUxadYZTWfsq27UTIEE557pAqOizJ94PYvKkKz/Tk=;
 b=WpQTvAiTPbU+d9NEGQZPzx8s4qYWxW1WwgqfxJ9tIftvA1VT6QJgEH0gYt2MB4hn72/Nvc1bj
 bURoR3tW8r9CUuamy7C14ia9csa/uKVnHEXN2LNkOUG7dKYqK7YHADM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC8280XP, being a partial derivative of SM8350, shares almost the exact
same videocc block. Extend the 8350 driver to support the bigger brother.

The only notable changes are higher possible frequencies on some clocks
and some switcheroo within the XO/sleep registers (probably due to some
different board crystal configuration).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/videocc-sm8350.c | 42 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc-sm8350.c
index b148877fc73d..581ad4440615 100644
--- a/drivers/clk/qcom/videocc-sm8350.c
+++ b/drivers/clk/qcom/videocc-sm8350.c
@@ -41,6 +41,10 @@ static const struct pll_vco lucid_5lpe_vco[] = {
 	{ 249600000, 1750000000, 0 },
 };
 
+static const struct pll_vco lucid_5lpe_vco_8280[] = {
+	{ 249600000, 1800000000, 0 },
+};
+
 static const struct alpha_pll_config video_pll0_config = {
 	.l = 0x25,
 	.alpha = 0x8000,
@@ -159,6 +163,16 @@ static const struct freq_tbl ftbl_video_cc_mvs0_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_video_cc_mvs0_clk_src_8280[] = {
+	F(720000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1014000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1098000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1332000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1599000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
+	F(1680000000, P_VIDEO_PLL0_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 video_cc_mvs0_clk_src = {
 	.cmd_rcgr = 0xb94,
 	.mnd_width = 0,
@@ -181,6 +195,15 @@ static const struct freq_tbl ftbl_video_cc_mvs1_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_video_cc_mvs1_clk_src_8280[] = {
+	F(840000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1098000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1332000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1600000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
+	F(1800000000, P_VIDEO_PLL1_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
 static struct clk_rcg2 video_cc_mvs1_clk_src = {
 	.cmd_rcgr = 0xbb4,
 	.mnd_width = 0,
@@ -499,6 +522,7 @@ static struct qcom_cc_desc video_cc_sm8350_desc = {
 
 static int video_cc_sm8350_probe(struct platform_device *pdev)
 {
+	u32 video_cc_xo_clk_cbcr = 0xeec;
 	struct regmap *regmap;
 	int ret;
 
@@ -510,6 +534,21 @@ static int video_cc_sm8350_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sc8280xp-videocc")) {
+		video_cc_sleep_clk_src.cmd_rcgr = 0xf38;
+		video_cc_sleep_clk.halt_reg = 0xf58;
+		video_cc_sleep_clk.clkr.enable_reg = 0xf58;
+		video_cc_xo_clk_src.cmd_rcgr = 0xf14;
+		video_cc_xo_clk_cbcr = 0xf34;
+
+		video_pll0.vco_table = video_pll1.vco_table = lucid_5lpe_vco_8280;
+		/* No change, but assign it for completeness */
+		video_pll0.num_vco = video_pll1.num_vco = ARRAY_SIZE(lucid_5lpe_vco_8280);
+
+		video_cc_mvs0_clk_src.freq_tbl = ftbl_video_cc_mvs0_clk_src_8280;
+		video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_8280;
+	}
+
 	regmap = qcom_cc_map(pdev, &video_cc_sm8350_desc);
 	if (IS_ERR(regmap)) {
 		pm_runtime_put(&pdev->dev);
@@ -525,7 +564,7 @@ static int video_cc_sm8350_probe(struct platform_device *pdev)
 	 *      video_cc_xo_clk
 	 */
 	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
+	regmap_update_bits(regmap, video_cc_xo_clk_cbcr, BIT(0), BIT(0));
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8350_desc, regmap);
 	pm_runtime_put(&pdev->dev);
@@ -534,6 +573,7 @@ static int video_cc_sm8350_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id video_cc_sm8350_match_table[] = {
+	{ .compatible = "qcom,sc8280xp-videocc" },
 	{ .compatible = "qcom,sm8350-videocc" },
 	{ }
 };

-- 
2.41.0

