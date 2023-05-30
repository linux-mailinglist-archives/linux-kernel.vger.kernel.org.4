Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE0D716E21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjE3Tv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjE3Tvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:51:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436A510D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:51:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3094910b150so5077463f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685476299; x=1688068299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/26ccg5UkeFfqvntqjKwDaHuOQm1W6x41JMO1nG6zU=;
        b=XyFGMMOyKph0D9oa4EszjwbtTRfJEzIwixk9NBnU8N815oO5wXlX4qZdGMSIov38DU
         nlK6OSpMqSwROslCNHlEddqvonLNsMTBwYcCKJcztSB5+VvEOV37CU3ZHBZZbQ7L8adY
         KNl0Owq/1fFZPctFFVcrDlrQbwqv+TAqTT1hIUTJqrewjAS4gMn7WMWtYEpysW2k0U4b
         Zy/XZA1yqw6xDVL3et+4HgEicUjf4GYsnARIHD/oNQVLcqMTjz7BUBrp3pP/Si1U0+5b
         ev1/SOlNcxtqaWzy3a5P148+NjZlwBNeph5DTaxUXL2849R5NeuyVRehOSLATGdDcosP
         nx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685476299; x=1688068299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/26ccg5UkeFfqvntqjKwDaHuOQm1W6x41JMO1nG6zU=;
        b=fHNSd3149LikYLs9ka4gv+DLyG1ZTMCDD9De27AklaJufaxFQKvqKBTeTUNieKugnH
         RGjutnp/Pvvad109js0h0kncC7sRj/+qDowgeisezSFPr9RqM1eb1WuSwcD4Q1eMoU6s
         7azAKVqNiRsKGOSFQHQn2XnDiPRwR9tuYXqyQChjCrn2ryqqEQeyn5720E1gewMBfYWM
         3N6ajnmhBeOJaacdoS5CLcBe1q5rGq1iZ0cVof2P7qXeeZaAjfn7ajxEGh4TbPgkFpu8
         U1MPgS9VuafSWSB9lFyIocXH1xjzsr07KWy/jCi3i9xkOED48DEMOprntitVNerxuQ3m
         8iGA==
X-Gm-Message-State: AC+VfDwH/+Ee4FR1HcXHyAoSAp6wVtoMFswJtBhX/0TLyfqamx0gaTRH
        b8Xt0jPnZWYefgN4IOl1poGETg==
X-Google-Smtp-Source: ACHHUZ4SY0ErVlPy0hqnvzFc1JeYBScUlCGguUGoy6VwpBtZ/zCVUj307MnsUh84vV2kADB77B7ODg==
X-Received: by 2002:adf:f591:0:b0:2ef:eb54:4dc0 with SMTP id f17-20020adff591000000b002efeb544dc0mr2383040wro.51.1685476299726;
        Tue, 30 May 2023 12:51:39 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n11-20020adfe34b000000b003078cd719ffsm4271545wrj.95.2023.05.30.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 12:51:39 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v4 4/5] arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones
Date:   Tue, 30 May 2023 21:51:31 +0200
Message-ID: <20230530195132.2286163-5-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <20230530195132.2286163-1-bero@baylibre.com>
References: <20230530195132.2286163-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add thermal nodes and thermal zones for the mt8192.
The mt8192 SoC has several hotspots around the CPUs.
Specify the targeted temperature threshold to apply the mitigation
and define the associated cooling devices.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[bero@baylibre.com: cosmetic changes, reduce lvts_ap size]
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 454 +++++++++++++++++++++++
 1 file changed, 454 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 65bc8b4046211..82d6629e38c26 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -14,6 +14,8 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt8192-power.h>
 #include <dt-bindings/reset/mt8192-resets.h>
+#include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
 
 / {
 	compatible = "mediatek,mt8192";
@@ -71,6 +73,7 @@ cpu0: cpu@0 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@100 {
@@ -88,6 +91,7 @@ cpu1: cpu@100 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@200 {
@@ -105,6 +109,7 @@ cpu2: cpu@200 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@300 {
@@ -122,6 +127,7 @@ cpu3: cpu@300 {
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu4: cpu@400 {
@@ -139,6 +145,7 @@ cpu4: cpu@400 {
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu5: cpu@500 {
@@ -156,6 +163,7 @@ cpu5: cpu@500 {
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu@600 {
@@ -173,6 +181,7 @@ cpu6: cpu@600 {
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu@700 {
@@ -190,6 +199,7 @@ cpu7: cpu@700 {
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu-map {
@@ -775,6 +785,17 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts_ap: thermal-sensor@1100b000 {
+			compatible = "mediatek,mt8192-lvts-ap";
+			reg = <0 0x1100b000 0 0xc00>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			resets = <&infracfg MT8192_INFRA_RST0_THERM_CTRL_SWRST>;
+			nvmem-cells = <&lvts_e_data1>;
+			nvmem-cell-names = "lvts-calib-data-1";
+			#thermal-sensor-cells = <1>;
+		};
+
 		pwm0: pwm@1100e000 {
 			compatible = "mediatek,mt8183-disp-pwm";
 			reg = <0 0x1100e000 0 0x1000>;
@@ -1101,6 +1122,17 @@ nor_flash: spi@11234000 {
 			status = "disabled";
 		};
 
+		lvts_mcu: thermal-sensor@11278000 {
+			compatible = "mediatek,mt8192-lvts-mcu";
+			reg = <0 0x11278000 0 0x1000>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			resets = <&infracfg MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+			nvmem-cells = <&lvts_e_data1>;
+			nvmem-cell-names = "lvts-calib-data-1";
+			#thermal-sensor-cells = <1>;
+		};
+
 		efuse: efuse@11c10000 {
 			compatible = "mediatek,mt8192-efuse", "mediatek,efuse";
 			reg = <0 0x11c10000 0 0x1000>;
@@ -1827,4 +1859,426 @@ larb2: larb@1f002000 {
 			power-domains = <&spm MT8192_POWER_DOMAIN_MDP>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU0>;
+
+			trips {
+				cpu0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu0_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU1>;
+
+			trips {
+				cpu1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu1_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU2>;
+
+			trips {
+				cpu2_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu2_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu2_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU3>;
+
+			trips {
+				cpu3_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu3_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu3_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu4-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU0>;
+
+			trips {
+				cpu4_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu4_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu4_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu5-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU1>;
+
+			trips {
+				cpu5_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu5_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu5_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu6-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU2>;
+
+			trips {
+				cpu6_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu6_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu6_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu7-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU3>;
+
+			trips {
+				cpu7_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu7_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu7_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		vpu0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_VPU0>;
+
+			trips {
+				vpu0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				vpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		vpu1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_VPU1>;
+
+			trips {
+				vpu1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				vpu1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_GPU0>;
+
+			trips {
+				gpu0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_GPU1>;
+
+			trips {
+				gpu1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		infra-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_INFRA>;
+
+			trips {
+				infra_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				infra_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cam-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_CAM>;
+
+			trips {
+				cam_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cam_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		md0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_MD0>;
+
+			trips {
+				md0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				md0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		md1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_MD1>;
+
+			trips {
+				md1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				md1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		md2-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_MD2>;
+
+			trips {
+				md2_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				md2_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.41.0.rc2

