Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3D5735CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjFSRCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjFSRCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:02:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D7E10D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:01:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so4392573a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687194114; x=1689786114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kFsNpkHLcFM//BtPKCIX3dn76ZP7phYzCOeBMJR7VSc=;
        b=l18FBLSB4Q5LH5BXVHfMra8c5WR+f/ZgyKART/bEbY7FXxQvgSMDzMoNpPqvkK1Rr8
         AkUFTAoN0CffSdQ0Tp353Rl3xlEr1Gw1tQ71tRxXLJUTntWchUei6qH7jMtqYuO2v1Zo
         p/VQaTMneYGur6erh0ZgTt9HI9gDGraytZxZNGMjmru4M7p2Wb0aMDcXTLSythH4hT+Z
         KpBKK4oP68GKS4rm+/pH9W7TxcUogVByGyXgXW3BhjIydpUJI0iUIYMrzV15+tDamWxt
         4ih/xNV1dbUTyrmK4istPCWfe+B4NbI1faxnHGHn21+jzEq7r7u/aBdtkJaV5+hdyjlU
         NAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194114; x=1689786114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFsNpkHLcFM//BtPKCIX3dn76ZP7phYzCOeBMJR7VSc=;
        b=UBLGwHsXnPDkflups3/4ELoc7cwLq5QoV1HDM4Gbw7/HdDb4rw8TwMDkJO4VKOyNNd
         xS30JdIhytisg2INgcP7i8V0NkQEWE+pv/RgBSYSe1/KvgKKYUFhZl16P2KC0cZLjFxF
         Xjhaxn0aqr87MSbKh/LXBMug1InmaaoSLNuWa/mtyTBdMD9AGd8+JuBuU5gug5TxBwnv
         3c8L3R/kacp/hBzUFBbLTSjT8SQDlt/f+4TKwRzXkCt9msatQSuQU9V8e6E36NCGkXK5
         OWSlH00bURNd3+tpDtPAlfUT19rEjc0kq1zuFNXy+pYykDuwrXuMsRAM81N2ZYdurTep
         1wYA==
X-Gm-Message-State: AC+VfDzV3S7gKN57WxNbDgXa0wHLO3Mrzflzjv3w+EbS7XotN5JD3hDO
        c4pR6yxNaeZa/gTbvtUNaNpNXw==
X-Google-Smtp-Source: ACHHUZ5BqxYFvcnq4ViebCsKF9n5slzSqaktTwqLLXRJEWPyUJxvmeid3ugx34q2Djn9iAH8ZljoDg==
X-Received: by 2002:aa7:cc87:0:b0:514:98c8:9d7c with SMTP id p7-20020aa7cc87000000b0051498c89d7cmr6303931edt.4.1687194114254;
        Mon, 19 Jun 2023 10:01:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p9-20020aa7cc89000000b005166663b8dcsm13136672edt.16.2023.06.19.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 10:01:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] ARM: dts: qcom: ipq4019: use generic node names for USB
Date:   Mon, 19 Jun 2023 19:01:48 +0200
Message-Id: <20230619170151.65505-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Device node names should be generic which is also expected by USB
bindings:

  qcom-ipq4018-jalapeno.dtb: dwc3@6000000: $nodename:0: 'dwc3@6000000' does not match '^usb(@.*)?'

Override also the DWC3 node in qcom-ipq4018-ap120c-ac.dtsi by
label/phandle, not via node path, because it is less error-prone and
makes the overriding node-name independent.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi |  7 ++++---
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 14 +++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
index d90b4f4c63af..da67d55fa557 100644
--- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
@@ -262,10 +262,11 @@ &usb3_hs_phy {
 &usb3 {
 	status = "okay";
 
-	dwc3@8a00000 {
-		phys = <&usb3_hs_phy>;
-		phy-names = "usb2-phy";
 	};
+
+&usb3_dwc {
+	phys = <&usb3_hs_phy>;
+	phy-names = "usb2-phy";
 };
 
 &usb2_hs_phy {
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index f0ef86fadc9d..13388e5c1b4b 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -621,7 +621,7 @@ ethphy4: ethernet-phy@4 {
 			};
 		};
 
-		usb3_ss_phy: ssphy@9a000 {
+		usb3_ss_phy: usb-phy@9a000 {
 			compatible = "qcom,usb-ss-ipq4019-phy";
 			#phy-cells = <0>;
 			reg = <0x9a000 0x800>;
@@ -631,7 +631,7 @@ usb3_ss_phy: ssphy@9a000 {
 			status = "disabled";
 		};
 
-		usb3_hs_phy: hsphy@a6000 {
+		usb3_hs_phy: usb-phy@a6000 {
 			compatible = "qcom,usb-hs-ipq4019-phy";
 			#phy-cells = <0>;
 			reg = <0xa6000 0x40>;
@@ -641,7 +641,7 @@ usb3_hs_phy: hsphy@a6000 {
 			status = "disabled";
 		};
 
-		usb3: usb3@8af8800 {
+		usb3: usb@8af8800 {
 			compatible = "qcom,ipq4019-dwc3", "qcom,dwc3";
 			reg = <0x8af8800 0x100>;
 			#address-cells = <1>;
@@ -653,7 +653,7 @@ usb3: usb3@8af8800 {
 			ranges;
 			status = "disabled";
 
-			dwc3@8a00000 {
+			usb3_dwc: usb@8a00000 {
 				compatible = "snps,dwc3";
 				reg = <0x8a00000 0xf8000>;
 				interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
@@ -663,7 +663,7 @@ dwc3@8a00000 {
 			};
 		};
 
-		usb2_hs_phy: hsphy@a8000 {
+		usb2_hs_phy: usb-phy@a8000 {
 			compatible = "qcom,usb-hs-ipq4019-phy";
 			#phy-cells = <0>;
 			reg = <0xa8000 0x40>;
@@ -673,7 +673,7 @@ usb2_hs_phy: hsphy@a8000 {
 			status = "disabled";
 		};
 
-		usb2: usb2@60f8800 {
+		usb2: usb@60f8800 {
 			compatible = "qcom,ipq4019-dwc3", "qcom,dwc3";
 			reg = <0x60f8800 0x100>;
 			#address-cells = <1>;
@@ -685,7 +685,7 @@ usb2: usb2@60f8800 {
 			ranges;
 			status = "disabled";
 
-			dwc3@6000000 {
+			usb@6000000 {
 				compatible = "snps,dwc3";
 				reg = <0x6000000 0xf8000>;
 				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

