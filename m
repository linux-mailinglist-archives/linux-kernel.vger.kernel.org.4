Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435FC65778C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiL1OJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiL1OJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:09:24 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1970EE0FA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:09:23 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id z7so10981733ljq.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlFhGsMACAKrTpw7bJWkPNyayRlXB9fU8gpjlKhEyEY=;
        b=stvZcfejOZF+2MbrbGlYoSOZBra+gnM31c53fFVqRJ9kDzqkyCl7F+8OXHlMLGtK3k
         FYwVOW5ahARowdfKCd2M3dHMPOVSxS4vzNzyjBRGfh+hNPRPhGYA/9i8AYepzLxjfqH3
         N8munEzIYoU/w2LZ7iXXEdyoJGRSmd3yFMA00So1toeb4LJiQK9osUmSnzXfpFrPvhNn
         KKpRo4XeSGOW/hIpYbvmJmrlNEho1bj5756AMBGzOrbsrHi4pTFFwRnm78eLKmRy1gV9
         p1Eo7Ytg1/zyh/DdHkz5dici3g9q1GCgETPDtMAhF7zLZeOpWfkMAsQLa7kmpl1UAb/B
         9HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlFhGsMACAKrTpw7bJWkPNyayRlXB9fU8gpjlKhEyEY=;
        b=staPUjVqDa0MbdPou+QPr6C/302F6DKG5A1strYp72XGdeMTxlZCwKc3LTqJ6wEhwK
         n06mgq2VnXyC0SDYjwsNrnrL/5ROq6lCIsR60LspqBten56wwdI+NI6v7KqVA9ZKTT1N
         umsC1+dfqCYr/cURlvGp399WDMn2Ui8+Ia18UN1XsL8PXiXzsXU4+gxR0H3gyQcnOze8
         OMji2hq5/f22uLY3SkR9CHIqpxnH1Jumnt1zdMaVPJin2Po2mUgdnoZLtLzAxXjdDLb4
         fQCFrVXJOn9eYyX2R6/d0Nswsl/lDSOL6UFA+SGCagK6TMI4fb1NxyNzPLV5ZqqvurSr
         O8Ew==
X-Gm-Message-State: AFqh2kr+lvuRrVed25FU0yWwoqtvggqiyHMlbrbTIPnvKaQew/YiuBIj
        Y7EAktfAx1D0cVUs57/5NJ0GNA==
X-Google-Smtp-Source: AMrXdXv4eYGS0m560CibXAQl+lnjJFa6WkcQWzkHG4Bf3FWgVkwNVbopP2Nu9wz76aDlkXFDnTv3LQ==
X-Received: by 2002:a2e:bcc5:0:b0:276:dc01:804f with SMTP id z5-20020a2ebcc5000000b00276dc01804fmr8053575ljp.28.1672236561400;
        Wed, 28 Dec 2022 06:09:21 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 20-20020a2eb954000000b002778801240asm1935017ljs.10.2022.12.28.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 06:09:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] clk: gcc-sm8150: drop PLL test clock
Date:   Wed, 28 Dec 2022 15:09:16 +0100
Message-Id: <20221228140917.118861-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228140917.118861-1-krzysztof.kozlowski@linaro.org>
References: <20221228140917.118861-1-krzysztof.kozlowski@linaro.org>
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

There is no user of core_bi_pll_test_se test clock so drop it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/gcc-sm8150.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 09cf827addab..70b067f3618c 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -26,7 +26,6 @@
 enum {
 	P_BI_TCXO,
 	P_AUD_REF_CLK,
-	P_CORE_BI_PLL_TEST_SE,
 	P_GPLL0_OUT_EVEN,
 	P_GPLL0_OUT_MAIN,
 	P_GPLL7_OUT_MAIN,
@@ -117,14 +116,12 @@ static const struct parent_map gcc_parent_map_0[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_GPLL0_OUT_EVEN, 6 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parents_0[] = {
 	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll0_out_even.clkr.hw },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map gcc_parent_map_1[] = {
@@ -132,7 +129,6 @@ static const struct parent_map gcc_parent_map_1[] = {
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_SLEEP_CLK, 5 },
 	{ P_GPLL0_OUT_EVEN, 6 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parents_1[] = {
@@ -140,41 +136,34 @@ static const struct clk_parent_data gcc_parents_1[] = {
 	{ .hw = &gpll0.clkr.hw },
 	{ .fw_name = "sleep_clk", .name = "sleep_clk" },
 	{ .hw = &gpll0_out_even.clkr.hw },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map gcc_parent_map_2[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_SLEEP_CLK, 5 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parents_2[] = {
 	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
 	{ .fw_name = "sleep_clk", .name = "sleep_clk" },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map gcc_parent_map_3[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parents_3[] = {
 	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
 	{ .hw = &gpll0.clkr.hw },
-	{ .fw_name = "core_bi_pll_test_se"},
 };
 
 static const struct parent_map gcc_parent_map_4[] = {
 	{ P_BI_TCXO, 0 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parents_4[] = {
 	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map gcc_parent_map_5[] = {
@@ -182,7 +171,6 @@ static const struct parent_map gcc_parent_map_5[] = {
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_GPLL7_OUT_MAIN, 3 },
 	{ P_GPLL0_OUT_EVEN, 6 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parents_5[] = {
@@ -190,7 +178,6 @@ static const struct clk_parent_data gcc_parents_5[] = {
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll7.clkr.hw },
 	{ .hw = &gpll0_out_even.clkr.hw },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map gcc_parent_map_6[] = {
@@ -198,7 +185,6 @@ static const struct parent_map gcc_parent_map_6[] = {
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_GPLL9_OUT_MAIN, 2 },
 	{ P_GPLL0_OUT_EVEN, 6 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parents_6[] = {
@@ -206,7 +192,6 @@ static const struct clk_parent_data gcc_parents_6[] = {
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll9.clkr.hw },
 	{ .hw = &gpll0_out_even.clkr.hw },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map gcc_parent_map_7[] = {
@@ -214,7 +199,6 @@ static const struct parent_map gcc_parent_map_7[] = {
 	{ P_GPLL0_OUT_MAIN, 1 },
 	{ P_AUD_REF_CLK, 2 },
 	{ P_GPLL0_OUT_EVEN, 6 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parents_7[] = {
@@ -222,7 +206,6 @@ static const struct clk_parent_data gcc_parents_7[] = {
 	{ .hw = &gpll0.clkr.hw },
 	{ .fw_name = "aud_ref_clk", .name = "aud_ref_clk" },
 	{ .hw = &gpll0_out_even.clkr.hw },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct freq_tbl ftbl_gcc_cpuss_ahb_clk_src[] = {
-- 
2.34.1

