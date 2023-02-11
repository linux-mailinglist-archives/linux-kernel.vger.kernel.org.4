Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B522A69301F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjBKKuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBKKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:50:13 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964C3227AD;
        Sat, 11 Feb 2023 02:50:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cq19so4465106edb.5;
        Sat, 11 Feb 2023 02:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT3cifnR/+tF3ipaHkd5EngPDjJXOxPeEMnt+INTFqo=;
        b=W0zeHcrj8kI2dG485h6uY8dJc5EVSp5fpK/HzIBRGOCRRynJf6YJ8mxmCImqC+soX2
         jYl4EZjR3cF+3KOUbhAAI12oXZFrCjOUqNug/g6V0WugPhC2W69Eh+O5rt1T74Lq/d/Y
         z9ZEflzjw6PKG12iH7nkrI8zIzfAEyJ01JGrAhoD86vOejsAulG6yDtbB/MwoW+apuqR
         tdfER9fo3BdXvz5GvOHSfy2+qXCKqtNqdp5ZDhrwoMOha/hqD9i6Zqx8o6Z6O1/TpYnu
         S3xrgUyI2x4vKh4cRspdJeqKfEQFeB4RsjNH/u2pX2Vvswf2FnTNE3Wr956BYiyLfkHD
         K8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT3cifnR/+tF3ipaHkd5EngPDjJXOxPeEMnt+INTFqo=;
        b=CCdCzranGbUIgkA1b7fQuPXiBYrmu17t2/peiK4Oc0Gzf8KgRa3+z9PmyzKVD/gnlN
         e/DI82U8giZrJebXewF1RH6h83U5q1rV/K1An3GrqGJhoUEOGaFfLvyTXE7sQOYZDvIw
         KRoSclBDX3b9ti0GkIpFSJv+baumJSmvTkCkaiIaJ4bo4HC/HjK49mT7QvM2TJsPBybE
         IFHuEMuD2NnZlCsBa4C3s+MiwgVluhKpTSpbGrqFGxIrPYodwwwRr4DtImDFIlSVcz2h
         20LMC17LCDJqSdNFDeb8eRu/6+xPJcgKB9a0vH7LZH7xp2SMqMj4oK7ntEFed+4PiuWc
         gqWg==
X-Gm-Message-State: AO0yUKUu9/Eq9BucOnWCdH6G+d/hXaOH46ca12K1HbYfl2ME4eGVH+Fk
        doOeVPnos2lNDKhb+zf50nc=
X-Google-Smtp-Source: AK7set+vWANpOv+9r2aKr1AJCvpXhOs6xKzfgiHggmDBe08EXAg/m5cVy203kP8Q+XiK4tfxqRllXQ==
X-Received: by 2002:a05:6402:5297:b0:4ab:4410:ae1a with SMTP id en23-20020a056402529700b004ab4410ae1amr1274232edb.15.1676112611049;
        Sat, 11 Feb 2023 02:50:11 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id cb10-20020a0564020b6a00b004ac54d4da22sm1597911edb.71.2023.02.11.02.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 02:50:10 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
Subject: [PATCH 2/2] mips: dts: ralink: mt7621: add port@5 as CPU port
Date:   Sat, 11 Feb 2023 13:49:15 +0300
Message-Id: <20230211104915.116253-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230211104915.116253-1-arinc.unal@arinc9.com>
References: <20230211104915.116253-1-arinc.unal@arinc9.com>
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

On MT7621AT, MT7621DAT, and MT7621ST SoCs, port 5 of the MT7530 switch is
connected to the second MAC of the SoC as a CPU port. Add the port and set
up the second MAC on the bindings. Revert PHY muxing on GB-PC1.

There's an external PHY connected to the second MAC of the SoC on GB-PC2,
therefore, disable port@5 for this device.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../boot/dts/ralink/mt7621-gnubee-gb-pc1.dts  | 16 +++++-----------
 .../boot/dts/ralink/mt7621-gnubee-gb-pc2.dts  |  9 ++++++++-
 arch/mips/boot/dts/ralink/mt7621.dtsi         | 19 ++++++++++++++++++-
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
index 4314aee97e18..129b6710b699 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
@@ -91,22 +91,16 @@ &pcie {
 	status = "okay";
 };
 
-&gmac1 {
-	status = "okay";
-	phy-handle = <&ethphy4>;
-};
-
-&mdio {
-	ethphy4: ethernet-phy@4 {
-		reg = <4>;
-	};
-};
-
 &switch0 {
 	ports {
 		port@0 {
 			status = "okay";
 			label = "ethblack";
 		};
+
+		port@4 {
+			status = "okay";
+			label = "ethblue";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
index 3ebbf933f644..f810cd10f4f4 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
@@ -112,9 +112,12 @@ &pcie {
 };
 
 &gmac1 {
-	status = "okay";
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&ethphy5>;
+
+	fixed-link {
+		status = "disabled";
+	};
 };
 
 &mdio {
@@ -134,5 +137,9 @@ port@4 {
 			status = "okay";
 			label = "ethblue";
 		};
+
+		port@5 {
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index aec85c779359..290d47fbcfbb 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -332,8 +332,13 @@ fixed-link {
 		gmac1: mac@1 {
 			compatible = "mediatek,eth-mac";
 			reg = <1>;
-			status = "disabled";
 			phy-mode = "rgmii";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+				pause;
+			};
 		};
 
 		mdio: mdio-bus {
@@ -384,6 +389,18 @@ port@4 {
 						label = "swp4";
 					};
 
+					port@5 {
+						reg = <5>;
+						ethernet = <&gmac1>;
+						phy-mode = "rgmii";
+
+						fixed-link {
+							speed = <1000>;
+							full-duplex;
+							pause;
+						};
+					};
+
 					port@6 {
 						reg = <6>;
 						ethernet = <&gmac0>;
-- 
2.37.2

