Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D1E746227
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGCSU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGCSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:20:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AC2E6D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:20:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b6adef5c22so73346751fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688408415; x=1691000415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgXZ+eRdRJHN8xsGvQGmmBaJDurThI2IbqW/jpkrGj0=;
        b=uceXZfbYZOlKkij7wFKMEyEmOpiTzp3vyUd3NWusgPamjZjrHdpgJB50UATD5qUJVN
         yp9pOw3lJ8SjlVVYm3i9XTH4z67lRQT9XmOFr7EK/+QEn1B6pJDUG73+Fk6XQW/t23a2
         v09orOz49sLAu/xYaPDQBEPMjCS1afCRFuR+6U78OnhG8jZvNRC5lXe/en01U6Gg1WjL
         cR/IIlBbTerGBIy2WAlGeTDhO/9b5YhATd9fyCETx5k0HZbk0ht0bbpSYpR6r3Gp5+fp
         f7D1r7AhCXIxdpsTXe8BO2DYWL2ll75pKS9vibr74/hVWcznEJImkXoQYS89pdVafroc
         C2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688408415; x=1691000415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgXZ+eRdRJHN8xsGvQGmmBaJDurThI2IbqW/jpkrGj0=;
        b=IcdtuUIYSN4Yxxp18I069BZKM3KjFJSqSAniIVGgOw/3FqarEdGuGHaE0mrSDzMO/U
         vnQ4oQ76Q0Srpa37F7TgVL6kWQO0bCECscz8Rg14Ijei5YWifO+OGw0ftjqI9Ce2m2vk
         j6citQ6SmDBvwOKNBLV1iPmsxXpAxIIGUtx28q880zuuAy+lYhP0iJ7xT/eeii4+LYGE
         BUC2ZscAV9DlfggFG2SM264JizFLkrGidO8smpHcQ957hQB4Zz3UoTZdNM+RLxlFL8o+
         ohVh+SwPmZTTzFNAji7ntrDqtEHFomozQjHQBccaZ+TSsQlyS3D/bz1etDHkDKq2Kvp8
         6yZg==
X-Gm-Message-State: ABy/qLbMLo+gfDug0WLaaRXcL58CMSGu4OR3zohTI1Py37J+f/MtxZKV
        9H3VYcGxxjkm6w5WgY/NwXUAmQ==
X-Google-Smtp-Source: APBJJlGO0FKQ32so8WWSWQSzDz/qJL9MkbQlG8vOXtueV2IcSk0985GL6XUv9PMX3DwtmNejitKBIQ==
X-Received: by 2002:a2e:9143:0:b0:2b4:6eb0:2a27 with SMTP id q3-20020a2e9143000000b002b46eb02a27mr8806972ljg.17.1688408415010;
        Mon, 03 Jul 2023 11:20:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e9c09000000b002b6995f38a2sm4946224lji.100.2023.07.03.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:20:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Jul 2023 20:20:08 +0200
Subject: [PATCH v2 4/8] clk: qcom: mmcc-msm8998: Properly consume GPLL0
 inputs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-8998clk-v2-4-6222fbc2916b@linaro.org>
References: <20230622-topic-8998clk-v2-0-6222fbc2916b@linaro.org>
In-Reply-To: <20230622-topic-8998clk-v2-0-6222fbc2916b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688408407; l=4937;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=pNpFd/werWG+oLvuHHpeYrlGmkALZ/dmf7xfH7d+kHc=;
 b=VW4i1+gxxDJfK3DsiUrdpLeAHClFLSCtu4j6f+S5L06ubK/8moZi9q4rRdK2cSupBisds/iH7
 KHuuZiZqwb6AZ12Wzu9X4/WrbFYWG53iiaAox16NU35zKUvncwcDm8W
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

Up until now, the GPLL0_DIV MMSS input has been modeled as a fixed
child of MMSS_GPLL0_DIV that's always-on. Properly representing the
former in the GCC driver makes us unable to keep doing so.

Consume MSS_GPLL0_DIV through fw_name ("gpll0_div") as well as add a
fixed .name link to keep backwards compatibility.

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/mmcc-msm8998.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index 4490594bde69..040c495e91e4 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -46,19 +46,6 @@ enum {
 	P_DPLINK,
 };
 
-static struct clk_fixed_factor gpll0_div = {
-	.mult = 1,
-	.div = 2,
-	.hw.init = &(struct clk_init_data){
-		.name = "mmss_gpll0_div",
-		.parent_data = &(const struct clk_parent_data){
-			.fw_name = "gpll0"
-		},
-		.num_parents = 1,
-		.ops = &clk_fixed_factor_ops,
-	},
-};
-
 static const struct clk_div_table post_div_table_fabia_even[] = {
 	{ 0x0, 1 },
 	{ 0x1, 2 },
@@ -354,7 +341,7 @@ static const struct parent_map mmss_xo_gpll0_gpll0_div_map[] = {
 static const struct clk_parent_data mmss_xo_gpll0_gpll0_div[] = {
 	{ .fw_name = "xo" },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_gpll0_gpll0_div_map[] = {
@@ -368,7 +355,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_gpll0_gpll0_div[] = {
 	{ .fw_name = "xo" },
 	{ .hw = &mmpll0_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_mmpll1_gpll0_gpll0_div_map[] = {
@@ -384,7 +371,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_mmpll1_gpll0_gpll0_div[] = {
 	{ .hw = &mmpll0_out_even.clkr.hw },
 	{ .hw = &mmpll1_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_mmpll5_gpll0_gpll0_div_map[] = {
@@ -400,7 +387,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_mmpll5_gpll0_gpll0_div[] = {
 	{ .hw = &mmpll0_out_even.clkr.hw },
 	{ .hw = &mmpll5_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div_map[] = {
@@ -418,7 +405,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_mmpll3_mmpll6_gpll0_gpll0_div
 	{ .hw = &mmpll3_out_even.clkr.hw },
 	{ .hw = &mmpll6_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map[] = {
@@ -436,7 +423,7 @@ static const struct clk_parent_data mmss_xo_mmpll4_mmpll7_mmpll10_gpll0_gpll0_di
 	{ .hw = &mmpll7_out_even.clkr.hw },
 	{ .hw = &mmpll10_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_mmpll7_mmpll10_gpll0_gpll0_div_map[] = {
@@ -454,7 +441,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_mmpll7_mmpll10_gpll0_gpll0_di
 	{ .hw = &mmpll7_out_even.clkr.hw },
 	{ .hw = &mmpll10_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static const struct parent_map mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map[] = {
@@ -474,7 +461,7 @@ static const struct clk_parent_data mmss_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_g
 	{ .hw = &mmpll7_out_even.clkr.hw },
 	{ .hw = &mmpll10_out_even.clkr.hw },
 	{ .fw_name = "gpll0" },
-	{ .hw = &gpll0_div.hw },
+	{ .fw_name = "gpll0_div", .name = "gcc_mmss_gpll0_div_clk" },
 };
 
 static struct clk_rcg2 byte0_clk_src = {
@@ -2544,10 +2531,6 @@ static struct clk_branch vmem_ahb_clk = {
 	},
 };
 
-static struct clk_hw *mmcc_msm8998_hws[] = {
-	&gpll0_div.hw,
-};
-
 static struct gdsc video_top_gdsc = {
 	.gdscr = 0x1024,
 	.pd = {
@@ -2855,8 +2838,6 @@ static const struct qcom_cc_desc mmcc_msm8998_desc = {
 	.num_resets = ARRAY_SIZE(mmcc_msm8998_resets),
 	.gdscs = mmcc_msm8998_gdscs,
 	.num_gdscs = ARRAY_SIZE(mmcc_msm8998_gdscs),
-	.clk_hws = mmcc_msm8998_hws,
-	.num_clk_hws = ARRAY_SIZE(mmcc_msm8998_hws),
 };
 
 static const struct of_device_id mmcc_msm8998_match_table[] = {

-- 
2.41.0

