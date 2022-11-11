Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412626256C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbiKKJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiKKJ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:26:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929E4787B2;
        Fri, 11 Nov 2022 01:26:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E2ECB824AE;
        Fri, 11 Nov 2022 09:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED87C4347C;
        Fri, 11 Nov 2022 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668158764;
        bh=xvw8f4uLya1tYtW/a3ebgxqOAIDX0JRk6onsrY8M4CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9NN+CbCyI6znH470xG2xd0oqyMZ/X5xVlrsNwCcNsYH/esAEAexnw2FXmEqXSG+d
         e+5LKXyOK2KDKbSgERWDCcnUY3837mr8lqk2+g+svxt8ss7XCn9xIn0PcuCLn6xKjd
         rs8UMQmxA0S7XaYOCcfg6vEqFv8MjUaF8zhx8InAxcX4CHmmenATzdJer/4m2b73Os
         RKuw74sfDiegGjhrf9FNQRuycT7XzHNrtJV+5pts4HQJGRam6w64qKXYMmUH/3+cTG
         +XfK8kTL8wRxo6ucLKjuRNLgoGNlnVaCNLgkqa5SSLDWCZSeG4OQtRp7CqEr4Zxy0g
         xz1umuv9SfhoA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQI4-0002kr-LX; Fri, 11 Nov 2022 10:25:36 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp bindings
Date:   Fri, 11 Nov 2022 10:24:45 +0100
Message-Id: <20221111092457.10546-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111092457.10546-1-johan+linaro@kernel.org>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current QMP USB3-DP PHY bindings are based on the original MSM8996
binding which provided multiple PHYs per IP block and these in turn were
described by child nodes.

The QMP USB3-DP PHY block provides a single multi-protocol PHY and even
if some resources are only used by either the USB or DP part of the
device there is no real benefit in describing these resources in child
nodes.

The original MSM8996 binding also ended up describing the individual
register blocks as belonging to either the wrapper node or the PHY child
nodes.

This is an unnecessary level of detail which has lead to problems when
later IP blocks using different register layouts have been forced to fit
the original mould rather than updating the binding. The bindings are
arguable also incomplete as they only the describe register blocks used
by the current Linux drivers (e.g. does not include the PCS LANE
registers).

This is specifically true for later USB4-USB3-DP QMP PHYs where the TX
registers are used by both the USB3 and DP parts of the PHY (and where
the USB4 part of the PHY was not covered by the binding at all). Notably
there are also no DP "RX" (sic) registers as described by the current
bindings and the DP "PCS" region is really a set of DP_PHY registers.

Add a new binding for the USB4-USB3-DP QMP PHYs found on SC8280XP which
further bindings can be based on.

Note that the binding uses a PHY type index to access either the USB3 or
DP part of the PHY and that this can later be used also for the USB4
part if needed.

Similarly, the clock inputs and outputs can later be extended to support
USB4.

Also note that the current binding is simply removed instead of being
deprecated as it was only recently merged and would not allow for
supporting DP mode.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,sc7180-qmp-usb3-dp-phy.yaml      |  12 --
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 111 ++++++++++++++++++
 2 files changed, 111 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
index 50b1fce530d5..2f4a419197a8 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
@@ -23,7 +23,6 @@ properties:
       - qcom,sc7180-qmp-usb3-dp-phy
       - qcom,sc7280-qmp-usb3-dp-phy
       - qcom,sc8180x-qmp-usb3-dp-phy
-      - qcom,sc8280xp-qmp-usb43dp-phy
       - qcom,sdm845-qmp-usb3-dp-phy
       - qcom,sm8250-qmp-usb3-dp-phy
   reg:
@@ -169,17 +168,6 @@ required:
 
 additionalProperties: false
 
-allOf:
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc8280xp-qmp-usb43dp-phy
-    then:
-      required:
-        - power-domains
-
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sdm845.h>
diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
new file mode 100644
index 000000000000..bd04150acee4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QMP USB4-USB3-DP PHY controller (SC8280XP)
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+description:
+  The QMP PHY controller supports physical layer functionality for a number of
+  controllers on Qualcomm chipsets, such as, PCIe, UFS and USB.
+
+  See also:
+    - include/dt-bindings/dt-bindings/phy/phy.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8280xp-qmp-usb43dp-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: aux
+      - const: ref
+      - const: com_aux
+      - const: usb3_pipe
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
+      - const: common
+
+  vdda-phy-supply: true
+
+  vdda-pll-supply: true
+
+  "#clock-cells":
+    const: 1
+
+  clock-output-names:
+    items:
+      - const: usb3_pipe
+      - const: dp_link
+      - const: dp_vco_div
+
+  "#phy-cells":
+    const: 1
+    description: |
+      PHY index
+        - PHY_TYPE_USB3
+        - PHY_TYPE_DP
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
+
+    phy@88eb000 {
+      compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
+      reg = <0x088eb000 0x4000>;
+
+      clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+               <&gcc GCC_USB4_EUD_CLKREF_CLK>,
+               <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+               <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+      clock-names = "aux", "ref", "com_aux", "usb3_pipe";
+
+      power-domains = <&gcc USB30_PRIM_GDSC>;
+
+      resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
+               <&gcc GCC_USB4_DP_PHY_PRIM_BCR>;
+      reset-names = "phy", "common";
+
+      vdda-phy-supply = <&vreg_l9d>;
+      vdda-pll-supply = <&vreg_l4d>;
+
+      #clock-cells = <1>;
+      clock-output-names = "usb3_pipe", "dp_link", "dp_vco_div";
+
+      #phy-cells = <1>;
+    };
-- 
2.37.4

