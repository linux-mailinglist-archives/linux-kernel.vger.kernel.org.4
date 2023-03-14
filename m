Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC776B8D85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCNIhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjCNIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:37:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D981167726
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:36:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ix20so9270957plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678783012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q+qyPGDLJ/AP4PFWDiCUsP/deylgofbigsoyAE3L1c=;
        b=e7G1aMvXtF1I8c2ZAyXFFVdLVf7S3x2cpF0pIqPbfCHSll/tn4b76cqEZRUyp0SBcc
         eWGYiNTKkXa3DB0jbogKkDQ1QTEZM/Q77pN2h82J/n1fOxLSSTXwNL1klE3Ib4FTREDF
         n1czqx5MaKBo9ZuWQf85of6l0+wC6fUZoWut5OUnQEmemmKcj3Mwqwvfo6pbF7arZTyP
         IXEraUeNCymbNY6ZFtLoybS1+M4LC0LGf7ZYjmXVsJuaQedS69eLVgXZHo+5s9zjRoHX
         e410uGTIeCf5ElCDUTQq2jEE6jzL5V5JpQjKCAEPTypKM08cFUpLe8ITIKM9nzQiUTin
         +zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678783012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q+qyPGDLJ/AP4PFWDiCUsP/deylgofbigsoyAE3L1c=;
        b=ZeMEh9qrRyOMkaKqsDWPCozMjUp3ThXVdjdP2gR0CpW7RPqzoGkLO2A0nnu1b2Fyym
         XShPKbKHSIssTgWY/zuNdvoVN2ntlRT8n6o33+rlJTIwLKaKFtdtMoDe3Ceu6JRy3ywQ
         q18DcHSj0cVTvvSH4TgXXH4EdFzLOzqybRDP27IIK3I14iVNzNHs3frcQp8VZ8cQnPNI
         InUhe2Ej52tklgGIjZg2BJzYgREF3YiyPA26k11TLEbXfDm+1BbrPsWwCbwxrwvjrZS7
         kUQPkHpFCUdiSTuBDHVyWrFPrc4GUFHVGZiP9hznoaJj6ZKdk1epJVzRDgwV7xNr8sWG
         37/w==
X-Gm-Message-State: AO0yUKXyrIoc+V7EiZkk73QKruSmRntrmr1ms3ah45ixRUUzwG9aKXwI
        lDy2je0/flC1G06T/xm9iUSwxg==
X-Google-Smtp-Source: AK7set+wPYAmDyw8cz9rtFC4/S9pcL0c0ADM/sO5yemGTJyo5TevbbMsUKWv9+A0wNFC8RfHzharMQ==
X-Received: by 2002:a05:6a20:c11c:b0:d3:c02a:1777 with SMTP id bh28-20020a056a20c11c00b000d3c02a1777mr8211352pzb.4.1678783012361;
        Tue, 14 Mar 2023 01:36:52 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:4a3e:15d0:d540:3861:ef0e])
        by smtp.gmail.com with ESMTPSA id g3-20020a631103000000b00502ecb91940sm1020980pgl.55.2023.03.14.01.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:36:52 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 1/2] arm64: dts: qcom: sm6115: Cleanup USB node's label
Date:   Tue, 14 Mar 2023 14:06:32 +0530
Message-Id: <20230314083633.1882214-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314083633.1882214-1-bhupesh.sharma@linaro.org>
References: <20230314083633.1882214-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one USB controller present on SM6115 / SM4250
Qualcomm SoC, so drop the numbering used with USB node's label
names in the dtsi and the related sm4250-oneplus-billie2.dts.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts | 4 ++--
 arch/arm64/boot/dts/qcom/sm6115.dtsi                | 8 ++++----
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts   | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index a3f1c7c41fd73..fa57f4bf58256 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -225,11 +225,11 @@ &ufs_mem_phy {
 	status = "okay";
 };
 
-&usb_1 {
+&usb {
 	status = "okay";
 };
 
-&usb_1_hsphy {
+&usb_hsphy {
 	vdd-supply = <&vreg_l4a>;
 	vdda-pll-supply = <&vreg_l12a>;
 	vdda-phy-dpdm-supply = <&vreg_l15a>;
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index fbd67d2c8d781..f477c7f5ad761 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -642,7 +642,7 @@ gcc: clock-controller@1400000 {
 			#power-domain-cells = <1>;
 		};
 
-		usb_1_hsphy: phy@1613000 {
+		usb_hsphy: phy@1613000 {
 			compatible = "qcom,sm6115-qusb2-phy";
 			reg = <0x0 0x01613000 0x0 0x180>;
 			#phy-cells = <0>;
@@ -1082,7 +1082,7 @@ spi5: spi@4a94000 {
 			};
 		};
 
-		usb_1: usb@4ef8800 {
+		usb: usb@4ef8800 {
 			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
 			reg = <0x0 0x04ef8800 0x0 0x400>;
 			#address-cells = <2>;
@@ -1110,11 +1110,11 @@ usb_1: usb@4ef8800 {
 			qcom,select-utmi-as-pipe-clk;
 			status = "disabled";
 
-			usb_1_dwc3: usb@4e00000 {
+			usb_dwc3: usb@4e00000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x04e00000 0x0 0xcd00>;
 				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&usb_1_hsphy>;
+				phys = <&usb_hsphy>;
 				phy-names = "usb2-phy";
 				iommus = <&apps_smmu 0x120 0x0>;
 				snps,dis_u2_susphy_quirk;
diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 4ce2d905d70e1..4a7194acb44a6 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -273,11 +273,11 @@ &ufs_mem_phy {
 	status = "okay";
 };
 
-&usb_1 {
+&usb {
 	status = "okay";
 };
 
-&usb_1_hsphy {
+&usb_hsphy {
 	vdd-supply = <&pm6125_l4>;
 	vdda-pll-supply = <&pm6125_l12>;
 	vdda-phy-dpdm-supply = <&pm6125_l15>;
-- 
2.38.1

