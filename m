Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AA564D8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiLOJqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiLOJqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:46:20 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17E764D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:46:00 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 4so6293320plj.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L50HRpx0Z4Or/BORkdatF6BNkaDTInB60seuiVz4K7k=;
        b=eHUz+FEGp2fVVH+Epxc0EYziMmf7juDRQflCBwdhUpuT8+aLM/DrgOrdTHsEIOf0aG
         0qyInRYvYmx8uRSOWCxBWyd/0ShUM2Z8iwcaqfd01TQt68ENktqNY22FoMJvWQMQqW1L
         UGoU6ZxNXvs6QvNU28q0p6In8bxEGa9v9oU5TUcYMoXaWlGcwTUqU5zRsZBVc/CN2L/W
         XCADRV9v64/J48tgjdsbRVG5D1fE9y4sJdS5vfwFuypt3w4z3k7HaAmyF4esXneP3FqS
         sJrpMd12vpq/h0+7Ca0a5wxTa6XVxRlV+odBrVWW1bP7Xj2o+24cTX6Wh9S4tHDOkpZP
         Abgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L50HRpx0Z4Or/BORkdatF6BNkaDTInB60seuiVz4K7k=;
        b=gIsJoJ5uv+jeCdtCTPWRnijRh6UdXQ8jJupAmnFGksE0Heola1vNn7P0Mc0eAuO/Bd
         oiL499xt0L5nsh+EISM3HZkR9lPsP4SzMKYHKsVQxWHXYHg1jEjAdBhCX7ldLGR+J/YS
         wmF10AIQcRxljJ9MhWaVcMlQvqGIZ1p29uq51HkvNrqLhXr9CdcixPLV4Gzd5Iu4zjAN
         tt3Ok/VR7IEvbBH8kYEg+uvkRKT78zXFPOQRg8Vrs6ghmiK2kOTdVk2p4Rn29s/c1T/A
         q/+nyGTWHaLh8RtESdV7xSEIGN9MfaxY6CQ2MSP0YtM4oO8/GPVJTtdqk9jv++CX+L/P
         coNg==
X-Gm-Message-State: ANoB5pk5qVqnfyHVLDdcNl/doMQbgBYgkwqgIhF+M5WOVSsybG3saHbU
        C9a8PmvBg8vYFgx6w2R05P3Ntg==
X-Google-Smtp-Source: AA0mqf5emL+4OFASnVCZkKIsuFyXTBa71S97LYgOrAVkQvjEwH/sOTNjFVdxghurfAlJkHDvANEYuA==
X-Received: by 2002:a17:902:d58a:b0:189:a11e:9995 with SMTP id k10-20020a170902d58a00b00189a11e9995mr28985586plh.13.1671097559571;
        Thu, 15 Dec 2022 01:45:59 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5f:4e45:ae49:8018:6d22:e5b4])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b0018971fba556sm3342646plk.139.2022.12.15.01.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:45:59 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
Subject: [PATCH v3 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Date:   Thu, 15 Dec 2022 15:15:32 +0530
Message-Id: <20221215094532.589291-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215094532.589291-1-bhupesh.sharma@linaro.org>
References: <20221215094532.589291-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB superspeed qmp phy node to dtsi.
Make sure that the oneplus board dts (which includes the
sm4250.dtsi) continues to work as intended.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 37 ++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index 3f39f25e0721e..4f0d65574448b 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -232,6 +232,9 @@ &usb {
 &usb_dwc3 {
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
+
+	phys = <&usb_hsphy>;
+	phy-names = "usb2-phy";
 };
 
 &usb_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index e4ce135264f3d..030763187cc3f 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -579,6 +579,39 @@ usb_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		usb_qmpphy: phy@1615000 {
+			compatible = "qcom,sm6115-qmp-usb3-phy";
+			reg = <0x01615000 0x200>;
+			clocks = <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_AHB2PHY_USB_CLK>;
+			clock-names = "com_aux",
+				      "ref",
+				      "cfg_ahb";
+			resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
+			reset-names = "phy", "phy_phy";
+			status = "disabled";
+			#clock-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			usb_ssphy: phy@1615200 {
+				reg = <0x01615200 0x200>,
+				      <0x01615400 0x200>,
+				      <0x01615c00 0x400>,
+				      <0x01615600 0x200>,
+				      <0x01615800 0x200>,
+				      <0x01615a00 0x100>;
+				#phy-cells = <0>;
+				#clock-cells = <1>;
+				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x01b40000 0x7000>;
@@ -1023,8 +1056,8 @@ usb_dwc3: usb@4e00000 {
 				compatible = "snps,dwc3";
 				reg = <0x04e00000 0xcd00>;
 				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&usb_hsphy>;
-				phy-names = "usb2-phy";
+				phys = <&usb_hsphy>, <&usb_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
 				iommus = <&apps_smmu 0x120 0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
-- 
2.38.1

