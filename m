Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2206D6831A2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjAaPh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjAaPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:37:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D03E4C6FF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:37:21 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t18so14619282wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pm9dedBohZwQnGpljqDLhY46ajQDOcYVRYzNxkYmfz8=;
        b=o692OoeYQJOwKthgIQuEeue2H+vYPw/MLklftjwtkwMyFp+hzmsVFFTuzUN5hXcdZv
         1diz6lhWSh3P2SgP6sgfFkt/YztmBV3CY2dq8ZJgxkxwzrmu3Bx17QaUa4JYmIvirW6V
         4flCvVmPNNmoejYhsjvwqKwCSi/5eDwjS8IvamVVR/LvRUFvUrdi+nGeKx4ScVr7L36z
         M+gVWA61AYRmhfqKRgOfQ4vEwxTAg9Y9Gv51ItZrtZuQ4ETzB7sdXmOpa/5C4h0c4UPc
         rud2ZghYFgXXXasxy9ErqpzRvhFwKqYum/vkUgPeU3lp4AUXQUuzgAzgdBrgCU2/3aaC
         WMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pm9dedBohZwQnGpljqDLhY46ajQDOcYVRYzNxkYmfz8=;
        b=cjM7bgEZLVPhn6T4OXO+Eas0/YAnnnKbkaW+0h+d/7BLxRpyHtouupnIP36i8nXiWg
         ieFxrSRoEhfYPkLi9Wy4owVI3r0kOa7b/FxMV14jt1wragyHJ2WDit7Ugo9baX1jqtEQ
         ngJoRzXFAxHIsVvw2RkFae7zclN3LIVwRI+UjzxiXZ3U5io2qMvwW/OqjqBWiE0l6GkM
         QDuVFbyKz7CUM/nmTrAT9y7CGFSu8UAuBRPfUPukalqFS7QMNOMOaaQ29UnvaORRVXWy
         nfGrq6aplDE3bdSszn8TkG5DWYAJU4Cau8Cm5i8vrGPAawqMA2DZwcjQJTcZ/Mzp7yca
         wzyg==
X-Gm-Message-State: AO0yUKXfUlWQOcJ6Ef61kKiVAw1mZO6TPso0GEnrMvNkCM7PWcF6QVQ8
        J67mUzaivm1iVeZ+F5+zU/F4IQ==
X-Google-Smtp-Source: AK7set+yHDJltXCiLAJAaJIl1JdzQwbVU1QNNVTqt5tuW8K/rnz+3j76pcMjOdN0zatg4o/3GTBKQQ==
X-Received: by 2002:a05:6000:1787:b0:2bf:f019:c23d with SMTP id e7-20020a056000178700b002bff019c23dmr4249393wrg.11.1675179439908;
        Tue, 31 Jan 2023 07:37:19 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id c11-20020adfa30b000000b002bfb5ebf8cfsm15068415wrb.21.2023.01.31.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:37:19 -0800 (PST)
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
Subject: [PATCH v12] arm64: dts: mediatek: mt8195: Add thermal zones and thermal nodes
Date:   Tue, 31 Jan 2023 16:37:17 +0100
Message-Id: <20230131153717.21460-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124131717.128660-6-bchihi@baylibre.com>
References: <20230124131717.128660-6-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add thermal zones and thermal nodes for the mt8195.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changelog:
v12:
     - Fixed subject prefix
     - Rename "include/dt-bindings/thermal/mediatek-lvts.h"
       to "include/dt-bindings/thermal/mediatek,lvts-thermal.h"
       due to this patch
       https://lore.kernel.org/all/20230131140439.600164-1-bchihi@baylibre.com/
---
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 129 +++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 09df105f4606..c7e958f8f1b5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 #include <dt-bindings/power/mt8195-power.h>
 #include <dt-bindings/reset/mt8195-resets.h>
+#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
 
 / {
 	compatible = "mediatek,mt8195";
@@ -954,6 +955,17 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts_ap: thermal-sensor@1100b000 {
+			compatible = "mediatek,mt8195-lvts-ap";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8195_INFRA_RST0_THERM_CTRL_SWRST>;
+			nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
+			nvmem-cell-names = "lvts-calib-data-1", "lvts-calib-data-2";
+			#thermal-sensor-cells = <1>;
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8195-spi",
 				     "mediatek,mt6765-spi";
@@ -1114,6 +1126,17 @@ mmc2: mmc@11250000 {
 			status = "disabled";
 		};
 
+		lvts_mcu: thermal-sensor@11278000 {
+			compatible = "mediatek,mt8195-lvts-mcu";
+			reg = <0 0x11278000 0 0x1000>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+			nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
+			nvmem-cell-names = "lvts-calib-data-1", "lvts-calib-data-2";
+			#thermal-sensor-cells = <1>;
+		};
+
 		xhci1: usb@11290000 {
 			compatible = "mediatek,mt8195-xhci",
 				     "mediatek,mtk-xhci";
@@ -2387,4 +2410,110 @@ dp_tx: dp-tx@1c600000 {
 			status = "disabled";
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu0-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU0>;
+			trips {
+				cpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU1>;
+			trips {
+				cpu1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU2>;
+			trips {
+				cpu2_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU3>;
+			trips {
+				cpu3_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu4-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU0>;
+			trips {
+				cpu4_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu5-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU1>;
+			trips {
+				cpu5_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu6-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU2>;
+			trips {
+				cpu6_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu7-thermal {
+			polling-delay = <0>;
+			polling-delay-passive = <0>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU3>;
+			trips {
+				cpu7_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.34.1

