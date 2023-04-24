Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1076ECB47
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjDXLZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDXLZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:25:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A922211F;
        Mon, 24 Apr 2023 04:25:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04141660324D;
        Mon, 24 Apr 2023 12:25:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682335529;
        bh=D8ECh98ZW5Kp7rjGcRUYfmB3ikfORMr6hVs/EvaqyaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMSJiDYplbt6V/NtGqCKbsjzj3AIscEoQ3/m3uKqfWxyGQDDQdvwTb4XEcgR91l0a
         4Ydp7xkJEWC7jO70TBhX7ZDSEzrAC7OMYzoGKUt7N3daMCxUpGtqU4sJdIpjnMxtll
         dPm8sBASqqjqcjp9H9CWTI+n4CfDA9oI6SjSE6ggA8FUuPNVUPScGRUUBd46+XsWbE
         EI1Kht2/031xfkxXwnK34CxtbRF9PCkW/uSlP/Qewo604FXRTk0U/xgW5bnMjXBX+V
         9NCkzTw21tByLmT/oTiZnRmZPOEcHY4bcjjfjAue3qGa4wcRXUlSjo0wFoR0MbibLW
         pR6XEkQ5oe1eA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 1/4] arm64: dts: mediatek: cherry: Add platform thermal configuration
Date:   Mon, 24 Apr 2023 13:25:20 +0200
Message-Id: <20230424112523.1436926-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 8ac80a136c37..4229f4f7dc2f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -114,6 +114,77 @@ ppvar_sys: regulator-ppvar-sys {
 		regulator-boot-on;
 	};
 
+	/* Murata NCP03WF104F05RL */
+	tboard_thermistor1: thermal-sensor-t1 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&auxadc 0>;
+		io-channel-names = "sensor-channel";
+		temperature-lookup-table = <	(-10000) 1553
+						(-5000) 1485
+						0 1406
+						5000 1317
+						10000 1219
+						15000 1115
+						20000 1007
+						25000 900
+						30000 796
+						35000 697
+						40000 605
+						45000 523
+						50000 449
+						55000 384
+						60000 327
+						65000 279
+						70000 237
+						75000 202
+						80000 172
+						85000 147
+						90000 125
+						95000 107
+						100000 92
+						105000 79
+						110000 68
+						115000 59
+						120000 51
+						125000 44>;
+	};
+
+	tboard_thermistor2: thermal-sensor-t2 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&auxadc 1>;
+		io-channel-names = "sensor-channel";
+		temperature-lookup-table = <	(-10000) 1553
+						(-5000) 1485
+						0 1406
+						5000 1317
+						10000 1219
+						15000 1115
+						20000 1007
+						25000 900
+						30000 796
+						35000 697
+						40000 605
+						45000 523
+						50000 449
+						55000 384
+						60000 327
+						65000 279
+						70000 237
+						75000 202
+						80000 172
+						85000 147
+						90000 125
+						95000 107
+						100000 92
+						105000 79
+						110000 68
+						115000 59
+						120000 51
+						125000 44>;
+	};
+
 	usb_vbus: regulator-5v0-usb-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb-vbus";
@@ -260,6 +331,10 @@ &gpu {
 	mali-supply = <&mt6315_7_vbuck1>;
 };
 
+&auxadc {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -1098,6 +1173,36 @@ mt6315_7_vbuck1: vbuck1 {
 	};
 };
 
+&thermal_zones {
+	soc-area-thermal {
+		polling-delay = <1000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&tboard_thermistor1>;
+
+		trips {
+			trip-crit {
+				temperature = <84000>;
+				hysteresis = <1000>;
+				type = "critical";
+			};
+		};
+	};
+
+	pmic-area-thermal {
+		polling-delay = <1000>;
+		polling-delay-passive = <0>;
+		thermal-sensors = <&tboard_thermistor2>;
+
+		trips {
+			trip-crit {
+				temperature = <84000>;
+				hysteresis = <1000>;
+				type = "critical";
+			};
+		};
+	};
+};
+
 &u3phy0 {
 	status = "okay";
 };
-- 
2.40.0

