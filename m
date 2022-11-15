Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3774B62980C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbiKOMDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbiKOMDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:03:05 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2340126111
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:55 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j4so24138572lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcmcIw/aoAY1FZoJ9/HC3cRwB98JOHeI75J1MhSGCew=;
        b=g+qfShLUo2LcjPN37+QJFvvM6HOfjcpebHHs3phTNmQ++jagmE2hVKe059ZJ8eIhJo
         uA1SJ9LaL+Ts/TvM8zdLa4hIU4rtoha67wRcaqNCsUPRiySxf8oYdcDYyxJuxn+HdnYM
         WaIR/Shar2GFUkui1AzEJP+eaNZpSN0S3WQ5R6/0nuyMXydR0sINrbs42DuR0n9W7G7j
         WeId26+kF7e9mX7wqAfpyXIaNzW2d3HRowZRm2nFAhg6kM0wF+go8lTXnxi1ZZx9rHsu
         3hiEtpHqW2tFGNu6oruAbQemBXPuINDtuCAPSmcRA5yWBI9vSgoy5y5T4/7+o5R6LvqM
         ishA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcmcIw/aoAY1FZoJ9/HC3cRwB98JOHeI75J1MhSGCew=;
        b=vwLljfC27SNskTjiBrqlNtF2AEx9jptizE4Ao0sdNywgRDeyhC28RcSVCd/34g/Zwz
         ozAqwdNJXWqSIWdpVNFy4AZ7TFZZ13BRAyE01ijK522/PkGAVNhZlHWBMhMv5U+cU9ah
         0p72Z6APsNHQnkzDwCQRijuZHGSSTqnjW3wlXr9p7UqcEiNBOWwNltjbyuHlr3Ii3ryd
         0v8ae2rtZybMQmCbox8QtoUfKLvtBZeH5NjkmZxVUC2Ipo8PqqhyZBNbNL7KtOgLTROd
         lyMJN1ZwKlvVxTtb1soAQnUVCoFw4wqXR6zAqof3hGNwiVPdM8l2kXmHnlIRs9QMx8Tg
         ckOg==
X-Gm-Message-State: ANoB5pmw73vgiqUrEGLDX4ZRgQigdRoHWcNV2ee5qNyj6J/Ut96mnDuH
        +2btgG6mU9xlBreh79N8zw54PQ==
X-Google-Smtp-Source: AA0mqf7xRuGkBbvLbDme2sRQQB7T7oFo2vBw1rzAMcKHBMUvDVvvO3WRtyIkW6ZMG5MN6t8MS2NRwQ==
X-Received: by 2002:a05:6512:313b:b0:4a2:27f0:46a5 with SMTP id p27-20020a056512313b00b004a227f046a5mr5943056lfd.611.1668513774167;
        Tue, 15 Nov 2022 04:02:54 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i13-20020ac25d2d000000b004b0b2212315sm2176233lfb.121.2022.11.15.04.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:02:53 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        quic_srivasam@quicinc.com, quic_plai@quicinc.com
Subject: [PATCH v2 07/11] ASoC: dt-bindings: qcom,q6asm: Split to separate schema
Date:   Tue, 15 Nov 2022 13:02:31 +0100
Message-Id: <20221115120235.167812-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
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

The APR/GPR bindings with services got complicated so move out the Q6ASM
service to its own binding.  Previously the compatible was documented in
qcom,apr.yaml.  Move most of the examples from its children to this new
file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: quic_srivasam@quicinc.com
Cc: quic_plai@quicinc.com
---
 .../bindings/sound/qcom,q6asm-dais.yaml       | 48 +++++--------
 .../devicetree/bindings/sound/qcom,q6asm.yaml | 68 +++++++++++++++++++
 2 files changed, 84 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
index 8deb8ffb143b..0110b38f6de9 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
@@ -73,40 +73,24 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/soc/qcom,apr.h>
-    #include <dt-bindings/sound/qcom,q6asm.h>
-
-    apr {
-        compatible = "qcom,apr-v2";
-        qcom,domain = <APR_DOMAIN_ADSP>;
+    dais {
+        compatible = "qcom,q6asm-dais";
+        iommus = <&apps_smmu 0x1821 0x0>;
         #address-cells = <1>;
         #size-cells = <0>;
+        #sound-dai-cells = <1>;
+
+        dai@0 {
+            reg = <0>;
+        };
+
+        dai@1 {
+            reg = <1>;
+        };
 
-        service@7 {
-            compatible = "qcom,q6asm";
-            reg = <APR_SVC_ASM>;
-            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-
-            dais {
-                compatible = "qcom,q6asm-dais";
-                iommus = <&apps_smmu 0x1821 0x0>;
-                #address-cells = <1>;
-                #size-cells = <0>;
-                #sound-dai-cells = <1>;
-
-                dai@0 {
-                    reg = <0>;
-                };
-
-                dai@1 {
-                    reg = <1>;
-                };
-
-                dai@2 {
-                    reg = <2>;
-                    is-compress-dai;
-                    direction = <1>;
-                };
-            };
+        dai@2 {
+            reg = <2>;
+            is-compress-dai;
+            direction = <1>;
         };
     };
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6asm.yaml
new file mode 100644
index 000000000000..cb49f9667cca
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6asm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Audio Stream Manager (Q6ASM)
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
+      - qcom,q6asm
+
+  dais:
+    type: object
+    $ref: /schemas/sound/qcom,q6asm-dais.yaml#
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
+    #include <dt-bindings/soc/qcom,apr.h>
+
+    apr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        service@7 {
+            compatible = "qcom,q6asm";
+            reg = <APR_SVC_ASM>;
+            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+            dais {
+                compatible = "qcom,q6asm-dais";
+                iommus = <&apps_smmu 0x1821 0x0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                #sound-dai-cells = <1>;
+
+                dai@0 {
+                    reg = <0>;
+                };
+
+                dai@1 {
+                    reg = <1>;
+                };
+
+                dai@2 {
+                    reg = <2>;
+                    is-compress-dai;
+                    direction = <1>;
+                };
+            };
+        };
+    };
-- 
2.34.1

