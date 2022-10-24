Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F3A609EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiJXKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiJXKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA3A33E08;
        Mon, 24 Oct 2022 03:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 160CA611C1;
        Mon, 24 Oct 2022 10:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAE3C4FEBC;
        Mon, 24 Oct 2022 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666606023;
        bh=NJAwVbdMAk/rD+rBNAeavqkcMVTVV3xeAlC+sLKCmj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFGJEgFGrFyQMn94qeHXpnc3Umc9LuEaJ7wPROSrdSViyuzzcgdIznrEOtfem896X
         NSKddvKSYYc94Do2ng6LjxRq33iCkR2VCo0ZHLMJERrT+2tCaHGos/LbZtn4b2qzro
         BI8l2U67Qq4Of5Ksc4logpZiPB6p8HkDaXL4MSwrZjogbHwncCIxkm730IN67cNiqc
         fyCNbl7S3o6emDXcVHbTX2J8PmzrNCgGUvZMBKg5OoRgCHg4X1j125+aMfeuft0YoU
         mJ7jFNN5iX4TFJl56kuCD+imG8QwV1wUbO6kJGdqkMAFWvy8P4J1W3KeL9QQU09q6a
         I6PWjm2JjDZcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omuM3-0005Mx-KX; Mon, 24 Oct 2022 12:06:47 +0200
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
Subject: [PATCH 11/13] dt-bindings: phy: qcom,qmp-usb: fix sc8280xp binding
Date:   Mon, 24 Oct 2022 12:06:30 +0200
Message-Id: <20221024100632.20549-12-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024100632.20549-1-johan+linaro@kernel.org>
References: <20221024100632.20549-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current QMP USB PHY bindings are based on the original MSM8996 PCIe
PHY binding which provided multiple PHYs per IP block and these in turn
were described by child nodes.

The QMP USB PHY block only provide a single PHY and the remnant child
node does not really reflect the hardware.

The original MSM8996 binding also ended up describing the individual
register blocks as belonging to either the wrapper node or the PHY child
nodes.

This is an unnecessary level of detail which has lead to problems when
later IP blocks using different register layouts have been forced to fit
the original mould rather than updating the binding. The bindings are
arguable also incomplete as they only the describe register blocks used
by the current Linux drivers (e.g. does not include the per lane PCS
registers).

Note that PCS_USB region is also not described by the current bindings
despite being used by the driver and this has led to people increasing
the size of the PCS region in the devicetree so that it includes PCS_USB
registers even though other regions like TX and RX may lie in between.

Add a new binding for the QMP USB PHYs found on SC8280XP which further
bindings can be based on.

Note that this also fixes the SC8280XP "phy_phy" reset name.

Also note that the current binding is simply removed instead of being
deprecated as it was only recently merged and support for SC8280XP is
still under development. And, specifically, there is no support in
mainline for the multiport controller that uses these PHYs.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,msm8996-qmp-usb-phy.yaml         |  13 ---
 .../phy/qcom,sc8280xp-qmp-usb-phy.yaml        | 105 ++++++++++++++++++
 2 files changed, 105 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb-phy.yaml
index a72e96f241d1..874c32b75428 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb-phy.yaml
@@ -26,7 +26,6 @@ properties:
       - qcom,qcm2290-qmp-usb3-phy
       - qcom,sc7180-qmp-usb3-phy
       - qcom,sc8180x-qmp-usb3-phy
-      - qcom,sc8280xp-qmp-usb3-uni-phy
       - qcom,sdm845-qmp-usb3-phy
       - qcom,sdm845-qmp-usb3-uni-phy
       - qcom,sdx55-qmp-usb3-uni-phy
@@ -204,7 +203,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,sc8280xp-qmp-usb3-uni-phy
               - qcom,sm8150-qmp-usb3-phy
               - qcom,sm8150-qmp-usb3-uni-phy
               - qcom,sm8250-qmp-usb3-uni-phy
@@ -271,16 +269,6 @@ allOf:
             - const: phy_phy
             - const: phy
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc8280xp-qmp-usb3-uni-phy
-    then:
-      required:
-        - power-domains
-
   - if:
       properties:
         compatible:
@@ -352,7 +340,6 @@ allOf:
           contains:
             enum:
               - qcom,msm8996-qmp-usb3-phy
-              - qcom,sc8280xp-qmp-usb3-uni-phy
               - qcom,sm8250-qmp-usb3-uni-phy
               - qcom,sm8350-qmp-usb3-uni-phy
     then:
diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb-phy.yaml
new file mode 100644
index 000000000000..95ee81d782f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb-phy.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QMP PHY controller (USB, SC8280XP)
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
+      - qcom,sc8280xp-qmp-usb3-uni-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: aux
+      - const: ref_clk_src
+      - const: ref
+      - const: com_aux
+      - const: pipe
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: phy
+      - const: phy_phy
+
+  vdda-phy-supply: true
+
+  vdda-pll-supply: true
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
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    phy@88ef000 {
+      compatible = "qcom,sc8280xp-qmp-usb3-uni-phy";
+      reg = <0x088ef000 0x2000>;
+
+      clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
+               <&rpmhcc RPMH_CXO_CLK>,
+               <&gcc GCC_USB3_MP0_CLKREF_CLK>,
+               <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>,
+               <&gcc GCC_USB3_MP_PHY_PIPE_0_CLK>;
+      clock-names = "aux", "ref_clk_src", "ref", "com_aux",
+                    "pipe";
+
+      power-domains = <&gcc USB30_MP_GDSC>;
+
+      resets = <&gcc GCC_USB3_UNIPHY_MP0_BCR>,
+               <&gcc GCC_USB3UNIPHY_PHY_MP0_BCR>;
+      reset-names = "phy", "phy_phy";
+
+      vdda-phy-supply = <&vreg_l3a>;
+      vdda-pll-supply = <&vreg_l5a>;
+
+      #clock-cells = <0>;
+      clock-output-names = "usb2_phy0_pipe_clk";
+
+      #phy-cells = <0>;
+    };
-- 
2.37.3

