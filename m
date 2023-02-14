Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FEF69694A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjBNQXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjBNQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:23:44 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EA02595A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lf10so9565675ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7BAF31xNZhLQjiozp7oE7XGB+UsYThUKP2mrciqqAE=;
        b=jBpCd0t58I+/nL2g//cPlO59Tn0LUn3rVgsOf17FKKlsdvflvv8NoYVcELZqfqW5Xh
         0zqfyNpgAcmofClBwQjBv75eWgYjn7HcTctrRBo9nAoivWC80/CrCSyUY9eDDbfwBbUF
         9crqKXu77XOGQgGZ+ghEv4oRRcnHbSV+6HSjm+G7folh116WMsBpctxmF+YY5r2CnJkh
         Uu4JT9Oq6Hp2c51PCfZq8rGIBT8m2VOR19F2NV/ErldA7s3hMZGzaDnOMgwIWycwgItV
         tzKiXNJ7Dq5md+KHEoHfneHWHqCHAGp8MDgmuX0UMEwIjstXR7Mmftd4srwXWgGakJje
         9nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7BAF31xNZhLQjiozp7oE7XGB+UsYThUKP2mrciqqAE=;
        b=RqUdaSO2ic/8FtWkSKFUmB6JWRwnqZsnr5GDwusQFOOzJYHeE1tVvmcmGVmrwOPJYr
         k5vTwHhW2FwROkk8oF56HULrXCIXs5D3opIq12sH4FLCRSQfob/5/0HIC/rR8HrUrhgM
         AdxRsV2SyetAJKdTcR3Z/HhkWqbpOtERKm/eb6iVMR4WI0JhTccp6s/Fy8d05UD2TmnP
         8Pc3QrB+A7nx/zWWp4CmPQLM14TzqJY+MxWYWCwkz2NLuMTMabdMo5SOdR+AxRBrdWLS
         Xf8511KEGnhVIYlQrtwm2EER6UFXL0i5q1iE7Mase2rkg4C1XGNpG1EM+ifPOLj3aiRR
         bqLQ==
X-Gm-Message-State: AO0yUKURUxjbevwyiPx+GISabcTRvk55UvmYySGA0AH8p1ZXYOBaoHUQ
        aoDLcrD8Iu9Si5eoiohL2XHF4w==
X-Google-Smtp-Source: AK7set+p5CptRx4PeNMcgVHk94WrFWuJ5ZY5d6pQjfSMzvUc2b5otL61FplrUzLaGupgFSX2EmJawg==
X-Received: by 2002:a17:906:190f:b0:877:6713:7e99 with SMTP id a15-20020a170906190f00b0087767137e99mr3116626eje.58.1676391809030;
        Tue, 14 Feb 2023 08:23:29 -0800 (PST)
Received: from fedora.. (cpezg-94-253-130-165-cbl.xnet.hr. [94.253.130.165])
        by smtp.googlemail.com with ESMTPSA id bp8-20020a170907918800b008806a3c22c5sm1318027ejb.25.2023.02.14.08.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:23:28 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/7] clk: qcom: gcc-ipq4019: convert XO and sleep clk to parent_data
Date:   Tue, 14 Feb 2023 17:23:20 +0100
Message-Id: <20230214162325.312057-2-robert.marko@sartura.hr>
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

Start off IPQ4019 GCC conversion by converting XO and sleep clks to
parent data in order to directly pass them.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/qcom/gcc-ipq4019.c | 75 ++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
index 362c732536cd3..a50887d3626f7 100644
--- a/drivers/clk/qcom/gcc-ipq4019.c
+++ b/drivers/clk/qcom/gcc-ipq4019.c
@@ -657,8 +657,9 @@ static struct clk_branch gcc_dcd_xo_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_dcd_xo_clk",
-			.parent_names = (const char *[]){
-				"xo",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -954,8 +955,9 @@ static struct clk_branch gcc_usb2_sleep_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb2_sleep_clk",
-			.parent_names = (const char *[]){
-				"gcc_sleep_clk_src",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "sleep_clk",
+				.name = "gcc_sleep_clk_src",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1021,8 +1023,9 @@ static struct clk_branch gcc_usb3_sleep_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb3_sleep_clk",
-			.parent_names = (const char *[]){
-				"gcc_sleep_clk_src",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "sleep_clk",
+				.name = "gcc_sleep_clk_src",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1110,8 +1113,9 @@ static struct clk_branch gcc_wcss2g_ref_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_wcss2g_ref_clk",
-			.parent_names = (const char *[]){
-				"xo",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1127,8 +1131,9 @@ static struct clk_branch gcc_wcss2g_rtc_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_wcss2g_rtc_clk",
-			.parent_names = (const char *[]){
-				"gcc_sleep_clk_src",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "sleep_clk",
+				.name = "gcc_sleep_clk_src",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1179,8 +1184,9 @@ static struct clk_branch gcc_wcss5g_ref_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_wcss5g_ref_clk",
-			.parent_names = (const char *[]){
-				"xo",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1196,8 +1202,9 @@ static struct clk_branch gcc_wcss5g_rtc_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_wcss5g_rtc_clk",
-			.parent_names = (const char *[]){
-				"gcc_sleep_clk_src",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "sleep_clk",
+				.name = "gcc_sleep_clk_src",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1360,8 +1367,9 @@ static struct clk_fepll gcc_apss_cpu_plldiv_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "ddrpllapss",
-			.parent_names = (const char *[]){
-				"xo",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
 			},
 			.num_parents = 1,
 			.ops = &clk_regmap_cpu_div_ops,
@@ -1412,8 +1420,9 @@ static struct clk_fepll gcc_apss_sdcc_clk = {
 	.cdiv.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "ddrpllsdcc",
-			.parent_names = (const char *[]){
-				"xo",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
 			},
 			.num_parents = 1,
 			.ops = &clk_fepll_div_ops,
@@ -1427,8 +1436,9 @@ static struct clk_fepll gcc_fepll125_clk = {
 	.cdiv.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "fepll125",
-			.parent_names = (const char *[]){
-				"xo",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
 			},
 			.num_parents = 1,
 			.ops = &clk_fepll_div_ops,
@@ -1442,8 +1452,9 @@ static struct clk_fepll gcc_fepll125dly_clk = {
 	.cdiv.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "fepll125dly",
-			.parent_names = (const char *[]){
-				"xo",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
 			},
 			.num_parents = 1,
 			.ops = &clk_fepll_div_ops,
@@ -1457,8 +1468,9 @@ static struct clk_fepll gcc_fepll200_clk = {
 	.cdiv.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "fepll200",
-			.parent_names = (const char *[]){
-				"xo",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
 			},
 			.num_parents = 1,
 			.ops = &clk_fepll_div_ops,
@@ -1472,8 +1484,9 @@ static struct clk_fepll gcc_fepll500_clk = {
 	.cdiv.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "fepll500",
-			.parent_names = (const char *[]){
-				"xo",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
 			},
 			.num_parents = 1,
 			.ops = &clk_fepll_div_ops,
@@ -1497,8 +1510,9 @@ static struct clk_fepll gcc_fepllwcss2g_clk = {
 	.cdiv.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "fepllwcss2g",
-			.parent_names = (const char *[]){
-				"xo",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
 			},
 			.num_parents = 1,
 			.ops = &clk_fepll_div_ops,
@@ -1515,8 +1529,9 @@ static struct clk_fepll gcc_fepllwcss5g_clk = {
 	.cdiv.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "fepllwcss5g",
-			.parent_names = (const char *[]){
-				"xo",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
 			},
 			.num_parents = 1,
 			.ops = &clk_fepll_div_ops,
-- 
2.39.1

