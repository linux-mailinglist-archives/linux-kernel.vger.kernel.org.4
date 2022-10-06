Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338935F66D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiJFMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiJFMtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:49:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06B6A4B96
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:47:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bu25so2557174lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6jCYOSDu55V6QZBvLkF9j6tijgskxnXCKDfSvqsPbyU=;
        b=zNo2urZELR20lqD5BX8cQy92lhbO6KIH0db9xKR2jzP0X7yrVF5vTXKCJ7ypnJSI7+
         PX7KxhuoKJDQgWtw2MTCLFAinS/GPhr13JsmIKvXeYH2OHB7dxbVKm+XHo7VeajorQ3Z
         /IOWXOtGQ9tmpUmEdFhN3750gWXi1pL0eAfsYRZn+Nb917QQL5mgNQ1or2NLnbP497f0
         sBqHbkZ5uR/lssZT1ui1ryJDXS2q+kEbR6T8WHjDuHkUQVB6btUhHqwUhVMBi2peC4lk
         3DoATJXs+YihL0Mw8PN/BYJAqEv8AY539Hn3DuXloGgUghQWtzt7esFWy2PI8tA2pBd0
         k9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6jCYOSDu55V6QZBvLkF9j6tijgskxnXCKDfSvqsPbyU=;
        b=P0qH3VRtgHKzFg4Sq9fl8BsJ9NBOCXprDRaVu+N0uma3p4oV/83FweAxetYo/do4yQ
         AkPwHln3xSjf4PWQsjhTVop4Ll0ucTVQxkpqaX3uFQFSNi26GP3BBbzjfxqRJG/eFkTN
         X9knxzzoBI2Efjz+5U7XU46SS9wAn9GwHjMjx+bAYSXIzOkg0eCzLzRapfnLYxvynimt
         j40QxD1l//t08UuAOtj+0wZv9ZKis/YWFRjqZ6BoxN1BGQhWHEAltcGph/hro60tCJLH
         B3B5kxxp4khe5Yw3MI3ASpSmLCbWSVdXQw6BXSvMSYtKvEFCiuFESnbr99gnPkJjwOpK
         SNtg==
X-Gm-Message-State: ACrzQf2foD2AoToNmB8nOch5sun2OOqZmtsPfjuqYtdvcPxI5BuUVBJ2
        /GdPD7hwwkAJNZgPHqbB7T/vAw==
X-Google-Smtp-Source: AMsMyM5tOmNYurHbcPgoRnRCMP1iNmw6jOf9USN6u+0Lspx8i3ZHewpM1Qi4jbE7hAq4VcVGlpDbMw==
X-Received: by 2002:ac2:484d:0:b0:4a0:5399:9b70 with SMTP id 13-20020ac2484d000000b004a053999b70mr1959158lfy.216.1665060453329;
        Thu, 06 Oct 2022 05:47:33 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:33 -0700 (PDT)
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
Subject: [PATCH v4 27/34] dt-bindings: pinctrl: qcom,qcm2290: use common TLMM schema
Date:   Thu,  6 Oct 2022 14:46:52 +0200
Message-Id: <20221006124659.217540-28-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
References: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
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
 .../pinctrl/qcom,qcm2290-pinctrl.yaml         | 32 +++----------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
index 5324b61eb4f7..0d73abeea715 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
@@ -20,28 +20,12 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts:
-    description: Specifies the TLMM summary IRQ
-    maxItems: 1
-
+  interrupts: true
   interrupt-controller: true
-
-  '#interrupt-cells':
-    description:
-      Specifies the PIN numbers and Flags, as defined in defined in
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
-
+  "#gpio-cells": true
+  gpio-ranges: true
   wakeup-parent: true
 
 #PIN CONFIGURATION NODES
@@ -119,17 +103,11 @@ patternProperties:
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

