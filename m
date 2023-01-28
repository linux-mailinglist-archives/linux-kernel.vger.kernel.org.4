Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3B667F4F9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 06:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjA1Ffg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 00:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjA1Ffd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 00:35:33 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF1C83056
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:35:30 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so6571199pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE9vgJ8RdpcnO9r+b86XorHTfhIOu45f5k1CvwyApiM=;
        b=MCKyMbw4lEcYsAxtGYPOhnuTHJPUuS7wM1LhDShDcz/vMV0R2DunPxSGSY+vsiSAya
         uVHMuCHcKP3oI2wAgvJXpQFWBCpciER6jcddiyDMy+sPLGFZsRmBXyI87axD1WLsxvDF
         IskIru9cOWQMTgDp5QOf9ZkVRJuYTZZl1aNlJFkDrR0GQZunsrZHxOJqNHBA677ugCYn
         LhHam8sbPRbcTogNXV6e0RDfEV6+8+KG/f7J4DIPwNbWhHdjJ5jL093DWNhQ6Ybw+Jp/
         hBbrai4la0bHuDalbRY41CEvVQi1T/j+MKdGevYxZmYI2IFSrv+C02j+BUgPTPMVNqcr
         dwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE9vgJ8RdpcnO9r+b86XorHTfhIOu45f5k1CvwyApiM=;
        b=aeR1k+8xZJzD+W/6UozAemcnpqnWQGxPSledcqdjHMTUipX6K43WRa+5O9OBWSkVez
         ghcer1u5/k+4knY1tiV1Jf1ngYWoBQ5i25cXiuWOtHRDT2EgIBYArQ+vRyHyIZrJVIap
         e5JfOztw1QYHE9wrnGuJqILtAP8SqDjI3OZEwi4XlhFPyEk9eRufG1PKuH7ilMHrN2he
         /W3qbCc6xuBCuBAGNcc4zGD8gZTaUTWD5kcSeAuEOv6osEf8CQPRhVrC2Y9WaNGld31P
         keVuXdAEbkzz2w43dyzZHav1l97b5mOmMSGzyxHf0u1uxmWgRQ+CLxGb6aEdeBjvSUuA
         7jIg==
X-Gm-Message-State: AFqh2kqJkt9OgfuO28spR5jAfdRUGPmLBNC/8yl5SxJWXWz5cSTugySZ
        Pnuw1yUg07osOlEtZPXT4KF93w==
X-Google-Smtp-Source: AMrXdXvmJZgr6nK/MJnHyaDBvPmYtfsEzDGpR2DeIEFqi1UKDFJCc79QZ++Loyt8L9F3hZ1GxEVmyg==
X-Received: by 2002:a05:6a20:c990:b0:a4:aa40:2253 with SMTP id gy16-20020a056a20c99000b000a4aa402253mr36384451pzb.21.1674884129831;
        Fri, 27 Jan 2023 21:35:29 -0800 (PST)
Received: from localhost.localdomain ([223.233.74.24])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902a40f00b00195e77c20a9sm3726841plq.163.2023.01.27.21.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 21:35:29 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     mani@kernel.org, mathieu.poirier@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, bhupesh.sharma@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 2/2] dt-bindings: remoteproc: qcom: Add sm6115 pas yaml file
Date:   Sat, 28 Jan 2023 11:05:04 +0530
Message-Id: <20230128053504.2099620-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230128053504.2099620-1-bhupesh.sharma@linaro.org>
References: <20230128053504.2099620-1-bhupesh.sharma@linaro.org>
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

This documents the aDSP, cDSP and MPSS DSPs present
on the SM6115 SoC.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../bindings/remoteproc/qcom,sm6115-pas.yaml  | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
new file mode 100644
index 000000000000..f5d1fa9f45f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sm6115-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM6115 Peripheral Authentication Service
+
+maintainers:
+  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
+
+description:
+  Qualcomm SM6115 SoC Peripheral Authentication Service loads and boots
+  firmware on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6115-adsp-pas
+      - qcom,sm6115-cdsp-pas
+      - qcom,sm6115-mpss-pas
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
+  memory-region:
+    minItems: 1
+    description: Reference to the reserved-memory for the Hexagon core
+
+  smd-edge: false
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Firmware name for the Hexagon core
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
+            - qcom,sm6115-adsp-pas
+            - qcom,sm6115-cdsp-pas
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
+            - qcom,sm6115-cdsp-pas
+            - qcom,sm6115-mpss-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+        power-domain-names:
+          items:
+            - const: cx
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6115-adsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: LPI CX power domain
+            - description: LPI MX power domain
+        power-domain-names:
+          items:
+            - const: lcx
+            - const: lmx
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    remoteproc@ab00000 {
+        compatible = "qcom,sm6115-adsp-pas";
+        reg = <0x0ab00000 0x100>;
+
+        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+        clock-names = "xo";
+
+        firmware-name = "qcom/sm6115/adsp.mdt";
+
+        interrupts-extended = <&intc GIC_SPI 282 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready",
+                          "handover", "stop-ack";
+
+        memory-region = <&pil_adsp_mem>;
+
+        power-domains = <&rpmpd SM6115_VDD_LPI_CX>,
+                        <&rpmpd SM6115_VDD_LPI_MX>;
+
+        qcom,smem-states = <&adsp_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts = <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>;
+            label = "lpass";
+            qcom,remote-pid = <2>;
+            mboxes = <&apcs_glb 8>;
+
+            /* ... */
+
+        };
+    };
-- 
2.38.1

