Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEAD629A83
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbiKONc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbiKONbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:31:45 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B649D27B0A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n20so15437247ejh.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHD2OBh6kLEwPWGhP5DZG0K5YY+cgkvailhPyjxhlmE=;
        b=PAvyCI8aBPIYuJU9qCEqdRSvJfgXnizMD20sY3fPTGR2BlsxycliQ6wf+TRXOpVzpM
         uD1KbCALtS2zTpIG6M6T2aiPuCLCVCAA+9l6FmRMVo7EVJWrC2avlqr4MPVIxSP/lqA9
         WBhXuR4RR0QBcsCNr8U5sPSbntAPpQfj2BUCY83HQnD53X/fd1RhaD7yuCnmdAYdF62Y
         eDA6XHkCNZMSm06ZN3O5lPrcxTNr8CiBGkhisVom+pClTj/CCYCAhQx/SYv3lUB2R5jO
         TIb/GaOZLYDuKVryN8NRCoM5TuctOkzFo28ocKGhYzfNKmNpYOsQzZxSJeg9gaBr7SQy
         Appw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHD2OBh6kLEwPWGhP5DZG0K5YY+cgkvailhPyjxhlmE=;
        b=a94oNHB8Gwxy1wwgM1CE+TJJpMCkH9YmpC5L0I9MqVr6V86wGz2BXIyDRZk/MjuAoO
         K39I9UyPE+NRJXY1oFiwlG3dj3EEQd1qfC3rZN2HysDp+1WrhnJhDDKFSk+YAMbJSUqk
         Vxo6FOFPqgyLIB4Ici5DrU2SG/+aEpj43OQyKBQRIRSJ+ko7252+ceHY8gghvQniIzvG
         FOU0VxILzLlOduNyeu8Iy6LseP5oFtd8pBSwsSG/GVRgTUGBPuw0G5mWFxVzSpshPbxC
         QWxmDBdALCdz6pYcb5C5iw0ZtIqbXEDsG8FTxtprovH1ClFgHfhT95/tEUZwWT/8NveE
         7iuQ==
X-Gm-Message-State: ANoB5pm4xxkLqePI093lEn532++RVIJbEfdXyaRB/ognghvspAytNLeA
        E3ShZyhTv/RYkOOesRYx+Dotug==
X-Google-Smtp-Source: AA0mqf6nZMcXtttESIT9HecMt93I091UuGJJk6dQ7GYebrKZq631Om4yisX50hL5bsy6ak8dzAt76g==
X-Received: by 2002:a17:907:cca7:b0:7ae:3b9e:1d8a with SMTP id up39-20020a170907cca700b007ae3b9e1d8amr13193876ejc.581.1668519093952;
        Tue, 15 Nov 2022 05:31:33 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7d456000000b004618f2127d2sm6162176edr.57.2022.11.15.05.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:31:33 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        robert.foss@linaro.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
Subject: [PATCH v2 10/12] arm64: dts: qcom: sm8350: Add display system nodes
Date:   Tue, 15 Nov 2022 14:31:03 +0100
Message-Id: <20221115133105.980877-11-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115133105.980877-1-robert.foss@linaro.org>
References: <20221115133105.980877-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mdss, mdss_mdp, dsi0, dsi0_phy nodes. With these
nodes the display subsystem is configured to support
one DSI output.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 197 ++++++++++++++++++++++++++-
 1 file changed, 193 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 434f8e8b12c1..5c98e5cf5ad0 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2020, Linaro Limited
  */
 
+#include <dt-bindings/interconnect/qcom,sm8350.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,dispcc-sm8350.h>
 #include <dt-bindings/clock/qcom,gcc-sm8350.h>
@@ -2536,14 +2537,201 @@ usb_2_dwc3: usb@a800000 {
 			};
 		};
 
+		mdss: mdss@ae00000 {
+			compatible = "qcom,sm8350-mdss";
+			reg = <0 0x0ae00000 0 0x1000>;
+			reg-names = "mdss";
+
+			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
+					<&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "mdp0-mem", "mdp1-mem";
+
+			power-domains = <&dispcc MDSS_GDSC>;
+			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
+
+			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&gcc GCC_DISP_SF_AXI_CLK>,
+				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+			clock-names = "iface", "bus", "nrt_bus", "core";
+
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			iommus = <&apps_smmu 0x820 0x402>;
+
+			status = "disabled";
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			mdss_mdp: display-controller@ae01000 {
+				compatible = "qcom,sm8350-dpu";
+				reg = <0 0x0ae01000 0 0x8f000>,
+				      <0 0x0aeb0000 0 0x2008>;
+				reg-names = "mdp", "vbif";
+
+				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+					<&gcc GCC_DISP_SF_AXI_CLK>,
+					<&dispcc DISP_CC_MDSS_AHB_CLK>,
+					<&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+					<&dispcc DISP_CC_MDSS_MDP_CLK>,
+					<&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "bus",
+					      "nrt_bus",
+					      "iface",
+					      "lut",
+					      "core",
+					      "vsync";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <19200000>;
+
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmhpd SM8350_MMCX>;
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dpu_intf1_out: endpoint {
+							remote-endpoint = <&dsi0_in>;
+						};
+					};
+				};
+
+				mdp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-200000000 {
+						opp-hz = /bits/ 64 <200000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-300000000 {
+						opp-hz = /bits/ 64 <300000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-345000000 {
+						opp-hz = /bits/ 64 <345000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-460000000 {
+						opp-hz = /bits/ 64 <460000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
+			dsi0: dsi@ae94000 {
+				compatible = "qcom,mdss-dsi-ctrl";
+				reg = <0 0x0ae94000 0 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4>;
+
+				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+					 <&dispcc DISP_CC_MDSS_ESC0_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&gcc GCC_DISP_HF_AXI_CLK>;
+				clock-names = "byte",
+					      "byte_intf",
+					      "pixel",
+					      "core",
+					      "iface",
+					      "bus";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&dsi0_phy 0>,
+							 <&dsi0_phy 1>;
+
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmhpd SM8350_MMCX>;
+
+				phys = <&dsi0_phy>;
+				phy-names = "dsi";
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dsi0_in: endpoint {
+							remote-endpoint = <&dpu_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dsi0_out: endpoint {
+						};
+					};
+				};
+			};
+
+			dsi0_phy: phy@ae94400 {
+				compatible = "qcom,dsi-phy-5nm-8350";
+				reg = <0 0x0ae94400 0 0x200>,
+				      <0 0x0ae94600 0 0x280>,
+				      <0 0x0ae94900 0 0x260>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmhcc RPMH_CXO_CLK>;
+				clock-names = "iface", "ref";
+
+				status = "disabled";
+
+				dsi_opp_table: dsi-opp-table {
+					compatible = "operating-points-v2";
+
+					opp-187500000 {
+						opp-hz = /bits/ 64 <187500000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-300000000 {
+						opp-hz = /bits/ 64 <300000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-358000000 {
+						opp-hz = /bits/ 64 <358000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+				};
+			};
+		};
+
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sm8350-dispcc";
 			reg = <0 0x0af00000 0 0x10000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
+				 <&dsi0_phy 0>, <&dsi0_phy 1>,
+				 <0>, <0>,
 				 <0>,
 				 <0>;
 			clock-names = "bi_tcxo",
@@ -2558,6 +2746,7 @@ dispcc: clock-controller@af00000 {
 			#power-domain-cells = <1>;
 
 			power-domains = <&rpmhpd SM8350_MMCX>;
+			required-opps = <&rpmhpd_opp_turbo>;
 		};
 
 		adsp: remoteproc@17300000 {
-- 
2.34.1

