Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3116D625979
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiKKLga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiKKLgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:36:16 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A28A787B8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:15 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a15so4216049ljb.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iso5JkYpW6A/jFTmsvAqcjCGN6f9RRbfN9V5NFqceLU=;
        b=LXbPVuetFmLz/utAf11ouZCa4kV24qXPKUpeSNelWVl0B6ejXUZpjeKWSlEwluruEV
         BmZk9vtldLG4J9gWoE2FfuptSUoE0Yd0pjmUlU+d/DYju9SbH+tpUXp+nVWOZ3hvOox5
         5kPGHAhHd5Vm6Rnl9eBkGSmnHDA2Z6OUge+sqngmG8beRQBPSdO/RtfiabGBRgS/TP20
         XXdF6oSI2nI336sGhLmvjTD43e4Y/mh6M9CqS9P5CV1xtu92Fql7EsRlfEen+R9yvtVP
         5mIM4LuKFazVAmQWay6FprRf3g2LJpDAmWlAic48BFqBoyNI4x0FrdhdfSvwzNJn9cP1
         ahAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iso5JkYpW6A/jFTmsvAqcjCGN6f9RRbfN9V5NFqceLU=;
        b=CTFTPbVS0Pz+A7qF5UOea0gNe2XOwuKiD/vHidmBxn0TGJ3ywzFiVfsN7E5OxB1Ee2
         xm2lkcBEpkhvDIWn20oLB0xy6S2prpE1gf50aGN2VT864Tlw1/LJi5d62byWFze0Jlig
         Kju+ej9HStoL9aK82HtUQb285WBbmHq9BnrDvS80ODMbCcHeMjQDvP6rR33mgr9tBYgR
         v8yVrhOg97qtzDuGIsZKH99Qke1sINxqwEF5YCbVgtll8qHeOa354O/BURgvzEF1opzH
         kBEruk42BE91c/03W4BU/lU8PSL89BgRnX2+0DCVhB2PZd59uscTU8GagzKBsgdffpTp
         ZbVg==
X-Gm-Message-State: ANoB5pk8vR3Gm4GCy4q+VhRy88v6ZMy0DIQZau7fPRsmCBtVLjZWyDk6
        5SxIV1S77w8LfMUzQ8epPSdmFw==
X-Google-Smtp-Source: AA0mqf7GKT3b2MaA1VA0vBY4OKP49a33B0Dv599vH91Aps2pvQn2vG05P5Ni1PhiEmUzPc0ZWj9yGA==
X-Received: by 2002:a2e:b711:0:b0:278:a461:cb7d with SMTP id j17-20020a2eb711000000b00278a461cb7dmr507235ljo.246.1668166573304;
        Fri, 11 Nov 2022 03:36:13 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b004acb2adfa1fsm274970lfb.307.2022.11.11.03.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:36:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <plai@qti.qualcomm.com>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/10] ASoC: dt-bindings: qcom,q6apm: Split to separate schema
Date:   Fri, 11 Nov 2022 12:35:41 +0100
Message-Id: <20221111113547.100442-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
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

The APR/GPR bindings with services got complicated so move out the Q6APM
service to its own binding.  Previously the compatible was documented in
qcom,apr.yaml.  Move most of the examples from its children to this new
file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,q6apm-dai.yaml        | 19 ++-----
 .../devicetree/bindings/sound/qcom,q6apm.yaml | 51 +++++++++++++++++++
 2 files changed, 54 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
index 24f7bf2bfd95..73a4afad5a74 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
@@ -27,20 +27,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/soc/qcom,gpr.h>
-    gpr {
-        compatible = "qcom,gpr";
-        #address-cells = <1>;
-        #size-cells = <0>;
-        qcom,domain = <GPR_DOMAIN_ID_ADSP>;
-
-        service@1 {
-            compatible = "qcom,q6apm";
-            reg = <1>;
-
-            dais {
-                compatible = "qcom,q6apm-dais";
-                iommus = <&apps_smmu 0x1801 0x0>;
-            };
-        };
+    dais {
+        compatible = "qcom,q6apm-dais";
+        iommus = <&apps_smmu 0x1801 0x0>;
     };
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
new file mode 100644
index 000000000000..7acb832aa557
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6apm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Audio Process Manager (Q6APM)
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+allOf:
+  - $ref: /schemas/soc/qcom/qcom,apr-services.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,q6apm
+
+  dais:
+    type: object
+    $ref: /schemas/sound/qcom,q6apm-dai.yaml#
+    unevaluatedProperties: false
+    description: Qualcomm DSP audio ports
+
+required:
+  - compatible
+  - dais
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qcom,gpr.h>
+
+    gpr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        service@1 {
+            reg = <GPR_APM_MODULE_IID>;
+            compatible = "qcom,q6apm";
+            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+            dais {
+                compatible = "qcom,q6apm-dais";
+                iommus = <&apps_smmu 0x1801 0x0>;
+            };
+        };
+    };
-- 
2.34.1

