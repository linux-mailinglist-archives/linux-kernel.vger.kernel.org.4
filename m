Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C757681524
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbjA3Pd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbjA3PdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:33:18 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C416125B2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:33:15 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id fi26so11305625edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdSQX0LrRXfachZslkET6uKTOBzCfMVLGTzHGzhhVmc=;
        b=JF0RItLRERfz/B4QO4rPZCOswCyZB5vZfqhBgpvFhSIETowsN9oqoE9rDJHC66gkIe
         CcYWRPuRJN1YjOmKgmLxU5c/aeeZf5VOrfBEjy7AbKyGjq0jf3UumLaNyAkYnZsKwAdl
         4PTbtwCI0q6QCKtCyi/qEKZL0N9nxppjIRQ2APAS0/PsUrg3Fb7KRIhW4qaK7o47jNFH
         VPE8b5Lxt7geW21E/UBFFC2szTe6/pi2m43k6Vc8tSQi9Hs8tBplGrtRVhb7LKweh/Q+
         k6UgCszQ1Khne63VKUXrOIMEdy7dkuemFk+eY6R6qaIyCpiH7rt5mknG/MZfP9SDqFPR
         ptJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdSQX0LrRXfachZslkET6uKTOBzCfMVLGTzHGzhhVmc=;
        b=IfDgbtL3JR0xqBnDzkrGqa6o2ev8CBNp/k3HAAqTFtYMAREU1ipA62oLOSh8jHNaxX
         vCN25werp8IfBjIer34EPZ1+qofh84z7Jmd89wMhf1jVx7ijvhaQhZaMi5IrFRPenlyN
         mlXONJwXXZVJnmmm6R5pPu3wcORTOx2erl6G5GIjDdoCMPEuiik5NbJhlp1PEUZ5D68y
         59D60sNRXj4Ny68jRnziYsfsf+w9KdjeLitHwf2Y3Eu4RK4NZVVQlAwRg4hw+VPee9wn
         uA6zUEr3zCvxd3m9p6la/OmZYSUyPTSWGf4zhljEwTWW3ZuIkXKGAF9mL9pCgtQyY/LW
         UoMg==
X-Gm-Message-State: AO0yUKX98Ok6nYkPARafCIcvMJBYdJntlRrhVEwHa5an63buiZ1MNdj8
        tVe9Hks9l2xnFTeSn2XU9TEfPQ==
X-Google-Smtp-Source: AK7set8Jyg0c60bllVPLinHOox3GzWrr0Zs4oW4Bkn/a4qCZEWFmaQK3pvbaBM8g1Nwtqf2wPEPzag==
X-Received: by 2002:a05:6402:3553:b0:4a2:49c0:abc0 with SMTP id f19-20020a056402355300b004a249c0abc0mr4122741edd.29.1675092793667;
        Mon, 30 Jan 2023 07:33:13 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906054700b00878769f1e6bsm6805773eja.55.2023.01.30.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:33:13 -0800 (PST)
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
Subject: [PATCH v3 5/8] dt-bindings: clock: Add Qcom SM6375 GPUCC
Date:   Mon, 30 Jan 2023 16:32:49 +0100
Message-Id: <20230130153252.2310882-6-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130153252.2310882-1-konrad.dybcio@linaro.org>
References: <20230130153252.2310882-1-konrad.dybcio@linaro.org>
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
Technology Inc's SM6375 SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v2 -> v3:

- Pick up tags

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

