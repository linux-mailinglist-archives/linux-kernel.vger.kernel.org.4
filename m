Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E1D69254E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjBJSZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjBJSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:25:22 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7160261D24;
        Fri, 10 Feb 2023 10:25:21 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lu11so18214170ejb.3;
        Fri, 10 Feb 2023 10:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=916XgVZ9fASoqPZFrOcZBdhhHsdFw2GVlGXOTRIHOcg=;
        b=HPVGsf5AoDNAGcwvHWXoIKJGcZehK5culQMeKU7O+QqHKQXZnw0SKmRZWWVghdeHlD
         iPohuCwptOedN1FwGCKUrBDgsyzxyJ51x/+rRlKU9XwxSuguE+a4RSErtzi2H1gYPK8P
         YdlLlQkTonP9ChuNfXIvc1DE1YKXKP3Nlb5W/XZ5jFXzSoTw4Mm9uYGzduspkFcWHaMd
         I2JwhjfnJY3bWtUzrUN/mxpybEYvkzMYBzmrBoIB/2FBqfvMRtGGtySyicAQ256K/RL6
         tTD9YT8E+wq5HNADUtR8Lc6r1Bv/9mAkpn5yd+bmvoWGHIzYIok+iPih8DnqT/DdKO/7
         Q9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=916XgVZ9fASoqPZFrOcZBdhhHsdFw2GVlGXOTRIHOcg=;
        b=z/3P+YCy4Y2fC3Enylxat96w3IdUAfwO3Vnpygpge3wPBOFCdQknKC83OZHgbAMZPB
         iDyqPV1glVwP49EURTryM66gZ3ZR6LnBy40I1fGuFnmvJ3oKBy9F4xRTw4SlJwGIE7Ec
         FhXaiIwFi23evOWV+YJKN+95wkRZIhaTFdXdoq6oJ6pP2kqSiMwNT1XUXC3cs1rq6uIV
         HHUbtVQTRQpjDu3VZ4IDT9giXSagwpAirIAtCzEmHJ86A3SBJ/XK429impALAf0dGYOY
         mwMNVxaxJRIoRohFtpPrug8mmMSK6sY5lrqAIMK1uQspB0ALX0wUXLYbkjhARHxbstzf
         oQFw==
X-Gm-Message-State: AO0yUKUPLry6QUrbBjmsm1ImwbbJh6uWYtocmJ0vkRJGwfPBnfGm5Ikz
        jJ8uuigL/OpXSnYg2j9DoF4=
X-Google-Smtp-Source: AK7set/QOnGx6F5MPHmVFkQdlYm4poP8qmAhex/C7DuEuZcrrTjeoJoC8VePE7xv4RouyakS0boaGw==
X-Received: by 2002:a17:906:3892:b0:88a:f42f:579c with SMTP id q18-20020a170906389200b0088af42f579cmr14485145ejd.77.1676053519888;
        Fri, 10 Feb 2023 10:25:19 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906024400b008aef19f678asm2708966ejl.165.2023.02.10.10.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:25:19 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com
Subject: [PATCH v3 2/5] arm: dts: mt7623: add mt7530 switch to mt7623a.dtsi
Date:   Fri, 10 Feb 2023 21:25:02 +0300
Message-Id: <20230210182505.24597-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230210182505.24597-1-arinc.unal@arinc9.com>
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
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

The MT7530 switch is included as a part of the multi-chip module on the
MT7623AI SoC. Add it to mt7623a.dtsi and adjust DTs that call mt7623a.dtsi.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/mt7623a-rfb-emmc.dts | 87 +++++++-------------------
 arch/arm/boot/dts/mt7623a-rfb-nand.dts | 87 +++++++-------------------
 arch/arm/boot/dts/mt7623a.dtsi         | 74 ++++++++++++++++++++++
 3 files changed, 118 insertions(+), 130 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
index a64d68b6e165..5654284bab01 100644
--- a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
+++ b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
@@ -112,74 +112,31 @@ &crypto {
 	status = "okay";
 };
 
-&gmac0 {
-	status = "okay";
-	phy-mode = "trgmii";
+&switch0 {
+	ports {
+		port@0 {
+			status = "okay";
+			label = "lan0";
+		};
 
-	fixed-link {
-		speed = <1000>;
-		full-duplex;
-		pause;
-	};
-};
+		port@1 {
+			status = "okay";
+			label = "lan1";
+		};
 
-&eth {
-	status = "okay";
+		port@2 {
+			status = "okay";
+			label = "lan2";
+		};
+
+		port@3 {
+			status = "okay";
+			label = "lan3";
+		};
 
-	mdio-bus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		switch@0 {
-			compatible = "mediatek,mt7530";
-			reg = <0>;
-			mediatek,mcm;
-			resets = <&ethsys MT2701_ETHSYS_MCM_RST>;
-			reset-names = "mcm";
-			core-supply = <&mt6323_vpa_reg>;
-			io-supply = <&mt6323_vemc3v3_reg>;
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					label = "lan0";
-				};
-
-				port@1 {
-					reg = <1>;
-					label = "lan1";
-				};
-
-				port@2 {
-					reg = <2>;
-					label = "lan2";
-				};
-
-				port@3 {
-					reg = <3>;
-					label = "lan3";
-				};
-
-				port@4 {
-					reg = <4>;
-					label = "wan";
-				};
-
-				port@6 {
-					reg = <6>;
-					label = "cpu";
-					ethernet = <&gmac0>;
-					phy-mode = "trgmii";
-
-					fixed-link {
-						speed = <1000>;
-						full-duplex;
-					};
-				};
-			};
+		port@4 {
+			status = "okay";
+			label = "wan";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/mt7623a-rfb-nand.dts b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
index fac3ca0322c8..afd177b3b516 100644
--- a/arch/arm/boot/dts/mt7623a-rfb-nand.dts
+++ b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
@@ -116,74 +116,31 @@ &crypto {
 	status = "okay";
 };
 
-&gmac0 {
-	status = "okay";
-	phy-mode = "trgmii";
+&switch0 {
+	ports {
+		port@0 {
+			status = "okay";
+			label = "lan0";
+		};
 
-	fixed-link {
-		speed = <1000>;
-		full-duplex;
-		pause;
-	};
-};
+		port@1 {
+			status = "okay";
+			label = "lan1";
+		};
 
-&eth {
-	status = "okay";
+		port@2 {
+			status = "okay";
+			label = "lan2";
+		};
 
-	mdio-bus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		switch@0 {
-			compatible = "mediatek,mt7530";
-			reg = <0>;
-			mediatek,mcm;
-			resets = <&ethsys MT2701_ETHSYS_MCM_RST>;
-			reset-names = "mcm";
-			core-supply = <&mt6323_vpa_reg>;
-			io-supply = <&mt6323_vemc3v3_reg>;
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-					label = "lan0";
-				};
-
-				port@1 {
-					reg = <1>;
-					label = "lan1";
-				};
-
-				port@2 {
-					reg = <2>;
-					label = "lan2";
-				};
-
-				port@3 {
-					reg = <3>;
-					label = "lan3";
-				};
-
-				port@4 {
-					reg = <4>;
-					label = "wan";
-				};
-
-				port@6 {
-					reg = <6>;
-					label = "cpu";
-					ethernet = <&gmac0>;
-					phy-mode = "trgmii";
-
-					fixed-link {
-						speed = <1000>;
-						full-duplex;
-					};
-				};
-			};
+		port@3 {
+			status = "okay";
+			label = "lan3";
+		};
+
+		port@4 {
+			status = "okay";
+			label = "wan";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
index d304b62d24b5..fbb5731a3a53 100644
--- a/arch/arm/boot/dts/mt7623a.dtsi
+++ b/arch/arm/boot/dts/mt7623a.dtsi
@@ -17,8 +17,82 @@ &crypto {
 	power-domains = <&scpsys MT7623A_POWER_DOMAIN_ETH>;
 };
 
+&gmac0 {
+	status = "okay";
+	phy-mode = "trgmii";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
+	};
+};
+
 &eth {
+	status = "okay";
 	power-domains = <&scpsys MT7623A_POWER_DOMAIN_ETH>;
+
+	mdio: mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch0: switch@0 {
+			compatible = "mediatek,mt7530";
+			reg = <0>;
+			mediatek,mcm;
+			resets = <&ethsys MT2701_ETHSYS_MCM_RST>;
+			reset-names = "mcm";
+			core-supply = <&mt6323_vpa_reg>;
+			io-supply = <&mt6323_vemc3v3_reg>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					status = "disabled";
+					reg = <0>;
+					label = "swp0";
+				};
+
+				port@1 {
+					status = "disabled";
+					reg = <1>;
+					label = "swp1";
+				};
+
+				port@2 {
+					status = "disabled";
+					reg = <2>;
+					label = "swp2";
+				};
+
+				port@3 {
+					status = "disabled";
+					reg = <3>;
+					label = "swp3";
+				};
+
+				port@4 {
+					status = "disabled";
+					reg = <4>;
+					label = "swp4";
+				};
+
+				port@6 {
+					reg = <6>;
+					label = "cpu";
+					ethernet = <&gmac0>;
+					phy-mode = "trgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+			};
+		};
+	};
 };
 
 &nandc {
-- 
2.37.2

