Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA47F6CD700
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjC2Jwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjC2Jwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:52:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CBA130
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t4so9779165wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680083555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMNUy4wAhCokazSv718dgud160aE6dmG6qam8MGG0Pw=;
        b=LWVeUV5dvDRWIswtgoLU5wq18K5REJ6tGVbIMf5Hgl1022SmATQBLVRfde0y0pDcNh
         AFzzHxLefxZbhT5msdgloaFB7GXjJ0Uv+yt8av6VdX4KZwkgGMrBEj+iUSFM5/Mw3xO5
         dsoWaZ/NTESiQ73pPWKWoUpCYHcBoPHnPaQY5MNDVFVTRTzvEOS73H2sOitb5jQBRZ+3
         tjDo78xLwYd2yBe7vF41E7+jf21LIt5PbZ1oWBFrQgH2ecJRkQ+Ap11lF3OAMYoD7D5X
         hzP+6RPqs+Y037NRDQyVMEGBupagYT99PAfsjVyCjpxZa35b4URbhZpSTzxDztX+IvKM
         HF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680083555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMNUy4wAhCokazSv718dgud160aE6dmG6qam8MGG0Pw=;
        b=Uwyw/Sl90eJ4ynrA+CeLHOP+E3v4PPQ9nBiaaLpoFlJjhMyhNCrvTFRC2nZe1KZwMr
         uiF3T+kksKoJJLj28+ilze1aHgQS/AfNvDy1y4Wpx1NhhOQQ71x9lrbjpPMoQBAcgxnX
         t0Qbh9tYNlBI8i7JArp0F7yVYo7jcio3g0opmxBXE9aCd72M0Gu9zABG5+q9J7QFyw25
         kU7nOdtsRa1gV68vUDOBAe3MpWGDeeY0KUP/Gilg2/OAYu1593leOazv4JkBDuHMoSME
         71mb2QRwoj8QZQd8WVop+kH8+XwVGWs3myd0kaBNviub9PZIjOaClEnviZb4XnQ0C7vn
         wQ3A==
X-Gm-Message-State: AAQBX9foVCPUx0t+iMokujJ4siodIu5nUxEhPivQJnb+SiNLcaAr6Oik
        01Kd7SXTpcPeU0f67mXmS+4bbw==
X-Google-Smtp-Source: AKy350aMvJxy0vuFud24VmdACZpUdxzoIkhSBs2yOSCjD8iebcxZ+A1f67XeRW/u48VEKmmc15fN3A==
X-Received: by 2002:a5d:46d2:0:b0:2d8:97c7:713d with SMTP id g18-20020a5d46d2000000b002d897c7713dmr12721945wrs.38.1680083555034;
        Wed, 29 Mar 2023 02:52:35 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm29667158wru.40.2023.03.29.02.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:52:34 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 11:52:22 +0200
Subject: [PATCH RESEND 3/6] arm64: dts: mediatek: add power domain support
 for mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v1-3-4a902f9aa412@baylibre.com>
References: <20230207-iommu-support-v1-0-4a902f9aa412@baylibre.com>
In-Reply-To: <20230207-iommu-support-v1-0-4a902f9aa412@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5182; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=nUqvNVaIUUC9759gt9aIwlcr2X6jsfbNIk6LWHQ+OUU=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJApfq06BV0gO0q20uJQ6YomTxbu2gHvuB6xb27tv
 bdcglIOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCQKXwAKCRArRkmdfjHURcA6D/
 4go9oU5Enmeu99YoHZOKf7xMSxooqDyVQOY/azheIwE9iJr6dLGIix6cs2HNOm7y5vUvd92/uhiJNy
 RxlRE91ZcMRa0+iRMITegvj1qIWiKAppQUe24gcCspGN3IDwkAmur1Kal4jXKbd5Ckz/BdrBflmnuL
 c3RwyHLxiGe5nyVnaIzJuqtyMseEsE7+LUya3D+FABDxFOHewJ6Pq4RBXdP4beyqSF9qh1txpDKyK3
 iWWlOnCoOdEcQ0Sk8t1J/sYKX2Lzt2ZcVsChmdlAjWcVVrbt0zu04aMuDYeTuhPgNWojWyjcNaGnlF
 9JbGNmoLDUu6Xb4iJQDb4iFvr7L7e9UzObuT8bRU5wx/PlAZAGQ8wtNlAz5VCxzCzLhm1//841jpa/
 Zf3JQlRjNMXPp/hxTD5PqQC1tAPYJzunZu6CCljhYamvpZnnwuSFtkjpRpAFYAFujE7fRkB4ZuXJOY
 WGeiu3CjcVVUqMb1gbozOeWijOeQ8ZaFopy96NF7nux8t/5GHRvGsn5vicaYzLqLytQnKgYTOFQPPr
 gvz4TheCWC9NVA0nWhOPL26eq+ISBZFmM5yBleIhXpzTd2reeYcHtglr2xUSh325oFWOm8/blA9m40
 SDOg5ZNXHIl3Fjc3XBJWWuaQA9kvJPfjKAMG1UadG2U+ef0c2+dBzCoO/4Ag==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following power domain are added to the SoC dts:
- MM (MultiMedia)
- CONN (Connectivity)
- MFG (MFlexGraphics)
- Audio
- Cam (Camera)
- DSP (Digital Signal Processor)
- Vdec (Video decoder)
- Venc (Video encoder)
- APU (AI Processor Unit)

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 129 +++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index b5f5c77f7f84..67b375fe2020 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/power/mediatek,mt8365-power.h>
 
 / {
 	compatible = "mediatek,mt8365";
@@ -282,6 +283,115 @@ syscfg_pctl: syscfg-pctl@10005000 {
 			reg = <0 0x10005000 0 0x1000>;
 		};
 
+		scpsys: syscon@10006000 {
+			compatible = "mediatek,mt8365-syscfg", "syscon", "simple-mfd";
+			reg = <0 0x10006000 0 0x1000>;
+			#power-domain-cells = <1>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8365-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				/* power domains of the SoC */
+				power-domain@MT8365_POWER_DOMAIN_MM {
+					reg = <MT8365_POWER_DOMAIN_MM>;
+					clocks = <&topckgen CLK_TOP_MM_SEL>,
+						 <&mmsys CLK_MM_MM_SMI_COMMON>,
+						 <&mmsys CLK_MM_MM_SMI_COMM0>,
+						 <&mmsys CLK_MM_MM_SMI_COMM1>,
+						 <&mmsys CLK_MM_MM_SMI_LARB0>;
+					clock-names = "mm", "mm-0", "mm-1",
+						      "mm-2", "mm-3";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+					mediatek,infracfg-nao = <&infracfg_nao>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					power-domain@MT8365_POWER_DOMAIN_CAM {
+						reg = <MT8365_POWER_DOMAIN_CAM>;
+						clocks = <&camsys CLK_CAM_LARB2>,
+							 <&camsys CLK_CAM_SENIF>,
+							 <&camsys CLK_CAMSV0>,
+							 <&camsys CLK_CAMSV1>,
+							 <&camsys CLK_CAM_FDVT>,
+							 <&camsys CLK_CAM_WPE>;
+						clock-names = "cam-0", "cam-1",
+							      "cam-2", "cam-3",
+							      "cam-4", "cam-5";
+						#power-domain-cells = <0>;
+						mediatek,infracfg = <&infracfg>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_VDEC {
+						reg = <MT8365_POWER_DOMAIN_VDEC>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_VENC {
+						reg = <MT8365_POWER_DOMAIN_VENC>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_APU {
+						reg = <MT8365_POWER_DOMAIN_APU>;
+						clocks = <&infracfg CLK_IFR_APU_AXI>,
+							 <&apu CLK_APU_IPU_CK>,
+							 <&apu CLK_APU_AXI>,
+							 <&apu CLK_APU_JTAG>,
+							 <&apu CLK_APU_IF_CK>,
+							 <&apu CLK_APU_EDMA>,
+							 <&apu CLK_APU_AHB>;
+						clock-names = "apu", "apu-0",
+							      "apu-1", "apu-2",
+							      "apu-3", "apu-4",
+							      "apu-5";
+						#power-domain-cells = <0>;
+						mediatek,infracfg = <&infracfg>;
+					};
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_CONN {
+					reg = <MT8365_POWER_DOMAIN_CONN>;
+					clocks = <&topckgen CLK_TOP_CONN_32K>,
+						 <&topckgen CLK_TOP_CONN_26M>;
+					clock-names = "conn", "conn1";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_MFG {
+					reg = <MT8365_POWER_DOMAIN_MFG>;
+					clocks = <&topckgen CLK_TOP_MFG_SEL>;
+					clock-names = "mfg";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_AUDIO {
+					reg = <MT8365_POWER_DOMAIN_AUDIO>;
+					clocks = <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
+						 <&infracfg CLK_IFR_AUDIO>,
+						 <&infracfg CLK_IFR_AUD_26M_BK>;
+					clock-names = "audio", "audio1", "audio2";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_DSP {
+					reg = <MT8365_POWER_DOMAIN_DSP>;
+					clocks = <&topckgen CLK_TOP_DSP_SEL>,
+						 <&topckgen CLK_TOP_DSP_26M>;
+					clock-names = "dsp", "dsp1";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+			};
+		};
+
 		watchdog: watchdog@10007000 {
 			compatible = "mediatek,mt8365-wdt",
 				     "mediatek,mt6589-wdt";
@@ -592,6 +702,25 @@ u2port1: usb-phy@1000 {
 				#phy-cells = <1>;
 			};
 		};
+
+		mmsys: syscon@14000000 {
+			compatible = "mediatek,mt8365-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		camsys: syscon@15000000 {
+			compatible = "mediatek,mt8365-imgsys", "syscon";
+			reg = <0 0x15000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		apu: syscon@19020000 {
+			compatible = "mediatek,mt8365-apu", "syscon";
+			reg = <0 0x19020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 	};
 
 	timer {

-- 
2.25.1

