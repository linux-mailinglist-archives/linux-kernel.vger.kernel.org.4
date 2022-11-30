Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19C63E182
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiK3UM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiK3ULx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:11:53 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45B34E68F;
        Wed, 30 Nov 2022 12:10:25 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z24so22173776ljn.4;
        Wed, 30 Nov 2022 12:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l55ZSpBSaEScUKVcaRYy5noOFCbwMf6AS4fim9mYDzU=;
        b=hX9Qc/69PdTYELzcvIONcTmgLCM1MCfDI8JC5rXsA12fgwJi8rJ/GgV8Anv3/iwMjO
         CGp8W8/Fg4RGFOwA1y3NTdq7sxLks1VQhAWeg737e2KRB6981vduvpwKAn8LcTkB37pr
         0U2W9/gdvRbJwdpjW9b+mcMLT0tT+l6A/tqVo4IDV56QRMVvqgiUO6tpqaTrhpkvRQzE
         BzfFQJ+3xj3fs1h2dwDDofVpmfCRp21MnTxKRFnGcqcawvbdXLHuOWDaWRlC1c4Gk1Mx
         6Vm51bA4Kdr7ORaVUtBAKaegltoZeApXfmTnrHDnOpn9CWLp4PV/2fUQOtniDo454NhW
         qxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l55ZSpBSaEScUKVcaRYy5noOFCbwMf6AS4fim9mYDzU=;
        b=HIFj8UxEwAbJ4Qf7H+Mva0Re/pqxOK+wsodt9L5Ucu0DQC9QZXSGUjsisMbbXODO14
         ayxH/x/TvYtJ8QGd7cgYWXJ7mpFUErNBv35BKV0cffoTEZfS6ZhcnNf0aUXbzKLn1izx
         rPerhkLirFt3e36CDZjvJsJlNUppAbwGL2cmr1taGRXVaMmi6cxkvG8gJT6hL5tP4nEJ
         D4n38bkOGPysrNvPVUG7UNpGII/RKfkkJAslRZHsMzv9yP/d87eGFRTN284dVNqUYf2k
         GYHj8eTEbmrevfktIL6DBIGVbJUeuqZUJcP6GRXk3UcnT9pX4KSZGcJ+ZwNqb/ZNWQ6M
         OSGQ==
X-Gm-Message-State: ANoB5ploDz+sGKFURemXd1ABWc2kkudz/Hb2riNE6oSNhLtTyGfkg6rf
        EFtpj5TGbUQk7HfTV41nlXy9dsHD92o=
X-Google-Smtp-Source: AA0mqf4N1MjwsUqz/qkPXY6Rb3zUqkrXqdkjaerUFav9rNOyY5/vWSnsxuY0T/WDHWeX58U2Kr+D0w==
X-Received: by 2002:a05:651c:1590:b0:279:dfe:897a with SMTP id h16-20020a05651c159000b002790dfe897amr21130009ljq.365.1669839014480;
        Wed, 30 Nov 2022 12:10:14 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:10:14 -0800 (PST)
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
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 08/12] arm64: dts: qcom: sm6115: Add mdss/dpu node
Date:   Wed, 30 Nov 2022 21:09:46 +0100
Message-Id: <20221130200950.144618-9-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200950.144618-1-a39.skl@gmail.com>
References: <20221130200950.144618-1-a39.skl@gmail.com>
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

Add mdss and dpu node to enable display support on SM6115.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 183 +++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 6e0699649257..c476b5ecb62b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -726,6 +726,189 @@ usb_1_dwc3: usb@4e00000 {
 			};
 		};
 
+		mdss: display-subsystem@5e00000 {
+			compatible = "qcom,sm6115-mdss";
+			reg = <0x05e00000 0x1000>;
+			reg-names = "mdss";
+
+			power-domains = <&dispcc MDSS_GDSC>;
+
+			clocks = <&gcc GCC_DISP_AHB_CLK>,
+				 <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			iommus = <&apps_smmu 0x420 0x2>,
+				 <&apps_smmu 0x421 0x0>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			status = "disabled";
+
+			mdp: display-controller@5e01000 {
+				compatible = "qcom,sm6115-dpu";
+				reg = <0x05e01000 0x8f000>,
+				      <0x05eb0000 0x2008>;
+				reg-names = "mdp", "vbif";
+
+				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+					 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+					 <&dispcc DISP_CC_MDSS_ROT_CLK>,
+					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+				clock-names = "bus",
+					      "iface",
+					      "core",
+					      "lut",
+					      "rot",
+					      "vsync";
+
+				operating-points-v2 = <&mdp_opp_table>;
+				power-domains = <&rpmpd SM6115_VDDCX>;
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
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
+					opp-19200000 {
+						opp-hz = /bits/ 64 <19200000>;
+						required-opps = <&rpmpd_opp_min_svs>;
+					};
+
+					opp-192000000 {
+						opp-hz = /bits/ 64 <192000000>;
+						required-opps = <&rpmpd_opp_low_svs>;
+					};
+
+					opp-256000000 {
+						opp-hz = /bits/ 64 <256000000>;
+						required-opps = <&rpmpd_opp_svs>;
+					};
+
+					opp-307200000 {
+						opp-hz = /bits/ 64 <307200000>;
+						required-opps = <&rpmpd_opp_svs_plus>;
+					};
+
+					opp-384000000 {
+						opp-hz = /bits/ 64 <384000000>;
+						required-opps = <&rpmpd_opp_nom>;
+					};
+				};
+			};
+
+			dsi0: dsi@5e94000 {
+				compatible = "qcom,dsi-ctrl-6g-qcm2290";
+				reg = <0x05e94000 0x400>;
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
+				assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
+
+				operating-points-v2 = <&dsi_opp_table>;
+				power-domains = <&rpmpd SM6115_VDDCX>;
+				phys = <&dsi0_phy>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
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
+
+				dsi_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-19200000 {
+						opp-hz = /bits/ 64 <19200000>;
+						required-opps = <&rpmpd_opp_min_svs>;
+					};
+
+					opp-164000000 {
+						opp-hz = /bits/ 64 <164000000>;
+						required-opps = <&rpmpd_opp_low_svs>;
+					};
+
+					opp-187500000 {
+						opp-hz = /bits/ 64 <187500000>;
+						required-opps = <&rpmpd_opp_svs>;
+					};
+				};
+			};
+
+			dsi0_phy: phy@5e94400 {
+				compatible = "qcom,dsi-phy-14nm-2290";
+				reg = <0x05e94400 0x100>,
+				      <0x05e94500 0x300>,
+				      <0x05e94800 0x188>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+				clock-names = "iface", "ref";
+
+				status = "disabled";
+			};
+		};
+
 		dispcc: clock-controller@5f00000 {
 			compatible = "qcom,sm6115-dispcc";
 			reg = <0x05f00000 0x20000>;
-- 
2.25.1

