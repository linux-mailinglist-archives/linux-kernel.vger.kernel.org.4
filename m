Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85336AE6D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCGQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCGQfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:35:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD050FB6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:34:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p16so8170621wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678206858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtpQswHmXs0sw0peefJa5VBggDGUC5cf/Wcr23GeMyw=;
        b=Te2kzU0aFUPi1nAwKDem6RJ8hZtHuOALKeHohxd+FVsEFXcdTd8pDLh5BuXss5H47x
         6IKRe+zkKBb0Lk60Ve+iJqGDTov13l4XmuoexwFPftyMxn9AsyZQ0gQv5iLoGAkNlgqc
         GkztZ9hkrcikhc01RTaHmLkbbREsTImxybZe3jaxMjRenSZF4OWWUMJvTSCyJLHxPvI9
         VCznbsrZ9XWhzPZyH+o5gSb6qLaBHVeltOWMFRxuFmVxsRtSrR2/H4dcFo0tjl9uO09I
         pDVNV4CcGLDUNOFMykXFyBujkFTkAgUK9gph7Wg8yR6Z1i93ViwCbd8dYl4RFeKKvyjf
         if8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtpQswHmXs0sw0peefJa5VBggDGUC5cf/Wcr23GeMyw=;
        b=Ludyj02XYV9aK/r4PeDLNGREdGuTwGSZ2t2F3kp3W0H6pVIn1vW4PG0KTuDZJGNThV
         vW608lVBzXZ7QVfsnHis0rQ+OeLGINUNbTFnlrItK4K9Ia0J+o6hHQnYZsWrjMJCM5Ce
         0dk2t5G3TjlHhiIqctXu6MKwJPmauR7laxjxPvi/G8mFHFNzHV1MfZ+T+M4VhMrOxIeg
         NFRjnIlIvQqmEVxpvlCGxi/ySnOwcj8/Xs2rmsDLiFJJfkj6lyfuhK95CVVTOaQpxWsx
         qaG1ibhPVMxwWTX6P/C8xzWdR4ClRiaVtAn449eA0Pjd5Ukn5UyGlUCs290BWfKq3sN6
         2DFQ==
X-Gm-Message-State: AO0yUKUlW0es+IhvhK1jxzmp4rLJmUbVLb+bXe7Xfdvw5ZZZVfzY1PNQ
        VdZbNhPuWfqQ7G4L8tbS7V4IGg==
X-Google-Smtp-Source: AK7set8gIMjYcGL0ERgTaGkjCA0X5qN4GQPSbU27oPyYgvP4N7MFbet0P/tthbT8q7PhqeuSERMyPw==
X-Received: by 2002:a05:600c:46c6:b0:3eb:3cc9:9f85 with SMTP id q6-20020a05600c46c600b003eb3cc99f85mr14879132wmo.26.1678206858257;
        Tue, 07 Mar 2023 08:34:18 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d49c1000000b002c563b124basm12778117wrs.103.2023.03.07.08.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 08:34:18 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH 4/4] arm64: dts: mediatek: mt8192: Add temperature mitigation threshold
Date:   Tue,  7 Mar 2023 17:34:13 +0100
Message-Id: <20230307163413.143334-5-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307163413.143334-1-bchihi@baylibre.com>
References: <20230307163413.143334-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

The mt8192 SoC has several hotspots around the CPUs.
Specify the targeted temperature threshold when to apply
the mitigation and define the associated cooling devices.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 259 ++++++++++++++++++++---
 1 file changed, 225 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 45c3d65a118a..772b9229b2a9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt8192-power.h>
 #include <dt-bindings/reset/mt8192-resets.h>
+#include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/thermal/mediatek,lvts-thermal.h>
 
 / {
@@ -57,6 +58,7 @@ cpu0: cpu@0 {
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@100 {
@@ -68,6 +70,7 @@ cpu1: cpu@100 {
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@200 {
@@ -79,6 +82,7 @@ cpu2: cpu@200 {
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@300 {
@@ -90,6 +94,7 @@ cpu3: cpu@300 {
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu4: cpu@400 {
@@ -101,6 +106,7 @@ cpu4: cpu@400 {
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu5: cpu@500 {
@@ -112,6 +118,7 @@ cpu5: cpu@500 {
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu@600 {
@@ -123,6 +130,7 @@ cpu6: cpu@600 {
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu@700 {
@@ -134,6 +142,7 @@ cpu7: cpu@700 {
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu-map {
@@ -1676,123 +1685,257 @@ larb2: larb@1f002000 {
 
 	thermal_zones: thermal-zones {
 		cpu0-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU0>;
 
 			trips {
+				cpu0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu0_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu0_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu1-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU1>;
 
 			trips {
+				cpu1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu1_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu1_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu2-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU2>;
 
 			trips {
+				cpu2_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu2_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu2_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu3-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU3>;
 
 			trips {
+				cpu3_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu3_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu3_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu4-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU0>;
 
 			trips {
+				cpu4_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu4_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu4_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu5-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU1>;
 
 			trips {
+				cpu5_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu5_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu5_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu6-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU2>;
 
 			trips {
+				cpu6_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu6_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu6_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu7-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU3>;
 
 			trips {
+				cpu7_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu7_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu7_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		vpu0-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8192_AP_VPU0>;
 
 			trips {
+				vpu0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				vpu0_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -1802,11 +1945,17 @@ vpu0_crit: trip-crit {
 		};
 
 		vpu1-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8192_AP_VPU1>;
 
 			trips {
+				vpu1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				vpu1_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -1816,11 +1965,17 @@ vpu1_crit: trip-crit {
 		};
 
 		gpu0-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8192_AP_GPU0>;
 
 			trips {
+				gpu0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				gpu0_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -1830,11 +1985,17 @@ gpu0_crit: trip-crit {
 		};
 
 		gpu1-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8192_AP_GPU1>;
 
 			trips {
+				gpu1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				gpu1_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -1844,11 +2005,17 @@ gpu1_crit: trip-crit {
 		};
 
 		infra-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8192_AP_INFRA>;
 
 			trips {
+				infra_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				infra_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -1858,11 +2025,17 @@ infra_crit: trip-crit {
 		};
 
 		cam-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8192_AP_CAM>;
 
 			trips {
+				cam_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cam_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -1872,11 +2045,17 @@ cam_crit: trip-crit {
 		};
 
 		md0-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8192_AP_MD0>;
 
 			trips {
+				md0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				md0_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -1886,11 +2065,17 @@ md0_crit: trip-crit {
 		};
 
 		md1-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8192_AP_MD1>;
 
 			trips {
+				md1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				md1_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -1900,11 +2085,17 @@ md1_crit: trip-crit {
 		};
 
 		md2-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8192_AP_MD2>;
 
 			trips {
+				md2_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				md2_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
-- 
2.34.1

