Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185EB713927
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjE1LXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1LXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:23:09 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD5DB8;
        Sun, 28 May 2023 04:23:08 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7748d634a70so200373539f.2;
        Sun, 28 May 2023 04:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685272988; x=1687864988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd4VCw8uMBSfA/O5eCNaB5FaYFoqdGeVNbX8CtNIaGY=;
        b=Xk3W5F2i0PpnecOJrDZGgR0zMuNVmWj5lALPFlM6CdkDRbByPMLJ6sJUS6sARuXIYb
         ijKUlBBX33e9v40iYRmBKU3Kn7WYOt9bwkNaRD9VySdbBPrW++tzYWhJH0X3AAXmd+lL
         t8aH3CLjfXdpSsVCjNQf2enbBrjdIc9NGcfr8l+vhhC0H4ALE/2jpmLpl20Fj2dJhdR1
         yAkepsNS6FIQMIlNc9NHPlzNH+BzA7ix9nifRNlpMNdgY1WQoR0XCyqwjRJK+R3deZ1k
         XnW7y8Hqlt564FWSY9/rC+VtuYdq+hc77WtAUXdYr25yJ8t65CG5mr6B8xTvMZRumCzs
         gGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685272988; x=1687864988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yd4VCw8uMBSfA/O5eCNaB5FaYFoqdGeVNbX8CtNIaGY=;
        b=g7BZvOaiI+sZj9PZgMowate2tUjiR+6zbAQi5f8OYsqIvXNcg8wVEchhzKsnlW9J25
         rFoIPZCH+Cg2X6yknzIntRx8A4cX6Ro/lB9Z6jeYFZP1/Tzv9Lv4C8YZba+f4g3v7HBu
         8gTQKRAV1eJEEc9skTG0ZbSS0bV4ttvVksPmQqtyiGHUxOSUw2Cy0BpixWo6k3Xg8i4W
         +FpkIuFl7YGlErP1iU/KzU7tOcVdKU4LoIXEXp/dQmR4qFrwBlF6b5APe0ogp8OBqnUr
         JKWNQBdZQJef9FHZvu4PCXHM8F46Bt/fMQQEvoul4Bbna7jCpWlKKnencExgdaKXIbBP
         cQIw==
X-Gm-Message-State: AC+VfDyAtK1Ss9vwuc4IoQVTq4zrko01SkXzBb35cnN4jepCafV5UDnx
        VSI92GqdqLxaNuSWGC6OHH4=
X-Google-Smtp-Source: ACHHUZ43RRML58IYC4q9sm/B8z6Mtb9LZLrwl17nViL8pv9fgqd1oNhJW0BQKle7eFTZ22EwcF8fqQ==
X-Received: by 2002:a5e:c20b:0:b0:777:4be:8b4b with SMTP id v11-20020a5ec20b000000b0077704be8b4bmr5425843iop.13.1685272987666;
        Sun, 28 May 2023 04:23:07 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:2abe:81ec:481:190b])
        by smtp.gmail.com with ESMTPSA id n40-20020a027168000000b004178754b24bsm2305814jaf.166.2023.05.28.04.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 04:23:07 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] arm64: dts: imx8mn-beacon: Migrate sound card to simple-audio-card
Date:   Sun, 28 May 2023 06:22:53 -0500
Message-Id: <20230528112254.2634028-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a custom glue layer connecting the wm8962 CODEC
to the SAI3 sound-dai, migrate the sound card to simple-audio-card.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 6dce77a6114c..038ef8a3e604 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -74,18 +74,30 @@ reg_usb_otg_vbus: regulator-usb {
 		enable-active-high;
 	};
 
-	sound {
-		compatible = "fsl,imx-audio-wm8962";
-		model = "wm8962-audio";
-		audio-cpu = <&sai3>;
-		audio-codec = <&wm8962>;
-		audio-routing =
-			"Headphone Jack", "HPOUTL",
-			"Headphone Jack", "HPOUTR",
-			"Ext Spk", "SPKOUTL",
-			"Ext Spk", "SPKOUTR",
-			"AMIC", "MICBIAS",
-			"IN3R", "AMIC";
+	sound-wm8962 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm8962";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets = "Headphone", "Headphones",
+					    "Microphone", "Headset Mic",
+					    "Speaker", "Speaker";
+		simple-audio-card,routing = "Headphones", "HPOUTL",
+					    "Headphones", "HPOUTR",
+					    "Speaker", "SPKOUTL",
+					    "Speaker", "SPKOUTR",
+					    "Headset Mic", "MICBIAS",
+					    "IN3R", "Headset Mic";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&wm8962>;
+			clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
+			frame-master;
+			bitclock-master;
+		};
 	};
 };
 
@@ -183,6 +195,7 @@ wm8962: audio-codec@1a {
 			0x0000 /* 4:FN_DMICCDAT */
 			0x0000 /* 5:Default */
 		>;
+		#sound-dai-cells = <0>;
 	};
 };
 
-- 
2.39.2

