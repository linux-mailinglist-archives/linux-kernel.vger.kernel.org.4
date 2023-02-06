Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFA668B9C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjBFKRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjBFKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:17:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8A20D26
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:17:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so10352482wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8BNt3P6FlT3kcYmEuu8JuiEyEcVrYDY8Kmy12NJEfA=;
        b=zgSsX1Q7/VpfxquQvwMtgivpLppI6KrnTpFPO5Nmc9n5uOWuMEGxQkQ/Gf4NlxPiFy
         EJ0jsQ+b/JZ+ys41QsiSgscK6SqRp1RkK0xKCO8bconbCTA+zZkWCcIvkGPGorUCT2lf
         zrQZT6lsz8Frqk6R6tE+8S1ziWDS/zDum/Ia6sLsiCQJbNNdushk43gUXM4VmJya/w68
         pjnzJ8GGJ6f1NgTN9PlVF2fuWWNzF7VBgGQGjba5TFXb97YejK4BdTqa9HFsBj/6unMm
         se57g8Hw+wp97Uz4s9g3+fptcua5sfWyEqAMDT7jiTzNxOMrTU7V2g3Z1FvnZT+9tDOO
         wyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8BNt3P6FlT3kcYmEuu8JuiEyEcVrYDY8Kmy12NJEfA=;
        b=n8ndTTkYh6UdFTg59qnXA66xiTP45orohP2I2JQL9nN1tC3jhunyKiaz4xsjucbPev
         CMJP6BakXN8MoQkZpOJM+j/ahUG7D0toLCdFrShNawC2XzNMTnkwhQ0HqNeocGggu5AA
         JaXHiYZ6HrENNWySOcIBDIZxEyXIdctHKK9P8vNdL54SKopbdDklbmXloyEkVpTNb3JZ
         iXY6ENFikCUHb6Vz9OtXTi193q5zpPr7q0X0jZXpx+nUct5bdGBS+tN8gOhswQpbbaMb
         zXbho/BQGaojHWwtBFsF4ntChDb1iOu01RLe2scVxXJl1o79ZbNNa1TyvFai4C9q5FTh
         13dQ==
X-Gm-Message-State: AO0yUKUGG4LwISF5omSNoO3P2eRcl0OAEuLQgxPe3PFHP38+tvk2stTF
        IiDrCw7boVMolnciSkXzngpJWw==
X-Google-Smtp-Source: AK7set+RBq1X59Rbn5OBJjwdZiUQ7+nz9FtH2iHRF6sKXMb6tfAELQ2EdPiWWyvxhSUGcUJmZxATGg==
X-Received: by 2002:a05:600c:3544:b0:3dd:1c46:b92 with SMTP id i4-20020a05600c354400b003dd1c460b92mr20586556wmq.16.1675678632105;
        Mon, 06 Feb 2023 02:17:12 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w15-20020a05600c474f00b003db0bb81b6asm11314201wmo.1.2023.02.06.02.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:17:11 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Feb 2023 11:17:08 +0100
Subject: [PATCH 5/5] arm64: dst: qcom: sm8450: add dp controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-topic-sm8450-upstream-dp-controller-v1-5-f1345872ed19@linaro.org>
References: <20230206-topic-sm8450-upstream-dp-controller-v1-0-f1345872ed19@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v1-0-f1345872ed19@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Display Port controller subnode to the MDSS node.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts |  4 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi    | 82 +++++++++++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 5bdc2c1159ae..1b4ef79f74b3 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -480,7 +480,9 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
-&mdss_mdp {
+&mdss_dp0 {
+	data-lanes = <0 1 2 3>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 757b7c56d5f5..8d83545d5e4a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2745,13 +2745,20 @@ ports {
 
 					port@0 {
 						reg = <0>;
-						dpu_intf1_out: endpoint {
-							remote-endpoint = <&mdss_dsi0_in>;
+						dpu_intf0_out: endpoint {
+							remote-endpoint = <&mdss_dp0_in>;
 						};
 					};
 
 					port@1 {
 						reg = <1>;
+						dpu_intf1_out: endpoint {
+							remote-endpoint = <&mdss_dsi0_in>;
+						};
+					};
+
+					port@2 {
+						reg = <2>;
 						dpu_intf2_out: endpoint {
 							remote-endpoint = <&mdss_dsi1_in>;
 						};
@@ -2789,6 +2796,75 @@ opp-500000000 {
 				};
 			};
 
+			mdss_dp0: displayport-controller@ae90000 {
+				compatible = "qcom,sm8350-dp";
+				reg = <0 0xae90000 0 0x0fc>,
+				      <0 0xae90200 0 0x0c0>,
+				      <0 0xae90400 0 0x770>,
+				      <0 0xae91000 0 0x098>;
+				interrupt-parent = <&mdss>;
+				interrupts = <12>;
+				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
+				clock-names = "core_iface", "core_aux",
+					      "ctrl_link",
+			                      "ctrl_link_iface", "stream_pixel";
+
+				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
+				assigned-clock-parents = <&usb_1_qmpphy 1>,
+							 <&usb_1_qmpphy 2>;
+
+				phys = <&usb_1_qmpphy 1>;
+			        phy-names = "dp";
+
+			        #sound-dai-cells = <0>;
+
+				operating-points-v2 = <&dp_opp_table>;
+				power-domains = <&rpmhpd SM8450_MMCX>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss_dp0_in: endpoint {
+							remote-endpoint = <&dpu_intf0_out>;
+						};
+					};
+				};
+
+				dp_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					opp-160000000 {
+						opp-hz = /bits/ 64 <160000000>;
+						required-opps = <&rpmhpd_opp_low_svs>;
+					};
+
+					opp-270000000 {
+						opp-hz = /bits/ 64 <270000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-540000000 {
+						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-810000000 {
+						opp-hz = /bits/ 64 <810000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+			};
+
 			mdss_dsi0: dsi@ae94000 {
 				compatible = "qcom,sm8450-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
@@ -2966,8 +3042,8 @@ dispcc: clock-controller@af00000 {
 				 <&mdss_dsi0_phy 1>,
 				 <&mdss_dsi1_phy 0>,
 				 <&mdss_dsi1_phy 1>,
-				 <&usb_1_qmpphy 0>,
 				 <&usb_1_qmpphy 1>,
+				 <&usb_1_qmpphy 2>,
 				 <0>, /* dp1 */
 				 <0>,
 				 <0>, /* dp2 */

-- 
2.34.1

