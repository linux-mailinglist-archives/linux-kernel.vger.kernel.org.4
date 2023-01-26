Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCEB67D3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjAZSNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjAZSNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:13:47 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652D85A355
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:13:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u21so2657760edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW3sC3ktDpdZxd0icwPexqyi6yhFwBIKGDsOHiNFRKo=;
        b=yz3O3ypV2TVaUHW5VBMM7xDR7DdZE8dHjVeQ5ob+7UhLWnQZZAw5QFTIxZvFjctOhs
         OasGcBDndNOUlnr3C2BTSGesNvTNei0dXzKlDZNKXhKjzegu1qOVA3K7NCMYYYyRTZSJ
         gH9ZOMtSMOfz5Xtumf824rzFbe9/bv9HAU7JrUkcYhT7W0B+xXJAnCoB1mPK+H3oPMI+
         mTOHuQYvn2VerRH8wInqlm6h7ZtFKv4UdL1lsOaBqdMuOUv3OEiNdMzykRJ5mjQQ3t4o
         rS5K8HF17GAVCz6Oz3jD768JkA10pFalntnuPo+tRtYCFjpITN9NTODCjLiBlt3zs2CH
         co6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dW3sC3ktDpdZxd0icwPexqyi6yhFwBIKGDsOHiNFRKo=;
        b=ntaOqkvtE3Xk2KT3z2GisAVXb72VUakT7mZKY6Gsgn2WJnNtwiMMEwjxgXoDShv5AI
         oy0KrCBh7U8aev2Wp1ZbSX2wXOlvG44BRtyWdKCf7KMFBavmzCFkQzMckJH9T40LsYCb
         nw1BmbuRHYW4VWmzXf9/R2Ik/cl6ncHm6Mw3q/WetH+f069d4kx76nHMxJvZX13G01ZZ
         arajiDaRzuhJYKKhMXHU67qS8j09MJBhE8LuX7DYRshpLlNPk29KYxrrq4i3LP3Q6UsZ
         VUV/5Yp9lPGqsT++7zA/A3zboQaieDGsY5HdpgWoAXVyVufjD4k4uSzLapuD6iiTs9fr
         T/xQ==
X-Gm-Message-State: AFqh2kqKISuDL1QIjBLuwd9xC7JjC19suHYWRvKCGj0OCCQBiUY9PWLL
        WgzMCqkuPfUL9bhEAw0hC6NVkg==
X-Google-Smtp-Source: AMrXdXsxw2tOad0R4RGEE1aVfIzjU2DsTarFDs9uMXTGTUwd4VhmYWeFFnMb8nW6gPs1BxwvLqs2mA==
X-Received: by 2002:a05:6402:1002:b0:49b:63ea:b5d8 with SMTP id c2-20020a056402100200b0049b63eab5d8mr38863609edu.4.1674756826042;
        Thu, 26 Jan 2023 10:13:46 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id k6-20020aa7d8c6000000b00487fc51c532sm1100416eds.33.2023.01.26.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 10:13:45 -0800 (PST)
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
Subject: [PATCH v2 3/6] dt-bindings: clock: Add Qcom SM6375 GPUCC
Date:   Thu, 26 Jan 2023 19:13:32 +0100
Message-Id: <20230126181335.12970-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126181335.12970-1-konrad.dybcio@linaro.org>
References: <20230126181335.12970-1-konrad.dybcio@linaro.org>
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
Technology Inc's SM6375 SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:

No changes

 .../bindings/clock/qcom,sm6375-gpucc.yaml     | 60 +++++++++++++++++++
 include/dt-bindings/clock/qcom,sm6375-gpucc.h | 36 +++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm6375-gpucc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
new file mode 100644
index 000000000000..b480ead5bd69
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm6375-gpucc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Graphics Clock & Reset Controller on SM6375
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  Qualcomm graphics clock control module provides clocks, resets and power
+  domains on Qualcomm SoCs.
+
+  See also:: include/dt-bindings/clock/qcom,sm6375-gpucc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6375-gpucc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 main branch source
+      - description: GPLL0 div branch source
+      - description: SNoC DVM GFX source
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
+    #include <dt-bindings/clock/qcom,sm6375-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@5990000 {
+            compatible = "qcom,sm6375-gpucc";
+            reg = <0 0x05990000 0 0x9000>;
+            clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+                     <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+                     <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>,
+                     <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+            #power-domain-cells = <1>;
+        };
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm6375-gpucc.h b/include/dt-bindings/clock/qcom,sm6375-gpucc.h
new file mode 100644
index 000000000000..0887ac03825e
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6375-gpucc.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_BLAIR_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_BLAIR_H
+
+/* GPU CC clocks */
+#define GPU_CC_PLL0					0
+#define GPU_CC_PLL1					1
+#define GPU_CC_AHB_CLK					2
+#define GPU_CC_CX_GFX3D_CLK				3
+#define GPU_CC_CX_GFX3D_SLV_CLK				4
+#define GPU_CC_CX_GMU_CLK				5
+#define GPU_CC_CX_SNOC_DVM_CLK				6
+#define GPU_CC_CXO_AON_CLK				7
+#define GPU_CC_CXO_CLK					8
+#define GPU_CC_GMU_CLK_SRC				9
+#define GPU_CC_GX_CXO_CLK				10
+#define GPU_CC_GX_GFX3D_CLK				11
+#define GPU_CC_GX_GFX3D_CLK_SRC				12
+#define GPU_CC_GX_GMU_CLK				13
+#define GPU_CC_SLEEP_CLK				14
+
+/* GDSCs */
+#define GPU_CX_GDSC					0
+#define GPU_GX_GDSC					1
+
+/* Resets */
+#define GPU_GX_BCR					0
+#define GPU_ACD_BCR					1
+#define GPU_GX_ACD_MISC_BCR				2
+
+#endif
-- 
2.39.1

