Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3DE691CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjBJKfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjBJKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:35:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36A06D62C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:35:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r18so3470789wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sq7lndL52Sa02Q2fDxz5uSdATzz3Jf03VJ3oBm4uE2U=;
        b=XIY/lo278ClXz7D9cQfEyvcGN1KrD9b9nAi1UkgCpX7LhgzYe0+ze4Fs/sjEnZa9JM
         thSggsK6SD9qBSCXgjW6vdwDr0efXvjn9jgrmzUBdmzsSUR6Bev+D9fjn75qWnj9x7Jr
         Q5nxX30PnMg+m1rH6rvwHeNwZON5DJMSD0pPqJF1Hd8SN0ro4T0xtUPRZ6mcWCC/k81U
         m3S2oY+FOf8evA8+md5lF6iIqmVGGMJW+BswUktZgg4+F0sL4nzDaIEHOQQ+PzA5FVyh
         l9pxDsbkcELgMz7GxazgFFFjmRuF6JbJEow/7ZFidC+4CfkJN+QM4zDU988HAYapzbaV
         BBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sq7lndL52Sa02Q2fDxz5uSdATzz3Jf03VJ3oBm4uE2U=;
        b=CYwFEQeRH5s0gGSBuOTsOg0BN7sCGpUpd1Io5EtLeveCliYKmDTRvva9OEa4/waNuV
         nXBFRb97S6I7rMsW0zuHQA+H0A0MlkQnibB/y1Y4u9LfbuHCeEUZdGE3ouWbBjmsdyse
         S3x2NexpuJNffTTwR3G927wLt3MVgyRthmT4Lx7fPOtm6YdPCsCj8q53bifnGePvGx0d
         seSsSpg2t+hAnlJSUASdTnYzRD0rfLqw3cl7BDfAZovosNICpRfm0gkYR2D5PVbJGrKc
         JDJNrAfJLu5ZvHyyh4c8thBTz0vfGHAPew+P5sd4UK+EbfOytAd4MeoFWW+qDQSnkoOk
         Ttbw==
X-Gm-Message-State: AO0yUKXTu8aglMSFO7moDVfaal5NiobCqhofTto01tw4AFKk8Sc4GxNV
        3MwfA8d+6X6PObjtJbVjItxYRQ==
X-Google-Smtp-Source: AK7set+i8KWgqB2sIndU6HhKOe50o1pOYMq4mSeiSZoYyaLX5GQzV3cjTJU4qu4oL8VIRJs/pPF9Ng==
X-Received: by 2002:a05:600c:43c4:b0:3dd:1b76:347f with SMTP id f4-20020a05600c43c400b003dd1b76347fmr12489882wmn.18.1676025299500;
        Fri, 10 Feb 2023 02:34:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b18-20020a05600c4e1200b003e00c453447sm7937958wmq.48.2023.02.10.02.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:34:58 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 10 Feb 2023 11:34:53 +0100
Subject: [PATCH v2 4/5] arm64: dst: qcom: sm8450: switch to usb3/dp combo
 phy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-topic-sm8450-upstream-dp-controller-v2-4-529da2203659@linaro.org>
References: <20230206-topic-sm8450-upstream-dp-controller-v2-0-529da2203659@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v2-0-529da2203659@linaro.org>
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

The QMP PHY is a USB3/DP combo phy, switch to the newly
documented bindings and register the clocks to the GCC
and DISPCC controllers.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 41 ++++++++++++------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d66dcd8fe61f..6248adc546f2 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -748,7 +748,7 @@ gcc: clock-controller@100000 {
 				 <&ufs_mem_phy_lanes 0>,
 				 <&ufs_mem_phy_lanes 1>,
 				 <&ufs_mem_phy_lanes 2>,
-				 <0>;
+				 <&usb_1_qmpphy 0>;
 			clock-names = "bi_tcxo",
 				      "sleep_clk",
 				      "pcie_0_pipe_clk",
@@ -2038,37 +2038,24 @@ usb_1_hsphy: phy@88e3000 {
 			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
 		};
 
-		usb_1_qmpphy: phy-wrapper@88e9000 {
-			compatible = "qcom,sm8450-qmp-usb3-phy";
-			reg = <0 0x088e9000 0 0x200>,
-			      <0 0x088e8000 0 0x20>;
-			status = "disabled";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+		usb_1_qmpphy: phy@88e8000 {
+			compatible = "qcom,sm8450-qmp-usb3-dp-phy";
+			reg = <0 0x088e8000 0 0x4000>;
 
 			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
-				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
-			clock-names = "aux", "ref_clk_src", "com_aux";
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
 
 			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
 				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
-			usb_1_ssphy: phy@88e9200 {
-				reg = <0 0x088e9200 0 0x200>,
-				      <0 0x088e9400 0 0x200>,
-				      <0 0x088e9c00 0 0x400>,
-				      <0 0x088e9600 0 0x200>,
-				      <0 0x088e9800 0 0x200>,
-				      <0 0x088e9a00 0 0x100>;
-				#phy-cells = <0>;
-				#clock-cells = <0>;
-				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "usb3_phy_pipe_clk_src";
-			};
+			#clock-cells = <1>;
+			#phy-cells = <1>;
+
+			status = "disabled";
 		};
 
 		remoteproc_slpi: remoteproc@2400000 {
@@ -2976,8 +2963,8 @@ dispcc: clock-controller@af00000 {
 				 <&mdss_dsi0_phy 1>,
 				 <&mdss_dsi1_phy 0>,
 				 <&mdss_dsi1_phy 1>,
-				 <0>, /* dp0 */
-				 <0>,
+				 <&usb_1_qmpphy 0>,
+				 <&usb_1_qmpphy 1>,
 				 <0>, /* dp1 */
 				 <0>,
 				 <0>, /* dp2 */
@@ -4157,7 +4144,7 @@ usb_1_dwc3: usb@a600000 {
 				iommus = <&apps_smmu 0x0 0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
-				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
+				phys = <&usb_1_hsphy>, <&usb_1_qmpphy 0>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};

-- 
2.34.1

