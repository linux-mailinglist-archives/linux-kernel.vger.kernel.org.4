Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4B64D155
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiLNUgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLNUfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:35:45 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E2DE20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:31:56 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d3so4577272plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPIAhqEAUFnaQX9FYqtKlCHsyyM8Y3BpxN8o+Dy0qmY=;
        b=U1+8X6QnTAv8LJbEQ5qFXSEdbpe4APhf2SYNK3m2nFrNtbn8nxtzlY7N9Si8dw+JSJ
         Y0wL/hPH/AnvIHGLSTsFLl6TfIBEBFRbH6T3VeuqvS2saU8IhRPBbGrwvaGRSAf+9UvP
         wSwKHpFlvqgHUkF3sZXLdHnoMNfWXcfYBoRpGbycuOLi/GJ2q8cECsOdBT5eWXqchA9d
         vBq9+mau2GFRyJNe8TgN3ZL0BdxQk9YB7ggFD8a39ixUZQ4q9ayL4X8jtGvZ69WxVwwD
         DZX4NDLn8xmYbXheVnRSb1L+Kx3LFzdWaD+tqolVtTYeJiHyQ4CD4GlSeHg9m07LpwJ9
         Jb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPIAhqEAUFnaQX9FYqtKlCHsyyM8Y3BpxN8o+Dy0qmY=;
        b=G42E3vBd7nK3wIm2AXk4kDMpe1rktVZYtPUjKTvNf1iGimcJIxnxdeNYLdAfA/R7q/
         fcLjIxGQ5SSIoX9El4hoX3X+UTt/hJa/NHGB54HAc47rvuyUvIvAJjUoAnfZOi8Hvsgx
         gg6SedycHClDgJJPqwpxVhh9QPDTbtziWdQ7HEmiCDMLAxHwZsqaSlGdc+sGsYnJ23Hg
         lGZd0PUkB8UiI6s37DQ/woIvWQw0YKET99aIFWwpqtldzhKjqXhISTL0BaQ/mNFZRrLY
         vNNrcOI6Oori6dsWo1oj1aqL0lnXhPZekFFv/JkWGyoU1I63qqVTVHAm8WOFnJPida4q
         nuhA==
X-Gm-Message-State: ANoB5pn/hw/WOSe11NY3pZBDyrIL43faD2wWY2VRozrBMxNtJSHp59LL
        TlWx1xXxl5GtTNEtRKNuWU6Q0Q==
X-Google-Smtp-Source: AA0mqf4kKDPrcLvLDV+cKqx6gJIYkhue388PwYZrWAvT4JfEBcApaMKK8+6JllstPRE+MIgdgGR4jw==
X-Received: by 2002:a17:90a:1b0b:b0:219:396c:9e32 with SMTP id q11-20020a17090a1b0b00b00219396c9e32mr27101974pjq.16.1671049915966;
        Wed, 14 Dec 2022 12:31:55 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c60:4bad:5c3:ab51:3d81:6264])
        by smtp.gmail.com with ESMTPSA id gx13-20020a17090b124d00b00219e38b42f5sm1812238pjb.26.2022.12.14.12.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:31:55 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Date:   Thu, 15 Dec 2022 02:01:24 +0530
Message-Id: <20221214203124.564537-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214203124.564537-1-bhupesh.sharma@linaro.org>
References: <20221214203124.564537-1-bhupesh.sharma@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 38 ++++++++++++++++++-
 2 files changed, 39 insertions(+), 2 deletions(-)

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
index e4ce135264f3d..15f311dcd289f 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -579,6 +579,40 @@ usb_hsphy: phy@1613000 {
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
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x01b40000 0x7000>;
@@ -1023,8 +1057,8 @@ usb_dwc3: usb@4e00000 {
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

