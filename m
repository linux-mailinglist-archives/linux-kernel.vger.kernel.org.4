Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17225E9AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiIZHoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiIZHof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:44:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7657B209
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:44:30 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so9473450lfo.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8lAIBCt1PKqT83z5Pfqrod3Tf9eYcvIt2hipTAD1Nug=;
        b=z6UFlG3OfdGAbektYn9KWNPF/J+44kdBVEwwsnBbZjAsd9PPF/+ifouKAfnU9BYQaj
         0iojt0yirV65C2x8aOlpVUhjq9eUOM1pHMwG7M1anrgaDZUt9t7XFfrto0MOUmVggmhh
         1JWoZc/e20lX3czt6Np+UglxFuII6/qcZ6+zIKeRv/6Eos+LpY+jZVrsdwVbLl1IZPDO
         Zf6S8NGRwn0RxT8T4uX4H1fKy9jiq4PRjHz2+rZdiFwampllU4frO3cygbsq+DCOYU9G
         lpfegom8dMH28BJhVcL9Qc+HB2FjQeqUgctPKsnIWE2xZqy6mAMtthpN+gieup+EVXGE
         b8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8lAIBCt1PKqT83z5Pfqrod3Tf9eYcvIt2hipTAD1Nug=;
        b=DtHr4tE/uaA7vRBjRAUvmGnYf1xvzGQmvHIhpwuCB8ZeGD8DseowToLq/NRTZzRRtH
         gUUAYDzp3nBW9lCk0nqq34O96y/W+e34q5BdgkUOav8GJKaUKJwIDNSe87Cp2CNuwTaG
         UquRD4U4lrMJhJ6hbZepxZDHtXnerQc5F64qn41qCloUD2JUqdROeUNnMm1YJFLID1Fd
         Nf8d6dhWYbWNzrpeUj9yK7IQ3agbccIA6xbdtKNj6b0w8BCwQX2XOM24xwRCaD3tg3QT
         CSpU+kVObGwo0if8UjChXHgvnobVDR9RbQYGEQO+wRWJXf+hvjiFNsLSuVlsC9ebi+mt
         Ic+A==
X-Gm-Message-State: ACrzQf0I4MhACpZJDtvfYsPDOAYBRtGlTtCP4owQoSWV0nR6naKQPprB
        rCDGE9nmtSZZn1Dx8bV3Dl2hhw==
X-Google-Smtp-Source: AMsMyM4rHC7YjueErdrmzj3FRdvvBSIRB2BGQ2H5XWZN9TaL4pE63huMoVQFKS7PmubF6NY6oSMcfQ==
X-Received: by 2002:ac2:58f8:0:b0:49e:da5c:1349 with SMTP id v24-20020ac258f8000000b0049eda5c1349mr7895305lfo.444.1664178268742;
        Mon, 26 Sep 2022 00:44:28 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:44:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 02/33] arm64: dts: qcom: ipq6018: align TLMM pin configuration with DT schema
Date:   Mon, 26 Sep 2022 09:43:44 +0200
Message-Id: <20220926074415.53100-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 4 ++--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index afc2dc79767d..e1fe7d598580 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -51,13 +51,13 @@ flash@0 {
 };
 
 &tlmm {
-	i2c_1_pins: i2c-1-pins {
+	i2c_1_pins: i2c-1-state {
 		pins = "gpio42", "gpio43";
 		function = "blsp2_i2c";
 		drive-strength = <8>;
 	};
 
-	spi_0_pins: spi-0-pins {
+	spi_0_pins: spi-0-state {
 		pins = "gpio38", "gpio39", "gpio40", "gpio41";
 		function = "blsp1_spi";
 		drive-strength = <8>;
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index a7c7ca980a71..9b9f778090e1 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -218,14 +218,14 @@ tlmm: pinctrl@1000000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			serial_3_pins: serial3-pinmux {
+			serial_3_pins: serial3-state {
 				pins = "gpio44", "gpio45";
 				function = "blsp2_uart";
 				drive-strength = <8>;
 				bias-pull-down;
 			};
 
-			qpic_pins: qpic-pins {
+			qpic_pins: qpic-state {
 				pins = "gpio1", "gpio3", "gpio4",
 					"gpio5", "gpio6", "gpio7",
 					"gpio8", "gpio10", "gpio11",
-- 
2.34.1

