Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357D86EF2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbjDZKu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbjDZKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:49:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DAB49F5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so4390094f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682506190; x=1685098190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRBwEvfGQIrh+pVMdhdSvf8KI6OxPqchD4EYbezjkwM=;
        b=FYB6XKHSK5KKsJr3WxBuRzt7a4ngh9IlwcxKwIBWhfFwmlPj4w9QvRnUf14Zud2OWr
         qPM0OzIHcGKwtFddfme28Ugk0gict/9LoW1Z/E+64kNpc0X0zVyotIINirzNIjjE2XM7
         zaaWUXOvVPBm8cY8qws7cFAac4sx6+hYtJ7UzbWbYwMklWxCdIQfALtnnL/oGIrdr47f
         Dt2PT6bOfqLu3miub99uy+KjLrA90TfC5B4Mjt4NGj+rmzXlmt4hZEJsBPFTCAEkV15q
         LYdSmhZOvFPKvl87gW8PKGuHxatWYbcvnzBvTwBfquCc8kT0MWamX9MLzjtsmv1BFCvP
         G3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682506190; x=1685098190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRBwEvfGQIrh+pVMdhdSvf8KI6OxPqchD4EYbezjkwM=;
        b=fghgIt07CcTtd1NB4/jvMoBI7j15QYEiwT0ffQBGbIMdJxnvLqDjx0RtzhvO/jQ0kp
         Pw7DkMN0SAnVfk9JIH0yeNeL+1NQg36QVjCzFoNnJY298Em8Nh2VuJ1xxgnnuyqif4sL
         6OkAy6rkhpZHOPn15fkr4+sNsUsZfmMxpLNoWaR8ovxyFkM1J8dhfx0O6mcKk3EsF/wm
         Z1ZpxeFQNNWwWr8xeR0NvFRDIvlGbxrOFGJnHdO6KzDpwTFKxdiFwiiUMR8cwEAb4Aqq
         awikGUsWoilTRpVdUziafleZ5HGZgD4jjN5NOmTrTXEvVnYZYt2KVYFimwuC34RK77Fm
         Xqxw==
X-Gm-Message-State: AC+VfDxApUOvcN2ZTzO8D95dOWd8MasbwQjzuc8kXMCn/fi+Ce7PBs6X
        pNyqzI8kaGk/MzNaNxoZzdGt6Q==
X-Google-Smtp-Source: ACHHUZ60G0FOxr7QbkS+ZT6GBwmKMmS2XUtDyx60byZRloL04GW+p5mCyFBHDEQZYkQZHCnBjdwV9A==
X-Received: by 2002:adf:db88:0:b0:304:a40c:43c3 with SMTP id u8-20020adfdb88000000b00304a40c43c3mr764782wri.45.1682506190004;
        Wed, 26 Apr 2023 03:49:50 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 25-20020a05600c025900b003ed2c0a0f37sm17601988wmj.35.2023.04.26.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 03:49:49 -0700 (PDT)
From:   amergnat@baylibre.com
Date:   Wed, 26 Apr 2023 12:49:12 +0200
Subject: [PATCH v6 12/12] arm64: dts: mediatek: Add CPU Idle support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v6-12-8d6b1cfe7f29@baylibre.com>
References: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2737; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=vYzOQ2oc5j6ZLGT/M6bLKTIS/chNEplrOLaJKWbM7ds=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkSQG//NpQI53n7ENVZKetGCC5B3KGBqtL1pkQsjqZ
 srv1ZcaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZEkBvwAKCRArRkmdfjHURdFOD/
 9s6M7dJ3f1t9Ed8MXttvbolu9ojaNWTU5EMJ+7zH8udM2rTz/P5ge7tmJn6KG+D33RjwpXBnKWC3H7
 U9N7xXV3QoTaLaVeUxUzoU75ISfZEJGufUgxElJiygTw7VFcO7bZornDO5jw2bnQ5oXoYjp0AL+1o5
 R68PF9vW2VipeMtxw3sPHD7LyFy96n9EYPS0LkRSBP+9VEqEkQuc45dzNwUtmgGcLv+KAvllQyRCLP
 3HnF+rVfq04Sy62ofdiIUC5IGMHyGXS+Rd5ofXDJpzhuQKhvcrPG1s9GRqG1VxoHvygvudOpddvaeX
 DSjCnYCW5jzAh772Boi1W9Qq1RYA5hgtoEnaNEPvieuRsXlyQ17N9b0Jxv547SPjl4Jzd3QsvNOLvm
 Ph4Nyf5X1a8/EUlzWCV6HZg/14Qp4wGudia6OKwLahWTMZ8czHt95aiFwRhJeGoxZcDQM4z4SQVfNw
 QlONqroOGAFvjiwrDEUYXVpCrcyZR+bxOGUFyI04+d+6ORytZYpTbfev+pX2cR2FtZJyvEvCp7WISq
 sW/NByCHH6Eq0uigoMARj7+r3vxaVWljOzf/KQcSGArqIMkLtvxuKhr9rkpCIvsL6SstC+b2KHOy0g
 xypXGB6U1r9aKg9H4ESi/92R/82AqJ7jt6/5QKXRVfpIqYAumyZj7UGxFPig==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amjad Ouled-Ameur <aouledameur@baylibre.com>

MT8365 has 3 CPU Idle states:
- MCDI_CPU. (Multi-Core-Deep-Idle)
- MCDI_CLUSTER.
- DPIDLE. (Deep-Idle)

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index cfe0c67ad61f..413496c92069 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -128,6 +128,7 @@ cpu0: cpu@0 {
 			reg = <0x0>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -147,6 +148,7 @@ cpu1: cpu@1 {
 			reg = <0x1>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -166,6 +168,7 @@ cpu2: cpu@2 {
 			reg = <0x2>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -185,6 +188,7 @@ cpu3: cpu@3 {
 			reg = <0x3>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -198,6 +202,37 @@ cpu3: cpu@3 {
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
+		idle-states {
+			entry-method = "psci";
+
+			CPU_MCDI: cpu-mcdi {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x00010001>;
+				entry-latency-us = <300>;
+				exit-latency-us = <200>;
+				min-residency-us = <1000>;
+			};
+
+			CLUSTER_MCDI: cluster-mcdi {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x01010001>;
+				entry-latency-us = <350>;
+				exit-latency-us = <250>;
+				min-residency-us = <1200>;
+			};
+
+			CLUSTER_DPIDLE: cluster-dpidle {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x01010004>;
+				entry-latency-us = <300>;
+				exit-latency-us = <800>;
+				min-residency-us = <3300>;
+			};
+		};
+
 		l2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;

-- 
2.25.1

