Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1F869695E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBNQYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjBNQXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:23:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72701A972
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id eq11so18178999edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7tABhwaxV7j/C8D3NavXjowVkv++pt1aFy4LTglkV4=;
        b=XVwRP+hEvd+qjCKkP+0IIWXy+QMu65dHZH9mOAoGF6kHXuYOLc5DFHh9eOR/V61+x8
         30OHezC3X/3Fu+JfC31FWuj3S5ZcRxjaKxsxCCaic4Em4I0tkpVjDjkC12HUsgKf9lzs
         FXt4k0gO73yvR7Ru2derbFXoaIkkHC3XVaLxcH3RSNU9XqFx0KxeV5Gnwu7e2ca/TcBH
         S4r1m2QlobV3sbYAOCM8vIhAyQ/VULwuACkZvCPU/HT1aX5f9TVLB43/QqjdZDBJFneZ
         lYeJ9Y2/VGUqTh+23Ws3EKo7PH3xiDIiCbGxmUECY9vI3kt6L1vZnlzRMBJJ/jU02z92
         VKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7tABhwaxV7j/C8D3NavXjowVkv++pt1aFy4LTglkV4=;
        b=Qgo+p8GopjIyJLjtzbqBrHUtYTBK2O/Y8PqvvhswQaURZIvxOULEcr+SVSJSEID8Pz
         geRrGQQqVUWBPNkF1owRraBq3IhMi98yRdhnceCipAW47v8tWH0XfuuoxAUUr9g6gcfJ
         vhS0s4j0jFuFxnp1FdWdsx3doOBq2vVdWZLPdWl7mrLKa+MK4G88CehPSY6ya12YMo+S
         zpmERUeEQqZqf7zCiu5bksL1Fg53HCIcPmd1YveY0KFp+ZfOvfSdbn5n3QreIPvzS3HL
         kK6Xku77Hecom/B6sglrPfFjN00winvhP0qaYCgLUX2qlp3Ar0VGlYOvRLHcxoLqPZy/
         GkLQ==
X-Gm-Message-State: AO0yUKVAMyG2N3HAmnTBibCv8RhmDPLIgwx7atoDeNyxytgVyIyVy4ek
        aWwAZekTgM1KwHKXEMI2RUMqsQ==
X-Google-Smtp-Source: AK7set9jo2uqNTOZ1Oh1xZ262fpL3k4m9D9IzcgOC3FvKV2LiQ5JNvEWxPCyPks2nVczTElj/2hRaA==
X-Received: by 2002:a50:a418:0:b0:49d:a60f:7827 with SMTP id u24-20020a50a418000000b0049da60f7827mr3151999edb.6.1676391815153;
        Tue, 14 Feb 2023 08:23:35 -0800 (PST)
Received: from fedora.. (cpezg-94-253-130-165-cbl.xnet.hr. [94.253.130.165])
        by smtp.googlemail.com with ESMTPSA id bp8-20020a170907918800b008806a3c22c5sm1318027ejb.25.2023.02.14.08.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:23:34 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 7/7] clk: qcom: gcc-ipq4019: convert to parent data
Date:   Tue, 14 Feb 2023 17:23:25 +0100
Message-Id: <20230214162325.312057-7-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214162325.312057-1-robert.marko@sartura.hr>
References: <20230214162325.312057-1-robert.marko@sartura.hr>
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

Convert the IPQ4019 GCC driver to use parent data instead of global
name matching.

Utilize ARRAY_SIZE for num_parents instead of hardcoding the value.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/qcom/gcc-ipq4019.c | 480 +++++++++++++++------------------
 1 file changed, 222 insertions(+), 258 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
index f2728dc1e5521..b1a8af01ef7da 100644
--- a/drivers/clk/qcom/gcc-ipq4019.c
+++ b/drivers/clk/qcom/gcc-ipq4019.c
@@ -77,99 +77,12 @@ struct clk_fepll {
 	const struct freq_tbl *freq_tbl;
 };
 
-static struct parent_map gcc_xo_200_500_map[] = {
-	{ P_XO, 0 },
-	{ P_FEPLL200, 1 },
-	{ P_FEPLL500, 2 },
-};
-
-static const char * const gcc_xo_200_500[] = {
-	"xo",
-	"fepll200",
-	"fepll500",
-};
-
-static struct parent_map gcc_xo_200_map[] = {
-	{  P_XO, 0 },
-	{  P_FEPLL200, 1 },
-};
-
-static const char * const gcc_xo_200[] = {
-	"xo",
-	"fepll200",
-};
-
-static struct parent_map gcc_xo_200_spi_map[] = {
-	{  P_XO, 0 },
-	{  P_FEPLL200, 2 },
-};
-
-static const char * const gcc_xo_200_spi[] = {
-	"xo",
-	"fepll200",
-};
-
-static struct parent_map gcc_xo_sdcc1_500_map[] = {
-	{  P_XO, 0 },
-	{  P_DDRPLL, 1 },
-	{  P_FEPLL500, 2 },
-};
-
-static const char * const gcc_xo_sdcc1_500[] = {
-	"xo",
-	"ddrpllsdcc",
-	"fepll500",
-};
-
-static struct parent_map gcc_xo_wcss2g_map[] = {
-	{  P_XO, 0 },
-	{  P_FEPLLWCSS2G, 1 },
-};
-
-static const char * const gcc_xo_wcss2g[] = {
-	"xo",
-	"fepllwcss2g",
-};
-
-static struct parent_map gcc_xo_wcss5g_map[] = {
-	{  P_XO, 0 },
-	{  P_FEPLLWCSS5G, 1 },
-};
-
-static const char * const gcc_xo_wcss5g[] = {
-	"xo",
-	"fepllwcss5g",
-};
-
-static struct parent_map gcc_xo_125_dly_map[] = {
-	{  P_XO, 0 },
-	{  P_FEPLL125DLY, 1 },
-};
-
-static const char * const gcc_xo_125_dly[] = {
-	"xo",
-	"fepll125dly",
-};
-
-static struct parent_map gcc_xo_ddr_500_200_map[] = {
-	{  P_XO, 0 },
-	{  P_FEPLL200, 3 },
-	{  P_FEPLL500, 2 },
-	{  P_DDRPLLAPSS, 1 },
-};
-
 /*
  * Contains index for safe clock during APSS freq change.
  * fepll500 is being used as safe clock so initialize it
  * with its index in parents list gcc_xo_ddr_500_200.
  */
 static const int gcc_ipq4019_cpu_safe_parent = 2;
-static const char * const gcc_xo_ddr_500_200[] = {
-	"xo",
-	"fepll200",
-	"fepll500",
-	"ddrpllapss",
-};
 
 /* Calculates the VCO rate for FEPLL. */
 static u64 clk_fepll_vco_calc_rate(struct clk_fepll *pll_div,
@@ -499,6 +412,18 @@ static struct clk_fepll gcc_fepllwcss5g_clk = {
 	.pll_vco = &gcc_fepll_vco,
 };
 
+static struct parent_map gcc_xo_200_500_map[] = {
+	{ P_XO, 0 },
+	{ P_FEPLL200, 1 },
+	{ P_FEPLL500, 2 },
+};
+
+static const struct clk_parent_data gcc_xo_200_500[] = {
+	{ .fw_name = "xo", .name = "xo" },
+	{ .hw = &gcc_fepll200_clk.cdiv.clkr.hw },
+	{ .hw = &gcc_fepll500_clk.cdiv.clkr.hw },
+};
+
 static const struct freq_tbl ftbl_gcc_pcnoc_ahb_clk[] = {
 	F(48000000,  P_XO,	 1, 0, 0),
 	F(100000000, P_FEPLL200, 2, 0, 0),
@@ -512,8 +437,8 @@ static struct clk_rcg2 gcc_pcnoc_ahb_clk_src = {
 	.freq_tbl = ftbl_gcc_pcnoc_ahb_clk,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcnoc_ahb_clk_src",
-		.parent_names = gcc_xo_200_500,
-		.num_parents = 3,
+		.parent_data = gcc_xo_200_500,
+		.num_parents = ARRAY_SIZE(gcc_xo_200_500),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -525,9 +450,8 @@ static struct clk_branch pcnoc_clk_src = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcnoc_clk_src",
-			.parent_names = (const char *[]){
-				"gcc_pcnoc_ahb_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&gcc_pcnoc_ahb_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT |
@@ -536,6 +460,16 @@ static struct clk_branch pcnoc_clk_src = {
 	},
 };
 
+static struct parent_map gcc_xo_200_map[] = {
+	{  P_XO, 0 },
+	{  P_FEPLL200, 1 },
+};
+
+static const struct clk_parent_data gcc_xo_200[] = {
+	{ .fw_name = "xo", .name = "xo" },
+	{ .hw = &gcc_fepll200_clk.cdiv.clkr.hw },
+};
+
 static const struct freq_tbl ftbl_gcc_audio_pwm_clk[] = {
 	F(48000000, P_XO, 1, 0, 0),
 	F(200000000, P_FEPLL200, 1, 0, 0),
@@ -549,8 +483,8 @@ static struct clk_rcg2 audio_clk_src = {
 	.freq_tbl = ftbl_gcc_audio_pwm_clk,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "audio_clk_src",
-		.parent_names = gcc_xo_200,
-		.num_parents = 2,
+		.parent_data = gcc_xo_200,
+		.num_parents = ARRAY_SIZE(gcc_xo_200),
 		.ops = &clk_rcg2_ops,
 
 	},
@@ -563,9 +497,8 @@ static struct clk_branch gcc_audio_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_audio_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.flags = CLK_SET_RATE_PARENT,
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -580,9 +513,8 @@ static struct clk_branch gcc_audio_pwm_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_audio_pwm_clk",
-			.parent_names = (const char *[]){
-				"audio_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&audio_clk_src.clkr.hw },
 			.flags = CLK_SET_RATE_PARENT,
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -602,8 +534,8 @@ static struct clk_rcg2 blsp1_qup1_i2c_apps_clk_src = {
 	.freq_tbl = ftbl_gcc_blsp1_qup1_2_i2c_apps_clk,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "blsp1_qup1_i2c_apps_clk_src",
-		.parent_names = gcc_xo_200,
-		.num_parents = 2,
+		.parent_data = gcc_xo_200,
+		.num_parents = ARRAY_SIZE(gcc_xo_200),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -615,9 +547,8 @@ static struct clk_branch gcc_blsp1_qup1_i2c_apps_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_blsp1_qup1_i2c_apps_clk",
-			.parent_names = (const char *[]){
-				"blsp1_qup1_i2c_apps_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&blsp1_qup1_i2c_apps_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -632,8 +563,8 @@ static struct clk_rcg2 blsp1_qup2_i2c_apps_clk_src = {
 	.freq_tbl = ftbl_gcc_blsp1_qup1_2_i2c_apps_clk,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "blsp1_qup2_i2c_apps_clk_src",
-		.parent_names = gcc_xo_200,
-		.num_parents = 2,
+		.parent_data = gcc_xo_200,
+		.num_parents = ARRAY_SIZE(gcc_xo_200),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -645,9 +576,8 @@ static struct clk_branch gcc_blsp1_qup2_i2c_apps_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_blsp1_qup2_i2c_apps_clk",
-			.parent_names = (const char *[]){
-				"blsp1_qup2_i2c_apps_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&blsp1_qup2_i2c_apps_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -655,6 +585,16 @@ static struct clk_branch gcc_blsp1_qup2_i2c_apps_clk = {
 	},
 };
 
+static struct parent_map gcc_xo_200_spi_map[] = {
+	{  P_XO, 0 },
+	{  P_FEPLL200, 2 },
+};
+
+static const struct clk_parent_data gcc_xo_200_spi[] = {
+	{ .fw_name = "xo", .name = "xo" },
+	{ .hw = &gcc_fepll200_clk.cdiv.clkr.hw },
+};
+
 static const struct freq_tbl ftbl_gcc_blsp1_qup1_2_spi_apps_clk[] = {
 	F(960000, P_XO, 12, 1, 4),
 	F(4800000, P_XO, 1, 1, 10),
@@ -674,8 +614,8 @@ static struct clk_rcg2 blsp1_qup1_spi_apps_clk_src = {
 	.freq_tbl = ftbl_gcc_blsp1_qup1_2_spi_apps_clk,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "blsp1_qup1_spi_apps_clk_src",
-		.parent_names = gcc_xo_200_spi,
-		.num_parents = 2,
+		.parent_data = gcc_xo_200_spi,
+		.num_parents = ARRAY_SIZE(gcc_xo_200_spi),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -687,9 +627,8 @@ static struct clk_branch gcc_blsp1_qup1_spi_apps_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_blsp1_qup1_spi_apps_clk",
-			.parent_names = (const char *[]){
-				"blsp1_qup1_spi_apps_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&blsp1_qup1_spi_apps_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -705,8 +644,8 @@ static struct clk_rcg2 blsp1_qup2_spi_apps_clk_src = {
 	.parent_map = gcc_xo_200_spi_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "blsp1_qup2_spi_apps_clk_src",
-		.parent_names = gcc_xo_200_spi,
-		.num_parents = 2,
+		.parent_data = gcc_xo_200_spi,
+		.num_parents = ARRAY_SIZE(gcc_xo_200_spi),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -718,9 +657,8 @@ static struct clk_branch gcc_blsp1_qup2_spi_apps_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_blsp1_qup2_spi_apps_clk",
-			.parent_names = (const char *[]){
-				"blsp1_qup2_spi_apps_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&blsp1_qup2_spi_apps_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -750,8 +688,8 @@ static struct clk_rcg2 blsp1_uart1_apps_clk_src = {
 	.parent_map = gcc_xo_200_spi_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "blsp1_uart1_apps_clk_src",
-		.parent_names = gcc_xo_200_spi,
-		.num_parents = 2,
+		.parent_data = gcc_xo_200_spi,
+		.num_parents = ARRAY_SIZE(gcc_xo_200_spi),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -763,9 +701,8 @@ static struct clk_branch gcc_blsp1_uart1_apps_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_blsp1_uart1_apps_clk",
-			.parent_names = (const char *[]){
-				"blsp1_uart1_apps_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&blsp1_uart1_apps_clk_src.clkr.hw },
 			.flags = CLK_SET_RATE_PARENT,
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -781,8 +718,8 @@ static struct clk_rcg2 blsp1_uart2_apps_clk_src = {
 	.parent_map = gcc_xo_200_spi_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "blsp1_uart2_apps_clk_src",
-		.parent_names = gcc_xo_200_spi,
-		.num_parents = 2,
+		.parent_data = gcc_xo_200_spi,
+		.num_parents = ARRAY_SIZE(gcc_xo_200_spi),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -794,9 +731,8 @@ static struct clk_branch gcc_blsp1_uart2_apps_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_blsp1_uart2_apps_clk",
-			.parent_names = (const char *[]){
-				"blsp1_uart2_apps_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&blsp1_uart2_apps_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -819,8 +755,8 @@ static struct clk_rcg2 gp1_clk_src = {
 	.parent_map = gcc_xo_200_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gp1_clk_src",
-		.parent_names = gcc_xo_200,
-		.num_parents = 2,
+		.parent_data = gcc_xo_200,
+		.num_parents = ARRAY_SIZE(gcc_xo_200),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -832,9 +768,8 @@ static struct clk_branch gcc_gp1_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gp1_clk",
-			.parent_names = (const char *[]){
-				"gp1_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&gp1_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -850,8 +785,8 @@ static struct clk_rcg2 gp2_clk_src = {
 	.parent_map = gcc_xo_200_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gp2_clk_src",
-		.parent_names = gcc_xo_200,
-		.num_parents = 2,
+		.parent_data = gcc_xo_200,
+		.num_parents = ARRAY_SIZE(gcc_xo_200),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -863,9 +798,8 @@ static struct clk_branch gcc_gp2_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gp2_clk",
-			.parent_names = (const char *[]){
-				"gp2_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&gp2_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -881,8 +815,8 @@ static struct clk_rcg2 gp3_clk_src = {
 	.parent_map = gcc_xo_200_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gp3_clk_src",
-		.parent_names = gcc_xo_200,
-		.num_parents = 2,
+		.parent_data = gcc_xo_200,
+		.num_parents = ARRAY_SIZE(gcc_xo_200),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -894,9 +828,8 @@ static struct clk_branch gcc_gp3_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_gp3_clk",
-			.parent_names = (const char *[]){
-				"gp3_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&gp3_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -904,6 +837,18 @@ static struct clk_branch gcc_gp3_clk = {
 	},
 };
 
+static struct parent_map gcc_xo_sdcc1_500_map[] = {
+	{  P_XO, 0 },
+	{  P_DDRPLL, 1 },
+	{  P_FEPLL500, 2 },
+};
+
+static const struct clk_parent_data gcc_xo_sdcc1_500[] = {
+	{ .fw_name = "xo", .name = "xo" },
+	{ .hw = &gcc_apss_sdcc_clk.cdiv.clkr.hw },
+	{ .hw = &gcc_fepll500_clk.cdiv.clkr.hw },
+};
+
 static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk[] = {
 	F(144000,    P_XO,			1,  3, 240),
 	F(400000,    P_XO,			1,  1, 0),
@@ -922,8 +867,8 @@ static struct clk_rcg2  sdcc1_apps_clk_src = {
 	.parent_map = gcc_xo_sdcc1_500_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "sdcc1_apps_clk_src",
-		.parent_names = gcc_xo_sdcc1_500,
-		.num_parents = 3,
+		.parent_data = gcc_xo_sdcc1_500,
+		.num_parents = ARRAY_SIZE(gcc_xo_sdcc1_500),
 		.ops = &clk_rcg2_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -947,6 +892,20 @@ static const struct freq_tbl ftbl_gcc_apps_clk[] = {
 	{ }
 };
 
+static struct parent_map gcc_xo_ddr_500_200_map[] = {
+	{  P_XO, 0 },
+	{  P_FEPLL200, 3 },
+	{  P_FEPLL500, 2 },
+	{  P_DDRPLLAPSS, 1 },
+};
+
+static const struct clk_parent_data gcc_xo_ddr_500_200[] = {
+	{ .fw_name = "xo", .name = "xo" },
+	{ .hw = &gcc_fepll200_clk.cdiv.clkr.hw },
+	{ .hw = &gcc_fepll500_clk.cdiv.clkr.hw },
+	{ .hw = &gcc_apss_cpu_plldiv_clk.cdiv.clkr.hw },
+};
+
 static struct clk_rcg2 apps_clk_src = {
 	.cmd_rcgr = 0x1900c,
 	.hid_width = 5,
@@ -954,8 +913,8 @@ static struct clk_rcg2 apps_clk_src = {
 	.parent_map = gcc_xo_ddr_500_200_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "apps_clk_src",
-		.parent_names = gcc_xo_ddr_500_200,
-		.num_parents = 4,
+		.parent_data = gcc_xo_ddr_500_200,
+		.num_parents = ARRAY_SIZE(gcc_xo_ddr_500_200),
 		.ops = &clk_rcg2_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -974,8 +933,8 @@ static struct clk_rcg2 apps_ahb_clk_src = {
 	.freq_tbl = ftbl_gcc_apps_ahb_clk,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "apps_ahb_clk_src",
-		.parent_names = gcc_xo_200_500,
-		.num_parents = 3,
+		.parent_data = gcc_xo_200_500,
+		.num_parents = ARRAY_SIZE(gcc_xo_200_500),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -988,9 +947,8 @@ static struct clk_branch gcc_apss_ahb_clk = {
 		.enable_mask = BIT(14),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_apss_ahb_clk",
-			.parent_names = (const char *[]){
-				"apps_ahb_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&apps_ahb_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1006,9 +964,8 @@ static struct clk_branch gcc_blsp1_ahb_clk = {
 		.enable_mask = BIT(10),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_blsp1_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1039,9 +996,8 @@ static struct clk_branch gcc_boot_rom_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_boot_rom_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1057,9 +1013,8 @@ static struct clk_branch gcc_crypto_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_crypto_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1074,9 +1029,8 @@ static struct clk_branch gcc_crypto_axi_clk = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_crypto_axi_clk",
-			.parent_names = (const char *[]){
-				"fepll125",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&gcc_fepll125_clk.cdiv.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1091,15 +1045,42 @@ static struct clk_branch gcc_crypto_clk = {
 		.enable_mask = BIT(2),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_crypto_clk",
-			.parent_names = (const char *[]){
-				"fepll125",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&gcc_fepll125_clk.cdiv.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
 };
 
+static struct parent_map gcc_xo_125_dly_map[] = {
+	{  P_XO, 0 },
+	{  P_FEPLL125DLY, 1 },
+};
+
+static const struct clk_parent_data gcc_xo_125_dly[] = {
+	{ .fw_name = "xo", .name = "xo" },
+	{ .hw = &gcc_fepll125dly_clk.cdiv.clkr.hw },
+};
+
+static const struct freq_tbl ftbl_gcc_fephy_dly_clk[] = {
+	F(125000000, P_FEPLL125DLY, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 fephy_125m_dly_clk_src = {
+	.cmd_rcgr = 0x12000,
+	.hid_width = 5,
+	.parent_map = gcc_xo_125_dly_map,
+	.freq_tbl = ftbl_gcc_fephy_dly_clk,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "fephy_125m_dly_clk_src",
+		.parent_data = gcc_xo_125_dly,
+		.num_parents = ARRAY_SIZE(gcc_xo_125_dly),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
 static struct clk_branch gcc_ess_clk = {
 	.halt_reg = 0x12010,
 	.clkr = {
@@ -1107,9 +1088,8 @@ static struct clk_branch gcc_ess_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_ess_clk",
-			.parent_names = (const char *[]){
-				"fephy_125m_dly_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&fephy_125m_dly_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1125,9 +1105,8 @@ static struct clk_branch gcc_imem_axi_clk = {
 		.enable_mask = BIT(17),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_imem_axi_clk",
-			.parent_names = (const char *[]){
-				"fepll200",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&gcc_fepll200_clk.cdiv.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1141,9 +1120,8 @@ static struct clk_branch gcc_imem_cfg_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_imem_cfg_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1157,9 +1135,8 @@ static struct clk_branch gcc_pcie_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1173,9 +1150,8 @@ static struct clk_branch gcc_pcie_axi_m_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_axi_m_clk",
-			.parent_names = (const char *[]){
-				"fepll200",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&gcc_fepll200_clk.cdiv.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1189,9 +1165,8 @@ static struct clk_branch gcc_pcie_axi_s_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_axi_s_clk",
-			.parent_names = (const char *[]){
-				"fepll200",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&gcc_fepll200_clk.cdiv.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1206,9 +1181,8 @@ static struct clk_branch gcc_prng_ahb_clk = {
 		.enable_mask = BIT(8),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_prng_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1222,9 +1196,8 @@ static struct clk_branch gcc_qpic_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qpic_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1238,9 +1211,8 @@ static struct clk_branch gcc_qpic_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qpic_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1254,9 +1226,8 @@ static struct clk_branch gcc_sdcc1_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_sdcc1_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1270,9 +1241,8 @@ static struct clk_branch gcc_sdcc1_apps_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_sdcc1_apps_clk",
-			.parent_names = (const char *[]){
-				"sdcc1_apps_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&sdcc1_apps_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1288,9 +1258,8 @@ static struct clk_branch gcc_tlmm_ahb_clk = {
 		.enable_mask = BIT(5),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_tlmm_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1304,9 +1273,8 @@ static struct clk_branch gcc_usb2_master_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb2_master_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&pcnoc_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1330,23 +1298,6 @@ static struct clk_branch gcc_usb2_sleep_clk = {
 	},
 };
 
-static struct clk_branch gcc_usb2_mock_utmi_clk = {
-	.halt_reg = 0x1e014,
-	.clkr = {
-		.enable_reg = 0x1e014,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_usb2_mock_utmi_clk",
-			.parent_names = (const char *[]){
-				"usb30_mock_utmi_clk_src",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-			.flags = CLK_SET_RATE_PARENT,
-		},
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_usb30_mock_utmi_clk[] = {
 	F(2000000, P_FEPLL200, 10, 0, 0),
 	{ }
@@ -1359,12 +1310,28 @@ static struct clk_rcg2 usb30_mock_utmi_clk_src = {
 	.freq_tbl = ftbl_gcc_usb30_mock_utmi_clk,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "usb30_mock_utmi_clk_src",
-		.parent_names = gcc_xo_200,
-		.num_parents = 2,
+		.parent_data = gcc_xo_200,
+		.num_parents = ARRAY_SIZE(gcc_xo_200),
 		.ops = &clk_rcg2_ops,
 	},
 };
 
+static struct clk_branch gcc_usb2_mock_utmi_clk = {
+	.halt_reg = 0x1e014,
+	.clkr = {
+		.enable_reg = 0x1e014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb2_mock_utmi_clk",
+			.parent_hws = (const struct clk_hw *[]){
+				&usb30_mock_utmi_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
 static struct clk_branch gcc_usb3_master_clk = {
 	.halt_reg = 0x1e028,
 	.clkr = {
@@ -1372,9 +1339,8 @@ static struct clk_branch gcc_usb3_master_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb3_master_clk",
-			.parent_names = (const char *[]){
-				"fepll125",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&gcc_fepll125_clk.cdiv.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
@@ -1405,9 +1371,8 @@ static struct clk_branch gcc_usb3_mock_utmi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb3_mock_utmi_clk",
-			.parent_names = (const char *[]){
-				"usb30_mock_utmi_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&usb30_mock_utmi_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1415,25 +1380,16 @@ static struct clk_branch gcc_usb3_mock_utmi_clk = {
 	},
 };
 
-static const struct freq_tbl ftbl_gcc_fephy_dly_clk[] = {
-	F(125000000, P_FEPLL125DLY, 1, 0, 0),
-	{ }
+static struct parent_map gcc_xo_wcss2g_map[] = {
+	{  P_XO, 0 },
+	{  P_FEPLLWCSS2G, 1 },
 };
 
-static struct clk_rcg2 fephy_125m_dly_clk_src = {
-	.cmd_rcgr = 0x12000,
-	.hid_width = 5,
-	.parent_map = gcc_xo_125_dly_map,
-	.freq_tbl = ftbl_gcc_fephy_dly_clk,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "fephy_125m_dly_clk_src",
-		.parent_names = gcc_xo_125_dly,
-		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
-	},
+static const struct clk_parent_data gcc_xo_wcss2g[] = {
+	{ .fw_name = "xo", .name = "xo" },
+	{ .hw = &gcc_fepllwcss2g_clk.cdiv.clkr.hw },
 };
 
-
 static const struct freq_tbl ftbl_gcc_wcss2g_clk[] = {
 	F(48000000, P_XO, 1, 0, 0),
 	F(250000000, P_FEPLLWCSS2G, 1, 0, 0),
@@ -1447,8 +1403,8 @@ static struct clk_rcg2 wcss2g_clk_src = {
 	.parent_map = gcc_xo_wcss2g_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "wcss2g_clk_src",
-		.parent_names = gcc_xo_wcss2g,
-		.num_parents = 2,
+		.parent_data = gcc_xo_wcss2g,
+		.num_parents = ARRAY_SIZE(gcc_xo_wcss2g),
 		.ops = &clk_rcg2_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -1461,9 +1417,8 @@ static struct clk_branch gcc_wcss2g_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_wcss2g_clk",
-			.parent_names = (const char *[]){
-				"wcss2g_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&wcss2g_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1506,6 +1461,16 @@ static struct clk_branch gcc_wcss2g_rtc_clk = {
 	},
 };
 
+static struct parent_map gcc_xo_wcss5g_map[] = {
+	{  P_XO, 0 },
+	{  P_FEPLLWCSS5G, 1 },
+};
+
+static const struct clk_parent_data gcc_xo_wcss5g[] = {
+	{ .fw_name = "xo", .name = "xo" },
+	{ .hw = &gcc_fepllwcss5g_clk.cdiv.clkr.hw },
+};
+
 static const struct freq_tbl ftbl_gcc_wcss5g_clk[] = {
 	F(48000000, P_XO, 1, 0, 0),
 	F(250000000, P_FEPLLWCSS5G, 1, 0, 0),
@@ -1519,8 +1484,8 @@ static struct clk_rcg2 wcss5g_clk_src = {
 	.freq_tbl = ftbl_gcc_wcss5g_clk,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "wcss5g_clk_src",
-		.parent_names = gcc_xo_wcss5g,
-		.num_parents = 2,
+		.parent_data = gcc_xo_wcss5g,
+		.num_parents = ARRAY_SIZE(gcc_xo_wcss5g),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -1532,9 +1497,8 @@ static struct clk_branch gcc_wcss5g_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_wcss5g_clk",
-			.parent_names = (const char *[]){
-				"wcss5g_clk_src",
-			},
+			.parent_hws = (const struct clk_hw *[]){
+				&wcss5g_clk_src.clkr.hw },
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 			.flags = CLK_SET_RATE_PARENT,
-- 
2.39.1

