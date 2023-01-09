Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FFB6627D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjAIN5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbjAIN4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:56:55 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5502BC7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:56:53 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g13so13072518lfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 05:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtRHADvv4anssYS+846iuuGfMjeI+w9hq/ijC5zrofw=;
        b=WqL6AtiLfyUJGsXEppqg/3kDZ4w4mbT0rOXsF17gBI/mhAh+xw8hrpjkVggQPhDsCV
         T9Mlycd5fJ1mybRDaK2theN0czfSAvKSxUgx9gWQp5zYFiMYqOgsC+yFnvXPORcanvH/
         MlNe+2OoAWnBnHZJUQRk2bjWs5aYvTBl3FqYSvBeneecFNNP5OsjwI0F6bY4ckIi4f/B
         Wsa1fX06aLSKkZ4kbM0sxVH9Z2CJz06uY1cH7t1xUSSTGh9gV4OhEhKto/8m/2QhyBEc
         qe2EtZyUQC/p57Xyrdealzvjzw5zONdk586yNihvzRi6Lu53mRsLf4lTZbVCIU4vxyyu
         zpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtRHADvv4anssYS+846iuuGfMjeI+w9hq/ijC5zrofw=;
        b=TYpM+jQtqMbn0TmyulpJVs8Mym6UMkzlT/bHjH33MrHpPAXh7pUFY/in1E44kTQib1
         DCHeQ0WOk6m740pj2tjPT1HH0N3mri1AmkHPsKthtUCoRoKaBkUXE58s//zJCgHTIndd
         2ykzGp2NGZb5A54E3Ggt0Mw+GU87f2FcpiPZ0BAPfYq4vb+D0u0qHWYAPKJmDUpujQI9
         WQJHQR+fJtcb6GUtdZGbX27E+P0MyNnK2t4b5fgVRvMpaNLO3XEzDpswm2Iy/FknBosf
         YD3GEHmdFojL/dTOSvblfRp3LRQKAzxkjwsdcmBd0mG25qtcgfoMOo1Yybnsi2ri8BwE
         1/1w==
X-Gm-Message-State: AFqh2kpiQcuYOjRbAHuc6d/HEWWjy+CNr6jhJgCeRIrcjhk18LGrzaQt
        KpK56FUc/SFiyyr9by23aKAoTw==
X-Google-Smtp-Source: AMrXdXttJHE0iG9e7/ObKTMZrDXIQploREc8fiolCCeZWtCVHUy25KAKs4KPKbvkrRIfYRj5wXhcTA==
X-Received: by 2002:ac2:5503:0:b0:4b5:9845:c8a9 with SMTP id j3-20020ac25503000000b004b59845c8a9mr17428962lfk.47.1673272611912;
        Mon, 09 Jan 2023 05:56:51 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x16-20020a056512079000b004c89b9fb1fdsm1638226lfr.68.2023.01.09.05.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 05:56:51 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: remoteproc: qcom,sm6375-pas: Document remoteprocs
Date:   Mon,  9 Jan 2023 14:56:44 +0100
Message-Id: <20230109135647.339224-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109135647.339224-1-konrad.dybcio@linaro.org>
References: <20230109135647.339224-1-konrad.dybcio@linaro.org>
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

SM6375 hosts an ADSP, CDSP and modem as remote processors. Create
related bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v2 -> v3:
- Separate out 6375 bindings

 .../bindings/remoteproc/qcom,sm6375-pas.yaml  | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
new file mode 100644
index 000000000000..60ee3fc7ab5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sm6375-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM6375 Peripheral Authentication Service
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM6375 SoC Peripheral Authentication Service loads and boots
+  firmware on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6375-adsp-pas
+      - qcom,sm6375-cdsp-pas
+      - qcom,sm6375-mpss-pas
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XO clock
+
+  clock-names:
+    items:
+      - const: xo
+
+  smd-edge: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6375-adsp-pas
+            - qcom,sm6375-cdsp-pas
+    then:
+      properties:
+        interrupts:
+          maxItems: 5
+        interrupt-names:
+          maxItems: 5
+    else:
+      properties:
+        interrupts:
+          minItems: 6
+        interrupt-names:
+          minItems: 6
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6375-adsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: LCX power domain
+            - description: LMX power domain
+        power-domain-names:
+          items:
+            - const: lcx
+            - const: lmx
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6375-cdsp-pas
+            - qcom,sm6375-mpss-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+        power-domain-names:
+          items:
+            - const: cx
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    remoteproc_adsp: remoteproc@a400000 {
+        compatible = "qcom,sm6375-adsp-pas";
+        reg = <0x0a400000 0x100>;
+
+        interrupts-extended = <&intc GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+                              <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready",
+                          "handover", "stop-ack";
+
+        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+        clock-names = "xo";
+
+        power-domains = <&rpmpd SM6375_VDD_LPI_CX>,
+                        <&rpmpd SM6375_VDD_LPI_MX>;
+        power-domain-names = "lcx", "lmx";
+
+        memory-region = <&pil_adsp_mem>;
+
+        qcom,smem-states = <&smp2p_adsp_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+                                         IPCC_MPROC_SIGNAL_GLINK_QMP
+                                         IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_CLIENT_LPASS
+                            IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+            label = "lpass";
+            qcom,remote-pid = <2>;
+
+            /* ... */
+        };
+    };
-- 
2.39.0

