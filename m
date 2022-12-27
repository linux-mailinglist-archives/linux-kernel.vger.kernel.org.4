Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83668656C06
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiL0OlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiL0OlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:41:10 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F24B7B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:41:06 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f34so19843793lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SlPdxJyvsPt8PpeCo1g/FF4zXXo1kMKqWIESrJA72+4=;
        b=Epuht4vXFPr+wFstaBnLphb6+mhQvGNH/rjcQR+R1aw3cBuFvKeGAPzQYakVPDYhNS
         WwAzKOZVEDt8S+bg2EelF02o9L/i8PIJLDrE/3kFtaKZ43ak+/kWwGIdT68gkHRHckVK
         OStytcCJSwo8WGkHUUo9N4anFwPFN5HJQ2eztFUcoPSEh3DZ6TiRqO9cz+1BD1e2J/f5
         NoTFezvIm5VQSYtATA2d0gV1BtrZuo/VFBDr+dN5gDlcinNNXEDOV+09+OpAIBp/ALAi
         ZgCvaV+fs0za1z15LYPUPjQO1KxklUEj3FJipUksn1dOfD4gegVIGX5E7gdpZaJ/Aflk
         rWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlPdxJyvsPt8PpeCo1g/FF4zXXo1kMKqWIESrJA72+4=;
        b=PxRD8ymSZUTr/0sxoX64zgQmPxhAfU/HWCLaZtUGSRu9WBz5qWQelL1j//Ol6sNjXJ
         8lPAbEeeUVg0SxUUB1gBiSOhQ0VGAryRsZXPAjXYXemgUkHoaP2r09kv3XRh94brzxTJ
         SIpuqIsaND6NtPjwlfCUw80MH2OfQHNXgIt8Ik7pJY+GsKo3XpxXKqAMDTVpfY+bNXHu
         y+ZTQ/6QpJlH8d49IJRECwiHIDZZWOZI5Rv7Ar4UcbA+JaSRBfBxYfPVi+ts7eJuU+M0
         RlSczGT2CsTE1BHyAHuawPVI60zTBWHF6tQ9fbb2/n3qAVxT7MZYT881NjIoGr4Q+nJ8
         pcHw==
X-Gm-Message-State: AFqh2kqWbPuCAYBC7mdQHpXw1GomuTdJDJYFNeoC/e91+D4a57eQOHqm
        wG6CWO/W0fLieGJjigxd10l1AQ==
X-Google-Smtp-Source: AMrXdXtEYQP3bj217RM9Pir6Mv12xtkPrCscc+E+rs65yhelZpUnmPrpNd5y1TGkscMzsT7BNKoq7g==
X-Received: by 2002:ac2:53a4:0:b0:4b5:9b7f:5a93 with SMTP id j4-20020ac253a4000000b004b59b7f5a93mr5641581lfh.59.1672152064623;
        Tue, 27 Dec 2022 06:41:04 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s1-20020a056512214100b004b5853f0fc6sm2261126lfr.246.2022.12.27.06.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:41:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/8] media: dt-bindings: qcom,venus: cleanup
Date:   Tue, 27 Dec 2022 15:40:55 +0100
Message-Id: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Cleanup the Qualcomm SoC Venus bindings:
 - Drop unneeded blank lines and quotes,
 - Fix indentation in example to 4-space (to match DT schema bindings
   style),
 - Add SoC name in each title.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/qcom,msm8916-venus.yaml    |  51 ++++----
 .../bindings/media/qcom,msm8996-venus.yaml    | 103 ++++++++---------
 .../bindings/media/qcom,sc7180-venus.yaml     |  61 +++++-----
 .../bindings/media/qcom,sc7280-venus.yaml     |  93 ++++++++-------
 .../bindings/media/qcom,sdm660-venus.yaml     | 109 +++++++++---------
 .../bindings/media/qcom,sdm845-venus-v2.yaml  |  71 ++++++------
 .../bindings/media/qcom,sdm845-venus.yaml     |  69 ++++++-----
 .../bindings/media/qcom,sm8250-venus.yaml     |  83 +++++++------
 8 files changed, 316 insertions(+), 324 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
index 2abb7d21c0d1..5c639e4232b3 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/media/qcom,msm8916-venus.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/media/qcom,msm8916-venus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Venus video encode and decode accelerators
+title: Qualcomm MSM8916 Venus video encode and decode accelerators
 
 maintainers:
   - Stanimir Varbanov <stanimir.varbanov@linaro.org>
@@ -97,26 +96,26 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        #include <dt-bindings/clock/qcom,gcc-msm8916.h>
-
-        video-codec@1d00000 {
-                compatible = "qcom,msm8916-venus";
-                reg = <0x01d00000 0xff000>;
-                interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-                clocks = <&gcc GCC_VENUS0_VCODEC0_CLK>,
-                        <&gcc GCC_VENUS0_AHB_CLK>,
-                        <&gcc GCC_VENUS0_AXI_CLK>;
-                clock-names = "core", "iface", "bus";
-                power-domains = <&gcc VENUS_GDSC>;
-                iommus = <&apps_iommu 5>;
-                memory-region = <&venus_mem>;
-
-                video-decoder {
-                        compatible = "venus-decoder";
-                };
-
-                video-encoder {
-                        compatible = "venus-encoder";
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,gcc-msm8916.h>
+
+    video-codec@1d00000 {
+        compatible = "qcom,msm8916-venus";
+        reg = <0x01d00000 0xff000>;
+        interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&gcc GCC_VENUS0_VCODEC0_CLK>,
+                 <&gcc GCC_VENUS0_AHB_CLK>,
+                 <&gcc GCC_VENUS0_AXI_CLK>;
+        clock-names = "core", "iface", "bus";
+        power-domains = <&gcc VENUS_GDSC>;
+        iommus = <&apps_iommu 5>;
+        memory-region = <&venus_mem>;
+
+        video-decoder {
+            compatible = "venus-decoder";
+        };
+
+        video-encoder {
+            compatible = "venus-encoder";
         };
+    };
diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
index 29d0cb6c6ebe..9254bfb90f5d 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/media/qcom,msm8996-venus.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/media/qcom,msm8996-venus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Venus video encode and decode accelerators
+title: Qualcomm MSM8996 Venus video encode and decode accelerators
 
 maintainers:
   - Stanimir Varbanov <stanimir.varbanov@linaro.org>
@@ -124,52 +123,52 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
-
-        video-codec@c00000 {
-                compatible = "qcom,msm8996-venus";
-                reg = <0x00c00000 0xff000>;
-                interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-                clocks = <&mmcc VIDEO_CORE_CLK>,
-                         <&mmcc VIDEO_AHB_CLK>,
-                         <&mmcc VIDEO_AXI_CLK>,
-                         <&mmcc VIDEO_MAXI_CLK>;
-                clock-names = "core", "iface", "bus", "mbus";
-                power-domains = <&mmcc VENUS_GDSC>;
-                iommus =  <&venus_smmu 0x00>,
-                          <&venus_smmu 0x01>,
-                          <&venus_smmu 0x0a>,
-                          <&venus_smmu 0x07>,
-                          <&venus_smmu 0x0e>,
-                          <&venus_smmu 0x0f>,
-                          <&venus_smmu 0x08>,
-                          <&venus_smmu 0x09>,
-                          <&venus_smmu 0x0b>,
-                          <&venus_smmu 0x0c>,
-                          <&venus_smmu 0x0d>,
-                          <&venus_smmu 0x10>,
-                          <&venus_smmu 0x11>,
-                          <&venus_smmu 0x21>,
-                          <&venus_smmu 0x28>,
-                          <&venus_smmu 0x29>,
-                          <&venus_smmu 0x2b>,
-                          <&venus_smmu 0x2c>,
-                          <&venus_smmu 0x2d>,
-                          <&venus_smmu 0x31>;
-                memory-region = <&venus_mem>;
-
-                video-decoder {
-                        compatible = "venus-decoder";
-                        clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
-                        clock-names = "core";
-                        power-domains = <&mmcc VENUS_CORE0_GDSC>;
-                };
-
-                video-encoder {
-                        compatible = "venus-encoder";
-                        clocks = <&mmcc VIDEO_SUBCORE1_CLK>;
-                        clock-names = "core";
-                        power-domains = <&mmcc VENUS_CORE1_GDSC>;
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
+
+    video-codec@c00000 {
+        compatible = "qcom,msm8996-venus";
+        reg = <0x00c00000 0xff000>;
+        interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&mmcc VIDEO_CORE_CLK>,
+                 <&mmcc VIDEO_AHB_CLK>,
+                 <&mmcc VIDEO_AXI_CLK>,
+                 <&mmcc VIDEO_MAXI_CLK>;
+        clock-names = "core", "iface", "bus", "mbus";
+        power-domains = <&mmcc VENUS_GDSC>;
+        iommus =  <&venus_smmu 0x00>,
+                  <&venus_smmu 0x01>,
+                  <&venus_smmu 0x0a>,
+                  <&venus_smmu 0x07>,
+                  <&venus_smmu 0x0e>,
+                  <&venus_smmu 0x0f>,
+                  <&venus_smmu 0x08>,
+                  <&venus_smmu 0x09>,
+                  <&venus_smmu 0x0b>,
+                  <&venus_smmu 0x0c>,
+                  <&venus_smmu 0x0d>,
+                  <&venus_smmu 0x10>,
+                  <&venus_smmu 0x11>,
+                  <&venus_smmu 0x21>,
+                  <&venus_smmu 0x28>,
+                  <&venus_smmu 0x29>,
+                  <&venus_smmu 0x2b>,
+                  <&venus_smmu 0x2c>,
+                  <&venus_smmu 0x2d>,
+                  <&venus_smmu 0x31>;
+        memory-region = <&venus_mem>;
+
+        video-decoder {
+            compatible = "venus-decoder";
+            clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
+            clock-names = "core";
+            power-domains = <&mmcc VENUS_CORE0_GDSC>;
+        };
+
+        video-encoder {
+            compatible = "venus-encoder";
+            clocks = <&mmcc VIDEO_SUBCORE1_CLK>;
+            clock-names = "core";
+            power-domains = <&mmcc VENUS_CORE1_GDSC>;
         };
+    };
diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
index 42ee3f06c6be..460e9048a034 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/media/qcom,sc7180-venus.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/media/qcom,sc7180-venus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Venus video encode and decode accelerators
+title: Qualcomm SC7180 Venus video encode and decode accelerators
 
 maintainers:
   - Stanimir Varbanov <stanimir.varbanov@linaro.org>
@@ -116,31 +115,31 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        #include <dt-bindings/clock/qcom,videocc-sc7180.h>
-
-        venus: video-codec@aa00000 {
-                compatible = "qcom,sc7180-venus";
-                reg = <0x0aa00000 0xff000>;
-                interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-                power-domains = <&videocc VENUS_GDSC>,
-                                <&videocc VCODEC0_GDSC>;
-                power-domain-names = "venus", "vcodec0";
-                clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
-                         <&videocc VIDEO_CC_VENUS_AHB_CLK>,
-                         <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
-                         <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
-                         <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
-                clock-names = "core", "iface", "bus",
-                              "vcodec0_core", "vcodec0_bus";
-                iommus = <&apps_smmu 0x0c00 0x60>;
-                memory-region = <&venus_mem>;
-
-                video-decoder {
-                        compatible = "venus-decoder";
-                };
-
-                video-encoder {
-                        compatible = "venus-encoder";
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,videocc-sc7180.h>
+
+    venus: video-codec@aa00000 {
+        compatible = "qcom,sc7180-venus";
+        reg = <0x0aa00000 0xff000>;
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&videocc VENUS_GDSC>,
+                        <&videocc VCODEC0_GDSC>;
+        power-domain-names = "venus", "vcodec0";
+        clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
+                 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
+                 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
+                 <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
+                 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
+        clock-names = "core", "iface", "bus",
+                      "vcodec0_core", "vcodec0_bus";
+        iommus = <&apps_smmu 0x0c00 0x60>;
+        memory-region = <&venus_mem>;
+
+        video-decoder {
+            compatible = "venus-decoder";
+        };
+
+        video-encoder {
+            compatible = "venus-encoder";
         };
+    };
diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
index cf361dd9de08..0055bd2a3379 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/media/qcom,sc7280-venus.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/media/qcom,sc7280-venus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Venus video encode and decode accelerators
+title: Qualcomm SC7280 Venus video encode and decode accelerators
 
 maintainers:
   - Stanimir Varbanov <stanimir.varbanov@linaro.org>
@@ -116,47 +115,47 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        #include <dt-bindings/clock/qcom,videocc-sc7280.h>
-        #include <dt-bindings/interconnect/qcom,sc7280.h>
-        #include <dt-bindings/power/qcom-rpmpd.h>
-
-        venus: video-codec@aa00000 {
-                compatible = "qcom,sc7280-venus";
-                reg = <0x0aa00000 0xd0600>;
-                interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-
-                clocks = <&videocc VIDEO_CC_MVSC_CORE_CLK>,
-                         <&videocc VIDEO_CC_MVSC_CTL_AXI_CLK>,
-                         <&videocc VIDEO_CC_VENUS_AHB_CLK>,
-                         <&videocc VIDEO_CC_MVS0_CORE_CLK>,
-                         <&videocc VIDEO_CC_MVS0_AXI_CLK>;
-                clock-names = "core", "bus", "iface",
-                              "vcodec_core", "vcodec_bus";
-
-                power-domains = <&videocc MVSC_GDSC>,
-                                <&videocc MVS0_GDSC>,
-                                <&rpmhpd SC7280_CX>;
-                power-domain-names = "venus", "vcodec0", "cx";
-
-                interconnects = <&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_VENUS_CFG 0>,
-                                <&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>;
-                interconnect-names = "cpu-cfg", "video-mem";
-
-                iommus = <&apps_smmu 0x2180 0x20>,
-                         <&apps_smmu 0x2184 0x20>;
-
-                memory-region = <&video_mem>;
-
-                video-decoder {
-                        compatible = "venus-decoder";
-                };
-
-                video-encoder {
-                        compatible = "venus-encoder";
-                };
-
-                video-firmware {
-                        iommus = <&apps_smmu 0x21a2 0x0>;
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,videocc-sc7280.h>
+    #include <dt-bindings/interconnect/qcom,sc7280.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    venus: video-codec@aa00000 {
+        compatible = "qcom,sc7280-venus";
+        reg = <0x0aa00000 0xd0600>;
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&videocc VIDEO_CC_MVSC_CORE_CLK>,
+                 <&videocc VIDEO_CC_MVSC_CTL_AXI_CLK>,
+                 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
+                 <&videocc VIDEO_CC_MVS0_CORE_CLK>,
+                 <&videocc VIDEO_CC_MVS0_AXI_CLK>;
+        clock-names = "core", "bus", "iface",
+                      "vcodec_core", "vcodec_bus";
+
+        power-domains = <&videocc MVSC_GDSC>,
+                        <&videocc MVS0_GDSC>,
+                        <&rpmhpd SC7280_CX>;
+        power-domain-names = "venus", "vcodec0", "cx";
+
+        interconnects = <&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_VENUS_CFG 0>,
+                        <&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>;
+        interconnect-names = "cpu-cfg", "video-mem";
+
+        iommus = <&apps_smmu 0x2180 0x20>,
+                 <&apps_smmu 0x2184 0x20>;
+
+        memory-region = <&video_mem>;
+
+        video-decoder {
+            compatible = "venus-decoder";
+        };
+
+        video-encoder {
+            compatible = "venus-encoder";
+        };
+
+        video-firmware {
+            iommus = <&apps_smmu 0x21a2 0x0>;
         };
+    };
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
index 45e3f58f52bd..0ebe4341d41f 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/media/qcom,sdm660-venus.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/media/qcom,sdm660-venus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Venus video encode and decode accelerators
+title: Qualcomm SDM660 Venus video encode and decode accelerators
 
 maintainers:
   - Stanimir Varbanov <stanimir.varbanov@linaro.org>
@@ -133,55 +132,55 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-
-        video-codec@cc00000 {
-                compatible = "qcom,sdm660-venus";
-                reg = <0x0cc00000 0xff000>;
-                clocks = <&mmcc VIDEO_CORE_CLK>,
-                         <&mmcc VIDEO_AHB_CLK>,
-                         <&mmcc VIDEO_AXI_CLK>,
-                         <&mmcc THROTTLE_VIDEO_AXI_CLK>;
-                clock-names = "core", "iface", "bus", "bus_throttle";
-                interconnects = <&gnoc 0 &mnoc 13>,
-                                <&mnoc 4 &bimc 5>;
-                interconnect-names = "cpu-cfg", "video-mem";
-                interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-                iommus = <&mmss_smmu 0x400>,
-                         <&mmss_smmu 0x401>,
-                         <&mmss_smmu 0x40a>,
-                         <&mmss_smmu 0x407>,
-                         <&mmss_smmu 0x40e>,
-                         <&mmss_smmu 0x40f>,
-                         <&mmss_smmu 0x408>,
-                         <&mmss_smmu 0x409>,
-                         <&mmss_smmu 0x40b>,
-                         <&mmss_smmu 0x40c>,
-                         <&mmss_smmu 0x40d>,
-                         <&mmss_smmu 0x410>,
-                         <&mmss_smmu 0x421>,
-                         <&mmss_smmu 0x428>,
-                         <&mmss_smmu 0x429>,
-                         <&mmss_smmu 0x42b>,
-                         <&mmss_smmu 0x42c>,
-                         <&mmss_smmu 0x42d>,
-                         <&mmss_smmu 0x411>,
-                         <&mmss_smmu 0x431>;
-                memory-region = <&venus_region>;
-                power-domains = <&mmcc VENUS_GDSC>;
-
-                video-decoder {
-                        compatible = "venus-decoder";
-                        clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
-                        clock-names = "vcodec0_core";
-                        power-domains = <&mmcc VENUS_CORE0_GDSC>;
-                };
-
-                video-encoder {
-                        compatible = "venus-encoder";
-                        clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
-                        clock-names = "vcodec0_core";
-                        power-domains = <&mmcc VENUS_CORE0_GDSC>;
-                };
+    #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    video-codec@cc00000 {
+        compatible = "qcom,sdm660-venus";
+        reg = <0x0cc00000 0xff000>;
+        clocks = <&mmcc VIDEO_CORE_CLK>,
+                 <&mmcc VIDEO_AHB_CLK>,
+                 <&mmcc VIDEO_AXI_CLK>,
+                 <&mmcc THROTTLE_VIDEO_AXI_CLK>;
+        clock-names = "core", "iface", "bus", "bus_throttle";
+        interconnects = <&gnoc 0 &mnoc 13>,
+                        <&mnoc 4 &bimc 5>;
+        interconnect-names = "cpu-cfg", "video-mem";
+        interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+        iommus = <&mmss_smmu 0x400>,
+                 <&mmss_smmu 0x401>,
+                 <&mmss_smmu 0x40a>,
+                 <&mmss_smmu 0x407>,
+                 <&mmss_smmu 0x40e>,
+                 <&mmss_smmu 0x40f>,
+                 <&mmss_smmu 0x408>,
+                 <&mmss_smmu 0x409>,
+                 <&mmss_smmu 0x40b>,
+                 <&mmss_smmu 0x40c>,
+                 <&mmss_smmu 0x40d>,
+                 <&mmss_smmu 0x410>,
+                 <&mmss_smmu 0x421>,
+                 <&mmss_smmu 0x428>,
+                 <&mmss_smmu 0x429>,
+                 <&mmss_smmu 0x42b>,
+                 <&mmss_smmu 0x42c>,
+                 <&mmss_smmu 0x42d>,
+                 <&mmss_smmu 0x411>,
+                 <&mmss_smmu 0x431>;
+        memory-region = <&venus_region>;
+        power-domains = <&mmcc VENUS_GDSC>;
+
+        video-decoder {
+            compatible = "venus-decoder";
+            clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
+            clock-names = "vcodec0_core";
+            power-domains = <&mmcc VENUS_CORE0_GDSC>;
+        };
+
+        video-encoder {
+            compatible = "venus-encoder";
+            clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
+            clock-names = "vcodec0_core";
+            power-domains = <&mmcc VENUS_CORE0_GDSC>;
         };
+    };
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
index 8edc8a2f43a5..639837724d01 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/media/qcom,sdm845-venus-v2.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/media/qcom,sdm845-venus-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Venus video encode and decode accelerators
+title: Qualcomm SDM845 Venus v2 video encode and decode accelerators
 
 maintainers:
   - Stanimir Varbanov <stanimir.varbanov@linaro.org>
@@ -111,36 +110,36 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        #include <dt-bindings/clock/qcom,videocc-sdm845.h>
-
-        video-codec@aa00000 {
-                compatible = "qcom,sdm845-venus-v2";
-                reg = <0x0aa00000 0xff000>;
-                interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-                clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
-                         <&videocc VIDEO_CC_VENUS_AHB_CLK>,
-                         <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
-                         <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
-                         <&videocc VIDEO_CC_VCODEC0_AXI_CLK>,
-                         <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
-                         <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
-                clock-names = "core", "iface", "bus",
-                              "vcodec0_core", "vcodec0_bus",
-                              "vcodec1_core", "vcodec1_bus";
-                power-domains = <&videocc VENUS_GDSC>,
-                                <&videocc VCODEC0_GDSC>,
-                                <&videocc VCODEC1_GDSC>;
-                power-domain-names = "venus", "vcodec0", "vcodec1";
-                iommus = <&apps_smmu 0x10a0 0x8>,
-                         <&apps_smmu 0x10b0 0x0>;
-                memory-region = <&venus_mem>;
-
-                video-core0 {
-                        compatible = "venus-decoder";
-                };
-
-                video-core1 {
-                        compatible = "venus-encoder";
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,videocc-sdm845.h>
+
+    video-codec@aa00000 {
+        compatible = "qcom,sdm845-venus-v2";
+        reg = <0x0aa00000 0xff000>;
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
+                 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
+                 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
+                 <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
+                 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>,
+                 <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
+                 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
+        clock-names = "core", "iface", "bus",
+                      "vcodec0_core", "vcodec0_bus",
+                      "vcodec1_core", "vcodec1_bus";
+        power-domains = <&videocc VENUS_GDSC>,
+                        <&videocc VCODEC0_GDSC>,
+                        <&videocc VCODEC1_GDSC>;
+        power-domain-names = "venus", "vcodec0", "vcodec1";
+        iommus = <&apps_smmu 0x10a0 0x8>,
+                 <&apps_smmu 0x10b0 0x0>;
+        memory-region = <&venus_mem>;
+
+        video-core0 {
+            compatible = "venus-decoder";
+        };
+
+        video-core1 {
+            compatible = "venus-encoder";
         };
+    };
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
index 57d503373efe..5f73eb76b02e 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/media/qcom,sdm845-venus.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/media/qcom,sdm845-venus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Venus video encode and decode accelerators
+title: Qualcomm SDM845 Venus video encode and decode accelerators
 
 maintainers:
   - Stanimir Varbanov <stanimir.varbanov@linaro.org>
@@ -125,35 +124,35 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        #include <dt-bindings/clock/qcom,videocc-sdm845.h>
-
-        video-codec@aa00000 {
-                compatible = "qcom,sdm845-venus";
-                reg = <0x0aa00000 0xff000>;
-                interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-                clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
-                         <&videocc VIDEO_CC_VENUS_AHB_CLK>,
-                         <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
-                clock-names = "core", "iface", "bus";
-                power-domains = <&videocc VENUS_GDSC>;
-                iommus = <&apps_smmu 0x10a0 0x8>,
-                         <&apps_smmu 0x10b0 0x0>;
-                memory-region = <&venus_mem>;
-
-                video-core0 {
-                        compatible = "venus-decoder";
-                        clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
-                                 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
-                        clock-names = "core", "bus";
-                        power-domains = <&videocc VCODEC0_GDSC>;
-                };
-
-                video-core1 {
-                        compatible = "venus-encoder";
-                        clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
-                                 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
-                        clock-names = "core", "bus";
-                        power-domains = <&videocc VCODEC1_GDSC>;
-                };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,videocc-sdm845.h>
+
+    video-codec@aa00000 {
+        compatible = "qcom,sdm845-venus";
+        reg = <0x0aa00000 0xff000>;
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
+                 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
+                 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
+        clock-names = "core", "iface", "bus";
+        power-domains = <&videocc VENUS_GDSC>;
+        iommus = <&apps_smmu 0x10a0 0x8>,
+                 <&apps_smmu 0x10b0 0x0>;
+        memory-region = <&venus_mem>;
+
+        video-core0 {
+            compatible = "venus-decoder";
+            clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
+                     <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
+            clock-names = "core", "bus";
+            power-domains = <&videocc VCODEC0_GDSC>;
+        };
+
+        video-core1 {
+            compatible = "venus-encoder";
+            clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
+                     <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
+            clock-names = "core", "bus";
+            power-domains = <&videocc VCODEC1_GDSC>;
         };
+    };
diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
index 4b7a12523dcf..cc68b2a263d4 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/media/qcom,sm8250-venus.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/media/qcom,sm8250-venus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Venus video encode and decode accelerators
+title: Qualcomm SM8250 Venus video encode and decode accelerators
 
 maintainers:
   - Stanimir Varbanov <stanimir.varbanov@linaro.org>
@@ -126,42 +125,42 @@ additionalProperties: false
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        #include <dt-bindings/clock/qcom,videocc-sm8250.h>
-        #include <dt-bindings/interconnect/qcom,sm8250.h>
-        #include <dt-bindings/clock/qcom,gcc-sm8250.h>
-        #include <dt-bindings/power/qcom-rpmpd.h>
-
-        venus: video-codec@aa00000 {
-            compatible = "qcom,sm8250-venus";
-            reg = <0x0aa00000 0xff000>;
-            interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-            power-domains = <&videocc MVS0C_GDSC>,
-                            <&videocc MVS0_GDSC>,
-                            <&rpmhpd SM8250_MX>;
-            power-domain-names = "venus", "vcodec0", "mx";
-
-            clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
-                     <&videocc VIDEO_CC_MVS0C_CLK>,
-                     <&videocc VIDEO_CC_MVS0_CLK>;
-            clock-names = "iface", "core", "vcodec0_core";
-
-            interconnects = <&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_VENUS_CFG>,
-                            <&mmss_noc MASTER_VIDEO_P0 &mc_virt SLAVE_EBI_CH0>;
-            interconnect-names = "cpu-cfg", "video-mem";
-
-            iommus = <&apps_smmu 0x2100 0x0400>;
-            memory-region = <&video_mem>;
-
-            resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
-                     <&videocc VIDEO_CC_MVS0C_CLK_ARES>;
-            reset-names = "bus", "core";
-
-            video-decoder {
-                compatible = "venus-decoder";
-            };
-
-            video-encoder {
-                compatible = "venus-encoder";
-            };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,videocc-sm8250.h>
+    #include <dt-bindings/interconnect/qcom,sm8250.h>
+    #include <dt-bindings/clock/qcom,gcc-sm8250.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    venus: video-codec@aa00000 {
+        compatible = "qcom,sm8250-venus";
+        reg = <0x0aa00000 0xff000>;
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&videocc MVS0C_GDSC>,
+                        <&videocc MVS0_GDSC>,
+                        <&rpmhpd SM8250_MX>;
+        power-domain-names = "venus", "vcodec0", "mx";
+
+        clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+                 <&videocc VIDEO_CC_MVS0C_CLK>,
+                 <&videocc VIDEO_CC_MVS0_CLK>;
+        clock-names = "iface", "core", "vcodec0_core";
+
+        interconnects = <&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_VENUS_CFG>,
+                        <&mmss_noc MASTER_VIDEO_P0 &mc_virt SLAVE_EBI_CH0>;
+        interconnect-names = "cpu-cfg", "video-mem";
+
+        iommus = <&apps_smmu 0x2100 0x0400>;
+        memory-region = <&video_mem>;
+
+        resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
+                 <&videocc VIDEO_CC_MVS0C_CLK_ARES>;
+        reset-names = "bus", "core";
+
+        video-decoder {
+            compatible = "venus-decoder";
+        };
+
+        video-encoder {
+            compatible = "venus-encoder";
         };
+    };
-- 
2.34.1

