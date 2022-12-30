Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E69659935
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiL3N5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiL3N5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:57:04 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745BB1B9FA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:58 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m6so21442319lfj.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AytPioOrnkLC7EyjbAxUNvCpG+GUL98ITmWx5IQwIc=;
        b=Sx4iECNSiSWb9yHarzg56abSC0eA1P8M3MxIcTDs9gXX3au0Qal80rhzJsmgOda8Wz
         jdY2qdPntR8XsSXHi1hE7ESHNbIWNy3s8PrFruDqSOVpeqWRBB2Z+29rRivcFEPGMQa1
         Y9h4Goq8sTrMourcISPAb/So0xsLiN5W4EJJzsYlHxprbSV0wwdj3PR5P1zUkOVzvRnp
         9WChkiTcSOABa6iTzyAq8Omy3x8vZ011kr0kgEuLjnPzAGsYrUQt/CZfKWICwjm6L0ZI
         V2JpLGvEfuXJbNF77huZ0959JrzHZurzeuIyhHPRxCAYNuaoNXHsvEiWLpbGPp6IzAF4
         JBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AytPioOrnkLC7EyjbAxUNvCpG+GUL98ITmWx5IQwIc=;
        b=qFHNEeuadCG9rLN1pfFQc8vzVaLmw+9QR/uuiUFMiMyMSsD6lfK/iHE5CzWtw4Z4+m
         +SAkDWO8t63zNoE/3tvrsbSFdjxSAA3tOcMQcPVMXqEX/YR1vy1rK1YpR6ZRpROonxnT
         wGTNYbEaLsHWpHipg0WD9ZEVM+lKGd/Dhe04BfUp4ArEhTOvjTL8wnpzA2Mn2vNPgGeV
         xs6HGh2BsiynWAQROSG3HTRFZSLBfhh/hMwCLN3g9jOgJ4bDcVU224mocD5YkUbx6/TB
         RBqsBoXXV0UZU3QdsYHud0LXuLohjWvqPpyKG1J+5M6zDmo0P2Ha6lXBLvH9jtSgxuhp
         ZYLQ==
X-Gm-Message-State: AFqh2kpVD9HEg+kcsiXNn6dviVmGh4FSOA8irToueBuCRMfjZNWNHxVh
        l/AhHLz3wWSjjjj1l5PrcwwEOwgI6YOdWLTF
X-Google-Smtp-Source: AMrXdXtaIm8AddoXV3k+eA4NnIdbXrQVhV1Po/KhCE/ohJAqZPZvPV7a1egHa0EVuIXyTtuWoFVkOQ==
X-Received: by 2002:a19:f514:0:b0:4b5:785b:846c with SMTP id j20-20020a19f514000000b004b5785b846cmr12066186lfb.68.1672408616757;
        Fri, 30 Dec 2022 05:56:56 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d9-20020a056512368900b004a26ba3458fsm3454787lfs.62.2022.12.30.05.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:56:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/9] dt-bindings: pinctrl: qcom: allow nine interrupts on SM6350
Date:   Fri, 30 Dec 2022 14:56:43 +0100
Message-Id: <20221230135645.56401-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
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

Almost all Qualcomm SoC Top Level Mode Multiplexers come with only
summary interrupt.  SM6350 is different because downstream and upstream
DTS have nine of the interrupts.  Allow such variation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,ipq8074-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,mdm9607-tlmm.yaml      |  4 +++-
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,msm8660-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml      |  4 +++-
 .../bindings/pinctrl/qcom,msm8916-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,msm8960-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,msm8974-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,msm8976-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,msm8994-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,msm8996-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,msm8998-pinctrl.yaml   |  4 +++-
 .../bindings/pinctrl/qcom,qcm2290-tlmm.yaml      |  4 +++-
 .../bindings/pinctrl/qcom,qcs404-pinctrl.yaml    |  4 +++-
 .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml    |  4 +++-
 .../bindings/pinctrl/qcom,sc8180x-tlmm.yaml      |  4 +++-
 .../bindings/pinctrl/qcom,sc8280xp-tlmm.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml    |  4 +++-
 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml       |  4 +++-
 .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml    |  4 +++-
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,sdx65-tlmm.yaml        |  4 +++-
 .../bindings/pinctrl/qcom,sm6115-tlmm.yaml       |  4 +++-
 .../bindings/pinctrl/qcom,sm6125-tlmm.yaml       |  4 +++-
 .../bindings/pinctrl/qcom,sm6350-tlmm.yaml       | 16 ++++++++++++++--
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml       |  4 +++-
 .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml    |  4 +++-
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml    |  4 +++-
 .../bindings/pinctrl/qcom,sm8350-tlmm.yaml       |  4 +++-
 .../bindings/pinctrl/qcom,sm8450-tlmm.yaml       |  4 +++-
 .../bindings/pinctrl/qcom,tlmm-common.yaml       |  5 +++--
 34 files changed, 113 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index 93f231c7a3b4..28f1b6a07b70 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -19,7 +19,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
index 5687acaf19bf..3137db927fc0 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
@@ -20,7 +20,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
index a0a12171b6d0..96b598bf9a76 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
@@ -22,7 +22,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
index a4f6e4c588f4..c7c94d742ed2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
@@ -20,7 +20,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   '#interrupt-cells': true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index 3b79f5be860b..ab6672a4c8c1 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -20,7 +20,9 @@ properties:
     description: Specifies the base address and size of the TLMM register space
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
index ad0cad4694c0..348d84c3cd21 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
@@ -20,7 +20,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
index cc6d0c9c5100..449e6e34be61 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
@@ -22,7 +22,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
index 5495f58905af..633c9e5ed49e 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
@@ -20,7 +20,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
index c9a4a79e8d01..6bcd52080801 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
@@ -19,7 +19,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
index 33d07d531273..cf386f644ccb 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
@@ -20,7 +20,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
index 9287cbbff711..afe4a80f0b79 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
@@ -20,7 +20,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
index 858f45710fe2..5dfcc3eadbb0 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
@@ -20,7 +20,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
index 55d5439c6c24..f4a8180f5959 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
@@ -22,7 +22,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
index 8e1cd4ba1116..047b4584e3c0 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
@@ -20,7 +20,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
index 21ba32cc204a..c07ee9868046 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
@@ -20,7 +20,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-tlmm.yaml
index adf64bfaa4ed..6271fd15e0b6 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-tlmm.yaml
@@ -19,7 +19,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
index 29d50c4a0034..20bc967a17b5 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
@@ -26,7 +26,9 @@ properties:
       - const: north
       - const: east
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
index b40f6dc6adae..f33792a1af6c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
@@ -26,7 +26,9 @@ properties:
       - const: north
       - const: south
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-tlmm.yaml
index 24191d5f64ac..0ace55c9868e 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-tlmm.yaml
@@ -28,7 +28,9 @@ properties:
       - const: east
       - const: south
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   '#interrupt-cells': true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
index 4efde29c36a2..97b27d6835e9 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
@@ -22,7 +22,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
index bd4fd8404aa4..ea6bd0b44f56 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
@@ -31,7 +31,9 @@ properties:
       - const: center
       - const: north
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
index 7585117c0f06..f586b3aa138e 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
@@ -22,7 +22,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
index 18ddcfe2e088..23d7c030fec0 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
@@ -23,7 +23,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index a76117e41d93..add3c7e64520 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
@@ -20,7 +20,9 @@ properties:
     description: Specifies the base address and size of the TLMM register space
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
index 2f53905260e6..89c5562583d1 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
@@ -19,7 +19,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
index 164f24db8b2b..29325483cd2b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
@@ -26,7 +26,9 @@ properties:
       - const: south
       - const: east
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
index e1dd54a160d5..c9bc4893e8e8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
@@ -27,7 +27,9 @@ properties:
       - const: south
       - const: east
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
index 39f3ec5b7187..d95935fcc8b5 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
@@ -22,7 +22,10 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    minItems: 9
+    maxItems: 9
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
@@ -125,7 +128,16 @@ examples:
     pinctrl@f100000 {
         compatible = "qcom,sm6350-tlmm";
         reg = <0x0f100000 0x300000>;
-        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
+
         gpio-controller;
         #gpio-cells = <2>;
         interrupt-controller;
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
index d54ebb2bd5a8..e4231d10d76f 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
@@ -22,7 +22,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
index 85adddbdee56..4376a9bd4d70 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
@@ -27,7 +27,9 @@ properties:
       - const: north
       - const: south
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index c80f3847ac08..56e058c315f7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -25,7 +25,9 @@ properties:
       - const: south
       - const: north
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
index 7b483e93bfe1..49a74f351e99 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
@@ -22,7 +22,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
index b5356d0f89f9..56c8046f1be0 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
@@ -22,7 +22,9 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts: true
+  interrupts:
+    maxItems: 1
+
   interrupt-controller: true
   "#interrupt-cells": true
   gpio-controller: true
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
index e1354f0c64f8..cb5ba1bd6f8d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
@@ -16,8 +16,9 @@ description:
 properties:
   interrupts:
     description:
-      Specifies the TLMM summary IRQ
-    maxItems: 1
+      TLMM summary IRQ and dirconn interrupts.
+    minItems: 1
+    maxItems: 9
 
   interrupt-controller: true
 
-- 
2.34.1

