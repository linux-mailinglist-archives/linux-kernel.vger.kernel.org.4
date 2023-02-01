Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6482B686E36
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjBAShs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjBAShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:37:25 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CEB80179
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:36:51 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z11so18670167ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA67TLxXEvH5vo53lgHeUwnhZhAWkiUA2se0bT0//1c=;
        b=wV8KuSEVvssP/fEzU3F7EhtJaUre6atA3VUbaqj96igtqmgWhsXowwklDYU/JzZw/x
         Tle3hGCuT+2uXdCPv2Yy/l9yROotXYEDG93aiJJp08ujvyg8Sk7vQk64OQswdLdIbGTg
         sYPurJNYYp1BIdZMjfaF4dbYKjIipcILLraMpHaF7G/o+4KjGwuU7OExwOxTnmhuObmG
         KGTFKmFGQvNPrRuI6dnEIWIgBfFs/yosCIq0KCgwkRFI/jMbz72Eivq4bj/J4QALPyty
         P0POLMzEV4A1086bzcQazRIA8s+2dFRUr73xoXY3Wb2e62J08rSG/0OUCrKvb1wAeLyN
         L0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA67TLxXEvH5vo53lgHeUwnhZhAWkiUA2se0bT0//1c=;
        b=BMxiAlyYeMIjyFT72mjLKwvltABgiUIAw7n7Lo43L951wcEj3GTdxWelvpkxpEwF6p
         v3J49t/3RAorrdX1ZKoEySB+MCGtXEc/jedaDIEgxtj6EXkh5/jPTEL/Xi50hlABzWjF
         bF2YKp506eyhnTVqWKb/7atMk+Zjbt6qqzc+xtYOAJgjifZqH9xdTZ5vXSoBDdxje6M1
         JTbH09VnZCVy7k7J5W9i/hjl9t6n2c0sW6RYkf7ZJGyE3HRkUqUXLLi5L9m3uwMmcQK/
         faPCdcx02lKLTzgFPMKR7rDQfL5OsERj5eppxzo1TmftFcG5Rned6ftlkjMgPUvozAyR
         fqTQ==
X-Gm-Message-State: AO0yUKWuIqhAY+1xyBuozLiK2UZ5YN57idUYpv1j2rkiIK57hja4Q0WK
        hHUwkp07nxhJsWNP5zULd1KFeQ==
X-Google-Smtp-Source: AK7set9BY+ASrlAVSPZqiT5NTlGfv3MX2UUK3N2NJ13b0LlPA+1zmyRTQcy7OrkidnR7I6Jxcj9SrQ==
X-Received: by 2002:a05:6402:500c:b0:49e:6bf1:5399 with SMTP id p12-20020a056402500c00b0049e6bf15399mr3378241eda.8.1675276609259;
        Wed, 01 Feb 2023 10:36:49 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id t13-20020a50d70d000000b00458b41d9460sm10297508edi.92.2023.02.01.10.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:36:48 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/10] dt-bindings: clock: Add Qcom SM6115 GPUCC
Date:   Wed,  1 Feb 2023 19:36:25 +0100
Message-Id: <20230201183626.351211-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201183626.351211-1-konrad.dybcio@linaro.org>
References: <20230201183626.351211-1-konrad.dybcio@linaro.org>
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

Add device tree bindings for graphics clock controller for Qualcomm
Technology Inc's SM6115 SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v4 -> v5:

- pick up rb

 .../bindings/clock/qcom,sm6115-gpucc.yaml     | 58 +++++++++++++++++++
 include/dt-bindings/clock/qcom,sm6115-gpucc.h | 36 ++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm6115-gpucc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
new file mode 100644
index 000000000000..cf19f44af774
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm6115-gpucc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Graphics Clock & Reset Controller on SM6115
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  Qualcomm graphics clock control module provides clocks, resets and power
+  domains on Qualcomm SoCs.
+
+  See also:: include/dt-bindings/clock/qcom,sm6115-gpucc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6115-gpucc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 main branch source
+      - description: GPLL0 main div source
+
+required:
+  - compatible
+  - clocks
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm6115.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        clock-controller@5990000 {
+            compatible = "qcom,sm6115-gpucc";
+            reg = <0x05990000 0x9000>;
+            clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+                     <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+                     <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+            #power-domain-cells = <1>;
+        };
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm6115-gpucc.h b/include/dt-bindings/clock/qcom,sm6115-gpucc.h
new file mode 100644
index 000000000000..945f21a7d745
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6115-gpucc.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM6115_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM6115_H
+
+/* GPU_CC clocks */
+#define GPU_CC_PLL0			0
+#define GPU_CC_PLL0_OUT_AUX2		1
+#define GPU_CC_PLL1			2
+#define GPU_CC_PLL1_OUT_AUX		3
+#define GPU_CC_AHB_CLK			4
+#define GPU_CC_CRC_AHB_CLK		5
+#define GPU_CC_CX_GFX3D_CLK		6
+#define GPU_CC_CX_GMU_CLK		7
+#define GPU_CC_CX_SNOC_DVM_CLK		8
+#define GPU_CC_CXO_AON_CLK		9
+#define GPU_CC_CXO_CLK			10
+#define GPU_CC_GMU_CLK_SRC		11
+#define GPU_CC_GX_CXO_CLK		12
+#define GPU_CC_GX_GFX3D_CLK		13
+#define GPU_CC_GX_GFX3D_CLK_SRC		14
+#define GPU_CC_SLEEP_CLK		15
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK	16
+
+/* Resets */
+#define GPU_GX_BCR			0
+
+/* GDSCs */
+#define GPU_CX_GDSC			0
+#define GPU_GX_GDSC			1
+
+#endif
-- 
2.39.1

