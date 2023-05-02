Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0E6F3D06
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjEBFgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjEBFgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:36:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A3469C
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 22:36:04 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ab032d9266so11067505ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 22:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683005763; x=1685597763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edN7qaIOGdbnADlJ0Za45tNBUjQcf3QWA/Qw0dQ45yM=;
        b=mbSJ/YcOiWfiHJiSwetG4Uyb8PfIu5NJKI5uN7ZH/BxYAAOKCJn/P0Ibiwxvr4tCo6
         SMppJDUQhHtfiQW1gV5abzMhqM+0AsELVcNjn17uqMrugZdmFFWTt2izNlNJZC4PAhSB
         cURIJiZSwENxEg3Dq0odypOKDkLbNU0BbLp71oSip717iIh+LJXFggq9sYREr7tThp2b
         WxxBN84w+qqgLk66mBa/kgBorKwlUdTR1PWG681P6eGC/+JEXbbXQUb65WI8WkGnK+N8
         SNSM1tlPQTtCuDxFxcazIMTAygLZD5YFWlG+8cR5Ok1lT8qJfPDbve0SIsd7iMRfGBqG
         tWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683005763; x=1685597763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edN7qaIOGdbnADlJ0Za45tNBUjQcf3QWA/Qw0dQ45yM=;
        b=TUiN2V54hsD0/EC3EsECLQTYM/NhTmnp7dC2i7G4FxPFwp5itHd8423wzjYCE4kHLQ
         qmDORpnsPGIZ5vFHpaT72Yk/7x5MsL9y2+PAJAU8KccZ3WLOrk1zgNh7x7ud44wbVZa+
         ONy7wn6EQ/1msUk3pqdXpmjxq4G/yNRnIs0rIZGGprR/WSTCodeDHWaWjYZN/SIe9TvD
         Yn689aDQ2jZoo9H+PPv13jTQuZjEJxMiC6TDeXHIaATL0MvCYpQyMaPEkZmalNDpHMps
         WetRSEChUZEYP392NO+Ilpb4gDuVP6tmviIW+9fUMGTMBF+9z3X1xSAvLe54Cc/Ptvdp
         RnUQ==
X-Gm-Message-State: AC+VfDwP6GNMFalQO0nru/JpwrNvb9TFDWWss+VoSKt+9ypPzoRd96fb
        fBSyJ3Nl5lwW+8lLUy9yaq2KQQ==
X-Google-Smtp-Source: ACHHUZ4uCcjnIN5BkTvMD/ido4dsMQ8WEdpomR/CkUHWXKLUDDl05Z9zLOxThJusg1Or3tLLh/KoBQ==
X-Received: by 2002:a17:902:c782:b0:1a1:ca37:5257 with SMTP id w2-20020a170902c78200b001a1ca375257mr14444834pla.7.1683005763545;
        Mon, 01 May 2023 22:36:03 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:58fa:39f6:37e1:bb9a:a094])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902690c00b001a6a6169d45sm18870369plk.168.2023.05.01.22.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 22:36:03 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v10 3/4] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Date:   Tue,  2 May 2023 11:05:33 +0530
Message-Id: <20230502053534.1240553-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230502053534.1240553-1-bhupesh.sharma@linaro.org>
References: <20230502053534.1240553-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB superspeed qmp phy node to dtsi.

Make sure that the various board dts files (which include sm4250.dtsi file)
continue to work as intended.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 29 +++++++++++++++++--
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
 3 files changed, 33 insertions(+), 2 deletions(-)

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
index 631ca327e064..f67863561f3f 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -661,6 +661,31 @@ usb_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		usb_qmpphy: phy@1615000 {
+			compatible = "qcom,sm6115-qmp-usb3-phy";
+			reg = <0x0 0x01615000 0x0 0x1000>;
+
+			clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "cfg_ahb",
+				      "ref",
+				      "com_aux",
+				      "pipe";
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
@@ -1111,8 +1136,8 @@ usb_dwc3: usb@4e00000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x04e00000 0x0 0xcd00>;
 				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&usb_hsphy>;
-				phy-names = "usb2-phy";
+				phys = <&usb_hsphy>, <&usb_qmpphy>;
+				phy-names = "usb2-phy", "usb3-phy";
 				iommus = <&apps_smmu 0x120 0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index ea3340d31110..81fdcaf48926 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -306,6 +306,9 @@ &usb {
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

