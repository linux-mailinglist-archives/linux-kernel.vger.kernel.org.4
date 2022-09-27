Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A606D5ECB5D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiI0Rl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiI0RkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:40:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31B91E8034
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so16752573lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EdFPEdu98Qeq/DyGzm+zuDUjyhN02vIkP9ZedDus6Ik=;
        b=Y43EAQLom1oxkcFJL6OdnJOmFbSJUKGhTJPZZXTkv4KJT7QjKk7MoP1OgLVO6vWlFz
         FHcSjm29M+YvgzjweWk33WktUzNq2nv2ngMGiYsRl/72a74a47glSazUJhpofvgXiiBf
         0TvoRN2OHg7z3Y0KsRnTgmZeuFrI2q37QFhBd16OxSiu7D4cZhw7n6wvRjfKXw7SYbiX
         i2bybTY+3u7t4vBcLDtR4XEBeE2bHeWvMGErURtuJklTodJ3y/IlkbprA0Wx4ZiqrDf+
         DOfHmIm2PoWdXga7FUIctDl2mAHTy/QrQOmVmSBLutFNLOJFQFlSfLp3CFvhZGheE3w4
         fVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EdFPEdu98Qeq/DyGzm+zuDUjyhN02vIkP9ZedDus6Ik=;
        b=AepoWEAhYVgLDKzA37vdy01NOFDMiPO2OqV22nNQ2z4MVgi7iOR270hoaqiVI2tCwW
         U3803dciE6WaFS4ycm2wq+eisQuWcu0gRHfMACPxCYL0A6UvDHX5GayM0IZpMbwxYxWe
         vNB84RosfCZnQZkO1OZlcvM0/hwUefSzxHM5XcIj+2FdhIFpAfrNsOFY6p6IDGZGkWvH
         n+FnkbVjHpZKlH4T1kDIhTpxmnrjTTm3MyyPfjtf2cqA/SCVwfievzANftoTHmvvMoRB
         9PB3yfbHiYSrC5ieL2JXnCgLHoncuI3bSN9i8JfEgGnXzNRFjWjhE+fduduE41wyd3a6
         BUzg==
X-Gm-Message-State: ACrzQf356e/FmGEbpUmEWg/KRUAOaVJ4pslLRrdzKOtdtFLYPu7EpUhM
        KnJCzytNtVcvRl6iEAwqfP6mQQ==
X-Google-Smtp-Source: AMsMyM4A5LRv+AG19HGCKM2Au/P+2JjkTMQs+iwERXAu8cUE6Ei6/qEmNyWOoH2YRo5ZVcxxAF1eYQ==
X-Received: by 2002:a05:6512:10cd:b0:498:fe5b:8ab3 with SMTP id k13-20020a05651210cd00b00498fe5b8ab3mr12332626lfg.613.1664300345904;
        Tue, 27 Sep 2022 10:39:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:39:04 -0700 (PDT)
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
Subject: [PATCH v3 28/34] dt-bindings: pinctrl: qcom,sdx55: fix matching pin config
Date:   Tue, 27 Sep 2022 19:36:56 +0200
Message-Id: <20220927173702.5200-29-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.

  qcom-sdx55-telit-fn980-tlb.dtb: pinctrl@f100000: 'pcie_ep_clkreq_default', 'pcie_ep_perst_default', 'pcie_ep_wake_default' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'

This method also unifies the bindings with other Qualcomm TLMM and LPASS
pinctrl bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml       | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index a38090b14aab..fff57abf4fbc 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
@@ -45,9 +45,17 @@ properties:
   gpio-reserved-ranges:
     maxItems: 1
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-pins$':
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sdx55-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sdx55-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sdx55-tlmm-state:
     type: object
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
@@ -146,7 +154,7 @@ examples:
                 #interrupt-cells = <2>;
                 interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
 
-                serial-pins {
+                serial-state {
                         pins = "gpio8", "gpio9";
                         function = "blsp_uart3";
                         drive-strength = <8>;
-- 
2.34.1

