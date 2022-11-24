Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5526E636ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKXASE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKXAR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:17:59 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FA74FFBC;
        Wed, 23 Nov 2022 16:17:54 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id d3so306746ljl.1;
        Wed, 23 Nov 2022 16:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgUKoZj1etk0iYKusMjoAmrONTie7d2Uh1yKnHz69bM=;
        b=gINZY0MQ8ESpdTcBMoFytNdNbHsWwbyqDwCRI4nnwQHQlqk4mBU661LxwbhJkpsVP/
         xohsmdT2FlQcWBhXXxCoNmuOVsB3A5i3Zv8QzhIeWwQmnVqcQd1CdhWlWMJ05t2qrMZW
         2zlqc8mWgTt45mS1AjM2s1NdmiYenbGzqAeAJgeo5sHuKo70aehbpWxHNLio1XTPIOsg
         N7p2KRPquvbY1PD/j/m3T8NZrLknBSjapj5sVuAvKRlJ/jFbd8VUqL74vQhhK94PMP4T
         GvcapUN/gAPGpeObLKKv2RjF4oCxMFY7NSsQx0B7vuJCnIcNi9V9+0OIp7KU96LMhEsc
         /lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgUKoZj1etk0iYKusMjoAmrONTie7d2Uh1yKnHz69bM=;
        b=rsMN9PKGcKGJsPfumWvrES5ACPZLTwb7KU88ODugmRTfKr3db1qJmbiw1MH9pjiw/a
         HrrQiGZgXkJ/LhaCf5iN4ztZ9sVnWTnVx2mxWgCTNW3cZFSeLh7sFlOhPbyzvigwZTrj
         GwyJXyGN1ycukxPpxC28pTpwzK4s5PcGXPiwyuOO/KAtDYhCR4cP57mJO1z4Fpfqf/HD
         ubkWnTc+rR89ZqYGcvbWolDd4iD0izAOXSYe/z4vIqneJxPeroKNIDF3r0X+MdxBiuQQ
         cTBXsiJnKynXk6VIRpKhomhy0uSu0pLBsP/vKIf/RQ2wH5ELot2rF66/rgWrZXdzdkbu
         WeMg==
X-Gm-Message-State: ANoB5pmNbCLddTyqm5Cxl1sf0N7TTsqnUVMXpsi7Inj+7AZW2/DthNhZ
        nkIwKqi8arEXGhYCBsPD2ilFHJ6h4glEtw==
X-Google-Smtp-Source: AA0mqf7uTzOJVuyp2nUYATXNEyDGO9H4zXeFeT2YA1ZPhJTOBYgDJ+cZoX4pYcumrcIwXT4FmqtvAg==
X-Received: by 2002:a05:651c:1a07:b0:277:11ae:d44e with SMTP id by7-20020a05651c1a0700b0027711aed44emr6741556ljb.458.1669249072744;
        Wed, 23 Nov 2022 16:17:52 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id p8-20020a19f008000000b004ac980a1ba1sm3054388lfc.24.2022.11.23.16.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:17:52 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: display/msm: add support for SM6115
Date:   Thu, 24 Nov 2022 01:16:31 +0100
Message-Id: <20221124001708.25720-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124001708.25720-1-a39.skl@gmail.com>
References: <20221124001708.25720-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DPU and MDSS schemas to describe MDSS and DPU blocks on the Qualcomm
SM6115 platform.
Configuration for DSI/PHY is shared with QCM2290 so compatibles are reused.
Lack of dsi phy supply in example is intended
due to fact on qcm2290, sm6115 and sm6125
this phy is supplied via power domain, not regulator.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../bindings/display/msm/qcom,sm6115-dpu.yaml |  94 +++++++++
 .../display/msm/qcom,sm6115-mdss.yaml         | 182 ++++++++++++++++++
 2 files changed, 276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
new file mode 100644
index 000000000000..4a39a3031409
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,sm6115-dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display DPU dt properties for SM6115 target
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+
+$ref: /schemas/display/msm/dpu-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: qcom,sm6115-dpu
+
+  reg:
+    items:
+      - description: MDP register set
+      - description: VBIF register set
+
+  reg-names:
+    items:
+      - const: mdp
+      - const: vbif
+
+  clocks:
+    items:
+      - description: Display AXI
+      - description: Display AHB
+      - description: Display core
+      - description: Display lut
+      - description: Display rotator
+      - description: Display vsync
+
+  clock-names:
+    items:
+      - const: bus
+      - const: iface
+      - const: core
+      - const: lut
+      - const: rot
+      - const: vsync
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm6115-dispcc.h>
+    #include <dt-bindings/clock/qcom,gcc-sm6115.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    display-controller@5e01000 {
+        compatible = "qcom,sm6115-dpu";
+        reg = <0x05e01000 0x8f000>,
+              <0x05eb0000 0x2008>;
+        reg-names = "mdp", "vbif";
+
+        clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+                 <&dispcc DISP_CC_MDSS_ROT_CLK>,
+                 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+        clock-names = "bus", "iface", "core", "lut", "rot", "vsync";
+
+        operating-points-v2 = <&mdp_opp_table>;
+        power-domains = <&rpmpd SM6115_VDDCX>;
+
+        interrupt-parent = <&mdss>;
+        interrupts = <0>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                endpoint {
+                    remote-endpoint = <&dsi0_in>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
new file mode 100644
index 000000000000..a86d7f53fa84
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
@@ -0,0 +1,182 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,sm6115-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM6115 Display MDSS
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+
+description:
+  Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
+  sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
+  are mentioned for SM6115 target.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: qcom,sm6115-mdss
+
+  clocks:
+    items:
+      - description: Display AHB clock from gcc
+      - description: Display AXI clock
+      - description: Display core clock
+
+  iommus:
+    maxItems: 2
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,sm6115-dpu
+
+  "^dsi@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,dsi-ctrl-6g-qcm2290
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,dsi-phy-14nm-2290
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm6115-dispcc.h>
+    #include <dt-bindings/clock/qcom,gcc-sm6115.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    mdss@5e00000 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        compatible = "qcom,sm6115-mdss";
+        reg = <0x05e00000 0x1000>;
+        reg-names = "mdss";
+        power-domains = <&dispcc MDSS_GDSC>;
+        clocks = <&gcc GCC_DISP_AHB_CLK>,
+                 <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+
+        interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        iommus = <&apps_smmu 0x420 0x2>,
+                 <&apps_smmu 0x421 0x0>;
+        ranges;
+
+        display-controller@5e01000 {
+            compatible = "qcom,sm6115-dpu";
+            reg = <0x05e01000 0x8f000>,
+                  <0x05eb0000 0x2008>;
+            reg-names = "mdp", "vbif";
+
+            clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+                     <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                     <&dispcc DISP_CC_MDSS_MDP_CLK>,
+                     <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+                     <&dispcc DISP_CC_MDSS_ROT_CLK>,
+                     <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+            clock-names = "bus", "iface", "core", "lut", "rot", "vsync";
+
+            operating-points-v2 = <&mdp_opp_table>;
+            power-domains = <&rpmpd SM6115_VDDCX>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dpu_intf1_out: endpoint {
+                        remote-endpoint = <&dsi0_in>;
+                    };
+                };
+            };
+        };
+
+        dsi@5e94000 {
+            compatible = "qcom,dsi-ctrl-6g-qcm2290";
+            reg = <0x05e94000 0x400>;
+            reg-names = "dsi_ctrl";
+
+            interrupt-parent = <&mdss>;
+            interrupts = <4>;
+
+            clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+                     <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+                     <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+                     <&dispcc DISP_CC_MDSS_ESC0_CLK>,
+                     <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                     <&gcc GCC_DISP_HF_AXI_CLK>;
+            clock-names = "byte",
+                          "byte_intf",
+                          "pixel",
+                          "core",
+                          "iface",
+                          "bus";
+            assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+            assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
+
+            operating-points-v2 = <&dsi_opp_table>;
+            power-domains = <&rpmpd SM6115_VDDCX>;
+            phys = <&dsi0_phy>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dsi0_in: endpoint {
+                        remote-endpoint = <&dpu_intf1_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    dsi0_out: endpoint {
+                    };
+                };
+            };
+        };
+
+        dsi0_phy: phy@5e94400 {
+            compatible = "qcom,dsi-phy-14nm-2290";
+            reg = <0x05e94400 0x100>,
+                  <0x05e94500 0x300>,
+                  <0x05e94800 0x188>;
+            reg-names = "dsi_phy",
+                        "dsi_phy_lane",
+                        "dsi_pll";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
+            clock-names = "iface", "ref";
+        };
+    };
+...
-- 
2.25.1

