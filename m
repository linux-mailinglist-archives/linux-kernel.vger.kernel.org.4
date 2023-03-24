Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609A16C86A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjCXUQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjCXUQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:16:53 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4521ABD6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:16:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q6so1261102iot.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679689011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4COcfpw9WG6m5GbVy1D4YLQiwmZKsGAwS1sbqXD1qEo=;
        b=gUrv+A8U/4sHWHCX7QHYNx/fX6Y4gsuwXZ5oXPeAWwsY1HA2CfpdU5AnXJETkmR/4R
         3sfKdnnyOcAiIavfTmHQXuiAyix7IbrrEuDIiX4hGaKzNz/RXBI24ji4Bih+s07l5eDP
         tHa0gd52lkQ0jB8ZwG7ZjG2H3p7mfFJIsGPtcpHAv9Q5YaalM4uGwcv+WF9H2vj44Jfg
         Xfzp8z2Nefov+AMBEn5YbqAWsr7b6K7BY3extnNVfm5dnzgPdGMU2PfMIT31utLF7zUE
         a/NEfk78BhSBZGn4YmuVUfqH19hgq5F+eRI3j1qJAmfojfZK8RLBBjoAJeGdw0u59sro
         3Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679689011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4COcfpw9WG6m5GbVy1D4YLQiwmZKsGAwS1sbqXD1qEo=;
        b=SUdFl75+kTk9q6lms/z/YHIPC1IxEWfN8LngwY+elvC+gfIpXdcV6lBh07/z1KQrl2
         iC/wjPLaXMYHHAdkdJbBq9IFeXVn3MzLGPBR/5odDanQKQTzkQYcP5fSh7AmQvnL1bae
         f3SH5HOlzel2R3XyY04LWsm8hdLl5blDBckUoUV4Q2oiF0GRLH5qhS2mQQYJjFEPrr7g
         9GSpMaqYndEclzTHewuSX8DuftRdMeRPJ+qeAOp2Y1X96TgJQM4/MXHFUo6/JkQcJhMw
         hy7rzfX+UjlBBMeEYS+sjgmKpGzeDNHYackymxDGCm+RPxq84saBuaWeCrZIvY+G71tS
         rteA==
X-Gm-Message-State: AO0yUKWge8G8xT+vmE2qio0GNYhjrtD9Hd2qQyx3K1+bdZrH5abxIPMG
        5hFtFqTQlt63MoXY3gyaSdZRHg==
X-Google-Smtp-Source: AK7set9LgaonR2SHhPcYWqJ5oyOKzict9DML0voVT7n4d0wQ8jpBszqkPscR+e4e9vUkV68emkKufw==
X-Received: by 2002:a6b:6f12:0:b0:758:4909:fbd6 with SMTP id k18-20020a6b6f12000000b007584909fbd6mr3154666ioc.12.1679689010900;
        Fri, 24 Mar 2023 13:16:50 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id q12-20020a05663810cc00b003e8a17d7b1fsm7173445jad.27.2023.03.24.13.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:16:42 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: qcom-sdx65: move status properties to end of nodes
Date:   Fri, 24 Mar 2023 15:15:28 -0500
Message-Id: <20230324201528.2540564-3-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324201528.2540564-1-elder@linaro.org>
References: <20230324201528.2540564-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move a few device tree "status" properties so that they are the last
specified property, in "qcom-sdx65-mtp.dts" and "qcom-sdx65.dtsi".
Note that properties must always be specified before sub-nodes.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 6 +++---
 arch/arm/boot/dts/qcom-sdx65.dtsi    | 8 +++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 72e25de0db5fc..57bc3b03d3aac 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -270,8 +270,8 @@ nand@0 {
 };
 
 &remoteproc_mpss {
-	status = "okay";
 	memory-region = <&mpss_adsp_mem>;
+	status = "okay";
 };
 
 &usb {
@@ -283,14 +283,14 @@ &usb_dwc3 {
 };
 
 &usb_hsphy {
-	status = "okay";
 	vdda-pll-supply = <&vreg_l4b_0p88>;
 	vdda33-supply = <&vreg_l10b_3p08>;
 	vdda18-supply = <&vreg_l5b_1p8>;
+	status = "okay";
 };
 
 &usb_qmpphy {
-	status = "okay";
 	vdda-phy-supply = <&vreg_l4b_0p88>;
 	vdda-pll-supply = <&vreg_l1b_1p2>;
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 360d6dc144811..a7adf28a395a8 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -224,16 +224,15 @@ usb_hsphy: phy@ff4000 {
 				     "qcom,usb-snps-hs-7nm-phy";
 			reg = <0xff4000 0x120>;
 			#phy-cells = <0>;
-			status = "disabled";
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "ref";
 			resets = <&gcc GCC_QUSB2PHY_BCR>;
+			status = "disabled";
 		};
 
 		usb_qmpphy: phy@ff6000 {
 			compatible = "qcom,sdx65-qmp-usb3-uni-phy";
 			reg = <0x00ff6000 0x1c8>;
-			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -247,6 +246,8 @@ usb_qmpphy: phy@ff6000 {
 				 <&gcc GCC_USB3_PHY_BCR>;
 			reset-names = "phy", "common";
 
+			status = "disabled";
+
 			usb_ssphy: phy@ff6200 {
 				reg = <0x00ff6e00 0x160>,
 				      <0x00ff7000 0x1ec>,
@@ -393,7 +394,6 @@ mem_noc: interconnect@9680000 {
 		usb: usb@a6f8800 {
 			compatible = "qcom,sdx65-dwc3", "qcom,dwc3";
 			reg = <0x0a6f8800 0x400>;
-			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -423,6 +423,8 @@ usb: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_BCR>;
 
+			status = "disabled";
+
 			usb_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0x0a600000 0xcd00>;
-- 
2.34.1

