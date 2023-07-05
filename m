Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8577C748706
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjGEO56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjGEO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:57:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDA1988
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:57:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d8fa4dbf9so7790066a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569068; x=1691161068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VEPj9MNRtJknVYwMtm8K9KHPmosJrfBiNj5dYN7jj4s=;
        b=URubkmlEbTg6P1Fe1S7d1HFf5IG1PybcKWIV8h3wl4VtsD1CWKW583PCB1F8rNlpNA
         iU54+0BJau+XNqARNBdeCBUSOvVcucL0cSoUH3/gGx8rriYjhx8PwaBtVOZWTrdvMd8M
         uPXXJ/jKbn2hN5GXAUXCpW8elYP5P6eiiO16JMqj4o5dHPcDe00RQJuY6jjUByOyO/57
         +dfI25XfOQtjYFwxIY+hExf2EquYbVdvKvAz0UK2Wzp8IWqUqqjugI1IvZEQl3EOVrVn
         Nne/Mha8kE+8GkwlP66Li93rldqBSFVbRJZA5DXL08jlR2XkYnA31C724agOC23RFmtL
         AivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569068; x=1691161068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEPj9MNRtJknVYwMtm8K9KHPmosJrfBiNj5dYN7jj4s=;
        b=HdYf/rRKS5Y3AXdg3xTagtdVJoy1mlLwIAwGOF6q0/lHLFyDypGM/5x0f4HcSql+Kp
         dw5j653hhy3ClTKXwjY6MsUrrLqAhoOP7W/dF3J9Bum/Vh4qSP47+83kYjFoDSqgQklP
         r7oq7e2aYFAn3hFPVw+c4/Qol6wSLaHYse40EQEsAJJYd8lsR7zNZE+oXbEkBmOmNo7l
         NY/BQbRUnkpE1rNOvBH2/FtKwDYabgC4g6H9BWlIof7kJvYkvZvfjMgN9hEhx7lAbhiP
         IWRwJchr9vJUF35pUf74EwtqV7lhcFkbJtrplkWCkUwfpfqjAEPdLVTPkH9Lbf6EhhdJ
         NyBg==
X-Gm-Message-State: ABy/qLabR6ngd5SdNQ6AKWF/eyJ2FsxprHrPyaFSGckDMMZJW7bPHGWW
        xZy8PH09TlncKSE/muh9M5EjrQ==
X-Google-Smtp-Source: APBJJlG6vsOX8k1cNJ3Gt/TYjk/rLFTMAwz7DghyTLEbVq4DCsOgN3iLG2kBiKyjXRn8cJ67PK8zBA==
X-Received: by 2002:aa7:de1a:0:b0:51d:ec25:ce38 with SMTP id h26-20020aa7de1a000000b0051dec25ce38mr12241724edv.10.1688569068018;
        Wed, 05 Jul 2023 07:57:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g25-20020aa7c859000000b0050cc4461fc5sm13044558edt.92.2023.07.05.07.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:57:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] powerpc: dts: add missing space before {
Date:   Wed,  5 Jul 2023 16:57:43 +0200
Message-Id: <20230705145743.292855-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/powerpc/boot/dts/fsl/c293si-post.dtsi  | 12 ++++++------
 arch/powerpc/boot/dts/fsl/p1022rdk.dts      | 10 +++++-----
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi |  2 +-
 arch/powerpc/boot/dts/fsl/p3041ds.dts       |  4 ++--
 arch/powerpc/boot/dts/fsl/p5040ds.dts       |  2 +-
 arch/powerpc/boot/dts/fsl/t4240qds.dts      |  2 +-
 arch/powerpc/boot/dts/mpc5121.dtsi          |  2 +-
 arch/powerpc/boot/dts/mpc5125twr.dts        |  2 +-
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/c293si-post.dtsi b/arch/powerpc/boot/dts/fsl/c293si-post.dtsi
index bec0fc36849d..f208fb8f64b3 100644
--- a/arch/powerpc/boot/dts/fsl/c293si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/c293si-post.dtsi
@@ -124,10 +124,10 @@ crypto@80000 {
 		reg = <0x80000 0x20000>;
 		ranges = <0x0 0x80000 0x20000>;
 
-		jr@1000{
+		jr@1000 {
 			interrupts = <45 2 0 0>;
 		};
-		jr@2000{
+		jr@2000 {
 			interrupts = <57 2 0 0>;
 		};
 	};
@@ -140,10 +140,10 @@ crypto@a0000 {
 		reg = <0xa0000 0x20000>;
 		ranges = <0x0 0xa0000 0x20000>;
 
-		jr@1000{
+		jr@1000 {
 			interrupts = <49 2 0 0>;
 		};
-		jr@2000{
+		jr@2000 {
 			interrupts = <50 2 0 0>;
 		};
 	};
@@ -156,10 +156,10 @@ crypto@c0000 {
 		reg = <0xc0000 0x20000>;
 		ranges = <0x0 0xc0000 0x20000>;
 
-		jr@1000{
+		jr@1000 {
 			interrupts = <55 2 0 0>;
 		};
-		jr@2000{
+		jr@2000 {
 			interrupts = <56 2 0 0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/p1022rdk.dts b/arch/powerpc/boot/dts/fsl/p1022rdk.dts
index 29e8af1e3711..4261c2f7e4b3 100644
--- a/arch/powerpc/boot/dts/fsl/p1022rdk.dts
+++ b/arch/powerpc/boot/dts/fsl/p1022rdk.dts
@@ -60,23 +60,23 @@ rtc@68 {
 				compatible = "st,m41t62";
 				reg = <0x68>;
 			};
-			adt7461@4c{
+			adt7461@4c {
 				compatible = "adi,adt7461";
 				reg = <0x4c>;
 			};
-			zl6100@21{
+			zl6100@21 {
 				compatible = "isil,zl6100";
 				reg = <0x21>;
 			};
-			zl6100@24{
+			zl6100@24 {
 				compatible = "isil,zl6100";
 				reg = <0x24>;
 			};
-			zl6100@26{
+			zl6100@26 {
 				compatible = "isil,zl6100";
 				reg = <0x26>;
 			};
-			zl6100@29{
+			zl6100@29 {
 				compatible = "isil,zl6100";
 				reg = <0x29>;
 			};
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 5f51b7bfc064..093e4e3ed368 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -238,7 +238,7 @@ global-utilities@e0000 {
 		fsl,has-rstcr;
 	};
 
-	power@e0070{
+	power@e0070 {
 		compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc";
 		reg = <0xe0070 0x20>;
 	};
diff --git a/arch/powerpc/boot/dts/fsl/p3041ds.dts b/arch/powerpc/boot/dts/fsl/p3041ds.dts
index 6f5f7283c533..ca0e0272ac62 100644
--- a/arch/powerpc/boot/dts/fsl/p3041ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p3041ds.dts
@@ -41,7 +41,7 @@ / {
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
-	aliases{
+	aliases {
 		phy_rgmii_0 = &phy_rgmii_0;
 		phy_rgmii_1 = &phy_rgmii_1;
 		phy_sgmii_1c = &phy_sgmii_1c;
@@ -165,7 +165,7 @@ adt7461@4c {
 			};
 		};
 
-		fman@400000{
+		fman@400000 {
 			ethernet@e0000 {
 				phy-handle = <&phy_sgmii_1c>;
 				phy-connection-type = "sgmii";
diff --git a/arch/powerpc/boot/dts/fsl/p5040ds.dts b/arch/powerpc/boot/dts/fsl/p5040ds.dts
index 30850b3228e0..5cfc689ee474 100644
--- a/arch/powerpc/boot/dts/fsl/p5040ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p5040ds.dts
@@ -41,7 +41,7 @@ / {
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
-	aliases{
+	aliases {
 		phy_sgmii_slot2_1c = &phy_sgmii_slot2_1c;
 		phy_sgmii_slot2_1d = &phy_sgmii_slot2_1d;
 		phy_sgmii_slot2_1e = &phy_sgmii_slot2_1e;
diff --git a/arch/powerpc/boot/dts/fsl/t4240qds.dts b/arch/powerpc/boot/dts/fsl/t4240qds.dts
index c0913ac5aaad..128b5798bb97 100644
--- a/arch/powerpc/boot/dts/fsl/t4240qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240qds.dts
@@ -41,7 +41,7 @@ / {
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
-	aliases{
+	aliases {
 		phy_rgmii1 = &phyrgmii1;
 		phy_rgmii2 = &phyrgmii2;
 		phy_sgmii3 = &phy3;
diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index 3f66b91a8e3c..d3fc8062fbcd 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -140,7 +140,7 @@ clks: clock@f00 {
 		};
 
 		/* Power Management Controller */
-		pmc@1000{
+		pmc@1000 {
 			compatible = "fsl,mpc5121-pmc";
 			reg = <0x1000 0x100>;
 			interrupts = <83 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc5125twr.dts b/arch/powerpc/boot/dts/mpc5125twr.dts
index 0bd2acc0401d..ee090709aa3a 100644
--- a/arch/powerpc/boot/dts/mpc5125twr.dts
+++ b/arch/powerpc/boot/dts/mpc5125twr.dts
@@ -104,7 +104,7 @@ clks: clock@f00 {	// Clock control
 			clock-names = "osc";
 		};
 
-		pmc@1000{  // Power Management Controller
+		pmc@1000 {  // Power Management Controller
 			compatible = "fsl,mpc5121-pmc";
 			reg = <0x1000 0x100>;
 			interrupts = <83 0x2>;
-- 
2.34.1

