Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399ED681526
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbjA3Pdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjA3PdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:33:23 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B933D0BE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:33:18 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ml19so9288380ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY6bmDpZuT/jbui7SIhjmD5i4pAVGcfG2+3UZeBqbNw=;
        b=V7dyGHNrREI0YSx86NW9XvSpOSfhvZLXW3Bs0+9+wKnT9w7WJlCfqYy41mZx4vE155
         8yzuYXsrVRLVRQ8WYh4d8j3AtEilwTjUIUrJ5EXaErco1kXa7OS72D7RDi36tiSdRsSd
         Oa9jBamloRB5NHDu5K5LQGKShmBJu3BMsALH8sE4IBPjg6gH+3YUyuDk5+foqspwKDx3
         1k8BexbFPHrdboSAR0DOhmb4T3+/cV57oiorKoG4ggUI0BeUrfbOx/B4Zfh7W53GnTNc
         cflC6SdeJAJemdDg+3LnnJPe6/kzL/qyzREqibkSwEHfSfulmn1VIGWVZ1lzpTjkhy/d
         pnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oY6bmDpZuT/jbui7SIhjmD5i4pAVGcfG2+3UZeBqbNw=;
        b=QIaOtugTSpN93QeOByUtwJr3ZombQFoxsGTm07y582t2ZUlA3qydlJxA6L/SXN/TDt
         u0SqlGEdvcbbBvnXB3+zjvY+RXQqnzTWWQ2t1cbd3JwDYymyT+qLuO7GN8CFrZeXBXtu
         WftQUGpgG5RdCGrxZHnRr+JwC4LSTIwtfWJpdHSRopFPZior2TIMQ84SkJHBcuI1rLRk
         E79mE7lju7s/kmtqLTt7iJi6S8UhFDalyoH2ApI3mUGnn3UrcZrLLbeSAcgGzW2/K2xe
         6I/ycCwsUQTNv5jWbhq5IYlKv6/M68dcHN6Jkh1O1LWwc8id6M4r2SdChKIP7Bg2Muer
         hOBA==
X-Gm-Message-State: AO0yUKUdZohkFOUOSwxLEZa6DMah+6XZ69dxKqV/X2oFU/+qbLT9omi+
        xgbuX2QOYtwl9IdN8X//WwUWqA==
X-Google-Smtp-Source: AK7set9dE5mkFWGNcpFYBq6Tuy1bnpUikyDCqOkLQCwtDZsFR7klqUr6R8FThshXLxdGj0xLPmID7Q==
X-Received: by 2002:a17:907:7679:b0:887:87e2:5102 with SMTP id kk25-20020a170907767900b0088787e25102mr5311392ejc.13.1675092797992;
        Mon, 30 Jan 2023 07:33:17 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906054700b00878769f1e6bsm6805773eja.55.2023.01.30.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:33:17 -0800 (PST)
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
Subject: [PATCH v3 7/8] dt-bindings: clock: Add Qcom SM6115 GPUCC
Date:   Mon, 30 Jan 2023 16:32:51 +0100
Message-Id: <20230130153252.2310882-8-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130153252.2310882-1-konrad.dybcio@linaro.org>
References: <20230130153252.2310882-1-konrad.dybcio@linaro.org>
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

Add device tree bindings for graphics clock controller for Qualcomm
Technology Inc's SM6115 SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v2 -> v3:

- Mention resets in description:
- Use gcc.yaml

 .../bindings/clock/qcom,sm6115-gpucc.yaml     | 58 +++++++++++++++++++
 include/dt-bindings/clock/qcom,sm6115-gpucc.h | 36 ++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm6115-gpucc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
new file mode 100644
index 000000000000..354ace48301d
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
+additionalProperties: false
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

