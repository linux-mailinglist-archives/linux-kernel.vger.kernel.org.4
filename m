Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8156A625980
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiKKLgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiKKLgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:36:17 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140BB5D6B5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:16 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p8so7886532lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR2tPQi4lIHKX8Jfaq8dJOpmO3FJy3VHaO4/AEfLyyE=;
        b=Zen78NeH4QaZ4C37xoIvhQ+rkugOPSj2xLWQO0jMtAR10MTBxdUPddsYgqGd5Je4Oy
         q+dpZwHQLC+bS0QHZzF4ae0SNoC1tF+8A1ypy5On+qA53Z8VGhMdgjoAEkCocn7zUQT5
         SG8rNiFwsv4cl5klZG6N4IN0xWiZO2T/E1eZm9n2v4kVTAxFJJ4vfAfNndqCCF5tLzdc
         MYCMX9NmUbxx3aVqY8JIHqhK9N/h24J7D0Yg8dRJPHZ536hgiiffs7Vz9XMfRa/ITYBy
         vb9xR1vqNVK/L0WsrgkciYhjwbAYxtFqcolcpsyYBMjC5qadFTxlhRFx1p5A8QuSpYyE
         dWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR2tPQi4lIHKX8Jfaq8dJOpmO3FJy3VHaO4/AEfLyyE=;
        b=kGA8Run6UeoWqx9w60r3F6ZT1XYPOIUD8rqW0otFnXa1XY0BT1Tm/P1tSJXu1Nsa4z
         UNTAkK7wCZxtpX+XIa4th9PBJ+RpfWkSJe/os82UEv7vACJO80bAScuWfFgc6+iUssQ8
         sES/jYPIpC7OgfBUuCC7SFxONyK78bPH/5DMto0a4uZRJiTzqc8H394AlpyBrhNjpOvm
         4CRuh/FM4wfFTwMkniNHsoQCKxISlNBQjq+ftRZ6njsVo51uOGRTHGUZlOOC7K4v5J4L
         GcWJWoZ7vEmT1AOniZaQqryfQlmJvFNbyp8l7+t3QJ5E2pnvWy0qAkdctHsChqEBy3GH
         mYRQ==
X-Gm-Message-State: ANoB5pnm5Jm0d68Y3X1YMr9JDGjGDxxftNIpVHlr+8O1by3g6AWRkxrt
        A0x1NntGUcxuXj1abfPIX5zzyQ==
X-Google-Smtp-Source: AA0mqf4QA2XX4+OsUF0J/6zszV+xaUirjx/TwI/UH/2+JFmqNiYLrNcrgCMLZKVvAV+DqdiDmATXwg==
X-Received: by 2002:ac2:5ccb:0:b0:4a2:4f74:f47c with SMTP id f11-20020ac25ccb000000b004a24f74f47cmr556364lfq.367.1668166574452;
        Fri, 11 Nov 2022 03:36:14 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b004acb2adfa1fsm274970lfb.307.2022.11.11.03.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:36:13 -0800 (PST)
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
Subject: [PATCH 05/10] ASoC: dt-bindings: qcom,q6adm: Split to separate schema
Date:   Fri, 11 Nov 2022 12:35:42 +0100
Message-Id: <20221111113547.100442-6-krzysztof.kozlowski@linaro.org>
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

The APR/GPR bindings with services got complicated so move out the Q6ADM
service to its own binding.  Previously the compatible was documented in
qcom,apr.yaml.  Move most of the examples from its children to this new
file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,q6adm-routing.yaml    | 22 ++------
 .../devicetree/bindings/sound/qcom,q6adm.yaml | 51 +++++++++++++++++++
 2 files changed, 54 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml b/Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml
index d0f7a79e240a..b7ed2d3f21f9 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml
@@ -30,23 +30,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/soc/qcom,apr.h>
-    #include <dt-bindings/sound/qcom,q6asm.h>
-
-    apr {
-        compatible = "qcom,apr-v2";
-        qcom,domain = <APR_DOMAIN_ADSP>;
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        service@8 {
-            compatible = "qcom,q6adm";
-            reg = <APR_SVC_ADM>;
-            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-
-            routing {
-                compatible = "qcom,q6adm-routing";
-                #sound-dai-cells = <0>;
-            };
-        };
+    routing {
+        compatible = "qcom,q6adm-routing";
+        #sound-dai-cells = <0>;
     };
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6adm.yaml
new file mode 100644
index 000000000000..fe14a97ea616
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6adm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Audio Device Manager (Q6ADM)
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
+      - qcom,q6adm
+
+  routing:
+    type: object
+    $ref: /schemas/sound/qcom,q6adm-routing.yaml#
+    unevaluatedProperties: false
+    description: Qualcomm DSP LPASS audio routing
+
+required:
+  - compatible
+  - routing
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
-- 
2.34.1

