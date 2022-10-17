Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9647F601D15
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiJQXCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiJQXBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:01:42 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496038276F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:01:11 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z8so8726970qtv.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj7AQGhrhWrN5o4B16oW61RC4t017WdbNAa0KxHWp8E=;
        b=h5bX9xLyL1eryIOXD95VkL/vAomYfbhqp2uPfikHhWeh1n94Pg7jLVIE4XDj09U4BN
         Q18dspm7hEWZKET/ZsziGw5CLu2QZb9fLF//hNgVMUj6rj1SXPod9WhP3SOwbQmrgehZ
         uCJxwhJPNvMmuZO4uG8zL8AqUZTgg8pT/trRzMHJAPvCgjmo8vewxBwv5XrEZEMwxhd2
         cx7To+nuXOiDjz5ao5yRgN3bL0GEyT4Tdnho/L+c+VR7ng0ALUsDrq6tj/hGhNiFtdxI
         Ko2iUmE3PSkS7JYgdi+NCM4v9tKP1t8mL6GYW2jPa7lefu4GOGUPoCDmuYD6BX4pI1HV
         31vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj7AQGhrhWrN5o4B16oW61RC4t017WdbNAa0KxHWp8E=;
        b=pvqU9JnXhOdWRA9lkiLyvhX++0Itn/gF37aksO5R7I14u4mOheUOh1VzUhYJ9FuDoh
         8+2+2VpGSek2F3H8lv0T+R4cZw4gzRubcab+K7MJq6rjsg9zR6pkTAp4zj+dbrfi7X1S
         G8QeIY2BM9cMfTw4ewyx4Op/OtB7RrhGWV5pFGF0Yl0aE+V781UTdy6LWxxw0bFvjcME
         cp8qCIkHJnOSqn4UK3XLbZwTDd0uwzGXKbmZVNdnLhRMFcgd2HQyzGc2E8/k2Hp55hUi
         S3+IQql7j9owT1sUhJ4Hlxube/jfaxQgl53gYPqIVNkg+kUrOlVGFSnvOWHIVbNI1zam
         RwpQ==
X-Gm-Message-State: ACrzQf1/URX1jwkwLRg7o5rwbV+/PvT+rlZinNID1nQ39SFan5iFtetn
        fIhInvxFYzw7a/N5kZRdsIetzQ==
X-Google-Smtp-Source: AMsMyM7ruoQrOf6U4+16kV1Kcef/Q+IJfNeY7C49NUL0s2rISGBi7MMIshYtVvcZQroIe0tFDrGy2g==
X-Received: by 2002:a05:622a:1649:b0:39c:f2ad:52d7 with SMTP id y9-20020a05622a164900b0039cf2ad52d7mr1632460qtj.219.1666047671484;
        Mon, 17 Oct 2022 16:01:11 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id fg11-20020a05622a580b00b0039cb9b6c390sm729670qtb.79.2022.10.17.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:01:10 -0700 (PDT)
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
Subject: [PATCH v3 19/33] dt-bindings: pinctrl: qcom,sdx65-tlmm: minor style cleanups
Date:   Mon, 17 Oct 2022 18:59:58 -0400
Message-Id: <20221017230012.47878-20-krzysztof.kozlowski@linaro.org>
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
pinctrl bindings), use double quotes consistently, drop redundant
quotes and rename file to match compatible (to match coding
convention).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 ...{qcom,sdx65-pinctrl.yaml => qcom,sdx65-tlmm.yaml} | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sdx65-pinctrl.yaml => qcom,sdx65-tlmm.yaml} (95%)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
index 523c072df05f..2f53905260e6 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/qcom,sdx65-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/qcom,sdx65-tlmm.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Technologies, Inc. SDX65 TLMM block
@@ -10,8 +10,7 @@ maintainers:
   - Vamsi krishna Lanka <quic_vamslank@quicinc.com>
 
 description:
-  This binding describes the Top Level Mode Multiplexer block found in the
-  SDX65 platform.
+  Top Level Mode Multiplexer pin controller in Qualcomm SDX65 SoC.
 
 properties:
   compatible:
@@ -30,9 +29,8 @@ properties:
   gpio-reserved-ranges:
     maxItems: 1
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-state$':
+  "-state$":
     oneOf:
       - $ref: "#/$defs/qcom-sdx65-tlmm-state"
       - patternProperties:
@@ -40,13 +38,13 @@ patternProperties:
             $ref: "#/$defs/qcom-sdx65-tlmm-state"
         additionalProperties: false
 
-'$defs':
+$defs:
   qcom-sdx65-tlmm-state:
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

