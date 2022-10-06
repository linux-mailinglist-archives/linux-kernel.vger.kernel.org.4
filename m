Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C905F669E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiJFMsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiJFMrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:47:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEEFA2AAD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:47:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r22so780412ljn.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DTnkMyPtDfiwoSgvFf9kmj5h7qwOf7FMQFhN75k8kMw=;
        b=ciXpxLHWeo2k6aiELo73Wm7k5Sxf17v/fd6IcSpQCIXq1zJb9ik6ZDAdSfEwooRseM
         YKep+K5MizcKry35ksqSfezCVbwdcIxlXDQMUJ6Y9hbqW6tPvUg/3A7E2tZRfP4QxV+4
         5zEjlglm8+GQFKSDM5PdGibhx6kqNnkxd/hz/yaUhek8G2GuQCTCQ8jNYYcXmW0Smg1E
         vxdbl/NdoKQ4cL0aK8W9+Z9EotoHogLr6K9sGo6Tn5CLOlHbRw7cuOW1cn3AoSuvLwtk
         6UPKKkaJPcVUfPEyBMiJgI+GAft/uAo0nX7cgL/Vcxsv+liPpTu4jB3NfyjGj773eCck
         Od+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DTnkMyPtDfiwoSgvFf9kmj5h7qwOf7FMQFhN75k8kMw=;
        b=zXaaoTWX+ltgkWPl1Gw8LTUUW95XhLcADXj06yuK6YLcgc9EO4LAzJd5dp9fa4/1yG
         92alGEWZVn7KfkFOdt42+iEJ7vbOOegPA3H/ryGvJatr5szp2MqcDRI3qHC9kqeWKLrQ
         62jgCIjlMF8D4xuHXKCPCBjlh8/uvEDPCHW8xZCnBXnuNW3DC7anNj5aEPKlr77KH0eH
         tHrCeX5tDOwTYwV1zT4+xaoxYnMG9FbqaRgbQn3eb5gDeV899hiVkGzXvyeC7xVwx+SR
         uIUDKhwFTzn/yYKeSct3NqN/CX3v6OqP0sCgGCzXvc23UwJsoK0fClzyk8v4+TZ+wYAh
         Ndyw==
X-Gm-Message-State: ACrzQf1zEpuHfPrGdHn5gct/y8H6H0la4obW/jhOlaUYF+VON35kDZua
        rOc4DJlk4+doeyTUR75vlYOUjw==
X-Google-Smtp-Source: AMsMyM6Gdx5ci4rSKeYaoMypk9fsgeXCvKxqkKJUKm2G5jdTcRNI4tJyCjBsD965OdQZkdvY8W6hCQ==
X-Received: by 2002:a2e:bf0f:0:b0:26d:e258:9ff6 with SMTP id c15-20020a2ebf0f000000b0026de2589ff6mr1840996ljr.356.1665060438970;
        Thu, 06 Oct 2022 05:47:18 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:18 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 15/34] dt-bindings: pinctrl: qcom,msm8226: use common TLMM schema
Date:   Thu,  6 Oct 2022 14:46:40 +0200
Message-Id: <20221006124659.217540-16-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
References: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
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

Reference common Qualcomm TLMM pin controller schema, to bring common
properties, other pinctrl schemas and additional checks, like function
required only for GPIOs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v3:
1. Drop properties and required items which are already provided by
   common TLMM schema.
---
 .../pinctrl/qcom,msm8226-pinctrl.yaml         | 33 ++++---------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index ecb90c77f666..158c9a50101e 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -21,26 +21,12 @@ properties:
     description: Specifies the base address and size of the TLMM register space
     maxItems: 1
 
-  interrupts:
-    description: Specifies the TLMM summary IRQ
-    maxItems: 1
-
+  interrupts: true
   interrupt-controller: true
-
-  '#interrupt-cells':
-    description: Specifies the PIN numbers and Flags, as defined in
-      include/dt-bindings/interrupt-controller/irq.h
-    const: 2
-
+  "#interrupt-cells": true
   gpio-controller: true
-
-  '#gpio-cells':
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
+  "#gpio-cells": true
+  gpio-ranges: true
 
   gpio-reserved-ranges:
     maxItems: 1
@@ -60,7 +46,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -101,22 +87,15 @@ $defs:
 
     required:
       - pins
-      - function
 
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-controller
-  - '#interrupt-cells'
-  - gpio-controller
-  - '#gpio-cells'
-  - gpio-ranges
 
 additionalProperties: false
 
-- 
2.34.1

