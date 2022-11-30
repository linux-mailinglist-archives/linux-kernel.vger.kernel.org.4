Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF10F63D686
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiK3NVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiK3NVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:21:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBCD6E55F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:21:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id fy37so41211335ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGbo4uHDKW9IQ68baJL+HwWuZH9Ha1GhHV4rpG2y+9E=;
        b=WQvG1sLEEXEYzUC6UvXwmgf9ntCxGi5GPlTzL+IRUAY19KZUR9KbkRdYyh5b/OJjXK
         lzhYzMBuVIUaMmJVEi5WD2EW0yLvg1bKySZQj4UUW022vOwWLlwtu9MwU81Osw7LqCsT
         Dmhtp8gTOuyENKt2CBUCxWbYpVF/CyU9BtDoAJEfrrn6uTv0j2sOoTZGeV8tzLKkQosy
         07KyJd9IQ+7Pgrb2Db/5JFWIlq6vRS/LnV7ha8UGGX6svLUF/nm11Dg6F70RNRd5+oD9
         3umTEZ2FVi/LHvtAZ4LxPTXvZCsCktuZlKbPwDWhkCoB6YN3rdabQGj1ZEc4I3K51Beu
         nPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGbo4uHDKW9IQ68baJL+HwWuZH9Ha1GhHV4rpG2y+9E=;
        b=47tWcD2SAr7w3wlyjwTebW5XDCskU29AAXGsU2AimcSxF3w8bt3niYU1MSnwr8RN4n
         riKWFw/L8hKMMQHQ2oBNkd6CCQ2c7i7mfrg7spS1uKF7jtYNVN0vYrFm7dFsX1pqYE/m
         WwwGdGdTHgxkZUO3ZU+5fUq7pRiBjhjHqwF1KklRAcVGhjsCknSbPZljEKvYXNCfO4bA
         dFN/G1fBceRTO+zAsgLCAyqbTZKVTms0YQSedPKz/Lyi+lXg6Q7ha5bNQzdJ2oUexmnu
         F0wQxa7oBum41mDqI1ts6ujjQjIfcj31Pszi4AXj5PaHKtshyvD4hqrB8vkneGiYizWg
         ekiw==
X-Gm-Message-State: ANoB5pnWvP/Ge+KqKHLkAeOJ02CnRnjQ0JsROFs/U+AtspApjLj2dOsb
        +ycE90/c/2sdJNpI7T68zdPaSw==
X-Google-Smtp-Source: AA0mqf43GQZrO32gzUbHrfQGD/0882Lvu2AdOmcCHa66WNf/1KM/bc5+7BoaYzh5aiO/AeZ3vm4oJg==
X-Received: by 2002:a17:906:3096:b0:7ae:eae9:25a5 with SMTP id 22-20020a170906309600b007aeeae925a5mr51931955ejv.394.1669814464381;
        Wed, 30 Nov 2022 05:21:04 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y20-20020a056402135400b0046856c307d0sm650800edw.5.2022.11.30.05.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:21:03 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: interconnect: Add Qualcomm SM8550
Date:   Wed, 30 Nov 2022 15:20:58 +0200
Message-Id: <20221130132059.3145243-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130132059.3145243-1-abel.vesa@linaro.org>
References: <20221130132059.3145243-1-abel.vesa@linaro.org>
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

The Qualcomm SM8550 SoC has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v3:
 * Dropped qcom,sm8550-rpmh.h and qcom,rpmh.h from examples
 * Added the header for interconnect IDs to the top-level description
 * Fixed examples indentation

 .../interconnect/qcom,sm8550-rpmh.yaml        | 139 +++++++++++++
 .../interconnect/qcom,sm8550-rpmh.h           | 190 ++++++++++++++++++
 2 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8550-rpmh.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
new file mode 100644
index 000000000000..716bd21f6041
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm8550-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on SM8550
+
+maintainers:
+  - Abel Vesa <abel.vesa@linaro.org>
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also:: include/dt-bindings/interconnect/qcom,sm8550-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8550-aggre1-noc
+      - qcom,sm8550-aggre2-noc
+      - qcom,sm8550-clk-virt
+      - qcom,sm8550-cnoc-main
+      - qcom,sm8550-config-noc
+      - qcom,sm8550-gem-noc
+      - qcom,sm8550-lpass-ag-noc
+      - qcom,sm8550-lpass-lpiaon-noc
+      - qcom,sm8550-lpass-lpicx-noc
+      - qcom,sm8550-mc-virt
+      - qcom,sm8550-mmss-noc
+      - qcom,sm8550-nsp-noc
+      - qcom,sm8550-pcie-anoc
+      - qcom,sm8550-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-clk-virt
+              - qcom,sm8550-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-aggre1-noc
+              - qcom,sm8550-aggre2-noc
+              - qcom,sm8550-pcie-anoc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm8550-gcc.h>
+
+    clk_virt: interconnect-0 {
+      compatible = "qcom,sm8550-clk-virt";
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16e0000 {
+      compatible = "qcom,sm8550-aggre1-noc";
+      reg = <0x016e0000 0x14400>;
+      #interconnect-cells = <2>;
+      clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+               <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sm8550-rpmh.h b/include/dt-bindings/interconnect/qcom,sm8550-rpmh.h
new file mode 100644
index 000000000000..9cfc67d0b032
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8550-rpmh.h
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8550_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8550_H
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_1				1
+#define MASTER_SDCC_4				2
+#define MASTER_UFS_MEM				3
+#define MASTER_USB3_0				4
+#define SLAVE_A1NOC_SNOC			5
+
+#define MASTER_QDSS_BAM				0
+#define MASTER_QUP_2				1
+#define MASTER_CRYPTO				2
+#define MASTER_IPA				3
+#define MASTER_SP				4
+#define MASTER_QDSS_ETR				5
+#define MASTER_QDSS_ETR_1			6
+#define MASTER_SDCC_2				7
+#define SLAVE_A2NOC_SNOC			8
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_2			2
+#define SLAVE_QUP_CORE_0			3
+#define SLAVE_QUP_CORE_1			4
+#define SLAVE_QUP_CORE_2			5
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_AHB2PHY_SOUTH			1
+#define SLAVE_AHB2PHY_NORTH			2
+#define SLAVE_APPSS				3
+#define SLAVE_CAMERA_CFG			4
+#define SLAVE_CLK_CTL				5
+#define SLAVE_RBCPR_CX_CFG			6
+#define SLAVE_RBCPR_MMCX_CFG			7
+#define SLAVE_RBCPR_MXA_CFG			8
+#define SLAVE_RBCPR_MXC_CFG			9
+#define SLAVE_CPR_NSPCX				10
+#define SLAVE_CRYPTO_0_CFG			11
+#define SLAVE_CX_RDPM				12
+#define SLAVE_DISPLAY_CFG			13
+#define SLAVE_GFX3D_CFG				14
+#define SLAVE_I2C				15
+#define SLAVE_IMEM_CFG				16
+#define SLAVE_IPA_CFG				17
+#define SLAVE_IPC_ROUTER_CFG			18
+#define SLAVE_CNOC_MSS				19
+#define SLAVE_MX_RDPM				20
+#define SLAVE_PCIE_0_CFG			21
+#define SLAVE_PCIE_1_CFG			22
+#define SLAVE_PDM				23
+#define SLAVE_PIMEM_CFG				24
+#define SLAVE_PRNG				25
+#define SLAVE_QDSS_CFG				26
+#define SLAVE_QSPI_0				27
+#define SLAVE_QUP_1				28
+#define SLAVE_QUP_2				29
+#define SLAVE_SDCC_2				30
+#define SLAVE_SDCC_4				31
+#define SLAVE_SPSS_CFG				32
+#define SLAVE_TCSR				33
+#define SLAVE_TLMM				34
+#define SLAVE_UFS_MEM_CFG			35
+#define SLAVE_USB3_0				36
+#define SLAVE_VENUS_CFG				37
+#define SLAVE_VSENSE_CTRL_CFG			38
+#define SLAVE_LPASS_QTB_CFG			39
+#define SLAVE_CNOC_MNOC_CFG			40
+#define SLAVE_NSP_QTB_CFG			41
+#define SLAVE_PCIE_ANOC_CFG			42
+#define SLAVE_QDSS_STM				43
+#define SLAVE_TCU				44
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AOSS				2
+#define SLAVE_TME_CFG				3
+#define SLAVE_CNOC_CFG				4
+#define SLAVE_DDRSS_CFG				5
+#define SLAVE_BOOT_IMEM				6
+#define SLAVE_IMEM				7
+#define SLAVE_PCIE_0				8
+#define SLAVE_PCIE_1				9
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_LPASS_GEM_NOC			4
+#define MASTER_MSS_PROC				5
+#define MASTER_MNOC_HF_MEM_NOC			6
+#define MASTER_MNOC_SF_MEM_NOC			7
+#define MASTER_COMPUTE_NOC			8
+#define MASTER_ANOC_PCIE_GEM_NOC		9
+#define MASTER_SNOC_GC_MEM_NOC			10
+#define MASTER_SNOC_SF_MEM_NOC			11
+#define SLAVE_GEM_NOC_CNOC			12
+#define SLAVE_LLCC				13
+#define SLAVE_MEM_NOC_PCIE_SNOC			14
+#define MASTER_MNOC_HF_MEM_NOC_DISP		15
+#define MASTER_ANOC_PCIE_GEM_NOC_DISP		16
+#define SLAVE_LLCC_DISP				17
+#define MASTER_MNOC_HF_MEM_NOC_CAM_IFE_0	18
+#define MASTER_MNOC_SF_MEM_NOC_CAM_IFE_0	19
+#define MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_0	20
+#define SLAVE_LLCC_CAM_IFE_0			21
+#define MASTER_MNOC_HF_MEM_NOC_CAM_IFE_1	22
+#define MASTER_MNOC_SF_MEM_NOC_CAM_IFE_1	23
+#define MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_1	24
+#define SLAVE_LLCC_CAM_IFE_1			25
+#define MASTER_MNOC_HF_MEM_NOC_CAM_IFE_2	26
+#define MASTER_MNOC_SF_MEM_NOC_CAM_IFE_2	27
+#define MASTER_ANOC_PCIE_GEM_NOC_CAM_IFE_2	28
+#define SLAVE_LLCC_CAM_IFE_2			29
+
+
+#define MASTER_LPIAON_NOC			0
+#define SLAVE_LPASS_GEM_NOC			1
+
+#define MASTER_LPASS_LPINOC			0
+#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		1
+
+#define MASTER_LPASS_PROC			0
+#define SLAVE_LPICX_NOC_LPIAON_NOC		1
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+#define MASTER_LLCC_DISP			2
+#define SLAVE_EBI1_DISP				3
+#define MASTER_LLCC_CAM_IFE_0			4
+#define SLAVE_EBI1_CAM_IFE_0			5
+#define MASTER_LLCC_CAM_IFE_1			6
+#define SLAVE_EBI1_CAM_IFE_1			7
+#define MASTER_LLCC_CAM_IFE_2			8
+#define SLAVE_EBI1_CAM_IFE_2			9
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_ICP			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_MDP				3
+#define MASTER_CDSP_HCP				4
+#define MASTER_VIDEO				5
+#define MASTER_VIDEO_CV_PROC			6
+#define MASTER_VIDEO_PROC			7
+#define MASTER_VIDEO_V_PROC			8
+#define MASTER_CNOC_MNOC_CFG			9
+#define SLAVE_MNOC_HF_MEM_NOC			10
+#define SLAVE_MNOC_SF_MEM_NOC			11
+#define SLAVE_SERVICE_MNOC			12
+#define MASTER_MDP_DISP				13
+#define SLAVE_MNOC_HF_MEM_NOC_DISP		14
+#define MASTER_CAMNOC_HF_CAM_IFE_0		15
+#define MASTER_CAMNOC_ICP_CAM_IFE_0		16
+#define MASTER_CAMNOC_SF_CAM_IFE_0		17
+#define SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_0		18
+#define SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_0		19
+#define MASTER_CAMNOC_HF_CAM_IFE_1		20
+#define MASTER_CAMNOC_ICP_CAM_IFE_1		21
+#define MASTER_CAMNOC_SF_CAM_IFE_1		22
+#define SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_1		23
+#define SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_1		24
+#define MASTER_CAMNOC_HF_CAM_IFE_2		25
+#define MASTER_CAMNOC_ICP_CAM_IFE_2		26
+#define MASTER_CAMNOC_SF_CAM_IFE_2		27
+#define SLAVE_MNOC_HF_MEM_NOC_CAM_IFE_2		28
+#define SLAVE_MNOC_SF_MEM_NOC_CAM_IFE_2		29
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define SLAVE_ANOC_PCIE_GEM_NOC			3
+#define SLAVE_SERVICE_PCIE_ANOC			4
+
+#define MASTER_GIC_AHB				0
+#define MASTER_A1NOC_SNOC			1
+#define MASTER_A2NOC_SNOC			2
+#define MASTER_GIC				3
+#define SLAVE_SNOC_GEM_NOC_GC			4
+#define SLAVE_SNOC_GEM_NOC_SF			5
+
+#endif
-- 
2.34.1

