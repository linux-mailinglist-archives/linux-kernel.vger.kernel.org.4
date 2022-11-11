Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930B9625975
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiKKLgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiKKLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:36:14 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B219A4B9AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:12 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r12so7952036lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EB4I3WqkMG0ssDPCVcZC0Ysf3XgZOuA6bOA7vE338fY=;
        b=DPf9pv4Blnc4lpQ5nhDMbtzrHDpDPhl3i+pMnLqzqRL5Jz1nglnLY8GehobSi+9D+z
         awTpJAA8Acp0z1pL5cieOf8Bp0ICe2LVVV9l5xwpAhnnrO5k+Ok0CJwSSH13bhltmqNr
         J6MzlKPHfsLn3n3DwFkJX306e5TmfH4cPOxoKY+uQZesUC3mEfvshqzjVZrNUZRa65ud
         71iFSEhEI08KxAWlErEaul7veH7nGWnVsyCn8lZxtDgCrKWorrRBfZjvrlnfYF0XKAJb
         Ha+Z6G5N9kiqyOGybC26DAyvZocAm29rQD6hpXW0C0NfrGx5apy3JlH5Mm9rjWaxz54H
         GgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB4I3WqkMG0ssDPCVcZC0Ysf3XgZOuA6bOA7vE338fY=;
        b=RSZ3L+n3cAKURzuYTGM5wvbpXBaMN/35J+Ha2w9/w1Dmi74z27aeO9Xwn+JIv/h1ig
         NiUWE+9bV/B+4047Tq0FyEOWZ1O9txyoLBeo5u0tVpA6mPYMoV9St9T9QZZBZCky3pYn
         mjtDqHNWmXWmRLlbVlfGijGkajQFujevkSfSQ+up6Ari41b2AyTqmStmtQcrbHH1eevb
         pkhBDtdt5o3dD0YyDAuoLp6CA5Koy66ZSTBzpCokOpQ8SBr5aIZWUKYy2SLhvrsuU5Tq
         q4pkwL0pIMlCOE1eu0tgutdIoExccLhKJ7EiTa+rkCixipU+R5sxPhsE+3NW/i0tj/Dg
         70xw==
X-Gm-Message-State: ANoB5pkZHrzLvnm55ROzq0Gu84zGFxtjHniOPZRpt6abM3sHooVSoiUS
        +s6bri1zab4rqMYT1act0lAgHw==
X-Google-Smtp-Source: AA0mqf5oOhPgXEjn9JMms/293AHcWVE0ZsLElWgNb5bUqlb4jW7YvVdCR0Xcl91+irLXEz74dxa4zg==
X-Received: by 2002:a05:6512:478:b0:4a2:3d2c:34ac with SMTP id x24-20020a056512047800b004a23d2c34acmr568409lfd.41.1668166571013;
        Fri, 11 Nov 2022 03:36:11 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b004acb2adfa1fsm274970lfb.307.2022.11.11.03.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:36:10 -0800 (PST)
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
Subject: [PATCH 02/10] ASoC: dt-bindings: qcom,apr: Split services to shared schema
Date:   Fri, 11 Nov 2022 12:35:39 +0100
Message-Id: <20221111113547.100442-3-krzysztof.kozlowski@linaro.org>
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

The APR/GPR nodes are organized like:

  apr-or-gpr-device-node <- qcom,apr.yaml
    apr-gpr-service@[0-9] <- qcom,apr.yaml
      service-specific-components <- /schemas/sound/qcom,q6*.yaml

The schema for services (apr-gpr-service@[0-9]) already grows
considerably and is still quite not specific.  It allows several
incorrect combinations, like adding a clock-controller to a APM device.
Restricting it would complicate the schema even more.  Bringing new
support for sound on Qualcomm SM8450 and SC8280XP SoC would grow it as
well.

Simplify the qcom,apr.yaml by splitting the services to a shared file
which will be:
1. Referenced by qcom,apr.yaml with additionalProperties:true,
2. Referenced by specific bindings for services with
   additionalProperties:false (not yet in this commit).

While moving the code, add also required 'reg' and
'qcom,protection-domain' to further constrain the bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/qcom/qcom,apr-services.yaml  |  54 +++++++++
 .../bindings/soc/qcom/qcom,apr.yaml           | 108 +-----------------
 MAINTAINERS                                   |   2 +-
 3 files changed, 58 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
new file mode 100644
index 000000000000..290555426c39
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,apr-services.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm APR/GPR services shared parts
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  Common parts of a static service in Qualcomm APR/GPR (Asynchronous/Generic
+  Packet Router).
+
+properties:
+  reg:
+    minimum: 1
+    maximum: 13
+    description: |
+      APR Service ID
+        3 = DSP Core Service
+        4 = Audio  Front End Service.
+        5 = Voice Stream Manager Service.
+        6 = Voice processing manager.
+        7 = Audio Stream Manager Service.
+        8 = Audio Device Manager Service.
+        9 = Multimode voice manager.
+        10 = Core voice stream.
+        11 = Core voice processor.
+        12 = Ultrasound stream manager.
+        13 = Listen stream manager.
+      GPR Service ID
+        1 = Audio Process Manager Service
+        2 = Proxy Resource Manager Service.
+        3 = AMDB Service.
+        4 = Voice processing manager.
+
+  qcom,protection-domain:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: |
+      Protection domain service name and path for APR service
+      possible values are::
+      "avs/audio", "msm/adsp/audio_pd".
+      "kernel/elf_loader", "msm/modem/wlan_pd".
+      "tms/servreg", "msm/adsp/audio_pd".
+      "tms/servreg", "msm/modem/wlan_pd".
+      "tms/servreg", "msm/slpi/sensor_pd".
+
+required:
+  - reg
+  - qcom,protection-domain
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index 0a7a34cb2497..9302ffe567d6 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -80,115 +80,13 @@ properties:
   '#size-cells':
     const: 0
 
-#APR/GPR Services
 patternProperties:
   "^service@[1-9a-d]$":
     type: object
+    $ref: /schemas/soc/qcom/qcom,apr-services.yaml
+    additionalProperties: true
     description:
-      APR/GPR node's client devices use subnodes for desired static port services.
-
-    properties:
-      compatible:
-        enum:
-          - qcom,q6core
-          - qcom,q6asm
-          - qcom,q6afe
-          - qcom,q6adm
-          - qcom,q6apm
-          - qcom,q6prm
-
-      reg:
-        minimum: 1
-        maximum: 13
-        description:
-          APR Service ID
-            3 = DSP Core Service
-            4 = Audio  Front End Service.
-            5 = Voice Stream Manager Service.
-            6 = Voice processing manager.
-            7 = Audio Stream Manager Service.
-            8 = Audio Device Manager Service.
-            9 = Multimode voice manager.
-            10 = Core voice stream.
-            11 = Core voice processor.
-            12 = Ultrasound stream manager.
-            13 = Listen stream manager.
-          GPR Service ID
-            1 = Audio Process Manager Service
-            2 = Proxy Resource Manager Service.
-            3 = AMDB Service.
-            4 = Voice processing manager.
-
-      clock-controller:
-        $ref: /schemas/sound/qcom,q6dsp-lpass-clocks.yaml#
-        description: Qualcomm DSP LPASS clock controller
-        unevaluatedProperties: false
-
-      dais:
-        type: object
-        oneOf:
-          - $ref: /schemas/sound/qcom,q6apm-dai.yaml#
-          - $ref: /schemas/sound/qcom,q6dsp-lpass-ports.yaml#
-          - $ref: /schemas/sound/qcom,q6asm-dais.yaml#
-        unevaluatedProperties: false
-        description: Qualcomm DSP audio ports
-
-      routing:
-        type: object
-        $ref: /schemas/sound/qcom,q6adm-routing.yaml#
-        unevaluatedProperties: false
-        description: Qualcomm DSP LPASS audio routing
-
-      qcom,protection-domain:
-        $ref: /schemas/types.yaml#/definitions/string-array
-        description: protection domain service name and path for apr service
-          possible values are
-          "avs/audio", "msm/adsp/audio_pd".
-          "kernel/elf_loader", "msm/modem/wlan_pd".
-          "tms/servreg", "msm/adsp/audio_pd".
-          "tms/servreg", "msm/modem/wlan_pd".
-          "tms/servreg", "msm/slpi/sensor_pd".
-
-    allOf:
-      - if:
-          properties:
-            compatible:
-              enum:
-                - qcom,q6afe
-        then:
-          properties:
-            dais:
-              properties:
-                compatible:
-                  const: qcom,q6afe-dais
-
-      - if:
-          properties:
-            compatible:
-              enum:
-                - qcom,q6apm
-        then:
-          properties:
-            dais:
-              properties:
-                compatible:
-                  enum:
-                    - qcom,q6apm-dais
-                    - qcom,q6apm-lpass-dais
-
-      - if:
-          properties:
-            compatible:
-              enum:
-                - qcom,q6asm
-        then:
-          properties:
-            dais:
-              properties:
-                compatible:
-                  const: qcom,q6asm-dais
-
-    additionalProperties: false
+      APR/GPR static port services.
 
 required:
   - compatible
diff --git a/MAINTAINERS b/MAINTAINERS
index 3df7b9a3f5ba..804e4a700477 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16893,7 +16893,7 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Banajit Goswami <bgoswami@quicinc.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
-F:	Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,apr*
 F:	Documentation/devicetree/bindings/sound/qcom,*
 F:	drivers/soc/qcom/apr.c
 F:	include/dt-bindings/sound/qcom,wcd9335.h
-- 
2.34.1

