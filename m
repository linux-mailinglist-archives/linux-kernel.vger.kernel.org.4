Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F764420E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiLFLYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiLFLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:23:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD69205DA;
        Tue,  6 Dec 2022 03:23:40 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A29CC6602B45;
        Tue,  6 Dec 2022 11:23:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670325819;
        bh=48tAHSkcotWDq/1mQynydodHHleYUjhYYLh9z9vaE/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaH+ZWmLuTxCHfUaiGpfXsx9FVHf6bZKLYW4CxEs8l8GL8ZZcYJn/A3nHVgfdQ7Dh
         vtjQWKDIdwcsVa+XnxXZcmaTRx6Y7YPcDPwBBP207xHNC+4ko0ZXClaHM+b9TbbF1+
         K6FyIoLCGy/l1VZsL720JVFt3MWYuCV7oGdw+7+t/2bE6RRnJJ3L50QBuUV8ivMbhM
         vHdrU3I3tIFU0oGXhftzsaIatOaURlEmPkSwwep+XZyO4yVl6cfbVzEfCU0urUSBiJ
         CdgqhBkTTgBc1JTDs0k3QdjFfmVQF2x5V6BRCome2efPoeRKFh5reHEhYnhw2Yb28/
         3wxepD4OolmEA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nfraprado@collabora.com, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/5] arm64: dts: mt8183: Add complete CPU caches information
Date:   Tue,  6 Dec 2022 12:23:29 +0100
Message-Id: <20221206112330.78431-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206112330.78431-1-angelogioacchino.delregno@collabora.com>
References: <20221206112330.78431-1-angelogioacchino.delregno@collabora.com>
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

This SoC features two clusters composed of:
 - 4x Cortex A53: 32KB I-cache, 2-way set associative,
                  32KB D-cache, 4-way set associative,
                  unified 1MB L2 cache, 16-way set associative;
 - 4x Cortex A73: 64KB I-cache and 64KB D-cache, 4-way set associative,
                  unified 1MB L2 cache, 16-way set associative;

With that in mind, add the appropriate properties needed to specify the
caches information for this SoC, which will now be correctly exported
to sysfs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 74 ++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index a70b669c49ba..12f61cd20da5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -336,6 +336,13 @@ cpu0: cpu@0 {
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 			mediatek,cci = <&cci>;
 		};
@@ -352,6 +359,13 @@ cpu1: cpu@1 {
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 			mediatek,cci = <&cci>;
 		};
@@ -368,6 +382,13 @@ cpu2: cpu@2 {
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 			mediatek,cci = <&cci>;
 		};
@@ -384,6 +405,13 @@ cpu3: cpu@3 {
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 			mediatek,cci = <&cci>;
 		};
@@ -400,6 +428,13 @@ cpu4: cpu@100 {
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
 			mediatek,cci = <&cci>;
 		};
@@ -416,6 +451,13 @@ cpu5: cpu@101 {
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
 			mediatek,cci = <&cci>;
 		};
@@ -432,6 +474,13 @@ cpu6: cpu@102 {
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
 			mediatek,cci = <&cci>;
 		};
@@ -448,6 +497,13 @@ cpu7: cpu@103 {
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
 			mediatek,cci = <&cci>;
 		};
@@ -481,6 +537,24 @@ CLUSTER_SLEEP1: cluster-sleep-1 {
 				min-residency-us = <1300>;
 			};
 		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-unified;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-unified;
+		};
 	};
 
 	gpu_opp_table: opp-table-0 {
-- 
2.38.1

