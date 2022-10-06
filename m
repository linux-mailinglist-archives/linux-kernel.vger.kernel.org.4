Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5285F6948
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiJFOJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiJFOIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:08:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F435AE85A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a29so2904006lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rPePIxM6Y/sOUxqRiFOj9TXWv8lmKuHZe3uWTu0CGZ8=;
        b=dKbL8C5a3O4j+ERMgEcPgCMacaje6rMWEI69Elb+dIGmXSUg1mlwwGp9K5Yzafw98Z
         P/AjyBtyavdm/LbPZ+2TakEoWXtiptA4sCUR/9ODLVyBd6dHQyCe98ommn/cCGq1xmc1
         JG6Jto9aS4G7SgUHj3yMqgSeA6FdPJNT6h84MCvAxqAjtQ4R51wrnjo6BOVGkZQdn2cy
         J0S5C8FtuZoWmwI85/rWByoRXhiatbeKPwAhh/GAdAB/wCVYmGPsVVcMv9+RQx0p8xqF
         A5veS/GHZMWRtzHXNQ+LVFjZun+fAhw1IOrKeidywkmqGEtrv5+FhJcq7l3sDGsjyGZM
         ghQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rPePIxM6Y/sOUxqRiFOj9TXWv8lmKuHZe3uWTu0CGZ8=;
        b=3kVdlCGZ42mkbVcWwFQopd0TLCfg08mc79ZvereXTuYznQOCJG1jvjpkJ+V1zpLCPI
         fEyWSSZ2Eu2GkB6tKO+XqsWIYxpAVl9MrR/izS6eTAqD3q3124VoJvVWjUxEp8S3Mesw
         sRV+Vbq+H6pQGmsCyJn8qEq6E45mf2s9Pr5FgpuAQWJEcFi7TAUWsgF2f6mbn7XVz72u
         ySlSAQXa2uWK1bPocmc3nun9R65U9k+qrd55HW4eWp6yYWRbo66+PN+KZHPTllQP/BtO
         RAWoqJAZyW9iWQpJ7S4joKYGcAPq8aNaUD2fmz2T8puiajRPvLQPhb7q4WvRXdxNPfcw
         t1lg==
X-Gm-Message-State: ACrzQf2RXlcx3UqSa5ZYP6KmmOQMUt99RiX++9MSlVJ/DbDGk4fxIbeK
        Rey4foVvFah+U68lATc8m2O5Bg==
X-Google-Smtp-Source: AMsMyM6SVV43HzSwx1+4kv/lgCWikJcFj65ECyM1Rin700/nOo+YVyCdyKdrmiGJa9iN5438P/yXtQ==
X-Received: by 2002:a05:6512:687:b0:4a2:4d2d:6aea with SMTP id t7-20020a056512068700b004a24d2d6aeamr44305lfe.207.1665065240643;
        Thu, 06 Oct 2022 07:07:20 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:20 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 29/34] dt-bindings: pinctrl: qcom,sm8450: minor style cleanups
Date:   Thu,  6 Oct 2022 16:06:32 +0200
Message-Id: <20221006140637.246665-30-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
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
pinctrl bindings), use double quotes consistently and drop redundant
quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml         | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
index 7ab9a0eec017..e0caa06b84a4 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. SM8450 TLMM block
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer (TLMM) block found
-  in the SM8450 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SM8450 SoC.
 
 allOf:
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
@@ -25,7 +24,7 @@ properties:
 
   interrupts: true
   interrupt-controller: true
-  '#interrupt-cells': true
+  "#interrupt-cells": true
   gpio-controller: true
 
   gpio-reserved-ranges:
@@ -35,7 +34,7 @@ properties:
   gpio-line-names:
     maxItems: 209
 
-  '#gpio-cells': true
+  "#gpio-cells": true
   gpio-ranges: true
   wakeup-parent: true
 
@@ -46,7 +45,7 @@ required:
 additionalProperties: false
 
 patternProperties:
-  '-state$':
+  "-state$":
     oneOf:
       - $ref: "#/$defs/qcom-sm8450-tlmm-state"
       - patternProperties:
-- 
2.34.1

