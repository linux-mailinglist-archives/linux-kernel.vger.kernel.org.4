Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A13C5FFA7C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJOOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 10:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJOOFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 10:05:34 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6127B2F66B
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 07:05:26 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b25so4207712qkk.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwTSZl4FjA5X+MSkGnECBxix0aF1j2kA0PRX2dyY1HI=;
        b=S/INp6HIrd1DZNj+papXumYFuxq/i+BmQX4h4o9ArX9GxjUr5NUIZGSD6ONYtpq198
         1w4O6ffGyAAfOEWTViXfAX6B96NbtuUGQd9zEDeB3FsgMbqyHsPRbbeunn3EPI9ctMWL
         GykRdzGAZM30RqwfNJwsop4/O7L8YR+91VuX65RFd0FGBfBCZ532IPdYEwpMEQXZ5NA8
         7bnEmLAURryyTOJP+9jZLJZOCdqzIr2+wYt1EEx8Cmm3p20JCcZPi8WH+kO5PGYZzbKq
         TN+fCxOd3jGpRjm4L8UHHAWELVeT9s7KtffgYQnijhXx9TJuJ7bKJzMGKRuHi5snZhfT
         2iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwTSZl4FjA5X+MSkGnECBxix0aF1j2kA0PRX2dyY1HI=;
        b=KRvd6Llj8NZ0c87/ryHI4PLEsX4uFmfomWlwcwjdcZxJb+DrJitK5Ip59j/r+kk8+G
         H4YGbF9oapxE2k8g6yWyd8Ya7ETn4tm97sMQFNVYiO/E1yhNO3ljA9kBenesaPgggHR1
         FhfgK169jzxxlkSF/bfbJp6nozFPK3Wmuds2o1BFn8/BXpKRtsgP6Q5e20mXaknC1LeM
         YXZvQCcxZfr7yemvQspXVV5Jf5Lztqwz8pI8RQWd0d1OK5AfqyhOqQmsy0a6MswMknNb
         F7uKUEbXX0PNmfyigpbn4vmDwfBSWld4+uiFDeFfL+8QldI3pmzqPKm5tl1cbUFBWtWh
         tmxQ==
X-Gm-Message-State: ACrzQf2fQkJAGaoS1+DhHOTuIR3NeHyDSf3CaRYVErLvxEipANMLH1+X
        fHfP0Zs7Y99SZGFfObwcbBAwhw==
X-Google-Smtp-Source: AMsMyM5kuRxWlh9mEspwdnZTzbDCBB6gzC7nHcFacIognpKWz4fSFv6zSH3vllWOfJd41v52mjRHwg==
X-Received: by 2002:a05:620a:1133:b0:6ed:72d9:dbf1 with SMTP id p19-20020a05620a113300b006ed72d9dbf1mr1874846qkk.752.1665842725177;
        Sat, 15 Oct 2022 07:05:25 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:161:5720:79e9:9739])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a29d500b006bb78d095c5sm4958022qkp.79.2022.10.15.07.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 07:05:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/5] arm64: dts: qcom: sm8350: Add GPI DMA compatible fallback
Date:   Sat, 15 Oct 2022 10:04:46 -0400
Message-Id: <20221015140447.55221-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org>
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

Use SM6350 as fallback for GPI DMA, to indicate devices are compatible
and that drivers can bind with only one compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a86d9ea93b9d..aa08c0e065c7 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -678,7 +678,7 @@ ipcc: mailbox@408000 {
 		};
 
 		gpi_dma2: dma-controller@800000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x00800000 0 0x60000>;
 			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
@@ -904,7 +904,7 @@ spi19: spi@894000 {
 		};
 
 		gpi_dma0: dma-controller@900000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x09800000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
@@ -1209,7 +1209,7 @@ spi7: spi@99c000 {
 		};
 
 		gpi_dma1: dma-controller@a00000 {
-			compatible = "qcom,sm8350-gpi-dma";
+			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x00a00000 0 0x60000>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1

