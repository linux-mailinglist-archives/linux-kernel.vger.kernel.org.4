Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0805F129D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiI3Tah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiI3TaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:30:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F952DA94
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:04 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a14so5803142ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IP8p9vKToYJMy7wcnsAiwE01U8L1mn26stcaAumSsjA=;
        b=ZRGeXwx9H8hloVBNuC5lW4Pb6w5plXq0fP/sKDp0i6Nnu11GIZR2aq0K2WkYPpdCu+
         0yBTI1oK4TsTtTbrGINqytVdf3RrDbE2Pl5BDrPMF9nH5I6v6mNydOWUHa5Rabh/fDEG
         JqZ76njUUCcWEG5kEjPiiJm5nsbVgBwxf2DhN69orh0Lt0Lzk9kW7Ie57kFVOrKGcdQZ
         bt7K8RuTp1ISOIqQWTBUpYJUpHUkIEUMe2okkZD3JlaxTRuuqVF0Kgo0jxx84cTwK6a9
         zqzRZ2JYtMs8tFy0nS9I+L1JalHH0bkaTAyGhoDalwQxhzInmAl7/njceOoqlOz3VbVU
         rHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IP8p9vKToYJMy7wcnsAiwE01U8L1mn26stcaAumSsjA=;
        b=w5UfhTE9ZbLdobMeCM/H2sHcpZY2EDeLGpWYKov/59cILxhxcHh1s0WdwHZv6umhOs
         VQr2VInQQvdpU0X/8EbV6/avUcScPuMmE5jnMLWnn/Xzman8uxK2ZH8fGGPDzxPG+QZO
         b3XnZAFcsOSfft9C6G1pqucde6ZGzjrgkQ5BpAi5uQV1htDdmB6QAxBK83K56uJs6OGY
         O7W7n28D1+gN11tzo21H7Us42qWPhRZiHFznvHRDohRo9+jcjk2r+tAL3YeRJL0P/OqM
         XBQJMYAHAsgdPh6/+Cbsf7kiyOlJYRUrfaXCmjYaP1fDrQTRmgQdMofsFcZLBWCcw1W2
         CCOw==
X-Gm-Message-State: ACrzQf1pVZPIgYQMfsp8S1xkNEUFgsNxl0HNygtgKs/85ddehnFCoeTE
        +j/qqS+/pgM8hHlBzCz9toIVnQ==
X-Google-Smtp-Source: AMsMyM7Oys9jjR7mG/RUKXJm3ZLD6M1oAcZ6jP3vUEvULauUPZwZEsC7wuKN1B8dXmaGoxfRotThYg==
X-Received: by 2002:a2e:bcc3:0:b0:26c:4c59:75ed with SMTP id z3-20020a2ebcc3000000b0026c4c5975edmr3171811ljp.505.1664566202614;
        Fri, 30 Sep 2022 12:30:02 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b0049f9799d349sm393603lfb.187.2022.09.30.12.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:30:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 05/16] arm64: dts: qcom: sc7280-herobrine: correct number of gpio-line-names
Date:   Fri, 30 Sep 2022 21:29:43 +0200
Message-Id: <20220930192954.242546-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
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

There are 175 GPIOs (gpio0-174).

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts          | 1 +
 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts    | 1 -
 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts | 1 -
 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi    | 1 -
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index f0f26af1e421..4e0b013e25f4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -372,5 +372,6 @@ &tlmm {
 			  "",				/* 170 */
 			  "MOS_BLE_UART_TX",
 			  "MOS_BLE_UART_RX",
+			  "",
 			  "";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
index ccbe50b6249a..739e81bd6d68 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
@@ -328,6 +328,5 @@ &tlmm {
 			  "MOS_BLE_UART_TX",
 			  "MOS_BLE_UART_RX",
 			  "",
-			  "",
 			  "";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index c1a671968725..c8ff13db30b9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -358,6 +358,5 @@ &tlmm {
 			  "MOS_BLE_UART_TX",
 			  "MOS_BLE_UART_RX",
 			  "",
-			  "",
 			  "";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
index 4566722bf4dd..3dff610fb946 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
@@ -321,6 +321,5 @@ &tlmm {
 			  "MOS_BLE_UART_TX",
 			  "MOS_BLE_UART_RX",
 			  "",
-			  "",
 			  "";
 };
-- 
2.34.1

