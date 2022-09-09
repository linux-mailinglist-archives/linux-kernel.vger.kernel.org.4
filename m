Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021705B33A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiIIJVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiIIJVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:21:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BD0FA680
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:20:53 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bs13so1089317ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fC7hlheaTm5w1H34Wr2YOUv8Ed7fsZ6b8bVojzbwAbY=;
        b=pIObONZD7zS+FEkOpRNNF3wwUHbQSQw3yUd1TaBlpCip1Mo7KE87exDgXzDtSm2+ME
         RQc1k7D+9HIhJ1xaeIf6RHVBGxWwcH0CrSxuDOtS39kzyO+TbvlXo8MUzq0aVqhuP9A7
         7nJcJ4mIeoI0oxn/gj7+67FX1Twno3V97uPmdm0XZ4BWG9GHSVxtI5ANq9yR0SYY9JYW
         010fGpt8261IJmBGS/alKp2VJiAcN+5Ch+3/USbe2bcGu6/UvPsByocRLobis3CN79kM
         tYt/6s38ZJufzbHKo43Uz8EMmJQ2LskkN8CclQV7ZxW5UO8Pp71NonX2ZUc3CvHsjUnm
         CHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fC7hlheaTm5w1H34Wr2YOUv8Ed7fsZ6b8bVojzbwAbY=;
        b=Fij0F1PgnGHeLyg7qzjPPwjSytoo07biZZ64aYZeNCtMmrZT2hgnOCfOl9NHj15LXD
         19lWJYovslsImWh3nOmnzp/lLH/yz5nmSz/Bn5ENNm31U1pivY5/0BocNWaNblX00K/e
         YCFRwVUAlJSljtwDVfuS76jXA+4W052wNsffSmSpCKgfCuAXRt0nJbk1yMD/fwa7BoLo
         EzVqvDoR9MMj9KHJFC3SaGzFXPtH8uPuRHhCX8Ey+x7aWpy8289LBfMgE6TRKctR+Zeq
         eOhB5iOJAb/GyQfPsUBZ5H/IOuvJ2hzi5WfNPMjNpdjFxkjMUhnZogY7rmcsAJM5SnSQ
         EpHQ==
X-Gm-Message-State: ACgBeo13fKJ53AJwPh21afz9k6DbjOvkPdO2l2eqbUtWFDaliiP9pB2s
        zqj6a0w7pyqnJQ77HWFSMczbVg==
X-Google-Smtp-Source: AA6agR4lRiN+pt2U3r6zcbvaPHFuFfqrQQsFBg6kH2oNet/v1pyWHaUU3+qCHNCjn8MFqE1V7eOkvA==
X-Received: by 2002:a2e:b5d3:0:b0:267:4da0:ce3b with SMTP id g19-20020a2eb5d3000000b002674da0ce3bmr3465949ljn.420.1662715253120;
        Fri, 09 Sep 2022 02:20:53 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b00498fe38ea0fsm2170lfr.174.2022.09.09.02.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:20:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 10/15] ARM: dts: qcom: msm8974: split TCSR halt regs out of mutex
Date:   Fri,  9 Sep 2022 11:20:30 +0200
Message-Id: <20220909092035.223915-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
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

The TCSR halt regs are next to TCSR mutex, so before converting the TCSR
mutex into device with address space, we need to split the halt regs to
its own syscon device.  This also describes more accurately the devices
and their IO address space.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts        |  2 +-
 .../boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts   |  2 +-
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi |  2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                   | 11 ++++++++---
 arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts   |  2 +-
 arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts    |  2 +-
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts    |  2 +-
 7 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 3051a861ff0c..2709a99e5c4c 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -38,7 +38,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs2_phy>;
-	phy-select = <&tcsr 0xb000 1>;
+	phy-select = <&tcsr_2 0xb000 1>;
 	extcon = <&smbb>, <&usb_id>;
 	vbus-supply = <&chg_otg>;
 	hnp-disable;
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index ec5d340562b6..5fd94dd6a427 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -251,7 +251,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
+	phy-select = <&tcsr_2 0xb000 0>;
 
 	extcon = <&charger>, <&usb_id>;
 	vbus-supply = <&usb_otg_vbus>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 5a70683d9103..118b231f3137 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -136,7 +136,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
+	phy-select = <&tcsr_2 0xb000 0>;
 	extcon = <&smbb>, <&usb_id>;
 	vbus-supply = <&chg_otg>;
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 90a6d4b7605c..ada232bed2c8 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1189,7 +1189,7 @@ remoteproc_mss: remoteproc@fc880000 {
 			resets = <&gcc GCC_MSS_RESTART>;
 			reset-names = "mss_restart";
 
-			qcom,halt-regs = <&tcsr_mutex_block 0x1180 0x1200 0x1280>;
+			qcom,halt-regs = <&tcsr_1 0x180 0x200 0x280>;
 
 			qcom,smem-states = <&modem_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
@@ -1230,10 +1230,15 @@ smd-edge {
 
 		tcsr_mutex_block: syscon@fd484000 {
 			compatible = "syscon";
-			reg = <0xfd484000 0x2000>;
+			reg = <0xfd484000 0x1000>;
 		};
 
-		tcsr: syscon@fd4a0000 {
+		tcsr_1: syscon@fd485000 {
+			compatible = "qcom,tcsr-msm8974", "syscon";
+			reg = <0xfd485000 0x1000>;
+		};
+
+		tcsr_2: syscon@fd4a0000 {
 			compatible = "qcom,tcsr-msm8974", "syscon";
 			reg = <0xfd4a0000 0x10000>;
 		};
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index ff6e0066768b..c264d17e0953 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -89,7 +89,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
+	phy-select = <&tcsr_2 0xb000 0>;
 	extcon = <&smbb>, <&usb_id>;
 	vbus-supply = <&chg_otg>;
 
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
index 983e10c3d863..2691a6dbbb8b 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
@@ -379,7 +379,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
+	phy-select = <&tcsr_2 0xb000 0>;
 
 	hnp-disable;
 	srp-disable;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 3f45f5c5d37b..d2bef3896c82 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -216,7 +216,7 @@ &otg {
 	status = "okay";
 
 	phys = <&usb_hs1_phy>;
-	phy-select = <&tcsr 0xb000 0>;
+	phy-select = <&tcsr_2 0xb000 0>;
 	extcon = <&smbb>, <&usb_id>;
 	vbus-supply = <&chg_otg>;
 
-- 
2.34.1

