Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497B468EAEA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjBHJQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjBHJPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:15:44 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790AF28D03
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:14:16 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v10so19499920edi.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TSevxjsz2ebd1zWwL/57FQ6G+Y5T9w1deof387AznE=;
        b=wIBvRatTa1AjHagD3WanDODAoyIZRm2QVRy0IeXjJNuJ1a3z0sIiCByM6W2Aruj/7H
         YgK8QLti213KOu/+gwPXAzHy1njSrG28dsxsy1MBQT6j9NhRvZ/m8LmW4FaZz3hSaH1/
         EdFVbc0zWwN5xTDBJ1NWSWihTH774vpcHOBZdOPDWYa+yBxf3cENnbjajiA6W70xuhJk
         sBTw3zu3SvxiBTRDLrst7aBK1MYe7SOxmWYNQcZOQ/2EwEnPf/0975OhtwSW0oAkeSXc
         2OvYiywMHjdYsQAYsKXVDM0WUAzNmREXmjaQ/CHQbD+rL8d0IgY2zA1NOcplWKcu7aQ7
         saVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TSevxjsz2ebd1zWwL/57FQ6G+Y5T9w1deof387AznE=;
        b=VyVT89vubY6L4pD3wVnStk32nYse2XncI4l+Nq6Nn4S4Y6+cuOo/ho3fSQby5GKAi9
         XyoMDsRCTFdSbtx3oqAsanoT+1t7qcnSHvutyt08uaBH1UBjRdEifZQiso1y8Pcqo7XA
         25v7VWDx9P0mvvaijfEWITz2yk2aA8pSVieAvCOMvnAmJ3eQi2z2a5oTCd5HSvrFZyyP
         F5Vko84wROyEBHuXKLESu1Jodl4rAA+U3sqFrFsftMMEJqN+D2E6fGp6VnQRM9DqFNKL
         35hrXWOAbG3gxSVNCGd6HzoGWmcRJt0adJLstpjDtnKvoIwtE2hQ1D1ZCSyzf/3uspfi
         3jHA==
X-Gm-Message-State: AO0yUKV3GCyFkGnMklLodQ2C+kEsq8mt5H2tAxrY59BnZNj4vg6kmxiN
        aSzqdxG42pCt8VW/dpg7gOkPPw==
X-Google-Smtp-Source: AK7set8WmgWDJvVE3rzfmYwjSOHF4Hojqyq6ZQ6rqv/JJv6k6QTlvj5xsewfJjE5D9oRAqmoXCK6+A==
X-Received: by 2002:a50:c35e:0:b0:4ab:1594:8581 with SMTP id q30-20020a50c35e000000b004ab15948581mr367618edb.35.1675847641772;
        Wed, 08 Feb 2023 01:14:01 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709064e0200b00887a23bab85sm7987279eju.220.2023.02.08.01.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 01:14:01 -0800 (PST)
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
Subject: [PATCH v6 09/10] dt-bindings: clock: Add Qcom SM6115 GPUCC
Date:   Wed,  8 Feb 2023 10:13:39 +0100
Message-Id: <20230208091340.124641-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208091340.124641-1-konrad.dybcio@linaro.org>
References: <20230208091340.124641-1-konrad.dybcio@linaro.org>
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

