Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16265609D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiJXJCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJXJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:01:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E064E19D;
        Mon, 24 Oct 2022 02:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08C2C61092;
        Mon, 24 Oct 2022 09:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1145EC4FEBE;
        Mon, 24 Oct 2022 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666602098;
        bh=+WkGHWoLZtDbhsbGRmzXKHjD/rB4ftzUCrvrsjeND8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEzrhd5+5POIVX4OipjaIv2tUjNV+1BnXX31ZbFe+6VVJa0QvKcDsPkGPMHXTt9kG
         B9DmbrTIowiNObhzhPI1E2RcuXzYyzoa1j+hJ4GBDj0i3NFwgKi0qsmPgyvFOR5dyB
         l94LVPpYUu0WFlSkLMjrKKSClrG9YWAfgDAB5RX9zTt7YDxFU1o06bwY1Z+vPW+SjX
         Q5K4tJ/Wwcz/+6QYp0qKym6oKBFNEKy/vXEnOBc+hzIAuvbARCVhFV2OXIvbXuW/nh
         fYx+XwYf+aLevQU/fKpn+PR++WsVuvh4CNJYcZj/67RhAdUTk/snWmfE39kfWiX8bY
         50kIj+CvzTkaQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omtKj-00056g-Mj; Mon, 24 Oct 2022 11:01:21 +0200
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
Subject: [PATCH 08/10] dt-bindings: phy: qcom,qmp-ufs: fix sc8280xp binding
Date:   Mon, 24 Oct 2022 11:00:39 +0200
Message-Id: <20221024090041.19574-9-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024090041.19574-1-johan+linaro@kernel.org>
References: <20221024090041.19574-1-johan+linaro@kernel.org>
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

The current QMP UFS PHY bindings are based on the original MSM8996 PCIe
PHY binding which provided multiple PHYs per IP block and these in turn
were described by child nodes.

The QMP UFS PHY block only provide a single PHY and the remnant child
node does not really reflect the hardware.

The original MSM8996 binding also ended up describing the individual
register blocks as belonging to either the wrapper node or the PHY child
nodes.

This is an unnecessary level of detail which has lead to problems when
later IP blocks using different register layouts have been forced to fit
the original mould rather than updating the binding. The bindings are
arguable also incomplete as they only the describe register blocks used
by the current Linux drivers.

Add a new binding for the UFS QMP PHYs found on SC8280XP which further
bindings can be based on.

Note that the current binding is simply removed instead of being
deprecated as it was only recently merged and support for SC8280XP is
still under development.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,msm8996-qmp-ufs-phy.yaml         | 10 +--
 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        | 83 +++++++++++++++++++
 2 files changed, 87 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
index 438f9606414a..be41acbd3b6c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
@@ -22,7 +22,6 @@ properties:
       - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8998-qmp-ufs-phy
       - qcom,sc8180x-qmp-ufs-phy
-      - qcom,sc8280xp-qmp-ufs-phy
       - qcom,sdm845-qmp-ufs-phy
       - qcom,sm6115-qmp-ufs-phy
       - qcom,sm6350-qmp-ufs-phy
@@ -122,7 +121,6 @@ allOf:
             enum:
               - qcom,msm8998-qmp-ufs-phy
               - qcom,sc8180x-qmp-ufs-phy
-              - qcom,sc8280xp-qmp-ufs-phy
               - qcom,sdm845-qmp-ufs-phy
               - qcom,sm6115-qmp-ufs-phy
               - qcom,sm6350-qmp-ufs-phy
@@ -159,7 +157,6 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-qmp-ufs-phy
-              - qcom,sc8280xp-qmp-ufs-phy
               - qcom,sdm845-qmp-ufs-phy
               - qcom,sm6350-qmp-ufs-phy
               - qcom,sm8150-qmp-ufs-phy
@@ -214,11 +211,12 @@ allOf:
 
 examples:
   - |
-    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/clock/qcom,gcc-sm8250.h>
     #include <dt-bindings/clock/qcom,rpmh.h>
+
     phy-wrapper@1d87000 {
-        compatible = "qcom,sc8280xp-qmp-ufs-phy";
-        reg = <0x01d87000 0xe10>;
+        compatible = "qcom,sm8250-qmp-ufs-phy";
+        reg = <0x01d87000 0x1c0>;
         #address-cells = <1>;
         #size-cells = <1>;
         ranges = <0x0 0x01d87000 0x1000>;
diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
new file mode 100644
index 000000000000..dde86a19f792
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-ufs-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QMP PHY controller (UFS, SC8280XP)
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
+      - qcom,sc8280xp-qmp-ufs-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ref
+      - const: ref_aux
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: ufsphy
+
+  vdda-phy-supply: true
+
+  vdda-pll-supply: true
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
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+
+    ufs_mem_phy: phy@1d87000 {
+        compatible = "qcom,sc8280xp-qmp-ufs-phy";
+        reg = <0x01d87000 0x1000>;
+
+        clocks = <&gcc GCC_UFS_REF_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+        clock-names = "ref", "ref_aux";
+
+        power-domains = <&gcc UFS_PHY_GDSC>;
+
+        resets = <&ufs_mem_hc 0>;
+        reset-names = "ufsphy";
+
+        vdda-phy-supply = <&vreg_l6b>;
+        vdda-pll-supply = <&vreg_l3b>;
+
+        #phy-cells = <0>;
+    };
-- 
2.37.3

