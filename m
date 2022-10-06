Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D565F6914
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiJFOI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiJFOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:07:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB45AAE85C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:09 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id t16so2380764ljh.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9Kad1IH+jLbZ8P6+0lUUf+Nr8Cb0qZGATZUa0YVUa0g=;
        b=OPVfAGrtikSRluPwpEC6Y8cP2PszFXhnzejofQ1jf5DvS8u2M8kkIbU+LhKuH1pv9n
         6aJJ7+fcplsgYaTguMT+hRFubox4QI+pHCIulS+MOz9FJWXH+WP0FMdkTTA6Yza8gCwp
         GWMOpG3H2BcBgdE/JtNK2uP44LUy0feLjaFEshCc7Axp7aayct9Y/zROImYd4kCmSyz/
         btL7axOIe3VoJ3Zaj6kgouWl0LClYpWvqCAuwPWhAFd7rJU7y9Nq7ooBt6LYMwPFZpfv
         T8gU5sJob6enY/aBhOBWCR/wuOfbSkYaT+LzrFJW9kN1EADzhN6hgvLL9n1zMD0yEF/9
         es7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9Kad1IH+jLbZ8P6+0lUUf+Nr8Cb0qZGATZUa0YVUa0g=;
        b=3xAL7hxgqrvLZFY2PGxWstaWl7fIRNx6cdWx/lF+xbxf4nNlx422i6iERCKpN9ORAB
         2Tz8pyOddPMa60eC9UueCoFAePv9M41rOyvb+xUm4Ps8BnzqcNN9iAscLVxYCZ/nnwhg
         OUvdzVn6v7/5SH4RXVvB33+ierYFbIbS0mVuxZgJZ6r5LeYs6SJ61gEx6HbZmhsL1A9b
         MswzUzq5/GikaYlfFOxFjvhtwf40VF21LjlAk0KQlfDLQgKdkEG3s4gEVu1LbolofMDM
         RFnnkmSfd+lyrFh4tNpTOq+LAnrYkfKN1Qlo5BDxj46oBG7bjRWbCx7vPu4ceXEqDAlx
         Yr5w==
X-Gm-Message-State: ACrzQf2EgVfE5djQ9fEvhCaXLux+jQaEcD8k9xqW9P18sPymVRT3m+Vx
        4IEEBnDaW0OfXsYfGsHMEG5mXQ==
X-Google-Smtp-Source: AMsMyM7B2fjrv8YQca3FwaG7+CRxiiXuJd3a8Xj56a3ZOXlhEKWGRSxRJK3mhkbTU21fdu2rlHaxXw==
X-Received: by 2002:a05:651c:2395:b0:26d:9549:b42d with SMTP id bk21-20020a05651c239500b0026d9549b42dmr1911643ljb.483.1665065229251;
        Thu, 06 Oct 2022 07:07:09 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:08 -0700 (PDT)
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
Subject: [PATCH 20/34] dt-bindings: pinctrl: qcom,sdx65: minor style cleanups
Date:   Thu,  6 Oct 2022 16:06:23 +0200
Message-Id: <20221006140637.246665-21-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description (and align it with other Qualcomm
pinctrl bindings), use double quotes consistently and drop redundant
quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml           | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
index ad1a2446a8af..c0f349b88002 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
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

