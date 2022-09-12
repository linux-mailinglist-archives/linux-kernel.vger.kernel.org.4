Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A225B5476
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiILGV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiILGVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:21:18 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2584A2C658
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:19:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id p5so9309547ljc.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GgI6sNuIiEld/+iiG14XAnJiIn6TNY0eqR/C3vJoJeY=;
        b=AZ2/CXMfG94NpKqvmvATbBdh/wh7IGSp/kCNkPmjDqn80oOyEquISBToVUWiKXE/Ak
         +XdNQSxmSGqe6CZOC+DNfOpgy0wNgLWKmMpluF0ZYQDV+RWoUIgbeVco9uY7YSKamjUY
         jSUa3W+AmX+vcLr8ElbE7gribHE+ixq4SrK6wJQOigGt3WAS9daXUSINGVolZgT3JWgv
         nAjkx5nmWIvYBRRKTCiyZjljBm+gso5dKp38A4EWLxkjuFnpErRliqs4BjuzSFEp84T9
         LUTBGDbyPcIvv1mCZhS04lAHeUI3ODv9nNe/JA6gOqiTvS7VAlV8RRbgNqIhIS1u2WtT
         fN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GgI6sNuIiEld/+iiG14XAnJiIn6TNY0eqR/C3vJoJeY=;
        b=LVo70wr1SjOoS3klw4U+ZNi1OrDdhSw6jbq51PkIoY3JRKoibLNp7NwZtUKzcq8Ttp
         jYg45LLA0CiYq5BblPMN/ntIKadbTae2g1kVqEm6d3fVVLunseyS33JPiC3rENG51iAQ
         A/Bb3HjGwgmMgZNIBLjKZjQJx1e+eIuEOwLmO1+5eZW7mafgZe9SQpFM4XYw6PlbFv55
         yZ0XpdctmUyGLlEuKOQJVqPI5QB7C6/r8TXfKRGXO2nJJ2AJnTtxn+n0Je5iDhxPuZLp
         SN6PCgZYqgEz/LTM9e7fBQcckPEVXjynmm5J39O8jKOmLeY0/PlLediCHKAXyRlRc3jo
         JOBg==
X-Gm-Message-State: ACgBeo0VKBBbP0jgfyk4JDGtjOFoWW3zWHGL+nFGuqm0v/zRfNO5HFTY
        QI8Qp2RxoimL+yVCwsHcso/3+Q==
X-Google-Smtp-Source: AA6agR4YgAvA7zMoENGzSneI75XAZYBTj1RKbWWcfo+LgroyLfiscFA2+fHOpW9UFcMiRO5yEGzBRg==
X-Received: by 2002:a2e:a587:0:b0:25f:e6ac:c287 with SMTP id m7-20020a2ea587000000b0025fe6acc287mr7087767ljp.416.1662963522651;
        Sun, 11 Sep 2022 23:18:42 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 35/40] arm64: dts: qcom: sm6350: align TLMM pin configuration with DT schema
Date:   Mon, 12 Sep 2022 08:17:41 +0200
Message-Id: <20220912061746.6311-36-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects TLMM pin configuration nodes to be named with '-state'
suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d882c29d53aa..c39de7d3ace0 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1314,49 +1314,49 @@ tlmm: pinctrl@f100000 {
 			#interrupt-cells = <2>;
 			gpio-ranges = <&tlmm 0 0 157>;
 
-			qup_uart9_default: qup-uart9-default {
+			qup_uart9_default: qup-uart9-default-state {
 				pins = "gpio25", "gpio26";
 				function = "qup13_f2";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			qup_i2c0_default: qup-i2c0-default {
+			qup_i2c0_default: qup-i2c0-default-state {
 				pins = "gpio0", "gpio1";
 				function = "qup00";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			qup_i2c2_default: qup-i2c2-default {
+			qup_i2c2_default: qup-i2c2-default-state {
 				pins = "gpio45", "gpio46";
 				function = "qup02";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			qup_i2c6_default: qup-i2c6-default {
+			qup_i2c6_default: qup-i2c6-default-state {
 				pins = "gpio13", "gpio14";
 				function = "qup10";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			qup_i2c7_default: qup-i2c7-default {
+			qup_i2c7_default: qup-i2c7-default-state {
 				pins = "gpio27", "gpio28";
 				function = "qup11";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			qup_i2c8_default: qup-i2c8-default {
+			qup_i2c8_default: qup-i2c8-default-state {
 				pins = "gpio19", "gpio20";
 				function = "qup12";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			qup_i2c10_default: qup-i2c10-default {
+			qup_i2c10_default: qup-i2c10-default-state {
 				pins = "gpio4", "gpio5";
 				function = "qup14";
 				drive-strength = <2>;
-- 
2.34.1

