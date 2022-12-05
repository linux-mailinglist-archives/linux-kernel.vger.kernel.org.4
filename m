Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD27642D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiLEQjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiLEQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:39:17 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFC71EC62
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:38:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id td2so29151615ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO3cf7ELE8VZsDkOe+RWJcSBHW9hBBZN8aOD3+5Q1zI=;
        b=fN3jg/aJn5llMlzmPJj6ui3qB723UwxmbOM+4CTWv24S98GhtWKlByke3D2Nxrl2bz
         dnspukAsGYMtV5ez0ZpMPWCxEMYkCprZRnyKQkYDZzodgvmN61hc2k+HNKetAhFeQzbR
         EatjDrIWQ8B9lf8Kti3DTYFhvkRhx3h7ZVjnPY8fSbXsfc7KsE3x5wIlX+CZhFL0yeEe
         yTyu9f2vEs8W9irLVIWlIMg8u78hO27JsJSMgh7rzbrmfODBkKpADoh4YV2ANifFVVaz
         i/jYeMBgs46Xhs42h3i5Cv8vS4buHufwTeKeBnHG1cAvtbCAe6NsUkH4783ey5BZwL+p
         NUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CO3cf7ELE8VZsDkOe+RWJcSBHW9hBBZN8aOD3+5Q1zI=;
        b=SdZTt6xbkMi8Zx4X/qDrhDhz8jHepbZxhtKa3QpskWYFgC6blN1Z7tCwXjYDkSA+w3
         48yjx+TnWheSj6f3NHhBZrmcbnrg2xE7XH2yvExVm3yV9YoIkMTfcxtGl+QsQxghaIix
         zcseD2YGs9aGesa2q7hipH24UuXByJI5JOC2TgPmsjnrX9j6475ZhKX21RnVheluzCNg
         NkJz5j8m04NVvbKgD8AlYr6Y1BnC9OIfEM4+KqRnJEzELvzHTDosngHov4Tp97HffOYh
         cOGltieyZDiYtcYjlE8cTVxk/FCnlDZGGE0tdVdgHYuJLq00EaapzqaMDRb+CTzHWT/u
         58bA==
X-Gm-Message-State: ANoB5pkK6d5KcR315eRzHGAzcPj35Jc2ZmeLFypeFVq2rZWF9YvvpuCO
        mhBS8bPAxK56NwL+dVjNR3UZKw==
X-Google-Smtp-Source: AA0mqf43S7ST/DGklLvSf3VA1xvjC3VtlE3soZSLIZ68/qqHKNNXk9yn7HHZBCeKv6TKR5O5ba8FIA==
X-Received: by 2002:a17:907:7ba2:b0:7c0:d08f:1d9a with SMTP id ne34-20020a1709077ba200b007c0d08f1d9amr10648949ejc.701.1670258281111;
        Mon, 05 Dec 2022 08:38:01 -0800 (PST)
Received: from prec5560.localdomain (ip5f58f364.dynamic.kabel-deutschland.de. [95.88.243.100])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906315500b007bed316a6d9sm6413610eje.18.2022.12.05.08.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:38:00 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, angelogioacchino.delregno@somainline.org,
        robert.foss@linaro.org, loic.poulain@linaro.org,
        swboyd@chromium.org, quic_vpolimer@quicinc.com, vkoul@kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com, andersson@kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v3 01/11] dt-bindings: display: msm: Add qcom,sm8350-dpu binding
Date:   Mon,  5 Dec 2022 17:37:44 +0100
Message-Id: <20221205163754.221139-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205163754.221139-1-robert.foss@linaro.org>
References: <20221205163754.221139-1-robert.foss@linaro.org>
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

Mobile Display Subsystem (MDSS) encapsulates sub-blocks
like DPU display controller, DSI etc. Add YAML schema for DPU device
tree bindings

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/msm/qcom,sm8350-dpu.yaml | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
new file mode 100644
index 000000000000..120500395c9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,sm8350-dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8350 Display DPU
+
+maintainers:
+  - Robert Foss <robert.foss@linaro.org>
+
+$ref: /schemas/display/msm/dpu-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm8350-dpu
+
+  reg:
+    items:
+      - description: Address offset and size for mdp register set
+      - description: Address offset and size for vbif register set
+
+  reg-names:
+    items:
+      - const: mdp
+      - const: vbif
+
+  clocks:
+    items:
+      - description: Display hf axi clock
+      - description: Display sf axi clock
+      - description: Display ahb clock
+      - description: Display lut clock
+      - description: Display core clock
+      - description: Display vsync clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: nrt_bus
+      - const: iface
+      - const: lut
+      - const: core
+      - const: vsync
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,dispcc-sm8350.h>
+    #include <dt-bindings/clock/qcom,gcc-sm8350.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interconnect/qcom,sm8350.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    display-controller@ae01000 {
+        compatible = "qcom,sm8350-dpu";
+        reg = <0x0ae01000 0x8f000>,
+              <0x0aeb0000 0x2008>;
+        reg-names = "mdp", "vbif";
+
+        clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&gcc GCC_DISP_SF_AXI_CLK>,
+                 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+                 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+        clock-names = "bus",
+                      "nrt_bus",
+                      "iface",
+                      "lut",
+                      "core",
+                      "vsync";
+
+        assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+        assigned-clock-rates = <19200000>;
+
+        operating-points-v2 = <&mdp_opp_table>;
+        power-domains = <&rpmhpd SM8350_MMCX>;
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
+                dpu_intf1_out: endpoint {
+                    remote-endpoint = <&dsi0_in>;
+                };
+            };
+        };
+
+        mdp_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-200000000 {
+                opp-hz = /bits/ 64 <200000000>;
+                required-opps = <&rpmhpd_opp_low_svs>;
+            };
+
+            opp-300000000 {
+                opp-hz = /bits/ 64 <300000000>;
+                required-opps = <&rpmhpd_opp_svs>;
+            };
+
+            opp-345000000 {
+                opp-hz = /bits/ 64 <345000000>;
+                required-opps = <&rpmhpd_opp_svs_l1>;
+            };
+
+            opp-460000000 {
+                opp-hz = /bits/ 64 <460000000>;
+                required-opps = <&rpmhpd_opp_nom>;
+            };
+        };
+    };
+...
-- 
2.34.1

