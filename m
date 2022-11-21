Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A975631B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKUIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKUIMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:12:30 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A752100
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:12:25 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id b9so13642905ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLJ+mqhSoVxvZcQr13CYq9oTt9J8Yi5NK8dAxceTyHA=;
        b=Xa7n46nKuZWvbD9Pd81p20qqLQknysyjNA+DZbnjPZ1H10PWLsOTM4Jg1YxIkeiBlu
         R9tYyuEw+5J8PdFKWP/6Kspj0m+zHxUhoL3a148BCnZwmDZGtvPACD5AibPIV7D8I5ea
         gPZ4/X21gHmqgz4kSDtOM5aNsBHHU8SwGA+P2WfO0HuXHVSmqkMQFV/RXVjC/X7RLgIq
         o6aErc33oYWu5UQgSW/f5p1gM/7kQ79cK/V9Hnw5jS+T0nY7nQqFIjniyJ5Rl/EnZmxk
         iSsa03A/GfdqvDnHKvDwd9DyJqadFkObb+GIjw7Glle91kMUbwH+NZX5gu6q+ut5suTW
         PEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLJ+mqhSoVxvZcQr13CYq9oTt9J8Yi5NK8dAxceTyHA=;
        b=3kj4KQp7Ppvsbzibw3NyB7d08rHuNxfQRJGhHWN28c4PSP5P6RKsjpykIpPUooj2NK
         SkIA22YSip1UKOOJQPlf/Q4WxSg4e/FyhmK5NJOM34Ep/mInwhcsINsBJq8+SRzBat1H
         i0AZN9V7c6jrD1FoNf7xSBlwmjHwVKcamNHNirdwzcZ5M61VVXC1dBr67oKdEAOD1k7P
         94Xs2PzU6OCwWmdhPCSk0BgiePAIE4sba26nEfRCBMWct+sPR3WrEJ/J7/soTIsD+lgM
         dSPUNwVg02H9f18tfycFr2osFn2ac5h10njjYpiAw7d2MgiEkBQ9TwD3KvfE8NEgPlhY
         7E7w==
X-Gm-Message-State: ANoB5pm33tp/+wIPzAo/jhRNmlcVS7EqFdJj2VQagpN4P0H+1cGHVRp+
        XD1Gy9SsYOdZmZiSXdOHhV5Zyg==
X-Google-Smtp-Source: AA0mqf7xMqWAMsA9zCfj7rdpS0o8a/tHL3Qg2btPPSL2Xm4kn5/kFOAYCHdWr2NSX1PpCg0Al5O5ZA==
X-Received: by 2002:a2e:9d0b:0:b0:279:f7d:15cf with SMTP id t11-20020a2e9d0b000000b002790f7d15cfmr1890826lji.468.1669018343694;
        Mon, 21 Nov 2022 00:12:23 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z10-20020ac25dea000000b0048b003c4bf7sm1910919lfq.169.2022.11.21.00.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 00:12:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: pinctrl: qcom,sdm845-pinctrl: add GPIO hogs
Date:   Mon, 21 Nov 2022 09:12:21 +0100
Message-Id: <20221121081221.30745-1-krzysztof.kozlowski@linaro.org>
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

Changes since v1:
1. Use different syntax (Rob).
---
 .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
index c9627777ceb3..18ddcfe2e088 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
@@ -48,6 +48,10 @@ patternProperties:
             $ref: "#/$defs/qcom-sdm845-tlmm-state"
         additionalProperties: false
 
+  "-hog(-[0-9]+)?$":
+    required:
+      - gpio-hog
+
 $defs:
   qcom-sdm845-tlmm-state:
     type: object
@@ -117,6 +121,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     pinctrl@3400000 {
@@ -130,6 +135,12 @@ examples:
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

