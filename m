Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF4265778D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiL1OJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiL1OJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:09:25 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E464CD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:09:24 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id p2so1041450ljn.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8mIKxk0N2DNE4tIxx9Wvugw4Q57es7J2KyF1r+n93E=;
        b=b08Zg1mYsa/096BZ29j2kIk890KnkCcYsqvwWJwsG8P8g2RLFszeJwMQm7NrzuiX/j
         CWgsgybOdmE2CgqRedW9/ZE+vZIaJlgF3R6WOkCFF+0SgDbk0wiyB0n1M1fOdiK1DFlX
         q+wjqva49SDWPpxg+yGjlQXdc1FixnaAiv55gMPhRzd3KYoeLkpil0thjWQPO4O9nZgv
         ALfOmtFERVeYL0uCB29mRYh49I3u0IYcx1tAVjrWa/rEXBmKJ1lsjAedSmmriyfpdTlo
         PqtNF3szIT6fUvMoNo0kRX+1vNzbqqAaI8xlNTusJgRkP7TUA2ko8TGWvfYf2TTdbzDs
         FumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8mIKxk0N2DNE4tIxx9Wvugw4Q57es7J2KyF1r+n93E=;
        b=eB5lBIkZVTN1tD8D/vA8SBG11OXmK8GZAjMgLO6X4HbG3O2QBcpVMshqPCzCycxKkH
         5EZEdzyc5/hp2vEiWD/MpCycC1W7AwNEZd6Tfgrl9DD549nKh6+ktv5oQOWYFcEjJ7sT
         NCa6/5aOpEbWK0+bDdIcZN7GH6zlg7kM5CmSm0kunG1KMir+np1koWFkgBjjgge/T589
         lOldoeFRpW3VkWoQEMT+z2Ogm9yjInVF/65yMDqUJqdb4O4+7xAhxB+O6eo5UgSiHTis
         nZzjz7a1QtVoV9S6bhpCeglUHJieWO/a1SdCflQY6dhcqWuqfiAGwJ8/NGlKrTdKyB8L
         v9wg==
X-Gm-Message-State: AFqh2krXtT3C0F4I+hUhvM624Q4BX1K8txUxejDAdrid09l6O3DiyiNz
        0mil3uyozYx0Jg+z7vmc94Kp8Q==
X-Google-Smtp-Source: AMrXdXsfH6lFMsCCFpdrRbfsIgYDSH8L4sAH2+1+R6YNSIKdRBxGXFI2wjnve8NFE5+ziCsHbgeSow==
X-Received: by 2002:a05:651c:1a14:b0:27f:976e:7126 with SMTP id by20-20020a05651c1a1400b0027f976e7126mr8681099ljb.33.1672236562577;
        Wed, 28 Dec 2022 06:09:22 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 20-20020a2eb954000000b002778801240asm1935017ljs.10.2022.12.28.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 06:09:22 -0800 (PST)
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
Subject: [PATCH 3/3] clk: gcc-sm8350: drop PLL test clock
Date:   Wed, 28 Dec 2022 15:09:17 +0100
Message-Id: <20221228140917.118861-3-krzysztof.kozlowski@linaro.org>
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
 drivers/clk/qcom/gcc-sm8350.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8350.c b/drivers/clk/qcom/gcc-sm8350.c
index c3731f96c8e6..af4a1ea28421 100644
--- a/drivers/clk/qcom/gcc-sm8350.c
+++ b/drivers/clk/qcom/gcc-sm8350.c
@@ -22,7 +22,6 @@
 
 enum {
 	P_BI_TCXO,
-	P_CORE_BI_PLL_TEST_SE,
 	P_GCC_GPLL0_OUT_EVEN,
 	P_GCC_GPLL0_OUT_MAIN,
 	P_GCC_GPLL4_OUT_MAIN,
@@ -119,14 +118,12 @@ static const struct parent_map gcc_parent_map_0[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GCC_GPLL0_OUT_MAIN, 1 },
 	{ P_GCC_GPLL0_OUT_EVEN, 6 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parent_data_0[] = {
 	{ .fw_name = "bi_tcxo" },
 	{ .hw = &gcc_gpll0.clkr.hw },
 	{ .hw = &gcc_gpll0_out_even.clkr.hw },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map gcc_parent_map_1[] = {
@@ -134,7 +131,6 @@ static const struct parent_map gcc_parent_map_1[] = {
 	{ P_GCC_GPLL0_OUT_MAIN, 1 },
 	{ P_SLEEP_CLK, 5 },
 	{ P_GCC_GPLL0_OUT_EVEN, 6 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parent_data_1[] = {
@@ -142,29 +138,24 @@ static const struct clk_parent_data gcc_parent_data_1[] = {
 	{ .hw = &gcc_gpll0.clkr.hw },
 	{ .fw_name = "sleep_clk" },
 	{ .hw = &gcc_gpll0_out_even.clkr.hw },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map gcc_parent_map_2[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_SLEEP_CLK, 5 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parent_data_2[] = {
 	{ .fw_name = "bi_tcxo" },
 	{ .fw_name = "sleep_clk" },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map gcc_parent_map_3[] = {
 	{ P_BI_TCXO, 0 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parent_data_3[] = {
 	{ .fw_name = "bi_tcxo" },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map gcc_parent_map_4[] = {
@@ -193,7 +184,6 @@ static const struct parent_map gcc_parent_map_6[] = {
 	{ P_GCC_GPLL9_OUT_MAIN, 2 },
 	{ P_GCC_GPLL4_OUT_MAIN, 5 },
 	{ P_GCC_GPLL0_OUT_EVEN, 6 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gcc_parent_data_6[] = {
@@ -202,7 +192,6 @@ static const struct clk_parent_data gcc_parent_data_6[] = {
 	{ .hw = &gcc_gpll9.clkr.hw },
 	{ .hw = &gcc_gpll4.clkr.hw },
 	{ .hw = &gcc_gpll0_out_even.clkr.hw },
-	{ .fw_name = "core_bi_pll_test_se" },
 };
 
 static const struct parent_map gcc_parent_map_7[] = {
@@ -267,25 +256,21 @@ static const struct clk_parent_data gcc_parent_data_12[] = {
 
 static const struct parent_map gcc_parent_map_13[] = {
 	{ P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK, 0 },
-	{ P_CORE_BI_PLL_TEST_SE, 1 },
 	{ P_BI_TCXO, 2 },
 };
 
 static const struct clk_parent_data gcc_parent_data_13[] = {
 	{ .fw_name = "usb3_phy_wrapper_gcc_usb30_pipe_clk" },
-	{ .fw_name = "core_bi_pll_test_se" },
 	{ .fw_name = "bi_tcxo" },
 };
 
 static const struct parent_map gcc_parent_map_14[] = {
 	{ P_USB3_UNI_PHY_SEC_GCC_USB30_PIPE_CLK, 0 },
-	{ P_CORE_BI_PLL_TEST_SE, 1 },
 	{ P_BI_TCXO, 2 },
 };
 
 static const struct clk_parent_data gcc_parent_data_14[] = {
 	{ .fw_name = "usb3_uni_phy_sec_gcc_usb30_pipe_clk" },
-	{ .fw_name = "core_bi_pll_test_se" },
 	{ .fw_name = "bi_tcxo" },
 };
 
-- 
2.34.1

