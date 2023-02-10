Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C10692108
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjBJOoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjBJOoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:44:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F572DD5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:44:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so4214861wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KG+b13pYRqQ3AMotewCXMg/fvG9C+W/U/A7+qVFsrG4=;
        b=tIWrV+lpsn1HJHyWCwwSR2K9yrdY+9dcj7U78S0bVemI7uyLshNqtlOWB0TIiW7Kq5
         4XORWhuuzt2v1y47DkRcNB/dfi/o+FSzOyrHRRHX8+UDmRMfEASH/DhwZxx32eTyJYLH
         W/v7k+WzfNG+LGCjNP/VFViHQP1TNlZoiWwiwkKvzTu6KJXbIoZ3/mFSjamRtDCpv7ae
         UzE3cq+mp16kGMh9wwJGKT5MM2v2HJXiTjwnHenGVCHRwsg0wbM2vsKkqcIZ25jKz5k5
         NK0OwC7WOhpPyz1jkB2Hl6LMkEtciW5zFVVIfNeR3/+MbQPm8vJOF84CwHCHDEEvYmCu
         JSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG+b13pYRqQ3AMotewCXMg/fvG9C+W/U/A7+qVFsrG4=;
        b=Vx+oAVo/n+qdkrQwJAuzmVvb/D0ebyCVEBfmlqbMMzFVEDkZ82R7NeSkhZJLyvV+Qk
         L6g4KHWm5Wu+aJNHQ4YQgO4zi8yRbytGQFK12BMN/AAbaM5FQ5+ADMWtYwvfu8l+q7PO
         lwL3gtXrOFpykuX/bUuZLVEuYnpg+Pdm6Ge5KibDkxgcZa0PXi0Sc0VbB8aKpIsEFNEh
         H8YqRid6GtQnNCfP4gndJvQZ0P6GLHltvDwlejbEu9Ygui8mOLcdsziBb6tOCduPyZcY
         Z91XSDXvZy3bSHJfd6aWhzgWWZzAjdjqMcMM9qxVrgjkzGVONL5L+jLfAELMV1RkSkuw
         igRA==
X-Gm-Message-State: AO0yUKXA32KXWi+JC4Vctl2hiJN47Ogcxs9KDNEgchMtn4PzSrcf/XII
        cz/DUWqXC5/UuxWdFMbYv1PWyA==
X-Google-Smtp-Source: AK7set958I/4vTBYy7M77sJE898iVLCK4Kq7ICf6ZqdPmw/HGtkxqEsjQ/effSYQan6kIYJrK0KnOQ==
X-Received: by 2002:a05:600c:16c5:b0:3db:1434:c51a with SMTP id l5-20020a05600c16c500b003db1434c51amr13124252wmn.40.1676040269667;
        Fri, 10 Feb 2023 06:44:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l40-20020a05600c1d2800b003dd1b00bd9asm6103000wms.32.2023.02.10.06.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 06:44:29 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 10 Feb 2023 15:44:22 +0100
Subject: [PATCH v3 2/5] arm64: dts: qcom: sm8350: switch to combo usb3/dp
 phy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-topic-sm8450-upstream-dp-controller-v3-2-636ef9e99932@linaro.org>
References: <20230206-topic-sm8450-upstream-dp-controller-v3-0-636ef9e99932@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v3-0-636ef9e99932@linaro.org>
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

The first QMP PHY is an USB3/DP combo phy, switch to the newly
documented bindings and register the clocks to the GCC
and DISPCC controllers.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #SM8350-HDK
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 42 +++++++++++++-----------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 4c1a2f814b5c..6638704ff469 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,sm8350.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -653,7 +654,7 @@ gcc: clock-controller@100000 {
 				 <&ufs_mem_phy_lanes 0>,
 				 <&ufs_mem_phy_lanes 1>,
 				 <&ufs_mem_phy_lanes 2>,
-				 <0>,
+				 <&usb_1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>,
 				 <0>;
 		};
 
@@ -2125,37 +2126,24 @@ usb_2_hsphy: phy@88e4000 {
 			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
 		};
 
-		usb_1_qmpphy: phy-wrapper@88e9000 {
-			compatible = "qcom,sm8350-qmp-usb3-phy";
-			reg = <0 0x088e9000 0 0x200>,
-			      <0 0x088e8000 0 0x20>;
-			status = "disabled";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+		usb_1_qmpphy: phy@88e9000 {
+			compatible = "qcom,sm8350-qmp-usb3-dp-phy";
+			reg = <0 0x088e8000 0 0x3000>;
 
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
 
 		usb_2_qmpphy: phy-wrapper@88eb000 {
@@ -2258,7 +2246,7 @@ usb_1_dwc3: usb@a600000 {
 				iommus = <&apps_smmu 0x0 0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
-				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
+				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};
@@ -2623,8 +2611,8 @@ dispcc: clock-controller@af00000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>,
 				 <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>,
-				 <0>,
-				 <0>;
+				 <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+				 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 			clock-names = "bi_tcxo",
 				      "dsi0_phy_pll_out_byteclk",
 				      "dsi0_phy_pll_out_dsiclk",

-- 
2.34.1

