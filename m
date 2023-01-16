Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EDD66D087
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjAPUtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjAPUsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:48:10 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB65427D60;
        Mon, 16 Jan 2023 12:48:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e3so19403709wru.13;
        Mon, 16 Jan 2023 12:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkjLqcCTee4LPDv2iPQ2BaMG6gf64UUuhQ8hfxO58R8=;
        b=Oz9oVCU0BZxXJ8YTtZa6BC6ahCjz5fTHG/ssHWYZFDEtHoTQX0d4iAQRrUSWsLNkvH
         u/Szdry3A6Bnq3cpfrkuKiXLfQGKThbhkWeXe53+eEDQE5oZVEr6aAijdAQLQOBwlGJ3
         couqIB6Qikv+6CBAekktkoWPrawi9gNhcaGL6HNN63Yf1fZV2UNSVFGNoHo/Y74u8Q5r
         OS8LmAi+2ghfOMvvGEJGk5lpb89scTtzLsEZMhPxCfVJD0pLTgFzB2P7YjawaE9vy5En
         pL2DW035HzpYZcayUImwottTJ7cTIH4Ia/Ey3c3jO/k24dULq4Ir+cu9GT3EabDqx8wy
         D/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkjLqcCTee4LPDv2iPQ2BaMG6gf64UUuhQ8hfxO58R8=;
        b=HDyZBHrfsUiuJN68dKbTxR5pI8Pbtd5KkBo03zYP4B+fCqpyt3B8i0L5DE+blpK8yq
         SS5FUQ3MBC1RnsttqWoISaF8kqsCziqvyu4OBsc1K38r1XW46MgMIm5GVHInjGAjG2+n
         /P5HklbbQr9giWm7eth+Wu7sBpmT5Ni9iMAuKuQq8GpdMyaa4d9LZ0pk+EfnUp8b4Pc0
         cw/2FPtWB268OiDLjLvAr+GhT2AjaePz4ge96KsWDIuOFrvIKe1qwJhkJaD69wZF1YA6
         q0ghIlavRuJ+dg7UAAq3zcRR7AA0IvwY4KvWqcAI0+KChOUfQadmj9wz+lF9HxZJaZsq
         VLkw==
X-Gm-Message-State: AFqh2krUBcIjXumlRP8NlwEa85x43kPwqjKd6RNgOAEqhRJAL2/DUzlw
        auSMsppoW5AehWnHHM90IZg=
X-Google-Smtp-Source: AMrXdXs9YF83SSmqJZDnZMjJCAd0rN3mvyO/QEj9uXo7ic15Zrkbs6FNCbT5dZW2vM9DF3Qd6/qTdA==
X-Received: by 2002:adf:ed0b:0:b0:2bd:f075:ede0 with SMTP id a11-20020adfed0b000000b002bdf075ede0mr645304wro.45.1673902083226;
        Mon, 16 Jan 2023 12:48:03 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id k18-20020adfb352000000b00241fab5a296sm27785372wrd.40.2023.01.16.12.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:48:02 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v7 5/7] ARM: dts: qcom: add and fix clock configuration for kpss-gcc nodes
Date:   Mon, 16 Jan 2023 21:47:49 +0100
Message-Id: <20230116204751.23045-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116204751.23045-1-ansuelsmth@gmail.com>
References: <20230116204751.23045-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing clock configuration by adding clocks, clock-names
and #clock-cells bindings for each kpss-acc-v1 clock-controller
node for apq8064 and msm8960 to reflect Documentation schema.
Add missing #clock-cells binding and remove useless clock-output-names for
ipq806x dtsi.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 3 +++
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 7065f6e88dcf..1e68b42acb91 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -882,6 +882,9 @@ mmcc: clock-controller@4000000 {
 		l2cc: clock-controller@2011000 {
 			compatible = "qcom,kpss-gcc-apq8064", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		rpm: rpm@108000 {
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index bd0728c57eab..de87fcaaa836 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -574,7 +574,7 @@ l2cc: clock-controller@2011000 {
 			reg = <0x02011000 0x1000>;
 			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
 			clock-names = "pll8_vote", "pxo";
-			clock-output-names = "acpu_l2_aux";
+			#clock-cells = <0>;
 		};
 
 		acc0: clock-controller@2088000 {
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 2dd90e57929a..3bd07cac315b 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -185,6 +185,9 @@ clock-controller@4000000 {
 		l2cc: clock-controller@2011000 {
 			compatible = "qcom,kpss-gcc-msm8960", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		rpm: rpm@108000 {
-- 
2.37.2

