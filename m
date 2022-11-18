Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D08162FA1C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbiKRQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKRQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:21:08 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE528EB54
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:21:07 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u2so7391680ljl.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjnqvZvoLJRruPXTecNFKm0hhbTgEsvXWGcm3Dhr9+E=;
        b=YRZudXVeLLu3eAEiGezFVHFfMIQpdfUYU3iAHhHAUaaJLNdqrIPuAkTEuw3TgRPkXR
         mEtU4mUyleui4ZNj7xU5UOMasba2WiEYDcCxTF0iB6lhZ+ZyiZCBByW8iB7zIU6aAdwv
         8J7HK2jSXilyScrjTQFThZhYQs97oiUyEQCeKLTEDdDEPdwnTQKKtGIUB5OY1p9lRnKQ
         4tEgx5hSj0X7923zaCsxz/Fz7DPwq/oPjlSorKlEOMq0f894jTFayEzwOJunSMlH0WMq
         JJ+fJT+90GKdAlU6GLIEF8k6/+9b5eraYjDLDLdaG6ilU8YQ9vuzPg6VeuNnsArvKLbh
         9uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjnqvZvoLJRruPXTecNFKm0hhbTgEsvXWGcm3Dhr9+E=;
        b=BftkhcXfGK41M22dN8VgvSZcBk1jMfmCReq6JYZff4LAslE2djwxIru75KvQJ6cOyq
         AH1kpySjZ+eXZA4+37wXztzUkWIhtkDYf7ZsitqLLPBFa9uB59XOdBI0BDAzpuzrgJ9V
         //H9OQDbvGOLIeZz4RMIH6VRXKNdVOg0ZwI7qvLBkG3Y2KIPgip/lAPur3FlAy8zU3MH
         GcY+6CYhhAMP4s2Z46VXnLcjaXXzIXvWEYhRqmru434gVuOH1MZhXQ3uPIZ4QuCkjc6v
         yd9Ivtn/bynOfnhsH3qS6FAkUN2+Qf+LKmLQz6pKUGupCv+bTrRr3QO3mg/+JkcGHW08
         IuaA==
X-Gm-Message-State: ANoB5pm3pZs5CEo77tb1xxsZDB8cp2e8QN1RD3XGsnnE8LQ6GNp1eE8T
        4vVhd2ulb0eYrWJcOvbWkNH6uw==
X-Google-Smtp-Source: AA0mqf5MDZ8n8aOqGyUjyf5Z4PQZnVdF3dQdUdGagTqmUi8FiWFnrvqAXqHOmN9vC36zzvrrZKWnkA==
X-Received: by 2002:a2e:b5d4:0:b0:279:5fa:8e7c with SMTP id g20-20020a2eb5d4000000b0027905fa8e7cmr2654551ljn.62.1668788465509;
        Fri, 18 Nov 2022 08:21:05 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u10-20020ac258ca000000b00499bf7605afsm718252lfo.143.2022.11.18.08.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 08:21:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: pinctrl: qcom,sdm845-pinctrl: add GPIO hogs
Date:   Fri, 18 Nov 2022 17:21:01 +0100
Message-Id: <20221118162101.145267-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Allow GPIO hogs in pin controller node.  qcom/sdm845-cheza.dtsi already
uses it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
index c9627777ceb3..57bac7f7a4fc 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
@@ -48,6 +48,11 @@ patternProperties:
             $ref: "#/$defs/qcom-sdm845-tlmm-state"
         additionalProperties: false
 
+  "-hog(-[0-9]+)?$":
+    $ref: /schemas/gpio/gpio-hog.yaml
+    type: object
+    unevaluatedProperties: false
+
 $defs:
   qcom-sdm845-tlmm-state:
     type: object
@@ -117,6 +122,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     pinctrl@3400000 {
@@ -130,6 +136,12 @@ examples:
         gpio-ranges = <&tlmm 0 0 151>;
         wakeup-parent = <&pdc_intc>;
 
+        ap-suspend-l-hog {
+            gpio-hog;
+            gpios = <126 GPIO_ACTIVE_LOW>;
+            output-low;
+        };
+
         cci0-default-state {
             pins = "gpio17", "gpio18";
             function = "cci_i2c";
-- 
2.34.1

