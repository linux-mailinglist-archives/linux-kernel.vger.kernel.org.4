Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379C86297FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiKOMDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiKOMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:03:00 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27549233A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:51 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u2so17211924ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRDkbLdN3Hk4s8rRHjrRfrub5qJgUXRitpmo0hUp4NU=;
        b=rqbfqgqXihYdyms1FEfA31MAYyeJnGOJoDb9UKZBBZc5U+dwLrFNFHrjzA2t/riwJc
         2YaeZJKCFP7hXfbnl2W24Le5sOiH8Hf9+kp9siQ6Asm6HGUft4YTm8p7atixX5KkPxc3
         LS9AjpvccnBXvCZrQZJzXQc1W2rWwPK0TQd9xjZRM86eTr0OJ5xyE41xrhkGmuQu5LO4
         nPjmqBYRgyXiBXjf1SQZkHmvzO+TIZJFAwIewgUu9keEQDtn5gW27JFgyE0vNIYeYTSq
         8RIpAkL0xBkIR+kPk5bBHW13bDmBFf0V+MKG5DyOU0kydJThn3f8woFWDlSQNFzZ9xtI
         JHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRDkbLdN3Hk4s8rRHjrRfrub5qJgUXRitpmo0hUp4NU=;
        b=CaTs+HlowlcfAL1uDAwDBvj4zpOURf8ttfAhfzn+0HEl9/E0axiBsit3YRnJ5Pv4Ke
         D7rHsiH9aQZVF+R5/3rqcgKKpQkhxsIrtCEv3OiRJdmLYv0KwytEjZJ+Pykn5EnV2mfC
         PLJ+xh0IsybfF4o7WmKckADqpY4uNNcpOYlYVEze0pubPTYwuJo8G55IM7r+r3r2Ejam
         yFuR6YzDdFACHRhlySK7Cie9lWUUuQryL5L2VloQCz9WcWIT5MZCAUOrybWgtrnJ4+GW
         o5XeW24BXsHp6yb81OHwwpmPEigYD+75KSwfneDxjCAynPxAZ4VD3NmDHBdJLzEmagwO
         OI1w==
X-Gm-Message-State: ANoB5pk5Txf4Hl5xLEdLKsnw32vs3+1i7GpdzCW1pbOBgjEBUMXr74dc
        rcn/SGWkxJigSbqtNS7p4L1AJQ==
X-Google-Smtp-Source: AA0mqf53KFS2L0LpS7xLPyVFNfySVDUtL9HkQX/tAIiQBVms2FOnxbLG1YfpPKw2QDkQrhul/g/FJg==
X-Received: by 2002:a2e:a54a:0:b0:26c:5db6:cd84 with SMTP id e10-20020a2ea54a000000b0026c5db6cd84mr5637666ljn.114.1668513769294;
        Tue, 15 Nov 2022 04:02:49 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i13-20020ac25d2d000000b004b0b2212315sm2176233lfb.121.2022.11.15.04.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:02:48 -0800 (PST)
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
Subject: [PATCH v2 04/11] ASoC: dt-bindings: qcom,q6afe: Split to separate schema
Date:   Tue, 15 Nov 2022 13:02:28 +0100
Message-Id: <20221115120235.167812-5-krzysztof.kozlowski@linaro.org>
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

The APR/GPR bindings with services got complicated so move out the Q6AFE
service to its own binding.  Previously the compatible was documented in
qcom,apr.yaml.  Move most of the examples from its children to this new
file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: quic_srivasam@quicinc.com
Cc: quic_plai@quicinc.com
---
 .../devicetree/bindings/sound/qcom,q6afe.yaml | 68 +++++++++++++++++++
 .../sound/qcom,q6dsp-lpass-clocks.yaml        | 40 +----------
 .../sound/qcom,q6dsp-lpass-ports.yaml         | 56 +++------------
 3 files changed, 80 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml b/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
new file mode 100644
index 000000000000..297aa362aa54
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
@@ -0,0 +1,68 @@
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

