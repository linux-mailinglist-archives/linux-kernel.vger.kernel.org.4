Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D846DA8C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjDGGLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjDGGLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:11:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13CD9EF9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 23:11:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a4fe31ee82so267225ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 23:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680847903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=211/WQndq/0dIl4SBYP+HR+YcyINuvXrDMq+d+OBMX0=;
        b=lIm2dOTV1ZyuKjez2fSI0LPbQVa4KKfwrbjvSJegqX/etzx4+UuDyt4VMVUuOmqXZh
         eYtKJ+tY+5EnH4q3WvFr6YsnG8hZSVYA6dcUENfbDukd1+PtsFY/TNQcfNZ9UJbMCZXl
         H04QxaDhreuEVjVgjrtUzMMZSt99NE62IDD+POwPQlMk9DG2GNkiqqP2OIHoL1GQtYGq
         lFYdHzjq2xjmwm2W+GTP90JFxWBTZdTFil+23TQkZQEcf4+hRvuaUSarLliAGVn0GAhW
         RRyej4c0zdtxcSmzg1+mGRxqgVw6SqBgxvHLB9AhqWbYs2g0907aEOvPnzGG51nNo005
         I2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680847903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=211/WQndq/0dIl4SBYP+HR+YcyINuvXrDMq+d+OBMX0=;
        b=3GF1K9AcU8EBpAm+q8viSlntPb679Ak25S0SCuklbvL96fFbh6fAqwVaXDV/y4O8V8
         B0ynYhjLOjtGKeARtU+MhmBzEpysLUzrtTW1+NJj9/tjbbJ+TBTWE6Lmfl4Kmu4QwBm8
         ECGsxQy+vcsUgXvqsyN5nAzMOb4zVeGB3zQEoT9h4J3SS3UCEDKtCPI8mnzYdJI6J999
         HRh6elz2zeULab339UKFzm1DtegqeObIWDXodjU+AWypQj5BI1J6kQtGO6k8HYchkDfI
         OiwdHGWOans6d0HKAYBxpAKVQl/OIitqKqrdwvauddwjJWC1tpi5dzEs1hXALgCoOxmt
         2qPw==
X-Gm-Message-State: AAQBX9fEdDEcPpnuNTppSwfwCGaYX/FbDJmsgwjrPfP2F9YCww4PzVfq
        MUX93pwDYnGqBSKs+Bla1b1fKQ==
X-Google-Smtp-Source: AKy350bzkyU/L95q1La6S7UbwY2cS2FuyGPLUXtdRiLUdUhCCWKIm6ciLc7IhgzxzDKXjvMjwoFsBQ==
X-Received: by 2002:a62:7b50:0:b0:62a:5769:25f9 with SMTP id w77-20020a627b50000000b0062a576925f9mr1420730pfc.28.1680847903256;
        Thu, 06 Apr 2023 23:11:43 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6a11:8ba1:beba:def7:a4ae])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b0062d7e9bb17asm2253879pfm.81.2023.04.06.23.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 23:11:42 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v6 2/2] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Date:   Fri,  7 Apr 2023 11:41:22 +0530
Message-Id: <20230407061122.2036838-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230407061122.2036838-1-bhupesh.sharma@linaro.org>
References: <20230407061122.2036838-1-bhupesh.sharma@linaro.org>
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
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 36 +++++++++++++++++--
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
 3 files changed, 40 insertions(+), 2 deletions(-)

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
index 2505c815c65a..f42065a0a71d 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -651,6 +651,38 @@ usb_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		usb_qmpphy: phy@1615000 {
+			compatible = "qcom,sm6115-qmp-usb3-phy";
+			reg = <0x0 0x01615000 0x0 0x200>;
+			clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+			clock-names = "cfg_ahb",
+				      "ref",
+				      "com_aux";
+			resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
+			reset-names = "phy", "phy_phy";
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			usb_ssphy: phy@1615200 {
+				reg = <0x0 0x01615200 0x0 0x200>,
+				      <0x0 0x01615400 0x0 0x200>,
+				      <0x0 0x01615c00 0x0 0x400>,
+				      <0x0 0x01615600 0x0 0x200>,
+				      <0x0 0x01615800 0x0 0x200>,
+				      <0x0 0x01615a00 0x0 0x100>;
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b40000 0x0 0x7000>;
@@ -1101,8 +1133,8 @@ usb_dwc3: usb@4e00000 {
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

