Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70711748CF5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjGETFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjGETEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:04:15 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7FA1FEE;
        Wed,  5 Jul 2023 12:03:40 -0700 (PDT)
Received: from p200300ccff0adc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:dc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qH7mk-0017Y1-DS; Wed, 05 Jul 2023 21:03:30 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qH7mj-001UQu-3D;
        Wed, 05 Jul 2023 21:03:30 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, peter.ujfalusi@gmail.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, andreas@kemnade.info,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ARM: dts: omap4: embt2ws: Add audio support
Date:   Wed,  5 Jul 2023 21:03:24 +0200
Message-Id: <20230705190324.355282-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705190324.355282-1-andreas@kemnade.info>
References: <20230705190324.355282-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a headset jack on the connection between control unit
and display. Wire things up to have audio output with MCBSP2 as a master.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap4-epson-embt2ws.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/omap4-epson-embt2ws.dts
index 5e9a997f686b0..ee86981b2e448 100644
--- a/arch/arm/boot/dts/omap4-epson-embt2ws.dts
+++ b/arch/arm/boot/dts/omap4-epson-embt2ws.dts
@@ -46,6 +46,24 @@ key-lock {
 		};
 	};
 
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "BT2 Sound";
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+
+		sound_master: simple-audio-card,cpu {
+			system-clock-frequency = <24000000>;
+			sound-dai = <&mcbsp2>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&tlv320aic3x>;
+			system-clock-frequency = <24000000>;
+		};
+	};
+
 	unknown_supply: unknown-supply {
 		compatible = "regulator-fixed";
 		regulator-name = "unknown";
@@ -274,6 +292,9 @@ &mcbsp2 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcbsp2_pins>;
+	assigned-clocks = <&abe_clkctrl OMAP4_MCBSP2_CLKCTRL 24>;
+	assigned-clock-parents = <&abe_clkctrl OMAP4_MCBSP2_CLKCTRL 26>;
+
 	status = "okay";
 };
 
-- 
2.39.2

