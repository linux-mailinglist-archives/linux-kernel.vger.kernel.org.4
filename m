Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF64F6297F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiKOMCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKOMCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:02:48 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D3A220C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:47 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id t10so17249417ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afNI0b/iz5bqmWxZzda65ypkON8o+45VDO2joMDytGk=;
        b=sJ6zc/nJho9IF7dHq+gwieTQIhLHXKfvXWlhjnTzuQUvJlGozSCJi56FtoaT8axaIH
         aTWIIynUt5esgSvZhKqI1KVLFjOhWRrzxvQPlUHkOUifCzEoj+0WFyFGsBJqDviIyM/s
         4Mf7cU4JjYYyTruJZM9Wpfm0sEryE56XnojkN+JL2mymS03V6SFp8rBsXv1vYL8MHkaD
         R4o3GO+JuHfiWofDZnSQk8mvaTg0J4cK29FG/Ffk7dsCGH8kDqkSfqLWXCsXnTuMAp1c
         0Uf8nwMgM0ZFXGw188kBeZPfWVnsg1YMf5U7L4qMMfD4sIXX6fGQeYw2i22PdHxdFHux
         DuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afNI0b/iz5bqmWxZzda65ypkON8o+45VDO2joMDytGk=;
        b=rReavpTD2A4vI/iQ1RrBwyERn8ftkX0es4WsQOeiN1kzWBfH3ojZUqQtLE7o7vZVCV
         g9Q3vuLG+Tsgn2BwMoqRjzL6eMN3yDQlg6KknUaXsAemPGvOpbsCQH/COzCcK+biGzEj
         pSiePBasrXY1OZj0pCShkFxTVv4JJgcVxRf/aPwAkBo5UVCixxOR7FzGCNQLQwWWQf49
         CM3lbspTw0Xv8GLjON3qeZjcyenvqqsuRWWfwUb3frhmKKRRAgGJTn0++EDiBuBdFyCP
         hJDSPnuNHnAQpcnEvMzW/oB1tp7NO1spobkkpeeq7zDAJ9wtOjICIj8mS/G+k9iou/2P
         Sn5A==
X-Gm-Message-State: ANoB5pmWf8ZIJeXm6HjI7VkrvAdxjdqdRtSfW3veTjTTQH7xiFmWgXK4
        l5SJCzal5BDPb0Nb3SyIggvdEg==
X-Google-Smtp-Source: AA0mqf4YzrtWT56H/aAnBjsioD0paB87aXAv3INFtEJ/8KIqZpBzt+aOe67OmMq4u++GM5kX+lLZrQ==
X-Received: by 2002:a05:651c:1790:b0:26c:4e3a:516 with SMTP id bn16-20020a05651c179000b0026c4e3a0516mr6025476ljb.510.1668513766208;
        Tue, 15 Nov 2022 04:02:46 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i13-20020ac25d2d000000b004b0b2212315sm2176233lfb.121.2022.11.15.04.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:02:45 -0800 (PST)
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
Subject: [PATCH v2 02/11] ASoC: dt-bindings: qcom,apr: Split services to shared schema
Date:   Tue, 15 Nov 2022 13:02:26 +0100
Message-Id: <20221115120235.167812-3-krzysztof.kozlowski@linaro.org>
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

Changes since v1:
1. Keep compatibles in qcom,apr.yaml

Cc: quic_srivasam@quicinc.com
Cc: quic_plai@quicinc.com
---
 .../bindings/soc/qcom/qcom,apr-services.yaml  | 54 ++++++++++
 .../bindings/soc/qcom/qcom,apr.yaml           | 98 +------------------
 MAINTAINERS                                   |  2 +-
 3 files changed, 58 insertions(+), 96 deletions(-)
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
index 0a7a34cb2497..1fab1d9a2dad 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -80,12 +80,13 @@ properties:
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
+      APR/GPR static port services.
 
     properties:
       compatible:
@@ -97,99 +98,6 @@ patternProperties:
           - qcom,q6apm
           - qcom,q6prm
 
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
-
 required:
   - compatible
   - qcom,domain
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

