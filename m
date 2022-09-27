Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043F15ECAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiI0Rh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI0RhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:37:19 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF961D2D2A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:37:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h3so11766288lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lYqcncrJGbkL6jJNc/7gkbAt6RxgsaRGH+e6gIoil6Q=;
        b=GpTs1D7KwdJaD4GMtF7yHB7ekrTcNh/FAi6MKN+ALiPeD85JxLsVJ7wUgNCGcg9h4p
         yK2IQXjwtMotWpoWs8F8kJIyOwRBhIWjRr+yCne/OvZhxgyIKkhMWOa70vWT1ts59M7y
         K9LmAnWyJiI5SlLtAtFD/iaUyaZKMXvQoStm5GtCSj6yCb351LO3+u/cLCCVNqn0yuhk
         lZyPWQnnRNGTTOmZiD0Tae3Bi6RBYD5tIIZlXQMey1NxAI6bLSgycQA+ug4s6/iCcSm1
         UDH4lbgWOGfvAYgf9OamPZISZlbciep0JgUhS11jKDw6yofMs0EuL3Qw7gBucjzHp5ao
         Si8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lYqcncrJGbkL6jJNc/7gkbAt6RxgsaRGH+e6gIoil6Q=;
        b=I7q61wstp4Jp5RGZ71RiOihIHeJ7UmIy07T4dgVhs1u6nzCKqnAZskLikk/0qofNHy
         GAOx0XAmgx0ybs80+S1derx+/xfgIFEDkPNroC6x9iYFUB3AxPbvaEq0KwpCqy9joklD
         102wunyYsVA1tfbHQcRhvldv2Sr66l2fMbkcHTbJHEATjgOz4zPgRSisky5vqwgWUTsp
         gEG4Uv+bk26bYzorBFIDr0+HILOV+cObQKP4ox4SlLBPyQQgbSt7QnT1Yeei1B3UDRnz
         zio8MRR4rHhgn9PXpcy43osLuGJ3hnoruAxfYeIFn6LezRgT+k2ic4v0+c4KvYxM8v9v
         UmNg==
X-Gm-Message-State: ACrzQf3wLLRzp46GvTIDKxYg4197fUuwHAS3X+3Pe+b0c3KvhIAPwvm6
        x5wTgl3MAt3/KxWLLxZKQx7ekQ==
X-Google-Smtp-Source: AMsMyM7838SqPCdhGV8cY8t7zcatz3PPQu+joRYoWTPbfu6z10AbVoUu0ginTxBSIpsj2DVwvJJWIw==
X-Received: by 2002:a2e:8848:0:b0:26c:cbb:9a1c with SMTP id z8-20020a2e8848000000b0026c0cbb9a1cmr10493970ljj.165.1664300237317;
        Tue, 27 Sep 2022 10:37:17 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:37:15 -0700 (PDT)
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
Subject: [PATCH v3 02/34] arm64: dts: qcom: ipq6018: align TLMM pin configuration with DT schema
Date:   Tue, 27 Sep 2022 19:36:30 +0200
Message-Id: <20220927173702.5200-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 4 ++--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index 6a716c83e5f1..ec999f972360 100644
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
 		function = "blsp0_spi";
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

