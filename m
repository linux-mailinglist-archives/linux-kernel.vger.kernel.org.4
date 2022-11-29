Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D576A63C0C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiK2NOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiK2NNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:13:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11020627D8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:12:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n20so33727527ejh.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJIzBaGiOEToYTPg4Nx5JjejDlKGR9dPTTOsmSZKgo4=;
        b=O4YELV5cRimw0pjMXrCOrxsYQfbBnp+DfR2PkLZ/VZdmf117ydBPo0rjZTnQw8Clt0
         HEH9OB9G5u3/HaFlqWVsFtBp/wdRmYX/vRSHjjfoO7V+vCqq8VhVSMftgvt4OuGOKCLL
         Z+G+kFO3Rw1s1d4Sw8UOp8xjnWf5RrzbgpCJbV65FCPfReboA3QzQ+DD5AapHOTCzcpZ
         aWBAjNSOfUNZSGyoryzXnk35fFgxeiHkqqa26jmm+GZ0T7Kw1NStIse5TDnfHDfZPMGM
         XmTQQ+UpJfY1YS0YiduxTtgPpcI7T7SyJxvmnSj5Vd3nomacG347wNY8WZRbPhyn+DED
         Za2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJIzBaGiOEToYTPg4Nx5JjejDlKGR9dPTTOsmSZKgo4=;
        b=y2g7WtN/qf5NCHJKdnUHW6ZD8idalJ9qvyf0sn8Acniol/QTl1NoQwqWqVlagTnCQf
         dC3zB/u7EA0tP6dKlkyYfJk7P+BRrLnzqG6gBM6Kte6HASY4MebpuRpGPKk63b4iF9Rd
         zl8RduKc/qRBekm0n3owmD50Xhre8iaLIGyqNh4Lxi8sZK2TyJ2V7CHNbU7OPvol/iYo
         D5RhGFt2SKBz8fGuPxfznn3keDQV1c7Q2izsyZDTeFNHUV9dZJmra1YK9nKfybLtqcc0
         Yzo3GLC1Wv1tup/yTsY0ccJf7NVztBXbKLU7QgT2Z9a/luJLIQCPU6tlvZCEn3crk4T1
         3uJg==
X-Gm-Message-State: ANoB5pmhp88GhkH78XhBaMb53boo63WDvKC+aQNTCiWdthLRpf+hkjg4
        nlxIp1b9MCoHTBjgeEhPR2uH3729GeTJvw==
X-Google-Smtp-Source: AA0mqf76aicPG+OBDUWjo2kq2GyrT/JOzZh44mC3wEtInbOYtEjzxsU02+WBXRMrfiDNUfQb+JMx9g==
X-Received: by 2002:a17:906:c08:b0:7bf:99a6:95aa with SMTP id s8-20020a1709060c0800b007bf99a695aamr9320411ejf.7.1669727529558;
        Tue, 29 Nov 2022 05:12:09 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p21-20020a05640210d500b0046b25b93451sm2620541edu.85.2022.11.29.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:12:09 -0800 (PST)
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
Subject: [PATCH v3 1/2] dt-bindings: interconnect: Add Qualcomm SM8550
Date:   Tue, 29 Nov 2022 15:12:02 +0200
Message-Id: <20221129131203.2197959-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129131203.2197959-1-abel.vesa@linaro.org>
References: <20221129131203.2197959-1-abel.vesa@linaro.org>
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

The Qualcomm SM8550 SoC has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v2:
 * Added Neil and I as maintainers in the binding doc, as Krzysztof
   suggested
 * Added top-level reg property witg maxItem 1
 * Fixed the if clause for reg property, like Krzysztof suggested
 * Added top-level clocks, along with dedicated if clause for clocks
   property for required/false, like Krzysztof suggested
 * Kept only clk_virt and aggre1 examples and dropped the rest
 * Renamed both header and bindings like the compatible
 * Squashed the bindings schema patch in the one with the header

 .../interconnect/qcom,sm8550-rpmh.yaml        | 139 +++++++++++++
 .../interconnect/qcom,sm8550-rpmh.h           | 190 ++++++++++++++++++
 2 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8550-rpmh.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
new file mode 100644
index 000000000000..785465926db9
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
+   RPMh interconnect providers support system bandwidth requirements through
+   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+   able to communicate with the BCM through the Resource State Coordinator (RSC)
+   associated with each execution environment. Provider nodes must point to at
+   least one RPMh device child node pertaining to their RSC and each provider
+   can map to multiple RPMh resources.
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
+      #include <dt-bindings/clock/qcom,sm8550-gcc.h>
+      #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
+      #include <dt-bindings/clock/qcom,rpmh.h>
+
+      clk_virt: interconnect-0 {
+             compatible = "qcom,sm8550-clk-virt";
+             #interconnect-cells = <2>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      aggre1_noc: interconnect@16e0000 {
+             compatible = "qcom,sm8550-aggre1-noc";
+             reg = <0x016e0000 0x14400>;
+             #interconnect-cells = <2>;
+             clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                      <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
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

