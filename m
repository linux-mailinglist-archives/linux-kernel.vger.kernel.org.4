Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6060360448C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiJSMIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiJSMHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8351AF09;
        Wed, 19 Oct 2022 04:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D78E560ECC;
        Wed, 19 Oct 2022 11:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FE3C4FF0A;
        Wed, 19 Oct 2022 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666179379;
        bh=/ulOJdpqzOLnXMpD6fZgdmLw3NSSl989/gEy+NOMms0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZXOnkqijx5zZwT3EQJ1CS7wzuG72hRnfV4YKYtBk4MM34ky9rtHi674p6IoWOgrS
         PXLubcm7DnF8gDiZa0kehup2ZUl0jKzn2kDMufBGe8/v1a4DK4e1J0i0Ghjus7g+gA
         Rs2R0QjCAfS300/aAaZIT7ZiDXbEJpHxgm3OtiSglbxFeRnhwx4RiOTPWOu+98jZvX
         gjpWRYJKb4QH4E5Ky/qqOGxmHCVbntjhQ3ASq/HmK8KHgHqBBEMExwOn3EjyCv/nlS
         7VgLAvl99fdnq6sCtmeUmDUXfCGplj35+sP/zsVi5U4wKsxY6A59mLWUXCGs6bTOPv
         Kosn0FyJHYoRg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ol7Mm-0005pf-3P; Wed, 19 Oct 2022 13:36:08 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 10/15] dt-bindings: phy: qcom,qmp-pcie: add sc8280xp bindings
Date:   Wed, 19 Oct 2022 13:35:47 +0200
Message-Id: <20221019113552.22353-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019113552.22353-1-johan+linaro@kernel.org>
References: <20221019113552.22353-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the PCIe QMP PHYs found on SC8280XP.

The PCIe2 and PCIe3 controllers and PHYs on SC8280XP can be used in
4-lane mode or as separate controllers and PHYs in 2-lane mode (e.g. as
PCIe2A and PCIe2B).

The configuration for a specific system can be read from a TCSR register.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       | 165 ++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
new file mode 100644
index 000000000000..80aa8d2507fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QMP PHY controller (PCIe, SC8280XP)
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+description:
+  The QMP PHY controller supports physical layer functionality for a number of
+  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8280xp-qmp-gen3x1-pcie-phy
+      - qcom,sc8280xp-qmp-gen3x2-pcie-phy
+      - qcom,sc8280xp-qmp-gen3x4-pcie-phy
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    maxItems: 6
+
+  clock-names:
+    items:
+      - const: aux
+      - const: cfg_ahb
+      - const: ref
+      - const: rchng
+      - const: pipe
+      - const: pipediv2
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: phy
+
+  vdda-phy-supply: true
+
+  vdda-pll-supply: true
+
+  qcom,4ln-config-sel:
+    description: PCIe 4-lane configuration
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle of TCSR syscon
+          - description: offset of PCIe 4-lane configuration register
+          - description: offset of configuration bit for this PHY
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+  - vdda-phy-supply
+  - vdda-pll-supply
+  - "#clock-cells"
+  - clock-output-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-qmp-gen3x4-pcie-phy
+    then:
+      properties:
+        reg:
+          items:
+            - description: port a
+            - description: port b
+      required:
+        - qcom,4ln-config-sel
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+
+    pcie2b_phy: phy@1c18000 {
+      compatible = "qcom,sc8280xp-qmp-gen3x2-pcie-phy";
+      reg = <0x01c18000 0x2000>;
+
+      clocks = <&gcc GCC_PCIE_2B_AUX_CLK>,
+               <&gcc GCC_PCIE_2B_CFG_AHB_CLK>,
+               <&gcc GCC_PCIE_2A2B_CLKREF_CLK>,
+               <&gcc GCC_PCIE2B_PHY_RCHNG_CLK>,
+               <&gcc GCC_PCIE_2B_PIPE_CLK>,
+               <&gcc GCC_PCIE_2B_PIPEDIV2_CLK>;
+      clock-names = "aux", "cfg_ahb", "ref", "rchng",
+                    "pipe", "pipediv2";
+
+      power-domains = <&gcc PCIE_2B_GDSC>;
+
+      resets = <&gcc GCC_PCIE_2B_PHY_BCR>;
+      reset-names = "phy";
+
+      vdda-phy-supply = <&vreg_l6d>;
+      vdda-pll-supply = <&vreg_l4d>;
+
+      #clock-cells = <0>;
+      clock-output-names = "pcie_2b_pipe_clk";
+
+      #phy-cells = <0>;
+    };
+
+    pcie2a_phy: phy@1c24000 {
+      compatible = "qcom,sc8280xp-qmp-gen3x4-pcie-phy";
+      reg = <0x01c24000 0x2000>, <0x01c26000 0x2000>;
+
+      clocks = <&gcc GCC_PCIE_2A_AUX_CLK>,
+               <&gcc GCC_PCIE_2A_CFG_AHB_CLK>,
+               <&gcc GCC_PCIE_2A2B_CLKREF_CLK>,
+               <&gcc GCC_PCIE2A_PHY_RCHNG_CLK>,
+               <&gcc GCC_PCIE_2A_PIPE_CLK>,
+               <&gcc GCC_PCIE_2A_PIPEDIV2_CLK>;
+      clock-names = "aux", "cfg_ahb", "ref", "rchng",
+                    "pipe", "pipediv2";
+
+      power-domains = <&gcc PCIE_2A_GDSC>;
+
+      resets = <&gcc GCC_PCIE_2A_PHY_BCR>;
+      reset-names = "phy";
+
+      vdda-phy-supply = <&vreg_l6d>;
+      vdda-pll-supply = <&vreg_l4d>;
+
+      qcom,4ln-config-sel = <&tcsr 0xa044 0>;
+
+      #clock-cells = <0>;
+      clock-output-names = "pcie_2a_pipe_clk";
+
+      #phy-cells = <0>;
+    };
-- 
2.37.3

