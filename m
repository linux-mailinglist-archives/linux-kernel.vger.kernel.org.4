Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580FE5ECB62
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiI0Rlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiI0RkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:40:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C431E3F53
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s6so16771059lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EGhxJ0JptFAB8FEIZTdaS5Ga4GZ33kMJV3Efk94SpRg=;
        b=tZR15wNkAOnS8cpWG4AA+dlutl6xt8U0WEeBXwkIRMP6lWrOODbRYDgKy1oOfhP1di
         llroUKibJ8s9WU9iX1NVJY48P+HhbjuPZcjoyU1pKBAZRxNax7ga/Fxvn0CcYJP4BYeL
         1CgW6RpDK6ziPVZcYLzPO6McE6X/62f02ig0n/vTQ1XcX9CMPE5HhB0Zs2PTPYBGvwAy
         NGRgsDe2XY7whoPF7+L2Gf/fMjesMieAi6hImzvuiMklQ2s/0iY6wdRXDUyTu4mps8rx
         gw/oOPRD9i6qY7rXLtPvsNA+OGm9bt2LujYTZtBxy6LW2CboHgrdQXmj74tISWfAlY/c
         KsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EGhxJ0JptFAB8FEIZTdaS5Ga4GZ33kMJV3Efk94SpRg=;
        b=MgjctfosawnLOcLDq29ikTa4WdjDgVAiJNlRtd9eGnS0DoCGXuOsA4DCndYKApwQQS
         ObdNdtcoNaOLZcoQPSH8502tKrsnIeLPu3z9XUGkg+jNi57JKqnMBf7KzjGVO6TxtV83
         ZGYmEPk4xY2hzor4lKKUvpQe9BJdgW1RkEmwOHjQcuxBh94kMzeS/ig+u/IFIs801ohZ
         5F7yTz81zpP6o6rOkU3LPvbNiqXJolqhRuiV+Q4JiWKt/y6glFoEuDKBtzYs29pxEG0h
         Njm34Ev+/vwhd5cApMYIk7n3OuPqXReruCTKEmGo41bbxkXCIGV9nQoBIoDOQ0psVGnH
         LCyQ==
X-Gm-Message-State: ACrzQf1mjISQivjBwt36Y16GwqDkzOlbMy/4JfQ+N8cPQkSCGRmEgXtG
        5YEwJL9ZG/2RMTisp0K1tDvo+g==
X-Google-Smtp-Source: AMsMyM4L6ieu0ioQjxjQZDtJDHVScPuhqnm4vXAksExHOriSXxJK2iazo5Sf0t0S8uDSe6UG9ev+3g==
X-Received: by 2002:a05:6512:31cf:b0:496:f023:5471 with SMTP id j15-20020a05651231cf00b00496f0235471mr11805249lfe.133.1664300334046;
        Tue, 27 Sep 2022 10:38:54 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:38:52 -0700 (PDT)
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
Subject: [PATCH v3 25/34] dt-bindings: pinctrl: qcom,mdm9607: fix indentation in example
Date:   Tue, 27 Sep 2022 19:36:53 +0200
Message-Id: <20220927173702.5200-26-krzysztof.kozlowski@linaro.org>
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

Bindings example should be indented with 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 .../pinctrl/qcom,mdm9607-pinctrl.yaml         | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
index 57a4fed55de7..a37b358715a3 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
@@ -120,14 +120,14 @@ patternProperties:
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        tlmm: pinctrl@1000000 {
-          compatible = "qcom,mdm9607-tlmm";
-          reg = <0x01000000 0x300000>;
-          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-          gpio-controller;
-          gpio-ranges = <&msmgpio 0 0 80>;
-          #gpio-cells = <2>;
-          interrupt-controller;
-          #interrupt-cells = <2>;
-        };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@1000000 {
+        compatible = "qcom,mdm9607-tlmm";
+        reg = <0x01000000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        gpio-ranges = <&msmgpio 0 0 80>;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+    };
-- 
2.34.1

