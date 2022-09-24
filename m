Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA65E8986
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiIXIGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiIXIF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:05:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98769120599
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h3so2342575lja.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cGaQ8e4uNHVgE+zInbqahLbk6anJu3w+VY6OAYjn4Sw=;
        b=jgKb07IEFCnzodKEn4Hgz45nekbx1huLoshFOlSqC1myNkdxIfx//X+XQNEpmnW6/2
         rj9DXO3EdnXb8bbwdKU+16mFwuiAXr3WDsCbjsk9NIzlB6HvRI/10og+FLjh3WiVfbrJ
         4KAhaiZ2l7yv1NC8URFG5E3upgTkG3WosH88J+vCgc4KLvyHt2lRkUMXpKp+Oo22sYpD
         D8L8vMjRs2bbm/hyc0n+YuMmRNqCzir5XMGZpkxvmj6yTvJGgKYdLZgkCxlkpLePGJfd
         eOED2+tM20K2h2cV7BPJO8TTBsxW96M3uklMcRRuUSh4ChiUwykUodDW3nPA7tm26BAH
         +vUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cGaQ8e4uNHVgE+zInbqahLbk6anJu3w+VY6OAYjn4Sw=;
        b=o+DsmlMeAG77HGt40i7EeUIBCU4ZcumQZII6RhcICW5X336Yt1Lcvi3suk+p3Cr7HJ
         Nd7GUnjBdo2SrkdvAwwYnD8dbtS33EwsERaTtPGMMv4VAdUXtvNM52L/KWeiiBn2ed8h
         kw8RfpEghpFb4Evc1oR94/RjSwWvPvf3Ykh/MbbmzkHOhYr2xjfAzCdeTTR1p8Hu59GQ
         Z0phXhRq/kQmz366FwY/Bei2eVI20N5BOVNZojJv7VXFcLiFXnvHESr3B6GnCeS5tpRZ
         ybRKQLhED7CsulTpfSUlvr5iz1TkQ2HQDFEAmiAnSA5Mb3VRkqn6w9PtRnznMVoDW24A
         MAvQ==
X-Gm-Message-State: ACrzQf0BAUn2kY1aeh5mQ3aF0jVhA/TEn1XLbVpJVzJDMvIALaZiWN3D
        dQiInPrTJv4ynkGqDCYTr5KnJw==
X-Google-Smtp-Source: AMsMyM5QmGyvwqI6fVrnfhExwT4jyDCZJk1E/w7xst5Wvc0ogWN/ccxXzYSjPxQY5zqRkHeL512NtA==
X-Received: by 2002:a05:651c:110f:b0:26c:68f4:5b31 with SMTP id e15-20020a05651c110f00b0026c68f45b31mr4054209ljo.29.1664006722009;
        Sat, 24 Sep 2022 01:05:22 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm1696668ljd.30.2022.09.24.01.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 11/32] dt-bindings: pinctrl: qcom,ipq6018: fix indentation in example
Date:   Sat, 24 Sep 2022 10:04:38 +0200
Message-Id: <20220924080459.13084-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
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
---
 .../pinctrl/qcom,ipq6018-pinctrl.yaml         | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index 2026fdac9fa8..075d014b2ec5 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -150,21 +150,21 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        tlmm: pinctrl@1000000 {
-              compatible = "qcom,ipq6018-pinctrl";
-              reg = <0x01000000 0x300000>;
-              interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-              interrupt-controller;
-              #interrupt-cells = <2>;
-              gpio-controller;
-              #gpio-cells = <2>;
-              gpio-ranges = <&tlmm 0 0 80>;
-
-              serial3-state {
-                      pins = "gpio44", "gpio45";
-                      function = "blsp2_uart";
-                      drive-strength = <8>;
-                      bias-pull-down;
-              };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@1000000 {
+        compatible = "qcom,ipq6018-pinctrl";
+        reg = <0x01000000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 80>;
+
+        serial3-state {
+            pins = "gpio44", "gpio45";
+            function = "blsp2_uart";
+            drive-strength = <8>;
+            bias-pull-down;
         };
+    };
-- 
2.34.1

