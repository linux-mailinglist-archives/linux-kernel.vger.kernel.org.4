Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5566A0C46
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjBWOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjBWOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:54:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5032552DF4;
        Thu, 23 Feb 2023 06:54:36 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C37E6602216;
        Thu, 23 Feb 2023 14:54:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677164075;
        bh=6pu9qitOcCueSg/XyeyLzoSlFZ5o/IQW+VQsBZPX1lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auXFFpiDZrBUMlDFrM3ayviuKcXeH9Y3WZXwAIeHZbbeKfuzs9pa7F1x+JZs9GsIa
         BYbexjJNUdLaXsyCABnXFPF/r3R4fDv7AeFNfohN9k3XkNf1Om0geQyJlOXWP38tX4
         1YyyUvaa08utDnHFamt6ki0jy0kMBnEW/TeCScSvd4H0x33aBoH4XYlEtzNgX1a6E9
         CWHWhaS5F2wr5wn7tmAmW7vniNsK7rHEmL5zH+VaXANNN+mYKGEQp098+DM2t3xKcF
         Q3nemt77J+0QcSSGvoPcBVUTJTvhIxyMl+yHoG0DGtW5fYsV6ivZTFiSjBxNlb+Q1d
         Xh4BGHz0ufAtw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 1/4] arm64: dts: mediatek: cherry: Add platform thermal configuration
Date:   Thu, 23 Feb 2023 15:54:23 +0100
Message-Id: <20230223145426.193590-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com>
References: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This platform has three auxiliary NTC thermistors, connected to the
SoC's ADC pins. Enable the auxadc in order to be able to read the
ADC values, add a generic-adc-thermal LUT for each and finally assign
them to the SoC's thermal zones.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 24669093fbed..ae2052a7160d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -104,6 +104,108 @@ ppvar_sys: regulator-ppvar-sys {
 		regulator-boot-on;
 	};
 
+	tboard_thermistor1: thermal-sensor-t1 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&auxadc 0>;
+		io-channel-names = "sensor-channel";
+		temperature-lookup-table = <	(-5000) 4241
+						0 4063
+						5000 3856
+						10000 3621
+						15000 3364
+						20000 3091
+						25000 2810
+						30000 2526
+						35000 2247
+						40000 1982
+						45000 1734
+						50000 1507
+						55000 1305
+						60000 1122
+						65000 964
+						70000 827
+						75000 710
+						80000 606
+						85000 519
+						90000 445
+						95000 382
+						100000 330
+						105000 284
+						110000 245
+						115000 213
+						120000 183
+						125000 161>;
+	};
+
+	tboard_thermistor2: thermal-sensor-t2 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&auxadc 0>;
+		io-channel-names = "sensor-channel";
+		temperature-lookup-table = <	(-5000) 4241
+						0 4063
+						5000 3856
+						10000 3621
+						15000 3364
+						20000 3091
+						25000 2810
+						30000 2526
+						35000 2247
+						40000 1982
+						45000 1734
+						50000 1507
+						55000 1305
+						60000 1122
+						65000 964
+						70000 827
+						75000 710
+						80000 606
+						85000 519
+						90000 445
+						95000 382
+						100000 330
+						105000 284
+						110000 245
+						115000 213
+						120000 183
+						125000 161>;
+	};
+
+	tboard_thermistor3: thermal-sensor-t3 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&auxadc 0>;
+		io-channel-names = "sensor-channel";
+		temperature-lookup-table = <	(-5000) 4241
+						0 4063
+						5000 3856
+						10000 3621
+						15000 3364
+						20000 3091
+						25000 2810
+						30000 2526
+						35000 2247
+						40000 1982
+						45000 1734
+						50000 1507
+						55000 1305
+						60000 1122
+						65000 964
+						70000 827
+						75000 710
+						80000 606
+						85000 519
+						90000 445
+						95000 382
+						100000 330
+						105000 284
+						110000 245
+						115000 213
+						120000 183
+						125000 161>;
+	};
+
 	usb_vbus: regulator-5v0-usb-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb-vbus";
@@ -243,6 +345,10 @@ &gpu {
 	mali-supply = <&mt6315_7_vbuck1>;
 };
 
+&auxadc {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -1074,6 +1180,24 @@ mt6315_7_vbuck1: vbuck1 {
 	};
 };
 
+&thermal_zones {
+	ap_ntc1 {
+		polling-delay = <1000>;
+		polling-delay-passive = <0>;
+		thermal-sensors = <&tboard_thermistor1>;
+	};
+	ap_ntc2 {
+		polling-delay = <1000>;
+		polling-delay-passive = <0>;
+		thermal-sensors = <&tboard_thermistor2>;
+	};
+	ap_ntc3 {
+		polling-delay = <1000>;
+		polling-delay-passive = <0>;
+		thermal-sensors = <&tboard_thermistor3>;
+	};
+};
+
 &u3phy0 {
 	status = "okay";
 };
-- 
2.39.2

