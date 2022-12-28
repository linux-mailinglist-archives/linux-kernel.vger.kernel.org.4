Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB66575E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiL1LZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiL1LZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:25:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F47510FCB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:25:01 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g13so23205077lfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBaKF3ctENLjh/5VUMrpeIPlkYdKfKPC8R4MOlRY2rs=;
        b=vKa9qRerRMsaoPc7o449DNFCz9NLlEsTyjtFCosdYpre1arTnQ3VFH2DWkSC9PS5Ow
         mNjj/2q//OxSh+biDdD/C7r+QcVV1dojUbpU7I6kl+sqHVA8QQtVjVePHhPLuHH1EPl6
         rwUewum+0lbaiBg3Nih0ZLgwah6bIds8V8K/WMfyWf9zrbmwc0h36HDbzh71XP1NH4cE
         c9hwChfABqaiAiHBvgNfqf+eLwQFXSYNlmDr/Pipq5LY9Yw2Vw5RxlXXnWGShVIWXtn1
         2//OgEGLUlrn6vTXVn5f4lasf8daprInM1QOu1r1b+jwYTmVQQR9mWam2caAS5aNO+Ck
         B+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBaKF3ctENLjh/5VUMrpeIPlkYdKfKPC8R4MOlRY2rs=;
        b=zfqGIq5cFUuavTmMGMqsoU6F6FPya7/i/lZL68YhrTnwF6scQ+GXqHOetEV4XfD/Zm
         jbB9YID+DxF8Cx2jqO093W9QQjkzXvlUili5X6UTlb+f5gp6Tv/wBU51M08OGSFHIXyE
         5rEKZKh1kcj61iIAwg7n3+QGMjyTkMLsNlAHRJUo56EWTDdf2PjoL9WP8uKIkTl1BGg7
         Ygo630IhvLvjs+JQIt9oJ8KiYQP93hg04viZO5JuVL2pfzsr1HS1mVBgPZfCLvd6kdiu
         IaxwHRm8C0UpRiQEELnCKuFRrQTWAVPmAd8F4CM1qFXxxYkyBjnXRzTU4R+nVwLes8JJ
         iuuA==
X-Gm-Message-State: AFqh2kpJhmTrS8afkxPdYzOHeGD5wCnK+cZGR4K0DuQXqdVxY8nLPI+I
        9PpTpQvO09JqzY8KWj/h+OouPA==
X-Google-Smtp-Source: AMrXdXsqfVWhLKuDht0ienfNLroQyMjRFOC6LcvtGmzQozjLk2zTGvyE5h1c8P7ylZBdJVyZlDPxjQ==
X-Received: by 2002:a05:6512:31cc:b0:4b0:1305:6ebf with SMTP id j12-20020a05651231cc00b004b013056ebfmr8032274lfe.53.1672226699641;
        Wed, 28 Dec 2022 03:24:59 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y16-20020ac255b0000000b004cb0242704asm1627039lfg.255.2022.12.28.03.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 03:24:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sm8350: add missing core_bi_pll_test_se GCC clock
Date:   Wed, 28 Dec 2022 12:24:55 +0100
Message-Id: <20221228112456.31348-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The GCC bindings expect core_bi_pll_test_se clock input, even if it is
optional:

  sm8350-mtp.dtb: clock-controller@100000: clock-names:2: 'core_bi_pll_test_se' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index d473194c968d..d5747bb467e0 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -644,6 +644,7 @@ gcc: clock-controller@100000 {
 			#power-domain-cells = <1>;
 			clock-names = "bi_tcxo",
 				      "sleep_clk",
+				      "core_bi_pll_test_se",
 				      "pcie_0_pipe_clk",
 				      "pcie_1_pipe_clk",
 				      "ufs_card_rx_symbol_0_clk",
@@ -661,6 +662,7 @@ gcc: clock-controller@100000 {
 				 <0>,
 				 <0>,
 				 <0>,
+				 <0>,
 				 <&ufs_phy_rx_symbol_0_clk>,
 				 <&ufs_phy_rx_symbol_1_clk>,
 				 <&ufs_phy_tx_symbol_0_clk>,
-- 
2.34.1

