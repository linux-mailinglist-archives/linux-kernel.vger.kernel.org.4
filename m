Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432645ECB25
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiI0RjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiI0Rij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:38:39 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B4A1D9819
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j16so16823113lfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QZpy1tQNR59VQx71GuVhrGdOEH9JzyWI/ex9XtbiKQ0=;
        b=cBr+FXjI2QdZouUINVDb5snru1miuCdF0/9KuAlaFeBNR3FerBcm0MSlEd4JRMe8LO
         Sm50aKKepQObpqku0nKbPzAOPcCdWInvwh/Q3ScyNla+FQwdX72dFsDQmpE4kEqVfneK
         tJ/QD1cJU/8JnmjmjRJqIHFWQOK23wPUOh16xlY6f6bUSyy44mOZ+xwxhl3jB67Yc7X0
         7+Vzy1L6rsXWh3cslj50vVcuNGilxXJaBolDluGzixZSPrVlupFuVK0uVvvcxrdMETc6
         BhuNO9stpCep9glQlYRK4zkQ9wkcu54ffp2mcD0b8xQ6OtP87qXGMl2X8kBYLxi1us93
         bIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QZpy1tQNR59VQx71GuVhrGdOEH9JzyWI/ex9XtbiKQ0=;
        b=xgXzDC4sR9LBBbNV2HrOfFLPPs1zFWLeuDWX5//waaf6rqV6nf/TD42UgwixwNBcN2
         zW8hlCOmQ4JobkEvifOVozNeM+VrHovxuv+2zRndpWXPneknCE/oSSfNCptrdX6QegiB
         C1e9X4GB31xC4ryK/RcT38SYsJ2GH6FapQBXmVbekW/ya/YJJXRLQiju8pw2IipNflr3
         7oc/Q9TyvqwmHgpxxnbnAbZWCG4pxv5tHyi4ldwYnq3lXW8h2zzCJIaSPTVzwlCDmHpK
         oAkPdwIaMMzYGTZeOmf8o0GpRnBf8ec6NDRuoAR+D5JxNJoQn9XW4kJ1/xCx8NHrpkib
         lOww==
X-Gm-Message-State: ACrzQf3TN4l+Cc2iNfq8OmG+zowrwlHGYBXc5Wj2Pbusv9vUYWg8ieR8
        sL3C7kuHKmKsgh6z/C/yVTLW9w==
X-Google-Smtp-Source: AMsMyM48G+IHPuxXwnXw+FyxHn5JBEimD90hr4zfb5of9AjoGUI9FgEmH3Tw2607uxpd0k8ochWDUw==
X-Received: by 2002:ac2:4d0b:0:b0:497:a7fb:229 with SMTP id r11-20020ac24d0b000000b00497a7fb0229mr10956634lfi.174.1664300300449;
        Tue, 27 Sep 2022 10:38:20 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:38:19 -0700 (PDT)
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
Subject: [PATCH v3 14/34] dt-bindings: pinctrl: qcom,msm8226: fix matching pin config
Date:   Tue, 27 Sep 2022 19:36:42 +0200
Message-Id: <20220927173702.5200-15-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.  This method also unifies
the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index ab4a2b4cfda2..ecb90c77f666 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -45,9 +45,17 @@ properties:
   gpio-reserved-ranges:
     maxItems: 1
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-pins$':
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-msm8226-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8226-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8226-tlmm-state:
     type: object
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
@@ -126,7 +134,7 @@ examples:
                 #interrupt-cells = <2>;
                 interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 
-                serial-pins {
+                serial-state {
                         pins = "gpio8", "gpio9";
                         function = "blsp_uart3";
                         drive-strength = <8>;
-- 
2.34.1

