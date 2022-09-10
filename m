Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F155B4585
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiIJJPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIJJPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:15:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2E32872C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z25so6728696lfr.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1cq2Cz6+Sy/tLxBRXynhhig1VTaXAXEwiLaRAUKokT0=;
        b=rDJ5SqyF0Ajf/iIhY3qigKE1/djVs2SBb1CDat7xU4E76GbX2Sxcv+F+kMXDS0Ef60
         dlZ+7FMqkqNCH6/1eIjoJQf3OwEre1m/Bfs8sbPFnMJRQgVagX86tN5XbyZupxVnwB6K
         u+G8zCl+mXQtm4TNA85+W/scSjxyAZa4f/uX74q1bt8mc05VjprOHhWxMOO++R8t0jTs
         GDxD8w1vcbhussJDB7jxjqj/jKDW8BctaBatLmfv243uDAPQQiUXcklhPrqwn2AEpDwU
         go+VeKEMnizvem+i5XrZZqnRoRW9KFg8Wq/pYVTs5nV9GRFXe/XbIJnRoRV4nJpIwlMi
         kgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1cq2Cz6+Sy/tLxBRXynhhig1VTaXAXEwiLaRAUKokT0=;
        b=SVjVbvVdtR2Ztp6Mav8a8CepcB2j6/CRtukTcMUoCYvrkIAZvRZZCBPnLL2fd126fH
         RQNoT9nh36YeMj3b4nt8B3AgPkIe2pNyQIKWnHXNtIJ8IX0V7FUXtk6renKbOec1RkYZ
         U/2rWr3k7+kBiy0BaGcXhP//apRjlJimNYAUtfbKwDXbvcnqjzwSxE5TOzGITsduLNUF
         qflCA/Fa0IDStJH1bIg/R8jXovPD+M7i2K6T3Ljrh2mqfsJ++HEv+tQG9BzSuADnDwqi
         +RDl754ct5RrMvwScK/ILtaCsVISLMazhXsW9qbxKHIzUE76y5xA3Wofx5M9A4dZ6iRE
         ONZQ==
X-Gm-Message-State: ACgBeo1wI0pvVU3l/lmBNpiV4f5d1L3ExdZhssFkV1TeVdh0NALSC3mk
        btj+6j6x2HUCgVrzho1ipstR/A==
X-Google-Smtp-Source: AA6agR7RKod47U0kD5QSHRgIkY8q0SH4jTo0lBV/oMq4KCefwxXWIcDQ7tqIanhG61C70/2ETM7CGg==
X-Received: by 2002:a19:520b:0:b0:498:f580:5cb5 with SMTP id m11-20020a19520b000000b00498f5805cb5mr3098607lfb.513.1662801290572;
        Sat, 10 Sep 2022 02:14:50 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x22-20020a19e016000000b0048b26d4bb64sm201552lfg.40.2022.09.10.02.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:14:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 11/15] ASoC: dt-bindings: qcom,q6adm: convert to dtschema
Date:   Sat, 10 Sep 2022 11:14:24 +0200
Message-Id: <20220910091428.50418-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
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

Convert Qualcomm Audio Device Manager (Q6ADM) bindings to DT schema.

The original bindings documented:
1. APR service node with compatibles: "qcom,q6adm" and
"qcom,q6adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>",
2. Routing child node with compatible "qcom,q6adm-routing".

The conversion entirely drops (1) because the compatible is already
documented in bindings/soc/qcom/qcom,apr.yaml.  The
"qcom,q6adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>" on the other hand is not
used at all - neither in existing DTS, nor in downstream sources - so
versions seems to be fully auto-detectable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v3:
1. New patch.
---
 .../bindings/soc/qcom/qcom,apr.yaml           |  3 +-
 .../bindings/sound/qcom,q6adm-routing.yaml    | 52 +++++++++++++++++++
 .../devicetree/bindings/sound/qcom,q6adm.txt  | 39 --------------
 3 files changed, 54 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index a1a8f77beef7..54328d74af85 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -112,8 +112,9 @@ patternProperties:
         description: Qualcomm DSP audio ports
 
       routing:
-        # TODO: Waiting for Documentation/devicetree/bindings/sound/qcom,q6adm.txt
         type: object
+        $ref: /schemas/sound/qcom,q6adm-routing.yaml#
+        unevaluatedProperties: false
         description: Qualcomm DSP LPASS audio routing
 
       qcom,protection-domain:
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml b/Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml
new file mode 100644
index 000000000000..d0f7a79e240a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6adm-routing.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Audio Device Manager (Q6ADM) routing
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  Qualcomm Audio Device Manager (Q6ADM) routing node represents routing
+  specific configuration.
+
+properties:
+  compatible:
+    enum:
+      - qcom,q6adm-routing
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qcom,apr.h>
+    #include <dt-bindings/sound/qcom,q6asm.h>
+
+    apr {
+        compatible = "qcom,apr-v2";
+        qcom,domain = <APR_DOMAIN_ADSP>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        service@8 {
+            compatible = "qcom,q6adm";
+            reg = <APR_SVC_ADM>;
+            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+            routing {
+                compatible = "qcom,q6adm-routing";
+                #sound-dai-cells = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
deleted file mode 100644
index 15c353a20de8..000000000000
--- a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Qualcomm Audio Device Manager (Q6ADM) binding
-
-Q6ADM is one of the APR audio service on Q6DSP.
-Please refer to qcom,apr.txt for details of the coommon apr service bindings
-used by the apr service device.
-
-- but must contain the following property:
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,q6adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
-		   Or "qcom,q6adm" where the version number can be queried
-		   from DSP.
-		   example "qcom,q6adm-v2.0"
-
-
-= ADM routing
-"routing" subnode of the ADM node represents adm routing specific configuration
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,q6adm-routing".
-
-- #sound-dai-cells
-	Usage: required
-	Value type: <u32>
-	Definition: Must be 0
-
-= EXAMPLE
-apr-service@8 {
-	compatible = "qcom,q6adm";
-	reg = <APR_SVC_ADM>;
-	q6routing: routing {
-		compatible = "qcom,q6adm-routing";
-		#sound-dai-cells = <0>;
-	};
-};
-- 
2.34.1

