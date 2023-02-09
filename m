Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388526905DC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjBIK5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjBIK4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:56:52 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C544C0C3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:56:41 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso3594272wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 02:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q8hw26gwJWXtp5r1FRgkbv2qRbakWQ2u6PTXa3lZjY=;
        b=pBkOx0touhkuyBlg2qnghsZt/3FUPu7IDpVUv/kK+iSBh5RDtfv01cEGnzb1CaHnR4
         eUl4QIoHA+RHfnlg9Km7NGoqmxJU9cOnVECgKnJm6+buPcalE2dnHcpKnoN3ORrrHkC6
         cPPLfdjm3Cmp8w7DLTkDQnNHH8tSkYwNKiby0oJihM1NH3RR/Nc7SORmTiDZDtP/r/mH
         MadwHIZtTfO/3XBPJzBNQZuw0g1xDHLYUrr2j/mMyeVfUZNOtTthR2ao3kiDcWlkKOe7
         LKWZ2p1Abxj7ZG3/kAuA/0/hMGgGqbYAmT9+HY9yFpE/lmmsQndS1yS1wQY4pzaxcVVR
         thLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2q8hw26gwJWXtp5r1FRgkbv2qRbakWQ2u6PTXa3lZjY=;
        b=lYF9zQijsh0HJDETf0IBUwKUzOBeUOI2XdcUERDcJpD2PltCxPnMRBYibpqJC6xKzW
         TzGKrglzrkUUIKhhl4NQ2mTUrva/WrhDfsrTOYQY3mhjc2JZAo/GaCdaN9Fi/mqbmkAd
         HSX4zjYHk6g54t22ow3pXFIIH6N7GwWkmEeXGnzsGFVH/u3uPcsQ+seaZcuML3K/qejx
         nlEKVtbTCUSnrgA7zjFw5Q7wmMtJFpq3nq4mW0qlqKWnH2bT15WIKR3ilsilBuq22eom
         7MEc+TAMWkTFuWeXLpo8GdYOWyAF9X1p+h78Lh3Ak8kLjsTkkLqFubzif3eiV0bEAClZ
         O5BA==
X-Gm-Message-State: AO0yUKVFQ69ku6FOOZicVQm1I/sdl0NAzOipP4EzkBhGgmifJtdxKCyK
        fvclsZeFBYDbWn62+2HociCC1w==
X-Google-Smtp-Source: AK7set8sJM+sYYdkMocTL4fw90ZAvRg4fpY02hAKNq8bcpW4Pul93Z1dRtAKSyvd9IWEj0/DFw12EA==
X-Received: by 2002:a05:600c:35cd:b0:3df:eda1:439c with SMTP id r13-20020a05600c35cd00b003dfeda1439cmr5578177wmq.11.1675940199925;
        Thu, 09 Feb 2023 02:56:39 -0800 (PST)
Received: from t480-bl003.. (185.173.185.81.rev.sfr.net. [81.185.173.185])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b003daf6e3bc2fsm9140466wms.1.2023.02.09.02.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 02:56:39 -0800 (PST)
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
Subject: [PATCH v14 6/6] arm64: dts: mediatek: mt8195: Add temperature mitigation threshold
Date:   Thu,  9 Feb 2023 11:56:28 +0100
Message-Id: <20230209105628.50294-7-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209105628.50294-1-bchihi@baylibre.com>
References: <20230209105628.50294-1-bchihi@baylibre.com>
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

The mt8195 SoC has several hotspots around the CPUs. Specify the
targeted temperature threshold when to apply the mitigation and define
the associated cooling devices.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 169 ++++++++++++++++++++---
 1 file changed, 153 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index c7e958f8f1b5a..10c8fb0856bc4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 #include <dt-bindings/power/mt8195-power.h>
 #include <dt-bindings/reset/mt8195-resets.h>
+#include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/thermal/mediatek,lvts-thermal.h>
 
 / {
@@ -2413,107 +2414,243 @@ dp_tx: dp-tx@1c600000 {
 
 	thermal_zones: thermal-zones {
 		cpu0-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU0>;
+
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
 			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU1>;
+
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
 			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU2>;
+
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
 			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU3>;
+
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
 			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU0>;
+
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
 			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU1>;
+
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
 			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU2>;
+
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
 			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU3>;
+
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
 	};
 };
-- 
2.34.1

