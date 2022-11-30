Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3300363D482
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiK3L30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiK3L3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:29:18 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A20EFCE5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:29:17 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id b2so24287233eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP7VV+zroOZCPd6r286+ldZ+A5J9ZPZmJejOEN0UecQ=;
        b=d+mntcv7M0fi4xWK5BS629e4dlsKmdshFAUG1RGVVteZxprJSiWiV+rV0qjSeI4SGv
         v3KPSLqHD9Sc7OhZxxE5gSIVvME0APLlhTtfVvSIOjhVf8X8GilgYC7Cl/1/AOWEIc/a
         NlY+lv2jIsPRAjpCvBYTgkHl7j1pESxvkYs0JVwCdkwJn208QBTz78C8aozO0StUpiXh
         /2I0XRm+hFqtAHAlzesnJV5UDo0x9chlFKop8TJ5Uz7zyt+UQR5D4dRGLMy0g1K6bK4j
         9plG0YYzi1osiLriHOhDxfPOhn6fuapcokJfWcej5ODRFtw4Hz2spPjzym/55Zge34UU
         07MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP7VV+zroOZCPd6r286+ldZ+A5J9ZPZmJejOEN0UecQ=;
        b=VNKBHltRPBXUubWhwDkIxnzyhWyBAMk5AWftXYS8lcmggrRD5zfmvoxXIWS1/eDukH
         yon4Fvs6qt6NkEy5767gnIswWdwYWlYUtaPPoC6PVW/q93euzpX52XRGqlZbEbsB6aTv
         RD06IxseR0fBduXgXkgVTRFeFbKAB4qfXEqbsN0d1m+zhAgff5fPQCCiq/qXWYH0chVB
         M2kbBR3lc6+A3V2J4RHH0vvyJOZ7a0COBum9xrgNExC9cH+mbFcz7sWSBlktAMvtg64K
         3FLKoL6Y/kgkQaYiftmohnvc4nvffe3BpV3Rm4M9VZrpzRFJ+d4Kg3zYDYJzxSNKeVk3
         K9uw==
X-Gm-Message-State: ANoB5pkKb7m91uulR5fbWEKIMtfptNzNoHMkguv+2UR7BKY4vmrDih0E
        3t5QGq4jJbgZq/sK2Z1Mw1x5CQ==
X-Google-Smtp-Source: AA0mqf6j8IetSf2XQuyxlSVj6PjeU2WT7pLKj2GecSfvN9rZNTxZsHVa5WnyqGwHV7M3u/Fe7xGp9Q==
X-Received: by 2002:a17:906:29cc:b0:78d:a836:1d88 with SMTP id y12-20020a17090629cc00b0078da8361d88mr1220733eje.470.1669807755828;
        Wed, 30 Nov 2022 03:29:15 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060a4a00b007c073be0127sm521593ejf.202.2022.11.30.03.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 03:29:15 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/9] dt-bindings: clock: Add SM8550 GCC clocks
Date:   Wed, 30 Nov 2022 13:28:44 +0200
Message-Id: <20221130112852.2977816-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130112852.2977816-1-abel.vesa@linaro.org>
References: <20221130112852.2977816-1-abel.vesa@linaro.org>
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

Add device tree bindings for global clock controller on SM8550 SoCs.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,sm8550-gcc.yaml       |  62 +++++
 include/dt-bindings/clock/qcom,sm8550-gcc.h   | 231 ++++++++++++++++++
 2 files changed, 293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-gcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
new file mode 100644
index 000000000000..0c706de31cf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8550-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on SM8550
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on SM8550
+
+  See also:: include/dt-bindings/clock/qcom,sm8550-gcc.h
+
+properties:
+  compatible:
+    const: qcom,sm8550-gcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+      - description: PCIE 0 Pipe clock source
+      - description: PCIE 1 Pipe clock source
+      - description: PCIE 1 Phy Auxiliary clock source
+      - description: UFS Phy Rx symbol 0 clock source
+      - description: UFS Phy Rx symbol 1 clock source
+      - description: UFS Phy Tx symbol 0 clock source
+      - description: USB3 Phy wrapper pipe clock source
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
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@100000 {
+      compatible = "qcom,sm8550-gcc";
+      reg = <0x00100000 0x001f4200>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>,
+               <&pcie0_phy>,
+               <&pcie1_phy>,
+               <&pcie_1_phy_aux_clk>,
+               <&ufs_mem_phy 0>,
+               <&ufs_mem_phy 1>,
+               <&ufs_mem_phy 2>,
+               <&usb_1_qmpphy>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,sm8550-gcc.h b/include/dt-bindings/clock/qcom,sm8550-gcc.h
new file mode 100644
index 000000000000..3bf6f2b75c99
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8550-gcc.h
@@ -0,0 +1,231 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM8550_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SM8550_H
+
+/* GCC clocks */
+#define GCC_AGGRE_NOC_PCIE_AXI_CLK				0
+#define GCC_AGGRE_UFS_PHY_AXI_CLK				1
+#define GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK			2
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK				3
+#define GCC_AHB2PHY_0_CLK					4
+#define GCC_BOOT_ROM_AHB_CLK					5
+#define GCC_CAMERA_AHB_CLK					6
+#define GCC_CAMERA_HF_AXI_CLK					7
+#define GCC_CAMERA_SF_AXI_CLK					8
+#define GCC_CAMERA_XO_CLK					9
+#define GCC_CFG_NOC_PCIE_ANOC_AHB_CLK				10
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				11
+#define GCC_CNOC_PCIE_SF_AXI_CLK				12
+#define GCC_DDRSS_GPU_AXI_CLK					13
+#define GCC_DDRSS_PCIE_SF_QTB_CLK				14
+#define GCC_DISP_AHB_CLK					15
+#define GCC_DISP_HF_AXI_CLK					16
+#define GCC_DISP_XO_CLK						17
+#define GCC_GP1_CLK						18
+#define GCC_GP1_CLK_SRC						19
+#define GCC_GP2_CLK						20
+#define GCC_GP2_CLK_SRC						21
+#define GCC_GP3_CLK						22
+#define GCC_GP3_CLK_SRC						23
+#define GCC_GPLL0						24
+#define GCC_GPLL0_OUT_EVEN					25
+#define GCC_GPLL4						26
+#define GCC_GPLL7						27
+#define GCC_GPLL9						28
+#define GCC_GPU_CFG_AHB_CLK					29
+#define GCC_GPU_GPLL0_CLK_SRC					30
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				31
+#define GCC_GPU_MEMNOC_GFX_CLK					32
+#define GCC_GPU_SNOC_DVM_GFX_CLK				33
+#define GCC_PCIE_0_AUX_CLK					34
+#define GCC_PCIE_0_AUX_CLK_SRC					35
+#define GCC_PCIE_0_CFG_AHB_CLK					36
+#define GCC_PCIE_0_MSTR_AXI_CLK					37
+#define GCC_PCIE_0_PHY_RCHNG_CLK				38
+#define GCC_PCIE_0_PHY_RCHNG_CLK_SRC				39
+#define GCC_PCIE_0_PIPE_CLK					40
+#define GCC_PCIE_0_PIPE_CLK_SRC					41
+#define GCC_PCIE_0_SLV_AXI_CLK					42
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				43
+#define GCC_PCIE_1_AUX_CLK					44
+#define GCC_PCIE_1_AUX_CLK_SRC					45
+#define GCC_PCIE_1_CFG_AHB_CLK					46
+#define GCC_PCIE_1_MSTR_AXI_CLK					47
+#define GCC_PCIE_1_PHY_AUX_CLK					48
+#define GCC_PCIE_1_PHY_AUX_CLK_SRC				49
+#define GCC_PCIE_1_PHY_RCHNG_CLK				50
+#define GCC_PCIE_1_PHY_RCHNG_CLK_SRC				51
+#define GCC_PCIE_1_PIPE_CLK					52
+#define GCC_PCIE_1_PIPE_CLK_SRC					53
+#define GCC_PCIE_1_SLV_AXI_CLK					54
+#define GCC_PCIE_1_SLV_Q2A_AXI_CLK				55
+#define GCC_PDM2_CLK						56
+#define GCC_PDM2_CLK_SRC					57
+#define GCC_PDM_AHB_CLK						58
+#define GCC_PDM_XO4_CLK						59
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				60
+#define GCC_QMIP_CAMERA_RT_AHB_CLK				61
+#define GCC_QMIP_DISP_AHB_CLK					62
+#define GCC_QMIP_GPU_AHB_CLK					63
+#define GCC_QMIP_PCIE_AHB_CLK					64
+#define GCC_QMIP_VIDEO_CV_CPU_AHB_CLK				65
+#define GCC_QMIP_VIDEO_CVP_AHB_CLK				66
+#define GCC_QMIP_VIDEO_V_CPU_AHB_CLK				67
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				68
+#define GCC_QUPV3_I2C_CORE_CLK					69
+#define GCC_QUPV3_I2C_S0_CLK					70
+#define GCC_QUPV3_I2C_S0_CLK_SRC				71
+#define GCC_QUPV3_I2C_S1_CLK					72
+#define GCC_QUPV3_I2C_S1_CLK_SRC				73
+#define GCC_QUPV3_I2C_S2_CLK					74
+#define GCC_QUPV3_I2C_S2_CLK_SRC				75
+#define GCC_QUPV3_I2C_S3_CLK					76
+#define GCC_QUPV3_I2C_S3_CLK_SRC				77
+#define GCC_QUPV3_I2C_S4_CLK					78
+#define GCC_QUPV3_I2C_S4_CLK_SRC				79
+#define GCC_QUPV3_I2C_S5_CLK					80
+#define GCC_QUPV3_I2C_S5_CLK_SRC				81
+#define GCC_QUPV3_I2C_S6_CLK					82
+#define GCC_QUPV3_I2C_S6_CLK_SRC				83
+#define GCC_QUPV3_I2C_S7_CLK					84
+#define GCC_QUPV3_I2C_S7_CLK_SRC				85
+#define GCC_QUPV3_I2C_S8_CLK					86
+#define GCC_QUPV3_I2C_S8_CLK_SRC				87
+#define GCC_QUPV3_I2C_S9_CLK					88
+#define GCC_QUPV3_I2C_S9_CLK_SRC				89
+#define GCC_QUPV3_I2C_S_AHB_CLK					90
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK				91
+#define GCC_QUPV3_WRAP1_CORE_CLK				92
+#define GCC_QUPV3_WRAP1_S0_CLK					93
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC				94
+#define GCC_QUPV3_WRAP1_S1_CLK					95
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC				96
+#define GCC_QUPV3_WRAP1_S2_CLK					97
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC				98
+#define GCC_QUPV3_WRAP1_S3_CLK					99
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC				100
+#define GCC_QUPV3_WRAP1_S4_CLK					101
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC				102
+#define GCC_QUPV3_WRAP1_S5_CLK					103
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC				104
+#define GCC_QUPV3_WRAP1_S6_CLK					105
+#define GCC_QUPV3_WRAP1_S6_CLK_SRC				106
+#define GCC_QUPV3_WRAP1_S7_CLK					107
+#define GCC_QUPV3_WRAP1_S7_CLK_SRC				108
+#define GCC_QUPV3_WRAP2_CORE_2X_CLK				109
+#define GCC_QUPV3_WRAP2_CORE_CLK				110
+#define GCC_QUPV3_WRAP2_S0_CLK					111
+#define GCC_QUPV3_WRAP2_S0_CLK_SRC				112
+#define GCC_QUPV3_WRAP2_S1_CLK					113
+#define GCC_QUPV3_WRAP2_S1_CLK_SRC				114
+#define GCC_QUPV3_WRAP2_S2_CLK					115
+#define GCC_QUPV3_WRAP2_S2_CLK_SRC				116
+#define GCC_QUPV3_WRAP2_S3_CLK					117
+#define GCC_QUPV3_WRAP2_S3_CLK_SRC				118
+#define GCC_QUPV3_WRAP2_S4_CLK					119
+#define GCC_QUPV3_WRAP2_S4_CLK_SRC				120
+#define GCC_QUPV3_WRAP2_S5_CLK					121
+#define GCC_QUPV3_WRAP2_S5_CLK_SRC				122
+#define GCC_QUPV3_WRAP2_S6_CLK					123
+#define GCC_QUPV3_WRAP2_S6_CLK_SRC				124
+#define GCC_QUPV3_WRAP2_S7_CLK					125
+#define GCC_QUPV3_WRAP2_S7_CLK_SRC				126
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK				127
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK				128
+#define GCC_QUPV3_WRAP_2_M_AHB_CLK				129
+#define GCC_QUPV3_WRAP_2_S_AHB_CLK				130
+#define GCC_SDCC2_AHB_CLK					131
+#define GCC_SDCC2_APPS_CLK					132
+#define GCC_SDCC2_APPS_CLK_SRC					133
+#define GCC_SDCC4_AHB_CLK					134
+#define GCC_SDCC4_APPS_CLK					135
+#define GCC_SDCC4_APPS_CLK_SRC					136
+#define GCC_UFS_PHY_AHB_CLK					137
+#define GCC_UFS_PHY_AXI_CLK					138
+#define GCC_UFS_PHY_AXI_CLK_SRC					139
+#define GCC_UFS_PHY_AXI_HW_CTL_CLK				140
+#define GCC_UFS_PHY_ICE_CORE_CLK				141
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				142
+#define GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK				143
+#define GCC_UFS_PHY_PHY_AUX_CLK					144
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				145
+#define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK				146
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				147
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK_SRC				148
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				149
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK_SRC				150
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				151
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK_SRC				152
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				153
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				154
+#define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK			155
+#define GCC_USB30_PRIM_MASTER_CLK				156
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				157
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				158
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			159
+#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC		160
+#define GCC_USB30_PRIM_SLEEP_CLK				161
+#define GCC_USB3_PRIM_PHY_AUX_CLK				162
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				163
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				164
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				165
+#define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC				166
+#define GCC_VIDEO_AHB_CLK					167
+#define GCC_VIDEO_AXI0_CLK					168
+#define GCC_VIDEO_AXI1_CLK					169
+#define GCC_VIDEO_XO_CLK					170
+
+/* GCC resets */
+#define GCC_CAMERA_BCR						0
+#define GCC_DISPLAY_BCR						1
+#define GCC_GPU_BCR						2
+#define GCC_PCIE_0_BCR						3
+#define GCC_PCIE_0_LINK_DOWN_BCR				4
+#define GCC_PCIE_0_NOCSR_COM_PHY_BCR				5
+#define GCC_PCIE_0_PHY_BCR					6
+#define GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR			7
+#define GCC_PCIE_1_BCR						8
+#define GCC_PCIE_1_LINK_DOWN_BCR				9
+#define GCC_PCIE_1_NOCSR_COM_PHY_BCR				10
+#define GCC_PCIE_1_PHY_BCR					11
+#define GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR			12
+#define GCC_PCIE_PHY_BCR					13
+#define GCC_PCIE_PHY_CFG_AHB_BCR				14
+#define GCC_PCIE_PHY_COM_BCR					15
+#define GCC_PDM_BCR						16
+#define GCC_QUPV3_WRAPPER_1_BCR					17
+#define GCC_QUPV3_WRAPPER_2_BCR					18
+#define GCC_QUPV3_WRAPPER_I2C_BCR				19
+#define GCC_QUSB2PHY_PRIM_BCR					20
+#define GCC_QUSB2PHY_SEC_BCR					21
+#define GCC_SDCC2_BCR						22
+#define GCC_SDCC4_BCR						23
+#define GCC_UFS_PHY_BCR						24
+#define GCC_USB30_PRIM_BCR					25
+#define GCC_USB3_DP_PHY_PRIM_BCR				26
+#define GCC_USB3_DP_PHY_SEC_BCR					27
+#define GCC_USB3_PHY_PRIM_BCR					28
+#define GCC_USB3_PHY_SEC_BCR					29
+#define GCC_USB3PHY_PHY_PRIM_BCR				30
+#define GCC_USB3PHY_PHY_SEC_BCR					31
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				32
+#define GCC_VIDEO_AXI0_CLK_ARES					33
+#define GCC_VIDEO_AXI1_CLK_ARES					34
+#define GCC_VIDEO_BCR						35
+
+/* GCC power domains */
+#define PCIE_0_GDSC						0
+#define PCIE_0_PHY_GDSC						1
+#define PCIE_1_GDSC						2
+#define PCIE_1_PHY_GDSC						3
+#define UFS_PHY_GDSC						4
+#define UFS_MEM_PHY_GDSC					5
+#define USB30_PRIM_GDSC						6
+#define USB3_PHY_GDSC						7
+
+#endif
-- 
2.34.1

