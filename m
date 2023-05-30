Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE8B716E76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjE3UNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjE3UNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:13:36 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A24106;
        Tue, 30 May 2023 13:13:35 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id 9E38062608;
        Tue, 30 May 2023 20:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1685477613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXh/enNCt6k/VhDbW4GU/2xM8uza5LciUBEJxVS6EdI=;
        b=CI8BBcYbvix0dTim705n4OMjImZz6V/xlQ/NOsayZsWYdaz0AMBFPnx4W2blggIxZ/o0QE
        Njfo1MNnEJtOuhKnGyrFzzIdLc3sxhRtuv5vSk5vRDlUurCYgBuof80wfqZi0fplupWlY5
        xzgWfpJE1thUuH9z6qij6vrdS68CrYI=
Received: from frank-G5.. (fttx-pool-217.61.157.145.bambit.de [217.61.157.145])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 649944092B;
        Tue, 30 May 2023 20:13:32 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v3 2/4] arm64: dts: mt7986: add thermal and efuse
Date:   Tue, 30 May 2023 22:12:33 +0200
Message-Id: <20230530201235.22330-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530201235.22330-1-linux@fw-web.de>
References: <20230530201235.22330-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: ad369705-4d0d-4dc7-9ee8-39fb1ed9b23d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Golle <daniel@makrotopia.org>

Add thermal related nodes to mt7986 devicetree.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
changes in v3:
- efuse compatibles in one line
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 36 ++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index aa9e679b78e2..ad4fd77b65a7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -337,6 +337,15 @@ spi1: spi@1100b000 {
 			status = "disabled";
 		};
 
+		auxadc: adc@1100d000 {
+			compatible = "mediatek,mt7986-auxadc";
+			reg = <0 0x1100d000 0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_ADC_26M_CK>;
+			clock-names = "main";
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
 		ssusb: usb@11200000 {
 			compatible = "mediatek,mt7986-xhci",
 				     "mediatek,mtk-xhci";
@@ -375,6 +384,21 @@ mmc0: mmc@11230000 {
 			status = "disabled";
 		};
 
+		thermal: thermal@1100c800 {
+			#thermal-sensor-cells = <1>;
+			compatible = "mediatek,mt7986-thermal";
+			reg = <0 0x1100c800 0 0x800>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_THERM_CK>,
+				 <&infracfg CLK_INFRA_ADC_26M_CK>,
+				 <&infracfg CLK_INFRA_ADC_FRC_CK>;
+			clock-names = "therm", "auxadc", "adc_32k";
+			mediatek,auxadc = <&auxadc>;
+			mediatek,apmixedsys = <&apmixedsys>;
+			nvmem-cells = <&thermal_calibration>;
+			nvmem-cell-names = "calibration-data";
+		};
+
 		pcie: pcie@11280000 {
 			compatible = "mediatek,mt7986-pcie",
 				     "mediatek,mt8192-pcie";
@@ -426,6 +450,17 @@ pcie_port: pcie-phy@11c00000 {
 			};
 		};
 
+		efuse: efuse@11d00000 {
+			compatible = "mediatek,mt7986-efuse", "mediatek,efuse";
+			reg = <0 0x11d00000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			thermal_calibration: calib@274 {
+				reg = <0x274 0xc>;
+			};
+		};
+
 		usb_phy: t-phy@11e10000 {
 			compatible = "mediatek,mt7986-tphy",
 				     "mediatek,generic-tphy-v2";
@@ -567,5 +602,4 @@ wifi: wifi@18000000 {
 			memory-region = <&wmcpu_emi>;
 		};
 	};
-
 };
-- 
2.34.1

