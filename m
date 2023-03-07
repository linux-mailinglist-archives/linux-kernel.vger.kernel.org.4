Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE66AE53A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjCGPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjCGPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:45:37 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2935E85345
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:45:32 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j2so12560901wrh.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678203930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JY0Ro4rQcxnhRsiPxJHCXtVEYXHerbDIXQMmbNIdWm4=;
        b=HPRCUxRSNyyA/oVsmJzaxnWi/aGeU+cplMFkWIaR2F7aOlur6xHyVOmHaPAKxhi6S5
         6HE4UAsO2+d0XsL5fLTME2qD1b9iemXabrKBz99/HFrLWyXgqZ10sOYFVcFPsXlzy/AS
         qt417U9I2jHYrPuL5Wu4SH7jhN8rWtLitFhGDLuldeq4REKk8ZLMdIpSTJm9bOwakbQI
         bsD2NwGi2p+IwZVSEEGnUIqRmG3GS4QFXwJ5n7Mx+wZ+zK+dywTlSMSeZp+gLtCSjkZ6
         JYg57EDiQZ3V7pMCmUA9qHRyOz+/J/8UADAxwLqYYLNvcg7sDXZnmTRvVIWvty46O2Yi
         E0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY0Ro4rQcxnhRsiPxJHCXtVEYXHerbDIXQMmbNIdWm4=;
        b=FsWu4z28Tn1rLi3RWOxf+zOIe33NoFwM6oeoR+aQ37ArigS69F64uxvNLZdo0GEfAs
         ZVBd2X1PlY/GmyEEkWN3YFaJKcu2Uk5iSUJQVOu/2IrzRyYkY6ooj8kUfXCxffYXsPX/
         Kmoxjx9v+Jvqqkz33dY9UZQD3oBKn8eZNciowEXB41zqhhHYb13E3r6jMNmWa8QrI5z6
         qxGIfM7ZGveC6WVFGaI/y5xRNwx0wOnyBHm63kyJ+EFsfAw4UbrGSc+ZSO6GZNAxMBxu
         iSQz9OJRajQssYTd+rPsNqn2f9ckuEZ++e9KEQXWHadDo6imU6aWbc01DwiAq4q8N2/n
         vXXg==
X-Gm-Message-State: AO0yUKWRnLh7v0C/HfUoWPbYKZ4RoG/7sEPfGkwuj9WRdL13wLs+dE7V
        rRQhRjtFSPS+VFG+tlg7M1ioFyh3zZeXptlXLCM=
X-Google-Smtp-Source: AK7set8RZzUjacZh8k2s+HDG9BdJ+pG4VhUR6FtsQdsozL54tKbWq3T7WAAE627gMEVl78AJPnNVIw==
X-Received: by 2002:a5d:6a48:0:b0:2c7:dec:77a7 with SMTP id t8-20020a5d6a48000000b002c70dec77a7mr8356572wrw.71.1678203930693;
        Tue, 07 Mar 2023 07:45:30 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002c704271b05sm12697905wrt.66.2023.03.07.07.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:45:30 -0800 (PST)
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
Subject: [PATCH 4/4] arm64: dts: mediatek: mt8195: Add AP domain temperature thresholds
Date:   Tue,  7 Mar 2023 16:45:24 +0100
Message-Id: <20230307154524.118541-5-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307154524.118541-1-bchihi@baylibre.com>
References: <20230307154524.118541-1-bchihi@baylibre.com>
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

Specify the targeted temperature thresholds.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 90 +++++++++++++++++++-----
 1 file changed, 72 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index b066d1eab1dc..0dab67d283a6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2654,11 +2654,17 @@ map0 {
 		};
 
 		vpu0-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8195_AP_VPU0>;
 
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
@@ -2668,11 +2674,17 @@ vpu0_crit: trip-crit {
 		};
 
 		vpu1-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8195_AP_VPU1>;
 
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
@@ -2682,11 +2694,17 @@ vpu1_crit: trip-crit {
 		};
 
 		gpu0-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8195_AP_GPU0>;
 
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
@@ -2696,11 +2714,17 @@ gpu0_crit: trip-crit {
 		};
 
 		gpu1-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8195_AP_GPU1>;
 
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
@@ -2710,11 +2734,17 @@ gpu1_crit: trip-crit {
 		};
 
 		vdec-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8195_AP_VDEC>;
 
 			trips {
+				vdec_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				vdec_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -2724,11 +2754,17 @@ vdec_crit: trip-crit {
 		};
 
 		img-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8195_AP_IMG>;
 
 			trips {
+				img_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				img_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -2738,11 +2774,17 @@ img_crit: trip-crit {
 		};
 
 		infra-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8195_AP_INFRA>;
 
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
@@ -2752,11 +2794,17 @@ infra_crit: trip-crit {
 		};
 
 		cam0-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8195_AP_CAM0>;
 
 			trips {
+				cam0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cam0_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
@@ -2766,11 +2814,17 @@ cam0_crit: trip-crit {
 		};
 
 		cam1-thermal {
-			polling-delay = <0>;
-			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8195_AP_CAM1>;
 
 			trips {
+				cam1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cam1_crit: trip-crit {
 					temperature = <100000>;
 					hysteresis = <2000>;
-- 
2.34.1

