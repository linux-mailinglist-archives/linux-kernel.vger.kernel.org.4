Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D740B721CB7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 05:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjFED6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 23:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjFED6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 23:58:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3608FEA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 20:58:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30ad99fa586so4359461f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 20:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685937490; x=1688529490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1INtN/KwPq/Kh+/tuqCsXKBvEKli+VsBh43RgsVDQQ=;
        b=CNJgdIQWmGpb04ERz1Ys1nZrFf5/mzRxPH6KaKPjMO/3ffHex71sKR7RzjL48hpK23
         7nGHLu+rmyyzYpb/kRA1/17nnxrMFAT0PuuxqWCtMnWJZB2fyxvreBAWcjNc55O32PVY
         vl+6m3g9FI7LaUsjVyfboXH2VuXHRFE3Z0hPlkHGcRdmg255pieg9l+0prOmR/AnRMvI
         pYX4RsS/sxwLEPA/5IneiOqDd0fblgwJ5evcpRLsfl81aaU/F+23pDwIhXYD9pgRzkjW
         F5u/VYEE6E2x8G0sBGYcVEJHMsP0DzY2ckxmZBQBJSYZmm9z5dpoj8ETASH5ezPYTL5H
         W2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685937490; x=1688529490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1INtN/KwPq/Kh+/tuqCsXKBvEKli+VsBh43RgsVDQQ=;
        b=XrzWIzyvPmBhQ2bnfK4WH3FChdL+Bwm+UWLzfeCBx5csolN4IRLD6Z8zNJNKtUKKED
         NbXYPIwT/JzktAKoG70nHIykyxdSln+nr9XDtLV/cmlk0PugzLMTIykayoAHetLXIjSJ
         NjgWf8QsDnoKnABnNSQegSibhIbudJ2RxZLTOUYtv8AQasBAy6zvFsyUl6uJbi6jzrmc
         KgnfM2uSlSnjvR9wnfRHIeSD2OA13qtLLo/91D3c5e5VZrxy7y0r3oWGokWTdFr1DYsm
         gTPEinOSr9sqnoE1uxu88LNOuHObPQ6Z2GfUc55wXuv5kICq1D3zKcpk6btmyptE+8Tl
         WDVg==
X-Gm-Message-State: AC+VfDxMGd9zMuuqDOkJ04CeYGEcZoRdtMBllohlU72Y0LTXxBhYbXmW
        PWcyST9wqTInBGTLIk4OlcSPew==
X-Google-Smtp-Source: ACHHUZ4DJGhaMm7brMwF3P8AN9X/VOOOSJlkXVvH96yVnAEoah1Hx3Zw7Ukr9AL0H+eD7KQMt0LyCw==
X-Received: by 2002:adf:fb45:0:b0:30a:ee5e:5cf5 with SMTP id c5-20020adffb45000000b0030aee5e5cf5mr4968771wrs.31.1685937490193;
        Sun, 04 Jun 2023 20:58:10 -0700 (PDT)
Received: from localhost.localdomain ([2.223.46.74])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003f61177faffsm22761574wms.0.2023.06.04.20.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 20:58:09 -0700 (PDT)
From:   Alexey Klimov <alexey.klimov@linaro.org>
To:     linux-sunxi@lists.linux.dev
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        daniel.lezcano@linaro.org, peter.griffin@linaro.org,
        klimov.linux@gmail.com
Subject: [PATCH] arm64: dts: allwinner: a64: Add thermal trip points for GPU
Date:   Mon,  5 Jun 2023 04:58:08 +0100
Message-Id: <20230605035808.594686-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without trip points for GPU, the following errors are printed in the
dmesg log and the sun8i-thermal driver fails to load:

thermal_sys: Failed to find 'trips' node
thermal_sys: Failed to find trip points for thermal-sensor id=1
sun8i-thermal: probe of 1c25000.thermal-sensor failed with error -22

When thermal zones are defined, trip points definitions are mandatory.
Trip values for the GPU are assumed to be the same values as the CPU
ones. The available specs do not provide any hints about thermal regimes
for the GPU and it seems GPU is implemented on the same die as the CPU.

Tested on Pine a64+.

Cc: Samuel Holland <samuel@sholland.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 62f45f71ec65..07963eea1bf0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -243,6 +243,29 @@ gpu0_thermal: gpu0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				gpu0_alert0: gpu0_alert0 {
+					/* milliCelsius */
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu0_alert1: gpu0_alert1 {
+					/* milliCelsius */
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				gpu0_crit: gpu0_crit {
+					/* milliCelsius */
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
 		gpu1_thermal: gpu1-thermal {
@@ -250,6 +273,29 @@ gpu1_thermal: gpu1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 2>;
+
+			trips {
+				gpu1_alert0: gpu1_alert0 {
+					/* milliCelsius */
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu1_alert1: gpu1_alert1 {
+					/* milliCelsius */
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				gpu1_crit: gpu1_crit {
+					/* milliCelsius */
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
-- 
2.40.1

