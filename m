Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2C5B5400
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiILGSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiILGSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:18:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB929811
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p5so9308120ljc.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dSJXKFEZI4T1kbFyh1aKF3VNgs72FXruybc3OKrfZRY=;
        b=OYnKB00l/lh4t3hosBq7sPudQrWN98jkklZEAM7wrHZi4WRJJajlSYWbsOBWEy3Wt9
         U1iez3g/sOAZKFkfCcBbuWBUWQDoKoRT0myMJDLjDxCe9KpU4SF1Az8dgLJehCrHr4N7
         8z/qDb+zcwkmGUzk5D3bLU27DBEr679mqRbq7icqKrDI4md4sdevTtMakMBAeCtQd4E/
         PEvsnB/cETQ2SuffQMPKzJodb+P/n4qSehEtma4eBOFgNpAHrblENdQV0qKFr9og88p1
         KkpIwz3fF/yfcYvD/tmyGxk0wjHSeuXVpKJUgcWZNrB4Dda91TN4JxwcvRngNuBuW5jO
         BbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dSJXKFEZI4T1kbFyh1aKF3VNgs72FXruybc3OKrfZRY=;
        b=Tl4ikGFgPOccxXSomk5veXExV680yzm736z17SwSdQ9gViebNUdd+ZpzobhcxwQPja
         EOXOIdKXbpbwOgT+/Z5FMvd7+bQhqH4mNLJEkVZi2H8J29Bw8pBKnDLN7UtFOdYE7hYk
         Fr5AJ3dp+ZU/4U31A9Pfps0/zyOhJu2VtQUfY4Trw0Hlk+ptyAyURo09Tw2HEqLxAXul
         8HNVcoVPQEcYIGECjdyXXrv/F60x7Zi7Q83TFpSKLLc6yuRLsVSliYtLEj5iNHJ2Gg1h
         V7vENwTTUxF3qfQRT+XdSGgfGOMQ+cof3CRKHzzErpRwCzMdFqaWMDe5OWsVVZHeibtd
         ZHhA==
X-Gm-Message-State: ACgBeo01s6RT8A07sEc/esQA4GQ1ediFrOZXU5Wk0t7OewVOTICUAVsL
        jHpIcWX4CQQq/mQ7+0QMU8+XeQ==
X-Google-Smtp-Source: AA6agR4WQR1eg6E6HyOOHovMK/iMZcVJ/7te7mGe79HMH/duPhKgGkTmuwVbvSO0omzw1OLxa0OTbA==
X-Received: by 2002:a2e:5356:0:b0:26b:dce1:419d with SMTP id t22-20020a2e5356000000b0026bdce1419dmr5323661ljd.52.1662963485739;
        Sun, 11 Sep 2022 23:18:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 09/40] dt-bindings: pinctrl: qcom,sm6350-pinctrl: fix indentation in example
Date:   Mon, 12 Sep 2022 08:17:15 +0200
Message-Id: <20220912061746.6311-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings example should be indented with 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml | 58 +++++++++----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
index 0c4bf6e90ba0..856b9c567ecb 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
@@ -125,34 +125,34 @@ $defs:
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        pinctrl@f100000 {
-                compatible = "qcom,sm6350-tlmm";
-                reg = <0x0f100000 0x300000>;
-                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-                gpio-controller;
-                #gpio-cells = <2>;
-                interrupt-controller;
-                #interrupt-cells = <2>;
-                gpio-ranges = <&tlmm 0 0 157>;
-
-                gpio-wo-subnode-state {
-                        pins = "gpio1";
-                        function = "gpio";
-                };
-
-                uart-w-subnodes-state {
-                        rx-pins {
-                                pins = "gpio25";
-                                function = "qup13_f2";
-                                bias-disable;
-                        };
-
-                        tx-pins {
-                                pins = "gpio26";
-                                function = "qup13_f2";
-                                bias-disable;
-                        };
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pinctrl@f100000 {
+        compatible = "qcom,sm6350-tlmm";
+        reg = <0x0f100000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 157>;
+
+        gpio-wo-subnode-state {
+            pins = "gpio1";
+            function = "gpio";
         };
+
+        uart-w-subnodes-state {
+            rx-pins {
+                pins = "gpio25";
+                function = "qup13_f2";
+                bias-disable;
+            };
+
+            tx-pins {
+                pins = "gpio26";
+                function = "qup13_f2";
+                bias-disable;
+            };
+        };
+    };
 ...
-- 
2.34.1

