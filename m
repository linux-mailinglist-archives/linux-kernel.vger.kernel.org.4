Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB9601D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiJQXM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiJQXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:12:41 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FE285A9F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:12:14 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d13so7678799qko.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQsQdPAjYV4OVBrRK4QovKjtdPgWInj9IFZR7QJJo9M=;
        b=r4GFM9PbOvU3Vq8IQA1LUVoHnLl0czMVhsMy/95Jrh1Fqq9xKn0S7E8D4/KdYJ71wF
         UMndOBldv+ZEYV3/BfZ8Xd79dPlUUKHLNVNIEqFx5ujyzjzlBaefQhbL0zdkTmvwA2qs
         tfN/opiIOx1gmBqHeTppNJnnCv3LBJuADIxOpKpNvEgbXz0fyKVJSElbZMIEKrSccIW5
         ynEkcOvJ21Rdzey6jVvTWPUWPqFQH9SxYkAdOBMKFmXuDdYxP3VBMoRsIZYPs6LtFc+S
         GUFFD4mhh9lxq3kOlar066dhpVzhBcbEvgpMwb4LpD/87ogMrMfjV/1GGPuUSwiGpICr
         5vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQsQdPAjYV4OVBrRK4QovKjtdPgWInj9IFZR7QJJo9M=;
        b=UmlIjoqu3LZGSxApjvO3HdWIRbwqQsLyYWHZQKUV6NU7fq6SX4joz/kD1ivy7i3//T
         e9Aj0hbIrjYi/8mVX0DDYkLwSc9Pj3iZ2sooomrPO4/NBpyIlOJhNvzyxIspjGhOWk/J
         PFZtjtgRcBSfAhlHkWEYi9GQgCXKVaxTPb40zDXceOZI+iuaID2yJVR5MLpm9toIv1K4
         yfRrY8lgh3nGpRmqL1zFETmR4RcPl9TL3u/L74jAaGCmoRsrvXNuGaZWhwiKieKvy36o
         kSTcZHAd2G+UXDIsLpLiBlgHNMhR/nHOGCdEfg4bswh/pKtgZMHDuXjy/6ohVSNUSYlA
         tF3Q==
X-Gm-Message-State: ACrzQf1xqy615kX6iHI0SiU2nRmctrF8LDihokJ3BDxlt/V7OMhzLGX2
        FHrj8gadNVX2FlYoe5k+380BKZaazo6rqA==
X-Google-Smtp-Source: AMsMyM4EuUnYVbp4IKupMTgrrr2WcrNX5jVINnIH9l/9MCcz+yjMr7TRoMlwrjwDGp7VcGmLsRqEzQ==
X-Received: by 2002:a05:622a:449:b0:39c:d73a:e7d5 with SMTP id o9-20020a05622a044900b0039cd73ae7d5mr10947732qtx.276.1666047685695;
        Mon, 17 Oct 2022 16:01:25 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id fg11-20020a05622a580b00b0039cb9b6c390sm729670qtb.79.2022.10.17.16.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:01:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 26/33] dt-bindings: pinctrl: qcom,sm8250: minor style cleanups
Date:   Mon, 17 Oct 2022 19:00:05 -0400
Message-Id: <20221017230012.47878-27-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
References: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description (and align it with other Qualcomm
pinctrl bindings), drop redundant minItems, use double quotes
consistently and drop redundant quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index e424ffc1472b..c80f3847ac08 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -9,23 +9,21 @@ title: Qualcomm Technologies, Inc. SM8250 TLMM block
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  SM8250 platform.
+description:
+  Top Level Mode Multiplexer pin controller in the Qualcomm SM8250 SoC.
 
 properties:
   compatible:
     const: qcom,sm8250-pinctrl
 
   reg:
-    minItems: 3
     maxItems: 3
 
   reg-names:
     items:
-      - const: "west"
-      - const: "south"
-      - const: "north"
+      - const: west
+      - const: south
+      - const: north
 
   interrupts: true
   interrupt-controller: true
@@ -121,16 +119,16 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     pinctrl@1f00000 {
-            compatible = "qcom,sm8250-pinctrl";
-            reg = <0x0f100000 0x300000>,
-                  <0x0f500000 0x300000>,
-                  <0x0f900000 0x300000>;
-            reg-names = "west", "south", "north";
-            interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-            gpio-controller;
-            #gpio-cells = <2>;
-            interrupt-controller;
-            #interrupt-cells = <2>;
-            gpio-ranges = <&tlmm 0 0 180>;
-            wakeup-parent = <&pdc>;
+        compatible = "qcom,sm8250-pinctrl";
+        reg = <0x0f100000 0x300000>,
+              <0x0f500000 0x300000>,
+              <0x0f900000 0x300000>;
+        reg-names = "west", "south", "north";
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 180>;
+        wakeup-parent = <&pdc>;
     };
-- 
2.34.1

