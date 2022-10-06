Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB245F66BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiJFMtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiJFMsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:48:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C61A2A98
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:47:39 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id j23so1981267lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gLNNPHYi9MZtpuf7Sf4vfCFMOo1TuKVCYuBKByb1QBU=;
        b=keU3l4AvJUnPJ+3yyRavQXHw0tU3n5niLcJd2vhRT4CjExMuUEJgdrwM8LlXqVuPZ1
         AvWa3DCj92iiWNV2BQqF9QrUOam4mYFOERWEK5URPAqy2z9h6YPcXtzchcQD9mdAIIkd
         50zD3pNW6Z/wQYs8wrj4b2jh7m/R+g8l1A8usm4py+CGWMSCYWi1sHwWVELtYbpaOURt
         +UzQuO8pQABhT5VX3ylXU01onlWrWGF/aOp58bu1UyVcVmeJp6HXk+lRCgztQrccXod4
         NDuEir4/qZ0SB5Lepd8Xn1Fq9t/lo6aCZI2umG8LqWuXaM+ad3HJ+gCT1BcfB2QiYZFU
         olPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gLNNPHYi9MZtpuf7Sf4vfCFMOo1TuKVCYuBKByb1QBU=;
        b=baLerbqc1FReHpTXEo8ezEJPOKyOcz5SniK5nUidR0oC8Y5sX6HqzXPAv59t9iENiq
         Jy6rXlHbL1v65X2X1Oyfo64affCfWsBGF/omr+vfobHjPMVsw46NP5N3Bn5u8hqTS1ed
         RiB9EmF1AUCEMQw2ofw25fErOKGgrdomsK3w3V6Y17fG/a/zbZmemeCOy6SEeLnCWNZJ
         9OTItTkFKeVaRlqH5qQ8hdDi4BHuknWBq6fS4KV+jGKHxrEPNE+GA6GZazvq76c8+TVn
         5Mts27n3FgqfZFPIr2PTzPnqiLUlXS2vCsjMmZEivwcESYGQr+x9usbz+Wam+XxWY7jT
         U4jA==
X-Gm-Message-State: ACrzQf3nhINgvz1Zht8Jn7mjId20SyBHj16UZuLroltiv6yLajfBCBs6
        NtPoeBcg7uV/PaaZKIIp4DbYKA==
X-Google-Smtp-Source: AMsMyM6/TvjnoCKQArHLuAkLMVa3xZQrDxt++eNx/9pB9jQ4dzx36xs5/M78tIftZtbuGGH84hPxLA==
X-Received: by 2002:a05:651c:1949:b0:26d:cf6d:54a6 with SMTP id bs9-20020a05651c194900b0026dcf6d54a6mr1728359ljb.3.1665060459218;
        Thu, 06 Oct 2022 05:47:39 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:38 -0700 (PDT)
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
Subject: [PATCH v4 32/34] dt-bindings: pinctrl: qcom,sdx65: use common TLMM schema
Date:   Thu,  6 Oct 2022 14:46:57 +0200
Message-Id: <20221006124659.217540-33-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  | 31 +++++--------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
index 0f796f1f0104..ad1a2446a8af 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
@@ -20,25 +20,12 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts:
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
@@ -142,19 +129,15 @@ patternProperties:
 
     required:
       - pins
-      - function
 
     additionalProperties: false
 
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
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

