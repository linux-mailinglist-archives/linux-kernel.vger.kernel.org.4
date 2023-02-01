Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4C686E78
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjBAS5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjBAS5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:57:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE187D6D6;
        Wed,  1 Feb 2023 10:57:06 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id k4so7956582edo.12;
        Wed, 01 Feb 2023 10:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuwRMKnXVYShc3P97jDcb26qSE0+haHJPdzfJ4jdlqw=;
        b=qmcO0TsXrFJNMB1blLN1OeISeDhx5W/vxRLQQfdyvpO7OLnUH8thmpVDbHr/FlRMJl
         ABTEEI2YgQuyaKsB+ruF4q8sEkGGlJg0313P52N2Eo0QIIDXh7PGesqm/PBViVMWJOIK
         nHPx6wtL7dTikU/IBhclK797ushAwPJ40cHnvE0Xk8hgcvG0fDOCpzz01Ic6Y+BunKM1
         +58w+IsUC7Lg8/4xjj2/bJhJdL47W+rd1LALXI5l2alh0qSck5hdAWTRPczsSJzjR9o5
         uMQzu3kaX2KYqupTPTiJrEG8sZyN2B9H43+U+CZYXxm0nKZ4xJVpeW/yszQVj1Si6Xsb
         ObqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuwRMKnXVYShc3P97jDcb26qSE0+haHJPdzfJ4jdlqw=;
        b=6zW1Y7b/9cfiwLdizYKaqa8HlWDtPmq8pMskNzLZC3ZxNrNhigtSewYUOzmpU+7cKB
         GNAcC37ICsbE45GampC5k+hpGkLwq1IyIlLGnll74ahsxWRElZUkXMlotXlNizsefYof
         4Uvotmml6dLq7S6VKj5JxMxAyCBCjL11aLbuAVpSSoJhGGJnVog4JeLMIzC7mjPw+egs
         T2DSZkDC41C9wfYoB/BEokKIECCW8ikKKNEjMC6i8ColYMHcniX9X3R4qzbqQxqlJeqT
         /oDQ6W/SpFb8wGcrqfoOPUy+kNudZGtNlWSsl1zHjV0tVxbfFSVLD4x9bFAhuNRpfaQO
         5Dlw==
X-Gm-Message-State: AO0yUKVMNYZsFLOFXWq4tmdEtX4nqy2WMUTbdV6YgHqy+G1CpBtj+fAQ
        x2+7od47nEBTOovr/A0kXk4=
X-Google-Smtp-Source: AK7set91GJkEZxaPNp8C1RCo1CWg9qYFPezo1BrwwNKJSy/zr2IdMXM+suS5sMEjj9ygXka+SU820Q==
X-Received: by 2002:a50:fb81:0:b0:498:b9ea:1894 with SMTP id e1-20020a50fb81000000b00498b9ea1894mr3819082edq.15.1675277825071;
        Wed, 01 Feb 2023 10:57:05 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id dy25-20020a05640231f900b0049e210884dasm10100883edb.15.2023.02.01.10.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:57:04 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: [PATCH v2 1/5] arm: dts: mt7623: add gmacs to mt7623.dtsi
Date:   Wed,  1 Feb 2023 21:56:52 +0300
Message-Id: <20230201185656.17164-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230201185656.17164-1-arinc.unal@arinc9.com>
References: <20230201185656.17164-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

There are two gigabit MACs on the MT7623AI and MT7623NI SoCs. Add them to
mt7623.dtsi and adjust the DTs that call mt7623.dtsi.

Now that there are labels for the MACs, remove them from under &eth on the
DTs that call mt7623.dtsi. Remove the unnecessary mdio label from Bananapi
BPI-R2.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/mt7623.dtsi                 | 12 +++++++
 arch/arm/boot/dts/mt7623a-rfb-emmc.dts        | 21 ++++++------
 arch/arm/boot/dts/mt7623a-rfb-nand.dts        | 21 ++++++------
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 23 +++++++------
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        | 32 +++++++++----------
 5 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 25d31e40a553..2bc3c49dc3df 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -981,6 +981,18 @@ eth: ethernet@1b100000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+
+		gmac0: mac@0 {
+			compatible = "mediatek,eth-mac";
+			reg = <0>;
+			status = "disabled";
+		};
+
+		gmac1: mac@1 {
+			compatible = "mediatek,eth-mac";
+			reg = <1>;
+			status = "disabled";
+		};
 	};
 
 	crypto: crypto@1b240000 {
diff --git a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
index e8b4b6d30d19..a64d68b6e165 100644
--- a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
+++ b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
@@ -112,20 +112,19 @@ &crypto {
 	status = "okay";
 };
 
-&eth {
+&gmac0 {
 	status = "okay";
+	phy-mode = "trgmii";
 
-	gmac0: mac@0 {
-		compatible = "mediatek,eth-mac";
-		reg = <0>;
-		phy-mode = "trgmii";
-
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-			pause;
-		};
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
 	};
+};
+
+&eth {
+	status = "okay";
 
 	mdio-bus {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/mt7623a-rfb-nand.dts b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
index 61f5da68d4b0..fac3ca0322c8 100644
--- a/arch/arm/boot/dts/mt7623a-rfb-nand.dts
+++ b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
@@ -116,20 +116,19 @@ &crypto {
 	status = "okay";
 };
 
-&eth {
+&gmac0 {
 	status = "okay";
+	phy-mode = "trgmii";
 
-	gmac0: mac@0 {
-		compatible = "mediatek,eth-mac";
-		reg = <0>;
-		phy-mode = "trgmii";
-
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-			pause;
-		};
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
 	};
+};
+
+&eth {
+	status = "okay";
 
 	mdio-bus {
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 5008115d2494..1e03a3de654f 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -171,22 +171,21 @@ dpi0_out: endpoint {
 	};
 };
 
-&eth {
+&gmac0 {
 	status = "okay";
+	phy-mode = "trgmii";
 
-	gmac0: mac@0 {
-		compatible = "mediatek,eth-mac";
-		reg = <0>;
-		phy-mode = "trgmii";
-
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-			pause;
-		};
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
 	};
+};
+
+&eth {
+	status = "okay";
 
-	mdio: mdio-bus {
+	mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
index bf67a8e9be59..5e328c2a6a6e 100644
--- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
@@ -156,27 +156,25 @@ dpi0_out: endpoint {
 	};
 };
 
-&eth {
+&gmac0 {
 	status = "okay";
+	phy-mode = "trgmii";
 
-	gmac0: mac@0 {
-		compatible = "mediatek,eth-mac";
-		reg = <0>;
-		phy-mode = "trgmii";
-
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-			pause;
-		};
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
 	};
+};
 
-	mac@1 {
-		compatible = "mediatek,eth-mac";
-		reg = <1>;
-		phy-mode = "rgmii";
-		phy-handle = <&phy5>;
-	};
+&gmac1 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&phy5>;
+};
+
+&eth {
+	status = "okay";
 
 	mdio-bus {
 		#address-cells = <1>;
-- 
2.37.2

