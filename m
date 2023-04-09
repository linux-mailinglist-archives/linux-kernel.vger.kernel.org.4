Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340516DC156
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 22:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDIUKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 16:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDIUJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 16:09:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24043C25
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 13:09:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id ke16so3028706plb.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 13:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681070994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAwtHEa5KqJFCC2AgvvTNGFMxN3ooON05S1Vg8ohC/E=;
        b=hr37uIbkdRoyKgTwjnuniHrHqJI8LTFu7gG/d7oMIFwEyHcHYiCnMDlHeFRSfd8mJc
         vzSLDJWfquLauRDQOyKWV1r+jr26xLdDr6yZkBxidoLUDuWLvDBW946bQuydBMm6Uv/6
         yg4DkgCk/uJgDIxVO40mx8xTwpFyJ3awjvSG7oMVivIqh8gTV3A9BqFXJVerYUJqJpkn
         jyDLKf2uwh7xWtvuh+iNh49O0tv0tFvgqsqzq3P62HOLIQypoinjRD38bcbgCgB5bwJe
         kHVe18Xo8EB6Rv1ka0XwCXFQ77wVUyyI0G1JHb823miiZIqJodLKpw3r0MHYPsFDVdlO
         xaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681070994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAwtHEa5KqJFCC2AgvvTNGFMxN3ooON05S1Vg8ohC/E=;
        b=E7lAmwQ8+DPZklC/mjMA3yyP7XfBaHwWuf7KIVTDT9PaHtB8iQLryBtYiEYGo8VNnt
         Bc/HWmNnqITeDsMhyD+UwB1tdsng3JAd4HHe9POEur+q+1zxGxR1rnmKQCkZQdihGjdP
         EBIZM9Ak4u2Zuq3eMNe/+w4tprBISVm+Jy6tWUrHdusTzwYWuJxE2tEEr2iJUWQZuM/C
         LTRStJkGz+JeC3v0zdCdzkZVt3ST+5o9PzsLNeYQb26O/d9STREapMpumdzDXv5iaPGT
         nxqWxrUpnHIHpIZx6wkPwSrl807GbfTpICOYx1aa9qYY7KWjq+O+iAF0g8+J78Cwh8p/
         7MUQ==
X-Gm-Message-State: AAQBX9d6UKSATIBTgSUE/+HCzzID94vsXBoA8DV9iRsuqeM48Z6byzbU
        mTb53muMb9Ssi7YgsDDLWoRZLQ==
X-Google-Smtp-Source: AKy350b++kbFAe+i/4YL7K/q1Au2AeDmk3+vLitjkcmomPcnTX8FfsGDl3nKeXcT7Y1xP+AQZMe85Q==
X-Received: by 2002:a17:902:d50b:b0:1a6:4532:1159 with SMTP id b11-20020a170902d50b00b001a645321159mr673plg.63.1681070993842;
        Sun, 09 Apr 2023 13:09:53 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6a11:8ba1:beba:def7:a4ae])
        by smtp.gmail.com with ESMTPSA id ji21-20020a170903325500b001a5260a6e6csm2876304plb.206.2023.04.09.13.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 13:09:53 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v7 2/2] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Date:   Mon, 10 Apr 2023 01:39:34 +0530
Message-Id: <20230409200934.2329297-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230409200934.2329297-1-bhupesh.sharma@linaro.org>
References: <20230409200934.2329297-1-bhupesh.sharma@linaro.org>
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

Add USB superspeed qmp phy node to dtsi.

Make sure that the various board dts files (which include sm4250.dtsi file)
continue to work as intended.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 +++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 27 +++++++++++++++++--
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 +++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index a1f0622db5a0..75951fd439df 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -242,6 +242,9 @@ &usb {
 &usb_dwc3 {
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
+
+	phys = <&usb_hsphy>;
+	phy-names = "usb2-phy";
 };
 
 &usb_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 2505c815c65a..e9c5d5fd2672 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -651,6 +651,29 @@ usb_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		usb_qmpphy: phy@1615000 {
+			compatible = "qcom,sm6115-qmp-usb3-phy";
+			reg = <0x0 0x01615000 0x0 0x200>;
+
+			clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+			clock-names = "cfg_ahb",
+				      "ref",
+				      "com_aux";
+
+			resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
+			reset-names = "phy", "phy_phy";
+
+			#clock-cells = <0>;
+			clock-output-names = "usb3_phy_pipe_clk_src";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b40000 0x0 0x7000>;
@@ -1101,8 +1124,8 @@ usb_dwc3: usb@4e00000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x04e00000 0x0 0xcd00>;
 				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&usb_hsphy>;
-				phy-names = "usb2-phy";
+				phys = <&usb_hsphy>, <&usb_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
 				iommus = <&apps_smmu 0x120 0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 10c9d338446c..d60cc024749b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -280,6 +280,9 @@ &usb {
 &usb_dwc3 {
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
+
+	phys = <&usb_hsphy>;
+	phy-names = "usb2-phy";
 };
 
 &usb_hsphy {
-- 
2.38.1

