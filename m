Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F34067D3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjAZSNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjAZSNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:13:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA625A355
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:13:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u21so2657574edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwu7GIxD7xZjN0XvP9+6NJsNqcMUvGhwmupilA4s3ZQ=;
        b=N+wIuEMYwj32c8Uc2Qea8UbDHNBhImfFs96fuCgkP1HLNQEdtxpPfi7MnXxKO8GpTq
         wMapf2Il83YjJx7C1o9yWayCoSpgGTcxrM8G1efEYp+m/D6qoA1LVwc5d7AQ0D3zC+UK
         ct1UCLqnku/Dg61Zgp02FDggTPRF6b94xWHh9gY1zQRErMjH8EzwXIsL5BqY6GHkqvWd
         AvCQqk2/xHr3jkyHu1+F8KrpVWAxrHOYvwj3ThrxxeQHNbMe0GU4ScO9fPNZzQo3I1Y7
         vYP/+rzFTGm/F0IBgI2EOHfLjhSDFJstYX0kEFG4Icbq8NdHrqnlEVAZxxzPz+DQYbdM
         nTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwu7GIxD7xZjN0XvP9+6NJsNqcMUvGhwmupilA4s3ZQ=;
        b=0CPIrjo05w/iY15j/07Ee0Ad4qCCUSRQP7q9ikpIeLe3B00fRRjMZxbL7+Sg9vEjXd
         TTUG6jDIMB1UwFpsnbVOMn3oPtBQTUDBPyGx2oTJV1i1o6lCQnYnvoNM2tTA3zHZO9FW
         xBJR9lOtxd6gyQ+wKSessr38s6KIRuNGe/agtd1yBLeXLWd3swpVxOgESbaaGgIk0o1u
         lL70ftsIe8Riomib8+IbrAhaZusNcbphn+RU/3Og4Gs7wwN4kgBPIGUwtRFadCbzlI/7
         ahCfkbMzFEWZk8B3a9ux5nm6L6wtmt/Er3RoBItCBtJ86pAUKoEb6KHDkaOh5UeSmLHm
         jILw==
X-Gm-Message-State: AFqh2kpraKXSIf4nm2eArpzhwoLjdvCh61VxuyL7rd85W21wLbKmZT61
        lBPzO9hx50ZE9KRtuhxJuTs8/w==
X-Google-Smtp-Source: AMrXdXsEMIbaMwrQUMl0SmoFRJGzPWPhc+YB69S1VB2LhKyir4OEiC7XTqPUcj2J1fQaLTAWlB9AZw==
X-Received: by 2002:a05:6402:400a:b0:496:bdb5:572f with SMTP id d10-20020a056402400a00b00496bdb5572fmr44047344eda.31.1674756821499;
        Thu, 26 Jan 2023 10:13:41 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id k6-20020aa7d8c6000000b00487fc51c532sm1100416eds.33.2023.01.26.10.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 10:13:41 -0800 (PST)
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
Subject: [PATCH v2 1/6] dt-bindings: clock: Add Qcom SM6125 GPUCC
Date:   Thu, 26 Jan 2023 19:13:30 +0100
Message-Id: <20230126181335.12970-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126181335.12970-1-konrad.dybcio@linaro.org>
References: <20230126181335.12970-1-konrad.dybcio@linaro.org>
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
Technology Inc's SM6125 SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:

No changes
 .../bindings/clock/qcom,sm6125-gpucc.yaml     | 64 +++++++++++++++++++
 include/dt-bindings/clock/qcom,sm6125-gpucc.h | 31 +++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm6125-gpucc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml
new file mode 100644
index 000000000000..374a1844a159
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6125-gpucc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm6125-gpucc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Graphics Clock & Reset Controller on SM6125
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  Qualcomm graphics clock control module provides clocks and power domains on
+  Qualcomm SoCs.
+
+  See also:: include/dt-bindings/clock/qcom,sm6125-gpucc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6125-gpucc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 main branch source
+
+  '#clock-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm6125.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        clock-controller@5990000 {
+            compatible = "qcom,sm6125-gpucc";
+            reg = <0x05990000 0x9000>;
+            clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+                     <&gcc GCC_GPU_GPLL0_CLK_SRC>;
+            #clock-cells = <1>;
+            #power-domain-cells = <1>;
+        };
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm6125-gpucc.h b/include/dt-bindings/clock/qcom,sm6125-gpucc.h
new file mode 100644
index 000000000000..ce5bd920f2c4
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6125-gpucc.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM6125_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM6125_H
+
+/* Clocks */
+#define GPU_CC_PLL0_OUT_AUX2			0
+#define GPU_CC_PLL1_OUT_AUX2			1
+#define GPU_CC_CRC_AHB_CLK			2
+#define GPU_CC_CX_APB_CLK			3
+#define GPU_CC_CX_GFX3D_CLK			4
+#define GPU_CC_CX_GMU_CLK			5
+#define GPU_CC_CX_SNOC_DVM_CLK			6
+#define GPU_CC_CXO_AON_CLK			7
+#define GPU_CC_CXO_CLK				8
+#define GPU_CC_GMU_CLK_SRC			9
+#define GPU_CC_SLEEP_CLK			10
+#define GPU_CC_GX_GFX3D_CLK			11
+#define GPU_CC_GX_GFX3D_CLK_SRC			12
+#define GPU_CC_AHB_CLK				13
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK		14
+
+/* GDSCs */
+#define GPU_CX_GDSC				0
+#define GPU_GX_GDSC				1
+
+#endif
-- 
2.39.1

