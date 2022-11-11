Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B9C625978
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiKKLg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiKKLgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:36:16 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B0660EA6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:13 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id c1so7920877lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64ecADi4+z7+ei9RWWqZDpGuTRxb+PiFx0FpSXFDUNU=;
        b=B1skD0aIiEDXoYNTZC4cNo2OPm9uTEXucEVa2PacHy0JHSrn2M+ox5xwMmXIn6nCVo
         TFzi5PBY9stKPEkiwbD9UFiN95jy5vJ+yxkV9TQJmEEwVar1mbjaiWbNtn1HnTjGbIrs
         yxspfvxtp1ppK0LsA2tI7BDu96Vw6CrD34iY705419dVOo4E7stcs2oDz0tIu0vITF7r
         ILpu2KY1Bc1T+hrFkyefa8/USprGzt4seQ19PGf0wtB3BVKiNyoAjBPfXmYeqC9dlQLX
         REKp3Gp8ZHnoVjwuCmoU/0m7FzLleezRxO21QgVofzUFkBFEKtksaSGuyta6iCQnD2PI
         6arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64ecADi4+z7+ei9RWWqZDpGuTRxb+PiFx0FpSXFDUNU=;
        b=sFse5DVqARbRIZ+d/xar2lXbeI5wB7ulOraYHj5Zx/nid49fQI2D24Xa2vBx9TUbO4
         g6TK1YvJnLHQthImXp/ThJuJKnQdWkjrENy8rO1z0rd05xq0eVOHu2uW+tW4FozDxNfe
         DjnRHyWDqrEeB5N/wl7ubAbXbwNDhJ3dAXqjG2s/EY7L8BzUaSbi+8wuZjm45q91a1lb
         XHbkaJU3S0ehDLtWEJ5Rc4jy8VOjqjocr0IO/FQzQ8XbY7PIBcBuQXx41CySvikRi3s6
         bzDUkl8LaXkyG1CJbdk21ef4p2SLyefENDHzJsKmG2oA7iwFow0PLMP/+wOSxCEJ9Bjc
         RyPQ==
X-Gm-Message-State: ANoB5pm/aVU+kq7CEWPAqaEoNyPSsN3PqMYJ9Hony+z7k4tis4lzmjL1
        CQW8xjjgfNdHREWgFjiLGSpeKHRDxC9W3A==
X-Google-Smtp-Source: AA0mqf6nL3sJR7ZROlkLXZr/JaPtxBlekOn176arXd+MeMnB7g1kMnKpchjZqBKlvQWM30pGiB+z9A==
X-Received: by 2002:a05:6512:2a87:b0:4ac:5faa:654d with SMTP id dt7-20020a0565122a8700b004ac5faa654dmr525928lfb.684.1668166572207;
        Fri, 11 Nov 2022 03:36:12 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b004acb2adfa1fsm274970lfb.307.2022.11.11.03.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:36:11 -0800 (PST)
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
Subject: [PATCH 03/10] ASoC: dt-bindings: qcom,q6afe: Split to separate schema
Date:   Fri, 11 Nov 2022 12:35:40 +0100
Message-Id: <20221111113547.100442-4-krzysztof.kozlowski@linaro.org>
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

The APR/GPR bindings with services got complicated so move out the Q6AFE
service to its own binding.  Previously the compatible was documented in
qcom,apr.yaml.  Move most of the examples from its children to this new
file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.yaml | 69 +++++++++++++++++++
 .../sound/qcom,q6dsp-lpass-clocks.yaml        | 40 +----------
 .../sound/qcom,q6dsp-lpass-ports.yaml         | 56 +++------------
 3 files changed, 81 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml b/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
new file mode 100644
index 000000000000..45ad703d70bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6afe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Audio FrontEnd (Q6AFE)
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
+      - qcom,q6afe
+
+  clock-controller:
+    $ref: /schemas/sound/qcom,q6dsp-lpass-clocks.yaml#
+    unevaluatedProperties: false
+    description: Qualcomm DSP LPASS clock controller
+
+  dais:
+    type: object
+    $ref: /schemas/sound/qcom,q6dsp-lpass-ports.yaml#
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
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    apr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        service@4 {
+            compatible = "qcom,q6afe";
+            reg = <APR_SVC_AFE>;
+            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+            clock-controller {
+                compatible = "qcom,q6afe-clocks";
+                #clock-cells = <2>;
+            };
+
+            dais {
+                compatible = "qcom,q6afe-dais";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                #sound-dai-cells = <1>;
+
+                dai@22 {
+                    reg = <QUATERNARY_MI2S_RX>;
+                    qcom,sd-lines = <0 1 2 3>;
+                };
+            };
+
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
index fd567d20417d..aa6c0ecba5cf 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
@@ -35,41 +35,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/soc/qcom,apr.h>
-    #include <dt-bindings/sound/qcom,q6afe.h>
-    apr {
-        compatible = "qcom,apr-v2";
-        qcom,domain = <APR_DOMAIN_ADSP>;
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        service@4 {
-            compatible = "qcom,q6afe";
-            reg = <APR_SVC_AFE>;
-            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-
-            clock-controller {
-                compatible = "qcom,q6afe-clocks";
-                #clock-cells = <2>;
-            };
-        };
-    };
-
-  - |
-    #include <dt-bindings/soc/qcom,gpr.h>
-    gpr {
-        compatible = "qcom,gpr";
-        qcom,domain = <GPR_DOMAIN_ID_ADSP>;
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        service@2 {
-            reg = <GPR_PRM_MODULE_IID>;
-            compatible = "qcom,q6prm";
-
-            clock-controller {
-                compatible = "qcom,q6prm-lpass-clocks";
-                #clock-cells = <2>;
-            };
-        };
+    clock-controller {
+        compatible = "qcom,q6afe-clocks";
+        #clock-cells = <2>;
     };
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
index e53fc0960a14..b202692f1756 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
@@ -150,54 +150,16 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/soc/qcom,apr.h>
-    #include <dt-bindings/sound/qcom,q6afe.h>
-    apr {
-        compatible = "qcom,apr-v2";
-        #address-cells = <1>;
-        #size-cells = <0>;
-        qcom,domain = <APR_DOMAIN_ADSP>;
-
-        service@4 {
-            compatible = "qcom,q6afe";
-            reg = <APR_SVC_AFE>;
-            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-
-            dais {
-                compatible = "qcom,q6afe-dais";
-                #address-cells = <1>;
-                #size-cells = <0>;
-                #sound-dai-cells = <1>;
-
-                dai@22 {
-                    reg = <QUATERNARY_MI2S_RX>;
-                    qcom,sd-lines = <0 1 2 3>;
-                };
-            };
-        };
-    };
-  - |
-    #include <dt-bindings/soc/qcom,gpr.h>
-    gpr {
-        compatible = "qcom,gpr";
+    #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+
+    dais {
+        compatible = "qcom,q6afe-dais";
         #address-cells = <1>;
         #size-cells = <0>;
-        qcom,domain = <GPR_DOMAIN_ID_ADSP>;
-
-        service@1 {
-            compatible = "qcom,q6apm";
-            reg = <GPR_APM_MODULE_IID>;
-
-            dais {
-                compatible = "qcom,q6apm-lpass-dais";
-                #address-cells = <1>;
-                #size-cells = <0>;
-                #sound-dai-cells = <1>;
-
-                dai@22 {
-                    reg = <QUATERNARY_MI2S_RX>;
-                    qcom,sd-lines = <0 1 2 3>;
-                };
-            };
+        #sound-dai-cells = <1>;
+
+        dai@22 {
+            reg = <QUATERNARY_MI2S_RX>;
+            qcom,sd-lines = <0 1 2 3>;
         };
     };
-- 
2.34.1

