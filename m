Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F65FB962
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJKR1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJKR1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:27:02 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6057B5B781
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:31 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id df9so9367087qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckAqRWeHF1bK7ElWb8y3OZX2IqijWRZJQ9nMTXZx2Fs=;
        b=peNy1a9BLD/2GJzOYLfTReOq9wQnChL0B86xYfLk6oQckaeyRdL534s8nqdY768wBs
         DqfvnsGTZeMgF0Vmki/3lrkIA003qhdBxlgm8SHGFatn3Xov5HSbIsEAjOA3RoTA9OSe
         6dpu55hBZe2hG9xP1ki2IODZHe5FlTiwBo/6RYYIE8T+R5y2oBA6GqwAiwiXrXdf3yfd
         tO2AU/h9JV3L3FULWh52xhvUtIO04eeotWizAAmxASaJPhPNT9i40TkkOGWzIZt0yGTh
         uJGeuHxGlpj6uCiJZPU6UpdzmntlmcvUSoPj55KvEtuL7hmaYfP6dANGH4fXHHVnfV2J
         4miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckAqRWeHF1bK7ElWb8y3OZX2IqijWRZJQ9nMTXZx2Fs=;
        b=6jdxfHHN4dUEa6nHAXMNHSpYP35AtXoVxdwIp57SZsutENSK2OxlNoojxsOWiBMD79
         rwS3EWnfscWhltAcQXhWkGaWeDByH1EdvVhtEubz0l2cA2fbgqt0PvkEFbSLM0kh+4BN
         PgOjx2VxQdBZR45CmKK2acT+q1xx5ggDVqGovr4ydfbxDX2B7PfgF1X/TuHGDsem2A7i
         XFW+q0+9iK5E/W9vYnrMbWoolcBuGL/IMwSum8y9NvdE67FUx4ZATLcaUD0ijfYS3xNJ
         sO5qPdwxsT5Jv21LX1sDb65lhwvXw0Clh1RA5RLOpYkoz199BQuLjCf26G3tL2aEsqfO
         OYyw==
X-Gm-Message-State: ACrzQf2lwRO9u2ISnzCTazf5IqLyCwO7bVECIfV4x06Tzpa4MUbX1j84
        11GY5N55l9+yCy3hXvXhTiQoBA==
X-Google-Smtp-Source: AMsMyM7uGmxOgMavkEjvNEj0JrDB5VUY2cBnGTmnHhzq3+glEOWltr5vy3fPFRflEAMGcg+VcwuG5g==
X-Received: by 2002:ad4:5d6c:0:b0:4af:b5e0:63f1 with SMTP id fn12-20020ad45d6c000000b004afb5e063f1mr19995113qvb.35.1665509191414;
        Tue, 11 Oct 2022 10:26:31 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14289087qkn.37.2022.10.11.10.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:26:30 -0700 (PDT)
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
Subject: [PATCH v2 17/34] dt-bindings: pinctrl: qcom,mdm9607-tlmm: minor style cleanups
Date:   Tue, 11 Oct 2022 13:23:41 -0400
Message-Id: <20221011172358.69043-18-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
References: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
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
pinctrl bindings), use double quotes consistently, drop redundant
quotes and rename file to match compatible (to match coding
convention).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 ...9607-pinctrl.yaml => qcom,mdm9607-tlmm.yaml} | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,mdm9607-pinctrl.yaml => qcom,mdm9607-tlmm.yaml} (93%)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
index 5a9002a83423..a0a12171b6d0 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/qcom,mdm9607-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/qcom,mdm9607-tlmm.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Technologies, Inc. MDM9607 TLMM block
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. MDM9607 TLMM block
 maintainers:
   - Konrad Dybcio <konrad.dybcio@somainline.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  MDM9607 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm MDM9607 SoC.
 
 allOf:
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
@@ -25,10 +24,10 @@ properties:
 
   interrupts: true
   interrupt-controller: true
-  '#interrupt-cells': true
+  "#interrupt-cells": true
   gpio-controller: true
   gpio-reserved-ranges: true
-  '#gpio-cells': true
+  "#gpio-cells": true
   gpio-ranges: true
   wakeup-parent: true
 
@@ -39,20 +38,20 @@ required:
 additionalProperties: false
 
 patternProperties:
-  '-state$':
+  "-state$":
     oneOf:
       - $ref: "#/$defs/qcom-mdm9607-tlmm-state"
       - patternProperties:
           ".*":
             $ref: "#/$defs/qcom-mdm9607-tlmm-state"
 
-'$defs':
+$defs:
   qcom-mdm9607-tlmm-state:
     type: object
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
-- 
2.34.1

