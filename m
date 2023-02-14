Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6619E69695D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBNQYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjBNQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:23:50 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6607417CD7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qb15so39365423ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScsbgOXtpb9xWT2guFGbhC+yddLEssXusAms+kqhCFk=;
        b=mmkWUKrp937tG//xDt3X3HVHLpC30KDnmup1PHGm2Pjdte+jEvbhzaVFoWqV2Xo/vK
         mNOsyewSVg1cdGFY9VmNetfjvy1/LFfZHfIRRNIPZM5ucWu12I2xjklpVRxzbNXiz2MX
         9tp1leXdE6YhH+Frl0fdqF2RmKgaOhToQQ6ynIbc2S/daeKv6I8T5IG7E4eUgnPRFPMn
         kRoZHclZlOZ6dx75jJpL2et3WoxMFbjvHDQ6Id24cIASJpEWEH0yqebXqnNf3zgu4Wn9
         AJubIpTteiUxfV+dwHIALfnKhr5GopYqDg49qUEkIqte1I+Oj1OFitHFDiolTW1vDEYJ
         71QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScsbgOXtpb9xWT2guFGbhC+yddLEssXusAms+kqhCFk=;
        b=qP9WGEiGLiNYXyNxuE9xpbEyYoMiPmsokGdrrKWmShYtZ+j0vNtQ8g52P2hNaQghEZ
         lGYzUMltYDmSUaX5JBzP87P7bvxwc5qk8XdW3m9j74aPa1u1MAgK4u7h15POSvVXJuGJ
         tAmw68cfkXvxI4zAIRNgeH/c1YtN0wcNpIXGmyVGGQ2IC3XNjYqO/ItgkenJU6UU+Sfv
         FW+jA4XjEj84RRQywgWOiLlSmqXQb96431FKhRQejeNpzlHshYBibIAatRuobNdoJvBo
         R5LEcQfmiY85W9zhSbivuZGIZ6AIqZBfu63Q7UaQipAFhaEJ3MppBBkZfrti+rr93oHL
         gY1g==
X-Gm-Message-State: AO0yUKULhUYDbRD65WLJcWHEzSFOH3KaK0Cf5zizzpd/l4OYeSXH6SJX
        1pvDFj+PQ0v8GczZHvU6i7mDQg==
X-Google-Smtp-Source: AK7set8ImZ4JswXFxpHDOJaqVcds+Hhjo91zVyfsT+KKOOoC/GCkMy9HYgfMLWD4lsWMLEzZ6sKQLw==
X-Received: by 2002:a17:906:57ca:b0:879:6abe:915e with SMTP id u10-20020a17090657ca00b008796abe915emr4323971ejr.69.1676391813943;
        Tue, 14 Feb 2023 08:23:33 -0800 (PST)
Received: from fedora.. (cpezg-94-253-130-165-cbl.xnet.hr. [94.253.130.165])
        by smtp.googlemail.com with ESMTPSA id bp8-20020a170907918800b008806a3c22c5sm1318027ejb.25.2023.02.14.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:23:33 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 6/7] clk: qcom: gcc-ipq4019: move pcnoc clocks up
Date:   Tue, 14 Feb 2023 17:23:24 +0100
Message-Id: <20230214162325.312057-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214162325.312057-1-robert.marko@sartura.hr>
References: <20230214162325.312057-1-robert.marko@sartura.hr>
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

Move pcnoc clocks up just after PLL-s to be able to use their
HW fields.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/qcom/gcc-ipq4019.c | 74 +++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
index f4bc587131c20..f2728dc1e5521 100644
--- a/drivers/clk/qcom/gcc-ipq4019.c
+++ b/drivers/clk/qcom/gcc-ipq4019.c
@@ -499,6 +499,43 @@ static struct clk_fepll gcc_fepllwcss5g_clk = {
 	.pll_vco = &gcc_fepll_vco,
 };
 
+static const struct freq_tbl ftbl_gcc_pcnoc_ahb_clk[] = {
+	F(48000000,  P_XO,	 1, 0, 0),
+	F(100000000, P_FEPLL200, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_pcnoc_ahb_clk_src = {
+	.cmd_rcgr = 0x21024,
+	.hid_width = 5,
+	.parent_map = gcc_xo_200_500_map,
+	.freq_tbl = ftbl_gcc_pcnoc_ahb_clk,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gcc_pcnoc_ahb_clk_src",
+		.parent_names = gcc_xo_200_500,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch pcnoc_clk_src = {
+	.halt_reg = 0x21030,
+	.clkr = {
+		.enable_reg = 0x21030,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "pcnoc_clk_src",
+			.parent_names = (const char *[]){
+				"gcc_pcnoc_ahb_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT |
+				CLK_IS_CRITICAL,
+		},
+	},
+};
+
 static const struct freq_tbl ftbl_gcc_audio_pwm_clk[] = {
 	F(48000000, P_XO, 1, 0, 0),
 	F(200000000, P_FEPLL200, 1, 0, 0),
@@ -1541,43 +1578,6 @@ static struct clk_branch gcc_wcss5g_rtc_clk = {
 	},
 };
 
-static const struct freq_tbl ftbl_gcc_pcnoc_ahb_clk[] = {
-	F(48000000,  P_XO,	 1, 0, 0),
-	F(100000000, P_FEPLL200, 2, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 gcc_pcnoc_ahb_clk_src = {
-	.cmd_rcgr = 0x21024,
-	.hid_width = 5,
-	.parent_map = gcc_xo_200_500_map,
-	.freq_tbl = ftbl_gcc_pcnoc_ahb_clk,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_pcnoc_ahb_clk_src",
-		.parent_names = gcc_xo_200_500,
-		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_branch pcnoc_clk_src = {
-	.halt_reg = 0x21030,
-	.clkr = {
-		.enable_reg = 0x21030,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "pcnoc_clk_src",
-			.parent_names = (const char *[]){
-				"gcc_pcnoc_ahb_clk_src",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-			.flags = CLK_SET_RATE_PARENT |
-				CLK_IS_CRITICAL,
-		},
-	},
-};
-
 static struct clk_regmap *gcc_ipq4019_clocks[] = {
 	[AUDIO_CLK_SRC] = &audio_clk_src.clkr,
 	[BLSP1_QUP1_I2C_APPS_CLK_SRC] = &blsp1_qup1_i2c_apps_clk_src.clkr,
-- 
2.39.1

