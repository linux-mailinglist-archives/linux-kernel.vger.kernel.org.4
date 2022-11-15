Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD096297FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbiKOMDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbiKOMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:03:00 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E8224F08
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d6so24041269lfs.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhFQwDZN5tKwjWiBCGVlIG1S7K2/rpG/m674X3+lJKs=;
        b=EvegI737vrbQhgSyJLIHL1krdI+z+24UywT80kcn6a1GsEnibbvC/pwMF24JxHW85G
         85/86KRy9xZZ5WsSDGgpIuIf91KGNFgQEo1jU1URVPbP8QvLwMYJW23mqc/KoJJMCV42
         QuSww7Hl647mCYMV6/1RZX6Jx2KwwiqcQnb0B7ueXyUiKJPW5enLxzf2jLdN9hFzZp55
         ecdqNG5W25vMc0a+c1DRx3zUY1CnLyxVS25/TfXw4cdr4XJJVSFehFWh15ReKG8dpyvd
         yQLFvt6KQcsehry2ZiVGUSGc1tzvusm/hTloql/zNAmniN8Mca4OYu6fqt/gJ7YptUMD
         1Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhFQwDZN5tKwjWiBCGVlIG1S7K2/rpG/m674X3+lJKs=;
        b=hjxFWu7BIk8Mrkp4ckYfrUMiYSBxSRwmcqc3WU4pxePeN23lHxZjsNuJ9cMeZF/6Ry
         Bt/EC/Phg4XbFRkqlvisiGzHfgFK2a9mqCIjU1er51/rom5b4y/GknhluA+CiHNElOnp
         BwtR+R0nl3GC1f4dZSaEyu0dn48x0pKM/+RTxnHNDINgDe8z40jCr9B5sGPw5s7OtgR9
         RdCXH409WXtQ+3bozTzUJ/TFdQ/lhljrUYIff2pgFLt+W8oF4Vc6nyLUd9+j+UA0c2AI
         +vEfGUOM8+SjZE7eRaA9wWsQpkIpBxh7Q3fvQ0X0HUdH8RHMMwUT6r3mkCDZT/GkoDBY
         iGLA==
X-Gm-Message-State: ANoB5pkdEwxokF8vp5Lth4viufRv1OSC6Bs9xXlTCG8OfDq8OJAV/y6P
        4jfc6/s6RJOI+MkXcw8blvYFXpFB9xvtEbd8
X-Google-Smtp-Source: AA0mqf5Avjze8mJqpmB/otxRNftLEtkt0pNU9EgD3UC/DTHK4bAdhHeRlo0WGXs0v9Syhhvw9l9iyw==
X-Received: by 2002:ac2:5487:0:b0:4a2:4b1b:6ad9 with SMTP id t7-20020ac25487000000b004a24b1b6ad9mr6206908lfk.296.1668513771211;
        Tue, 15 Nov 2022 04:02:51 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i13-20020ac25d2d000000b004b0b2212315sm2176233lfb.121.2022.11.15.04.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:02:50 -0800 (PST)
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
Subject: [PATCH v2 05/11] ASoC: dt-bindings: qcom,q6apm: Split to separate schema
Date:   Tue, 15 Nov 2022 13:02:29 +0100
Message-Id: <20221115120235.167812-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
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

The APR/GPR bindings with services got complicated so move out the Q6APM
service to its own binding.  Previously the compatible was documented in
qcom,apr.yaml.  Move most of the examples from its children to this new
file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: quic_srivasam@quicinc.com
Cc: quic_plai@quicinc.com
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

