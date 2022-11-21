Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48472631C14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiKUIxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiKUIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:52:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B907FC35;
        Mon, 21 Nov 2022 00:51:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF99B60F41;
        Mon, 21 Nov 2022 08:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8065DC43148;
        Mon, 21 Nov 2022 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669020714;
        bh=oaYydGIIhFbVg1SOFvykm3oAbCc9Ak2k+xW9nwe5c/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olGyWcvVUP0coNOd9kW8Idz/ytERBmGqAHrlgh/ysBGBmBZv1A+GP+oFH7uf8DT1a
         VbyhY58+3gaxeDGKka9B07xxEGZe21nAyEqPgGR9KSefkzQUS10iIWyYbrbs7R1Vkv
         HPS0WNZzf4N/GpWPCJ/14tWjzgaGRDmAtJIqHER7T8mHzcACHb1I3VNiF6aFZm4V4i
         qixFnYCjvZYAz8dMyz+nRlYdf8REOSY1yXWslQqZeBKqqFcDXKQMZiNBEo2JWKuiV5
         r5/UmV1iQHDNTgdFkB6byWrtBD7qTzJeoenw7+o8OfevFKUy2xqQHqTI6J4BU1hZ2g
         qsXDjdqVhtIqA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ox2WS-00088H-It; Mon, 21 Nov 2022 09:51:24 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 02/15] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp binding
Date:   Mon, 21 Nov 2022 09:50:45 +0100
Message-Id: <20221121085058.31213-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221121085058.31213-1-johan+linaro@kernel.org>
References: <20221121085058.31213-1-johan+linaro@kernel.org>
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

Note that the binding uses a PHY index to access either the USB3 or DP
part of the PHY and that this can later be used also for the USB4 part
if needed.

Similarly, the clock inputs and outputs can later be extended to support
USB4.

Also note that the current binding is simply removed instead of being
deprecated as it was only recently merged and would not allow for
supporting DP mode.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,sc7180-qmp-usb3-dp-phy.yaml      | 12 ---
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 99 +++++++++++++++++++
 include/dt-bindings/phy/phy-qcom-qmp.h        | 20 ++++
 3 files changed, 119 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
 create mode 100644 include/dt-bindings/phy/phy-qcom-qmp.h

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
index 8afc5e815ae8..d9d0ab90edb1 100644
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
index 000000000000..6f31693d9868
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -0,0 +1,99 @@
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
+    description:
+      See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
+
+  "#phy-cells":
+    const: 1
+    description:
+      See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
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
+      #phy-cells = <1>;
+    };
diff --git a/include/dt-bindings/phy/phy-qcom-qmp.h b/include/dt-bindings/phy/phy-qcom-qmp.h
new file mode 100644
index 000000000000..4edec4c5b224
--- /dev/null
+++ b/include/dt-bindings/phy/phy-qcom-qmp.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Qualcomm QMP PHY constants
+ *
+ * Copyright (C) 2022 Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_PHY_QMP
+#define _DT_BINDINGS_PHY_QMP
+
+/* QMP USB4-USB3-DP clocks */
+#define QMP_USB43DP_USB3_PIPE_CLK	0
+#define QMP_USB43DP_DP_LINK_CLK		1
+#define QMP_USB43DP_DP_VCO_DIV_CLK	2
+
+/* QMP USB4-USB3-DP PHYs */
+#define QMP_USB43DP_USB3_PHY		0
+#define QMP_USB43DP_DP_PHY		1
+
+#endif /* _DT_BINDINGS_PHY_QMP */
-- 
2.37.4

