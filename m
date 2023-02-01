Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A890686E7B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjBAS5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjBAS5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:57:09 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715497D6E6;
        Wed,  1 Feb 2023 10:57:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m8so9492088edd.10;
        Wed, 01 Feb 2023 10:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=916XgVZ9fASoqPZFrOcZBdhhHsdFw2GVlGXOTRIHOcg=;
        b=j4jCT3RNd4Fl3IhtsLOweL6JFnXgXuaJ/jZ7h5FNY5pcpO0mVtox0Bw4f9DvCnj+Gy
         TlaDzjmQcLkuQ5UfFWUPAEWCMVbM/Qii1P9+/lfII9nl99vUtkf9Os/1pizWpKOQjnoi
         lm/VQiytbkIqkefka60dSPUHl72SVAij0U/DbvLRldYFD5pyuGYvtZaqYPveBlWqk/NC
         HwoeqEjQK/c8BwCYzH4SZDRlqh3qMcu8bPUDYb08FqXAMGz6ap8C5r1ROOGK0pSuO1Jb
         5xnmaoxSdB6IxJ5byRjWV6mAMFnUVHJ4n93zietmRiYVRZXXUJn7Pfkcf0QR58k6nQl+
         iM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=916XgVZ9fASoqPZFrOcZBdhhHsdFw2GVlGXOTRIHOcg=;
        b=yqCXGTuL8dSPQO7weqjzO5XVioWoyoidB8Z5BzaAYBKxMATu/83xIrsFgQf/q2W/uw
         tmJ1sKE9lTqSx1JnAO/RpqgfkTgtiORy54uiiEhuDXSPzH0zr1z2B3bnlr4657X9Vc3N
         57OViRCSkkaL4nSWBTpNCSDReRsG/CTzJh4Yf0QKr/NA/2+RpcRGgMVZOpHyKdpL+adp
         Hz044yW81Qu/n6livk7tsYxIHrTwu/GzJCh+ai08NNg41SK41lzUJuKkigGayaMh9UNs
         xgzfsnHw3NZsR4vRxTVIHIwVVf44W0q9QOq2ssJkvP3K2EBaTo1vFne3UcApIibHkvfp
         H6dA==
X-Gm-Message-State: AO0yUKX/44W94Rp21WCYpTxk4KDkfHKb4k6pXsP4O+razBmcfh29Ojv1
        83YE4FMRa2O+osGlpS0LNaCHCS/WkkmV9U0E
X-Google-Smtp-Source: AK7set+2KbiCTcddKLi6FlDnx9PjS8pp/NRXkaAMusiSZph4MTOlIO/4yg8XJu6FxV/4hlEXoGy56g==
X-Received: by 2002:a05:6402:1950:b0:4a2:260f:3bbe with SMTP id f16-20020a056402195000b004a2260f3bbemr3759756edz.23.1675277826917;
        Wed, 01 Feb 2023 10:57:06 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id dy25-20020a05640231f900b0049e210884dasm10100883edb.15.2023.02.01.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:57:06 -0800 (PST)
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
Subject: [PATCH v2 2/5] arm: dts: mt7623: add mt7530 switch to mt7623a.dtsi
Date:   Wed,  1 Feb 2023 21:56:53 +0300
Message-Id: <20230201185656.17164-3-arinc.unal@arinc9.com>
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

